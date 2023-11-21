Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFAF7F2376
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjKUCBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjKUCBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:01:35 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A42F5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40839652b97so19540615e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700532088; x=1701136888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBOOKbt8qYeu3I6qmruIZOshMMipjUc2q0LuWEyo1Tk=;
        b=X10eg7GW7jMUjWFbHr1w/Od1YyGMrWLempQxTyyVmH/D2qS1vlbLo/wlLSopElquH3
         JHz5kQgRW/g4HyaOSEvCQ834osJnFAtAI3fcPGr6eJny9qWw6MnMtQeRrSwh0zuZ9sXD
         J5V6KlWq7+teyUnq/3xWbEvzlJ3ll7WSF+2gN8BT9KRsyevhC7HUulUV0EoL/81epit5
         p1RZ/yDxc1qV0zn3auvnjY6FVB2jdP6LenrvnRy7I0/LXD/4+aleNUBb2V4xGh2Wka/p
         jgrh9fiBM4OU/gGPjjaMHtZNhGUiyCUmJ3I/i7V20LR3z9B2SbUimxKJTPSF0nbI6U+A
         T0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532088; x=1701136888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBOOKbt8qYeu3I6qmruIZOshMMipjUc2q0LuWEyo1Tk=;
        b=Z97BtRuLu3P0VvBV3ZpmfSVDT/DTrVA6HWE1JYewr32vWfKdJRlu2w1R8bqsxCnYLD
         gcCG/VVrJkxJrDluj2Dbi3Zi3X7SZRqjc3okO4Ms/+mLNfy75Jw0WDajUrYRTYrcoYzm
         VncL3bTqJDvCtfwqR9oiq3VrggVVq7eIpEbc5cDQBdDdHMVEsEn3dYglZXLZknw+/Oqo
         K82jhz9WZlYL7f9r+JntBm0b7on+i/zKsV/XeVFO9ZiH1JoZKN+u1EfxHNB1u9ddMIo1
         1ZCzpUNYyIZH8kpprXHXhUQXZgsoEbUUlUVULYcvXmXU8IW62ElhtRP3REfmnaVMrHdM
         hyOA==
X-Gm-Message-State: AOJu0YwRSNRXC/wVUkaksp+HsZhs7nqdl3ls+GeEHnBSAi+UJ0pNmouP
        w8/32sSnZErVx4Pfy5LBJ1TVYQ==
X-Google-Smtp-Source: AGHT+IFUb2kPEOqjsQe+RX4pd7eVkewEsSHkT4T1xu2TuDc1YK1Zv+TSvo0MSIAJJf9Mv3tFSbbACw==
X-Received: by 2002:adf:e58b:0:b0:32d:b051:9a27 with SMTP id l11-20020adfe58b000000b0032db0519a27mr6193939wrm.20.1700532088379;
        Mon, 20 Nov 2023 18:01:28 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000184d00b00332cb846f21sm2617105wri.27.2023.11.20.18.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:01:27 -0800 (PST)
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
Subject: [PATCH 7/7] net/tcp: Don't store TCP-AO maclen on reqsk
Date:   Tue, 21 Nov 2023 02:01:11 +0000
Message-ID: <20231121020111.1143180-8-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121020111.1143180-1-dima@arista.com>
References: <20231121020111.1143180-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This extra check doesn't work for a handshake when SYN segment has
(current_key.maclen != rnext_key.maclen). It could be amended to
preserve rnext_key.maclen instead of current_key.maclen, but that
requires a lookup on listen socket.

