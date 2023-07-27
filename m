Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE25F765BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjG0TSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjG0TRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:17:54 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C54FA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:17:53 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40540a8a3bbso47871cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690485473; x=1691090273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjaICTqH+cZvfMDigfbOcA5yUI6vz5+/jEk/szdxuyE=;
        b=3eURap2jCy1X1+Y0vpp99Mf1wqN21k7CprGG94jUm0nCmOjDF5YmGVGfUOv7brl3v6
         yTrRE0UHjwn8xaokwm7gwwYqB7mhKwshXo9H9hHInqnBjTGdpF7vidjAkfFZjRNjodJr
         iVYhsBFSc7+2wDnAKPGZhe6BOkhWHZGxfZtfogeDDk7D7TB8WHAI3+oWw2u4NIcsqRYg
         fC9/VCW9K4aDiFWUwO5K7gKzaPBSQsoU0SVOQKfijMUKnj4TpPEKy6/zX2cf2mzVXhev
         uQnvvLny6Pu9737cnCfbDRG+Is7ydcHSc97wTjSYtdEUpt04GFFzPzk2BPpbyirW3Lcu
         qrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485473; x=1691090273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjaICTqH+cZvfMDigfbOcA5yUI6vz5+/jEk/szdxuyE=;
        b=VsQu6TiIkPmD/KxaYhPMj5VuRNsbMTj+xYpDJkBArFbraTzBFly6L63nBg7sqRpKhG
         9nclsw5yy0MLaE1ob41zl0C2CAmNi1yYHxD8LhbofaaVVm4BWZ/BTU+mhWEUFr2fysUX
         I3Gt20yt8Ru4m0SzuJ4vlCFXrTZMUwzqeUEvWLdLE3Loqfk6jYP4DI9jt7NIi/jLl//x
         S9ogpCzaIxiB5ZyOxOPJyNPS2XB04owek7Uy6vEtGpCjGfDWCnDwcFk9YrC9TmDCgAgN
         /wx56x+X0MaSX8ueGXkzsRFHHjgJoBju1JV0Otf5LWR3VR+INbi7WIWpHbNQktX20BZQ
         LQag==
X-Gm-Message-State: ABy/qLZ++hu+nc4x9JZGniYB2VGRAfx6O7whm740OU+dokdzvAR4y37n
        4niR3NDKVVPWA5CvI+swZB+eODh2NviYxVkYtmPRNA==
X-Google-Smtp-Source: APBJJlH/+kGW+EsrfzDedROZlWmvYOKTcHd3WCSC6kPSaTfi+smYxRUcwpQztQBzk+rM1Yc+Nc2UsHv+AznNLs7YOHA=
X-Received: by 2002:ac8:58d5:0:b0:403:b1e5:bcae with SMTP id
 u21-20020ac858d5000000b00403b1e5bcaemr62160qta.10.1690485472810; Thu, 27 Jul
 2023 12:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com> <20230727125125.1194376-2-imagedong@tencent.com>
In-Reply-To: <20230727125125.1194376-2-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Jul 2023 21:17:41 +0200
Message-ID: <CANn89iLwLxzSLKtobE9y+ZBU_eizfNo6FUfBa61KeUXsodA2FQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: tcp: send zero-window ACK when no memory
To:     menglong8.dong@gmail.com
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        dsahern@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 2:51=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
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
>  include/net/inet_connection_sock.h |  3 ++-
>  net/ipv4/tcp_input.c               |  4 ++--
>  net/ipv4/tcp_output.c              | 14 +++++++++++---
>  3 files changed, 15 insertions(+), 6 deletions(-)
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
> index 3cd92035e090..03111af6115d 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5061,7 +5061,8 @@ static void tcp_data_queue(struct sock *sk, struct =
sk_buff *skb)
>                         reason =3D SKB_DROP_REASON_PROTO_MEM;
>                         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPRCVQDROP=
);
>                         sk->sk_data_ready(sk);
> -                       goto drop;
> +                       inet_csk(sk)->icsk_ack.pending |=3D ICSK_ACK_NOME=
M;

Also set ICSK_ACK_NOW ?

We also need to make sure to send an immediate ACK WIN 0 in the case we que=
ued
the skb in an empty receive queue and we were under pressure.

We do not want to have a delayed ACK sending a normal RWIN,
then wait for another packet that we will probably drop.

Look at the code :

if (skb_queue_len(&sk->sk_receive_queue) =3D=3D 0)
     sk_forced_mem_schedule(sk, skb->truesize);
else if (tcp_try_rmem_schedule(sk, skb, skb->truesize)) {

and refactor it to make sure to set  ICSK_ACK_NOMEM even on the first packe=
t
that bypassed the rmem_schedule().



> +                       goto out_of_window;

Why forcing quickack mode ? Please leave the "goto drop;"

>                 }
>
>                 eaten =3D tcp_queue_rcv(sk, skb, &fragstolen);
> @@ -5102,7 +5103,6 @@ static void tcp_data_queue(struct sock *sk, struct =
sk_buff *skb)
>  out_of_window:
>                 tcp_enter_quickack_mode(sk, TCP_MAX_QUICKACKS);
>                 inet_csk_schedule_ack(sk);
> -drop:
>                 tcp_drop_reason(sk, skb, reason);
>                 return;
>         }
>
