Return-Path: <linux-kernel+bounces-44216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CC6841EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8930E1C241BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2B45915B;
	Tue, 30 Jan 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V9gbwDs+"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2958AB8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605928; cv=none; b=FeuwaDCNwDHr3OJHfsGzxXyPX+qUoOhP0KfTPdX/vRel9G1OnK5hrYRCl9D4u03D4CpQrPM606BGzf+oemTJ5VFnXNNTi32PPC0EIaXlpzfzFyh9XanYmn5W75QL7u+SjDMaPkEnUvPc0X6TMdr2S052dsUw3XwReVLixoly3co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605928; c=relaxed/simple;
	bh=vZlHem6hzuG3LFpthbRM+SoNrdspQpN3rAyWGZtr6Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sR9H6pPamra10s8ezqaZNGMbN0kPM15Rl3T9DfdGlBT8NxceORfcKMewYlIGuITWZHoHY5QtToFq1OdKLbwfWt93pTWAMMVJ+iJOVqLqZah1o+sFPB/UChxovIq0q1/9PHg09G507VMTz7zf2JYw1zDiaSpA7d34p9gX2LlkxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=V9gbwDs+; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc261316b0dso3182140276.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1706605926; x=1707210726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjMzYiCsE7PaNmy35UnbQyvsqa5heiYDi1xRNMyjnas=;
        b=V9gbwDs+MRG/9Dmz3S1zl7jiwZtgiSowRAkiweiAwpnqrXJSeu5l/GKYJLhYXmeIf/
         ufR/Deho1nkNTNMNO3giicpJJC+Kn+4SwXt3g6d6uVn2iitVWQ50OZtsXxZyNCFAgqTy
         nXa2nAPsxILUv7/32uymRpR9fvcotmFTKm/fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605926; x=1707210726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjMzYiCsE7PaNmy35UnbQyvsqa5heiYDi1xRNMyjnas=;
        b=f2zlBNIe4Kb4Q9NgzEM9HOnhFjUguUjPgIoPy9/s7Ds6eZh3rfFqIYFSMRf1y7vdZ8
         XXpBngCGWVGAMe4KSmuqzycYbaFLM3zygL01rHHvFw/k9pfCEY36JW1kZO1N4KH9Bz0n
         pXRqCvuWOBkul/Dr5Gf89FSMJeufE2wofB3JVhGaVhqPtWtezPIleyxq8pOjPNrvd7Eo
         FDEB6MWvDfeLjZGzPtKJ1RoomI+CicQC8U9s++5OvdOJuQOxOLibqQln2VItTdluNTzn
         OLElJq3Rxk+6/pSLuxQJLpcl8XHpaR+ccz4BTYbE5wHuaFWn/FIvCTPSLIOwGPrzd3BV
         wVfg==
X-Gm-Message-State: AOJu0YxzohqWEgzydAby+t3w4kXYuoAckt2DAE3WdF5F1ZoBtVRZDV/j
	yVXs3xKl/qQCO2dEETV+D8tf/tdacu4PA1bJlD/filLk3lFlWY2w93/xFASF9k8TkaDB/pYpjFp
	JJHSFUaTRoEsSLDumMXAPnqiMzLPs002j8AD5CA==
X-Google-Smtp-Source: AGHT+IE1Xtyo447bABZUIXxJVEHr3YoCy1sd7si+1fdu6stw64epBG2GA9tH9vg6XiVGO8+8xyGxBj+g/74LPW1Euz8=
X-Received: by 2002:a25:854b:0:b0:dc2:3608:2b24 with SMTP id
 f11-20020a25854b000000b00dc236082b24mr4210395ybn.25.1706605926248; Tue, 30
 Jan 2024 01:12:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113164344.1612602-1-mwalle@kernel.org> <631fe35a2a3b00781231e4f3f5094fae@kernel.org>
 <1ef3dad2-5f55-40e5-bba7-3c71d71c12e4@kontron.de> <CAAQKjZMccDwa63_PNJCP0rNOaHjTwcOz8AbKa=JXLQi-b0QVVw@mail.gmail.com>
 <2400535875c353ff7208be2d86d4556f@kernel.org> <ZZ1BBO2nNSp3g-gT@phenom.ffwll.local>
 <CAAQKjZNnJQDn_r1+WNmsxM-2O48O0+yWAUAqpjZRjMYMT3xGwg@mail.gmail.com>
 <CAPM=9tytMB9frxNeD08hu1qsusY=wEE3bJOFmUgA1rSpabwDpg@mail.gmail.com>
 <b18d88302acfca001a6693d78909bc2a@kernel.org> <31e1a38a1d012a32d6f7bc8372b6360e@kernel.org>
