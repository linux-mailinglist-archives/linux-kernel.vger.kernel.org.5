Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6869F801D81
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 16:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjLBPlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 10:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLBPlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 10:41:47 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96C7125;
        Sat,  2 Dec 2023 07:41:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701531674; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=YzOx7SVnwV5ebNZQGBeGoSc+wZ0Vqmn7zDjbMX8A1HZiY3fF5LCP2aRzOUEjRTHQGe2H2jCoRP561kp26jCtmc1oSdUVJV+NVR+L6p7MtHLQtmzz3JG/PMI3VPn1lvonT4H9megUZEUxBWCXpa4P0CkpvglHrg8UvAtzffCfuMs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701531674; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=2/y8gNDVdvE3iVtTQwtex+8cx1buAga8FFDXuaGHqVY=; 
        b=PJjfV/lMVpbGyS70Os0DRLgSA3MblAIGIvlUcmFJbQjHcDnIfEmGznZDhm1/hLEsb2NLWOVsQmRISQNV8InB5+qbhnyHZR6kjRbe52ocbMsLIfxFXMttdukAzMwAIM8vrAkTvtyjm5OgRyHrjP5BHs9ksj/P4Fu5FHP98gWeMQo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701531674;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=2/y8gNDVdvE3iVtTQwtex+8cx1buAga8FFDXuaGHqVY=;
        b=Ek3iTZ64lv3ZVAD79JdLetXTahik6epLFZmXoyDww7AAWaBnxPqMBiVxAMTADrNb
        bXXKZ0tJloXvMyTUllqWeGQeC9d/+Y6Yqy9NYKay2KqdIexpoYhhq+mW+reg7cUbG9m
        V5TFu2wMtuJn9merj0T62FFmBGcKApAm8I21WvNk=
Received: from kampyooter.. (122.170.35.155 [122.170.35.155]) by mx.zoho.in
        with SMTPS id 1701531671764225.8381284275174; Sat, 2 Dec 2023 21:11:11 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Ortiz <sameo@linux.intel.com>,
        syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Subject: [PATCH net-next v2 1/2] nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local
Date:   Sat,  2 Dec 2023 21:10:58 +0530
Message-ID: <476cccdcb57645784889fc82f0c7c10ff4c8b8c0.1701530776.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701530776.git.code@siddh.me>
References: <cover.1701530776.git.code@siddh.me>
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
 net/nfc/llcp_core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 1dac28136e6a..a574c653e5d2 100644
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
 
@@ -959,8 +963,17 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
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
+		goto fail;
+	}
+
+	new_sock->dev = local->dev;
 	new_sock->rw = sock->rw;
 	new_sock->miux = sock->miux;
 	new_sock->nfc_protocol = sock->nfc_protocol;
@@ -1597,7 +1610,11 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	if (local == NULL)
 		return -ENOMEM;
 
-	local->dev = ndev;
+	/* Hold a reference to the device. */
+	local->dev = nfc_get_device(ndev->idx);
+	if (!local->dev)
+		return -ENODEV;
+
 	INIT_LIST_HEAD(&local->list);
 	kref_init(&local->ref);
 	mutex_init(&local->sdp_lock);
-- 
2.42.0

