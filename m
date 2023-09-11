Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDE679C1AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjILBdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbjILBcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:32:48 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DA53E1D5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:15:01 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b9338e4695so83503831fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1694480998; x=1695085798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCHePTh3wXMrS3B+DxYEZ6ss607rejigY/btHpXbnFs=;
        b=h9lW0WFg9PefGe/zkwCYyZFZAT5FoRiAmQ+OIN93Zml9G8pPftsnIS+6s5s+XIKfHw
         166N0To6OoHgZQI4bujdjbtEpjF/d1rdyuLEw1DN688XKeYdHuA8JkoEfWRCNpV6cfwD
         Bhde7+skUWIrVaKlPVqZL11rLwt+rYQ1nlnVtKBzjtI18xbTP/YxAAG5qSBjfZPSbnle
         +RPZfLKx7kZDhGwmpavjScFNtJKFt6WKLO6oKSnLuYfpOgWPcLGrGrT11IkyZCqQLyIs
         zHwFOHCeOnFo6etdLze4aL3LdrcszuFUA3zet42ZDZb+HJUEvgAGsvSZeBA3K+9y2RJM
         luyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694480998; x=1695085798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCHePTh3wXMrS3B+DxYEZ6ss607rejigY/btHpXbnFs=;
        b=mjCww6k+uOmtxr1mQkfD3i5CA/40sT48NJophw5bDyufVHYaMY6zsZuJRtpCTaQMOD
         AwBy5R8quPRJg0jhGGpAylWp7Bm02oeU43J7RoPm/3Cbkj3wlJZ7RmH0PXX0y6lXGeG6
         ra3Kps7L7djNW+xX9lLMb7CQlVVFjgvlbDfwen7T+icBlTdc+zZ5fNBZanWnT6d+C1td
         cfjK1lqvo0YzOZ3Fkmh3PzBtJZ7wHvKsxX6BO7sfTfO2EXcD+VpiBx2CmyDxooOvWmIz
         nBgIsVc/xh50Rf9QuR7DIG31ctJOceEK90liJcdVJyBAAml0L2M6JvZeA6K1UonNfJVv
         VYUA==
X-Gm-Message-State: AOJu0Yxby7nwZUwM4EQQRjp2VrYdgRaaWkUHRBQaPqS4kMWvLv6gjS8W
        h7v3wBJp2ftFNFUg2davBMh59Ffukf1RhFYMf3M=
X-Google-Smtp-Source: AGHT+IHAom7+UcwolTupDbhggSy3czgDAnsjGH8/rX1838DvSV3nNQBCi3elDVP07aNtrCE4hxwwIQ==
X-Received: by 2002:a7b:c3d4:0:b0:402:bbcc:ea52 with SMTP id t20-20020a7bc3d4000000b00402bbccea52mr9347671wmj.12.1694466261045;
        Mon, 11 Sep 2023 14:04:21 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z20-20020a1c4c14000000b00402e942561fsm14261699wmf.38.2023.09.11.14.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 14:04:20 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
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
Subject: [PATCH v11 net-next 14/23] net/tcp: Add TCP-AO SNE support
Date:   Mon, 11 Sep 2023 22:03:34 +0100
Message-ID: <20230911210346.301750-15-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911210346.301750-1-dima@arista.com>
References: <20230911210346.301750-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sequence Number Extension (SNE) for TCP-AO.
This is needed to protect long-living TCP-AO connections from replaying
attacks after sequence number roll-over, see RFC5925 (6.2).

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp_ao.h     | 22 ++++++++++++++++++++-
 net/ipv4/tcp_ao.c        | 41 ++++++++++++++++++++++++++++++++--------
 net/ipv4/tcp_input.c     | 28 +++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c      |  3 ++-
 net/ipv4/tcp_minisocks.c | 15 ++++++++++++++-
 net/ipv4/tcp_output.c    |  6 +++++-
 net/ipv6/tcp_ipv6.c      |  3 ++-
 7 files changed, 105 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index ec9a247f58cb..e62452bc17d6 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -95,6 +95,25 @@ struct tcp_ao_info {
 				__unused	:31;
 	__be32			lisn;
 	__be32			risn;
+	/* Sequence Number Extension (SNE) are upper 4 bytes for SEQ,
+	 * that protect TCP-AO connection from replayed old TCP segments.
+	 * See RFC5925 (6.2).
+	 * In order to get correct SNE, there's a helper tcp_ao_compute_sne().
+	 * It needs SEQ basis to understand whereabouts are lower SEQ numbers.
+	 * According to that basis vector, it can provide incremented SNE
+	 * when SEQ rolls over or provide decremented SNE when there's
+	 * a retransmitted segment from before-rolling over.
+	 * - for request sockets such basis is rcv_isn/snt_isn, which seems
+	 *   good enough as it's unexpected to receive 4 Gbytes on reqsk.
+	 * - for full sockets the basis is rcv_nxt/snd_una. snd_una is
+	 *   taken instead of snd_nxt as currently it's easier to track
+	 *   in tcp_snd_una_update(), rather than updating SNE in all
+	 *   WRITE_ONCE(tp->snd_nxt, ...)
+	 * - for time-wait sockets the basis is tw_rcv_nxt/tw_snd_nxt.
+	 *   tw_snd_nxt is not expected to change, while tw_rcv_nxt may.
+	 */
+	u32			snd_sne;
+	u32			rcv_sne;
 	atomic_t		refcnt;		/* Protects twsk destruction */
 	struct rcu_head		rcu;
 };
