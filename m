Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390A6803E6B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjLDTd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjLDTdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:33:25 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E33C1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:33:32 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67ad891ff36so2710406d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701718411; x=1702323211; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ypze9oh3HMRwpIkYiVL5giOKcJP1gJiTxNjbvg3EfEk=;
        b=Fat7gM8PqNI4PGUx3XM+fYGZOtkOAzT6OSIv1Q0SuAC+nDy/AMx8EK+q+hfT8XJd0H
         yPl3LHg6kIenoXF5gGiLxBcThMlaEjQwjC1Edg2tsvNIBeHnqveCd8VLd2bp4CumF3P9
         dxc50ACsld3BTNaGWMbeRb9zt5wIIuJTQHplD2KbZVbf6uRUJiwbs59bqi4WED3y8bkY
         j/+qGtbLHoOGoCa3GK8YQBhR2lmrPqk9uf/kYJ83H16I7Qq4aRgr33Y3A7EdcsGhFPnx
         F5apbFB2/u0vF/TMyTbag2IO3NhQ6/3ozV85loD4IByOgHVmVM4F+4vKf6pHN+oh2gum
         wS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701718411; x=1702323211;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ypze9oh3HMRwpIkYiVL5giOKcJP1gJiTxNjbvg3EfEk=;
        b=JAVJp9XD4AFuJf9yExNaN6XHszsoorPkbtljgtbKn3zAdVK2dCi0ymnawo+T7LErJV
         i2CU5V6LXf9g1ABbRRQG1MONte9Yj06+N6E1jAu/U5Fosb6fuDrVUwdXSsI54IVBI6Kb
         G8r77guJRWg1MTttY62pxVXqGSMafULWMcMT0nmLvroEJKIZELhQ3DFdLpIMtICtMfKC
         YrcYXJRdtk7FhS0V+XPs2ysWHrRAbhoyGeiA+6MMsM6oNulsLmtmUN2oUvYdbxlkEFlT
         UAMYTUm6V07W4Uk2SCCoq3MXP/XumG8QR/eZJLNZ6uV+hE7egeF+s4E7RRKspsMCEb8s
         FunA==
X-Gm-Message-State: AOJu0YxBGYLdnk5r9lNHXuwee0aQaTlyBEoX605Os2wcMDaoxKQrpKQA
        t9UON07m1rB+Z3/kMi0zd+Ihzw==
X-Google-Smtp-Source: AGHT+IG9Yy5ZYzCwVfgdZvPfLEymUdVE6FwPmAuV1RznBAxIv8oj68oFaS9vR+9w5b5pi/yyFI7lag==
X-Received: by 2002:a0c:ea24:0:b0:67a:a721:d78c with SMTP id t4-20020a0cea24000000b0067aa721d78cmr76089qvp.114.1701718411197;
        Mon, 04 Dec 2023 11:33:31 -0800 (PST)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id mh10-20020a056214564a00b0067a9235d5f0sm3884654qvb.105.2023.12.04.11.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:33:30 -0800 (PST)
Date:   Mon, 4 Dec 2023 11:33:28 -0800
From:   Yan Zhai <yan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Jesper Brouer <jesper@cloudflare.com>
Subject: [PATCH v4 net-next] packet: add a generic drop reason for receive
Message-ID: <ZW4piNbx3IenYnuw@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
from consume_skb to kfree_skb to improve error handling. However, this
could bring a lot of noises when we monitor real packet drops in
kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
can be freed, not actual packets.

Adding a generic drop reason to allow distinguish these "clone drops".

[1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com/
Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
Suggested-by: Eric Dumazet <edumazet@google.com>
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v3->v4: code style amend suggested by Willem de Bruijn
v2->v3: removed an unused variable
v1->v2: fixups suggested by Eric Dumazet
v3: https://lore.kernel.org/lkml/ZWomqO8m4vVcW+ro@debian.debian/
v2: https://lore.kernel.org/netdev/ZWobMUp22oTpP3FW@debian.debian/
v1: https://lore.kernel.org/netdev/ZU3EZKQ3dyLE6T8z@debian.debian/

---
 include/net/dropreason-core.h |  6 ++++++
 net/packet/af_packet.c        | 20 +++++++-------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 3c70ad53a49c..278e4c7d465c 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -86,6 +86,7 @@
 	FN(IPV6_NDISC_NS_OTHERHOST)	\
 	FN(QUEUE_PURGE)			\
 	FN(TC_ERROR)			\
+	FN(PACKET_SOCK_ERROR)		\
 	FNe(MAX)
 
 /**
@@ -378,6 +379,11 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_QUEUE_PURGE,
 	/** @SKB_DROP_REASON_TC_ERROR: generic internal tc error. */
 	SKB_DROP_REASON_TC_ERROR,
+	/**
+	 * @SKB_DROP_REASON_PACKET_SOCK_ERROR: generic packet socket errors
+	 * after its filter matches an incoming packet.
+	 */
+	SKB_DROP_REASON_PACKET_SOCK_ERROR,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a84e00b5904b..f92edba4c40f 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2121,13 +2121,13 @@ static int packet_rcv_vnet(struct msghdr *msg, const struct sk_buff *skb,
 static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		      struct packet_type *pt, struct net_device *orig_dev)
 {
+	enum skb_drop_reason drop_reason = SKB_CONSUMED;
 	struct sock *sk;
 	struct sockaddr_ll *sll;
 	struct packet_sock *po;
 	u8 *skb_head = skb->data;
 	int skb_len = skb->len;
 	unsigned int snaplen, res;
-	bool is_drop_n_account = false;
 
 	if (skb->pkt_type == PACKET_LOOPBACK)
 		goto drop;
@@ -2217,9 +2217,9 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 	return 0;
 
 drop_n_acct:
-	is_drop_n_account = true;
 	atomic_inc(&po->tp_drops);
 	atomic_inc(&sk->sk_drops);
+	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
 
 drop_n_restore:
 	if (skb_head != skb->data && skb_shared(skb)) {
@@ -2227,16 +2227,14 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	if (!is_drop_n_account)
-		consume_skb(skb);
-	else
-		kfree_skb(skb);
+	kfree_skb_reason(skb, drop_reason);
 	return 0;
 }
 
 static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		       struct packet_type *pt, struct net_device *orig_dev)
 {
+	enum skb_drop_reason drop_reason = SKB_CONSUMED;
 	struct sock *sk;
 	struct packet_sock *po;
 	struct sockaddr_ll *sll;
@@ -2250,7 +2248,6 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct sk_buff *copy_skb = NULL;
 	struct timespec64 ts;
 	__u32 ts_status;
-	bool is_drop_n_account = false;
 	unsigned int slot_id = 0;
 	int vnet_hdr_sz = 0;
 
@@ -2498,19 +2495,16 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		skb->len = skb_len;
 	}
 drop:
-	if (!is_drop_n_account)
-		consume_skb(skb);
-	else
-		kfree_skb(skb);
+	kfree_skb_reason(skb, drop_reason);
 	return 0;
 
 drop_n_account:
 	spin_unlock(&sk->sk_receive_queue.lock);
 	atomic_inc(&po->tp_drops);
-	is_drop_n_account = true;
+	drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
 
 	sk->sk_data_ready(sk);
-	kfree_skb(copy_skb);
+	kfree_skb_reason(copy_skb, drop_reason);
 	goto drop_n_restore;
 }
 
-- 
2.30.2