Originally, this extra maclen check was introduced just because it was
cheap. Drop it and convert tcp_request_sock::maclen into boolean
tcp_request_sock::used_tcp_ao.

Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/tcp.h   | 10 ++++------
 net/ipv4/tcp_ao.c     |  4 ++--
 net/ipv4/tcp_input.c  |  5 +++--
 net/ipv4/tcp_output.c |  9 +++------
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 68f3d315d2e1..3af897b00920 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -155,6 +155,9 @@ struct tcp_request_sock {
 	bool				req_usec_ts;
 #if IS_ENABLED(CONFIG_MPTCP)
 	bool				drop_req;
+#endif
+#ifdef CONFIG_TCP_AO
+	bool				used_tcp_ao;
 #endif
 	u32				txhash;
 	u32				rcv_isn;
@@ -169,7 +172,6 @@ struct tcp_request_sock {
 #ifdef CONFIG_TCP_AO
 	u8				ao_keyid;
 	u8				ao_rcv_next;
-	u8				maclen;
 #endif
 };
 
@@ -180,14 +182,10 @@ static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *req)
 
 static inline bool tcp_rsk_used_ao(const struct request_sock *req)
 {
-	/* The real length of MAC is saved in the request socket,
-	 * signing anything with zero-length makes no sense, so here is
-	 * a little hack..
-	 */
 #ifndef CONFIG_TCP_AO
 	return false;
 #else
-	return tcp_rsk(req)->maclen != 0;
+	return tcp_rsk(req)->used_tcp_ao;
 #endif
 }
 
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 9b7f1970c2e9..07221319e8c5 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -851,7 +851,7 @@ void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 	const struct tcp_ao_hdr *aoh;
 	struct tcp_ao_key *key;
 
-	treq->maclen = 0;
+	treq->used_tcp_ao = false;
 
 	if (tcp_parse_auth_options(th, NULL, &aoh) || !aoh)
 		return;
@@ -863,7 +863,7 @@ void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 
 	treq->ao_rcv_next = aoh->keyid;
 	treq->ao_keyid = aoh->rnext_keyid;
-	treq->maclen = tcp_ao_maclen(key);
+	treq->used_tcp_ao = true;
 }
 
 static enum skb_drop_reason
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 78896c8be0d4..89cb6912dd91 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7182,11 +7182,12 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
 		goto drop_and_release; /* Invalid TCP options */
 	if (aoh) {
-		tcp_rsk(req)->maclen = aoh->length - sizeof(struct tcp_ao_hdr);
+		tcp_rsk(req)->used_tcp_ao = true;
 		tcp_rsk(req)->ao_rcv_next = aoh->keyid;
 		tcp_rsk(req)->ao_keyid = aoh->rnext_keyid;
+
 	} else {
-		tcp_rsk(req)->maclen = 0;
+		tcp_rsk(req)->used_tcp_ao = false;
 	}
 #endif
 	tcp_rsk(req)->snt_isn = isn;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 93eef1dbbc55..f5ef15e1d9ac 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3720,7 +3720,6 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	if (tcp_rsk_used_ao(req)) {
 #ifdef CONFIG_TCP_AO
 		struct tcp_ao_key *ao_key = NULL;
-		u8 maclen = tcp_rsk(req)->maclen;
 		u8 keyid = tcp_rsk(req)->ao_keyid;
 
 		ao_key = tcp_sk(sk)->af_specific->ao_lookup(sk, req_to_sk(req),
@@ -3730,13 +3729,11 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 		 * for another peer-matching key, but the peer has requested
 		 * ao_keyid (RFC5925 RNextKeyID), so let's keep it simple here.
 		 */
-		if (unlikely(!ao_key || tcp_ao_maclen(ao_key) != maclen)) {
-			u8 key_maclen = ao_key ? tcp_ao_maclen(ao_key) : 0;
-
+		if (unlikely(!ao_key)) {
 			rcu_read_unlock();
 			kfree_skb(skb);
-			net_warn_ratelimited("TCP-AO: the keyid %u with maclen %u|%u from SYN packet is not present - not sending SYNACK\n",
-					     keyid, maclen, key_maclen);
+			net_warn_ratelimited("TCP-AO: the keyid %u from SYN packet is not present - not sending SYNACK\n",
+					     keyid);
 			return NULL;
 		}
 		key.ao_key = ao_key;
-- 
2.42.0

