Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E5A7F6923
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjKWWxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWWx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D225D68
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700780015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgkyQVWNEh0w8FRWOuAxuO8xPZdHyxrc2iTVyvbqtKU=;
        b=f4cOZ6NseOX5jeUg4/sS2qaYiIRIAIzRwasASnLhDQVLMhRLSIqUU0bJ0ZiRPo8Ph0pWpu
        SEEFmgx1rLMJjb7FjIK3J34Mh5qxPXwxov+pXx3KPZLzdRoK7aLL1RY8c3Bj9sPLqrulyD
        jgM8D8/knQh3zZoILrh1gQArgPfc4mM=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-AqUnGleSOj6l9hBgcrhKvw-1; Thu, 23 Nov 2023 17:53:34 -0500
X-MC-Unique: AqUnGleSOj6l9hBgcrhKvw-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1f08758b52cso1751563fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700780013; x=1701384813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgkyQVWNEh0w8FRWOuAxuO8xPZdHyxrc2iTVyvbqtKU=;
        b=iewbPq+7BCCXNO3RxSk8tE4Vvh40IVPpyyPqgU+u7rizjbx0FsDmVxuRLVVmKwIlS5
         E0PL5DmyDwbAH83KR2jfT9Y1xJQdQ0fIbrpq7F3Uw/5zVlDNG/EC/G7yr0EX3rfZ6xdn
         5S/DYNafRe9yCwrq4ndzjQSnASTX/W77n/bWazmL4CghQb60BeuHP3LBQAaB19Xfzo4T
         lFEtuA1gs7tFiZS0iSUhY/CSBu8ll62JNbGqQtwbprFY/okig0S5l4Ml2oDk+T3e9KKd
         romhmuQeMFGJ9Pck+jSElaNRiSTAsyQYbZGdXKGLoN6/EnGY4zrfTXEgDfuYAWhqYcbX
         nVTg==
X-Gm-Message-State: AOJu0Yw5Vi2HMxV7jdh44BYnfZzEE4zkKXwQQ+2dKaYSFSrNI2Qkwfso
        6rW8M2V1SZdpYFpCXjDahS0d03m3v5+FDuoSHmDH4olQ95bSow5oinzMUaznsWcJMDVBRGSDxMM
        I+S2IUDgz73zUhDeUQeA99d/PX3gyx3cCV7YQyosm
X-Received: by 2002:a05:6870:ebca:b0:1ef:cedd:5c32 with SMTP id cr10-20020a056870ebca00b001efcedd5c32mr998593oab.3.1700780013306;
        Thu, 23 Nov 2023 14:53:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6HGCbuC2wuf4qW3jUuFH9NOq5sUWsl30jXSKTaMc3yOR1OB7UdxlczqfoO5wGGXUKu8ApVrKHNBUO0CwSip0=
X-Received: by 2002:a05:6870:ebca:b0:1ef:cedd:5c32 with SMTP id
 cr10-20020a056870ebca00b001efcedd5c32mr998579oab.3.1700780013047; Thu, 23 Nov
 2023 14:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20231123183835.635210-1-mkp@redhat.com> <655fc32bb506e_d14d4294b3@willemb.c.googlers.com.notmuch>
In-Reply-To: <655fc32bb506e_d14d4294b3@willemb.c.googlers.com.notmuch>
From:   Mike Pattrick <mkp@redhat.com>
Date:   Thu, 23 Nov 2023 17:53:21 -0500
Message-ID: <CAHcdBH7h-sq=Gzkan1du3uxx44WibK0yzdnUcZCuw-mp=9OxOg@mail.gmail.com>
Subject: Re: [PATCH net-next] packet: Account for VLAN_HLEN in csum_start when
 virtio_net_hdr is enabled
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Mike Pattrick wrote:
> > Af_packet provides checksum offload offsets to usermode applications
> > through struct virtio_net_hdr when PACKET_VNET_HDR is enabled on the
> > socket. For skbuffs with a vlan being sent to a SOCK_RAW socket,
> > af_packet will include the link level header and so csum_start needs
> > to be adjusted accordingly.
>
> Is this patch based on observing an incorrect offset in a workload,
> or on code inspection?

Based on an incorrect offset in a workload. The setup involved sending
vxlan traffic though a veth interface configured with a vlan. The
vnet_hdr's csum_start value was off by 4, and this problem went away
when the vlan was removed.

I'll take another look at this patch.

