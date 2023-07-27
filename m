Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3417647F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjG0HJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjG0HId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:08:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB3A3C31;
        Thu, 27 Jul 2023 00:05:00 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBM9R3RmrztRjS;
        Thu, 27 Jul 2023 15:00:43 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 15:03:58 +0800
Subject: Re: [PATCH] USB:bugfix a controller halt error
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <c3ab029f-f6ab-4b09-b2b5-1cc6a5370d0d@rowland.harvard.edu>
 <bfee90c1-a7ca-27e3-88f9-936f48cd2595@huawei.com>
 <bd440f1d-5ea4-485e-9924-433997765adc@rowland.harvard.edu>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <77a8ecb4-8099-1826-abd8-4f080d80b07d@huawei.com>
Date:   Thu, 27 Jul 2023 15:03:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bd440f1d-5ea4-485e-9924-433997765adc@rowland.harvard.edu>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/26 22:20, Alan Stern wrote:
> On Wed, Jul 26, 2023 at 02:58:18PM +0800, liulongfang wrote:
>> On 2023/7/21 22:57, Alan Stern Wrote:
>>> On Fri, Jul 21, 2023 at 06:00:15PM +0800, liulongfang wrote:
>>>> On systems that use ECC memory. The ECC error of the memory will
>>>> cause the USB controller to halt. It causes the usb_control_msg()
>>>> operation to fail.
>>>
>>> How often does this happen in real life?  (Besides, it seems to me that 
>>> if your system is getting a bunch of ECC memory errors then you've got 
>>> much worse problems than a simple USB failure!)
>>>
>>
>> This problem is on ECC memory platform.
>> In the test scenario, the problem is 100% reproducible.
>>
>>> And why do you worry about ECC memory failures in particular?  Can't 
>>> _any_ kind of failure cause the usb_control_msg() operation to fail?
>>>
>>>> At this point, the returned buffer data is an abnormal value, and
>>>> continuing to use it will lead to incorrect results.
>>>
>>> The driver already contains code to check for abnormal values.  The 
>>> check is not perfect, but it should prevent things from going too 
>>> badly wrong.
>>>
>>
>> If it is ECC memory error. These parameter checks would also
>> actually be invalid.
>>
>>>> Therefore, it is necessary to judge the return value and exit.
>>>>
>>>> Signed-off-by: liulongfang <liulongfang@huawei.com>
>>>
>>> There is a flaw in your reasoning.
>>>
>>> The operation carried out here is deliberately unsafe (for full-speed 
>>> devices).  It is made before we know the actual maxpacket size for ep0, 
>>> and as a result it might return an error code even when it works okay.  
>>> This shouldn't happen, but a lot of USB hardware is unreliable.
>>>
>>> Therefore we must not ignore the result merely because r < 0.  If we do 
>>> that, the kernel might stop working with some devices.
>>>
>> It may be that the handling solution for ECC errors is different from that
>> of the OS platform. On the test platform, after usb_control_msg() fails,
>> reading the memory data of buf will directly lead to kernel crash:
> 
> All right, then here's a proposal for a different way to solve the 
> problem: Change the kernel's handler for the ECC error notification.  
> Have it clear the affected parts of memory, so that the kernel can go 
> ahead and use them without crashing.
> 
> It seems to me that something along these lines must be necessary in 
> any case.  Unless the bad memory is cleared somehow, it would never be 
> usable again.  The kernel might deallocate it, then reallocate for 
> another purpose, and then crash when the new user tries to access it.  
> 
> In fact, this scenario could still happen even with your patch, which 
> means the patch doesn't really fix the problem.
> 

This patch is only used to prevent data in the buffer from being accessed.
As long as the data is not accessed, the kernel does not crash.

thanks,
Longfang.

> Alan Stern
> 
> .
> 
