Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8467FC694
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346588AbjK1U6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346432AbjK1U6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:58:01 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802AC1988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:58:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-409299277bbso44973775e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701205085; x=1701809885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSvJAX5xEWm65BCEWRMtE0TH1+4ODDUnnX8Wr582TKo=;
        b=cMcanfZv44ih24nQp4KkGWgZQEEJ/NPH12hvhgAbiZodmi/ViAstGT8cBrC/y3G+rn
         y2QvIQYV1ab1ia+T6fYPRaXEWNeXpS41cNb3m7q16epyKlKeCErV/Rnc6ENJvD76xAPe
         aUm1tOj6LQyy1fknhRktkTSRp4wrn6AEnHi2u3TuK8FuuYLXYDL/8s34PEZanU3PwuQP
         i7mRz4dH5J+nUUli+Pwg/gyeZHqxNDdz03XusjZjszgj2n9IcmdGE9jiPZTYnEM8AFY8
         7rLp61P8uIeh8FB+cAbEQm+qq7W1JeO9BMszGEu7tP05hCWki9Ud0KK9j+Na8HVAk4g1
         FEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205085; x=1701809885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSvJAX5xEWm65BCEWRMtE0TH1+4ODDUnnX8Wr582TKo=;
        b=Hd4aC3Es0O3oUap2jD/YbyHtHHifiQJ9qGr+mdQiNgSxhraTw9OJLEh9N6yXcWKLP0
         1cWKdFA/l08WNrAeGfY7JB25aGhxsHneAXF7IrdgS2paFqdjwTbhd85NhTYiC0WzMUaP
         hUF66RqnDDeaLvuUaHI63lI9vtmJ/bUzjrGsCP9DwNnSUvo1CABiZ7F0BVEiNeU8ygGL
         dad8v3vcoidRlzJe7o1bf0ZbsZD2IlP2YYs2qDKqPdqldlJd6xXhmUbe5ZqyjqoVc2P8
         UCUcbX9BEa5ZHxe/6ixtN6ptFpZRmgIXk1L/Dw826hW65qw/CTyhHBYuuV6Jt9wXGzd/
         Wt0A==
X-Gm-Message-State: AOJu0YzjOU9NMKatz+P8F22zbowap3fMuQagTQKkos1WOKvA016SvIQw
        5rk4xxKx1y1inWUPMRTqDQj1rA==
X-Google-Smtp-Source: AGHT+IFS6+qtcy5whq9ymBpsW6yatWbluZp3Eekvf6Qxi7Y7fNVqZ/CAjwgxt+Ezr96AHCJH7HBCgQ==
X-Received: by 2002:a05:6000:224:b0:332:e7da:a167 with SMTP id l4-20020a056000022400b00332e7daa167mr10301640wrz.16.1701205085021;
        Tue, 28 Nov 2023 12:58:05 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0040b45356b72sm9247423wmq.33.2023.11.28.12.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:58:04 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH v3 6/7] net/tcp: Store SNEs + SEQs on ao_info
Date:   Tue, 28 Nov 2023 20:57:48 +0000
Message-ID: <20231128205749.312759-7-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128205749.312759-1-dima@arista.com>
References: <20231128205749.312759-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC 5925 (6.2):
> TCP-AO emulates a 64-bit sequence number space by inferring when to
> increment the high-order 32-bit portion (the SNE) based on
> transitions in the low-order portion (the TCP sequence number).

snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
Unfortunately, reading two 4-bytes pointers can't be performed
atomically (without synchronization).

In order to avoid locks on TCP fastpath, let's just double-account for
SEQ changes: snd_una/rcv_nxt will be lower 4 bytes of snd_sne/rcv_sne.

