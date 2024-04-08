Return-Path: <linux-kernel+bounces-135499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1FC89C6BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA261C21D7D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C465612AAC8;
	Mon,  8 Apr 2024 14:18:04 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43858127B4E;
	Mon,  8 Apr 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585884; cv=none; b=C0KsXaBkvOX9o65nXp99/JN/IWceXuvsZi5mlu7ZtFoWzjJHWJxaBQ4lnMt4gI+Lss+X+oKxxQfaV3xb5EoDfrWHOI3Bvo7rZeU6go/S5UcLuUro5EFEc+j3L8JDtnj3qQ9PEsAmdEPSpGXOG2t244YasMmT0qo+4vNFov+tnJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585884; c=relaxed/simple;
	bh=H92i75+oyvNWVJtkoi+cDWvL0dIIzwlAH92gqf8Shvo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dLMFOll4dZfHGuc9lzRcD0JP95OuZ9QmablSafB/aRB4j5u/oO8sAih3Oin5n6yP/FWgSMrpBSQpgWfresLaNYTl4V4RHcN/EQrY06noIy0xWFJPmCLQKfS5iG/oJbCWLbCZ3VzZiH3alnJN4WsLw7thi99ABZPBEpjlShvgBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FBEC43399;
	Mon,  8 Apr 2024 14:18:00 +0000 (UTC)
Message-ID: <5aa6d853-60f5-485b-b892-e6e81acdfc12@xs4all.nl>
Date: Mon, 8 Apr 2024 16:17:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Switch subdev dv timing callbacks to pad ops
Content-Language: en-US, nl
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
To: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>,
 kieran.bingham@ideasonboard.com, mchehab@kernel.org, tharvey@gateworks.com,
 niklas.soderlund@ragnatech.se, prabhakar.csengg@gmail.com,
 charles-antoine.couret@nexvision.fr, thierry.reding@gmail.com,
 jonathanh@nvidia.com, skomatineni@nvidia.com, luca.ceresoli@bootlin.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 chromeos-krk-upstreaming@google.com
References: <20240405141411.1807189-1-panikiel@google.com>
 <6027dacf-549e-4855-97d9-dd02e65fd94a@xs4all.nl>
