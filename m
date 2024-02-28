Return-Path: <linux-kernel+bounces-85685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E63786B941
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E431C2314B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3095415E5CE;
	Wed, 28 Feb 2024 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LibtN70t"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C46D15DBBB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709153314; cv=none; b=fNxLEibpW33+J1Ykm2XWe2Vmc71JKdnHSGkvNKIDCYFBFbqx73ckOEcFCZUgtFUkb9xiLlQuO+pl9GAIE/Ly/kn9wsmQj7FYmS1gKOaAK8tufuBvVSwIlLSlQOTftkQUYiiWMjY1XdYAamjXvBqinEY9JwKtCCGt8pkPq1BoeXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709153314; c=relaxed/simple;
	bh=j7yv2aZOYPyxqiCW7SC4YeHXcQrFeT9++J/3vRdLw6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDAO/q9bI901HIciTn/hDfcxeW0kaRVEUtqALx1vQcbZy/L0ONjjInUckhVEhkiVF5mLuqVH0QYxpETL3KlijolexlH9FFNmvxu6dEE3gHdDAJdVcPXut5A6LTPIZfG+wq9upemhTkg97RfSx63u7+ng9Qhdehoho79LVRiHEzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LibtN70t; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so320126a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709153307; x=1709758107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7yv2aZOYPyxqiCW7SC4YeHXcQrFeT9++J/3vRdLw6I=;
        b=LibtN70tuJeuLmSqDky4HPmoDXrM7LtFWmWLHig8jIBi/eu6jJdCsGt6ymc6uiZGTJ
         DKO8K2PXMimiihifqNTXeMzCD7lafZOj05mIad3Ril/uKK3b57XUP6/laKA74BYoay+3
         FCtiHCHq1eJFakugvleGcQDk2qfQz/9Gxh1tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709153307; x=1709758107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7yv2aZOYPyxqiCW7SC4YeHXcQrFeT9++J/3vRdLw6I=;
        b=K1en2PfXFpy/Lh7SEk7ge+fc4jk//ngEcNn15AV2CqBV/P5jQ7iqsBvY2Kaauhcdx0
         c6B72OCJKT8vSzhTBq5Lai0Q/OQRMg3CAOkxQAtV56QXo64OROEWaCnBSCmGsFGnvZrE
         EhsRrQUiu4bk9DsLrHxlLA9iAx86nRIVTCZWvRPmRXYOhn3VG7zk43ee+kG56yKYT5GF
         SlDaO468P1ZP42Jer5upxkf+0ci0ZylA3158niinUkA84F98EnQPDe35RGwNKzYFI0do
         743bG0Ic6Xuex6DdKLUmRYmcG8dDuR16Wxd3cppkGq7jV5kDVD99C1XO+2iqurxj446m
         HRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWygt/3Hohh50y/NfGpk0rXBPywOhbHpuBXi9XwE/oq9Mnqdcpa8ET7ztoPC/3q4ydhNrsFMsMmoKDj4mfFWwRiOCkMHXgIxzl40Lhg
X-Gm-Message-State: AOJu0Yx6b0cImqC/z/Qmzr8NyLEP1Yi7QTplnx+b40TIRLmBhteEcbGR
	NMM8ziPYdv5W5x4hOJQfg6C8nAQXRrPay1o3C8OFl4X4eeZ8RGd3hOUgB1CrnZU0W8MEo8efKXi
	fhkBm
X-Google-Smtp-Source: AGHT+IFidFyeCm2I/z7QiF+5wcQDRe33dbXNQoRK0k9FrT/UklgHWJXFQwOdtXhRNr8Qpm7whS7PsA==
X-Received: by 2002:a17:906:3e0d:b0:a3f:4eaf:ec66 with SMTP id k13-20020a1709063e0d00b00a3f4eafec66mr69505eji.25.1709153307545;
        Wed, 28 Feb 2024 12:48:27 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id vu5-20020a170907a64500b00a442124bd2dsm440286ejc.37.2024.02.28.12.48.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 12:48:27 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4129a748420so20055e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:48:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXsbw5O6oReaON/97WU/lHAQfAbkfhE/NLC0dAhh0FbYRPcC37ZwWUt5PdBYZZblvIX9rXbP5s9ncMaHlIiadloYgB7kk8a+j33yl4r
X-Received: by 2002:a05:600c:b99:b0:412:a37b:4171 with SMTP id
 fl25-20020a05600c0b9900b00412a37b4171mr134980wmb.4.1709153305657; Wed, 28 Feb
 2024 12:48:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202141109.1.I24277520ac754ea538c9b14578edc94e1df11b48@changeid>
 <CAJMQK-it9YMod4rHKnACq4O-iaGieK2SN4x5vQ018CghsA631A@mail.gmail.com>
 <CAD=FV=VfuFrK1cSKA0maMzT5dxzKEzADqrd69fZKXuAGrU2rmA@mail.gmail.com>
 <87sf1u58k0.fsf@intel.com> <CAD=FV=XQdLm3PcjEd_g_dBJ9QO8zAJtj5nrXS9=cjC80+-Jbfg@mail.gmail.com>
 <cbcd981f-bd5d-477e-8482-d3414be17057@linaro.org> <CAD=FV=UtpL=Wy7jnUFkTF8WtMjWa3ZfJXsXDX=Q=j6o_6rd4AQ@mail.gmail.com>
 <b4266102-3354-4d4a-8368-c143b12dbead@linaro.org>
