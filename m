Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF50480F5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376832AbjLLSuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376638AbjLLSuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:50:01 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB19CE;
        Tue, 12 Dec 2023 10:50:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702406966; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=LGV/XknIHZ+zp7YLAnIG2Oe/Fr8L0fSEC3pG4DIXSGqwNAYldOXKILF/9NL165pS1gHapoF2XmTqc9NcVsfM/8GeEfZLkvJ0M2J2hSi1I4gTbuqYhM6+vjGQIlQxbpmtXPnh0UVthnTN6j8lJGcjiHaaoeFqf0S126P+B+LXf+4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1702406966; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=7RCDvTtCKRGsE+W0Q84GxYSqs2sZMkWAKNJDaj4VdG8=; 
        b=adlWOXZUodTgBEJ0zwVHScx6iAztlGzt9k0NHOROdBCyI9xwsrWn2hfyXQQgBiRPvHGOgxKkXkdZC+F/+0JY0c+DN37f7RXiHI+l/X74SBR8cQW7hT61ih+EYRypQ/1ZJ4f6Tf7c41KtxE9QmkYYKVfs+SJ3QiPFoVoje4lH/eE=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702406966;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=7RCDvTtCKRGsE+W0Q84GxYSqs2sZMkWAKNJDaj4VdG8=;
        b=t4B/dsuU2ewzZQ07xfGwoz/zZ6XbnDj1khhgUaKOEKfIJVE0n2YLYISlP+0eHSK0
        3hdMvYU/SvydF+5IDvKXv1TppmYtwzV33qWA9dMwfN5Va0HAYu17I0cPKD5WVC6sPTI
        AqAY72RjPV62huIfS98+TefTnFHi/2UpK/9a+gJ8=
Received: from kampyooter.. (182.69.31.144 [182.69.31.144]) by mx.zoho.in
        with SMTPS id 1702406965792752.930614411838; Wed, 13 Dec 2023 00:19:25 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Suman Ghosh <sumang@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Subject: [PATCH net-next v5 1/2] nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local
Date:   Wed, 13 Dec 2023 00:19:19 +0530
Message-ID: <6a26e3b65817bb31cb11c8dde5b1b420071d944e.1702404519.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702404519.git.code@siddh.me>
References: <cover.1702404519.git.code@siddh.me>
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
Reviewed-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 net/nfc/llcp_core.c | 72 +++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..2f77200a3720 100644
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
@@ -901,7 +916,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 
 	if (dsap != LLCP_SAP_SDP) {
 		sock = nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);
-		if (sock == NULL || sock->sk.sk_state != LLCP_LISTEN) {
+		if (!sock || sock->sk.sk_state != LLCP_LISTEN) {
 			reason = LLCP_DM_NOBOUND;
 			goto fail;
 		}
@@ -910,7 +925,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 		size_t sn_len;
 
 		sn = nfc_llcp_connect_sn(skb, &sn_len);
-		if (sn == NULL) {
+		if (!sn) {
 			reason = LLCP_DM_NOBOUND;
 			goto fail;
 		}
@@ -918,7 +933,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 		pr_debug("Service name length %zu\n", sn_len);
 
 		sock = nfc_llcp_sock_get_sn(local, sn, sn_len);
-		if (sock == NULL) {
+		if (!sock) {
 			reason = LLCP_DM_NOBOUND;
 			goto fail;
 		}
@@ -928,39 +943,31 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 
 	parent = &sock->sk;
 
-	if (sk_acceptq_is_full(parent)) {
-		reason = LLCP_DM_REJ;
-		release_sock(&sock->sk);
-		sock_put(&sock->sk);
-		goto fail;
-	}
+	if (sk_acceptq_is_full(parent))
+		goto fail_put_sock;
 
 	if (sock->ssap == LLCP_SDP_UNBOUND) {
 		u8 ssap = nfc_llcp_reserve_sdp_ssap(local);
 
 		pr_debug("First client, reserving %d\n", ssap);
 
-		if (ssap == LLCP_SAP_MAX) {
-			reason = LLCP_DM_REJ;
-			release_sock(&sock->sk);
-			sock_put(&sock->sk);
-			goto fail;
-		}
+		if (ssap == LLCP_SAP_MAX)
+			goto fail_put_sock;
 
 		sock->ssap = ssap;
 	}
 
 	new_sk = nfc_llcp_sock_alloc(NULL, parent->sk_type, GFP_ATOMIC, 0);
-	if (new_sk == NULL) {
-		reason = LLCP_DM_REJ;
-		release_sock(&sock->sk);
-		sock_put(&sock->sk);
-		goto fail;
-	}
+	if (!new_sk)
+		goto fail_put_sock;
 
 	new_sock = nfc_llcp_sock(new_sk);
-	new_sock->dev = local->dev;
+
 	new_sock->local = nfc_llcp_local_get(local);
+	if (!new_sock->local)
+		goto fail_free_new_sock;
+
+	new_sock->dev = local->dev;
 	new_sock->rw = sock->rw;
 	new_sock->miux = sock->miux;
 	new_sock->nfc_protocol = sock->nfc_protocol;
@@ -1004,8 +1011,14 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 
 	return;
 
+fail_free_new_sock:
+	sock_put(&new_sock->sk);
+	nfc_llcp_sock_free(new_sock);
+fail_put_sock:
+	reason = LLCP_DM_REJ;
+	release_sock(&sock->sk);
+	sock_put(&sock->sk);
 fail:
-	/* Send DM */
 	nfc_llcp_send_dm(local, dsap, ssap, reason);
 }
 
@@ -1597,7 +1610,16 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
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

