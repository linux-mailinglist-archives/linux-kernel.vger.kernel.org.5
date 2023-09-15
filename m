Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44C27A2741
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbjIOTd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbjIOTdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:33:41 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60D61FC9;
        Fri, 15 Sep 2023 12:33:35 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 6D27C100009;
        Fri, 15 Sep 2023 22:33:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6D27C100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1694806414;
        bh=v8qrWHEpktj/HI37WHvjpCicfK73rrI34hJOHObgZ+g=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=be8gWYSd5t78hgY0ruFA6FlGcYM/mn1oGHHMdKI8z7WnkQYVPgZ4+s+DVECBxXvUx
         02JgTRhNdNds2UHJkPyQLuBoJYOEDKGJa8EC/I6YP2z2D20ni46yKSICbUQcq6G4zx
         MD6xOsU7mRY14o3Zw9p1LgXOA+V9ow3k8hReIBvksW9RE6esjk1Wnfr7pLzk40rJm9
         C74TU+BGz7NC1m9fGfqgBPCyC/ZuTKq87pVZ+j/Mp1CxPyIy2b02FAsJ3Xhk81Kt3L
         UZdJjUHR7B1cDf/t3QRmxHkFxim+GDn+x59xFSEYrrSE0prv9Dr0lTbnbKLpPzqM6w
         FyMpEUiNx+lhw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 15 Sep 2023 22:33:34 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 22:33:33 +0300
Message-ID: <fa40fd12-a0dd-0fdf-8f35-c842fca27207@salutedevices.com>
Date:   Fri, 15 Sep 2023 22:26:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH net-next 4/5] vsock/test: use send_buf() in vsock_test.c
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <oxffffaa@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
References: <20230915121452.87192-1-sgarzare@redhat.com>
 <20230915121452.87192-5-sgarzare@redhat.com>
