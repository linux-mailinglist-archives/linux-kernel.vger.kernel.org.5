Return-Path: <linux-kernel+bounces-70671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8983B859AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4381C21249
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5448B4C87;
	Mon, 19 Feb 2024 03:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9MgkbUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE64128E2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708312402; cv=none; b=DsKgR4LEvMzKVVzKTvpJwTYg1sEQyS2cTKw1ffdfUpQLMjqjx3RhQiSQ8K8JCE7/JlESGJXnGEzRautkQRr3S9wqiQ0y8uG584bwrIrVEOs+aNEDbv5bmRtYP8n+IIb24wKIUidiFulUhtN+mg6IwuADfbDstn4AOyI+My5Wh58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708312402; c=relaxed/simple;
	bh=vq0VEJAynaPzZpllpCAymXzLVyScLU3lDjD1xtMA6ks=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=N8zYS4V3U6ulEdrIRCalQtLr91V453gQjIOPJESTzS1NeUvr9GpSRkCC9rWh7olredqtRv40VvXfucUFZbaxFwLCHGsbVlHHZRRLH29xdnSloO+gGm1RxDuReycA5gCOIiC1uhFc5rS6PvEJZ7GH3X11WxE4esvZJguNs5h1oXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9MgkbUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFBCC43390;
	Mon, 19 Feb 2024 03:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708312402;
	bh=vq0VEJAynaPzZpllpCAymXzLVyScLU3lDjD1xtMA6ks=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=Z9MgkbULBD4KuZMGI+r3Mjt+s/DG6XCU9szLF0FOMpjStKU3HfQs8EezxvApFK5j1
	 PUCzK2WiwhPa200O730Kr1puvhye13eb/iMaEyfr8KhASGyK2GA1OQzkHVBEqXnTyY
	 VyMSJ+a7eaEKnXEe3ETMPzPQ+PTgUu8C3ieD+OtzUrJswfZe5F/TWaJMErG4R25FRI
	 PSjbV9v+3bc2Edb5lTCsVEt8/7oaD5rYBZrdrgIs3OlCdkdP2FFFmSeIBKxNk6Q9xt
	 8znF7bu/z2PxehwLO4p032pooTZRWPpgaiA/gMB5fx1Q9RJWlQqy8qiQ35t19Mg1Bg
	 X7hDTEwop9wVg==
Message-ID: <8e69aa15-9779-4696-98ab-f173666a87a7@kernel.org>
Date: Mon, 19 Feb 2024 11:13:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix to return EIO when reading after device removal
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240206032513.2495025-1-chao@kernel.org>
 <ZcQd3DtIpiA5P9DQ@google.com>
Content-Language: en-US
In-Reply-To: <ZcQd3DtIpiA5P9DQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/8 8:18, Jaegeuk Kim wrote:
> On 02/06, Chao Yu wrote:
>> generic/730 2s ... - output mismatch (see /media/fstests/results//generic/730.out.bad)
>>      --- tests/generic/730.out	2023-08-07 01:39:51.055568499 +0000
>>      +++ /media/fstests/results//generic/730.out.bad	2024-02-06 02:26:43.000000000 +0000
>>      @@ -1,2 +1 @@
>>       QA output created by 730
>>      -cat: -: Input/output error
>>      ...
>>      (Run 'diff -u /media/fstests/tests/generic/730.out /media/fstests/results//generic/730.out.bad'  to see the entire diff)
>> Ran: generic/730
>> Failures: generic/730
>> Failed 1 of 1 tests
>>
>> This patch adds a check condition in f2fs_file_read_iter() to
>> detect cp_error status after device removal, and retrurn -EIO
>> for such case.
> 
> Can we check device removal?

We can use blk_queue_dying() to detect device removal, but, IMO, device
removal can almost not happen in Android, not sure for distros or server,
do you want to add this check condition into f2fs_cp_error()?

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/file.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 45b7e3610b0f..9e4386d4144c 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -4462,6 +4462,9 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>   	const loff_t pos = iocb->ki_pos;
>>   	ssize_t ret;
>>   
>> +	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>> +		return -EIO;
>> +
>>   	if (!f2fs_is_compress_backend_ready(inode))
>>   		return -EOPNOTSUPP;
>>   
>> -- 
>> 2.40.1

