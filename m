Return-Path: <linux-kernel+bounces-44750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F378A8426EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B53B1F27598
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C356DD1E;
	Tue, 30 Jan 2024 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdKdehbE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABF6BB20
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624973; cv=none; b=hvG92Mu0dOFEMF1WZv8oKxSP7u+xAhsKpdInOQIfpY3Y6G6JWNZi1FSwouWsVWLtIAHj9rneOCj/+7fNvGxmZgWHa50lA7aRO4thwZAeOqCAFzbzIWpqlGMDhMJfEYomsQ2n/veAR8gXo2JctyK62UOUG4ItOkxLY5hTTeouniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624973; c=relaxed/simple;
	bh=KnPGMMxaf6TMJMYT3i9Zl9SSMDr+33/RimwM+rsX9rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHhSSDTzipSZnRFXYsEx756L+VwacN3Nr4exXwLeKlfKHDjDxLsShh2+jEzQDbnc9MG8c9TGQjQcdnYAZvVIv+UHGosBEq23CKsxJ8yCOr+gE4CbwtYkpH8BHerNmEnGramjgcOo0nyndQ/x081kUhSD04zODPdC1uST5ggLoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdKdehbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B756C433F1;
	Tue, 30 Jan 2024 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706624973;
	bh=KnPGMMxaf6TMJMYT3i9Zl9SSMDr+33/RimwM+rsX9rs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gdKdehbEQY9Okls+GpFDmjtaa+626FfhvMX+7nKHmRMPLswzaTX0GV8ip8cvVNmGT
	 6+igRmtgtwVsA104YSN7ypCJDu/jaCjjmyUVkdHQuZVZPFZcxe+LDFkaAG3KHILsQY
	 fSK9D8YCPGCGL37uT7VTlVXMTVfOfUNIvifWBpxshYH0As6u/rzpapTy2GLqOOe+K0
	 AJ+WXOeoDEJzQmjxaiWWChkpHiFgsUQIyUE2ebJUaDFdb66F8a6AWvAzCU/7I0EpSD
	 aPvuyYPBuVOB7MSikE9mvLkV3mEsuzZCaRadlxqZ0aDxuVfmQW28NS/xipXgxXx1jS
	 zI5DAbV2K0Uzw==
Message-ID: <c65cc502-3448-4627-8245-6cba07945183@kernel.org>
Date: Tue, 30 Jan 2024 22:29:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: allocate logs after conventional
 area for HM zoned devices
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, Daeho Jeong <daehojeong@google.com>,
 Yongpeng Yang <yangyongpeng1@oppo.com>
References: <20240117230032.2312067-1-daeho43@gmail.com>
 <df9645d9-1e9a-4bd2-88bb-26425cf45811@kernel.org>
 <CACOAw_yjEuGSvo_qyoA13U0HwOr3gOzGtNf2Twhes01SNSGQeg@mail.gmail.com>
 <b18c286a-cc72-439c-b373-98e0d6504618@kernel.org>
 <CACOAw_yqrtEhq4wtJbs7CVn260h7iZyC7koCWH1iMyeQo5140g@mail.gmail.com>
 <e879da72-4c4f-4aed-8081-784f2de5c887@kernel.org>
 <CACOAw_xDDoOQEHOAXkG+8PF8yD0MtUAW4J04tYcPCh3VMp7FGQ@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
Autocrypt: addr=chao@kernel.org; keydata=
 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
