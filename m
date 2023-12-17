Return-Path: <linux-kernel+bounces-2591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6663A815F2F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3371F21A34
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E464436F;
	Sun, 17 Dec 2023 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="XWxdG2t/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A05542AA5;
	Sun, 17 Dec 2023 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siddh.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siddh.me
ARC-Seal: i=1; a=rsa-sha256; t=1702818675; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=HDDJxvglwfDtkgVMPa8hqysuAZOIyl+ZMMl7ynOB8dKyIcw+Fdw3DJcYcgr+DO8dUvpupFtiDRRgPYX7o1y0/noHfgKNKm40qeCRLrCGC2U5UfyZ73YIvv45NjJ47z3nMLnNMYl0wXgUktiIg/c6YPuRGp+cn4d1ZkZ+RKYpMvI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1702818675; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8WRK+iesJAbnH4jSLyDESYEBrykLMCNMgI+C244SKGQ=; 
	b=C8nIc+UAAwa28qMsMpokFyJEGyW0DrLfhrP+wTnYjKCrbgx5nvaUSNh8S+tNKVLRxaGByoVQ8Qf321OOIdx65v6ZVz96b1UiaDTbZG7Wm/D6fR30H0W3V99EHMzK7O2ojOlaeBb36SeIwcthex+UtQO30N4OY/q68JqqM43LR7g=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702818675;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8WRK+iesJAbnH4jSLyDESYEBrykLMCNMgI+C244SKGQ=;
	b=XWxdG2t/9Vy2/UgIDYE5STwOqDqz7qeRu9jhG4dEusicqHHkVClx1stkohAu5niz
	6Zj51XMozqzDbkA538Y/sS/7jDoliRf1QnZ6YUG+0egQBBONa0VTntAyhQn0LahtIxL
	9MLUDa4dECmhWzOFQptNWJArKav8IuXZQoNZQ9+0=
Received: from kampyooter.. (122.170.167.40 [122.170.167.40]) by mx.zoho.in
	with SMTPS id 1702818673882496.18443141454156; Sun, 17 Dec 2023 18:41:13 +0530 (IST)
From: Siddh Raman Pant <code@siddh.me>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Suman Ghosh <sumang@marvell.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Subject: [PATCH net-next v6 1/2] nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local
Date: Sun, 17 Dec 2023 18:41:03 +0530
Message-ID: <0d812b9aae2f16691d373460b06c5f3e098ed2a6.1702816635.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702816635.git.code@siddh.me>
References: <cover.1702816635.git.code@siddh.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

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
 net/nfc/llcp_core.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..fadc8a9ec4df 100644
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
@@ -959,8 +974,18 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 	}
 
 	new_sock = nfc_llcp_sock(new_sk);
-	new_sock->dev = local->dev;
+
 	new_sock->local = nfc_llcp_local_get(local);
+	if (!new_sock->local) {
+		reason = LLCP_DM_REJ;
+		release_sock(&sock->sk);
+		sock_put(&sock->sk);
+		sock_put(&new_sock->sk);
+		nfc_llcp_sock_free(new_sock);
+		goto fail;
+	}
+
+	new_sock->dev = local->dev;
 	new_sock->rw = sock->rw;
 	new_sock->miux = sock->miux;
 	new_sock->nfc_protocol = sock->nfc_protocol;
@@ -1597,7 +1622,16 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
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


