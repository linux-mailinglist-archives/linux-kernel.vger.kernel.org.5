Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3CF75CEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjGUQXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjGUQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:22:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1352249CA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:19:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso18817155e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1689956389; x=1690561189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1Hko4AFcO0IMdyB7ocCH9V+zaUpkiTYdC3M+qmlMZ4=;
        b=jT5bLDnv1uDQH3GysAe3SXicpz4gNYBDBJC/AgDX6POstquAgsETAAOpy1HoU7QlRK
         ufJzAnZmnC6R7QpbW1nCApfeHd/HCObDMNhgPZeToVg4hQqHLGcACqzevz3fbYPIjrRN
         hYONqmqpKUlSSer+cYOux1TNlhMHyZlO/rHcplF/7Q6RasMMgYD+wQWQClANfepreXAC
         BmFu9dCG0kWsynijxYDdZZys4VHlyPmGWhjXCBSc98Bj1A59yMRM3K0YQC/x+WLHanLy
         S//eIrMByFlBECnMLrNEtiKbPU5d1FqCIHUaVXe9al4tM4qgrucIrZrCZ/Rdyx7waLxz
         Wlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956389; x=1690561189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1Hko4AFcO0IMdyB7ocCH9V+zaUpkiTYdC3M+qmlMZ4=;
        b=ZaD5JMsgCcRsinWn1PakNQQy/cAu5z0BWfW/BNWuzWzbIfVTkgtVWIbmaQkBujBhaP
         gH2WFgDvKtrFWdjBPUglnZBxFSfts3PWJ+29cctNPG4B91Qn/7PoUfjeNnAK3AxbA3Ju
         iByAj6qc63D/ool0PSNsMNjJbHD4uVV4+9aB4HXil4FJ1Y3ykgQHnJq4q0nvcHfaJeou
         r5DIeK23kG0Tb3aIEe64zPDBRo8+a350pkcjUCnHYJ+9hkp0n7jNOSOUR5Rjfb1BsXJQ
         el+2u7u0B0EnnSTQVTXWUoU/gpV0z+PUIYQN+nf7JYKa83Cz/+5853oUuRJxqrq7scW0
         Mo5A==
X-Gm-Message-State: ABy/qLYXgOe0WPgnp63iUBEtLK5S0vschTuv6Llu6rdvdTdGI1PW3+rF
        JG/+N3W1BoCbZ9l97jxXGv9etw==
X-Google-Smtp-Source: APBJJlGACTBTVvdBV81kYDy1biqNiInbdieyM4xUCibqxpUSbwbMTXtx6XwkNIXCsTKCaNCJlNIrRw==
X-Received: by 2002:a05:600c:2047:b0:3fb:e643:1225 with SMTP id p7-20020a05600c204700b003fbe6431225mr1825804wmg.13.1689956388940;
        Fri, 21 Jul 2023 09:19:48 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l19-20020a7bc453000000b003fbc681c8d1sm6390210wmi.36.2023.07.21.09.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:19:48 -0700 (PDT)
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
        Salam Noureddine <noureddine@arista.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: [PATCH v8.1 net-next 14/23] net/tcp: Add TCP-AO SNE support
Date:   Fri, 21 Jul 2023 17:19:05 +0100
Message-ID: <20230721161916.542667-15-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721161916.542667-1-dima@arista.com>
References: <20230721161916.542667-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
---
 include/net/tcp_ao.h     | 20 ++++++++++++++++++++
 net/ipv4/tcp_ao.c        | 40 +++++++++++++++++++++++++++++++++-------
 net/ipv4/tcp_input.c     | 28 ++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c      |  1 +
 net/ipv4/tcp_minisocks.c | 15 ++++++++++++++-
 net/ipv4/tcp_output.c    |  6 +++++-
 net/ipv6/tcp_ipv6.c      |  1 +
 7 files changed, 102 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 0a02098bddeb..fc5674763730 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -96,6 +96,25 @@ struct tcp_ao_info {
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
@@ -144,6 +163,7 @@ enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
 			const struct request_sock *req,
 			const struct tcp_ao_hdr *aoh);
+u32 tcp_ao_compute_sne(u32 next_sne, u32 next_seq, u32 seq);
 struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 				    const union tcp_ao_addr *addr,
 				    int family, int sndid, int rcvid, u16 port);
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 5ab66928a952..5ebbfadfbfd0 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -403,6 +403,21 @@ static int tcp_ao_hash_pseudoheader(unsigned short int family,
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
@@ -641,7 +656,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 
 			sisn = htonl(tcp_rsk(req)->rcv_isn);
 			disn = htonl(tcp_rsk(req)->snt_isn);
-			*sne = 0;
+			*sne = tcp_ao_compute_sne(0, tcp_rsk(req)->snt_isn,
+						  ntohl(seq));
 		} else {
 			sisn = th->seq;
 			disn = 0;
@@ -674,11 +690,15 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
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
 
@@ -688,7 +708,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		*traffic_key = snd_other_key(*key);
 		rnext_key = READ_ONCE(ao_info->rnext_key);
 		*keyid = rnext_key->rcvid;
-		*sne = 0;
+		*sne = tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne),
+					  snd_basis, ntohl(seq));
 	}
 	return 0;
 }
@@ -821,7 +842,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		if (unlikely(th->syn && !th->ack))
 			goto verify_hash;
 
-		sne = 0;
+		sne = tcp_ao_compute_sne(info->rcv_sne, tcp_sk(sk)->rcv_nxt,
+					 ntohl(th->seq));
 		/* Established socket, traffic key are cached */
 		traffic_key = rcv_other_key(key);
 		err = tcp_ao_verify_hash(sk, skb, family, info, aoh, key,
@@ -856,14 +878,16 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
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
@@ -963,6 +987,7 @@ void tcp_ao_connect_init(struct sock *sk)
 		tp->tcp_header_len += tcp_ao_len(key);
 
 		ao_info->lisn = htonl(tp->write_seq);
+		ao_info->snd_sne = 0;
 	} else {
 		/* TODO: probably, it should fail to connect() here */
 		rcu_assign_pointer(tp->ao_info, NULL);
@@ -981,6 +1006,7 @@ void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
 		return;
 
 	ao->risn = tcp_hdr(skb)->seq;
+	ao->rcv_sne = 0;
 
 	hlist_for_each_entry_rcu(key, &ao->head, node)
 		tcp_ao_cache_traffic_keys(sk, ao, key);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2a7ed329f7cb..4b37e82ab612 100644
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
 
@@ -6387,6 +6405,16 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
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
index d8d2499b5e26..37497dec5eb9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1039,6 +1039,7 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 		struct tcp_ao_key *rnext_key;
 
 		traffic_key = snd_other_key(ao_key);
+		ao_sne = READ_ONCE(ao_info->snd_sne);
 		rnext_key = READ_ONCE(ao_info->rnext_key);
 		rcv_next = rnext_key->rcvid;
 	}
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 11b76fa601a7..3b367365dc7d 100644
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
index ed1164f287b7..d87a3823fec5 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1443,6 +1443,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		u8 *traffic_key;
 		void *tkey_buf = NULL;
 		u32 disn;
+		u32 sne;
 
 		sk_gso_disable(sk);
 		if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {
@@ -1460,9 +1461,12 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
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
index c825d7c80f5b..873ce0d72f34 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1180,6 +1180,7 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 		/* rcv_next switches to our rcv_next */
 		rnext_key = READ_ONCE(ao_info->rnext_key);
 		rcv_next = rnext_key->rcvid;
+		ao_sne = READ_ONCE(ao_info->snd_sne);
 	}
 #endif
 
-- 
2.41.0

