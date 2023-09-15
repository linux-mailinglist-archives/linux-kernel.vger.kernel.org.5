Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1247A2736
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbjIOTbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbjIOTbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:31:01 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365D719A9;
        Fri, 15 Sep 2023 12:30:55 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 6D2A4100009;
        Fri, 15 Sep 2023 22:30:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6D2A4100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1694806253;
        bh=BJmNIIu0BtHxmHFhqg1tKtUOcEa7uuEFeK9C4qQIVSc=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=cIEuq7XrvX4jRTjQvS9oXnJ5fddSbuAVqn127C/53EGQRV+Z0twCAkGFwl6TKKdhG
         EGKDRrxKUQ/cyvUmjqWLqsTbu+WDzBf8/3du/McHcvpdV0KbVP/XMHGdXPcElmtglV
         LGO0kizM5q0nnCLNYRLfyTc6AocoD4c2LDHmScE+ilxYt2j/I3eZ6F7eQOSSopMhPM
         dvz+HVPwHMtjUBiiS2g59SSD3QwxtlSdsOeqmgjtuTZFooNcNEoJPnd8nZze18wk+0
         H1LOgxQxKDC/IL64aBOZWsnCcIbwae1KaDlnxKs03iQKQTYKeC8fwPY7SEP+KXF0s9
         IUJOyc1Lf9Fwg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 15 Sep 2023 22:30:53 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 22:30:53 +0300
Message-ID: <77156ae4-3a81-8fe0-15c9-0d7bfc66328f@salutedevices.com>
Date:   Fri, 15 Sep 2023 22:24:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH net-next 2/5] vsock/test: use recv_buf() in vsock_test.c
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <oxffffaa@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
References: <20230915121452.87192-1-sgarzare@redhat.com>
 <20230915121452.87192-3-sgarzare@redhat.com>
From:   Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20230915121452.87192-3-sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
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
X-KSMG-AntiSpam-Info: LuaCore: 530 530 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
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
> now replace with the new recv_buf().
> 
> This allows us to reuse the code we already had to check the
> actual return value and wait for all bytes to be received with
> an appropriate timeout.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tools/testing/vsock/vsock_test.c | 104 +++++--------------------------
>  1 file changed, 17 insertions(+), 87 deletions(-)

Reviewed-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

