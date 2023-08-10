Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B92776D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjHJBUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHJBUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:20:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B88D10D8;
        Wed,  9 Aug 2023 18:20:39 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLpx82lpvzcbZ9;
        Thu, 10 Aug 2023 09:19:24 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 09:20:36 +0800
Subject: Re: [PATCH] USB:bugfix a controller halt error
To:     Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <c3ab029f-f6ab-4b09-b2b5-1cc6a5370d0d@rowland.harvard.edu>
 <bfee90c1-a7ca-27e3-88f9-936f48cd2595@huawei.com>
 <bd440f1d-5ea4-485e-9924-433997765adc@rowland.harvard.edu>
 <77a8ecb4-8099-1826-abd8-4f080d80b07d@huawei.com>
 <73b58ff7-2a0a-43f7-bda9-52b9437f5bc0@rowland.harvard.edu>
 <e983fecd-ff59-e97e-0099-b33685d45d00@suse.com>
 <c827147f-793b-49ae-8549-3c5d4e8a7264@rowland.harvard.edu>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <c80c7065-5cb2-7e49-de71-ea589e588fef@huawei.com>
Date:   Thu, 10 Aug 2023 09:20:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c827147f-793b-49ae-8549-3c5d4e8a7264@rowland.harvard.edu>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/27 23:57, Alan Stern wrote:
> On Thu, Jul 27, 2023 at 05:31:41PM +0200, Oliver Neukum wrote:
>> On 27.07.23 16:42, Alan Stern wrote:
>>> On Thu, Jul 27, 2023 at 03:03:57PM +0800, liulongfang wrote:
>>>> On 2023/7/26 22:20, Alan Stern wrote:
>>
>>>>> It seems to me that something along these lines must be necessary in
>>>>> any case.  Unless the bad memory is cleared somehow, it would never be
>>>>> usable again.  The kernel might deallocate it, then reallocate for
>>>>> another purpose, and then crash when the new user tries to access it.
>>>>>
>>>>> In fact, this scenario could still happen even with your patch, which
>>>>> means the patch doesn't really fix the problem.
>>
>> I suppose in theory you could have something like a bad blocks list
>> just for RAM, but that would really hurt. You'd have to do something
>> about every DMA operation in every driver in theory.
>>
>> Error handling would basically be an intentional memory leak.
> 
> I started out thinking this way, but maybe that's not how it works.  
> Perhaps simply overwriting the part of memory that got the ECC error 
> would clear the error state.  (This may depend on the kind of error, 
> one-time vs. permanent.)
> 
> If that's the case, and if the memory buffer was deallocated without 
> being accessed and then later reallocated, things would be okay.  The 
> routine that reallocated the buffer wouldn't try to read from it before 
> initializing it somehow.
> 
>>>> This patch is only used to prevent data in the buffer from being accessed.
>>>> As long as the data is not accessed, the kernel does not crash.
>>>
>>> I still don't understand.  You haven't provided nearly enough
>>> information.  You should start by answering the questions that Oliver
>>> asked.  Then answer this question:
>>>
>>> The code you are concerned about is this:
>>>
>>> 		r = usb_control_msg(udev, usb_rcvaddr0pipe(),
>>> 				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
>>> 				USB_DT_DEVICE << 8, 0,
>>> 				buf, GET_DESCRIPTOR_BUFSIZE,
>>> 				initial_descriptor_timeout);
>>> 		switch (buf->bMaxPacketSize0) {
>>>
>>> You're worried that if an ECC memory error occurs during the
>>> usb_control_msg transfer, the kernel will crash when the "switch"
>>> statement tries to read the value of buf->bMaxPacketSize0.  That's a
>>> reasonable thing to worry about.
>>
>> Albeit unlikely. If the hardware and implementation are reasonable
>> you'd return a specific error code from the HCD and clean up the
>> RAM in your ecc driver.
>>
>> The fix for USB would then conceptually be something like
>>
>> retryio:
>> 	r = usb_control_msg()
>> 	if (r == -EMEMORYCORRUPTION)
>> 		goto retryio;
> 
> Yes, we could do this, but it's not necessary.  Let's say that the HCD 
> returns -EMEMORYCORRUPTION and the ecc driver cleans up the RAM 
> (probably by resetting its contents to 0, but possibly leaving garbage 
> there instead).  Then when the following code in hub_port_init() tests 
> buf->bMaxPacketSize0, it will see an invalid value and will retry the 
> transfer.
> 
> Or, with low probability, it will see a valid but incorrect value.  If 
> that happens then later transfers using ep0 will fail, causing the hub 
> driver to reiterate the outer loop in hub_port_connect().  Eventually 
> the device will be correctly initialized and enumerated.
> 
> Alan Stern
>

OK, thanks.
Longfang.
> .
> 
