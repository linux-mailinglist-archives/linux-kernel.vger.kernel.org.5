Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AB180515D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376576AbjLEK4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346812AbjLEK4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:56:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D711F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 02:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701773763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHoHZN4aRFvNFdo4bu58j5O/6N2eNq1OsRYRF67Krww=;
        b=b6wI7k2VUX06PukWNujk6iS8KttcDWVu//M7jOEXEP8oMSpmjoYUh0gYh8ZLWEJzAY5zzn
        /75p76Dg47yHX2t9g0YDn48DKz1Gm87vOkLvghxMp/0h2nnKvA0EkT6PrJkmb1vmHSMztb
        KVz3F2t0BCCUBh3xS8MudYPcRpnIueA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-ny9gJhTPMkiH6XfcMoNa2w-1; Tue, 05 Dec 2023 05:56:02 -0500
X-MC-Unique: ny9gJhTPMkiH6XfcMoNa2w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1c915eae11so39017166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 02:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701773761; x=1702378561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHoHZN4aRFvNFdo4bu58j5O/6N2eNq1OsRYRF67Krww=;
        b=Kg9CYdEDHxhSEk9QGHmWJpwoZHwK2yp5Rp/vqQyKu9Gi1+bpBriVxEB5a+GUztho/q
         NElj7hFdckIde35AwPa9lOmZdehiQWbqIGn68tjX4VlrsOwtF5TlvKYZRQdeoP30kFEv
         J++nGr3luDLiUberacPFGrCccjSN7ntrd1Z8mNe4wTCu991qxYv4J81q3Y7eEGl24qXk
         2tBLxNx5FbVOGzkql6FBCK5R2e/Xgypb+5EdopvFRR4H83HyTrl8odMhwEBXkNIA2LCC
         S19IgO6pTFOiIBv+C3Vzh26e93C+loSUfDdv9DeSzyJT1oJxzeihEpYOHfI27QHlbtv9
         Mwxg==
X-Gm-Message-State: AOJu0YwOVmWf4P68W6Hyhz2irHzFXh7vqyBGbdwaPkgOSlOohp+T3dBV
        N4kh/8PoVrpZUB2toV/E/XhTienuk/pZsJEIdZ2+3gbWrHaziBtQ6THVyovCYzd2HLIbcTLZrDE
        SkYhBpf7fTkZkUpOtsOrcZHDO
X-Received: by 2002:a17:906:2558:b0:a0f:c538:4612 with SMTP id j24-20020a170906255800b00a0fc5384612mr770823ejb.28.1701773761251;
        Tue, 05 Dec 2023 02:56:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFodYj5wYSzJpUOxz5vmAW8yxE1ykvgpNcy8FOngHr66MXZwbO9eVpr4+yZyLwfPmeuRUBXfQ==
X-Received: by 2002:a17:906:2558:b0:a0f:c538:4612 with SMTP id j24-20020a170906255800b00a0fc5384612mr770808ejb.28.1701773760965;
        Tue, 05 Dec 2023 02:56:00 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-125.retail.telecomitalia.it. [79.46.200.125])
        by smtp.gmail.com with ESMTPSA id ci9-20020a170907266900b00a1be80a0b69sm1143002ejc.58.2023.12.05.02.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 02:56:00 -0800 (PST)
Date:   Tue, 5 Dec 2023 11:55:58 +0100
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
Subject: Re: [PATCH net-next v6 4/4] vsock/test: two tests to check credit
 update logic
Message-ID: <tcrlrx2iegveaioryasdvsnjvnrumvq4ky6qcq2p5tb4g65joa@ckin3ipduxvv>
References: <20231205064806.2851305-1-avkrasnov@salutedevices.com>
 <20231205064806.2851305-5-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231205064806.2851305-5-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:48:06AM +0300, Arseniy Krasnov wrote:
>Both tests are almost same, only differs in two 'if' conditions, so
>implemented in a single function. Tests check, that credit update
>message is sent:
>
>1) During setting SO_RCVLOWAT value of the socket.
>2) When number of 'rx_bytes' become smaller than SO_RCVLOWAT value.
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
> v5 -> v6:
>  * Add second test which checks, that credit update is sent during
>    reading data from socket.
>  * Update commit message.
>
> tools/testing/vsock/vsock_test.c | 175 +++++++++++++++++++++++++++++++
> 1 file changed, 175 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 01fa816868bc..66246d81d654 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1232,6 +1232,171 @@ static void test_double_bind_connect_client(const struct test_opts *opts)
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
>+static void test_stream_credit_update_test(const struct test_opts *opts,
>+					   bool low_rx_bytes_test)
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
>+	if (low_rx_bytes_test) {
>+		/* Set new SO_RCVLOWAT here. This enables sending credit
>+		 * update when number of bytes if our rx queue become <
>+		 * SO_RCVLOWAT value.
>+		 */
>+		recv_buf_size = 1 + VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>+
>+		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>+			       &recv_buf_size, sizeof(recv_buf_size))) {
>+			perror("setsockopt(SO_RCVLOWAT)");
>+			exit(EXIT_FAILURE);
>+		}
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
>+	/* There is 128KB of data in the socket's rx queue, dequeue first
>+	 * 64KB, credit update is sent if 'low_rx_bytes_test' == true.
>+	 * Otherwise, credit update is sent in 'if (!low_rx_bytes_test)'.
>+	 */
>+	recv_buf_size = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
>+	recv_buf(fd, buf, recv_buf_size, 0, recv_buf_size);
>+
>+	if (!low_rx_bytes_test) {
>+		recv_buf_size++;
>+
>+		/* Updating SO_RCVLOWAT will send credit update. */
>+		if (setsockopt(fd, SOL_SOCKET, SO_RCVLOWAT,
>+			       &recv_buf_size, sizeof(recv_buf_size))) {
>+			perror("setsockopt(SO_RCVLOWAT)");
>+			exit(EXIT_FAILURE);
>+		}
>+	}
>+
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
>+static void test_stream_cred_upd_on_low_rx_bytes(const struct test_opts *opts)
>+{
>+	test_stream_credit_update_test(opts, true);
>+}
>+
>+static void test_stream_cred_upd_on_set_rcvlowat(const struct test_opts *opts)
>+{
>+	test_stream_credit_update_test(opts, false);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1342,6 +1507,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_double_bind_connect_client,
> 		.run_server = test_double_bind_connect_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM virtio credit update + SO_RCVLOWAT",
>+		.run_client = test_stream_rcvlowat_def_cred_upd_client,
>+		.run_server = test_stream_cred_upd_on_set_rcvlowat,
>+	},
>+	{
>+		.name = "SOCK_STREAM virtio credit update + low rx_bytes",
>+		.run_client = test_stream_rcvlowat_def_cred_upd_client,
>+		.run_server = test_stream_cred_upd_on_low_rx_bytes,
>+	},
> 	{},
> };
>
>-- 
>2.25.1
>

