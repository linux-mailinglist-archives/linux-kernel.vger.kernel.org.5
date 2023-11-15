Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEBE7EBE76
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343500AbjKOIS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 03:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjKOIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:18:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A66DEE
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:18:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA18C433C7;
        Wed, 15 Nov 2023 08:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700036334;
        bh=maXGNjDC3LU3+kPDr6sKssbLSYqPMDFqN3BOrOKB8Wk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mLXun7JKLSTwAYaBdcUk1MrRasSsd6P06AiCyiIzIVeoo+ZMzS7ZGLXSCa1bZhru0
         3f/pHHmIaQBTvf4+cDuDRxkgliTxIXd+NovJhkoNprii3/+Lw6IPQ0/O4wf0aLnW63
         AcTxMnGmAEQbrAulSO8oV8rtGUzhM8EV3fEGDK74TjH50/FBNf1pIh14b1ZLRzGvii
         3knPRG/3F2OSxfkLzdj11fo9eTFBinF20qly0/esP1ZXV8Q0BXzMUeYp0usy0sNRTA
         ipFZoP3zZYxNqQ2jAZOesGYLi8czZwCJz4qbYvqhiIh1FKs5WMUT002oPtrtzP2avn
         nwFqJoL5APbDg==
Message-ID: <e307e1bc-9c50-ed43-be12-c535b95a417e@kernel.org>
Date:   Wed, 15 Nov 2023 16:18:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs-tools: do not reuse corrupted quota
 inodes
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20231027002123.1195780-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231027002123.1195780-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/27 8:21, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When we detect quota inode corruption, we better deallocate the current
> space and allocate new ones for a clean start.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> ---
> v2: change node count check when creating a new node block
> ---
>   fsck/fsck.c    | 148 +++++++++++++++++++++++++++++++++++--------------
>   fsck/segment.c |   5 +-
>   2 files changed, 109 insertions(+), 44 deletions(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 99cface..dc8e282 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -67,6 +67,14 @@ int f2fs_set_sit_bitmap(struct f2fs_sb_info *sbi, u32 blk)
>   	return f2fs_set_bit(BLKOFF_FROM_MAIN(sbi, blk), fsck->sit_area_bitmap);
>   }
>   
> +static inline int f2fs_clear_sit_bitmap(struct f2fs_sb_info *sbi, u32 blk)
> +{
> +	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> +
> +	return f2fs_clear_bit(BLKOFF_FROM_MAIN(sbi, blk),
> +						fsck->sit_area_bitmap);
> +}
> +
>   static int add_into_hard_link_list(struct f2fs_sb_info *sbi,
>   						u32 nid, u32 link_cnt)
>   {
> @@ -2150,6 +2158,9 @@ int fsck_chk_quota_node(struct f2fs_sb_info *sbi)
>   	return ret;
>   }
>   
> +static void fsck_disconnect_file(struct f2fs_sb_info *sbi, nid_t ino,
> +			bool dealloc);
> +
>   int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
>   {
>   	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> @@ -2181,6 +2192,8 @@ int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
>   		if (c.fix_on) {
>   			DBG(0, "Fixing Quota file ([%3d] ino [0x%x])\n",
>   							qtype, ino);
> +			fsck_disconnect_file(sbi, ino, true);
> +			f2fs_rebuild_qf_inode(sbi, qtype);
>   			f2fs_filesize_update(sbi, ino, 0);
>   			ret = quota_write_inode(sbi, qtype);
>   			if (!ret) {
> @@ -2874,10 +2887,53 @@ static int fsck_do_reconnect_file(struct f2fs_sb_info *sbi,
>   	return 0;
>   }
>   
> -static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
> -					struct f2fs_inode *inode, nid_t nid)
> +static inline void release_inode_cnt(struct f2fs_sb_info *sbi, bool dealloc)
> +{
> +	F2FS_FSCK(sbi)->chk.valid_inode_cnt--;
> +	if (dealloc)
> +		sbi->total_valid_inode_count--;
> +}
> +
> +static inline void release_node_cnt(struct f2fs_sb_info *sbi, bool dealloc)
> +{
> +	F2FS_FSCK(sbi)->chk.valid_node_cnt--;
> +	if (dealloc)
> +		sbi->total_valid_node_count--;
> +}
> +
> +static inline void release_block_cnt(struct f2fs_sb_info *sbi, bool dealloc)
> +{
> +	F2FS_FSCK(sbi)->chk.valid_blk_cnt--;
> +	if (dealloc)
> +		sbi->total_valid_block_count--;
> +}
> +
> +static inline void release_block(struct f2fs_sb_info *sbi, u64 blkaddr,
> +			bool dealloc)
> +{
> +	f2fs_clear_main_bitmap(sbi, blkaddr);
> +	if (dealloc) {
> +		struct seg_entry *se;
> +		u64 offset;
> +
> +		se = get_seg_entry(sbi, GET_SEGNO(sbi, blkaddr));
> +		offset = OFFSET_IN_SEG(sbi, blkaddr);
> +		se->valid_blocks--;
> +		f2fs_clear_bit(offset, (char *)se->cur_valid_map);
> +		se->dirty = 1;
> +		f2fs_clear_sit_bitmap(sbi, blkaddr);
> +	}
> +}
> +
> +static inline void release_nat_entry(struct f2fs_sb_info *sbi, u32 nid)
> +{
> +	nullify_nat_entry(sbi, nid);
> +	F2FS_FSCK(sbi)->chk.valid_nat_entry_cnt--;
> +}
> +
> +static void fsck_disconnect_file_dnode(struct f2fs_sb_info *sbi,
> +			struct f2fs_inode *inode, nid_t nid, bool dealloc)
>   {
> -	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
>   	struct f2fs_node *node;
>   	struct node_info ni;
>   	u32 addr;
> @@ -2890,27 +2946,29 @@ static void fsck_failed_reconnect_file_dnode(struct f2fs_sb_info *sbi,
>   	err = dev_read_block(node, ni.blk_addr);
>   	ASSERT(err >= 0);
>   
> -	fsck->chk.valid_node_cnt--;
> -	fsck->chk.valid_blk_cnt--;
> -	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> +	release_node_cnt(sbi, dealloc);
> +	release_block_cnt(sbi, dealloc);
> +	release_block(sbi, ni.blk_addr, dealloc);
>   
>   	for (i = 0; i < ADDRS_PER_BLOCK(inode); i++) {
>   		addr = le32_to_cpu(node->dn.addr[i]);
>   		if (!addr)
>   			continue;
> -		fsck->chk.valid_blk_cnt--;
> +		release_block_cnt(sbi, dealloc);
>   		if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
>   			continue;
> -		f2fs_clear_main_bitmap(sbi, addr);
> +		release_block(sbi, addr, dealloc);
>   	}
>   
> +	if (dealloc)
> +		release_nat_entry(sbi, nid);
> +
>   	free(node);
>   }
>   
> -static void fsck_failed_reconnect_file_idnode(struct f2fs_sb_info *sbi,
> -					struct f2fs_inode *inode, nid_t nid)
> +static void fsck_disconnect_file_idnode(struct f2fs_sb_info *sbi,
> +			struct f2fs_inode *inode, nid_t nid, bool dealloc)
>   {
> -	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
>   	struct f2fs_node *node;
>   	struct node_info ni;
>   	nid_t tmp;
> @@ -2923,24 +2981,26 @@ static void fsck_failed_reconnect_file_idnode(struct f2fs_sb_info *sbi,
>   	err = dev_read_block(node, ni.blk_addr);
>   	ASSERT(err >= 0);
>   
> -	fsck->chk.valid_node_cnt--;
> -	fsck->chk.valid_blk_cnt--;
> -	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> +	release_node_cnt(sbi, dealloc);
> +	release_block_cnt(sbi, dealloc);
> +	release_block(sbi, ni.blk_addr, dealloc);
>   
>   	for (i = 0; i < NIDS_PER_BLOCK; i++) {
>   		tmp = le32_to_cpu(node->in.nid[i]);
>   		if (!tmp)
>   			continue;
> -		fsck_failed_reconnect_file_dnode(sbi, inode, tmp);
> +		fsck_disconnect_file_dnode(sbi, inode, tmp, dealloc);
>   	}
>   
> +	if (dealloc)
> +		release_nat_entry(sbi, nid);
> +
>   	free(node);
>   }
>   
> -static void fsck_failed_reconnect_file_didnode(struct f2fs_sb_info *sbi,
> -					struct f2fs_inode *inode, nid_t nid)
> +static void fsck_disconnect_file_didnode(struct f2fs_sb_info *sbi,
> +			struct f2fs_inode *inode, nid_t nid, bool dealloc)
>   {
> -	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
>   	struct f2fs_node *node;
>   	struct node_info ni;
>   	nid_t tmp;
> @@ -2953,28 +3013,26 @@ static void fsck_failed_reconnect_file_didnode(struct f2fs_sb_info *sbi,
>   	err = dev_read_block(node, ni.blk_addr);
>   	ASSERT(err >= 0);
>   
> -	fsck->chk.valid_node_cnt--;
> -	fsck->chk.valid_blk_cnt--;
> -	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> +	release_node_cnt(sbi, dealloc);
> +	release_block_cnt(sbi, dealloc);
> +	release_block(sbi, ni.blk_addr, dealloc);
>   
>   	for (i = 0; i < NIDS_PER_BLOCK; i++) {
>   		tmp = le32_to_cpu(node->in.nid[i]);
>   		if (!tmp)
>   			continue;
> -		fsck_failed_reconnect_file_idnode(sbi, inode, tmp);
> +		fsck_disconnect_file_idnode(sbi, inode, tmp, dealloc);
>   	}
>   
> +	if (dealloc)
> +		release_nat_entry(sbi, nid);
> +
>   	free(node);
>   }
>   
> -/*
> - * Counters and main_area_bitmap are already changed during checking
> - * inode block, so clear them. There is no need to clear new blocks
> - * allocted to lost+found.
> - */
> -static void fsck_failed_reconnect_file(struct f2fs_sb_info *sbi, nid_t ino)
> +static void fsck_disconnect_file(struct f2fs_sb_info *sbi, nid_t ino,
> +			bool dealloc)
>   {
> -	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
>   	struct f2fs_node *node;
>   	struct node_info ni;
>   	nid_t nid;
> @@ -2988,18 +3046,18 @@ static void fsck_failed_reconnect_file(struct f2fs_sb_info *sbi, nid_t ino)
>   	ASSERT(err >= 0);
>   
>   	/* clear inode counters */
> -	fsck->chk.valid_inode_cnt--;
> -	fsck->chk.valid_node_cnt--;
> -	fsck->chk.valid_blk_cnt--;
> -	f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> +	release_inode_cnt(sbi, dealloc);
> +	release_node_cnt(sbi, dealloc);
> +	release_block_cnt(sbi, dealloc);
> +	release_block(sbi, ni.blk_addr, dealloc);
>   
>   	/* clear xnid counters */
>   	if (node->i.i_xattr_nid) {
>   		nid = le32_to_cpu(node->i.i_xattr_nid);
> -		fsck->chk.valid_node_cnt--;
> -		fsck->chk.valid_blk_cnt--;
> +		release_node_cnt(sbi, dealloc);
> +		release_block_cnt(sbi, dealloc);
>   		get_node_info(sbi, nid, &ni);
> -		f2fs_clear_main_bitmap(sbi, ni.blk_addr);
> +		release_block(sbi, ni.blk_addr, dealloc);

Needs to release xattr node's nat entry, right?

if (dealloc)
	release_nat_entry(sbi, nid);

Thanks,

>   	}
>   
>   	/* clear data counters */
> @@ -3009,10 +3067,10 @@ static void fsck_failed_reconnect_file(struct f2fs_sb_info *sbi, nid_t ino)
>   			block_t addr = le32_to_cpu(node->i.i_addr[ofs + i]);
>   			if (!addr)
>   				continue;
> -			fsck->chk.valid_blk_cnt--;
> +			release_block_cnt(sbi, dealloc);
>   			if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
>   				continue;
> -			f2fs_clear_main_bitmap(sbi, addr);
> +			release_block(sbi, addr, dealloc);
>   		}
>   	}
>   
> @@ -3024,18 +3082,24 @@ static void fsck_failed_reconnect_file(struct f2fs_sb_info *sbi, nid_t ino)
>   		switch (i) {
>   		case 0: /* direct node */
>   		case 1:
> -			fsck_failed_reconnect_file_dnode(sbi, &node->i, nid);
> +			fsck_disconnect_file_dnode(sbi, &node->i, nid,
> +					dealloc);
>   			break;
>   		case 2: /* indirect node */
>   		case 3:
> -			fsck_failed_reconnect_file_idnode(sbi, &node->i, nid);
> +			fsck_disconnect_file_idnode(sbi, &node->i, nid,
> +					dealloc);
>   			break;
>   		case 4: /* double indirect node */
> -			fsck_failed_reconnect_file_didnode(sbi, &node->i, nid);
> +			fsck_disconnect_file_didnode(sbi, &node->i, nid,
> +					dealloc);
>   			break;
>   		}
>   	}
>   
> +	if (dealloc)
> +		release_nat_entry(sbi, ino);
> +
>   	free(node);
>   }
>   
> @@ -3121,7 +3185,7 @@ static int fsck_reconnect_file(struct f2fs_sb_info *sbi)
>   			if (fsck_do_reconnect_file(sbi, lpf_node, node)) {
>   				DBG(1, "Failed to reconnect inode [0x%x]\n",
>   				    nid);
> -				fsck_failed_reconnect_file(sbi, nid);
> +				fsck_disconnect_file(sbi, nid, false);
>   				continue;
>   			}
>   
> diff --git a/fsck/segment.c b/fsck/segment.c
> index 3a9500f..4e326c4 100644
> --- a/fsck/segment.c
> +++ b/fsck/segment.c
> @@ -37,7 +37,7 @@ int reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
>   				return -ENOSPC;
>   			}
>   			if (is_node && fsck->chk.valid_node_cnt >=
> -					sbi->total_valid_node_count) {
> +					sbi->total_node_count) {
>   				ERR_MSG("Not enough space for node block\n");
>   				return -ENOSPC;
>   			}
> @@ -76,7 +76,7 @@ int reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
>   
>   	se = get_seg_entry(sbi, GET_SEGNO(sbi, blkaddr));
>   	offset = OFFSET_IN_SEG(sbi, blkaddr);
> -	se->type = type;
> +	se->type = se->orig_type = type;
>   	if (se->valid_blocks == 0)
>   		SM_I(sbi)->free_segments--;
>   	se->valid_blocks++;
> @@ -101,6 +101,7 @@ int reserve_new_block(struct f2fs_sb_info *sbi, block_t *to,
>   		if (c.func == FSCK) {
>   			fsck->chk.valid_blk_cnt++;
>   			if (is_node) {
> +				fsck->chk.valid_nat_entry_cnt++;
>   				fsck->chk.valid_node_cnt++;
>   				if (is_inode)
>   					fsck->chk.valid_inode_cnt++;
