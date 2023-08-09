Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797417752DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjHIG1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjHIG1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:27:00 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACED61BFA;
        Tue,  8 Aug 2023 23:26:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VpNrcmf_1691562412;
Received: from 30.97.48.62(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VpNrcmf_1691562412)
          by smtp.aliyun-inc.com;
          Wed, 09 Aug 2023 14:26:53 +0800
Message-ID: <f808a0c7-013d-9999-8c2d-435609f9fde4@linux.alibaba.com>
Date:   Wed, 9 Aug 2023 14:26:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] serial: sprd: Support 12 uart ports
To:     wenhua lin <wenhua.lin1994@gmail.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
References: <20230807080726.7190-1-Wenhua.Lin@unisoc.com>
 <3554a99d-339f-39f9-111d-040025096f97@linux.alibaba.com>
 <CAB9BWhdh8CXuWAQGir=9QqLPdVaN8hgmqii9Da=buSj=9BWJaw@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAB9BWhdh8CXuWAQGir=9QqLPdVaN8hgmqii9Da=buSj=9BWJaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2023 1:52 PM, wenhua lin wrote:
> The change of the max ports is to adapt to an new
> SPRD serial hardware,also is backward-compatibility with old hardware.

Again, DO NOT top-posting! Thanks.

>>
>> On 8/7/2023 4:07 PM, Wenhua Lin wrote:
>>> From: Wenhua Lin <wenhua.lin@unisoc.com>
>>>
>>> Support 12 uart ports, which can solve the problem
>>> of insufficient uart ports.
>>
>> This sounds incorrect to me.
>> If this is a software bug, please add a Fixes tag to backport for stable
>> kernels. If the change of the max ports is only avaliable on the new
>> SPRD serial hardware, you should ensure the change is
>> backward-compatibility with old hardware.

This is not backward-compatibility. Please see 'sprd_uart_driver' 
structure as below:

static struct uart_driver sprd_uart_driver = {
	.owner = THIS_MODULE,
	.driver_name = "sprd_serial",
	.dev_name = SPRD_TTY_NAME,
	.major = 0,
	.minor = 0,
	.nr = UART_NR_MAX,
	.cons = SPRD_CONSOLE,
};

That means you will still register 12 UART ports in the tty for old 
serial hardwares which actually only support 8 UART ports, and if users 
want to use another 4 ports which are not supported in the hardware, 
then system crashes.

So I think you should add a SoC data in 'serial_ids' to change the 
number of UART port according to different SoC.

>>> Signed-off-by: Wenhua Lin <wenhua.lin@unisoc.com>
>>> ---
>>>    drivers/tty/serial/sprd_serial.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
>>> index b58f51296ace..2774df490899 100644
>>> --- a/drivers/tty/serial/sprd_serial.c
>>> +++ b/drivers/tty/serial/sprd_serial.c
>>> @@ -22,7 +22,7 @@
>>>    #include <linux/tty_flip.h>
>>>
>>>    /* device name */
>>> -#define UART_NR_MAX          8
>>> +#define UART_NR_MAX          12
>>>    #define SPRD_TTY_NAME               "ttyS"
>>>    #define SPRD_FIFO_SIZE              128
>>>    #define SPRD_DEF_RATE               26000000
