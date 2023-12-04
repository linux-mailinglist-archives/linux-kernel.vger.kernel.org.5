Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B452F803E2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345317AbjLDTBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjLDTBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:01:05 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13633111
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:01:04 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9e1021dbd28so663958166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701716462; x=1702321262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mT3D/Z66Vs1yufZpC/lcvNBlunBHyn7u3P08XO8P98=;
        b=EmOPx5fUQS4vptuJKQv8y9P5AmrPe3uprHbrugnbt5tCSmJcIZD8HNcKdlkso0hDK3
         cR0tBMELizu0ZftuhBi2CwFFTIjRwMUY0WmbncBO7q6EkZRwqi7y7nsTi1yL+XGsnHoL
         gMrMcHcz3EoA1bdmHJlbT1IlXOQ0jqWwgMmB0uZh+E/botNKA42N7/4Xvcrq+KEK0v+T
         8jP3PPU/M1UdR0WMnm64STXF6YV6YCq4hqQPnY9kHw0UgyHV7ZqGpkmETyFKx4866QAm
         cIDgnBSl9gyORzFd31TszUZFwkyo/KPWCNdSUjqZKOQVaUMANtJPnv9yPUc6CDS7u+CB
         sMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716462; x=1702321262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mT3D/Z66Vs1yufZpC/lcvNBlunBHyn7u3P08XO8P98=;
        b=BBdJBvGrdwKreHf0KfMPIgQGF9GgJowFOyHVbHmTQHRS0/Aw0rhSgJHR92c9D/2JqJ
         3EJMUwfWh8yThN5IzpLnt9h+k7fzD4LDOyD/TUmh034trK7vnQYXnYRxZQ0VMTqsZ2h7
         gGig2Wpnofx7rcneSm8Sm0oIQYuGCksagwbaUM4D1IPqTDOMVkC5+0dzdX/arcjxOFU5
         9jTI9J+Ex6+vdUjaJahsGgNNTn2wowVO+UJ9d2AtmOfpayghf1Bbo6HXQgdXJb57PFgv
         ARAcCkq4b6WgxDfNT2aJvgloRc+3ZmoyeWJ8ANC6kugqJz9Dv+tuIaCSQWJCYoZW1tma
         r9ow==
X-Gm-Message-State: AOJu0YwzpRKLTA/+qjihi3OIVQcY4oHlpGJBDWdCMZIbXT4eg/BS1a90
        LMHCOeywpPksUE8fpBQlNYJn4A==
X-Google-Smtp-Source: AGHT+IHzDnqU6wmCDoMJN/sPJhXVQgMW2J767VgFxk/VZIoIU67UKrP6sZu8a6h2FPdtEQTZ9jClUg==
X-Received: by 2002:a17:906:6c91:b0:a0f:44c6:8eb5 with SMTP id s17-20020a1709066c9100b00a0f44c68eb5mr2889368ejr.22.1701716462629;
        Mon, 04 Dec 2023 11:01:02 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id dx9-20020a170906a84900b009fbc655335dsm5577614ejb.27.2023.12.04.11.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:01:01 -0800 (PST)
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
Subject: [PATCH v5 5/5] net/tcp: Don't store TCP-AO maclen on reqsk
Date:   Mon,  4 Dec 2023 19:00:44 +0000
Message-ID: <20231204190044.450107-6-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204190044.450107-1-dima@arista.com>
References: <20231204190044.450107-1-dima@arista.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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
index 18dacfef7a07..f8308d3f565e 100644
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
index bcb55d98004c..337c8bb07ccc 100644
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
2.43.0