In-Reply-To: <6027dacf-549e-4855-97d9-dd02e65fd94a@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/04/2024 16:15, Hans Verkuil wrote:
> On 05/04/2024 16:13, Paweł Anikiel wrote:
>> Currently, subdev dv timing calls (i.e. g/s/query_dv_timings) are video
>> ops without a pad argument. This is a problem if the subdevice can have
>> different dv timings for each pad (e.g. a DisplayPort receiver with
>> multiple virtual channels).
>>
>> This patchset changes subdev dv timing callbacks to include a pad
>> argument, and moves them from video to pad ops. All the affected
>> drivers are updated to use the new pad ops version.
>>
>> The affected drivers were updated in a way that mathes how they deal
>> with the pad argument in other callbacks (mainly enum_dv_timings,
>> dv_timings_cap, get/set_edid).
>>
>> This was originally a part of a larger patchset:
>> https://lore.kernel.org/lkml/20240221160215.484151-2-panikiel@google.com/
>>
>> Paweł Anikiel (16):
>>   media: v4l2-subdev: Add pad versions of dv timing subdev calls
>>   media: i2c: adv748x: Switch dv timing callbacks to pad ops
>>   media: i2c: adv7511: Switch dv timing callbacks to pad ops
>>   media: i2c: adv7604: Switch dv timing callbacks to pad ops
>>   media: i2c: adv7842: Switch dv timing callbacks to pad ops
>>   media: i2c: tc358743: Switch dv timing callbacks to pad ops
>>   media: i2c: tda1997x: Switch dv timing callbacks to pad ops
>>   media: i2c: ths7303: Switch dv timing callbacks to pad ops
>>   media: i2c: ths8200: Switch dv timing callbacks to pad ops
>>   media: i2c: tvp7002: Switch dv timing callbacks to pad ops
>>   media: spi: gs1662: Switch dv timing callbacks to pad ops
>>   media: cobalt: Use pad variant of dv timing subdev calls
>>   media: rcar-vin: Use pad variant of dv timing subdev calls
>>   media: vpif_capture: Use pad variant of dv timing subdev calls
>>   media: tegra-video: Use pad variant of dv timing subdev calls
>>   media: v4l2-subdev: Remove non-pad dv timing callbacks
> 
> You missed one:
> 
> In file included from include/media/v4l2-device.h:13,
>                  from drivers/media/platform/ti/davinci/vpif_display.h:13,
>                  from drivers/media/platform/ti/davinci/vpif_display.c:26:
> drivers/media/platform/ti/davinci/vpif_display.c: In function 'vpif_s_dv_timings':
> include/media/v4l2-subdev.h:1816:56: error: 'const struct v4l2_subdev_video_ops' has no member named 's_dv_timings'
>  1816 |                 else if (!(__sd->ops->o && __sd->ops->o->f))            \
>       |                                                        ^~
> drivers/media/platform/ti/davinci/vpif_display.c:937:15: note: in expansion of macro 'v4l2_subdev_call'
>   937 |         ret = v4l2_subdev_call(ch->sd, video, s_dv_timings, timings);
>       |               ^~~~~~~~~~~~~~~~
> include/media/v4l2-subdev.h:1819:53: error: 'const struct v4l2_subdev_video_ops' has no member named 's_dv_timings'
>  1819 |                          v4l2_subdev_call_wrappers.o->f)                \
>       |                                                     ^~
> drivers/media/platform/ti/davinci/vpif_display.c:937:15: note: in expansion of macro 'v4l2_subdev_call'
>   937 |         ret = v4l2_subdev_call(ch->sd, video, s_dv_timings, timings);
>       |               ^~~~~~~~~~~~~~~~
> include/media/v4l2-subdev.h:1820:63: error: 'const struct v4l2_subdev_video_ops' has no member named 's_dv_timings'
>  1820 |                         __result = v4l2_subdev_call_wrappers.o->f(      \
>       |                                                               ^~
> drivers/media/platform/ti/davinci/vpif_display.c:937:15: note: in expansion of macro 'v4l2_subdev_call'
>   937 |         ret = v4l2_subdev_call(ch->sd, video, s_dv_timings, timings);
>       |               ^~~~~~~~~~~~~~~~
> include/media/v4l2-subdev.h:1823:48: error: 'const struct v4l2_subdev_video_ops' has no member named 's_dv_timings'
>  1823 |                         __result = __sd->ops->o->f(__sd, ##args);       \
>       |                                                ^~
> drivers/media/platform/ti/davinci/vpif_display.c:937:15: note: in expansion of macro 'v4l2_subdev_call'
>   937 |         ret = v4l2_subdev_call(ch->sd, video, s_dv_timings, timings);
>       |               ^~~~~~~~~~~~~~~~
> drivers/media/platform/ti/davinci/vpif_display.c:937:15: error: no member 's_dv_timings' in struct v4l2_subdev_video_ops
> drivers/media/platform/ti/davinci/vpif_display.c:937:15: error: no member 's_dv_timings' in struct v4l2_subdev_video_ops
> drivers/media/platform/ti/davinci/vpif_display.c:937:15: error: no member 's_dv_timings' in struct v4l2_subdev_video_ops
> drivers/media/platform/ti/davinci/vpif_display.c:937:15: error: no member 's_dv_timings' in struct v4l2_subdev_video_ops

No need to post a v2. Just post a single patch '14.5/16' to convert vpif_display that
will be added after patch [14/16], then I'll take care of it.

Regards,

	Hans

> 
> Regards,
> 
> 	Hans
> 
>>
>>  drivers/media/i2c/adv748x/adv748x-hdmi.c      | 16 ++++----
>>  drivers/media/i2c/adv7511-v4l2.c              | 14 +++++--
>>  drivers/media/i2c/adv7604.c                   | 14 +++----
>>  drivers/media/i2c/adv7842.c                   | 25 ++++++++----
>>  drivers/media/i2c/tc358743.c                  | 23 +++++++----
>>  drivers/media/i2c/tda1997x.c                  | 12 +++---
>>  drivers/media/i2c/ths7303.c                   |  8 +++-
>>  drivers/media/i2c/ths8200.c                   | 14 +++++--
>>  drivers/media/i2c/tvp7002.c                   | 26 +++++++++----
>>  drivers/media/pci/cobalt/cobalt-v4l2.c        | 12 +++---
>>  .../platform/renesas/rcar-vin/rcar-v4l2.c     |  9 +++--
>>  .../media/platform/ti/davinci/vpif_capture.c  |  4 +-
>>  drivers/media/spi/gs1662.c                    | 21 +++++++---
>>  drivers/media/v4l2-core/v4l2-subdev.c         | 39 +++++++++++++++++--
>>  drivers/staging/media/tegra-video/vi.c        | 12 +++---
>>  include/media/v4l2-subdev.h                   | 28 ++++++-------
>>  16 files changed, 183 insertions(+), 94 deletions(-)
>>
> 
> 


