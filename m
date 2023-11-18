Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77CD7EFEF4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 11:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjKRKlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 05:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKRKlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 05:41:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6934D6D
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 02:41:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C91C433C8;
        Sat, 18 Nov 2023 10:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700304074;
        bh=IbhrKQIHbt867NOmvlXVQQ/KhWWhW4WnEbDhXB0zfMc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eJpfNqUS/ufprXVU1rWDyuPlonh5+Ts3e9BtwgX66m32maoUHUJu3smuB7zBHdfe1
         d9SloI8FOsAAlx6nuDUi73c9w5lQSH5lbwYb2HQeFVRkS12sL9y6NyCB/uKm5ERIt2
         CtgrMt0Zc72Q/veFUMGfYyJGjRACEVOZ/oEWLvLoqhqLIwTZElQ4Uh0SbzeOC06jxA
         dkjlVqfjXCqwY+YFNgagFDD0YPQ21XbPbtT7/VHOdhCfYsXGOzqS/+HApU0NdB6p5K
         rqpuoTSxuStU93Vi/lLuW8x3KXfcITBuF3Ii1A1aoD3ALpwRuHKc+mzI3TcOVi/CgY
         1qVkxjuRGNZKQ==
Message-ID: <6a8c44e1-d3a3-49ee-bfbc-8a994a6d4ff8@kernel.org>
Date:   Sat, 18 Nov 2023 12:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] usb: cdns3-ti: add suspend/resume procedures for
 J7200
Content-Language: en-US
To:     =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "Vardhan, Vibhore" <vibhore@ti.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-3-ad1ee714835c@bootlin.com>
 <5080372b-1f48-4cbc-a6c4-8689c28983cb@kernel.org>
 <CWZH66HQZNYM.T623ZOEEE0BK@tleb-bootlin-xps13-01>
 <dad980f3-e032-41e4-a1e4-a16a7f45ff95@kernel.org>
 <CX0GOP07I40N.198G7LJ0HYDBG@tleb-bootlin-xps13-01>
 <bdea68ad-7523-4738-8fa1-b670d81a6b93@kernel.org>
 <CX10D9YX1O1C.30PF317AG065N@tleb-bootlin-xps13-01>
 <3e00b2ad-b58f-4b09-9230-683c58d3bb92@kernel.org>
 <CX15J7B8F8HH.1WZ10OOW31X1H@tleb-bootlin-xps13-01>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <CX15J7B8F8HH.1WZ10OOW31X1H@tleb-bootlin-xps13-01>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2023 16:20, Théo Lebrun wrote:
> Hi Roger,
> 
> On Fri Nov 17, 2023 at 12:51 PM CET, Roger Quadros wrote:
>> On 17/11/2023 12:17, Théo Lebrun wrote:
>>> On Thu Nov 16, 2023 at 10:44 PM CET, Roger Quadros wrote:
>>>> On 16/11/2023 20:56, Théo Lebrun wrote:
>>>>> On Thu Nov 16, 2023 at 1:40 PM CET, Roger Quadros wrote:
>>>>>> On 15/11/2023 17:02, Théo Lebrun wrote:
>>>>>>> On Wed Nov 15, 2023 at 12:37 PM CET, Roger Quadros wrote:
>>>>>>>> You might want to check suspend/resume ops in cdns3-plat and
>>>>>>>> do something similar here.
>>>>>>>
>>>>>>> I'm unsure what you are referring to specifically in cdns3-plat?
>>>>>>
>>>>>> What I meant is, calling pm_runtime_get/put() from system suspend/resume
>>>>>> hooks doesn't seem right.
>>>>>>
>>>>>> How about using something like pm_runtime_forbid(dev) on devices which
>>>>>> loose USB context on runtime suspend e.g. J7200.
>>>>>> So at probe we can get rid of the pm_runtime_get_sync() call.
>>>>>
>>>>> What is the goal of enabling PM runtime to then block (ie forbid) it in
>>>>> its enabled state until system suspend?
>>>>
>>>> If USB controller retains context on runtime_suspend on some platforms
>>>> then we don't want to forbid PM runtime.
>>>
>>> What's the point of runtime PM if nothing is done based on it? This is
>>> the current behavior of the driver.
>>
>> Even if driver doesn't have runtime_suspend/resume hooks, wouldn't 
>> the USB Power domain turn off if we enable runtime PM and allow runtime
>> autosuspend and all children have runtime suspended?
> 
> That cannot be the currently desired behavior as it would require a
> runtime_resume implementation that restores this wrapper to its desired
> state.
> 
> It could however be something that could be implemented. It would be a
> matter of enabling PM runtime and that is it in the probe. No need to
> even init the hardware in the probe. Then the runtime_resume
> implementation would call the new cdns_ti_init_hw.
> 
> This is what the cdns3-imx wrapper is doing in a way, though what they
> need is clocks rather than some registers to be written.
> 
> That all feels like outside the scope of the current patch series
> though.
> 
> My suggestion for V2 would still therefore be to remove all PM runtime
> as it has no impact. It could be added later down the road if cutting
> the power-domain is a goal of yours.

OK let's do this.

-- 
cheers,
-roger
