Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC3751CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjGMJM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjGMJMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2732D7C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689239455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4W0yrN0Cztq3pwQ9ywn2rhI9G08X2g+8/njUIA/yh2o=;
        b=VC1P3C6YZufs9jt/ZL3xTxI/3Qx98wtnMgyCQ3zubNJ0VDaNnw2RbFmrXfzHCajEYlAqXC
        cRyzf0g3gJHugjf5qXeEua+Ajz2Zu6YvBCrYNPpce3U7s4/EfXfoAj5rz3JIdhSdaJ+e0p
        NfoLazb6GdlUlfxQQM2h8qclW9IV3jw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-pnO3auLYOgCFyP5R0sCFwQ-1; Thu, 13 Jul 2023 05:10:53 -0400
X-MC-Unique: pnO3auLYOgCFyP5R0sCFwQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6c4c018aaso1232671fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239452; x=1689844252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4W0yrN0Cztq3pwQ9ywn2rhI9G08X2g+8/njUIA/yh2o=;
        b=T7j7wYiG3MeTeqTo2TDXZL4lmQ4SjH2VK4QqDG7VsZtXKcBwUr6vVw3qeU+vwAPaIQ
         Q2QAYWrlaQxUn4v2rDeUaqdZf0iK8us4Iqhk/CMlxTxKQ4nnx8mZpAi1j0RTuU301T6V
         83Fv5+gFb9g1CwTJUnnAUoMODv+Hk7j0lREev/trNBmAWznFo11tx9GxSEYwaDlz6zKr
         opdavQD+15DVfMIu2VRz1SKjIjZl9b/53YSsrmcxuIq8+FiYmKJp219H0j1B65jXuOwB
         k/iJozTsmY9Z+jwhWen+C+y2Cwi9V+mXEfJS1W1vO/lgGe0uHD1so8JcUv77URYb1riL
         VHxg==
X-Gm-Message-State: ABy/qLbcvoh+sFcqglhVIH08f6zIJVZxdhVmpNdrLR4tvmyXllUyqY9H
        ynCF1FNwt9O+9jaz0vYVEUktpq2olsiHO5eD4z5zrjWFzWzL9njhNSDxwDPgmzKO90tL0Ix/Wft
        2e7jgw4zOJs7rXkr/rGWqL6L1vUDFESFvMu8zJ1F+
X-Received: by 2002:a05:651c:1a29:b0:2b7:3f55:9cb9 with SMTP id by41-20020a05651c1a2900b002b73f559cb9mr846830ljb.5.1689239452445;
        Thu, 13 Jul 2023 02:10:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFTnbNU5Ab6EvMvIcED79oNwfHqmFNcsSHM5EzDOSFj8yh2O3lsaqjAzj2RLA9IWeT11AKCZtA9u/lc82jnsZY=
X-Received: by 2002:a05:651c:1a29:b0:2b7:3f55:9cb9 with SMTP id
 by41-20020a05651c1a2900b002b73f559cb9mr846805ljb.5.1689239452111; Thu, 13 Jul
 2023 02:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230710072012.54076-1-xujianghui@cdjrlc.com> <0b4bfadaf22077b14fe579c1935058ff@208suo.com>
In-Reply-To: <0b4bfadaf22077b14fe579c1935058ff@208suo.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 13 Jul 2023 11:10:41 +0200
Message-ID: <CACO55ttEnpLTJspqb23RaqNZHms3TM030hZZcFVsBojBskLnDA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/pci: ERROR: "foo * bar" should be "foo *bar"
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 9:23=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
> index 6be87ecffc89..bc51987c5f5f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
> @@ -147,7 +147,7 @@ gk104_pcie_set_link_speed(struct nvkm_pci *pci, enum
> nvkm_pcie_speed speed)
>   }
>
>   static int
> -gk104_pcie_init(struct nvkm_pci * pci)
> +gk104_pcie_init(struct nvkm_pci *pci)
>   {
>       enum nvkm_pcie_speed lnkctl_speed, max_speed, cap_speed;
>       struct nvkm_subdev *subdev =3D &pci->subdev;
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

