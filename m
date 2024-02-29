Return-Path: <linux-kernel+bounces-86258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1914E86C2FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5584284BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C3C481C0;
	Thu, 29 Feb 2024 08:02:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3618044C9E;
	Thu, 29 Feb 2024 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709193775; cv=none; b=iXuO3NG6DQhAsh1P95KrQcCZhsFV8naqYd6l5YKDnAEzJpqPaNKJ6IRazqqy5VFStVaOkXCj7iUtKhY/8az7MoWmuZXX9vC+7e8/6QyMbeCABTIVCYal1Q3QrGoNg75e5pUW9B5EW5xKpAuC7VEZmaNVbMw24LNVSEobQacJ0Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709193775; c=relaxed/simple;
	bh=7k/vpqip6N2vOj8cgKjOPE36pEsJVMgA/FdZblV+Xl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRma3zYvYK3N0uI2o5ArEy+zON1AIFZPpWF4QCd3imFTHmN5R7Uam4AALngODQoiv3pnlhFB3TsH5OVgK/6hwLTg3+m5TXQ6JK7XbqtEfNAS28zkQ9TrwZoVJGA97zabIRL2j/YtXKP+4lAx7DCTQ9TzUJcnS07ubnuRsH3J4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A78C433C7;
	Thu, 29 Feb 2024 08:02:51 +0000 (UTC)
Message-ID: <03f65fbc-9cf8-4347-8277-e53cb01b00a5@xs4all.nl>
Date: Thu, 29 Feb 2024 09:02:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] media: v4l2-subdev: Add a pad variant of
 .query_dv_timings()
Content-Language: en-US, nl
To: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Cc: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org,
 daniel@ffwll.ch, dinguyen@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 maarten.lankhorst@linux.intel.com, mchehab@kernel.org, mripard@kernel.org,
 robh+dt@kernel.org, tzimmermann@suse.de, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, chromeos-krk-upstreaming@google.com,
 ribalda@chromium.org
References: <20240221160215.484151-1-panikiel@google.com>
 <20240221160215.484151-2-panikiel@google.com>
 <ce262cda-84ba-4d8f-a916-76488c94066d@xs4all.nl>
 <CAM5zL5qrMNfyiXMOJHUzLySm_U2U8kbD=D_Cyn0WjkvpikiYpQ@mail.gmail.com>
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <CAM5zL5qrMNfyiXMOJHUzLySm_U2U8kbD=D_Cyn0WjkvpikiYpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/02/2024 16:34, Paweł Anikiel wrote:
> On Wed, Feb 28, 2024 at 12:25 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>>
>> Hi Paweł,
>>
>> On 21/02/2024 17:02, Paweł Anikiel wrote:
>>> Currently, .query_dv_timings() is defined as a video callback without
>>> a pad argument. This is a problem if the subdevice can have different
>>> dv timings for each pad (e.g. a DisplayPort receiver with multiple
>>> virtual channels).
>>>
>>> To solve this, add a pad variant of this callback which includes
>>> the pad number as an argument.
>>
>> So now we have two query_dv_timings ops: one for video ops, and one
>> for pad ops. That's not very maintainable. I would suggest switching
>> all current users of the video op over to the pad op.
> 
> I agree it would be better if there was only one. However, I have some concerns:
> 1. Isn't there a problem with backwards compatibility? For example, an
> out-of-tree driver is likely to use this callback, which would break.
> I'm asking because I'm not familiar with how such API changes are
> handled.

It's out of tree, so they will just have to adapt. That's how life is if
you are not part of the mainline kernel.

> 2. If I do switch all current users to the pad op, I can't test those
> changes. Isn't that a problem?

I can test one or two drivers, but in general I don't expect this to be
a problem.

> 3. Would I need to get ACK from all the driver maintainers?

CC the patches to the maintainers. Generally you will get back Acks from
some but not all maintainers, but that's OK. For changes affecting multiple
drivers you never reach 100% on that. I can review the remainder. The DV
Timings API is my expert area, so that shouldn't be a problem.

A quick grep gives me these subdev drivers that implement it:

adv748x, adv7604, adv7842, tc358743, tda1997x, tvp7002, gs1662.

And these bridge drivers that call the subdevs:

cobalt, rcar-vin, vpif_capture.

The bridge drivers can use the following pad when calling query_dv_timings:

cobalt: ADV76XX_PAD_HDMI_PORT_A
rcar_vin: vin->parallel.sink_pad
vpif_capture: 0

The converted subdev drivers should check if the pad is an input pad.
Ideally it should check if the pad is equal to the current input pad
since most devices can only query the timings for the currently selected
input pad. But some older drivers predate the pad concept and they
ignore the pad value.

Regards,

	Hans

