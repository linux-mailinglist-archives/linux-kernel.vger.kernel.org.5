Return-Path: <linux-kernel+bounces-99737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AFE878C66
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4881F21694
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA921877;
	Tue, 12 Mar 2024 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6TsgF5f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E652217CD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207742; cv=none; b=BuhjXBQbMrYyvpx5ILThq2r+ExGeNzwbFKIs/M9GfummyKJ81exBw0lXLmwy+hMHPbrhERRVQgepGHGYeIyMyQojdwTiTUoaPvMh9ujqcW0y0efV/+vLTBdjk4678s0pCNAE9abjaDEY84tLg3gkUTTtHuEpRqEzvDS7pV579KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207742; c=relaxed/simple;
	bh=SvN91sVbn4Vcb6UyAAUWB0V+z3nlk1QHgidCJdScNrk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j1ve2h+5PHlk8UevRKkbyCiB1qoL9QLy+fJiQeeV1OLtg7Ri2IL5AY35OkjGgLlbJ3JPe/1BEqKwqmSSDLYFxYbLQ6bIUCyRLO3Xxo+ES+Ww5tihcF+ndsoWDQK8g3evlEhKFzBnsOa9YMwsdChDVLxXdMpKjMljaotC2GnJLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6TsgF5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7FBC433C7;
	Tue, 12 Mar 2024 01:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710207741;
	bh=SvN91sVbn4Vcb6UyAAUWB0V+z3nlk1QHgidCJdScNrk=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=J6TsgF5ftbA35AqVO1Q2CglrqxDO3Q5WHOa/iQrhqXWFwJvjZwkLqKWv0sJLnsf+O
	 wUoAY5lW+/1b50HuWVX5n3CWtAE++4SOS1ZiCoWgphuytr+FK6lntn7BX8md6EkgWP
	 QXLtdMghvxs9ar269OXVUz9EPPFEtBNyA+StNYFMg0vvXTo9gXedjn1teNrleGnU+S
	 wfQ5ao5XVjkeZLG/SgnOTMlsJEI6ss0vvpfkLfccnG9AJUDBQnwpqFUvE48jErhtzE
	 V0enq+VMRrCqsCUot13bKYch70Tj4xomHD0gIGtx+lw195+zXsE/Lxw4IqIGXInNZU
	 XJMZQOUupaPCg==
Message-ID: <5f335b3b-7edc-458f-819d-40012b61672a@kernel.org>
Date: Tue, 12 Mar 2024 09:42:17 +0800
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
 <23aa8351-e002-4185-89c7-ccde6b5b0549@kernel.org>
In-Reply-To: <23aa8351-e002-4185-89c7-ccde6b5b0549@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ping,

Jaegeuk, do you have any comments on this patch?

Thanks,

On 2024/2/26 16:00, Chao Yu wrote:
> Any comments?
> 
> Thanks,
> 
> On 2024/2/19 11:13, Chao Yu wrote:
>> On 2024/2/8 8:18, Jaegeuk Kim wrote:
>>> On 02/06, Chao Yu wrote:
>>>> generic/730 2s ... - output mismatch (see /media/fstests/results//generic/730.out.bad)
>>>>      --- tests/generic/730.out    2023-08-07 01:39:51.055568499 +0000
>>>>      +++ /media/fstests/results//generic/730.out.bad    2024-02-06 02:26:43.000000000 +0000
>>>>      @@ -1,2 +1 @@
>>>>       QA output created by 730
>>>>      -cat: -: Input/output error
>>>>      ...
>>>>      (Run 'diff -u /media/fstests/tests/generic/730.out /media/fstests/results//generic/730.out.bad'  to see the entire diff)
>>>> Ran: generic/730
>>>> Failures: generic/730
>>>> Failed 1 of 1 tests
>>>>
>>>> This patch adds a check condition in f2fs_file_read_iter() to
>>>> detect cp_error status after device removal, and retrurn -EIO
>>>> for such case.
>>>
>>> Can we check device removal?
>>
>> We can use blk_queue_dying() to detect device removal, but, IMO, device
>> removal can almost not happen in Android, not sure for distros or server,
>> do you want to add this check condition into f2fs_cp_error()?
>>
>> Thanks,
>>
>>>
>>>>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>>   fs/f2fs/file.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>> index 45b7e3610b0f..9e4386d4144c 100644
>>>> --- a/fs/f2fs/file.c
>>>> +++ b/fs/f2fs/file.c
>>>> @@ -4462,6 +4462,9 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>>>       const loff_t pos = iocb->ki_pos;
>>>>       ssize_t ret;
>>>> +    if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
>>>> +        return -EIO;
>>>> +
>>>>       if (!f2fs_is_compress_backend_ready(inode))
>>>>           return -EOPNOTSUPP;
>>>> -- 
>>>> 2.40.1
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

