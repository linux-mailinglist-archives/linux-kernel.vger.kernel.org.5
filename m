Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02ED7A274A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbjIOTiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbjIOThr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:37:47 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F831BD3;
        Fri, 15 Sep 2023 12:37:39 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 6A56B100009;
        Fri, 15 Sep 2023 22:37:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6A56B100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1694806658;
        bh=8r2kiW0lxJDZivI++rMKs4XPF5xmCox99cXA3ODMEFU=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=DfAYDeIhJsRKV8/QRNq15yBATgLUMQoRXHPCzD0+cXUm92njCDBr94OPqZL5WIH/L
         rDXrtqAXSMHxfTw7/4IJGpAl4Ofk4pUZPzzfhgD+PwBqpZsvy6o7Mr5zhKIeGPlFp3
         nM6NQ3TInCPsTZf+SQiaUAYBWi9l07PsrIItDjbgivyAQWJYfT5iGsX8Gv0CZ6COoM
         U6+RCIJ9hsds61BQDY8NWIV25X2KfO3um00krjRRxQmRZlX9CJQwZIg2+NKvwU/k2N
         gNPNPEY5ys/pgHGsswzqSk9qsCtHClqTdKKXnnbeW5v9EiBMibK0H2uhHR6nypESDl
         zC0Bhf4YT7lhg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 15 Sep 2023 22:37:38 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 15 Sep 2023 22:37:37 +0300
Message-ID: <f805f647-24b2-fc66-afd0-9a428947a9df@salutedevices.com>
Date:   Fri, 15 Sep 2023 22:30:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH net-next 0/5] vsock/test: add recv_buf()/send_buf()
 utility functions and some improvements
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>, <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>, <oxffffaa@gmail.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
References: <20230915121452.87192-1-sgarzare@redhat.com>
From:   Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20230915121452.87192-1-sgarzare@redhat.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 530 530 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/09/15 11:00:00
X-KSMG-LinksScanning: Clean, bases: 2023/09/15 11:01:00
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
> We recently found that some tests were failing [1].
> 
> The problem was that we were not waiting for all the bytes correctly,
> so we had a partial read. I had initially suggested using MSG_WAITALL,
> but this could have timeout problems.
> 
> Since we already had send_byte() and recv_byte() that handled the timeout,
> but also the expected return value, I moved that code to two new functions
> that we can now use to send/receive generic buffers.
> 
> The last commit is just an improvement to a test I found difficult to
> understand while using the new functions.
> 
> @Arseniy a review and some testing are really appreciated :-)

Thanks for this cleanup of the tests, I reviewed this patchset and run local
testing, seems everything is ok! :)

Thanks, Arseniy

> 
> [1] https://lore.kernel.org/netdev/63xflnwiohdfo6m3vnrrxgv2ulplencpwug5qqacugqh7xxpu3@tsczkuqgwurb/
> 
> Stefano Garzarella (5):
>   vsock/test: add recv_buf() utility function
>   vsock/test: use recv_buf() in vsock_test.c
>   vsock/test: add send_buf() utility function
>   vsock/test: use send_buf() in vsock_test.c
>   vsock/test: track bytes in MSG_PEEK test for SOCK_SEQPACKET
> 
>  tools/testing/vsock/util.h       |   3 +
>  tools/testing/vsock/util.c       | 124 ++++++++++++--------
>  tools/testing/vsock/vsock_test.c | 187 ++++++-------------------------
>  3 files changed, 117 insertions(+), 197 deletions(-)
> 
