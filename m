Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78AB7BEECF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379132AbjJIXIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378991AbjJIXII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:08:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA295133
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:07:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4054496bde3so47142005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1696892868; x=1697497668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6yvkbC9zxiESkSN/2AZ8N3F73mVw7qpiPkHO82A7NE=;
        b=b7yVO0KVDjWL+NqMbLzaZil6LSX+zCEPrD42gKsw1T4DifboujHIwV576OVfQhASKZ
         Lit3U4qJgGL7hSTU9nvJsGfqOPIqv2SnRcD54NRUy5m6j4szrEz6GOUQ6uTTyOap4V2V
         NHwwFaEAbVzdX1GX4iHbCoJG/Lg9xJfzYHNMUiUOj9mWmUTFIfvLqXu237XFQrh4fPbH
         mupeJA5KJNe85OjSZmg8kDk+Vq3p7WIUWkrbY8iiDsdhd2oETKGW7D2ZcFSB1KWrdh50
         XNhmQ1pdFAjHnAg0fua320yExZJm0k3oIWRhDR3BNzqiuCdBXu61qbc4j3ixfMxdNlbH
         Lcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892868; x=1697497668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6yvkbC9zxiESkSN/2AZ8N3F73mVw7qpiPkHO82A7NE=;
        b=h5MEyjLDHoYpreAPFW9W5xs4YXfFwWOzqqaMBMKKryNB0clrUM8Tl31Pkt6v4GJmwX
         odgMoUoVVNwv/Uuye7Xm2KzRK3dozj8lSfPK+8EXbTnNf9sBm+9au1O4Dpo2YVWRdR+E
         6Qlvv9Hywnlqqnu9AASDaJSO9Petul0/CYV/uGpMctnuMiOhdKAgTWIbJ47/ZGOTFJIy
         y6amGKlE604jHlN3UYZanOynkRb/mGgefVr3txwKS7xvFHcvJ3v1GVtB6uxMxL0Xd/Hn
         LW4sPJdfMiVAfQL5bqk7GjVBsMBcy8N0Kt76Gca8lt6p2tD9y7D/kyFx66mK8CFPFCPU
         n4VQ==
X-Gm-Message-State: AOJu0YwOXptfl63eHmAMidaQvw95KQ+UG5z6mgl9WO1GXSBqVIXNpun4
        xqeplbpyrvGJGBGgzSHFc7ae0Q==
X-Google-Smtp-Source: AGHT+IH2ydKe69G1Sv5Y+ZcvKtJnHQZs5wWvYUDbJz4IHCh9RtZCrAD0zuru1rhqi6u9kPpV6qNOeg==
X-Received: by 2002:a1c:7705:0:b0:401:d947:c8a3 with SMTP id t5-20020a1c7705000000b00401d947c8a3mr14277736wmi.32.1696892868049;
        Mon, 09 Oct 2023 16:07:48 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b004042dbb8925sm14592104wmj.38.2023.10.09.16.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:07:47 -0700 (PDT)
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
Subject: [PATCH v14 net-next 12/23] net/tcp: Verify inbound TCP-AO signed segments
Date:   Tue, 10 Oct 2023 00:07:03 +0100
Message-ID: <20231009230722.76268-13-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009230722.76268-1-dima@arista.com>
References: <20231009230722.76268-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there is a common function to verify signature on TCP segments:
tcp_inbound_hash(). It has checks for all possible cross-interactions
with MD5 signs as well as with unsigned segments.

The rules from RFC5925 are:
(1) Any TCP segment can have at max only one signature.
(2) TCP connections can't switch between using TCP-MD5 and TCP-AO.
(3) TCP-AO connections can't stop using AO, as well as unsigned
    connections can't suddenly start using AO.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/dropreason-core.h |  17 ++++
 include/net/tcp.h             |  53 ++++++++++++-
 include/net/tcp_ao.h          |  14 ++++
 net/ipv4/tcp.c                |  39 ++--------
 net/ipv4/tcp_ao.c             | 142 ++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_ipv4.c           |  10 +--
 net/ipv6/tcp_ao.c             |   9 ++-
 net/ipv6/tcp_ipv6.c           |  11 +--
 8 files changed, 248 insertions(+), 47 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 216cde184db1..a01e1860fe25 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -24,6 +24,10 @@
 	FN(TCP_MD5NOTFOUND)		\
 	FN(TCP_MD5UNEXPECTED)		\
 	FN(TCP_MD5FAILURE)		\
