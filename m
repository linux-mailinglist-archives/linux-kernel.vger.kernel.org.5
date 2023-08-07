Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A7A772705
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjHGOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjHGOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:06:07 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7272113
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:05:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40c72caec5cso457891cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 07:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691417139; x=1692021939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcqZjIjj2ZxSNyzceQClsXuFqdzy2bj8lsXDxxCdwN8=;
        b=NlvsO7B966uRAeNtCDjZUYd2wjihnxbtDr17Tb2TTNUbeyg4F4P9nfCy7ffxV1Hhwr
         PbdupuCQXF/6BoFBzVvVroU1O5jcsm34+baTESmlQZLj5qNOTDg2pvq2CdOEdCORGKVB
         5+veLrMGh4kKE09qq163tGffoyxapnpRxNu4Q4yqNBoK9cg3vAOXFYUGLymmw2GisW2q
         wQrNcTsZNLBAxEwDhRkcEXRz1PJhI8FB2BxZjv6YzD7K5Qqnhtfn8vMTly9iXE4zoGDF
         Nn7OcWUzOo9lVOmP/kVRH1zn9KP42asBwKdFXy74OZs2jObdZkqLExuzOxNPBSjirALk
         TZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691417139; x=1692021939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcqZjIjj2ZxSNyzceQClsXuFqdzy2bj8lsXDxxCdwN8=;
        b=NzMgHnF9MxlZM3MAPZgJzD0opYZJuFuKrbirsWAxyS5ovCiO7FvGiBvjhwyth01BQ7
         +oqxKeVXG9gcr8AzhsKUtpSa9VR/Eau9Y5TqHQrMtB62Ooe17NySyxiU4e8Aq5mlcOLE
         86n8Slaq/3nDXs5d/x02RsSXn+88UunGqlV3b51q1e2JgizqrNlc1ovPGIOVN4gn9+OT
         wlz7Kj5tmnoGVqaEONFwI4NUPqMeW+7ixu8zDL5NcufIDwQZwXUuE/SIZBQg2mIJ5paR
         fSEaQ0u/Stz3fEPkhlwIW0ywSRqirh9Hw0/V+hGucBQ/06hT+Sy02KYesV/uhsjL/D+8
         Y3Gg==
X-Gm-Message-State: AOJu0YwIXMenczB61+kMSg5CjgALJHUWfiDThgbrueFQHp82Wvs/fFQW
        dp8/J6eKTDYEvsKA2eqHlOUGwZkD/mCb/CAXHWgm1Q==
X-Google-Smtp-Source: AGHT+IHjQ78yMRA0AmnG+lEoFynqSj8ZnHgM/YZEuMi8NhbDiJi/kq/CdaDz/qYXNKtI5TU7cLzFmjS3nRyNETlNofw=
X-Received: by 2002:ac8:5951:0:b0:403:96e3:4745 with SMTP id
 17-20020ac85951000000b0040396e34745mr483057qtz.20.1691417138942; Mon, 07 Aug
 2023 07:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230807134547.2782227-1-imagedong@tencent.com> <20230807134547.2782227-2-imagedong@tencent.com>
