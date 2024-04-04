Return-Path: <linux-kernel+bounces-132217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FC589918D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68821285E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D8D134434;
	Thu,  4 Apr 2024 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="P4xoFD9+"
Received: from mail-108-mta94.mxroute.com (mail-108-mta94.mxroute.com [136.175.108.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A9771B40
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270660; cv=none; b=qM/xEmtKr65FRlUmSyX8bCH1tBrWLRko2BbgPpohDUooW9UmqMz9jaukQ48l/JSbGcS0aSNmBK5qLlaqIHndBthyIlUTpX4RHyIMpOCgl7l7NZV44M67b/F6oQBxT3yWmNMfEPh15h873QNnnGpgxJVD1437n85E3jzHbg0NPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270660; c=relaxed/simple;
	bh=4F48DbPAZTaQbmsS4zILjS/2SL+3NYNZv4tNShQAY9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdVRJ3ONXJWrXIke+vuUa2OzR1o5hIm5RKU2M0KpnK1CFmUwJIB9AeP4DAnZXr/0XW74PaVmTu+0vU7ZR7RVUeF270a9d0hERSiPwB1z8qC7S1J4Shepmfd4owUEodT2BIs1+sg8QZoFhQkf1jofYZVvNLFja/BAu/np61x2SmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=P4xoFD9+; arc=none smtp.client-ip=136.175.108.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta94.mxroute.com (ZoneMTA) with ESMTPSA id 18eab48ac4f0003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 04 Apr 2024 22:44:10 +0000
X-Zone-Loop: ba66edb1c7ed08b8ae65edd57a84d113778c80eebd21
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pKWa1rLBYgiYR8KNxTp6qkp4Py0+RJpW5btHSLGQ1SE=; b=P4xoFD9+PO2Kx4t9TlLMeOLHxU
	IUbGD7YtGzwoG7vXLHevCPuReRiRKx8Xfn27PklTzl1Xh20ncdtPPL6ulqRbEtXrEDq0e37fEnBHf
	t7KsBij2b2dpCr5Nd9+zkehEMr9QRu3M0WUnpTQ5uVxOM7dVfemQM2BsnZU2eTfONsTOPRejpdMKE
	Ja1FwyQnR6jmCFXJcQwNSe27eV3oVbF7s1yllaOkYOVTW3cZ0QYnPfx4rexysg969BKsEnZtL8RlZ
	0d5+ga5g4E7RlK0l7yHJUqtIvWCaHf8tm/CQ1wPK5iew1gsu51PEXwMDPJz7VTEHs+EHlHtXTxWDD
	jqf2VwGA==;
Message-ID: <998efafa-699b-4226-91d4-2ebba85d63ec@luigi311.com>
Date: Thu, 4 Apr 2024 16:44:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/25] media: i2c: imx258: Change register settings for
 variants of the sensor
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pavel@ucw.cz, phone-devel@vger.kernel.org
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-20-git@luigi311.com>
 <Zg2BZXQpzsm7jMnc@kekkonen.localdomain>
Content-Language: en-US
From: Luigi311 <git@luigi311.com>
In-Reply-To: <Zg2BZXQpzsm7jMnc@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: git@luigi311.com

On 4/3/24 10:18, Sakari Ailus wrote:
> Hi Luis, Dave,
> 
> On Wed, Apr 03, 2024 at 09:03:48AM -0600, git@luigi311.com wrote:
>> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>
>> Sony have advised that there are variants of the IMX258 sensor which
>> require slightly different register configuration to the mainline
>> imx258 driver defaults.
>>
>> There is no available run-time detection for the variant, so add
>> configuration via the DT compatible string.
>>
>> The Vision Components imx258 module supports PDAF, so add the
>> register differences for that variant
>>
>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>> Signed-off-by: Luis Garcia <git@luigi311.com>
>> ---
>>  drivers/media/i2c/imx258.c | 48 ++++++++++++++++++++++++++++++++++----
>>  1 file changed, 44 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>> index 775d957c9b87..fa48da212037 100644
>> --- a/drivers/media/i2c/imx258.c
>> +++ b/drivers/media/i2c/imx258.c
>> @@ -6,6 +6,7 @@
>>  #include <linux/delay.h>
>>  #include <linux/i2c.h>
>>  #include <linux/module.h>
>> +#include <linux/of_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/regulator/consumer.h>
>>  #include <media/v4l2-ctrls.h>
>> @@ -321,8 +322,6 @@ static const struct imx258_reg mipi_642mbps_24mhz_4l[] = {
>>  
>>  static const struct imx258_reg mode_common_regs[] = {
>>  	{ 0x3051, 0x00 },
>> -	{ 0x3052, 0x00 },
>> -	{ 0x4E21, 0x14 },
>>  	{ 0x6B11, 0xCF },
>>  	{ 0x7FF0, 0x08 },
>>  	{ 0x7FF1, 0x0F },
>> @@ -345,7 +344,6 @@ static const struct imx258_reg mode_common_regs[] = {
>>  	{ 0x7FA8, 0x03 },
>>  	{ 0x7FA9, 0xFE },
>>  	{ 0x7B24, 0x81 },
>> -	{ 0x7B25, 0x00 },
>>  	{ 0x6564, 0x07 },
>>  	{ 0x6B0D, 0x41 },
>>  	{ 0x653D, 0x04 },
>> @@ -460,6 +458,33 @@ static const struct imx258_reg mode_1048_780_regs[] = {
>>  	{ 0x034F, 0x0C },
>>  };
>>  
>> +struct imx258_variant_cfg {
>> +	const struct imx258_reg *regs;
>> +	unsigned int num_regs;
>> +};
>> +
>> +static const struct imx258_reg imx258_cfg_regs[] = {
>> +	{ 0x3052, 0x00 },
>> +	{ 0x4E21, 0x14 },
>> +	{ 0x7B25, 0x00 },
>> +};
>> +
>> +static const struct imx258_variant_cfg imx258_cfg = {
>> +	.regs = imx258_cfg_regs,
>> +	.num_regs = ARRAY_SIZE(imx258_cfg_regs),
>> +};
>> +
>> +static const struct imx258_reg imx258_pdaf_cfg_regs[] = {
>> +	{ 0x3052, 0x01 },
>> +	{ 0x4E21, 0x10 },
>> +	{ 0x7B25, 0x01 },
>> +};
>> +
>> +static const struct imx258_variant_cfg imx258_pdaf_cfg = {
>> +	.regs = imx258_pdaf_cfg_regs,
>> +	.num_regs = ARRAY_SIZE(imx258_pdaf_cfg_regs),
>> +};
>> +
>>  static const char * const imx258_test_pattern_menu[] = {
>>  	"Disabled",
>>  	"Solid Colour",
>> @@ -637,6 +662,8 @@ struct imx258 {
>>  	struct v4l2_subdev sd;
>>  	struct media_pad pad;
>>  
>> +	const struct imx258_variant_cfg *variant_cfg;
>> +
>>  	struct v4l2_ctrl_handler ctrl_handler;
>>  	/* V4L2 Controls */
>>  	struct v4l2_ctrl *link_freq;
>> @@ -1104,6 +1131,14 @@ static int imx258_start_streaming(struct imx258 *imx258)
>>  		return ret;
>>  	}
>>  
>> +	ret = imx258_write_regs(imx258, imx258->variant_cfg->regs,
>> +				imx258->variant_cfg->num_regs);
>> +	if (ret) {
>> +		dev_err(&client->dev, "%s failed to set variant config\n",
>> +			__func__);
>> +		return ret;
>> +	}
>> +
>>  	ret = imx258_write_reg(imx258, IMX258_CLK_BLANK_STOP,
>>  			       IMX258_REG_VALUE_08BIT,
>>  			       imx258->csi2_flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK ?
>> @@ -1492,6 +1527,10 @@ static int imx258_probe(struct i2c_client *client)
>>  
>>  	imx258->csi2_flags = ep.bus.mipi_csi2.flags;
>>  
>> +	imx258->variant_cfg = of_device_get_match_data(&client->dev);
> 
> You'll also need to keep this working for ACPI based systems. I.e. in
> practice remove "of_" prefix here and add the non-PDAF variant data to the
> relevant ACPI ID list.
> 

Removing of_ is easy enough and looking at all the other commits that make
this change in other drivers I dont see anything else being done besides
adding in the .data section that is down below for both imx258 and pdaf
versions. Is that what you are referencing or is there some other place
to add variant data to ACPI ID list?

>> +	if (!imx258->variant_cfg)
>> +		imx258->variant_cfg = &imx258_cfg;
>> +
>>  	/* Initialize subdev */
>>  	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
>>  
>> @@ -1579,7 +1618,8 @@ MODULE_DEVICE_TABLE(acpi, imx258_acpi_ids);
>>  #endif
>>  
>>  static const struct of_device_id imx258_dt_ids[] = {
>> -	{ .compatible = "sony,imx258" },
>> +	{ .compatible = "sony,imx258", .data = &imx258_cfg },
>> +	{ .compatible = "sony,imx258-pdaf", .data = &imx258_pdaf_cfg },
>>  	{ /* sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(of, imx258_dt_ids);
> 


