Return-Path: <linux-kernel+bounces-39493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F15783D20D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B745728CAE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C44B10F5;
	Fri, 26 Jan 2024 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHxRaxA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D81EBE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232436; cv=none; b=LotKoIU8QNTDUy9JkpvnLZIY5Rlub+ncM3DLVy7LTlmQQZDmVG4LMeaG8x9ixneTteeaNihpLs/8Lh/wKFfGFvqePhEHOotAtEkcCZUGcdin+E7wpaP4IHDAnBwvMsOulppP7Uk7uTCEVsZnscpfrv1pcng6MYT5t4Di7E2Ehsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232436; c=relaxed/simple;
	bh=GTtKobOQ217q5L9Z4HLE5gx1zWcNYGYQZI5Zm9HQ1u4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Np1pJ68iaU8cdBsxwI7ZC/ubpXeFXQX90Kp24qUQCN8EnTyBUJqhLxAQdKK1/DuRKWLVwwuo5qW+97Eu6rBPkQKR4gul3dnk7qfXH+FSpEA6HGyvZFB/ueiGclHkv9RsT84BnFdxrpFaylh/bTOP4R2YVCkGilOTZIDQtNGcA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHxRaxA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC20EC433C7;
	Fri, 26 Jan 2024 01:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706232436;
	bh=GTtKobOQ217q5L9Z4HLE5gx1zWcNYGYQZI5Zm9HQ1u4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aHxRaxA9Vt8sN1cQQGlptLuXjn7khkCw8t1qI/IuGcR1xQ7mfh+DDYfVYSgKfLmRb
	 +zyVSmk+bUVPGC8GG/QQuvDvEbAmGRkBryAXT0mCbOAEUa1t71SNeXPzctfU76Ic+V
	 LQDltZQMLt99HC6C8s9cUFQ7w+Ff2KzGVLfjROFAhcuSGjzNbVwsZxKqhhjEean/SC
	 LIV23rW0Lt+ipDrjv9E3r/l/yaud6hluKKJSCHPSUAxrsreFwDy5fBqD8VoI1MvV3h
	 W3q7FopFr6zpDQGOs0vxtQp0khbpjXxyKFELf5xvflwEFBiP50TJoJj1F9V/Ub3s4Y
	 8shvo7dlg076Q==
Message-ID: <b18c286a-cc72-439c-b373-98e0d6504618@kernel.org>
Date: Fri, 26 Jan 2024 09:27:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: allocate logs after conventional
 area for HM zoned devices
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, Daeho Jeong <daehojeong@google.com>,
 Yongpeng Yang <yangyongpeng1@oppo.com>
References: <20240117230032.2312067-1-daeho43@gmail.com>
 <df9645d9-1e9a-4bd2-88bb-26425cf45811@kernel.org>
 <CACOAw_yjEuGSvo_qyoA13U0HwOr3gOzGtNf2Twhes01SNSGQeg@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_yjEuGSvo_qyoA13U0HwOr3gOzGtNf2Twhes01SNSGQeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/1/26 0:25, Daeho Jeong wrote:
> On Wed, Jan 24, 2024 at 7:34 PM Chao Yu <chao@kernel.org> wrote:
>>
>> +Cc Yongpeng Yang
>>
>> Daeho,
>>
>> Yongpeng reports a potential issue: if c.devices[0].total_segments is
>> larger than segments of mainarea, c.cur_seg[CURSEG_HOT_NODE] will exceed
>> end boundary of mainarea. Could you please check that? though it's a corner
>> case.
> 
> Can you elaborate more?

Since c.cur_seg[CURSEG_HOT_NODE] is an offset started from main_blkaddr.
If c.cur_seg[CURSEG_HOT_NODE] was assigned w/ c.devices[0].total_segments,
and c.devices[0].total_segments is larger than segments of mainare,
c.cur_seg[CURSEG_HOT_NODE] will exceed the end boundary of mainarea.

	c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
			c.devices[0].total_segments : 0;

> In the case of F2FS_ZONED_HM, we have the devices[1].
> Do you mean the case we format the filesystem intentionally smaller
> than what devices have?

I mean blew case:
device[0]: conventional device size = 10240 MB
device[1]: zone device size = 2 MB

Thanks,

> 
>>
>> On 2024/1/18 7:00, Daeho Jeong wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> Make to allocate logs after conventional area for HM zoned devices to
>>> spare them for file pinning support.
>>>
>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> ---
>>>    mkfs/f2fs_format.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>>> index f2840c8..91a7f4b 100644
>>> --- a/mkfs/f2fs_format.c
>>> +++ b/mkfs/f2fs_format.c
>>> @@ -557,7 +557,8 @@ static int f2fs_prepare_super_block(void)
>>>                c.cur_seg[CURSEG_COLD_DATA] = 0;
>>>                c.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
>>>        } else if (c.zoned_mode) {
>>> -             c.cur_seg[CURSEG_HOT_NODE] = 0;
>>> +             c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>>> +                     c.devices[0].total_segments : 0;
>>>                c.cur_seg[CURSEG_WARM_NODE] = next_zone(CURSEG_HOT_NODE);
>>>                c.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
>>>                c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);

