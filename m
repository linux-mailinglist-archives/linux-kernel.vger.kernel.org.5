Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720E47B4BB7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbjJBGxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 02:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbjJBGxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:53:07 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CA7C9;
        Sun,  1 Oct 2023 23:53:03 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-4529d1238a9so7691583137.3;
        Sun, 01 Oct 2023 23:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696229583; x=1696834383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l+jmeB2VfTAn+b6B+3ppKXZp69RAqjIcox5duaFcYw=;
        b=d9is37bqTFwZtKp+EFKhURrRVPZUmRVwOV1sskBvkO4lD2ZNhuEAALxHOmCoQ2RHfC
         ySPyK/0DF4FVGKevOc07OxzgJXz3iDhNFZ7X7tD4ZIHQINasxXRlnycvocNTdRqzLMtC
         IeLHB05uwTkdEDzkabOdYeXQbYhAJzs6gJ3NVek9oERfU2YtAB6pXAND7zPJ8MJyN8o6
         JV59sh64ABX3N1xiS7G9+MV3qMNZG4/rvJhKKL2EmNIB+abXadfAOoT7PX62M8WeH5+n
         fB1dr1pQI1hmOcdGjR9ODavopnsiiD/ZSWEz24vORz2X5GZ5xV3YQ9ZBYZCvc+40xwpf
         F5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696229583; x=1696834383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6l+jmeB2VfTAn+b6B+3ppKXZp69RAqjIcox5duaFcYw=;
        b=Wdc/drctqAdi2bAxQ4SQiSy415llzAHVD9nvI4GEseNcxm/DMUhR9yUudcwuXwUsc4
         8m44JH9g2pdkvLGxQUCmLNsmJXRJr2FSQqynUg9Bz9sBMsprhUcj0lv20AMPh47zBk0h
         BmMk364VluoOHzoD6Shi63EAG8xIYjivv/QK95VjbLaxNHSbfhkSwQRp/TjCf7dI6nzb
         bFY2H5PigSJ4BcpDwqBiwsuYvzgn4GUc2bcjdXd6wANN5xriDu456tBUFfo+iFdedI9Y
         rC5f7J3PMeFrs7FOY4dTVRn6Kn3F4tUukq2nhlZAYJ/hLiEz1lMZEbNnRIx/zSWJF6Ap
         9EZw==
X-Gm-Message-State: AOJu0YxbY+RTo858GWeR1kJXko+/1BoVhmnCxce5Za/5Wl5UmBmWF+Wf
        szeg06uw2SyLcGbhbjAzvK4cpsccBvKvPVnocNc=
X-Google-Smtp-Source: AGHT+IHEWJBqMBCVUZ8gONTAN9/9lSmcfocSJE4xfoGOl0sVAuwUbcCSDed6NgsEQo2eC+da2oqM2nBObo1igJnn6Q8=
X-Received: by 2002:a67:f71a:0:b0:44e:ab53:6152 with SMTP id
 m26-20020a67f71a000000b0044eab536152mr9446139vso.29.1696229582591; Sun, 01
 Oct 2023 23:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <ZRcOXJ0pkuph6fko@debian.debian> <20230930110854.GA13787@breakpoint.cc>
In-Reply-To: <20230930110854.GA13787@breakpoint.cc>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 2 Oct 2023 08:52:26 +0200
Message-ID: <CAF=yD-JR8cxEt6JRhmMyBFucyHtbaKrarDh=xN7jeT2obBsCRQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: avoid atomic fragment on GSO packets
To:     Florian Westphal <fw@strlen.de>
Cc:     Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
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

On Sat, Sep 30, 2023 at 1:09=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Yan Zhai <yan@cloudflare.com> wrote:
> > GSO packets can contain a trailing segment that is smaller than
> > gso_size. When examining the dst MTU for such packet, if its gso_size
> > is too large, then all segments would be fragmented. However, there is =
a
> > good chance the trailing segment has smaller actual size than both
> > gso_size as well as the MTU, which leads to an "atomic fragment".
> > RFC-8021 explicitly recommend to deprecate such use case. An Existing
> > report from APNIC also shows that atomic fragments can be dropped
> > unexpectedly along the path [1].
> >
> > Add an extra check in ip6_fragment to catch all possible generation of
> > atomic fragments. Skip atomic header if it is called on a packet no
> > larger than MTU.
> >
> > Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1=
]
> > Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 pr=
ocessing")
> > Reported-by: David Wragg <dwragg@cloudflare.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> >  net/ipv6/ip6_output.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> > index 951ba8089b5b..42f5f68a6e24 100644
> > --- a/net/ipv6/ip6_output.c
> > +++ b/net/ipv6/ip6_output.c
> > @@ -854,6 +854,13 @@ int ip6_fragment(struct net *net, struct sock *sk,=
 struct sk_buff *skb,
> >       __be32 frag_id;
> >       u8 *prevhdr, nexthdr =3D 0;
> >
> > +     /* RFC-8021 recommended atomic fragments to be deprecated. Double=
 check
> > +      * the actual packet size before fragment it.
> > +      */
> > +     mtu =3D ip6_skb_dst_mtu(skb);
> > +     if (unlikely(skb->len <=3D mtu))
> > +             return output(net, sk, skb);
> > +
>
> This helper is also called for skbs where IP6CB(skb)->frag_max_size
> exceeds the MTU, so this check looks wrong to me.
>
> Same remark for dst_allfrag() check in __ip6_finish_output(),
> after this patch, it would be ignored.
>
> I think you should consider to first refactor __ip6_finish_output to make
> the existing checks more readable (e.g. handle gso vs. non-gso in separat=
e
> branches) and then add the check to last seg in
> ip6_finish_output_gso_slowpath_drop().
>
> Alternatively you might be able to pass more info down to
> ip6_fragment and move decisions there.
>
> In any case we should make same frag-or-no-frag decisions,
> regardless of this being the orig skb or a segmented one,

To add to that: if this is a suggestion to update the algorithm to
match RFC 8021, not a fix for a bug in the current implementation,
then I think this should target net-next.

That will also make it easier to include the kind of refactoring that
Florian suggests.
