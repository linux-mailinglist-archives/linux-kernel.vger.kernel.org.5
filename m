Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED6A7F69D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjKXA1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjKXA1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:27:35 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C0A10E6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:27:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-332e7630a9dso318737f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700785659; x=1701390459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+xjuCITs6Hv9gSdP5tkhTp9hyYcojUzFzOsLW1PoYI=;
        b=K61bA4Dj07U41I/enlM+jFWwgf5GrwH1ZZsyd1msZm96/x39u7ygoXCYPYoJj5HucA
         gti5mIOWAOYwV9JBm9+Z68v7AFTQz/KLi55mw//W35xKY0XMrHWpBWpn23KsFpGlD9QF
         zcuH22VrdQLkwmfE66nKKS/BwJYZjcCdMQ0hxKmpV1IvCPbBzzrs7MeCg870+z0z0kXC
         ygSeO5bjPVSDd5c3whYNUMH0LynueDkPtL6wzUgbKs883uoXYoPMWsfrU6Katf1rzNKa
         MKSRxLUI7lZLXGw0KZVGbOIODNHtZA0V2jVCY+ALaws0JPplOUQ8y0oEzV/jfHorsGF0
         UmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785659; x=1701390459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+xjuCITs6Hv9gSdP5tkhTp9hyYcojUzFzOsLW1PoYI=;
        b=gPH96Qcm6NonBhq4mErKar2H1JHipsWRLZCXSqoQcaZ7CxmkZ25lu4QInrjRGEXdmG
         uu4U88H1+taGg9J64t/X+S9WbUKn9jnUklAxV7h7rnZ3OP5PPztcT/C1B4lgt1m/tbJa
         GhD4HML81bL/u/8cGw8ctcBCah5Z5jAKmB6yxwGBLN7v5AO7uKpZqIi0ZB9m4gAEMIw1
         AyAX1f7ZPQG84AibPfvvIMPrFpFuWtAlCVbY8pU+eIkLeuuYLw81JdjzvD1FIVVhVjQS
         +eF5JByXpDdS8NPY2C93QiIvfJsYHJ7RsRa878V9z/bcI3Xei2ZNkwG8m6acw5YDQie5
         ZC4Q==
X-Gm-Message-State: AOJu0YyVwzBoMj0LnwZFRjoHRnO7LdltNHc4j+vp4qEbWMQawVXCsEz3
        cASkkt06GOpZEI0REL8GGyNpWw==
X-Google-Smtp-Source: AGHT+IHbSUYFXCRpczlpyhRrAyziYifakMY/lsH2oafyE/3Mz23Zj7iFfIe/KGa4ctGfG+6kMqaOkw==
X-Received: by 2002:a5d:63d1:0:b0:332:ca10:37f with SMTP id c17-20020a5d63d1000000b00332ca10037fmr643730wrw.43.1700785659176;
        Thu, 23 Nov 2023 16:27:39 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm3453230wmo.23.2023.11.23.16.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:27:38 -0800 (PST)
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
Subject: [PATCH v2 7/7] net/tcp: Don't store TCP-AO maclen on reqsk
Date:   Fri, 24 Nov 2023 00:27:20 +0000
Message-ID: <20231124002720.102537-8-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124002720.102537-1-dima@arista.com>
References: <20231124002720.102537-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/tcp.h   | 8 ++------
 net/ipv4/tcp_ao.c     | 4 ++--
 net/ipv4/tcp_input.c  | 5 +++--
 net/ipv4/tcp_output.c | 9 +++------
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 68f3d315d2e1..b646b574b060 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -169,7 +169,7 @@ struct tcp_request_sock {
 #ifdef CONFIG_TCP_AO
 	u8				ao_keyid;
 	u8				ao_rcv_next;
-	u8				maclen;
+	bool				used_tcp_ao;
 #endif
 };
 
@@ -180,14 +180,10 @@ static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *req)
 
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
index 74db80aeeef3..cfa264c320a7 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -855,7 +855,7 @@ void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 	const struct tcp_ao_hdr *aoh;
 	struct tcp_ao_key *key;
 
-	treq->maclen = 0;
+	treq->used_tcp_ao = false;
 
 	if (tcp_parse_auth_options(th, NULL, &aoh) || !aoh)
 		return;
@@ -867,7 +867,7 @@ void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 
 	treq->ao_rcv_next = aoh->keyid;
 	treq->ao_keyid = aoh->rnext_keyid;
-	treq->maclen = tcp_ao_maclen(key);
+	treq->used_tcp_ao = true;
 }
 
 static enum skb_drop_reason
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index fc3c27ce2b73..0135a6c6f600 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7194,11 +7194,12 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
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
2.43.0

