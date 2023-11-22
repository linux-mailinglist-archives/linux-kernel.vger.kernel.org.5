Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697567F44D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjKVLWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjKVLWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:22:03 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DE5D8;
        Wed, 22 Nov 2023 03:21:57 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AM7Q1o8011498;
        Wed, 22 Nov 2023 05:21:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=CyZZZAJGHL5zuGw0uzi5JTgSN5c1fjynedb59fk38xE=; b=
        Id1kZiY4u6trLYWzefpvtBLcGNBlkFiGjv23PZbmh1y/9PfQvQ6so5EYRWYZXs0x
        5S2iBCOZhada4E8h6mxjXR5910HV7YBfJD6CjVQYqTPOeaomwED13m2RQMVY/jOY
        +tah9R9pqk73gIdUvTBsGb4DzoXlxiNaPK2o46Tsj68qknES2dIlKoQl8RXiQngk
        fhU75/W0/xykgqluWGSLSjtVr7Urt5yd97wnQet+Uu4EdO/Q8IZ2hk9nSxEJPov3
        Sg5pfeAUFondYHtwClYr529KZcH8ltiIC75+pV8i4RAuKwuYQZYHBDrvCit00H7c
        vRVlxOcbqyVIsX16g+qiPA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3uetjpccvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 05:21:28 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 22 Nov
 2023 11:21:26 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Wed, 22 Nov 2023 11:21:26 +0000
Received: from [198.61.65.15] (LONN2DGDQ73.ad.cirrus.com [198.61.65.15])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 01D12458;
        Wed, 22 Nov 2023 11:21:25 +0000 (UTC)
Message-ID: <d39b587b-fffc-4e5f-b213-8c4029d829f2@opensource.cirrus.com>
Date:   Wed, 22 Nov 2023 11:21:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/8] spi: Add multi-cs memories support in SPI core
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
References: <20231118135446.52783-1-amit.kumar-mahapatra@amd.com>
 <20231118135446.52783-2-amit.kumar-mahapatra@amd.com>
 <8182135b-6f4f-47ae-ba53-e94a058d466f@opensource.cirrus.com>
 <BN7PR12MB28026E2EBD64F0D49A1084ABDCBBA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <b10252e3-41bf-4d5c-bbd1-0af4c723884f@opensource.cirrus.com>
 <BN7PR12MB2802ADDA7C5789CADC1D89D2DCBBA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <d5b50766-b8f8-45b4-8a53-7baad200c6c2@opensource.cirrus.com>
 <BN7PR12MB2802C60FAEAD1716F76517ACDCBBA@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Language: en-GB
