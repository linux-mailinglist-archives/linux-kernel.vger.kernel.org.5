Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538BF751997
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjGMHOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbjGMHOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:14:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB9D213B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689232311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rbQFF4yS3GMxwkk3pn6/zA31jQ3tbZhDFGj76ueuJQ=;
        b=VErrStRA25u1gwBeOPt/vIlFXKsbpDYBkIhPJMtL2Fm0i/2hotmtLMcjy7a9pjH3+JKMKD
        yczt8rM7W4AwJBHthvLnb4lTcABHjQxSNcq7HZC8UvoLYbh3auU2N7pmkeE6l4duWfqV92
        TKis5Oo5oV+/ZyM3dlGuYHlrxw6USNo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-wziDqvOqNuO2foMwBt_Urw-1; Thu, 13 Jul 2023 03:11:49 -0400
X-MC-Unique: wziDqvOqNuO2foMwBt_Urw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-62dd79f63e0so1115806d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689232308; x=1689837108;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4rbQFF4yS3GMxwkk3pn6/zA31jQ3tbZhDFGj76ueuJQ=;
        b=Qg1OBqdlQ9F87XLVkCtpdZmdNNseB9bhKFm6+JR7oEu0sHPdn3rJKJCFRF0OUw5bMg
         +D1TF78Fj0dFHlKhqdDS6tRcdq8ol1D6xTqF1RY04FbIUOp/Lfn2qtXYpd/6S62iJrhi
         AHy+GN4nEANpbEe/og6LKV6/TrnmSxoUGhj31D2aAlPwWsPMb3CLVa7IfWgw139/TNMu
         8NmiOqP+dIO5+8yDmxp/Hq0NBya5JAg19WElN6CwAMNuVxMIbz/s4Bn6YJyoEova4F3f
         0I1iEO8oY+g5LuV2gYMGd2Q9NgZvu7iQW1sqbpElz8okvqYTnAI4lWvMRtWEVV6ZN1oX
         5/cg==
X-Gm-Message-State: ABy/qLYoqfD5P111vEzs6ICoFnBDNOe0WN/uR3VALaV4oIcZAU8MCdje
        p+73Mg7WztE4wSvahp8LWeLVp0e+qNB7EHUvREvW1NP2KQ8Y04aeOsu2Muu6+RgjBZsDsV9i/NH
        OD8N+UGw8VCLBfTYib09QOqpK
X-Received: by 2002:a05:622a:453:b0:3ff:2a6b:5a76 with SMTP id o19-20020a05622a045300b003ff2a6b5a76mr1023107qtx.5.1689232308748;
        Thu, 13 Jul 2023 00:11:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlErYDj2t9Gqn1bkKhZr8rKPzq+adKKENgLpBmad1q5vqdriwgXadx8H4HdDp5pMraZmaEQwbQ==
X-Received: by 2002:a05:622a:453:b0:3ff:2a6b:5a76 with SMTP id o19-20020a05622a045300b003ff2a6b5a76mr1023080qtx.5.1689232308424;
        Thu, 13 Jul 2023 00:11:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id c7-20020ae9e207000000b00767cfb1e859sm2693833qkc.47.2023.07.13.00.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 00:11:48 -0700 (PDT)
Message-ID: <31b64f509a9b4b8badf8925dddff4269ad572d39.camel@redhat.com>
Subject: Re: [PATCH net] gso: fix GSO_DODGY bit handling for related
 protocols
From:   Paolo Abeni <pabeni@redhat.com>
To:     Yan Zhai <yan@cloudflare.com>, Jason Wang <jasowang@redhat.com>
Cc:     "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Melnychenko <andrew@daynix.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
Date:   Thu, 13 Jul 2023 09:11:44 +0200
In-Reply-To: <CAO3-PboQ1WL4wu+znnrF4kEdNnx42xPNJ_+Oc88bEejW2J-A+Q@mail.gmail.com>
References: <ZK9ZiNMsJX8+1F3N@debian.debian>
         <CACGkMEsy+dFK+BnTg_9K59VX-PzHW_fpwY3SRpUxg-MRyD5HWA@mail.gmail.com>
         <CAO3-PboQ1WL4wu+znnrF4kEdNnx42xPNJ_+Oc88bEejW2J-A+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-12 at 21:58 -0500, Yan Zhai wrote:
> On Wed, Jul 12, 2023 at 9:11=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >=20
> > On Thu, Jul 13, 2023 at 9:55=E2=80=AFAM Yan Zhai <yan@cloudflare.com> w=
rote:
> > >=20
> > > SKB_GSO_DODGY bit indicates a GSO packet comes from an untrusted sour=
ce.
> > > The canonical way is to recompute the gso_segs to avoid device driver
> > > issues. Afterwards, the DODGY bit can be removed to avoid re-check at=
 the
