Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B86810CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjLMIwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:52:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CD8AC;
        Wed, 13 Dec 2023 00:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a3hyHU444stCFxhhDZa/P+PmoLtQc1fA3WonZdHSww0=; b=DRNZLiD1QGXGKtdC6Z8g7cnvH6
        N9xt/UB36lTsK0ABOr/rbBt2Gog0TlyXX3URhEJ7aIoR3V0mjts83wcD4pewINVrmwxHZW1v8eas7
        h0Vb8X2novBlmvvJLgz5s27WbP2MhEjO1uH7SJFbNKOYokc/Yp1CSpvvviMAO1OM9remZVZOn96/m
        Eq0prHkqZOsSe6J1usFzrCrYmnLqDM94MXwc6TARLukzBijMa2Bqk99koujWxM8NIqrCseJupwe+m
        PzVsCr6PwEiUDGHnRg2vISmCOK4WuQJs3b67ObYBUWPPWV/Qbjos5TBddmokkYretenrvE0cWPSUI
        xxwYsaXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDKyQ-00E5QW-1D;
        Wed, 13 Dec 2023 08:52:10 +0000
Date:   Wed, 13 Dec 2023 00:52:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] btrfs: factor out RAID1 block mapping
Message-ID: <ZXlwurmwHg+oWlv4@infradead.org>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-4-b2d954d9a55b@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-4-b2d954d9a55b@wdc.com>
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

On Tue, Dec 12, 2023 at 04:38:02AM -0800, Johannes Thumshirn wrote:
> Now that we have a container for the I/O geometry that has all the needed
> information for the block mappings of RAID1, factor out a helper calculating
> this information.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/volumes.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index a5d85a77da25..f6f1e783b3c1 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6372,6 +6372,25 @@ static void map_blocks_for_raid0(struct btrfs_chunk_map *map,
>  		io_geom->mirror_num = 1;
>  }
>  
> +static void map_blocks_for_raid1(struct btrfs_fs_info *fs_info,
> +				 struct btrfs_chunk_map *map,
> +				 enum btrfs_map_op op,
> +				 struct btrfs_io_geometry *io_geom, int replace)

replace looks like a bool to me.  Also elsewhere in the code it is
called dev_replace_is_ongoing.  Even if that name is a little clumsy
it's nice to not switch forth and back between names in a call chain.

