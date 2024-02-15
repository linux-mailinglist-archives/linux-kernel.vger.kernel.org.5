Return-Path: <linux-kernel+bounces-67140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B2C8566EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC1D1F22EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486E0132C2B;
	Thu, 15 Feb 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ENW0g4RQ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70965132C12
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009754; cv=none; b=Qhk48zSqVIgN6cBOV1nGeacQ2ok+pQgHdjxS6pEviEb4DxT59pJoTZXKLnOD63BvcEmX/rKgauXoGsBjmgAB2duMJOutapMLUNybeyco9VB1EDFqPJCZsEhuxNuHZJRglHZzbZzN/lsdXR1Jb1J06opKGFD6MEc1WZ0jiiVI41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009754; c=relaxed/simple;
	bh=0S6qo+pjG4pQkQLOFKm/LBtGD/HT4X70qfMEKBvwsD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lS0zTk290i5d07p03qV5UH7QJhpglFh7PX5q7kGLgF8tFWZ09AHS9npn1tEXR8CKOozlmq9iaR+lG2NuOlb4p22pmxSyhJtjsdoVReMKoVQ8ompuC02qJ4fIu33NBxPH2GVIgiNIAB25MErOE7VooVfWRWpwptud8CofR3xPEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ENW0g4RQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a30e445602cso395285566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708009748; x=1708614548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0S6qo+pjG4pQkQLOFKm/LBtGD/HT4X70qfMEKBvwsD8=;
        b=ENW0g4RQ45LX5Fi4qi4qGMO24qPIVy6hMAGCrQUIZU40OfagbIQnzeHvwVJ1ddvfT8
         yil41dwctrF0NY1vwKzMBZ/mZww/nOxHRdPrb5ruTiHMcF4FgV9I4b71n1YBepz1k+ZE
         j4K8qimh3p89hLieOtG3xirHX9UqY8rYAt51A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708009748; x=1708614548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0S6qo+pjG4pQkQLOFKm/LBtGD/HT4X70qfMEKBvwsD8=;
        b=K4CLwIs/h6Xd5m35a3eQe7mBxjfNBuzRxVHlvHHaC3ircrxaldQJAMuZI5ZSQ3dVYu
         IQKwz7JNSgr3//EjJQ70FpU/QBR6lS6bEGXD5z3RO3yMWkzBMLd9CXQpQvEW01T91jHe
         GUEfleUcuk7+dWK+qOhQyZVTrlCoCCsxmogruWQPh3Bh/3c4iiNBJPyZLqRGRvZdGCj+
         Ke56IH5aoCKWKmDB1JrGIQ8Url3r7UiKnQvvyC0q7Yhiwe7O7WdHCpVzIH2tTCxwacPV
         9raS54fmHF1v3QYV33uaa4p+dJ8E7ge4N1OWoTsWjS6gMOkgQseM8Oa8Z92Vxvct2ihK
         ZchA==
X-Forwarded-Encrypted: i=1; AJvYcCUFjTdzun104gFTm3v2jlE4+BempMdrKF6JmHclPv69v34tsfw9GdW7iSVdzxqHPH/S+8Yrq6uGJAoLOKFtTk4oVOhEMTtw/b8p0aE3
X-Gm-Message-State: AOJu0YycF5jsgVHXvuqPjN/veCG3Z32ty6mXtjXJML2hgse6e+RTPUr+
	7c4FGdnJF8uRTQtaxOzdqfWEf0O4cIUqVXMNA4sVrGFz8xRm54ooQhAAjTN+AjqpQfoUlOQf9Sp
	IpqMw
X-Google-Smtp-Source: AGHT+IGo48CpxHMzHrIoKHKAxtqm/ncbOvoCkWoTCaX67/zurTc/By4CWPfvAGPTIO8QItO3geFFRA==
X-Received: by 2002:a17:906:bc4e:b0:a3c:a545:5fd8 with SMTP id s14-20020a170906bc4e00b00a3ca5455fd8mr2027429ejv.26.1708009747742;
        Thu, 15 Feb 2024 07:09:07 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id sn24-20020a170906629800b00a38a705121csm643194ejc.47.2024.02.15.07.09.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 07:09:05 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso9493a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:09:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXj/q/FKj68MKf7rlwibtLJFh9Y/YkwnWf9OZQscCS6W/n5AYKDnFTGGHj6Wa3DVeSvqbgiRAwW+1F+O2uFhRqtcunwENtEcNHVOIL7
