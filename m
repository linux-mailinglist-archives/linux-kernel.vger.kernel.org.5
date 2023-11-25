Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD3F7F8EAA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 21:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjKYU1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 15:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKYU1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 15:27:05 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C0710B;
        Sat, 25 Nov 2023 12:27:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1700943997; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=E8pah2PkEyu0QS7s/qU7SRkza+Lo2QrfNd8H2RvTuTTW98TFkbP0eFvnIypIW8EYd/VA6Z5IWyE6ruqwi7PEPSZa4I6w0kcpfg/N0/v7LRdAUmgFGV6V0f4bm//ZygCARLOdUILMi+x5JFocB7C1LC5GC1KmkkZjkTpJOmBQyJo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1700943997; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=BEgkYV/g4NVqjVg4g/pZSrbzunesAbsgXj6OKtD8qnY=; 
        b=LkK8FuB9+0K1zgJJzuOWWpy0/A6KrVm5/bB5ATAPM5D4ooYdoqfjCdvpe4iOeNRAWpH4ZN7kV6QHPsxmzMT5M+xE1VWl6+SwrsZM+FMqvUMusNOMV1+TD2LEIH2zWV7zmanP3rnmFN+mj+bOvuYq1GnVSrfyWUHrh4P9KDcVdp0=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1700943997;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=BEgkYV/g4NVqjVg4g/pZSrbzunesAbsgXj6OKtD8qnY=;
        b=RLde9bkgAi7h1vbXSpCfVyrbn5NIW/vzyqsmig0vjGOF7ocCwiuNI/FLKMgWdg9+
        PcE6wrzCT8VrkZYMi61PSl3x9i2LQtCDAl+jr7ghPTQs55Fe1eXbbW3sk7u15pG5WQX
        W94W4cdUGV1j4L4DinGAyVRNxmb1iG/jXSuhU954=
Received: from kampyooter.. (110.226.61.26 [110.226.61.26]) by mx.zoho.in
        with SMTPS id 1700943995162403.864052366456; Sun, 26 Nov 2023 01:56:35 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Subject: [PATCH 2/4] nfc: Protect access to nfc_dev in an llcp_sock with a rwlock
Date:   Sun, 26 Nov 2023 01:56:17 +0530
Message-ID: <7c198c2aa08b34045b8f9e0afe3d0b3bf5802180.1700943019.git.code@siddh.me>
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

llcp_sock_sendmsg() calls nfc_llcp_send_ui_frame(), which accesses the
nfc_dev from the llcp_sock for getting the headroom and tailroom needed
for skb allocation.

Parallely, the nfc_dev can be freed via the nfc_unregister_device()
codepath (nfc_release() being called due to the class unregister in
nfc_exit()), leading to the UAF reported by Syzkaller.

We have the following call tree before freeing:

nfc_unregister_device()
	-> nfc_llcp_unregister_device()
		-> local_cleanup()
			-> nfc_llcp_socket_release()

nfc_llcp_socket_release() sets the state of sockets to LLCP_CLOSED,
and this is encountered necessarily before any freeing of nfc_dev.

Thus, add a rwlock in struct llcp_sock to synchronize access to
nfc_dev. nfc_dev in an llcp_sock will be NULLed in a write critical
section when socket state has been set to closed. Thus, we can avoid
the UAF by bailing out from a read critical section upon seeing NULL.

Since this is repeated multiple times in nfc_llcp_socket_release(),
extract the behaviour into a new function.

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 net/nfc/llcp.h          |  1 +
 net/nfc/llcp_commands.c | 27 ++++++++++++++++++++++++---
 net/nfc/llcp_core.c     | 31 +++++++++++++++++++------------
 net/nfc/llcp_sock.c     |  2 ++
 4 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/net/nfc/llcp.h b/net/nfc/llcp.h
