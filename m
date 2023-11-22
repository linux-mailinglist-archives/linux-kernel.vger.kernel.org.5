Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A3F7F4EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbjKVSNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjKVSNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:13:15 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC0CA2;
        Wed, 22 Nov 2023 10:13:10 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id A11FC120071;
        Wed, 22 Nov 2023 21:13:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A11FC120071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700676786;
        bh=PHuX2kiU/Nw67VMyYDVUZRMzOKwEXqxibwx95TeiHrY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=qKbbYsqcVz1eJcEhXQyiURPf5mSMbm5h5oQI+sT1NLmyNPqLwKa261XpE4pm6SeoV
         XLKQ6NA314B2NC4a/cTzD9TdFctwL551mcgzudoYAaw3MUVSa/viTfsXYYOKEi3pSb
         buLKdfS5BHiHGyVvMZisk9HXAFLY/UYbT8fFtjuCIgJP35ye04xlwywE/thwwcnZXS
         Q+OY5e0MJgTjNrwoMrEY3VHHvxy034Qzfonr6hE58X1fO5ElsEeSc5GGV4q8ZUm7db
         qFkHEhoscmj2A2scwKUdVFG5VGVPqiKfJj/C6+fOUmN+7IALVUsNa4Ct9c+6gXNeNh
         zoN+mBSUk2d7g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 22 Nov 2023 21:13:06 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 21:13:06 +0300
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
Subject: [RFC PATCH v3 3/3] vsock/test: SO_RCVLOWAT + deferred credit update test
Date:   Wed, 22 Nov 2023 21:05:10 +0300
Message-ID: <20231122180510.2297075-4-avkrasnov@salutedevices.com>
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

Test which checks, that updating SO_RCVLOWAT value also sends credit
update message. Otherwise mutual hungup may happen when receiver didn't
send credit update and then calls 'poll()' with non default SO_RCVLOWAT
value (e.g. waiting enough bytes to read), while sender waits for free
space at receiver's side. Important thing is that this test relies on
kernel's define for maximum packet size for virtio transport and this
value is not exported to user: VIRTIO_VSOCK_MAX_PKT_BUF_SIZE (this
define is used to control moment when to send credit update message).
If this value or its usage will be changed in kernel - this test may
become useless/broken.

Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
---
 Changelog:
 v1 -> v2:
  * Update commit message by removing 'This patch adds XXX' manner.
  * Update commit message by adding details about dependency for this
    test from kernel internal define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
  * Add comment for this dependency in 'vsock_test.c' where this define
    is duplicated.
 v2 -> v3:
  * Replace synchronization based on control TCP socket with vsock
    data socket - this is needed to allow sender transmit data only
    when new buffer size of receiver is visible to sender. Otherwise
    there is race and test fails sometimes.

 tools/testing/vsock/vsock_test.c | 142 +++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 5b0e93f9996c..773a71260fba 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1225,6 +1225,143 @@ static void test_double_bind_connect_client(const struct test_opts *opts)
 	}
 }
 
+#define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
+/* This define is the same as in 'include/linux/virtio_vsock.h':
+ * it is used to decide when to send credit update message during
+ * reading from rx queue of a socket. Value and its usage in
+ * kernel is important for this test.
+ */
+#define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE	(1024 * 64)
+
+static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opts)
+{
+	size_t buf_size;
+	void *buf;
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, 1234);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Send 1 byte more than peer's buffer size. */
+	buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE + 1;
+
+	buf = malloc(buf_size);
+	if (!buf) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Wait until peer sets needed buffer size. */
+	recv_byte(fd, 1, 0);
+
+	if (send(fd, buf, buf_size, 0) != buf_size) {
+		perror("send failed");
+		exit(EXIT_FAILURE);
+	}
+
+	free(buf);
+	close(fd);
+}
+
+static void test_stream_rcvlowat_def_cred_upd_server(const struct test_opts *opts)
+{
+	size_t recv_buf_size;
+	struct pollfd fds;
+	size_t buf_size;
+	void *buf;
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE;
+
+	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
+		       &buf_size, sizeof(buf_size))) {
+		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Send one dummy byte here, because 'setsockopt()' above also
+	 * sends special packet which tells sender to update our buffer
+	 * size. This 'send_byte()' will serialize such packet with data
+	 * reads in a loop below. Sender starts transmission only when
+	 * it receives this single byte.
+	 */
+	send_byte(fd, 1, 0);
+
+	buf = malloc(buf_size);
+	if (!buf) {
+		perror("malloc");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Wait until there will be 128KB of data in rx queue. */
+	while (1) {
+		ssize_t res;
+
+		res = recv(fd, buf, buf_size, MSG_PEEK);
+		if (res == buf_size)
+			break;
+
+		if (res <= 0) {
+			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	/* There is 128KB of data in the socket's rx queue,
+	 * dequeue first 64KB, credit update is not sent.
+	 */
+	recv_buf_size = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
+	recv_buf(fd, buf, recv_buf_size, 0, recv_buf_size);
+	recv_buf_size++;
+
+	/* Updating SO_RCVLOWAT will send credit update. */
+	if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
+		       &recv_buf_size, sizeof(recv_buf_size))) {
+		perror("setsockopt(SO_RCVLOWAT)");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&fds, 0, sizeof(fds));
+	fds.fd = fd;
+	fds.events = POLLIN | POLLRDNORM | POLLERR |
+		     POLLRDHUP | POLLHUP;
+
+	/* This 'poll()' will return once we receive last byte
+	 * sent by client.
+	 */
+	if (poll(&fds, 1, -1) < 0) {
+		perror("poll");
+		exit(EXIT_FAILURE);
+	}
+
+	if (fds.revents & POLLERR) {
+		fprintf(stderr, "'poll()' error\n");
+		exit(EXIT_FAILURE);
+	}
+
+	if (fds.revents & (POLLIN | POLLRDNORM)) {
+		recv_buf(fd, buf, recv_buf_size, 0, recv_buf_size);
+	} else {
+		/* These flags must be set, as there is at
+		 * least 64KB of data ready to read.
+		 */
+		fprintf(stderr, "POLLIN | POLLRDNORM expected\n");
+		exit(EXIT_FAILURE);
+	}
+
+	free(buf);
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1335,6 +1472,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_double_bind_connect_client,
 		.run_server = test_double_bind_connect_server,
 	},
+	{
+		.name = "SOCK_STREAM virtio SO_RCVLOWAT + deferred cred update",
+		.run_client = test_stream_rcvlowat_def_cred_upd_client,
+		.run_server = test_stream_rcvlowat_def_cred_upd_server,
+	},
 	{},
 };
 
-- 
2.25.1

