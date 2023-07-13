Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7140B751CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjGMJMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjGMJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492CB2D46
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689239482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNbtyQ76nBuBqvvqrZSc6orqqyUgVCDr6u2ACe6GE7E=;
        b=PNQ3r49etue1L1nWkcmA32Wgbtrrx3V3ighyRlKSQ+IzZODV+sQajlbkTB39awLRfv3Y+F
        c6pHL/3lopQZxe8AvtiMQjdHa1AWAzrLZ6uYZWrPhRQpdLItdRd7ymlM3la/EQJEYysbCP
        rTUP2GkDCo2gbCxdm558Es4ATeHzXfw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-0J4GCrBoPreNU32yZttXzw-1; Thu, 13 Jul 2023 05:11:18 -0400
X-MC-Unique: 0J4GCrBoPreNU32yZttXzw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b6a4dba654so895801fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689239476; x=1691831476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNbtyQ76nBuBqvvqrZSc6orqqyUgVCDr6u2ACe6GE7E=;
        b=FX3NKp6PaZ/JIb/bpc3Tag3bDzUSILHhG8RS5eTNKWxgS76ZihcqFv139sMw3RCFze
         D4B8+3vjunWS+7o+VuHqrmddPEVsCROwPL9auf+rIgBhs/FQV9ul8S+kO7e8J56moOC+
         MnxKt92ug4LxvEvB80icQ4HzkjX7RXV+lv45TcR1xLq4hVd4bFibdvRWO9tOCW2u+dCv
         V1D2VZ/NFUSaBkR8nfgIsxaHKWxMR5DeWg0dpnXU7j/CS+BU8ZGyxclaWRsTAJmJbUvr
         AUS3VHA0SPH/5yVWFsXccafPlFIA5DQbj9ZOKXkXJbIpnOBfAzdxWYT5euzkyEOZEVjS
         abXw==
X-Gm-Message-State: ABy/qLYjEvly/QziSQJSzeU5ocglJjFdb7f96p4EHjh1VWy4k5/FMSg0
        1RjrmYsAWxPq2tTLO2iyAhTHMKxEXxAqN6HfhUO93fKm8ZC5G+wS9Xns0n8UN0FUnbPTH4bh556
        YMfrB+7ysLW4JeiKLJPTM7kmvLsnNsf2mPaQaVy49
X-Received: by 2002:a2e:be10:0:b0:2b7:2ca0:989a with SMTP id z16-20020a2ebe10000000b002b72ca0989amr920198ljq.5.1689239476623;
        Thu, 13 Jul 2023 02:11:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFw0DuOdoAUA01Xd1FeaBlxKLaI+Rdgpiyi8L3qD/rUV/T0VD7an8HsyTVLGisDJzNOpGN7qGOhAvSEwkaj3i8=
X-Received: by 2002:a2e:be10:0:b0:2b7:2ca0:989a with SMTP id
 z16-20020a2ebe10000000b002b72ca0989amr920186ljq.5.1689239476330; Thu, 13 Jul
 2023 02:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230710032131.52747-1-xujianghui@cdjrlc.com> <decd9e6f68cbebda22d6648fa7b9b737@208suo.com>
In-Reply-To: <decd9e6f68cbebda22d6648fa7b9b737@208suo.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 13 Jul 2023 11:11:05 +0200
Message-ID: <CACO55tut_20kwHC4-0fkkyGrh0sLrRO2e6TVCuUL_q7vuz+tPw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/nvkm: do not use assignment in if condition
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 9:23=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Assignments in if condition are less readable and error-prone.  Fixes
> also checkpatch warning:
>
> ERROR: do not use assignment in if condition
>
> Signed-off-by:Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
> index 976539de4220..054fa42f1d04 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c
> @@ -286,7 +286,8 @@ nvkm_i2c_new_(const struct nvkm_i2c_func *func,
> struct nvkm_device *device,
>
>           if (ccbE.share !=3D DCB_I2C_UNUSED) {
>               const int id =3D NVKM_I2C_PAD_HYBRID(ccbE.share);
> -            if (!(pad =3D nvkm_i2c_pad_find(i2c, id)))
> +            pad =3D nvkm_i2c_pad_find(i2c, id);
> +            if (!pad)
>                   ret =3D func->pad_s_new(i2c, id, &pad);
>               else
>                   ret =3D 0;
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

