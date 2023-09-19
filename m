Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44167A57FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjISDsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjISDsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:48:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F9110E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:48:06 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J3lvxM015983;
        Mon, 18 Sep 2023 22:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695095277;
        bh=xvr6P2c6usmltqifh7a8DUkpaYOsPQxUxw0KAi+r1dc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=RmokO0H4RF0JsQvIoxOd9Fate1e4N8LqdNUktceiACa2pcaHR6fPyD+Rv84awk5Gt
         fZyFYZRJm2/U5d96bfoBsQK0P/46CNrAkqvmHv5bQmsJxbKMMDt1gkFmhhDjt3c/4h
         6ObrENLy8h3rYsQwdQfmz71wmijy9Wx1WJFhs86A=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J3lvpk077989
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Sep 2023 22:47:57 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Sep 2023 22:47:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Sep 2023 22:47:56 -0500
Received: from [10.24.68.114] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J3lsYC045476;
        Mon, 18 Sep 2023 22:47:55 -0500
Message-ID: <5ceb9aad-dce9-c044-019d-6e8ed1500246@ti.com>
Date:   Tue, 19 Sep 2023 09:17:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] soc: ti: k3-socinfo: Revamp driver to accommodate
 different rev structs
To:     Nishanth Menon <nm@ti.com>
CC:     <ssantosh@kernel.org>, <t-konduru@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
References: <20230915064650.2287638-1-n-francis@ti.com>
 <20230915064650.2287638-2-n-francis@ti.com>
 <20230915122127.f4cogffx4sc3towe@uncork>
Content-Language: en-US
From:   Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230915122127.f4cogffx4sc3towe@uncork>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth

On 15/09/23 17:51, Nishanth Menon wrote:
> On 12:16-20230915, Neha Malcom Francis wrote:
>> k3-socinfo.c driver assumes silicon revisions to be 1.0, 2.0 etc. for
>> every platform. However this typical style is not followed by J721E
>> (1.0, 1.1) and need not be followed by upcoming silicon revisions as
>> well. Adapt the driver to be similar to its U-Boot counterpart
>> (drivers/soc/soc_ti_k3.c) that accounts for this difference on the
>> basis of partno/family.
>>
>> Note that we change the order of invocation of
>> k3_chipinfo_partno_to_names before k3_chipinfo_variant_to_sr so we
>> have the family name in case error is returned.
> 
> Drop reference to U-boot and others. How about this:
> 
> The driver assumes that the silicon revisions for every platform are
> incremental and one-to-one, corresponding to JTAG_ID's variant field:
> 1.0, 2.0, and so on. This assumption is wrong for SoCs such as J721E,
> where the variant field to revision mapping is 1,0, 1.1. Further,
> there are SoCs such as AM65x where the sub-variant version requires
> custom decoding of other registers.
> 
> Address this by using conditional handling per JTAG ID that requires
> an exception with J721E as the first example. To facilitate this
> conversion, use macros to identify the JTAG_ID part number and map them
> to predefined string array.
> 
>>
>> Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
> 
> Maintain original From or drop this or use Co-developed-by as applicable?
> 
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   drivers/soc/ti/k3-socinfo.c | 71 +++++++++++++++++++++++++++++--------
>>   1 file changed, 56 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
>> index 6ea9b8c7d335..6de1e3531af9 100644
>> --- a/drivers/soc/ti/k3-socinfo.c
>> +++ b/drivers/soc/ti/k3-socinfo.c
>> @@ -33,19 +33,37 @@
>>   
>>   #define CTRLMMR_WKUP_JTAGID_MFG_TI		0x17
>>   
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
>>   static const struct k3_soc_id {
>>   	unsigned int id;
>>   	const char *family_name;
>>   } k3_soc_ids[] = {
>> -	{ 0xBB5A, "AM65X" },
>> -	{ 0xBB64, "J721E" },
>> -	{ 0xBB6D, "J7200" },
>> -	{ 0xBB38, "AM64X" },
>> -	{ 0xBB75, "J721S2"},
>> -	{ 0xBB7E, "AM62X" },
>> -	{ 0xBB80, "J784S4" },
>> -	{ 0xBB8D, "AM62AX" },
>> -	{ 0xBB9D, "AM62PX" },
>> +	{ JTAG_ID_PARTNO_AM65X, "AM65X" },
>> +	{ JTAG_ID_PARTNO_J721E, "J721E" },
>> +	{ JTAG_ID_PARTNO_J7200, "J7200" },
>> +	{ JTAG_ID_PARTNO_AM64X, "AM64X" },
>> +	{ JTAG_ID_PARTNO_J721S2, "J721S2"},
>> +	{ JTAG_ID_PARTNO_AM62X, "AM62X" },
>> +	{ JTAG_ID_PARTNO_J784S4, "J784S4" },
>> +	{ JTAG_ID_PARTNO_AM62AX, "AM62AX" },
>> +	{ JTAG_ID_PARTNO_AM62PX, "AM62PX" },
>> +};
>> +
>> +static char *j721e_rev_string_map[] = {
> 
> static const?
> 
>> +	"1.0", "1.1",
>> +};
>> +
>> +static char *k3_rev_string_map[] = {
> 
> We can drop this (See below)
> 
>> +	"1.0", "2.0", "3.0",
>>   };
>>   
>>   static int
>> @@ -63,6 +81,29 @@ k3_chipinfo_partno_to_names(unsigned int partno,
>>   	return -EINVAL;
>>   }
>>   
>> +static int
>> +k3_chipinfo_variant_to_sr(unsigned int partno, unsigned int variant,
>> +			  struct soc_device_attribute *soc_dev_attr)
>> +{
>> +	switch (partno) {
>> +	case JTAG_ID_PARTNO_J721E:
>> +		if (variant >= ARRAY_SIZE(j721e_rev_string_map))
>> +			goto bail;
>> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
>> +						   j721e_rev_string_map[variant]);
>> +		break;
>> +	default:
>> +		if (variant >= ARRAY_SIZE(k3_rev_string_map))
>> +			goto bail;
>> +		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%s",
>> +						   k3_rev_string_map[variant]);
> 
> How about retaining the old logic as is?
> 
> soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
> 
>> +	}
> 
> what if !soc_dev_attr->revision error handling?
> 
>> +	return 0;
>> +
>> +bail:
> 
> Rename to something like err_unknown_variant ?
> 
>> +	return -EINVAL;
> return -ENODEV instead to help distinguish between not having memory Vs
> not finding a match?
> 
>> +}
>> +
>>   static int k3_chipinfo_probe(struct platform_device *pdev)
>>   {
>>   	struct device_node *node = pdev->dev.of_node;
>> @@ -94,7 +135,6 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>>   
>>   	variant = (jtag_id & CTRLMMR_WKUP_JTAGID_VARIANT_MASK) >>
>>   		  CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT;
>> -	variant++;
>>   
>>   	partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
>>   		 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
>> @@ -103,15 +143,16 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
>>   	if (!soc_dev_attr)
>>   		return -ENOMEM;
>>   
>> -	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
>> -	if (!soc_dev_attr->revision) {
>> -		ret = -ENOMEM;
>> +	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
>> +	if (ret) {
>> +		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);
> 
> Might be worthwhile to print the errno to distinguish between no mem
> fail vs nodev match fail. - see below for k3_chipinfo_partno_to_names
> 
>> +		ret = -ENODEV;
> 
> don't over-ride the return value - that is probably a preceding cleanup patch
> for k3_chipinfo_partno_to_names - also to distinguish between -ENOMEM vs
> -ENODEV.
> 
>>   		goto err;
>>   	}
>>   
>> -	ret = k3_chipinfo_partno_to_names(partno_id, soc_dev_attr);
>> +	ret = k3_chipinfo_variant_to_sr(partno_id, variant, soc_dev_attr);
>>   	if (ret) {
>> -		dev_err(dev, "Unknown SoC JTAGID[0x%08X]\n", jtag_id);
>> +		dev_err(dev, "Unknown revision for %s\n", soc_dev_attr->family);
>>   		ret = -ENODEV;
>>   		goto err_free_rev;
>>   	}
>> -- 
>> 2.34.1
>>
> 

Thanks for the detailed review! I will work on it and send v3.

-- 
Thanking You
Neha Malcom Francis