From:   Stefan Binding <sbinding@opensource.cirrus.com>
In-Reply-To: <BN7PR12MB2802C60FAEAD1716F76517ACDCBBA@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zw1mD8lwo4xDuwzKQ6WqVHAcwZnwuoOB
X-Proofpoint-ORIG-GUID: zw1mD8lwo4xDuwzKQ6WqVHAcwZnwuoOB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/11/2023 19:18, Mahapatra, Amit Kumar wrote:
> Hello Stefan,
>
>> -----Original Message-----
>> From: Stefan Binding <sbinding@opensource.cirrus.com>
>> Sent: Tuesday, November 21, 2023 11:07 PM
>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>> broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
>> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com
>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>> michael@walle.cc; linux-mtd@lists.infradead.org;
>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>> claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>; linux-
>> arm-kernel@lists.infradead.org; git (AMD-Xilinx) <git@amd.com>;
>> amitrkcian2002@gmail.com; patches@opensource.cirrus.com
>> Subject: Re: [PATCH v10 1/8] spi: Add multi-cs memories support in SPI core
>>
>>
>> On 21/11/2023 16:35, Mahapatra, Amit Kumar wrote:
>>> Hello Stefan,
>>>
>>>> -----Original Message-----
>>>> From: Stefan Binding <sbinding@opensource.cirrus.com>
>>>> Sent: Tuesday, November 21, 2023 7:28 PM
>>>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>>>> broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
>>>> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com
>>>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> michael@walle.cc; linux-mtd@lists.infradead.org;
>>>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>>>> claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>;
>>>> linux- arm-kernel@lists.infradead.org; git (AMD-Xilinx)
>>>> <git@amd.com>; amitrkcian2002@gmail.com;
>>>> patches@opensource.cirrus.com
>>>> Subject: Re: [PATCH v10 1/8] spi: Add multi-cs memories support in
>>>> SPI core
>>>>
>>>>
>>>> On 21/11/2023 07:39, Mahapatra, Amit Kumar wrote:
>>>>> Hello Stefan,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Stefan Binding <sbinding@opensource.cirrus.com>
>>>>>> Sent: Monday, November 20, 2023 8:00 PM
>>>>>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>>>>>> broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
>>>>>> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com
>>>>>> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>>> michael@walle.cc; linux-mtd@lists.infradead.org;
>>>>>> nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
>>>>>> claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>;
>>>>>> linux- arm-kernel@lists.infradead.org; git (AMD-Xilinx)
>>>>>> <git@amd.com>; amitrkcian2002@gmail.com;
>>>>>> patches@opensource.cirrus.com
>>>>>> Subject: Re: [PATCH v10 1/8] spi: Add multi-cs memories support in
>>>>>> SPI core
>>>>>>
>>>>>>
>>>>>> On 18/11/2023 13:54, Amit Kumar Mahapatra wrote:
>>>>>>> AMD-Xilinx GQSPI controller has two advanced mode that allows the
>>>>>>> controller to consider two flashes as one single device.
>>>>>>>
>>>>>>> One of these two mode is the parallel mode in which each byte of
>>>>>>> data is stored in both devices, the even bits in the lower flash &
>>>>>>> the odd bits in the upper flash. The byte split is automatically
>>>>>>> handled by the QSPI controller.
>>>>>>>
>>>>>>> The other mode is the stacked mode in which both the flashes share
>>>>>>> the same SPI bus but each of the device contain half of the data.
>>>>>>> In this mode, the controller does not follow CS requests but
>>>>>>> instead internally wires the two CS levels with the value of the
>>>>>>> most significant
>>>>>> address bit.
>>>>>>> For supporting both these modes SPI core need to be updated for
>>>>>>> providing multiple CS for a single SPI device.
>>>>>>>
>>>>>>> For adding multi CS support the SPI device need to be aware of all
>>>>>>> the CS values. So, the "chip_select" member in the spi_device
>>>>>>> structure is now an array that holds all the CS values.
>>>>>>>
>>>>>>> spi_device structure now has a "cs_index_mask" member. This acts
>>>>>>> as an index to the chip_select array. If nth bit of
>>>>>>> spi->cs_index_mask is set then the driver would assert spi-
>>> chip_select[n].
>>>>>>> In parallel mode all the chip selects are asserted/de-asserted
>>>>>>> simultaneously and each byte of data is stored in both devices,
>>>>>>> the even bits in one, the odd bits in the other. The split is
>>>>>>> automatically handled by the GQSPI controller. The GQSPI
>>>>>>> controller supports a maximum of two flashes connected in parallel
>>>>>>> mode. A SPI_CONTROLLER_MULTI_CS flag bit is added in the spi
>>>>>>> controller flags, through ctlr->flags the spi core will make sure
>>>>>>> that the controller is capable of handling multiple chip selects at once.
>>>>>>>
>>>>>>> For supporting multiple CS via GPIO the cs_gpiod member of the
>>>>>>> spi_device structure is now an array that holds the gpio
>>>>>>> descriptor for each chipselect.
>>>>>>>
>>>>>>> CS GPIO is not tested due to unavailability of necessary hardware
>> setup.
>>>>>>> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-
>>>> mahapatra@amd.com>
>>>>>>> ---
>>>>>>> Hello @Stefen,
>>>>>>> We restructured the SPI core implementation, for handling
>>>>>>> arbitrary number of devices connected in parallel(multi-cs) or stacked
>> mode.
>>>>>>> We have tested this updated patch on native-cs setup but couldn't
>>>>>>> test cs-gpio due to unavailability of a proper setup. If possible,
>>>>>>> could you please retest the cs-gpio use case with this updated
>>>>>>> patch and provide
>>>>>> your feedback.
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I tested this chain on 2 different systems using GPIOs as chip
>>>>>> selects, and see the same error on both:
>>>>>> [    2.842045] pxa2xx-spi pxa2xx-spi.6: chipselect 0 already in use
>>>>>>
>>>>>> Let me know if you need any further testing.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> Stefan Binding
>>>>>>
>>>>>>> ---
>>>>>>>      drivers/spi/spi.c       | 192 +++++++++++++++++++++++++++++++-------
>> --
>>>>>>>      include/linux/spi/spi.h |  51 ++++++++---
>>>>>>>      2 files changed, 191 insertions(+), 52 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
>>>>>>> 8ead7acb99f3..ff66147ba95f 100644
>>>>>>> --- a/drivers/spi/spi.c
>>>>>>> +++ b/drivers/spi/spi.c
>>>>>>> @@ -612,10 +612,21 @@ static int spi_dev_check(struct device *dev,
>>>>>>> void
>>>>>> *data)
>>>>>>>      {
>>>>>>>      	struct spi_device *spi = to_spi_device(dev);
>>>>>>>      	struct spi_device *new_spi = data;
>>>>>>> -
>>>>>>> -	if (spi->controller == new_spi->controller &&
>>>>>>> -	    spi_get_chipselect(spi, 0) == spi_get_chipselect(new_spi, 0))
>>>>>>> -		return -EBUSY;
>>>>>>> +	int idx, nw_idx;
>>>>>>> +	u8 cs, cs_nw;
>>>>>>> +
>>>>>>> +	if (spi->controller == new_spi->controller) {
>>>>>>> +		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>>>> +			cs = spi_get_chipselect(spi, idx);
>>>>>>> +			for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX;
>>>>>> nw_idx++) {
>>>>>>> +				cs_nw = spi_get_chipselect(spi,
>> nw_idx);
>>>>> Thank you for dedicating your time to test my patch.
>>>>> As per my analysis the error is reported from here as we are
>>>>> supplying the former SPI device structure to retrieve the CS value
>>>>> for the new SPI devices.
>>>>> To fix this, could you kindly substitute the above line with
>>>>>
>>>>> cs_nw = spi_get_chipselect(new_spi, nw_idx);
>>>>>
>>>>> and rerun your tests?
>>>>> If it works correctly, I will incorporate this fix into my upcoming
>>>>> series.
>>>>>
>>>>> Regards,
>>>>> Amit
>> Hi,
>>
>> I've attached my log.
>> I notice that you add a print to of_spi_parse_dt, however since the laptop I
>> am using is an x86 laptop, it uses ACPI rather than OF, and I don't think this
>> function isnt even compiled in.
> That’s correct, I missed it.
> Upon reviewing the logs, I discovered that in the ACPI flow, I am not
> initializing the unused CS[] to FF, as I am doing in the OF flow.
> Consequently, in the ACPI flow, all the unused CS[] are automatically
> initialized to 0. During the __spi_add_device process, the SPI core faces
> difficulty distinguishing between a valid CS value of 0 and an unused CS
> value of 0, leading to a failure in the driver probe.
>
> Incorporating the following modifications should resolve this issue.
> Kindly apply these changes on top of 1/8 and re-run the test.
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ff66147ba95f..d0301c17d4f8 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -619,7 +619,7 @@ static int spi_dev_check(struct device *dev, void *data)
>                  for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>                          cs = spi_get_chipselect(spi, idx);
>                          for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
> -                               cs_nw = spi_get_chipselect(spi, nw_idx);
> +                               cs_nw = spi_get_chipselect(new_spi, nw_idx);
>                                  if (cs != 0xFF && cs_nw != 0xFF && cs == cs_nw) {
>                                          dev_err(dev, "chipselect %d already in use\n", cs_nw);
>                                          return -EBUSY;
> @@ -764,6 +764,7 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
>   {
>          struct spi_device       *proxy;
>          int                     status;
> +       u8                      idx;
>   
>          /*
>           * NOTE:  caller did any chip->bus_num checks necessary.
> @@ -779,6 +780,9 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
>   
>          WARN_ON(strlen(chip->modalias) >= sizeof(proxy->modalias));
>   
> +       for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
> +               spi_set_chipselect(proxy, idx, 0xFF);
> +
>          spi_set_chipselect(proxy, 0, chip->chip_select);
>          proxy->max_speed_hz = chip->max_speed_hz;
>          proxy->mode = chip->mode;
> @@ -2514,6 +2518,7 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
>          struct spi_controller *ctlr = spi->controller;
>          struct spi_device *ancillary;
>          int rc = 0;
> +       u8 idx;
>   
>          /* Alloc an spi_device */
>          ancillary = spi_alloc_device(ctlr);
> @@ -2524,6 +2529,9 @@ struct spi_device *spi_new_ancillary_device(struct spi_device *spi,
>
>          strscpy(ancillary->modalias, "dummy", sizeof(ancillary->modalias));
>   
> +       for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
> +               spi_set_chipselect(ancillary, idx, 0xFF);
> +
>          /* Use provided chip-select for ancillary device */
>          spi_set_chipselect(ancillary, 0, chip_select);
>   
> @@ -2732,6 +2740,7 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
>          struct acpi_spi_lookup lookup = {};
>          struct spi_device *spi;
>          int ret;
> +       u8 idx;
>   
>          if (!ctlr && index == -1)
>                  return ERR_PTR(-EINVAL);
> @@ -2767,6 +2776,9 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
>                  return ERR_PTR(-ENOMEM);
>          }
>   
> +       for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
> +               spi_set_chipselect(spi, idx, 0xFF);
> +
>          ACPI_COMPANION_SET(&spi->dev, adev);
>          spi->max_speed_hz       = lookup.max_speed_hz;
>          spi->mode               |= lookup.mode;
>
> Regards,
> Amit
>   

Hi,

I no longer see that error, or any errors printed from SPI, however, all 
of the transactions are now broken.
Every transaction seems to read back 0x0, on all SPI devices, whether 
native CS or GPIO CS, and I dont see it toggling the CS GPIO anymore.

Thanks,

Stefan

>> Thanks,
>>
>> Stefan
>>
>>>> Hi,
>>>>
>>>> I still see the same error:
>>>>
>>>> [    2.748546] pxa2xx-spi pxa2xx-spi.6: chipselect 0 already in use
>>> Thank you for the quick testing. For further analysis I have
>>> incorporated additional debug prints on top of 1/8 patch. The
>>> corresponding diff is shared below. Kindly implement the specified
>>> changes, rerun your test and share the kernel logs.
>>>
>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
>>> ff66147ba95f..7f59ea81593d 100644
>>> --- a/drivers/spi/spi.c
>>> +++ b/drivers/spi/spi.c
>>> @@ -618,8 +618,10 @@ static int spi_dev_check(struct device *dev, void
>> *data)
>>>           if (spi->controller == new_spi->controller) {
>>>                   for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>                           cs = spi_get_chipselect(spi, idx);
>>> +                       printk("%s() [%d] CS[%d] = [%d]\n", __func__,
>>> + __LINE__, idx, cs);
>>>                           for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
>>> -                               cs_nw = spi_get_chipselect(spi, nw_idx);
>>> +                               cs_nw = spi_get_chipselect(new_spi, nw_idx);
>>> +                               printk("%s() [%d] CS_NEW[%d] =
>>> + [%d]\n", __func__, __LINE__, nw_idx, cs_nw);
>>>                                   if (cs != 0xFF && cs_nw != 0xFF && cs == cs_nw) {
>>>                                           dev_err(dev, "chipselect %d already in use\n",
>> cs_nw);
>>>                                           return -EBUSY; @@ -659,8
>>> +661,10 @@ static int __spi_add_device(struct spi_device *spi)
>>>            */
>>>           for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>                   cs = spi_get_chipselect(spi, idx);
>>> +               printk("%s() [%d] CS[%d] = [%d]\n", __func__,
>>> + __LINE__, idx, cs);
>>>                   for (nw_idx = idx + 1; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
>>>                           nw_cs = spi_get_chipselect(spi, nw_idx);
>>> +                       printk("%s() [%d] CS_NEW[%d] = [%d]\n",
>>> + __func__, __LINE__, nw_idx, nw_cs);
>>>                           if (cs != 0xFF && nw_cs != 0xFF && cs == nw_cs) {
>>>                                   dev_err(dev, "chipselect %d already in use\n", nw_cs);
>>>                                   return -EBUSY; @@ -2401,6 +2405,9 @@
>>> static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>>           for (idx = 0; idx < rc; idx++)
>>>                   spi_set_chipselect(spi, idx, cs[idx]);
>>>
>>> +       for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
>>> +               printk("%s() [%d] CS[%d] = [%d]\n", __func__,
>>> + __LINE__, idx, spi_get_chipselect(spi, idx));
>>> +
>>>           /* spi->chip_select[i] gives the corresponding physical CS for logical CS i
>>>            * logical CS number is represented by setting the ith bit in spi-
>>> cs_index_mask
>>>            * So, for example, if spi->cs_index_mask = 0x01 then logical
>>> CS number is 0 and
>>>
>>> Regards,
>>> Amit
>>>
>>>> Thanks,
>>>>
>>>> Stefan
>>>>
>>>>>>> +				if (cs != 0xFF && cs_nw != 0xFF && cs
>> ==
>>>>>> cs_nw) {
>>>>>>> +					dev_err(dev, "chipselect %d
>> already in
>>>>>> use\n", cs_nw);
>>>>>>> +					return -EBUSY;
>>>>>>> +				}
>>>>>>> +			}
>>>>>>> +		}
>>>>>>> +	}
>>>>>>>      	return 0;
>>>>>>>      }
>>>>>>>
>>>>>>> @@ -629,13 +640,32 @@ static int __spi_add_device(struct
>>>>>>> spi_device
>>>> *spi)
>>>>>>>      {
>>>>>>>      	struct spi_controller *ctlr = spi->controller;
>>>>>>>      	struct device *dev = ctlr->dev.parent;
>>>>>>> -	int status;
>>>>>>> +	int status, idx, nw_idx;
>>>>>>> +	u8 cs, nw_cs;
>>>>>>> +
>>>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>>>> +		/* Chipselects are numbered 0..max; validate. */
>>>>>>> +		cs = spi_get_chipselect(spi, idx);
>>>>>>> +		if (cs != 0xFF && cs >= ctlr->num_chipselect) {
>>>>>>> +			dev_err(dev, "cs%d >= max %d\n",
>>>>>> spi_get_chipselect(spi, idx),
>>>>>>> +				ctlr->num_chipselect);
>>>>>>> +			return -EINVAL;
>>>>>>> +		}
>>>>>>> +	}
>>>>>>>
>>>>>>> -	/* Chipselects are numbered 0..max; validate. */
>>>>>>> -	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
>>>>>>> -		dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
>>>>>>> -			ctlr->num_chipselect);
>>>>>>> -		return -EINVAL;
>>>>>>> +	/*
>>>>>>> +	 * Make sure that multiple logical CS doesn't map to the same
>>>>>> physical CS.
>>>>>>> +	 * For example, spi->chip_select[0] != spi->chip_select[1] and
>> so on.
>>>>>>> +	 */
>>>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>>>> +		cs = spi_get_chipselect(spi, idx);
>>>>>>> +		for (nw_idx = idx + 1; nw_idx < SPI_CS_CNT_MAX;
>> nw_idx++) {
>>>>>>> +			nw_cs = spi_get_chipselect(spi, nw_idx);
>>>>>>> +			if (cs != 0xFF && nw_cs != 0xFF && cs ==
>> nw_cs) {
>>>>>>> +				dev_err(dev, "chipselect %d already in
>> use\n",
>>>>>> nw_cs);
>>>>>>> +				return -EBUSY;
>>>>>>> +			}
>>>>>>> +		}
>>>>>>>      	}
>>>>>>>
>>>>>>>      	/* Set the bus ID string */
>>>>>>> @@ -647,11 +677,8 @@ static int __spi_add_device(struct spi_device
>>>> *spi)
>>>>>>>      	 * its configuration.
>>>>>>>      	 */
>>>>>>>      	status = bus_for_each_dev(&spi_bus_type, NULL, spi,
>> spi_dev_check);
>>>>>>> -	if (status) {
>>>>>>> -		dev_err(dev, "chipselect %d already in use\n",
>>>>>>> -				spi_get_chipselect(spi, 0));
>>>>>>> +	if (status)
>>>>>>>      		return status;
>>>>>>> -	}
>>>>>>>
>>>>>>>      	/* Controller may unregister concurrently */
>>>>>>>      	if (IS_ENABLED(CONFIG_SPI_DYNAMIC) && @@ -659,8
>> +686,15 @@
>>>>>> static
>>>>>>> int __spi_add_device(struct spi_device *spi)
>>>>>>>      		return -ENODEV;
>>>>>>>      	}
>>>>>>>
>>>>>>> -	if (ctlr->cs_gpiods)
>>>>>>> -		spi_set_csgpiod(spi, 0, ctlr->cs_gpiods[spi_get_chipselect(spi,
>>>>>> 0)]);
>>>>>>> +	if (ctlr->cs_gpiods) {
>>>>>>> +		u8 cs;
>>>>>>> +
>>>>>>> +		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>>>> +			cs = spi_get_chipselect(spi, idx);
>>>>>>> +			if (cs != 0xFF)
>>>>>>> +				spi_set_csgpiod(spi, idx, ctlr-
>>> cs_gpiods[cs]);
>>>>>>> +		}
>>>>>>> +	}
>>>>>>>
>>>>>>>      	/*
>>>>>>>      	 * Drivers may modify this initial i/o setup, but will @@
>>>>>>> -701,6
>>>>>>> +735,9 @@ int spi_add_device(struct spi_device *spi)
>>>>>>>      	struct spi_controller *ctlr = spi->controller;
>>>>>>>      	int status;
>>>>>>>
>>>>>>> +	/* Set the bus ID string */
>>>>>>> +	spi_dev_set_name(spi);
>>>>>>> +
>>>>>>>      	mutex_lock(&ctlr->add_lock);
>>>>>>>      	status = __spi_add_device(spi);
>>>>>>>      	mutex_unlock(&ctlr->add_lock); @@ -942,32 +979,51 @@
>> static
>>>>>>> void spi_res_release(struct spi_controller
>>>>>> *ctlr, struct spi_message *mes
>>>>>>>      }
>>>>>>>
>>>>>>>
>>>>>>> /*----------------------------------------------------------------
>>>>>>> --
>>>>>>> --
>>>>>>> -----*/
>>>>>>> +static inline bool spi_is_last_cs(struct spi_device *spi) {
>>>>>>> +	u8 idx;
>>>>>>> +	bool last = false;
>>>>>>> +
>>>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>>>> +		if ((spi->cs_index_mask >> idx) & 0x01) {
>>>>>>> +			if (spi->controller->last_cs[idx] ==
>>>>>> spi_get_chipselect(spi, idx))
>>>>>>> +				last = true;
>>>>>>> +		}
>>>>>>> +	}
>>>>>>> +	return last;
>>>>>>> +}
>>>>>>> +
>>>>>>>
>>>>>>>      static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>>>>>>>      {
>>>>>>>      	bool activate = enable;
>>>>>>> +	u8 idx;
>>>>>>>
>>>>>>>      	/*
>>>>>>>      	 * Avoid calling into the driver (or doing delays) if the chip
>> select
>>>>>>>      	 * isn't actually changing from the last time this was called.
>>>>>>>      	 */
>>>>>>> -	if (!force && ((enable && spi->controller->last_cs ==
>>>>>> spi_get_chipselect(spi, 0)) ||
>>>>>>> -		       (!enable && spi->controller->last_cs !=
>>>>>> spi_get_chipselect(spi, 0))) &&
>>>>>>> +	if (!force && ((enable && spi->controller->last_cs_index_mask
>> ==
>>>>>>> +spi-
>>>>>>> cs_index_mask &&
>>>>>>> +			spi_is_last_cs(spi)) ||
>>>>>>> +		       (!enable && spi->controller->last_cs_index_mask
>> == spi-
>>>>>>> cs_index_mask &&
>>>>>>> +			!spi_is_last_cs(spi))) &&
>>>>>>>      	    (spi->controller->last_cs_mode_high == (spi->mode &
>>>>>> SPI_CS_HIGH)))
>>>>>>>      		return;
>>>>>>>
>>>>>>>      	trace_spi_set_cs(spi, activate);
>>>>>>>
>>>>>>> -	spi->controller->last_cs = enable ? spi_get_chipselect(spi, 0) : -1;
>>>>>>> +	spi->controller->last_cs_index_mask = spi->cs_index_mask;
>>>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
>>>>>>> +		spi->controller->last_cs[idx] = enable ?
>>>>>>> +spi_get_chipselect(spi,
>>>>>> 0)
>>>>>>> +: -1;
>>>>>>>      	spi->controller->last_cs_mode_high = spi->mode &
>> SPI_CS_HIGH;
>>>>>>> -	if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) &&
>>>>>> !activate)
>>>>>>> -		spi_delay_exec(&spi->cs_hold, NULL);
>>>>>>> -
>>>>>>>      	if (spi->mode & SPI_CS_HIGH)
>>>>>>>      		enable = !enable;
>>>>>>>
>>>>>>> -	if (spi_get_csgpiod(spi, 0)) {
>>>>>>> +	if (spi_is_csgpiod(spi)) {
>>>>>>> +		if (!spi->controller->set_cs_timing && !activate)
>>>>>>> +			spi_delay_exec(&spi->cs_hold, NULL);
>>>>>>> +
>>>>>>>      		if (!(spi->mode & SPI_NO_CS)) {
>>>>>>>      			/*
>>>>>>>      			 * Historically ACPI has no means of the GPIO
>> polarity
>>>>>> and @@
>>>>>>> -979,26 +1035,38 @@ static void spi_set_cs(struct spi_device *spi,
>>>>>>> bool
>>>>>> enable, bool force)
>>>>>>>      			 * ambiguity. That's why we use enable, that
>> takes
>>>>>> SPI_CS_HIGH
>>>>>>>      			 * into account.
>>>>>>>      			 */
>>>>>>> -			if (has_acpi_companion(&spi->dev))
>>>>>>> -
>>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), !enable);
>>>>>>> -			else
>>>>>>> -				/* Polarity handled by GPIO library */
>>>>>>> -
>>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), activate);
>>>>>>> +			for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>>>> +				if (((spi->cs_index_mask >> idx) &
>> 0x01) &&
>>>>>>> +				    spi_get_csgpiod(spi, idx)) {
>>>>>>> +					if (has_acpi_companion(&spi-
>>> dev))
>>>>>>> +
>>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
>>>>>>> +
>>>>>> !enable);
>>>>>>> +					else
>>>>>>> +						/* Polarity handled by
>> GPIO
>>>>>> library */
>>>>>>> +
>>>>>> 	gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
>>>>>>> +
>>>>>> activate);
>>>>>>> +
>>>>>>> +					if (activate)
>>>>>>> +						spi_delay_exec(&spi-
>>>>>>> cs_setup, NULL);
>>>>>>> +					else
>>>>>>> +						spi_delay_exec(&spi-
>>>>>>> cs_inactive, NULL);
>>>>>>> +				}
>>>>>>> +			}
>>>>>>>      		}
>>>>>>>      		/* Some SPI masters need both GPIO CS &
>> slave_select */
>>>>>>>      		if ((spi->controller->flags &
>> SPI_CONTROLLER_GPIO_SS) &&
>>>>>>>      		    spi->controller->set_cs)
>>>>>>>      			spi->controller->set_cs(spi, !enable);
>>>>>>> +
>>>>>>> +		if (!spi->controller->set_cs_timing) {
>>>>>>> +			if (activate)
>>>>>>> +				spi_delay_exec(&spi->cs_setup,
>> NULL);
>>>>>>> +			else
>>>>>>> +				spi_delay_exec(&spi->cs_inactive,
>> NULL);
>>>>>>> +		}
>>>>>>>      	} else if (spi->controller->set_cs) {
>>>>>>>      		spi->controller->set_cs(spi, !enable);
>>>>>>>      	}
>>>>>>> -
>>>>>>> -	if (spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) {
>>>>>>> -		if (activate)
>>>>>>> -			spi_delay_exec(&spi->cs_setup, NULL);
>>>>>>> -		else
>>>>>>> -			spi_delay_exec(&spi->cs_inactive, NULL);
>>>>>>> -	}
>>>>>>>      }
>>>>>>>
>>>>>>>      #ifdef CONFIG_HAS_DMA
>>>>>>> @@ -2222,8 +2290,8 @@ static void of_spi_parse_dt_cs_delay(struct
>>>>>> device_node *nc,
>>>>>>>      static int of_spi_parse_dt(struct spi_controller *ctlr, struct
>>>>>>> spi_device
>>>> *spi,
>>>>>>>      			   struct device_node *nc)
>>>>>>>      {
>>>>>>> -	u32 value;
>>>>>>> -	int rc;
>>>>>>> +	u32 value, cs[SPI_CS_CNT_MAX];
>>>>>>> +	int rc, idx;
>>>>>>>
>>>>>>>      	/* Mode (clock phase/polarity/etc.) */
>>>>>>>      	if (of_property_read_bool(nc, "spi-cpha")) @@ -2295,14
>>>>>>> +2363,52
>>>>>> @@
>>>>>>> static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device
>> *spi,
>>>>>>>      		return 0;
>>>>>>>      	}
>>>>>>>
>>>>>>> +	if (ctlr->num_chipselect > SPI_CS_CNT_MAX) {
>>>>>>> +		dev_err(&ctlr->dev, "No. of CS is more than max. no.
>> of
>>>>>> supported CS\n");
>>>>>>> +		return -EINVAL;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	/*
>>>>>>> +	 * Zero(0) is a valid physical CS value and can be located at
>> any
>>>>>>> +	 * logical CS in the spi->chip_select[]. If all the physical CS
>>>>>>> +	 * are initialized to 0 then It would be difficult to differentiate
>>>>>>> +	 * between a valid physical CS 0 & an unused logical CS whose
>>>>>> physical
>>>>>>> +	 * CS can be 0. As a solution to this issue initialize all the CS to
>> 0xFF.
>>>>>>> +	 * Now all the unused logical CS will have 0xFF physical CS
>>>>>>> +value & can
>>>>>> be
>>>>>>> +	 * ignore while performing physical CS validity checks.
>>>>>>> +	 */
>>>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
>>>>>>> +		spi_set_chipselect(spi, idx, 0xFF);
>>>>>>> +
>>>>>>>      	/* Device address */
>>>>>>> -	rc = of_property_read_u32(nc, "reg", &value);
>>>>>>> -	if (rc) {
>>>>>>> +	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0],
>> 1,
>>>>>>> +						 SPI_CS_CNT_MAX);
>>>>>>> +	if (rc < 0) {
>>>>>>>      		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property
>>>>>> (%d)\n",
>>>>>>>      			nc, rc);
>>>>>>>      		return rc;
>>>>>>>      	}
>>>>>>> -	spi_set_chipselect(spi, 0, value);
>>>>>>> +	if (rc > ctlr->num_chipselect) {
>>>>>>> +		dev_err(&ctlr->dev, "%pOF has number of CS > ctlr-
>>>>>>> num_chipselect (%d)\n",
>>>>>>> +			nc, rc);
>>>>>>> +		return rc;
>>>>>>> +	}
>>>>>>> +	if ((of_property_read_bool(nc, "parallel-memories")) &&
>>>>>>> +	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
>>>>>>> +		dev_err(&ctlr->dev, "SPI controller doesn't support
>> multi
>>>>>> CS\n");
>>>>>>> +		return -EINVAL;
>>>>>>> +	}
>>>>>>> +	for (idx = 0; idx < rc; idx++)
>>>>>>> +		spi_set_chipselect(spi, idx, cs[idx]);
>>>>>>> +
>>>>>>> +	/* spi->chip_select[i] gives the corresponding physical CS for
>>>>>>> +logical CS
>>>>>> i
>>>>>>> +	 * logical CS number is represented by setting the ith bit in
>>>>>>> +spi-
>>>>>>> cs_index_mask
>>>>>>> +	 * So, for example, if spi->cs_index_mask = 0x01 then logical
>> CS
>>>>>> number is 0 and
>>>>>>> +	 * spi->chip_select[0] will give the physical CS.
>>>>>>> +	 * By default spi->chip_select[0] will hold the physical CS
>>>>>>> +number so,
>>>>>> set
>>>>>>> +	 * spi->cs_index_mask as 0x01.
>>>>>>> +	 */
>>>>>>> +	spi->cs_index_mask = 0x01;
>>>>>>>
>>>>>>>      	/* Device speed */
>>>>>>>      	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
>>>>>>> @@
>>>>>>> -3100,6 +3206,7 @@ int spi_register_controller(struct spi_controller
>> *ctlr)
>>>>>>>      	struct boardinfo	*bi;
>>>>>>>      	int			first_dynamic;
>>>>>>>      	int			status;
>>>>>>> +	int			idx;
>>>>>>>
>>>>>>>      	if (!dev)
>>>>>>>      		return -ENODEV;
>>>>>>> @@ -3164,7 +3271,8 @@ int spi_register_controller(struct
>>>>>>> spi_controller
>>>>>> *ctlr)
>>>>>>>      	}
>>>>>>>
>>>>>>>      	/* Setting last_cs to -1 means no chip selected */
>>>>>>> -	ctlr->last_cs = -1;
>>>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
>>>>>>> +		ctlr->last_cs[idx] = -1;
>>>>>>>
>>>>>>>      	status = device_add(&ctlr->dev);
>>>>>>>      	if (status < 0)
>>>>>>> @@ -3889,7 +3997,7 @@ static int __spi_validate(struct spi_device
>>>>>>> *spi,
>>>>>> struct spi_message *message)
>>>>>>>      	 * cs_change is set for each transfer.
>>>>>>>      	 */
>>>>>>>      	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits &
>>>>>> SPI_CS_WORD) ||
>>>>>>> -					  spi_get_csgpiod(spi, 0))) {
>>>>>>> +					  spi_is_csgpiod(spi))) {
>>>>>>>      		size_t maxsize = BITS_TO_BYTES(spi->bits_per_word);
>>>>>>>      		int ret;
>>>>>>>
>>>>>>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>>>>>>> index 7b4baff63c5c..871d3a6d879b 100644
>>>>>>> --- a/include/linux/spi/spi.h
>>>>>>> +++ b/include/linux/spi/spi.h
>>>>>>> @@ -20,6 +20,9 @@
>>>>>>>
>>>>>>>      #include <uapi/linux/spi/spi.h>
>>>>>>>
>>>>>>> +/* Max no. of CS supported per spi device */ #define
>>>>>>> +SPI_CS_CNT_MAX
>>>>>>> +4
>>>>>>> +
>>>>>>>      struct dma_chan;
>>>>>>>      struct software_node;
>>>>>>>      struct ptp_system_timestamp;
>>>>>>> @@ -132,7 +135,8 @@ extern void
>>>>>> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
>>>>>>>       * @max_speed_hz: Maximum clock rate to be used with this chip
>>>>>>>       *	(on this board); may be changed by the device's driver.
>>>>>>>       *	The spi_transfer.speed_hz can override this for each transfer.
>>>>>>> - * @chip_select: Chipselect, distinguishing chips handled by
>> @controller.
>>>>>>> + * @chip_select: Array of physical chipselect, spi->chipselect[i] gives
>>>>>>> + *	the corresponding physical CS for logical CS i.
>>>>>>>       * @mode: The spi mode defines how data is clocked out and in.
>>>>>>>       *	This may be changed by the device's driver.
>>>>>>>       *	The "active low" default for chipselect mode can be
>> overridden
>>>>>>> @@ -157,8 +161,8 @@ extern void
>>>>>> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
>>>>>>>       *	the device will bind to the named driver and only the named
>> driver.
>>>>>>>       *	Do not set directly, because core frees it; use
>> driver_set_override() to
>>>>>>>       *	set or clear it.
>>>>>>> - * @cs_gpiod: GPIO descriptor of the chipselect line (optional,
>>>>>>> NULL
>>>> when
>>>>>>> - *	not using a GPIO line)
>>>>>>> + * @cs_gpiod: Array of GPIO descriptors of the corresponding
>>>>>>> + chipselect
>>>>>> lines
>>>>>>> + *	(optional, NULL when not using a GPIO line)
>>>>>>>       * @word_delay: delay to be inserted between consecutive
>>>>>>>       *	words of a transfer
>>>>>>>       * @cs_setup: delay to be introduced by the controller after
>>>>>>> CS is asserted @@ -167,6 +171,7 @@ extern void
>>>>>> spi_transfer_cs_change_delay_exec(struct spi_message *msg,
>>>>>>>       *	deasserted. If @cs_change_delay is used from @spi_transfer,
>> then
>>>>>> the
>>>>>>>       *	two delays will be added up.
>>>>>>>       * @pcpu_statistics: statistics for the spi_device
>>>>>>> + * @cs_index_mask: Bit mask of the active chipselect(s) in the
>>>>>>> + chipselect array
>>>>>>>       *
>>>>>>>       * A @spi_device is used to interchange data between an SPI slave
>>>>>>>       * (usually a discrete chip) and CPU memory.
>>>>>>> @@ -182,7 +187,7 @@ struct spi_device {
>>>>>>>      	struct spi_controller	*controller;
>>>>>>>      	struct spi_controller	*master;	/* Compatibility layer
>> */
>>>>>>>      	u32			max_speed_hz;
>>>>>>> -	u8			chip_select;
>>>>>>> +	u8			chip_select[SPI_CS_CNT_MAX];
>>>>>>>      	u8			bits_per_word;
>>>>>>>      	bool			rt;
>>>>>>>      #define SPI_NO_TX		BIT(31)		/* No transmit wire */
>>>>>>> @@ -213,7 +218,7 @@ struct spi_device {
>>>>>>>      	void			*controller_data;
>>>>>>>      	char			modalias[SPI_NAME_SIZE];
>>>>>>>      	const char		*driver_override;
>>>>>>> -	struct gpio_desc	*cs_gpiod;	/* Chip select GPIO descriptor
>>>>>> */
>>>>>>> +	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/*
>> Chip select
>>>>>> gpio desc */
>>>>>>>      	struct spi_delay	word_delay; /* Inter-word delay */
>>>>>>>      	/* CS delays */
>>>>>>>      	struct spi_delay	cs_setup;
>>>>>>> @@ -223,6 +228,13 @@ struct spi_device {
>>>>>>>      	/* The statistics */
>>>>>>>      	struct spi_statistics __percpu	*pcpu_statistics;
>>>>>>>
>>>>>>> +	/* Bit mask of the chipselect(s) that the driver need to use
>> from
>>>>>>> +	 * the chipselect array.When the controller is capable to
>> handle
>>>>>>> +	 * multiple chip selects & memories are connected in parallel
>>>>>>> +	 * then more than one bit need to be set in cs_index_mask.
>>>>>>> +	 */
>>>>>>> +	u32			cs_index_mask : SPI_CS_CNT_MAX;
>>>>>>> +
>>>>>>>      	/*
>>>>>>>      	 * Likely need more hooks for more protocol options affecting
>> how
>>>>>>>      	 * the controller talks to each chip, like:
>>>>>>> @@ -279,22 +291,33 @@ static inline void *spi_get_drvdata(const
>>>>>>> struct spi_device *spi)
>>>>>>>
>>>>>>>      static inline u8 spi_get_chipselect(const struct spi_device *spi, u8 idx)
>>>>>>>      {
>>>>>>> -	return spi->chip_select;
>>>>>>> +	return spi->chip_select[idx];
>>>>>>>      }
>>>>>>>
>>>>>>>      static inline void spi_set_chipselect(struct spi_device *spi,
>>>>>>> u8 idx, u8
>>>>>> chipselect)
>>>>>>>      {
>>>>>>> -	spi->chip_select = chipselect;
>>>>>>> +	spi->chip_select[idx] = chipselect;
>>>>>>>      }
>>>>>>>
>>>>>>>      static inline struct gpio_desc *spi_get_csgpiod(const struct
>>>>>>> spi_device *spi,
>>>>>> u8 idx)
>>>>>>>      {
>>>>>>> -	return spi->cs_gpiod;
>>>>>>> +	return spi->cs_gpiod[idx];
>>>>>>>      }
>>>>>>>
>>>>>>>      static inline void spi_set_csgpiod(struct spi_device *spi, u8
>>>>>>> idx, struct
>>>>>> gpio_desc *csgpiod)
>>>>>>>      {
>>>>>>> -	spi->cs_gpiod = csgpiod;
>>>>>>> +	spi->cs_gpiod[idx] = csgpiod;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline bool spi_is_csgpiod(struct spi_device *spi) {
>>>>>>> +	u8 idx;
>>>>>>> +
>>>>>>> +	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
>>>>>>> +		if (spi_get_csgpiod(spi, idx))
>>>>>>> +			return true;
>>>>>>> +	}
>>>>>>> +	return false;
>>>>>>>      }
>>>>>>>
>>>>>>>      /**
>>>>>>> @@ -399,6 +422,8 @@ extern struct spi_device
>>>>>> *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>>>>>>>       * @bus_lock_spinlock: spinlock for SPI bus locking
>>>>>>>       * @bus_lock_mutex: mutex for exclusion of multiple callers
>>>>>>>       * @bus_lock_flag: indicates that the SPI bus is locked for
>>>>>>> exclusive use
>>>>>>> + * @multi_cs_cap: indicates that the SPI Controller can assert/de-
>> assert
>>>>>>> + *	more than one chip select at once.
>>>>>>>       * @setup: updates the device mode and clocking records used by a
>>>>>>>       *	device's SPI controller; protocol code may call this.  This
>>>>>>>       *	must fail if an unrecognized or unsupported mode is
>> requested.
>>>>>>> @@ -567,6 +592,11 @@ struct spi_controller {
>>>>>>>      #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx
>>>> */
>>>>>>>      #define SPI_CONTROLLER_GPIO_SS		BIT(5)	/* GPIO CS
>>>> must
>>>>>> select slave */
>>>>>>>      #define SPI_CONTROLLER_SUSPENDED	BIT(6)	/* Currently
>>>>>> suspended */
>>>>>>> +	/*
>>>>>>> +	 * The spi-controller has multi chip select capability and can
>>>>>>> +	 * assert/de-assert more than one chip select at once.
>>>>>>> +	 */
>>>>>>> +#define SPI_CONTROLLER_MULTI_CS		BIT(7)
>>>>>>>
>>>>>>>      	/* Flag indicating if the allocation of this struct is devres-
>> managed */
>>>>>>>      	bool			devm_allocated;
>>>>>>> @@ -677,7 +707,8 @@ struct spi_controller {
>>>>>>>      	bool				rt;
>>>>>>>      	bool				auto_runtime_pm;
>>>>>>>      	bool				cur_msg_mapped;
>>>>>>> -	char				last_cs;
>>>>>>> +	char				last_cs[SPI_CS_CNT_MAX];
>>>>>>> +	char				last_cs_index_mask;
>>>>>>>      	bool				last_cs_mode_high;
>>>>>>>      	bool                            fallback;
>>>>>>>      	struct completion               xfer_completion;
