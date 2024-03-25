Return-Path: <linux-kernel+bounces-118196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E9788B5A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4842A1F2D4C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C6284FDA;
	Mon, 25 Mar 2024 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jRzdO768"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41BC84D36
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711410720; cv=none; b=rio5f/aO3WFlEjm6AdxQ29mtL/6G9KzpMc+ZBGv9Y53SyoQnmT3FBiACnV25ktsBK7z3M6WbdhDJTILbj3TpD5FElumAm4+OK+rl5qipDMzQgOaeTDiPCQtndpYloCDWFJERbznsWw932Jvr6g1brFgTtvrLYKqAh6m2FxLgJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711410720; c=relaxed/simple;
	bh=oxuzlqVOTLOpfh3OJSKBQ9Jx5FDcP7ZC2rMXAjAaBUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4jN4ahvhhtbpXfmSEzr5IdU4dr/ZWDxx5cU7iT/LcmYFxIEJVOaAV1wLhBtq8VC/WNRS9mxZSfdK1020QC53qIE3xl/6/dHHOHfr26QERxfjaaiqlAhUb/5CFAfWwfGXcI0rfm2E/5zyLYbTgavYO+91MEliEPfbYe4BM60bXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jRzdO768; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e6d063e88bso1102070a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711410717; x=1712015517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MrRPD0X2P2h7H+3eSPulHbHlM+c9Z5ydkL4v8ZwLYc=;
        b=jRzdO768CRVfKVfhtJEix8rxhkPca1DLyFnQxnfuydyc4+CtGpHoRJ1J4iZd6fEqpi
         Z51ATzekFp/x4OPrnW7WWxao/xDB9XKgYiRjFymDkRmIouI/CSHKlwyH48xqQ//OJpdK
         6is26eTnoO/5SHEBU4MHZHbM2b83Jg5S5opAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711410717; x=1712015517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MrRPD0X2P2h7H+3eSPulHbHlM+c9Z5ydkL4v8ZwLYc=;
        b=Yf8nMM2vhJ8MZwFQCJGyCEeK/rul/SG7t1WMOW8JlJLBLJkmxAWEBgwpW/pHS1JHpE
         gx/q0R/HKRxwdOc4Y2DGHLdEJW0AQ5XsN5BaDT+/xAcbYGAKgWRfR/bAoKDQAgqWy+lB
         AsRuXC/gqlerdbs3NAbRl5FFRTjphQ2EfEVYEPTn4rpSmak/01PDuntmgDWX9IdLUhH9
         AdcynLzUg0VLd90sqZusouN1yWmo9snc26mhEJPWtndTn+boBjPb/lHrPYTRALAC4W8U
         Tiirmxru1BqghOfpj2ad+Cg447N3LoEQPuQ/oXWUjAzKGER+8NS1NS4LeQXD4WCa1BZ2
         t0mg==
X-Forwarded-Encrypted: i=1; AJvYcCXecW54ivTUXMImVGDe2ERd3prqQHRpOCy2rQsUDu++AiHo5Xb7wXGwYwtbkq6AeYg49qjS4WlPkLH0NBMtThogPcA0jXIL2lBRvsck
X-Gm-Message-State: AOJu0Yx4MMDT3Cj9G/KjtLgQxxog4+71hBHPv9WUDejPYMSW7wbBah/4
	Jl6GWt6QeRyTrkqjUy/B2PEWmTFJKP0un8ehFyK3SNgYHHJ7ga3rEFmrEHQr1eE8SNCfmDEQoV4
	EEp5UqaYfOM3gLfu2yZz2Pd4DmtIeCyznUCFG
