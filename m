Return-Path: <linux-kernel+bounces-134222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E6989AF37
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F9E283D47
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FDCCA7A;
	Sun,  7 Apr 2024 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+es7zhb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2416AB9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712474966; cv=none; b=qycwoyLDn9Q4j4Hq5ttrJT49aWfvn4OxsjEW/bKxxoJvBWa5mq/r91wTMGPhfiRxKs7ZjmL2b+R1DiLlO4EDluBPdhslMBBdCFtwHWMfwlDKiuMJEc5uz2WGjfuj+E8m7HD/ZVi0kI36dvuMHVMWlIBsyTJk0rmuzXy5bzsiVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712474966; c=relaxed/simple;
	bh=29YP5x/Os973Sl32/dIiO+nQ4l2sbAEznxA8GpsSHS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/pKgY6FdgyO0DLnhbP8qMGgcd0DWcuxHbmiNr4dnnkmEIDKO+kMpb/MKzg3wTiqhW5ynyr/CFNMwcZzPezP59/PWWQAmSzuZW4Sp3Ibo0HppxG8sqS0H+KeNeyi/Q3OPraWxk8oJ1CIjQvO11SNYFgHoVbIpT5VdXzR9xUeKAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+es7zhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B265C433F1;
	Sun,  7 Apr 2024 07:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712474966;
	bh=29YP5x/Os973Sl32/dIiO+nQ4l2sbAEznxA8GpsSHS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m+es7zhb6d8kBBprLCV3fRWapkeqAnZHqpxDTSeZbFtIoUOOlZXIT/Kc/0f55Yl/H
	 XtRGjpcNfI7X81yaP/o9u0BrfwkoifSpVMke7s6cjaUUPDabSzw4MG+EkHppR+RHLo
	 5XssEb8U7UZ1y+0NTm15xbxYC+9icWnGuWZVU0AQ5ulUX77GW0HA4I/9gLNF5pq+B0
	 axw1ck0U4/yJL7s4mlpjX2v0bDEORK/2sktFwaaWKgiCZWPJ/gb6K9MYLx5MGI6xVh
	 3Z6Ky5fG+7vhym7mITs1cBF6pkUniF6CrC6jGk8aiReOxefYLIYQjywCTkEhPJMEdo
	 Hi8BywgbNXwMQ==
Message-ID: <6a50a23e-8975-43cb-9496-38b6a083c703@kernel.org>
Date: Sun, 7 Apr 2024 15:29:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to relocate check condition in
 f2fs_fallocate()
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240403142420.2042498-1-chao@kernel.org>
 <CAHJ8P3LdZXLc2rqeYjvymgYHr2+YLuJ0sLG9DdsJZmwO7deuhw@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAHJ8P3LdZXLc2rqeYjvymgYHr2+YLuJ0sLG9DdsJZmwO7deuhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/7 10:11, Zhiguo Niu wrote:
> On Wed, Apr 3, 2024 at 10:26 PM Chao Yu <chao@kernel.org> wrote:
>>
>> compress and pinfile flag should be checked after inode lock held to
>> avoid race condition, fix it.
>>
>> Fixes: 4c8ff7095bef ("f2fs: support data compression")
>> Fixes: 5fed0be8583f ("f2fs: do not allow partial truncation on pinned file")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/file.c | 20 +++++++++++---------
>>   1 file changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 148bfe3effdf..83a807e25e31 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1820,15 +1820,6 @@ static long f2fs_fallocate(struct file *file, int mode,
>>                  (mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
>>                  return -EOPNOTSUPP;
>>
>> -       /*
>> -        * Pinned file should not support partial truncation since the block
>> -        * can be used by applications.
>> -        */
>> -       if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
>> -               (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
>> -                       FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE)))
>> -               return -EOPNOTSUPP;
>> -
>>          if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
>>                          FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
>>                          FALLOC_FL_INSERT_RANGE))
>> @@ -1836,6 +1827,17 @@ static long f2fs_fallocate(struct file *file, int mode,
>>
>>          inode_lock(inode);
>>
>> +       /*
>> +        * Pinned file should not support partial truncation since the block
>> +        * can be used by applications.
>> +        */
>> +       if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
>> +               (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
>> +                       FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))) {
>> +               ret = -EOPNOTSUPP;
>> +               goto out;
>> +       }
>> +
> Dear Chao,
> I see  the judgment code "if(!f2fs_compressed_file(inode))" also is
> before inode_lock in functions
> f2fs_ioc_decompress_file/f2fs_ioc_compress_file/f2fs_reserve_compress_blocks/f2fs_release_compress_blocks.
> should they are changed together?

Zhiguo,

Thanks for noticing that, I've submitted separated patches for fixing
because those bugs were introduced by separated commits.

Thanks,

> thanks！
>>          ret = file_modified(file);
>>          if (ret)
>>                  goto out;
>> --
>> 2.40.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

