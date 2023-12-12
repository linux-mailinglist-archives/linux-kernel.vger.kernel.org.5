Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A753480ED20
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376626AbjLLNRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376632AbjLLNRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:17:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D856210E;
        Tue, 12 Dec 2023 05:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=76xsvfvsQao0L1F4mpEWw4iFvDSKTUGOH0rkCxylyR0=; b=QmO1jXrHyamW18FiZ0XlDmH8Gd
        J6J4dTRw2FLTkkOKvQrns7exRXAFguyfbw2uOyWEWmNoQXBfbqBZNewfmIkmoQ6bdSNxZ1x5tnPZH
        084wgWpxKkNR2iIpsHjtrRZ9JY1ddTp/EvS2MbTosRtewIEI8Orvb3OQJiNOerl/hksqowqURXjvG
        fYWtLshBV60dlUDv9CIGwurTqiWt8vAiJIHs2JUjuped4+Ibfiu5fRUW9EHItbwHjIC6CXlZJyNyk
        OIbxjiE1dEkn9Ncl10qwLKuiHA8BtEyU6VYvKAm8AyY9ExdjsSwpGxcfoUdawzLHnMiAOJUPVSQrR
        k2K6LA6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rD2d4-00Bm1M-0C;
        Tue, 12 Dec 2023 13:16:54 +0000
Date:   Tue, 12 Dec 2023 05:16:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
        kent.overstreet@gmail.com, joern@lazybastard.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, agruenba@redhat.com, jack@suse.com,
        konishi.ryusuke@gmail.com, willy@infradead.org,
        akpm@linux-foundation.org, p.raghav@samsung.com, hare@suse.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        gfs2@lists.linux.dev, linux-nilfs@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 for-6.8/block 01/18] block: add some bdev apis
Message-ID: <ZXhdRhfr+JoWdhyj@infradead.org>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
 <20231211140552.973290-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211140552.973290-2-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +void invalidate_bdev_range(struct block_device *bdev, pgoff_t start,
> +			   pgoff_t end)
> +{
> +	invalidate_mapping_pages(bdev->bd_inode->i_mapping, start, end);
> +}
> +EXPORT_SYMBOL_GPL(invalidate_bdev_range);

Can we have kerneldoc comments for the new helpers please?

> +struct folio *__bdev_get_folio(struct block_device *bdev, loff_t pos,
> +			       fgf_t fgp_flags, gfp_t gfp)
> +{
> +	return __filemap_get_folio(bdev->bd_inode->i_mapping, pos >> PAGE_SHIFT,
> +				   fgp_flags, gfp);
> +}
> +EXPORT_SYMBOL_GPL(__bdev_get_folio);

It's a bit silly to have a __-prefixed API without a version that
doesn't have the prefix, so I'd prefer to drop it.  Unless willy has
a good argument for keeping it the same as the filemap API.

