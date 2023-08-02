Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E95976D052
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjHBOmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjHBOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:42:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0247119
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:41:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A975619CB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876C8C433C7;
        Wed,  2 Aug 2023 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690987317;
        bh=rgBibd0o1fF3a08ENh2daqV1NavlTbBZdbLQsxegWxc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LsO5YIjulAA+IzwpnNSj1YqtdW3281G/xtbfm3/p7lpBThcXcAAbHrV/ZlJsfeWp3
         LD2aDD9fHkqgBUBRTpQLqtgxI39svr4NnQLOvBCEyok2kL4/Gtu7itm9xiezkMl2uu
         4zU/TcHLqyPZ6yn/Q9Q/WfDwwnyUEfU/mG+0daExoPCBWYiB+PBUj33Q4V7T2wo1L7
         T7s66Jx6Zd3THMYDp8GFcxWwcMwDL00K1S9xd3lTFVm5zTsc/y5ukLrUPRi6j/yUQd
         5Q5Ckz9yUNxXlRkSNlAGMya8p55pfeuXVkDISabeGI3A+/WcdonwDdX4ibgXakBKbP
         WMm3q04z2oPcw==
Message-ID: <7a8fbee4-6176-b122-7d43-32fb553ef332@kernel.org>
Date:   Wed, 2 Aug 2023 22:41:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] f2fs: introduce two helper functions for the largest
 cached extent
To:     Chao Liu <chaoliu719@gmail.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Liu <liuchao@coolpad.com>
References: <20230725013607.4134123-1-chaoliu719@gmail.com>
 <16625fbb-3dc0-34d5-ee75-fe010aa0d9ec@kernel.org>
 <ZMC6JfDFOo3WrRsC@liuchao-VM>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZMC6JfDFOo3WrRsC@liuchao-VM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/26 14:16, Chao Liu wrote:
