Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35CD777344
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjHJIpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjHJIpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1426210C7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691657084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/XARBHUNfpKRSnWZ8phWlFKnQY1ySWvTtddZ5XFgCw=;
        b=F8SiwuVboJr5NSvsWeWP5KxNzCCisnzjb3G5IJrTZ4o/E5lwshHIxBNrtyrv02HwN2uULP
        0B2S2oEJvHKYR8pfsarHaXwd18PStEKms5GrfnPRywEELuVcoMlZLZJngg87q/sv3AxVSg
        4V3CSrDQnDj7BFzMixWmlNuPkW8pLjo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-VIf5whNXM6eJna5r9y_65Q-1; Thu, 10 Aug 2023 04:44:42 -0400
X-MC-Unique: VIf5whNXM6eJna5r9y_65Q-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5897d05e878so10093747b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657082; x=1692261882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/XARBHUNfpKRSnWZ8phWlFKnQY1ySWvTtddZ5XFgCw=;
        b=LjcOunUD+79jStg+y2bndw5foZndl88sa27mIGks2YHOivh6FvcUXHcmlDoQ1a+cUP
         wshLX+z+2NrctnOCZEEapfZT+8zqo5yZEannPT9czO0BYUpVPbdpEA3myap4e47UcFyc
         nCuLU0IANGZH5HpUwwXkYn4W7cG+cXkR8i0hz4h4ObnYiUDrxG7jr7TckjCBlTqaCCxz
         YRCe0ORVNGE1OCWmRetAWPU1OlV7bVXZ8pZibpH6CvkQ5N08XTEeKlK1RmcU/UfUCfxG
         wN05mO9oGe4xjZ1yEFv6eNtcVxbXflRnAzRJaY6S0UG71Bj9AaSJ2UjSCS9myjSwuQFe
         1Tcg==
X-Gm-Message-State: AOJu0Ywdn0zdR8aspveTl/5l2cDVLgN8CcGbxY2Cyguoq3YEaxnEbZcF
        4HTTRgwdgWaWqv36JW+hy1MDqNNUsgeka/oZFiXeNKvoUeBBGoTFGxvj/KsK10vC1hKjP+SZUQ0
        g6++ANJkqIsG7zlLDyY6lh2mWgyO4S4xnIS+giq2k0fDKph8Lkus=
X-Received: by 2002:a25:b92:0:b0:d0f:ea4b:1dff with SMTP id 140-20020a250b92000000b00d0fea4b1dffmr1867129ybl.8.1691657082036;
        Thu, 10 Aug 2023 01:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFBo1aUNEaXKYTWOZ5RTaEuRyB2I1Ji4x6yJ0+dGDKLhUKju4Y+wKNw1oJ/Oc5Qi2Wd8yycuFnak4XyYefkPU=
X-Received: by 2002:a25:b92:0:b0:d0f:ea4b:1dff with SMTP id
 140-20020a250b92000000b00d0fea4b1dffmr1867118ybl.8.1691657081820; Thu, 10 Aug
 2023 01:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230810031557.135557-1-yin31149@gmail.com>
In-Reply-To: <20230810031557.135557-1-yin31149@gmail.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Thu, 10 Aug 2023 10:44:05 +0200
Message-ID: <CAJaqyWcex+R_=umJoR2a-FNPmV+cZDKSoLzx1RnM4KzZDCoCAg@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG
 case
To:     Hawkins Jiawei <yin31149@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, 18801353760@163.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Aug 10, 2023 at 5:16=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Kernel uses `struct virtio_net_ctrl_rss` to save command-specific-data
> for both the VIRTIO_NET_CTRL_MQ_HASH_CONFIG and
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG commands.
>
> According to the VirtIO standard, "Field reserved MUST contain zeroes.
> It is defined to make the structure to match the layout of
> virtio_net_rss_config structure, defined in 5.1.6.5.7.".
>
> Yet for the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command case, the `max_tx_vq`
> field in struct virtio_net_ctrl_rss, which corresponds to the
> `reserved` field in struct virtio_net_hash_config, is not zeroed,
> thereby violating the VirtIO standard.
>
> This patch solves this problem by zeroing this field in
> virtnet_init_default_rss().
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>
> TestStep
> =3D=3D=3D=3D=3D=3D=3D=3D
> 1. Boot QEMU with one virtio-net-pci net device with `mq` and `hash`
> feature on, command line like:
>       -netdev tap,vhost=3Doff,...
>       -device virtio-net-pci,mq=3Don,hash=3Don,...
>
> 2. Trigger VIRTIO_NET_CTRL_MQ_HASH_CONFIG command in guest, command
> line like:
>         ethtool -K eth0 rxhash on
>
> Without this patch, in virtnet_commit_rss_command(), we can see the
> `max_tx_vq` field is 1 in gdb like below:
>
>         pwndbg> p vi->ctrl->rss
>         $1 =3D {
>           hash_types =3D 63,
>           indirection_table_mask =3D 0,
>           unclassified_queue =3D 0,
>           indirection_table =3D {0 <repeats 128 times>},
>           max_tx_vq =3D 1,
>           hash_key_length =3D 40 '(',
>           ...
>         }
>
> With this patch, in virtnet_commit_rss_command(), we can see the
> `max_tx_vq` field is 0 in gdb like below:
>
>         pwndbg> p vi->ctrl->rss
>         $1 =3D {
>           hash_types =3D 63,
>           indirection_table_mask =3D 0,
>           unclassified_queue =3D 0,
>           indirection_table =3D {0 <repeats 128 times>},
>           max_tx_vq =3D 0,
>           hash_key_length =3D 40 '(',
>           ...
>         }
>
>  drivers/net/virtio_net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1270c8d23463..8db38634ae82 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2761,7 +2761,7 @@ static void virtnet_init_default_rss(struct virtnet=
_info *vi)
>                 vi->ctrl->rss.indirection_table[i] =3D indir_val;
>         }
>
> -       vi->ctrl->rss.max_tx_vq =3D vi->curr_queue_pairs;
> +       vi->ctrl->rss.max_tx_vq =3D vi->has_rss ? vi->curr_queue_pairs : =
0;
>         vi->ctrl->rss.hash_key_length =3D vi->rss_key_size;
>
>         netdev_rss_key_fill(vi->ctrl->rss.key, vi->rss_key_size);
> --
> 2.34.1
>

