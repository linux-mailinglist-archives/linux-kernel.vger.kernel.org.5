Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B80D7AA691
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjIVBeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjIVBeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:34:09 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AD96DCF;
        Thu, 21 Sep 2023 18:34:02 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id AEF146031B0B7;
        Fri, 22 Sep 2023 09:33:53 +0800 (CST)
Message-ID: <902e29df-785c-b194-44a9-72d1691813dd@nfschina.com>
Date:   Fri, 22 Sep 2023 09:33:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 wireless-next 2/9] carl9170: remove unnecessary (void*)
 conversions
Content-Language: en-US
To:     Christian Lamparter <chunkeey@gmail.com>, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
In-Reply-To: <e544d992-cddd-4ade-81ef-2eed4f3681e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christian

On 2023/9/21 03:00, Christian Lamparter wrote:

> On 9/19/23 06:49, Wu Yunchuan wrote:
>> No need cast (void *) to (struct ar9170 *), (u8 *) or (void*).
>
> hmm, your mail went into the spam folder. Good thing I checked.
>
Sometimes mail didn't work :(.
> From what I remember: The reason why these casts were added in
> carl9170 was because of compiler warnings/complaints.
> Current gcc compilers should be OK (given that the kernel-bot
> didn't react, or went your Mail to their spam-folder as well?)
> but have you checked these older versions?
>
My gcc version is 10.2.1. And this seems work when gcc version is 
5.4(ubuntu 16.04) or 4.84(Ubuntu 14.04）.
I can't  compile Linux under Ubuntu 16.04 because of some compatibility 
problems.

So I test a simple demo like this:


void *p_void = NULL;
long var_long = 5;
long *p_long = &var_long;
p_void = p_long;

This works fine.

> (In 6.5.0 Documentation/admin-guide/README.rst states that one
> should have at least gcc 5.1 - could you run with those and
> see if C=2 W=1 passes?)
Oh, I want to do this, but I can't compile or install gcc 5.1 in my 
computer.
There are some compatibility problems. I hope I can deal this problem 
next week.

Wu Yunchan

>
> Regards,
> Christian
>
>> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
>> ---
>>   drivers/net/wireless/ath/carl9170/usb.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/carl9170/usb.c 
>> b/drivers/net/wireless/ath/carl9170/usb.c
>> index e4eb666c6eea..c4edf8355941 100644
>> --- a/drivers/net/wireless/ath/carl9170/usb.c
>> +++ b/drivers/net/wireless/ath/carl9170/usb.c
>> @@ -178,7 +178,7 @@ static void carl9170_usb_tx_data_complete(struct 
>> urb *urb)
>>       switch (urb->status) {
>>       /* everything is fine */
>>       case 0:
>> -        carl9170_tx_callback(ar, (void *)urb->context);
>> +        carl9170_tx_callback(ar, urb->context);
>>           break;
>>         /* disconnect */
>> @@ -369,7 +369,7 @@ void carl9170_usb_handle_tx_err(struct ar9170 *ar)
>>       struct urb *urb;
>>         while ((urb = usb_get_from_anchor(&ar->tx_err))) {
>> -        struct sk_buff *skb = (void *)urb->context;
>> +        struct sk_buff *skb = urb->context;
>>             carl9170_tx_drop(ar, skb);
>>           carl9170_tx_callback(ar, skb);
>> @@ -397,7 +397,7 @@ static void carl9170_usb_tasklet(struct 
>> tasklet_struct *t)
>>     static void carl9170_usb_rx_complete(struct urb *urb)
>>   {
>> -    struct ar9170 *ar = (struct ar9170 *)urb->context;
>> +    struct ar9170 *ar = urb->context;
>>       int err;
>>         if (WARN_ON_ONCE(!ar))
>> @@ -559,7 +559,7 @@ static int carl9170_usb_flush(struct ar9170 *ar)
>>       int ret, err = 0;
>>         while ((urb = usb_get_from_anchor(&ar->tx_wait))) {
>> -        struct sk_buff *skb = (void *)urb->context;
>> +        struct sk_buff *skb = urb->context;
>>           carl9170_tx_drop(ar, skb);
>>           carl9170_tx_callback(ar, skb);
>>           usb_free_urb(urb);
>> @@ -668,7 +668,7 @@ int carl9170_exec_cmd(struct ar9170 *ar, const 
>> enum carl9170_cmd_oids cmd,
>>           memcpy(ar->cmd.data, payload, plen);
>>         spin_lock_bh(&ar->cmd_lock);
>> -    ar->readbuf = (u8 *)out;
>> +    ar->readbuf = out;
>>       ar->readlen = outlen;
>>       spin_unlock_bh(&ar->cmd_lock);
>
