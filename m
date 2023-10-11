Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151E47C5AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343652AbjJKSEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjJKSEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:04:35 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AF5B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:04:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so1874a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697047471; x=1697652271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiZmTUMTpbJ2uLA/FEXjYHDD+T9QCsN1hihJhm6QStw=;
        b=Rjmhgl6mg+2rbwnk8BlfUgV/oTzYl/NXWyEwhe8pCWsc27a72Bo2np6I3nI9D16GOq
         PjDoxx5092E47E3ARcVtUmWCDtDkGtw88f5Z66PbhReJExAS+kEzFGm4tLx8n1SAGsu+
         1yO2CuFYgbp+3M0LTAnf0D+ZNEnfVtKekapJgFuTqX+3UZzevse9SwX4LXTKy+p6ZnpT
         PlnG3chUz4ndXX6FsFc4Lu+fHLh297AdECg9Xrhwb70iZrQgdYlU7m3cuB/VHN9TFm1b
         BB0puJXbPs4fOvcG7/N+16oG4pOuy+YKFzv34JBHnoQjQ6gOq3Xj+AnY/w3e6c9bwjpb
         Bkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697047471; x=1697652271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiZmTUMTpbJ2uLA/FEXjYHDD+T9QCsN1hihJhm6QStw=;
        b=tFDuLWFVVr7RTfzt+sHMtO5KW5IevJupaGsIYHghJGuLwovRzPWlDpUNw/P9RNXv0A
         wQVwFbtaKKcL7eMGNLGJ5low6ClmCEzeSvwz1rrozQUe9Hmo6CHcGT3Ddm/LemXQTKFI
         UhhTVgsD4QEfLeKN0buwwc7D/EoJJYKpv3R2JvFaX1mgmjXVE3mMI4LXkv99lW1Oj69l
         bqEjqRprPP6V/DJlkF/9gnQI1G7iThc4NOQmN9UC/Q4HsAg3L/r4+THajCdfYiosGj+w
         1j59U1xcJbNn4b0B40tfmOrwz/Xr2DfeC4zMC/Y0yKhzKIPg6aArn1XWlv4oJwfs+1Wk
         2PNA==
X-Gm-Message-State: AOJu0YynrSV3urM+6RWPUVf2GbJ8pnMjkrT+CzLzUeWHqzAL6b6mzl7Z
        0v9gH1az1zKKomQzoGmSksaamuIYtwN+AnK//CzA5w==
X-Google-Smtp-Source: AGHT+IGhlcUX97Hk3Tvpn9UkgNU+7u4bzBt6Ty7fyrd0f1y1JbOSKzKTMlNf1sihimKLsW/uRRn7motU0UdS2v30sLA=
X-Received: by 2002:a50:f60c:0:b0:538:47bb:3e88 with SMTP id
 c12-20020a50f60c000000b0053847bb3e88mr185448edn.6.1697047470356; Wed, 11 Oct
 2023 11:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231009230722.76268-1-dima@arista.com> <20231009230722.76268-9-dima@arista.com>
