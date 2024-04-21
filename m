Return-Path: <linux-kernel+bounces-152608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A418AC11F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 21:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808FA1C2085A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB2842057;
	Sun, 21 Apr 2024 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJLTIOS0"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCBF2A1A6
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713729183; cv=none; b=GR9z2Ttz4rf+fnhVtF2+waTL5b2U8eYZoD+MiMn2HY6zD+cl9R65s586cweULg5BMxl0gsnH0JPzOpYTChK0Aih7khvuQyexovco5RHhQOUC4OnX3pXTfwxCB6AA7TtqdvWqvWngSW+3mnodLxFIFp19sYEVVTyL77uvmOpDfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713729183; c=relaxed/simple;
	bh=0Zw43nCq0snAHABmH7B6SV89iFyXVG14aowboRvSbWk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4YH/C5n4TWNBYvhBXkTrkJs3vZbsEEsSF+kB5KLLen308oKyaBKsWfe9B95XS2BMlSYdpG1bAEsrIqqtQVE9oVC7m73D/NAOVPcf/YtfNqCFaj1IaRE2esn+HGP7ibYv1mE9jQMMWkNziSdDwtHwVfKMBNqAMPoxosdKIVujI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJLTIOS0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4155819f710so30786535e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713729180; x=1714333980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMaenB/28UTgVBO1bvU65I16JiSLNMn+INLi6fNav7Q=;
        b=FJLTIOS0hD/3MsD2Sytq3UBE6BWCWCMaOhgKp4cBsxF65WS+5Egix4kM4sFdsxIqWy
         0HsX3P4kA8ZBZEEA7ngHU7lW1npTVjhtxd8xL5kpJ3W7ACM7fvy8Uvpuwoi9QsOhYU8y
         sFgx1d/3xDSFlEpR9Bn5dN2BlgkbUqw8Z2u3QoRFk12utTZbz3tOnT6N8954XJB59VEq
         UEqbrEM+ZxhCqqvvP1Zr8AT4w/twHrdHzTpAJ2EKcEH2ctDIA9yNP3kMeXtqmh7pW2Uv
         7c8C3aEaavC9oDS/U392FDJlbi6HU1AG0R9wbMh7maBHejoJzS0qjWuoF7ul6f0gExYI
         aTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713729180; x=1714333980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMaenB/28UTgVBO1bvU65I16JiSLNMn+INLi6fNav7Q=;
        b=Pza4QD4tQZVQWnfIDD3jA8pmyyCzbaQLZHusvIoIDNeMg1tOsef1Z45k1KaQpBvUqj
         USMDn2Qet9CFcKuUPaeXbg7VWVwiPV+V5dsQUNY8TWqlO5nr23sSbw6RgShTfWxBwYOQ
         +TjqFXI4VPNeDh8CCJ//I2M6VXvtvPbODrN/vtgEh4crBY4JXJoXFnaV6rlDpBQiwvrW
         86lL4kTldQZ49udQgmsYuwmXfNlo7BqNYr96zsOhHm01wWnl5xMggSVVVU5r7aFfxKNv
         UOc1CLzhlJECyoH8Mt+w/uphFNsXsNCphijBLIyLv/xvFrEpBx7Q/xa9Z2F+ozzsS96n
         8gVw==
X-Forwarded-Encrypted: i=1; AJvYcCVZUnrlMGsYJkk/F+MU5cwWxRG2QG5DZu6Vceu6ANAy+Fk2tWBlbqf32yK8AvBvYqpNS5MQNdFM3Btr0j0kbpTaKmkObRU0pnLszAHp
X-Gm-Message-State: AOJu0YyTgfNo1e7MKKowjCCmhvxeny/nWV3CtF3Jbn7nu+mK07sbm42C
	Wf2HbW2JxQwUt7bB00ZFiwYvU7EGEApYgOSocVsrkUI7fE/Jdbjt
X-Google-Smtp-Source: AGHT+IH+FOSeFQjKP56pJvGYgnwg2xOA1gAlCxEdbMe/MGWtoLYfC/TIEOFAPaMrgTx6JTqFla3PYQ==
X-Received: by 2002:a5d:6083:0:b0:347:f94b:94df with SMTP id w3-20020a5d6083000000b00347f94b94dfmr5847674wrt.2.1713729179923;
        Sun, 21 Apr 2024 12:52:59 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id x5-20020a5d6b45000000b003472489d26fsm10129829wrw.19.2024.04.21.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 12:52:59 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: =?utf-8?B?T25kxZllag==?= Jirman <megi@xff.cz>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject:
 Re: [PATCH v2 0/3] Move blender setup from individual planes to crtc commit
 in sun4i-drm
Date: Sun, 21 Apr 2024 21:52:58 +0200
Message-ID: <2725781.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <wynuwtyn2skchb7gc5qixql2pxnb2nqvbmrda6s53u7nt5ki7n@hqb46kttkhee>
References:
 <20240224150604.3855534-1-megi@xff.cz>
 <wynuwtyn2skchb7gc5qixql2pxnb2nqvbmrda6s53u7nt5ki7n@hqb46kttkhee>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 19. april 2024 ob 15:36:17 GMT +2 je Ond=C5=99ej Jirman napisal(=
a):
> Hi,
>=20
> On Sat, Feb 24, 2024 at 04:05:57PM GMT, megi xff wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> >=20
> > This series refactors blender setup from individual planes to a common
> > place where it can be performed at once and is easier to reason about.
> >=20
> > In the process this fixes a few bugs that allowed blender pipes to be
> > disabled while corresponding DRM planes were requested to be enabled.
> >=20
> > Please take a look. :)
> >=20
> > v2:
> > - use regmap_write where possible
> > - add review tags
>=20
> It would be nice to have this applied.

Maxime,

do you mind applying?

Best regards,
Jernej

>=20
> Kind regards,
> 	o.
>=20
> > Thank you very much,
> > 	Ond=C5=99ej Jirman
> >=20
> > Ondrej Jirman (3):
> >   drm/sun4i: Unify sun8i_*_layer structs
> >   drm/sun4i: Add more parameters to sunxi_engine commit callback
> >   drm/sun4i: Fix layer zpos change/atomic modesetting
> >=20
> >  drivers/gpu/drm/sun4i/sun4i_backend.c  |  4 +-
> >  drivers/gpu/drm/sun4i/sun4i_crtc.c     |  2 +-
> >  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 70 ++++++++++++++++++++-
> >  drivers/gpu/drm/sun4i/sun8i_mixer.h    | 20 ++++++
> >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 85 +++----------------------
> >  drivers/gpu/drm/sun4i/sun8i_ui_layer.h | 20 ++----
> >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 86 +++-----------------------
> >  drivers/gpu/drm/sun4i/sun8i_vi_layer.h | 20 ++----
> >  drivers/gpu/drm/sun4i/sunxi_engine.h   | 13 +++-
> >  9 files changed, 125 insertions(+), 195 deletions(-)
> >=20
>=20





