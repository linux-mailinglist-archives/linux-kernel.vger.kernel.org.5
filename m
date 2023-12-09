Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBB580B36E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 10:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjLIJ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 04:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIJ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 04:27:15 -0500
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A59B1A1;
        Sat,  9 Dec 2023 01:27:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702114030; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=c4EPJskWDNc3xa89EkEHx6QoCE59/qC470swWT/Eb/hfEXWL/QFCATp3EsdeOpFEaS/4fDl9tjql2+Zi0iZ44BzggDldqKvlK6Uc2z+NJvtxWexMMAV6zUb5/SGBn/c0JAky7lt7X2keTxVLQvI3vjyMUYKgOHhP+BprhkbfE/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1702114030; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=9HifBpJc5qMXAFdtxZd4YRtuBh2XKnXg7W7+1B+UIHk=; 
        b=NxyfT1MOLDabvesW0fyORNyeulsyiEVF0/5zlITUiOLKYvh1YeraV9dn9nZc3YNgLxy1tco+Ic4LLvepfNlP97NEpfQL7XI4Le7KgG4+heNBPWCYHh1Qdjqxoykv2RFS43ievf1bauR8Onsl5s2EjD55t16o69itm1hholEDSRo=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702114030;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=9HifBpJc5qMXAFdtxZd4YRtuBh2XKnXg7W7+1B+UIHk=;
        b=JAwJECmpxynQp4r0Y6oOA5IYCQs0OI/CNGRfldpkA21wFrFyC7HohqaRxFFiXbUK
        WlYwOsiqqW1crsg8s4IILM2lwo0ZvI3jRikuxiRdQWJ/6/OsuQhNbxqCp5YPE/GKhZC
        vzNXD+/jRK7ty6bW2wKThbNpkPSNvuHgUQVmj0K4=
Received: from [192.168.1.12] (110.227.243.208 [110.227.243.208]) by mx.zoho.in
        with SMTPS id 1702114029175807.7530028703645; Sat, 9 Dec 2023 14:57:09 +0530 (IST)
Message-ID: <3753ec68-b5e3-40f7-8abe-6e4c737fa5f7@siddh.me>
Date:   Sat, 9 Dec 2023 14:57:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

