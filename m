Return-Path: <linux-kernel+bounces-82404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315FA8683C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2B11F24A35
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0690F1332A0;
	Mon, 26 Feb 2024 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XkgBnM/C"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1D133280
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986568; cv=none; b=Jg9Jp/KmGLnJMdrNsHN5sBwUiBBxXpBZkYlrGV3e/0GfXUBc3S0l00XfosNVJArSGeLUY6cZE+Ijt2bp9M3CKuSMf3Vn/RpwBo91k5GEkvKbyiquD01veXY6U8kWqPdVkgSnVSnxBCNGICZln9Ejsof02AphT7qB8xpo8vYHurY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986568; c=relaxed/simple;
	bh=LPSvMg+QCFjUVfX7axRA8ovlTMn7/5woB7NWiDPw9dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAlXvdHTDYundfY7eipencL6Rzh3e+RRASIKa50cBHr+Qw/G7wG2bUsBMWNHZ5l7HV2KVIwnRo1Oz3eN2GGPO59qm1HRBUU9nV/sbwfdALdNMCKlJr0914VUqi5cNAuxmL6YBDInyrvURIjmYHaXewJkTySJnmAp+BcMe0QXVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XkgBnM/C; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so4563193a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708986562; x=1709591362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwHOxhCzVgWRYHLx5UlREeeks0w7r8W0vRg5wArpOeU=;
        b=XkgBnM/CvujefZjWQG6fTFjpftpIxmthb9kDwW6OZjxBJ4uw/3/OPkbweLOHLqLVjq
         JX4uOr/YOxXW41powiTjw1lFavx+xXmQJhZ01e1e1IOZ1Xc6upLKFv0qgDeyXTXu5/ZG
         AMRREz9UzDOLK9g7M3WgLBOAGHxuV/DsvfvaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708986562; x=1709591362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwHOxhCzVgWRYHLx5UlREeeks0w7r8W0vRg5wArpOeU=;
        b=KZAQkyat2fkLvhMwVRSFfUeStfrZACfn5HbwV9QsOFb1M5pqWDJyHQyqbrQ3JwhP9N
         mmIzngnPAKkyL0e4OTCNKVPXKxGeP3db5D6ae+psfEwu5IWCtO1sdtgvP61y+onC+wnx
         +jbF/2gAip46k/3ydR0xcoOQhGcUNbjfNRdAELajWuWohu+G+r88agVb8bU0TrWtpr70
         jhfAN9mKVx+bIj66zhJfi+h9oFoWpGox9GZa1dO+xxtJWtpcA6UNkvdbZdVSxQ25ded3
         rVXkG4/Xhk7VjG2LKrdBCLRjvxCdEvu2Yke6serOrYEPo7bSm4kPF1vGrSRINLFRXJzu
         WSsw==
X-Forwarded-Encrypted: i=1; AJvYcCUgPfvZDQaczOe40WlMTDZRCL4Zxv0oHEAIbybHX3o3TVe/Itd/BM+HqfXaFhsY3Xp5ts9A5No40XNSLlNEIargeLIoaFQYru3bVXjN
X-Gm-Message-State: AOJu0Yy8Oi83JenxBXsdRiH2qvOdGl/bTPONDfBHMiS5vIVnUEZ/ti39
	jgCRJbJK67YlOpMQF4w0ikq3K9HhXaYsV/YgtIWX0dk+oZalORrzQC7Qe+sRgn0i191LgjvMaYs
	f//wU
X-Google-Smtp-Source: AGHT+IGvOyshG4+zJb9MdtibWpKxYL5E7u9RVopVKpQ0c+8YR1FLuDlNHGNLhAA+yQ1P57sty8cKfg==
X-Received: by 2002:a17:906:3397:b0:a3f:d797:e6e2 with SMTP id v23-20020a170906339700b00a3fd797e6e2mr5040491eja.28.1708986562134;
        Mon, 26 Feb 2024 14:29:22 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id m16-20020a170906235000b00a3d153fba90sm149883eja.220.2024.02.26.14.29.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 14:29:21 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a9f272f4so14905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:29:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzZ//T3TBWDn2FyXjp0vCsLiYae+/X+PS3kU/p5ZSByeIzENPrz8rydwhPZNB0EL888LGToDxliV1gceOh8vYkWT4ZztUvyvZ1T8Gq
