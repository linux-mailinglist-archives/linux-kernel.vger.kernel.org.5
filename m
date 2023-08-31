Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DBB78F006
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346510AbjHaPN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjHaPNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57341E4A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693494791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7q3Y4yiktGEyTW0UFreHL9GRNARDnev7O8/a837iJGA=;
        b=SwyeNfu8y4H1Jl+4HBASUg4dV3F6AKjxFIxVerFOIlT6eKJ8dW1csCHI1sQuk252CUww8f
        +T9yiCxM4wY4R59+EjddrUCj2U7ygvEnU1WkmEbwH3Jzbh1Fh1mEGF94sE46AGUC3NvmSX
        QRAYBp7vBVWRb0WeBTyAGKUZ0acQ+u8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-LdU52Vl5PRirw-X0i_skNA-1; Thu, 31 Aug 2023 11:13:07 -0400
X-MC-Unique: LdU52Vl5PRirw-X0i_skNA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-52a5e65d9b4so705254a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693494786; x=1694099586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q3Y4yiktGEyTW0UFreHL9GRNARDnev7O8/a837iJGA=;
        b=JLv6Yy0wHYemELaKYSR/QCmJSTZgWSVQO6lmYbUmRHyKiW01fdIgRQIrB+27udMAf9
         2EDFFF0IHf4DUZfGpKA6jUGUlJWo1mXjZ+F99feMU9KAcAOjL5q3hOe8hGPxeJYJ04dN
         CikzR7+xrCCUVqItSgDilPrq3n/TzX4JKvT7LapvrrUogiaLQV4r1jqbmJDgPylWFF1Z
         1AOj5W7f5bkYO8gmkmQ7mpdBgJUZwWd35f+mCnVdVNq2l/e2yztNtLfts4Nrh72eT0RB
         Rlx9Oxfrmfvx2r0esG/gKarpz7KqHkDwmH92G0SWmTfdcx0OK7TLJFWp6cvavOBaSHjZ
         W0GA==
X-Gm-Message-State: AOJu0YxCp1IPASD8QSbMJ3S1L10eA1Od1TWGibaLpWDdHjaeA6cpH1fN
        K0oPX00Y+VyPMeV5WLfQQrej1Fh200/+r1eTw8qFDxoIen4Z3bB4IfFJUzvJ66eBsfs8MSjIUCS
        eeiFPQ915ctKXZa8nVU3L17VL
X-Received: by 2002:a17:907:2711:b0:99b:627b:e96d with SMTP id w17-20020a170907271100b0099b627be96dmr3925103ejk.44.1693494786302;
        Thu, 31 Aug 2023 08:13:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF715v/t0gaQyatoS18qed412E+sQSxkJ3L84oJw2LaknRVSuElh16mJtXthOZpoaHZRxEsZQ==
X-Received: by 2002:a17:907:2711:b0:99b:627b:e96d with SMTP id w17-20020a170907271100b0099b627be96dmr3925080ejk.44.1693494785954;
        Thu, 31 Aug 2023 08:13:05 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it. [82.57.51.114])
        by smtp.gmail.com with ESMTPSA id i2-20020a1709064ec200b0099bc8db97bcsm852964ejv.131.2023.08.31.08.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:13:05 -0700 (PDT)
Date:   Thu, 31 Aug 2023 17:13:02 +0200
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
Subject: Re: [RFC PATCH v2 2/2] test/vsock: shutdowned socket test
Message-ID: <tejk4hvlsjalsrm4fimm7vojhwhluj6ous3im33kmkydpmv6fi@nvy3twy6gtxy>
References: <20230826175900.3693844-1-avkrasnov@salutedevices.com>
 <20230826175900.3693844-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230826175900.3693844-3-avkrasnov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 08:59:00PM +0300, Arseniy Krasnov wrote:
>This adds two tests for 'shutdown()' call. It checks that SIGPIPE is
>sent when MSG_NOSIGNAL is not set and vice versa. Both flags SHUT_WR
>and SHUT_RD are tested.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> tools/testing/vsock/vsock_test.c | 138 +++++++++++++++++++++++++++++++
> 1 file changed, 138 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 90718c2fd4ea..148fc9c47c50 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -19,6 +19,7 @@
> #include <time.h>
> #include <sys/mman.h>
> #include <poll.h>
>+#include <signal.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -1170,6 +1171,133 @@ static void test_seqpacket_msg_peek_server(const struct test_opts *opts)
> 	return test_msg_peek_server(opts, true);
> }
>
>+static sig_atomic_t have_sigpipe;
>+
>+static void sigpipe(int signo)
>+{
>+	have_sigpipe = 1;
>+}
>+
>+static void test_stream_check_sigpipe(int fd)
>+{
>+	ssize_t res;
>+
>+	have_sigpipe = 0;
>+
>+	res = send(fd, "A", 1, 0);
>+	if (res != -1) {
>+		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (!have_sigpipe) {
>+		fprintf(stderr, "SIGPIPE expected\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	have_sigpipe = 0;
>+
>+	res = send(fd, "A", 1, MSG_NOSIGNAL);
>+	if (res != -1) {
>+		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (have_sigpipe) {
>+		fprintf(stderr, "SIGPIPE not expected\n");
>+		exit(EXIT_FAILURE);
>+	}
>+}
>+
>+static void test_stream_shutwr_client(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	struct sigaction act = {
>+		.sa_handler = sigpipe,
>+	};
>+
>+	sigaction(SIGPIPE, &act, NULL);
>+
>+	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (shutdown(fd, SHUT_WR)) {
>+		perror("shutdown");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	test_stream_check_sigpipe(fd);
>+
>+	control_writeln("CLIENTDONE");
>+
>+	close(fd);
>+}
>+
>+static void test_stream_shutwr_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("CLIENTDONE");
>+
>+	close(fd);
>+}
>+
>+static void test_stream_shutrd_client(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	struct sigaction act = {
>+		.sa_handler = sigpipe,
>+	};
>+
>+	sigaction(SIGPIPE, &act, NULL);
>+
>+	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SHUTRDDONE");
>+
>+	test_stream_check_sigpipe(fd);
>+
>+	control_writeln("CLIENTDONE");
>+
>+	close(fd);
>+}
>+
>+static void test_stream_shutrd_server(const struct test_opts *opts)
>+{
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (shutdown(fd, SHUT_RD)) {
>+		perror("shutdown");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_writeln("SHUTRDDONE");
>+	control_expectln("CLIENTDONE");
>+
>+	close(fd);
>+}
>+
> static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM connection reset",
>@@ -1250,6 +1378,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_seqpacket_msg_peek_client,
> 		.run_server = test_seqpacket_msg_peek_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM SHUT_WR",
>+		.run_client = test_stream_shutwr_client,
>+		.run_server = test_stream_shutwr_server,
>+	},
>+	{
>+		.name = "SOCK_STREAM SHUT_RD",
>+		.run_client = test_stream_shutrd_client,
>+		.run_server = test_stream_shutrd_server,
>+	},
> 	{},
> };
>
>-- 
>2.25.1
>
>

