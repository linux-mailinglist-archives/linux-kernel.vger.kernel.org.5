Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355937BCC13
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 06:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344362AbjJHEgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 00:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344270AbjJHEgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 00:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B305AB9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 21:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696739744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOoZlfZQTFF53TPPF0ugCLV6miB6G9bhMJCsmxI+TZs=;
        b=LbBVEr63IuZ6WK2yoAumZpFigArcGaYG+A3XaPfbI1QvhFwE+n/61/Ixx0SMqBlRcNLNo6
        AQxj29s5KbMfnWguTdcWc+8yYQ6zi1YwfTQHsN6msS8wJSFPKItorfvmts1uupHT7EWAke
        W7iPK2w3+aNDPZ8ydOju/0Rs75sucMM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-5HiHZFchPkmLAY_kd7kc9w-1; Sun, 08 Oct 2023 00:35:43 -0400
X-MC-Unique: 5HiHZFchPkmLAY_kd7kc9w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5043eb2c436so3006755e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 21:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696739742; x=1697344542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOoZlfZQTFF53TPPF0ugCLV6miB6G9bhMJCsmxI+TZs=;
        b=PqvD4x8e2R972O+7xZ9sO3STPybF45NWr0lWRNzVK3R92eOfK5+JoJ9meU4dgapeYZ
         wXGVGDj8aVmsDwTyZcBqGF+JrIPKh6pm3bxw/6+afrWo67ZlHpLLJKd1ZXpwVXCWHRDi
         m7qjoihJINKux0k/bFq01agQFqCVNHv7HPsn2GKg5GBG8ioX5fXJM2witWMzxU/iXBWi
         cp44pF0TWaeH+zKXKW/FsDIz0fC8uAQsWPrUf6ISIavLxN+MN1sdykmlOJ+Y/bI+9LE7
         6HQVsbsgELs7ThoJbK1plTGU4C+rXVPfNV4uyPcWspuswee81erDClaOiHia/xcd5iJC
         z+5A==
X-Gm-Message-State: AOJu0YyrfUFo3xQiMMr2M9JPVuT9Gq75lArP6IA6VIlCBxowYKO3pcPk
        BcaGC4bvLyljjIEvNc55l8VuqjUPzQFzSqAiEXPXNKLVg0GHOZOiy6gtPtRNCrGHua64iTedm7q
        oWR+A7xqRRWjfiykMbWBuCWjun+Z6AO/xByrny5tB
X-Received: by 2002:a19:435c:0:b0:500:91c1:9642 with SMTP id m28-20020a19435c000000b0050091c19642mr10346145lfj.21.1696739741946;
        Sat, 07 Oct 2023 21:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEesW3+LqZnNyyPWhlp2aUtbUAkF/QV4pVuw/g7/p5xHxM6btq/MV1uwbCGf05M1pAxvqEdVbSQyK8H6pYHRZo=
X-Received: by 2002:a19:435c:0:b0:500:91c1:9642 with SMTP id
 m28-20020a19435c000000b0050091c19642mr10346138lfj.21.1696739741529; Sat, 07
 Oct 2023 21:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230926050021.717-1-liming.wu@jaguarmicro.com> <20230926050021.717-2-liming.wu@jaguarmicro.com>
In-Reply-To: <20230926050021.717-2-liming.wu@jaguarmicro.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Sun, 8 Oct 2023 12:35:30 +0800
Message-ID: <CACGkMEujvBtAx=1eTqSrzyjBde=0xpC9D0sRVC7wHHf_aqfqwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/virtio: Add hints when module is not installed
To:     liming.wu@jaguarmicro.com
Cc:     "Michael S . Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, 398776277@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 1:00=E2=80=AFPM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> Need to insmod vhost_test.ko before run virtio_test.
> Give some hints to users.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>
> ---
>  tools/virtio/virtio_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 028f54e6854a..ce2c4d93d735 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -135,6 +135,10 @@ static void vdev_info_init(struct vdev_info* dev, un=
signed long long features)
>         dev->buf =3D malloc(dev->buf_size);
>         assert(dev->buf);
>         dev->control =3D open("/dev/vhost-test", O_RDWR);
> +
> +       if (dev->control < 0)
> +               fprintf(stderr, "Install vhost_test module" \
> +               "(./vhost_test/vhost_test.ko) firstly\n");

There should be many other reasons to fail for open().

Let's use strerror()?

Thanks


>         assert(dev->control >=3D 0);
>         r =3D ioctl(dev->control, VHOST_SET_OWNER, NULL);
>         assert(r >=3D 0);
> --
> 2.34.1
>

