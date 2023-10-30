Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9737DB4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjJ3IQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjJ3IQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:16:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42EEB4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:16:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so11676a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698653781; x=1699258581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g89XSggoLUaEMPo+RRID+6tdEeDrel7KLo6Qj6UN4p0=;
        b=flF6YDsmduK+vpK/QFn2fm/1huYgaWSiO5ovHa+eRvhMPklkFHS5KUGCS+GTZ2kOK3
         MfZ37MHtjAD1+/9mIIiuimXGg1g3xmyktcjMHJBpl6Bxk3qDib86kfg5DVpCLYwRyVqK
         TxAU29B3eQYAvgP5uqFYs+WeOqeVsV8KbI+EKy+gKrtv0SFLibVASx7XyeIamOC+BIQl
         cS/43hoPsO1PsyMeW+1Rf0vh6HPpvurlukuIACqWncBtz47Lu/kTk/+C6oNk5dvKeamr
         qK01DjIR5OhebNW8xb1OaIJCQ28dHwuVCEvuklbHvEajSX9UHYVrdZLViwxedk+2lBoN
         ca3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698653781; x=1699258581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g89XSggoLUaEMPo+RRID+6tdEeDrel7KLo6Qj6UN4p0=;
        b=r4/PqbY2STUvb4olXvoDwu/bdGTnksZS78N+MS86qr5r5oOJoolQriVBa3z4aTrZGv
         mhlphzP65tEFQYDF2qSpV+TSJ6Tzhr1xWU6GAgU8vsuCO/hlzCzEuv2CjYV32H43rtEj
         1t4YJ+JcvJ4DqJ3oTLasc7KWh1ybiTd0nIw0wfwb7Gvuz8DWMEri091XYmgwEHDSCOWF
         7PlXck2NjL/ykQo39/1IBGkCVW1aMNkihVVGIwAu3GpX+IRU9ZPfdQdZ1FwU/rtXtfl6
         Hc4BmHMo3ttM9b0qg4gYT206GCAIN0jdXTbKTa5v3AJAGT6blf9okUBEhbxVBar5+iMU
         Mr6g==
X-Gm-Message-State: AOJu0YwfzYDkJYcykmVNsZCz8rBb1YMDuLy18UesWh7ues/Uj08N+ALN
        rfi5qMkP1rQQOrgK2QGUNCGnrJXU5fPY929jhlqz7g==
X-Google-Smtp-Source: AGHT+IG4I7Rtp4zpBaUCuU660uqL5hMSv74JlubURsiyygvmUDA4z2m2beZ18vlmuO0Yv/s3YCT8ZDuLK12Wrfjhwqg=
X-Received: by 2002:a50:baee:0:b0:540:e63d:3cfb with SMTP id
 x101-20020a50baee000000b00540e63d3cfbmr93917ede.3.1698653780877; Mon, 30 Oct
 2023 01:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231023192217.426455-1-dima@arista.com> <20231023192217.426455-16-dima@arista.com>
In-Reply-To: <20231023192217.426455-16-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 30 Oct 2023 09:16:08 +0100
Message-ID: <CANn89iJQvO11pRqrsHpB5Y3NuurX1UcEFu_SYq7kxJsvW7y7BQ@mail.gmail.com>
Subject: Re: [PATCH v16 net-next 15/23] net/tcp: Add tcp_hash_fail()
 ratelimited logs
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
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

