Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF3A7F8EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 21:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjKYU1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 15:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjKYU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 15:27:05 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D38119;
        Sat, 25 Nov 2023 12:27:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700943997; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=dqsZItpanhNpUQhMs5iWna0XZrthWxu22M1e+Vhd1fiZ5ekGGfU8EXJtccoXEY1cp8HDLYnj+4F1UZ7f6sRuJsveD7q+hbYkTUUTZGS+LEwqT5MkZn2gnC+pgSJaLAkfyhNAw3JBM09OTrIhk2+XFpZY30ZL5+5CkI7sMtW0gHo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1700943997; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=zRlFgAJrtEWCzZS3K60IRfSk2CnQKoHBXTn6uGX5VTg=; 
        b=ZoRGS+zGGPM3gYlAP5ciNLZ3GR0vOtkq3y6UzaH0n5pTnUBLYczkvPhC8QSgLwsk8R0l/lBfR/GZjoIWPu+vDOaRyGWXZfdN8KPN7whoKC9jD6siLLBECx/z4/mydkSEAq7H8yXLf4H5chnIVOSdTbMCh2xf23EuRKngPjkqc14=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700943997;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=zRlFgAJrtEWCzZS3K60IRfSk2CnQKoHBXTn6uGX5VTg=;
        b=AY+2kf2SDxD9sh2zXy27svfV+rJHAtS9zqCRP72MnjNRYAbEGViY2TKp/tRym9/Z
        nkMOXC986gaW8bpRP6D7+ZHirvEkRuEdyeJ8c0hRdpmrUj4dvv7tfEArJXjMeAjPf8i
        3iXJcHNITq6uVFkB0TME/9NQawWby3R4ZG46dvFo=
Received: from kampyooter.. (110.226.61.26 [110.226.61.26]) by mx.zoho.in
        with SMTPS id 1700943995667656.7460159615724; Sun, 26 Nov 2023 01:56:35 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] nfc: Do not send datagram if socket state isn't LLCP_BOUND
Date:   Sun, 26 Nov 2023 01:56:18 +0530
Message-ID: <ff2e1639a591e413ce95eb64dea85751292c0be0.1700943019.git.code@siddh.me>
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

As we know we cannot send the datagram (state can be set to LLCP_CLOSED
by nfc_llcp_socket_release()), there is no need to proceed further.

Thus, bail out early from llcp_sock_sendmsg().

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 net/nfc/llcp_sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index ef1ab88a5e4f..603f2219b62f 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -796,6 +796,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (sk->sk_type == SOCK_DGRAM) {
+		if (sk->sk_state != LLCP_BOUND) {
+			release_sock(sk);
+			return -ENOTCONN;
+		}
+
 		DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
 				 msg->msg_name);
 
-- 
2.42.0

