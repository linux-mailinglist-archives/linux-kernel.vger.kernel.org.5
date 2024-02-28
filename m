Return-Path: <linux-kernel+bounces-85388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB21286B547
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5691C21A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EAA200C4;
	Wed, 28 Feb 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mwa7/10j"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43C1E88D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138877; cv=none; b=EReo5JhN+Iw1YTPJc3JemvEIofqfva786r2QUJw6yQzAGaJd5r4B9L/2wfsiU5zgQjK0ZLs2n02ZC11q1rzCWnItlWnguO/mF5/J4brFfFCTlGrydtc335gjVDS8li8lItlb/1ZBWt/xoMNLF9eCYjn95VzJJEXWpwtu6wkEAks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138877; c=relaxed/simple;
	bh=In3p83V6zrI+MWpNKueg5JQ5LR0pNF8Pef8UBUpES94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4jjsZ/lAn0Lknlxoc+lzEldcRRlj/FAyw7vNwUqNahk1L8Nk0GycrV2HkQ0DRZR3z50nUWwKX6Ky07FGX9s2vr8GdxwBkQAMR3nyzcCRcWl9Z1qfy9MvFcZwMebHebWz2RH0X/VpxOVe4czYyJvbLRUwGY+++OQnvqgB4s9xEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mwa7/10j; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so1826887a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709138873; x=1709743673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=In3p83V6zrI+MWpNKueg5JQ5LR0pNF8Pef8UBUpES94=;
        b=mwa7/10jUd8QtamzcmUAxktE6U4MesfDF8vfbkcbUe4oTjk7vruXl0xVgnUg/LfLRP
         6UE/lUCJzhh7k/fnArGEV4EWSgV+9lZJTQ2MyqtBLlfL4E9KNw4A0NHeFCscyP9uo8aV
         kYZnKcjWh6uazSdu/Rf8e9kie/PhJSyKdq2PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138873; x=1709743673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=In3p83V6zrI+MWpNKueg5JQ5LR0pNF8Pef8UBUpES94=;
        b=ihP5HvHEZhBJGdLon2pY6aGy0BCFJEMnqawr0O+NFeN9p51DYWSVfd9N1C/z0Eb8E9
         I5bpQ6wSPcT/qKtL2CA+w72n92G5z5/TdSTqicQDAsZcbpGOpvnA7cFInVO6Oqr1e2/g
         +CNkX/bRyhc5ImZB34t57ZP1oA09eiqspnLzss3UxsD9aSAvfGHqRqtn1/c27SQVxMV6
         zyS7jlIr1YSILErrGxtCAXF2dCpuEuTb1aXPnzcZAtoEh81o21daU1obTQ47Re7h1zuU
         0Hn+yHQDtqAeG8bENbsJLRWrIq2U4tjQJJzbm1LquugmjbgcPVv70QD4V7JOT5D4+D3J
         EkBA==
X-Forwarded-Encrypted: i=1; AJvYcCWbeuoH95WMHHifyrLE/taI3QZmXbigi4r49YJ3YquUwO68XcJbT2qw9vW0SN+IIVe2FgWqO6iMQP5ZiLDg1T6+w4oO/hVObIfx/X+k
X-Gm-Message-State: AOJu0YyVrvw3qjbGLOFv3b8rR9iLTFpcWDqJz+qAmamfdr+ngoagslnn
	NcsuWm81E5wqBdz1QinaJE5kfAqcYQXoxk1zhHdobClLFgReXEqi82oBlEYfeneP/byJOQfHl7h
	AFcGv
X-Google-Smtp-Source: AGHT+IEb0jmeuKlIyydEIuVRHo7PG91jz0usMWvhTmOKF6SZADjQyjeZJHInFIti9Y8bKfBU91hHfQ==
X-Received: by 2002:a05:6402:e94:b0:566:59f5:26db with SMTP id h20-20020a0564020e9400b0056659f526dbmr8652eda.11.1709138873512;
        Wed, 28 Feb 2024 08:47:53 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id da25-20020a056402177900b00566194247desm1939683edb.59.2024.02.28.08.47.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:47:53 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5664623c311so13541a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:47:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTBz+B/H02DL2IB7L0kPaQOL+EjkH3of0fvFE8nZgS2EmmOhjkGPtX0Fvks2AhEUWhCzsRtfRgpKi7QJN4JCI3yVHy7kRKp73E4kiS
X-Received: by 2002:a05:600c:1e24:b0:412:acde:4839 with SMTP id
 ay36-20020a05600c1e2400b00412acde4839mr68722wmb.3.1709138438231; Wed, 28 Feb
 2024 08:40:38 -0800 (PST)
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
 <cbcd981f-bd5d-477e-8482-d3414be17057@linaro.org>
