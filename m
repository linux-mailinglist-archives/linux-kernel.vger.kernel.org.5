Return-Path: <linux-kernel+bounces-80715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDA2866B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603931F21D19
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C211C692;
	Mon, 26 Feb 2024 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB+Md4fL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C611C28F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934425; cv=none; b=FycWMojqpLZ2fDvvDv65PVeJ2qp7hppLK1ygupeNTbGRgZXbmnVXb2Ma7e728FwLzQeKVd2NMSQwLLm9LhOeIfzDULnyDbUQHXXivPh9TVk8u/R1B0De+QwvHGn6TedJ2i30Q1lGl8pcLNItL16k8GZPzoNs/FRGK6/aqExdTOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934425; c=relaxed/simple;
	bh=KaztjbJAu9AA6Q3r1wg6HIlBYGMJFuoPY5mQkV5N21k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dYZFdcNTW0AjuzguaiqvSK1y99UCNmPLWmWzltz+wL1aDNvkQbln46R9yoaaZ64fO99yO8mADjfYkY50ScNls+enSRXTsIMnPm10fjIjQGn9aFr7MichhWsosXHKo23O2SfcAI7uZwKO2DJ3dA0JXAbaEcVA7PzBgIzoXGN1o/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB+Md4fL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BBAC433C7;
	Mon, 26 Feb 2024 08:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708934424;
	bh=KaztjbJAu9AA6Q3r1wg6HIlBYGMJFuoPY5mQkV5N21k=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=LB+Md4fLk5a+tZj4Cuk9L8p08jvlDFgOEN2C2kA0a0llhHm/Aqp3b4x8wuHM/QM08
	 5O9o6u9GHSeJyMqU3HxQiRyzjJmWu8yjTIqGAJRWqNJ/qs02tNySL95sOcqRaTHh7K
	 y1HHy/KxQ8+jWQil+rd0MlR+BRfdZ54/fyb3g1lQvM/Va6cv+yWoev8WIpR90hLCeU
	 d2VLdiEPUKJbhL1/JVKKkQqMZPgQjnFQFG5gR/hKGcYRDJGgTBe4dVWiT0Hp7yfz2k
	 OQoNXz1poousLfzPi64o9ea9YmUckyCgWzks8jT9YlugO77IHaJnBt7+NvcBhuDWCe
	 23IBhMPWv2RPg==
Message-ID: <23aa8351-e002-4185-89c7-ccde6b5b0549@kernel.org>
Date: Mon, 26 Feb 2024 16:00:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to return EIO when reading after
 device removal
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240206032513.2495025-1-chao@kernel.org>
 <ZcQd3DtIpiA5P9DQ@google.com>
 <8e69aa15-9779-4696-98ab-f173666a87a7@kernel.org>
In-Reply-To: <8e69aa15-9779-4696-98ab-f173666a87a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Any comments?

Thanks,

On 2024/2/19 11:13, Chao Yu wrote:
> On 2024/2/8 8:18, Jaegeuk Kim wrote:
>> On 02/06, Chao Yu wrote:
>>> generic/730 2s ... - output mismatch (see /media/fstests/results//generic/730.out.bad)
>>>      --- tests/generic/730.out    2023-08-07 01:39:51.055568499 +0000
>>>      +++ /media/fstests/results//generic/730.out.bad    2024-02-06 02:26:43.000000000 +0000
>>>      @@ -1,2 +1 @@
>>>       QA output created by 730
>>>      -cat: -: Input/output error
>>>      ...
>>>      (Run 'diff -u /media/fstests/tests/generic/730.out /media/fstests/results//generic/730.out.bad'  to see the entire diff)
>>> Ran: generic/730
>>> Failures: generic/730
>>> Failed 1 of 1 tests
>>>
>>> This patch adds a check condition in f2fs_file_read_iter() to
>>> detect cp_error status after device removal, and retrurn -EIO
>>> for such case.
>>
>> Can we check device removal?
> 
> We can use blk_queue_dying() to detect device removal, but, IMO, device
> removal can almost not happen in Android, not sure for distros or server,
> do you want to add this check condition into f2fs_cp_error()?
> 
> Thanks,
> 
>>
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>   fs/f2fs/file.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 45b7e3610b0f..9e4386d4144c 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -4462,6 +4462,9 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>>       const loff_t pos = iocb->ki_pos;
>>>       ssize_t ret;
>>> +    if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>>> +        return -EIO;
>>> +
>>>       if (!f2fs_is_compress_backend_ready(inode))
>>>           return -EOPNOTSUPP;
>>> -- 
>>> 2.40.1
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

