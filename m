Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A382076EEEB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbjHCQBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbjHCQBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:01:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF45421E;
        Thu,  3 Aug 2023 09:00:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 373G0DfD090675;
        Thu, 3 Aug 2023 11:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691078413;
        bh=6WeceiBT+62w0bpe3ah2ZUYPVdg/njV3u+KqFCIMe6c=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=T/zevSXQSCHh5/juZBsI8HOPXwJTP66UM5YsSlAc1SrRMQkXNbv5kuAHjDdxq1FIn
         lrrWoTlF3byLcxOfuMWdk0ZdAdQYpTwfyqWQDn7bxCjcTk332ZO6DXtVeLtKbMRrTn
         l+JIXc2H0hgIeJLwNofqWgTDHw8e6OBYqh7oZP/Q=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 373G0Dhu113337
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 11:00:13 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 11:00:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 11:00:12 -0500
Received: from [10.250.36.243] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 373G0B1W012107;
        Thu, 3 Aug 2023 11:00:11 -0500
Message-ID: <8c330bd9-5f4e-8cd0-ed02-c3a696d7473a@ti.com>
Date:   Thu, 3 Aug 2023 11:00:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V6 4/4] firmware: ti_sci: Introduce system suspend resume
 support
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
        Vibhore Vardhan <vibhore@ti.com>, Georgi Vlaev <g-vlaev@ti.com>
References: <20230803064247.503036-1-d-gole@ti.com>
 <20230803064247.503036-5-d-gole@ti.com>
 <3882f0ac-b74c-6eb2-197c-34ca233cd7a3@ti.com>
 <20230803155541.nwsfwobfkbpefoyw@dhruva>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230803155541.nwsfwobfkbpefoyw@dhruva>
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

On 8/3/23 10:55 AM, Dhruva Gole wrote:
> On Aug 03, 2023 at 10:26:32 -0500, Andrew Davis wrote:
>> On 8/3/23 1:42 AM, Dhruva Gole wrote:
>>> Introduce system suspend resume calls that will allow the ti_sci
>>> driver to support deep sleep low power mode when the user space issues a
>>> suspend to mem.
>>>
>>> Also, write a ti_sci_prepare_system_suspend call to be used in the driver
>>> suspend handler to allow the system to identify the low power mode being
>>> entered and if necessary, send TISCI_MSG_PREPARE_SLEEP with information
>>> about the mode is being entered and the address for allocated memory for
>>> storing the context during Deep Sleep.
>>>
>>> We're using "pm_suspend_target_state" to map the kernel's target suspend
>>> state to SysFW low power mode. Make sure this is available only when
>>> CONFIG_SUSPEND is enabled.
>>>
>>> Co-developed-by: Dave Gerlach <d-gerlach@ti.com>
>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
>>> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
>>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>>> ---
>>>    drivers/firmware/ti_sci.c | 63 +++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 63 insertions(+)
>>>
> [..snip..]
>>> +static int ti_sci_suspend(struct device *dev)
>>> +{
>>> +	struct ti_sci_info *info = dev_get_drvdata(dev);
>>> +	int ret;
>>> +
>>> +	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
>>
>> After this the will the IOs be in isolation? Or does the firmware wait
>> until power down begins later?
> 
>  From what I understand,
> IOs will be in isolation immediately
> 

That is what I understand too, so then any device that may need to do some
external communication for its suspend will not function, this must be the
last driver _suspend() the system calls, how do you enforce that?

Andrew

>>
>> Andrew
>>
>>> +	if (ret)
>>> +		return ret;
>>> +	dev_dbg(dev, "%s: set I/O isolation: %d\n", __func__, ret);
>>> +
>>> +	ret = ti_sci_prepare_system_suspend(info);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ti_sci_resume(struct device *dev)
>>> +{
>>> +	struct ti_sci_info *info = dev_get_drvdata(dev);
>>> +	int ret;
>>> +
>>> +	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
>>> +	if (ret)
>>> +		return ret;
>>> +	dev_dbg(dev, "%s: disable I/O isolation: %d\n", __func__, ret);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static DEFINE_SIMPLE_DEV_PM_OPS(ti_sci_pm_ops, ti_sci_suspend, ti_sci_resume);
>>> +
>>>    static int ti_sci_init_suspend(struct platform_device *pdev,
>>>    			       struct ti_sci_info *info)
>>>    {
>>> @@ -3759,6 +3821,7 @@ static struct platform_driver ti_sci_driver = {
>>>    	.driver = {
>>>    		   .name = "ti-sci",
>>>    		   .of_match_table = of_match_ptr(ti_sci_of_match),
>>> +		   .pm = &ti_sci_pm_ops,
>>>    	},
>>>    };
>>>    module_platform_driver(ti_sci_driver);
> 
