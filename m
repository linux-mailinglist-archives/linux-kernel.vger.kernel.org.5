Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF74A784DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 02:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjHWAhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 20:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjHWAhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 20:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A4CFF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692750988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2IL+cZp/0HHCpa5Ko71FJgAGVSdljaI2sGgMww+L4A=;
        b=FBbzeja4mHHuACvtrAFC0m++jEZELNkq5mnNY3HVYk97ujEFlpXpYK4gH0opszR6cDm6qU
        l65RbkHHXqPrZHVDK3zKgl0x9w/kR6pR2KS2YmbRf8baimVQprQZAlpHgtMZLakUL/qM4N
        EEqXBOXekCc7CmK58eq+hDlnmzIvz6A=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695--AkQ53xLP6-vyq2u2KxGIg-1; Tue, 22 Aug 2023 20:36:27 -0400
X-MC-Unique: -AkQ53xLP6-vyq2u2KxGIg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bbbaa6001dso46192161fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 17:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692750985; x=1693355785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2IL+cZp/0HHCpa5Ko71FJgAGVSdljaI2sGgMww+L4A=;
        b=Y9URvcsN8Z6fyMkYWtUJXPxYtX+qLD55dzN9R39AdLEJW9lBJN4WEILVAjNYds2uIl
         z2jACrS66eeGXDy9V0wr9Ygg9MzEhjEkr0ZGzLgtlTy/2/D+4DcXFz5yTln5hb8D87CR
         T38/iSmeYjVR3FvMbejTzTK9gJsBXYMOWhp8nDKzr2FRMuWZaqKdhUiQvA4aWYYo0kpS
         sG7WJsVN2WNI8etKVOuPV4YYmLdiyykfXEFtzk7uHLXQCLG9lQMGo45GXXocUrtOZgif
         4lIRiSV10HyeqcFT09YDbB0xLvxa+w2pcs8X5y4q1pcKSbjtnXUUWKS/NhRtt2O3GGEt
         i6eA==
X-Gm-Message-State: AOJu0YzkWk9HYX4O4Ng+OcXv/CFCCMFdkawNvGyF6Qd1YhgIJhTugJ8K
        Lif2trXW3P4x7N4aXYdXhPBPMpTMS7vn84ljm4jkY7UVDVn7kXk2PpCll4KNRKewAVUU9SkZyeZ
        DmsFEUnC+JYfzNmaP7WoUL2Qv0nRO0uz+9dg5SffBePUA8xyfALt1XQ==
X-Received: by 2002:a2e:3607:0:b0:2b6:de52:357 with SMTP id d7-20020a2e3607000000b002b6de520357mr8028171lja.40.1692750985670;
        Tue, 22 Aug 2023 17:36:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEFPDsk5hA0Fn4R6rUDIO6eqwFcn1qxMxURYoc60s0yH3huA1vp9eXuhPoq72Mx9oKSgrLLDu1lRa2xVe/Epk=
X-Received: by 2002:a2e:3607:0:b0:2b6:de52:357 with SMTP id
 d7-20020a2e3607000000b002b6de520357mr8028163lja.40.1692750985367; Tue, 22 Aug
 2023 17:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230821142713.5062-1-feliu@nvidia.com>
