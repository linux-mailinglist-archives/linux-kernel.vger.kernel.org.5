Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2994D7793A0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbjHKP66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236693AbjHKP6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:58:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C062723
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31956020336so809881f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769526; x=1692374326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXo0sd7SwYNHKnxVFphwOPuJHuje+rAleUnK3N6bXns=;
        b=13y5vALU9DW+JJ2uo9mfksvy1dk73siK5uzK8gc4SXHP1eziiEQAFRO1aTUrsZv0jW
         6cakbID3ywLC+T/uZ0W+bymrKCy3C7WnFOOCVDNEMlTMc9m4fVIqgMGN4N38p2M3mtI3
         SSO8Pdlnd3VH3/aZi5bjADFKUT3Q1HD8gZia2XkI5MVPr+qtBRnWyiGimYv7U6zTQeyW
         piuCFbEIP6A5yAvUzcm+r8DVdaQ+vvLRvJ6ayoZyKsTTmrqnjosjZ7tbJ9iZWZZ/TnTa
         NrY9Uz44enNrAfN++CU1qupQJDDrhLxlaB8gab1WaOlj7nVwStKdgpN43mrP/tK1PT6p
         UNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769526; x=1692374326;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXo0sd7SwYNHKnxVFphwOPuJHuje+rAleUnK3N6bXns=;
        b=AszfeuNbxPnyVp/FVW1A9bo6rjseB62XAwhQ62Osgid1voBAlLj46xRzA5ZGPJlq+H
         h0MGsW1FpemvzqJX1AA2hZODxSsrrInTBdnUnQa1TX+8hkHaEjsvJTUNW89rMVdYN0Rd
         71OJRYSQE1TFrtBMNuFJ3hQ6SwzXTbELA7f8fa3OpC+jR1FbcGqwk0PO7rtK+k0AxFzp
         jXXE9GzlkCMuR3rAV8JJGcuVKC775SjDCNyWYkfBRVwv8Nvi8KSDiTFIYW1yKELFzEDn
         6dmDtwxOWi7NvmzmSurzAs0/fjfq8t6FHrSPonabGskxkY20BJmHbsgYlgG30+74kMK+
         7W8g==
X-Gm-Message-State: AOJu0Yz92otpJpDUlrTCyed5IZXdnkRt4Xc7rySoHsSPLV61iVTCpAf9
        10cmFOajcOovEFHiRYDBOFnBL4IGH9kjINyX53BPlg==
X-Google-Smtp-Source: AGHT+IFJPySODNZASWJwgumOMgIlOK+JSgpHaW2lQlb/mSeShN4RnZANnmzMasJy+nIeIULx7YAy4Q==
X-Received: by 2002:adf:d0d2:0:b0:316:fc03:3c66 with SMTP id z18-20020adfd0d2000000b00316fc033c66mr1971213wrh.3.1691769525729;
        Fri, 11 Aug 2023 08:58:45 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:45 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 11 Aug 2023 17:57:18 +0200
Subject: [PATCH net-next 05/14] mptcp: mptcp: avoid additional indirection
 in mptcp_bind()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-5-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=cdwy4jZYJOHpcHNPu/Z9TpyfzeGedcmkSzxHG6aP0d4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqvp6igb6LLgMw0L0m3fOD5/XhmzXvqIteac
 rzBRElskEaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c11KD/9UokU2haRftpKeotauDl76HX7tCqE3iw4xRk5XJvZkHuq1stH7gm4PN1Yb654o8nk0d4f
 vOd44O3is3+wImlJijpb/JC4XnDm7UIgPivo49Y/Ffa8oBeF8H3+mZE2jjhZkP46Ah0xNIFd5vK
 +0ho6WTK9/kxzznIugKjyHu9ILe0Kz40Nfwyu32EKdQrbjk7ho1/lMDxb0YcBADaOfx7KN1uU2j
 tn5+X2GH9SEk+zLdjmVB0lqeHERql3n4P/Xk6MJ8ajtc+A4PWWNZZ3gz/JJ9asaSWBD8yKzGcfg
 zN7Zev5BJmqRCb4QFh7RbkFBmFIqOQ5ROrkj/HkVlC5En4uA+g5g6LrbpC5adtjxiaoPKKdSuGN
 d8kHbKIVwn37lPm0TKU+8zMlqFKglgfCIunqehisK5DLANS5Ryk7XXzTQy36dI33h5pc5PluGbE
 h20VyHrAQ6wVRiFdkHwuR7rtijtfpxAr/TEn7A8ZnpOIVs6uM4Ia2Lv2P5ktwgO+O/v5mAoxAlj
 KBTmZ4Uorsbaj7FuTZF8xGHVfwcD9ft3oSlFiqN1ou5eJQkRXp3ZTel3Pq7oIQmFDHlegKTGPZL
 KXtkHRCYfIIUxz1pnWvZJvjrZ/xrEiU86VoSM2xkGvK2fYQuGPNKOfgXgAuaUxCbWJTTSyB7pR4
 ltiVCyO+859qRgw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

We are going to remove the first subflow socket soon, so avoid
the additional indirection via at bind() time. Instead call directly
the recently introduced helpers on the first subflow sock.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 891f49722263..5b4d6f0628a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3689,22 +3689,29 @@ static struct proto mptcp_prot = {
 static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
+	struct sock *ssk, *sk = sock->sk;
 	struct socket *ssock;
-	int err;
+	int err = -EINVAL;
 
-	lock_sock(sock->sk);
+	lock_sock(sk);
 	ssock = __mptcp_nmpc_socket(msk);
 	if (IS_ERR(ssock)) {
 		err = PTR_ERR(ssock);
 		goto unlock;
 	}
 
-	err = READ_ONCE(ssock->ops)->bind(ssock, uaddr, addr_len);
+	ssk = msk->first;
+	if (sk->sk_family == AF_INET)
+		err = inet_bind_sk(ssk, uaddr, addr_len);
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (sk->sk_family == AF_INET6)
+		err = inet6_bind_sk(ssk, uaddr, addr_len);
+#endif
 	if (!err)
-		mptcp_copy_inaddrs(sock->sk, ssock->sk);
+		mptcp_copy_inaddrs(sk, ssk);
 
 unlock:
-	release_sock(sock->sk);
+	release_sock(sk);
 	return err;
 }
 

-- 
2.40.1

