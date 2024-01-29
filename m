Return-Path: <linux-kernel+bounces-42139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E2A83FCF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2BE61F2100E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1A810A0D;
	Mon, 29 Jan 2024 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cPWriCex"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2055.outbound.protection.outlook.com [40.92.15.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146E11733;
	Mon, 29 Jan 2024 03:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706500071; cv=fail; b=f5t4iML74f6qydd7Hh4EsAIXULQLyC+GHM0ZwOm46RFpz9PCQx8OtImrcEHTErKHZP8v8UtXfUODIFjHxYpfQMZ8h/fpyhA1DyQevQLyDLQ1Z2g/AFafKMIsdYX9mfLacZ795RZArwnpQbdwNel5QvJRMnZ80jjtaxgHIPJALtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706500071; c=relaxed/simple;
	bh=V4cx8ByUF7mVl+gmXOdq3ppMX3M3RhKP8PfurC2Tqek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SYyC8cG55ZByiYzxo0skVCJnh5FY8E1qxUPdzVCNkgCXMkVcgWiYNtSwGhrSZsdi4CN8JH5fs/R0LxM+b8VGqF7OWrm2ulf7r9gOPVQ/SEqw8LOOpW1fUTkjkKGRhxkUgTO6QeqzcQOTp3rdcbQp0tFXTTqSnxmxDq91RrpfjDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cPWriCex; arc=fail smtp.client-ip=40.92.15.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1SbFo0Y73M+haK1y9s1vOwHQ5Xe2bMwsleiVjQjL17EaTDQizhHN349BvcpdALWYDgdvQxcbewHGaOW9wXFwhJfz0YntjheCOcifpbwHbgoiKoHnZPh1BcbUwtbzVK/ljXLzhoxloZlTOsVVG6owWeGlRsc9XiCx3WHTn2awbabPX170JJiJn393lwxkuleAfmpeUlvogud7D+scIBy+eZ7dRwmIbbDnluGIjuL+sicT0ECWrwPh7EYNW5kHw3HmTkOE8tTuedXSiVmVJn6KOsy/UddXwUMRLNGe/R69s/hEwGWmqRwHre6kqojhbFWF1kQmbHreMYdPpyhzPUymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEGp9XcjIJbY02mZ78n/ICpQXtQa76336IMc/d55imk=;
 b=TEh84JqEn6vUNW9hoT9WMrr5/b2qTf1OIzOT8ZgZ3Asu9z3iSjBnAdOnd+vxg4V47xDs4boL/88Vp1aWEUtrzOe0fxq4J0+bfVJAPw7S/3tB8siYxy6OtIhc+4Jsy/GCPfNmcs/vtmb9EBUkJq1Z7AeOwl+BRIaBTPwrerwjW3w1rdU1bFeuHoehZjPCTcbNoGp+hfMk4VSr3QvWqcgs3RC5IscN2n8JHjwOugK50s+z6tJMEaCcpNvQJYoDM3XRrSrvfsKF15jcfc7cOsLBOL6CU2+CrWpkoWnKEOZrrBf9ERW54nYRksBJKoia2nBqTY51dBMXrdmIwGWa5+wXCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEGp9XcjIJbY02mZ78n/ICpQXtQa76336IMc/d55imk=;
 b=cPWriCexR+RDrcx+nFIJLHTQA24HO20UafLAoRVELq10v8iqOfc8BHuIL5CvhI+vk+4CFPZpnfAJvMxxQVcGYd/8oCvKlYKNm54W2hIXQfjZByP5MuxU0+b2plw4mQClbVV1Zxm+g6VvoKenD9oRhCBYSJcmBLG2hlobh7npGr/ZnUGo9DYDBf2kf8V5Ubdt02Lh7WS7+JOOSiVAcWT1rw1PeEv5t7ZbWg84xbR9/LMMdGBGdjiQ7m8PdC0Fxt1FBvF1hb8mylgTY9v7Aydw6ZtXCiiX2XzTGOzABVrZpK35N/US9ksBVbvg6KEbWLYy8HBeziGDd9WsQxTaH4L65A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA3PR20MB5935.namprd20.prod.outlook.com (2603:10b6:806:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 03:47:47 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::406a:664b:b8bc:1e6b%2]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 03:47:46 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Yixun Lan <dlan@gentoo.org>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: dts: sophgo: cv18xx: Add spi devices
Date: Mon, 29 Jan 2024 11:47:18 +0800
Message-ID:
 <IA1PR20MB49532962D49F119F355EC55ABB7E2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129030115.GB1097489@ofsar>
