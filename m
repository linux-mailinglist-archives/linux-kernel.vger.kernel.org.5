Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173157A1E56
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjIOMQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjIOMQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26216211E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694780124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GDBE00lKHk1z88MDFMXNFeObsJMvojUkDq7liDEdWcM=;
        b=EnZ5rGH0gBcplfxoNzQXlPKm1VaNa/2NVS3yrrh3a2hUeat9Hvea4s27ixL/FkSHKDflc6
        4m8Mf7SZCHQiE3MYLBo27jdIc7lBpjyDoS/U1rP+xBZYP0Dpua0zphUcmtrlr/4PzI0YO3
        0HmDVPWwpO/JrIXfN9fbKlZyfhfpKtU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-iH5mqS86PwGccXqpq59F7Q-1; Fri, 15 Sep 2023 08:15:20 -0400
X-MC-Unique: iH5mqS86PwGccXqpq59F7Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31aef28315eso1405995f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780119; x=1695384919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDBE00lKHk1z88MDFMXNFeObsJMvojUkDq7liDEdWcM=;
        b=DS7CgOz+J+VkmqgeAiOwwRVQbvqz01l3FHqUmk5DXj1WgPw2S1iAtt1W3bg8oLSFHG
         Nb3YjhXHPAyjWqY8IhAUXcr4z3/WOHh3QvZaXGN6A3GcE8BG5CUObrVWyTyV30Jyg/qX
         CC4XdS9ew6oXCk8b6bas59QTCUuIT0hy41DYfqobGtrW4Xbko6eaLKov7I5Emgd2tjXX
         wWDszZEms3HsvS4pqC6K8lajK5sP9z5fRRA0tMG+MCrR+/bR3dHhGiKXZba2RLQ3RPD/
         8ixidOHGc+1cOvEfKzrFa4uPA/boXRdrfB9sdNYnIngdWXSmQl7JfYfBDDRnsfefYZmf
         INgA==
X-Gm-Message-State: AOJu0YwYXUD2wwJJeWpgnNKKPuNu9BKytd1SBHzWu21u/83eUjYmr3tH
        O7zk4zqQduHjutOtL2bVmggxGE04o/nE9O+5g03DM7Yo7AzW/ISMzgtDLr7kvKvW7/3TGzKtQzy
        BQvKhYmQ1IXFPc+UWUz9CHOc5
X-Received: by 2002:adf:fb50:0:b0:31f:d7bb:481e with SMTP id c16-20020adffb50000000b0031fd7bb481emr1184332wrs.63.1694780119411;
        Fri, 15 Sep 2023 05:15:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeyzHuoaEGMp/jTcaIbZGY1B+QuzLExkcenZEXxgsQDgcXpE6ANREgAfuYkNjFwkxggDkAvQ==
X-Received: by 2002:adf:fb50:0:b0:31f:d7bb:481e with SMTP id c16-20020adffb50000000b0031fd7bb481emr1184319wrs.63.1694780119150;
        Fri, 15 Sep 2023 05:15:19 -0700 (PDT)
Received: from step1.lan ([46.222.72.72])
        by smtp.gmail.com with ESMTPSA id m2-20020a056000174200b0031fe9a47a87sm3054745wrf.112.2023.09.15.05.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:15:18 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Arseniy Krasnov <avkrasnov@salutedevices.com>,
        virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net-next 4/5] vsock/test: use send_buf() in vsock_test.c
Date:   Fri, 15 Sep 2023 14:14:51 +0200
Message-ID: <20230915121452.87192-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915121452.87192-1-sgarzare@redhat.com>
References: <20230915121452.87192-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a very common pattern used in vsock_test that we can
now replace with the new send_buf().