In-Reply-To: <20230807134547.2782227-2-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 7 Aug 2023 16:05:27 +0200
Message-ID: <CANn89iJ762Y3KvL26-3s9vkZdkWi9PoJXhzLHr3+5v9Ti47gTw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: tcp: send zero-window ACK when no memory
To:     menglong8.dong@gmail.com
Cc:     ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 3:47=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> For now, skb will be dropped when no memory, which makes client keep
> retrans util timeout and it's not friendly to the users.
>
> In this patch, we reply an ACK with zero-window in this case to update
> the snd_wnd of the sender to 0. Therefore, the sender won't timeout the
> connection and will probe the zero-window with the retransmits.
>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
> v2:
> - send 0 rwin ACK for the receive queue empty case when necessary
> - send the ACK immediately by using the ICSK_ACK_NOW flag
> ---
>  include/net/inet_connection_sock.h |  3 ++-
>  net/ipv4/tcp_input.c               | 14 +++++++++++---
>  net/ipv4/tcp_output.c              | 14 +++++++++++---
>  3 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> index c2b15f7e5516..be3c858a2ebb 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -164,7 +164,8 @@ enum inet_csk_ack_state_t {
>         ICSK_ACK_TIMER  =3D 2,
>         ICSK_ACK_PUSHED =3D 4,
>         ICSK_ACK_PUSHED2 =3D 8,
> -       ICSK_ACK_NOW =3D 16       /* Send the next ACK immediately (once)=
 */
> +       ICSK_ACK_NOW =3D 16,      /* Send the next ACK immediately (once)=
 */
> +       ICSK_ACK_NOMEM =3D 32,
>  };
>
>  void inet_csk_init_xmit_timers(struct sock *sk,
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 8e96ebe373d7..aae485d0a3b6 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5059,12 +5059,20 @@ static void tcp_data_queue(struct sock *sk, struc=
t sk_buff *skb)
>
>                 /* Ok. In sequence. In window. */
>  queue_and_out:
> -               if (skb_queue_len(&sk->sk_receive_queue) =3D=3D 0)
> -                       sk_forced_mem_schedule(sk, skb->truesize);
> -               else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
> +               if (skb_queue_len(&sk->sk_receive_queue) =3D=3D 0) {
> +                       if (tcp_try_rmem_schedule(sk, skb, skb->truesize)=
) {
> +                               sk_forced_mem_schedule(sk, skb->truesize)=
;

I think we want sk->sk_data_ready() here, to let applications drain the que=
ue,
regardless of sk->sk_rcvlowat value.


> +                               inet_csk(sk)->icsk_ack.pending |=3D
> +                                       (ICSK_ACK_NOMEM | ICSK_ACK_NOW);
> +                               inet_csk_schedule_ack(sk);
> +                       }
> +               } else if (tcp_try_rmem_schedule(sk, skb, skb->truesize))=
 {
>                         reason =3D SKB_DROP_REASON_PROTO_MEM;
>                         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP=
);
>                         sk->sk_data_ready(sk);

We also want to keep this sk->sk_data_ready(sk) call.

> +                       inet_csk(sk)->icsk_ack.pending |=3D
> +                               (ICSK_ACK_NOMEM | ICSK_ACK_NOW);
> +                       inet_csk_schedule_ack(sk);
>                         goto drop;
>                 }

This would suggest a different code refactoring, to avoid code duplication.

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 57c8af1859c16eba5e952a23ea959b628006f9c1..dde6c44f2c1e33dcf60c23b49cd=
99f270874ca96
100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5050,13 +5050,17 @@ static void tcp_data_queue(struct sock *sk,
struct sk_buff *skb)

                /* Ok. In sequence. In window. */
 queue_and_out:
-               if (skb_queue_len(&sk->sk_receive_queue) =3D=3D 0)
-                       sk_forced_mem_schedule(sk, skb->truesize);
-               else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
-                       reason =3D SKB_DROP_REASON_PROTO_MEM;
-                       NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP);
+               if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {
+                       /* TODO: maybe ratelimit these WIN 0 ACK ? */
+                       inet_csk(sk)->icsk_ack.pending |=3D
CSK_ACK_NOMEM | ICSK_ACK_NOW;
+                       inet_csk_schedule_ack(sk);
                        sk->sk_data_ready(sk);
-                       goto drop;
+                       if (skb_queue_len(&sk->sk_receive_queue)) {
+                               reason =3D SKB_DROP_REASON_PROTO_MEM;
+                               NET_INC_STATS(sock_net(sk),
LINUX_MIB_TCPRCVQDROP);
+                               goto drop;
+                       }
+                       sk_forced_mem_schedule(sk, skb->truesize);
                }

                eaten =3D tcp_queue_rcv(sk, skb, &fragstolen);