+	FN(TCP_AONOTFOUND)		\
+	FN(TCP_AOUNEXPECTED)		\
+	FN(TCP_AOKEYNOTFOUND)		\
+	FN(TCP_AOFAILURE)		\
 	FN(SOCKET_BACKLOG)		\
 	FN(TCP_FLAGS)			\
 	FN(TCP_ZEROWINDOW)		\
@@ -162,6 +166,19 @@ enum skb_drop_reason {
 	 * to LINUX_MIB_TCPMD5FAILURE
 	 */
 	SKB_DROP_REASON_TCP_MD5FAILURE,
+	/**
+	 * @SKB_DROP_REASON_TCP_AONOTFOUND: no TCP-AO hash and one was expected
+	 */
+	SKB_DROP_REASON_TCP_AONOTFOUND,
+	/**
+	 * @SKB_DROP_REASON_TCP_AOUNEXPECTED: TCP-AO hash is present and it
+	 * was not expected.
+	 */
+	SKB_DROP_REASON_TCP_AOUNEXPECTED,
+	/** @SKB_DROP_REASON_TCP_AOKEYNOTFOUND: TCP-AO key is unknown */
+	SKB_DROP_REASON_TCP_AOKEYNOTFOUND,
+	/** @SKB_DROP_REASON_TCP_AOFAILURE: TCP-AO hash is wrong */
+	SKB_DROP_REASON_TCP_AOFAILURE,
 	/**
 	 * @SKB_DROP_REASON_SOCKET_BACKLOG: failed to add skb to socket backlog (
 	 * see LINUX_MIB_TCPBACKLOGDROP)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 717887c3d76d..c5c7893c77cc 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1775,7 +1775,7 @@ tcp_md5_do_lookup_any_l3index(const struct sock *sk,
 enum skb_drop_reason
 tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 		     const void *saddr, const void *daddr,
-		     int family, int dif, int sdif);
+		     int family, int l3index, const __u8 *hash_location);
 
 
 #define tcp_twsk_md5_key(twsk)	((twsk)->tw_md5_key)
@@ -1797,7 +1797,7 @@ tcp_md5_do_lookup_any_l3index(const struct sock *sk,
 static inline enum skb_drop_reason
 tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 		     const void *saddr, const void *daddr,
-		     int family, int dif, int sdif)
+		     int family, int l3index, const __u8 *hash_location)
 {
 	return SKB_NOT_DROPPED_YET;
 }
@@ -2692,4 +2692,53 @@ static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
 	return false;
 }
 
+/* Called with rcu_read_lock() */
+static inline enum skb_drop_reason
+tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
+		 const struct sk_buff *skb,
+		 const void *saddr, const void *daddr,
+		 int family, int dif, int sdif)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	const struct tcp_ao_hdr *aoh;
+	const __u8 *md5_location;
+	int l3index;
+
+	/* Invalid option or two times meet any of auth options */
+	if (tcp_parse_auth_options(th, &md5_location, &aoh))
+		return SKB_DROP_REASON_TCP_AUTH_HDR;
+
+	if (req) {
+		if (tcp_rsk_used_ao(req) != !!aoh)
+			return SKB_DROP_REASON_TCP_AOFAILURE;
+	}
+
+	/* sdif set, means packet ingressed via a device
+	 * in an L3 domain and dif is set to the l3mdev
+	 */
+	l3index = sdif ? dif : 0;
+
+	/* Fast path: unsigned segments */
+	if (likely(!md5_location && !aoh)) {
+		/* Drop if there's TCP-MD5 or TCP-AO key with any rcvid/sndid
+		 * for the remote peer. On TCP-AO established connection
+		 * the last key is impossible to remove, so there's
+		 * always at least one current_key.
+		 */
+		if (tcp_ao_required(sk, saddr, family))
+			return SKB_DROP_REASON_TCP_AONOTFOUND;
+		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
+			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
+		}
+		return SKB_NOT_DROPPED_YET;
+	}
+
+	if (aoh)
+		return tcp_inbound_ao_hash(sk, skb, family, req, aoh);
+
+	return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
+				    l3index, md5_location);
+}
+
 #endif	/* _TCP_H */
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 56c2e34ad7d2..6e62235c7cae 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -111,6 +111,9 @@ struct tcp6_ao_context {
 };
 
 struct tcp_sigpool;
+#define TCP_AO_ESTABLISHED (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | \
+			    TCPF_CLOSE | TCPF_CLOSE_WAIT | \
+			    TCPF_LAST_ACK | TCPF_CLOSING)
 
 int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 			struct tcp_ao_key *key, struct tcphdr *th,
