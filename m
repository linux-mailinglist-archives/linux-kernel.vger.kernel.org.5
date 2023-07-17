Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55E2756873
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGQP5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjGQP5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694D61A8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA6D161146
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C433C433CD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689609452;
        bh=tvDXX50eV0510jxsIGXoT/FDUwk5Yt+r7BtNl9UglPk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l0JMfhsyT/TjCvHj86lEa2Opnrt4GzAGkH83Z8tUl3CL0qsUKMdnK/EaZNxBbmHg3
         8ulPDN9HOY1KL2Dn4x07yoIoa0YA+TFtI+tqx2ytx/VzkP5Dd4+5aISNz/QrIKVVQA
         DStAns0ALunKPxBmx/OcrUw+ynA4FPAuyjw/S5IZShkPtkceQ9YuxTsEBD0GahrGTH
         J79fyIWaXOr+TRkNCfrbpjrMvRFVuQsr6rQMv29fZOCebeyA5ypx9scl0cJp6VvfUw
         FkK4UOpKOl8agWbRsXf8GtZ8gpBF6fHsLE3pGeE2Buh3EZ8Kn/i0IZ1yNZoj7NDRkX
         ZHKgRfQL022Tg==
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3459baa237bso29512365ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:57:32 -0700 (PDT)
X-Gm-Message-State: ABy/qLZVhy3/yAsdxy2SHgnitj+Mx9GURS/kEGg3ARAesd35BpYGKYSQ
        Hed5QrVc0nVJgdqg9gBVSclWBSQaOiV8ITxy0NTP5A==
X-Google-Smtp-Source: APBJJlEl+sYXDXAF+Ig7ijzeSXsJd0KXiL2sFKWdFkS2p73/g9jU12eFPg+kJhmtwCUDDxPUdk16MFd/8j/syDLB56I=
X-Received: by 2002:a05:6e02:1e07:b0:346:5a8b:53f3 with SMTP id
 g7-20020a056e021e0700b003465a8b53f3mr189745ila.26.1689609451630; Mon, 17 Jul
 2023 08:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230710085922.1871465-1-wenst@chromium.org>
In-Reply-To: <20230710085922.1871465-1-wenst@chromium.org>
From:   Robert Foss <rfoss@kernel.org>
Date:   Mon, 17 Jul 2023 17:57:20 +0200
X-Gmail-Original-Message-ID: <CAN6tsi508WALxzza5VEjm5wiwZrafJa32=+R8SS4vmg-ybqHig@mail.gmail.com>
Message-ID: <CAN6tsi508WALxzza5VEjm5wiwZrafJa32=+R8SS4vmg-ybqHig@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: anx7625: Drop device lock before drm_helper_hpd_irq_event()
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Xin Ji <xji@analogixsemi.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 10:59=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> The device lock is used to serialize the low level power sequencing
> operations. Since drm_helper_hpd_irq_event() could end up calling
> .atomic_enable, which also calls power sequencing functions through
> runtime PM, this results in a real deadlock. This was observed on an
> MT8192-based Chromebook's external display (with appropriate patches [1]
> and DT changes applied).
>
> Move the drm_helper_hpd_irq_event() call outside of the lock range. The
> lock only needs to be held so that the device status can be read back.
> This is the bare minimum change to avoid the deadlock. The lock could
> be dropped completely and have pm_runtime_get_if_in_use() increase the
> reference count, but this is not the same as pm_runtime_suspended().
>
> Dropping the lock completely also causes the internal display of the
> same device to not function correctly if the internal bridge's
> interrupt line is added in the device tree. Both the internal and
> external display of said device each use one anx7625 bridge.
>
> [1] https://lore.kernel.org/dri-devel/20230112042104.4107253-1-treapking@=
chromium.org/
>
> Fixes: 60487584a79a ("drm/bridge: anx7625: refactor power control to use =
runtime PM framework")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - restore early return if event < 0
>
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/=
bridge/analogix/anx7625.c
> index 866d018f4bb1..e93eba89d5ee 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1593,18 +1593,20 @@ static void anx7625_work_func(struct work_struct =
*work)
>
>         mutex_lock(&ctx->lock);
>
> -       if (pm_runtime_suspended(&ctx->client->dev))
> -               goto unlock;
> +       if (pm_runtime_suspended(&ctx->client->dev)) {
> +               mutex_unlock(&ctx->lock);
> +               return;
> +       }
>
>         event =3D anx7625_hpd_change_detect(ctx);
> +
> +       mutex_unlock(&ctx->lock);
> +
>         if (event < 0)
> -               goto unlock;
> +               return;
>
>         if (ctx->bridge_attached)
>                 drm_helper_hpd_irq_event(ctx->bridge.dev);
> -
> -unlock:
> -       mutex_unlock(&ctx->lock);
>  }
>
>  static irqreturn_t anx7625_intr_hpd_isr(int irq, void *data)
> --
> 2.41.0.255.g8b1d071c50-goog
>

LGTM, let's snooze this until next week, incase someone comes up with an is=
sue.

Reviewed-by: Robert Foss <rfoss@kernel.org>
