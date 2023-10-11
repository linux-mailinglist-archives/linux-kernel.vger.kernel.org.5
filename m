Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BF37C5A90
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjJKRx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjJKRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:53:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6999D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:53:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-537f07dfe8eso1183a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697046802; x=1697651602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egXaxNWVQ5M/aN9LWpBlAHfgD1+JaDM5+YAVt7Ur/wg=;
        b=BYta/ZoMOzSoiW/V80fEr6LMF33A90zYQJDNv5PDAqK2H/lLnU7dYtFw2ZlQVpBflv
         TBKp6RMmoo4yJCvRgd3vFrolbFyIgxeUIuPUz7iL/tl2rfTlPPU4Cb8+N0MycEsCPGeJ
         WhQy9DCcjIWpvaIbRu4cfRrpkMyCOgN4CXfezGz3wwcg4puBBkNvGcvAxtO2lSHOfh3k
         VK/XeggQKTr8PZFfoWMt7I3U8NEEakVTQ8LrSCZufTz81hot1f49+60Z7nYDcV3Ud8Ia
         vetCC7xK/pxGIFNAfpJ7WflZG164pRj95SpK8IUmvJNPd/tjJpx/jUwX+rukqd7RUBvn
         qyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697046802; x=1697651602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egXaxNWVQ5M/aN9LWpBlAHfgD1+JaDM5+YAVt7Ur/wg=;
        b=JU5UTCQmZWZ6mTqmFzjzkDzgRXxIKXgSujbp0lhA29baUU1J+iVMV9CBbxbfZl8dAC
         TezxxiEOTYklC0Ilg6BcT9GaF+ngv6r7HdUAWUs9zmNLassJU8sfiLpevG8Pi097ibzU
         Ws9oFl2sxyf29LAuoi1k3okpwpLZP9WHzrPnNCdJ9we5f/LasbHZqm0Ar/YZ8kF//iEd
         WgxlBfePdyFW/mbMsLCruTFU+yFJNtE0jn1PgmsETyHz0awYvvYxE3vr+R9dPiXDDKNP
         mRYS+z+29vd2R7xW0msJex+uH9vhHHGPSm381NA7hYjLWhJ+NyTYVGtc+cIEjdcyg/SE
         UV2Q==
X-Gm-Message-State: AOJu0Yx3DKV/G1KIN35KDQc3ku6O1B8/KbGoJQ37+4mc0ugxfoXYDzUC
        5X+tkjNU2BUa6Sk99d2MNtVEUyPu3BPfimfzu/ObsA==
X-Google-Smtp-Source: AGHT+IGIYKVt+6BJ8+OH/a7wvZjQK5sbD32WHmDaiOVRbnYzrbpBZuqca6S0hNBBys5vgrSbSECmXjaoj0rnFPcm2LU=
X-Received: by 2002:a50:aad8:0:b0:525:573c:643b with SMTP id
 r24-20020a50aad8000000b00525573c643bmr183452edc.7.1697046801434; Wed, 11 Oct
 2023 10:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231009230722.76268-1-dima@arista.com> <20231009230722.76268-17-dima@arista.com>
In-Reply-To: <20231009230722.76268-17-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 11 Oct 2023 19:53:10 +0200
Message-ID: <CANn89i+LwYbzNd=mA8Hk0RTTy6siEUpGtJaRw7DdFQju_+4mjA@mail.gmail.com>
Subject: Re: [PATCH v14 net-next 16/23] net/tcp: Ignore specific ICMPs for
 TCP-AO connections
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
        Simon Horman <simon.horman@corigine.com>,
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