Fixes: 64382c71a557 ("net/tcp: Add TCP-AO SNE support")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp_ao.h    | 25 +++++++++++++++++---
 net/ipv4/tcp.c          |  7 ++++--
 net/ipv4/tcp_ao.c       | 51 ++++++++++++++++++++++-------------------
 net/ipv4/tcp_fastopen.c |  2 ++
 net/ipv4/tcp_input.c    | 21 ++++++++++-------
 net/ipv4/tcp_output.c   |  1 +
 6 files changed, 71 insertions(+), 36 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 647781080613..b8ef25d4b632 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -121,8 +121,8 @@ struct tcp_ao_info {
 	 * - for time-wait sockets the basis is tw_rcv_nxt/tw_snd_nxt.
 	 *   tw_snd_nxt is not expected to change, while tw_rcv_nxt may.
 	 */
-	u32			snd_sne;
-	u32			rcv_sne;
+	u64			snd_sne;
+	u64			rcv_sne;
 	refcount_t		refcnt;		/* Protects twsk destruction */
 	struct rcu_head		rcu;
 };
@@ -212,7 +212,6 @@ enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
 			const struct sk_buff *skb, unsigned short int family,
 			const struct request_sock *req, int l3index,
 			const struct tcp_ao_hdr *aoh);
-u32 tcp_ao_compute_sne(u32 next_sne, u32 next_seq, u32 seq);
 struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk, int l3index,
 				    const union tcp_ao_addr *addr,
 				    int family, int sndid, int rcvid);
@@ -353,6 +352,26 @@ static inline int tcp_ao_set_repair(struct sock *sk,
 }
 #endif
 
+static inline void tcp_ao_sne_set(struct tcp_sock *tp, bool send, u64 sne)
+{
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao;
+
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return;
+
+	ao = rcu_dereference_protected(tp->ao_info,
+				       lockdep_sock_is_held((struct sock *)tp));
+	if (!ao)
+		return;
+
+	if (send)
+		WRITE_ONCE(ao->snd_sne, sne);
+	else
+		WRITE_ONCE(ao->rcv_sne, sne);
+#endif
+}
+
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 int tcp_do_parse_auth_options(const struct tcphdr *th,
 			      const u8 **md5_hash, const u8 **ao_hash);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b1fe4eb01829..431c10917d27 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3545,16 +3545,19 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (sk->sk_state != TCP_CLOSE) {
 			err = -EPERM;
 		} else if (tp->repair_queue == TCP_SEND_QUEUE) {
-			if (!tcp_rtx_queue_empty(sk))
+			if (!tcp_rtx_queue_empty(sk)) {
 				err = -EPERM;
-			else
+			} else {
 				WRITE_ONCE(tp->write_seq, val);
+				tcp_ao_sne_set(tp, true, val);
+			}
 		} else if (tp->repair_queue == TCP_RECV_QUEUE) {
 			if (tp->rcv_nxt != tp->copied_seq) {
 				err = -EPERM;
 			} else {
 				WRITE_ONCE(tp->rcv_nxt, val);
 				WRITE_ONCE(tp->copied_seq, val);
+				tcp_ao_sne_set(tp, false, val);
 			}
 		} else {
 			err = -EINVAL;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 2d000e275ce7..fe68983fcf26 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -472,9 +472,10 @@ static int tcp_ao_hash_pseudoheader(unsigned short int family,
 	return -EAFNOSUPPORT;
 }
 
-u32 tcp_ao_compute_sne(u32 next_sne, u32 next_seq, u32 seq)
+static u32 tcp_ao_compute_sne(u64 seq_sne, u32 seq)
 {
-	u32 sne = next_sne;
+	u32 next_seq = (u32)(seq_sne & 0xffffffff);
+	u32 sne = seq_sne >> 32;
 
 	if (before(seq, next_seq)) {
 		if (seq > next_seq)
@@ -483,7 +484,6 @@ u32 tcp_ao_compute_sne(u32 next_sne, u32 next_seq, u32 seq)
 		if (seq < next_seq)
 			sne++;
 	}
-
 	return sne;
 }
 
@@ -731,7 +731,7 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 
 			sisn = htonl(tcp_rsk(req)->rcv_isn);
 			disn = htonl(tcp_rsk(req)->snt_isn);
-			*sne = tcp_ao_compute_sne(0, tcp_rsk(req)->snt_isn, seq);
+			*sne = tcp_ao_compute_sne(tcp_rsk(req)->snt_isn, seq);
 		} else {
 			sisn = th->seq;
 			disn = 0;
@@ -763,14 +763,11 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		*keyid = (*key)->rcvid;
 	} else {
 		struct tcp_ao_key *rnext_key;
-		u32 snd_basis;
 
 		if (sk->sk_state == TCP_TIME_WAIT) {
 			ao_info = rcu_dereference(tcp_twsk(sk)->ao_info);
-			snd_basis = tcp_twsk(sk)->tw_snd_nxt;
 		} else {
 			ao_info = rcu_dereference(tcp_sk(sk)->ao_info);
-			snd_basis = tcp_sk(sk)->snd_una;
 		}
 		if (!ao_info)
 			return -ENOENT;
@@ -781,8 +778,7 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 		*traffic_key = snd_other_key(*key);
 		rnext_key = READ_ONCE(ao_info->rnext_key);
 		*keyid = rnext_key->rcvid;
-		*sne = tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne),
-					  snd_basis, seq);
+		*sne = tcp_ao_compute_sne(READ_ONCE(ao_info->snd_sne), seq);
 	}
 	return 0;
 }
