Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255C67824DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjHUHul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjHUHuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:50:40 -0400
X-Greylist: delayed 1383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 00:50:38 PDT
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F43392;
        Mon, 21 Aug 2023 00:50:38 -0700 (PDT)
Received: from 212-39-89-85.ip.btc-net.bg ([212.39.89.85] helo=[192.168.14.227])
        by www.kot-begemot.co.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1qXzJj-001Ag5-3l; Mon, 21 Aug 2023 07:27:15 +0000
Message-ID: <02404242-ab8a-5300-ec76-fb13dc3fb403@cambridgegreys.com>
Date:   Mon, 21 Aug 2023 08:27:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4] um: vector: Fix exception handling in
 vector_eth_configure()
Content-Language: en-US
To:     Richard Weinberger <richard@nod.at>, Minjie Du <duminjie@vivo.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        opensource kernel <opensource.kernel@vivo.com>
References: <20230706013911.695-1-duminjie@vivo.com>
 <888265629.6490567.1692478887611.JavaMail.zimbra@nod.at>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <888265629.6490567.1692478887611.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/08/2023 22:01, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> The resource cleanup was incomplete in the implementation
>> of the function "vector_eth_configure".
>> Thus replace the jump target
>> "out_undo_user_init" by "out_free_netdev".
>> Delate the orphan function "out_undo_user_init"
>>
>> PATCH v1-v3: Modify the patch format.
>>
>> Signed-off-by: Minjie Du <duminjie@vivo.com>
>> ---
>> arch/um/drivers/vector_kern.c | 4 +---
>> 1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
>> index 131b7cb29..7ae6ab8df 100644
>> --- a/arch/um/drivers/vector_kern.c
>> +++ b/arch/um/drivers/vector_kern.c
>> @@ -1646,7 +1646,7 @@ static void vector_eth_configure(
>> 	err = register_netdevice(dev);
>> 	rtnl_unlock();
>> 	if (err)
>> -		goto out_undo_user_init;
>> +		goto out_free_netdev;
>>
>> 	spin_lock(&vector_devices_lock);
>> 	list_add(&device->list, &vector_devices);
>> @@ -1654,8 +1654,6 @@ static void vector_eth_configure(
>>
>> 	return;
>>
>> -out_undo_user_init:
>> -	return;
> 
> I don't think this is correct.
> vector_eth_configure() cannot communicate the failure since it is of type void.
> So, vector_remove() will run and will call unregister_netdev(). That can cause a double-free.

vector_remove() will be called only once per device. It checks if the 
device is in the device list and if it is not - bails. If it is in the 
list it removes it from there and calls unregister_netdev() after that.

So, unless I am missing something, there is no harm here - unregister 
will not be called for a device that failed to register, because the 
list is updated only if the device has registered successfully.

However, on second read - if register fails, the current code leaks a 
*device which was alloc-ed in the beginning of configure. So even if we 
skip free_netdev, which invokes remove we still need to free that *device.

> 
> Thanks,
> //richard
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