On Tue, Oct 10, 2023 at 1:07=E2=80=AFAM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Similarly to IPsec, RFC5925 prescribes:
>   ">> A TCP-AO implementation MUST default to ignore incoming ICMPv4
>   messages of Type 3 (destination unreachable), Codes 2-4 (protocol
>   unreachable, port unreachable, and fragmentation needed -- =E2=80=99har=
d
>   errors=E2=80=99), and ICMPv6 Type 1 (destination unreachable), Code 1
>   (administratively prohibited) and Code 4 (port unreachable) intended
>   for connections in synchronized states (ESTABLISHED, FIN-WAIT-1, FIN-
>   WAIT-2, CLOSE-WAIT, CLOSING, LAST-ACK, TIME-WAIT) that match MKTs."
>
> A selftest (later in patch series) verifies that this attack is not
> possible in this TCP-AO implementation.
>
> Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> Co-developed-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Acked-by: David Ahern <dsahern@kernel.org>
> ---
>  include/net/tcp_ao.h      | 10 ++++++-
>  include/uapi/linux/snmp.h |  1 +
>  include/uapi/linux/tcp.h  |  4 ++-
>  net/ipv4/proc.c           |  1 +
>  net/ipv4/tcp_ao.c         | 58 +++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_ipv4.c       |  7 +++++
>  net/ipv6/tcp_ipv6.c       |  7 +++++
>  7 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 8c315c3f31da..eec38e9e6380 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -24,6 +24,7 @@ struct tcp_ao_counters {
>         atomic64_t      pkt_bad;
>         atomic64_t      key_not_found;
>         atomic64_t      ao_required;
> +       atomic64_t      dropped_icmp;
>  };
>
>  struct tcp_ao_key {
> @@ -92,7 +93,8 @@ struct tcp_ao_info {
>         struct tcp_ao_key       *rnext_key;
>         struct tcp_ao_counters  counters;
>         u32                     ao_required     :1,
> -                               __unused        :31;
> +                               accept_icmps    :1,
> +                               __unused        :30;
>         __be32                  lisn;
>         __be32                  risn;
>         /* Sequence Number Extension (SNE) are upper 4 bytes for SEQ,
> @@ -191,6 +193,7 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u=
8 *key, void *ctx,
>                             unsigned int len, struct tcp_sigpool *hp);
>  void tcp_ao_destroy_sock(struct sock *sk, bool twsk);
>  void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *=
tp);
> +bool tcp_ao_ignore_icmp(const struct sock *sk, int type, int code);
>  enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
>                         const struct sk_buff *skb, unsigned short int fam=
ily,
>                         const struct request_sock *req,
> @@ -274,6 +277,11 @@ static inline void tcp_ao_syncookie(struct sock *sk,=
 const struct sk_buff *skb,
>  {
>  }
>
> +static inline bool tcp_ao_ignore_icmp(const struct sock *sk, int type, i=
nt code)
> +{
> +       return false;
> +}
> +
>  static inline enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
>                 const struct sk_buff *skb, unsigned short int family,
>                 const struct request_sock *req, const struct tcp_ao_hdr *=
aoh)
> diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
> index 06ddf4cd295c..47a6b47da66f 100644
> --- a/include/uapi/linux/snmp.h
> +++ b/include/uapi/linux/snmp.h
> @@ -300,6 +300,7 @@ enum
>         LINUX_MIB_TCPAOBAD,                     /* TCPAOBad */
>         LINUX_MIB_TCPAOKEYNOTFOUND,             /* TCPAOKeyNotFound */
>         LINUX_MIB_TCPAOGOOD,                    /* TCPAOGood */
> +       LINUX_MIB_TCPAODROPPEDICMPS,            /* TCPAODroppedIcmps */
>         __LINUX_MIB_MAX
>  };
>
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index 62543f7c5523..e4ddca6178ca 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -404,7 +404,8 @@ struct tcp_ao_info_opt { /* setsockopt(TCP_AO_INFO) *=
/
>                 set_rnext       :1,     /* corresponding ::rnext */
>                 ao_required     :1,     /* don't accept non-AO connects *=
/
>                 set_counters    :1,     /* set/clear ::pkt_* counters */
> -               reserved        :28;    /* must be 0 */
> +               accept_icmps    :1,     /* accept incoming ICMPs */
> +               reserved        :27;    /* must be 0 */
>         __u16   reserved2;              /* padding, must be 0 */
>         __u8    current_key;            /* KeyID to set as Current_key */
>         __u8    rnext;                  /* KeyID to set as Rnext_key */
> @@ -412,6 +413,7 @@ struct tcp_ao_info_opt { /* setsockopt(TCP_AO_INFO) *=
/
>         __u64   pkt_bad;                /* failed verification */
>         __u64   pkt_key_not_found;      /* could not find a key to verify=
 */
>         __u64   pkt_ao_required;        /* segments missing TCP-AO sign *=
/
> +       __u64   pkt_dropped_icmp;       /* ICMPs that were ignored */
>  } __attribute__((aligned(8)));
>
>  /* setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...) */
> diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> index 3f643cd29cfe..5d3c9c96773e 100644
> --- a/net/ipv4/proc.c
> +++ b/net/ipv4/proc.c
> @@ -302,6 +302,7 @@ static const struct snmp_mib snmp4_net_list[] =3D {
>         SNMP_MIB_ITEM("TCPAOBad", LINUX_MIB_TCPAOBAD),
>         SNMP_MIB_ITEM("TCPAOKeyNotFound", LINUX_MIB_TCPAOKEYNOTFOUND),
>         SNMP_MIB_ITEM("TCPAOGood", LINUX_MIB_TCPAOGOOD),
> +       SNMP_MIB_ITEM("TCPAODroppedIcmps", LINUX_MIB_TCPAODROPPEDICMPS),
>         SNMP_MIB_SENTINEL
>  };
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index 801174c17853..168073cd1c89 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -15,6 +15,7 @@
>
>  #include <net/tcp.h>
>  #include <net/ipv6.h>
> +#include <net/icmp.h>
>
>  int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
>                             unsigned int len, struct tcp_sigpool *hp)
> @@ -44,6 +45,60 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8=
 *key, void *ctx,
>         return 1;
>  }
>
> +bool tcp_ao_ignore_icmp(const struct sock *sk, int type, int code)
> +{
> +       bool ignore_icmp =3D false;
> +       struct tcp_ao_info *ao;
> +
> +       /* RFC5925, 7.8:
> +        * >> A TCP-AO implementation MUST default to ignore incoming ICM=
Pv4
> +        * messages of Type 3 (destination unreachable), Codes 2-4 (proto=
col
> +        * unreachable, port unreachable, and fragmentation needed -- =E2=
=80=99hard
> +        * errors=E2=80=99), and ICMPv6 Type 1 (destination unreachable),=
 Code 1
> +        * (administratively prohibited) and Code 4 (port unreachable) in=
tended
> +        * for connections in synchronized states (ESTABLISHED, FIN-WAIT-=
1, FIN-
> +        * WAIT-2, CLOSE-WAIT, CLOSING, LAST-ACK, TIME-WAIT) that match M=
KTs.
> +        */
> +       if (READ_ONCE(sk->sk_family) =3D=3D AF_INET) {

You can not use sk->sk_family to make this decision.

 It could be AF_INET6 and yet the flow could be IPv4.  (dual stack)

Let the caller pass this information ?

 tcp_ao_ignore_icmp(sk, AF_INET, type, code);

 tcp_ao_ignore_icmp(sk, AF_INET6, type, code);



> +               if (type !=3D ICMP_DEST_UNREACH)
> +                       return false;
> +               if (code < ICMP_PROT_UNREACH || code > ICMP_FRAG_NEEDED)
> +                       return false;
> +       } else {
> +               if (type !=3D ICMPV6_DEST_UNREACH)
> +                       return false;
> +               if (code !=3D ICMPV6_ADM_PROHIBITED && code !=3D ICMPV6_P=
ORT_UNREACH)
> +                       return false;
> +       }
> +
> +       rcu_read_lock();
> +       switch (sk->sk_state) {
> +       case TCP_TIME_WAIT:
> +               ao =3D rcu_dereference(tcp_twsk(sk)->ao_info);
> +               break;
> +       case TCP_SYN_SENT:
> +       case TCP_SYN_RECV:
> +       case TCP_LISTEN:
> +       case TCP_NEW_SYN_RECV:
> +               /* RFC5925 specifies to ignore ICMPs *only* on connection=
s
> +                * in synchronized states.
> +                */
> +               rcu_read_unlock();
> +               return false;
> +       default:
> +               ao =3D rcu_dereference(tcp_sk(sk)->ao_info);
> +       }
> +
> +       if (ao && !ao->accept_icmps) {
> +               ignore_icmp =3D true;
> +               __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAODROPPEDICMPS=
);
> +               atomic64_inc(&ao->counters.dropped_icmp);
> +       }
> +       rcu_read_unlock();
> +
> +       return ignore_icmp;
> +}
>
