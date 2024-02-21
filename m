Return-Path: <linux-kernel+bounces-74995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8906785E10F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1052848E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9835669D05;
	Wed, 21 Feb 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="mNfvz9cB"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B717FBC8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529223; cv=none; b=WwKhhrCxGIfVqblivcHuHORzX/Vq0FTfGYIf+Ew6FAPPRBpANH6pkM1kX2Lf745y70QpjDGv6pLPglFAzOsYYoMpNioVIMo0OLtYZ5yzhVXWOBnb/8u/CYSsv9PE+IPNjzwvSTlxH9jMJ1Q1hT4nXKyyuQoQZQb7vq7JPL3JDP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529223; c=relaxed/simple;
	bh=UMyVHwJ+E3hxFUahAJZzZza+ewuOnSmK3q6iw5hJSwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJEh6204bll1qJX6f6AvzqtI7tB+hen/NXWZNVVHe5jDFlrlnM7fH0stnmPr3I5BkUaPrWj97ZVdhQ0L4f7Cf19m3lGHrUdbnYtGb3Io10S4cJSoFaz3WlQMr2c/tYXU3lIW1HW6h1S8fFFYARmztLNxilpiDBVaNM5vklTqTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=mNfvz9cB; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d995bd557eso2160516241.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1708529220; x=1709134020; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w/YNMvZO8t1f9q9QebKmqlEKpDTAu6MakGAAlkCXnaE=;
        b=mNfvz9cBOWyNKXhiMt/srA5fvIDlegotsFnF3AiIczAd6MH/FwMnGqhg4kkNWcWShE
         zCIaQg5EGapmzTKYmwe29CcIKtE4zAyzAzkkIngk8/OzEuYNRk/S1mUzWy6A9BBoePj7
         iZmanGA3PkbKr5oxraF9ICnXrBfj6NNQpfxlO9V1qty6q26iI4hF+CJuin26tYZIis9/
         pDm3ha9e/pYUBXBQM+sRE7wQoOvLQwcY7JtENZ/TQRxVfvoqldeQ+mHj0H4DmhXms1av
         fkAPDM++dv5AOvZd5+fSo1U1ya+Uh+U0VIAoWWdqtckKzhDhfztAHbMbLoKesFrpaRBd
         d1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529220; x=1709134020;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/YNMvZO8t1f9q9QebKmqlEKpDTAu6MakGAAlkCXnaE=;
        b=Jmz2m1arShPhv2oiKpAXebdZP82n8hQzO/Dtb4m3Xi/jUpKHII3EtuACowBez1MpNF
         5OLzhoF06nuzgZYZfP3ZMS8yNu6MlW3NWksSnpG6Qt+40QG8uTmhD3XkHBDPLIckML98
         +o8bGoh7KOcr+ik+IFh+v4k1gAxYRtvwyd0jz+0F5JUTkrChYtTu0t/bylekSL878fco
         Yg2YAHPQpozxxPH7XouHLsISPzY/M9PkkUM1zVz1ADcbyPW8MJ4/JGssTmTQMnfVtZc7
         H0uqMk/1BRsUxSXuzyxKzZP2WAKmkDykDpPMRj0f0GPEOavl/fKCVAlmqMnHOGXhhaKM
         o1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXUd8mBt0Brdpj+Cyf69havWuM8QmY1nq4zOG+F+G9v0PuskuXP83SmFSTSciXn6G3Hj8cUOCp8cJYe8IvegEzmLRENXlPeLT5cW0SK
X-Gm-Message-State: AOJu0Yw3Ca3/SOCys/xFwUOcrygK+PCqH4d7IYsRs2HHbzVvJe5885Af
	cOSVKKrREwyfukaI40pKIgzreuUFhbtdlGKL52L/Ys8yhzR9W6oG1XERz7nmtcY=
X-Google-Smtp-Source: AGHT+IHL5VdbfmrjwOkdDYbolHvWLbQSQkWbjiHq3JkePyRGRrGHcNgE1G/QlV8vkdML8wNEsL3/8w==
X-Received: by 2002:a1f:ea04:0:b0:4c8:90e5:6790 with SMTP id i4-20020a1fea04000000b004c890e56790mr10283746vkh.5.1708529220313;
        Wed, 21 Feb 2024 07:27:00 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id ql1-20020a056214540100b0068f9b20fb0bsm1349796qvb.100.2024.02.21.07.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:26:59 -0800 (PST)
