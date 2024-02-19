Return-Path: <linux-kernel+bounces-70810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1543A859CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60A6283465
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355E208C6;
	Mon, 19 Feb 2024 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tt0hTkjP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B949208B2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708326887; cv=none; b=DFMNkat7JuU5QgN1TeZjk9YmawnbFyUn5ifQUz/xtfULw32QLny43PtoXpwcbnpt0GKkfn576nTxQWXLOsmd6zMRhThV1W94YW7jK+7TYDsbQePWRYD6sbaXua8FhmoFPhUcQlo2S0WSqxHvVo7Skp669Q2DPL0r7nDhv+5sYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708326887; c=relaxed/simple;
	bh=M3JjNo/uMWn6Nt2P8NOEOOPiTVBzyf4oipKYVYsFXnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=InNlgnWpUKS366juPA4TDY44h/Kftn4G2WmzU3xdb/5oNrWyhdX1ShWjGEMzYCGbc92Vlb1y/eUQcgi17e3jf5+JEDu30Oz3hzB06B7E+0Cz340u0TTeh1+RUmNhPoa5nMSyU8oBjS5CaDBjenvHqkbbS9eRP/T6Gt+Nl0NGwds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tt0hTkjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FF6C433F1;
	Mon, 19 Feb 2024 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708326886;
	bh=M3JjNo/uMWn6Nt2P8NOEOOPiTVBzyf4oipKYVYsFXnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tt0hTkjPoLnsVkzH+V49hmlsgqXaVg6qqwJ94VXDq/CZVrjII+Ki3UpoVKoq0FRWI
	 klu4NbIdBZS5wXq3IbT4tWxyPOSiyZlwP9MEJCIQDRGLpsjsnjp+dE9+Dcdl8myj40
	 NB85xPJH9lMzldzTE8r5zcWSwPSQg6SnofkX4rmgx6UDpXAulv+kCmMjMPBmb9sCBw
	 k35HovDEtTS2jIRMjfu6JQa2DbmJTQA2k/DSuX37Jn6Ymgd2Jod9K0bZa1pR4sGfud
	 ZCDlAwbE9+CvZNLzWo1koza53KwnmdgiIXPpuPM9HHv/hj6xB9dNwZLcbPs/8QUZHI
	 nvHjlfPp801Jw==
Message-ID: <e7d269c8-c3f2-4d86-8ac2-653912880119@kernel.org>
Date: Mon, 19 Feb 2024 15:14:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] f2fs: stop checkpoint when get a out-of-bounds
 segment
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
 <1707271264-5551-5-git-send-email-zhiguo.niu@unisoc.com>
 <ZcQdeC4e7rnr9pCr@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZcQdeC4e7rnr9pCr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/8 8:16, Jaegeuk Kim wrote:
> On 02/07, Zhiguo Niu wrote:
>> There is low probability that an out-of-bounds segment will be got
>> on a small-capacity device. In order to prevent subsequent write requests
>> allocating block address from this invalid segment, which may cause
>> unexpected issue, stop checkpoint should be performed.
>>
>> Also introduce a new stop cp reason:  STOP_CP_REASON_OUTOF_RAGNE.
> 
> OUT_OF_RANGE?

Maybe STOP_CP_REASON_NO_SEGMENT will be more explicit?

Thanks,

> 
>>
>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>> ---
>>   fs/f2fs/segment.c       | 12 ++++++++++--
>>   include/linux/f2fs_fs.h |  1 +
>>   2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 6772ad4..6fe2baf 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2666,7 +2666,11 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>>   		if (dir == ALLOC_RIGHT) {
>>   			secno = find_first_zero_bit(free_i->free_secmap,
>>   							MAIN_SECS(sbi));
>> -			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
>> +			if (secno >= MAIN_SECS(sbi)) {
>> +				f2fs_stop_checkpoint(sbi, false,
>> +						STOP_CP_REASON_OUTOF_RAGNE);
>> +				f2fs_bug_on(sbi, 1);
>> +			}
>>   		} else {
>>   			go_left = 1;
>>   			left_start = hint - 1;
>> @@ -2682,7 +2686,11 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>>   		}
>>   		left_start = find_first_zero_bit(free_i->free_secmap,
>>   							MAIN_SECS(sbi));
>> -		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
>> +		if (left_start >= MAIN_SECS(sbi)) {
>> +			f2fs_stop_checkpoint(sbi, false,
>> +					STOP_CP_REASON_OUTOF_RAGNE);
>> +			f2fs_bug_on(sbi, 1);
>> +		}
>>   		break;
>>   	}
>>   	secno = left_start;
>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> index 053137a0..72c6782 100644
>> --- a/include/linux/f2fs_fs.h
>> +++ b/include/linux/f2fs_fs.h
>> @@ -81,6 +81,7 @@ enum stop_cp_reason {
>>   	STOP_CP_REASON_CORRUPTED_SUMMARY,
>>   	STOP_CP_REASON_UPDATE_INODE,
>>   	STOP_CP_REASON_FLUSH_FAIL,
>> +	STOP_CP_REASON_OUTOF_RAGNE,
>>   	STOP_CP_REASON_MAX,
>>   };
>>   
>> -- 
>> 1.9.1

