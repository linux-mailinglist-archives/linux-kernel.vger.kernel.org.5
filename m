Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C88764766
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjG0HAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjG0HAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:00:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A11F1FCF;
        Thu, 27 Jul 2023 00:00:10 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RBM4q5z03zNmNc;
        Thu, 27 Jul 2023 14:56:43 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 15:00:06 +0800
Subject: Re: [PATCH] USB:bugfix a controller halt error
To:     Oliver Neukum <oneukum@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230721100015.27124-1-liulongfang@huawei.com>
 <2023072153-module-wannabe-5637@gregkh>
 <bc2cd818-c7ad-9061-29ce-f5390d44d8ab@huawei.com>
 <2023072629-unblended-perky-4732@gregkh>
 <05f0dc06-5a16-fba7-a256-b1d9dea989de@suse.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <f03958f4-de73-ec43-fa13-02727b6018c3@huawei.com>
Date:   Thu, 27 Jul 2023 15:00:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <05f0dc06-5a16-fba7-a256-b1d9dea989de@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On 2023/7/26 19:16, Oliver Neukum wrote:
> On 26.07.23 09:18, Greg KH wrote:
>> On Wed, Jul 26, 2023 at 02:44:01PM +0800, liulongfang wrote:
> 
>>> This is a test conducted under a special test scenario.
>>> ECC memory errors are caused by some test tools.
> 
> So we are looking at a corner case here.
> 
> I think we need to step back, get an overview. And I would
> like to apologize for not being entirely helpful.
> 
> I see a theoretical possibility here of what is going wrong
> and an extremely theoretical bug, but it would be very good
> if you could describe your test setup.
> 
> So. You are inducing simulated memory errors.
> For this scenario to make any sense your failure must be
> 
> 1. temporary - that is you have detected memory corruption but the RAM cell is not broken
> 2. unrecoverable - that is we have lost data
> 3. locateable - that is you know it hit the buffer of this operation and only it
> 
> Am I correct so far?
>
You are right about the testing process.
But this problem can exist in the real environment, just the probability of
occurrence is very low.
Use a test tool just to make it easier to trigger it.

> Furthermore your system reports the error to the HC, so that in last
> consequence the transfer fails. Right?
> 
>> What memory is failing, and why does just this single check matter in
>> the whole kernel?
> 
> The difference here is that we are deliberately ignoring errors.
>  
>> If hardware is broken, and failing, it's not the job of the kernel to
>> protect against that, is it?  Shouldn't the ECC memory controller have
>> properly notified the kernel of the fault
> 
> Definitely it should. But this whole discussion makes only sense
> if exactly that happens.
>
Our test tool only simulates that external interference destroys this part
of the data in the buffer on the ECC memory. Even without this testing tool.
This problem may also occur on real business hardware devices.

>> and reset the machine because
>> it is now in an undetermined state?
> 
> No. It is not in an undetermined state if your detection logic is good enough.
> 
>     Regards
>         Oliver
> .
> 
Thanks,
Longfang.
