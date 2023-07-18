Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DCC75860F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGRU3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGRU3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:29:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAD81997
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:29:02 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso4667939a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689712141; x=1692304141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deZ6/MphDLbE3b6/WAb1wk5PSC/mFgjmOYT8mAVc0cs=;
        b=dJzYkf6oBwKs5q7adrr0Rogf0Jdj4MhtsOveJaxzWOgKkZTJvVSZYo0ycLFknMfojH
         KSW00cbrsGgMmL4AfjFQEoHwQLSZjOH3HdGYgTSW2iLhvn+YvztBK0F8Ju9QrXZq0ooG
         zpA/sx1h+WGZ/GpdvmgLsAgOh6V0iApcv0iUGsL4yoblgHFantFH8RqhVTibKiE6omK2
         KBzYiFu5OokHgDzSUz2yAUUqnOdJ+KowQYFMqwiMLS6HvGJe//FUG/R07OcbTbOo1vqp
         OTUWFeQLtThSTCgkWd5ecj4ca+VjSo3MmV4zqjdassdWYr+xLcTfc9hdvf9PknqCCDO7
         hhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689712141; x=1692304141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deZ6/MphDLbE3b6/WAb1wk5PSC/mFgjmOYT8mAVc0cs=;
        b=chGBzeBPYYGNrI1TXWTlQSeP5HN3UcYXEIoc7uFt9+HvSRrazFPEEGzlli3Ves7aZc
         7iHhFUVPSY/KRAORgWHh1NBDpRtuq9odg4GEyBNCQpuTKLx318eHwwK7EZQY92PwpERP
         C8Tnk5MMj1phQHmA2iDELNhnSOrYR0tlCNGcZPraHg6Iy+xy+hTE15U+hxXhljPvCVZw
         sFW3T7ddQVpJRndieqerB/xLZuMBUA16U8XZAePFdY8pkIoQEnM8p1JQBdCnsBdD+st/
         wT38VtiLhwtoHHTO0dKn6en4SqWAniqIIod1hLzSTbQukRgOFmFuciHL4zDNwAsiN0hS
         dI2w==
X-Gm-Message-State: ABy/qLaXjnnjLvyoqQ2g06pz6A0ZOBlI9fEwVHt7KWVRbOZ4QG+D1RsA
        xeVvYEhwVwgVUG63k9Lmm8oypuwifKSB1jcKALr6LQ==
X-Google-Smtp-Source: APBJJlEJrixphIFDrx3BZ1Bc05t/6tjoIoX3sCRCf1S64A+HNuLyrFbFua63sUi0wrFA818kiCyV6E16Z1RrXPp6RpU=
X-Received: by 2002:a17:90a:4d8e:b0:263:4815:cb9a with SMTP id
 m14-20020a17090a4d8e00b002634815cb9amr197219pjh.41.1689712141202; Tue, 18 Jul
 2023 13:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZLbYdpWC8zt9EJtq@debian.debian>
In-Reply-To: <ZLbYdpWC8zt9EJtq@debian.debian>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 18 Jul 2023 13:28:49 -0700
Message-ID: <CAKH8qBsZeqchfcYm-pNKjafYwFzGnwzcXDgHfj3Omkm0yWd31A@mail.gmail.com>
Subject: Re: [PATCH] bpf: lwt: do not return NET_XMIT_xxx values on bpf_redirect
To:     Yan Zhai <yan@cloudflare.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:22=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrot=
e:
>
> skb_do_redirect handles returns error code from both rx and tx path.
> The tx path codes are special, e.g. NET_XMIT_CN: they are
> non-negative, and can conflict with LWTUNNEL_XMIT_xxx values. Directly
> returning such code can cause unexpected behavior. We found at least
> one bug that will panic the kernel through KASAN report when we
> accidentally redirect packets to a down or carrier-down device at lwt
> xmit hook:
>
> https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48
>
> Above bug is hit because NET_XMIT_CN is returned by noop_qdisc of the
> down device, and it propagates from dev_queue_xmit all way to the lwt
> logic. Although skb has been freed by the qdisc, it still continues to
> neighbor subsystem and triggers the bug.
>
> This change converts the tx code to proper errors that lwt can consume.
>
> Reported-by: Jordan Griege <jgriege@cloudflare.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  net/core/filter.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 06ba0e56e369..c9cc501ecdc0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2129,6 +2129,11 @@ static inline int __bpf_tx_skb(struct net_device *=
dev, struct sk_buff *skb)
>         ret =3D dev_queue_xmit(skb);
>         dev_xmit_recursion_dec();
>
> +       // We should not return NET_XMIT_xxx here since it will conflict =
with
> +       // LWTUNNEL_XMIT_xxx values. Convert the return value to errno in=
stead.

C++ comments; should be /* */. But, also, maybe they are not really needed?

ret =3D dev_queue_xmit(skb);
if (ret)
        ret =3D net_xmit_errno(ret);

We have a bunch of places with the pattern like this, so probably can
do the same here?

> +       if (unlikely(ret !=3D NET_XMIT_SUCCESS))
> +               ret =3D net_xmit_errno(ret);
> +
>         return ret;
>  }
>
> --
> 2.30.2
>