On Mon, Oct 23, 2023 at 9:22=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Add a helper for logging connection-detailed messages for failed TCP
> hash verification (both MD5 and AO).
>
> Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> Co-developed-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Acked-by: David Ahern <dsahern@kernel.org>
> ---
>  include/net/tcp.h    | 14 ++++++++++++--
>  include/net/tcp_ao.h | 29 +++++++++++++++++++++++++++++
>  net/ipv4/tcp.c       | 23 +++++++++++++----------
>  net/ipv4/tcp_ao.c    |  7 +++++++
>  4 files changed, 61 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index d29c8a867f0e..c93ac6cc12c4 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2746,12 +2746,18 @@ tcp_inbound_hash(struct sock *sk, const struct re=
quest_sock *req,
>         int l3index;
>
>         /* Invalid option or two times meet any of auth options */
> -       if (tcp_parse_auth_options(th, &md5_location, &aoh))
> +       if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
> +               tcp_hash_fail("TCP segment has incorrect auth options set=
",
> +                             family, skb, "");
>                 return SKB_DROP_REASON_TCP_AUTH_HDR;
> +       }
>
>         if (req) {
>                 if (tcp_rsk_used_ao(req) !=3D !!aoh) {
>                         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
> +                       tcp_hash_fail("TCP connection can't start/end usi=
ng TCP-AO",
> +                                     family, skb, "%s",
> +                                     !aoh ? "missing AO" : "AO signed");
>                         return SKB_DROP_REASON_TCP_AOFAILURE;
>                 }
>         }
> @@ -2768,10 +2774,14 @@ tcp_inbound_hash(struct sock *sk, const struct re=
quest_sock *req,
>                  * the last key is impossible to remove, so there's
>                  * always at least one current_key.
>                  */
> -               if (tcp_ao_required(sk, saddr, family, true))
> +               if (tcp_ao_required(sk, saddr, family, true)) {
> +                       tcp_hash_fail("AO hash is required, but not found=
",
> +                                       family, skb, "L3 index %d", l3ind=
ex);
>                         return SKB_DROP_REASON_TCP_AONOTFOUND;
> +               }
>                 if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family=
))) {
>                         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFO=
UND);
> +                       tcp_hash_fail("MD5 Hash not found", family, skb, =
"");
>                         return SKB_DROP_REASON_TCP_MD5NOTFOUND;
>                 }
>                 return SKB_NOT_DROPPED_YET;
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 0c3516d1b968..4da6e3657913 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -118,6 +118,35 @@ struct tcp_ao_info {
>         struct rcu_head         rcu;
>  };
>
> +#define tcp_hash_fail(msg, family, skb, fmt, ...)                      \
> +do {                                                                   \
> +       const struct tcphdr *th =3D tcp_hdr(skb);                        =
 \
> +       char hdr_flags[5] =3D {};                                        =
 \
> +       char *f =3D hdr_flags;                                           =
 \
> +                                                                       \
> +       if (th->fin)                                                    \
> +               *f++ =3D 'F';                                            =
 \
> +       if (th->syn)                                                    \
> +               *f++ =3D 'S';                                            =
 \
> +       if (th->rst)                                                    \
> +               *f++ =3D 'R';                                            =
 \
> +       if (th->ack)                                                    \
> +               *f++ =3D 'A';                                            =
 \
> +       if (f !=3D hdr_flags)                                            =
 \
> +               *f =3D ' ';                                              =
 \

I see no null termination of  hdr_flags[] if FIN+SYN+ACK+RST are all set.

I will send something like:

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index a375a171ef3cb37ab1d8246c72c6a3e83f5c9184..5daf96a3dbee14bd3786e19ea49=
72e351058e6e7
100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -124,7 +124,7 @@ struct tcp_ao_info {
 #define tcp_hash_fail(msg, family, skb, fmt, ...)                      \
 do {                                                                   \
        const struct tcphdr *th =3D tcp_hdr(skb);                         \
-       char hdr_flags[5] =3D {};                                         \
+       char hdr_flags[5];                                              \
        char *f =3D hdr_flags;                                            \
                                                                        \
        if (th->fin)                                                    \
@@ -135,8 +135,7 @@ do {
                         \
                *f++ =3D 'R';                                             \
        if (th->ack)                                                    \
                *f++ =3D 'A';                                             \
-       if (f !=3D hdr_flags)                                             \
-               *f =3D ' ';                                               \
+       *f =3D 0;                                                         \
        if ((family) =3D=3D AF_INET) {                                     =
 \
                net_info_ratelimited("%s for (%pI4, %d)->(%pI4, %d)
%s" fmt "\n", \
                                msg, &ip_hdr(skb)->saddr, ntohs(th->source)=
, \