@@ -130,6 +133,10 @@ int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 			    unsigned int len, struct tcp_sigpool *hp);
 void tcp_ao_destroy_sock(struct sock *sk, bool twsk);
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp);
+enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
+			const struct sk_buff *skb, unsigned short int family,
+			const struct request_sock *req,
+			const struct tcp_ao_hdr *aoh);
 struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 				    const union tcp_ao_addr *addr,
 				    int family, int sndid, int rcvid);
@@ -208,6 +215,13 @@ static inline void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 {
 }
 
+static inline enum skb_drop_reason tcp_inbound_ao_hash(struct sock *sk,
+		const struct sk_buff *skb, unsigned short int family,
+		const struct request_sock *req, const struct tcp_ao_hdr *aoh)
+{
+	return SKB_NOT_DROPPED_YET;
+}
+
 static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
 		const union tcp_ao_addr *addr, int family, int sndid, int rcvid)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f8e6c11e5132..0f801850481f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4363,42 +4363,23 @@ EXPORT_SYMBOL(tcp_md5_hash_key);
 enum skb_drop_reason
 tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 		     const void *saddr, const void *daddr,
-		     int family, int dif, int sdif)
+		     int family, int l3index, const __u8 *hash_location)
 {
-	/*
-	 * This gets called for each TCP segment that arrives
-	 * so we want to be efficient.
+	/* This gets called for each TCP segment that has TCP-MD5 option.
 	 * We have 3 drop cases:
 	 * o No MD5 hash and one expected.
 	 * o MD5 hash and we're not expecting one.
 	 * o MD5 hash and its wrong.
 	 */
-	const __u8 *hash_location = NULL;
-	struct tcp_md5sig_key *hash_expected;
 	const struct tcphdr *th = tcp_hdr(skb);
 	const struct tcp_sock *tp = tcp_sk(sk);
-	int genhash, l3index;
+	struct tcp_md5sig_key *key;
 	u8 newhash[16];
+	int genhash;
 
-	/* sdif set, means packet ingressed via a device
-	 * in an L3 domain and dif is set to the l3mdev
-	 */
-	l3index = sdif ? dif : 0;
+	key = tcp_md5_do_lookup(sk, l3index, saddr, family);
 
-	hash_expected = tcp_md5_do_lookup(sk, l3index, saddr, family);
-	if (tcp_parse_auth_options(th, &hash_location, NULL))
-		return SKB_DROP_REASON_TCP_AUTH_HDR;
-
-	/* We've parsed the options - do we have a hash? */
-	if (!hash_expected && !hash_location)
-		return SKB_NOT_DROPPED_YET;
-
-	if (hash_expected && !hash_location) {
-		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
-		return SKB_DROP_REASON_TCP_MD5NOTFOUND;
-	}
-
-	if (!hash_expected && hash_location) {
+	if (!key && hash_location) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5UNEXPECTED);
 		return SKB_DROP_REASON_TCP_MD5UNEXPECTED;
 	}
@@ -4408,14 +4389,10 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 	 * IPv4-mapped case.
 	 */
 	if (family == AF_INET)
-		genhash = tcp_v4_md5_hash_skb(newhash,
-					      hash_expected,
-					      NULL, skb);
+		genhash = tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
 	else
-		genhash = tp->af_specific->calc_md5_hash(newhash,
-							 hash_expected,
+		genhash = tp->af_specific->calc_md5_hash(newhash, key,
 							 NULL, skb);
-
 	if (genhash || memcmp(hash_location, newhash, 16) != 0) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5FAILURE);
 		if (family == AF_INET) {
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 0102d0662fca..4813b9283c55 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -761,6 +761,148 @@ void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 	treq->maclen = tcp_ao_maclen(key);
 }
 
