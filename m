Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB537CBD77
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjJQIbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbjJQIbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:31:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1DBF2;
        Tue, 17 Oct 2023 01:31:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C70C433C8;
        Tue, 17 Oct 2023 08:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697531473;
        bh=sV57NWu1mWWa2mHpvDUHkKn7U2+oSh51miAvxpzYdC8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=limWfxRwQD1a//4aVP0bZ4acqnOQpo/86hRSXt85GQcD0THK4EKvF1kz5dY7zz9ew
         WMmSBZPEOVl+7eHhnY2VbuZ1JcP/6CYkOzgdsfBuS9c9pa2haV7zGHlCPGFczOI3zh
         hOc46EJXW4BHj3kA7y7IzOboZiJhFvlPh/vLFDzuU3bMKvvI5H/84fa5lswfBs1O9P
         FM2Q/7M91KW3s3IJJpx0TZiPubUtNtNlXi5D2dZ3pqbWXfKJfku70lXTMcI+Aj2rGC
         a89MGuis9NSDIhzkWzhDHwPMoQMEsMm8eXYcSp1fAhLH6ygpWac6I+/u9e1ri/ifem
         H8/IYIBF9d4jA==
Message-ID: <258a5d1b-46b2-4f79-89cf-157d5bf89f15@kernel.org>
Date:   Tue, 17 Oct 2023 17:31:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/26] PM / devfreq: rockchip-dfi: Add RK3568 support
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
 <20230704093242.583575-11-s.hauer@pengutronix.de>
 <ac224dfe-ff7d-57c7-89ad-f10939975b4d@kernel.org>
 <20231016113442.GZ3359458@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20231016113442.GZ3359458@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 16. 20:34, Sascha Hauer wrote:
> On Sat, Oct 07, 2023 at 03:17:14AM +0900, Chanwoo Choi wrote:
>> On 23. 7. 4. 18:32, Sascha Hauer wrote:
>>> This adds RK3568 support to the DFI driver.  Only iniitialization
>>> differs from the currently supported RK3399.
>>>
>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>> ---
>>>  drivers/devfreq/event/rockchip-dfi.c | 21 +++++++++++++++++++++
>>>  include/soc/rockchip/rk3568_grf.h    | 12 ++++++++++++
>>>  2 files changed, 33 insertions(+)
>>>  create mode 100644 include/soc/rockchip/rk3568_grf.h
>>>
>>> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
>>> index 6b3ef97b3be09..261d112580c9e 100644
>>> --- a/drivers/devfreq/event/rockchip-dfi.c
>>> +++ b/drivers/devfreq/event/rockchip-dfi.c
>>> @@ -23,6 +23,7 @@
>>>  
>>>  #include <soc/rockchip/rockchip_grf.h>
>>>  #include <soc/rockchip/rk3399_grf.h>
>>> +#include <soc/rockchip/rk3568_grf.h>
>>>  
>>>  #define DMC_MAX_CHANNELS	2
>>>  
>>> @@ -209,10 +210,30 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
>>>  	return 0;
>>>  };
>>>  
>>> +static int rk3568_dfi_init(struct rockchip_dfi *dfi)
>>> +{
>>> +	struct regmap *regmap_pmu = dfi->regmap_pmu;
>>> +	u32 reg2, reg3;
>>> +
>>> +	regmap_read(regmap_pmu, RK3568_PMUGRF_OS_REG2, &reg2);
>>> +	regmap_read(regmap_pmu, RK3568_PMUGRF_OS_REG3, &reg3);
>>> +
>>> +	dfi->ddr_type = FIELD_GET(RK3568_PMUGRF_OS_REG2_DRAMTYPE_INFO, reg2);
> 
> The ddr_type is 5 bits wide. The lower three bits are here.
> 
>>> +
>>> +	if (FIELD_GET(RK3568_PMUGRF_OS_REG3_SYSREG_VERSION, reg3) >= 0x3)
>>> +		dfi->ddr_type |= FIELD_GET(RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3, reg3) << 3;
> 
> The upper two bits are here, hence we need to shift the value above the
> lower three bits.
> 
>>
>> There are no reason of why shifting the '3'.
>> Could you add the comment about '3' or add the constant definition '3'?
> 
> I don't think adding a constant makes sense. I'll add a comment making
> it more clear what happens.

It is enough to add the comment. Thanks.

> 
>>
>>> +
>>> +	dfi->channel_mask = 1;
>>
>> nitpick.
>> On other rkXXXX_dfi_init, use GENMASK() to initialize 'dfi->channel_mask'.
>> In order to keep the consistency, it is better to use BIT() macro as following:
>> 	dfi->channel_mask = BIT(0);
> 
> Ok, will do.

Thanks.

> 
> Sascha
> 

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

