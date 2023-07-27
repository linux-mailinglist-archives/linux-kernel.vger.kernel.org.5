Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491C87644BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjG0ECt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjG0ECq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:02:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0EA26B8;
        Wed, 26 Jul 2023 21:02:45 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RBH876WXhzNmXM;
        Thu, 27 Jul 2023 11:59:19 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 12:02:42 +0800
Subject: Re: [PATCH] USB:bugfix a controller halt error
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <2023072153-module-wannabe-5637@gregkh>
 <bc2cd818-c7ad-9061-29ce-f5390d44d8ab@huawei.com>
 <2023072629-unblended-perky-4732@gregkh>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <e6c676d8-0175-e07f-3416-f3b88d0ea4e9@huawei.com>
Date:   Thu, 27 Jul 2023 12:02:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2023072629-unblended-perky-4732@gregkh>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/26 15:18, Greg KH wrote:
> On Wed, Jul 26, 2023 at 02:44:01PM +0800, liulongfang wrote:
>> On 2023/7/21 19:08, Greg KH Wrote:
>>> On Fri, Jul 21, 2023 at 06:00:15PM +0800, liulongfang wrote:
>>>> On systems that use ECC memory. The ECC error of the memory will
>>>> cause the USB controller to halt. It causes the usb_control_msg()
>>>> operation to fail.
>>>
>>> Why does ECC memory matter here?
>>>
>>
>> This is a test conducted under a special test scenario.
>> ECC memory errors are caused by some test tools.
> 
> What memory is failing, and why does just this single check matter in
> the whole kernel?
> 
> If hardware is broken, and failing, it's not the job of the kernel to
> protect against that, is it?  Shouldn't the ECC memory controller have
> properly notified the kernel of the fault and reset the machine because
> it is now in an undetermined state?
> 
>>> Are you sure this is correct?  How was this tested?  Seems to me that
>>> this will still return "success" if this code path ever happens, what am
>>
>> You are right. I made a patch error here. The code modification should be like this:
>> if (r < 0) {
>> 	retval = r;
>> 	kfree(buf);
>> 	goto fail;
>> }
> 
> This means that you didn't test this change at all, so I don't really
> think it is needed :(
> 
In fact, currently we have not added this retval assignment operation.
Due to the circumvention of buf access during patch testing.
This problem causes calltrace not to trigger.

Thanks.
Longfang.
> thanks,
> 
> greg k-h
> .
> 
