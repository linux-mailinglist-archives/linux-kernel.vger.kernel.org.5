Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1E77005F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjHDMlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjHDMlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:41:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F83646A8;
        Fri,  4 Aug 2023 05:41:17 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHQGh4tF2zGpnN;
        Fri,  4 Aug 2023 20:37:48 +0800 (CST)
Received: from [10.67.110.89] (10.67.110.89) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 20:41:14 +0800
Message-ID: <7ff795d4-fb67-4c5d-04be-4eff7f9b70fa@huawei.com>
Date:   Fri, 4 Aug 2023 20:41:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] serial: 8250_dw: Fix assignment error of data in
 dw8250_probe()
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <heikki.krogerus@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
References: <20230804121607.191203-1-xiafukun@huawei.com>
 <b22177d4-f911-cb8f-18e6-4ca8b2855c73@linux.intel.com>
From:   Xia Fukun <xiafukun@huawei.com>
In-Reply-To: <b22177d4-f911-cb8f-18e6-4ca8b2855c73@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.89]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/8/4 20:24, Ilpo Järvinen wrote:
> On Fri, 4 Aug 2023, Xia Fukun wrote:
> 
>> When the "ri-override" property is present in the device,
>> data->msr_mask_on and UART_MSR_RI should be used for
>> OR-assignment. Fix the errors in it.
>>  
>>  	if (device_property_read_bool(dev, "ri-override")) {
>>  		/* Always report Ring indicator as inactive */
>> -		data->msr_mask_off |= UART_MSR_RI;
>> +		data->msr_mask_on |= UART_MSR_RI;
>>  		data->msr_mask_off |= UART_MSR_TERI;
> 
> The comment and also documentation says RI signal is always kept inactive 
> when ri-override is present.
> 
> In Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml:
> 
>   ri-override:
>     description: Override the RI modem status signal. This signal will always
>       be reported as inactive instead of being obtained from the modem status
>       register. Define this if your serial port does not use this pin.
> 
> ...So why you think this patch is correct? (Please explain it in the v2
> changelog clearly if you think your patch is still correct thing to do, 
> thank you).
> 

Thank you very much for your reply. My understanding of this property is
indeed flawed. That is to say, in the "ri-override" property,
data->msr_mask_on will not be used, there will be no signal transmission?
In that case, you are right. My patch may be redundant.