>
> As the referenced patch mentions, VLAN_HLEN adjustment is needed
> in macvtap because it pulls the vlan header from skb->vlan_tci. At
> which point skb->csum_start is wrong.
>
> "Commit f09e2249c4f5 ("macvtap: restore vlan header on user read")
>  added this feature to macvtap. Commit 3ce9b20f1971 ("macvtap: Fix
>  csum_start when VLAN tags are present") then fixed up csum_start."
>
> But the commit also mentions "Virtio, packet and uml do not insert
> the vlan header in the user buffer.". This situation has not changed.
>
> Packet sockets may receive packets with VLAN headers present, but
> unless they were inserted manually before passing to user, as macvtap
> does, this does not affect csum_start.
>
> Packet sockets support reading those skb->vlan_tci stored VLAN
> headers using AUXDATA.
>
> > Fixes: fd3a88625844 ("net: in virtio_net_hdr only add VLAN_HLEN to csum=
_start if payload holds vlan")
>
> The fix should target net, not net-next.
>
> > Signed-off-by: Mike Pattrick <mkp@redhat.com>
> > ---
> >  net/packet/af_packet.c | 36 ++++++++++++++++++++++++++----------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index a84e00b5904b..f6b602ffe383 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2092,15 +2092,23 @@ static unsigned int run_filter(struct sk_buff *=
skb,
> >  }
> >
> >  static int packet_rcv_vnet(struct msghdr *msg, const struct sk_buff *s=
kb,
> > -                        size_t *len, int vnet_hdr_sz)
> > +                        size_t *len, int vnet_hdr_sz,
> > +                        const struct sock *sk)
> >  {
> >       struct virtio_net_hdr_mrg_rxbuf vnet_hdr =3D { .num_buffers =3D 0=
 };
> > +     int vlan_hlen;
> >
> >       if (*len < vnet_hdr_sz)
> >               return -EINVAL;
> >       *len -=3D vnet_hdr_sz;
> >
> > -     if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_h=
dr, vio_le(), true, 0))
> > +     if (sk->sk_type =3D=3D SOCK_RAW && skb_vlan_tag_present(skb))
> > +             vlan_hlen =3D VLAN_HLEN;
> > +     else
> > +             vlan_hlen =3D 0;
> > +
> > +     if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_h=
dr,
> > +                                 vio_le(), true, vlan_hlen))
> >               return -EINVAL;
> >
> >       return memcpy_to_msg(msg, (void *)&vnet_hdr, vnet_hdr_sz);
> > @@ -2368,13 +2376,21 @@ static int tpacket_rcv(struct sk_buff *skb, str=
uct net_device *dev,
> >               __set_bit(slot_id, po->rx_ring.rx_owner_map);
> >       }
> >
> > -     if (vnet_hdr_sz &&
> > -         virtio_net_hdr_from_skb(skb, h.raw + macoff -
> > -                                 sizeof(struct virtio_net_hdr),
> > -                                 vio_le(), true, 0)) {
> > -             if (po->tp_version =3D=3D TPACKET_V3)
> > -                     prb_clear_blk_fill_status(&po->rx_ring);
> > -             goto drop_n_account;
> > +     if (vnet_hdr_sz) {
> > +             int vlan_hlen;
> > +
> > +             if (sk->sk_type =3D=3D SOCK_RAW && skb_vlan_tag_present(s=
kb))
> > +                     vlan_hlen =3D VLAN_HLEN;
> > +             else
> > +                     vlan_hlen =3D 0;
> > +
> > +             if (virtio_net_hdr_from_skb(skb, h.raw + macoff -
> > +                                         sizeof(struct virtio_net_hdr)=
,
> > +                                         vio_le(), true, vlan_hlen)) {
> > +                     if (po->tp_version =3D=3D TPACKET_V3)
> > +                             prb_clear_blk_fill_status(&po->rx_ring);
> > +                     goto drop_n_account;
> > +             }
> >       }
> >
> >       if (po->tp_version <=3D TPACKET_V2) {
> > @@ -3464,7 +3480,7 @@ static int packet_recvmsg(struct socket *sock, st=
ruct msghdr *msg, size_t len,
> >       packet_rcv_try_clear_pressure(pkt_sk(sk));
> >
> >       if (vnet_hdr_len) {
> > -             err =3D packet_rcv_vnet(msg, skb, &len, vnet_hdr_len);
> > +             err =3D packet_rcv_vnet(msg, skb, &len, vnet_hdr_len, sk)=
;
> >               if (err)
> >                       goto out_free;
> >       }
> > --
> > 2.40.1
> >
>
>