index d8345ed57c95..800cbe8e3d6b 100644
--- a/net/nfc/llcp.h
+++ b/net/nfc/llcp.h
@@ -102,6 +102,7 @@ struct nfc_llcp_local {
 struct nfc_llcp_sock {
 	struct sock sk;
 	struct nfc_dev *dev;
+	rwlock_t rw_dev_lock;
 	struct nfc_llcp_local *local;
 	u32 target_idx;
 	u32 nfc_protocol;
diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 39c7c59bbf66..b132830bc206 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -315,13 +315,24 @@ static struct sk_buff *llcp_allocate_pdu(struct nfc_llcp_sock *sock,
 {
 	struct sk_buff *skb;
 	int err, headroom, tailroom;
+	unsigned long irq_flags;
 
 	if (sock->ssap == 0)
 		return NULL;
 
+	read_lock_irqsave(&sock->rw_dev_lock, irq_flags);
+
+	if (!sock->dev) {
+		read_unlock_irqrestore(&sock->rw_dev_lock, irq_flags);
+		pr_err("NFC device does not exit\n");
+		return NULL;
+	}
+
 	headroom = sock->dev->tx_headroom;
 	tailroom = sock->dev->tx_tailroom;
 
+	read_unlock_irqrestore(&sock->rw_dev_lock, irq_flags);
+
 	skb = nfc_alloc_send_skb(&sock->sk, MSG_DONTWAIT,
 				 size + LLCP_HEADER_SIZE, headroom, tailroom,
 				 &err);
@@ -739,6 +750,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 	u8 *msg_ptr, *msg_data;
 	u16 remote_miu;
 	int err, headroom, tailroom;
+	unsigned long irq_flags;
 
 	pr_debug("Send UI frame len %zd\n", len);
 
@@ -746,6 +758,18 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 	if (local == NULL)
 		return -ENODEV;
 
+	read_lock_irqsave(&sock->rw_dev_lock, irq_flags);
+
+	if (!sock->dev) {
+		read_unlock_irqrestore(&sock->rw_dev_lock, irq_flags);
+		return -ENODEV;
+	}
+
+	headroom = sock->dev->tx_headroom;
+	tailroom = sock->dev->tx_tailroom;
+
+	read_unlock_irqrestore(&sock->rw_dev_lock, irq_flags);
+
 	msg_data = kmalloc(len, GFP_USER | __GFP_NOWARN);
 	if (msg_data == NULL)
 		return -ENOMEM;
@@ -755,9 +779,6 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 		return -EFAULT;
 	}
 
-	headroom = sock->dev->tx_headroom;
-	tailroom = sock->dev->tx_tailroom;
-
 	remaining_len = len;
 	msg_ptr = msg_data;
 
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..a565712d7db8 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -20,6 +20,22 @@ static LIST_HEAD(llcp_devices);
 /* Protects llcp_devices list */
 static DEFINE_SPINLOCK(llcp_devices_lock);
 
+static inline void nfc_llcp_sock_close(struct nfc_llcp_sock *llcp_sock, int err)
+{
+	struct sock *sk = &llcp_sock->sk;
+	unsigned long irq_flags;
+
+	if (err)
+		sk->sk_err = err;
+
+	sk->sk_state = LLCP_CLOSED;
+	sk->sk_state_change(sk);
+
+	write_lock_irqsave(&llcp_sock->rw_dev_lock, irq_flags);
+	llcp_sock->dev = NULL;
+	write_unlock_irqrestore(&llcp_sock->rw_dev_lock, irq_flags);
+}
+
 static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb);
 
 void nfc_llcp_sock_link(struct llcp_sock_list *l, struct sock *sk)
@@ -96,19 +112,13 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 
 				nfc_llcp_accept_unlink(accept_sk);
 
-				if (err)
-					accept_sk->sk_err = err;
-				accept_sk->sk_state = LLCP_CLOSED;
-				accept_sk->sk_state_change(sk);
+				nfc_llcp_sock_close(lsk, err);
 
 				bh_unlock_sock(accept_sk);
 			}
 		}
 
-		if (err)
-			sk->sk_err = err;
-		sk->sk_state = LLCP_CLOSED;
-		sk->sk_state_change(sk);
+		nfc_llcp_sock_close(llcp_sock, err);
 
 		bh_unlock_sock(sk);
 
@@ -130,10 +140,7 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 
 		nfc_llcp_socket_purge(llcp_sock);
 
-		if (err)
-			sk->sk_err = err;
-		sk->sk_state = LLCP_CLOSED;
-		sk->sk_state_change(sk);
+		nfc_llcp_sock_close(llcp_sock, err);
 
 		bh_unlock_sock(sk);
 
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 645677f84dba..ef1ab88a5e4f 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -983,6 +983,8 @@ struct sock *nfc_llcp_sock_alloc(struct socket *sock, int type, gfp_t gfp, int k
 	sk->sk_type = type;
 	sk->sk_destruct = llcp_sock_destruct;
 
+	rwlock_init(&llcp_sock->rw_dev_lock);
+
 	llcp_sock->ssap = 0;
 	llcp_sock->dsap = LLCP_SAP_SDP;
 	llcp_sock->rw = LLCP_MAX_RW + 1;
-- 
2.42.0

