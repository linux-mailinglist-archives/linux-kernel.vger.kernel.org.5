Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480227E1EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjKFKtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:49:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF37AD8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 02:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699267712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AY8KQ4dvEPvqonuERioJ87ft9Eic3IHQdrVBtrNqSWo=;
        b=H9XLn04bE9N2jLDSw4oU8RZPenF+OREAJG2qTal0kHXsg3NkrNiGWm3I3zdmYMykPJtW2g
        bCvZfDDZavMUeJQoRkccCasOiWF/xYoDyjzOn8LI46Nr0AOpE6zmSDPSx0ZDYnIo6xXOos
        CucjpHDRkjCGEjrwsJtwTr8ZyEy1i8k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-QvL3ldHvNqGBKz1wS6EUKw-1; Mon, 06 Nov 2023 05:48:30 -0500
X-MC-Unique: QvL3ldHvNqGBKz1wS6EUKw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-670b32845a7so51533936d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 02:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699267710; x=1699872510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AY8KQ4dvEPvqonuERioJ87ft9Eic3IHQdrVBtrNqSWo=;
        b=nUZfk7NrwGwuTf4BSlFhSLPjqGA1s4s4dGA6Cf+1GAtgJOdfGINz3c83nCtOim0QUO
         wo5iRbn2jBGISSvinrxosqicagZxjoBDv330ZlLX0BD3dw/WsJY5e0SOY3TT2yu3Dzmz
         fTlHwXI1l8ZGAqVb3VNQlYI0PwZPnIF3OHIGsLAlZ0YB0G+oXN+d39SXtkGlP2GJDKSP
         vEo6KgGzsEuaMJp7YzS3ouqIjjj2rCmTvFsdmS0t/ffE5j+xAHJEfy/CjprpTec9gKHw
         PVhcUVS40jh69YbualifFHGZAFewK2wiWOHngMKtz24UEWMO4Ncj2qJslNqDVSFxcy9j
         D4zA==
X-Gm-Message-State: AOJu0YyCyHKqjEQtfZ5xGfXPYbL/2MOuVAm5I7CbR5QLX/HgC1wQbj0Z
        0R6hiJOamNHrj40UQ0+8vpSYPqmIytI+vsN8SuSOYwLF+MUcVDCc0qud6aOvXzMXDDgrwteu+f6
        AvRl3zioHf3npbeEkAkDyXwmH
X-Received: by 2002:a05:6214:1bc6:b0:671:c324:9f45 with SMTP id m6-20020a0562141bc600b00671c3249f45mr26686704qvc.37.1699267709721;
        Mon, 06 Nov 2023 02:48:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSWODpMGqUx3V+1IHlXcJNCdjNt6jKwKZosYLRGIC47MezPBYolbbHK/PWFX0kgd39uUHuxA==
X-Received: by 2002:a05:6214:1bc6:b0:671:c324:9f45 with SMTP id m6-20020a0562141bc600b00671c3249f45mr26686691qvc.37.1699267709389;
        Mon, 06 Nov 2023 02:48:29 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
        by smtp.gmail.com with ESMTPSA id u5-20020a0cea45000000b00670bd5a3720sm3334051qvp.97.2023.11.06.02.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 02:48:29 -0800 (PST)
Date:   Mon, 6 Nov 2023 11:48:23 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     f.storniolo95@gmail.com
Cc:     luigi.leonardi@outlook.com, kvm@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, mst@redhat.com,
        imbrenda@linux.vnet.ibm.com, kuba@kernel.org, asias@redhat.com,
        stefanha@redhat.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net 4/4] test/vsock: add dobule bind connect test
Message-ID: <65r6y2wdx3grj6ofsat2c2rpqwijvnfni2yxsbwnr6vcjalbpt@5rh46vj2dbcc>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
 <20231103175551.41025-5-f.storniolo95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231103175551.41025-5-f.storniolo95@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 06:55:51PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>This add bind connect test which creates a listening server socket
