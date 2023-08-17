Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F17577FDDD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354392AbjHQS2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354401AbjHQS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:27:51 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C843C20;
        Thu, 17 Aug 2023 11:27:21 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-44acad48bffso16943137.0;
        Thu, 17 Aug 2023 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692296839; x=1692901639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRtAo876cuASoEB01zNxdIhAA/DXPdvYkEysdJ4oMA8=;
        b=mhvWCzwDtA3e2XM05IgesAy3ZTUsbchE6NWIqkycct7TUK6Ute3fUuuO0ZO9Ur4Tmg
         j6+8DK3XmKbiyi6g4i9zeu9uwRyvnEU+CWPXsXbOTwTnAK+yFQG5nUMZSioWSMJlkMHn
         kolYZN7KYfx0pKoUHr+4gPrbozMSA2tRpuJtm+SCpsOacjN2tMvsP0NtzgZWV1zi3u32
         IWKwSAtA8GhSZe0eEMjrp8ST/AhWE0jMMtwn01+Oxb8Ug0bd0wwiez4ghBVcuImn0ZDR
         LpdusGzXdBryW+oU6Ac90BAEik2yBUY/1w4hgjqpOkIfqRp+T9F6LReKqXTy/aED6dRX
         DvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296839; x=1692901639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRtAo876cuASoEB01zNxdIhAA/DXPdvYkEysdJ4oMA8=;
        b=YXgxXFdeBnHydBB94iSLFalTDFeJ4PPqhsgAzbJYUoHAklzLpZJJ2BgmQjd3Dbx+25
         VTmJtXVR+6GrpmwqT170FIARYXULikrxu7maQuoauaVl1lk+lShE5bD2OV1UoOH+m5Ab
         vVQlZTPgQJeBpPbiKOXS3to9S1J/VEjgdxGoVcrk2YtN8Z104jcnWV586jG02XDuMVbu
         XvALz+eFoKZ6smF4cNmiFnv7nEGdWqjFWHeacxPSZB7QrCcifRDte66q7byu8xrg42AO
         oduNrUX9MzbEAKjHIy2NLpX4fF8C4v254WNq39Fi3AYAbccE/QySkBxJXqhLV6l2d63q
         gctg==
X-Gm-Message-State: AOJu0YxL5dHMOKbHxXvFi1kTSLPvIq+fq5DyljKt6zrz79Bx4fj7XPsr
        lArERx0PsPktejT7J2uMTV4UeidUFmqez3KdUX4=
X-Google-Smtp-Source: AGHT+IGBK/rYQtQRwk0IkRT3MnJVQxEOG7oPx8gcBkXKx5X7MyS+nGJUbotmmstWWdhANpXn830fAVvRHjqXdtgbLq0=
X-Received: by 2002:a67:cf07:0:b0:443:5aca:d2dc with SMTP id
 y7-20020a67cf07000000b004435acad2dcmr697912vsl.6.1692296838836; Thu, 17 Aug
 2023 11:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230817151941.18692-1-feliu@nvidia.com>
In-Reply-To: <20230817151941.18692-1-feliu@nvidia.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 17 Aug 2023 14:26:42 -0400
Message-ID: <CAF=yD-KN=-2fhc2nxxzr-bJ5kwQVFken_iTo4sBbuAkjmbn3fQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
To:     Feng Liu <feliu@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Simon Horman <horms@kernel.org>,
        Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:20=E2=80=AFAM Feng Liu <feliu@nvidia.com> wrote:
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
> introducing struct virtio_net_hdr_mrg_rxbuf.

You mean virtio_net_common_hdr?

I'm not sure I follow the reasoning. Because then hdr_len might be
sizeof(virtio_net_hdr_mrg_rxbuf), but sizeof(virtio_net_common_hdr) is
larger. So the same issue remains?

Indeed, everywhere this patches replaces the one with the other, you
have to verify that nothing was using sizeof(*hdr). Which would not be
visible from the truncated patch contents itself.

>
> Change log
> v1->v2
> feedback from Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> feedback from Simon Horman <horms@kernel.org>
> 1. change to use net-next tree.
> 2. move skb_vnet_common_hdr inside kernel file instead of the UAPI header=
.
>
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/virtio_net.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1270c8d23463..03cf744de512 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -303,6 +303,13 @@ struct padded_vnet_hdr {
>         char padding[12];
>  };
>
> +struct virtio_net_common_hdr {
> +       union {
> +               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> +               struct virtio_net_hdr_v1_hash hash_v1_hdr;
> +       };
> +};

Perhaps even add in struct virtio_net_hdr. As that is the original of
the three structs, and all the initial fields overlap.

> +
>  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
>
> @@ -344,9 +351,10 @@ static int rxq2vq(int rxq)
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
> @@ -469,7 +477,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>                                    unsigned int headroom)
>  {
>         struct sk_buff *skb;
> -       struct virtio_net_hdr_mrg_rxbuf *hdr;
> +       struct virtio_net_common_hdr *hdr;
>         unsigned int copy, hdr_len, hdr_padded_len;
>         struct page *page_to_free =3D NULL;
>         int tailroom, shinfo_size;
> @@ -554,7 +562,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>                 give_pages(rq, page);
>
>  ok:
> -       hdr =3D skb_vnet_hdr(skb);
> +       hdr =3D skb_vnet_common_hdr(skb);
>         memcpy(hdr, hdr_p, hdr_len);
>         if (page_to_free)
>                 put_page(page_to_free);
> @@ -966,7 +974,7 @@ static struct sk_buff *receive_small_build_skb(struct=
 virtnet_info *vi,
>                 return NULL;
>
>         buf +=3D header_offset;
> -       memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> +       memcpy(skb_vnet_common_hdr(skb), buf, vi->hdr_len);
>
>         return skb;
>  }
> @@ -1577,7 +1585,8 @@ static void receive_buf(struct virtnet_info *vi, st=
ruct receive_queue *rq,
>  {
>         struct net_device *dev =3D vi->dev;
>         struct sk_buff *skb;
> -       struct virtio_net_hdr_mrg_rxbuf *hdr;
> +       struct virtio_net_common_hdr *common_hdr;
> +       struct virtio_net_hdr_mrg_rxbuf *mrg_hdr;

No more need for this second struct now that we have the union. That's
its whole purpose?
>
>         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>                 pr_debug("%s: short packet %i\n", dev->name, len);
> @@ -1597,18 +1606,19 @@ static void receive_buf(struct virtnet_info *vi, =
struct receive_queue *rq,
>         if (unlikely(!skb))
>                 return;
>
> -       hdr =3D skb_vnet_hdr(skb);
> +       common_hdr =3D skb_vnet_common_hdr(skb);
>         if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> -               virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash =
*)hdr, skb);
> +               virtio_skb_set_hash(&common_hdr->hash_v1_hdr, skb);
>
> -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> +       mrg_hdr =3D &common_hdr->mrg_hdr;
> +       if (mrg_hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>                 skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>
> -       if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> +       if (virtio_net_hdr_to_skb(skb, &mrg_hdr->hdr,
>                                   virtio_is_little_endian(vi->vdev))) {
>                 net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> -                                    dev->name, hdr->hdr.gso_type,
> -                                    hdr->hdr.gso_size);
> +                                    dev->name, mrg_hdr->hdr.gso_type,
> +                                    mrg_hdr->hdr.gso_size);
>                 goto frame_err;
>         }
>
> @@ -2105,7 +2115,7 @@ static int xmit_skb(struct send_queue *sq, struct s=
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
