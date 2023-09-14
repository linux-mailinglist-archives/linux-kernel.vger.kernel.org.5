Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD379F968
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbjINEGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjINEFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:05:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035121BF8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:05:48 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38E45ZqI012669;
        Wed, 13 Sep 2023 23:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694664335;
        bh=7IIEC67naZi6/0RAJKrEfkH2cWlE/u6Yf+YjSmZRSxQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=h3pkAJl2x4fDuqohz2bwIVhB8VtrgtItA8EpWu6TZA8BRsyA7n1TxX6rfDPe/dKp4
         AqPJfwOsBOVWujIm09ubDCzy+FYvhPSeJ0d2TL1mKMGF1gYsWWBSv8BZc92KDrilIi
         IewUSUbLTYgnBL7lRMMuAXSStiORX8vaUmgGhuBc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38E45ZJm119512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 23:05:35 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 23:05:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 23:05:35 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38E45VtF120507;
        Wed, 13 Sep 2023 23:05:32 -0500
Message-ID: <a83aaf52-7fa4-d9dc-a058-8bfe387731b4@ti.com>
Date:   Thu, 14 Sep 2023 09:35:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] soc: ti: k3-socinfo: Fix the silicon revision misprint
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Thejasvi Konduru <t-konduru@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Apurva Nandan <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>
References: <20230607080349.26671-1-t-konduru@ti.com>
 <20230607104304.iengykppptr3fxe6@reflected>
 <d50e7612-0b17-0f65-872f-90e08bed9948@ti.com>
 <20230913112823.prv5dmasvv4nt6qv@nuclear>
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230913112823.prv5dmasvv4nt6qv@nuclear>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth

On 13/09/23 16:58, Nishanth Menon wrote:
> On 12:07-20230912, Neha Malcom Francis wrote:
> 
> [...]
> 
>>>> +void
>>>> +k3_chipinfo_silicon_rev(unsigned int variant,
>>>> +			struct soc_device_attribute *soc_dev_attr)
>>>> +{
>>>> +	const char *family_name = soc_dev_attr->family;
>>>> +	int j721e_lookup_arr_size = ARRAY_SIZE(soc_revision_j721e);
>>>> +
>>>> +	if (!strcmp(family_name, "J721E") && variant < j721e_lookup_arr_size) {
>>>> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s", soc_revision_j721e[variant]);
>>>> +	} else {
>>>> +		variant++;
>>>> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
>>>> +	}
>>>
>>> I am not comfortable with if else here. Why not extend k3_soc_id
>>> structure to include the variant LuT? Are there exceptions to this rule
>>> (Say AM65x?), those would make sense to handle with a compare against
>>> the partno?
>>>
>>
>> Trying to revive this patch, I see what you are saying is similar to the way
>> detection has already been implemented in U-Boot (drivers/soc/soc_ti_k3.c)
>> if I'm not mistaken.
> 
> Yes.
> 
>>
>> But I can't find any existing exception to this "family --> version" rule
>> that forces us to use "partno --> version". Checked through all AM65x device
>> TRMs available in ti.com; all seem to use common partno. So maybe I am not
>> on the same page, did you mean something else?
> 
> https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
> CTRLMMR_WKUP_JTAGID:: VARIANT field: SR2.0: 1h SR1.0: 0h
> Latest data sheet: https://www.ti.com/lit/ds/symlink/am6548.pdf
> indicates SR 2.1
> 
> How is this detected?

Detection of the ".x" bit is still a WIP and needs some alignment internally 
before I can add that patch. So for now, working on cleaning up the known issues 
of the driver.

> 
> What I indicated is a LUT table similar to
> https://git.ti.com/cgit/k3conf/k3conf/tree/common/socinfo.c#n382
> 
> This allows a switch statement to handle custom SR handling schemes or
> use LUT with variants that use VARIANT field to handle things properly.
> 

This makes sense, will work on the patch accordingly. Thanks!

> [...]

-- 
Thanking You
Neha Malcom Francis