>and tries to connect a client with a bound local port to it twice.
>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Filippo Storniolo <f.storniolo95@gmail.com>
>---
> tools/testing/vsock/util.c       | 47 ++++++++++++++++++++++++++++++
> tools/testing/vsock/util.h       |  3 ++
> tools/testing/vsock/vsock_test.c | 50 ++++++++++++++++++++++++++++++++
> 3 files changed, 100 insertions(+)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 2fc96f29bdf2..ae2b33c21c45 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -85,6 +85,48 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>+/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
>+int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
>+{
>+	struct sockaddr_vm sa_client = {
>+		.svm_family = AF_VSOCK,
>+		.svm_cid = VMADDR_CID_ANY,
>+		.svm_port = bind_port,
>+	};
>+	struct sockaddr_vm sa_server = {
>+		.svm_family = AF_VSOCK,
>+		.svm_cid = cid,
>+		.svm_port = port,
>+	};
>+
>+	int client_fd, ret;
>+
>+	client_fd = socket(AF_VSOCK, type, 0);
>+	if (client_fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (bind(client_fd, (struct sockaddr *)&sa_client, sizeof(sa_client))) {
>+		perror("bind");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	timeout_begin(TIMEOUT);
>+	do {
>+		ret = connect(client_fd, (struct sockaddr *)&sa_server, sizeof(sa_server));
>+		timeout_check("connect");
>+	} while (ret < 0 && errno == EINTR);
>+	timeout_end();
>+
>+	if (ret < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	return client_fd;
>+}
>+
> /* Connect to <cid, port> and return the file descriptor. */
> static int vsock_connect(unsigned int cid, unsigned int port, int type)
> {
>@@ -223,6 +265,11 @@ int vsock_stream_accept(unsigned int cid, unsigned int port,
> 	return vsock_accept(cid, port, clientaddrp, SOCK_STREAM);
> }
>
>+int vsock_stream_listen(unsigned int cid, unsigned int port)
>+{
>+	return vsock_listen(cid, port, SOCK_STREAM);
>+}
>+
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp)
> {
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index a77175d25864..03c88d0cb861 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -36,9 +36,12 @@ struct test_case {
> void init_signals(void);
> unsigned int parse_cid(const char *str);
> int vsock_stream_connect(unsigned int cid, unsigned int port);
>+int vsock_bind_connect(unsigned int cid, unsigned int port,
>+		       unsigned int bind_port, int type);
> int vsock_seqpacket_connect(unsigned int cid, unsigned int port);
> int vsock_stream_accept(unsigned int cid, unsigned int port,
> 			struct sockaddr_vm *clientaddrp);
>+int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index c1f7bc9abd22..5b0e93f9996c 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1180,6 +1180,51 @@ static void test_stream_shutrd_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+static void test_double_bind_connect_server(const struct test_opts *opts)
>+{
>+	int listen_fd, client_fd, i;
>+	struct sockaddr_vm sa_client;
>+	socklen_t socklen_client = sizeof(sa_client);
>+
>+	listen_fd = vsock_stream_listen(VMADDR_CID_ANY, 1234);
>+
>+	for (i = 0; i < 2; i++) {
>+		control_writeln("LISTENING");
>+
>+		timeout_begin(TIMEOUT);
>+		do {
>+			client_fd = accept(listen_fd, (struct sockaddr *)&sa_client,
>+					   &socklen_client);
>+			timeout_check("accept");
>+		} while (client_fd < 0 && errno == EINTR);
>+		timeout_end();
>+
>+		if (client_fd < 0) {
>+			perror("accept");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		/* Waiting for remote peer to close connection */
>+		vsock_wait_remote_close(client_fd);
>+	}
>+
>+	close(listen_fd);
>+}
>+
>+static void test_double_bind_connect_client(const struct test_opts *opts)
>+{
>+	int i, client_fd;
>+
>+	for (i = 0; i < 2; i++) {
>+		/* Wait until server is ready to accept a new connection */
>+		control_expectln("LISTENING");
>+
>+		client_fd = vsock_bind_connect(opts->peer_cid, 1234, 4321, SOCK_STREAM);
>+
>+		close(client_fd);
>+	}
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1285,6 +1330,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_msgzcopy_empty_errq_client,
> 		.run_server = test_stream_msgzcopy_empty_errq_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM double bind connect",
>+		.run_client = test_double_bind_connect_client,
>+		.run_server = test_double_bind_connect_server,
>+	},
> 	{},
> };
>
>-- 
>2.41.0
>

