Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3455F7A24F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbjIORgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbjIORf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79FF430E9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694799215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlpIc4DwS1d7tWoYWtATBVAp1YG/9Jib85DcTdMBUWQ=;
        b=P0064uweYcVfMTVYtnfsOT4fGf3B1yTDMSW1fQLcQ3PamZVW22+GIuFg2sM58eVn+M5Uii
        MFdBliweBzOkGDWehF3qdP7y2Hw41KnXRY7LApY2DSUwwxQrfDDNNSd7fW2w2wRLK/5TU1
        PGKNCQciOKq/N/C9l5AuDcVNtMWZ2OM=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-c_J5kVWAMWieZCWcH6G3Tg-1; Fri, 15 Sep 2023 13:33:34 -0400
X-MC-Unique: c_J5kVWAMWieZCWcH6G3Tg-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7a85544b8d4so937909241.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799213; x=1695404013;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlpIc4DwS1d7tWoYWtATBVAp1YG/9Jib85DcTdMBUWQ=;
        b=vT+XVVhF6MpHbBrWtmAz3EhsJdZo9x9ac3DSKHLJ4BguJaUPFd6NmGX+dzGmQ3gGqw
         Om5x1f+KoqspPaJ47HeGCqD8L8iyF8nRdaaN4KPL09hvpEKvMEezCEQmyecdPuHGH0EW
         icqSUH1mQP3nwZn0GVcls1ZZhFLMNxueWyWy5QPuOf1MTrLehFFSfp5Is98FbslIfBQg
         GXnpg3B+L+Mdt35H5ceA04oU7PfD0O3L3lA7iam6h1TLeyaJZFHGDMxjJJHgqX/5f8gC
         hJyOypGnUK41dhsOQ0ieSzeQRyjYqZHNXjmduzlB+HZGfqKgmIrxqmkImfqtMSQFEK7v
         HiXw==
X-Gm-Message-State: AOJu0Yz+zomuhsm5LULSxGid53zu1Le7GbUHHj8FwvtH9iU+JKIZ9NpE
        aPJwkf6zxzJg4j47RUH8RGIujkg4kTZf8dJUB3Qo2/OyYHA9M+7UrWMZ+FlnScK87oRuwYHRtEr
        Thdw7Pbvy/5BPnIKUWmPTrxxT
X-Received: by 2002:a05:6102:445:b0:44e:b11a:8b16 with SMTP id e5-20020a056102044500b0044eb11a8b16mr2136900vsq.13.1694799213552;
        Fri, 15 Sep 2023 10:33:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxMg9innJnBPyO40JOwexxh/opPl5r7RbWdfIe2XJJW9pyDk9tqNYJKPoYihmT01Z0kPQWww==
X-Received: by 2002:a05:6102:445:b0:44e:b11a:8b16 with SMTP id e5-20020a056102044500b0044eb11a8b16mr2136872vsq.13.1694799213203;
        Fri, 15 Sep 2023 10:33:33 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id r19-20020a0ccc13000000b0064f91d410b9sm1409818qvk.128.2023.09.15.10.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:33:32 -0700 (PDT)
Message-ID: <00fba033910961bac96dabe9d7e0435342fd021d.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/core: refactor deprecated strncpy
From:   Lyude Paul <lyude@redhat.com>
To:     Justin Stitt <justinstitt@google.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Fri, 15 Sep 2023 13:33:32 -0400
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-core-firmware-c-v1-1-3aeae46c032f@google.com>
References: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-core-firmware-c-v1-1-3aeae46c032f@google.com>
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

Eek, I didn't realize how many instances of this we had. Thanks for doing t=
his
:)

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2023-09-14 at 21:40 +0000, Justin Stitt wrote:
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
> There is likely no bug in the current implementation due to the safeguard=
:
> > 	cname[sizeof(cname) - 1] =3D '\0';
> ... however we can provide simpler and easier to understand code using
> the newer (and recommended) `strscpy` api.
>=20
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/core/firmware.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c b/drivers/gpu/d=
rm/nouveau/nvkm/core/firmware.c
> index 91fb494d4009..374212da9e95 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/core/firmware.c
> @@ -79,8 +79,7 @@ nvkm_firmware_get(const struct nvkm_subdev *subdev, con=
st char *fwname, int ver,
>  	int i;
> =20
>  	/* Convert device name to lowercase */
> -	strncpy(cname, device->chip->name, sizeof(cname));
> -	cname[sizeof(cname) - 1] =3D '\0';
> +	strscpy(cname, device->chip->name, sizeof(cname));
>  	i =3D strlen(cname);
>  	while (i) {
>  		--i;
>=20
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-core-firmware-c-=
791223838b72
>=20
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