Message-ID: <be5ce95b023bcff24f53fdae55763bf4a3f6b1d7.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v0 3/5] wave5 : Support runtime suspend/resume.
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, "mchehab@kernel.org"
	 <mchehab@kernel.org>, "linux-media@vger.kernel.org"
	 <linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>
Cc: "lafley.kim" <lafley.kim@chipsnmedia.com>, "b-brnich@ti.com"
	 <b-brnich@ti.com>
Date: Wed, 21 Feb 2024 10:26:58 -0500
In-Reply-To: <SE1P216MB1303932A0D3FC399179115D9ED572@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
	 <20240131013046.15687-4-jackson.lee@chipsnmedia.com>
	 <efe24b949a60034bf618eb3b8a8ba82e8a5dc99c.camel@ndufresne.ca>
	 <SE1P216MB130326E2C4BA7E723A8955C9ED512@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <20489b01f1ac9ab3e434ea4c17b4e0ccd84afa36.camel@ndufresne.ca>
	 <SE1P216MB1303CEEF6DFAB5FA7C69D645ED502@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <d5546b48ea829316a8dbd2ecc27bbf05e70e8188.camel@ndufresne.ca>
	 <SE1P216MB1303932A0D3FC399179115D9ED572@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mercredi 21 f=C3=A9vrier 2024 =C3=A0 02:27 +0000, jackson.lee a =C3=A9cr=
it=C2=A0:
> Hello Nicolas
>=20
>=20
> Thanks for your comment
>=20
> > Le mardi 20 f=C3=A9vrier 2024 =C3=A0 05:12 +0000, jackson.lee a =C3=A9c=
rit=C2=A0:
> > > A pause is common state for media player, but our VPU could trigger a=
n
> > interrupt regardless of a player state.
> > > So at a pause state if a power turns off, our driver becomes hang-up.
> > > I think power on/off should be controlled in the open/close function.
> >=20
> > Please, avoid top posting, this breaks the discussion completely. Walk
> > through the comments, and reply to them underneath so we can have a pro=
per
> > discussion.
> >=20
> > In our experience, and with the rework of the driver we did during up-
> > streaming, there is no more un-solicited IRQ. The way the driver state
> > machine has been built, when the m2m framework is idle (no jobs are act=
ive
> > or pending), it means the firmware is stalled, waiting on some applicat=
ion
> > action. Combined with a timer of course, so we don't actively
> > suspend/resume, this seems adequate place to do power management. If th=
at
> > application action never occurred passed a decent delay, we can suspend=
.
> > Later on, user actions like qbuf, will lead to
> > device_run() to be called again, and it would be a good place to resume=
 it.
>=20
> The above comment means like the below ?
> The wave5_vpu_dec_finish_decode is called by IRQ if there is a decoded fr=
ame.
> And at the end of the function, if there is no data queued, v4l2_m2m_job_=
finish is called.
> You means suspend is called in that function and if app feeds new data in=
to v4l2 driver, the device_run then is called,
> In the device_run, resume is called.

That is the general idea. (Note that we don't forcefully suspect, for this =
type
of HW, we should configure a delay. Just saying in case someone miss-interp=
ret
what was written here)

>=20
>=20
> I have a question,=20
> If app is paused or resumed , the v4l2's vidioc_decoder_cmd is always cal=
led ?

There is no indication if an app is paused / resumed. Runtime PM in fact sh=
ould
not depend on application actions in general. In the case of V4L2, most dri=
ver
will configure a delay (like 5 seconds). If the driver has been idle (no pe=
nding
work, no jobs) withing that delay, it will auto suspend. Then whenever new
activity comes, like a QBUF, we resume.

Nicolas

