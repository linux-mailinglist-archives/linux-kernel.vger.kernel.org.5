Return-Path: <linux-kernel+bounces-12395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D34D81F42F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6C71F21FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98453C07;
	Thu, 28 Dec 2023 02:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2MUYIXW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224BD3C00
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 02:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901E8C433C7;
	Thu, 28 Dec 2023 02:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703731639;
	bh=2AjIOZxyvSsnOs5RvR4gm8XqtCrUbOnC19jU5B+aS1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f2MUYIXWxRuy8oqd0WDfNtx+tGlwmeRADgTRQn8dzT9IilUKJdP8x7LlaxWl5DUND
	 yVdjZFw8nTmI/pTAvBeWsgsp91dz/UkWUVdd7jkN4VTpWju2rTbyJp5BEu9TvVMx1n
	 JP2GUI+Kc+h4MlJppB7U1Kc4TtlQHIypIYgiQU/IdH9/fRywlWMzMR6chUMA8FISqj
	 kC0t4Cst+Z8fZrpeeoUaq2ScDUXUyQQzZuKJ97qwF7pf1nSVLsHaT5dKC17NMQ6MGs
	 yxrcWiBOCu7hwb+tY9uzIleF0Q+CeJKPIv7U4sQbz5ADL7NmGIefMKMi3QE3iDosXo
	 UaljN8u42/MgQ==
Message-ID: <b4b08863-4cd5-471f-9f88-ca3559201446@kernel.org>
Date: Thu, 28 Dec 2023 10:47:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] f2fs: introduce FAULT_INCONSISTENCE
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20231225144335.2548-1-chao@kernel.org>
 <ZYyt7dNmPw0aMa5l@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZYyt7dNmPw0aMa5l@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/28 7:06, Jaegeuk Kim wrote:
> On 12/25, Chao Yu wrote:
>> We will encounter below inconsistent status when FAULT_BLKADDR type
>> fault injection is on.
>>
>> Info: checkpoint state = d6 :  nat_bits crc fsck compacted_summary orphan_inodes sudden-power-off
>> [ASSERT] (fsck_chk_inode_blk:1254)  --> ino: 0x1c100 has i_blocks: 000000c0, but has 191 blocks
>> [FIX] (fsck_chk_inode_blk:1260)  --> [0x1c100] i_blocks=0x000000c0 -> 0xbf
>> [FIX] (fsck_chk_inode_blk:1269)  --> [0x1c100] i_compr_blocks=0x00000026 -> 0x27
>> [ASSERT] (fsck_chk_inode_blk:1254)  --> ino: 0x1cadb has i_blocks: 0000002f, but has 46 blocks
>> [FIX] (fsck_chk_inode_blk:1260)  --> [0x1cadb] i_blocks=0x0000002f -> 0x2e
>> [FIX] (fsck_chk_inode_blk:1269)  --> [0x1cadb] i_compr_blocks=0x00000011 -> 0x12
>> [ASSERT] (fsck_chk_inode_blk:1254)  --> ino: 0x1c62c has i_blocks: 00000002, but has 1 blocks
>> [FIX] (fsck_chk_inode_blk:1260)  --> [0x1c62c] i_blocks=0x00000002 -> 0x1
>>
>> After we inject fault into f2fs_is_valid_blkaddr() during truncation,
>> a) it missed to increase @nr_free or @valid_blocks
>> b) it can cause in blkaddr leak in truncated dnode
>> Which may cause inconsistent status.
>>
>> This patch separates FAULT_INCONSISTENCE from FAULT_BLKADDR, so that
> 
> Could you please rename FAULT_INCONSISTENCE to give exactly what it tries
> to break?

Sure, maybe FAULT_BLKADDR_INCONSISTENCE... let me know if you want/have a
better one. :)

Thanks,