In-Reply-To: <b4266102-3354-4d4a-8368-c143b12dbead@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Feb 2024 12:48:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VQvC+JxVgtm=w8jFf+_caUoH=6QsKdfP5zzDFwORgC-Q@mail.gmail.com>
Message-ID: <CAD=FV=VQvC+JxVgtm=w8jFf+_caUoH=6QsKdfP5zzDFwORgC-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are
 not powered
To: neil.armstrong@linaro.org
Cc: Jani Nikula <jani.nikula@intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org, eizan@chromium.org, 
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Imre Deak <imre.deak@intel.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2024 at 8:52=E2=80=AFAM <neil.armstrong@linaro.org> wrote:
>
> On 28/02/2024 17:40, Doug Anderson wrote:
> > Neil,
> >
> > On Thu, Feb 15, 2024 at 8:53=E2=80=AFAM Neil Armstrong
> > <neil.armstrong@linaro.org> wrote:
> >>
> >> Hi Doug,
> >>
> >> On 15/02/2024 16:08, Doug Anderson wrote:
> >>> Hi,
> >>>
> >>> On Thu, Feb 15, 2024 at 2:24=E2=80=AFAM Jani Nikula <jani.nikula@inte=
l.com> wrote:
> >>>>
> >>>> On Wed, 14 Feb 2024, Doug Anderson <dianders@chromium.org> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On Tue, Feb 13, 2024 at 10:25=E2=80=AFPM Hsin-Yi Wang <hsinyi@chrom=
ium.org> wrote:
> >>>>>>
> >>>>>> On Wed, Feb 14, 2024 at 2:23=E2=80=AFPM Douglas Anderson <dianders=
@chromium.org> wrote:
> >>>>>>>
> >>>>>>> If an eDP panel is not powered on then any attempts to talk to it=
 over
> >>>>>>> the DP AUX channel will timeout. Unfortunately these attempts may=
 be
> >>>>>>> quite slow. Userspace can initiate these attempts either via a
> >>>>>>> /dev/drm_dp_auxN device or via the created i2c device.
> >>>>>>>
> >>>>>>> Making the DP AUX drivers timeout faster is a difficult propositi=
on.
> >>>>>>> In theory we could just poll the panel's HPD line in the AUX tran=
sfer
> >>>>>>> function and immediately return an error there. However, this is
> >>>>>>> easier said than done. For one thing, there's no hard requirement=
 to
> >>>>>>> hook the HPD line up for eDP panels and it's OK to just delay a f=
ixed
> >>>>>>> amount. For another thing, the HPD line may not be fast to probe.=
 On
> >>>>>>> parade-ps8640 we need to wait for the bridge chip's firmware to b=
oot
> >>>>>>> before we can get the HPD line and this is a slow process.
> >>>>>>>
> >>>>>>> The fact that the transfers are taking so long to timeout is caus=
ing
> >>>>>>> real problems. The open source fwupd daemon sometimes scans DP bu=
sses
> >>>>>>> looking for devices whose firmware need updating. If it happens t=
o
> >>>>>>> scan while a panel is turned off this scan can take a long time. =
The
> >>>>>>> fwupd daemon could try to be smarter and only scan when eDP panel=
s are
> >>>>>>> turned on, but we can also improve the behavior in the kernel.
> >>>>>>>
> >>>>>>> Let's let eDP panels drivers specify that a panel is turned off a=
nd
> >>>>>>> then modify the common AUX transfer code not to attempt a transfe=
r in
> >>>>>>> this case.
> >>>>>>>
> >>>>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>>>>>> ---
> >>>>>>
> >>>>>> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >>>>>
> >>>>> Thanks for the review!
> >>>>>
> >>>>> Given that this touches core DRM code and that I never got
> >>>>> confirmation that Jani's concerns were addressed with my previous
> >>>>> response, I'm still going to wait a little while before applying. I=
'm
> >>>>> on vacation for most of next week, but if there are no further repl=
ies
> >>>>> between now and then I'll plan to apply this to "drm-misc-next" the
> >>>>> week of Feb 26th. If someone else wants to apply this before I do t=
hen
> >>>>> I certainly won't object. Jani: if you feel this needs more discuss=
ion
> >>>>> or otherwise object to this patch landing then please yell. Likewis=
e
> >>>>> if anyone else in the community wants to throw in their opinion, fe=
el
> >>>>> free.
> >>>>
> >>>> Sorry for dropping the ball after my initial response. I simply have=
 not
> >>>> had the time to look into this.
> >>>>
> >>>> It would be great to get, say, drm-misc maintainer ack on this befor=
e
> >>>> merging. It's not fair for me to stall this any longer, I'll trust t=
heir
> >>>> judgement.
> >>>>
> >>>> Reasonable?
> >>>
> >>> I'd be more than happy for one of the drm-misc maintainers to Ack.
> >>> I'll move Maxime, Thomas, and Maarten to the "To:" line to see if tha=
t
> >>> helps get through their filters.
> >>
> >> I'll like some test reports to be sure it doesn't break anything,
> >> then I'll be happy to give my ack !
> >
> > Are you looking for any more test reports at this point? Eizan did
> > some testing and provided a tag, though this was also on ChromeOS.
> > Steev also tested on two non-ChromeOS environments and provided his
> > tag. It's also been another two weeks of this being rolled out to some
> > Chromebook users and I haven't heard any reports of problems. If
> > somehow something was missed, I'm happy to follow-up and provide
> > additional fixes if some report comes in later.
>
> Sure, thx I think you can apply it now
>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Pushed to drm-misc-next.

8df1ddb5bf11 drm/dp: Don't attempt AUX transfers when eDP panels are not po=
wered