In-Reply-To: <CACOAw_xDDoOQEHOAXkG+8PF8yD0MtUAW4J04tYcPCh3VMp7FGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/1/29 23:47, Daeho Jeong wrote:
> On Sun, Jan 28, 2024 at 5:27 PM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2024/1/27 2:17, Daeho Jeong wrote:
>>> On Thu, Jan 25, 2024 at 5:27 PM Chao Yu <chao@kernel.org> wrote:
>>>>
>>>> On 2024/1/26 0:25, Daeho Jeong wrote:
>>>>> On Wed, Jan 24, 2024 at 7:34 PM Chao Yu <chao@kernel.org> wrote:
>>>>>>
>>>>>> +Cc Yongpeng Yang
>>>>>>
>>>>>> Daeho,
>>>>>>
>>>>>> Yongpeng reports a potential issue: if c.devices[0].total_segments is
>>>>>> larger than segments of mainarea, c.cur_seg[CURSEG_HOT_NODE] will exceed
>>>>>> end boundary of mainarea. Could you please check that? though it's a corner
>>>>>> case.
>>>>>
>>>>> Can you elaborate more?
>>>>
>>>> Since c.cur_seg[CURSEG_HOT_NODE] is an offset started from main_blkaddr.
>>>
>>> Oh, Got it.
>>> Then, how about this?
>>>
>>>            c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>>>                            (c.devices[1].start_blkaddr -
>>> get_sb(main_blkaddr)) / c.blks_per_seg : 0;
>>
>> Better, but log header should align to start blkaddr of zone?
> 
> It's already aligned here.

Ah, thanks for the explanation. :)

Thanks,

> 
>          if (c.zoned_mode && c.ndevs > 1)
>                  zone_align_start_offset +=
>                          (c.devices[0].total_sectors * c.sector_size) %
> zone_size_bytes;
> 
> ...
> 
>          for (i = 0; i < c.ndevs; i++) {
>                  if (i == 0) {
>                          c.devices[i].total_segments =
>                                  (c.devices[i].total_sectors *
>                                  c.sector_size - zone_align_start_offset) /
>                                  segment_size_bytes;
>                          c.devices[i].start_blkaddr = 0;
>                          c.devices[i].end_blkaddr = c.devices[i].total_segments *
>                                                  c.blks_per_seg - 1 +
>                                                  sb->segment0_blkaddr;
>                  } else {
>                          c.devices[i].total_segments =
>                                  c.devices[i].total_sectors /
>                                  (c.sectors_per_blk * c.blks_per_seg);
>                          c.devices[i].start_blkaddr =
>                                          c.devices[i - 1].end_blkaddr + 1;
> 
> ...
> 
>          total_meta_zones = ZONE_ALIGN(total_meta_segments *
>                                                  c.blks_per_seg);
> 
>          set_sb(main_blkaddr, get_sb(segment0_blkaddr) + total_meta_zones *
>                                  c.segs_per_zone * c.blks_per_seg);
> 
>>
>> Thanks,
>>
>>>
>>>> If c.cur_seg[CURSEG_HOT_NODE] was assigned w/ c.devices[0].total_segments,
>>>> and c.devices[0].total_segments is larger than segments of mainare,
>>>> c.cur_seg[CURSEG_HOT_NODE] will exceed the end boundary of mainarea.
>>>>
>>>>           c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>>>>                           c.devices[0].total_segments : 0;
>>>>
>>>>> In the case of F2FS_ZONED_HM, we have the devices[1].
>>>>> Do you mean the case we format the filesystem intentionally smaller
>>>>> than what devices have?
>>>>
>>>> I mean blew case:
>>>> device[0]: conventional device size = 10240 MB
>>>> device[1]: zone device size = 2 MB
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> On 2024/1/18 7:00, Daeho Jeong wrote:
>>>>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>>>>
>>>>>>> Make to allocate logs after conventional area for HM zoned devices to
>>>>>>> spare them for file pinning support.
>>>>>>>
>>>>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>>>>> ---
>>>>>>>      mkfs/f2fs_format.c | 3 ++-
>>>>>>>      1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>>>>>>> index f2840c8..91a7f4b 100644
>>>>>>> --- a/mkfs/f2fs_format.c
>>>>>>> +++ b/mkfs/f2fs_format.c
>>>>>>> @@ -557,7 +557,8 @@ static int f2fs_prepare_super_block(void)
>>>>>>>                  c.cur_seg[CURSEG_COLD_DATA] = 0;
>>>>>>>                  c.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
>>>>>>>          } else if (c.zoned_mode) {
>>>>>>> -             c.cur_seg[CURSEG_HOT_NODE] = 0;
>>>>>>> +             c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
>>>>>>> +                     c.devices[0].total_segments : 0;
>>>>>>>                  c.cur_seg[CURSEG_WARM_NODE] = next_zone(CURSEG_HOT_NODE);
>>>>>>>                  c.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
>>>>>>>                  c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);

