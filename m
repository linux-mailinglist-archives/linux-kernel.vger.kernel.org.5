Return-Path: <linux-kernel+bounces-77295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA1C86036F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E9C1F24CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4369D6E615;
	Thu, 22 Feb 2024 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0otoRoc"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432C6E608
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708632178; cv=none; b=lRmivGEevyhbXseF5yv2adroKQWVyoqKMulLwwYKyn+HDaYoJim+SslN3Mcmqigc7cWsLzhrTan5mh1haciNJGSkwWXCGyTphU7U2rtGc64DKk4f33fOGeOjQ23ziSKxJs5mIRqUM2QgHjTIsPJ5veN/7gxJTHHFg7Psjg1DdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708632178; c=relaxed/simple;
	bh=Xi2wjrOo72UA133tK1EqoNVejEiGxEbbLe93GFk7rNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHg9AF4ejSPf6x6ieQL/ZK3X+JARdoxYbA7tElb3A0uQskksZd9LlAyV8cp+fIdVnJNAmIXn8zJBEwo76eH3bpVI9GxNHWFwMFBHfUw9hNz7xJ4SN9pIL03afqgBt0iKKRDHsSYg5EaKcWnhRjkXgubAXD0r2K1Ka1DDDbrpLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0otoRoc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3d484a58f6so16123666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708632175; x=1709236975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D91+NNYRuFeok9CBgQ7kElLom/IZjF4ZNUVGAGFMcWc=;
        b=B0otoRoc0CfE85w2JjcRQiXCa5soa7aFi5pCkPaS8x6BkDYp6cc4e70OvKvOPVMe9n
         NehrWU/5inhB62msyB7QhRPGtfUlf9TKQhWd1uqkN16SnY54YjKfSKyXZgDHyJWn2pf/
         rurkAnty9Ipwu+fbZ+ezBOzN8HQATMKqH0p+jqcNwmLEetbMJmfDYvoeou0hSp0GSsru
         vQsRYK4kfrgtVjyEXDQfreSsBVXUPoHVbLlpWWnSUdlUdAauP2xv/EUyO0MfZXdPPhHj
         oaGPv6ehl4asIvsMlmywHOoaVEhv3uc7vpFP/rANawgtxH2y7buiKOXZJ8WzD8JkgWgt
         By2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708632175; x=1709236975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D91+NNYRuFeok9CBgQ7kElLom/IZjF4ZNUVGAGFMcWc=;
        b=l30O2H+TUeyaO2xZ69NTHXoCxyrE5LAmk0N477pH1SOg5WN2i+9DEr5wysizdxQdWr
         MQ2fy3AyI5iRwuUSHideNZErHFGKhAp4q7acDY4mL1EiacnHhRsrG0dwjCTSDfeqnmzM
         gyxpfqhldLmtZIt12drqQ+/YyUqoC+NPusqqTb/QzGdZwOxNHifJPhFYFG1UqkX2hbRL
         0FXPlogBWiUe9GFAAgEu87qYD9+enNMZ8wtBtZBqjkn+WQZRyu32D3nnnzDS3U2QZsZK
         jqZ/q33MXbsGWyEl8lRZZ9PvuFeHZcusJ8faOZt9ZLaMFiEyh3wGNDN9dV/TdXOdiwn/
         gtaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3cBePhnpCJnsGUKacyCnkk/tQhfiluMhZaS68srNfjRIpR5h61jbZ/+USniAh6VP5o8dEmzun3wS51LYYOhJ17y3CF776hvhyBRJr
X-Gm-Message-State: AOJu0YwglNCQKU3EpfU5bthDAEV6MieTgW9GDsTL4OLobLHBbGd6+w6e
	VPDJqdmNYsjZgLEQ6VMyoFnPBUi4VtybTCs7xYc/KJxzzehZuutn
X-Google-Smtp-Source: AGHT+IEgvTKQkasQRFEm9qA5fvN8XNPWdx6hB/jSsMaHVhviWIDzjakARe/kyNDcFAl7qhoDmu/LtA==
X-Received: by 2002:a17:906:b106:b0:a3e:e869:a151 with SMTP id u6-20020a170906b10600b00a3ee869a151mr5856787ejy.45.1708632174997;
        Thu, 22 Feb 2024 12:02:54 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709067d5400b00a3e85909a1csm4520555ejp.182.2024.02.22.12.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 12:02:54 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: =?utf-8?B?T25kxZllag==?= Jirman <megi@xff.cz>,
 Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Samuel Holland <samuel@sholland.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/sun4i: Fix layer zpos change/atomic modesetting
Date: Thu, 22 Feb 2024 21:02:53 +0100
Message-ID: <2448947.jE0xQCEvom@jernej-laptop>
In-Reply-To: <inuhwnlexpt6dpre4uailtvytjhms4uqeerzehbntczurhcxol@fc4nvkdwffdd>
References:
 <20240216190430.1374132-1-megi@xff.cz> <20240216190430.1374132-4-megi@xff.cz>
 <inuhwnlexpt6dpre4uailtvytjhms4uqeerzehbntczurhcxol@fc4nvkdwffdd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne sreda, 21. februar 2024 ob 14:45:20 CET je Maxime Ripard napisal(a):
> Hi,
>=20
> On Fri, Feb 16, 2024 at 08:04:26PM +0100, Ond=C5=99ej Jirman wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> >=20
> > Identical configurations of planes can lead to different (and wrong)
> > layer -> pipe routing at HW level, depending on the order of atomic
> > plane changes.
> >=20
> > For example:
> >=20
> > - Layer 1 is configured to zpos 0 and thus uses pipe 0. No other layer
> >   is enabled. This is a typical situation at boot.
> >=20
> > - When a compositor takes over and layer 3 is enabled,
> >   sun8i_ui_layer_enable() will get called with old_zpos=3D0 zpos=3D1, w=
hich
> >   will lead to incorrect disabling of pipe 0 and enabling of pipe 1.
> >=20
> > What happens is that sun8i_ui_layer_enable() function may disable
> > blender pipes even if it is no longer assigned to its layer.
> >=20
> > To correct this, move the routing setup out of individual plane's
> > atomic_update into crtc's atomic_update, where it can be calculated
> > and updated all at once.
> >=20
> > Remove the atomic_disable callback because it is no longer needed.
> >=20
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
>=20
> I don't have enough knowledge about the mixers code to comment on your
> patch, so I'll let Jernej review it. However, this feels to me like the
> pipe assignment is typically the sort of things that should be dealt
> with device-wide, and in atomic_check.

In DE2 and DE3.0, you cannot move planes between mixers (crtcs), because ea=
ch
one is hardwired to specific mixer. Movable planes are the feature of DE3.3
and one of the pain points for upstreaming the code. Anyway, this commit on=
ly
addresses current issue of enabling and disabling planes and handling zpos.

In atomic check you can only precalculate final register values, but I don't
see any benefit doing that. I think that this code elegantly solves current
issue of enabling or disabling wrong plane in certain situations, so:

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Note, if there is new revision, please rewrite blender regmap_update_bits()
to regmap_write(). Since there is HW issue with reads, I would like to
get rid of regmap_update_bits() calls eventually.

Best regards,
Jernej

>=20
> If I'm talking non-sense, it would be great to mention at least why that
> can't be an option in the commit log.
>=20
> Maxime
>=20





