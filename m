Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056247F383A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjKUVYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUVYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:24:44 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4166CDD;
        Tue, 21 Nov 2023 13:24:39 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id D216F12005A;
        Wed, 22 Nov 2023 00:24:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru D216F12005A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700601877;
        bh=u9fx6BXWHsu28OWJVt3WPYYDtH1LMdQKdP1Xw3XIl5s=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=AjInmCZV1UUpTgDFNZFOTjad3x5OnA/ZVlSCqOXc/2QSVThYwVASfDgh27Ghq1s2Q
         UErvgpmiuUp4Jj0SgmIpMRes1ox/t1O9qtuRsgP8ScHoeUgEUv5Ktq2F18Ycu1pr3g
         EFXWwrWnKkjC+a7LfNh1JYAv3njvu5MiB85xd+G5a8DwGOHZP075lAdgYSNogJ0+SF
         YKQk1x8bY5PNvVh8bpjNo0Nix56+NKXT6RdO1HFkLQ4c+hNl/tfK8l/fL4PKY38oUv
         G31/Wtw9bv2J6B31s4dyd0pPkpHg7N4CEXSD5RSbrwwrkPNU5GnLFFbxGUyTmVsdJ6
         VjEbX000XvYDQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 22 Nov 2023 00:24:37 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 00:24:37 +0300
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
Subject: [PATCH net v1] vsock/test: fix SEQPACKET message bounds test
Date:   Wed, 22 Nov 2023 00:16:42 +0300
Message-ID: <20231121211642.163474-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181514 [Nov 21 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/21 19:56:00 #22495758
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

Tune message length calculation to make this test work on machines
where 'getpagesize()' returns >32KB. Now maximum message length is not
hardcoded (on machines above it was smaller than 'getpagesize()' return
value, thus we get negative value and test fails), but calculated at
runtime and always bigger than 'getpagesize()' result. Reproduced on
aarch64 with 64KB page size.

Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 tools/testing/vsock/vsock_test.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index f5623b8d76b7..691e44c746bf 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -353,11 +353,12 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
 }
 
 #define SOCK_BUF_SIZE (2 * 1024 * 1024)
-#define MAX_MSG_SIZE (32 * 1024)
+#define MAX_MSG_PAGES 4
 
 static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 {
 	unsigned long curr_hash;
+	size_t max_msg_size;
 	int page_size;
 	int msg_count;
 	int fd;
@@ -373,7 +374,8 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 
 	curr_hash = 0;
 	page_size = getpagesize();
-	msg_count = SOCK_BUF_SIZE / MAX_MSG_SIZE;
+	max_msg_size = MAX_MSG_PAGES * page_size;
+	msg_count = SOCK_BUF_SIZE / max_msg_size;
 
 	for (int i = 0; i < msg_count; i++) {
 		size_t buf_size;
@@ -383,7 +385,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 		/* Use "small" buffers and "big" buffers. */
 		if (i & 1)
 			buf_size = page_size +
-					(rand() % (MAX_MSG_SIZE - page_size));
+					(rand() % (max_msg_size - page_size));
 		else
 			buf_size = 1 + (rand() % page_size);
 
@@ -429,7 +431,6 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 	unsigned long remote_hash;
 	unsigned long curr_hash;
 	int fd;
-	char buf[MAX_MSG_SIZE];
 	struct msghdr msg = {0};
 	struct iovec iov = {0};
 
@@ -457,8 +458,13 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 	control_writeln("SRVREADY");
 	/* Wait, until peer sends whole data. */
 	control_expectln("SENDDONE");
-	iov.iov_base = buf;
-	iov.iov_len = sizeof(buf);
+	iov.iov_len = MAX_MSG_PAGES * getpagesize();
+	iov.iov_base = malloc(iov.iov_len);
+	if (!iov.iov_base) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+
 	msg.msg_iov = &iov;
 	msg.msg_iovlen = 1;
 
@@ -483,6 +489,7 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 		curr_hash += hash_djb2(msg.msg_iov[0].iov_base, recv_size);
 	}
 
+	free(iov.iov_base);
 	close(fd);
 	remote_hash = control_readulong();
 
-- 
2.25.1

