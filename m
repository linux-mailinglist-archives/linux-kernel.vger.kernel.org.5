Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DC5807334
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442107AbjLFO7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378993AbjLFO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:59:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6017B5;
        Wed,  6 Dec 2023 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s+7kV2NOaPEBmhFkJpDv/pC5Llv4VXEE9i8fdKbvmjw=; b=ojDk7+bvhmkVaj86d9uPvOhQaz
        kbAJJlz3eiFA7yxHtxf02BCaqsNM5pS9C8k5lXRoPly3/N/e0u5QADIgtZKFOwGOJtwsI5ZzSsYPS
        PKyktYqelsFB3E+G8W+4/yQSFmaQ2jHSWEigX57CwcwQszQ0bDoxOOqdU2sc0+ZoE3Ff1wwcpqslV
        VWLgXJnu2MrDZGBo0sVLqXRdAvGI+d1WdlsXWEVkM0crARzZz5+nD3AR2Avd8/g6eRde0hkW/FoXX
        agEz57imZpOlmdW73T5pzua0TfxBEP/xRZ/WXwPlD7/tpJRN5cqF7OvXJrtIdGRYW6omWvwYwBXvA
        OJr6nVaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rAtMN-002zkJ-Nc; Wed, 06 Dec 2023 14:58:47 +0000
Date:   Wed, 6 Dec 2023 14:58:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
        kent.overstreet@gmail.com, joern@lazybastard.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, nico@fluxnic.net, xiang@kernel.org,
        chao@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        agruenba@redhat.com, jack@suse.com, konishi.ryusuke@gmail.com,
        akpm@linux-foundation.org, hare@suse.de, p.raghav@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next RFC 01/14] block: add some bdev apis
Message-ID: <ZXCMJ9skAAgPm4z3@casper.infradead.org>
References: <20231205123728.1866699-1-yukuai1@huaweicloud.com>
 <20231205123728.1866699-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205123728.1866699-2-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 08:37:15PM +0800, Yu Kuai wrote:
> +struct folio *bdev_read_folio(struct block_device *bdev, pgoff_t index)
> +{
> +	return read_mapping_folio(bdev->bd_inode->i_mapping, index, NULL);
> +}
> +EXPORT_SYMBOL_GPL(bdev_read_folio);

I'm coming to the opinion that 'index' is the wrong parameter here.
Looking through all the callers of bdev_read_folio() in this patchset,
they all have a position in bytes, and they all convert it to
index for this call.  The API should probably be:

struct folio *bdev_read_folio(struct block_device *bdev, loff_t pos)
{
	return read_mapping_folio(bdev->bd_inode->i_mapping,
			pos / PAGE_SIZE, NULL);
}

... and at some point, we'll get round to converting read_mapping_folio()
to take its argument in loff_t.

Similiarly for these two APIs:

> +struct folio *bdev_read_folio_gfp(struct block_device *bdev, pgoff_t index,
> +				  gfp_t gfp)
> +struct folio *bdev_get_folio(struct block_device *bdev, pgoff_t index)

> +struct folio *bdev_find_or_create_folio(struct block_device *bdev,
> +					pgoff_t index, gfp_t gfp)
> +{
> +	return __filemap_get_folio(bdev->bd_inode->i_mapping, index,
> +				   FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
> +}
> +EXPORT_SYMBOL_GPL(bdev_find_or_create_folio);

This one probably shouldn't exist.  I've been converting callers of
find_or_create_page() to call __filemap_get_folio; I suspect we
should expose a __bdev_get_folio and have the callers use the FGP
arguments directly, but I'm open to other opinions here.

> +void bdev_sync_readahead(struct block_device *bdev, struct file_ra_state *ra,
> +			 struct file *file, pgoff_t index,
> +			 unsigned long req_count)
> +{
> +	struct file_ra_state tmp_ra = {};
> +
> +	if (!ra) {
> +		ra = &tmp_ra;
> +		file_ra_state_init(ra, bdev->bd_inode->i_mapping);
> +	}
> +	page_cache_sync_readahead(bdev->bd_inode->i_mapping, ra, file, index,
> +				  req_count);
> +}

I think the caller should always be passing in a valid file_ra_state.
It's only cramfs that doesn't have one, and it really should!
Not entirely sure about the arguments here; part of me says "bytes",
but this is weird enough to maybe take arguments in pages.
