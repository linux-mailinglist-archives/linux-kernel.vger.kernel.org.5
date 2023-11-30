Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E237FEC75
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjK3KD5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 05:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjK3KDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:03:55 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3077A10DB;
        Thu, 30 Nov 2023 02:03:59 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id D8A9F7F8A;
        Thu, 30 Nov 2023 18:03:55 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Nov
 2023 18:03:55 +0800
Received: from [192.168.125.136] (113.72.145.176) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 30 Nov
 2023 18:03:55 +0800
Message-ID: <f0844a59-7534-4195-b656-eb51586cbff6@starfivetech.com>
Date:   Thu, 30 Nov 2023 18:03:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: Add PCIE_CONFIG_REQUEST_WAIT_MS waiting time
 value
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mason.huo@starfivetech.com>,
        <leyfoon.tan@starfivetech.com>, <minda.chen@starfivetech.com>
References: <20231129232108.GA444155@bhelgaas>
Content-Language: en-US
From:   Kevin Xie <kevin.xie@starfivetech.com>
In-Reply-To: <20231129232108.GA444155@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/30 7:21, Bjorn Helgaas wrote:
> On Fri, Nov 24, 2023 at 09:45:08AM +0800, Kevin Xie wrote:
>> Add the PCIE_CONFIG_REQUEST_WAIT_MS marco to define the minimum waiting
>> time between sending the first configuration request to the device and
>> exit from a conventional reset (or after link training completes).
> 
> s/marco/macro/
> 
> List the first event before the second one, i.e., the delay is from
> exit from reset to the config request.
> 

OK，I will use "from A to B" instead of "between A and B".

>> As described in the conventional reset rules of PCI specifications,
>> there are two different use cases of the value:
>> 
>>    - With a downstream port that supports link speeds <= 5.0 GT/s,
>>      the waiting is following exit from a conventional reset.
>> 
>>    - With a downstream port that supports link speeds > 5.0 GT/s,
>>      the waiting is after link training completes.
> 
> Include the spec citation here as well as in the comment below.
> 

OK, I will include the spec citation here.

> I assume there are follow-on patches that actually use this?  Can we
> make this the first patch in a series so we know we don't have an
> unused macro lying around?
> 

Yes, we will use the marco in the next version of our PCIe controller patches.
Here is the link of current version patch series:
https://lore.kernel.org/lkml/20231115114912.71448-20-minda.chen@starfivetech.com/T/#u 

Do you mean that I should put this patch back to the above series as one of the separate patches?

Thanks for your review.

>> Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
>> Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
>> ---
>>  drivers/pci/pci.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>> 
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 5ecbcf041179..4ca8766e546e 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -22,6 +22,13 @@
>>   */
>>  #define PCIE_PME_TO_L2_TIMEOUT_US	10000
>>  
>> +/*
>> + * PCIe r6.0, sec 6.6.1, <Conventional Reset>
>> + * Requires a minimum waiting of 100ms before sending a configuration
>> + * request to the device.
>> + */
>> +#define PCIE_CONFIG_REQUEST_WAIT_MS	100
>> +
>>  extern const unsigned char pcie_link_speed[];
>>  extern bool pci_early_dump;
>>  
>> -- 
>> 2.25.1
>> 
