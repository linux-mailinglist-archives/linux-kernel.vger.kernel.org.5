Return-Path: <linux-kernel+bounces-32278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF9835957
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF5C1C21871
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760D2EA4;
	Mon, 22 Jan 2024 02:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfhM1ujm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D37FF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705890354; cv=none; b=PLVARjAisfkFJfYnjIRgGVVzNq1LDZBXA39X2x6msxP99G4teib/dKdrunQB4ZTitt9i5/pVsAQVQJ7L9bBYPL65XnzIWfbC386/6HNSq1v6x9hyVGPedduc4F5IJh39LTMb1mfF0al53LMDtvutfMVWr6AQyWvbRiOyeC0FK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705890354; c=relaxed/simple;
	bh=pqWOr9OHT2JahfiJ6SPNOeiDvCjj5v7HglRe9H85FMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfWaBrqjwmbDW/TznMZjljxrFGsqdyNg0/2cpyA3CZAwM1fbmKTUfm2Gjp4kyOTFL4jk11WBxsTSdGTzWEqRlq5px309j1vSvhWIUmDbaduiIlLJtpBwo4U5MrxnPUXggVclINTetw3QWMyr6uI2vM8sIw7Lck+Sm+NB9YtCwqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfhM1ujm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5708BC433C7;
	Mon, 22 Jan 2024 02:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705890354;
	bh=pqWOr9OHT2JahfiJ6SPNOeiDvCjj5v7HglRe9H85FMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NfhM1ujm7lZG5xqfp+dzY2VVZcmA1iatFM7qmPT00b2v09nGPD74+smS4rFECCVjU
	 7CXGGKHeb8JjjCeJQWodxgI9NTYOHasTY2/0c6vulNoq0eQN2OKZBvtDchldWIJwVy
	 6pBpjOIn+I1sFvHkFqTeMG3Z49hJpYlPufCu/63SIN6HVT4BjC1C6k+IEiUAOV5dMl
	 FKNxPlIS8PFxigtYhRrZS73Wcy0CgyfMX3u81ypVFnqXnWY5kKUkpfdr8Slu3oi1s2
	 wueqVMQQ2MSvufG82v72IRE2qQHLnZlZgnSwMR1PoEV+uSyGtHx2/hz8KSF9p/Y7n/
	 EpLr0tJa9a8pA==
Message-ID: <e8e44b18-26da-47d0-85fd-ab8c35006f65@kernel.org>
Date: Mon, 22 Jan 2024 10:25:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: compress: fix to cover
 f2fs_disable_compressed_file() w/ i_sem
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240111064406.2970205-1-chao@kernel.org>
 <ZabLA4EWNzNFGb5Q@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZabLA4EWNzNFGb5Q@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/17 2:29, Jaegeuk Kim wrote:
> On 01/11, Chao Yu wrote:
>> - f2fs_disable_compressed_file
>>    - check inode_has_data
>> 					- f2fs_file_mmap
>> 					- mkwrite
>> 					 - f2fs_get_block_locked
>> 					 : update metadata in compressed
>> 					   inode's disk layout
>>    - fi->i_flags &= ~F2FS_COMPR_FL
>>    - clear_inode_flag(inode, FI_COMPRESSED_FILE);
>>
>> we should use i_sem lock to prevent above race case.
>>
>> Meanwhile, this patch adds i_size check to restrict compress inode
>> conversion condition.
> 
> Sorry, what was the reason to check i_size?

Oh, I don't see any race condition, let's remove it in v2.

Thanks,

> 
>>
>> Fixes: 4c8ff7095bef ("f2fs: support data compression")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/f2fs.h | 18 ++++++++++++++++--
>>   fs/f2fs/file.c |  5 ++---
>>   2 files changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 74729db0b381..e2e0ca45f881 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -4406,19 +4406,33 @@ static inline int set_compress_context(struct inode *inode)
>>   #endif
>>   }
>>   
>> +static inline bool inode_has_data(struct inode *inode)
>> +{
>> +	return (S_ISREG(inode->i_mode) &&
>> +		(F2FS_HAS_BLOCKS(inode) || i_size_read(inode)));
>> +}
>> +
>>   static inline bool f2fs_disable_compressed_file(struct inode *inode)
>>   {
>>   	struct f2fs_inode_info *fi = F2FS_I(inode);
>>   
>> -	if (!f2fs_compressed_file(inode))
>> +	f2fs_down_write(&F2FS_I(inode)->i_sem);
>> +
>> +	if (!f2fs_compressed_file(inode)) {
>> +		f2fs_up_write(&F2FS_I(inode)->i_sem);
>>   		return true;
>> -	if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
>> +	}
>> +	if (f2fs_is_mmap_file(inode) || inode_has_data(inode)) {
>> +		f2fs_up_write(&F2FS_I(inode)->i_sem);
>>   		return false;
>> +	}
>>   
>>   	fi->i_flags &= ~F2FS_COMPR_FL;
>>   	stat_dec_compr_inode(inode);
>>   	clear_inode_flag(inode, FI_COMPRESSED_FILE);
>>   	f2fs_mark_inode_dirty_sync(inode, true);
>> +
>> +	f2fs_up_write(&F2FS_I(inode)->i_sem);
>>   	return true;
>>   }
>>   
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 0e4c871d6aed..5e5df234eb92 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1926,8 +1926,7 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>   
>>   			f2fs_down_write(&F2FS_I(inode)->i_sem);
>>   			if (!f2fs_may_compress(inode) ||
>> -					(S_ISREG(inode->i_mode) &&
>> -					F2FS_HAS_BLOCKS(inode))) {
>> +					inode_has_data(inode)) {
>>   				f2fs_up_write(&F2FS_I(inode)->i_sem);
>>   				return -EINVAL;
>>   			}
>> @@ -4011,7 +4010,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>>   		goto out;
>>   	}
>>   
>> -	if (F2FS_HAS_BLOCKS(inode)) {
>> +	if (inode_has_data(inode)) {
>>   		ret = -EFBIG;
>>   		goto out;
>>   	}
>> -- 
>> 2.40.1

