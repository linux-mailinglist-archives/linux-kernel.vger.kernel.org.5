Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF857FF7CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbjK3RMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjK3RMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:12:15 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5232D7F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:12:21 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fa26074783so607310fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701364340; x=1701969140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaaBtEflyA6x6ruzKE5d6vUTqZ4Td7RnZNZ2C5AvoOU=;
        b=Em1b15avQ+FH/129cmxhm5JL5zNUhoTKMRYRHmI3m2Mz7qSRfqq+AezCfwMbvdFjeo
         /gyL95YSQwhtsP2qauUipbLP3rfbzD3acE6JQKson2zmLS4x6lC+TCp2gorE3CzF17i8
         LveWudBIE45wmu06Nj2YGXmcxtgVM6YhD/UNtck7weEGcHUDTyzB1dV2lEtFJjTw1cw2
         MpFuwLeg+AtdUAarX8l5i4yfvSca2zIOUqvCPLFad+ioVRytd+01azDVcM7m5f/Ywuz6
         Z7I3j6zlpoWNkLt3tW2l1g00T0X0tOTW75YHAClUIlDayX0GTHzQPqFTcnxrWcbDn3Ve
         GpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701364340; x=1701969140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VaaBtEflyA6x6ruzKE5d6vUTqZ4Td7RnZNZ2C5AvoOU=;
        b=WRD1TH8nXL4hkSQmpPR68uSwLmI0cWfz1f9XnWAFKPdlBdRRfy+DI/8w7cLF6iFUqj
         uVarTv2iN2sTF80JJu4z11NeS5TujnVaybaIJRkxrZE/WuD6+LfT9RSTFw+iU7oiRHRX
         3dsCen9XkmtUkAY0kC2g+ve0ZCUCj0fFc+qmO9jimmj/MZ/WtUoDV7RkiwdzlHo/niP0
         vbOWCazM8lBcRjj6Vh9eOA18eIsvljfOYI4CC215e+zWsv/mqYpbUuGZ9XcOXYRDFMSc
         ptw2VkjJjdefBn9HWwDQsUXIB35w2cIwLGK2wZdmMXSYcdSulFFR5NT13NsvpTPa7e4H
         HGDw==
X-Gm-Message-State: AOJu0YzsFS5GdMKe4HAd2t3DGg1sibV5dm3W0hleoInVMn0BKHphD8eL
        3dbMe/US8+cwIV1XSZ62v2+08FNeFXebB1UYhTY=
X-Google-Smtp-Source: AGHT+IHjQP5KfWwohtlFpHuAMVKuCCScyyPSUQ+E7t1/fWX2KSsB9czShnT/buF2h8V7udAhaVLIo/wLJ80NX1wFl+s=
X-Received: by 2002:a05:6870:781b:b0:1fa:1ca3:ced5 with SMTP id
 hb27-20020a056870781b00b001fa1ca3ced5mr25898056oab.4.1701364340063; Thu, 30
 Nov 2023 09:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20230808180416.7567-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20230808180416.7567-1-n.zhandarovich@fintech.ru>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Nov 2023 12:12:08 -0500
Message-ID: <CADnq5_OYYRmDKk1QGSCc+G5JwswycVF4EHcSPV_D0anTZadCjg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: check return value of radeon_ring_lock()
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Tue, Aug 8, 2023 at 2:08=E2=80=AFPM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> In the unlikely event of radeon_ring_lock() failing, its errno return
> value should be processed. This patch checks said return value and
> prints a debug message in case of an error.
>
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
>
> Fixes: 48c0c902e2e6 ("drm/radeon/kms: add support for CP setup on SI")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/gpu/drm/radeon/si.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> index 8d5e4b25609d..df1b2ebc37c2 100644
> --- a/drivers/gpu/drm/radeon/si.c
> +++ b/drivers/gpu/drm/radeon/si.c
> @@ -3611,6 +3611,10 @@ static int si_cp_start(struct radeon_device *rdev)
>         for (i =3D RADEON_RING_TYPE_GFX_INDEX; i <=3D CAYMAN_RING_TYPE_CP=
2_INDEX; ++i) {
>                 ring =3D &rdev->ring[i];
>                 r =3D radeon_ring_lock(rdev, ring, 2);
> +               if (r) {
> +                       DRM_ERROR("radeon: cp failed to lock ring (%d).\n=
", r);
> +                       return r;
> +               }
>
>                 /* clear the compute context state */
>                 radeon_ring_write(ring, PACKET3_COMPUTE(PACKET3_CLEAR_STA=
TE, 0));
> --
> 2.25.1
>