> > > egress of later devices, e.g. packets can egress to a vlan device bac=
ked
> > > by a real NIC.
> > >=20
> > > Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> > > packets.") checks DODGY bit for UDP, but for packets that can be fed
> > > directly to the device after gso_segs reset, it actually falls throug=
h
> > > to fragmentation [1].
> > >=20
> > > Commit 90017accff61 ("sctp: Add GSO support") and commit 3820c3f3e417
> > > ("[TCP]: Reset gso_segs if packet is dodgy") both didn't remove the D=
ODGY
> > > bit after recomputing gso_segs.
> >=20
> > If we try to fix two issues, we'd better use separate patches.
> >=20
> > >=20
> > > This change fixes the GSO_UDP_L4 handling case, and remove the DODGY =
bit
> > > at other places.
> > >=20
> > > Fixes: 90017accff61 ("sctp: Add GSO support")
> > > Fixes: 3820c3f3e417 ("[TCP]: Reset gso_segs if packet is dodgy")
> > > Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 pa=
ckets.")
> > > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > >=20
> > > ---
> > > [1]:
> > > https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaD=
o28KzYDg+A@mail.gmail.com/
> > >=20
> > > ---
> > >  net/ipv4/tcp_offload.c |  1 +
> > >  net/ipv4/udp_offload.c | 19 +++++++++++++++----
> > >  net/ipv6/udp_offload.c | 19 +++++++++++++++----
> > >  net/sctp/offload.c     |  2 ++
> > >  4 files changed, 33 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > > index 8311c38267b5..f9b93708c22e 100644
> > > --- a/net/ipv4/tcp_offload.c
> > > +++ b/net/ipv4/tcp_offload.c
> > > @@ -87,6 +87,7 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb=
,
> > >                 /* Packet is from an untrusted source, reset gso_segs=
. */
> > >=20
> > >                 skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(skb->len, =
mss);
> > > +               skb_shinfo(skb)->gso_type &=3D ~SKB_GSO_DODGY;
> > >=20
> > >                 segs =3D NULL;
> > >                 goto out;
> > > diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> > > index 75aa4de5b731..bd29cf19bb6b 100644
> > > --- a/net/ipv4/udp_offload.c
> > > +++ b/net/ipv4/udp_offload.c
> > > @@ -388,11 +388,22 @@ static struct sk_buff *udp4_ufo_fragment(struct=
 sk_buff *skb,
> > >         if (!pskb_may_pull(skb, sizeof(struct udphdr)))
> > >                 goto out;
> > >=20
> > > -       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> > > -           !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
> > > -               return __udp_gso_segment(skb, features, false);
> > > -
> > >         mss =3D skb_shinfo(skb)->gso_size;
> > > +
> > > +       if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> > > +               if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
> > > +                       /* Packet is from an untrusted source, reset =
actual gso_segs */
> > > +                       skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(sk=
b->len - sizeof(*uh),
> > > +                                                                mss)=
;
> > > +                       skb_shinfo(skb)->gso_type &=3D ~SKB_GSO_DODGY=
;
> > > +
> > > +                       segs =3D NULL;
> > > +                       goto out;
> > > +               } else {
> > > +                       return __udp_gso_segment(skb, features, false=
);
> >=20
> > I think it's better and cleaner to move those changes in
> > __udp_gso_segment() as Willem suggests.
> >=20
> > > +               }
> > > +       }
> > > +
> > >         if (unlikely(skb->len <=3D mss))
> > >                 goto out;
> > >=20
> > > diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
> > > index ad3b8726873e..6857d9f7bd06 100644
> > > --- a/net/ipv6/udp_offload.c
> > > +++ b/net/ipv6/udp_offload.c
> > > @@ -43,11 +43,22 @@ static struct sk_buff *udp6_ufo_fragment(struct s=
k_buff *skb,
> > >                 if (!pskb_may_pull(skb, sizeof(struct udphdr)))
> > >                         goto out;
> > >=20
> > > -               if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
> > > -                   !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
> > > -                       return __udp_gso_segment(skb, features, true)=
;
> > > -
> > >                 mss =3D skb_shinfo(skb)->gso_size;
> > > +
> > > +               if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> > > +                       if (skb_gso_ok(skb, features | NETIF_F_GSO_RO=
BUST)) {
> > > +                               /* Packet is from an untrusted source=
, reset actual gso_segs */
> > > +                               skb_shinfo(skb)->gso_segs =3D DIV_ROU=
ND_UP(skb->len - sizeof(*uh),
> > > +                                                                    =
    mss);
> > > +                               skb_shinfo(skb)->gso_type &=3D ~SKB_G=
SO_DODGY;
> >=20
> > Any reason you want to remove the DODGY here? Is this an optimization?
> > We will lose the chance to recognize/validate it elsewhere.
> >=20
> It is intended as a small optimization. And this is in fact the piece
> I am not fully confident about: after validating the gso_segs at a
> trusted location (i.e. assuming the kernel is the trusted computing
> base), do we need to validate it somewhere else? For example, in our
> scenario, we have a tun/tap device in a net namespace, so the packet
> going out will enter from the tap, get forwarded through an veth, and
> then a vlan backed by a real ethernet interface. If the bit is carried
> over, then at each egress of these devices, we need to enter the GSO
> code, which feels pretty redundant as long as the packet does not
> leave kernel space. WDYT?

As an optimization, I think it should land on a different (net-next)
patch. Additionally I think it should be possible to get a greater gain
adding the  ROBUST feature to virtual devices (but I'm not sure if
syzkaller will be able to use that in nasty ways).

Cheers,

Paolo

