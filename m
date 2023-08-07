Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89E6772421
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjHGMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjHGMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:34:40 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60810F3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:34:38 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40c72caec5cso430851cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691411677; x=1692016477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FG/UEllzNChCej8uXILncmRysAuM1vV07T2iwe42JA=;
        b=JpyDvOlj8VBrVqf1QSAgsDbip9pZlub24NJkJgJyyKB/H/DvdYdoxmjreXhlt1XvEP
         BP0DjmArpqwF15QAa3jz91kn+FPVNwL+cRVQ3I/BKEXs07v/DA+dOdarrrjAcNiyXf4Y
         J59sSCESD9TIZf4sTxP8kqwazGIcloy5AMOdFtij0HlIzDpZK5rFOw+zPENKEcfIv/yu
         3B/2arwFsiBhG4ZUeUh0EG1CNngwKQX+VkNkpwxYQodGXSONZrJngAxrxzgNj3Lk++JE
         on7fa7ERhUJGQfqu3LEfqOVs5Rc+FljYUwIM3CcQ4stUUYTtGKEvP5N6gcfr2dKAYfOp
         s2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411677; x=1692016477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FG/UEllzNChCej8uXILncmRysAuM1vV07T2iwe42JA=;
        b=R8e8F4kzbIIjnj1Nal56Jy2OQMSxfvAbTJ6CLEurrpWrRWvKhKd0ozVhXBBLo3burO
         WzwviskS5mS96yOEPDrgCxTTuY73ClelieF2zaKhMHmuITgOLkmg3AJZ5IABAUukv6gm
         BoKti0+SbhaLUOG0byC5cwBN3RDAGldNAjG059sZ3Yq4wCii6Ltvv+D4iwMDR11p7J+O
         GA+11I1K86LS4YrKuLpMw5NxunYLdJlFSmnQvBD5cvviSl002cM9cqXnu1VHE9WX9YZ5
         9V1/X1N5z3/Jt83CEJjLUoXCIvgrwaEg77n+DlAzX6EK3CQ/V06WW4nOWZQmjQSCDpSl
         yriA==
X-Gm-Message-State: AOJu0YyjVnurZ4PnJJoChmY1gg5/cFOXwmZGCiCqRMmaYUXTDvOwiNRz
        N/ZTVssvf9eO671nDQPWHoh0wPsrX1XgY8m3WH7oMQ==
X-Google-Smtp-Source: AGHT+IGFEOfPtttEqEQyisE87Q3lIx5E81ZJFnGZiNcPLZo40nfouDPJGZtep5wdJaynAYrKupNCRJJKkJYsTDd7zVc=
X-Received: by 2002:ac8:7d8c:0:b0:405:3a65:b3d6 with SMTP id
 c12-20020ac87d8c000000b004053a65b3d6mr369753qtd.13.1691411677157; Mon, 07 Aug
 2023 05:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230806075216.13378-1-me@manjusaka.me>
In-Reply-To: <20230806075216.13378-1-me@manjusaka.me>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 7 Aug 2023 14:34:24 +0200
Message-ID: <CANn89i+bMh-xU7PCxf_O5N+vy=83S+V=23mAAmbCuhjuP5Ob9g@mail.gmail.com>
Subject: Re: [PATCH] [RFC PATCH] tcp event: add new tcp:tcp_cwnd_restart event
To:     Manjusaka <me@manjusaka.me>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, davem@davemloft.net,
        dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 6, 2023 at 9:52=E2=80=AFAM Manjusaka <me@manjusaka.me> wrote:
>
> The tcp_cwnd_restart function would be called if the user has enabled the
> tcp_slow_start_after_idle configuration and would be triggered when the
> connection is idle (like LONG RTO etc.). I think it would be great to
> add a new trace event named 'tcp:tcp_cwnd_reset'; it would help people
> to monitor the TCP state in a complicated network environment(like
> overlay/underlay SDN in Kubernetes, etc)
>
> Signed-off-by: Manjusaka <me@manjusaka.me>
> ---
>  include/trace/events/tcp.h | 7 +++++++
>  net/ipv4/tcp_output.c      | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index bf06db8d2046..fa44191cc609 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -187,6 +187,13 @@ DEFINE_EVENT(tcp_event_sk, tcp_rcv_space_adjust,
>         TP_ARGS(sk)
>  );
>
> +DEFINE_EVENT(tcp_event_sk, tcp_cwnd_restart,
> +
> +       TP_PROTO(struct sock *sk),
> +
> +       TP_ARGS(sk)
> +);
> +
>  TRACE_EVENT(tcp_retransmit_synack,
>
>         TP_PROTO(const struct sock *sk, const struct request_sock *req),
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 51d8638d4b4c..e902fa74303d 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -141,6 +141,7 @@ static __u16 tcp_advertise_mss(struct sock *sk)
>   */
>  void tcp_cwnd_restart(struct sock *sk, s32 delta)
>  {
> +       trace_tcp_cwnd_restart(sk);

Do not include code before variable declarations.

>         struct tcp_sock *tp =3D tcp_sk(sk);
>         u32 restart_cwnd =3D tcp_init_cwnd(tp, __sk_dst_get(sk));
>         u32 cwnd =3D tcp_snd_cwnd(tp);
> --
> 2.34.1
>

I would rather add a trace in tcp_ca_event(), this would be more generic ?
