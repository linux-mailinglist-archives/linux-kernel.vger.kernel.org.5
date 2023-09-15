Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBFB7A2739
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbjIOTcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbjIOTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:32:18 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358CA1BD3;
        Fri, 15 Sep 2023 12:32:13 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id CEE47120006;
        Fri, 15 Sep 2023 22:32:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CEE47120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1694806331;
        bh=l0Loo6vjrMYjpOkEIy8hPGh/WjLnRg5uM0/1NlORcvw=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=rQKhg2dKUTWalvNdwlLxBvRuBV21Xb8UibNnlfq16SNS1pV7JypTG/1bi970I53gb
         C/Ql5SQQbFX/LGxc1wSfLJgpRVuwnMnq63+c0Yj4KxUzk3FLJesCASF/XzNtfc3POg
         s08Gy7Gt0GXaEskM6FNzlxoi0S/tmMaZLRnxl7AycHjCQA8cKgZsgQHWvjFyUI4oWt
         EXRZWgRn0NMwH6gfa82lf+CaUEJwdA/LpiHlhNM3qIdZDsu/bmMkWXxsfHz5Alecch
         YkXZPv84WSqTrxBwLMi87fzGi/sHPEK8uE+cCLUbVReJyhDlUrmnbHBTOLtCLtQOP2
         4P8esKiZbf2Hg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 15 Sep 2023 22:32:11 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 22:32:11 +0300
Message-ID: <ee1382e7-1e0e-a8f5-3703-11d28939df4f@salutedevices.com>
Date:   Fri, 15 Sep 2023 22:25:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH net-next 3/5] vsock/test: add send_buf() utility function
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <oxffffaa@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
References: <20230915121452.87192-1-sgarzare@redhat.com>
 <20230915121452.87192-4-sgarzare@redhat.com>
From:   Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20230915121452.87192-4-sgarzare@redhat.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 530 530 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
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
> Move the code of send_byte() out in a new utility function that
> can be used to send a generic buffer.
> 
> This new function can be used when we need to send a custom
> buffer and not just a single 'A' byte.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tools/testing/vsock/util.h |  2 +
>  tools/testing/vsock/util.c | 90 +++++++++++++++++++++++---------------
>  2 files changed, 56 insertions(+), 36 deletions(-)

Reviewed-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

> 
> diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
> index fe31f267e67e..e5407677ce05 100644
> --- a/tools/testing/vsock/util.h
> +++ b/tools/testing/vsock/util.h
> @@ -42,6 +42,8 @@ int vsock_stream_accept(unsigned int cid, unsigned int port,
>  int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
>  			   struct sockaddr_vm *clientaddrp);
>  void vsock_wait_remote_close(int fd);
> +void send_buf(int fd, const void *buf, size_t len, int flags,
> +	      ssize_t expected_ret);
>  void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret);
>  void send_byte(int fd, int expected_ret, int flags);
>  void recv_byte(int fd, int expected_ret, int flags);
> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> index 2826902706e8..6779d5008b27 100644
> --- a/tools/testing/vsock/util.c
> +++ b/tools/testing/vsock/util.c
> @@ -211,6 +211,59 @@ int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
>  	return vsock_accept(cid, port, clientaddrp, SOCK_SEQPACKET);
>  }
>  
> +/* Transmit bytes from a buffer and check the return value.
> + *
> + * expected_ret:
> + *  <0 Negative errno (for testing errors)
> + *   0 End-of-file
> + *  >0 Success (bytes successfully written)
> + */
> +void send_buf(int fd, const void *buf, size_t len, int flags,
> +	      ssize_t expected_ret)
> +{
> +	ssize_t nwritten = 0;
> +	ssize_t ret;
> +
> +	timeout_begin(TIMEOUT);
> +	do {
> +		ret = send(fd, buf + nwritten, len - nwritten, flags);
> +		timeout_check("send");
> +
> +		if (ret == 0 || (ret < 0 && errno != EINTR))
> +			break;
> +
> +		nwritten += ret;
> +	} while (nwritten < len);
> +	timeout_end();
> +
> +	if (expected_ret < 0) {
> +		if (ret != -1) {
> +			fprintf(stderr, "bogus send(2) return value %zd (expected %zd)\n",
> +				ret, expected_ret);
> +			exit(EXIT_FAILURE);
> +		}
> +		if (errno != -expected_ret) {
> +			perror("send");
> +			exit(EXIT_FAILURE);
> +		}
> +		return;
> +	}
> +
> +	if (ret < 0) {
> +		perror("send");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	if (nwritten != expected_ret) {
> +		if (ret == 0)
> +			fprintf(stderr, "unexpected EOF while sending bytes\n");
> +
> +		fprintf(stderr, "bogus send(2) bytes written %zd (expected %zd)\n",
> +			nwritten, expected_ret);
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
>  /* Receive bytes in a buffer and check the return value.
>   *
>   * expected_ret:
> @@ -273,43 +326,8 @@ void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
>  void send_byte(int fd, int expected_ret, int flags)
>  {
>  	const uint8_t byte = 'A';
> -	ssize_t nwritten;
> -
> -	timeout_begin(TIMEOUT);
> -	do {
> -		nwritten = send(fd, &byte, sizeof(byte), flags);
> -		timeout_check("write");
> -	} while (nwritten < 0 && errno == EINTR);
> -	timeout_end();
> -
> -	if (expected_ret < 0) {
> -		if (nwritten != -1) {
> -			fprintf(stderr, "bogus send(2) return value %zd\n",
> -				nwritten);
> -			exit(EXIT_FAILURE);
> -		}
> -		if (errno != -expected_ret) {
> -			perror("write");
> -			exit(EXIT_FAILURE);
> -		}
> -		return;
> -	}
>  
> -	if (nwritten < 0) {
> -		perror("write");
> -		exit(EXIT_FAILURE);
> -	}
> -	if (nwritten == 0) {
> -		if (expected_ret == 0)
> -			return;
> -
> -		fprintf(stderr, "unexpected EOF while sending byte\n");
> -		exit(EXIT_FAILURE);
> -	}
> -	if (nwritten != sizeof(byte)) {
> -		fprintf(stderr, "bogus send(2) return value %zd\n", nwritten);
> -		exit(EXIT_FAILURE);
> -	}
> +	send_buf(fd, &byte, sizeof(byte), flags, expected_ret);
>  }
>  
>  /* Receive one byte and check the return value.
