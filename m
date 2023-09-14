Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7863F7A0B13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjINQ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjINQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:56:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7321FDE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:56:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD4181F74C;
        Thu, 14 Sep 2023 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694710611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9dYbcygFs+B71xYNYqVHVDk/ZWOqRCfnzVK6KuhBKJI=;
        b=Rheo62hLVc0dxeDLyvQ5sjmbAvZLXFpqZnskMAwq8m+e5BP+OY4EoCEVJQ3IQ5hGcOetul
        D0eG7FEfYFe0Wa2I6io9FWd3rsnfPJJoNzKXLRNFdTRj1+/QGWbH1pHxqrvxRCLxw7i1D/
        26Omj6jLkgHAsDtjC0MhGXWkYenKals=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DFEF139DB;
        Thu, 14 Sep 2023 16:56:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eTH/IlM7A2XnPgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 14 Sep 2023 16:56:51 +0000
Date:   Thu, 14 Sep 2023 18:56:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Breno Leitao <leitao@debian.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix GFP_NOFS recursion in memory.high
 enforcement
Message-ID: <ZQM7UiuRKPB9giYK@dhcp22.suse.cz>
References: <20230914152139.100822-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914152139.100822-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-09-23 11:21:39, Johannes Weiner wrote:
> Breno and Josef report a deadlock scenario from cgroup reclaim
> re-entering the filesystem:
> 
> [  361.546690] ======================================================
> [  361.559210] WARNING: possible circular locking dependency detected
> [  361.571703] 6.5.0-0_fbk700_debug_rc0_kbuilder_13159_gbf787a128001 #1 Tainted: G S          E
> [  361.589704] ------------------------------------------------------
> [  361.602277] find/9315 is trying to acquire lock:
> [  361.611625] ffff88837ba140c0 (&delayed_node->mutex){+.+.}-{4:4}, at: __btrfs_release_delayed_node+0x68/0x4f0
> [  361.631437]
> [  361.631437] but task is already holding lock:
> [  361.643243] ffff8881765b8678 (btrfs-tree-01){++++}-{4:4}, at: btrfs_tree_read_lock+0x1e/0x40
> 
> [  362.904457]  mutex_lock_nested+0x1c/0x30
> [  362.912414]  __btrfs_release_delayed_node+0x68/0x4f0
> [  362.922460]  btrfs_evict_inode+0x301/0x770
> [  362.982726]  evict+0x17c/0x380
> [  362.988944]  prune_icache_sb+0x100/0x1d0
> [  363.005559]  super_cache_scan+0x1f8/0x260
> [  363.013695]  do_shrink_slab+0x2a2/0x540
> [  363.021489]  shrink_slab_memcg+0x237/0x3d0
> [  363.050606]  shrink_slab+0xa7/0x240
> [  363.083382]  shrink_node_memcgs+0x262/0x3b0
> [  363.091870]  shrink_node+0x1a4/0x720
> [  363.099150]  shrink_zones+0x1f6/0x5d0
> [  363.148798]  do_try_to_free_pages+0x19b/0x5e0
> [  363.157633]  try_to_free_mem_cgroup_pages+0x266/0x370
> [  363.190575]  reclaim_high+0x16f/0x1f0
> [  363.208409]  mem_cgroup_handle_over_high+0x10b/0x270
> [  363.246678]  try_charge_memcg+0xaf2/0xc70
> [  363.304151]  charge_memcg+0xf0/0x350
> [  363.320070]  __mem_cgroup_charge+0x28/0x40
> [  363.328371]  __filemap_add_folio+0x870/0xd50
> [  363.371303]  filemap_add_folio+0xdd/0x310
> [  363.399696]  __filemap_get_folio+0x2fc/0x7d0
> [  363.419086]  pagecache_get_page+0xe/0x30
> [  363.427048]  alloc_extent_buffer+0x1cd/0x6a0
> [  363.435704]  read_tree_block+0x43/0xc0
> [  363.443316]  read_block_for_search+0x361/0x510
> [  363.466690]  btrfs_search_slot+0xc8c/0x1520
> 
> This is caused by the mem_cgroup_handle_over_high() not respecting the
> gfp_mask of the allocation context. We used to only call this function
> on resume to userspace, where no locks were held. But c9afe31ec443
> ("memcg: synchronously enforce memory.high for large overcharges")
> added a call from the allocation context without considering the gfp.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for large overcharges")
> Cc: stable@vger.kernel.org # 5.17+
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!
-- 
Michal Hocko
SUSE Labs
