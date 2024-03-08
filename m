Return-Path: <linux-kernel+bounces-96397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6074F875B9F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175B5282F16
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4780B2134B;
	Fri,  8 Mar 2024 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGREz/gF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B9A21101
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859335; cv=none; b=XAZ9Y+OJLJVilcOWObWoCc+RcWsIQw/eD70jHsgMntClyd8TeV44FQ6LbymHAaOu57YRHkDoRSGdQIEpQLJ0w8m7xkmFl+ewUgcx3E3Erg3q9cVaPtxOMto6rq5/RGlS17NlteRmcC0PJBGiGKDvy8Qfm5Rr536/GE0PAqCHNkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859335; c=relaxed/simple;
	bh=e0ccYedOJCgEkhN+ZKip6Y2Wg4KOHk1fAiTFxhhILoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+gdsYhkvXQqO2sJYGOezWPH25DDEZWfDRkGBEbkofKgbQ4GWPakk4dpXMx0QEKuRFtp1qWMyrNrnR9WvRtiCxsmLus6gjoPVf/qxsuxoIOUx61JvIZlioLo28EDwMaZf7Sff1K2/HkK+EeyOjgcO5ECLN/AtY3ci2tWElCZjIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGREz/gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16806C433F1;
	Fri,  8 Mar 2024 00:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709859334;
	bh=e0ccYedOJCgEkhN+ZKip6Y2Wg4KOHk1fAiTFxhhILoU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XGREz/gF4eq/YRDqV7Ao6RgZ7MpE/xqApokBvdQ5PrQb2SXpxBBnt0r8263bpM8D/
	 fYnr3kCI8JEuF0+0DMsJF03P4GRuZ8u4guRAY8aNqdl/9UVRXSxCdX8LRx7xfwuymt
	 RodQndq+27/22PdVul1PDxqSqhpcT4gj0/NydCnxVuBpd8OsppqSwPLYAvzJoMwpcS
	 h0B6XR+2ZE112Wfl/yNZH0NglxX8xhd0UKlpcedHPpbHv2BhAMxEljLK8lPo0HN+zT
	 TufD6Bq7VBq/s/t/65pE+7ApImBeIGTIgYgp7EKp8LL+kFICnGK3nm+TJfL4XKD1o1
	 GLFzC0dMWGNWg==
Message-ID: <2c8ef129-9381-4c82-a421-57b698a18291@kernel.org>
Date: Fri, 8 Mar 2024 08:55:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix to truncate meta inode pages forcely
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240307151235.3864725-1-chao@kernel.org>
 <ZeoJa705xDrPRNQY@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZeoJa705xDrPRNQY@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/8 2:37, Jaegeuk Kim wrote:
> On 03/07, Chao Yu wrote:
>> Below race case can cause data corruption:
>>
>> Thread A				GC thread
>> - f2fs_inplace_write_data
>> 					- gc_data_segment
>> 					 - ra_data_block
>> 					  - locked meta_inode page
>>   - invalidate_mapping_pages
>>   : fail to invalidate meta_inode page
>>     due to lock failure or dirty|writeback
>>     status
> 
> Wasn't the original data page locked in both cases?

Oh, the race case needs to fixed as below:

Thread A				GC thread
					- gc_data_segment
					 - ra_data_block
					  - locked meta_inode page
- f2fs_inplace_write_data
  - invalidate_mapping_pages
  : fail to invalidate meta_inode page
    due to lock failure or dirty|writeback
    status
  - f2fs_submit_page_bio
  : write last dirty data to old blkaddr
					 - move_data_block
					  - load old data from meta_inode page
					  - f2fs_submit_page_write
					  : write old data to new blkaddr

There is a hole in between ra_data_block() and move_data_block(),
in where the data page is unlocked.

Thanks,

