Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CE87EE0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbjKPMl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344966AbjKPMl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:41:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C30D8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:41:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BD7C433C8;
        Thu, 16 Nov 2023 12:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700138513;
        bh=vLGyRyE7xZ4srKu6DV6MaEhKkGUc+EK7JixMRPPZLu8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=naPC5FlEcHUpIG7KPTqcFrWgDAQBrCPlZNLUlBMx+SgTqAoTsIt+Ie6lwGNcVw8HT
         mO48U9xc+J7nkmTCu+PPbnnSdK4v98ieT4m16G1gEhQQw6F5YmbnNZ+JBznpqzLLh5
         3NtPrgxClTTHbd0JbVdhToJwnyfv/KOO7bLAchKCNmcd+nUA0rDctkb0L3jkNvcRDJ
         AfHz6Ps0lUxXCMpzwQ68hlSZcfnXOPM97yEuP/w8qXyaMfSn415m3amGbkANCNTEqp
         vqn6KzXtjjj8gXOySCTcw/qFJEU2fc3Quu30FGy95JSgr/OSEcgW/TGCzu4rNhUML7
         clsYg4Cr/Jf5w==
Message-ID: <dad980f3-e032-41e4-a1e4-a16a7f45ff95@kernel.org>
Date:   Thu, 16 Nov 2023 14:40:55 +0200
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
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-3-ad1ee714835c@bootlin.com>
 <5080372b-1f48-4cbc-a6c4-8689c28983cb@kernel.org>
 <CWZH66HQZNYM.T623ZOEEE0BK@tleb-bootlin-xps13-01>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <CWZH66HQZNYM.T623ZOEEE0BK@tleb-bootlin-xps13-01>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/11/2023 17:02, Théo Lebrun wrote:
> Hi Roger,
> 
> On Wed Nov 15, 2023 at 12:37 PM CET, Roger Quadros wrote:
>> On 13/11/2023 16:26, Théo Lebrun wrote:
>>> Hardware initialisation is only done at probe. The J7200 USB controller
>>> is reset at resume because of power-domains toggling off & on. We
>>> therefore (1) toggle PM runtime at suspend/resume & (2) reconfigure the
>>> hardware at resume.
>>
>> at probe we are doing a pm_runtime_get() and never doing a put thus
>> preventing any runtime PM.
> 
> Indeed. The get() from probe/resume are in symmetry with the put() from
> suspend. Is this wrong in some manner?
> 
>>> index c331bcd2faeb..50b38c4b9c87 100644
>>> --- a/drivers/usb/cdns3/cdns3-ti.c
>>> +++ b/drivers/usb/cdns3/cdns3-ti.c
>>> @@ -197,6 +197,50 @@ static int cdns_ti_probe(struct platform_device *pdev)
>>>  	return error;
>>>  }
>>>  
>>> +#ifdef CONFIG_PM
>>> +
>>> +static int cdns_ti_suspend(struct device *dev)
>>> +{
>>> +	struct cdns_ti *data = dev_get_drvdata(dev);
>>> +
>>> +	if (!of_device_is_compatible(dev_of_node(dev), "ti,j7200-usb"))
>>> +		return 0;
>>> +
>>> +	pm_runtime_put_sync(data->dev);
>>> +
>>> +	return 0;
>>
>> You might want to check suspend/resume ops in cdns3-plat and
>> do something similar here.
> 
> I'm unsure what you are referring to specifically in cdns3-plat?

What I meant is, calling pm_runtime_get/put() from system suspend/resume
hooks doesn't seem right.

How about using something like pm_runtime_forbid(dev) on devices which
loose USB context on runtime suspend e.g. J7200.
So at probe we can get rid of the pm_runtime_get_sync() call.
e.g.

        pm_runtime_set_active(dev);
        pm_runtime_enable(dev);
        if (cnds_ti->can_loose_context)
                pm_runtime_forbid(dev);

        pm_runtime_set_autosuspend_delay(dev, CNDS_TI_AUTOSUSPEND_DELAY);	/* could be 20ms? */
        pm_runtime_mark_last_busy(dev);
        pm_runtime_use_autosuspend(dev);

You will need to modify the suspend/resume handlers accordingly.
https://docs.kernel.org/power/runtime_pm.html#runtime-pm-and-system-sleep

What I'm not sure of is if there are any TI platforms that retain USB context
on power domain off. Let me get back on this. Till then we can assume that
all platforms loose USB context on power domain off.

One comment below.

> +	return ret;
> +}


> 
>  - Using pm_runtime_status_suspended() to get the current PM runtime
>    state & act on it? I don't see why because we know the pm_runtime
>    state is a single put() at probe.
> 
>  - Having a `in_lpm` flag to track low-power mode state? I wouldn't see
>    why we'd want that as we don't register runtime_suspend &
>    runtime_resume callbacks and system syspend/resume can be assumed to
>    be called in the right order.
> 
>  - Checking the `device_may_wakeup()`? That doesn't apply to this driver
>    which cannot be a wakeup source.
> 
> Thanks for your review!
> Regards,
> 
> --> +static int cdns_ti_resume(struct device *dev)
> +{
> +	struct cdns_ti *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!of_device_is_compatible(dev_of_node(dev), "ti,j7200-usb"))
> +		return 0;
> +
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
> +		goto err;
> +	}
> +
> +	cdns_ti_init_hw(data);
> +
> +	return 0;
> +
> +err:
> +	pm_runtime_put_sync(data->dev);
> +	pm_runtime_disable(data->dev);

Why do you do a pm_runtime_disable() here?

> +	return ret;
> +}


> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
> ------------------------------------------------------------------------
> 
> 

-- 
cheers,
-roger
