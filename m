Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1721177D8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbjHPDEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241438AbjHPDDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E401E6B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692154973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LcFVA2nCdKKYGmq34judjgdk23/81L6bmK0qNCyshhY=;
        b=ZkTARX10V1xzBmVSdxO9ZDl+/C6LvbpFMHPewpkCZFwHZfhLPjTBQdlx+SvysE996JGHTD
        YkmFWtGS/xtWBtfYNxhTBaNlufpeYmHfiGKNglQIQCfl/EhgK3P2brRMC389DgtDxA3WmM
        Iwzb7PFSOM1uga7YUl73FFE/EegeFl8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-lu8SYlvLO7mYc18PFW3xuw-1; Tue, 15 Aug 2023 23:02:52 -0400
X-MC-Unique: lu8SYlvLO7mYc18PFW3xuw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9ba3d6191so59986121fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692154970; x=1692759770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcFVA2nCdKKYGmq34judjgdk23/81L6bmK0qNCyshhY=;
        b=Iw34zpGuY9OvajNXaYy9ulmVJZhaxPuYlqNtPFPxPHZTCXJfxrSQLqIljXbAZwDqXn
         TLEQeD6W3LDn03oZ3UA+IFvDVT994PZX8fHVQlgy5YP4wQIVJe1L6mzZ70GYbFlrMl/R
         M7X4nIiFQambMMT1u7KrU2xUzgbEZ9NCWCK8vKwwJ2709MKTgsIX7Hz54QS9Uigt5zL9
         3hpiOnUqB4u4UQ6jSSAyMOMwYBQEFae8o4qZwXjeWRmcnGAVY7ze4jvv2deQ9F9UoSQR
         19WPrqx38PNUJsWZiHMD73ctN9hfeLgw8PUXMotpl2adZNjjkWqcKTEMjP0wiHTf5c/8
         TTdw==
X-Gm-Message-State: AOJu0YwkkUF6CgsXo9/oN5YBI7WlrujRY7DDycVNlMwFmqTVe0DoQiY8
        4noQ4Ib39NlyUq9ky0rPaIya8rDS93kCt+08ZQALyp8V5FJ9UVvLY2Ql3fZfD2tyoMOP23n7afG
        Vy5UIX8YGLq1gerKAVpawtOhLgv726US8RTFC94BbT80yblOH
X-Received: by 2002:a2e:8814:0:b0:2b9:4b2b:89d8 with SMTP id x20-20020a2e8814000000b002b94b2b89d8mr440962ljh.35.1692154970506;
        Tue, 15 Aug 2023 20:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0nerfHH/tVlMsNPUjH9G3l6KwWiMRn8jUMdqKfEH2bBbtkorV2iB+yCO2UR+wYiUzHgmCo9E47+7OzL0KX1o=
X-Received: by 2002:a2e:8814:0:b0:2b9:4b2b:89d8 with SMTP id
 x20-20020a2e8814000000b002b94b2b89d8mr440953ljh.35.1692154970208; Tue, 15 Aug
 2023 20:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230815083321.533688-1-dtatulea@nvidia.com>
In-Reply-To: <20230815083321.533688-1-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 16 Aug 2023 11:02:39 +0800
Message-ID: <CACGkMEtt55e4Bk9C6dE-jztqhstgR3oi0NiBmOmQpp8hSq+08Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as mlx5_vdpa driver
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 4:33=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> As Eli Cohen moved to other work, I'll be the contact point for
> mlx5_vdpa.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a5863f1b016..c9a9259f4d37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13555,6 +13555,12 @@ F:     Documentation/leds/leds-mlxcpld.rst
>  F:     drivers/leds/leds-mlxcpld.c
>  F:     drivers/leds/leds-mlxreg.c
>
> +MELLANOX MLX5_VDPA DRIVER
> +M:     Dragos Tatulea <dtatulea@nvidia.com>
> +L:     virtualization@lists.linux-foundation.org
> +S:     Supported
> +F:     drivers/vdpa/mlx5/
> +
>  MELLANOX PLATFORM DRIVER
>  M:     Vadim Pasternak <vadimp@nvidia.com>
>  L:     platform-driver-x86@vger.kernel.org
> --
> 2.41.0
>

