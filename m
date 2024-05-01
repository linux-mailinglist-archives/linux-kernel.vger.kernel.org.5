Return-Path: <linux-kernel+bounces-164872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C1C8B8449
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458C61C22653
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA1B134DE;
	Wed,  1 May 2024 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cNzzk3vw"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2093.outbound.protection.outlook.com [40.92.41.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9110940;
	Wed,  1 May 2024 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529948; cv=fail; b=QmzENAhRoROV/QXhizI2+cxeTYQ16Nedxs5YlNTg5D5xMBx+yqyFu+ZpaRTvcmFb+rTG1c9cKS+7T/JFGsv42vkp+dF1nS8XicVF4wHx8OZ5iI/Lp28GN8GbAuc2hBQDx7tN0FZl/ToUTrBEy82YbGHZhXcxiMISjr6uV2Am0Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529948; c=relaxed/simple;
	bh=Leq8Go+WFaBZGNFSBHA3se7qcLEyT09uI2L37zHNQC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oiGTQ9VUSD2KGsqv7qq4/Eys5HwAyqgFFlt4GUt38tk8DftTl3Np8Xaq+yehzyMg23oemFP5v8XiOyLWDFnDiAYkDXVtzZXebqaahF2E2ZiiIG/v5rHz/ni/ZGLiPrj23wWL4PJEs7gquaUe/NgR27L2yLr5d60IJ6JgT/dGQ/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cNzzk3vw; arc=fail smtp.client-ip=40.92.41.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq65yyTKRA898wYRXaVd9V2/QkUb6mZKxD/gbbllMz6T1NDgCVECnplzjGXGg5n5Sfat4k4GKotj02I6Nl2duJhFl6Ahrcbzz2uepLbsY9MNORQS4F7eG8XBo2CjJfsaI9vHd03zPqaoGOpPJvkXQ8iAfhg63j/JFdBFvk49RhJMtaZ2Zt0brIClFS2JjxjOBtYcj2zc0/hcfnX4QFoXpNZP6Ik+AnmrqdeonmdV3T59JSKO0SCrvSxlhBPOmTYIQ5K3vsTbX6FODHNVBHbjew6aBN/rnbJ7FoejNz/V+I2PeeWfmyUqgecM6ETwtCYorTfPJFlGe2dqpes2Jfz4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+k2S1DFdm/rDoskPhCW5gv9sjoGUaRQMsSM4qb+g1w=;
 b=kFMCmEekaOOXfDD6wrTt3rjRWVxZblwmnGPcrFj8iCByacaTcCiL6BwmDLoTIMyVGJ8bNTV50GT+jqyxiv6ER54xM4YGy4bRvo2GcT1wo7TsYYz2X6dO1xo2n1/gduRfSyrYwrPOTbHzIzJRZRyRJQMJNCeUqwZFgu7AQO+Tm/kQv9a38839OOSB3khUQWW5GsjBw01xRyMSjoKQaemnB+pFKQgzgptI5SgryC+c2pmcgLy9GI5dNuo72zY6oepytV7s3c8GSxm7HXP8Q3ieWpMucCg2Wm1iM4EgJjHKcSr675zZaHeymarcjjjJ9nYNLO11HCjwHhuRsGjLP/Na+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+k2S1DFdm/rDoskPhCW5gv9sjoGUaRQMsSM4qb+g1w=;
 b=cNzzk3vwQwR/P8siFqzBQXj29vqerhj5geYexMEvJGlvWK8GyRk36tuXPNSLEsIvDI99kVP7UwQ/lxMVsttoa/Yho7xDX2gY99kUKbrDVLBOOY2X+1Wq343+bTFDCEb0f/wqEqfQTXEJfZjJJNmirExzvJjN51zPuxlEDKg7FkaUy6QkidATtwavd6po/IZlO6hV9PTw/3hXsEo8gP1thDaqBwnlhPlIRy0NawgGviQ/JtOYz0VhHKlfFck/tBWi3VGPPYtPEjrdgPMVQreHlNxZWSKHHGHCc1q11z/JGMBxU66jLw1eNRCk4OqqkmXxUFM08ejJC/nwPvgmqu18Vg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB5319.namprd20.prod.outlook.com (2603:10b6:806:24e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 02:19:03 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 02:19:03 +0000
Date: Wed, 1 May 2024 10:19:34 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>, alexandre.belloni@bootlin.com, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org, inochiama@outlook.com
Subject: Re: [PATCH v8 2/2] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Message-ID:
 <IA1PR20MB49533772D594D18204E9F9EEBB192@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com>
 <20240204044143.415915-3-qiujingbao.dlmu@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204044143.415915-3-qiujingbao.dlmu@gmail.com>
X-TMN: [YGlz3yLVObwP+kPeI9IokNB7yzY8hP0NmFwKyeUa73c=]
X-ClientProxiedBy: PS1PR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:803:3d::27) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <ik33kna3y3ht3nm4elytjrcoovf3tea6vjsbh4llee424mkzcl@74m2gdz7xe7x>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b95a59c-69c4-4620-27aa-08dc69851205
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	LNEEjfMyA07dwW4TVH0qO8H7MEu5M6wR4X6t9+RSqFquubgEloTSNPW7/wQ1JC+QkVjjXmcgwIixG3qHeTyAxHhqUKahtqkWrtjoWqAyvdLP2rkUC2gCJTKU5DHDpHgQvQLuD+/oGZDGFUBdtH4HUZA9RasuWTKErkHQ+hRUhU6VUjMEDallvmFSk5cW95szwXxR1KUokDqZph/TUlAWR0OI16HCVMJey55MhxYwdj0BNx37Dxaosja87besnaRyR3pXRBKAgMMMbL6YQb9chYDPrpyOYOB0REFdXEg1RwnvFZdY5OjAS1n9bal9nTWxMznhKGfMr0uZ2fET3WLnd5dDrlDgh5Bp6HeaD061vCCrauZXbpsiiMCNARf8cdTr5keHGobkZWTa9Uu+IGcYsFmcKVqJPUPs62N/FeI3SkO9eRnwgk6l9fgDeP7bPdiR9GDbJzucsK5bx1pGHiqcytG64i6mc7Sem6IwYJnfrPDbc97B+ZliC4jLsRmllLDJ1nclf0lM+y0YNff/xU5p92nXfqOcAqPOeRB+HbVmlL9U/mE/TQG4s9rO6IQBigdUXofVKhnGn04YRGupctggm6vn/+98S5c+eSWWKilewtEppbFsfUvnh1ecNsLq1bK4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JcUFuC9GImyeNjgaW6IYcf6nIR7xWhjh7CB4uWUGYqKju68MMxAEwjlho12X?=
 =?us-ascii?Q?fzOdr7Xa8hagFADI09rVkZjNH49V+n4EnUquedangrBP9VqDw0JxPxvKVga1?=
 =?us-ascii?Q?MPhvwWK6wLaWwVLC2Syh517jLmfuljc2Qoh37GKFUZ1778tW+IAD1jnEedtZ?=
 =?us-ascii?Q?7nkBZkmb6gI+x19x3WQ0QT7TpWnzWAmuLDxXF9N1MDu8qYkWDG5WI8Ombowl?=
 =?us-ascii?Q?09yDHBNlC9dL3z+3yCcAsNrofowchC0SoNdbHOUu03EBRdCcMdmwSiTAv2+6?=
 =?us-ascii?Q?4FIkWYBsyrE+BIT2NIAbcJOXeWrXgHU3etXeh36yybXjGRIJzua80++zoGS5?=
 =?us-ascii?Q?0WieMzCmDml7z+65UjWY/uCJEummZsnNNU8zKFTYmpVCEkBSoZZuw/Msd8rE?=
 =?us-ascii?Q?3l3jpACCJG2gDnZL4Nt50bwLnxKhT+AX1TA+buipmN8gSsx0X9zesbhjF5fQ?=
 =?us-ascii?Q?46fLIzWRx8EzC4iX+A9AO6k2MRrSGgQc0jvxb/AJEVm9fAsNMCF1qTKKUPwn?=
 =?us-ascii?Q?7pWm51EVusgxdpSfOJ79tUbX3TiJovk1ZQR5FNiGdQLTcwtngmAu/dU3BbqK?=
 =?us-ascii?Q?48sHPmYAvuepIjt81yrkgYb2kUlSyoudZ7LR82LSRGztOzR1j6BpRfDR14Tc?=
 =?us-ascii?Q?3w0RVb9yx1gx6Odxe6b7xcRL+RFJIRnp/KgPy0UaSRf9jQxq08MT2lVvR+xX?=
 =?us-ascii?Q?ZLhuh+u3CzB7trLIFbv+xw1zkUoXsw6aUkc+lJS1lfsJwtlRdM5XT+zNAMtQ?=
 =?us-ascii?Q?pyL8PQr0b+PJocM/FK5PdP2tNaKkITujkMMrw5wSCgC57MjL952msO/Ay209?=
 =?us-ascii?Q?81A1Mr02UkQLPhRB3rV8fO05HuHAv4EjinCbxlt+HG9SwvURNlLj9c8lyM/j?=
 =?us-ascii?Q?371aN3vKsyLlx6+lsrgjR/hJQbU/HYVsgk3Rm3omHav11cDNEXMaRyCgJFIr?=
 =?us-ascii?Q?9JJLS8L0f4cBdhilgfQqwfEYLbc+R0l4KHDb8vWu3eDlA15laqcGui9tke6b?=
 =?us-ascii?Q?i7kCDtJ2FcxaD26H+knJueZAf7jlZ5y5ipp7yFgUaSbNmA86hDkMZja70PFJ?=
 =?us-ascii?Q?m90hVFvV+qHTdyhXp+7pjSLuV3+AMvb3D8hKTzvMpXonROAjolQb44kw6BJR?=
 =?us-ascii?Q?pYYAjgL9AGMNzwICpdd5MEz3Rij/tLQQ2MMgVZN1b98ZSMjhDLh92QbrGRha?=
 =?us-ascii?Q?OA73eiZCL5/DFETPsV7XmpmUXJtrutoUZ4OlnMrYDDh8lHRVOOmmR+hf8l2/?=
 =?us-ascii?Q?bf574rhMGVFUP7Pn73nx?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b95a59c-69c4-4620-27aa-08dc69851205
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 02:19:03.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5319

