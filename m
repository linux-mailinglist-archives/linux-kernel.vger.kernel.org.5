Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A88A7A1E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjIOMQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjIOMQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:16:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DD9F2715
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694780129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4IzPTIpBjDzBGvsyRo0gBVOG837dBZudcrNhelcBAVs=;
        b=dfvMqVfyvQ0j6+M3Q7eswFMUxV/FXBnVNAmiIBTTC/soC7XJegtOsAmbNCV6rTbYL7crDN
        WysCkwFDGwOvKVYeGn1HzZtU0mUl1+t38bJZXE/2PmXN/CECsAALpVGwLt4BwlCJK/QbnZ
        Ukq+92JbGeLiyuiFNOk2EXvC0xtCr2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-uq9ypopcOkSRoyDePEM61A-1; Fri, 15 Sep 2023 08:15:26 -0400
X-MC-Unique: uq9ypopcOkSRoyDePEM61A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so15413495e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780125; x=1695384925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IzPTIpBjDzBGvsyRo0gBVOG837dBZudcrNhelcBAVs=;
        b=TrsViEo0cxSrsQzW1qY9GTyiYzXlI0smWdUziSPvU8V3HpwVbOu4RqDhvjo0LL9F6E
         5s/MK9duewX7tn9AWdzpdevce10sP/DFuscjESSCG5tgY+fbqOocrWp2ERg4m2ZlN5YN
         p7Iy14uoPDe3sq3V6lFn5b0rTAYxrKO9EUXsY0fLv0bdly7gBpL5B2BMrRfEJ3gysTap
         pIjjAA2bKDDkJDzkk7Ks4EJ46a23O/P/NkaAppp8yYol0YuTl1H1PQeID2zG0o4Glipa
         SfVwM70GQv/2p0Gmpa/C9l3krqqF0pB8NXbtfmoQfm58AiV8Jzsvn6kvt7OqJKmNWFMc
         9wfA==
X-Gm-Message-State: AOJu0YyVBJbMAMxd7rfhKr0ARjqbA21MDfEbxPXZZC+ERFlk9JFZKbLm
        2uAzolly5FPi+mHCB2dcZbynACiXd7GZyNGFD1W8M9DkbQnIyw/isA7rZPLZl9NdcGxxCahkeFX
        bnOvg93xQx0drzKARtfLbV31x
X-Received: by 2002:adf:cd08:0:b0:31f:afeb:4e71 with SMTP id w8-20020adfcd08000000b0031fafeb4e71mr1327904wrm.48.1694780124841;
        Fri, 15 Sep 2023 05:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAM+qT8oGEefSDmkyANZPTMrHB/rc6Va9KYPc9DtRjeZCpejNAvp5rpxARReDs63NX0XPsvQ==
X-Received: by 2002:adf:cd08:0:b0:31f:afeb:4e71 with SMTP id w8-20020adfcd08000000b0031fafeb4e71mr1327892wrm.48.1694780124604;
        Fri, 15 Sep 2023 05:15:24 -0700 (PDT)
Received: from step1.lan ([46.222.72.72])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4ec1000000b0031fbbe347e1sm4287767wrv.65.2023.09.15.05.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:15:23 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Arseniy Krasnov <avkrasnov@salutedevices.com>,
        virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net-next 5/5] vsock/test: track bytes in MSG_PEEK test for SOCK_SEQPACKET
Date:   Fri, 15 Sep 2023 14:14:52 +0200
Message-ID: <20230915121452.87192-6-sgarzare@redhat.com>
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

The test was a bit complicated to read.
Added variables to keep track of the bytes read and to be read
in each step. Also some comments.

The test is unchanged.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index b18acbaf92e2..5743dcae2350 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1002,6 +1002,7 @@ static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
 
 static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 {
+	size_t read = 0, to_read;
 	unsigned char buf[64];
 	int fd;
 
@@ -1014,14 +1015,21 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 	control_expectln("SEND0");
 
 	/* Read skbuff partially. */
-	recv_buf(fd, buf, 2, 0, 2);
+	to_read = 2;
+	recv_buf(fd, buf + read, to_read, 0, to_read);
+	read += to_read;
 
 	control_writeln("REPLY0");
 	control_expectln("SEND1");
 
-	recv_buf(fd, buf + 2, 8, 0, 8);
+	/* Read the rest of both buffers */
+	to_read = strlen(HELLO_STR WORLD_STR) - read;
+	recv_buf(fd, buf + read, to_read, 0, to_read);
+	read += to_read;
 
-	recv_buf(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT, -EAGAIN);
+	/* No more bytes should be there */
+	to_read = sizeof(buf) - read;
+	recv_buf(fd, buf + read, to_read, MSG_DONTWAIT, -EAGAIN);
 
 	if (memcmp(buf, HELLO_STR WORLD_STR, strlen(HELLO_STR WORLD_STR))) {
 		fprintf(stderr, "pattern mismatch\n");
-- 
2.41.0

