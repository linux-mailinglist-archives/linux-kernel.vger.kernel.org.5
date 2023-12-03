Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AF1802636
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 19:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjLCSWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 13:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjLCSWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 13:22:31 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B96EA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 10:22:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701627744; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Fw7k7UJwknaw7oRn3rgQwZ0Xwok4RCDstVXQeB9ZmoxabJGvQLGwB6ZBmLm5GhvOTi8hee9gEU+PeaM6OgK3ehLxvLXOHD8igdL0qkJ4WJR/QS9fHZzmWWM2rH2Vptycht4uFF89SWgWTBOEkCH4o6Wj9hXSrcn78Y3KN5jJDwM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1701627744; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=he8+CQnFdhRGU96QfM/CG8zus2XOa0vQnyKBNkZ1cY0=; 
        b=AWKctc7jRKGxqUBPXWGGmG3hC4oFjVodFX2EAH4blciSPpLpJhr/Z1YCxV9mkoy6nhu0UK2vJxmylqFU2UNWKtOmHSATJ/ZQabZm5X8AWKarHRlijS4cbgab5mZXMiNwnGT1VeYp87hkJF93AsBexAwz+FmmavLcfwqM0RZqGqk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701627744;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=he8+CQnFdhRGU96QfM/CG8zus2XOa0vQnyKBNkZ1cY0=;
        b=Ouxf1P7Zvt92PHWmGTh6hfX+uDVUhXdy1SSIuLEeeR4CAAsYt+5X/QB3eNiv9mHP
        WkMvotfvb2LcBSLhfELUFm3o8QYtkSeF/tuwg0WU050UWn3eXtyL2Q9on/0+O4fmLWH
        jodDtzH+JID9JkF0KHvTKlQyCfeiZftxQLeiWBzA=
Received: from [192.168.1.12] (122.170.35.155 [122.170.35.155]) by mx.zoho.in
        with SMTPS id 1701627743346100.15525689527851; Sun, 3 Dec 2023 23:52:23 +0530 (IST)
Message-ID: <6b24a73f-095b-462c-8354-1cb606ea2f1d@siddh.me>
Date:   Sun, 3 Dec 2023 23:52:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000cb112e0609b419d3@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in
 nfc_alloc_send_skb
Content-Language: en-US, en-GB, hi-IN
From:   Siddh Raman Pant <code@siddh.me>
In-Reply-To: <000000000000cb112e0609b419d3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main

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

