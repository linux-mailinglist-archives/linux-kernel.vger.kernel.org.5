Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1D375A482
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 04:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjGTCs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 22:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGTCs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 22:48:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ACC1FD9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:48:52 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5216569f9e3so344612a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689821330; x=1690426130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6WYVWYrbXb8iJtFoUKTJHuArrTvnYpoCUNdm9ArDBU=;
        b=vcpSq5efiWfRoeEuQ8DIpdemJ/kEyExu1pg4fGvQDP9AqI6EHLqRkrkvQ3LzqedoQ8
         +5eOgLm5sUSffZnSTGRjU1uQV80HONokEyIl5FocvTQvle3W0Ef6LmGvKPf1DRuqce6q
         NB/h5wq2mOhw1TW6bGfFARGLwoTv1d1x9oE90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689821330; x=1690426130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6WYVWYrbXb8iJtFoUKTJHuArrTvnYpoCUNdm9ArDBU=;
        b=CnWxjk42eHKRcjs5Y27WJTAz5PY3PO8u5FetVYMhvnNdovl4E2gBo77KlBXIhkJ+Um
         hqr6xz/yo7j656HdHiEtO7PxigDildobwe7Lnnqy0rgRMmyed30R8jXbVfZmghuQJBG4
         +b6sZlk16SVdnyAqqEc2Sczbg6aIsFjSNq2lFtTMnCQ8lR/AwPXoxKbEQb1X9cNQGIFA
         pTN/cMQIJV/PKVAEXLBqViOASKYQsz51ab/pR/IirmpPHmVJREFdK4lXd+0VwBaFSjkG
         QgcIprfhU2Rj+4HL3UKbg30ommSu+yHGTbQ1EDd1HZjdaxalTf24fkwkuLerbsLcuuGo
         uJoQ==
X-Gm-Message-State: ABy/qLZcfwygTvP/5v66DoQW9Z4+cSmzj6YSLk7H1MGeposFlIxNDRFe
        PD0yCfvcGHnncZQVsbZDa9mj5mjfK2PeUPWwy+UpSA==
X-Google-Smtp-Source: APBJJlE4lJbEWuicmvx7rTLzbS0AdQfZ0xYO09uqtILx/IgDEyJpnJ/Zj1jfL9NtM7jOdCNdJ9odgbHvUeY3HhKVqr4=
X-Received: by 2002:a05:6402:1295:b0:51a:3159:53c7 with SMTP id
 w21-20020a056402129500b0051a315953c7mr3643380edv.30.1689821330554; Wed, 19
 Jul 2023 19:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <ZLdY6JkWRccunvu0@debian.debian> <CAADnVQJNCEntFEh6pNY2HHwxoua0_2mRky2g2U5tj6XU2eoZog@mail.gmail.com>
In-Reply-To: <CAADnVQJNCEntFEh6pNY2HHwxoua0_2mRky2g2U5tj6XU2eoZog@mail.gmail.com>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Wed, 19 Jul 2023 21:48:39 -0500
Message-ID: <CAO3-Pbr_S_1RYk0x4kHbnna=qcYVJ7u9zx9O-TGNcJz3oUQ0FQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] bpf: do not return NET_XMIT_xxx values on bpf_redirect
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jordan Griege <jgriege@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:42=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 18, 2023 at 8:30=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wro=
te:
> >
> > skb_do_redirect handles returns error code from both rx and tx path. Th=
e
> > tx path codes are special, e.g. NET_XMIT_CN: they are non-negative, and
> > can conflict with LWTUNNEL_XMIT_xxx values. Directly returning such cod=
e
> > can cause unexpected behavior. We found at least one bug that will pani=
c
> > the kernel through KASAN report when we are redirecting packets to a
> > down or carrier-down device at lwt xmit hook:
> >
> > https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48
> >
> > Above bug is hit because NET_XMIT_CN is returned by noop_qdisc of the
> > down device, and it propagates from dev_queue_xmit all way to the lwt
> > logic. The result is skb that has been freed by the qdisc continues to
> > neighbor subsystem and triggers the bug.
>
> I'm struggling to parse the above paragraph.
> Where bpf prog is installed?
> Is this lwt bpf prog that returns BPF_REDIRECT ?
> that redirects to netdev with noop_qdisc ?
> What is the topology?
>
Sorry for the confusion. Mentioning noop_qdisc is an explanation of
what happened. The actual trigger is simple: install a bpf program on
lwt route at xmit hook. It bpf_redirect packets to a device FOO. If
FOO is down or carrier-down, redirected packets will crash the kernel.

> Please add a selftest to make sure we don't regress.
>
> Also pls mark your patch as [PATCH v3 bpf] when you respin.
>
Ack

> > This change converts the tx code to proper errors that lwt can consume.
> >
> > Suggested-by: Stanislav Fomichev <sdf@google.com>
> > Reported-by: Jordan Griege <jgriege@cloudflare.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > ---
> > v2: coding style fix; sent to netdev instead of bpf for bug fixing.
> >
> > ---
> >  net/core/filter.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 06ba0e56e369..8738c7a4701d 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2129,6 +2129,9 @@ static inline int __bpf_tx_skb(struct net_device =
*dev, struct sk_buff *skb)
> >         ret =3D dev_queue_xmit(skb);
> >         dev_xmit_recursion_dec();
> >
> > +       if (unlikely(ret > 0))
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