> On 7月 26 09:24, Chao Yu wrote:
>> On 2023/7/25 9:36, Chao Liu wrote:
>>> From: Chao Liu <liuchao@coolpad.com>
>>>
>>> This patch is a cleanup:
>>> 1. Merge __drop_largest_extent() since it has only one caller.
>>> 2. Introduce __unlock_tree_with_checking_largest() and
>>>      __drop_largest_extent() to help manage largest and largest_update
>>>      in extent_tree.
>>>
>>> Signed-off-by: Chao Liu <liuchao@coolpad.com>
>>> ---
>>> v2: Make sure et->largest_updated gets updated within &et->lock.
>>>       Thanks to Chao Yu for pointing out.
>>> ---
>>>    fs/f2fs/extent_cache.c | 66 ++++++++++++++++++++----------------------
>>>    fs/f2fs/f2fs.h         |  4 +--
>>>    2 files changed, 33 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>>> index 0e2d49140c07f..cfc69621a8a26 100644
>>> --- a/fs/f2fs/extent_cache.c
>>> +++ b/fs/f2fs/extent_cache.c
>>> @@ -19,6 +19,12 @@
>>>    #include "node.h"
>>>    #include <trace/events/f2fs.h>
>>> +static void __drop_largest_extent(struct extent_tree *et)
>>> +{
>>> +	et->largest.len = 0;
>>> +	et->largest_updated = true;
>>> +}
>>> +
>>>    bool sanity_check_extent_cache(struct inode *inode)
>>>    {
>>>    	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>> @@ -35,8 +41,7 @@ bool sanity_check_extent_cache(struct inode *inode)
>>>    	/* Let's drop, if checkpoint got corrupted. */
>>>    	if (is_set_ckpt_flags(sbi, CP_ERROR_FLAG)) {
>>> -		ei->len = 0;
>>> -		et->largest_updated = true;
>>> +		__drop_largest_extent(et);
>>
>> __drop_largest_extent_force(et);
>>
>>>    		return true;
>>>    	}
>>> @@ -310,6 +315,8 @@ static void __detach_extent_node(struct f2fs_sb_info *sbi,
>>>    	if (et->cached_en == en)
>>>    		et->cached_en = NULL;
>>> +
>>> +	/* keep the largest as we can still use it */
>>
>> The comments doesn't match below code?
>>
> 
> Sorry for not explaining this earlier.
> 
> It's just a hint and has nothing to do with the code below. It

So, it should be near to related code..., otherwise, IMO, it makes the code
more confused.

Thanks,

> simply explains that we don't need to disable the largest here, which
> makes the whole code logic of the largest more clear. :)
> 
> If it's not fitting, please let me know, and I'll drop them.
> 
>>>    	kmem_cache_free(extent_node_slab, en);
>>>    }
>>> @@ -385,15 +392,6 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
>>>    	return count - atomic_read(&et->node_cnt);
>>>    }
>>> -static void __drop_largest_extent(struct extent_tree *et,
>>> -					pgoff_t fofs, unsigned int len)
>>> -{
>>> -	if (fofs < et->largest.fofs + et->largest.len &&
>>> -			fofs + len > et->largest.fofs) {
>>> -		et->largest.len = 0;
>>> -		et->largest_updated = true;
>>> -	}
>>> -}
>>
>> What about:
>>
>> static void __drop_largest_extent_cond(struct extent_tree *et,
>> 					pgoff_t fofs, unsigned int len,
>> 					bool force)
>> {
>> 	if (force || (fofs < et->largest.fofs + et->largest.len &&
>> 			fofs + len > et->largest.fofs)) {
>> 		et->largest.len = 0;
>> 		et->largest_updated = true;
>> 	}
>> }
>>
>> static void __drop_largest_extent_force(struct extent_tree *et)
>> {
>> 	__drop_largest_extent_cond(et, 0, 0, true);
>> }
>>
> 
> Thank you. I feel it matches better with the existing code
> organization style. Let me apply it in v3.
> 
>>>    void f2fs_init_read_extent_tree(struct inode *inode, struct page *ipage)
>>>    {
>>> @@ -601,6 +599,19 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
>>>    	return en;
>>>    }
>>> +static void __unlock_tree_with_checking_largest(struct extent_tree *et,
>>> +						struct inode *inode)
>>> +{
>>> +	if (et->type == EX_READ && et->largest_updated) {
>>> +		et->largest_updated = false;
>>> +		write_unlock(&et->lock);
>>> +		f2fs_mark_inode_dirty_sync(inode, true);
>>> +		return;
>>> +	}
>>> +
>>> +	write_unlock(&et->lock);
>>> +}
>>> +
>>>    static void __update_extent_tree_range(struct inode *inode,
>>>    			struct extent_info *tei, enum extent_type type)
>>>    {
>>> @@ -612,7 +623,6 @@ static void __update_extent_tree_range(struct inode *inode,
>>>    	struct rb_node **insert_p = NULL, *insert_parent = NULL;
>>>    	unsigned int fofs = tei->fofs, len = tei->len;
>>>    	unsigned int end = fofs + len;
>>> -	bool updated = false;
>>>    	bool leftmost = false;
>>>    	if (!et)
>>> @@ -636,11 +646,10 @@ static void __update_extent_tree_range(struct inode *inode,
>>>    		prev = et->largest;
>>>    		dei.len = 0;
>>> -		/*
>>> -		 * drop largest extent before lookup, in case it's already
>>> -		 * been shrunk from extent tree
>>> -		 */
>>> -		__drop_largest_extent(et, fofs, len);
>>
>> __drop_largest_extent_cond(et, fofs, len, false);
>>
>>> +		/* updates may cause largest extent cache to become invalid */
>>> +		if (fofs < et->largest.fofs + et->largest.len &&
>>> +		    fofs + len > et->largest.fofs)
>>> +			__drop_largest_extent(et);
>>>    	}
>>>    	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
>>> @@ -733,8 +742,7 @@ static void __update_extent_tree_range(struct inode *inode,
>>>    		if (dei.len >= 1 &&
>>>    				prev.len < F2FS_MIN_EXTENT_LEN &&
>>>    				et->largest.len < F2FS_MIN_EXTENT_LEN) {
>>> -			et->largest.len = 0;
>>> -			et->largest_updated = true;
>>> +			__drop_largest_extent(et);
>>
>> __drop_largest_extent_force(et);
>>
>>>    			set_inode_flag(inode, FI_NO_EXTENT);
>>>    		}
>>>    	}
>>> @@ -742,10 +750,6 @@ static void __update_extent_tree_range(struct inode *inode,
>>>    	if (is_inode_flag_set(inode, FI_NO_EXTENT))
>>>    		__free_extent_tree(sbi, et);
>>> -	if (et->largest_updated) {
>>> -		et->largest_updated = false;
>>> -		updated = true;
>>> -	}
>>
>> I guess we'd better keep previous logic.
> 
> Ok, I will drop these changes in v3. Ditto for __drop_extent_tree().
> 
>>
>>>    	goto out_read_extent_cache;
>>>    update_age_extent_cache:
>>>    	if (!tei->last_blocks)
>>> @@ -757,10 +761,7 @@ static void __update_extent_tree_range(struct inode *inode,
>>>    		__insert_extent_tree(sbi, et, &ei,
>>>    					insert_p, insert_parent, leftmost);
>>>    out_read_extent_cache:
>>> -	write_unlock(&et->lock);
>>> -
>>> -	if (updated)
>>> -		f2fs_mark_inode_dirty_sync(inode, true);
>>
>> Ditto,
>>
>>> +	__unlock_tree_with_checking_largest(et, inode);
>>>    }
>>>    #ifdef CONFIG_F2FS_FS_COMPRESSION
>>> @@ -1092,7 +1093,6 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
>>>    {
>>>    	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>    	struct extent_tree *et = F2FS_I(inode)->extent_tree[type];
>>> -	bool updated = false;
>>>    	if (!__may_extent_tree(inode, type))
>>>    		return;
>>> @@ -1101,14 +1101,10 @@ static void __drop_extent_tree(struct inode *inode, enum extent_type type)
>>>    	__free_extent_tree(sbi, et);
>>>    	if (type == EX_READ) {
>>>    		set_inode_flag(inode, FI_NO_EXTENT);
>>> -		if (et->largest.len) {
>>> -			et->largest.len = 0;
>>> -			updated = true;
>>> -		}
>>> +		if (et->largest.len)
>>> +			__drop_largest_extent(et);
>>>    	}
>>> -	write_unlock(&et->lock);
>>> -	if (updated)
>>> -		f2fs_mark_inode_dirty_sync(inode, true);
>>
>> Ditto,
>>
>> Thanks,
>>
>>> +	__unlock_tree_with_checking_largest(et, inode);
>>>    }
>>>    void f2fs_drop_extent_tree(struct inode *inode)
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index d372bedb0fe4e..da02e120e5ea6 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -665,7 +665,7 @@ struct extent_tree {
>>>    struct extent_tree_info {
>>>    	struct radix_tree_root extent_tree_root;/* cache extent cache entries */
>>> -	struct mutex extent_tree_lock;	/* locking extent radix tree */
>>> +	struct mutex extent_tree_lock;		/* locking extent radix tree */
>>>    	struct list_head extent_list;		/* lru list for shrinker */
>>>    	spinlock_t extent_lock;			/* locking extent lru list */
>>>    	atomic_t total_ext_tree;		/* extent tree count */
>>> @@ -766,7 +766,7 @@ enum {
>>>    	FI_ACL_MODE,		/* indicate acl mode */
>>>    	FI_NO_ALLOC,		/* should not allocate any blocks */
>>>    	FI_FREE_NID,		/* free allocated nide */
>>> -	FI_NO_EXTENT,		/* not to use the extent cache */
>>> +	FI_NO_EXTENT,		/* not to use the read extent cache */
>>>    	FI_INLINE_XATTR,	/* used for inline xattr */
>>>    	FI_INLINE_DATA,		/* used for inline data*/
>>>    	FI_INLINE_DENTRY,	/* used for inline dentry */