+static enum skb_drop_reason
+tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
+		   unsigned short int family, struct tcp_ao_info *info,
+		   const struct tcp_ao_hdr *aoh, struct tcp_ao_key *key,
+		   u8 *traffic_key, u8 *phash, u32 sne)
+{
+	u8 maclen = aoh->length - sizeof(struct tcp_ao_hdr);
+	const struct tcphdr *th = tcp_hdr(skb);
+	void *hash_buf = NULL;
+
+	if (maclen != tcp_ao_maclen(key))
+		return SKB_DROP_REASON_TCP_AOFAILURE;
+
+	hash_buf = kmalloc(tcp_ao_digest_size(key), GFP_ATOMIC);
+	if (!hash_buf)
+		return SKB_DROP_REASON_NOT_SPECIFIED;
+
+	/* XXX: make it per-AF callback? */
+	tcp_ao_hash_skb(family, hash_buf, key, sk, skb, traffic_key,
+			(phash - (u8 *)th), sne);
+	if (memcmp(phash, hash_buf, maclen)) {
+		kfree(hash_buf);
+		return SKB_DROP_REASON_TCP_AOFAILURE;
+	}
+	kfree(hash_buf);
+	return SKB_NOT_DROPPED_YET;
+}
+
+enum skb_drop_reason
+tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
+		    unsigned short int family, const struct request_sock *req,
+		    const struct tcp_ao_hdr *aoh)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	u8 *phash = (u8 *)(aoh + 1); /* hash goes just after the header */
+	struct tcp_ao_info *info;
+	enum skb_drop_reason ret;
+	struct tcp_ao_key *key;
+	__be32 sisn, disn;
+	u8 *traffic_key;
+	u32 sne = 0;
+
+	info = rcu_dereference(tcp_sk(sk)->ao_info);
+	if (!info)
+		return SKB_DROP_REASON_TCP_AOUNEXPECTED;
+
+	if (unlikely(th->syn)) {
+		sisn = th->seq;
+		disn = 0;
+	}
+
+	/* Fast-path */
+	if (likely((1 << sk->sk_state) & TCP_AO_ESTABLISHED)) {
+		enum skb_drop_reason err;
+		struct tcp_ao_key *current_key;
+
+		/* Check if this socket's rnext_key matches the keyid in the
+		 * packet. If not we lookup the key based on the keyid
+		 * matching the rcvid in the mkt.
+		 */
+		key = READ_ONCE(info->rnext_key);
+		if (key->rcvid != aoh->keyid) {
+			key = tcp_ao_established_key(info, -1, aoh->keyid);
+			if (!key)
+				goto key_not_found;
+		}
+
+		/* Delayed retransmitted SYN */
+		if (unlikely(th->syn && !th->ack))
+			goto verify_hash;
+
+		sne = 0;
+		/* Established socket, traffic key are cached */
+		traffic_key = rcv_other_key(key);
+		err = tcp_ao_verify_hash(sk, skb, family, info, aoh, key,
+					 traffic_key, phash, sne);
+		if (err)
+			return err;
+		current_key = READ_ONCE(info->current_key);
+		/* Key rotation: the peer asks us to use new key (RNext) */
+		if (unlikely(aoh->rnext_keyid != current_key->sndid)) {
+			/* If the key is not found we do nothing. */
+			key = tcp_ao_established_key(info, aoh->rnext_keyid, -1);
+			if (key)
+				/* pairs with tcp_ao_del_cmd */
+				WRITE_ONCE(info->current_key, key);
+		}
+		return SKB_NOT_DROPPED_YET;
+	}
+
+	/* Lookup key based on peer address and keyid.
+	 * current_key and rnext_key must not be used on tcp listen
+	 * sockets as otherwise:
+	 * - request sockets would race on those key pointers
+	 * - tcp_ao_del_cmd() allows async key removal
+	 */
+	key = tcp_ao_inbound_lookup(family, sk, skb, -1, aoh->keyid);
+	if (!key)
+		goto key_not_found;
+
+	if (th->syn && !th->ack)
+		goto verify_hash;
+
+	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
+		/* Make the initial syn the likely case here */
+		if (unlikely(req)) {
+			sne = 0;
+			sisn = htonl(tcp_rsk(req)->rcv_isn);
+			disn = htonl(tcp_rsk(req)->snt_isn);
+		} else if (unlikely(th->ack && !th->syn)) {
+			/* Possible syncookie packet */
+			sisn = htonl(ntohl(th->seq) - 1);
+			disn = htonl(ntohl(th->ack_seq) - 1);
+			sne = 0;
+		} else if (unlikely(!th->syn)) {
+			/* no way to figure out initial sisn/disn - drop */
+			return SKB_DROP_REASON_TCP_FLAGS;
+		}
+	} else if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
+		disn = info->lisn;
+		if (th->syn || th->rst)
+			sisn = th->seq;
+		else
+			sisn = info->risn;
+	} else {
+		WARN_ONCE(1, "TCP-AO: Unexpected sk_state %d", sk->sk_state);
+		return SKB_DROP_REASON_TCP_AOFAILURE;
+	}
+verify_hash:
+	traffic_key = kmalloc(tcp_ao_digest_size(key), GFP_ATOMIC);
+	if (!traffic_key)
+		return SKB_DROP_REASON_NOT_SPECIFIED;
+	tcp_ao_calc_key_skb(key, traffic_key, skb, sisn, disn, family);
+	ret = tcp_ao_verify_hash(sk, skb, family, info, aoh, key,
+				 traffic_key, phash, sne);
+	kfree(traffic_key);
+	return ret;
+
+key_not_found:
+	return SKB_DROP_REASON_TCP_AOKEYNOTFOUND;
+}
+
 static int tcp_ao_cache_traffic_keys(const struct sock *sk,
 				     struct tcp_ao_info *ao,
 				     struct tcp_ao_key *ao_key)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b4d26d893f9d..1b1ad6da5929 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2202,9 +2202,9 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb))
 			drop_reason = SKB_DROP_REASON_XFRM_POLICY;
 		else
