Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A2F8082E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjLGIXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjLGIXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:23:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A4173E;
        Thu,  7 Dec 2023 00:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZrFkvVjmgGqgbYVIpnx13kdaPXXAZZlJh+/DhftTK40=; b=C7D41x5BQlcgnROxpxe2FuMQCO
        NqP32cw6wsk+h5AodZ+vpsjltQ6pmrzcfG9fsTeQ2/7TRT8Bzj5xc77Y5bFg+DjR7qRU4BOPRPsFO
        pkL2rMBszmQcNNiHxSiyBd7BcmwkrLz8fTcQ70BCNs+/MBJT1BXbeFCGt5HqEcnwZ0IjOSs+81JB3
        VOYJ6FlBerKIelhEG6tYS0WEmx05l4+3OPjzjoMAv8OUqmj4IiSqf3jBx/vMVf/2pJQJpyR2Ddq4c
        NUVHcPDOAWcYwPUkWj1sll505OSjhGlzb7q0jKkBY8z/gY7yps4NCeQl69OOFfURPa1DmaIuYE9M7
        lXuKNBKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rB9ev-00CCR5-0I;
        Thu, 07 Dec 2023 08:23:01 +0000
Date:   Thu, 7 Dec 2023 00:23:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@linux.dev>
Cc:     axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: Re: [PATCH v6 06/11] blksnap: handling and tracking I/O units
Message-ID: <ZXGA5f0/UqC/OHu6@infradead.org>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
 <20231124165933.27580-7-sergei.shtepa@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124165933.27580-7-sergei.shtepa@linux.dev>
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

> +
> +static int (*const ctl_table[])(struct tracker *tracker,
> +				__u8 __user *buf, __u32 *plen) = {
> +	ctl_cbtinfo,
> +	ctl_cbtmap,
> +	ctl_cbtdirty,
> +	ctl_snapshotadd,
> +	ctl_snapshotinfo,
> +};

Please use a switch statement like the rest of the kernel.  Besides
being simple to follow it also avoid having a speculation gadget
on user controlled input.

