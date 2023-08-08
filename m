Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D703D773B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjHHPo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjHHPnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:43:31 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683F8E3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:36:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40a47e8e38dso277461cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691508985; x=1692113785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyES+4AF5nitte7BPshvVJ/M/14djHeZo3yws6zb9Z8=;
        b=kCiIF6wuQpgF7gaHNap6/0i3mHgvlsEZQ7WtkpQBS6Auitf6xqx+6ZpeNcUUr5tgq1
         GxaYCBKAJmUtnQ17sE7jcb4L9yxDRBTi0mlQhyEkc1s3jekJqfDll5HIo6+fgX0Ogr9V
         HVwFl0SfZCf42dFHiD7R2cSm5xPLvBYNb3B1MCXxAUZh5S4gQmKKsvIclzyRlnQ2eGhG
         XaxwJ2xpxdklfKC6M7NIudnoiiu/Dcq3cg6ubf9QzHH5+FyguPMin5NAfB63o23u9AVk
         RW8CFddF3djV/KGD3LpdZx9F/Gs28bRB1DrLH2Er0ElgoS8/kzxYlJ7OamI7JiYr7OpP
         rbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691508985; x=1692113785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyES+4AF5nitte7BPshvVJ/M/14djHeZo3yws6zb9Z8=;
        b=hskHea4F0YfggZP47DOzUBL7MKYGqlslWwHoVQTw7uAB31x+rk1lrUuqSqgYIpqg4m
         aoSGBpGEhfMmUAC8OI4t738CeIbC57lPe3GRUa4kgMAGCNNtVFtA4Bz/vepOU5nK+Q3c
         PJRt3OQjU4lcWCFjSJepcExl2u9CkoDBtLCnuYVr2GjayvOs7A2MjKFvvJ+CfQ6g6f3Z
         EjfWhCjfaTmdPQeGAznI44KQ9lUeS9dLdykr45AKGYBsGGOTO7Uulkn1BRHdptC4fsJG
         P4O48FPJ6WeJ0vlZF828+ydjnGY0sOlQ9ngbN9ddbQ8I/DZmPe2LJSI4Ng9X/nQbNWj3
         7Ajg==
X-Gm-Message-State: AOJu0YyGWY2W8XkDUz/NnD1KZgtpsmwc2vFv35PLPXfaRlmnCEAEYpEx
        LwpRaTfH0z5rIvPmNcbdfyOEvEEzkZGdUVbDnZ+WLob7Sc73ZEO9MHn5GQ==
X-Google-Smtp-Source: AGHT+IHc9vm7JbEPlckcKoimq6rV3JrGtLsAkpCo98NFPRTR+rWv/NXfBb6AidjtdAp6Ci1rTqmNQCaXGL7gXYK71ww=
X-Received: by 2002:a05:622a:40b:b0:3f9:56c:1129 with SMTP id
 n11-20020a05622a040b00b003f9056c1129mr777271qtx.5.1691502249315; Tue, 08 Aug
 2023 06:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230802172654.1467777-1-dima@arista.com> <20230802172654.1467777-17-dima@arista.com>
In-Reply-To: <20230802172654.1467777-17-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 8 Aug 2023 15:43:57 +0200
Message-ID: <CANn89iKjT3i-0rZLu8WE_P94aN65rj8uBAw3MyMPhsnMKWSs_A@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 16/23] net/tcp: Ignore specific ICMPs for
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
        Salam Noureddine <noureddine@arista.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 7:27=E2=80=AFPM Dmitry Safonov <dima@arista.com> wro=
