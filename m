Return-Path: <linux-kernel+bounces-152090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 680A18AB8B0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C181F214A8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EB4610E;
	Sat, 20 Apr 2024 02:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcPk9puF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385DA48
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580169; cv=none; b=YiMuk1Rqw1aAe2+JqbWu23J76eEOxgfavbZ+BdCz1H7vaeUaZN6cO0Ib4wc7Ofc9P3jTJQwqLQM6tRVg8VtZSjJCl7/JcBFJud8bCojyGDjGFqaIiWgIjEE7RFoqiL8VN5TsRLM+dnH5bifUK4ibQLo0hfNGe+Oa5FxodagGh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580169; c=relaxed/simple;
	bh=Zj+Ogh39xK3UVqRSVy/m/GTxBKMVuCZMKLD1aaqY2AY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMWlgKQ00ku8U2EzxfQuEehTmtBhH3vilmmtaT9BFbmsmlHQRy+E0eLYiybye+WKfydbXed7Eg2cPbQpK5pdHrHhyIdFKlraFdD7/4kMS377lP8Ph0y3Obb4LG8Za7ck21xk6OMcEer6TNsFShbsf96bhZCl7aJBfopRiZxolU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcPk9puF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FECC072AA;
	Sat, 20 Apr 2024 02:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713580169;
	bh=Zj+Ogh39xK3UVqRSVy/m/GTxBKMVuCZMKLD1aaqY2AY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rcPk9puFrwkLZLePcpkE1JwO+26xtTkFCtyWJzrcHUZW9C8FJVR1RWPIWXe4ZY8ms
	 OevZaopOValGfzX7etqqftS2dWYabEpMbfwqL23vJdUoMGdQblYdmJqgwmd5K2S44f
	 7FvpSYbvBGmDwht/jk61zgIAiQzYGYu3fBRAOCv2HoFTk5GFLfS3V6Jil5briTRmVE
	 xgfqW0V7sVpQasvPan3SNKHxrR235cviMPfnZqqSTG+Ypnkf/bL57iicYu4UWb3R4x
	 +VXYEnB4iVqMGcgWJdZOPwsZfzv9NWE/4SqnFS98tUyqZV27YxotuPnpdW/CxJwfoW
	 n9ppBb68NI1SQ==
Message-ID: <feb59013-b002-4064-8d50-656af2790897@kernel.org>
Date: Sat, 20 Apr 2024 10:29:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: assign write hint in direct write IO path
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Hyunchul Lee <cheol.lee@lge.com>
References: <20240418033334.861570-1-chao@kernel.org>
 <ZiKvg81HxG088cwm@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <ZiKvg81HxG088cwm@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/20 1:53, Jaegeuk Kim wrote:
> Thanks, Chao,
> 
> If you don't mind, can I merge this into my patch. Ok?

No problem. :)

Thanks,

> 
> On 04/18, Chao Yu wrote:
>> f2fs has its own write_hint policy, let's assign write hint for
>> direct write bio.
>>
>> Cc: Hyunchul Lee <cheol.lee@lge.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/f2fs.h    |  1 +
>>   fs/f2fs/file.c    | 15 ++++++++++++++-
>>   fs/f2fs/segment.c | 17 +++++++++++------
>>   3 files changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index b3b878acc86b..3f7196122574 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -3722,6 +3722,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
>>   			block_t old_addr, block_t new_addr,
>>   			unsigned char version, bool recover_curseg,
>>   			bool recover_newaddr);
>> +int f2fs_get_segment_temp(int seg_type);
>>   int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>>   			block_t old_blkaddr, block_t *new_blkaddr,
>>   			struct f2fs_summary *sum, int type,
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index ac1ae85f3cc3..d382f8bc2fbe 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -4685,8 +4685,21 @@ static int f2fs_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
>>   	return 0;
>>   }
>>   
>> +static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
>> +					struct bio *bio, loff_t file_offset)
>> +{
>> +	struct inode *inode = iter->inode;
>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> +	int seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
>> +	enum temp_type temp = f2fs_get_segment_temp(seg_type);
>> +
>> +	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
>> +	submit_bio(bio);
>> +}
>> +
>>   static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
>> -	.end_io = f2fs_dio_write_end_io,
>> +	.end_io		= f2fs_dio_write_end_io,
>> +	.submit_io	= f2fs_dio_write_submit_io,
>>   };
>>   
>>   static void f2fs_flush_buffered_write(struct address_space *mapping,
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index daa94669f7ee..2206199e8099 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -3502,6 +3502,15 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>>   	}
>>   }
>>   
>> +int f2fs_get_segment_temp(int seg_type)
>> +{
>> +	if (IS_HOT(seg_type))
>> +		return HOT;
>> +	else if (IS_WARM(seg_type))
>> +		return WARM;
>> +	return COLD;
>> +}
>> +
>>   static int __get_segment_type(struct f2fs_io_info *fio)
>>   {
>>   	int type = 0;
>> @@ -3520,12 +3529,8 @@ static int __get_segment_type(struct f2fs_io_info *fio)
>>   		f2fs_bug_on(fio->sbi, true);
>>   	}
>>   
>> -	if (IS_HOT(type))
>> -		fio->temp = HOT;
>> -	else if (IS_WARM(type))
>> -		fio->temp = WARM;
>> -	else
>> -		fio->temp = COLD;
>> +	fio->temp = f2fs_get_segment_temp(type);
>> +
>>   	return type;
>>   }
>>   
>> -- 
>> 2.40.1