-			drop_reason = tcp_inbound_md5_hash(sk, skb,
-						   &iph->saddr, &iph->daddr,
-						   AF_INET, dif, sdif);
+			drop_reason = tcp_inbound_hash(sk, req, skb,
+						       &iph->saddr, &iph->daddr,
+						       AF_INET, dif, sdif);
 		if (unlikely(drop_reason)) {
 			sk_drops_add(sk, skb);
 			reqsk_put(req);
@@ -2281,8 +2281,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		goto discard_and_relse;
 	}
 
-	drop_reason = tcp_inbound_md5_hash(sk, skb, &iph->saddr,
-					   &iph->daddr, AF_INET, dif, sdif);
+	drop_reason = tcp_inbound_hash(sk, NULL, skb, &iph->saddr, &iph->daddr,
+				       AF_INET, dif, sdif);
 	if (drop_reason)
 		goto discard_and_relse;
 
diff --git a/net/ipv6/tcp_ao.c b/net/ipv6/tcp_ao.c
index 99753e12c08c..8b04611c9078 100644
--- a/net/ipv6/tcp_ao.c
+++ b/net/ipv6/tcp_ao.c
@@ -53,11 +53,12 @@ int tcp_v6_ao_calc_key_skb(struct tcp_ao_key *mkt, u8 *key,
 			   const struct sk_buff *skb,
 			   __be32 sisn, __be32 disn)
 {
-       const struct ipv6hdr *iph = ipv6_hdr(skb);
-       const struct tcphdr *th = tcp_hdr(skb);
+	const struct ipv6hdr *iph = ipv6_hdr(skb);
+	const struct tcphdr *th = tcp_hdr(skb);
 
-       return tcp_v6_ao_calc_key(mkt, key, &iph->saddr, &iph->daddr,
-				 th->source, th->dest, sisn, disn);
+	return tcp_v6_ao_calc_key(mkt, key, &iph->saddr,
+				  &iph->daddr, th->source,
+				  th->dest, sisn, disn);
 }
 
 int tcp_v6_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 05d9ded5a413..aefe0825532e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1782,9 +1782,9 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		if (!xfrm6_policy_check(sk, XFRM_POLICY_IN, skb))
 			drop_reason = SKB_DROP_REASON_XFRM_POLICY;
 		else
-			drop_reason = tcp_inbound_md5_hash(sk, skb,
-							   &hdr->saddr, &hdr->daddr,
-							   AF_INET6, dif, sdif);
+			drop_reason = tcp_inbound_hash(sk, req, skb,
+						       &hdr->saddr, &hdr->daddr,
+						       AF_INET6, dif, sdif);
 		if (drop_reason) {
 			sk_drops_add(sk, skb);
 			reqsk_put(req);
@@ -1858,8 +1858,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		goto discard_and_relse;
 	}
 
-	drop_reason = tcp_inbound_md5_hash(sk, skb, &hdr->saddr, &hdr->daddr,
-					   AF_INET6, dif, sdif);
+	drop_reason = tcp_inbound_hash(sk, NULL, skb, &hdr->saddr, &hdr->daddr,
+				       AF_INET6, dif, sdif);
 	if (drop_reason)
 		goto discard_and_relse;
 
@@ -2087,6 +2087,7 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific = {
 	.ao_lookup	=	tcp_v6_ao_lookup,
 	.calc_ao_hash	=	tcp_v4_ao_hash_skb,
 	.ao_parse	=	tcp_v6_parse_ao,
+	.ao_calc_key_sk	=	tcp_v4_ao_calc_key_sk,
 #endif
 };
 #endif
-- 
2.42.0

