Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7CE7F8EA9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 21:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjKYU1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 15:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKYU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 15:27:05 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8667F127;
        Sat, 25 Nov 2023 12:27:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700943997; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=BGfGn3DCDFmOnkDsztjNxOlpWIHIH2sruFlmgC7D8pkdi9qKFpSlaYh+ugi8u8cgDMdWM3KNN0FGXlX57MLnelbQhc9lv40CgfgbssO5FKhZHazb5jeH2W5nmwQXJq/3Vvw4hvPmS0ZWP1lMqfSXfuK8Nk6tTlRuLq/pyN3Lq7c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1700943997; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=khXX+6WIAnh+nbfhSLVUt+KViQdJnf6YZ3f3zq0qJyA=; 
        b=Ncih+qyH3NB0WdbOHkljRWMEgbiratVKpxabNsTYoETjMo2gF0Af6WgPwIjA9LotQ3M59jDhH2O4MyeRZ3N0R4iv2B2sKaR/6l5u5txcAs62zCDmLSQkIJUHEk0m490/JR8F5hyJ1dZuBLePXuwSV4spADb3LrCor1iMvvbSijo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700943997;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=khXX+6WIAnh+nbfhSLVUt+KViQdJnf6YZ3f3zq0qJyA=;
        b=kfic7x93BI2BMMABAGJ7+jpOVjI7JhUXRyUg1ZCPqgR4fqJisHvm9T5DTztDiHIL
        QeImSU3M7tV6efOBTccqiEGas8C+0QsaVNUK/etmQl305JMlar9YSipc8NxwYgtC7MH
        9LVhKie744FkyWWj+DWy22VBX4w01fmJBjjUQ+Sc=
Received: from kampyooter.. (110.226.61.26 [110.226.61.26]) by mx.zoho.in
        with SMTPS id 1700943994641928.1437515996658; Sun, 26 Nov 2023 01:56:34 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] nfc: Extract nfc_dev access from nfc_alloc_send_skb() into the callers
Date:   Sun, 26 Nov 2023 01:56:16 +0530
Message-ID: <ba18da37e48b5c473e5b8bd76d6460017342f968.1700943019.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1700943019.git.code@siddh.me>
References: <cover.1700943019.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only reason why nfc_dev was accessed inside nfc_alloc_send_skb() is
for getting the headroom and tailroom values.

This can cause UAF to be reported from nfc_alloc_send_skb(), but the
callers are responsible for managing the device access, and thus the
UAF being reported, as the callers (like nfc_llcp_send_ui_frame()) may
repeatedly call this function, and this function will repeatedly try
to get the same headroom and tailroom values.

Thus, put the nfc_dev access responsibility on the callers and accept
the headroom and tailroom values directly.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 include/net/nfc/nfc.h   |  6 +++---
 net/nfc/core.c          | 14 +++++++-------
 net/nfc/llcp_commands.c | 20 ++++++++++++++------
 net/nfc/rawsock.c       |  8 ++++++--
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index 5dee575fbe86..efe20a9a8499 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -260,9 +260,9 @@ static inline const char *nfc_device_name(const struct nfc_dev *dev)
 	return dev_name(&dev->dev);
 }
 