In-Reply-To: <20230821142713.5062-1-feliu@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 23 Aug 2023 08:36:14 +0800
Message-ID: <CACGkMEvbYCf-TsV+VtNT6iUiHM7s+MOnJ5UZz8yyw2MSifVT5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
To:     Feng Liu <feliu@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:27=E2=80=AFPM Feng Liu <feliu@nvidia.com> wrote:
>
> The virtio_net driver currently deals with different versions and types
> of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
> virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
> on multiple type casts to convert memory between different structures,
> potentially leading to bugs when there are changes in these structures.
>
> Introduces the "struct skb_vnet_common_hdr" as a unifying header
> structure using a union. With this approach, various virtio net header
> structures can be converted by accessing different members of this
> structure, thus eliminating the need for type casting and reducing the
> risk of potential bugs.
>
> For example following code:
> static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>                 struct receive_queue *rq,
>                 struct page *page, unsigned int offset,
>                 unsigned int len, unsigned int truesize,
>                 unsigned int headroom)
> {
> [...]
>         struct virtio_net_hdr_mrg_rxbuf *hdr;
> [...]
>         hdr_len =3D vi->hdr_len;
> [...]
> ok:
>         hdr =3D skb_vnet_hdr(skb);
>         memcpy(hdr, hdr_p, hdr_len);
> [...]
> }
>
> When VIRTIO_NET_F_HASH_REPORT feature is enabled, hdr_len =3D 20
> But the sizeof(*hdr) is 12,
> memcpy(hdr, hdr_p, hdr_len); will copy 20 bytes to the hdr,
> which make a potential risk of bug. And this risk can be avoided by
> introducing struct skb_vnet_common_hdr.
>
> Change log
> v1->v2
> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> feedback from Simon Horman <horms@kernel.org>
> 1. change to use net-next tree.
> 2. move skb_vnet_common_hdr inside kernel file instead of the UAPI header=
.
>
> v2->v3
> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> 1. fix typo in commit message.
> 2. add original struct virtio_net_hdr into union
> 3. remove virtio_net_hdr_mrg_rxbuf variable in receive_buf;
>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e9f4cfe941f..8c74bc8cfe68 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -303,6 +303,14 @@ struct padded_vnet_hdr {
>         char padding[12];
>  };
>
> +struct virtio_net_common_hdr {
> +       union {
> +               struct virtio_net_hdr hdr;
> +               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> +               struct virtio_net_hdr_v1_hash hash_v1_hdr;
> +       };
> +};
> +
>  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>
> @@ -344,9 +352,10 @@ static int rxq2vq(int rxq)
>         return rxq * 2;
>  }
>
> -static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_bu=
ff *skb)
> +static inline struct virtio_net_common_hdr *
> +skb_vnet_common_hdr(struct sk_buff *skb)
>  {
> -       return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
> +       return (struct virtio_net_common_hdr *)skb->cb;
>  }
>
>  /*
> @@ -469,7 +478,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>                                    unsigned int headroom)
>  {
>         struct sk_buff *skb;
> -       struct virtio_net_hdr_mrg_rxbuf *hdr;
> +       struct virtio_net_common_hdr *hdr;
>         unsigned int copy, hdr_len, hdr_padded_len;
>         struct page *page_to_free =3D NULL;
>         int tailroom, shinfo_size;
> @@ -554,7 +563,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>                 give_pages(rq, page);
>
>  ok:
> -       hdr =3D skb_vnet_hdr(skb);
> +       hdr =3D skb_vnet_common_hdr(skb);
>         memcpy(hdr, hdr_p, hdr_len);
>         if (page_to_free)
>                 put_page(page_to_free);
> @@ -966,7 +975,7 @@ static struct sk_buff *receive_small_build_skb(struct=
 virtnet_info *vi,
>                 return NULL;
>
>         buf +=3D header_offset;
> -       memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> +       memcpy(skb_vnet_common_hdr(skb), buf, vi->hdr_len);
>
>         return skb;
>  }
> @@ -1577,7 +1586,7 @@ static void receive_buf(struct virtnet_info *vi, st=
ruct receive_queue *rq,
>  {
>         struct net_device *dev =3D vi->dev;
>         struct sk_buff *skb;
> -       struct virtio_net_hdr_mrg_rxbuf *hdr;
> +       struct virtio_net_common_hdr *hdr;
>
>         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>                 pr_debug("%s: short packet %i\n", dev->name, len);
> @@ -1597,9 +1606,9 @@ static void receive_buf(struct virtnet_info *vi, st=
ruct receive_queue *rq,
>         if (unlikely(!skb))
>                 return;
>
> -       hdr =3D skb_vnet_hdr(skb);
> +       hdr =3D skb_vnet_common_hdr(skb);
>         if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> -               virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash =
*)hdr, skb);
> +               virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
>
>         if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>                 skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> @@ -2105,7 +2114,7 @@ static int xmit_skb(struct send_queue *sq, struct s=
k_buff *skb)
>         if (can_push)
>                 hdr =3D (struct virtio_net_hdr_mrg_rxbuf *)(skb->data - h=
dr_len);
>         else
> -               hdr =3D skb_vnet_hdr(skb);
> +               hdr =3D &skb_vnet_common_hdr(skb)->mrg_hdr;
>
>         if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
>                                     virtio_is_little_endian(vi->vdev), fa=
lse,
> --
> 2.37.1 (Apple Git-137.1)
>

