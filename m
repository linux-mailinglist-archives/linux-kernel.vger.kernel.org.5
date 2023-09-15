Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515497A2744
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbjIOTgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237025AbjIOTf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:35:56 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C811BD3;
        Fri, 15 Sep 2023 12:35:50 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 6BC05120006;
        Fri, 15 Sep 2023 22:35:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6BC05120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1694806549;
        bh=EoVRfIycVq5CUGfnsCjJEvjbWmLF3KZCRHTlIU2ad1c=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=sKafJcg33wiPmnYgdgs/37KbtxssDPZT8snLLUyGWV6qQlRjtm26Jq7J72Dl5S5Es
         VM/Kd5ZF3zZe2YQuqv9wfBLduqClKz5Q5fB0HqHdPwXWbWDq1RKiUlPWq1OnHZR/6b
         Ny2CsL/cFGUkyHcXjovgZloL7udrHky5zOWV+bm8oSLsAvM6UFWc0akTK47JsO24Ls
         a7wH8s6rQzkdw+7K2D4yiDcPPE8Y8kkvlzJX8EYMbSJaIShukRymCFs1sIVFt/uWk8
         Ga5ts0oR5QPLWYP9PfMGNuoBUNZQCw88OBMzEFPha+/NWANPMjLlRMx/S4L7x0c5l+
         0v3t4anhgYrdw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 15 Sep 2023 22:35:49 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 22:35:49 +0300
Message-ID: <97ea5def-d82f-9f8b-fb45-8b37c3d96cb9@salutedevices.com>
Date:   Fri, 15 Sep 2023 22:29:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH net-next 5/5] vsock/test: track bytes in MSG_PEEK test for
 SOCK_SEQPACKET
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <oxffffaa@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
References: <20230915121452.87192-1-sgarzare@redhat.com>
 <20230915121452.87192-6-sgarzare@redhat.com>
From:   Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20230915121452.87192-6-sgarzare@redhat.com>
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

Small remark on 'Subject' - this is not MSG_PEEK test, it is test for sk_buff merging.

Considering that:

Reviewed-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

Thanks, Arseniy

On 15.09.2023 15:14, Stefano Garzarella wrote:
> The test was a bit complicated to read.
> Added variables to keep track of the bytes read and to be read
> in each step. Also some comments.
> 
> The test is unchanged.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tools/testing/vsock/vsock_test.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index b18acbaf92e2..5743dcae2350 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -1002,6 +1002,7 @@ static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
>  
>  static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
>  {
> +	size_t read = 0, to_read;
>  	unsigned char buf[64];
>  	int fd;
>  
> @@ -1014,14 +1015,21 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
>  	control_expectln("SEND0");
>  
>  	/* Read skbuff partially. */
> -	recv_buf(fd, buf, 2, 0, 2);
> +	to_read = 2;
> +	recv_buf(fd, buf + read, to_read, 0, to_read);
> +	read += to_read;
>  
>  	control_writeln("REPLY0");
>  	control_expectln("SEND1");
>  
> -	recv_buf(fd, buf + 2, 8, 0, 8);
> +	/* Read the rest of both buffers */
> +	to_read = strlen(HELLO_STR WORLD_STR) - read;
> +	recv_buf(fd, buf + read, to_read, 0, to_read);
> +	read += to_read;
>  
> -	recv_buf(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT, -EAGAIN);
> +	/* No more bytes should be there */
> +	to_read = sizeof(buf) - read;
> +	recv_buf(fd, buf + read, to_read, MSG_DONTWAIT, -EAGAIN);
>  
>  	if (memcmp(buf, HELLO_STR WORLD_STR, strlen(HELLO_STR WORLD_STR))) {
>  		fprintf(stderr, "pattern mismatch\n");
