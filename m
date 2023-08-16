Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C10077E0CF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244796AbjHPLvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244399AbjHPLup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E111FC3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3C2263729
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971DBC433C7;
        Wed, 16 Aug 2023 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692186624;
        bh=K5UuP55MZJ1xP8kfzlNmsJdJK6+0SZxeygX7UdDuRto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGh3cs+BJCw56/SjCfd/t2kcRfuW2stdrhNKzVlxvUIpSm84DL801VqE1y24l/nRW
         B/B/K9ypI5v0egh5hSN0jFd5d68a1tPAOzjAsOGzdY0ote8/AYnyQpi+nk0cY7Hl1D
         AVnlCEuK5PgDMv56fCPJmBj5j07hYZc4+IUfMQWmffUxKF6oFQme8b02Dx8EyDq9Qe
         SEPaREHZkxj9GS4ZOJBE0Pcy06fAM6EvxrJQmiNT37GTnfDmweZu4zh6c5JsBgGgD4
         NMGxadgT8yOrIIOM8r30F4Qr2Si7+4KnsaN85noTVkyzNmhnBsHR5njm1M44DrEoH+
         dIoNSZdckUFNw==
Date:   Wed, 16 Aug 2023 13:50:17 +0200
From:   Simon Horman <horms@kernel.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
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
Subject: Re: [PATCH v10 net-next 08/23] net/tcp: Add AO sign to RST packets
Message-ID: <ZNy3+f6ZtDKfsQ5C@vergenet.net>
References: <20230815191455.1872316-1-dima@arista.com>
 <20230815191455.1872316-9-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815191455.1872316-9-dima@arista.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 08:14:37PM +0100, Dmitry Safonov wrote:
> Wire up sending resets to TCP-AO hashing.
> 
> Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> Co-developed-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Acked-by: David Ahern <dsahern@kernel.org>

> ---
>  include/net/tcp_ao.h |  12 +++++
>  net/ipv4/tcp_ao.c    | 104 ++++++++++++++++++++++++++++++++++++++++++-
>  net/ipv4/tcp_ipv4.c  |  69 ++++++++++++++++++++++------
>  net/ipv6/tcp_ipv6.c  |  70 ++++++++++++++++++++++-------
>  4 files changed, 225 insertions(+), 30 deletions(-)
> 
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index e685ad9db949..67f997aabd9c 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -117,12 +117,24 @@ int tcp_ao_hash_skb(unsigned short int family,
>  		    const u8 *tkey, int hash_offset, u32 sne);
>  int tcp_parse_ao(struct sock *sk, int cmd, unsigned short int family,
>  		 sockptr_t optval, int optlen);
> +struct tcp_ao_key *tcp_ao_established_key(struct tcp_ao_info *ao,
> +					  int sndid, int rcvid);
>  int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
>  			    unsigned int len, struct tcp_sigpool *hp);
>  void tcp_ao_destroy_sock(struct sock *sk);
>  struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
>  				    const union tcp_ao_addr *addr,
>  				    int family, int sndid, int rcvid);
> +int tcp_ao_hash_hdr(unsigned short family, char *ao_hash,
> +		    struct tcp_ao_key *key, const u8 *tkey,
> +		    const union tcp_ao_addr *daddr,
> +		    const union tcp_ao_addr *saddr,
> +		    const struct tcphdr *th, u32 sne);
> +int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
> +			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
> +			 struct tcp_ao_key **key, char **traffic_key,
> +			 bool *allocated_traffic_key, u8 *keyid, u32 *sne);
> +
>  /* ipv4 specific functions */
>  int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
>  struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c

...