X-Received: by 2002:a05:600c:4e15:b0:412:a786:e8a1 with SMTP id
 b21-20020a05600c4e1500b00412a786e8a1mr82285wmq.6.1708986560846; Mon, 26 Feb
 2024 14:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <20240223223958.3887423-2-hsinyi@chromium.org>
In-Reply-To: <20240223223958.3887423-2-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 14:29:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XZJgFhufr8EkUfBYK+00Kb6R3dHob=EY8XUZ8NJmSChA@mail.gmail.com>
Message-ID: <CAD=FV=XZJgFhufr8EkUfBYK+00Kb6R3dHob=EY8XUZ8NJmSChA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm_edid: Add a function to get EDID base block
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 23, 2024 at 2:40=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> @@ -2770,58 +2770,63 @@ static u32 edid_extract_panel_id(const struct edi=
d *edid)
>  }
>
>  /**
> - * drm_edid_get_panel_id - Get a panel's ID through DDC
> - * @adapter: I2C adapter to use for DDC
> + * drm_edid_get_panel_id - Get a panel's ID from EDID base block
> + * @base_bock: EDID base block that contains panel ID.

s/base_bock/base_block, as identified by:

scripts/kernel-doc -v drivers/gpu/drm/drm_edid.c | less 2>&1

drivers/gpu/drm/drm_edid.c:2787: warning: Function parameter or struct
member 'base_block' not described in 'drm_edid_get_panel_id'
drivers/gpu/drm/drm_edid.c:2787: warning: Excess function parameter
'base_bock' description in 'drm_edid_get_panel_id'


>   *
> - * This function reads the first block of the EDID of a panel and (assum=
ing
> + * This function uses the first block of the EDID of a panel and (assumi=
ng
>   * that the EDID is valid) extracts the ID out of it. The ID is a 32-bit=
 value
>   * (16 bits of manufacturer ID and 16 bits of per-manufacturer ID) that'=
s
>   * supposed to be different for each different modem of panel.
>   *
> + * Return: A 32-bit ID that should be different for each make/model of p=
anel.
> + *         See the functions drm_edid_encode_panel_id() and
> + *         drm_edid_decode_panel_id() for some details on the structure =
of this
> + *         ID.
> + */
> +u32 drm_edid_get_panel_id(void *base_block)
> +{
> +       return edid_extract_panel_id(base_block);
> +}
> +EXPORT_SYMBOL(drm_edid_get_panel_id);
> +
> +/**
> + * drm_edid_get_base_block - Get a panel's EDID base block
> + * @adapter: I2C adapter to use for DDC
> + *
> + * This function returns the first block of the EDID of a panel.
> + *
>   * This function is intended to be used during early probing on devices =
where
>   * more than one panel might be present. Because of its intended use it =
must
> - * assume that the EDID of the panel is correct, at least as far as the =
ID
> - * is concerned (in other words, we don't process any overrides here).
> + * assume that the EDID of the panel is correct, at least as far as the =
base
> + * block is concerned (in other words, we don't process any overrides he=
re).
>   *
>   * NOTE: it's expected that this function and drm_do_get_edid() will bot=
h
>   * be read the EDID, but there is no caching between them. Since we're o=
nly
>   * reading the first block, hopefully this extra overhead won't be too b=
ig.
>   *
> - * Return: A 32-bit ID that should be different for each make/model of p=
anel.
> - *         See the functions drm_edid_encode_panel_id() and
> - *         drm_edid_decode_panel_id() for some details on the structure =
of this
> - *         ID.
> + * Caller should free the base block after use.

Don't you need a "Return:" clause here to document what you're returning?


Other than the kernel-doc nits, this looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

It'll probably need at least an Ack from someone else in the DRM
community before it can land, though, since this is touching a core
file.


-Doug

