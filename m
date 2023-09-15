Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00BF7A24F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbjIORgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbjIORgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35ECF30EB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694799285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8Q7NvhKrNUpZ1wyEQLmlUvhyw6KnFkbyTR3LCH8q2k=;
        b=coG/S+6AOpIr3hdP172ULAULP/f9nLfARDJlwDZ/1VafrYy2zdS/gD5w3g0PvFmO961QTl
        0bTklqesOwgiEOyfEajxtCM9x2CgkcBNOF3rFFIdnIYxS9JknZwuGpAyUVX8qF2dne5KmP
        dw9ttlP/D8YzRjAUuOLGyQ0JGyaCYcc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-fXSFP-y7MpCuauT5hfTXhw-1; Fri, 15 Sep 2023 13:34:44 -0400
X-MC-Unique: fXSFP-y7MpCuauT5hfTXhw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-414d7fb4859so25587431cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799283; x=1695404083;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8Q7NvhKrNUpZ1wyEQLmlUvhyw6KnFkbyTR3LCH8q2k=;
        b=ooyNl1YRVeqjjFbJMldpGKhBWiOWhdSfQ8I44sF/P8AxJR/W8wycAYfxdLF/8owc9h
         /2Mtf1Y6rf/7d6uvgHzBgV0mvKf/o674EvvAWsAY10KO5wgygf9MjJy/3cuxer9L6eqc
         ecwCIsDofWRsufcHR8F4SPteUGQXoDwRh8vpkA0+Q0L4mz2na2rTih6JXhHhqeCdwQL+
         6EYZ3mhD9LcLvT6dk3QU7sPPclj0SKx4jC5MdC3uIUOk++7EwTqV+BTFyMZVWj+3lK/P
         lNHMvk6b4+GDB5H54JWY9d8PTBe6p6VCJX4/cgtJR7B9UjXkTh5fvXgwp2YMNrODmzK/
         g+4g==
X-Gm-Message-State: AOJu0Yy47ccX+ZxKjVf0di0f5JIyMUf1XxdzHAdnrDqXFDAvq5knQ1a2
        hPVLm/8AnEG2BOTpqn3wvgRc3R+y2M1LHetw/51qwVTsFD1ptIbIOr5bZQBdm/ZDefyNGaaZZIH
        T91T/vY58G8V4kl/T8A3buhxoV2pvgpUE
X-Received: by 2002:ac8:5701:0:b0:403:cecf:4ade with SMTP id 1-20020ac85701000000b00403cecf4ademr3237069qtw.32.1694799283265;
        Fri, 15 Sep 2023 10:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH23IQ3dxGhZ9gN1USPsCNMq0X92TLWKItrONedXesd3PQqAjirC0kn2Zv9fgi5UN/hQwH9sw==
X-Received: by 2002:ac8:5701:0:b0:403:cecf:4ade with SMTP id 1-20020ac85701000000b00403cecf4ademr3237049qtw.32.1694799283049;
        Fri, 15 Sep 2023 10:34:43 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id b6-20020a05620a126600b007675c4b530fsm1370418qkl.28.2023.09.15.10.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:34:42 -0700 (PDT)
Message-ID: <cf0f001fe5688d956c6a8521af494694377efb5b.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/pm: refactor deprecated strncpy
From:   Lyude Paul <lyude@redhat.com>
To:     Justin Stitt <justinstitt@google.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Fri, 15 Sep 2023 13:34:41 -0400
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-v1-1-4b09ed453f84@google.com>
References: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-v1-1-4b09ed453f84@google.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...oops, responded to the wrong email :P

Reviewed-by: Lyude Paul <lyude@redhat.com>


On Thu, 2023-09-14 at 22:17 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1]=
.
>=20
> We should prefer more robust and less ambiguous string interfaces.
>=20
> A suitable replacement is `strscpy` [2] due to the fact that it guarantee=
s
> NUL-termination on the destination buffer without unnecessarily NUL-paddi=
ng.
>=20
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c b/drivers/gpu/=
drm/nouveau/nvkm/engine/pm/base.c
> index 8fe0444f761e..131db2645f84 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c
> @@ -462,7 +462,7 @@ nvkm_perfmon_mthd_query_domain(struct nvkm_perfmon *p=
erfmon,
> =20
>  		args->v0.id         =3D di;
>  		args->v0.signal_nr  =3D nvkm_perfdom_count_perfsig(dom);
> -		strncpy(args->v0.name, dom->name, sizeof(args->v0.name) - 1);
> +		strscpy(args->v0.name, dom->name, sizeof(args->v0.name));
> =20
>  		/* Currently only global counters (PCOUNTER) are implemented
>  		 * but this will be different for local counters (MP). */
> @@ -513,8 +513,7 @@ nvkm_perfmon_mthd_query_signal(struct nvkm_perfmon *p=
erfmon,
>  			snprintf(args->v0.name, sizeof(args->v0.name),
>  				 "/%s/%02x", dom->name, si);
>  		} else {
> -			strncpy(args->v0.name, sig->name,
> -				sizeof(args->v0.name) - 1);
> +			strscpy(args->v0.name, sig->name, sizeof(args->v0.name));
>  		}
> =20
>  		args->v0.signal =3D si;
> @@ -572,7 +571,7 @@ nvkm_perfmon_mthd_query_source(struct nvkm_perfmon *p=
erfmon,
> =20
>  		args->v0.source =3D sig->source[si];
>  		args->v0.mask   =3D src->mask;
> -		strncpy(args->v0.name, src->name, sizeof(args->v0.name) - 1);
> +		strscpy(args->v0.name, src->name, sizeof(args->v0.name));
>  	}
> =20
>  	if (++si < source_nr) {
>=20
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c=
-38bf9c78bc0f
>=20
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

