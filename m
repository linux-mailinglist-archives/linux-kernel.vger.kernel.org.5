Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98D1781021
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378557AbjHRQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378552AbjHRQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:17:12 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077453C0F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:17:11 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1c4dd644cf8so604618fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692375430; x=1692980230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmsKotSwYF+kPiIcHWALWBh/ukbgHTS/mEBTjEjcav8=;
        b=FVHqGr/fOb1UCdX8GGM2iLUJry3Lc6ptJ2VUTEjTzpbcQazo6xUUcGNEad3RuB5Zd9
         oOdFrcLy/jLQsE7aE/nqTL9JtuG723yC0Qw9iUGydscO5Ki6V0uHEZpONbBZPhu/9ibq
         rurS4nBFXKjZabvp4wzzZ+pw/T5bxFai6KXPwyYtNY+EA5gLnIcUzI9PlWSt2pGhBAOd
         JYSvHjpNRPHy/7hV6vXSAGjQVnKraN9Hyv768ITx9G+4g7/Au8bs8tko9onUNMn+n4sh
         mtfnWIvw3ILHcPHY17wxqI0UfHmtoKnfFPV1nLYVWcI3aqOwy5QXhWRcWdr2Y0IF/vKA
         iyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692375430; x=1692980230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmsKotSwYF+kPiIcHWALWBh/ukbgHTS/mEBTjEjcav8=;
        b=Gb3x8IGj9yti9zPUga2sby7DEgKf9vqgajgx7YTMQLB2hUIWy0YphxMTgueENXwjQF
         kw82lHXFFUJnEp2eE4KLyV7tagfulfXGT4lM5kLuV8lTp8y1ll/ROiOzqY7P4PSZ/mH/
         8VLUTeL98eMEFMHWXZpRtrToiROtWsVYHIxPiVTM9l7MOB/ncsHUGYkQjzOXmwiRf2Cq
         kUPu+qw+VGae5M1p9kV5npYVumHJhXO/lDkCJhL4PwN6fF8U7FBlOTLoDqPCpAB9KF5A
         1qcyspECBvG4pmRGcY1dA/3zm+zCP37I5p/cSLU6nWObRgLE3u4deRtU9+YRN9aPjFkv
         /lZQ==
X-Gm-Message-State: AOJu0Yx0pQ41JrZWnrF0Ftulep4qEAdhk0pj/lDB0dGVMfQJeHi9hXPD
        F348s3Bj7G9RT9iQJzslrqtcMbpNb3gUm5tRol4=
X-Google-Smtp-Source: AGHT+IEbBMyiu2ye/T762d0evV957KNMqzHYgj0Gtr/TXQYWPbXqSWEuxLLMDxRhGe5glkzIXv1n6ijj6wgk13JvSiE=
X-Received: by 2002:a05:6871:68d:b0:1bf:61d1:a4d4 with SMTP id
 l13-20020a056871068d00b001bf61d1a4d4mr3548702oao.6.1692375430306; Fri, 18 Aug
 2023 09:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230817113349.749797-1-konstantin.meskhidze@huawei.com>
In-Reply-To: <20230817113349.749797-1-konstantin.meskhidze@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 18 Aug 2023 12:16:59 -0400
Message-ID: <CADnq5_M6QEU5fZXiACiQWsLODtdWmpfX5FCvgyDBsdNGw95a1w@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpu: drm: radeon: possible buffer overflow
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     alexander.deucher@amd.com, artem.kuzin@huawei.com,
        Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        yusongping@huawei.com, christian.koenig@amd.com
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

Applied.  Thanks!

On Thu, Aug 17, 2023 at 7:34=E2=80=AFAM Konstantin Meskhidze
<konstantin.meskhidze@huawei.com> wrote:
>
> Buffer 'afmt_status' of size 6 could overflow, since index 'afmt_idx' is
> checked after access.
>
> Fixes: 5cc4e5fc293b ("drm/radeon: Cleanup HDMI audio interrupt handling f=
or evergreen")
> Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> ---
>  drivers/gpu/drm/radeon/evergreen.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/=
evergreen.c
> index 4f06356d9..f0ae087be 100644
> --- a/drivers/gpu/drm/radeon/evergreen.c
> +++ b/drivers/gpu/drm/radeon/evergreen.c
> @@ -4821,14 +4821,15 @@ int evergreen_irq_process(struct radeon_device *r=
dev)
>                         break;
>                 case 44: /* hdmi */
>                         afmt_idx =3D src_data;
> -                       if (!(afmt_status[afmt_idx] & AFMT_AZ_FORMAT_WTRI=
G))
> -                               DRM_DEBUG("IH: IH event w/o asserted irq =
bit?\n");
> -
>                         if (afmt_idx > 5) {
>                                 DRM_ERROR("Unhandled interrupt: %d %d\n",
>                                           src_id, src_data);
>                                 break;
>                         }
> +
> +                       if (!(afmt_status[afmt_idx] & AFMT_AZ_FORMAT_WTRI=
G))
> +                               DRM_DEBUG("IH: IH event w/o asserted irq =
bit?\n");
> +
>                         afmt_status[afmt_idx] &=3D ~AFMT_AZ_FORMAT_WTRIG;
>                         queue_hdmi =3D true;
>                         DRM_DEBUG("IH: HDMI%d\n", afmt_idx + 1);
> --
> 2.34.1
>
