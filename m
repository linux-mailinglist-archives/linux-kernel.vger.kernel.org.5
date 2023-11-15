Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C779B7EC11F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343572AbjKOLLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbjKOLLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:11:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEA4E1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700046671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P+9IBIN2TseVRMl8fITJ/N2WS2NwQD1vqkbQglXI4X4=;
        b=hBk0q8WC1EsTqTSJOHK8rNcLHuiY9Lmh4sLgdMJlQ3vDWRbuyb/M8tyPigUDAps8EAS1og
        fLCEBBYsuRHXcNAiO7kyvSM7w++lchlxzxpBH5auqArM+aUq9Oy9TR5VeQFCNFS8ZOKeL2
        hkvHTjMrZQ3ZpykJ9mMHMLM+FXzfARc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-v4o9SRQiOIGG6Kjirw7D1g-1; Wed, 15 Nov 2023 06:11:10 -0500
X-MC-Unique: v4o9SRQiOIGG6Kjirw7D1g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9e31708ad72so460129166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700046669; x=1700651469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+9IBIN2TseVRMl8fITJ/N2WS2NwQD1vqkbQglXI4X4=;
        b=Jx69lecBP4Npkop6fZhgFHqxNbH6K1l0CRYfa5ekEN5rTLfN5lzZtgWXcSJW6qJaFD
         gcmKu+XWIvF+Pw2sWhkNzUA3Tc8KfDBRzhnu4+o0+1jT6NnnC0A+4tFDbU+DZyFZC5u7
         5Xce7p4VpKYxie3lsCyJCcC0ldgZWbOodOfpm9YXFe16sA2oZpLyqAMo1IozyIOzU/lG
         5qbWf/gXF1OeDvzbAaDMrtY108iKeDmVMjRibrm/O4oYdw+5sK1IOb1MWHRNqoA6RIy2
         WJEnKtEAQAofR9OQW4gA4lz7GzY9n8dOIsQS/pP3n4zfOPv6kUiHRUu8NdZPdHxsH/DH
         AewQ==
X-Gm-Message-State: AOJu0Yyj3rELWBw2tMBiCOlFPLzJ4EqutU+CH5SnJPLoAzyoM5He/JLk
        ErK45Bjmy43JnE3d2ubUwj/4Oq1bn+eH5ljfbpJXwf3Nho1zQ8P+5oWwf03nNGbnSotLGDCQi4+
        sf9icJLwqJHqccEUu8yRRIPqv
X-Received: by 2002:a17:906:d292:b0:9dd:f5ba:856d with SMTP id ay18-20020a170906d29200b009ddf5ba856dmr10523742ejb.62.1700046669460;
        Wed, 15 Nov 2023 03:11:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEicy/bLc4oN1a42wj/6SobC5kFcPGCJNdEL99xoe8FtbG79XQBALGZSqlBlQSbj2/E80ogpw==
X-Received: by 2002:a17:906:d292:b0:9dd:f5ba:856d with SMTP id ay18-20020a170906d29200b009ddf5ba856dmr10523724ejb.62.1700046669162;
        Wed, 15 Nov 2023 03:11:09 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906080a00b009a193a5acffsm6916813ejd.121.2023.11.15.03.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 03:11:08 -0800 (PST)
Date:   Wed, 15 Nov 2023 12:11:02 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 2/2] vsock/test: SO_RCVLOWAT + deferred credit
 update test
Message-ID: <zukasb6k7ogta33c2wik6cgadg2rkacestat7pkexd45u53swh@ovso3hafta77>
References: <20231108072004.1045669-1-avkrasnov@salutedevices.com>
 <20231108072004.1045669-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231108072004.1045669-3-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 10:20:04AM +0300, Arseniy Krasnov wrote:
>This adds test which checks, that updating SO_RCVLOWAT value also sends

You can avoid "This adds", and write just "Add test ...".

See https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

     Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
     instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
     to do frotz", as if you are giving orders to the codebase to change
     its behaviour.

Also in the other patch.

