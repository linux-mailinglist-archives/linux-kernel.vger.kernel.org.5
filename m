Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4536C751CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjGMJLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjGMJLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986D11FC8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689239342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hUpFy+8PT4u79LgrjVCf5QWEAaQj/iACvNS6/iRtcoM=;
        b=gnyf3NQJuuwjRfEifZNH+2T2C6rBK/0UZ12f3mkfHtYFfSazK6z7OFxieFabJ6qS6uQiS7
        FxGovzRaU8+xZX0M+/7Y3e3/uLsXtFxkFD3zECjmnsIAAE3qjF6qJsADjWIIEVdTMgQ80z
        hPoiJTWSWrNMRJ6aD8zNkSZi5o0rEd4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-uGsTcrjoPViyH5dUmsUJCQ-1; Thu, 13 Jul 2023 05:09:01 -0400
X-MC-Unique: uGsTcrjoPViyH5dUmsUJCQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b6fdb8d0acso1252481fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239340; x=1689844140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUpFy+8PT4u79LgrjVCf5QWEAaQj/iACvNS6/iRtcoM=;
        b=l19pZreO8F313hr8yn4NsB2a6DTAg0cdz17cPtxnptjRKRXrGzyPdATcfTQUX/hvds
         bE7Ih5p5/Ouwgoj7Pt6331w3x2Gf4WNL2TWJmkgzB4IGBmZCJnH/ARgiyV2W7oAISJjn
         UQibHxv5TiRCIuDf8s4x0wZZ81fNy4poQfaInqzeJNdDdg15Vqoa0HNt6UyGsRWuKABz
         +zjBBxzdrcowlkCgQAU3STWl0xu48zMjfO8Zs/qKnzOII59GG2bi3kOH/9W/gzE6l1na
         kovWGdcdUaH5w50DLhGZjraHLD8XG5DYXeGZPENr32KLXm339TYOkka+ZrNnxyGX27lA
         4Fog==
X-Gm-Message-State: ABy/qLYLUGwbEY7pe9SIciZo+w2HYtcRgHSp4iIb6UXG3RNQUBeqpAI3
        PUnEiYcLMh9qqG49rkXlmdF9DiaafG31PPxiv1/wydQn21RStPWnNH5pYj9zKxVUMnJ7orkFvc8
        ipO3OSHwfEuINIfh7AxeoBQrTisLtwmIozqlIKC0q
X-Received: by 2002:a05:651c:1c7:b0:2b6:9b02:cf1c with SMTP id d7-20020a05651c01c700b002b69b02cf1cmr786692ljn.2.1689239339833;
        Thu, 13 Jul 2023 02:08:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHkkcDpkbmRv5mhgZhEUsmC9uPWxawlczs6fpfBEbxv/TjvIaMUhATKq+oc+c0OgRiAoxO+FmksdCen7QhUoPY=
X-Received: by 2002:a05:651c:1c7:b0:2b6:9b02:cf1c with SMTP id
 d7-20020a05651c01c700b002b69b02cf1cmr786682ljn.2.1689239339523; Thu, 13 Jul
 2023 02:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230710063529.53769-1-xujianghui@cdjrlc.com> <2156ff3c1fcec8914f1493ac6d7cd807@208suo.com>
In-Reply-To: <2156ff3c1fcec8914f1493ac6d7cd807@208suo.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 13 Jul 2023 11:08:48 +0200
Message-ID: <CACO55tuMNXZmuqSCVoRTOanWd5m26sf-nYOW7OHuhwC-gV9GwQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/i2c: do not use assignment in if condition
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

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Mon, Jul 10, 2023 at 9:23=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Assignments in if condition are less readable and error-prone.  Fixes
> also checkpatch warning:
>
> ERROR: do not use assignment in if condition
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busgf119.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busgf119.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busgf119.c
> index 96bbdda0f439..a1cf406ff141 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busgf119.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/busgf119.c
> @@ -85,7 +85,8 @@ gf119_i2c_bus_new(struct nvkm_i2c_pad *pad, int id, u8
> drive,
>   {
>       struct gf119_i2c_bus *bus;
>
> -    if (!(bus =3D kzalloc(sizeof(*bus), GFP_KERNEL)))
> +    bus =3D kzalloc(sizeof(*bus), GFP_KERNEL);
> +    if (!bus)
>           return -ENOMEM;
>       *pbus =3D &bus->base;
>