> 
>> we can:
>> a) use FAULT_INCONSISTENCE in f2fs_truncate_data_blocks_range() to
>> simulate inconsistent issue independently,
>> b) FAULT_BLKADDR fault will not cause any inconsistent status, we can
>> just use it to check error path handling in kernel side.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - make __f2fs_is_valid_blkaddr() void.
>>   Documentation/ABI/testing/sysfs-fs-f2fs |  1 +
>>   Documentation/filesystems/f2fs.rst      |  1 +
>>   fs/f2fs/checkpoint.c                    | 19 +++++++++++++++----
>>   fs/f2fs/f2fs.h                          |  3 +++
>>   fs/f2fs/file.c                          |  8 ++++++--
>>   fs/f2fs/super.c                         |  1 +
>>   6 files changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
>> index 4f1d4e636d67..649aabac16c2 100644
>> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
>> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
>> @@ -708,6 +708,7 @@ Description:	Support configuring fault injection type, should be
>>   		FAULT_DQUOT_INIT         0x000010000
>>   		FAULT_LOCK_OP            0x000020000
>>   		FAULT_BLKADDR            0x000040000
>> +		FAULT_INCONSISTENCE      0x000080000
>>   		===================      ===========
>>   
>>   What:		/sys/fs/f2fs/<disk>/discard_io_aware_gran
>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>> index d32c6209685d..5616fb8ae207 100644
>> --- a/Documentation/filesystems/f2fs.rst
>> +++ b/Documentation/filesystems/f2fs.rst
>> @@ -206,6 +206,7 @@ fault_type=%d		 Support configuring fault injection type, should be
>>   			 FAULT_DQUOT_INIT	  0x000010000
>>   			 FAULT_LOCK_OP		  0x000020000
>>   			 FAULT_BLKADDR		  0x000040000
>> +			 FAULT_INCONSISTENCE	  0x000080000
>>   			 ===================	  ===========
>>   mode=%s			 Control block allocation mode which supports "adaptive"
>>   			 and "lfs". In "lfs" mode, there should be no random
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index b0597a539fc5..84546f529cf0 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -170,12 +170,9 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>>   	return exist;
>>   }
>>   
>> -bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>> +static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>   					block_t blkaddr, int type)
>>   {
>> -	if (time_to_inject(sbi, FAULT_BLKADDR))
>> -		return false;
>> -
>>   	switch (type) {
>>   	case META_NAT:
>>   		break;
>> @@ -230,6 +227,20 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>   	return true;
>>   }
>>   
>> +bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>> +					block_t blkaddr, int type)
>> +{
>> +	if (time_to_inject(sbi, FAULT_BLKADDR))
>> +		return false;
>> +	return __f2fs_is_valid_blkaddr(sbi, blkaddr, type);
>> +}
>> +
>> +bool f2fs_is_valid_blkaddr_raw(struct f2fs_sb_info *sbi,
>> +					block_t blkaddr, int type)
>> +{
>> +	return __f2fs_is_valid_blkaddr(sbi, blkaddr, type);
>> +}
>> +
>>   /*
>>    * Readahead CP/NAT/SIT/SSA/POR pages
>>    */
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 34b20700b5ec..3985296e64cb 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -61,6 +61,7 @@ enum {
>>   	FAULT_DQUOT_INIT,
>>   	FAULT_LOCK_OP,
>>   	FAULT_BLKADDR,
>> +	FAULT_INCONSISTENCE,
>>   	FAULT_MAX,
>>   };
>>   
>> @@ -3767,6 +3768,8 @@ struct page *f2fs_get_meta_page_retry(struct f2fs_sb_info *sbi, pgoff_t index);
>>   struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index);
>>   bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>   					block_t blkaddr, int type);
>> +bool f2fs_is_valid_blkaddr_raw(struct f2fs_sb_info *sbi,
>> +					block_t blkaddr, int type);
>>   int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
>>   			int type, bool sync);
>>   void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index,
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 9f4e21b5916c..b5149f1f2a20 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -590,9 +590,13 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>>   		f2fs_set_data_blkaddr(dn, NULL_ADDR);
>>   
>>   		if (__is_valid_data_blkaddr(blkaddr)) {
>> -			if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
>> -					DATA_GENERIC_ENHANCE))
>> +			if (time_to_inject(sbi, FAULT_INCONSISTENCE))
>> +				continue;
>> +			if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
>> +						DATA_GENERIC_ENHANCE)) {
>> +				f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>   				continue;
>> +			}
>>   			if (compressed_cluster)
>>   				valid_blocks++;
>>   		}
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 206d03c82d96..9a5c5e06f766 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -62,6 +62,7 @@ const char *f2fs_fault_name[FAULT_MAX] = {
>>   	[FAULT_DQUOT_INIT]	= "dquot initialize",
>>   	[FAULT_LOCK_OP]		= "lock_op",
>>   	[FAULT_BLKADDR]		= "invalid blkaddr",
>> +	[FAULT_INCONSISTENCE]	= "inconsistence",
>>   };
>>   
>>   void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
>> -- 
>> 2.40.1

