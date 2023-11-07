Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5D7E3C38
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjKGMNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjKGMMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:12:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E073170A;
        Tue,  7 Nov 2023 04:10:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C585C433C7;
        Tue,  7 Nov 2023 12:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359022;
        bh=q4YJap9+E3vrfXB4ogEHuOmxTN52MNFYxRfJwMNDyvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jiX4mxq1VAygKJF0dq1033sKa85Bm2ozouesSjO2+YJwwC7lyYj1FOeJSP+OOHhuO
         wOkl8H7xrGLaAe8sZ7Zf2vaUGhxPbg6QzzS4aRqJRACJ4PnvthcApflJsJEvkVyL0V
         RocmuN0AvUz4BdUPM7eJt/oyK3aZ5OuCyFqStv1qlNtMO2OYBw2MVK2rWIX2fArVEx
         CqImfQMUF3KodNpgdlwu/ZYi6hTpjBsFnZ+lg1ngm4RpXt98UEQvK4xOPlnnm5L2+a
         eBcczR9ODkSAt/DsW6p2MbGRDTRCQysVGWq5HjSXZuV/JitsjFISSB/mbHV6H5h+Bl
         shAMFCc4vXA9Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arseniy Krasnov <avkrasnov@salutedevices.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, dhowells@redhat.com,
        willemb@google.com, kuniyu@amazon.com, alexander@mihalicyn.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 20/30] vsock: read from socket's error queue
Date:   Tue,  7 Nov 2023 07:08:35 -0500
Message-ID: <20231107120922.3757126-20-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arseniy Krasnov <avkrasnov@salutedevices.com>

[ Upstream commit 49dbe25adac42d3e06f65d1420946bec65896222 ]

This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
is used to read socket's error queue instead of data queue. Possible
scenario of error queue usage is receiving completions for transmission
with MSG_ZEROCOPY flag. This patch also adds new defines: 'SOL_VSOCK'
and 'VSOCK_RECVERR'.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/socket.h          |  1 +
 include/uapi/linux/vm_sockets.h | 17 +++++++++++++++++
 net/vmw_vsock/af_vsock.c        |  6 ++++++
 3 files changed, 24 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 39b74d83c7c4a..cfcb7e2c3813f 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -383,6 +383,7 @@ struct ucred {
 #define SOL_MPTCP	284
 #define SOL_MCTP	285
 #define SOL_SMC		286
+#define SOL_VSOCK	287
 
 /* IPX options */
 #define IPX_TYPE	1
diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
index c60ca33eac594..ed07181d4eff9 100644
--- a/include/uapi/linux/vm_sockets.h
+++ b/include/uapi/linux/vm_sockets.h
@@ -191,4 +191,21 @@ struct sockaddr_vm {
 
 #define IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)
 
+/* MSG_ZEROCOPY notifications are encoded in the standard error format,
+ * sock_extended_err. See Documentation/networking/msg_zerocopy.rst in
+ * kernel source tree for more details.
+ */
+
+/* 'cmsg_level' field value of 'struct cmsghdr' for notification parsing
+ * when MSG_ZEROCOPY flag is used on transmissions.
+ */
+
+#define SOL_VSOCK	287
+
+/* 'cmsg_type' field value of 'struct cmsghdr' for notification parsing
+ * when MSG_ZEROCOPY flag is used on transmissions.
+ */
+
+#define VSOCK_RECVERR	1
+
 #endif /* _UAPI_VM_SOCKETS_H */
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 020cf17ab7e47..ccd8cefeea7ba 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -89,6 +89,7 @@
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/cred.h>
+#include <linux/errqueue.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -110,6 +111,7 @@
 #include <linux/workqueue.h>
 #include <net/sock.h>
 #include <net/af_vsock.h>
+#include <uapi/linux/vm_sockets.h>
 
 static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
 static void vsock_sk_destruct(struct sock *sk);
@@ -2134,6 +2136,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	int err;
 
 	sk = sock->sk;
+
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return sock_recv_errqueue(sk, msg, len, SOL_VSOCK, VSOCK_RECVERR);
+
 	vsk = vsock_sk(sk);
 	err = 0;
 
-- 
2.42.0

