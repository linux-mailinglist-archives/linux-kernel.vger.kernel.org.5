Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9497380F545
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377076AbjLLSLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjLLSL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:11:28 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA7EBD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:11:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702404685; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=aB1GS5ER43ugiCtXrlRzmJ14CP25jy1HU+JUvbjVCXLd/vb17LXHbkHdO1J78MwqLxCWgNc4h9NLPko0WfEj0BWIpPWPL2ROvUdkwRCLg3s156DIFiP5YNjpijdaU6G5eVAv58huJ0KCF2df/iPzwgUxzG5NaTAJbmpvs+nDVpQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1702404685; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=CdVFAutf16HunPP4VGxIvYXTf6+XNrdgytRbuVIRwvE=; 
        b=InDKLhjWaQ1/C7/Ljt9nOux3cAcxhaAqBvkj0ZU1i5oAkey5QrI34uX4faKBfKKag0u+pXAncGGs264EHbea4fn3rRChrlJGTeSYYgSSeURdNsi46WgSZI62kFcp/ipHFKipczAzzXcU3RXzdXixc50bgAcY9smD8b+R9iv4GOg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702404685;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=CdVFAutf16HunPP4VGxIvYXTf6+XNrdgytRbuVIRwvE=;
        b=gR59eeze9bRlhyIs6mtzmz/eCluIIsJK5kn7dZMt7/CG1sGqZPmLCt1Zez5TdriU
        xVGxgyiM9iE/5j2yzR3IMRF9Zrp9dg5r65NMq8YRCNEAIIKpXEAn6ZQwjZ6+RFhC/7C
        oIfgLWHgrBlNne0+hVqtgL4ydWlPySzAe+cliozA=
Received: from [192.168.1.12] (182.69.31.144 [182.69.31.144]) by mx.zoho.in
        with SMTPS id 1702404684363952.426048869551; Tue, 12 Dec 2023 23:41:24 +0530 (IST)
Message-ID: <66e9ef2c-baba-4484-be9d-4abbb930a7bf@siddh.me>
Date:   Tue, 12 Dec 2023 23:41:21 +0530
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

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