te:
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
>  net/ipv4/tcp_ao.c         | 61 +++++++++++++++++++++++++++++++++++++++
>  net/ipv4/tcp_ipv4.c       |  5 ++++
>  net/ipv6/tcp_ipv6.c       |  4 +++
>  7 files changed, 84 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 986e8dcbb150..94fde002b638 100644
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
> @@ -189,6 +191,7 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u=
8 *key, void *ctx,
>                             unsigned int len, struct tcp_sigpool *hp);
>  void tcp_ao_destroy_sock(struct sock *sk, bool twsk);
>  void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *=
tp);
> +bool tcp_ao_ignore_icmp(struct sock *sk, int type, int code);
>  enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
>                         const struct sk_buff *skb, unsigned short int fam=
ily,
>                         const struct request_sock *req,
> @@ -264,6 +267,11 @@ static inline void tcp_ao_syncookie(struct sock *sk,=
 const struct sk_buff *skb,
>  {
>  }
>
> +static inline bool tcp_ao_ignore_icmp(struct sock *sk, int type, int cod=
e)
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
> index 3fe0612ec59a..ca7ed18ce67b 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -392,7 +392,8 @@ struct tcp_ao_info_opt { /* setsockopt(TCP_AO_INFO) *=
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
> @@ -400,6 +401,7 @@ struct tcp_ao_info_opt { /* setsockopt(TCP_AO_INFO) *=
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
> index 226dcefb426a..236c8cd1a0c7 100644
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
> @@ -44,6 +45,63 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8=
 *key, void *ctx,
>         return 1;
>  }
>
> +bool tcp_ao_ignore_icmp(struct sock *sk, int type, int code)

const struct sock *sk ?

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

I know this sounds silly, but you should read sk->sk_family once.

Or risk another KCSAN report with IPV6_ADDRFORM

if (sk->sk_family =3D=3D AF_INET) {
    ...
} else {
    /* AF_INET case */
}


> +       if (sk->sk_family =3D=3D AF_INET) {
> +               if (type !=3D ICMP_DEST_UNREACH)
> +                       return false;
> +               if (code < ICMP_PROT_UNREACH || code > ICMP_FRAG_NEEDED)
> +                       return false;
> +       } else if (sk->sk_family =3D=3D AF_INET6) {
> +               if (type !=3D ICMPV6_DEST_UNREACH)
> +                       return false;
> +               if (code !=3D ICMPV6_ADM_PROHIBITED && code !=3D ICMPV6_P=
ORT_UNREACH)
> +                       return false;
> +       } else {


No WARN_ON_ONCE(1) here please.

> +               WARN_ON_ONCE(1);
> +               return false;
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
> +
>  /* Optimized version of tcp_ao_do_lookup(): only for sockets for which
>   * it's known that the keys in ao_info are matching peer's
>   * family/address/VRF/etc.
> @@ -1036,6 +1094,7 @@ int tcp_ao_copy_all_matching(const struct sock *sk,=
 struct sock *newsk,
>         new_ao->lisn =3D htonl(tcp_rsk(req)->snt_isn);
>         new_ao->risn =3D htonl(tcp_rsk(req)->rcv_isn);
>         new_ao->ao_required =3D ao->ao_required;
> +       new_ao->accept_icmps =3D ao->accept_icmps;
>
>         if (family =3D=3D AF_INET) {
>                 addr =3D (union tcp_ao_addr *)&newsk->sk_daddr;
> @@ -1742,9 +1801,11 @@ static int tcp_ao_info_cmd(struct sock *sk, unsign=
ed short int family,
>                 atomic64_set(&ao_info->counters.pkt_bad, cmd.pkt_bad);
>                 atomic64_set(&ao_info->counters.key_not_found, cmd.pkt_ke=
y_not_found);
>                 atomic64_set(&ao_info->counters.ao_required, cmd.pkt_ao_r=
equired);
> +               atomic64_set(&ao_info->counters.dropped_icmp, cmd.pkt_dro=
pped_icmp);
>         }
>
>         ao_info->ao_required =3D cmd.ao_required;
> +       ao_info->accept_icmps =3D cmd.accept_icmps;
>         if (new_current)
>                 WRITE_ONCE(ao_info->current_key, new_current);
>         if (new_rnext)
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 42a3be6c25a4..ae910181693d 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -494,6 +494,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
>                 return -ENOENT;
>         }
>         if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
> +               /* To increase the counter of ignored icmps for TCP-AO */
> +               tcp_ao_ignore_icmp(sk, type, code);
>                 inet_twsk_put(inet_twsk(sk));
>                 return 0;
>         }
> @@ -508,6 +510,9 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
>         }
>
>         bh_lock_sock(sk);

Do we need to hold the spinlock before calling tcp_ao_ignore_icmp() ?

> +       if (tcp_ao_ignore_icmp(sk, type, code))
> +               goto out;
> +
>         /* If too many ICMPs get dropped on busy
>          * servers this needs to be solved differently.
>          * We do take care of PMTU discovery (RFC1191) special case :
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index f1804ec3bb1d..07126d9eeda9 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -395,6 +395,8 @@ static int tcp_v6_err(struct sk_buff *skb, struct ine=
t6_skb_parm *opt,
>         }
>
>         if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
> +               /* To increase the counter of ignored icmps for TCP-AO */
> +               tcp_ao_ignore_icmp(sk, type, code);
>                 inet_twsk_put(inet_twsk(sk));
>                 return 0;
>         }
> @@ -406,6 +408,8 @@ static int tcp_v6_err(struct sk_buff *skb, struct ine=
t6_skb_parm *opt,
>         }
>
>         bh_lock_sock(sk);
> +       if (tcp_ao_ignore_icmp(sk, type, code))
> +               goto out;
>         if (sock_owned_by_user(sk) && type !=3D ICMPV6_PKT_TOOBIG)
>                 __NET_INC_STATS(net, LINUX_MIB_LOCKDROPPEDICMPS);
>
> --
> 2.41.0
>
