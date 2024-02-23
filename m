Return-Path: <linux-kernel+bounces-78944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4995B861B30
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C703A1F28255
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D031141997;
	Fri, 23 Feb 2024 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="0ysmUY2T"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9213B7B3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711776; cv=none; b=isqaQ84G72ildzY+3iXRQmONFkS+CqJSg6P7meCDRKmDO6AbNrClyI14ILCYn7zdyFcH26bTCP4/0kuaW9HaDRM+RHjCnykBm5RKIlrOEl9/wgu1ZsdR7C+kuD2yn+lX+HNtijOYsv56V1SoKKIyJzalJ7cbulyVvUNJpqc87AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711776; c=relaxed/simple;
	bh=1zoGDa+DTJbXN7b56j7LThSsxySulA8iXbXg0gcaYeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cD1+I79ltJpxADAS2OVFFsWCwb1RwmwDlj/trLkda77Da7YJZu3fw+WiBoC+oK/jevKx40nVM26tCqgonNWgwfIDCZ9oR6LfuUxXtvNnV6HoNCWFs67w7dwh7wST/uL5BYjCjfuDG3v40Fet9zO9DMu7oSHykQ/V2tYAbmSbYug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=0ysmUY2T; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-787b0b1deeaso56454185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1708711773; x=1709316573; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8napiSq6AiKqB2AEQRPSPvQnf1V0X0HBaLbENJLY9dc=;
        b=0ysmUY2TJQYXAGozg91yOyAkTvEVErxGXjocUpHyk8s6HIKKNbSyk/YiK/bpxTmfiU
         E/SROc6QcpP1+b7c3EiFjEQCd11U6/Fcy1cEfPbvL8LlXU0Vrnc7l1ycpMsgD4KRXodJ
         FdiDWHpLOkpbkpf/TNo34oQDqINQFIzo8bLaWTWY5O+p6hg4kFJmTq0JPOhpdCwOZHVL
         XpCvOF3oaviqS7+qDwBEPqXbS+T1NWQMAmwdfDb1tdRIQoOgW6jyQfCRcbZTIdg9rati
         9oTiwJPqaBrSNZ9LvSd/AZzoNHrJLGlAZpsMflPy8GflY/CrT0PclalCHAo04PuZXgVP
         jO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711773; x=1709316573;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8napiSq6AiKqB2AEQRPSPvQnf1V0X0HBaLbENJLY9dc=;
        b=jFoohvoZneMabk8j7b3122q7zKNQdijqX8cUNn03AitcNvhmPUNtcnV3SBunDxtc0V
         8o7157PMtmvrvsVte5aO4Dn8FE//etkHyzojhaC76otbFSUfjGNG2aANUeLZjEfusY+X
         VnrJ3rm89lSH8SdpsT4f13Xx5hzttluJRL5DUiH74mPi3BH1KRgeqOZO5dLe9T82cnTk
         oexUI8YmtJ2ok/zJnFQkeb9x6gk7c2HJjmGyRkAlCvarotSNny2wcXZtpNdDzmytL4VS
         5L+iAA8Vo35PbxsM82fFmhw3yoU/7toiQ0zq2Qx/q/wcQWU+q+oEYv6geLstN3SKtxS2
         TmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb6RoF4JX1QG+oKTM7joZeVStst402sLX/38HmLo9yfSBmFFbFIhZzMs2Mhs3sa0aessRBuLR0n/LOcYmwQOMBaSvsTFPd8o4wtR9M
X-Gm-Message-State: AOJu0YzychXTsouMYFg05Oz/R5P/iVeSEa7d6d9AXT/xHmIoj+gIvsg+
	2ggMK51NDwYnj00+gCXblPapYxif1GbGsOhW0I2RDrcJlMcczvFYSqFI8e5vbZg=
X-Google-Smtp-Source: AGHT+IEZDrah5gmcrkdtyIxeYnAvsSLCFMU9BEMpB3RtkTqeXjCno5KuSshLoHuU3ysYmlc1UTEVxA==
X-Received: by 2002:a05:620a:12eb:b0:787:a705:d5c3 with SMTP id f11-20020a05620a12eb00b00787a705d5c3mr548618qkl.66.1708711772537;
        Fri, 23 Feb 2024 10:09:32 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b007878458ba10sm2949108qki.59.2024.02.23.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 10:09:32 -0800 (PST)
Message-ID: <d4d43f9e19a9d0ecf54167fd3fc71f1fc03aec2d.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v0 3/5] wave5 : Support runtime suspend/resume.
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, "mchehab@kernel.org"
	 <mchehab@kernel.org>, "linux-media@vger.kernel.org"
	 <linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, Nas Chung <nas.chung@chipsnmedia.com>
