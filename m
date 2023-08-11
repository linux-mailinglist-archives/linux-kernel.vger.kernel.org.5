Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866177793A5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbjHKP7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbjHKP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:58:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986D530E9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:53 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-317f1c480eeso1904058f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769532; x=1692374332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=st2NKZ9E1hXrfDL5Ot0q/FaTfuFvnM6rU0/aNjt+RGc=;
        b=TGFIIasqCurxVc8BEOtpb7f0OIiHFeMet4baqs+yRG+W1i1oVpnRM7RH/oRF2dGxHu
         C3yaSG936y/XFN8cFrb3PMr9yODT9g8P7U3CJvMLHGL72yTu++BvRLnXj8GK9c7yO4qq
         B90jn6CTED9DabWy5o4ivqlOkl+g/Wx9ue+bKmzH700b9rs9Fj5L51k/NsSviadPG9uo
         5Srlly7ULuVfkVqVLWSMgTKirFez42x5hJmEga1Wfi8xh29VbL+TXjSR3kIfTeMlETqO
         pOP7LD/6pkfaQFEyYmILGr4/Trla2LyutlHlST2Rxpc4G/wGX8MS6hGcXOQSoP15krxv
         nHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769532; x=1692374332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st2NKZ9E1hXrfDL5Ot0q/FaTfuFvnM6rU0/aNjt+RGc=;
        b=ZuJxcDhA5gS6eH67UFhB0roVIRQ4BIbjKBpfFTPQi1CEgok0af/oT8jvByczMc4S0p
         TlrxTj1snrBk59r4senK4SqSRUSAP/1WkTZE7iBk0UEwIR7zk3f2QJmX5GCtmJw5Hgm+
         MlH3aWWVJk7AsD1wCacW8+GrSw8PNh/pRIp0XWjyuDo7okQq+i4MgNbTWUv79u4eCS2x
         1aEfiV4XvyxSAay+nvJooAoUNtZHNUlM92+pD/wj7o+s9y5CBsTTcrmvbXpA/QbsJxX3
         /he8yBjkY/q7b7UpS9AC09YTK8kSOGxfv0fvbdLl9bcT+C9LZQpWkI7TVEND6HNaTmR9
         gpNA==
X-Gm-Message-State: AOJu0YwywXSBOzhcrHBxvJXT9+zx1CBRHVWTrQ4lA3W/8idhWMuRIeaU
        ZNDG/bOkUqc3ubpMsIbnjV37gQ==
X-Google-Smtp-Source: AGHT+IG6K+E9E28dAF2CoPZoZYVbMBVGSUSdw0piTwy+yuUln7CVT3T59uKh993Hsq2y/6zb/QQlTw==
X-Received: by 2002:adf:fa8c:0:b0:317:7081:9a6a with SMTP id h12-20020adffa8c000000b0031770819a6amr1667780wrr.24.1691769532173;
        Fri, 11 Aug 2023 08:58:52 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:51 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 11 Aug 2023 17:57:24 +0200
Subject: [PATCH net-next 11/14] mptcp: avoid ssock usage in
 mptcp_pm_nl_create_listen_socket()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-11-36183269ade8@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=ryKEnhcU8jzGTw+8/ZGieSQgwwgsCHLHT0d+ugOOpQc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqvmajEXvtvTqt8lHzWQds82lCmd/Y2V7HCi
 Z01gYHwgqaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 cwrJD/40dDF0EYxvn5MXmn3Z/EHHQzIE6RcDCAsJGNaSvTC/z0X5Qd57QL50ZkUasy7eWY/XL04
 dVxdTQXld587lj44Hpu4qUxptiGHQcjviVPK8jhcH9QBJME4PL9apiurN28mna90GcUCuZfgTWU
 hn1pw0e2lY0nEY91BMsvdrbgPXYQljrn+kn2O6nIkNq0WWsfphkTWNMfeBCwFeVzto6Kecrf5bI
 LVPSdRtuy+fBfG2qAa+HUyf5wvyo4Lpu3PBlWvJJuj3gL7Qjpp/xfXWMRhsTRpe1iHl6CmhhguS
 Nkag1RM90+SzkkKWzMKEZEJkWAgM+5hMY2Kzzodm4V6raj7tof+dxZdii0Zike1tiV0FTQK0WLo
 o8xPMddT995MaoIDY3QCxbiViJDQpRRUPH6+NeMWq+AheVQJauH2eLA2DotoBZUCVjbWTWKfHfO
 /jm3l4X8Xam9FNNKeFMQ/lr+ZyydVpZ1bx5gye6iBVHRH06E0o+J9stqqlmqIV8hQo8J880Fhr2
 eWvuLyMImbi0rKsspWbaphIL/iTrMjzaK+n4WkfcXtzcaQtn/9ROyHYtErQZh3A8wfdbMjJX1UX
 JkngATdTVyt+Kiy0BAHiirZrk1HjjgQkw+v5U+UJXvMBcrwFXQCIz8t/ECB9soCoeBK6MThJH5D
 Pr81hahvz6kdXcA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

This is one of the few remaining spots actually manipulating the
first subflow socket. We can leverage the recently introduced
inet helpers to get rid of ssock there.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_netlink.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5692daf57a4d..ae36155ff128 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -9,6 +9,7 @@
 #include <linux/inet.h>
 #include <linux/kernel.h>
 #include <net/tcp.h>
+#include <net/inet_common.h>
 #include <net/netns/generic.h>
 #include <net/mptcp.h>
 #include <net/genetlink.h>
@@ -1005,8 +1006,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	bool is_ipv6 = sk->sk_family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
+	struct sock *newsk, *ssk;
 	struct socket *ssock;
-	struct sock *newsk;
 	int backlog = 1024;
 	int err;
 
@@ -1042,18 +1043,23 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (entry->addr.family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
-	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
+	ssk = mptcp_sk(newsk)->first;
+	if (ssk->sk_family == AF_INET)
+		err = inet_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (ssk->sk_family == AF_INET6)
+		err = inet6_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
+#endif
 	if (err)
 		return err;
 
 	inet_sk_state_store(newsk, TCP_LISTEN);
-	err = kernel_listen(ssock, backlog);
-	if (err)
-		return err;
-
-	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
-
-	return 0;
+	lock_sock(ssk);
+	err = __inet_listen_sk(ssk, backlog);
+	if (!err)
+		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
+	release_sock(ssk);
+	return err;
 }
 
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc)

-- 
2.40.1