> 
>>   - f2fs_submit_page_bio
>>   : write last dirty data to old blkaddr
>> 					 - move_data_block
>> 					  - load old data from meta_inode page
>> 					  - f2fs_submit_page_write
>> 					  : write old data to new blkaddr
>>
>> Because invalidate_mapping_pages() will skip invalidating page when the
>> page has unclear status including locked, dirty, writeback and so on, so
>> we need to use truncate_inode_pages_range() instead of
>> invalidate_mapping_pages() to make sure meta_inode page will be dropped.
>>
>> Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
>> Fixes: e3b49ea36802 ("f2fs: invalidate META_MAPPING before IPU/DIO write")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/checkpoint.c    |  5 +++--
>>   fs/f2fs/f2fs.h          | 28 +++++++++++++++++++++++++++-
>>   fs/f2fs/segment.c       |  5 ++---
>>   include/linux/f2fs_fs.h |  1 +
>>   4 files changed, 33 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index a09a9609e228..55b7d2cf030f 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -1598,8 +1598,9 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>   	 */
>>   	if (f2fs_sb_has_encrypt(sbi) || f2fs_sb_has_verity(sbi) ||
>>   		f2fs_sb_has_compression(sbi))
>> -		invalidate_mapping_pages(META_MAPPING(sbi),
>> -				MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi) - 1);
>> +		f2fs_bug_on(sbi,
>> +			invalidate_inode_pages2_range(META_MAPPING(sbi),
>> +				MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi) - 1));
>>   
>>   	f2fs_release_ino_entry(sbi, false);
>>   
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 4836e7cb0efe..9814e5981a6a 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -4655,10 +4655,36 @@ static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
>>   	return f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
>>   }
>>   
>> +static inline void f2fs_truncate_meta_inode_pages(struct f2fs_sb_info *sbi,
>> +					block_t blkaddr, unsigned int cnt)
>> +{
>> +	bool need_submit = false;
>> +	int i = 0;
>> +
>> +	do {
>> +		struct page *page;
>> +
>> +		page = find_get_page(META_MAPPING(sbi), blkaddr + i);
>> +		if (page) {
>> +			if (PageWriteback(page))
>> +				need_submit = true;
>> +			f2fs_put_page(page, 0);
>> +		}
>> +	} while (++i < cnt && !need_submit);
>> +
>> +	if (need_submit)
>> +		f2fs_submit_merged_write_cond(sbi, sbi->meta_inode,
>> +							NULL, 0, DATA);
>> +
>> +	truncate_inode_pages_range(META_MAPPING(sbi),
>> +			F2FS_BLK_TO_BYTES((loff_t)blkaddr),
>> +			F2FS_BLK_END_BYTES((loff_t)(blkaddr + cnt - 1)));
>> +}
>> +
>>   static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
>>   								block_t blkaddr)
>>   {
>> -	invalidate_mapping_pages(META_MAPPING(sbi), blkaddr, blkaddr);
>> +	f2fs_truncate_meta_inode_pages(sbi, blkaddr, 1);
>>   	f2fs_invalidate_compress_page(sbi, blkaddr);
>>   }
>>   
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 4ff3b2d14ddf..20af48d7f784 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3741,8 +3741,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
>>   	}
>>   
>>   	if (fio->post_read)
>> -		invalidate_mapping_pages(META_MAPPING(sbi),
>> -				fio->new_blkaddr, fio->new_blkaddr);
>> +		f2fs_truncate_meta_inode_pages(sbi, fio->new_blkaddr, 1);
>>   
>>   	stat_inc_inplace_blocks(fio->sbi);
>>   
>> @@ -3932,7 +3931,7 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
>>   	for (i = 0; i < len; i++)
>>   		f2fs_wait_on_block_writeback(inode, blkaddr + i);
>>   
>> -	invalidate_mapping_pages(META_MAPPING(sbi), blkaddr, blkaddr + len - 1);
>> +	f2fs_truncate_meta_inode_pages(sbi, blkaddr, len);
>>   }
>>   
>>   static int read_compacted_summaries(struct f2fs_sb_info *sbi)
>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> index 755e9a41b196..a357287eac1e 100644
>> --- a/include/linux/f2fs_fs.h
>> +++ b/include/linux/f2fs_fs.h
>> @@ -27,6 +27,7 @@
>>   
>>   #define F2FS_BYTES_TO_BLK(bytes)	((bytes) >> F2FS_BLKSIZE_BITS)
>>   #define F2FS_BLK_TO_BYTES(blk)		((blk) << F2FS_BLKSIZE_BITS)
>> +#define F2FS_BLK_END_BYTES(blk)		(F2FS_BLK_TO_BYTES(blk + 1) - 1)
>>   
>>   /* 0, 1(node nid), 2(meta nid) are reserved node id */
>>   #define F2FS_RESERVED_NODE_NUM		3
>> -- 
>> 2.40.1

