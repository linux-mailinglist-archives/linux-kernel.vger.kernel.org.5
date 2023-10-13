Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A227C8718
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjJMNnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMNnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:43:19 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7797CC2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:43:18 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1dcf357deedso1141271fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697204596; x=1697809396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnWEZv1MNtgqh9gti2tLWs0h9m12y4MRumc01RdiEtk=;
        b=aEM4FYBXMJdoOBgUSNw/pvqNkIHQucPnxQhof28rz4LIGWBdBWLUKSmfOXFAwYuYBC
         +l6dMTuxC33bbuiBm4KNtrENI63UKQZlM4T1qYmweUi3mTbqGbwmzBdYAMWI3TCYNhNW
         owxqwjdrd2bSnd1WbRn1nDl6XOHHHvT7Vi4d+1p0mh4YPXbiwBqqVZ62sNtn1NBjNj2C
         FQPYyKuwCALYn6sT18djejy6K7Gg997nP7cEOhg/Y1t+mF/zlUw5zjg+Qpt+/SwtLdzt
         R1LiESNl/bZnZQ97ArBZ6EzU8yKKuX1F2+XzpkWwKGZR6/BFtycyr5KMFrd6pcIwO6Ga
         B4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697204596; x=1697809396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnWEZv1MNtgqh9gti2tLWs0h9m12y4MRumc01RdiEtk=;
        b=iiELdKIUdjB3XvgIMrxWpRtpz8LhEDVcrT97WReIzL16Ult9+J0EEUs4cbGz9iFfl2
         fj8VFUdGhgDNMKBiG5z+fI4Qxlr1lwOMz2wxkgstkdypkkqpvat9p1neKuQX7qhIGh3K
         tIGaJzXeR3adkQ8OdYuwNQFG95AOLk8mA7UyjqHISE1Z1D6hFhNVwLuFwZIXjmwvzs7T
         hYKohhiG5Tn8WH+/KKWCJHHuIyEDCiP8qixNBX3Ja//3QrSlXSJXkj4yicxscmbvJl2j
         o7zu4HwdmlSxQiIbYa4RwwjT+LBl4W+66rNbHp3V6PMKpR7L20lG19OG5k25fSfrejU4
         WcMA==
X-Gm-Message-State: AOJu0YxifPiwf+E/mUPvpIXp4ke4XbRs84C4VfS0aGPzGsy1dwE2a/KQ
        k/tVPuiOBTjrKgtsvZGIihGWtONLHsjaQQQmTQc=
X-Google-Smtp-Source: AGHT+IFoW3UGKp6WFchSFelNoxU/WAsrS3zOm0oHTP2cYQpadsAsYs+Nk8COpFjgfB4j6U0yPXA5ci7qMvaaTZquInY=
X-Received: by 2002:a05:6871:4414:b0:1e9:9537:c1a9 with SMTP id
 nd20-20020a056871441400b001e99537c1a9mr9024226oab.12.1697204596057; Fri, 13
 Oct 2023 06:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231013015343.290456-1-make_ruc2021@163.com>
In-Reply-To: <20231013015343.290456-1-make_ruc2021@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Oct 2023 09:43:05 -0400
Message-ID: <CADnq5_P4i2J2AaO2R6rMO0nvRGZNT1EUN1jDUB2mC4BkHKOecg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vkms: fix a possible null pointer dereference
To:     Ma Ke <make_ruc2021@163.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        guchun.chen@amd.com, yifan1.zhang@amd.com, Tim.Huang@amd.com,
        zackr@vmware.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:32=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote=
:
>
> In amdgpu_vkms_conn_get_modes(), the return value of drm_cvt_mode()
> is assigned to mode, which will lead to a NULL pointer dereference
> on failure of drm_cvt_mode(). Add a check to avoid null pointer
> dereference.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vkms.c
> index 7148a216ae2f..db6fc0cb18eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -239,6 +239,8 @@ static int amdgpu_vkms_conn_get_modes(struct drm_conn=
ector *connector)
>
>         for (i =3D 0; i < ARRAY_SIZE(common_modes); i++) {
>                 mode =3D drm_cvt_mode(dev, common_modes[i].w, common_mode=
s[i].h, 60, false, false, false);
> +               if (!mode)
> +                       continue;
>                 drm_mode_probed_add(connector, mode);
>         }
>
> --
> 2.37.2
>
