Return-Path: <linux-kernel+bounces-159071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 694F58B28EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E758D1F23D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04259152163;
	Thu, 25 Apr 2024 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BXF3bksC"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D82135A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072674; cv=none; b=DVkTL8hc5IhdL765+H/VldwkX/X9Wr9q896XOT68a28A3T6kFyPl138do4GPgGJtR7mhGiR/+OBaNUAMnOnk/amEkMqFC61EhPeo2w0ZriaKceFs7w0McpQUDeM2ZcI3+ha/TMlwWggU0M5VZzvHwJL0ixPK5LEVOw9KuP+Cd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072674; c=relaxed/simple;
	bh=A6lPPyQHtBEecCLkp8Hl78aGwUS8l8z7MSFEY3wt5nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ca4l33xuzW28zAjLSuTwmKe5eiYOj5tiimsrTBiMdYmVE1St1lx15VteODmqnXBM4x9mcAbGlL4hgAx5RnJhcFWM/cXMb8GlWYoFlplHfFsoz3EN2ZjvtOOch2JU/wnbNl2UH2sQ5xQ/Y8tB1xJgkB7wuHauuO1D279djRNDbl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BXF3bksC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41a72f3a1edso10934535e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714072670; x=1714677470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TORP8JmPLsgmNgoZFGOZHT7MTm2YWpfB21iCEYUVT4g=;
        b=BXF3bksC7v58VEKEjBM/puJRecAS2I8JydcvZq94F+tmsv/QDMYL1tL6pUeQkiNaqV
         kD+7I83EzQYjry/xWWS3UkRhokUcLU58vCcpC4YQtxngF3osCT6ecFuV23zDB6GMetF5
         kdL2i7gO0ZTFfn6WdaWsNTJuZlyZGrddpgNlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714072670; x=1714677470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TORP8JmPLsgmNgoZFGOZHT7MTm2YWpfB21iCEYUVT4g=;
        b=K994NDOjbjSsCkUCjcPxmqVDfyQoFHT3GGRgg0EaC7d3YICiSST4HEr7cUhDA00/Q9
         cezDho5/3roF9TAVq4SHmSXXcy8/GZAVSW8J0tLSGdvMH0SW28xgwURr+X6YX+Xp5m2+
         hWAPyuALGVjbQrTjt4k9aEpgGj31CibtI2FFl6XnFmX2L4f51Nc6L4GmFpZetPhnDDwR
         gOocbO3tcc9PN1oG67WwjIYQgEilUmo15213t5kF/ElfPw9Gv8r+EjcitJBYJWWFus8B
         Az4Oedppuo42/a9K11+V81Tw+UOMVC+aYlKPqjfeoHcJX3l4Tq9c1JMJbEJyWFfq94pi
         vUcA==
X-Gm-Message-State: AOJu0Yx/SHg7zyAlQzvD+aL4Me3Ai7dXesrQEmhm8mwg8q6VYl25uW6v
	Cb53HXKtmYO8v1RvARDHyW88BZBxdmaSIfiyGnk18Gs6x6n8rbsxt7OnoEDk7O9yWJxKhUz0IeE
	3D5HivfwnGPAkyfu3y2DnwOpuEPhqgPapcZ/y1EcTEATERU8=
X-Google-Smtp-Source: AGHT+IG9K92yKqs8W2lMzB8dBG/qC9LIChhVCwedymWfAuz6JtrzHXcl/KngZ1SL5O3XeaVaoJnnaFweWnBNq4oSPXM=
X-Received: by 2002:a5d:54cd:0:b0:349:efb7:6532 with SMTP id
 x13-20020a5d54cd000000b00349efb76532mr249726wrv.28.1714072670453; Thu, 25 Apr
 2024 12:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221180622.v2.1.I0690aa3e96a83a43b3fc33f50395d334b2981826@changeid>
In-Reply-To: <20240221180622.v2.1.I0690aa3e96a83a43b3fc33f50395d334b2981826@changeid>
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Date: Thu, 25 Apr 2024 13:17:39 -0600
Message-ID: <CAJZwx_=5AB=EmG7ANcH4aw6GvCPtb0K2h_SEx4x8xpWA2F0HJA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/i915/intel_bios: Fix parsing backlight BDB data
To: LKML <linux-kernel@vger.kernel.org>
Cc: stable@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>, 
	=?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A kind reminder to review this change.