This allows us to reuse the code we already had to check the
actual return value and wait for all the bytes to be sent with
an appropriate timeout.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 75 ++++----------------------------
 1 file changed, 9 insertions(+), 66 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d1dcbaeb477a..b18acbaf92e2 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -261,7 +261,6 @@ static void test_msg_peek_client(const struct test_opts *opts,
 				 bool seqpacket)
 {
 	unsigned char buf[MSG_PEEK_BUF_LEN];
-	ssize_t send_size;
 	int fd;
 	int i;
 
@@ -280,17 +279,7 @@ static void test_msg_peek_client(const struct test_opts *opts,
 
 	control_expectln("SRVREADY");
 
-	send_size = send(fd, buf, sizeof(buf), 0);
-
-	if (send_size < 0) {
-		perror("send");
-		exit(EXIT_FAILURE);
-	}
-
-	if (send_size != sizeof(buf)) {
-		fprintf(stderr, "Invalid send size %zi\n", send_size);
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
 
 	close(fd);
 }
@@ -385,7 +374,6 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 	msg_count = SOCK_BUF_SIZE / MAX_MSG_SIZE;
 
 	for (int i = 0; i < msg_count; i++) {
-		ssize_t send_size;
 		size_t buf_size;
 		int flags;
 		void *buf;
@@ -413,17 +401,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
 			flags = 0;
 		}
 
-		send_size = send(fd, buf, buf_size, flags);
-
-		if (send_size < 0) {
-			perror("send");
-			exit(EXIT_FAILURE);
-		}
-
-		if (send_size != buf_size) {
-			fprintf(stderr, "Invalid send size\n");
-			exit(EXIT_FAILURE);
-		}
+		send_buf(fd, buf, buf_size, flags, buf_size);
 
 		/*
 		 * Hash sum is computed at both client and server in
@@ -524,10 +502,7 @@ static void test_seqpacket_msg_trunc_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
-	if (send(fd, buf, sizeof(buf), 0) != sizeof(buf)) {
-		perror("send failed");
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
 
 	control_writeln("SENDDONE");
 	close(fd);
@@ -649,7 +624,6 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
 static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
 {
 	unsigned long sock_buf_size;
-	ssize_t send_size;
 	socklen_t len;
 	void *data;
 	int fd;
@@ -676,18 +650,7 @@ static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
-	send_size = send(fd, data, sock_buf_size, 0);
-	if (send_size != -1) {
-		fprintf(stderr, "expected 'send(2)' failure, got %zi\n",
-			send_size);
-		exit(EXIT_FAILURE);
-	}
-
-	if (errno != EMSGSIZE) {
-		fprintf(stderr, "expected EMSGSIZE in 'errno', got %i\n",
-			errno);
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, data, sock_buf_size, 0, -EMSGSIZE);
 
 	control_writeln("CLISENT");
 
@@ -741,15 +704,9 @@ static void test_seqpacket_invalid_rec_buffer_client(const struct test_opts *opt
 	memset(buf1, BUF_PATTERN_1, buf_size);
 	memset(buf2, BUF_PATTERN_2, buf_size);
 
-	if (send(fd, buf1, buf_size, 0) != buf_size) {
-		perror("send failed");
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, buf1, buf_size, 0, buf_size);
 
-	if (send(fd, buf2, buf_size, 0) != buf_size) {
-		perror("send failed");
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, buf2, buf_size, 0, buf_size);
 
 	close(fd);
 }
@@ -972,7 +929,6 @@ static void test_inv_buf_client(const struct test_opts *opts, bool stream)
 static void test_inv_buf_server(const struct test_opts *opts, bool stream)
 {
 	unsigned char data[INV_BUF_TEST_DATA_LEN] = {0};
-	ssize_t res;
 	int fd;
 
 	if (stream)
@@ -985,11 +941,7 @@ static void test_inv_buf_server(const struct test_opts *opts, bool stream)
 		exit(EXIT_FAILURE);
 	}
 
-	res = send(fd, data, sizeof(data), 0);
-	if (res != sizeof(data)) {
-		fprintf(stderr, "unexpected send(2) result %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, data, sizeof(data), 0, sizeof(data));
 
 	control_writeln("SENDDONE");
 
@@ -1023,7 +975,6 @@ static void test_seqpacket_inv_buf_server(const struct test_opts *opts)
 
 static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
 {
-	ssize_t res;
 	int fd;
 
 	fd = vsock_stream_connect(opts->peer_cid, 1234);
@@ -1033,22 +984,14 @@ static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
 	}
 
 	/* Send first skbuff. */
-	res = send(fd, HELLO_STR, strlen(HELLO_STR), 0);
-	if (res != strlen(HELLO_STR)) {
-		fprintf(stderr, "unexpected send(2) result %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, HELLO_STR, strlen(HELLO_STR), 0, strlen(HELLO_STR));
 
 	control_writeln("SEND0");
 	/* Peer reads part of first skbuff. */
 	control_expectln("REPLY0");
 
 	/* Send second skbuff, it will be appended to the first. */
-	res = send(fd, WORLD_STR, strlen(WORLD_STR), 0);
-	if (res != strlen(WORLD_STR)) {
-		fprintf(stderr, "unexpected send(2) result %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, WORLD_STR, strlen(WORLD_STR), 0, strlen(WORLD_STR));
 
 	control_writeln("SEND1");
 	/* Peer reads merged skbuff packet. */
-- 
2.41.0