References: <20240129030115.GB1097489@ofsar>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [PRJ7Ta8LhVgYjwnJCc6XaaQL4J2CntZRLvH+Zsa6DTygPIve5hvbFak9oQ5ZpYOd]
X-ClientProxiedBy: TYAPR01CA0145.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240129034719.15928-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA3PR20MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7a0efb-cb81-46f4-f88c-08dc207d0e25
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT8PLw9LS0xFHvWB+TzQT4pmIItFBh9s9AsQlNNhyFYFAJZ15D2og5CSYerTiIOhAUGkY3CPcIrk2QwXgyQaC8cacnRT6jV/ltuJWECO1MOSLVoxH03hh913itZttpUa5urA1A2ipoOzTQ8qn9U4rya6tkzQh5xVeguL+3Mi2LEYDNsuf3HHKLZGQ+VzP3PXWdRkXQw8DWhAySG/yOOGAfnzaolAj2qfCqf6efYQWtR3U66kGCTx4ltMl5TJJOW1GcVCOYfNWsQpScCn1GToefgz4RxjUdts/3zcEtQRcYss5KLVHN3LyuLbvx4frZj60vTY4XCmZqIl8JB+J49FYq3enySgTmKQ5FUqouqTctbNl76BHHr8AgRY7sB0d6g29LWKGwkACL7DgFRc+wpWh7toFyqV/FpyGbM/rhBEjhIsyuFrNuHPpQLTaD6rrJA7RC91yaIRI7l008/LJVrEGCrVl6r4Yub9Y6nABIPw95WcMq6gsbr+dnL7DUR63G9sGbGD57LNKaW7QZAXSGi7+740cJx2VmH6Rhfo2Qd6QO8I6TvNgluhHldQmQgS7fCiMc93o2zvpe/IZmx79UVO91Lc+/CC/55fjuAB6FIPEDVBrsW87413Y94YeVC5bOrDIbwOdHHaM2RcSn9Teh4YWB3oXQqjTj1xg19Jg1Moi77b33D3PnWZ76YEEdGqdySIkMjbg0cFGnoyZRAZdZ37HpROtrusnTzOBnP6ogGP2g0Eotu2YPsD0lYWcToGMaGwyH2sC1l0XHhHVeLeaubjWFVb518ZHKil83smrvq+YLwikHYFVJtu5uzb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8WJ3jBXfTKtNNjktwTZI3qQWuoWOL5Oej5GWabShAMHRtEPNWuDDrOEhUtZ6+SI6l6Pk/2WWOLZWTgj4XmJUXV//dcft67lAFd9sZRe2T7x3Q5+yzJnV1+UL/M2xl6mp8AKM9ONVjGBq9s1YUox254/9H5JpPNzpFym+F0blOo/jFk9XpO0T9YMbeHYPPoUd8T6j4L2N5q7XA+TYSYHTOOZtNEYSsASxpvcngkJrJDp1cN9MrFWXGejxYQ8moLcbmfB4eLIza7X8thARt4gdTb9xrnEMrwG1WP50FS5DBlThkO/vz5wwfWvjl5nY/fc4KbZ7pH/QKiy5PRjFASwjjEQh5PyKnU+I37Sn7a21I7BnC+KkXaCuiaqJBnfAf5hDLzaYAOld4eaZPTlkjLP5DV9R0Xdf5dzr5/kYlq3ktB2Otw2umZla5+G/OMC3c8voBlDpioLG5VUZKd4HA7MOurxL5+O6YsPotZ2O6CcI01GqXlvQuI7wNz0LSOq3K31lPxxGVg4jIg6mcP586BC5VsZRBfZPIb+y0zFexSCJaomCH430iVNLZ63u8iKNdSKUmTLnTmypU3kOPdiAH2kAjAXw5za+7BBZptJaHsFKmIJeI+po/hfs58fUoeKWlD5Y
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NelfE6c3dOrgIz+8MBmlVmUh9SjIvfbpI1ge2CBXBLona9Izd0g7kCWO+W51?=
 =?us-ascii?Q?JvMKzmpgwJc66Pv3I0F8iySXadKudKivGV5BvEbu0JepEAwWLz6PQ+gj30nF?=
 =?us-ascii?Q?xhETn/wRlwF9iQLVSf3yJny13XVsLG3nSON4xJ7AtwZZwZACsXfMp7l4jkzw?=
 =?us-ascii?Q?miYB4GxBlGIPeoQPd9gal9obp8iHNDL4GQEUYxnMBIY/MiO7JIVJTKe12vgE?=
 =?us-ascii?Q?QSaxua2wErlesSYGzrqu+HIKGks1QgzVpVwTvKu/jWPgN2qY2CGVgsv20WuD?=
 =?us-ascii?Q?4tQryjPNg6ammNWfkFxBKG9kVcXhgSw+HrxhRfA9JKKL3FtuZO6PTshRHQkN?=
 =?us-ascii?Q?pP/LSzh1eC5XD57G26Jg8PHH+OAoKSWUaiDyol8B5BwmWhkC+c0rirm16q1v?=
 =?us-ascii?Q?lew4mwJ/wVLp2c+5RbCa5bYJZTfuQN9woeMb2weR8PWRmwiSlSjvuBLXZ+PG?=
 =?us-ascii?Q?sNTmp/uvdRNFasUvBQJ3mxmwwHKun5Zz3gN4Beb5MfEu5zuOmQyrY/NHXQ8V?=
 =?us-ascii?Q?jkpzcS7sVbPSKGUaXuWx6htEK+yg9sw650bsvVYICHsV8OaQj4sI9u4ckGPG?=
 =?us-ascii?Q?XSbbm3Cm7ApQXCtjoZL5ORFDEkDTwJImSkIE1Yhi+pCYnAD0uR/0hfiI4rto?=
 =?us-ascii?Q?Ox9evJWQNR6ea5yYjaH09VoxykeuQj4IO3k3ngA9LCK1FJG1fz/KSSQ81sRY?=
 =?us-ascii?Q?U+NUOShTYZgjC+gljk4j3FXrqGGx/yYT0HVuu3e8yZDqHhV6L5lPxKEwolRu?=
 =?us-ascii?Q?qeb6072zjJLgKHr5z8mVVwzO6elHiNd3ege0TCCeK3Sn/Z2PZF3Yg9abFbC+?=
 =?us-ascii?Q?IRDPpK52ICwY6jUS13VKMbZgazKr9ae2YWrEa+p5lEIVbe5WCvdmivqfjESI?=
 =?us-ascii?Q?CQmZSMerYphKwGNxjR2uQR4U37G9OfflYMqyWr/q8VkKAVBEIsbap7dZNdMf?=
 =?us-ascii?Q?h5eM+dUUBC/o8ccSY3tcm1h26IVPlIQZLUbzGbaA5pHvWwo8xeZmMWXkU6qt?=
 =?us-ascii?Q?qUKpsy2JR7MbqPV/hKx0SxFyx18RZomXzxD0ypVP/0cS4l0RqUYWbh9A5XE3?=
 =?us-ascii?Q?KfPEY5ZL2K8VK72HXaYrQgGtIxuT2FjGL05cw6eeVXqXSRCu3bT2SVzz1dGL?=
 =?us-ascii?Q?g8+O3cmGsBLbMvVVK8kMkdgx51lJuqVC2KacOmzQw/XqU25iBczk3iyVAj+o?=
 =?us-ascii?Q?S+XgwaWOA1SgXyTOoXz2BKrZuubzXHmjmm/1+Go2msTG6KYehH1fFLXWujP+?=
 =?us-ascii?Q?4q02rYMVvrO+eJEcMurZjl1X6AZijW1hYryueS0uuQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7a0efb-cb81-46f4-f88c-08dc207d0e25
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 03:47:46.1954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR20MB5935

