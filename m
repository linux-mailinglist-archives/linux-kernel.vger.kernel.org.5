Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770747A1E50
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjIOMQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjIOMQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEF8E268A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694780111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FP0IT9D2do1i/qXeFKAhCEFBnRZ2j14dkv/qsnZwWc=;
        b=CSqrGf3WBmVVU+zExhHPCtrNwcPygnWsyTQZcR+p3wZy39B/zuOlLwwYntP3bFbq7AN2lw
        obt4a0nJTXdzerWMhjqoa4u2PgNytvIPgUXVsSijafylaZGbHLi2IyFHrd3wzycoQCzS56
        7eKs8B5WaNrY4nUVQ6CvJv7MEjm9Amk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-8J5piP9FMNK80LmhvJZ_Sw-1; Fri, 15 Sep 2023 08:15:09 -0400
X-MC-Unique: 8J5piP9FMNK80LmhvJZ_Sw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31f79595669so1295938f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780108; x=1695384908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FP0IT9D2do1i/qXeFKAhCEFBnRZ2j14dkv/qsnZwWc=;
        b=BTRX7bzZznwEN9RoypsMznD61wULZ0l24pgpGSpUL17NbjbChxBJ2Z0+s+LMDthsmL
         xOaNyfln7m7n0aGI8bw0vG+kHCd3EPy76w4e8gv5Lp78HlG8IrSC4wqKQtK5P1A+ejWn
         8/d1yy0Jb+hu9u1Vv4c4XapEuM7/GQrTqqmvJYujvvdchKJs9Tk0T0i9w08724gYywhI
         ZAFuoGU2LoX9OHjQ1p4opkRs/GQwOLijp0qQHqzmbD3Vm8Qx2IfCNvW32G3Ss4onjLDa
         s4AAoeULmfQa6IYaD4cmnPVjGHRxsyPNR/MRX5SJgqqDWFkTKFort+TY0hpmxoL/9orr
         w6BQ==
X-Gm-Message-State: AOJu0Yx5GxHaitDdRZQHAbrjIn1MKK7U25zMgFiVMiPKzDV+3dBsoMma
        l2E8VoP9rktZA6A7GApjNYd5YUbj+i504dQ9+fz0J7hhRdPW3D+MQkSF+w+uog4Z8FMgf/HHQSm
        MM+G/flFeRPdZ+ZQr9zl17iK58ocUU4DXmkU=
X-Received: by 2002:adf:d202:0:b0:31f:f8a7:a26c with SMTP id j2-20020adfd202000000b0031ff8a7a26cmr619574wrh.25.1694780108275;
        Fri, 15 Sep 2023 05:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJF6T446VPfAO2MFW1Z0pgHTw0vTmbNmzAcUKmbss0UAE9W23X6m2itdgZ2I4QNcEqteZP5Q==
X-Received: by 2002:adf:d202:0:b0:31f:f8a7:a26c with SMTP id j2-20020adfd202000000b0031ff8a7a26cmr619554wrh.25.1694780107830;
        Fri, 15 Sep 2023 05:15:07 -0700 (PDT)
Received: from step1.lan ([46.222.72.72])
        by smtp.gmail.com with ESMTPSA id d6-20020adfef86000000b0031f82743e25sm4300429wro.67.2023.09.15.05.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:15:06 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Arseniy Krasnov <avkrasnov@salutedevices.com>,
        virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net-next 2/5] vsock/test: use recv_buf() in vsock_test.c
Date:   Fri, 15 Sep 2023 14:14:49 +0200
Message-ID: <20230915121452.87192-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915121452.87192-1-sgarzare@redhat.com>
References: <20230915121452.87192-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a very common pattern used in vsock_test that we can
now replace with the new recv_buf().