>credit update message. Otherwise mutual hungup may happen when receiver
>didn't send credit update and then calls 'poll()' with non default
>SO_RCVLOWAT value (e.g. waiting enough bytes to read), while sender
>waits for free space at receiver's side.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> tools/testing/vsock/vsock_test.c | 131 +++++++++++++++++++++++++++++++
> 1 file changed, 131 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index c1f7bc9abd22..c71b3875fd16 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1180,6 +1180,132 @@ static void test_stream_shutrd_server(const struct test_opts *opts)
> 	close(fd);
> }
>
>+#define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
>+#define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE	(1024 * 64)

What about adding a comment like the one in the cover letter about
dependency with kernel values?

Please add it also in the commit description.

I'm thinking if we should move all the defines that depends on the
kernel in some special header.

>+
>+static void test_stream_rcvlowat_def_cred_upd_client(const struct test_opts *opts)
>+{
>+	size_t buf_size;
>+	void *buf;
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Send 1 byte more than peer's buffer size. */
>+	buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE + 1;
>+
>+	buf = malloc(buf_size);
>+	if (!buf) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Wait until peer sets needed buffer size. */
>+	control_expectln("SRVREADY");
>+
>+	if (send(fd, buf, buf_size, 0) != buf_size) {
>+		perror("send failed");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	free(buf);
>+	close(fd);
>+}
>+
>+static void test_stream_rcvlowat_def_cred_upd_server(const struct test_opts *opts)
>+{
>+	size_t recv_buf_size;
>+	struct pollfd fds;
>+	size_t buf_size;
>+	void *buf;
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	buf_size = RCVLOWAT_CREDIT_UPD_BUF_SIZE;
>+
>+	if (setsockopt(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>+		       &buf_size, sizeof(buf_size))) {
>+		perror("setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	buf = malloc(buf_size);
>+	if (!buf) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SRVREADY");
>+
>+	/* Wait until there will be 128KB of data in rx queue. */
>+	while (1) {
>+		ssize_t res;
>+
>+		res = recv(fd, buf, buf_size, MSG_PEEK);
>+		if (res == buf_size)
>+			break;
>+
>+		if (res <= 0) {
>+			fprintf(stderr, "unexpected 'recv()' return: %zi\n", res);
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+
>+	/* There is 128KB of data in the socket's rx queue,
>+	 * dequeue first 64KB, credit update is not sent.
>+	 */
>+	recv_buf_size = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>+	recv_buf(fd, buf, recv_buf_size, 0, recv_buf_size);
>+	recv_buf_size++;
>+
>+	/* Updating SO_RCVLOWAT will send credit update. */
>+	if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>+		       &recv_buf_size, sizeof(recv_buf_size))) {
>+		perror("setsockopt(SO_RCVLOWAT)");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	memset(&fds, 0, sizeof(fds));
>+	fds.fd = fd;
>+	fds.events = POLLIN | POLLRDNORM | POLLERR |
>+		     POLLRDHUP | POLLHUP;
>+
>+	/* This 'poll()' will return once we receive last byte
>+	 * sent by client.
>+	 */
>+	if (poll(&fds, 1, -1) < 0) {
>+		perror("poll");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (fds.revents & POLLERR) {
>+		fprintf(stderr, "'poll()' error\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (fds.revents & (POLLIN | POLLRDNORM)) {
>+		recv_buf(fd, buf, recv_buf_size, 0, recv_buf_size);
>+	} else {
>+		/* These flags must be set, as there is at
>+		 * least 64KB of data ready to read.
>+		 */
>+		fprintf(stderr, "POLLIN | POLLRDNORM expected\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	free(buf);
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1285,6 +1411,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_msgzcopy_empty_errq_client,
> 		.run_server = test_stream_msgzcopy_empty_errq_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM virtio SO_RCVLOWAT + deferred cred update",
>+		.run_client = test_stream_rcvlowat_def_cred_upd_client,
>+		.run_server = test_stream_rcvlowat_def_cred_upd_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1
>

