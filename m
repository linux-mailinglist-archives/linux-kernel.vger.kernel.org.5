Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F21758C35
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjGSDmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGSDmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:42:38 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D88710E;
        Tue, 18 Jul 2023 20:42:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b71ae5fa2fso95842101fa.0;
        Tue, 18 Jul 2023 20:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689738155; x=1692330155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42DLWrQppHmezzGkUVHbOkS8MWrbz9UmK6GWcAskQbY=;
        b=pGNJirjjUor1iHDIdtX43LQqsqXmmJIicVS0DXbusW97GAGRv2EBmqUcVYGf42aEJI
         93y0RZA1OMsYqvxUMdepBt9UesQgfakc7UisfOnTkyBdIMFqfWY0gBKJqiHfGwHO5gBC
         QJdm5EZVet+u4Q3KcbECQOvxwLfWzDVlLLj44x8Cynj+tsMZeMvprcR66TXxqEX5eLYS
         TLqonofq77GFJiXYCw156UWnAUUgVQnXBoDfqGSn5zCdzhk+DD84MxEuKQnxYjUXJmJt
         s6JhQSkjMYTgK52sn2V9twt/XSi4DLImvsRiLOS5vt9VgEuGx3pQscvpFS5Vu5SLpk9A
         ItLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689738155; x=1692330155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42DLWrQppHmezzGkUVHbOkS8MWrbz9UmK6GWcAskQbY=;
        b=G+aUtIIN4Pqax5IibQJ54+vovqrxx9XhtNLjmcue8o3IdbSM2S22ZwL/uudkEV0Oy8
         1b8GK56zjyP/QE6WcqgBhbAdeFoBUaZdE1aF+VY/5qneR5DbMYhWO3uLJiU1637XRbAc
         GhCfX55ThHA2wt5vp5MLs4V/1tHf+Z9kWQ2hg+BY6h7ImTfzv8lvRRcPWUpemjlu48Cg
         xo3pUzi7uugwOfe5tbqej7Q1joQH3doKaYAcMvnbSSd7aaBw2L027Yu39p66jZfUfRcK
         3fZhYSy32Km8A8S5JUvbQKZKi7MzIAql72ny5O2Uz92Z/2XNHaGq3LeERAC1rbUvUbqT
         49Eg==
X-Gm-Message-State: ABy/qLZXx9hU0BwZoPM4QokwGZL5aw9/YZ/HFChmISut34qdDq2l7y7G
        emDs7+cIHAE+sDcb8JSp11ErGnHlZi3DRyoocdw=
X-Google-Smtp-Source: APBJJlFN6bAz8PyruK95IZJJHNj1qeE2qEzAEy07bdpprkkqLhUV7yUi7UovNXI9r/emv1jkgtz+NrKHKOaF9pILxyA=
X-Received: by 2002:a2e:3315:0:b0:2b6:fa8d:ff91 with SMTP id
 d21-20020a2e3315000000b002b6fa8dff91mr12026176ljc.3.1689738155043; Tue, 18
 Jul 2023 20:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <ZLdY6JkWRccunvu0@debian.debian>
In-Reply-To: <ZLdY6JkWRccunvu0@debian.debian>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 18 Jul 2023 20:42:23 -0700
Message-ID: <CAADnVQJNCEntFEh6pNY2HHwxoua0_2mRky2g2U5tj6XU2eoZog@mail.gmail.com>
Subject: Re: [PATCH v2 net] bpf: do not return NET_XMIT_xxx values on bpf_redirect
To:     Yan Zhai <yan@cloudflare.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 8:30=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> skb_do_redirect handles returns error code from both rx and tx path. The
> tx path codes are special, e.g. NET_XMIT_CN: they are non-negative, and
> can conflict with LWTUNNEL_XMIT_xxx values. Directly returning such code
> can cause unexpected behavior. We found at least one bug that will panic
> the kernel through KASAN report when we are redirecting packets to a
> down or carrier-down device at lwt xmit hook:
>
> https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48
>
> Above bug is hit because NET_XMIT_CN is returned by noop_qdisc of the
> down device, and it propagates from dev_queue_xmit all way to the lwt
> logic. The result is skb that has been freed by the qdisc continues to
> neighbor subsystem and triggers the bug.

I'm struggling to parse the above paragraph.
Where bpf prog is installed?
Is this lwt bpf prog that returns BPF_REDIRECT ?
that redirects to netdev with noop_qdisc ?
What is the topology?

Please add a selftest to make sure we don't regress.

Also pls mark your patch as [PATCH v3 bpf] when you respin.

> This change converts the tx code to proper errors that lwt can consume.
>
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Reported-by: Jordan Griege <jgriege@cloudflare.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
> v2: coding style fix; sent to netdev instead of bpf for bug fixing.
>
> ---
>  net/core/filter.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 06ba0e56e369..8738c7a4701d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2129,6 +2129,9 @@ static inline int __bpf_tx_skb(struct net_device *d=
ev, struct sk_buff *skb)
>         ret =3D dev_queue_xmit(skb);
>         dev_xmit_recursion_dec();
>
> +       if (unlikely(ret > 0))
> +               ret =3D net_xmit_errno(ret);
> +
>         return ret;
>  }
>
> --
> 2.30.2
>
