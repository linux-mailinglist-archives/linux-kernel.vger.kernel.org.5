Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC667FF03D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345560AbjK3NgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345542AbjK3NgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:36:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ECC194
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701351371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d7NbcS23obYuAf1xLnepErpBcuJF3mxbRXVeb1/aOyk=;
        b=WW3rMFe5nCNDr+OgZDkMPRiQ92U9wvwsxSxYBfMbArAZOD7dhQWXjvN9HnllQBgpUIWxJl
        gTPsTN1xggnsZjWNJbeiilZt3DmTXHUFdVV3/X0DsDKnfGZgUDFkwY2VLPdUayUJ1vhAeO
        i1ylHbx07c8g4bgX86u7Jamk4tfBl+A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-0mmq9DFAOayfg3dFLemesg-1; Thu, 30 Nov 2023 08:36:10 -0500
X-MC-Unique: 0mmq9DFAOayfg3dFLemesg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33308815448so815523f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:36:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351369; x=1701956169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7NbcS23obYuAf1xLnepErpBcuJF3mxbRXVeb1/aOyk=;
        b=U3FAI3ykZ1WG+Nj52PxpEfwDIBvIIrL2mvfrnPM/8fwXRMMiPLVSSWwvf9RhBDnx2y
         Zj/ac28V0zEZGGZmL+64oSmETvlrHhwHxlKb64g7e4zw2/YEho+sl/OW5x5dnaLs5B78
         O6iRHDdmUvjy1ZAdEbnwy/P06du9RubPADmkLxZsBe5S5gxL9NgEamo2F4qyvGBh4yAa
         1IY7RCTc9vyM6NufSGhVqsYMiHubzIUZGVn0ODQDe0pEGmsUOsCWNqDpTEBZALoTl6q4
         jzlH2g6U3BeFwGhIwL7za6UlDIT9Iha2wzloqzSAIFVid1RB+Vz19AM7ZDGoTQjZ6WOR
         GZAw==
X-Gm-Message-State: AOJu0YzFKlCzRxfUf0U8CNJ/lrMEiDi4rlP8FzsocO+1P/Sf+dyPgWTV
        dl1VuR7djA9irMSjdzGlbuG3OmGVQbysEWKx5bPOehyq7UsWFmBLdlOcbnCo9UWpZjXji8W0Hz/
        CiUAM0S0cN1WEympnjMZtrFtT
X-Received: by 2002:a5d:448f:0:b0:332:c593:16c with SMTP id j15-20020a5d448f000000b00332c593016cmr14884089wrq.45.1701351369125;
        Thu, 30 Nov 2023 05:36:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR3jKJGt6tBdWO3pDi42NqgbDR7i64AOzGM0BK73Ce9FYmYXkKqlaQaBsR/IcPbXWMWnLT+Q==
X-Received: by 2002:a5d:448f:0:b0:332:c593:16c with SMTP id j15-20020a5d448f000000b00332c593016cmr14884068wrq.45.1701351368725;
        Thu, 30 Nov 2023 05:36:08 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-199.retail.telecomitalia.it. [79.46.200.199])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d464e000000b003330f9287a8sm1582694wrs.51.2023.11.30.05.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:36:08 -0800 (PST)
Date:   Thu, 30 Nov 2023 14:36:03 +0100
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
Subject: Re: [PATCH net-next v5 3/3] vsock/test: SO_RCVLOWAT + deferred
 credit update test
Message-ID: <3i2ohqtxyncvd7n32rgoui3gf44jpupdbsa3yue7dnflgftalj@7ldbyg5deytj>
References: <20231130130840.253733-1-avkrasnov@salutedevices.com>
 <20231130130840.253733-4-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231130130840.253733-4-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:08:40PM +0300, Arseniy Krasnov wrote:
>Test which checks, that updating SO_RCVLOWAT value also sends credit
>update message. Otherwise mutual hungup may happen when receiver didn't
>send credit update and then calls 'poll()' with non default SO_RCVLOWAT
>value (e.g. waiting enough bytes to read), while sender waits for free
>space at receiver's side. Important thing is that this test relies on
>kernel's define for maximum packet size for virtio transport and this
>value is not exported to user: VIRTIO_VSOCK_MAX_PKT_BUF_SIZE (this
>define is used to control moment when to send credit update message).
>If this value or its usage will be changed in kernel - this test may
>become useless/broken.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Update commit message by removing 'This patch adds XXX' manner.
>  * Update commit message by adding details about dependency for this
>    test from kernel internal define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
>  * Add comment for this dependency in 'vsock_test.c' where this define
>    is duplicated.
> v2 -> v3:
>  * Replace synchronization based on control TCP socket with vsock
>    data socket - this is needed to allow sender transmit data only
>    when new buffer size of receiver is visible to sender. Otherwise
>    there is race and test fails sometimes.
> v3 -> v4:
>  * Replace 'recv_buf()' to 'recv(MSG_DONTWAIT)' in last read operation
>    in server part. This is needed to ensure that 'poll()' wake up us
>    when number of bytes ready to read is equal to SO_RCVLOWAT value.
> v4 -> v5:
>  * Use 'recv_buf(MSG_DONTWAIT)' instead of 'recv(MSG_DONTWAIT)'.
>
> tools/testing/vsock/vsock_test.c | 142 +++++++++++++++++++++++++++++++
> 1 file changed, 142 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 01fa816868bc..d66bc4987026 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1232,6 +1232,143 @@ static void test_double_bind_connect_client(const struct test_opts *opts)
> 	}
> }
>
>+#define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
>+/* This define is the same as in 'include/linux/virtio_vsock.h':
>+ * it is used to decide when to send credit update message during
>+ * reading from rx queue of a socket. Value and its usage in
>+ * kernel is important for this test.
>+ */
>+#define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE	(1024 * 64)
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
>+	recv_byte(fd, 1, 0);
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
>+	/* Send one dummy byte here, because 'setsockopt()' above also
>+	 * sends special packet which tells sender to update our buffer
>+	 * size. This 'send_byte()' will serialize such packet with data
>+	 * reads in a loop below. Sender starts transmission only when
>+	 * it receives this single byte.
>+	 */
>+	send_byte(fd, 1, 0);
>+
>+	buf = malloc(buf_size);
>+	if (!buf) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
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

I would add a comment here, like this:

   We expect poll to wake up only after receiving all the
   bytes requested with SO_RCVLOWAT, so we don't want the
   read to block waiting for more.

The rest LGTM.

Thanks,
Stefano

>+		recv_buf(fd, buf, recv_buf_size, MSG_DONTWAIT, recv_buf_size);
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
>@@ -1342,6 +1479,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_double_bind_connect_client,
> 		.run_server = test_double_bind_connect_server,
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

