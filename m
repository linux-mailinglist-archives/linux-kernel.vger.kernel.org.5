Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA5375DCC2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjGVNZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 09:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGVNZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 09:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A6C1BC
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 06:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 691A260B3B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 13:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59560C433C9;
        Sat, 22 Jul 2023 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690032329;
        bh=cBZVn6q0fbALKHQXUEmeXfI3nq2e37N2KDUI/cfm25w=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=RMjK6H2oAAt/En87mtZSFB7xfzqJGBAHJVZJRbjd9b8c/PnIo32Q3Otf80LGO8Dqp
         pgBhBjsQ58/kBLt2KHU4pMKrnMLbnAfVaQ+BF7nEcriBMAdIaoG41R719nWfyRc2dk
         VFPXboZ9kLXRSKgLJ2I1DJNSDJYdaOXlg75nm1mxLw87dbbiqQT+qQ7EDBMTUzZGSj
         pZq8eMdu+yIF3N2zf6kAVBSBNPuRN2DV8kMBWlc0DFtc0/xpWCGc+6JXgervEZfhsq
         GhhudbbiXXq/MlZsIPHWYEtEMMyDxRWaiJcSQoj021Sr1G57a7vnYguF5kHCByV17W
         0MLhe6v2CAS8A==
Message-ID: <a25c1baf-7e45-5489-d559-62462f0d94d3@kernel.org>
Date:   Sat, 22 Jul 2023 21:25:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     Chao Liu <chaoliu719@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Liu <liuchao@coolpad.com>
References: <20230718083310.367067-1-chaoliu719@gmail.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: introduce two helper functions for the largest
 cached extent
