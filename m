Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F50758BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjGSDV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGSDVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:21:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE01BF7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:21:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e5d9e20ecso9087992a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689736912; x=1692328912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6nGe3/14lsIlAFKvEfl97Na5N58gbsjqham6f34LTI=;
        b=Wv+4+oXQl7HjDsiJtgHXbRji7FkiAndbYjBdgI+lOTSTnCWTHSki+QPrxMg/vtOvSh
         r0iVYBxIjy3Wga8epsor/VmNiFFJfTXP91/upI7QJ6eJAQP/0Hw1HIJ0gpgAlpCrutQS
         sDkFj3Jo4/KxP8goc1v6ulCxpyCWDxYCc/Do0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689736912; x=1692328912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6nGe3/14lsIlAFKvEfl97Na5N58gbsjqham6f34LTI=;
        b=KcZK0UQQD4pYBVktZ5oTGOXPe6GDCMirj2qtgsphRkz+So0lM446c2gUno4Y3HRYMV
         lNFoR3YdmiLg0eV7HoyVaAucHxIten8jTFr+G6hmG0+HUvbv9nIuCkdR8MnROHKqAYkT
         lyVX5gIplULBlVbbBYOTWh5psSeTHraYKPIrInz9rmRAy6fXZ6gwp7OS85JMuovWugrm
         JQkIDv1M8XFW1yoACS29BC7/Lia9ord1qWfTODdmyrsQEA27OavXM0RX5liecbLpYmOM
         6x82YNS/neHQzthTVOFSRg/yqjBD6wPhqg7jEttWna7iBQY4ws1wk4CFmrxVMQsMvMR2
         /MoA==
X-Gm-Message-State: ABy/qLa8quXyzZ18avXqneZkFBLVoZDEncZHyYVOUncKrcNP6kkr4YJG
        85sWZgmPFH43msE/uWP3IOQ6pk59j4IcrhL4rihNoA==
X-Google-Smtp-Source: APBJJlFF1zPR6RZhoXb9k5Shx2JBKFy+oeMXucMQtDZCRUaNOkXMNH9jV9AG0eGzaVc4G/xOkyyTsTlw1zqedF1qjZE=
X-Received: by 2002:aa7:d384:0:b0:51e:309:2e11 with SMTP id
 x4-20020aa7d384000000b0051e03092e11mr1453872edq.36.1689736912402; Tue, 18 Jul
 2023 20:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <ZLbYdpWC8zt9EJtq@debian.debian> <CAKH8qBsZeqchfcYm-pNKjafYwFzGnwzcXDgHfj3Omkm0yWd31A@mail.gmail.com>
In-Reply-To: <CAKH8qBsZeqchfcYm-pNKjafYwFzGnwzcXDgHfj3Omkm0yWd31A@mail.gmail.com>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Tue, 18 Jul 2023 22:21:41 -0500
Message-ID: <CAO3-PbqF_JMyHK2hE=MH9cF3i2xVQ-vpQhdZ7HG4uVM7jan4xw@mail.gmail.com>
Subject: Re: [PATCH] bpf: lwt: do not return NET_XMIT_xxx values on bpf_redirect
To:     Stanislav Fomichev <sdf@google.com>
Cc:     "open list:BPF [NETWORKING] (tc BPF, sock_addr)" 
        <bpf@vger.kernel.org>, kernel-team@cloudflare.com,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:BPF [NETWORKING] (tc BPF, sock_addr)" 
        <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
        Jordan Griege <jgriege@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 3:29=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On Tue, Jul 18, 2023 at 11:22=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wr=
ote:
> >
> > skb_do_redirect handles returns error code from both rx and tx path.
> > The tx path codes are special, e.g. NET_XMIT_CN: they are
> > non-negative, and can conflict with LWTUNNEL_XMIT_xxx values. Directly
> > returning such code can cause unexpected behavior. We found at least
> > one bug that will panic the kernel through KASAN report when we
> > accidentally redirect packets to a down or carrier-down device at lwt
> > xmit hook:
> >
> > https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48
> >
> > Above bug is hit because NET_XMIT_CN is returned by noop_qdisc of the
> > down device, and it propagates from dev_queue_xmit all way to the lwt
> > logic. Although skb has been freed by the qdisc, it still continues to
> > neighbor subsystem and triggers the bug.
> >
> > This change converts the tx code to proper errors that lwt can consume.
> >
> > Reported-by: Jordan Griege <jgriege@cloudflare.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> >  net/core/filter.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 06ba0e56e369..c9cc501ecdc0 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2129,6 +2129,11 @@ static inline int __bpf_tx_skb(struct net_device=
 *dev, struct sk_buff *skb)
> >         ret =3D dev_queue_xmit(skb);
> >         dev_xmit_recursion_dec();
> >
> > +       // We should not return NET_XMIT_xxx here since it will conflic=
t with
> > +       // LWTUNNEL_XMIT_xxx values. Convert the return value to errno =
instead.
>
> C++ comments; should be /* */. But, also, maybe they are not really neede=
d?
>
*facepalm* yes I think we can remove them since the commit message
already covers it...

> ret =3D dev_queue_xmit(skb);
> if (ret)
>         ret =3D net_xmit_errno(ret);
>
> We have a bunch of places with the pattern like this, so probably can
> do the same here?
>
Personally I like an explicit name better, since not all the return
codes use 0 to signal success, e.g. XDP_PASS, TC_ACT_PIPE. But I'd
leave that for future improvements now that all other places use 0 on
this.

thanks
Yan

> > +       if (unlikely(ret !=3D NET_XMIT_SUCCESS))
> > +               ret =3D net_xmit_errno(ret);
> > +
> >         return ret;
> >  }
> >
> > --
> > 2.30.2
> >



--=20

Yan
