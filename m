Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2D7BEED2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379066AbjJIXJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379075AbjJIXI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:08:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249D9193
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:07:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso46572025e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1696892871; x=1697497671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmfxTdTv7SROsm0CD9D/66Mv9P7AuZjhowXOKcHQB+A=;
        b=Bsqpdme69HQTip/tFAloU8oDabv4w7WSB/tPeEd2+V+XVGHXrjSUcbiSm4hJrdXfuE
         njomDsjXjq7OlI5mBOTXIa6qVs1LvJ1SXQJ4w98UQLR9SVMXG9R2rs14B68PW8hXd4z8
         AETp97MNACEuhl0x9wcjv6XEh3VDplR+S7pLLmqBwerE3qFLS2ynOl2kihgXs/ZTHNsn
         j5qQ9ziu5qIQGv9CeC+7obmw0ibGi0DCDmTTav12TKVV3brN2+8m7japfHMWpAtiAJok
         sbGdsWfb12WUqIfXeZ9PTuEjgouE9cTh9tAZ0rQil0pv15LxN5pLl2Z63bQE9KvZ/Slq
         4zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892871; x=1697497671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmfxTdTv7SROsm0CD9D/66Mv9P7AuZjhowXOKcHQB+A=;
        b=hjRB4j+f+YwmmW+ZqEOpk/YMPge0G7wbzTTdJY6QQQRJNfWx/HJasG5c5DU/GgsNhv
         vhMTY4SKS9q5V1GTvNWms3dZ5xHWc/F1fQaJxNwvsRMeZvlXNEX/BII8/yF0RYMek0m0
         ok9xhqhhVmvJErdlaxWGkn3hydiWtxoxoCXY6kvaPNV6hYuW71zCIUxlIyJQPDAwBSBu
         YgqAHBMFcNV/+065Qn21Up6YJPbWzNmMK2Jv66TtjscgDLKaJUDNK1HD8gl/qcmUcFPW
         Lkvdk8bE/Xxwt6n+1a/NOwtldLPX/O1vIbbEuMVODksXfighN0OhllQpDb7x42GV+o3t
         Ly8A==
X-Gm-Message-State: AOJu0YxrEeTAduV6wPJNqNXEgTMg/7LLrYOxHzRo2G0GeF+a6LFLpbgq
        PoRkMf4PMXY54MjlPloDsQh8lw==
X-Google-Smtp-Source: AGHT+IGj2Yw2XElBGI2AkVtdkCYIvnR8HMZYDBEI4RMcfuGvQw2KLtgEdhEdZWvCdpnv8k+72v+UQA==
X-Received: by 2002:a05:600c:28c:b0:406:44e6:15f0 with SMTP id 12-20020a05600c028c00b0040644e615f0mr13935941wmk.5.1696892871131;
        Mon, 09 Oct 2023 16:07:51 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b004042dbb8925sm14592104wmj.38.2023.10.09.16.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:07:50 -0700 (PDT)
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
Subject: [PATCH v14 net-next 14/23] net/tcp: Add TCP-AO SNE support
Date:   Tue, 10 Oct 2023 00:07:05 +0100
Message-ID: <20231009230722.76268-15-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009230722.76268-1-dima@arista.com>
References: <20231009230722.76268-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp_ao.h     | 22 ++++++++++++++++++-
 net/ipv4/tcp_ao.c        | 46 ++++++++++++++++++++++++++++++++--------
 net/ipv4/tcp_input.c     | 28 ++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c      |  3 ++-
 net/ipv4/tcp_minisocks.c | 15 ++++++++++++-
 net/ipv6/tcp_ipv6.c      |  3 ++-
 6 files changed, 104 insertions(+), 13 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index b34b9a37c81b..9e37193fe805 100644
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
@@ -147,6 +166,7 @@ enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
 			const struct request_sock *req,
 			const struct tcp_ao_hdr *aoh);
+u32 tcp_ao_compute_sne(u32 next_sne, u32 next_seq, u32 seq);
 struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 				    const union tcp_ao_addr *addr,
 				    int family, int sndid, int rcvid);
@@ -156,7 +176,7 @@ int tcp_ao_hash_hdr(unsigned short family, char *ao_hash,
 		    const union tcp_ao_addr *saddr,
 		    const struct tcphdr *th, u32 sne);
 int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
-			 const struct tcp_ao_hdr *aoh, int l3index,
+			 const struct tcp_ao_hdr *aoh, int l3index, u32 seq,
 			 struct tcp_ao_key **key, char **traffic_key,
 			 bool *allocated_traffic_key, u8 *keyid, u32 *sne);
 
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index f7ee2aecf8fc..deae7209f8a1 100644
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
@@ -670,11 +685,15 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
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
 