In-Reply-To: <20231009230722.76268-9-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 11 Oct 2023 20:04:18 +0200
Message-ID: <CANn89iLo8sOL=CnAvMv_PSeS_hUQ0cfF6LdFEDnuwGxhSmo+xg@mail.gmail.com>
Subject: Re: [PATCH v14 net-next 08/23] net/tcp: Add AO sign to RST packets
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
> Wire up sending resets to TCP-AO hashing.
>
> Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> Co-developed-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Acked-by: David Ahern <dsahern@kernel.org>
> ---
>  include/net/tcp.h    |   7 ++-
>  include/net/tcp_ao.h |  12 +++++
>  net/ipv4/tcp_ao.c    | 104 ++++++++++++++++++++++++++++++++++++++++++-
>  net/ipv4/tcp_ipv4.c  |  69 ++++++++++++++++++++++------
>  net/ipv6/tcp_ipv6.c  |  96 ++++++++++++++++++++++++++++-----------
>  5 files changed, 245 insertions(+), 43 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index a619c429a8bd..dc74908ffa5a 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2220,7 +2220,12 @@ static inline __u32 cookie_init_sequence(const str=
uct tcp_request_sock_ops *ops,
>
>  struct tcp_key {
>         union {
> -               struct tcp_ao_key *ao_key;
> +               struct {
> +                       struct tcp_ao_key *ao_key;
> +                       u32 sne;
> +                       char *traffic_key;

Move sne after traffic_key to avoid a hole on 64bit arches.

> +                       u8 rcv_next;
> +               };
>                 struct tcp_md5sig_key *md5_key;
>         };
>         enum {
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index fdd2f5091b98..629ab0365b83 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -120,12 +120,24 @@ int tcp_ao_hash_skb(unsigned short int family,
>                     const u8 *tkey, int hash_offset, u32 sne);
>  int tcp_parse_ao(struct sock *sk, int cmd, unsigned short int family,
>                  sockptr_t optval, int optlen);
> +struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
> +                                         int sndid, int rcvid);
>  int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
>                             unsigned int len, struct tcp_sigpool *hp);
>  void tcp_ao_destroy_sock(struct sock *sk);
>  struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
>                                     const union tcp_ao_addr *addr,
>                                     int family, int sndid, int rcvid);
> +int tcp_ao_hash_hdr(unsigned short family, char *ao_hash,
> +                   struct tcp_ao_key *key, const u8 *tkey,
> +                   const union tcp_ao_addr *daddr,
> +                   const union tcp_ao_addr *saddr,
> +                   const struct tcphdr *th, u32 sne);
> +int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
> +                        const struct tcp_ao_hdr *aoh, int l3index,
> +                        struct tcp_ao_key **key, char **traffic_key,
> +                        bool *allocated_traffic_key, u8 *keyid, u32 *sne=
);
> +
>  /* ipv4 specific functions */
>  int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optl=
en);
>  struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *=
addr_sk,
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index 6eb9241d14a3..df59924c3828 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -48,8 +48,8 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 =
*key, void *ctx,
>   * it's known that the keys in ao_info are matching peer's
>   * family/address/VRF/etc.
>   */
> -static struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
> -                                                int sndid, int rcvid)
> +struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
> +                                         int sndid, int rcvid)
>  {
>         struct tcp_ao_key *key;
>
> @@ -369,6 +369,66 @@ static int tcp_ao_hash_header(struct tcp_sigpool *hp=
,
>         return err;
>  }
>
> +int tcp_ao_hash_hdr(unsigned short int family, char *ao_hash,
> +                   struct tcp_ao_key *key, const u8 *tkey,
> +                   const union tcp_ao_addr *daddr,
> +                   const union tcp_ao_addr *saddr,
> +                   const struct tcphdr *th, u32 sne)
> +{
> +       int tkey_len =3D tcp_ao_digest_size(key);
> +       int hash_offset =3D ao_hash - (char *)th;
> +       struct tcp_sigpool hp;
> +       void *hash_buf =3D NULL;
> +
> +       hash_buf =3D kmalloc(tkey_len, GFP_ATOMIC);
> +       if (!hash_buf)
> +               goto clear_hash_noput;
> +
> +       if (tcp_sigpool_start(key->tcp_sigpool_id, &hp))
> +               goto clear_hash_noput;
> +
> +       if (crypto_ahash_setkey(crypto_ahash_reqtfm(hp.req), tkey, tkey_l=
en))
> +               goto clear_hash;
> +
> +       if (crypto_ahash_init(hp.req))
> +               goto clear_hash;
> +
> +       if (tcp_ao_hash_sne(&hp, sne))
> +               goto clear_hash;
> +       if (family =3D=3D AF_INET) {
> +               if (tcp_v4_ao_hash_pseudoheader(&hp, daddr->a4.s_addr,
> +                                               saddr->a4.s_addr, th->dof=
f * 4))
> +                       goto clear_hash;
> +#if IS_ENABLED(CONFIG_IPV6)
> +       } else if (family =3D=3D AF_INET6) {
> +               if (tcp_v6_ao_hash_pseudoheader(&hp, &daddr->a6,
> +                                               &saddr->a6, th->doff * 4)=
)
> +                       goto clear_hash;
> +#endif
> +       } else {
> +               WARN_ON_ONCE(1);
> +               goto clear_hash;
> +       }
> +       if (tcp_ao_hash_header(&hp, th, false,
> +                              ao_hash, hash_offset, tcp_ao_maclen(key)))
> +               goto clear_hash;
> +       ahash_request_set_crypt(hp.req, NULL, hash_buf, 0);
> +       if (crypto_ahash_final(hp.req))
> +               goto clear_hash;
> +
> +       memcpy(ao_hash, hash_buf, tcp_ao_maclen(key));
> +       tcp_sigpool_end(&hp);
> +       kfree(hash_buf);
> +       return 0;
> +
> +clear_hash:
> +       tcp_sigpool_end(&hp);
> +clear_hash_noput:
> +       memset(ao_hash, 0, tcp_ao_maclen(key));
> +       kfree(hash_buf);
> +       return 1;
> +}
> +
>  int tcp_ao_hash_skb(unsigned short int family,
>                     char *ao_hash, struct tcp_ao_key *key,
>                     const struct sock *sk, const struct sk_buff *skb,
> @@ -435,6 +495,46 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct soc=
k *sk, struct sock *addr_sk,
>         return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid);
>  }
>
> +int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
> +                        const struct tcp_ao_hdr *aoh, int l3index,
> +                        struct tcp_ao_key **key, char **traffic_key,
> +                        bool *allocated_traffic_key, u8 *keyid, u32 *sne=
)
> +{
> +       struct tcp_ao_info *ao_info;
> +
> +       *allocated_traffic_key =3D false;
> +       /* If there's no socket - than initial sisn/disn are unknown.
> +        * Drop the segment. RFC5925 (7.7) advises to require graceful
> +        * restart [RFC4724]. Alternatively, the RFC5925 advises to
> +        * save/restore traffic keys before/after reboot.
> +        * Linux TCP-AO support provides TCP_AO_ADD_KEY and TCP_AO_REPAIR
> +        * options to restore a socket post-reboot.
> +        */
> +       if (!sk)
> +               return -ENOTCONN;
> +
> +       if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
> +               return -1;
> +       } else {
> +               struct tcp_ao_key *rnext_key;
> +
> +               if (sk->sk_state =3D=3D TCP_TIME_WAIT)

Why not adding TCPF_TIME_WAIT in the prior test ?

> +                       return -1;
> +               ao_info =3D rcu_dereference(tcp_sk(sk)->ao_info);
> +               if (!ao_info)
> +                       return -ENOENT;
> +
> +               *key =3D tcp_ao_established_key(ao_info, aoh->rnext_keyid=
, -1);
> +               if (!*key)
> +                       return -ENOENT;
> +               *traffic_key =3D snd_other_key(*key);
> +               rnext_key =3D READ_ONCE(ao_info->rnext_key);
> +               *keyid =3D rnext_key->rcvid;
> +               *sne =3D 0;
> +       }
> +       return 0;
> +}
> +
>