Cc: "lafley.kim" <lafley.kim@chipsnmedia.com>, "b-brnich@ti.com"
	 <b-brnich@ti.com>
Date: Fri, 23 Feb 2024 13:09:31 -0500
In-Reply-To: <SE1P216MB13035B8E53454881C87059B9ED562@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
	 <20240131013046.15687-4-jackson.lee@chipsnmedia.com>
	 <efe24b949a60034bf618eb3b8a8ba82e8a5dc99c.camel@ndufresne.ca>
	 <SE1P216MB130326E2C4BA7E723A8955C9ED512@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <20489b01f1ac9ab3e434ea4c17b4e0ccd84afa36.camel@ndufresne.ca>
	 <SE1P216MB1303CEEF6DFAB5FA7C69D645ED502@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <d5546b48ea829316a8dbd2ecc27bbf05e70e8188.camel@ndufresne.ca>
	 <SE1P216MB1303932A0D3FC399179115D9ED572@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <be5ce95b023bcff24f53fdae55763bf4a3f6b1d7.camel@ndufresne.ca>
	 <SE1P216MB13038F3890F8B4597465B394ED562@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
	 <SE1P216MB13035B8E53454881C87059B9ED562@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le jeudi 22 f=C3=A9vrier 2024 =C3=A0 03:57 +0000, jackson.lee a =C3=A9crit=
=C2=A0:
> >=20
> > > Le mercredi 21 f=C3=A9vrier 2024 =C3=A0 02:27 +0000, jackson.lee a =
=C3=A9crit=C2=A0:
> > > > Hello Nicolas
> > > >=20
> > > >=20
> > > > Thanks for your comment
> > > >=20
> > > > > Le mardi 20 f=C3=A9vrier 2024 =C3=A0 05:12 +0000, jackson.lee a =
=C3=A9crit=C2=A0:
> > > > > > A pause is common state for media player, but our VPU could
> > > > > > trigger an
> > > > > interrupt regardless of a player state.
> > > > > > So at a pause state if a power turns off, our driver becomes ha=
ng-
> > up.
> > > > > > I think power on/off should be controlled in the open/close
> > function.
> > > > >=20
> > > > > Please, avoid top posting, this breaks the discussion completely.
> > > > > Walk through the comments, and reply to them underneath so we can
> > > > > have a proper discussion.
> > > > >=20
> > > > > In our experience, and with the rework of the driver we did durin=
g
> > > > > up- streaming, there is no more un-solicited IRQ. The way the
> > > > > driver state machine has been built, when the m2m framework is
> > > > > idle (no jobs are active or pending), it means the firmware is
> > > > > stalled, waiting on some application action. Combined with a time=
r
> > > > > of course, so we don't actively suspend/resume, this seems
> > > > > adequate place to do power management. If that application action
> > > > > never occurred passed a
> > > decent delay, we can suspend.
> > > > > Later on, user actions like qbuf, will lead to
> > > > > device_run() to be called again, and it would be a good place to
> > > resume it.
> > > >=20
> > > > The above comment means like the below ?
> > > > The wave5_vpu_dec_finish_decode is called by IRQ if there is a
> > > > decoded
> > > frame.
> > > > And at the end of the function, if there is no data queued,
> > > v4l2_m2m_job_finish is called.
> > > > You means suspend is called in that function and if app feeds new
> > > > data into v4l2 driver, the device_run then is called, In the
> > > > device_run,
> > > resume is called.
> > >=20
> > > That is the general idea. (Note that we don't forcefully suspect, for
> > > this type of HW, we should configure a delay. Just saying in case
> > > someone miss- interpret what was written here)
> > >=20
> > > >=20
> > > >=20
> > > > I have a question,
> > > > If app is paused or resumed , the v4l2's vidioc_decoder_cmd is
> > > > always
> > > called ?
> > >=20
> > > There is no indication if an app is paused / resumed. Runtime PM in
> > > fact should not depend on application actions in general. In the case
> > > of V4L2, most driver will configure a delay (like 5 seconds). If the
> > > driver has been idle (no pending work, no jobs) withing that delay, i=
t
> > > will auto suspend. Then whenever new activity comes, like a QBUF, we
> > resume.
> > >=20
>=20
> Below is a pseudo code for configuring a delay for the Run time suspend/r=
esume.=20
> The logic you are saying means the below ?
>=20
> Driver_probe=20
> {
> =C2=A0	pm_runtime_set_autosuspend_delay(vpu->dev, 100);
> 	pm_runtime_use_autosuspend(vpu->dev);
> 	pm_runtime_enable(vpu->dev);
>=20
> }
>=20
> Device_run=20
> {
>=20
> 	pm_runtime_resume_and_get(ctx->dev->dev);
> }
>=20
>=20
> Finish_job=20
> {
> 	pm_runtime_mark_last_busy(vpu->dev);
> 	pm_runtime_put_autosuspend(vpu->dev);
>=20
> }
>=20

