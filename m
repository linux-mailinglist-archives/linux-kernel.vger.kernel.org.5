Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7187D3C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjJWQ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjJWQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:26:20 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1583210A;
        Mon, 23 Oct 2023 09:26:17 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39NGQA8Q064284;
        Mon, 23 Oct 2023 11:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698078370;
        bh=ToVUXy/JJet0aGuRbevQ1uj23FQvFLehD2uGhtFjkOw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=RmPm0XZT1FuQyVBHx2xmRT0GxHgTWos1KfY2lxlHygEGoqcaHpSWdKv1e2+kmGBFm
         7jgfTUQttjCnNGdy2nMk9kInpQ/qxe2qBJsniUGyw1p1OcYJA/SygAOBiInmB8EGSM
         1VqEDYTtMVlkvSvexR6FEAD6kq4m+wIgY8cr3+0Q=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39NGQAux094084
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Oct 2023 11:26:10 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Oct 2023 11:26:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Oct 2023 11:26:09 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39NGQ9NO063677;
        Mon, 23 Oct 2023 11:26:09 -0500
Message-ID: <67efff7e-adc5-4117-a715-7fe219d2f92c@ti.com>
Date:   Mon, 23 Oct 2023 11:26:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mux: mmio: use reg property when parent device is not
 a syscon
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230911151030.71100-1-afd@ti.com>
 <0cb645c7-f3c5-e4bb-7686-2a83d32274bb@axentia.se>
 <ab1c4929-0d7d-45eb-ab70-7680dbebcdbb@ti.com>
 <38d3582f-c2d6-3d1a-5706-84fccd22a2ac@axentia.se>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <38d3582f-c2d6-3d1a-5706-84fccd22a2ac@axentia.se>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/23 4:22 PM, Peter Rosin wrote:
> Hi!
> 
> 2023-10-20 at 18:43, Andrew Davis wrote:
>> On 10/20/23 9:28 AM, Peter Rosin wrote:
>>> Hi!
>>>
>>> 2023-09-11 at 17:10, Andrew Davis wrote:
>>>> The DT binding for the reg-mux compatible states it can be used when the
>>>> "parent device of mux controller is not syscon device". It also allows
>>>> for a reg property. When the reg property is provided, use that to
>>>> identify the address space for this mux. If not provided fallback to
>>>> using the parent device as a regmap provider.
>>>>
>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>> Reviewed-by: Nishanth Menon <nm@ti.com>
>>>> ---
>>>>
>>>> Changes from v2:
>>>>    - Rebased on v6.6-rc1
>>>>
>>>> Changes from v1:
>>>>    - Flip logic as suggested in v1[0]
>>>>
>>>> [0] https://lore.kernel.org/lkml/1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com/T/
>>>>
>>>>    drivers/mux/mmio.c | 9 ++++++---
>>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
>>>> index fd1d121a584ba..b6095b7853ed2 100644
>>>> --- a/drivers/mux/mmio.c
>>>> +++ b/drivers/mux/mmio.c
>>>> @@ -44,10 +44,13 @@ static int mux_mmio_probe(struct platform_device *pdev)
>>>>        int ret;
>>>>        int i;
>>>>    -    if (of_device_is_compatible(np, "mmio-mux"))
>>>> +    if (of_device_is_compatible(np, "mmio-mux")) {
>>>>            regmap = syscon_node_to_regmap(np->parent);
>>>> -    else
>>>> -        regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
>>>> +    } else {
>>>> +        regmap = device_node_to_regmap(np);
>>>
>>> I started digging in device_node_to_regmap() to try to find an error that
>>> could be used to trigger if the failover to dev_get_regmap() should be
>>> tried, instead of always doing the failover on error. I got lost fairly
>>> quickly, but it seems device_node_to_regmap() can return -EDEFER_PROBE.
>>> While I'm not certain that it is applicable, that case should probably
>>> not fall back to dev_get_regmap()...
>>>
>>> Are there other error cases that should prevent the failover? I would
>>> guess that it's perhaps just a single error that should trigger trying
>>> the failover path? But I don't know, and which error if that's the case?
>>>
>>
>> Ideally the only error that will be returned is ENOMEM, which happens when
>> this node does not have a 'reg' property, and this is also the one case we
>> want to do the failover. So all should be well.
> 
> The ideal working case is usually not much of a problem. When I look at what
> device_node_to_regmap does, I find, appart from -ENOMEM, possibilities of
> -ENOENT (because no clock), and the clock may theoretically fail to prepare
> for numerous reasons hidden in clock drivers, but the clock core can
> trigger at least -EACCES and -EINPROGRESS via runtime PM.
> 
> And it definitely looks like the -EPROBE_DEFER case needs to be addressed.
> I.e., why is this call chain not a problem?
> 
> mux_mmio_probe
>   ->device_node_to_regmap
>    -> device_node_get_regmap
>     -> of_syscon_register
>      -> of_hwspin_lock_get_id
>      <- -EPROBE_DEFER
>     <- ERR_PTR(-EPROBE_DEFER)
>    <- ERR_PTR(-EPROBE_DEFER)
>   <- ERR_PTR(-EPROBE_DEFER)
> 
> As far as I can tell, if device_node_to_regmap() fails with -EPROBE_DEFER
> with your patch, then mux_mmio_probe() misbehaves. It should have aborted
> and failed with -EPROBE_DEFER, but instead throws that error away and
> goes on to try dev_get_regmap(). That, in turn, is probably futile and
> will likely error out in some way, breaking a system that might have been
> ok, if the probe had been retried some time later.
> 

This is why I liked the v1 version, dev_get_regmap() just returns a
simple NULL on error, no complex EPROBE_DEFER oddness :)

So is EPROBE_DEFER the only one we think should retry and not go
down the fallback path? I believe that is the normal assumption
for most drivers.

> As long as the above is not sufficiently explained away, or fixed, I
> consider the patch broken.
> 
>>> How much badness can be caused if syscon_node_to_regmap() fails for some
>>> random obscure reason and the failover path is taken inadvertently? It
>>> certainly smells bad for -EDEFER_PROBE, but do you have any insight in
>>> other cases?
>>>
>>
>> If we take the failover inadvertently then we will check if the parent
>> node is a syscon, if it is then our offset will most likely be wrong
>> (parent will not match child 'reg').
>>
>>> And after getting to approx that point a while back, I had other things
>>> to take care of, and this fell off the table. Sorry!
>>>
>>
>> No problem as long as we can find a way to get this in quickly (lot of
>> DT warning need cleaned up based on this patch).
> 
> Hold your horses, I need the above explanation first (and perhaps an
> updated patch).
> 

I'm not normally so impatient but this went two whole kernel cycles without
any comment until rc6.. v4 on the way.

Andrew

> Cheers,
> Peter
> 
>> Thanks
>> Andrew
>>
>>> Cheers,
>>> Peter
>>>
>>>> +        if (IS_ERR(regmap))
>>>> +            regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
>>>> +    }
>>>>        if (IS_ERR(regmap)) {
>>>>            ret = PTR_ERR(regmap);
>>>>            dev_err(dev, "failed to get regmap: %d\n", ret);