X-Google-Smtp-Source: AGHT+IGbekR0Vue1xLl0EWSZ1BWGHK5l2W7TtzXDw/0HDGKWhLS9f4FhS58OXOS/D2ImlTRUf5Ts6pGmcmOJBXePe+s=
X-Received: by 2002:a05:6830:3103:b0:6e6:7d92:d5ab with SMTP id
 b3-20020a056830310300b006e67d92d5abmr1402055ots.10.1711410717736; Mon, 25 Mar
 2024 16:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325215631.3804796-1-dianders@chromium.org> <20240325145626.1.I659b2517d9f619d09e804e071591ecab76335dfb@changeid>
In-Reply-To: <20240325145626.1.I659b2517d9f619d09e804e071591ecab76335dfb@changeid>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Mon, 25 Mar 2024 16:51:32 -0700
Message-ID: <CAJMQK-gcN06k2zFQoSYKZcxxoRvkXVqCFmFtQ0xUS=+1VG+92Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/panel-edp: Abstract out function to set
 conservative timings
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Pin-yen Lin <treapking@chromium.org>, 
	Prahlad Kilambi <prahladk@google.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:56=E2=80=AFPM Douglas Anderson <dianders@chromium=
org> wrote:
>
> If we're using the generic "edp-panel" compatible string and we fail
> to detect an eDP panel then we fall back to conservative timings for
> powering up and powering down the panel. Abstract out the function for
> setting these timings so it can be used in future patches.
>
> No functional change expected--just code movement.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 40 +++++++++++++++----------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index c4f851200aa2..8a19fea90ddf 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -760,6 +760,25 @@ static void panel_edp_parse_panel_timing_node(struct=
 device *dev,
>
>  static const struct edp_panel_entry *find_edp_panel(u32 panel_id, const =
struct drm_edid *edid);
>
> +static void panel_edp_set_conservative_timings(struct panel_edp *panel, =
struct panel_desc *desc)
> +{
> +       /*
> +        * It's highly likely that the panel will work if we use very
> +        * conservative timings, so let's do that.
> +        *
> +        * Nearly all panels have a "unprepare" delay of 500 ms though
> +        * there are a few with 1000. Let's stick 2000 in just to be
> +        * super conservative.
> +        *
> +        * An "enable" delay of 80 ms seems the most common, but we'll
> +        * throw in 200 ms to be safe.
> +        */
> +       desc->delay.unprepare =3D 2000;
> +       desc->delay.enable =3D 200;
> +
> +       panel->detected_panel =3D ERR_PTR(-EINVAL);
> +}
> +
>  static int generic_edp_panel_probe(struct device *dev, struct panel_edp =
*panel)
>  {
>         struct panel_desc *desc;
> @@ -816,26 +835,7 @@ static int generic_edp_panel_probe(struct device *de=
v, struct panel_edp *panel)
>                 dev_warn(dev,
>                          "Unknown panel %s %#06x, using conservative timi=
ngs\n",
>                          vend, product_id);
> -
> -               /*
> -                * It's highly likely that the panel will work if we use =
very
> -                * conservative timings, so let's do that. We already kno=
w that
> -                * the HPD-related delays must have worked since we got t=
his
> -                * far, so we really just need the "unprepare" / "enable"
> -                * delays. We don't need "prepare_to_enable" since that
> -                * overlaps the "enable" delay anyway.
> -                *
> -                * Nearly all panels have a "unprepare" delay of 500 ms t=
hough
> -                * there are a few with 1000. Let's stick 2000 in just to=
 be
> -                * super conservative.
> -                *
> -                * An "enable" delay of 80 ms seems the most common, but =
we'll
> -                * throw in 200 ms to be safe.
> -                */
> -               desc->delay.unprepare =3D 2000;
> -               desc->delay.enable =3D 200;
> -
> -               panel->detected_panel =3D ERR_PTR(-EINVAL);
> +               panel_edp_set_conservative_timings(panel, desc);
>         } else {
>                 dev_info(dev, "Detected %s %s (%#06x)\n",
>                          vend, panel->detected_panel->ident.name, product=
_id);
> --
> 2.44.0.396.g6e790dbe36-goog
>