> @@ -435,6 +495,46 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
>  	return tcp_ao_do_lookup(sk, addr, AF_INET, sndid, rcvid);
>  }
>  
> +int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
> +			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
> +			 struct tcp_ao_key **key, char **traffic_key,
> +			 bool *allocated_traffic_key, u8 *keyid, u32 *sne)
> +{
> +	struct tcp_ao_info *ao_info;
> +
> +	*allocated_traffic_key = false;
> +	/* If there's no socket - than initial sisn/disn are unknown.
> +	 * Drop the segment. RFC5925 (7.7) advises to require graceful
> +	 * restart [RFC4724]. Alternatively, the RFC5925 advises to
> +	 * save/restore traffic keys before/after reboot.
> +	 * Linux TCP-AO support provides TCP_AO_ADD_KEY and TCP_AO_REPAIR
> +	 * options to restore a socket post-reboot.
> +	 */
> +	if (!sk)
> +		return -ENOTCONN;
> +
> +	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
> +		return -1;
> +	} else {
> +		struct tcp_ao_key *rnext_key;
> +
> +		if (sk->sk_state == TCP_TIME_WAIT)
> +			return -1;
> +		ao_info = rcu_dereference(tcp_sk(sk)->ao_info);
> +		if (!ao_info)
> +			return -ENOENT;
> +
> +		*key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
> +		if (!*key)
> +			return -ENOENT;
> +		*traffic_key = snd_other_key(*key);
> +		rnext_key = READ_ONCE(ao_info->rnext_key);
> +		*keyid = rnext_key->rcvid;
> +		*sne = 0;
> +	}
> +	return 0;
> +}
> +
>  static int tcp_ao_cache_traffic_keys(const struct sock *sk,
>  				     struct tcp_ao_info *ao,
>  				     struct tcp_ao_key *ao_key)
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 31169971cc56..f07a12f478d4 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -657,6 +657,52 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
>  }
>  EXPORT_SYMBOL(tcp_v4_send_check);
>  
> +#define REPLY_OPTIONS_LEN      (MAX_TCP_OPTION_SPACE / sizeof(__be32))
> +
> +static bool tcp_v4_ao_sign_reset(const struct sock *sk, struct sk_buff *skb,
> +				 const struct tcp_ao_hdr *aoh,
> +				 struct ip_reply_arg *arg, struct tcphdr *reply,
> +				 __be32 reply_options[REPLY_OPTIONS_LEN])
> +{
> +#ifdef CONFIG_TCP_AO
> +	int sdif = tcp_v4_sdif(skb);
> +	int dif = inet_iif(skb);
> +	int l3index = sdif ? dif : 0;
> +	bool allocated_traffic_key;
> +	struct tcp_ao_key *key;
> +	char *traffic_key;
> +	bool drop = true;
> +	u32 ao_sne = 0;
> +	u8 keyid;
> +
> +	rcu_read_lock();
> +	if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, reply->seq,
> +				 &key, &traffic_key, &allocated_traffic_key,
> +				 &keyid, &ao_sne))

Hi Dmitry,

The type of the 4th parameter of tcp_ao_prepare_reset() (seq) is u32,
but here a __be32 value is passed.

Also, it seems that parameter is unused by tcp_ao_prepare_reset().

> +		goto out;
> +
> +	reply_options[0] = htonl((TCPOPT_AO << 24) | (tcp_ao_len(key) << 16) |
> +				 (aoh->rnext_keyid << 8) | keyid);
> +	arg->iov[0].iov_len += round_up(tcp_ao_len(key), 4);
> +	reply->doff = arg->iov[0].iov_len / 4;
> +
> +	if (tcp_ao_hash_hdr(AF_INET, (char *)&reply_options[1],
> +			    key, traffic_key,
> +			    (union tcp_ao_addr *)&ip_hdr(skb)->saddr,
> +			    (union tcp_ao_addr *)&ip_hdr(skb)->daddr,
> +			    reply, ao_sne))
> +		goto out;
> +	drop = false;
> +out:
> +	rcu_read_unlock();
> +	if (allocated_traffic_key)
> +		kfree(traffic_key);
> +	return drop;
> +#else
> +	return true;
> +#endif
> +}
> +
>  /*
>   *	This routine will send an RST to the other tcp.
>   *

...

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c

...

> @@ -1064,6 +1088,19 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
>  		ack_seq = ntohl(th->seq) + th->syn + th->fin + skb->len -
>  			  (th->doff << 2);
>  
> +#ifdef CONFIG_TCP_AO
> +	if (aoh) {
> +		int l3index;
> +
> +		l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
> +		if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, htonl(seq),

Ditto.

> +					 &ao_key, &traffic_key,
> +					 &allocated_traffic_key,
> +					 &rcv_next, &ao_sne))
> +			goto out;
> +	}
> +#endif
> +
>  	if (sk) {
>  		oif = sk->sk_bound_dev_if;
>  		if (sk_fullsock(sk)) {

...
