Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81682807FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjLGE6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjLGE6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:58:44 -0500
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10963D44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 20:58:49 -0800 (PST)
Date:   Wed, 6 Dec 2023 23:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701925128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ER/rFK8I9p5Nyi4EPWTSpp7ceXu8C84i7TakscXSgrg=;
        b=dtxRa5HC5BjEY1vwLAImPX6PE01YgnBPYYyJqYC7IFH37NPuxd2HfUGXBpzqwqos1FqlkY
        0bouvtRlgrvXR+xFdH2T3pfxm1sf7fUdOcZe9i0B5L3CkNFLbgRTOc6XBY8RLYr6mGXWWX
        182ilBeK2tqvjOkOYtDQU/rBzYLw0uE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-cachefs@redhat.com, dhowells@redhat.com,
        gfs2@lists.linux.dev, dm-devel@lists.linux.dev,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] vfs: inode cache conversion to hash-bl
Message-ID: <20231207045844.u26r5vn26gtmqwe5@moria.home.lan>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-9-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-9-david@fromorbit.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:05:37PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Scalability of the global inode_hash_lock really sucks for
> filesystems that use the vfs inode cache (i.e. everything but XFS).

Ages ago, we talked about (and I attempted, but ended up swearing at
inode lifetime rules) - conversion to rhashtable instead, which I still
believe would be preferable since that code is fully lockless (and
resizeable, of course). But it turned out to be a much bigger project...

But IIRC the bulk of the work was going to be "clean up inode
refcounting/lifetime rules into something sane/modern" - maybe we could
leave some breadcrumbs/comments in fs/inode.c for what that would take,
if/when someone else is sufficiently motivated?

> threads		vanilla	 patched	vanilla	patched
> 2		 7.923	  7.358		 8.003	 7.276
> 4		 8.152	  7.530		 9.097	 8.506
> 8		13.090	  7.871		11.752	10.015
> 16		24.602	  9.540		24.614	13.989
> 32		49.536	 19.314		49.179	25.982

nice

> The big wins here are at >= 8 threads, with both filesytsems now
> being limited by internal filesystem algorithms, not the VFS inode
> cache scalability.
> 
> Ext4 contention moves to the buffer cache on directory block
> lookups:
> 
> -   66.45%     0.44%  [kernel]              [k] __ext4_read_dirblock
>    - 66.01% __ext4_read_dirblock
>       - 66.01% ext4_bread
>          - ext4_getblk
>             - 64.77% bdev_getblk
>                - 64.69% __find_get_block
>                   - 63.01% _raw_spin_lock
>                      - 62.96% do_raw_spin_lock
>                           59.21% __pv_queued_spin_lock_slowpath
> 
> bcachefs contention moves to internal btree traversal locks.
> 
>  - 95.37% __lookup_slow
>     - 93.95% bch2_lookup
>        - 82.57% bch2_vfs_inode_get
> 	  - 65.44% bch2_inode_find_by_inum_trans
> 	     - 65.41% bch2_inode_peek_nowarn
> 		- 64.60% bch2_btree_iter_peek_slot
> 		   - 64.55% bch2_btree_path_traverse_one
> 		      - bch2_btree_path_traverse_cached
> 			 - 63.02% bch2_btree_path_traverse_cached_slowpath
> 			    - 56.60% mutex_lock

dlist-lock ought to be perfect for solving this one

Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
