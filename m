Return-Path: <linux-kernel+bounces-7121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ECF81A1F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340E5287FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3053F8E1;
	Wed, 20 Dec 2023 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aW0FUOWG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C228F3E47C;
	Wed, 20 Dec 2023 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d31116dbeso11255035e9.3;
        Wed, 20 Dec 2023 07:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703085166; x=1703689966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yicW/0g5zGKG++pwwlmWWUmEq4VzIsF4byaTzV8risI=;
        b=aW0FUOWGZNNwl93VqkcnA0aiYsybD2dvanyziuVIzgSHvS5pmqYLKTOq92zvWh6jYE
         IGrG9+HPaXJ2wIzimzdJCqXdCt6rEpblqSsiL1cXRaIoWQ228OypqcmgnnQkE6yQltUp
         MhuUF7uC2l7BOFtAKkfoXrDenxp5Bl8ODHUL5ygFQ4keORKkMfSDuixdPUug/2Zy0sEL
         ksKrAmFgiILcjnaPyjHcN3Mz2mY7fHCosofE3bx/gUrBA3Put3SCEtEiin6zt+Hx4Di/
         xxVtCDIOElIu60es/5ETc9ua/lH48SylTXIpU64MdrL0JUIo8uEz1xkQQfJL4EFYUcym
         gIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703085166; x=1703689966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yicW/0g5zGKG++pwwlmWWUmEq4VzIsF4byaTzV8risI=;
        b=Jc3dOcqLNtGhNj9MtcV2zPPPUbO6HKImjaof6gvlQmlmGtUTK7160SMvRpBRe2TWRw
         uAU+35P/vxJtHM/ysYfWdprD1NQ0ej2vklpYjHYicMFXSDJ7J1IwD3acf5ZbJyu3lu4W
         WCf4zWb7qmBTmLjqQUVhUuhcNVPwz7/0IQ+8wisqOKhWnLdFJAGwlZHDvz2ikM6nP6/y
         NsKYLfB395QAaggHqjyEKAbW8lCeoSymn7uqqQjpMFbxlS6kOc1iliLZSelX4VihGmWA
         wiCf1Stuufh3Nw72L8IS8CjWVh50H19Tw4VYqyinEHD25tF8qUmJnEJhJ81eghZX9rgN
         K2yQ==
X-Gm-Message-State: AOJu0YwHevpUzlDZh9DUaytSZ3ih3GWt0dosk3LawoHb/fFKCEU0cs4q
	55HYx96hPYjmWkUgUVoFA9I=
X-Google-Smtp-Source: AGHT+IEKaIqHWDfrMHQzZy/DZQAUnHiC5clwJLE6Mzl2x0m3qk5dXSE5YR5bdZlk9zrAuj1HQst5eA==
X-Received: by 2002:a05:600c:4d0e:b0:40b:47c5:35e4 with SMTP id u14-20020a05600c4d0e00b0040b47c535e4mr10309451wmp.39.1703085165645;
        Wed, 20 Dec 2023 07:12:45 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id e2-20020adfef02000000b00336644c400bsm9770223wro.64.2023.12.20.07.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 07:12:45 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Frank Oltmanns <frank@oltmanns.dev>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject:
 Re: [PATCH 4/5] clk: sunxi-ng: a64: Add constraints on PLL-VIDEO0's n/m ratio
Date: Wed, 20 Dec 2023 16:12:42 +0100
Message-ID: <2174554.Mh6RI2rZIc@jernej-laptop>
In-Reply-To: <87il4t9wi1.fsf@oltmanns.dev>
References:
 <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <13411739.uLZWGnKmhe@jernej-laptop> <87il4t9wi1.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne sreda, 20. december 2023 ob 08:09:28 CET je Frank Oltmanns napisal(a):
>=20
> On 2023-12-19 at 17:54:19 +0100, Jernej =C5=A0krabec <jernej.skrabec@gmai=
l.com> wrote:
> > Dne ponedeljek, 18. december 2023 ob 14:35:22 CET je Frank Oltmanns nap=
isal(a):
> >> The Allwinner A64 manual lists the following constraint for the
> >> PLL-VIDEO0 clock: 8 <=3D N/M <=3D 25
> >>
> >> Use this constraint.
> >>
> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >> ---
> >>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi=
=2Dng/ccu-sun50i-a64.c
> >> index c034ac027d1c..75d839da446c 100644
> >> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> >> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> >> @@ -68,7 +68,8 @@ static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_bas=
e_clk, "pll-audio-base",
> >>  				       BIT(28),	/* lock */
> >>  				       CLK_SET_RATE_UNGATE);
> >>
> >> -static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST(pll_video0_cl=
k, "pll-video0",
> >> +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT_NM_RATIO(pll_vid=
eo0_clk,
> >> +						"pll-video0",
> >>  						"osc24M", 0x010,
> >>  						192000000,	/* Minimum rate */
> >>  						1008000000,	/* Maximum rate */
> >> @@ -80,7 +81,10 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLO=
SEST(pll_video0_clk, "pll-vid
> >>  						297000000,	/* frac rate 1 */
> >>  						BIT(31),	/* gate */
> >>  						BIT(28),	/* lock */
> >> -						CLK_SET_RATE_UNGATE);
> >> +						CLK_SET_RATE_UNGATE,
> >> +						CCU_FEATURE_FRACTIONAL |
> >> +						CCU_FEATURE_CLOSEST_RATE,
> >
> > Above flags are unrelated change, put them in new patch if needed.
>=20
> You might notice that I am using a new macro for initializing the
> pll_video0_clk struct:
> New: SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT_NM_RATIO
> Old: SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST
>=20
> Setting the two CCU_FEATURE flags is part of the old initialization
> macro.
>=20
> I'll add SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_NM_RATIO_CLOSEST which
> hopefully resolves the confusion.

I'm in doubt if we need so many macros. How many users of these macro we'll=
 have?
I see that R40 SoC would also need same ratio limits, but other that that, =
none?

Best regards,
Jernej

>=20
> Thanks,
>   Frank
>=20
> >
> > Best regards,
> > Jernej
> >
> >> +						8, 25);		/* min/max nm ratio */
> >>
> >>  static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
> >>  					"osc24M", 0x018,
> >>
> >>
>=20





