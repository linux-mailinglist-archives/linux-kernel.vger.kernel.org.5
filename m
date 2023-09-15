Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A909B7A13F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjIOCqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjIOCqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:46:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA2626B8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 19:45:57 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38F2jkH1037106;
        Thu, 14 Sep 2023 21:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694745946;
        bh=M/B3CZINXVjbUkXIUbr/eaa8OB7I9LGTuM5TX0QBV9o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=WLXPRkc2mHWg75lPRK7fEePtAAusOTUt70Uy1ouvPUoM8uYcnk+NdLVZTsPgmoHM1
         FWn+ONnKbsez7QqmYL0AJ1g988jPOb23ET73VTXMlyHD3MrtP5hDP4n7o5/k7qclGv
         LCEQr9AiQyONnjtDVcwmLK8RK7lB1FuJGgQCDc2w=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38F2jkoJ040070
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Sep 2023 21:45:46 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Sep 2023 21:45:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Sep 2023 21:45:46 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38F2jikk026629;
        Thu, 14 Sep 2023 21:45:45 -0500
Message-ID: <17d20ae4-22fc-430d-77eb-4c0511b9f8b9@ti.com>
Date:   Fri, 15 Sep 2023 08:15:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] soc: ti: k3-socinfo: Revamp driver to accommodate
 different rev structs
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
References: <20230914074426.1901226-1-n-francis@ti.com>
 <20230914160224.doytoq2bbvymuieh@onslaught>
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230914160224.doytoq2bbvymuieh@onslaught>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth

On 14/09/23 21:32, Nishanth Menon wrote:
> On 13:14-20230914, Neha Malcom Francis wrote:
>> k3-socinfo.c driver assumes silicon revisions to be 1.0, 2.0 etc. for
>> every platform. However this typical style is not followed by J721E
>> (1.0, 1.1) and need not be followed by upcoming silicon revisions as
>> well. Adapt the driver to be similar to its U-Boot counterpart
>> (drivers/soc/soc_ti_k3.c) that accounts for this difference on the basis
>> of partno/family. While at it, modify driver to be more understandable.
> 
> Don't mix so many things up in a single patch.
> 
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> This patch tries to revive an earlier attempt [1] and also works off of
>> those review comments, sending it as a new patch since the approach is
>> slightly different.
>>
>> [1] https://lore.kernel.org/all/20230607080349.26671-1-t-konduru@ti.com/
>>
>>   drivers/soc/ti/k3-socinfo.c | 112 +++++++++++++++++++++++++-----------
>>   1 file changed, 80 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
>> index 6ea9b8c7d335..1e7a32b5b63f 100644
>> --- a/drivers/soc/ti/k3-socinfo.c
>> +++ b/drivers/soc/ti/k3-socinfo.c
>> @@ -20,7 +20,7 @@
>>    *  31-28 VARIANT	Device variant
>>    *  27-12 PARTNO	Part number
>>    *  11-1  MFG		Indicates TI as manufacturer (0x17)
>> - *  1			Always 1
>> + *  0			Always 1
> 
> Looks like a typo you are fixing, but no information in commit message.
> 
>>    */
>>   #define CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT	(28)
>>   #define CTRLMMR_WKUP_JTAGID_VARIANT_MASK	GENMASK(31, 28)
>> @@ -33,33 +33,81 @@
>>   
>>   #define CTRLMMR_WKUP_JTAGID_MFG_TI		0x17
>>   
>> -static const struct k3_soc_id {
>> -	unsigned int id;
>> -	const char *family_name;
>> -} k3_soc_ids[] = {
>> -	{ 0xBB5A, "AM65X" },
>> -	{ 0xBB64, "J721E" },
>> -	{ 0xBB6D, "J7200" },
>> -	{ 0xBB38, "AM64X" },
>> -	{ 0xBB75, "J721S2"},
>> -	{ 0xBB7E, "AM62X" },
>> -	{ 0xBB80, "J784S4" },
>> -	{ 0xBB8D, "AM62AX" },
>> -	{ 0xBB9D, "AM62PX" },
>> +#define JTAG_ID_PARTNO_AM65X		0xBB5A
>> +#define JTAG_ID_PARTNO_J721E		0xBB64
>> +#define JTAG_ID_PARTNO_J7200		0xBB6D
>> +#define JTAG_ID_PARTNO_AM64X		0xBB38
>> +#define JTAG_ID_PARTNO_J721S2		0xBB75
>> +#define JTAG_ID_PARTNO_AM62X		0xBB7E
>> +#define JTAG_ID_PARTNO_J784S4		0xBB80
>> +#define JTAG_ID_PARTNO_AM62AX		0xBB8D
>> +#define JTAG_ID_PARTNO_AM62PX		0xBB9D
>> +
>> +static char *j721e_rev_string_map[] = {
>> +	"1.0", "1.1",
>> +};
>> +
>> +static char *typical_rev_string_map[] = {
> 
> use k3_ name space please for vars.
> 
>> +	"1.0", "2.0", "3.0",
>>   };
>>   
>>   static int
>>   k3_chipinfo_partno_to_names(unsigned int partno,
>>   			    struct soc_device_attribute *soc_dev_attr)
>>   {
>> -	int i;
>> +	switch (partno) {
>> +	case JTAG_ID_PARTNO_AM62AX:
>> +		soc_dev_attr->family = "AM62AX";
>> +		break;
>> +	case JTAG_ID_PARTNO_AM62PX:
>> +		soc_dev_attr->family = "AM62PX";
>> +		break;
>> +	case JTAG_ID_PARTNO_AM62X:
>> +		soc_dev_attr->family = "AM62X";
>> +		break;
>> +	case JTAG_ID_PARTNO_AM64X:
>> +		soc_dev_attr->family = "AM64X";
>> +		break;
>> +	case JTAG_ID_PARTNO_AM65X:
>> +		soc_dev_attr->family = "AM65X";
>> +		break;
>> +	case JTAG_ID_PARTNO_J7200:
>> +		soc_dev_attr->family = "J7200";
>> +		break;
>> +	case JTAG_ID_PARTNO_J721E:
>> +		soc_dev_attr->family = "J721E";
>> +		break;
>> +	case JTAG_ID_PARTNO_J721S2:
>> +		soc_dev_attr->family = "J721S2";
>> +		break;
>> +	case JTAG_ID_PARTNO_J784S4:
>> +		soc_dev_attr->family = "J784S4";
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	};
>> +	return 0;
>> +};
>>   
>> -	for (i = 0; i < ARRAY_SIZE(k3_soc_ids); i++)
>> -		if (partno == k3_soc_ids[i].id) {
>> -			soc_dev_attr->family = k3_soc_ids[i].family_name;
>> -			return 0;
>> -		}
> 
> Why redo the family attribute? That is JTAG standard and handling is
> valid and implementation is optimal - no sense in churning here.
> 
>> +static int k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
>> +				     struct soc_device_attribute *soc_dev_attr)
>> +{
>> +	switch (partno) {
>> +	case JTAG_ID_PARTNO_J721E:
>> +		if (variant >= ARRAY_SIZE(j721e_rev_string_map))
>> +			goto bail;
>> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
>> +						   j721e_rev_string_map[variant]);
>> +		break;
>> +	default:
>> +		if (variant >= ARRAY_SIZE(typical_rev_string_map))
>> +			goto bail;
>> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
>> +						   typical_rev_string_map[variant]);
>> +	}
>> +	return 0;
>>   
>> +bail:
>>   	return -EINVAL;
>>   }
>>   
>> @@ -70,10 +118,10 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>>   	struct device *dev = &pdev->dev;
>>   	struct soc_device *soc_dev;
>>   	struct regmap *regmap;
>> -	u32 partno_id;
>> -	u32 variant;
>>   	u32 jtag_id;
>>   	u32 mfg;
>> +	u32 partno_id;
>> +	u32 variant;
>>   	int ret;
>>   
>>   	regmap = device_node_to_regmap(node);
>> @@ -92,28 +140,28 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>>   		return -ENODEV;
>>   	}
>>   
>> -	variant = (jtag_id & CTRLMMR_WKUP_JTAGID_VARIANT_MASK) >>
>> -		  CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT;
>> -	variant++;
>> -
>>   	partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
>>   		 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
>>   
>> +	variant = (jtag_id & CTRLMMR_WKUP_JTAGID_VARIANT_MASK) >>
>> +		  CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT;
>> +
> no need to relocate the code - just call the chip_info_to_sr
> 
>>   	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>>   	if (!soc_dev_attr)
>>   		return -ENOMEM;
>>   
>> -	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
>> -	if (!soc_dev_attr->revision) {
>> -		ret = -ENOMEM;
>> +	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
>> +	if (ret) {
>> +		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);
>> +		ret = -ENODEV;
>>   		goto err;
>>   	}
>>   
>> -	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
>> +	ret = k3_chipinfo_variant_to_sr(partno_id, variant, soc_dev_attr);
>>   	if (ret) {
>> -		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);
>> +		dev_err(dev, "Unknown revision for %s\n", soc_dev_attr->family);
>>   		ret = -ENODEV;
>> -		goto err_free_rev;
>> +		goto err;
>>   	}
>>   
>>   	node = of_find_node_by_path("/");
>> -- 
>> 2.34.1
>>
> 

Thanks for the review, will work on it and send v2

-- 
Thanking You
Neha Malcom Francis
