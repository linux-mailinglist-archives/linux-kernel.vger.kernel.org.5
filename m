Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C30808322
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjLGIgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjLGIgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:36:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25D9D4A;
        Thu,  7 Dec 2023 00:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u099gzjDXzJ4GHKJVOCEEgCI+HNpjyaO5+j80X95e2M=; b=mI/U/5XKN2ARAgTCnAZnGUNidm
        llAtiKBODd6zoC4Hxgv9jXUJwfuZv9ii9kpYhc/luds3zKQ9WsoEy4/BBPf02mzaBFNhScotUAGHj
        i9+vmqwFDUzJdnNBRLfZZpSY2+L0Rs3JvosSJsCKItFgmwtnn4tyR8c+IJxQ8ayqsNFHYmxaU0L0B
        0k9Och0sMoDnUBHBNScqTNviA7lAEYLiI2b3zHTWbF+tDx2bPbpTfUjFSAXGTwGD0sNC4jiBTA8NE
        Q+pS9cVMv5u14b8UjE37FoKM/7BmUwnoPYOcWXgyW0COzhdnIFcyBTesXOqiLufj7LwG8D/VhjBQc
        3vITmcWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rB9rr-00CEn1-0o;
        Thu, 07 Dec 2023 08:36:23 +0000
Date:   Thu, 7 Dec 2023 00:36:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@linux.dev>
Cc:     axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: Re: [PATCH v6 07/11] blksnap: difference storage and chunk
Message-ID: <ZXGEB5M1+/2QMxqi@infradead.org>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <20231124165933.27580-8-sergei.shtepa@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124165933.27580-8-sergei.shtepa@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline bool unsupported_mode(const umode_t m)
> +{
> +	return (S_ISCHR(m) || S_ISFIFO(m) || S_ISSOCK(m));
> +}
> +
> +static inline bool unsupported_flags(const unsigned int flags)
> +{
> +	if (!(flags | O_RDWR)) {
> +		pr_err("Read and write access is required\n");
> +		return true;
> +	}
> +	if (!(flags | O_EXCL)) {
> +		pr_err("Exclusive access is required\n");
> +		return true;
> +	}

You probably want to positively check the allowed flags and types
to be more future proof.  I'd also drop these very easy to trigger
messages.

> +	if (S_ISBLK(file_inode(file)->i_mode)) {

Splitting the blk and regular file open path into separate helpers
would improve readability a lot I think.

> +		/*
> +		 * The block device is opened non-exclusively.
> +		 * It should be exclusive to open the file whose descriptor is
> +		 * passed to the module.
> +		 */
> +		bdev = blkdev_get_by_dev(dev_id,
> +					 BLK_OPEN_READ | BLK_OPEN_WRITE,
> +					 NULL, NULL);

Note that this will have some interesting interaction with the patches
from Jan to optionally disallow any other write for exclusively opened
block devices.  But given that right now we don't support using the
original device as backing store, this probably should become an
exclusive open anyway.