>=20
> Thanks.
>=20
>=20
> > There is of course other places where you'll have to make sure the
> > hardware is resumed, like on close, as you want to remove the instance.
> > There is also small queries here and there that need to be surrounded w=
ith
> > resume/put, but with the redesign, most of the HW access now take place
> > inside device_run() only.
> >=20
> > Open/Close is not invalid, but it has a lot of issues, as any random
> > application can endup disabling the kernel ability to save power.
> > Personally, I think we should at least give it a try, and document vali=
d
> > reason not to do so if we find hardware issues. Otherwise, this sounds
> > like all we care is ticking the box "this driver has runtime PM" withou=
t
> > actually caring about effective power saving.
> >=20
> > Nicolas
> >=20
> > >=20
> > > Thanks.
> > >=20
> > > > Le lundi 19 f=C3=A9vrier 2024 =C3=A0 04:04 +0000, jackson.lee a =C3=
=A9crit=C2=A0:
> > > > > Hi Nicolas
> > > > >=20
> > > > >=20
> > > > > > This seems very unnatural. We do the get() in
> > > > > > "start_streaming()", but the
> > > > > > put() is only done when the device is closed, or when the drive=
r
> > > > > > is removed. As this is not balanced, you seem to have to check
> > > > > > the suspended condition all over the place.
> > > > > >=20
> > > > > > I think we could aim for start_streaming()/stop_streaming() for
> > > > > > your get/put placement. At least they will be bound to an
> > > > > > entirely balanced
> > > > API.
> > > > > > But then, a media player in paused sate will prevent that devic=
e
> > > > > > from being suspended.
> > > > > >=20
> > > > > > If the HW is capable of preserving enough state, and From the
> > > > > > short doc I have it gives me the impression it can preserve
> > > > > > that, I'd suggest to follow what hantro driver is doing. What i=
s
> > > > > > does is that it will do get() in device_run(), and put()
> > > > > > whenever the job completes. This driver has been designed so
> > > > > > when there is no job, it means the firmware is currently idle
> > > > > > and looking for more work. So it seems like the perfect moment =
to
> > do suspend it.
> > > > > >=20
> > > > >=20
> > > > > Thanks your comment,
> > > > >=20
> > > > > Currently they are not balanced,
> > > > > If we puts "the put functon" into the stop_streaming, our hw is
> > > > > stalled
> > > > until doing wake-up command, so our v4l2 device become block.
> > > > > so I'd like to update the below instead of calling get at the
> > > > start_streaming function.
> > > > >=20
> > > > >=20
> > > > > @@ -1867,6 +1868,13 @@ static int wave5_vpu_open_dec(struct file
> > > > > *filp)
> > > > >=20
> > > > >         wave5_vdi_allocate_sram(inst->dev);
> > > > >=20
> > > > > +       err =3D pm_runtime_resume_and_get(inst->dev->dev);
> > > > > +       if (err) {
> > > > > +               dev_err(inst->dev->dev, "decoder runtime resume
> > > > failed %d\n", err);
> > > > > +               ret =3D -EINVAL;
> > > > > +               goto cleanup_inst;
> > > > > +       }
> > > > > +
> > > > >         return 0;
> > > >=20
> > > > I guess we need to discuss the power management strategy for this
> > device.
> > > > If you do resume_and_get() in open(), and then put in close(), that
> > > > seems balanced. But in term of power saving, it might not be very
> > > > strong. If you have a media player that is set to pause and then
> > > > placed in the background, you still keep the IP running. This is
> > > > extremely common, since application cannot close their device
> > > > without loosing the reference frames, and thus having to do extra
> > > > work on resume to seek back to the previous sync point and drop
> > unneeded frames.
> > > >=20
> > > > It seems like the whole point of asking the firmware to save the
> > > > state and suspend is to be able to do so while there is meaningful
> > > > sate in the firt place.
> > > > If we are to suspend only when there is no meaningful state, we
> > > > could just free all resources and power it off completely. (This is
> > > > just for illustration, its probably to slow to boot the firmware at
> > > > runtime)
> > > >=20
> > > >=20
> > > > I understand you suffered lockup with a start_streaming() for
> > > > resume_and_get(), and stop_streaming() for put(), this may simply
> > > > indicate that some hardware access are needed between these two. Ca=
n
> > > > you write down a power management plan that would effectively save
> > > > power in common use cases ? We can certainly help in refactoring th=
e
> > code to make that happen.
> > > >=20
> > > > Nicolas
> > > >=20
> > > > >=20
> > > > > > Le mercredi 31 janvier 2024 =C3=A0 10:30 +0900, jackson.lee a =
=C3=A9crit=C2=A0:
> > > > > > > There are two device run-time PM callbacks defined in 'struct
> > > > > > dev_pm_ops'
> > > > > > > int (*runtime_suspend)(struct device *dev); int
> > > > > > > (*runtime_resume)(struct device *dev);
> > > > > >=20
> > > > > > I wonder how useful is it to teach everyone what the generic
> > > > > > 'struct dev_pm_ops'
> > > > > > contains. Perhaps you simply wanted that this patch implement
> > > > > > both suspend and resume ops ?
> > > > > >=20
> > > > > > >=20
> > > > > > > Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> > > > > > > Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> > > > > > > ---
> > > > > > >  .../platform/chips-media/wave5/wave5-hw.c     |  5 +-
> > > > > > >  .../chips-media/wave5/wave5-vpu-dec.c         |  9 +++
> > > > > > >  .../chips-media/wave5/wave5-vpu-enc.c         |  9 +++
> > > > > > >  .../platform/chips-media/wave5/wave5-vpu.c    | 68
> > > > +++++++++++++++++++
> > > > > > >  .../platform/chips-media/wave5/wave5-vpuapi.c |  7 ++
> > > > > > > .../media/platform/chips-media/wave5/wave5.h  |  3 +
> > > > > > >  6 files changed, 99 insertions(+), 2 deletions(-)
> > > > > > >=20
> > > > > > > diff --git
> > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > > > > > index 8ad7f3a28ae1..8aade5a38439 100644
> > > > > > > --- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > > > > > @@ -503,6 +503,7 @@ int wave5_vpu_build_up_dec_param(struct
> > > > > > > vpu_instance
> > > > > > *inst,
> > > > > > >  	/* This register must be reset explicitly */
> > > > > > >  	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
> > > > > > >  	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1,
> > > > > > > (COMMAND_QUEUE_DEPTH - 1));
> > > > > > > +	vpu_write_reg(inst->dev, W5_CMD_ERR_CONCEAL, 0);
> > > > > >=20
> > > > > > In some way, the relation between suspend and this register
> > > > > > write is not obvious. If its not related, please do this in its
> > own patch.
> > > > > > Otherwise you want to explain why you needed this (possibly jus=
t
> > > > > > in the commit message).
> > > > > >=20
> > > > > > >=20
> > > > > > >  	ret =3D send_firmware_command(inst, W5_CREATE_INSTANCE, tru=
e,
> > > > > > > NULL,
> > > > > > NULL);
> > > > > > >  	if (ret) {
> > > > > > > @@ -1075,8 +1076,8 @@ int wave5_vpu_re_init(struct device
> > > > > > > *dev, u8 *fw,
> > > > > > size_t size)
> > > > > > >  	return setup_wave5_properties(dev);  }
> > > > > > >=20
> > > > > > > -static int wave5_vpu_sleep_wake(struct device *dev, bool
> > > > > > > i_sleep_wake,
> > > > > > const uint16_t *code,
> > > > > > > -				size_t size)
> > > > > > > +int wave5_vpu_sleep_wake(struct device *dev, bool
> > > > > > > +i_sleep_wake, const
> > > > > > uint16_t *code,
> > > > > > > +			 size_t size)
> > > > > > >  {
> > > > > > >  	u32 reg_val;
> > > > > > >  	struct vpu_buf *common_vb;
> > > > > > > diff --git
> > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> > > > > > > index ef227af72348..328a7a8f26c5 100644
> > > > > > > --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.=
c
> > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.=
c
> > > > > > > @@ -5,6 +5,7 @@
> > > > > > >   * Copyright (C) 2021-2023 CHIPS&MEDIA INC
> > > > > > >   */
> > > > > > >=20
> > > > > > > +#include <linux/pm_runtime.h>
> > > > > > >  #include "wave5-helper.h"
> > > > > > >=20
> > > > > > >  #define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
> > > > > > > @@ -1387,9 +1388,17 @@ static int
> > > > > > > wave5_vpu_dec_start_streaming(struct
> > > > > > > vb2_queue *q, unsigned int count
> > > > > > >=20
> > > > > > >  	if (q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE && ins=
t-
> > > > > state
> > > > > > > =3D=3D
> > > > > > VPU_INST_STATE_NONE) {
> > > > > > >  		struct dec_open_param open_param;
> > > > > > > +		int err =3D 0;
> > > > > > >=20
> > > > > > >  		memset(&open_param, 0, sizeof(struct dec_open_param));
> > > > > > >=20
> > > > > > > +		err =3D pm_runtime_resume_and_get(inst->dev->dev);
> > > > > > > +		if (err) {
> > > > > > > +			dev_err(inst->dev->dev, "decoder runtime resume
> > > > > > failed %d\n", err);
> > > > > > > +			ret =3D -EINVAL;
> > > > > > > +			goto return_buffers;
> > > > > > > +		}
> > > > > > > +
> > > > > > >  		ret =3D wave5_vpu_dec_allocate_ring_buffer(inst);
> > > > > > >  		if (ret)
> > > > > > >  			goto return_buffers;
> > > > > > > diff --git
> > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > > > > > index 761775216cd4..ff73d69de41c 100644
> > > > > > > --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.=
c
> > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.=
c
> > > > > > > @@ -5,6 +5,7 @@
> > > > > > >   * Copyright (C) 2021-2023 CHIPS&MEDIA INC
> > > > > > >   */
> > > > > > >=20
> > > > > > > +#include <linux/pm_runtime.h>
> > > > > > >  #include "wave5-helper.h"
> > > > > > >=20
> > > > > > >  #define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
> > > > > > > @@ -1387,9 +1388,17 @@ static int
> > > > > > > wave5_vpu_enc_start_streaming(struct
> > > > > > > vb2_queue *q, unsigned int count
> > > > > > >=20
> > > > > > >  	if (inst->state =3D=3D VPU_INST_STATE_NONE && q->type =3D=
=3D
> > > > > > V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > > > > > >  		struct enc_open_param open_param;
> > > > > > > +		int err =3D 0;
> > > > > > >=20
> > > > > > >  		memset(&open_param, 0, sizeof(struct enc_open_param));
> > > > > > >=20
> > > > > > > +		err =3D pm_runtime_resume_and_get(inst->dev->dev);
> > > > > > > +		if (err) {
> > > > > > > +			dev_err(inst->dev->dev, "encoder runtime resume
> > > > > > failed %d\n", err);
> > > > > > > +			ret =3D -EINVAL;
> > > > > > > +			goto return_buffers;
> > > > > > > +		}
> > > > > > > +
> > > > > > >  		wave5_set_enc_openparam(&open_param, inst);
> > > > > > >=20
> > > > > > >  		ret =3D wave5_vpu_enc_open(inst, &open_param); diff --
> > > > git
> > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > > > > > index 0d90b5820bef..f81409740a56 100644
> > > > > > > --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > > > > > @@ -10,6 +10,7 @@
> > > > > > >  #include <linux/clk.h>
> > > > > > >  #include <linux/firmware.h>
> > > > > > >  #include <linux/interrupt.h>
> > > > > > > +#include <linux/pm_runtime.h>
> > > > > > >  #include "wave5-vpu.h"
> > > > > > >  #include "wave5-regdefine.h"
> > > > > > >  #include "wave5-vpuconfig.h"
> > > > > > > @@ -117,6 +118,65 @@ static int wave5_vpu_load_firmware(struc=
t
> > > > > > > device
> > > > > > *dev, const char *fw_name,
> > > > > > >  	return 0;
> > > > > > >  }
> > > > > > >=20
> > > > > > > +static __maybe_unused int wave5_pm_suspend(struct device *de=
v)
> > {
> > > > > > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > > > > > +
> > > > > > > +	if (pm_runtime_suspended(dev))
> > > > > > > +		return 0;
> > > > > > > +
> > > > > > > +	wave5_vpu_sleep_wake(dev, true, NULL, 0);
> > > > > > > +	clk_bulk_disable_unprepare(vpu->num_clks, vpu->clks);
> > > > > > > +
> > > > > > > +	return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static __maybe_unused int wave5_pm_resume(struct device *dev=
) {
> > > > > > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > > > > > +	int ret =3D 0;
> > > > > > > +
> > > > > > > +	wave5_vpu_sleep_wake(dev, false, NULL, 0);
> > > > > > > +	ret =3D clk_bulk_prepare_enable(vpu->num_clks, vpu->clks);
> > > > > > > +	if (ret) {
> > > > > > > +		dev_err(dev, "Enabling clocks, fail: %d\n", ret);
> > > > > > > +		return ret;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	return ret;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static __maybe_unused int wave5_suspend(struct device *dev) =
{
> > > > > > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > > > > > +	struct vpu_instance *inst;
> > > > > > > +
> > > > > > > +	list_for_each_entry(inst, &vpu->instances, list)
> > > > > > > +		v4l2_m2m_suspend(inst->v4l2_m2m_dev);
> > > > > > > +
> > > > > > > +	return pm_runtime_force_suspend(dev); }
> > > > > > > +
> > > > > > > +static __maybe_unused int wave5_resume(struct device *dev) {
> > > > > > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > > > > > +	struct vpu_instance *inst;
> > > > > > > +	int ret =3D 0;
> > > > > > > +
> > > > > > > +	ret =3D pm_runtime_force_resume(dev);
> > > > > > > +	if (ret < 0)
> > > > > > > +		return ret;
> > > > > > > +
> > > > > > > +	list_for_each_entry(inst, &vpu->instances, list)
> > > > > > > +		v4l2_m2m_resume(inst->v4l2_m2m_dev);
> > > > > > > +
> > > > > > > +	return ret;
> > > > > > > +}
> > > > > >=20
> > > > > > The functions wave5_suspend() and wave5_resume() are not just
> > > > > > "maybe_unsued" but actually never used. What was the intention =
?
> > > > > > Considering the usage of __maybe_unused has been such a bad
> > > > > > friend for this one, could you instead bracket the functions
> > > > > > with an
> > > > explicit ?
> > > > > >=20
> > > > > > #ifdef CONFIG_PM
> > > > > > #endif
> > > > > >=20
> > > > > > This way the compiler will have a word if you implement
> > > > > > something that you forgot to actually use.
> > > > > >=20
> > > > > > > +
> > > > > > > +static const struct dev_pm_ops wave5_pm_ops =3D {
> > > > > > > +	SET_RUNTIME_PM_OPS(wave5_pm_suspend, wave5_pm_resume,
> > > > NULL) };
> > > > > > > +
> > > > > > >  static int wave5_vpu_probe(struct platform_device *pdev)  {
> > > > > > >  	int ret;
> > > > > > > @@ -232,6 +292,10 @@ static int wave5_vpu_probe(struct
> > > > > > > platform_device
> > > > > > *pdev)
> > > > > > >  		 (match_data->flags & WAVE5_IS_DEC) ? "'DECODE'" : "");
> > > > > > >  	dev_info(&pdev->dev, "Product Code:      0x%x\n", dev-
> > > > > product_code);
> > > > > > >  	dev_info(&pdev->dev, "Firmware Revision: %u\n",
> > > > > > > fw_revision);
> > > > > > > +
> > > > > > > +	pm_runtime_enable(&pdev->dev);
> > > > > > > +	wave5_vpu_sleep_wake(&pdev->dev, true, NULL, 0);
> > > > > > > +
> > > > > > >  	return 0;
> > > > > > >=20
> > > > > > >  err_enc_unreg:
> > > > > > > @@ -254,6 +318,9 @@ static int wave5_vpu_remove(struct
> > > > > > > platform_device
> > > > > > > *pdev)  {
> > > > > > >  	struct vpu_device *dev =3D dev_get_drvdata(&pdev->dev);
> > > > > > >=20
> > > > > > > +	pm_runtime_put_sync(&pdev->dev);
> > > > > > > +	pm_runtime_disable(&pdev->dev);
> > > > > > > +
> > > > > > >  	mutex_destroy(&dev->dev_lock);
> > > > > > >  	mutex_destroy(&dev->hw_lock);
> > > > > > >  	clk_bulk_disable_unprepare(dev->num_clks, dev->clks); @@ -
> > > > 281,6
> > > > > > > +348,7 @@ static struct platform_driver wave5_vpu_driver =3D =
{
> > > > > > >  	.driver =3D {
> > > > > > >  		.name =3D VPU_PLATFORM_DEVICE_NAME,
> > > > > > >  		.of_match_table =3D of_match_ptr(wave5_dt_ids),
> > > > > > > +		.pm =3D &wave5_pm_ops,
> > > > > > >  		},
> > > > > > >  	.probe =3D wave5_vpu_probe,
> > > > > > >  	.remove =3D wave5_vpu_remove,
> > > > > > > diff --git
> > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> > > > > > > index 1a3efb638dde..f1f8e4fc8474 100644
> > > > > > > --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> > > > > > > @@ -6,6 +6,7 @@
> > > > > > >   */
> > > > > > >=20
> > > > > > >  #include <linux/bug.h>
> > > > > > > +#include <linux/pm_runtime.h>
> > > > > > >  #include "wave5-vpuapi.h"
> > > > > > >  #include "wave5-regdefine.h"
> > > > > > >  #include "wave5.h"
> > > > > > > @@ -232,6 +233,9 @@ int wave5_vpu_dec_close(struct
> > > > > > > vpu_instance *inst,
> > > > > > > u32 *fail_res)
> > > > > > >=20
> > > > > > >  	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_task);
> > > > > > >=20
> > > > > > > +	if (!pm_runtime_suspended(inst->dev->dev))
> > > > > > > +		pm_runtime_put_sync(inst->dev->dev);
> > > > > > > +
> > > > > > >  unlock_and_return:
> > > > > > >  	mutex_unlock(&vpu_dev->hw_lock);
> > > > > > >=20
> > > > > > > @@ -734,6 +738,9 @@ int wave5_vpu_enc_close(struct
> > > > > > > vpu_instance *inst,
> > > > > > > u32 *fail_res)
> > > > > > >=20
> > > > > > >  	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
> > > > > > >=20
> > > > > > > +	if (!pm_runtime_suspended(inst->dev->dev))
> > > > > > > +		pm_runtime_put_sync(inst->dev->dev);
> > > > > >=20
> > > > > > This seems very unnatural. We do the get() in
> > > > > > "start_streaming()", but the
> > > > > > put() is only done when the device is closed, or when the drive=
r
> > > > > > is removed. As this is not balanced, you seem to have to check
> > > > > > the suspended condition all over the place.
> > > > > >=20
> > > > > > I think we could aim for start_streaming()/stop_streaming() for
> > > > > > your get/put placement. At least they will be bound to an
> > > > > > entirely balanced
> > > > API.
> > > > > > But then, a media player in paused sate will prevent that devic=
e
> > > > > > from being suspended.
> > > > > >=20
> > > > > > If the HW is capable of preserving enough state, and From the
> > > > > > short doc I have it gives me the impression it can preserve
> > > > > > that, I'd suggest to follow what hantro driver is doing. What i=
s
> > > > > > does is that it will do get() in device_run(), and put()
> > > > > > whenever the job completes. This driver has been designed so
> > > > > > when there is no job, it means the firmware is currently idle
> > > > > > and looking for more work. So it seems like the perfect moment =
to
> > do suspend it.
> > > > > >=20
> > > > > > Nicolas
> > > > > >=20
> > > > > > > +
> > > > > > >  	mutex_unlock(&vpu_dev->hw_lock);
> > > > > > >=20
> > > > > > >  	return 0;
> > > > > > > diff --git a/drivers/media/platform/chips-media/wave5/wave5.h
> > > > > > > b/drivers/media/platform/chips-media/wave5/wave5.h
> > > > > > > index 063028eccd3b..6125eff938a8 100644
> > > > > > > --- a/drivers/media/platform/chips-media/wave5/wave5.h
> > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave5.h
> > > > > > > @@ -56,6 +56,9 @@ int wave5_vpu_get_version(struct vpu_device
> > > > > > > *vpu_dev, u32 *revision);
> > > > > > >=20
> > > > > > >  int wave5_vpu_init(struct device *dev, u8 *fw, size_t size);
> > > > > > >=20
> > > > > > > +int wave5_vpu_sleep_wake(struct device *dev, bool
> > > > > > > +i_sleep_wake, const
> > > > > > uint16_t *code,
> > > > > > > +			 size_t size);
> > > > > > > +
> > > > > > >  int wave5_vpu_reset(struct device *dev, enum sw_reset_mode
> > > > > > > reset_mode);
> > > > > > >=20
> > > > > > >  int wave5_vpu_build_up_dec_param(struct vpu_instance *inst,
> > > > > > > struct dec_open_param *param);
> > > > >=20
> > >=20
>=20