In-Reply-To: <cbcd981f-bd5d-477e-8482-d3414be17057@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Feb 2024 08:40:22 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UtpL=Wy7jnUFkTF8WtMjWa3ZfJXsXDX=Q=j6o_6rd4AQ@mail.gmail.com>
Message-ID: <CAD=FV=UtpL=Wy7jnUFkTF8WtMjWa3ZfJXsXDX=Q=j6o_6rd4AQ@mail.gmail.com>
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

Neil,

On Thu, Feb 15, 2024 at 8:53=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Hi Doug,
>
> On 15/02/2024 16:08, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Feb 15, 2024 at 2:24=E2=80=AFAM Jani Nikula <jani.nikula@intel.=
com> wrote:
> >>
> >> On Wed, 14 Feb 2024, Doug Anderson <dianders@chromium.org> wrote:
> >>> Hi,
> >>>
> >>> On Tue, Feb 13, 2024 at 10:25=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromiu=
m.org> wrote:
> >>>>
> >>>> On Wed, Feb 14, 2024 at 2:23=E2=80=AFPM Douglas Anderson <dianders@c=
hromium.org> wrote:
> >>>>>
> >>>>> If an eDP panel is not powered on then any attempts to talk to it o=
ver
> >>>>> the DP AUX channel will timeout. Unfortunately these attempts may b=
e
> >>>>> quite slow. Userspace can initiate these attempts either via a
> >>>>> /dev/drm_dp_auxN device or via the created i2c device.
> >>>>>
> >>>>> Making the DP AUX drivers timeout faster is a difficult proposition=
.
> >>>>> In theory we could just poll the panel's HPD line in the AUX transf=
er
> >>>>> function and immediately return an error there. However, this is
> >>>>> easier said than done. For one thing, there's no hard requirement t=
o
> >>>>> hook the HPD line up for eDP panels and it's OK to just delay a fix=
ed
> >>>>> amount. For another thing, the HPD line may not be fast to probe. O=
n
> >>>>> parade-ps8640 we need to wait for the bridge chip's firmware to boo=
t
> >>>>> before we can get the HPD line and this is a slow process.
> >>>>>
> >>>>> The fact that the transfers are taking so long to timeout is causin=
g
> >>>>> real problems. The open source fwupd daemon sometimes scans DP buss=
es
> >>>>> looking for devices whose firmware need updating. If it happens to
> >>>>> scan while a panel is turned off this scan can take a long time. Th=
e
> >>>>> fwupd daemon could try to be smarter and only scan when eDP panels =
are
> >>>>> turned on, but we can also improve the behavior in the kernel.
> >>>>>
> >>>>> Let's let eDP panels drivers specify that a panel is turned off and
> >>>>> then modify the common AUX transfer code not to attempt a transfer =
in
> >>>>> this case.
> >>>>>
> >>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>>>> ---
> >>>>
> >>>> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >>>
> >>> Thanks for the review!
> >>>
> >>> Given that this touches core DRM code and that I never got
> >>> confirmation that Jani's concerns were addressed with my previous
> >>> response, I'm still going to wait a little while before applying. I'm
> >>> on vacation for most of next week, but if there are no further replie=
s
> >>> between now and then I'll plan to apply this to "drm-misc-next" the
> >>> week of Feb 26th. If someone else wants to apply this before I do the=
n
> >>> I certainly won't object. Jani: if you feel this needs more discussio=
n
> >>> or otherwise object to this patch landing then please yell. Likewise
> >>> if anyone else in the community wants to throw in their opinion, feel
> >>> free.
> >>
> >> Sorry for dropping the ball after my initial response. I simply have n=
ot
> >> had the time to look into this.
> >>
> >> It would be great to get, say, drm-misc maintainer ack on this before
> >> merging. It's not fair for me to stall this any longer, I'll trust the=
ir
> >> judgement.
> >>
> >> Reasonable?
> >
> > I'd be more than happy for one of the drm-misc maintainers to Ack.
> > I'll move Maxime, Thomas, and Maarten to the "To:" line to see if that
> > helps get through their filters.
>
> I'll like some test reports to be sure it doesn't break anything,
> then I'll be happy to give my ack !

Are you looking for any more test reports at this point? Eizan did
some testing and provided a tag, though this was also on ChromeOS.
Steev also tested on two non-ChromeOS environments and provided his
tag. It's also been another two weeks of this being rolled out to some
Chromebook users and I haven't heard any reports of problems. If
somehow something was missed, I'm happy to follow-up and provide
additional fixes if some report comes in later.

Thanks!

-Doug

