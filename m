Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FCD7F2742
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjKUITp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjKUITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:19:24 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48830D75
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:18:23 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548db776f6cso6854a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700554702; x=1701159502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tImNK0HAC3h8at2LMrscyPDeWDs8XsM3oVqLvSbzmek=;
        b=wOeDfqCqaS4Ko7m87tAz7uHmUec2HNOSrmyIDv2VdVz4EJuUd+u9HxiWxKUC1zFw/v
         3OTYIZ6mJ7pLr3hsg3nuu4mAqVJpDWtROwz/JadzJVqK1pcn9jL/Sj19vcw61ov4XZDB
         Yn+0zH5bFhNlsd2XJa0Rksxww8zV7fwao51C7D3ac9ZccnKUJ/N+d+vWdJj9fJKDZ4Xz
         MO6XpzOHFMAv+KnRDC+UEeGzcED6zHopDcIiIH9jn6JqYUEe/TcAq3lVAy8P93qscKYS
         uVQDNhmVpGaNNjGXk8gNinxlbhXFp4o0zMjlH6XuI9qYnj0nhPC7gSveYwfNn1xKAmVN
         0tlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700554702; x=1701159502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tImNK0HAC3h8at2LMrscyPDeWDs8XsM3oVqLvSbzmek=;
        b=Sj+yvDFF7iCcojLGJB+g9yc6TxKQ6gW+Fbb0Kb6cuepeZLQd9cSRPqwr3dIk2ZMSh4
         eTi5Omln5cerCEeZOm/KiY01yUUFlAgoSdhTHXffxev4M/yjn4hLG+klRqhRc71B+yGg
         iglcEe9tDyOzdMICJgArRbVa0kpnUwexm1QCNOo3VnY4UzY3JAP6KMHmyhQGZpZl6yGI
         MJlTel8CBC3NYWKsdHIxt9PqQ5Ku4MXyvnfLoAqfNiz+mZrups1Ua9KPo5O6R4q+v8HI
         e0U++7EiAcvtVY4gHWiGg8tOVj/LVXhmcEK+VUbaVWNRVvsEJooDG0VkPEXlrlAPbJzs
         aSxQ==
X-Gm-Message-State: AOJu0YzvD6VXGTceo4ySm3avWl3gw29rKOM7K+Wk6cj4cUgC4pMKia1Y
        zcsAq+XEr1kvc4ABTeA3gokY8oY3iAW4glsxgvzeWQ==
X-Google-Smtp-Source: AGHT+IGLvpulRLsnUca8HoXd1vl18gKSh3Wwuxd2H4xwr46yVqyIzu+oZh97J0GTnolApKOSie5JTcYWtw796idZICY=
X-Received: by 2002:a05:6402:10ca:b0:544:466b:3b20 with SMTP id
 p10-20020a05640210ca00b00544466b3b20mr501485edu.5.1700554701871; Tue, 21 Nov
 2023 00:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20231121020111.1143180-1-dima@arista.com> <20231121020111.1143180-5-dima@arista.com>
In-Reply-To: <20231121020111.1143180-5-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 21 Nov 2023 09:18:10 +0100
Message-ID: <CANn89i+xvBQY5HLXNkjW0o9R4SX1hqRisJnr54ZqwuOpEJdHeA@mail.gmail.com>
Subject: Re: [PATCH 4/7] net/tcp: Reset TCP-AO cached keys on listen() syscall
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 3:01=E2=80=AFAM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> TCP_LISTEN sockets are not connected to any peer, so having
> current_key/rnext_key doesn't make sense.
>
> The userspace may falter over this issue by setting current or rnext
> TCP-AO key before listen() syscall. setsockopt(TCP_AO_DEL_KEY) doesn't
> allow removing a key that is in use (in accordance to RFC 5925), so
> it might be inconvenient to have keys that can be destroyed only with
> listener socket.

I think this is the wrong way to solve this issue. listen() should not
mess with anything else than socket state.

>
> Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/net/tcp_ao.h |  5 +++++
>  net/ipv4/af_inet.c   |  1 +
>  net/ipv4/tcp_ao.c    | 14 ++++++++++++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 647781080613..e36057ca5ed8 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -270,6 +270,7 @@ int tcp_v6_ao_synack_hash(char *ao_hash, struct tcp_a=
o_key *ao_key,
>  void tcp_ao_established(struct sock *sk);
>  void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
>  void tcp_ao_connect_init(struct sock *sk);
> +void tcp_ao_listen(struct sock *sk);
>  void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
>                       struct tcp_request_sock *treq,
>                       unsigned short int family, int l3index);
> @@ -330,6 +331,10 @@ static inline void tcp_ao_connect_init(struct sock *=
sk)
>  {
>  }
>
> +static inline void tcp_ao_listen(struct sock *sk)
> +{
> +}
> +
>  static inline int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, soc=
kptr_t optlen)
>  {
>         return -ENOPROTOOPT;
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index fb81de10d332..a08d1266344f 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -200,6 +200,7 @@ int __inet_listen_sk(struct sock *sk, int backlog)
>          * we can only allow the backlog to be adjusted.
>          */
>         if (old_state !=3D TCP_LISTEN) {
> +               tcp_ao_listen(sk);

Ouch...

Please add your hook in tcp_disconnect() instead of this layering violation=
.

I think you missed the fact that applications can call listen(fd,
backlog) multiple times,
if they need to dynamically adjust backlog.