From:   Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20230915121452.87192-5-sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179903 [Sep 15 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 530 530 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/09/15 17:43:00 #21898246
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.09.2023 15:14, Stefano Garzarella wrote:
> We have a very common pattern used in vsock_test that we can
> now replace with the new send_buf().
> 
> This allows us to reuse the code we already had to check the
> actual return value and wait for all the bytes to be sent with
> an appropriate timeout.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tools/testing/vsock/vsock_test.c | 75 ++++----------------------------
>  1 file changed, 9 insertions(+), 66 deletions(-)

Reviewed-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

> 
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index d1dcbaeb477a..b18acbaf92e2 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -261,7 +261,6 @@ static void test_msg_peek_client(const struct test_opts *opts,
>  				 bool seqpacket)
>  {
>  	unsigned char buf[MSG_PEEK_BUF_LEN];
> -	ssize_t send_size;
>  	int fd;
>  	int i;
>  
> @@ -280,17 +279,7 @@ static void test_msg_peek_client(const struct test_opts *opts,
>  
>  	control_expectln("SRVREADY");
>  
> -	send_size = send(fd, buf, sizeof(buf), 0);
> -
> -	if (send_size < 0) {
> -		perror("send");
> -		exit(EXIT_FAILURE);
> -	}
> -
> -	if (send_size != sizeof(buf)) {
> -		fprintf(stderr, "Invalid send size %zi\n", send_size);
> -		exit(EXIT_FAILURE);
> -	}
> +	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>  
>  	close(fd);
>  }
> @@ -385,7 +374,6 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>  	msg_count = SOCK_BUF_SIZE / MAX_MSG_SIZE;
>  
>  	for (int i = 0; i < msg_count; i++) {
> -		ssize_t send_size;
>  		size_t buf_size;
>  		int flags;
>  		void *buf;
> @@ -413,17 +401,7 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>  			flags = 0;
>  		}
>  
> -		send_size = send(fd, buf, buf_size, flags);
> -
> -		if (send_size < 0) {
> -			perror("send");
> -			exit(EXIT_FAILURE);
> -		}
> -
> -		if (send_size != buf_size) {
> -			fprintf(stderr, "Invalid send size\n");
> -			exit(EXIT_FAILURE);
> -		}
> +		send_buf(fd, buf, buf_size, flags, buf_size);
>  
>  		/*
>  		 * Hash sum is computed at both client and server in
> @@ -524,10 +502,7 @@ static void test_seqpacket_msg_trunc_client(const struct test_opts *opts)
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	if (send(fd, buf, sizeof(buf), 0) != sizeof(buf)) {
> -		perror("send failed");
> -		exit(EXIT_FAILURE);
> -	}
> +	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>  
>  	control_writeln("SENDDONE");
>  	close(fd);
> @@ -649,7 +624,6 @@ static void test_seqpacket_timeout_server(const struct test_opts *opts)
>  static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
>  {
>  	unsigned long sock_buf_size;
> -	ssize_t send_size;
>  	socklen_t len;
>  	void *data;
>  	int fd;
> @@ -676,18 +650,7 @@ static void test_seqpacket_bigmsg_client(const struct test_opts *opts)
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	send_size = send(fd, data, sock_buf_size, 0);
> -	if (send_size != -1) {
> -		fprintf(stderr, "expected 'send(2)' failure, got %zi\n",
> -			send_size);
> -		exit(EXIT_FAILURE);
> -	}
> -
> -	if (errno != EMSGSIZE) {
> -		fprintf(stderr, "expected EMSGSIZE in 'errno', got %i\n",
> -			errno);
> -		exit(EXIT_FAILURE);
> -	}
> +	send_buf(fd, data, sock_buf_size, 0, -EMSGSIZE);
>  
>  	control_writeln("CLISENT");
>  
> @@ -741,15 +704,9 @@ static void test_seqpacket_invalid_rec_buffer_client(const struct test_opts *opt
>  	memset(buf1, BUF_PATTERN_1, buf_size);
>  	memset(buf2, BUF_PATTERN_2, buf_size);
>  
> -	if (send(fd, buf1, buf_size, 0) != buf_size) {
> -		perror("send failed");
> -		exit(EXIT_FAILURE);
> -	}
> +	send_buf(fd, buf1, buf_size, 0, buf_size);
>  
> -	if (send(fd, buf2, buf_size, 0) != buf_size) {
> -		perror("send failed");
> -		exit(EXIT_FAILURE);
> -	}
> +	send_buf(fd, buf2, buf_size, 0, buf_size);
>  
>  	close(fd);
>  }
> @@ -972,7 +929,6 @@ static void test_inv_buf_client(const struct test_opts *opts, bool stream)
>  static void test_inv_buf_server(const struct test_opts *opts, bool stream)
>  {
>  	unsigned char data[INV_BUF_TEST_DATA_LEN] = {0};
> -	ssize_t res;
>  	int fd;
>  
>  	if (stream)
> @@ -985,11 +941,7 @@ static void test_inv_buf_server(const struct test_opts *opts, bool stream)
>  		exit(EXIT_FAILURE);
>  	}
>  
> -	res = send(fd, data, sizeof(data), 0);
> -	if (res != sizeof(data)) {
> -		fprintf(stderr, "unexpected send(2) result %zi\n", res);
> -		exit(EXIT_FAILURE);
> -	}
> +	send_buf(fd, data, sizeof(data), 0, sizeof(data));
>  
>  	control_writeln("SENDDONE");
>  
> @@ -1023,7 +975,6 @@ static void test_seqpacket_inv_buf_server(const struct test_opts *opts)
>  
>  static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
>  {
> -	ssize_t res;
>  	int fd;
>  
>  	fd = vsock_stream_connect(opts->peer_cid, 1234);
> @@ -1033,22 +984,14 @@ static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
>  	}
>  
>  	/* Send first skbuff. */
> -	res = send(fd, HELLO_STR, strlen(HELLO_STR), 0);
> -	if (res != strlen(HELLO_STR)) {
> -		fprintf(stderr, "unexpected send(2) result %zi\n", res);
> -		exit(EXIT_FAILURE);
> -	}
> +	send_buf(fd, HELLO_STR, strlen(HELLO_STR), 0, strlen(HELLO_STR));
>  
>  	control_writeln("SEND0");
>  	/* Peer reads part of first skbuff. */
>  	control_expectln("REPLY0");
>  
>  	/* Send second skbuff, it will be appended to the first. */
> -	res = send(fd, WORLD_STR, strlen(WORLD_STR), 0);
> -	if (res != strlen(WORLD_STR)) {
> -		fprintf(stderr, "unexpected send(2) result %zi\n", res);
> -		exit(EXIT_FAILURE);
> -	}
> +	send_buf(fd, WORLD_STR, strlen(WORLD_STR), 0, strlen(WORLD_STR));
>  
>  	control_writeln("SEND1");
>  	/* Peer reads merged skbuff packet. */
