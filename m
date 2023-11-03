Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B39F7E07D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjKCR4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjKCR4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:56:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64689D44;
        Fri,  3 Nov 2023 10:55:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9dd98378a39so78814666b.0;
        Fri, 03 Nov 2023 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699034158; x=1699638958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sVtZKx35+w7Chro8MkeRQaBuJMC8Dm37tS6SVEgp8c=;
        b=lZj/8UPfdfCxBwFM2nTC6nxk34IYgqdtIUWLITIwsc3D803VwcJxxfj0brJGi2Cwmn
         LhrOK+d1DTdwXH+kHdGKDiUiqlXTa9SWaY4ZIXvKUyRtCk/PFS4ffX84RA1QuDjToKvF
         mNuLQbSw7Dc5Pcjz401nnGZbj+XApAsu4onuKuUK5yPxuC2Kl5CsSRLNd2ruuCxh2HAl
         0FyuPUvzOiQFcTb6SOxgrUTJApxln7swsWE/fv1JfCx3tKvtHqo+fYrEMgO+jVNZ+THb
         6Hmggg27LQDS5idsaR6STBMt6BErX2MX0aYfV7ne8vtsvV6deMfSQXd38fUZe3bjjOkk
         BAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699034158; x=1699638958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sVtZKx35+w7Chro8MkeRQaBuJMC8Dm37tS6SVEgp8c=;
        b=gKrNFp14va9HvqjLmyUjQvn820Pp6HZsAmwsfjIRO9HxlNn6iqp0AhKBFMdZDfxCUY
         yua+JhWRhtfcJ3MNQQDdAxW+RacHHp/dVMZwfy9uDVslLPRiGye0H6ytdwEecuqApbOH
         DM9aIV4Qv+9Q1dUGEai9hT2VM2lZj9D0lq+xm61dEUw3XyGH8RsKJZEdnrdfAsxdphTS
         4PKh5C51WHoIxfK5Z3o5+UTnAo5Lj3vNNIoo6yHG2KBgISO3rbFMVp+9FQgIbozZ5lqd
         iNNyt3MEDFnC5tMC1TOUg2cjbxk3/sKwVfLdF18z0MVqakJmk6elHF9SPzgkkrBWfCjQ
         sKFA==
X-Gm-Message-State: AOJu0YwwqOQGB0yE7x170XmNxi3g7yHzyeFTaTmB4m2BYekz93AvN0dB
        IP8AbTQTm8aCJa0uzcgDgqs=
X-Google-Smtp-Source: AGHT+IH8If8+KrUor2UBAKUl2OT2Ez6RViX0N4Y+caY1fkZ2T9AZtbgx2FFxCNFArBAhSaRfGzq+sA==
X-Received: by 2002:a17:906:4f96:b0:9dc:2291:d384 with SMTP id o22-20020a1709064f9600b009dc2291d384mr3312326eju.22.1699034157567;
        Fri, 03 Nov 2023 10:55:57 -0700 (PDT)
Received: from fedora.. (host-62-211-113-16.retail.telecomitalia.it. [62.211.113.16])
        by smtp.gmail.com with ESMTPSA id wj6-20020a170907050600b009ddf1a84379sm80306ejb.51.2023.11.03.10.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:55:56 -0700 (PDT)
From:   f.storniolo95@gmail.com
To:     luigi.leonardi@outlook.com, kvm@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, mst@redhat.com,
        imbrenda@linux.vnet.ibm.com, kuba@kernel.org, asias@redhat.com,
        stefanha@redhat.com, pabeni@redhat.com, sgarzare@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Filippo Storniolo <f.storniolo95@gmail.com>
Subject: [PATCH net 3/4] test/vsock: refactor vsock_accept
Date:   Fri,  3 Nov 2023 18:55:50 +0100
Message-ID: <20231103175551.41025-4-f.storniolo95@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103175551.41025-1-f.storniolo95@gmail.com>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filippo Storniolo <f.storniolo95@gmail.com>

This is a preliminary patch to introduce SOCK_STREAM bind connect test.
vsock_accept() is split into vsock_listen() and vsock_accept().

Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
Signed-off-by: Filippo Storniolo <f.storniolo95@gmail.com>
---
 tools/testing/vsock/util.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 698b0b44a2ee..2fc96f29bdf2 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -136,11 +136,8 @@ int vsock_seqpacket_connect(unsigned int cid, unsigned int port)
 	return vsock_connect(cid, port, SOCK_SEQPACKET);
 }
 
-/* Listen on <cid, port> and return the first incoming connection.  The remote
- * address is stored to clientaddrp.  clientaddrp may be NULL.
- */
-static int vsock_accept(unsigned int cid, unsigned int port,
-			struct sockaddr_vm *clientaddrp, int type)
+/* Listen on <cid, port> and return the file descriptor. */
+static int vsock_listen(unsigned int cid, unsigned int port, int type)
 {
 	union {
 		struct sockaddr sa;
@@ -152,14 +149,7 @@ static int vsock_accept(unsigned int cid, unsigned int port,
 			.svm_cid = cid,
 		},
 	};
-	union {
-		struct sockaddr sa;
-		struct sockaddr_vm svm;
-	} clientaddr;
-	socklen_t clientaddr_len = sizeof(clientaddr.svm);
 	int fd;
-	int client_fd;
-	int old_errno;
 
 	fd = socket(AF_VSOCK, type, 0);
 	if (fd < 0) {
@@ -177,6 +167,24 @@ static int vsock_accept(unsigned int cid, unsigned int port,
 		exit(EXIT_FAILURE);
 	}
 
+	return fd;
+}
+
+/* Listen on <cid, port> and return the first incoming connection.  The remote
+ * address is stored to clientaddrp.  clientaddrp may be NULL.
+ */
+static int vsock_accept(unsigned int cid, unsigned int port,
+			struct sockaddr_vm *clientaddrp, int type)
+{
+	union {
+		struct sockaddr sa;
+		struct sockaddr_vm svm;
+	} clientaddr;
+	socklen_t clientaddr_len = sizeof(clientaddr.svm);
+	int fd, client_fd, old_errno;
+
+	fd = vsock_listen(cid, port, type);
+
 	control_writeln("LISTENING");
 
 	timeout_begin(TIMEOUT);
-- 
2.41.0