@@ -816,8 +812,7 @@ int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 		tp->af_specific->ao_calc_key_sk(key, traffic_key,
 						sk, ao->lisn, disn, true);
 	}
-	sne = tcp_ao_compute_sne(READ_ONCE(ao->snd_sne), READ_ONCE(tp->snd_una),
-				 ntohl(th->seq));
+	sne = tcp_ao_compute_sne(READ_ONCE(ao->snd_sne), ntohl(th->seq));
 	tp->af_specific->calc_ao_hash(hash_location, key, sk, skb, traffic_key,
 				      hash_location - (u8 *)th, sne);
 	kfree(tkey_buf);
@@ -938,8 +933,8 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 
 	/* Fast-path */
 	if (likely((1 << sk->sk_state) & TCP_AO_ESTABLISHED)) {
-		enum skb_drop_reason err;
 		struct tcp_ao_key *current_key;
+		enum skb_drop_reason err;
 
 		/* Check if this socket's rnext_key matches the keyid in the
 		 * packet. If not we lookup the key based on the keyid
@@ -956,8 +951,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		if (unlikely(th->syn && !th->ack))
 			goto verify_hash;
 
-		sne = tcp_ao_compute_sne(info->rcv_sne, tcp_sk(sk)->rcv_nxt,
-					 ntohl(th->seq));
+		sne = tcp_ao_compute_sne(READ_ONCE(info->rcv_sne), ntohl(th->seq));
 		/* Established socket, traffic key are cached */
 		traffic_key = rcv_other_key(key);
 		err = tcp_ao_verify_hash(sk, skb, family, info, aoh, key,
@@ -992,7 +986,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
 		/* Make the initial syn the likely case here */
 		if (unlikely(req)) {
-			sne = tcp_ao_compute_sne(0, tcp_rsk(req)->rcv_isn,
+			sne = tcp_ao_compute_sne(tcp_rsk(req)->rcv_isn,
 						 ntohl(th->seq));
 			sisn = htonl(tcp_rsk(req)->rcv_isn);
 			disn = htonl(tcp_rsk(req)->snt_isn);
@@ -1000,8 +994,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 			/* Possible syncookie packet */
 			sisn = htonl(ntohl(th->seq) - 1);
 			disn = htonl(ntohl(th->ack_seq) - 1);
-			sne = tcp_ao_compute_sne(0, ntohl(sisn),
-						 ntohl(th->seq));
+			sne = tcp_ao_compute_sne(ntohl(sisn), ntohl(th->seq));
 		} else if (unlikely(!th->syn)) {
 			/* no way to figure out initial sisn/disn - drop */
 			return SKB_DROP_REASON_TCP_FLAGS;
@@ -1103,7 +1096,8 @@ void tcp_ao_connect_init(struct sock *sk)
 		tp->tcp_header_len += tcp_ao_len_aligned(key);
 
 		ao_info->lisn = htonl(tp->write_seq);
-		ao_info->snd_sne = 0;
+		ao_info->snd_sne = htonl(tp->write_seq);
+		ao_info->rcv_sne = 0;
 	} else {
 		/* Can't happen: tcp_connect() verifies that there's
 		 * at least one tcp-ao key that matches the remote peer.
@@ -1139,7 +1133,7 @@ void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb)
 		return;
 
 	WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
-	ao->rcv_sne = 0;
+	WRITE_ONCE(ao->rcv_sne, ntohl(tcp_hdr(skb)->seq));
 
 	hlist_for_each_entry_rcu(key, &ao->head, node)
 		tcp_ao_cache_traffic_keys(sk, ao, key);
@@ -1169,6 +1163,8 @@ int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 		return -ENOMEM;
 	new_ao->lisn = htonl(tcp_rsk(req)->snt_isn);
 	new_ao->risn = htonl(tcp_rsk(req)->rcv_isn);
+	new_ao->snd_sne = tcp_rsk(req)->snt_isn;
+	new_ao->rcv_sne = tcp_rsk(req)->rcv_isn;
 	new_ao->ao_required = ao->ao_required;
 	new_ao->accept_icmps = ao->accept_icmps;
 
@@ -1694,6 +1690,8 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 			goto err_free_sock;
 		}
 		sk_gso_disable(sk);
+		WRITE_ONCE(ao_info->snd_sne, tcp_sk(sk)->snd_una);
+		WRITE_ONCE(ao_info->rcv_sne, tcp_sk(sk)->rcv_nxt);
 		rcu_assign_pointer(tcp_sk(sk)->ao_info, ao_info);
 	}
 
@@ -2334,6 +2332,7 @@ int tcp_ao_set_repair(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	struct tcp_ao_repair cmd;
 	struct tcp_ao_key *key;
 	struct tcp_ao_info *ao;
+	u64 sne;
 	int err;
 
 	if (optlen < sizeof(cmd))
@@ -2354,8 +2353,14 @@ int tcp_ao_set_repair(struct sock *sk, sockptr_t optval, unsigned int optlen)
 
 	WRITE_ONCE(ao->lisn, cmd.snt_isn);
 	WRITE_ONCE(ao->risn, cmd.rcv_isn);
-	WRITE_ONCE(ao->snd_sne, cmd.snd_sne);
-	WRITE_ONCE(ao->rcv_sne, cmd.rcv_sne);
+
+	sne = READ_ONCE(ao->snd_sne) & 0xffffffff;
+	sne += (u64)cmd.snd_sne << 32;
+	WRITE_ONCE(ao->snd_sne, sne);
+
+	sne = READ_ONCE(ao->rcv_sne) & 0xffffffff;
+	sne += (u64)cmd.rcv_sne << 32;
+	WRITE_ONCE(ao->rcv_sne, sne);
 
 	hlist_for_each_entry_rcu(key, &ao->head, node)
 		tcp_ao_cache_traffic_keys(sk, ao, key);
@@ -2388,8 +2393,8 @@ int tcp_ao_get_repair(struct sock *sk, sockptr_t optval, sockptr_t optlen)
 
 	opt.snt_isn	= ao->lisn;
 	opt.rcv_isn	= ao->risn;
-	opt.snd_sne	= READ_ONCE(ao->snd_sne);
-	opt.rcv_sne	= READ_ONCE(ao->rcv_sne);
+	opt.snd_sne	= READ_ONCE(ao->snd_sne) >> 32;
+	opt.rcv_sne	= READ_ONCE(ao->rcv_sne) >> 32;
 	rcu_read_unlock();
 
 	if (copy_to_sockptr(optval, &opt, min_t(int, len, sizeof(opt))))
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 8ed54e7334a9..d28d0df300d3 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -194,6 +194,7 @@ void tcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_SYN;
 
 	tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
+	tcp_ao_sne_set(tp, false, TCP_SKB_CB(skb)->end_seq);
 	__skb_queue_tail(&sk->sk_receive_queue, skb);
 	tp->syn_data_acked = 1;
 
@@ -282,6 +283,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	tcp_init_transfer(child, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);
 
 	tp->rcv_nxt = TCP_SKB_CB(skb)->seq + 1;
+	tcp_ao_sne_set(tp, false, TCP_SKB_CB(skb)->seq + 1);
 
 	tcp_fastopen_add_skb(child, skb);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bcb55d98004c..0a58447c33b1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3572,7 +3572,7 @@ static inline bool tcp_may_update_window(const struct tcp_sock *tp,
 		(ack_seq == tp->snd_wl1 && (nwin > tp->snd_wnd || !nwin));
 }
 
-static void tcp_snd_sne_update(struct tcp_sock *tp, u32 ack)
+static void tcp_ao_snd_sne_update(struct tcp_sock *tp, u32 delta)
 {
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao;
@@ -3582,8 +3582,9 @@ static void tcp_snd_sne_update(struct tcp_sock *tp, u32 ack)
 
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
-	if (ao && ack < tp->snd_una)
-		ao->snd_sne++;
+	if (!ao)
+		return;
+	WRITE_ONCE(ao->snd_sne, ao->snd_sne + delta);
 #endif
 }
 
@@ -3594,11 +3595,11 @@ static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
 
 	sock_owned_by_me((struct sock *)tp);
 	tp->bytes_acked += delta;
-	tcp_snd_sne_update(tp, ack);
+	tcp_ao_snd_sne_update(tp, delta);
 	tp->snd_una = ack;
 }
 
-static void tcp_rcv_sne_update(struct tcp_sock *tp, u32 seq)
+static void tcp_ao_rcv_sne_update(struct tcp_sock *tp, u32 delta)
 {
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao;
@@ -3608,8 +3609,9 @@ static void tcp_rcv_sne_update(struct tcp_sock *tp, u32 seq)
 
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
-	if (ao && seq < tp->rcv_nxt)
-		ao->rcv_sne++;
+	if (!ao)
+		return;
+	WRITE_ONCE(ao->rcv_sne, ao->rcv_sne + delta);
 #endif
 }
 
@@ -3620,7 +3622,7 @@ static void tcp_rcv_nxt_update(struct tcp_sock *tp, u32 seq)
 
 	sock_owned_by_me((struct sock *)tp);
 	tp->bytes_received += delta;
-	tcp_rcv_sne_update(tp, seq);
+	tcp_ao_rcv_sne_update(tp, delta);
 	WRITE_ONCE(tp->rcv_nxt, seq);
 }
 
@@ -6400,6 +6402,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 * move to established.
 		 */
 		WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
+		tcp_ao_sne_set(tp, false, TCP_SKB_CB(skb)->seq + 1);
 		tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
 
 		/* RFC1323: The window in SYN & SYN/ACK segments is
@@ -6510,6 +6513,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		}
 
 		WRITE_ONCE(tp->rcv_nxt, TCP_SKB_CB(skb)->seq + 1);
+		tcp_ao_sne_set(tp, false, TCP_SKB_CB(skb)->seq + 1);
 		WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
 		tp->rcv_wup = TCP_SKB_CB(skb)->seq + 1;
 
@@ -6722,6 +6726,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (sk->sk_socket)
 			sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);
 
+		tcp_ao_sne_set(tp, true, TCP_SKB_CB(skb)->ack_seq);
 		tp->snd_una = TCP_SKB_CB(skb)->ack_seq;
 		tp->snd_wnd = ntohs(th->window) << tp->rx_opt.snd_wscale;
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 93eef1dbbc55..3ddd057fb6f7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3882,6 +3882,7 @@ static void tcp_connect_init(struct sock *sk)
 	tp->snd_wnd = 0;
 	tcp_init_wl(tp, 0);
 	tcp_write_queue_purge(sk);
+	tcp_ao_sne_set(tp, true, tp->write_seq);
 	tp->snd_una = tp->write_seq;
 	tp->snd_sml = tp->write_seq;
 	tp->snd_up = tp->write_seq;
-- 
2.43.0