This is aligned with what I had in mind. There will be few cases were you'l=
l
need to ensure the hardware is active outside of this (open() and close() a=
re
examples), but otherwise this should in my perception gives the best power
saving. And finally, the delay might need tuning, at first 100ms seems a bi=
t
low, the delay needs to be balanced against the suspend cost.

Nicolas

>=20
>=20
> Thanks.
> Jackson=20
>=20
> >=20
> > The delay means a timer, so there is no input for 5 secs, then timeout
> > callback is called, And suspend is set, if new activity comes, the devi=
ce
> > is resumed again ?
> > My understanding is correct ?
> >=20
>=20
>=20
> >=20
> >=20
> > > Nicolas
> > >=20
> > > >=20
> > > > Thanks.
> > > >=20
> > > >=20
> > > > > There is of course other places where you'll have to make sure th=
e
> > > > > hardware is resumed, like on close, as you want to remove the
> > instance.
> > > > > There is also small queries here and there that need to be
> > > > > surrounded with resume/put, but with the redesign, most of the HW
> > > > > access now take place inside device_run() only.
> > > > >=20
> > > > > Open/Close is not invalid, but it has a lot of issues, as any
> > > > > random application can endup disabling the kernel ability to save
> > power.
> > > > > Personally, I think we should at least give it a try, and documen=
t
> > > > > valid reason not to do so if we find hardware issues. Otherwise,
> > > > > this sounds like all we care is ticking the box "this driver has
> > > > > runtime PM" without actually caring about effective power saving.
> > > > >=20
> > > > > Nicolas
> > > > >=20
> > > > > >=20
> > > > > > Thanks.
> > > > > >=20
> > > > > > > Le lundi 19 f=C3=A9vrier 2024 =C3=A0 04:04 +0000, jackson.lee=
 a =C3=A9crit=C2=A0:
