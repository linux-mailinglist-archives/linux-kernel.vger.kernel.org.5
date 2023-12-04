Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F03B802C01
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 08:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjLDHZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 02:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjLDHZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 02:25:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B516CFE;
        Sun,  3 Dec 2023 23:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QADMa6nbLVHNExTzn9mdT5YRkJaeYYWbi+oyuJIGZ5Y=; b=QXhnb5+m24kcqNdne/VJ3jOk1N
        f0XWKry4YBE+l7ghhqBQiWZ57oUFixvA6Rd2uTDtmhz4KwuXPstUP25hwl9z0zWQ/m4dF+EsRVqlE
        j1mlasWucxDXSyfJ5tjjLDAf5I7cvA6rLh/J4q/kqtObcv3xt7mI6zHAz7s2ycdjF8MdxEQQeztJl
        4ahZxMQNWqFOevxoWrAlaL++piWHVTOznEIjjZ3eH4D0D5rSBh6VkeKYBybSaie5nU8MCJgQH7SGy
        9TIjEm6fW3j72ynzej9ELR4J7pq1YaprOGNSzkBpSXZHTpB++rENLDsZSbA3pwPIHwSUgHxWTwdD7
        +zyXAtNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rA3Kz-0039Cf-2J;
        Mon, 04 Dec 2023 07:25:53 +0000
Date:   Sun, 3 Dec 2023 23:25:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, me@jcix.top,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 3/3] xfs: extract xfs_da_buf_copy() helper function
Message-ID: <ZW1/ATZf9gMZsndW@infradead.org>
References: <20231130040516.35677-1-zhangjiachen.jaycee@bytedance.com>
 <20231130040516.35677-4-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130040516.35677-4-zhangjiachen.jaycee@bytedance.com>
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

> -	/* copy leaf to new buffer, update identifiers */
> -	xfs_trans_buf_set_type(args->trans, bp2, XFS_BLFT_ATTR_LEAF_BUF);
> -	bp2->b_ops = bp1->b_ops;
> -	memcpy(bp2->b_addr, bp1->b_addr, args->geo->blksize);
> -	if (xfs_has_crc(mp)) {
> -		struct xfs_da3_blkinfo *hdr3 = bp2->b_addr;
> -		hdr3->blkno = cpu_to_be64(xfs_buf_daddr(bp2));
> -	}
> +	/*
> +	 * copy leaf to new buffer and log it.
> +	 */

Nit: The first word in a sentence should be capitalized.
Alternativalely just keep the old comment format that doesn't
pretence to be a sentence :)

> +	/*
> +	 * Now we could drop the child buffer.
> +	 */

s/could/can/ ?

> +/*
> + * Copy src directory/xattribute leaf/node buffer to the dst.
> + * If xfs enables crc(IOW, xfs' on-disk format is v5), we have to
> + * make sure that the block specific identifiers are kept intact.
> + */

I'd reword this a bit:

 * Copy src directory/attr leaf/node buffer to the dst.
 * For v5 file systems make sure the right blkno is stamped in.

Also maybe move this function further up in the file?  Even for
non-static functions it's kinda nice if they are implemented before
use to ease the reading flow.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

