Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF687C727F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379543AbjJLQ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379520AbjJLQ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:26:39 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0764C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:26:37 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1dd54aca17cso754927fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697127997; x=1697732797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBcJDMO8BqJFA0osnFXlLxTGR2LNlFZQr/WWXq6Wi0U=;
        b=U+a/vOg5XJJYt/Fj++T3i7pcC7tx/ZylNU7AgFgUXuEkxYaY9dGWm3y8zU9iv0FUy+
         XGHjDO+Tp+U2odqqnouGsRvXykrvOxSblU63cZUoKiX/VfBu14+mTul/T3nQzpzgPo6i
         dRcvYgBqs+XawEW5GH9JNescQIqJkuShgQPT+Nlz4gEfMHz2OeeE8hLh1KvbJmKMkf5m
         8ZJRNoj2FLmRTcbDHoH1W8mVoXH53LRs0rMj13J4qrWJCsGmFiafVSQ54RYlsxWNBMQU
         lWKP2Z0iewRKoqqHM4VjOsCymnEi5eac9dE/8UJHETeVPkzxVcwUc6V3+ypVUceQ/e3C
         BZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127997; x=1697732797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBcJDMO8BqJFA0osnFXlLxTGR2LNlFZQr/WWXq6Wi0U=;
        b=UJB/FUcg8YchICuXbPf/pud0GMHKH2np7omYDyeNe75qy6DCLkeHa/fy76X5cP0CB3
         mQMnnKBgPIK3tujg4z/gdeJIXJdNWjHJjcdybonkqzy3tFS+WOp5E1/pdMsN6PNpmnkf
         YljJYQ/CB28W8QSnLFf5WDFK7XdqhvAqQu4L5ICAjz+ixsC3aLI5xws6B6JY0XQMcN8M
         jnl+oD+UqhMA77ommfSMCC7DoHclhPGlVrZ1EzTZCWD4wRyIaAzsNOPIqXeJgzM59PD+
         nX5pxsA9Oxh0mRi8IBJb5EZ41jLRlXCOjOAFWVYDS5Ez5SSaOmZ4Skk9uG6XLQ168QWS
         mrmw==
X-Gm-Message-State: AOJu0YweBDe5VKJhQ1yB+3+eQa1+acpnlZUahqCLFnbDblcNQwyE8Pkm
        qE08ndSHKHH+/0HMfMSPse5q09NXm6lx0QhJowI=
X-Google-Smtp-Source: AGHT+IFUrc0sLwkm6fAdE0Ys+114EjlMatPYD8Ku+zVny9zH5yswsOsrwiyGA9vIiuPk7/4R78tUxC5ZFCCqzUPj/zU=
X-Received: by 2002:a05:6870:160b:b0:1c0:d0e8:8ff9 with SMTP id
 b11-20020a056870160b00b001c0d0e88ff9mr26744492oae.16.1697127996643; Thu, 12
 Oct 2023 09:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231011012143.4091532-1-make_ruc2021@163.com>
In-Reply-To: <20231011012143.4091532-1-make_ruc2021@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 Oct 2023 12:26:25 -0400
Message-ID: <CADnq5_OzFoCDoOMRURXuh6fT=1KXwg6SGs=p4+jwpUqwimkNiw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix a possible null pointer dereference
To:     Ma Ke <make_ruc2021@163.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Tue, Oct 10, 2023 at 9:32=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote:
>
> In radeon_tv_get_modes(), the return value of drm_cvt_mode()
> is assigned to mode, which will lead to a NULL pointer
> dereference on failure of drm_cvt_mode(). Add a check to
> avoid null point dereference.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm=
/radeon/radeon_connectors.c
> index d2f02c3dfce2..b84b58926106 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -1119,6 +1119,8 @@ static int radeon_tv_get_modes(struct drm_connector=
 *connector)
>         else {
>                 /* only 800x600 is supported right now on pre-avivo chips=
 */
>                 tv_mode =3D drm_cvt_mode(dev, 800, 600, 60, false, false,=
 false);
> +               if (!tv_mode)
> +                       return 0;
>                 tv_mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PR=
EFERRED;
>                 drm_mode_probed_add(connector, tv_mode);
>         }
> --
> 2.37.2
>
