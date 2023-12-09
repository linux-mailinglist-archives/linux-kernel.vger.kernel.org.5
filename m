Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A997780B3E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 12:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjLILFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 06:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjLILFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 06:05:03 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101B10E6;
        Sat,  9 Dec 2023 03:05:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702119866; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=B811NESP0jokoVx2W9ggjXGr4+BAmEt/+ZAinFeKNk+sQ7DlmcM6XwE79IHvBuzAmeML12PQo2FhYdAw2KDka25OTM2ysnDMLJBGkh3Bvc0zyt1EaGFHymoo3kG0JDhXcqDtGipLe74DORkEE/scCIi9UsJ0MV8zKJrv581viW0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1702119866; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=yavI52OC8tlbl19v66raaOoqMeQlZYQq2S/tCxbIsG4=; 
        b=bZcxKFbVK3OJok5Uuad2GtmU1C9y4HwnfT5y3sGOrZRXsM2H+NeKNQ5sfNNKiQDL/cG8mFp4NbWRok+OAbJitA8jRcJq58+s0zOMgI8ip0hHi2Zs7yVgx/ME/TmgBRl9jVPEW/1N7WElRbR39CkK2ELC21/I35FPNbX2/ubX7bo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702119866;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=yavI52OC8tlbl19v66raaOoqMeQlZYQq2S/tCxbIsG4=;
        b=t8i0miUC4Omfh4RcDBWWuBDTN8zZrbw7hQUz8r2bO9oGd+VgCNkuaoFBeIp4Xnl9
        0WRIPGb4rBiy5lvMmm2x0DV8RwZd/AjX3FwxwNVQ3CRnhIL+Rbdaju6DGl7w8Vge1cM
        0lWtrrEoWl/HKHtAzRPPZOs+Tkij+TZYFjxEF3BM=
Received: from kampyooter.. (110.227.243.208 [110.227.243.208]) by mx.zoho.in
        with SMTPS id 1702119865209276.2854511924712; Sat, 9 Dec 2023 16:34:25 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Suman Ghosh <sumang@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Subject: [PATCH net-next v4 1/2] nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local
Date:   Sat,  9 Dec 2023 16:34:20 +0530
Message-ID: <4233248c0ca219693c6e6476aa6e59c799241ac8.1702118242.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702118242.git.code@siddh.me>
References: <cover.1702118242.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

llcp_sock_sendmsg() calls nfc_llcp_send_ui_frame() which in turn calls
nfc_alloc_send_skb(), which accesses the nfc_dev from the llcp_sock for
getting the headroom and tailroom needed for skb allocation.

Parallelly the nfc_dev can be freed, as the refcount is decreased via
nfc_free_device(), leading to a UAF reported by Syzkaller, which can
be summarized as follows:

(1) llcp_sock_sendmsg() -> nfc_llcp_send_ui_frame()
	-> nfc_alloc_send_skb() -> Dereference *nfc_dev
(2) virtual_ncidev_close() -> nci_free_device() -> nfc_free_device()
	-> put_device() -> nfc_release() -> Free *nfc_dev

When a reference to llcp_local is acquired, we do not acquire the same
for the nfc_dev. This leads to freeing even when the llcp_local is in
use, and this is the case with the UAF described above too.

Thus, when we acquire a reference to llcp_local, we should acquire a
reference to nfc_dev, and release the references appropriately later.

References for llcp_local is initialized in nfc_llcp_register_device()
(which is called by nfc_register_device()). Thus, we should acquire a
reference to nfc_dev there.

nfc_unregister_device() calls nfc_llcp_unregister_device() which in
turn calls nfc_llcp_local_put(). Thus, the reference to nfc_dev is
appropriately released later.

Reported-and-tested-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
Fixes: c7aa12252f51 ("NFC: Take a reference on the LLCP local pointer when creating a socket")
Signed-off-by: Siddh Raman Pant <code@siddh.me>
Reviewed-by: Suman Ghosh <sumang@marvell.com>
---
 net/nfc/llcp_core.c | 55 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..0ae89ab42aaa 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -145,6 +145,13 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 
 static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 {
+	/* Since using nfc_llcp_local may result in usage of nfc_dev, whenever
+	 * we hold a reference to local, we also need to hold a reference to
+	 * the device to avoid UAF.
+	 */
+	if (!nfc_get_device(local->dev->idx))
+		return NULL;
+
 	kref_get(&local->ref);
 
 	return local;
@@ -177,10 +184,18 @@ static void local_release(struct kref *ref)
 
 int nfc_llcp_local_put(struct nfc_llcp_local *local)
 {
+	struct nfc_dev *dev;
+	int ret;
+
 	if (local == NULL)
 		return 0;
 
-	return kref_put(&local->ref, local_release);
+	dev = local->dev;
+
+	ret = kref_put(&local->ref, local_release);
+	nfc_put_device(dev);
+
+	return ret;
 }
 
 static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
@@ -930,9 +945,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 
 	if (sk_acceptq_is_full(parent)) {
 		reason = LLCP_DM_REJ;
-		release_sock(&sock->sk);
-		sock_put(&sock->sk);
-		goto fail;
+		goto fail_put_sock;
 	}
 
 	if (sock->ssap == LLCP_SDP_UNBOUND) {
@@ -942,9 +955,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 
 		if (ssap == LLCP_SAP_MAX) {
 			reason = LLCP_DM_REJ;
-			release_sock(&sock->sk);
-			sock_put(&sock->sk);
-			goto fail;
+			goto fail_put_sock;
 		}
 
 		sock->ssap = ssap;
@@ -953,14 +964,18 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 	new_sk = nfc_llcp_sock_alloc(NULL, parent->sk_type, GFP_ATOMIC, 0);
 	if (new_sk == NULL) {
 		reason = LLCP_DM_REJ;
-		release_sock(&sock->sk);
-		sock_put(&sock->sk);
-		goto fail;
+		goto fail_put_sock;
 	}
 
 	new_sock = nfc_llcp_sock(new_sk);
-	new_sock->dev = local->dev;
+
 	new_sock->local = nfc_llcp_local_get(local);
+	if (!new_sock->local) {
+		reason = LLCP_DM_REJ;
+		goto fail_free_new_sock;
+	}
+
+	new_sock->dev = local->dev;
 	new_sock->rw = sock->rw;
 	new_sock->miux = sock->miux;
 	new_sock->nfc_protocol = sock->nfc_protocol;
@@ -1004,8 +1019,13 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 
 	return;
 
+fail_free_new_sock:
+	sock_put(&new_sock->sk);
+	nfc_llcp_sock_free(new_sock);
+fail_put_sock:
+	release_sock(&sock->sk);
+	sock_put(&sock->sk);
 fail:
-	/* Send DM */
 	nfc_llcp_send_dm(local, dsap, ssap, reason);
 }
 
@@ -1597,7 +1617,16 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	if (local == NULL)
 		return -ENOMEM;
 
-	local->dev = ndev;
+	/* As we are going to initialize local's refcount, we need to get the
+	 * nfc_dev to avoid UAF, otherwise there is no point in continuing.
+	 * See nfc_llcp_local_get().
+	 */
+	local->dev = nfc_get_device(ndev->idx);
+	if (!local->dev) {
+		kfree(local);
+		return -ENODEV;
+	}
+
 	INIT_LIST_HEAD(&local->list);
 	kref_init(&local->ref);
 	mutex_init(&local->sdp_lock);
-- 
2.42.0