X-Received: by 2002:a05:6402:128c:b0:562:a438:47ff with SMTP id
 w12-20020a056402128c00b00562a43847ffmr389580edv.6.1708009744921; Thu, 15 Feb
 2024 07:09:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202141109.1.I24277520ac754ea538c9b14578edc94e1df11b48@changeid>
 <CAJMQK-it9YMod4rHKnACq4O-iaGieK2SN4x5vQ018CghsA631A@mail.gmail.com>
 <CAD=FV=VfuFrK1cSKA0maMzT5dxzKEzADqrd69fZKXuAGrU2rmA@mail.gmail.com> <87sf1u58k0.fsf@intel.com>
In-Reply-To: <87sf1u58k0.fsf@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 15 Feb 2024 07:08:49 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XQdLm3PcjEd_g_dBJ9QO8zAJtj5nrXS9=cjC80+-Jbfg@mail.gmail.com>
Message-ID: <CAD=FV=XQdLm3PcjEd_g_dBJ9QO8zAJtj5nrXS9=cjC80+-Jbfg@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Don't attempt AUX transfers when eDP panels are
 not powered
To: Jani Nikula <jani.nikula@intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, dri-devel@lists.freedesktop.org, 
	eizan@chromium.org, Ankit Nautiyal <ankit.k.nautiyal@intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Imre Deak <imre.deak@intel.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 15, 2024 at 2:24=E2=80=AFAM Jani Nikula <jani.nikula@intel.com>=
 wrote:
>
> On Wed, 14 Feb 2024, Doug Anderson <dianders@chromium.org> wrote:
> > Hi,
> >
> > On Tue, Feb 13, 2024 at 10:25=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.=
org> wrote:
> >>
> >> On Wed, Feb 14, 2024 at 2:23=E2=80=AFPM Douglas Anderson <dianders@chr=
omium.org> wrote:
> >> >
> >> > If an eDP panel is not powered on then any attempts to talk to it ov=
er
> >> > the DP AUX channel will timeout. Unfortunately these attempts may be
> >> > quite slow. Userspace can initiate these attempts either via a
> >> > /dev/drm_dp_auxN device or via the created i2c device.
> >> >
> >> > Making the DP AUX drivers timeout faster is a difficult proposition.
> >> > In theory we could just poll the panel's HPD line in the AUX transfe=
r
> >> > function and immediately return an error there. However, this is
> >> > easier said than done. For one thing, there's no hard requirement to
> >> > hook the HPD line up for eDP panels and it's OK to just delay a fixe=
d
> >> > amount. For another thing, the HPD line may not be fast to probe. On
> >> > parade-ps8640 we need to wait for the bridge chip's firmware to boot
> >> > before we can get the HPD line and this is a slow process.
> >> >
> >> > The fact that the transfers are taking so long to timeout is causing
> >> > real problems. The open source fwupd daemon sometimes scans DP busse=
s
> >> > looking for devices whose firmware need updating. If it happens to
> >> > scan while a panel is turned off this scan can take a long time. The
> >> > fwupd daemon could try to be smarter and only scan when eDP panels a=
re
> >> > turned on, but we can also improve the behavior in the kernel.
> >> >
> >> > Let's let eDP panels drivers specify that a panel is turned off and
> >> > then modify the common AUX transfer code not to attempt a transfer i=
n
> >> > this case.
> >> >
> >> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> > ---
> >>
> >> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >
> > Thanks for the review!
> >
> > Given that this touches core DRM code and that I never got
> > confirmation that Jani's concerns were addressed with my previous
> > response, I'm still going to wait a little while before applying. I'm
> > on vacation for most of next week, but if there are no further replies
> > between now and then I'll plan to apply this to "drm-misc-next" the
> > week of Feb 26th. If someone else wants to apply this before I do then
> > I certainly won't object. Jani: if you feel this needs more discussion
> > or otherwise object to this patch landing then please yell. Likewise
> > if anyone else in the community wants to throw in their opinion, feel
> > free.
>
> Sorry for dropping the ball after my initial response. I simply have not
> had the time to look into this.
>
> It would be great to get, say, drm-misc maintainer ack on this before
> merging. It's not fair for me to stall this any longer, I'll trust their
> judgement.
>
> Reasonable?

I'd be more than happy for one of the drm-misc maintainers to Ack.
I'll move Maxime, Thomas, and Maarten to the "To:" line to see if that
helps get through their filters.

-Doug

