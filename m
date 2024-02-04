Return-Path: <linux-kernel+bounces-51380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A8D848AA2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0B9B21150
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28025138C;
	Sun,  4 Feb 2024 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKPLco9j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F8810EB
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013473; cv=none; b=uiUElE/fT0AsWWoT0+1Jz9UF+KWHD605txZx4SAZE/bHlPNzFpgbZmPQwiBD+vNO0XZb9Ji026a0DBhko0+ql/B/YbS/TvLM3dyX4jcl4fxRTb8LTUVLeggIfk0sJpuf7HKVS6jK4l5SHutMPBn3Cn34KjKnqUkGLnLgGw5wTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013473; c=relaxed/simple;
	bh=w/HWrR+lQGWzJxB85ky3dmWebYzJu5r/BKHq8uRrEXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGMzjCtbHXH7VG+X7aw9mntwOva+B4uoqdC2BQbODeN26CIuLbrC6ce4Bwm8ZCIb959nB4ltG5+g/3mkybjoC+DNrTqpWCwVQvdPagq3PWOeG4+wtMPCJRVv1awHU+eSKrxz1RFkbBO2w9RbE8vrgfA+GgSou1QoYp+G9nNlApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKPLco9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7C8C433F1;
	Sun,  4 Feb 2024 02:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707013472;
	bh=w/HWrR+lQGWzJxB85ky3dmWebYzJu5r/BKHq8uRrEXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NKPLco9jJb9cP8o5a92KUMkiFYpFazPUfaqQtGVqbgSUT5dpcwoHB9O9A4o8amDD6
	 8EIGv4wlDzvIGfhZmOKwkugzpabWmi8dM7Fh7YxMgRGGKl15pyosbeGIWnUGI/wfLm
	 0I6icbSDsIakO/bqVci64zacXyRV1BqKzJk2G4e4zql1H8uX3Ez/0OQZorJL7IDD/F
	 XCtd61ilA29P4RymD8j0fOcK9J3JpAZ3AalFl0IjqXFtFcnPgQHg0PBHC3jTgO/TB4
	 uuICc1ns/4M7uGEnhpIh4u1LYu42zCu73oyfXjDCs91IOc6HghP07+UQIeoBSNNDtC
	 RRbrrv/V57jng==
Message-ID: <e42ae14e-88b8-41de-9693-1513bf335fc2@kernel.org>
Date: Sun, 4 Feb 2024 10:24:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] f2fs: fix zoned block device information
 initialization
Content-Language: en-US
To: Wenjie Qi <qwjhust@gmail.com>
Cc: jaegeuk@kernel.org, yangyongpeng1@oppo.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 hustqwj@hust.edu.cn
References: <20240203152436.1352-1-qwjhust@gmail.com>
 <8eaf59a4-1aaa-460e-a3cc-b798ed5e0f63@kernel.org>
 <CAGFpFsTz_9Zaj0PuptjBxOJwxF68geAUfd1qtx9--Tczh+jZww@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAGFpFsTz_9Zaj0PuptjBxOJwxF68geAUfd1qtx9--Tczh+jZww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/2/4 10:18, Wenjie Qi wrote:
> Hi Chao,
> 
> It seems to me that when mounting multiple zoned devices,
> if their max_open_zones are all 0, then sbi->max_open_zones is 0.
> This suggests that all of the mounted devices can open an unlimited
> number of zones,
> and that we don't need to compare sbi->max_open_zones with
> F2FS_OPTION( sbi).active_logs.

Yes, but I'm curious about how this case (sbi->max_open_zones is zero)
works w/ following patch, do we need to initialized sbi->max_open_zones
w/ UINT_MAX to indicate the unlimited open zone status of device if
all zoned devices' max_open_zones is zero?

> 
> Thanks,
> 
> Chao Yu <chao@kernel.org> 于2024年2月4日周日 09:47写道：
>>
>> On 2024/2/3 23:24, Wenjie Qi wrote:
>>> If the max open zones of zoned devices are less than
>>> the active logs of F2FS, the device may error due to
>>> insufficient zone resources when multiple active logs are
>>> being written at the same time. If this value is 0,
>>> there is no limit.
>>>
>>> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
>>> ---
>>>    fs/f2fs/f2fs.h  |  1 +
>>>    fs/f2fs/super.c | 21 +++++++++++++++++++++
>>>    2 files changed, 22 insertions(+)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 543898482f8b..161107f2d3bd 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -1558,6 +1558,7 @@ struct f2fs_sb_info {
>>>
>>>    #ifdef CONFIG_BLK_DEV_ZONED
>>>        unsigned int blocks_per_blkz;           /* F2FS blocks per zone */
>>> +     unsigned int max_open_zones;            /* max open zone resources of the zoned device */
>>>    #endif
>>>
>>>        /* for node-related operations */
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 1b718bebfaa1..45e82d6016fc 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -2388,6 +2388,16 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>        if (err)
>>>                goto restore_opts;
>>>
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +     if (sbi->max_open_zones && sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
>>> +             f2fs_err(sbi,
>>> +                     "zoned: max open zones %u is too small, need at least %u open zones",
>>> +                              sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
>>> +             err = -EINVAL;
>>> +             goto restore_opts;
>>> +     }
>>> +#endif
>>> +
>>>        /* flush outstanding errors before changing fs state */
>>>        flush_work(&sbi->s_error_work);
>>>
>>> @@ -3930,11 +3940,22 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>>>        sector_t nr_sectors = bdev_nr_sectors(bdev);
>>>        struct f2fs_report_zones_args rep_zone_arg;
>>>        u64 zone_sectors;
>>> +     unsigned int max_open_zones;
>>>        int ret;
>>>
>>>        if (!f2fs_sb_has_blkzoned(sbi))
>>>                return 0;
>>>
>>> +     max_open_zones = bdev_max_open_zones(bdev);
>>
>> Wenjie,
>>
>> max_open_zones can always be zero? then sbi->max_open_zones will be zero,
>> is this a valid case?
>>
>> Thanks,
>>
>>> +     if (max_open_zones && (max_open_zones < sbi->max_open_zones || !sbi->max_open_zones))
>>> +             sbi->max_open_zones = max_open_zones;
>>> +     if (sbi->max_open_zones && sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
>>> +             f2fs_err(sbi,
>>> +                     "zoned: max open zones %u is too small, need at least %u open zones",
>>> +                              sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>>        zone_sectors = bdev_zone_sectors(bdev);
>>>        if (!is_power_of_2(zone_sectors)) {
>>>                f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");

