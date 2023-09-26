Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9CF7AEF07
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjIZOBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:01:21 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6351AFC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:01:14 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-59bf1dde73fso112368017b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695736873; x=1696341673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xHsjPqk6JJBUwczwrhg2APBTdxlZcsovPFUPf8oBcY=;
        b=M9ay2qpQ7AmTwO8+Ktsgpp80OBtSZ/XeqvqK0Wt8fC2KPLmlsX4YXiXNADyURIEHFs
         53zSz2h2yR78iewy4NFMa4kd98GzzJyfBBan2PQ6OrZY9sMO1ehWcgBo+uOXNLlzru5A
         6yYNil9qCZ+88Gie84WkgzHyMVHoBcMxO5hns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695736873; x=1696341673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xHsjPqk6JJBUwczwrhg2APBTdxlZcsovPFUPf8oBcY=;
        b=Zh18h7XW+/lRX1zRJ8Yb7y2S4JdcUfV4NMMs4UicGFR8mWCfQMX7bCPRmqIYlg4IY0
         hTmU+R75szDeyybt0VSo6V/1gJItgcmG119aDFWiJK2OiZNlyKYCGlil48kYiYjzX73K
         tzGg1VFmop76pO0mZkct4HvVhYD+GodfprxO6sm+kc3crTtEWcceuyRHfvPtkFORoN4O
         x0q6IwGd2IRfthfxectYIfq7GGNVZctU4C8n/TnbC2C0dp/RxQtpmN1mZ0gdmxGXZRDo
         0Do3CynU7wIQadOcx8EVKsKVmDZKR1C/2elMZJtMRRY2phGpNu+bCwCiBCnbc1pVv+l9
         VW2w==
X-Gm-Message-State: AOJu0Yxgg/zNQu0bXgMAvy4OySpfQ3WyF2+sEXhC2ht8Bx7el7Nc09Jg
        y2WTrFdvobWFT/D+4RQPF8LPqRnX3xLEQhamvCmumw==
X-Google-Smtp-Source: AGHT+IHRQWjCnf+1z4BiGKGiibQRq7Ph9T+j4h2Pjol7PnCXtpHRP2XwhQG5pMLdECETFZ8LCCzuvpzFQ+pve6GD7Do=
X-Received: by 2002:a81:4f4d:0:b0:586:a170:7dbe with SMTP id
 d74-20020a814f4d000000b00586a1707dbemr9693811ywb.13.1695736873520; Tue, 26
 Sep 2023 07:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230921131201.157767-1-lma@semihalf.com> <20230922063410.23626-1-lma@semihalf.com>
In-Reply-To: <20230922063410.23626-1-lma@semihalf.com>
From:   =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@chromium.org>
Date:   Tue, 26 Sep 2023 16:01:02 +0200
Message-ID: <CADmiTCTHn+XaNqkAZjLmaYUy+6bsb5chue97g3n0bKP7Lcf9_w@mail.gmail.com>
Subject: Re: [PATCH v3] drm/dp_mst: Fix NULL deref in get_mst_branch_device_by_guid_helper()
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>, upstream@semihalf.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 8:34=E2=80=AFAM Lukasz Majczak <lma@semihalf.com> w=
rote:
>
> As drm_dp_get_mst_branch_device_by_guid() is called from
> drm_dp_get_mst_branch_device_by_guid(), mstb parameter has to be checked,
> otherwise NULL dereference may occur in the call to
> the memcpy() and cause following:
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
> As get_mst_branch_device_by_guid_helper() is recursive, moving condition
> to the first line allow to remove a similar one for step over of NULL ele=
ments
> inside a loop.
>
> Fixes: 5e93b8208d3c ("drm/dp/mst: move GUID storage from mgr, port to onl=
y mst branch")
> Cc: <stable@vger.kernel.org> # 4.14+
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> ---
>
> v2->v3:
> * Fixed patch description.
>
>  drivers/gpu/drm/display/drm_dp_mst_topology.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index ed96cfcfa304..8c929ef72c72 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -2574,14 +2574,14 @@ static struct drm_dp_mst_branch *get_mst_branch_d=
evice_by_guid_helper(
>         struct drm_dp_mst_branch *found_mstb;
>         struct drm_dp_mst_port *port;
>
> +       if (!mstb)
> +               return NULL;
> +
>         if (memcmp(mstb->guid, guid, 16) =3D=3D 0)
>                 return mstb;
>
>
>         list_for_each_entry(port, &mstb->ports, next) {
> -               if (!port->mstb)
> -                       continue;
> -
>                 found_mstb =3D get_mst_branch_device_by_guid_helper(port-=
>mstb, guid);
>
>                 if (found_mstb)
> --
> 2.42.0.515.g380fc7ccd1-goog
>

Reviewed-by: Radoslaw Biernacki <rad@chromium.org>