> 
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 90718c2fd4ea..d1dcbaeb477a 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -301,7 +301,6 @@ static void test_msg_peek_server(const struct test_opts *opts,
>  	unsigned char buf_half[MSG_PEEK_BUF_LEN / 2];
>  	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
>  	unsigned char buf_peek[MSG_PEEK_BUF_LEN];
> -	ssize_t res;
>  	int fd;
>  
>  	if (seqpacket)
> @@ -315,34 +314,16 @@ static void test_msg_peek_server(const struct test_opts *opts,
>  	}
>  
>  	/* Peek from empty socket. */
> -	res = recv(fd, buf_peek, sizeof(buf_peek), MSG_PEEK | MSG_DONTWAIT);
> -	if (res != -1) {
> -		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);
> -		exit(EXIT_FAILURE);
> -	}
> -
> -	if (errno != EAGAIN) {
> -		perror("EAGAIN expected");
> -		exit(EXIT_FAILURE);
> -	}
> +	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK | MSG_DONTWAIT,
> +		 -EAGAIN);
>  
>  	control_writeln("SRVREADY");
>  
>  	/* Peek part of data. */
> -	res = recv(fd, buf_half, sizeof(buf_half), MSG_PEEK);
> -	if (res != sizeof(buf_half)) {
> -		fprintf(stderr, "recv(2) + MSG_PEEK, expected %zu, got %zi\n",
> -			sizeof(buf_half), res);
> -		exit(EXIT_FAILURE);
> -	}
> +	recv_buf(fd, buf_half, sizeof(buf_half), MSG_PEEK, sizeof(buf_half));
>  
>  	/* Peek whole data. */
> -	res = recv(fd, buf_peek, sizeof(buf_peek), MSG_PEEK);
> -	if (res != sizeof(buf_peek)) {
> -		fprintf(stderr, "recv(2) + MSG_PEEK, expected %zu, got %zi\n",
> -			sizeof(buf_peek), res);
> -		exit(EXIT_FAILURE);
> -	}
> +	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK, sizeof(buf_peek));
>  
>  	/* Compare partial and full peek. */
>  	if (memcmp(buf_half, buf_peek, sizeof(buf_half))) {
> @@ -355,22 +336,11 @@ static void test_msg_peek_server(const struct test_opts *opts,
>  		 * so check it with MSG_PEEK. We must get length
>  		 * of the message.
>  		 */
> -		res = recv(fd, buf_half, sizeof(buf_half), MSG_PEEK |
> -			   MSG_TRUNC);
> -		if (res != sizeof(buf_peek)) {
> -			fprintf(stderr,
> -				"recv(2) + MSG_PEEK | MSG_TRUNC, exp %zu, got %zi\n",
> -				sizeof(buf_half), res);
> -			exit(EXIT_FAILURE);
> -		}
> +		recv_buf(fd, buf_half, sizeof(buf_half), MSG_PEEK | MSG_TRUNC,
> +			 sizeof(buf_peek));
>  	}
>  
> -	res = recv(fd, buf_normal, sizeof(buf_normal), 0);
> -	if (res != sizeof(buf_normal)) {
> -		fprintf(stderr, "recv(2), expected %zu, got %zi\n",
> -			sizeof(buf_normal), res);
> -		exit(EXIT_FAILURE);
> -	}
> +	recv_buf(fd, buf_normal, sizeof(buf_normal), 0, sizeof(buf_normal));
>  
>  	/* Compare full peek and normal read. */
>  	if (memcmp(buf_peek, buf_normal, sizeof(buf_peek))) {
> @@ -900,7 +870,6 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
>  	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
>  	char buf[RCVLOWAT_BUF_SIZE];
>  	struct pollfd fds;
> -	ssize_t read_res;
>  	short poll_flags;
>  	int fd;
>  
> @@ -955,12 +924,7 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
>  	/* Use MSG_DONTWAIT, if call is going to wait, EAGAIN
>  	 * will be returned.
>  	 */
> -	read_res = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
> -	if (read_res != RCVLOWAT_BUF_SIZE) {
> -		fprintf(stderr, "Unexpected recv result %zi\n",
> -			read_res);
> -		exit(EXIT_FAILURE);
> -	}
> +	recv_buf(fd, buf, sizeof(buf), MSG_DONTWAIT, RCVLOWAT_BUF_SIZE);
>  
>  	control_writeln("POLLDONE");
>  
> @@ -972,7 +936,7 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
>  static void test_inv_buf_client(const struct test_opts *opts, bool stream)
>  {
>  	unsigned char data[INV_BUF_TEST_DATA_LEN] = {0};
> -	ssize_t ret;
> +	ssize_t expected_ret;
>  	int fd;
>  
>  	if (stream)
> @@ -988,39 +952,18 @@ static void test_inv_buf_client(const struct test_opts *opts, bool stream)
>  	control_expectln("SENDDONE");
>  
>  	/* Use invalid buffer here. */
> -	ret = recv(fd, NULL, sizeof(data), 0);
> -	if (ret != -1) {
> -		fprintf(stderr, "expected recv(2) failure, got %zi\n", ret);
> -		exit(EXIT_FAILURE);
> -	}
> -
> -	if (errno != EFAULT) {
> -		fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
> -		exit(EXIT_FAILURE);
> -	}
> -
> -	ret = recv(fd, data, sizeof(data), MSG_DONTWAIT);
> +	recv_buf(fd, NULL, sizeof(data), 0, -EFAULT);
>  
>  	if (stream) {
>  		/* For SOCK_STREAM we must continue reading. */
> -		if (ret != sizeof(data)) {
> -			fprintf(stderr, "expected recv(2) success, got %zi\n", ret);
> -			exit(EXIT_FAILURE);
> -		}
> -		/* Don't check errno in case of success. */
> +		expected_ret = sizeof(data);
>  	} else {
>  		/* For SOCK_SEQPACKET socket's queue must be empty. */
> -		if (ret != -1) {
> -			fprintf(stderr, "expected recv(2) failure, got %zi\n", ret);
> -			exit(EXIT_FAILURE);
> -		}
> -
> -		if (errno != EAGAIN) {
> -			fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
> -			exit(EXIT_FAILURE);
> -		}
> +		expected_ret = -EAGAIN;
>  	}
>  
> +	recv_buf(fd, data, sizeof(data), MSG_DONTWAIT, expected_ret);
> +
>  	control_writeln("DONE");
>  
>  	close(fd);
> @@ -1117,7 +1060,6 @@ static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
>  static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
>  {
>  	unsigned char buf[64];
> -	ssize_t res;
>  	int fd;
>  
>  	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
> @@ -1129,26 +1071,14 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
>  	control_expectln("SEND0");
>  
>  	/* Read skbuff partially. */
> -	res = recv(fd, buf, 2, 0);
> -	if (res != 2) {
> -		fprintf(stderr, "expected recv(2) returns 2 bytes, got %zi\n", res);
> -		exit(EXIT_FAILURE);
> -	}
> +	recv_buf(fd, buf, 2, 0, 2);
>  
>  	control_writeln("REPLY0");
>  	control_expectln("SEND1");
>  
> -	res = recv(fd, buf + 2, sizeof(buf) - 2, 0);
> -	if (res != 8) {
> -		fprintf(stderr, "expected recv(2) returns 8 bytes, got %zi\n", res);
> -		exit(EXIT_FAILURE);
> -	}
> +	recv_buf(fd, buf + 2, 8, 0, 8);
>  
> -	res = recv(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT);
> -	if (res != -1) {
> -		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);
> -		exit(EXIT_FAILURE);
> -	}
> +	recv_buf(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT, -EAGAIN);
>  
>  	if (memcmp(buf, HELLO_STR WORLD_STR, strlen(HELLO_STR WORLD_STR))) {
>  		fprintf(stderr, "pattern mismatch\n");
