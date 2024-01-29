Return-Path: <linux-kernel+bounces-42059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7BF83FBCC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7B71C20D29
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 01:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00603D528;
	Mon, 29 Jan 2024 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpGWaGzR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349478F6A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706491669; cv=none; b=QacewUNecKoWrkCa6fWWMAhdFdB+uDgjDXAYrlxeD4EeAXSwxyOOUPO5e5rqve5Rh/RMcbJsBtwNZEEyl+qUKwzQPKiSuREMp07u2Yig13nr06MtzRSLODevskXh2B269CB4Cqs3lOy1sFbgmQ1BB07Jh2E3s7FL6ET2YKP9fKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706491669; c=relaxed/simple;
	bh=NkU7xTweU96ajdi9Fvy8l3qWym9x0Ihl2M8f3JBKtCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3VA+di7oZuebj8G74jxx3TaXfzR7itlxoZCW/6nJ+zxZoVedR4+oNQhMPuIg+UO+ax8p/7YWTljoWAwFS81wun5o4J7RX4DRb7Y9Ps3KY0cU43kbNh6cHEQVZNGKBbYgN+6bADmew3lQSvAOYn2EFyvGWXED36oeUef/kWFfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpGWaGzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF83EC433C7;
	Mon, 29 Jan 2024 01:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706491668;
	bh=NkU7xTweU96ajdi9Fvy8l3qWym9x0Ihl2M8f3JBKtCs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hpGWaGzRZQO3vY65y0NHyElKDi8PXRMW0iwOAaWRjxervIvQH3ZVIu+E0Up/EcD0L
	 1PFsxld3n+kZjpj+4VjmVWBVAetWYCbdDLiGlN07jcGx6IEB8QSZEVy2SxqUqcCtCD
	 optOJHib52iCli9R8CTa2qNiocSVyFW1JUmxpdGCQIXEuSL2fDd22CNJaM7181FD8w
	 8z3027AN+rMZDv+9xpMn0PI1JQB3F1p8iIkvv4+Wt5wURaJ8n9mb+lf6HqLJ83lMyN
	 abIgtCCsEyTUOtJpIc7ljBsAt44zXYBEO8lHaErtPGeCiCA82UIqCgiruxTQAJXtzb
	 WoFtvpUG3RH/Q==
Message-ID: <e879da72-4c4f-4aed-8081-784f2de5c887@kernel.org>
Date: Mon, 29 Jan 2024 09:27:44 +0800
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
 <b18c286a-cc72-439c-b373-98e0d6504618@kernel.org>
 <CACOAw_yqrtEhq4wtJbs7CVn260h7iZyC7koCWH1iMyeQo5140g@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_yqrtEhq4wtJbs7CVn260h7iZyC7koCWH1iMyeQo5140g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/1/27 2:17, Daeho Jeong wrote:
> On Thu, Jan 25, 2024 at 5:27 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/1/26 0:25, Daeho Jeong wrote:
>>> On Wed, Jan 24, 2024 at 7:34 PM Chao Yu <chao@kernel.org> wrote:
>>>>
>>>> +Cc Yongpeng Yang
>>>>
>>>> Daeho,
>>>>
>>>> Yongpeng reports a potential issue: if c.devices[0].total_segments is
>>>> larger than segments of mainarea, c.cur_seg[CURSEG_HOT_NODE] will exceed
>>>> end boundary of mainarea. Could you please check that? though it's a corner
>>>> case.
>>>
>>> Can you elaborate more?
>>
>> Since c.cur_seg[CURSEG_HOT_NODE] is an offset started from main_blkaddr.
> 
> Oh, Got it.
> Then, how about this?
> 
>           c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>                           (c.devices[1].start_blkaddr -
> get_sb(main_blkaddr)) / c.blks_per_seg : 0;

Better, but log header should align to start blkaddr of zone?

Thanks,

> 
>> If c.cur_seg[CURSEG_HOT_NODE] was assigned w/ c.devices[0].total_segments,
>> and c.devices[0].total_segments is larger than segments of mainare,
>> c.cur_seg[CURSEG_HOT_NODE] will exceed the end boundary of mainarea.
>>
>>          c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>>                          c.devices[0].total_segments : 0;
>>
>>> In the case of F2FS_ZONED_HM, we have the devices[1].
>>> Do you mean the case we format the filesystem intentionally smaller
>>> than what devices have?
>>
>> I mean blew case:
>> device[0]: conventional device size = 10240 MB
>> device[1]: zone device size = 2 MB
>>
>> Thanks,
>>
>>>
>>>>
>>>> On 2024/1/18 7:00, Daeho Jeong wrote:
>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>
>>>>> Make to allocate logs after conventional area for HM zoned devices to
>>>>> spare them for file pinning support.
>>>>>
>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>>> ---
>>>>>     mkfs/f2fs_format.c | 3 ++-
>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>>>>> index f2840c8..91a7f4b 100644
>>>>> --- a/mkfs/f2fs_format.c
>>>>> +++ b/mkfs/f2fs_format.c
>>>>> @@ -557,7 +557,8 @@ static int f2fs_prepare_super_block(void)
>>>>>                 c.cur_seg[CURSEG_COLD_DATA] = 0;
>>>>>                 c.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
>>>>>         } else if (c.zoned_mode) {
>>>>> -             c.cur_seg[CURSEG_HOT_NODE] = 0;
>>>>> +             c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>>>>> +                     c.devices[0].total_segments : 0;
>>>>>                 c.cur_seg[CURSEG_WARM_NODE] = next_zone(CURSEG_HOT_NODE);
>>>>>                 c.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
>>>>>                 c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);