-struct sk_buff *nfc_alloc_send_skb(struct nfc_dev *dev, struct sock *sk,
-				   unsigned int flags, unsigned int size,
-				   unsigned int *err);
+struct sk_buff *nfc_alloc_send_skb(struct sock *sk, unsigned int flags,
+				   unsigned int size, int headroom,
+				   int tailroom, unsigned int *err);
 struct sk_buff *nfc_alloc_recv_skb(unsigned int size, gfp_t gfp);
 
 int nfc_set_remote_general_bytes(struct nfc_dev *dev,
diff --git a/net/nfc/core.c b/net/nfc/core.c
index eb2c0959e5b6..1f7d20971f6f 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -705,25 +705,25 @@ EXPORT_SYMBOL(nfc_tm_deactivated);
 /**
  * nfc_alloc_send_skb - allocate a skb for data exchange responses
  *
- * @dev: device sending the response
  * @sk: socket sending the response
  * @flags: MSG_DONTWAIT flag
  * @size: size to allocate
+ * @headroom: Extra headroom, in addition to size
+ * @tailroom: Extra tailroom, in addition to size
  * @err: pointer to memory to store the error code
  */
-struct sk_buff *nfc_alloc_send_skb(struct nfc_dev *dev, struct sock *sk,
-				   unsigned int flags, unsigned int size,
-				   unsigned int *err)
+struct sk_buff *nfc_alloc_send_skb(struct sock *sk, unsigned int flags,
+				   unsigned int size, int headroom,
+				   int tailroom, unsigned int *err)
 {
 	struct sk_buff *skb;
 	unsigned int total_size;
 
-	total_size = size +
-		dev->tx_headroom + dev->tx_tailroom + NFC_HEADER_SIZE;
+	total_size = size + headroom + tailroom + NFC_HEADER_SIZE;
 
 	skb = sock_alloc_send_skb(sk, total_size, flags & MSG_DONTWAIT, err);
 	if (skb)
-		skb_reserve(skb, dev->tx_headroom + NFC_HEADER_SIZE);
+		skb_reserve(skb, headroom + NFC_HEADER_SIZE);
 
 	return skb;
 }
diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index e2680a3bef79..39c7c59bbf66 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -314,13 +314,17 @@ static struct sk_buff *llcp_allocate_pdu(struct nfc_llcp_sock *sock,
 					 u8 cmd, u16 size)
 {
 	struct sk_buff *skb;
-	int err;
+	int err, headroom, tailroom;
 
 	if (sock->ssap == 0)
 		return NULL;
 
-	skb = nfc_alloc_send_skb(sock->dev, &sock->sk, MSG_DONTWAIT,
-				 size + LLCP_HEADER_SIZE, &err);
+	headroom = sock->dev->tx_headroom;
+	tailroom = sock->dev->tx_tailroom;
+
+	skb = nfc_alloc_send_skb(&sock->sk, MSG_DONTWAIT,
+				 size + LLCP_HEADER_SIZE, headroom, tailroom,
+				 &err);
 	if (skb == NULL) {
 		pr_err("Could not allocate PDU\n");
 		return NULL;
@@ -734,7 +738,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 	size_t frag_len = 0, remaining_len;
 	u8 *msg_ptr, *msg_data;
 	u16 remote_miu;
-	int err;
+	int err, headroom, tailroom;
 
 	pr_debug("Send UI frame len %zd\n", len);
 
@@ -751,6 +755,9 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 		return -EFAULT;
 	}
 
+	headroom = sock->dev->tx_headroom;
+	tailroom = sock->dev->tx_tailroom;
+
 	remaining_len = len;
 	msg_ptr = msg_data;
 
@@ -763,8 +770,9 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 		pr_debug("Fragment %zd bytes remaining %zd",
 			 frag_len, remaining_len);
 
-		pdu = nfc_alloc_send_skb(sock->dev, &sock->sk, 0,
-					 frag_len + LLCP_HEADER_SIZE, &err);
+		pdu = nfc_alloc_send_skb(&sock->sk, 0,
+					 frag_len + LLCP_HEADER_SIZE,
+					 headroom, tailroom, &err);
 		if (pdu == NULL) {
 			pr_err("Could not allocate PDU (error=%d)\n", err);
 			len -= remaining_len;
diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
index 5125392bb68e..fab1facb7105 100644
--- a/net/nfc/rawsock.c
+++ b/net/nfc/rawsock.c
@@ -207,7 +207,7 @@ static int rawsock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	struct sock *sk = sock->sk;
 	struct nfc_dev *dev = nfc_rawsock(sk)->dev;
 	struct sk_buff *skb;
-	int rc;
+	int rc, headroom, tailroom;
 
 	pr_debug("sock=%p sk=%p len=%zu\n", sock, sk, len);
 
@@ -217,7 +217,11 @@ static int rawsock_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	if (sock->state != SS_CONNECTED)
 		return -ENOTCONN;
 
-	skb = nfc_alloc_send_skb(dev, sk, msg->msg_flags, len, &rc);
+	headroom = dev->tx_headroom;
+	tailroom = dev->tx_tailroom;
+
+	skb = nfc_alloc_send_skb(sk, msg->msg_flags, len, headroom, tailroom,
+				 &rc);
 	if (skb == NULL)
 		return rc;
 
-- 
2.42.0

