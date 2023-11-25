Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054757F8EA5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 21:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjKYU1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 15:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKYU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 15:27:05 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B582110;
        Sat, 25 Nov 2023 12:27:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700943997; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=CG/6YhYXSiA5o5lvnsjgbz7aLpPRNl4YXm976la8f/2GIZvRCRzdhQb2f4dKW/TT/QNVQaG5auUOiW0MNHU3dIXOfP1xzLahWzQ1BGH6e1E9FL3uJ49uwfJXBNdeLJ3kLLZnfMgDO985BxpQQk6v95aS/gcjB0FniKVyYcaxTWU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1700943997; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=jokTckctzJGZx54kn2OoTfaUts6J5fPPiEFPTgkvFQU=; 
        b=P7LvR7B5qeEGzTC+VoxGb//U+UGwUXPt4R7tYkjO9TwhGl/uQAu87JPGOadm6DIYmqBzd8OG++Tv27oWUrCpVhihB0PbXC/s6qJ4lGOQK3y6lMMKGaMBUaOoM9qoMmWvqkqlMyeS083z02Z3eNVpVR+O1jqSK5+NzhFHoL2OLWg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700943997;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=jokTckctzJGZx54kn2OoTfaUts6J5fPPiEFPTgkvFQU=;
        b=aDWr574rrke4JA3n2T/oeX65rRJaWiCazf5v/whS1uwzqo7U6qyXXk28tmoNPI9Q
        lpTlK02r6wV1f5BkhKTouF+Ae+DLCwPVn4EnNxOMh5plyBRoNAZLKFm59OPQUzOs5/E
        YacV251mdlRVJQx+A/bz0yu8+Q+5Ckxaw0nVbUK4=
Received: from kampyooter.. (110.226.61.26 [110.226.61.26]) by mx.zoho.in
        with SMTPS id 1700943996154743.8918060401706; Sun, 26 Nov 2023 01:56:36 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] nfc: llcp_sock_sendmsg: Reformat code to make the smaller block indented
Date:   Sun, 26 Nov 2023 01:56:19 +0530
Message-ID: <f5e1fc8131923c50d08fa30eb7136f32ddafe37d.1700943019.git.code@siddh.me>
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

The block for datagram sending is a significantly bigger chunk of the
function compared to the other scenario.

Thus, put the significantly smaller block inside the if-block.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 net/nfc/llcp_sock.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 603f2219b62f..3f1a39e54aa1 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -795,34 +795,32 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		return -ENODEV;
 	}
 
-	if (sk->sk_type == SOCK_DGRAM) {
-		if (sk->sk_state != LLCP_BOUND) {
-			release_sock(sk);
-			return -ENOTCONN;
-		}
+	if (sk->sk_type != SOCK_DGRAM) {
+		release_sock(sk);
 
-		DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
-				 msg->msg_name);
+		if (sk->sk_state != LLCP_CONNECTED)
+			return -ENOTCONN;
 
-		if (msg->msg_namelen < sizeof(*addr)) {
-			release_sock(sk);
-			return -EINVAL;
-		}
+		return nfc_llcp_send_i_frame(llcp_sock, msg, len);
+	}
 
+	if (sk->sk_state != LLCP_BOUND) {
 		release_sock(sk);
-
-		return nfc_llcp_send_ui_frame(llcp_sock, addr->dsap, addr->ssap,
-					      msg, len);
+		return -ENOTCONN;
 	}
 
-	if (sk->sk_state != LLCP_CONNECTED) {
+	DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr, msg->msg_name);
+
+	if (msg->msg_namelen < sizeof(*addr)) {
 		release_sock(sk);
-		return -ENOTCONN;
+		return -EINVAL;
 	}
 
 	release_sock(sk);
 
-	return nfc_llcp_send_i_frame(llcp_sock, msg, len);
+	return nfc_llcp_send_ui_frame(llcp_sock, addr->dsap, addr->ssap,
+				      msg, len);
+
 }
 
 static int llcp_sock_recvmsg(struct socket *sock, struct msghdr *msg,
-- 
2.42.0