This allows us to reuse the code we already had to check the
actual return value and wait for all bytes to be received with
an appropriate timeout.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 104 +++++--------------------------
 1 file changed, 17 insertions(+), 87 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 90718c2fd4ea..d1dcbaeb477a 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -301,7 +301,6 @@ static void test_msg_peek_server(const struct test_opts *opts,
 	unsigned char buf_half[MSG_PEEK_BUF_LEN / 2];
 	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
 	unsigned char buf_peek[MSG_PEEK_BUF_LEN];
-	ssize_t res;
 	int fd;
 
 	if (seqpacket)
@@ -315,34 +314,16 @@ static void test_msg_peek_server(const struct test_opts *opts,
 	}
 
 	/* Peek from empty socket. */
-	res = recv(fd, buf_peek, sizeof(buf_peek), MSG_PEEK | MSG_DONTWAIT);
-	if (res != -1) {
-		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
-
-	if (errno != EAGAIN) {
-		perror("EAGAIN expected");
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK | MSG_DONTWAIT,
+		 -EAGAIN);
 
 	control_writeln("SRVREADY");
 
 	/* Peek part of data. */
-	res = recv(fd, buf_half, sizeof(buf_half), MSG_PEEK);
-	if (res != sizeof(buf_half)) {
-		fprintf(stderr, "recv(2) + MSG_PEEK, expected %zu, got %zi\n",
-			sizeof(buf_half), res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf_half, sizeof(buf_half), MSG_PEEK, sizeof(buf_half));
 
 	/* Peek whole data. */
-	res = recv(fd, buf_peek, sizeof(buf_peek), MSG_PEEK);
-	if (res != sizeof(buf_peek)) {
-		fprintf(stderr, "recv(2) + MSG_PEEK, expected %zu, got %zi\n",
-			sizeof(buf_peek), res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK, sizeof(buf_peek));
 
 	/* Compare partial and full peek. */
 	if (memcmp(buf_half, buf_peek, sizeof(buf_half))) {
@@ -355,22 +336,11 @@ static void test_msg_peek_server(const struct test_opts *opts,
 		 * so check it with MSG_PEEK. We must get length
 		 * of the message.
 		 */
-		res = recv(fd, buf_half, sizeof(buf_half), MSG_PEEK |
-			   MSG_TRUNC);
-		if (res != sizeof(buf_peek)) {
-			fprintf(stderr,
-				"recv(2) + MSG_PEEK | MSG_TRUNC, exp %zu, got %zi\n",
-				sizeof(buf_half), res);
-			exit(EXIT_FAILURE);
-		}
+		recv_buf(fd, buf_half, sizeof(buf_half), MSG_PEEK | MSG_TRUNC,
+			 sizeof(buf_peek));
 	}
 
-	res = recv(fd, buf_normal, sizeof(buf_normal), 0);
-	if (res != sizeof(buf_normal)) {
-		fprintf(stderr, "recv(2), expected %zu, got %zi\n",
-			sizeof(buf_normal), res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf_normal, sizeof(buf_normal), 0, sizeof(buf_normal));
 
 	/* Compare full peek and normal read. */
 	if (memcmp(buf_peek, buf_normal, sizeof(buf_peek))) {
@@ -900,7 +870,6 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
 	char buf[RCVLOWAT_BUF_SIZE];
 	struct pollfd fds;
-	ssize_t read_res;
 	short poll_flags;
 	int fd;
 
@@ -955,12 +924,7 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 	/* Use MSG_DONTWAIT, if call is going to wait, EAGAIN
 	 * will be returned.
 	 */
-	read_res = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
-	if (read_res != RCVLOWAT_BUF_SIZE) {
-		fprintf(stderr, "Unexpected recv result %zi\n",
-			read_res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf, sizeof(buf), MSG_DONTWAIT, RCVLOWAT_BUF_SIZE);
 
 	control_writeln("POLLDONE");
 
@@ -972,7 +936,7 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 static void test_inv_buf_client(const struct test_opts *opts, bool stream)
 {
 	unsigned char data[INV_BUF_TEST_DATA_LEN] = {0};
-	ssize_t ret;
+	ssize_t expected_ret;
 	int fd;
 
 	if (stream)
@@ -988,39 +952,18 @@ static void test_inv_buf_client(const struct test_opts *opts, bool stream)
 	control_expectln("SENDDONE");
 
 	/* Use invalid buffer here. */
-	ret = recv(fd, NULL, sizeof(data), 0);
-	if (ret != -1) {
-		fprintf(stderr, "expected recv(2) failure, got %zi\n", ret);
-		exit(EXIT_FAILURE);
-	}
-
-	if (errno != EFAULT) {
-		fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
-		exit(EXIT_FAILURE);
-	}
-
-	ret = recv(fd, data, sizeof(data), MSG_DONTWAIT);
+	recv_buf(fd, NULL, sizeof(data), 0, -EFAULT);
 
 	if (stream) {
 		/* For SOCK_STREAM we must continue reading. */
-		if (ret != sizeof(data)) {
-			fprintf(stderr, "expected recv(2) success, got %zi\n", ret);
-			exit(EXIT_FAILURE);
-		}
-		/* Don't check errno in case of success. */
+		expected_ret = sizeof(data);
 	} else {
 		/* For SOCK_SEQPACKET socket's queue must be empty. */
-		if (ret != -1) {
-			fprintf(stderr, "expected recv(2) failure, got %zi\n", ret);
-			exit(EXIT_FAILURE);
-		}
-
-		if (errno != EAGAIN) {
-			fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
-			exit(EXIT_FAILURE);
-		}
+		expected_ret = -EAGAIN;
 	}
 
+	recv_buf(fd, data, sizeof(data), MSG_DONTWAIT, expected_ret);
+
 	control_writeln("DONE");
 
 	close(fd);
@@ -1117,7 +1060,6 @@ static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
 static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 {
 	unsigned char buf[64];
-	ssize_t res;
 	int fd;
 
 	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
@@ -1129,26 +1071,14 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 	control_expectln("SEND0");
 
 	/* Read skbuff partially. */
-	res = recv(fd, buf, 2, 0);
-	if (res != 2) {
-		fprintf(stderr, "expected recv(2) returns 2 bytes, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf, 2, 0, 2);
 
 	control_writeln("REPLY0");
 	control_expectln("SEND1");
 
-	res = recv(fd, buf + 2, sizeof(buf) - 2, 0);
-	if (res != 8) {
-		fprintf(stderr, "expected recv(2) returns 8 bytes, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf + 2, 8, 0, 8);
 
-	res = recv(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT);
-	if (res != -1) {
-		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT, -EAGAIN);
 
 	if (memcmp(buf, HELLO_STR WORLD_STR, strlen(HELLO_STR WORLD_STR))) {
 		fprintf(stderr, "pattern mismatch\n");
-- 
2.41.0

