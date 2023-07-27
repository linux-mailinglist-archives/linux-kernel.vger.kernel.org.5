Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D2276467B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjG0GKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjG0GKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA610F9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690438169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IHlsz0LypAsJKen8iGzFwcAD9nS/sYfmhPmKhEwdVpQ=;
        b=NR9fbDUXxTeJ9Af+YNKHQ/jFqi8E05pTcd/Pe9bguiY/x59sfq7i2wN08awQIEabduUcWe
        Kufr7WT6KS2napY3aVHdX0opKr/9h5UEushuxHt8fKlBB2S/EPkhzxiKAw+0GSAF9TgV2b
        JZldoe2UK8cSR4oHcuLH6xtidT2mR/Q=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-WhoqsDmsN1KPmq-m1CkJLA-1; Thu, 27 Jul 2023 02:09:22 -0400
X-MC-Unique: WhoqsDmsN1KPmq-m1CkJLA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9b820c94fso4777591fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690438160; x=1691042960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHlsz0LypAsJKen8iGzFwcAD9nS/sYfmhPmKhEwdVpQ=;
        b=jDAUVy8zxZFMK1OmwiMsyvornMJTcNLeSX+KjG9vxMmsKcHs8gYvfTFuMKlmJSia/f
         gxZaCsMVjZdkE2DfZ01PuhjEAJ3cwiKOiJzJwhiuLPIXj/YObPRITbme5KFa19b9rOug
         ALuBvrufWZs0xKwO8pJFFMw09jd3RD7sie9+IXPL/iK1qBz20QwGrRyf2Y0l6jjBKT3W
         DRIKp520zg63MJ5UvrJo0Q9vA3v7retKqqwQr3yLg8b8ClRc85pfjBMC///KQLx9iff/
         0uF59axaDVC3tV7aZbk89T+7j1UW1SE/52KBGaTSMujCHPO1Hnq8zNDE/Vxg+HSyxiev
         2mCQ==
X-Gm-Message-State: ABy/qLZVjIS4ir88reZGwwSpQ0pnVmssC6N5BN0cA8pn7WOnaz4RRijW
        IayFbaAaeQrr++qPZKW2+pOhqNIX7lc/6WQBiwF+xO56E4W5wjyoMQcBBAQE/mEm1fDu7+SHROn
        YL1GJ7YJXG5tlq4AwGerfjleeIgl/ufH/KL7mDckAEBql78bsZJ8=
X-Received: by 2002:a2e:a0c7:0:b0:2b6:dc55:c3c7 with SMTP id f7-20020a2ea0c7000000b002b6dc55c3c7mr914279ljm.20.1690438160627;
        Wed, 26 Jul 2023 23:09:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG9gSQ6pqMIto55DqQ/PMDpcLyo2v1QAuKSuzXquZGm1GzyjEzrvi1fgxAP/gY2dc9tZHcbKbyVth3agxWpbD4=
X-Received: by 2002:a2e:a0c7:0:b0:2b6:dc55:c3c7 with SMTP id
 f7-20020a2ea0c7000000b002b6dc55c3c7mr914260ljm.20.1690438160346; Wed, 26 Jul
 2023 23:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230726191036.14324-1-dtatulea@nvidia.com>
In-Reply-To: <20230726191036.14324-1-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 27 Jul 2023 14:09:09 +0800
Message-ID: <CACGkMEspMnAQq+mX_eNH9u32m+=7WN69aHi01J_DxSVL6qOiyQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-vdpa: Fix cpumask memory leak in virtio_vdpa_find_vqs()
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Xie Yongji <xieyongji@bytedance.com>, stable@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 3:11=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> From: Gal Pressman <gal@nvidia.com>
>
> Free the cpumask allocated by create_affinity_masks() before returning
> from the function.
>
> Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading m=
echanism")
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/virtio/virtio_vdpa.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 989e2d7184ce..961161da5900 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -393,11 +393,13 @@ static int virtio_vdpa_find_vqs(struct virtio_devic=
e *vdev, unsigned int nvqs,
>         cb.callback =3D virtio_vdpa_config_cb;
>         cb.private =3D vd_dev;
>         ops->set_config_cb(vdpa, &cb);
> +       kfree(masks);
>
>         return 0;
>
>  err_setup_vq:
>         virtio_vdpa_del_vqs(vdev);
> +       kfree(masks);
>         return err;
>  }
>
> --
> 2.41.0
>