On Wed, Feb 21, 2024 at 6:06=E2=80=AFPM Karthikeyan Ramasubramanian
<kramasub@chromium.org> wrote:
>
> Starting BDB version 239, hdr_dpcd_refresh_timeout is introduced to
> backlight BDB data. Commit 700034566d68 ("drm/i915/bios: Define more BDB
> contents") updated the backlight BDB data accordingly. This broke the
> parsing of backlight BDB data in VBT for versions 236 - 238 (both
> inclusive) and hence the backlight controls are not responding on units
> with the concerned BDB version.
>
> backlight_control information has been present in backlight BDB data
> from at least BDB version 191 onwards, if not before. Hence this patch
> extracts the backlight_control information for BDB version 191 or newer.
> Tested on Chromebooks using Jasperlake SoC (reports bdb->version =3D 236)=
.
> Tested on Chromebooks using Raptorlake SoC (reports bdb->version =3D 251)=
.
>
> Fixes: 700034566d68 ("drm/i915/bios: Define more BDB contents")
> Cc: stable@vger.kernel.org
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
> ---
>
> Changes in v2:
> - removed checking the block size of the backlight BDB data
>
>  drivers/gpu/drm/i915/display/intel_bios.c     | 19 ++++---------------
>  drivers/gpu/drm/i915/display/intel_vbt_defs.h |  5 -----
>  2 files changed, 4 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/=
i915/display/intel_bios.c
> index aa169b0055e97..8c1eb05fe77d2 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.c
> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> @@ -1042,22 +1042,11 @@ parse_lfp_backlight(struct drm_i915_private *i915=
,
>         panel->vbt.backlight.type =3D INTEL_BACKLIGHT_DISPLAY_DDI;
>         panel->vbt.backlight.controller =3D 0;
>         if (i915->display.vbt.version >=3D 191) {
> -               size_t exp_size;
> +               const struct lfp_backlight_control_method *method;
>
> -               if (i915->display.vbt.version >=3D 236)
> -                       exp_size =3D sizeof(struct bdb_lfp_backlight_data=
);
> -               else if (i915->display.vbt.version >=3D 234)
> -                       exp_size =3D EXP_BDB_LFP_BL_DATA_SIZE_REV_234;
> -               else
> -                       exp_size =3D EXP_BDB_LFP_BL_DATA_SIZE_REV_191;
> -
> -               if (get_blocksize(backlight_data) >=3D exp_size) {
> -                       const struct lfp_backlight_control_method *method=
;
> -
> -                       method =3D &backlight_data->backlight_control[pan=
el_type];
> -                       panel->vbt.backlight.type =3D method->type;
> -                       panel->vbt.backlight.controller =3D method->contr=
oller;
> -               }
> +               method =3D &backlight_data->backlight_control[panel_type]=
;
> +               panel->vbt.backlight.type =3D method->type;
> +               panel->vbt.backlight.controller =3D method->controller;
>         }
>
>         panel->vbt.backlight.pwm_freq_hz =3D entry->pwm_freq_hz;
> diff --git a/drivers/gpu/drm/i915/display/intel_vbt_defs.h b/drivers/gpu/=
drm/i915/display/intel_vbt_defs.h
> index a9f44abfc9fc2..b50cd0dcabda9 100644
> --- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> +++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> @@ -897,11 +897,6 @@ struct lfp_brightness_level {
>         u16 reserved;
>  } __packed;
>
> -#define EXP_BDB_LFP_BL_DATA_SIZE_REV_191 \
> -       offsetof(struct bdb_lfp_backlight_data, brightness_level)
> -#define EXP_BDB_LFP_BL_DATA_SIZE_REV_234 \
> -       offsetof(struct bdb_lfp_backlight_data, brightness_precision_bits=
)
> -
>  struct bdb_lfp_backlight_data {
>         u8 entry_size;
>         struct lfp_backlight_data_entry data[16];
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

