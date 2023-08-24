Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41E1786A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbjHXInE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbjHXIm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CF21725
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692866528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKYRtl5Yx0hEY4pWR4M/Uy6QWBRCM4DzVDpLi45xd5M=;
        b=QTuAbSaXmMUsFMQ4n2JrIqeIuhkJX1zl1Q30OFUOjzvJDMGBh0Yv6tsa5sfAZL0gzbp5yc
        UP6CGUGYIHjqr+Pw4WANPS7AIIaV0xfoprs/2PbKaOMIzRc0BHJlmbLVQjMBUqUl+SX6yT
        jvycW1UezZv4K7Vu5Pd1ey4ZksxCYOs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-iOtZpJiJNxW4y9UEP8OP3w-1; Thu, 24 Aug 2023 04:42:06 -0400
X-MC-Unique: iOtZpJiJNxW4y9UEP8OP3w-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b6fdb8d0acso18914591fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866525; x=1693471325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKYRtl5Yx0hEY4pWR4M/Uy6QWBRCM4DzVDpLi45xd5M=;
        b=j2peHgnavfmaCdYQWWLd1CxvPb3KFjR7gPQrzDZUN/ZNOKwY8LbOkNw43tjVSlNxvs
         vEzibFw08rx+atbL2dK0w7S/EsuCQzGvwwsCh3QHdTqFtLleB9PkwZkQlYZjc/eJy3mo
         YawlJsckvLOLOLHjEBo/2Bq3qgWjE2vaYRELmZmx2bI/eRPAqyg3q+PSofpkwdR8LPWO
         Gth/o+2+Wor8rteBSl3h6Jhus8hliCy0UYkCdEDac6M8+IE+DNY3lOKRAXbePgqHMRrZ
         rfAbeOmR89JLemzNI3+jXY/lSUsUpEDASkSBmbNlmAGQ9Thbaa530fjWdXvxIjZ5/2EH
         ZUVw==
X-Gm-Message-State: AOJu0YyzxkmLNx1nBZmZt/nBRawJ+ydA2PYI51+wGqaICq19y+GEj4T5
        0ioVWQhEsS/A8T5DEoM5gxTSiYpARuVfK8yAAnVkRzj7YsWb6F6uF9J1HlLbiFgkQOrHtCIPDqq
        SXKdmTLuzzuxeH8D3w19VMCcYz9ID0z/cox+47mG0
X-Received: by 2002:a05:651c:1506:b0:2bb:8d47:9d95 with SMTP id e6-20020a05651c150600b002bb8d479d95mr12650901ljf.2.1692866525166;
        Thu, 24 Aug 2023 01:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnemdgzgB9fzCa20Hz7riOR9wmLV3H2dIzPUxCYkPMXh0k1lqvvJuOT31QecoQlOKl2ZqKX8XN+RV2GKh0lM4=
X-Received: by 2002:a05:651c:1506:b0:2bb:8d47:9d95 with SMTP id
 e6-20020a05651c150600b002bb8d479d95mr12650891ljf.2.1692866525008; Thu, 24 Aug
 2023 01:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230824073710.2677348-1-lee@kernel.org> <20230824073710.2677348-6-lee@kernel.org>
In-Reply-To: <20230824073710.2677348-6-lee@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 24 Aug 2023 10:41:53 +0200
Message-ID: <CACO55tv6tqSH-xaM_5iyjJSsaKgeksGD8NXdU6AWi8iVhjhEEg@mail.gmail.com>
Subject: Re: [PATCH 05/20] drm/nouveau/nvkm/engine/gr/gf100: Demote kerneldoc abuse
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 9:37=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:1044: warning: This comme=
nt starts with '/**', but isn't a kernel-doc comment. Refer Documentation/d=
oc-guide/kernel-doc.rst
>
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/gr/gf100.c
> index 3648868bb9fc5..788b1773c46a7 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> @@ -1040,7 +1040,7 @@ gf100_gr_zbc_init(struct gf100_gr *gr)
>         }
>  }
>
> -/**
> +/*
>   * Wait until GR goes idle. GR is considered idle if it is disabled by t=
he
>   * MC (0x200) register, or GR is not busy and a context switch is not in
>   * progress.
> --
> 2.42.0.rc1.204.g551eb34607-goog
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

