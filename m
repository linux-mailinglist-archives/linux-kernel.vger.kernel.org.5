Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D37F5173
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjKVUVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjKVUVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:21:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334229A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700684488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I3BVhZG5LsRAUkYD7e/+h2TH6j1J+jVcWFbi2Qhl1fc=;
        b=G0Nbh4iqBHVTm5efWi6J525mqfzIlHfffkeqj4EJnWd5RBeC+oMcClM5IJTvrlAcwl7u1k
        XOAZmPHjxhg7O+HyxqDMgkzJjVpyH7flMIuYUtkFb1DE1i0qtxZV8umxMQvKpYoyemEuAh
        lpifvUIM9tFXPbOQ5Lw61j7CgCg328c=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-EJqk39iENXSJ7GutywyX9w-1; Wed, 22 Nov 2023 15:21:27 -0500
X-MC-Unique: EJqk39iENXSJ7GutywyX9w-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6cf61d80fafso152974a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684486; x=1701289286;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3BVhZG5LsRAUkYD7e/+h2TH6j1J+jVcWFbi2Qhl1fc=;
        b=go+0xPTBrvIteSTGJvBWNbRyV70LJt1qmH05ApL29Cqt97IVH21SHckjg26One/4qW
         OxB4NSssXLLKo2UJfF1zyavwrY+oMf6oehN2gUVMh8p4Fj0igE8eETeHtpFHRJ/FpEbc
         Ok5chRV9+IktNYFd5YKtOGRyfv8HfPk5p2OZX80dt67HL9nmkADCKoYF2Jo5Eo3hmIFv
         jQ0bft/zvVtNMwUV1KAuLKEheuQvbX9nFSVLiL+lbYe5N7RLQPo5LdiImC2ioQXrgOVw
         5IOuqbrATIpAVFLxxMApskB1MgVtpu/sfGVgaI6EyW7kzN5ITf2OZv5KdtPAHJtOtWJC
         t0WQ==
X-Gm-Message-State: AOJu0YwkaPx3Rb/DucY46imluMIZOCz17qfWIfiDeBvq8a38AKO+9sDC
        GvB4Yr8WAdgmX96CCUwev3esWRQb+xEfpmEx59PRfhMx3ZybWEu7M7uZzn3CxHk/yQMvT2EEP4B
        ptPNh9guO0SbmMt029cqxlpGZ
X-Received: by 2002:a05:6830:4128:b0:6c6:18c7:7ca2 with SMTP id w40-20020a056830412800b006c618c77ca2mr4666273ott.12.1700684486499;
        Wed, 22 Nov 2023 12:21:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvVrkc3v5No4q2mIgbDR41Xqf/9uVqeJ4fBmgbeOkBmOBDHi5mnqK7zdASidj8R5t6NtsvfA==
X-Received: by 2002:a05:6830:4128:b0:6c6:18c7:7ca2 with SMTP id w40-20020a056830412800b006c618c77ca2mr4666252ott.12.1700684486285;
        Wed, 22 Nov 2023 12:21:26 -0800 (PST)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id v7-20020a0c9c07000000b0063d5d173a51sm72337qve.50.2023.11.22.12.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:21:25 -0800 (PST)
Message-ID: <76447329d6aaa46625e5cf6fa72e711a2c5fad50.camel@redhat.com>
Subject: Re: [PATCH -next] drm/nouveau/fifo: Remove duplicated include in
 chan.c
From:   Lyude Paul <lyude@redhat.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, airlied@gmail.com,
        daniel@ffwll.ch, kherbst@redhat.com, dakr@redhat.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Date:   Wed, 22 Nov 2023 15:21:24 -0500
In-Reply-To: <20231122004926.84933-1-yang.lee@linux.alibaba.com>
References: <20231122004926.84933-1-yang.lee@linux.alibaba.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push upstream in a moment

On Wed, 2023-11-22 at 08:49 +0800, Yang Li wrote:
> ./drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c: chid.h is included mor=
e than once.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D7603
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c b/drivers/gp=
u/drm/nouveau/nvkm/engine/fifo/chan.c
> index 87a62d4ff4bd..7d4716dcd512 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
> @@ -24,7 +24,6 @@
>  #include "chan.h"
>  #include "chid.h"
>  #include "cgrp.h"
> -#include "chid.h"
>  #include "runl.h"
>  #include "priv.h"
> =20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

