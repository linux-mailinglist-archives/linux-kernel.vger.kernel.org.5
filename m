Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59B37FDDC3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjK2Q5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjK2Q5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:57:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D09710A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:57:41 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b34563987so7493325e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701277059; x=1701881859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmBiYbeRYeqEOWnh9NtuJRqQCUW1g+S+1n2KtbA3qWw=;
        b=juLZN//eJC4/L99bKGgH+oz2FiN/OPF3a/iY4L8LvQGOR/ENQGU/lcPdW5yKVKMluA
         Fj1MZdjLhZY95jErYdmBYafCI6DT9utdwSHoaPrMMajdo/z6UQlKffaK+nq6jTf+BOgo
         ErWGYkJe9SGK1XBj7Ref24A4SR0ej/hkOsr3E9FSnyP6iYrdCXDgjoYK0p6NQ/QP+PdX
         OlWbKhWUHPXhkUJwcT+wfDBxlBVL9Yr+oHYJt7tdTF917xqYCcwfRqTYEy9QbYwOwXgF
         Xmbm4JTBhHAtCDWKsMZJkUqOnJomcpt3whwu2lG/+yCRFGir2X8dpBLAgPzp7bUjNm/0
         y6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277059; x=1701881859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmBiYbeRYeqEOWnh9NtuJRqQCUW1g+S+1n2KtbA3qWw=;
        b=fjHJs0SGFfEgnz6JYHY++oPyRk3m2heJ3ZSSFJS5K+021Soj0v1TC59NNbXLKrDwoN
         WIm9EniFMZNjRd8d8+k18YR6gBJD9mbVO6uxzlbCDWYXwr2cTMLQFAtjAGAKkgeDxcsr
         OVMmIOaEwpv8xbZoyaJks4ElnXY0xMSX+6lqlurkZFvKvF0TPxuBQ0GjZBmk3RlzYS6Q
         00WFdVu5pOWU9AqLJ1Z5BHGcGDrcMH1bgxwolvfqhcap/V+JnQTVdXYXB4IW396RRfrV
         MjbYODIbnEa78EuxaUjD5ymCo48vG1F8lww9AWb8N7N9mIalHrXCXTIjWfJAx0FudZqS
         sMxA==
X-Gm-Message-State: AOJu0YxnWdNDCkH+wLCGTkD1AO0xyUFX1rfgabLThXGcu4fqiQnOdoU9
        WUm3pEtEa2Xkvj+8+JERpF0a6g==
X-Google-Smtp-Source: AGHT+IG3m8FsQjSYSIjukTgNd4NpOUwy+N8TV/YPwCpLFnzlNQFr5Ua7TZrb+VA7k+5VV4xMsElbdg==
X-Received: by 2002:a05:600c:3003:b0:407:73fc:6818 with SMTP id j3-20020a05600c300300b0040773fc6818mr19316555wmh.2.1701277059584;
        Wed, 29 Nov 2023 08:57:39 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b003fe1fe56202sm2876823wmo.33.2023.11.29.08.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:57:38 -0800 (PST)
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
Subject: [PATCH v4 7/7] net/tcp: Don't store TCP-AO maclen on reqsk
Date:   Wed, 29 Nov 2023 16:57:21 +0000
Message-ID: <20231129165721.337302-8-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129165721.337302-1-dima@arista.com>
References: <20231129165721.337302-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 25fbb1e0a0ad..dbfea165ff44 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -846,7 +846,7 @@ void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 	const struct tcp_ao_hdr *aoh;
 	struct tcp_ao_key *key;
 
-	treq->maclen = 0;
+	treq->used_tcp_ao = false;
 
 	if (tcp_parse_auth_options(th, NULL, &aoh) || !aoh)
 		return;
@@ -858,7 +858,7 @@ void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 
 	treq->ao_rcv_next = aoh->keyid;
 	treq->ao_keyid = aoh->rnext_keyid;
-	treq->maclen = tcp_ao_maclen(key);
+	treq->used_tcp_ao = true;
 }
 
 static enum skb_drop_reason
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0a58447c33b1..9bcbde89ab5c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7187,11 +7187,12 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
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
index 3ddd057fb6f7..335ab90afe65 100644
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