On Sun, Feb 04, 2024 at 12:41:43PM GMT, Jingbao Qiu wrote:
> Implement the RTC driver for CV1800, which able to provide time alarm.
> 
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
>  drivers/rtc/Kconfig      |  10 ++
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-cv1800.c | 244 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 255 insertions(+)
>  create mode 100644 drivers/rtc/rtc-cv1800.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index e37a4341f442..3c6ed45a3b03 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1128,6 +1128,16 @@ config RTC_DRV_DS2404
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-ds2404.
>  
> +config RTC_DRV_CV1800
> +	tristate "Sophgo CV1800 RTC"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  If you say yes here you get support the RTC driver
> +	  for Sophgo CV1800 chip.
> +
> +	  This driver can also be built as a module.If so, the
> +	  module will be called rtc-cv1800.
> +
>  config RTC_DRV_DA9052
>  	tristate "Dialog DA9052/DA9053 RTC"
>  	depends on PMIC_DA9052
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 6efff381c484..4efdd2d1e963 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_RTC_DRV_CADENCE)	+= rtc-cadence.o
>  obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
>  obj-$(CONFIG_RTC_DRV_CPCAP)	+= rtc-cpcap.o
>  obj-$(CONFIG_RTC_DRV_CROS_EC)	+= rtc-cros-ec.o
> +obj-$(CONFIG_RTC_DRV_CV1800)	+= rtc-cv1800.o
>  obj-$(CONFIG_RTC_DRV_DA9052)	+= rtc-da9052.o
>  obj-$(CONFIG_RTC_DRV_DA9055)	+= rtc-da9055.o
>  obj-$(CONFIG_RTC_DRV_DA9063)	+= rtc-da9063.o
> diff --git a/drivers/rtc/rtc-cv1800.c b/drivers/rtc/rtc-cv1800.c
> new file mode 100644
> index 000000000000..60a7192659f5
> --- /dev/null
> +++ b/drivers/rtc/rtc-cv1800.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * rtc-cv1800.c: RTC driver for Sophgo cv1800 RTC
> + *
> + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/rtc.h>
> +
> +#define CTRL                   0x08
> +#define ANA_CALIB              0x1000
> +#define SEC_PULSE_GEN          0x1004
> +#define ALARM_TIME             0x1008
> +#define ALARM_ENABLE           0x100C
> +#define SET_SEC_CNTR_VAL       0x1010
> +#define SET_SEC_CNTR_TRIG      0x1014
> +#define SEC_CNTR_VAL           0x1018
> +#define APB_RDATA_SEL          0x103C
> +#define POR_DB_MAGIC_KEY       0x1068
> +#define EN_PWR_WAKEUP          0x10BC
> +
> +/*
> + * When in VDDBKUP domain, this MACRO register
> + * does not power down
> + */
> +#define MACRO_DA_CLEAR_ALL     0x1480
> +#define MACRO_DA_SOC_READY     0x148C
> +#define MACRO_RO_T             0x14A8
> +#define MACRO_RG_SET_T         0x1498
> +
> +#define CTRL_MODE_MASK         BIT(10)
> +#define CTRL_MODE_OSC32K       0x00UL
> +#define CTRL_MODE_XTAL32K      BIT(0)
> +#define REG_ENABLE_FUN         BIT(0)
> +#define REG_DISABLE_FUN        0x00UL
> +#define ALARM_ENABLE_MASK      BIT(0)
> +#define SET_SEC_CNTR_VAL_INIT  (BIT(28) || BIT(29))
> +#define SEC_PULSE_SEL_INNER    BIT(31)
> +#define SEC_PULSE_GEN_SEL_MASK GENMASK(30, 0)
> +#define CALIB_SEL_FTUNE_MASK   GENMASK(30, 0)
> +#define CALIB_SEL_FTUNE_INNER  0x00UL
> +
> +struct cv1800_rtc_priv {
> +	struct rtc_device *rtc_dev;
> +	struct regmap *rtc_map;
> +	struct clk *clk;
> +	int irq;
> +};
> +
> +static const struct regmap_config cv1800_rtc_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int cv1800_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
> +{
> +	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> +
> +	regmap_write(info->rtc_map, ALARM_ENABLE, enabled);
> +
> +	return 0;
> +}
> +
> +static int cv1800_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> +	unsigned long alarm_time;
> +
> +	alarm_time = rtc_tm_to_time64(&alrm->time);
> +
> +	cv1800_rtc_alarm_irq_enable(dev, REG_DISABLE_FUN);
> +
> +	regmap_write(info->rtc_map, ALARM_TIME, alarm_time);
> +
> +	cv1800_rtc_alarm_irq_enable(dev, alrm->enabled);
> +
> +	return 0;
> +}
> +
> +static int cv1800_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
> +{
> +	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> +	u32 enabled;
> +	u32 time;
> +
> +	regmap_read(info->rtc_map, ALARM_ENABLE, &enabled);
> +
> +	alarm->enabled = enabled & ALARM_ENABLE_MASK;
> +
> +	regmap_read(info->rtc_map, ALARM_TIME, &time);
> +
> +	rtc_time64_to_tm(time, &alarm->time);
> +
> +	return 0;
> +}
> +
> +static void rtc_enable_sec_counter(struct cv1800_rtc_priv *info)
> +{
> +	u32 sec_ro_t;
> +	u32 sec;
> +
> +	/* select inner sec pulse */
> +	regmap_update_bits(info->rtc_map, SEC_PULSE_GEN,
> +			   (u32)(~SEC_PULSE_GEN_SEL_MASK),
> +			   (u32)(~SEC_PULSE_SEL_INNER));
> +
> +	regmap_update_bits(info->rtc_map, ANA_CALIB,
> +			   (u32)(~CALIB_SEL_FTUNE_MASK),
> +			   CALIB_SEL_FTUNE_INNER);
> +
> +	sec = SET_SEC_CNTR_VAL_INIT;
> +
> +	/* load from MACRO register */
> +	regmap_read(info->rtc_map, MACRO_RO_T, &sec_ro_t);
> +	if (sec_ro_t > (SET_SEC_CNTR_VAL_INIT))
> +		sec = sec_ro_t;
> +
> +	regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
> +	regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
> +}
> +
> +static int cv1800_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> +	u32 sec;
> +
> +	regmap_read(info->rtc_map, SEC_CNTR_VAL, &sec);
> +
> +	rtc_time64_to_tm(sec, tm);
> +
> +	return 0;
> +}
> +
> +static int cv1800_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> +	unsigned long sec;
> +
> +	sec = rtc_tm_to_time64(tm);
> +
> +	regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
> +	regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
> +
> +	regmap_write(info->rtc_map, MACRO_RG_SET_T, sec);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t cv1800_rtc_irq_handler(int irq, void *dev_id)
> +{
> +	struct rtc_device *rtc = dev_id;
> +
> +	rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct rtc_class_ops cv1800_rtc_ops = {
> +	.read_time = cv1800_rtc_read_time,
> +	.set_time = cv1800_rtc_set_time,
> +	.read_alarm = cv1800_rtc_read_alarm,
> +	.set_alarm = cv1800_rtc_set_alarm,
> +	.alarm_irq_enable = cv1800_rtc_alarm_irq_enable,
> +};
> +
> +static int cv1800_rtc_probe(struct platform_device *pdev)
> +{
> +	struct cv1800_rtc_priv *rtc;
> +	u32 ctrl_val;
> +	void __iomem *base;
> +	int ret;
> +
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	rtc->rtc_map = devm_regmap_init_mmio(&pdev->dev, base,
> +					     &cv1800_rtc_regmap_config);
> +	if (IS_ERR(rtc->rtc_map))
> +		return PTR_ERR(rtc->rtc_map);
> +
> +	rtc->irq = platform_get_irq(pdev, 0);
> +	if (rtc->irq < 0)
> +		return rtc->irq;
> +
> +	ret = devm_request_irq(&pdev->dev, rtc->irq, cv1800_rtc_irq_handler,
> +			       IRQF_TRIGGER_HIGH, "alarm", &pdev->dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot register interrupt handler\n");
> +
> +	rtc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(rtc->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->clk),
> +				     "clk not found\n");
> +
> +	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(rtc->rtc_dev))
> +		return PTR_ERR(rtc->rtc_dev);
> +
> +	platform_set_drvdata(pdev, rtc);
> +
> +	rtc->rtc_dev->ops = &cv1800_rtc_ops;
> +	rtc->rtc_dev->range_max = U32_MAX;
> +

> +	regmap_read(rtc->rtc_map, CTRL, &ctrl_val);
> +	ctrl_val &= CTRL_MODE_MASK;
> +
> +	if (ctrl_val == CTRL_MODE_OSC32K)
> +		rtc_enable_sec_counter(rtc);
> +

use (ctrl_val & CTRL_MODE_OSC32K).

Another thing is that I do not think is a good way to let the
rtc driver access RTC_CTRL area directly. You have already
know there is a 8051 device in the 0x05025000. It is necessary
to make some room for this device. Maybe you want to implement
them all in the rtc driver? If so, I do think it is a bad idea.

> +	return devm_rtc_register_device(rtc->rtc_dev);
> +}
> +
> +static const struct of_device_id cv1800_dt_ids[] = {
> +	{ .compatible = "sophgo,cv1800-rtc" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, cv1800_dt_ids);
> +
> +static struct platform_driver cv1800_rtc_driver = {
> +	.driver = {
> +		.name = "sophgo-cv1800-rtc",
> +		.of_match_table = cv1800_dt_ids,
> +	},
> +	.probe = cv1800_rtc_probe,
> +};
> +
> +module_platform_driver(cv1800_rtc_driver);
> +MODULE_AUTHOR("Jingbao Qiu");
> +MODULE_DESCRIPTION("Sophgo cv1800 RTC Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