>Hi Inochi Amaoto
>
>On 10:26 Mon 29 Jan     , Inochi Amaoto wrote:
>> Add spi devices for the CV180x, CV181x and SG200x soc.
>>
>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>> ---
>>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 44 ++++++++++++++++++++++++++
>>  1 file changed, 44 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>> index 7c88cbe8e91d..e66f9e9feb48 100644
>> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
>> @@ -176,6 +176,50 @@ uart3: serial@4170000 {
>>  			status = "disabled";
>>  		};
>>
>> +		spi0: spi@4180000 {
>> +			compatible = "snps,dw-apb-ssi";
>> +			reg = <0x04180000 0x10000>;
>> +			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI0>;
>> +			clock-names = "ssi_clk", "pclk";
>..
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>I'd suggest moving those two above 'interrupts' property
>
>there is an ongoing discussion here..
>https://lore.kernel.org/all/20231203174622.18402-1-krzysztof.kozlowski@linaro.org/
>

Thanks for this info. I will take care of it.

>> +			status = "disabled";
>> +		};
>> +
>> +		spi1: spi@4190000 {
>> +			compatible = "snps,dw-apb-ssi";
>> +			reg = <0x04190000 0x10000>;
>> +			interrupts = <55 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI1>;
>> +			clock-names = "ssi_clk", "pclk";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		spi2: spi@41a0000 {
>> +			compatible = "snps,dw-apb-ssi";
>> +			reg = <0x041a0000 0x10000>;
>> +			interrupts = <56 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI2>;
>> +			clock-names = "ssi_clk", "pclk";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>> +		spi3: spi@41b0000 {
>> +			compatible = "snps,dw-apb-ssi";
>> +			reg = <0x041b0000 0x10000>;
>> +			interrupts = <57 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clk CLK_SPI>, <&clk CLK_APB_SPI3>;
>> +			clock-names = "ssi_clk", "pclk";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			status = "disabled";
>> +		};
>> +
>>  		uart4: serial@41c0000 {
>>  			compatible = "snps,dw-apb-uart";
>>  			reg = <0x041c0000 0x100>;
>> --
>> 2.43.0
>
>--
>Yixun Lan (dlan)
>Gentoo Linux Developer
>GPG Key ID AABEFD55

