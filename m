Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95BD77DCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243215AbjHPJI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243214AbjHPJIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:08:09 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78851BF8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:08:08 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-589e590af61so46361087b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1692176888; x=1692781688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4E6y+EsBZT+xa8sFtpV5pHAhyhxp/Z2XFWH1I0j3iY=;
        b=k2SpWvwJV96h7cjYIgbcAulHgYn/SeqI69Ta92U7nJxV/Rb2epbSBTK4byp3Rmssvy
         ei8z6iSXMVHSuo9TokjCpvjSPGSrbC84gYidM3i3g2t2yLwwqI0qSiIS5IREK77PLAPb
         JKNt6V7YGovc6cwJIsYByqMXtZP+eQ71Ncz/boUHrTWcDW0vrseG6ObaXC55iGJ3BvD2
         cCbgJSKNYm+8nN5DwbzLHiT6PrS43DOORmHJ6jQZmgT9DYcEHzk9+Mddz98cGsejuLB6
         v/Cj7qogF/GlfA7E8JYrq+Zx+JiQ3Ms3KjTm++H++s6mQB+KMUbKKtiu7aNL5ZUcuFiu
         YH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692176888; x=1692781688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4E6y+EsBZT+xa8sFtpV5pHAhyhxp/Z2XFWH1I0j3iY=;
        b=BDAGol61tOq6EXqK1ENNjR5vNVUtc3BVcM7GEzYML3sUtRxYkFABGYSqLE7wKJxXRz
         cq62LzOAFJyCEyU3d2cJc9UjXtA7XlYF0m91BvpPwtcbpjP4lGHVp/s1C57cwZPJWf8e
         pCtjOyj2hYyYrPu8y//CigpEiRI4Q7oxdNyDWWbBNsDe/CuJbAk8UrKCk6Ui3RdV2DtH
         l8J39MpQk01PhtqF9uYmmKS4YSjGDoG3Uag+55Fk3B14eSd527hRU0gigS6dI2EApwaq
         1/VqWuI0CW8IWR3CH3j4f7crpIkdcAr2Zn6c4QJ9VZF30vN50kybgo0EFJsZhEOL+lfw
         cwdw==
X-Gm-Message-State: AOJu0Yys9Fxw6kdu9cycMq8w0U90PYmXFttZ1AL3OYvpIC1+z78ezBde
        TvLeM3X0Pk44H3k936QlIXsyFY8SD5irGBtDZctw+A==
X-Google-Smtp-Source: AGHT+IHs3/3TrKxg3s9PVZt7PqVQ46mOv8b7b4u/wLYVkSAhu+ZR5b9bIvK6MhNsKqncE6TPb64oJar7x9WLjBTwuTA=
X-Received: by 2002:a0d:d649:0:b0:583:7564:49de with SMTP id
 y70-20020a0dd649000000b00583756449demr1616392ywd.3.1692176887862; Wed, 16 Aug
 2023 02:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230803092308.79197-1-lma@semihalf.com>
In-Reply-To: <20230803092308.79197-1-lma@semihalf.com>
From:   Lukasz Majczak <lma@semihalf.com>
Date:   Wed, 16 Aug 2023 11:07:56 +0200
Message-ID: <CAFJ_xbqoVjXQXJZ0krbsRqUOe3hLNubi12r_q=idSgkfeV=LRQ@mail.gmail.com>
Subject: Re: [PATCH] drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Guenter Roeck <linux@roeck-us.net>, upstream@semihalf.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 3 sie 2023 o 11:23 Lukasz Majczak <lma@semihalf.com> napisa=C5=82(a):
>
> Check mgr->mst_primary, before passing it to
> the get_mst_branch_device_by_guid_helper(), otherwise NULL dereference
> may occur in the call to memcpy() and cause:
>
> [12579.365869] BUG: kernel NULL pointer dereference, address: 00000000000=
00049
> [12579.365878] #PF: supervisor read access in kernel mode
> [12579.365880] #PF: error_code(0x0000) - not-present page
> [12579.365882] PGD 0 P4D 0
> [12579.365887] Oops: 0000 [#1] PREEMPT SMP NOPTI
> ...
> [12579.365895] Workqueue: events_long drm_dp_mst_up_req_work
> [12579.365899] RIP: 0010:memcmp+0xb/0x29
> [12579.365921] Call Trace:
> [12579.365927] get_mst_branch_device_by_guid_helper+0x22/0x64
> [12579.365930] drm_dp_mst_up_req_work+0x137/0x416
> [12579.365933] process_one_work+0x1d0/0x419
> [12579.365935] worker_thread+0x11a/0x289
> [12579.365938] kthread+0x13e/0x14f
> [12579.365941] ? process_one_work+0x419/0x419
> [12579.365943] ? kthread_blkcg+0x31/0x31
> [12579.365946] ret_from_fork+0x1f/0x30
>
> Similar check is done in e.g: drm_dp_mst_topology_get_mstb_validated().
>
> Fixes: 5e93b8208d3c ("drm/dp/mst: move GUID storage from mgr, port to onl=
y mst branch")
> Cc: <stable@vger.kernel.org> # 4.14+
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> ---
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index ed96cfcfa304..703cd97b1d11 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -2595,19 +2595,19 @@ static struct drm_dp_mst_branch *
>  drm_dp_get_mst_branch_device_by_guid(struct drm_dp_mst_topology_mgr *mgr=
,
>                                      const uint8_t *guid)
>  {
> -       struct drm_dp_mst_branch *mstb;
> +       struct drm_dp_mst_branch *mstb =3D NULL;
>         int ret;
>
>         /* find the port by iterating down */
>         mutex_lock(&mgr->lock);
> -
> -       mstb =3D get_mst_branch_device_by_guid_helper(mgr->mst_primary, g=
uid);
> -       if (mstb) {
> -               ret =3D drm_dp_mst_topology_try_get_mstb(mstb);
> -               if (!ret)
> -                       mstb =3D NULL;
> +       if (mgr->mst_primary) {
> +               mstb =3D get_mst_branch_device_by_guid_helper(mgr->mst_pr=
imary, guid);
> +               if (mstb) {
> +                       ret =3D drm_dp_mst_topology_try_get_mstb(mstb);
> +                       if (!ret)
> +                               mstb =3D NULL;
> +               }
>         }
> -
>         mutex_unlock(&mgr->lock);
>         return mstb;
>  }
> --
> 2.41.0.640.ga95def55d0-goog
>
Hi,

Is there anything more I should do regarding these changes?

Best regards,
Lukasz
