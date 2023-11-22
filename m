Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599A77F4EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbjKVSNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjKVSNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:13:15 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD8FF9;
        Wed, 22 Nov 2023 10:13:10 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 14EB112006F;
        Wed, 22 Nov 2023 21:13:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 14EB112006F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700676786;
        bh=vL+qQ9rhbaR3YIaKSe6iD2hKBiaKdxLdqmIkkNYOJUg=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=Vf6nTi3WL903bejvUiRrGEeuSUznz0hTUBw0sovSH1vl02IKcIGaEKMSli5blwTD3
         Xy5wo5LvVouc6Ys8UYtMJfAFdO0oqZStLxKg5Z8VWe+DijeLVcuR0lCu9Z8ocL3JWh
         X5fb71GCyMrRULAUS4xcgM06MOCQiu5GHyO0Q83Bszd5yH46TJZbIf/o4XAc81RzVi
         WYeYiAeiuoJxZxyXwAkUnqRdlchE5AA8DO3/M8mArCSmgmoL0gnmOjzaayywwl9ezp
         IL9HzBelu50cm/n32A75aVtrllt7oUT3TbilUHP7xpGzLuRrqTXaVElmTcstsiO+YT
         2Uv6kDh4HpPdA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 22 Nov 2023 21:13:05 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 21:13:05 +0300
From:   Arseniy Krasnov <avkrasnov@salutedevices.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
CC:     <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <oxffffaa@gmail.com>,
        <avkrasnov@salutedevices.com>
Subject: [RFC PATCH v3 1/3] vsock: update SO_RCVLOWAT setting callback
Date:   Wed, 22 Nov 2023 21:05:08 +0300
Message-ID: <20231122180510.2297075-2-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20231122180510.2297075-1-avkrasnov@salutedevices.com>
References: <20231122180510.2297075-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181545 [Nov 22 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/22 11:24:00 #22501433
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not return if transport callback for SO_RCVLOWAT is set (only in
error case). In this case we don't need to set 'sk_rcvlowat' field in
each transport - only in 'vsock_set_rcvlowat()'.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 net/vmw_vsock/af_vsock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 816725af281f..af0058037f72 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2264,8 +2264,13 @@ static int vsock_set_rcvlowat(struct sock *sk, int val)
 
 	transport = vsk->transport;
 
-	if (transport && transport->set_rcvlowat)
-		return transport->set_rcvlowat(vsk, val);
+	if (transport && transport->set_rcvlowat) {
+		int err;
+
+		err = transport->set_rcvlowat(vsk, val);
+		if (err)
+			return err;
+	}
 
 	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
 	return 0;
-- 
2.25.1

