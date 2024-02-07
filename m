Return-Path: <linux-kernel+bounces-56432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD084CA19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF621F239EC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0843659B4C;
	Wed,  7 Feb 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4z9BGUg"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8B59176
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307251; cv=none; b=F6UN0SqOXweVhTSfeS0R9Il/brVbWRORoz1SrMxwIrphsaj1Erw17Hn8MjqC4Wv8vciPWTsDzlQPKRBxIelTpgl/z6GoB2sgesP9Q8fRMmZ9A/lsl03K7ZdyYw42PHRdGdNRnAdoZfSwGxDMjc8qQxx71Rk4cYzS4MO/Z9YkjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307251; c=relaxed/simple;
	bh=oKkNLcPW+HWvM4UDBNrhlNV/3Cdnn3H7J3MtElNAl28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcxFIWQuQr1NSZsidAnjh+1CjDgJD2nfvECNVWmON/YRNFJb/z1J8ZZbKE2jowbtepG9Ym6m6ChHihx7tZUuI/iHvWSQ4DhRZDLjGzmWX+dsYVazKlmU1lWDKopVT3FZ3TjE14MdieqrSKy3te2viZg4RUsM+hLs6QDIleORHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4z9BGUg; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso376363a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707307249; x=1707912049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM6QsWjACFBChfoK3bSweEUSE6o11Fq5T/YgBy/dphE=;
        b=A4z9BGUgTQ3psnkBbFWDp/TCc5JoBcUD9PR9E84bSQ6IE1ACI+woG+yXfH2JMOVlVd
         x7Ku9X9vKU7AO7DqGmIa+rDq1b3l0J08EiyW0mWat/mycxwTBvnzvVyaAMdbQ43/jRPn
         CjGlEK4hAYFtWslvYbmvtllTv7j6zN0pN7qDdc+ktAYHUIinBrGN2VZtfVi0/W1nMosu
         VaWBzIhOZpbf4abLofVfn8frWDuXAX+0LuEdL0s0z0VlaLu7yIroXSNr/8vWIzGTNR5L
         sWQhB72m1mJbMBMWZ1Ey3HUTKg/8A/6NAdQkgZrnKt0ezZ+klG3wGYnI+V+RuclJvb1J
         ZLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307249; x=1707912049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gM6QsWjACFBChfoK3bSweEUSE6o11Fq5T/YgBy/dphE=;
        b=Oro4HVujwrXxh+39f2nIMVF/m5LjYjvzeCRyhcHDM45eqAwMZkwGndBMQ1RtCMko+S
         xEqOIUtHRioYyC54IsxGZ0JPPFh2rISlX80MbHC6tk0yco4bQej/IFZtUCfcbITL6l0/
         v2KF98WZ/poGtEZhWzbEXiRTaUCZdHWJPdoilbDt2CncF8d/H7qKknwZrp72zldNviwA
         cdDVDI2mszw7v5cUQNdzpDxPRWB1uspkE8ZhZEZx0/SsNIdO96e/KABAIpkfRBKiV4IJ
         Z7ujFo4kes4su+ptTuI4EyI+Ie+szkBAxixEVfHGuVDy1O7RUWouEwsUHa7MITLoJPcA
         h8hQ==
X-Gm-Message-State: AOJu0Yx7Qf2Lino2HvRCOoU/ypPvziM1PczKYyMiG4KyAVv3eM66wGwD
	E05VA9idc0fsny2qu1ad+nrpGZK16mWYZvSR3sC4Sa6WHDmrgthqhA0Uu9Xa0mPQ0ayzht/LTZz
	zfLdHFK0KE5TugnhSzWwp2vA+/cM=
X-Google-Smtp-Source: AGHT+IFmLjBaaEtX1/OMpKtsa7brGGtfjfLPXpt7bimcTxISC6q36Cd1j1/g2neE7C1t5/rt+Ks0wZAktODPx5HJXOM=
X-Received: by 2002:a05:6a20:3c94:b0:19c:1881:b4fa with SMTP id
 b20-20020a056a203c9400b0019c1881b4famr4911318pzj.33.1707307248929; Wed, 07
 Feb 2024 04:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207002305.618499-1-aford173@gmail.com> <CAOMZO5A1yiXiLOtR=H_4vJYAMGwjpqrErCzvSkmLoB_f6_rN_w@mail.gmail.com>
 <7b71ab7f-7ea5-4144-a7c5-d0b66ab13476@linaro.org>
In-Reply-To: <7b71ab7f-7ea5-4144-a7c5-d0b66ab13476@linaro.org>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 7 Feb 2024 06:00:37 -0600
Message-ID: <CAHCN7xJRWr8Og6E7Q10hAzd=8bb4kqOPJHQ9Rs98b5gqF8a3vg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: imx8mp-hdmi-pvi: Fix build warnings
To: neil.armstrong@linaro.org
Cc: Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org, nathan@kernel.org, 
	kernel test robot <lkp@intel.com>, Liu Ying <victor.liu@nxp.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Lucas Stach <l.stach@pengutronix.de>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:24=E2=80=AFAM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> On 07/02/2024 10:22, Fabio Estevam wrote:
> > Hi Adam,
> >
> > On Tue, Feb 6, 2024 at 9:23=E2=80=AFPM Adam Ford <aford173@gmail.com> w=
rote:
> >>
> >> Two separate build warnings were reported.  One from an
> >> uninitialized variable, and the other from returning 0
> >> instead of NULL from a pointer.
> >>
> >> Fixes: 059c53e877ca ("drm/bridge: imx: add driver for HDMI TX Parallel=
 Video Interface")
> >> Reported-by: nathan@kernel.org
> >
> > The Reported-by line format can be improved:
> >
Sorry about .that

> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> >
> > Thanks
>
> Fixed while applying,

Thank you!

adam
>
> Thanks,
> Neil

