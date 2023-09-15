Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747237A1E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjIOMQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjIOMQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9CFA2120
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694780130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMEGvb3Sq84IyOhcCt8lUx9+cduXmZG2jRi2oEjFcn4=;
        b=iA1eWIA2fj6SuWECU7ptV+aGgKp+3Vv16bl2SpKy9BjdhArOaoLlypBtBmYlEE8dX76zJn
        /UFLqK10oAIMYqBVwecYgg+H8oKFeMWT8IzIaR17ziHUx4nF+IpzdrON63QTMEAjWN7YQB
        UA37+D8fH2lLITimCOACgpWUX+S9inw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-A1nB6_X0OH2CpuCJqZveEA-1; Fri, 15 Sep 2023 08:15:28 -0400
X-MC-Unique: A1nB6_X0OH2CpuCJqZveEA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-401c19fc097so16044085e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780127; x=1695384927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMEGvb3Sq84IyOhcCt8lUx9+cduXmZG2jRi2oEjFcn4=;
        b=NVQbkbsW9ZLcScUEdLlawwCTByLtC0u9hCeBuWL7xAqj27AcerFEWVgo6E9kKVeE4x
         ExHeP+g7UEwtWiLvjCjeYhd6b0fL6Kf1U1QofrL96nQ2l9kxdFwIhPw6aXtoWrPfaPzW
         6fIraBzAcFE9D+ho92tGnaBP+Dn5d/FK4txdwgGSz52CAjHPPZr5TRcPTdDJrUDpSHzJ
         6bWtALOaRogoLGW/SotjkBBIby7JkjQPohdnCmVwVSblp5+F+JQufgWoHraauBNIbn2T
         BxNbDMiURiZgm4/2ZjwwN4MVAMBUFQlcUk8tqyB4L4tSDpgVYvcdk28Y1P5dTx3cWjlh
         +U8w==
X-Gm-Message-State: AOJu0Ywb33QjRmrAFdtl00lWGxd/zzgocP00AaYF/JnkAMqk5imTNMIi
        /N3gLK8lOcooM8G3CvF2sjumxbUzLtC5gR7oluSginUb7wz70aWsUGBkU25bRpU/3HNmc+vKCZV
        gWvEcK8L9wPQAqml6xtE9fZBJ
X-Received: by 2002:a5d:6dcb:0:b0:31f:eb8d:4823 with SMTP id d11-20020a5d6dcb000000b0031feb8d4823mr1120364wrz.26.1694780116117;
        Fri, 15 Sep 2023 05:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmZEMz8JTAkutLT6oF8NF90vZ5bmQukR1ASa3FCQYrmpM8Mq37F3IN0p/HD9/gA/uhMXLXfw==
X-Received: by 2002:a5d:6dcb:0:b0:31f:eb8d:4823 with SMTP id d11-20020a5d6dcb000000b0031feb8d4823mr1119962wrz.26.1694780101879;
        Fri, 15 Sep 2023 05:15:01 -0700 (PDT)
Received: from step1.lan ([46.222.72.72])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d674c000000b0030ae53550f5sm4257548wrw.51.2023.09.15.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:15:00 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Arseniy Krasnov <avkrasnov@salutedevices.com>,
        virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net-next 1/5] vsock/test: add recv_buf() utility function
Date:   Fri, 15 Sep 2023 14:14:48 +0200
Message-ID: <20230915121452.87192-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915121452.87192-1-sgarzare@redhat.com>
References: <20230915121452.87192-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code of recv_byte() out in a new utility function that
can be used to receive a generic buffer.

This new function can be used when we need to receive a custom
buffer and not just a single 'A' byte.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.h |  1 +
 tools/testing/vsock/util.c | 88 +++++++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fb99208a95ea..fe31f267e67e 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -42,6 +42,7 @@ int vsock_stream_accept(unsigned int cid, unsigned int port,
 int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 			   struct sockaddr_vm *clientaddrp);
 void vsock_wait_remote_close(int fd);
+void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret);
 void send_byte(int fd, int expected_ret, int flags);
 void recv_byte(int fd, int expected_ret, int flags);
 void run_tests(const struct test_case *test_cases,
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 01b636d3039a..2826902706e8 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -211,6 +211,58 @@ int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 	return vsock_accept(cid, port, clientaddrp, SOCK_SEQPACKET);
 }
 
+/* Receive bytes in a buffer and check the return value.
+ *
+ * expected_ret:
+ *  <0 Negative errno (for testing errors)
+ *   0 End-of-file
+ *  >0 Success (bytes successfully read)
+ */
+void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
+{
+	ssize_t nread = 0;
+	ssize_t ret;
+
+	timeout_begin(TIMEOUT);
+	do {
+		ret = recv(fd, buf + nread, len - nread, flags);
+		timeout_check("recv");
+
+		if (ret == 0 || (ret < 0 && errno != EINTR))
+			break;
+
+		nread += ret;
+	} while (nread < len);
+	timeout_end();
+
+	if (expected_ret < 0) {
+		if (ret != -1) {
+			fprintf(stderr, "bogus recv(2) return value %zd (expected %zd)\n",
+				ret, expected_ret);
+			exit(EXIT_FAILURE);
+		}
+		if (errno != -expected_ret) {
+			perror("recv");
+			exit(EXIT_FAILURE);
+		}
+		return;
+	}
+
+	if (ret < 0) {
+		perror("recv");
+		exit(EXIT_FAILURE);
+	}
+
+	if (nread != expected_ret) {
+		if (ret == 0)
+			fprintf(stderr, "unexpected EOF while receiving bytes\n");
+
+		fprintf(stderr, "bogus recv(2) bytes read %zd (expected %zd)\n",
+			nread, expected_ret);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /* Transmit one byte and check the return value.
  *
  * expected_ret:
@@ -270,43 +322,9 @@ void send_byte(int fd, int expected_ret, int flags)
 void recv_byte(int fd, int expected_ret, int flags)
 {
 	uint8_t byte;
-	ssize_t nread;
-
-	timeout_begin(TIMEOUT);
-	do {
-		nread = recv(fd, &byte, sizeof(byte), flags);
-		timeout_check("read");
-	} while (nread < 0 && errno == EINTR);
-	timeout_end();
-
-	if (expected_ret < 0) {
-		if (nread != -1) {
-			fprintf(stderr, "bogus recv(2) return value %zd\n",
-				nread);
-			exit(EXIT_FAILURE);
-		}
-		if (errno != -expected_ret) {
-			perror("read");
-			exit(EXIT_FAILURE);
-		}
-		return;
-	}
 
-	if (nread < 0) {
-		perror("read");
-		exit(EXIT_FAILURE);
-	}
-	if (nread == 0) {
-		if (expected_ret == 0)
-			return;
+	recv_buf(fd, &byte, sizeof(byte), flags, expected_ret);
 
-		fprintf(stderr, "unexpected EOF while receiving byte\n");
-		exit(EXIT_FAILURE);
-	}
-	if (nread != sizeof(byte)) {
-		fprintf(stderr, "bogus recv(2) return value %zd\n", nread);
-		exit(EXIT_FAILURE);
-	}
 	if (byte != 'A') {
 		fprintf(stderr, "unexpected byte read %c\n", byte);
 		exit(EXIT_FAILURE);
-- 
2.41.0