> > > > > > > > Hi Nicolas
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > > This seems very unnatural. We do the get() in
> > > > > > > > > "start_streaming()", but the
> > > > > > > > > put() is only done when the device is closed, or when the
> > > > > > > > > driver is removed. As this is not balanced, you seem to
> > > > > > > > > have to check the suspended condition all over the place.
> > > > > > > > >=20
> > > > > > > > > I think we could aim for
> > > > > > > > > start_streaming()/stop_streaming()
> > > > > > > > > for your get/put placement. At least they will be bound t=
o
> > > > > > > > > an entirely balanced
> > > > > > > API.
> > > > > > > > > But then, a media player in paused sate will prevent that
> > > > > > > > > device from being suspended.
> > > > > > > > >=20
> > > > > > > > > If the HW is capable of preserving enough state, and From
> > > > > > > > > the short doc I have it gives me the impression it can
> > > > > > > > > preserve that, I'd suggest to follow what hantro driver i=
s
> > > > > > > > > doing. What is does is that it will do get() in
> > > > > > > > > device_run(), and put() whenever the job completes. This
> > > > > > > > > driver has been designed so when there is no job, it mean=
s
> > > > > > > > > the firmware is currently idle and looking for more work.
> > > > > > > > > So it seems like the perfect moment to
> > > > > do suspend it.
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Thanks your comment,
> > > > > > > >=20
> > > > > > > > Currently they are not balanced, If we puts "the put functo=
n"
> > > > > > > > into the stop_streaming, our hw is stalled
> > > > > > > until doing wake-up command, so our v4l2 device become block.
> > > > > > > > so I'd like to update the below instead of calling get at
> > > > > > > > the
> > > > > > > start_streaming function.
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > @@ -1867,6 +1868,13 @@ static int wave5_vpu_open_dec(struct
> > > > > > > > file
> > > > > > > > *filp)
> > > > > > > >=20
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0wave5_vdi_a=
llocate_sram(inst->dev);
> > > > > > > >=20
> > > > > > > > +       err =3D pm_runtime_resume_and_get(inst->dev->dev);
> > > > > > > > +       if (err) {
> > > > > > > > +               dev_err(inst->dev->dev, "decoder runtime
> > > > > > > > + resume
> > > > > > > failed %d\n", err);
> > > > > > > > +               ret =3D -EINVAL;
> > > > > > > > +               goto cleanup_inst;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > > > >=20
> > > > > > > I guess we need to discuss the power management strategy for
> > > > > > > this
> > > > > device.
> > > > > > > If you do resume_and_get() in open(), and then put in close()=
,
> > > > > > > that seems balanced. But in term of power saving, it might no=
t
> > > > > > > be very strong. If you have a media player that is set to
> > > > > > > pause and then placed in the background, you still keep the I=
P
> > > > > > > running. This is extremely common, since application cannot
> > > > > > > close their device without loosing the reference frames, and
> > > > > > > thus having to do extra work on resume to seek back to the
> > > > > > > previous sync point and drop
> > > > > unneeded frames.
> > > > > > >=20
> > > > > > > It seems like the whole point of asking the firmware to save
> > > > > > > the state and suspend is to be able to do so while there is
> > > > > > > meaningful sate in the firt place.
> > > > > > > If we are to suspend only when there is no meaningful state,
> > > > > > > we could just free all resources and power it off completely.
> > > > > > > (This is just for illustration, its probably to slow to boot
> > > > > > > the firmware at
> > > > > > > runtime)
> > > > > > >=20
> > > > > > >=20
> > > > > > > I understand you suffered lockup with a start_streaming() for
> > > > > > > resume_and_get(), and stop_streaming() for put(), this may
> > > > > > > simply indicate that some hardware access are needed between
> > > > > > > these two. Can you write down a power management plan that
> > > > > > > would effectively save power in common use cases ? We can
> > > > > > > certainly help in refactoring the
> > > > > code to make that happen.
> > > > > > >=20
> > > > > > > Nicolas
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > > Le mercredi 31 janvier 2024 =C3=A0 10:30 +0900, jackson.l=
ee a
> > > =C3=A9crit=C2=A0:
> > > > > > > > > > There are two device run-time PM callbacks defined in
> > > > > > > > > > 'struct
> > > > > > > > > dev_pm_ops'
> > > > > > > > > > int (*runtime_suspend)(struct device *dev); int
> > > > > > > > > > (*runtime_resume)(struct device *dev);
> > > > > > > > >=20
> > > > > > > > > I wonder how useful is it to teach everyone what the
> > > > > > > > > generic 'struct dev_pm_ops'
> > > > > > > > > contains. Perhaps you simply wanted that this patch
> > > > > > > > > implement both suspend and resume ops ?
> > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com=
>
> > > > > > > > > > Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> > > > > > > > > > ---
> > > > > > > > > > =C2=A0.../platform/chips-media/wave5/wave5-hw.c     |  =
5 +-
> > > > > > > > > > =C2=A0.../chips-media/wave5/wave5-vpu-dec.c         |  =
9 +++
> > > > > > > > > > =C2=A0.../chips-media/wave5/wave5-vpu-enc.c         |  =
9 +++
> > > > > > > > > > =C2=A0.../platform/chips-media/wave5/wave5-vpu.c    | 6=
8
> > > > > > > +++++++++++++++++++
> > > > > > > > > > =C2=A0.../platform/chips-media/wave5/wave5-vpuapi.c |  =
7 ++
> > > > > > > > > > .../media/platform/chips-media/wave5/wave5.h  |  3 +
> > > > > > > > > > =C2=A06 files changed, 99 insertions(+), 2 deletions(-)
> > > > > > > > > >=20
> > > > > > > > > > diff --git
> > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > > > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > > > > > > > > index 8ad7f3a28ae1..8aade5a38439 100644
> > > > > > > > > > ---
> > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-hw.c
> > > > > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave5-hw=
.
> > > > > > > > > > +++ c
> > > > > > > > > > @@ -503,6 +503,7 @@ int
> > > > > > > > > > wave5_vpu_build_up_dec_param(struct
> > > > > > > > > > vpu_instance
> > > > > > > > > *inst,
> > > > > > > > > > =C2=A0	/* This register must be reset explicitly */
> > > > > > > > > > =C2=A0	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, 0);
> > > > > > > > > > =C2=A0	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1,
> > > > > > > > > > (COMMAND_QUEUE_DEPTH - 1));
> > > > > > > > > > +	vpu_write_reg(inst->dev, W5_CMD_ERR_CONCEAL, 0);
> > > > > > > > >=20
> > > > > > > > > In some way, the relation between suspend and this
> > > > > > > > > register write is not obvious. If its not related, please
> > > > > > > > > do this in its
> > > > > own patch.
> > > > > > > > > Otherwise you want to explain why you needed this
> > > > > > > > > (possibly just in the commit message).
> > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0	ret =3D send_firmware_command(inst, W5_CREATE_IN=
STANCE,
> > > > > > > > > > true, NULL,
> > > > > > > > > NULL);
> > > > > > > > > > =C2=A0	if (ret) {
> > > > > > > > > > @@ -1075,8 +1076,8 @@ int wave5_vpu_re_init(struct
> > > > > > > > > > device *dev, u8 *fw,
> > > > > > > > > size_t size)
> > > > > > > > > > =C2=A0	return setup_wave5_properties(dev);  }
> > > > > > > > > >=20
> > > > > > > > > > -static int wave5_vpu_sleep_wake(struct device *dev,
> > > > > > > > > > bool i_sleep_wake,
> > > > > > > > > const uint16_t *code,
> > > > > > > > > > -				size_t size)
> > > > > > > > > > +int wave5_vpu_sleep_wake(struct device *dev, bool
> > > > > > > > > > +i_sleep_wake, const
> > > > > > > > > uint16_t *code,
> > > > > > > > > > +			 size_t size)
> > > > > > > > > > =C2=A0{
> > > > > > > > > > =C2=A0	u32 reg_val;
> > > > > > > > > > =C2=A0	struct vpu_buf *common_vb; diff --git
> > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vpu-de=
c
> > > > > > > > > > .c
> > > > > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-vpu-de=
c
> > > > > > > > > > .c index ef227af72348..328a7a8f26c5 100644
> > > > > > > > > > ---
> > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vpu-de=
c
> > > > > > > > > > .c
> > > > > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > +++ -d
> > > > > > > > > > +++ ec.c
> > > > > > > > > > @@ -5,6 +5,7 @@
> > > > > > > > > > =C2=A0=C2=A0* Copyright (C) 2021-2023 CHIPS&MEDIA INC
> > > > > > > > > > =C2=A0=C2=A0*/
> > > > > > > > > >=20
> > > > > > > > > > +#include <linux/pm_runtime.h>
> > > > > > > > > > =C2=A0#include "wave5-helper.h"
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0#define VPU_DEC_DEV_NAME "C&M Wave5 VPU decoder"
> > > > > > > > > > @@ -1387,9 +1388,17 @@ static int
> > > > > > > > > > wave5_vpu_dec_start_streaming(struct
> > > > > > > > > > vb2_queue *q, unsigned int count
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0	if (q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MP=
LANE &&
> > > > > > > > > > inst-
> > > > > > > > state
> > > > > > > > > > =3D=3D
> > > > > > > > > VPU_INST_STATE_NONE) {
> > > > > > > > > > =C2=A0		struct dec_open_param open_param;
> > > > > > > > > > +		int err =3D 0;
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0		memset(&open_param, 0, sizeof(struct
> > > dec_open_param));
> > > > > > > > > >=20
> > > > > > > > > > +		err =3D pm_runtime_resume_and_get(inst->dev->dev);
> > > > > > > > > > +		if (err) {
> > > > > > > > > > +			dev_err(inst->dev->dev, "decoder runtime
> > > resume
> > > > > > > > > failed %d\n", err);
> > > > > > > > > > +			ret =3D -EINVAL;
> > > > > > > > > > +			goto return_buffers;
> > > > > > > > > > +		}
> > > > > > > > > > +
> > > > > > > > > > =C2=A0		ret =3D wave5_vpu_dec_allocate_ring_buffer(inst=
);
> > > > > > > > > > =C2=A0		if (ret)
> > > > > > > > > > =C2=A0			goto return_buffers; diff --git
> > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vpu-en=
c
> > > > > > > > > > .c
> > > > > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-vpu-en=
c
> > > > > > > > > > .c index 761775216cd4..ff73d69de41c 100644
> > > > > > > > > > ---
> > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vpu-en=
c
> > > > > > > > > > .c
> > > > > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > +++ -e
> > > > > > > > > > +++ nc.c
> > > > > > > > > > @@ -5,6 +5,7 @@
> > > > > > > > > > =C2=A0=C2=A0* Copyright (C) 2021-2023 CHIPS&MEDIA INC
> > > > > > > > > > =C2=A0=C2=A0*/
> > > > > > > > > >=20
> > > > > > > > > > +#include <linux/pm_runtime.h>
> > > > > > > > > > =C2=A0#include "wave5-helper.h"
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0#define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
> > > > > > > > > > @@ -1387,9 +1388,17 @@ static int
> > > > > > > > > > wave5_vpu_enc_start_streaming(struct
> > > > > > > > > > vb2_queue *q, unsigned int count
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0	if (inst->state =3D=3D VPU_INST_STATE_NONE && q-=
>type =3D=3D
> > > > > > > > > V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > > > > > > > > > =C2=A0		struct enc_open_param open_param;
> > > > > > > > > > +		int err =3D 0;
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0		memset(&open_param, 0, sizeof(struct
> > > enc_open_param));
> > > > > > > > > >=20
> > > > > > > > > > +		err =3D pm_runtime_resume_and_get(inst->dev->dev);
> > > > > > > > > > +		if (err) {
> > > > > > > > > > +			dev_err(inst->dev->dev, "encoder runtime
> > > resume
> > > > > > > > > failed %d\n", err);
> > > > > > > > > > +			ret =3D -EINVAL;
> > > > > > > > > > +			goto return_buffers;
> > > > > > > > > > +		}
> > > > > > > > > > +
> > > > > > > > > > =C2=A0		wave5_set_enc_openparam(&open_param, inst);
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0		ret =3D wave5_vpu_enc_open(inst, &open_param);
> > > diff --
> > > > > > > git
> > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > > > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > > > > > > > > index 0d90b5820bef..f81409740a56 100644
> > > > > > > > > > ---
> > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > > > > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > +++ .c
> > > > > > > > > > @@ -10,6 +10,7 @@
> > > > > > > > > > =C2=A0#include <linux/clk.h>
> > > > > > > > > > =C2=A0#include <linux/firmware.h>  #include
> > > > > > > > > > <linux/interrupt.h>
> > > > > > > > > > +#include <linux/pm_runtime.h>
> > > > > > > > > > =C2=A0#include "wave5-vpu.h"
> > > > > > > > > > =C2=A0#include "wave5-regdefine.h"
> > > > > > > > > > =C2=A0#include "wave5-vpuconfig.h"
> > > > > > > > > > @@ -117,6 +118,65 @@ static int
> > > > > > > > > > wave5_vpu_load_firmware(struct device
> > > > > > > > > *dev, const char *fw_name,
> > > > > > > > > > =C2=A0	return 0;
> > > > > > > > > > =C2=A0}
> > > > > > > > > >=20
> > > > > > > > > > +static __maybe_unused int wave5_pm_suspend(struct
> > > > > > > > > > +device
> > > > > > > > > > +*dev)
> > > > > {
> > > > > > > > > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > > > > > > > > +
> > > > > > > > > > +	if (pm_runtime_suspended(dev))
> > > > > > > > > > +		return 0;
> > > > > > > > > > +
> > > > > > > > > > +	wave5_vpu_sleep_wake(dev, true, NULL, 0);
> > > > > > > > > > +	clk_bulk_disable_unprepare(vpu->num_clks, vpu->clks);
> > > > > > > > > > +
> > > > > > > > > > +	return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static __maybe_unused int wave5_pm_resume(struct devic=
e
> > > *dev) {
> > > > > > > > > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > > > > > > > > +	int ret =3D 0;
> > > > > > > > > > +
> > > > > > > > > > +	wave5_vpu_sleep_wake(dev, false, NULL, 0);
> > > > > > > > > > +	ret =3D clk_bulk_prepare_enable(vpu->num_clks, vpu-
> > > > clks);
> > > > > > > > > > +	if (ret) {
> > > > > > > > > > +		dev_err(dev, "Enabling clocks, fail: %d\n",
> > > ret);
> > > > > > > > > > +		return ret;
> > > > > > > > > > +	}
> > > > > > > > > > +
> > > > > > > > > > +	return ret;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > > +static __maybe_unused int wave5_suspend(struct device
> > > > > > > > > > +*dev)
> > > {
> > > > > > > > > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > > > > > > > > +	struct vpu_instance *inst;
> > > > > > > > > > +
> > > > > > > > > > +	list_for_each_entry(inst, &vpu->instances, list)
> > > > > > > > > > +		v4l2_m2m_suspend(inst->v4l2_m2m_dev);
> > > > > > > > > > +
> > > > > > > > > > +	return pm_runtime_force_suspend(dev); }
> > > > > > > > > > +
> > > > > > > > > > +static __maybe_unused int wave5_resume(struct device
> > > > > > > > > > +*dev)
> > > {
> > > > > > > > > > +	struct vpu_device *vpu =3D dev_get_drvdata(dev);
> > > > > > > > > > +	struct vpu_instance *inst;
> > > > > > > > > > +	int ret =3D 0;
> > > > > > > > > > +
> > > > > > > > > > +	ret =3D pm_runtime_force_resume(dev);
> > > > > > > > > > +	if (ret < 0)
> > > > > > > > > > +		return ret;
> > > > > > > > > > +
> > > > > > > > > > +	list_for_each_entry(inst, &vpu->instances, list)
> > > > > > > > > > +		v4l2_m2m_resume(inst->v4l2_m2m_dev);
> > > > > > > > > > +
> > > > > > > > > > +	return ret;
> > > > > > > > > > +}
> > > > > > > > >=20
> > > > > > > > > The functions wave5_suspend() and wave5_resume() are not
> > > > > > > > > just "maybe_unsued" but actually never used. What was the
> > > intention ?
> > > > > > > > > Considering the usage of __maybe_unused has been such a
> > > > > > > > > bad friend for this one, could you instead bracket the
> > > > > > > > > functions with an
> > > > > > > explicit ?
> > > > > > > > >=20
> > > > > > > > > #ifdef CONFIG_PM
> > > > > > > > > #endif
> > > > > > > > >=20
> > > > > > > > > This way the compiler will have a word if you implement
> > > > > > > > > something that you forgot to actually use.
> > > > > > > > >=20
> > > > > > > > > > +
> > > > > > > > > > +static const struct dev_pm_ops wave5_pm_ops =3D {
> > > > > > > > > > +	SET_RUNTIME_PM_OPS(wave5_pm_suspend, wave5_pm_resume,
> > > > > > > NULL) };
> > > > > > > > > > +
> > > > > > > > > > =C2=A0static int wave5_vpu_probe(struct platform_device=
 *pdev)
> > {
> > > > > > > > > > =C2=A0	int ret;
> > > > > > > > > > @@ -232,6 +292,10 @@ static int wave5_vpu_probe(struct
> > > > > > > > > > platform_device
> > > > > > > > > *pdev)
> > > > > > > > > > =C2=A0		 (match_data->flags & WAVE5_IS_DEC) ?
> > > "'DECODE'" : "");
> > > > > > > > > > =C2=A0	dev_info(&pdev->dev, "Product Code:      0x%x\n"=
, dev-
> > > > > > > > product_code);
> > > > > > > > > > =C2=A0	dev_info(&pdev->dev, "Firmware Revision: %u\n",
> > > > > > > > > > fw_revision);
> > > > > > > > > > +
> > > > > > > > > > +	pm_runtime_enable(&pdev->dev);
> > > > > > > > > > +	wave5_vpu_sleep_wake(&pdev->dev, true, NULL, 0);
> > > > > > > > > > +
> > > > > > > > > > =C2=A0	return 0;
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0err_enc_unreg:
> > > > > > > > > > @@ -254,6 +318,9 @@ static int wave5_vpu_remove(struct
> > > > > > > > > > platform_device
> > > > > > > > > > *pdev)  {
> > > > > > > > > > =C2=A0	struct vpu_device *dev =3D dev_get_drvdata(&pdev=
->dev);
> > > > > > > > > >=20
> > > > > > > > > > +	pm_runtime_put_sync(&pdev->dev);
> > > > > > > > > > +	pm_runtime_disable(&pdev->dev);
> > > > > > > > > > +
> > > > > > > > > > =C2=A0	mutex_destroy(&dev->dev_lock);
> > > > > > > > > > =C2=A0	mutex_destroy(&dev->hw_lock);
> > > > > > > > > > =C2=A0	clk_bulk_disable_unprepare(dev->num_clks, dev->c=
lks);
> > > @@
> > > > > > > > > > -
> > > > > > > 281,6
> > > > > > > > > > +348,7 @@ static struct platform_driver wave5_vpu_drive=
r
> > > > > > > > > > +=3D {
> > > > > > > > > > =C2=A0	.driver =3D {
> > > > > > > > > > =C2=A0		.name =3D VPU_PLATFORM_DEVICE_NAME,
> > > > > > > > > > =C2=A0		.of_match_table =3D of_match_ptr(wave5_dt_ids),
> > > > > > > > > > +		.pm =3D &wave5_pm_ops,
> > > > > > > > > > =C2=A0		},
> > > > > > > > > > =C2=A0	.probe =3D wave5_vpu_probe,
> > > > > > > > > > =C2=A0	.remove =3D wave5_vpu_remove, diff --git
> > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vpuapi=
.
> > > > > > > > > > c
> > > > > > > > > > b/drivers/media/platform/chips-media/wave5/wave5-vpuapi=
.
> > > > > > > > > > c index 1a3efb638dde..f1f8e4fc8474 100644
> > > > > > > > > > ---
> > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5-vpuapi=
.
> > > > > > > > > > c
> > > > > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vp=
u
> > > > > > > > > > +++ ap
> > > > > > > > > > +++ i.c
> > > > > > > > > > @@ -6,6 +6,7 @@
> > > > > > > > > > =C2=A0=C2=A0*/
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0#include <linux/bug.h>
> > > > > > > > > > +#include <linux/pm_runtime.h>
> > > > > > > > > > =C2=A0#include "wave5-vpuapi.h"
> > > > > > > > > > =C2=A0#include "wave5-regdefine.h"
> > > > > > > > > > =C2=A0#include "wave5.h"
> > > > > > > > > > @@ -232,6 +233,9 @@ int wave5_vpu_dec_close(struct
> > > > > > > > > > vpu_instance *inst,
> > > > > > > > > > u32 *fail_res)
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0	wave5_vdi_free_dma_memory(vpu_dev,
> > > > > > > > > > &p_dec_info->vb_task);
> > > > > > > > > >=20
> > > > > > > > > > +	if (!pm_runtime_suspended(inst->dev->dev))
> > > > > > > > > > +		pm_runtime_put_sync(inst->dev->dev);
> > > > > > > > > > +
> > > > > > > > > > =C2=A0unlock_and_return:
> > > > > > > > > > =C2=A0	mutex_unlock(&vpu_dev->hw_lock);
> > > > > > > > > >=20
> > > > > > > > > > @@ -734,6 +738,9 @@ int wave5_vpu_enc_close(struct
> > > > > > > > > > vpu_instance *inst,
> > > > > > > > > > u32 *fail_res)
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0	wave5_vdi_free_dma_memory(vpu_dev,
> > > > > > > > > > &p_enc_info->vb_task);
> > > > > > > > > >=20
> > > > > > > > > > +	if (!pm_runtime_suspended(inst->dev->dev))
> > > > > > > > > > +		pm_runtime_put_sync(inst->dev->dev);
> > > > > > > > >=20
> > > > > > > > > This seems very unnatural. We do the get() in
> > > > > > > > > "start_streaming()", but the
> > > > > > > > > put() is only done when the device is closed, or when the
> > > > > > > > > driver is removed. As this is not balanced, you seem to
> > > > > > > > > have to check the suspended condition all over the place.
> > > > > > > > >=20
> > > > > > > > > I think we could aim for
> > > > > > > > > start_streaming()/stop_streaming()
> > > > > > > > > for your get/put placement. At least they will be bound t=
o
> > > > > > > > > an entirely balanced
> > > > > > > API.
> > > > > > > > > But then, a media player in paused sate will prevent that
> > > > > > > > > device from being suspended.
> > > > > > > > >=20
> > > > > > > > > If the HW is capable of preserving enough state, and From
> > > > > > > > > the short doc I have it gives me the impression it can
> > > > > > > > > preserve that, I'd suggest to follow what hantro driver i=
s
> > > > > > > > > doing. What is does is that it will do get() in
> > > > > > > > > device_run(), and put() whenever the job completes. This
> > > > > > > > > driver has been designed so when there is no job, it mean=
s
> > > > > > > > > the firmware is currently idle and looking for more work.
> > > > > > > > > So it seems like the perfect moment to
> > > > > do suspend it.
> > > > > > > > >=20
> > > > > > > > > Nicolas
> > > > > > > > >=20
> > > > > > > > > > +
> > > > > > > > > > =C2=A0	mutex_unlock(&vpu_dev->hw_lock);
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0	return 0;
> > > > > > > > > > diff --git
> > > > > > > > > > a/drivers/media/platform/chips-media/wave5/wave5.h
> > > > > > > > > > b/drivers/media/platform/chips-media/wave5/wave5.h
> > > > > > > > > > index 063028eccd3b..6125eff938a8 100644
> > > > > > > > > > --- a/drivers/media/platform/chips-media/wave5/wave5.h
> > > > > > > > > > +++ b/drivers/media/platform/chips-media/wave5/wave5.h
> > > > > > > > > > @@ -56,6 +56,9 @@ int wave5_vpu_get_version(struct
> > > > > > > > > > vpu_device *vpu_dev, u32 *revision);
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0int wave5_vpu_init(struct device *dev, u8 *fw, si=
ze_t
> > > > > > > > > > size);
> > > > > > > > > >=20
> > > > > > > > > > +int wave5_vpu_sleep_wake(struct device *dev, bool
> > > > > > > > > > +i_sleep_wake, const
> > > > > > > > > uint16_t *code,
> > > > > > > > > > +			 size_t size);
> > > > > > > > > > +
> > > > > > > > > > =C2=A0int wave5_vpu_reset(struct device *dev, enum
> > > > > > > > > > sw_reset_mode reset_mode);
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0int wave5_vpu_build_up_dec_param(struct vpu_insta=
nce
> > > > > > > > > > *inst, struct dec_open_param *param);
> > > > > > > >=20
> > > > > >=20
> > > >=20
>=20