In-Reply-To: <31e1a38a1d012a32d6f7bc8372b6360e@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Tue, 30 Jan 2024 10:11:55 +0100
Message-ID: <CABGWkvp5Xx61h+sfKotb=jsQE3jPXP0bJfTtb1k9_OCH-TzTvQ@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE
To: Michael Walle <mwalle@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Inki Dae <daeinki@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Robert Foss <rfoss@kernel.org>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Jagan Teki <jagan@amarulasolutions.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Tim Harvey <tharvey@gateworks.com>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	linux-kernel@vger.kernel.org, 
	DRI mailing list <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, 
	Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Mon, Jan 29, 2024 at 5:06=E2=80=AFPM Michael Walle <mwalle@kernel.org> w=
rote:
>
> >> Just FYI this conflictted pretty heavily with drm-misc-next changes in
> >> the same area, someone should check drm-tip has the correct
> >> resolution, I'm not really sure what is definitely should be.
> >
> > FWIW, this looks rather messy now. The drm-tip doesn't build.
> >
> > There was a new call to samsung_dsim_set_stop_state() introduced
> > in commit b2fe2292624ac (drm: bridge: samsung-dsim: enter display
> > mode in the enable() callback).
>
> I had a closer look at the latest linux-next (where somehow my patch
> made it into) and tried to apply commit b2fe2292624ac (drm: bridge:
> samsung-dsim: enter display mode in the enable() callback). It looks
> like only the following hunk is still needed from that patch. Everything
> else is covered by this fixes patch.
>
> Dario, could you rebase your commit onto this patch? I had a quick test
> with this change and it seems to work fine for our case.
>
> --snip--
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c
> b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 63a1a0c88be4..92755c90e7d2 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1498,6 +1498,8 @@ static void samsung_dsim_atomic_disable(struct
> drm_bridge *bridge,
>          if (!(dsi->state & DSIM_STATE_ENABLED))
>                  return;
>
> +       samsung_dsim_set_display_enable(dsi, false);
> +
>          dsi->state &=3D ~DSIM_STATE_VIDOUT_AVAILABLE;
>   }
>
> @@ -1506,8 +1508,6 @@ static void
> samsung_dsim_atomic_post_disable(struct drm_bridge *bridge,
>   {
>          struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);
>
> -       samsung_dsim_set_display_enable(dsi, false);
> -
>          dsi->state &=3D ~DSIM_STATE_ENABLED;
>          pm_runtime_put_sync(dsi->dev);
>   }
> --snip--
>
> -michael

I'm sorry, but I didn't understand well what I have to do.
This is what I have done:

git clone https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/lin=
ux-next.git
cd linux-next
# add your changes, the ones of the emails
git am --reject 0001-drm-bridge-samsung-dsim-enter-display-mode-in-the-en.p=
atch

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c
b/drivers/gpu/drm/bridge/samsung-dsim.c
index 92755c90e7d2..b47929072583 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1508,6 +1508,9 @@ static void
samsung_dsim_atomic_post_disable(struct drm_bridge *bridge,
 {
        struct samsung_dsim *dsi =3D bridge_to_dsi(bridge);

+       if (!samsung_dsim_hw_is_exynos(dsi->plat_data->hw_type))
+               samsung_dsim_set_stop_state(dsi, true);
+
        dsi->state &=3D ~DSIM_STATE_ENABLED;
        pm_runtime_put_sync(dsi->dev);
 }

And then test the driver for my use case.

Is everything I wrote correct, or am I making a mistake?

Thanks and regards,
Dario

--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