@@ -684,7 +703,8 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		*traffic_key = snd_other_key(*key);
 		rnext_key = READ_ONCE(ao_info->rnext_key);
 		*keyid = rnext_key->rcvid;
-		*sne = 0;
+		*sne = tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne),
+					  snd_basis, seq);
 	}
 	return 0;
 }
@@ -698,6 +718,7 @@ int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	struct tcp_ao_info *ao;
 	void *tkey_buf = NULL;
 	u8 *traffic_key;
+	u32 sne;
 
 	ao = rcu_dereference_protected(tcp_sk(sk)->ao_info,
 				       lockdep_sock_is_held(sk));
@@ -717,8 +738,10 @@ int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		tp->af_specific->ao_calc_key_sk(key, traffic_key,
 						sk, ao->lisn, disn, true);
 	}
+	sne = tcp_ao_compute_sne(READ_ONCE(ao->snd_sne), READ_ONCE(tp->snd_una),
+				 ntohl(th->seq));
 	tp->af_specific->calc_ao_hash(hash_location, key, sk, skb, traffic_key,
-				      hash_location - (u8 *)th, 0);
+				      hash_location - (u8 *)th, sne);
 	kfree(tkey_buf);
 	return 0;
 }
@@ -846,7 +869,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		if (unlikely(th->syn && !th->ack))
 			goto verify_hash;
 
-		sne = 0;
+		sne = tcp_ao_compute_sne(info->rcv_sne, tcp_sk(sk)->rcv_nxt,
+					 ntohl(th->seq));
 		/* Established socket, traffic key are cached */
 		traffic_key = rcv_other_key(key);
 		err = tcp_ao_verify_hash(sk, skb, family, info, aoh, key,
@@ -881,14 +905,16 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
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
@@ -986,6 +1012,7 @@ void tcp_ao_connect_init(struct sock *sk)
 		tp->tcp_header_len += tcp_ao_len(key);
 
 		ao_info->lisn = htonl(tp->write_seq);
+		ao_info->snd_sne = 0;
 	} else {
 		/* TODO: probably, it should fail to connect() here */
 		rcu_assign_pointer(tp->ao_info, NULL);
@@ -1018,6 +1045,7 @@ void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
 		return;
 
 	WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
+	ao->rcv_sne = 0;
 
 	hlist_for_each_entry_rcu(key, &ao->head, node)
 		tcp_ao_cache_traffic_keys(sk, ao, key);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 520776714591..219c0e2ce803 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3559,9 +3559,18 @@ static inline bool tcp_may_update_window(const struct tcp_sock *tp,
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
 
@@ -3569,9 +3578,18 @@ static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
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
 
@@ -6427,6 +6445,16 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 * simultaneous connect with crossed SYNs.
 		 * Particularly, it can be connect to self.
 		 */
+#ifdef CONFIG_TCP_AO
+		struct tcp_ao_info *ao;
+
+		ao = rcu_dereference_protected(tp->ao_info,
+					       lockdep_sock_is_held(sk));
+		if (ao) {
+			WRITE_ONCE(ao->risn, th->seq);
+			ao->rcv_sne = 0;
+		}
+#endif
 		tcp_set_state(sk, TCP_SYN_RECV);
 
 		if (tp->rx_opt.saw_tstamp) {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1e714b26d9ce..48fb81a8a712 100644
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
@@ -1033,6 +1033,7 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 		struct tcp_ao_key *rnext_key;
 
 		key.traffic_key = snd_other_key(key.ao_key);
+		key.sne = READ_ONCE(ao_info->snd_sne);
 		rnext_key = READ_ONCE(ao_info->rnext_key);
 		key.rcv_next = rnext_key->rcvid;
 		key.type = TCP_KEY_AO;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index a6ece0edf4d7..96963c15a05e 100644
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
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d022659f40e8..25911302d5e3 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1087,7 +1087,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		int l3index;
 
 		l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
-		if (tcp_ao_prepare_reset(sk, skb, aoh, l3index,
+		if (tcp_ao_prepare_reset(sk, skb, aoh, l3index, seq,
 					 &key.ao_key, &key.traffic_key,
 					 &allocated_traffic_key,
 					 &key.rcv_next, &key.sne))
@@ -1164,6 +1164,7 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 		/* rcv_next switches to our rcv_next */
 		rnext_key = READ_ONCE(ao_info->rnext_key);
 		key.rcv_next = rnext_key->rcvid;
+		key.sne = READ_ONCE(ao_info->snd_sne);
 		key.type = TCP_KEY_AO;
 #else
 	if (0) {
-- 
2.42.0

