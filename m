Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000478033FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344263AbjLDNJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjLDNJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:09:04 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5739ED5B;
        Mon,  4 Dec 2023 05:09:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701695309; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=FuJc7I9gI1RkTq8sK+QC5tIAlRPr+gnyONRuBkcwoeFW0R7cEa877xmmErxmSNNcnlm9KZv6ZK/jgdWNvh9HWlLkZAhxlsg8uQ61KhzgH6cwiEQ/vortwlpHmCNwDzaaTUy7IVXqY2lUBjILkUW+JHJz38leeK83bl7zcW41mrU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701695309; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=R3iDLTqqyWsCW/yZ9x9fWDYA3oYZ6WCh4COkmNHdQK4=; 
        b=a48H7NBxEMBntfGwtB5CvG3I8k9j5o6RLZ2GJ63nHW0Sl5zTHsWluBLBvNFvai5zsq4ch3DyBgjmlI96msXUujX731N7Eq+M7vKXFPDd4P4YwQnN5D14Cnj+WHDVc8VQRSxDgdD1aw4gx9qjsLs8ugNPQn4mDYscrdlfuPpYmls=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701695309;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=R3iDLTqqyWsCW/yZ9x9fWDYA3oYZ6WCh4COkmNHdQK4=;
        b=CXRmlxmNsWzehyzUEEgqV5rDvEO2SimcT6ofZlkfeHZ4ohHwYY30iC7Z4x0Ggor3
        biFmmQqk04h7kN+fDNs+8x6U3xt2q7E9hx1xQflOmRFsi3BbGpPztZoAPhUx2zzPwEQ
        RFWLQUnYWBp2vWRYwo8gIBieetIzZ8aEwJ1XMlNw=
Received: from kampyooter.. (223.229.148.242 [223.229.148.242]) by mx.zoho.in
        with SMTPS id 1701695308534654.1773373137597; Mon, 4 Dec 2023 18:38:28 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Suman Ghosh <sumang@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Subject: [PATCH net-next v3 1/2] nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local
Date:   Mon,  4 Dec 2023 18:38:21 +0530
Message-ID: <4143dc4398aa4940a76d3f375ec7984e98891a11.1701627492.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701627492.git.code@siddh.me>
References: <cover.1701627492.git.code@siddh.me>
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
---
 net/nfc/llcp_core.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..9d45ce6dcdca 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -145,6 +145,9 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 
 static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 {
+	if (!nfc_get_device(local->dev->idx))
+		return NULL;
+
 	kref_get(&local->ref);
 
 	return local;
@@ -180,6 +183,7 @@ int nfc_llcp_local_put(struct nfc_llcp_local *local)
 	if (local == NULL)
 		return 0;
 
+	nfc_put_device(local->dev);
 	return kref_put(&local->ref, local_release);
 }
 
@@ -959,8 +963,18 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
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
@@ -1597,7 +1611,13 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	if (local == NULL)
 		return -ENOMEM;
 
-	local->dev = ndev;
+	/* Hold a reference to the device. */
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

