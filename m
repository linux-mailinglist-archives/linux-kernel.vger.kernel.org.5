Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71457EF21F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345781AbjKQLwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjKQLwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:52:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C338D5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:51:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A6BC433C7;
        Fri, 17 Nov 2023 11:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700221916;
        bh=5ZHexz3dAhJlMDGTudHyhTd6kwWzrrePNKd8DrxTuEo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KZGdU4Pu42n4aaFkPPt5SUe0neGnHjVCJoi1rFNP07vq5JqEsYQkzXoXTZxO25mfy
         aX++K93oA2GkRMwgUp71LAhNBP8FSCr554nZDZaMXlPgLBLsb1nOX3LP2x7FXniJ7O
         XXhIOOLCJcTiQsIuadxtOAMXNejf7T8n19zTVt0JoXqBrI5t0O0+GMgv0dDom+HRDU
         KMAWxjZRFe81M88eQQEmzqeslO1kcksjuc5JRGjygkMJGFZcgupSPr1vrWgeGmzZTd
         w8UI+fq7+f0jjSRJMktV559GXqXLP307h2CtIQI7LF3L9fRNvOBK9n7zL6YxTWEVU9
         H8/aIIhsTDGTQ==
Message-ID: <3e00b2ad-b58f-4b09-9230-683c58d3bb92@kernel.org>
Date:   Fri, 17 Nov 2023 13:51:49 +0200
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
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <CX10D9YX1O1C.30PF317AG065N@tleb-bootlin-xps13-01>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/11/2023 12:17, Théo Lebrun wrote:
> Hello,
> 
> On Thu Nov 16, 2023 at 10:44 PM CET, Roger Quadros wrote:
>> On 16/11/2023 20:56, Théo Lebrun wrote:
>>> On Thu Nov 16, 2023 at 1:40 PM CET, Roger Quadros wrote:
>>>> On 15/11/2023 17:02, Théo Lebrun wrote:
>>>>> On Wed Nov 15, 2023 at 12:37 PM CET, Roger Quadros wrote:
>>>>>> You might want to check suspend/resume ops in cdns3-plat and
>>>>>> do something similar here.
>>>>>
>>>>> I'm unsure what you are referring to specifically in cdns3-plat?
>>>>
>>>> What I meant is, calling pm_runtime_get/put() from system suspend/resume
>>>> hooks doesn't seem right.
>>>>
>>>> How about using something like pm_runtime_forbid(dev) on devices which
>>>> loose USB context on runtime suspend e.g. J7200.
>>>> So at probe we can get rid of the pm_runtime_get_sync() call.
>>>
>>> What is the goal of enabling PM runtime to then block (ie forbid) it in
>>> its enabled state until system suspend?
>>
>> If USB controller retains context on runtime_suspend on some platforms
>> then we don't want to forbid PM runtime.
> 
> What's the point of runtime PM if nothing is done based on it? This is
> the current behavior of the driver.

Even if driver doesn't have runtime_suspend/resume hooks, wouldn't 
the USB Power domain turn off if we enable runtime PM and allow runtime
autosuspend and all children have runtime suspended?

> 
>>> Thinking some more about it and having read parts of the genpd source,
>>> it's unclear to me why there even is some PM runtime calls in this
>>> driver. No runtime_suspend/runtime_resume callbacks are registered.
>>> Also, power-domains work as expected without any PM runtime calls.
>>
>> Probably it was required when the driver was introduced.
> 
> I'm not seeing any behavior change in cdns3-ti since its addition in Oct
> 2019.
> 
>>> The power domain is turned on when attached to a device
>>> (see genpd_dev_pm_attach). It gets turned off automatically at
>>> suspend_noirq (taking into account the many things that make genpd
>>> complex: multiple devices per PD, subdomains, flags to customise the
>>> behavior, etc.). Removing calls to PM runtime at probe keeps the driver
>>> working.
>>>
>>> So my new proposal would be: remove all all PM runtime calls from this
>>> driver. Anything wrong with this approach?
>>
>> Nothing wrong if we don't expect runtime_pm to work with this driver.
>>
>>>
>>> Only possible reason I see for having PM runtime in this wrapper driver
>>> would be cut the full power-domain when USB isn't used, with some PM
>>> runtime interaction with the children node. But that cannot work
>>> currently as we don't register a runtime_resume to init the hardware,
>>> so this cannot be the current expected behavior.
>>>
>>>> e.g.
>>>>
>>>>         pm_runtime_set_active(dev);
>>>>         pm_runtime_enable(dev);
>>>>         if (cnds_ti->can_loose_context)
>>>>                 pm_runtime_forbid(dev);
>>>>
>>>>         pm_runtime_set_autosuspend_delay(dev, CNDS_TI_AUTOSUSPEND_DELAY);	/* could be 20ms? */
>>>
>>> Why mention autosuspend in this driver? This will turn the device off in
>>> CNDS_TI_AUTOSUSPEND_DELAY then nothing enables it back using
>>> pm_runtime_get. We have nothing to reconfigure the device, ie no
>>> runtime_resume, so we must not go into runtime suspend.
>>
>> It would be enabled/disabled based on when the child "cdns3,usb"
>> does runtime_resume/suspend.
> 
> Why care about being enabled or disabled if we don't do anything based
> on that? Children does do runtime PM stuff but I don't understand how
> that could influence us.
> 
> Regards,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

-- 
cheers,
-roger
