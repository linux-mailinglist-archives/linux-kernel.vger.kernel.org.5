Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030487C5492
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbjJKM4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346776AbjJKMz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7464C91
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697028910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJd+F+1J07wBQgE2LpwHaS1V2fAItQIC6yyvUcClvl0=;
        b=Q59yaltt3AbR1b4Z7rdc+UMSluslb3YFCZJ7Q25mVJGxq5F8FqlXiEoXGQezpvMU8kMbfk
        lje2sQzAW+Zb3h8VhfEDAFeR2D5QTE7t5y074YU7Rdq2h2McWzbj42rAemDFmMDIGZ1oK8
        2w7UbSGyGVeya4FaTCfNEPiqP6Ag5F8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-dFq9ZHTgPIOAK3RT8BUEug-1; Wed, 11 Oct 2023 08:55:09 -0400
X-MC-Unique: dFq9ZHTgPIOAK3RT8BUEug-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5a7a6fd18abso39806597b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697028909; x=1697633709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJd+F+1J07wBQgE2LpwHaS1V2fAItQIC6yyvUcClvl0=;
        b=LnDvP+9QhHsVHWejGcWVYl7O0xS2f13FJMgzjt1vJP3VF5fRlLg2uo+cfUYhtGHUvA
         C6UJ59/TVWZ/++4nys5bRtHQbqq3RRokLGJhaZLKIk6P/nyAl+l3ZZRvNDuAoFoSVZc+
         1hhFp5zNkYcQW++g1eJzmwHYv0FjAN6eZape3d62nZXpnL0o1Qbn//AKo8lJwWKd1Rnn
         XWW3sStYPxtwp2Dr7t7i977cq9dpuu/a264pjk25cqyufldjydRPpyKAi+wc632cWu/b
         2akJzw/KjkeoGDSLfLXQcWRUG0dfXBcZBFIxHaIpMpeGt2drNKj1sSLoOi+g0u/D96R5
         aZMQ==
X-Gm-Message-State: AOJu0YyiRCfuaU6BCp8Ubj7qVYbjxIDzT9J88UAktZx1eQMZ6EfoewQT
        Ym/VNxqAhWEiOWiEcx1VyjCkNPbrOCZgr7oxL4PNxe8Kh//7jNejXsRLSjqJJXb/PPw4mU3u8F+
        kgf/9+GLxBjEayU+kau21yVRk
X-Received: by 2002:a0d:f387:0:b0:589:c065:b419 with SMTP id c129-20020a0df387000000b00589c065b419mr25260684ywf.34.1697028908820;
        Wed, 11 Oct 2023 05:55:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUvmy1rg5/NhlNofu08qiGaNFJjHtBDi2LInJsYATuvWP8qGFA63br25JSlZAuICkrN/s5fQ==
X-Received: by 2002:a0d:f387:0:b0:589:c065:b419 with SMTP id c129-20020a0df387000000b00589c065b419mr25260671ywf.34.1697028908504;
        Wed, 11 Oct 2023 05:55:08 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-251.retail.telecomitalia.it. [79.46.200.251])
        by smtp.gmail.com with ESMTPSA id r6-20020a0c8d06000000b0065655bb349csm5685356qvb.141.2023.10.11.05.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:55:07 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:55:03 +0200
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
Subject: Re: [PATCH net-next v4 12/12] test/vsock: io_uring rx/tx tests
Message-ID: <5oqx2vxfzgp4sryyvsjdnkex3wihiova43rubxyrzusrgrc75i@f3ayebkdbrtz>
References: <20231010191524.1694217-1-avkrasnov@salutedevices.com>
 <20231010191524.1694217-13-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231010191524.1694217-13-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:15:24PM +0300, Arseniy Krasnov wrote:
