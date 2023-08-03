Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8599876EECE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbjHCP5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjHCP5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:57:45 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8A211F;
        Thu,  3 Aug 2023 08:57:43 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373Fvaa6079791;
        Thu, 3 Aug 2023 10:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691078256;
        bh=ap9tKouw072YkIwIE1OUhTE7tz2wKEeSEURmBKG1QQc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Sle5TNoqJlPMEECyl3wVffUDjOuJYimYpvGTFuj9JwJMD+jLLzJubzKJExGD62yFs
         3D7neFqK8quSne5q+eTGlHnC4sTawI+hHrV+mfuF9Et/00o+ScXLHb/4Ana75h2S2F
         a7ZzNiP735J9t3ChzY36JLOZlnAHk4WDhq0c1bgU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373FvaQ2111483
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 10:57:36 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 10:57:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 10:57:36 -0500
Received: from [10.250.36.243] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373FvZWK025943;
        Thu, 3 Aug 2023 10:57:35 -0500
Message-ID: <4019ef37-1c3d-ae2c-3006-17487e69f077@ti.com>
Date:   Thu, 3 Aug 2023 10:57:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V6 1/4] firmware: ti_sci: Introduce Power Management Ops
Content-Language: en-US
To:     Dhruva Gole <d-gole@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        "Santosh Shilimkar" <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Vibhore Vardhan <vibhore@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-2-d-gole@ti.com>
 <930ffb16-f212-0bcb-4713-2acc138c4035@ti.com>
 <20230803154204.iyohslrpma7bqqpk@dhruva>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230803154204.iyohslrpma7bqqpk@dhruva>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 10:42 AM, Dhruva Gole wrote:
> On Aug 03, 2023 at 10:14:03 -0500, Andrew Davis wrote:
> [..snip..]
>>>    #define TI_SCI_IRQ_SECONDARY_HOST_INVALID	0xff
>>>    /**
>>> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
>>> index bd0d11af76c5..f2d1d74ab8fc 100644
>>> --- a/include/linux/soc/ti/ti_sci_protocol.h
>>> +++ b/include/linux/soc/ti/ti_sci_protocol.h
>>> @@ -195,6 +195,49 @@ struct ti_sci_clk_ops {
>>>    			u64 *current_freq);
>>>    };
>>> +/* TISCI LPM wake up sources */
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_I2C0	0x00
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_UART0	0x10
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_GPIO0	0x20
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_ICEMELTER0	0x30
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER0	0x40
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_TIMER1	0x41
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_WKUP_RTC0	0x50
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_RESET		0x60
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB0		0x70
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_USB1		0x71
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MAIN_IO		0x80
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_MCU_IO		0x81
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_CAN_IO		0x82
>>> +#define TISCI_MSG_VALUE_LPM_WAKE_SOURCE_INVALID		0xFF
>>
>> I don't see these used in this series, do you need them? lpm_wake_reason()
> 
> True, we are not currently using these macros. They _maybe required in
> future.
> I can remove them if required?
> 
>> doesn't seem used either and I'm not sure how you plan to use it, could
>> you detail that?
> 
> When the system wakes from suspend-to-mem we can check which
> subsystem has woken us up with the TISCI LPM_WAKEUP_REASON message.
> There's no hardware event generated and we have to ask the firmware
> for the actual wake reason.
> 
> We may want to add support for a wake up interrupt controller that will
> generate an interrupt for other subsystems. This might end up using this
> lpm_wake_reason API, hence even though the function maybe unused today
> it will be required for above described scenario.
> 
> However if you prefer that I remove it and then add it in future when we
> finally write a working interrupt controller driver, then do let me
> know.
> 

It's easier to review code that is used. We may go with a
completely different approach by then, will be easier to unwind
this if you don't start with it, only add it when used.

Andrew

>>
>> Andrew
>>
>>> +
>>> +/* TISCI LPM IO isolation control values */
>>> +#define TISCI_MSG_VALUE_IO_ENABLE			1
>>> +#define TISCI_MSG_VALUE_IO_DISABLE			0
>>> +
> [..snip..]
> 