@@ -145,6 +164,7 @@ enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
 			const struct request_sock *req,
 			const struct tcp_ao_hdr *aoh);
+u32 tcp_ao_compute_sne(u32 next_sne, u32 next_seq, u32 seq);
 struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 				    const union tcp_ao_addr *addr,
 				    int family, int sndid, int rcvid);
@@ -154,7 +174,7 @@ int tcp_ao_hash_hdr(unsigned short family, char *ao_hash,
 		    const union tcp_ao_addr *saddr,
 		    const struct tcphdr *th, u32 sne);
 int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
-			 const struct tcp_ao_hdr *aoh, int l3index,
+			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
 			 struct tcp_ao_key **key, char **traffic_key,
 			 bool *allocated_traffic_key, u8 *keyid, u32 *sne);
 
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index ec636a8ecf33..0b5621cbc744 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -401,6 +401,21 @@ static int tcp_ao_hash_pseudoheader(unsigned short int family,
 	return -EAFNOSUPPORT;
 }
 
+u32 tcp_ao_compute_sne(u32 next_sne, u32 next_seq, u32 seq)
+{
+	u32 sne = next_sne;
+
+	if (before(seq, next_seq)) {
+		if (seq > next_seq)
+			sne--;
+	} else {
+		if (seq < next_seq)
+			sne++;
+	}
+
+	return sne;
+}
+
 /* tcp_ao_hash_sne(struct tcp_sigpool *hp)
  * @hp	- used for hashing
  * @sne - sne value
@@ -611,7 +626,7 @@ struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 }
 
 int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
-			 const struct tcp_ao_hdr *aoh, int l3index,
+			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
 			 struct tcp_ao_key **key, char **traffic_key,
 			 bool *allocated_traffic_key, u8 *keyid, u32 *sne)
 {
@@ -639,7 +654,7 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 
 			sisn = htonl(tcp_rsk(req)->rcv_isn);
 			disn = htonl(tcp_rsk(req)->snt_isn);
-			*sne = 0;
+			*sne = tcp_ao_compute_sne(0, tcp_rsk(req)->snt_isn, seq);
 		} else {
 			sisn = th->seq;
 			disn = 0;
@@ -671,11 +686,15 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		*keyid = (*key)->rcvid;
 	} else {
 		struct tcp_ao_key *rnext_key;
+		u32 snd_basis;
 
-		if (sk->sk_state == TCP_TIME_WAIT)
+		if (sk->sk_state == TCP_TIME_WAIT) {
 			ao_info = rcu_dereference(tcp_twsk(sk)->ao_info);
-		else
+			snd_basis = tcp_twsk(sk)->tw_snd_nxt;
+		} else {
 			ao_info = rcu_dereference(tcp_sk(sk)->ao_info);
+			snd_basis = tcp_sk(sk)->snd_una;
+		}
 		if (!ao_info)
 			return -ENOENT;
 
@@ -685,7 +704,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		*traffic_key = snd_other_key(*key);
 		rnext_key = READ_ONCE(ao_info->rnext_key);
 		*keyid = rnext_key->rcvid;
-		*sne = 0;
+		*sne = tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne),
+					  snd_basis, seq);
 	}
 	return 0;
 }
@@ -814,7 +834,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		if (unlikely(th->syn && !th->ack))
 			goto verify_hash;
 
-		sne = 0;
+		sne = tcp_ao_compute_sne(info->rcv_sne, tcp_sk(sk)->rcv_nxt,
+					 ntohl(th->seq));
 		/* Established socket, traffic key are cached */
 		traffic_key = rcv_other_key(key);
 		err = tcp_ao_verify_hash(sk, skb, family, info, aoh, key,
@@ -849,14 +870,16 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
 		/* Make the initial syn the likely case here */
 		if (unlikely(req)) {
-			sne = 0;
+			sne = tcp_ao_compute_sne(0, tcp_rsk(req)->rcv_isn,
+						 ntohl(th->seq));
 			sisn = htonl(tcp_rsk(req)->rcv_isn);
 			disn = htonl(tcp_rsk(req)->snt_isn);
 		} else if (unlikely(th->ack && !th->syn)) {
 			/* Possible syncookie packet */
 			sisn = htonl(ntohl(th->seq) - 1);
 			disn = htonl(ntohl(th->ack_seq) - 1);
-			sne = 0;
+			sne = tcp_ao_compute_sne(0, ntohl(sisn),
+						 ntohl(th->seq));
 		} else if (unlikely(!th->syn)) {
 			/* no way to figure out initial sisn/disn - drop */
 			return SKB_DROP_REASON_TCP_FLAGS;
@@ -955,6 +978,7 @@ void tcp_ao_connect_init(struct sock *sk)
 		tp->tcp_header_len += tcp_ao_len(key);
 
 		ao_info->lisn = htonl(tp->write_seq);
+		ao_info->snd_sne = 0;
 	} else {
 		/* TODO: probably, it should fail to connect() here */
 		rcu_assign_pointer(tp->ao_info, NULL);
@@ -973,6 +997,7 @@ void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
 		return;
 
 	ao->risn = tcp_hdr(skb)->seq;
+	ao->rcv_sne = 0;
 
 	hlist_for_each_entry_rcu(key, &ao->head, node)
 		tcp_ao_cache_traffic_keys(sk, ao, key);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 59154235056e..1e9e423bb718 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3532,9 +3532,18 @@ static inline bool tcp_may_update_window(const struct tcp_sock *tp,
 static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
 {
 	u32 delta = ack - tp->snd_una;
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao;
+#endif
 
 	sock_owned_by_me((struct sock *)tp);
 	tp->bytes_acked += delta;
+#ifdef CONFIG_TCP_AO
+	ao = rcu_dereference_protected(tp->ao_info,
+				       lockdep_sock_is_held((struct sock *)tp));
+	if (ao && ack < tp->snd_una)
+		ao->snd_sne++;
+#endif
 	tp->snd_una = ack;
 }
 
@@ -3542,9 +3551,18 @@ static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
 static void tcp_rcv_nxt_update(struct tcp_sock *tp, u32 seq)
 {
 	u32 delta = seq - tp->rcv_nxt;
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao;
+#endif
 
 	sock_owned_by_me((struct sock *)tp);
 	tp->bytes_received += delta;
+#ifdef CONFIG_TCP_AO
+	ao = rcu_dereference_protected(tp->ao_info,
+				       lockdep_sock_is_held((struct sock *)tp));
+	if (ao && seq < tp->rcv_nxt)
+		ao->rcv_sne++;
+#endif
 	WRITE_ONCE(tp->rcv_nxt, seq);
 }
 
@@ -6392,6 +6410,16 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 * simultaneous connect with crossed SYNs.
 		 * Particularly, it can be connect to self.
 		 */
+#ifdef CONFIG_TCP_AO
+		struct tcp_ao_info *ao;
+
+		ao = rcu_dereference_protected(tp->ao_info,
+					       lockdep_sock_is_held(sk));
+		if (ao) {
+			ao->risn = th->seq;
+			ao->rcv_sne = 0;
+		}
+#endif
 		tcp_set_state(sk, TCP_SYN_RECV);
 
 		if (tp->rx_opt.saw_tstamp) {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5f6829f1a5cf..0f702b33fdef 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -675,7 +675,7 @@ static bool tcp_v4_ao_sign_reset(const struct sock *sk, struct sk_buff *skb,
 	u8 keyid;
 
 	rcu_read_lock();
-	if (tcp_ao_prepare_reset(sk, skb, aoh, l3index,
+	if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, ntohl(reply->seq),
 				 &key, &traffic_key, &allocated_traffic_key,
 				 &keyid, &ao_sne))
 		goto out;
@@ -1038,6 +1038,7 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 		struct tcp_ao_key *rnext_key;
 
 		traffic_key = snd_other_key(ao_key);
+		ao_sne = READ_ONCE(ao_info->snd_sne);
 		rnext_key = READ_ONCE(ao_info->rnext_key);
 		rcv_next = rnext_key->rcvid;
 	}
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index e5c6fe0e2a6e..b594439dad82 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -51,6 +51,18 @@ tcp_timewait_check_oow_rate_limit(struct inet_timewait_sock *tw,
 	return TCP_TW_SUCCESS;
 }
 
+static void twsk_rcv_nxt_update(struct tcp_timewait_sock *tcptw, u32 seq)
+{
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao;
+
+	ao = rcu_dereference(tcptw->ao_info);
+	if (unlikely(ao && seq < tcptw->tw_rcv_nxt))
+		WRITE_ONCE(ao->rcv_sne, ao->rcv_sne + 1);
+#endif
+	tcptw->tw_rcv_nxt = seq;
+}
+
 /*
  * * Main purpose of TIME-WAIT state is to close connection gracefully,
  *   when one of ends sits in LAST-ACK or CLOSING retransmitting FIN
@@ -136,7 +148,8 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 
 		/* FIN arrived, enter true time-wait state. */
 		tw->tw_substate	  = TCP_TIME_WAIT;
-		tcptw->tw_rcv_nxt = TCP_SKB_CB(skb)->end_seq;
+		twsk_rcv_nxt_update(tcptw, TCP_SKB_CB(skb)->end_seq);
+
 		if (tmp_opt.saw_tstamp) {
 			tcptw->tw_ts_recent_stamp = ktime_get_seconds();
 			tcptw->tw_ts_recent	  = tmp_opt.rcv_tsval;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c9d6decef443..cd78620f6554 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1457,6 +1457,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		u8 *traffic_key;
 		void *tkey_buf = NULL;
 		__be32 disn;
+		u32 sne;
 
 		sk_gso_disable(sk);
 		if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
@@ -1474,9 +1475,12 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		} else {
 			traffic_key = snd_other_key(ao_key);
 		}
+		sne = tcp_ao_compute_sne(READ_ONCE(ao->snd_sne),
+					 READ_ONCE(tp->snd_una),
+					 ntohl(th->seq));
 		tp->af_specific->calc_ao_hash(opts.hash_location, ao_key, sk, skb,
 					      traffic_key,
-					      opts.hash_location - (u8 *)th, 0);
+					      opts.hash_location - (u8 *)th, sne);
 		kfree(tkey_buf);
 	}
 #endif
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9687ae199349..59719c8bc5ac 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1098,7 +1098,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		int l3index;
 
 		l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
-		if (tcp_ao_prepare_reset(sk, skb, aoh, l3index,
+		if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, seq,
 					 &ao_key, &traffic_key,
 					 &allocated_traffic_key,
 					 &rcv_next, &ao_sne))
@@ -1180,6 +1180,7 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 		/* rcv_next switches to our rcv_next */
 		rnext_key = READ_ONCE(ao_info->rnext_key);
 		rcv_next = rnext_key->rcvid;
+		ao_sne = READ_ONCE(ao_info->snd_sne);
 	}
 #endif
 
-- 
2.41.0