>This adds set of tests which use io_uring for rx/tx. This test suite is
>implemented as separated util like 'vsock_test' and has the same set of
>input arguments as 'vsock_test'. These tests only cover cases of data
>transmission (no connect/bind/accept etc).
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Add 'LDLIBS = -luring' to the target 'vsock_uring_test'.
>  * Add 'vsock_uring_test' to the target 'test'.
> v2 -> v3:
>  * Make 'struct vsock_test_data' private by placing it to the .c file.
>    Rename it and add comments to this struct to clarify sense of its
>    fields.
>  * Add 'vsock_uring_test' to the '.gitignore'.
>  * Add receive loop to the server side - this is needed to read entire
>    data sent by client.
> v3 -> v4:
>  * Link with 'msg_zerocopy_common.o'.
>  * Use '#ifndef' around '#define PAGE_SIZE 4096'.
>
> tools/testing/vsock/.gitignore         |   1 +
> tools/testing/vsock/Makefile           |   7 +-
> tools/testing/vsock/vsock_uring_test.c | 342 +++++++++++++++++++++++++
> 3 files changed, 348 insertions(+), 2 deletions(-)
> create mode 100644 tools/testing/vsock/vsock_uring_test.c

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/.gitignore b/tools/testing/vsock/.gitignore
>index a8adcfdc292b..d9f798713cd7 100644
>--- a/tools/testing/vsock/.gitignore
>+++ b/tools/testing/vsock/.gitignore
>@@ -3,3 +3,4 @@
> vsock_test
> vsock_diag_test
> vsock_perf
>+vsock_uring_test
>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>index 228470ae33c2..a7f56a09ca9f 100644
>--- a/tools/testing/vsock/Makefile
>+++ b/tools/testing/vsock/Makefile
>@@ -1,12 +1,15 @@
> # SPDX-License-Identifier: GPL-2.0-only
> all: test vsock_perf
>-test: vsock_test vsock_diag_test
>+test: vsock_test vsock_diag_test vsock_uring_test
> vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o control.o util.o msg_zerocopy_common.o
> vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
> vsock_perf: vsock_perf.o msg_zerocopy_common.o
>
>+vsock_uring_test: LDLIBS = -luring
>+vsock_uring_test: control.o util.o vsock_uring_test.o timeout.o msg_zerocopy_common.o
>+
> CFLAGS += -g -O2 -Werror -Wall -I. -I../../include -I../../../usr/include -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -D_GNU_SOURCE
> .PHONY: all test clean
> clean:
>-	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf
>+	${RM} *.o *.d vsock_test vsock_diag_test vsock_perf vsock_uring_test
> -include *.d
>diff --git a/tools/testing/vsock/vsock_uring_test.c b/tools/testing/vsock/vsock_uring_test.c
>new file mode 100644
>index 000000000000..d976d35f0ba9
>--- /dev/null
>+++ b/tools/testing/vsock/vsock_uring_test.c
>@@ -0,0 +1,342 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/* io_uring tests for vsock
>+ *
>+ * Copyright (C) 2023 SberDevices.
>+ *
>+ * Author: Arseniy Krasnov <avkrasnov@salutedevices.com>
>+ */
>+
>+#include <getopt.h>
>+#include <stdio.h>
>+#include <stdlib.h>
>+#include <string.h>
>+#include <liburing.h>
>+#include <unistd.h>
>+#include <sys/mman.h>
>+#include <linux/kernel.h>
>+#include <error.h>
>+
>+#include "util.h"
>+#include "control.h"
>+#include "msg_zerocopy_common.h"
>+
>+#ifndef PAGE_SIZE
>+#define PAGE_SIZE		4096
>+#endif
>+
>+#define RING_ENTRIES_NUM	4
>+
>+#define VSOCK_TEST_DATA_MAX_IOV 3
>+
>+struct vsock_io_uring_test {
>+	/* Number of valid elements in 'vecs'. */
>+	int vecs_cnt;
>+	struct iovec vecs[VSOCK_TEST_DATA_MAX_IOV];
>+};
>+
>+static struct vsock_io_uring_test test_data_array[] = {
>+	/* All elements have page aligned base and size. */
>+	{
>+		.vecs_cnt = 3,
>+		{
>+			{ NULL, PAGE_SIZE },
>+			{ NULL, 2 * PAGE_SIZE },
>+			{ NULL, 3 * PAGE_SIZE },
>+		}
>+	},
>+	/* Middle element has both non-page aligned base and size. */
>+	{
>+		.vecs_cnt = 3,
>+		{
>+			{ NULL, PAGE_SIZE },
>+			{ (void *)1, 200  },
>+			{ NULL, 3 * PAGE_SIZE },
>+		}
>+	}
>+};
>+
>+static void vsock_io_uring_client(const struct test_opts *opts,
>+				  const struct vsock_io_uring_test *test_data,
>+				  bool msg_zerocopy)
>+{
>+	struct io_uring_sqe *sqe;
>+	struct io_uring_cqe *cqe;
>+	struct io_uring ring;
>+	struct iovec *iovec;
>+	struct msghdr msg;
>+	int fd;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (msg_zerocopy)
>+		enable_so_zerocopy(fd);
>+
>+	iovec = alloc_test_iovec(test_data->vecs, test_data->vecs_cnt);
>+
>+	if (io_uring_queue_init(RING_ENTRIES_NUM, &ring, 0))
>+		error(1, errno, "io_uring_queue_init");
>+
>+	if (io_uring_register_buffers(&ring, iovec, test_data->vecs_cnt))
>+		error(1, errno, "io_uring_register_buffers");
>+
>+	memset(&msg, 0, sizeof(msg));
>+	msg.msg_iov = iovec;
>+	msg.msg_iovlen = test_data->vecs_cnt;
>+	sqe = io_uring_get_sqe(&ring);
>+
>+	if (msg_zerocopy)
>+		io_uring_prep_sendmsg_zc(sqe, fd, &msg, 0);
>+	else
>+		io_uring_prep_sendmsg(sqe, fd, &msg, 0);
>+
>+	if (io_uring_submit(&ring) != 1)
>+		error(1, errno, "io_uring_submit");
>+
>+	if (io_uring_wait_cqe(&ring, &cqe))
>+		error(1, errno, "io_uring_wait_cqe");
>+
>+	io_uring_cqe_seen(&ring, cqe);
>+
>+	control_writeulong(iovec_hash_djb2(iovec, test_data->vecs_cnt));
>+
>+	control_writeln("DONE");
>+	io_uring_queue_exit(&ring);
>+	free_test_iovec(test_data->vecs, iovec, test_data->vecs_cnt);
>+	close(fd);
>+}
>+
>+static void vsock_io_uring_server(const struct test_opts *opts,
>+				  const struct vsock_io_uring_test *test_data)
>+{
>+	unsigned long remote_hash;
>+	unsigned long local_hash;
>+	struct io_uring ring;
>+	size_t data_len;
>+	size_t recv_len;
>+	void *data;
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	data_len = iovec_bytes(test_data->vecs, test_data->vecs_cnt);
>+
>+	data = malloc(data_len);
>+	if (!data) {
>+		perror("malloc");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (io_uring_queue_init(RING_ENTRIES_NUM, &ring, 0))
>+		error(1, errno, "io_uring_queue_init");
>+
>+	recv_len = 0;
>+
>+	while (recv_len < data_len) {
>+		struct io_uring_sqe *sqe;
>+		struct io_uring_cqe *cqe;
>+		struct iovec iovec;
>+
>+		sqe = io_uring_get_sqe(&ring);
>+		iovec.iov_base = data + recv_len;
>+		iovec.iov_len = data_len;
>+
>+		io_uring_prep_readv(sqe, fd, &iovec, 1, 0);
>+
>+		if (io_uring_submit(&ring) != 1)
>+			error(1, errno, "io_uring_submit");
>+
>+		if (io_uring_wait_cqe(&ring, &cqe))
>+			error(1, errno, "io_uring_wait_cqe");
>+
>+		recv_len += cqe->res;
>+		io_uring_cqe_seen(&ring, cqe);
>+	}
>+
>+	if (recv_len != data_len) {
>+		fprintf(stderr, "expected %zu, got %zu\n", data_len,
>+			recv_len);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	local_hash = hash_djb2(data, data_len);
>+
>+	remote_hash = control_readulong();
>+	if (remote_hash != local_hash) {
>+		fprintf(stderr, "hash mismatch\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("DONE");
>+	io_uring_queue_exit(&ring);
>+	free(data);
>+}
>+
>+void test_stream_uring_server(const struct test_opts *opts)
>+{
>+	int i;
>+
>+	for (i = 0; i < ARRAY_SIZE(test_data_array); i++)
>+		vsock_io_uring_server(opts, &test_data_array[i]);
>+}
>+
>+void test_stream_uring_client(const struct test_opts *opts)
>+{
>+	int i;
>+
>+	for (i = 0; i < ARRAY_SIZE(test_data_array); i++)
>+		vsock_io_uring_client(opts, &test_data_array[i], false);
>+}
>+
>+void test_stream_uring_msg_zc_server(const struct test_opts *opts)
>+{
>+	int i;
>+
>+	for (i = 0; i < ARRAY_SIZE(test_data_array); i++)
>+		vsock_io_uring_server(opts, &test_data_array[i]);
>+}
>+
>+void test_stream_uring_msg_zc_client(const struct test_opts *opts)
>+{
>+	int i;
>+
>+	for (i = 0; i < ARRAY_SIZE(test_data_array); i++)
>+		vsock_io_uring_client(opts, &test_data_array[i], true);
>+}
>+
>+static struct test_case test_cases[] = {
>+	{
>+		.name = "SOCK_STREAM io_uring test",
>+		.run_server = test_stream_uring_server,
>+		.run_client = test_stream_uring_client,
>+	},
>+	{
>+		.name = "SOCK_STREAM io_uring MSG_ZEROCOPY test",
>+		.run_server = test_stream_uring_msg_zc_server,
>+		.run_client = test_stream_uring_msg_zc_client,
>+	},
>+	{},
>+};
>+
>+static const char optstring[] = "";
>+static const struct option longopts[] = {
>+	{
>+		.name = "control-host",
>+		.has_arg = required_argument,
>+		.val = 'H',
>+	},
>+	{
>+		.name = "control-port",
>+		.has_arg = required_argument,
>+		.val = 'P',
>+	},
>+	{
>+		.name = "mode",
>+		.has_arg = required_argument,
>+		.val = 'm',
>+	},
>+	{
>+		.name = "peer-cid",
>+		.has_arg = required_argument,
>+		.val = 'p',
>+	},
>+	{
>+		.name = "help",
>+		.has_arg = no_argument,
>+		.val = '?',
>+	},
>+	{},
>+};
>+
>+static void usage(void)
>+{
>+	fprintf(stderr, "Usage: vsock_uring_test [--help] [--control-host=<host>] --control-port=<port> --mode=client|server --peer-cid=<cid>\n"
>+		"\n"
>+		"  Server: vsock_uring_test --control-port=1234 --mode=server --peer-cid=3\n"
>+		"  Client: vsock_uring_test --control-host=192.168.0.1 --control-port=1234 --mode=client --peer-cid=2\n"
>+		"\n"
>+		"Run transmission tests using io_uring. Usage is the same as\n"
>+		"in ./vsock_test\n"
>+		"\n"
>+		"Options:\n"
>+		"  --help                 This help message\n"
>+		"  --control-host <host>  Server IP address to connect to\n"
>+		"  --control-port <port>  Server port to listen on/connect to\n"
>+		"  --mode client|server   Server or client mode\n"
>+		"  --peer-cid <cid>       CID of the other side\n"
>+		);
>+	exit(EXIT_FAILURE);
>+}
>+
>+int main(int argc, char **argv)
>+{
>+	const char *control_host = NULL;
>+	const char *control_port = NULL;
>+	struct test_opts opts = {
>+		.mode = TEST_MODE_UNSET,
>+		.peer_cid = VMADDR_CID_ANY,
>+	};
>+
>+	init_signals();
>+
>+	for (;;) {
>+		int opt = getopt_long(argc, argv, optstring, longopts, NULL);
>+
>+		if (opt == -1)
>+			break;
>+
>+		switch (opt) {
>+		case 'H':
>+			control_host = optarg;
>+			break;
>+		case 'm':
>+			if (strcmp(optarg, "client") == 0) {
>+				opts.mode = TEST_MODE_CLIENT;
>+			} else if (strcmp(optarg, "server") == 0) {
>+				opts.mode = TEST_MODE_SERVER;
>+			} else {
>+				fprintf(stderr, "--mode must be \"client\" or \"server\"\n");
>+				return EXIT_FAILURE;
>+			}
>+			break;
>+		case 'p':
>+			opts.peer_cid = parse_cid(optarg);
>+			break;
>+		case 'P':
>+			control_port = optarg;
>+			break;
>+		case '?':
>+		default:
>+			usage();
>+		}
>+	}
>+
>+	if (!control_port)
>+		usage();
>+	if (opts.mode == TEST_MODE_UNSET)
>+		usage();
>+	if (opts.peer_cid == VMADDR_CID_ANY)
>+		usage();
>+
>+	if (!control_host) {
>+		if (opts.mode != TEST_MODE_SERVER)
>+			usage();
>+		control_host = "0.0.0.0";
>+	}
>+
>+	control_init(control_host, control_port,
>+		     opts.mode == TEST_MODE_SERVER);
>+
>+	run_tests(test_cases, &opts);
>+
>+	control_cleanup();
>+
>+	return 0;
>+}
>-- 
>2.25.1
>