In-Reply-To: <20230718083310.367067-1-chaoliu719@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/18 16:33, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> This patch is a cleanup:
> 1. Merge __drop_largest_extent() since it has only one caller.
> 2. Introduce __notify_largest_extent_updated() and
>     __drop_largest_extent() to help manage largest and largest_update
>     in extent_tree.
> 
> Signed-off-by: Chao Liu <liuchao@coolpad.com>
> ---
>   fs/f2fs/extent_cache.c | 60 +++++++++++++++++++-----------------------
>   fs/f2fs/f2fs.h         |  4 +--
>   2 files changed, 29 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 0e2d49140c07f..45dfddd8c3ad0 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -19,6 +19,12 @@
>   #include "node.h"
>   #include <trace/events/f2fs.h>
>   
> +static void __drop_largest_extent(struct extent_tree *et)
> +{
> +	et->largest.len = 0;
> +	et->largest_updated = true;
> +}
> +
>   bool sanity_check_extent_cache(struct inode *inode)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> @@ -35,8 +41,7 @@ bool sanity_check_extent_cache(struct inode *inode)
>   
>   	/* Let's drop, if checkpoint got corrupted. */
>   	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG)) {
> -		ei->len = 0;
> -		et->largest_updated = true;
> +		__drop_largest_extent(et);
>   		return true;
>   	}
>   
> @@ -310,6 +315,8 @@ static void __detach_extent_node(struct f2fs_sb_info *sbi,
>   
>   	if (et->cached_en == en)
>   		et->cached_en = NULL;
> +
> +	/* keep the largest as we can still use it */
>   	kmem_cache_free(extent_node_slab, en);
>   }
>   
> @@ -385,15 +392,6 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
>   	return count - atomic_read(&et->node_cnt);
>   }
>   
> -static void __drop_largest_extent(struct extent_tree *et,
> -					pgoff_t fofs, unsigned int len)
> -{
> -	if (fofs < et->largest.fofs + et->largest.len &&
> -			fofs + len > et->largest.fofs) {
> -		et->largest.len = 0;
> -		et->largest_updated = true;
> -	}
> -}
>   
>   void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
>   {
> @@ -601,6 +599,15 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>   	return en;
>   }
>   
> +static void __notify_largest_extent_updated(struct extent_tree *et,
> +					struct inode *inode)
> +{
> +	if (et->type == EX_READ && et->largest_updated) {
> +		f2fs_mark_inode_dirty_sync(inode, true);
> +		et->largest_updated = false;
> +	}
> +}
> +
>   static void __update_extent_tree_range(struct inode *inode,
>   			struct extent_info *tei, enum extent_type type)
>   {
> @@ -612,7 +619,6 @@ static void __update_extent_tree_range(struct inode *inode,
>   	struct rb_node **insert_p = NULL, *insert_parent = NULL;
>   	unsigned int fofs = tei->fofs, len = tei->len;
>   	unsigned int end = fofs + len;
> -	bool updated = false;
>   	bool leftmost = false;
>   
>   	if (!et)
> @@ -636,11 +642,10 @@ static void __update_extent_tree_range(struct inode *inode,
>   		prev = et->largest;
>   		dei.len = 0;
>   
> -		/*
> -		 * drop largest extent before lookup, in case it's already
> -		 * been shrunk from extent tree
> -		 */
> -		__drop_largest_extent(et, fofs, len);
> +		/* updates may cause largest extent cache to become invalid */
> +		if (fofs < et->largest.fofs + et->largest.len &&
> +		    fofs + len > et->largest.fofs)
> +			__drop_largest_extent(et);
>   	}
>   
>   	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
> @@ -733,8 +738,7 @@ static void __update_extent_tree_range(struct inode *inode,
>   		if (dei.len >= 1 &&
>   				prev.len < F2FS_MIN_EXTENT_LEN &&
>   				et->largest.len < F2FS_MIN_EXTENT_LEN) {
> -			et->largest.len = 0;
> -			et->largest_updated = true;
> +			__drop_largest_extent(et);
>   			set_inode_flag(inode, FI_NO_EXTENT);
>   		}
>   	}
> @@ -742,10 +746,6 @@ static void __update_extent_tree_range(struct inode *inode,
>   	if (is_inode_flag_set(inode, FI_NO_EXTENT))
>   		__free_extent_tree(sbi, et);
>   
> -	if (et->largest_updated) {
> -		et->largest_updated = false;
> -		updated = true;
> -	}
>   	goto out_read_extent_cache;
>   update_age_extent_cache:
>   	if (!tei->last_blocks)
> @@ -758,9 +758,7 @@ static void __update_extent_tree_range(struct inode *inode,
>   					insert_p, insert_parent, leftmost);
>   out_read_extent_cache:
>   	write_unlock(&et->lock);
> -
> -	if (updated)
> -		f2fs_mark_inode_dirty_sync(inode, true);
> +	__notify_largest_extent_updated(et, inode);

et->largest_updated should be updated w/ &et->lock, this is why we checks
local variable @updated here to decide whether setting inode dirty or not.

Thanks,

>   }
>   
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
> @@ -1092,7 +1090,6 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
> -	bool updated = false;
>   
>   	if (!__may_extent_tree(inode, type))
>   		return;
> @@ -1101,14 +1098,11 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
>   	__free_extent_tree(sbi, et);
>   	if (type == EX_READ) {
>   		set_inode_flag(inode, FI_NO_EXTENT);
> -		if (et->largest.len) {
> -			et->largest.len = 0;
> -			updated = true;
> -		}
> +		if (et->largest.len)
> +			__drop_largest_extent(et);
>   	}
>   	write_unlock(&et->lock);
> -	if (updated)
> -		f2fs_mark_inode_dirty_sync(inode, true);
> +	__notify_largest_extent_updated(et, inode);
>   }
>   
>   void f2fs_drop_extent_tree(struct inode *inode)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d372bedb0fe4e..da02e120e5ea6 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -665,7 +665,7 @@ struct extent_tree {
>   
>   struct extent_tree_info {
>   	struct radix_tree_root extent_tree_root;/* cache extent cache entries */
> -	struct mutex extent_tree_lock;	/* locking extent radix tree */
> +	struct mutex extent_tree_lock;		/* locking extent radix tree */
>   	struct list_head extent_list;		/* lru list for shrinker */
>   	spinlock_t extent_lock;			/* locking extent lru list */
>   	atomic_t total_ext_tree;		/* extent tree count */
> @@ -766,7 +766,7 @@ enum {
>   	FI_ACL_MODE,		/* indicate acl mode */
>   	FI_NO_ALLOC,		/* should not allocate any blocks */
>   	FI_FREE_NID,		/* free allocated nide */
> -	FI_NO_EXTENT,		/* not to use the extent cache */
> +	FI_NO_EXTENT,		/* not to use the read extent cache */
>   	FI_INLINE_XATTR,	/* used for inline xattr */
>   	FI_INLINE_DATA,		/* used for inline data*/
>   	FI_INLINE_DENTRY,	/* used for inline dentry */
