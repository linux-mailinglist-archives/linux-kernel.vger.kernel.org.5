Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5AD7A1E51
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjIOMQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjIOMQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B7DD271C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694780116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Wsy1q2POvkf/slH3ci56G5sHfd/fayJdujAf9EVUnI=;
        b=WiyevuVOD9kARfYqkbi9WXhcOMBBx6xWZYKCq2umtAFN7W0iqe7/muSmn9c2kMq+dUZYHO
        VfsQfmq7rIFsJrOn2/Wfa+ul3Dk232/5qLur/1jxSU6AT1SGzUN3s6O9r0Ow10xs4MnCGi
        WUoixHS1NmgKzR/xubs3tDuWck1mIo0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-eKCSCtAvMO611vH_W1oMoQ-1; Fri, 15 Sep 2023 08:15:15 -0400
X-MC-Unique: eKCSCtAvMO611vH_W1oMoQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-402d1892cecso9706265e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780114; x=1695384914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Wsy1q2POvkf/slH3ci56G5sHfd/fayJdujAf9EVUnI=;
        b=gBOT/W29Bm4cShH4/LMNw59IeTkfr+Jts57Et0ykL8NAYhj/N8ALEdG9sQiwC/UZ6u
         uDqTtV97pMruG+j83p9+eek56uAh5XeZP7SBJLmjCaAsbLVEwTwVLKjgKwmP70xsP8o1
         NYHan2NrIk/3jA+08q5Wgf2fIcIQZHJfKK/leY5Yn1y2xN3/5q4e9E280WL2EuUPU8Ei
         vWgWJDUqtv6hciVki8wKc8tv5z/RUmTsGRnnUO5txUXJBoEm1hB64VNyNA1dLj6dqnmg
         nN2tsLgOlBL7tZwvaErsyBJip3j+ZB6ObuX8RXtmr+rrHBtSlohjBEOUQ1T1GxlCakh8
         5e0A==
X-Gm-Message-State: AOJu0YyO4ZF1LCVCkJajyGsV3u13uNygGFXN/MM17h97gqI4iyVIvJco
        FLq+EzDry1pQ4/4YQKcFbEgR7QyVPqmARZeNFOHS/au4PUmxyibYSfRF0LxPw8PjSvVhSaXd3w4
        RMZfnBmFB4smLq6B+3wnxrxGxmngOJWyNV/A=
X-Received: by 2002:a05:600c:1914:b0:401:bcec:be3e with SMTP id j20-20020a05600c191400b00401bcecbe3emr3493380wmq.17.1694780113966;
        Fri, 15 Sep 2023 05:15:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF80cLLN3KCVixXwI3Sp+oFXdhCzhUU59hAIcQenPXVtkDPh17T7T+QOc2QolC6Hazp8647uA==
X-Received: by 2002:a05:600c:1914:b0:401:bcec:be3e with SMTP id j20-20020a05600c191400b00401bcecbe3emr3493366wmq.17.1694780113612;
        Fri, 15 Sep 2023 05:15:13 -0700 (PDT)
Received: from step1.lan ([46.222.72.72])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c214d00b00401dc20a070sm7346864wml.43.2023.09.15.05.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:15:12 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Arseniy Krasnov <avkrasnov@salutedevices.com>,
        virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net-next 3/5] vsock/test: add send_buf() utility function
Date:   Fri, 15 Sep 2023 14:14:50 +0200
Message-ID: <20230915121452.87192-4-sgarzare@redhat.com>
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

Move the code of send_byte() out in a new utility function that
can be used to send a generic buffer.

This new function can be used when we need to send a custom
buffer and not just a single 'A' byte.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.h |  2 +
 tools/testing/vsock/util.c | 90 +++++++++++++++++++++++---------------
 2 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fe31f267e67e..e5407677ce05 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -42,6 +42,8 @@ int vsock_stream_accept(unsigned int cid, unsigned int port,
 int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 			   struct sockaddr_vm *clientaddrp);
 void vsock_wait_remote_close(int fd);
+void send_buf(int fd, const void *buf, size_t len, int flags,
+	      ssize_t expected_ret);
 void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret);
 void send_byte(int fd, int expected_ret, int flags);
 void recv_byte(int fd, int expected_ret, int flags);
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 2826902706e8..6779d5008b27 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -211,6 +211,59 @@ int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 	return vsock_accept(cid, port, clientaddrp, SOCK_SEQPACKET);
 }
 
+/* Transmit bytes from a buffer and check the return value.
+ *
+ * expected_ret:
+ *  <0 Negative errno (for testing errors)
+ *   0 End-of-file
+ *  >0 Success (bytes successfully written)
+ */
+void send_buf(int fd, const void *buf, size_t len, int flags,
+	      ssize_t expected_ret)
+{
+	ssize_t nwritten = 0;
+	ssize_t ret;
+
+	timeout_begin(TIMEOUT);
+	do {
+		ret = send(fd, buf + nwritten, len - nwritten, flags);
+		timeout_check("send");
+
+		if (ret == 0 || (ret < 0 && errno != EINTR))
+			break;
+
+		nwritten += ret;
+	} while (nwritten < len);
+	timeout_end();
+
+	if (expected_ret < 0) {
+		if (ret != -1) {
+			fprintf(stderr, "bogus send(2) return value %zd (expected %zd)\n",
+				ret, expected_ret);
+			exit(EXIT_FAILURE);
+		}
+		if (errno != -expected_ret) {
+			perror("send");
+			exit(EXIT_FAILURE);
+		}
+		return;
+	}
+
+	if (ret < 0) {
+		perror("send");
+		exit(EXIT_FAILURE);
+	}
+
+	if (nwritten != expected_ret) {
+		if (ret == 0)
+			fprintf(stderr, "unexpected EOF while sending bytes\n");
+
+		fprintf(stderr, "bogus send(2) bytes written %zd (expected %zd)\n",
+			nwritten, expected_ret);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /* Receive bytes in a buffer and check the return value.
  *
  * expected_ret:
@@ -273,43 +326,8 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
 void send_byte(int fd, int expected_ret, int flags)
 {
 	const uint8_t byte = 'A';
-	ssize_t nwritten;
-
-	timeout_begin(TIMEOUT);
-	do {
-		nwritten = send(fd, &byte, sizeof(byte), flags);
-		timeout_check("write");
-	} while (nwritten < 0 && errno == EINTR);
-	timeout_end();
-
-	if (expected_ret < 0) {
-		if (nwritten != -1) {
-			fprintf(stderr, "bogus send(2) return value %zd\n",
-				nwritten);
-			exit(EXIT_FAILURE);
-		}
-		if (errno != -expected_ret) {
-			perror("write");
-			exit(EXIT_FAILURE);
-		}
-		return;
-	}
 
-	if (nwritten < 0) {
-		perror("write");
-		exit(EXIT_FAILURE);
-	}
-	if (nwritten == 0) {
-		if (expected_ret == 0)
-			return;
-
-		fprintf(stderr, "unexpected EOF while sending byte\n");
-		exit(EXIT_FAILURE);
-	}
-	if (nwritten != sizeof(byte)) {
-		fprintf(stderr, "bogus send(2) return value %zd\n", nwritten);
-		exit(EXIT_FAILURE);
-	}
+	send_buf(fd, &byte, sizeof(byte), flags, expected_ret);
 }
 
 /* Receive one byte and check the return value.
-- 
2.41.0

