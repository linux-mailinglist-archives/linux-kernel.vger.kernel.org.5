Return-Path: <linux-kernel+bounces-63193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6D852C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6DD1F21B75
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243A22231C;
	Tue, 13 Feb 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="M+kQcdor"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2126.outbound.protection.outlook.com [40.107.247.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AEB22615;
	Tue, 13 Feb 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815960; cv=fail; b=l5QWMcZje73D8CgnhT7OBjjDMzwp4ptiMiA9FIoAhxY6menmQNmbtl/d9ihA7ecgAZfxG70CXGJ5hNcXgebSUE3zwk5G20JRTpvs/GQi4yBcAApS8CaQ5twK9HQgMOTng+PCHJMEPSQpe67O4rxTdEWlKPlRDTOGBRZXA3B3vMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815960; c=relaxed/simple;
	bh=CM9/ITO3sEOaNsOo4bfcfCoYcnUFPb4wpxwJ+FZYpNI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uKUcji5auBOfVVzKpcDMVO5Ptm4j1N7vUnewpWL4r6S4jPLzNG3tNWnrE2tkzHj0Yhr76cYRzNYNL258uVr051fhIBaV35qhYkI7oRvY92j72Cs8+IkACszH3WCCJvPlK1aZ4hNqqex3z92+WoB/tXFrrAetm+uonrm1t59CgzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=M+kQcdor; arc=fail smtp.client-ip=40.107.247.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQdybFMCpZe8A6bPGzw4ZylrVRr+N7i6it/kpUa3anZvZrGfVbxEvW8oVrDy1Xp9nh3x0B5zBqvcTvOfG3FSh8Ym1ox4q0x4lVngknPFLM9EPKxQicOrCesLmvuQa26gZ/6F53dJWxkWQI8+FGAYTovX0Xs+F6lIJUzv+N9HJOu4P44ejcSQB/PH0dFd5OyDvce94gE/9SNXcu6de54nkObQmjmB9zYjApR6iUQu+5rp/amZ7b6nkHD5gOOPxVHUuEJmvrWh4ndoxDchDuTuRccUY+Lz/qyNCc6OnQ2PekMjyFtAOkImEg5E2/UR+mSIm+zbBP3tZfVEQg7iDLmcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiDEzjExpjnYp6wsJckB6ehFVKQwfWnNLBQ7IthnPrc=;
 b=mD1FJQuRFOwdvsrOYssJbJR7ePQvyycNF+7MI4SvHPPHUeRIqbnIgcri9/NqsGMJ2GN+9DAlaHeHoEcGVlgiAjyW5Hvn4rQJC+F4F/+XYlJW5qkncmwLW8oHqof+wB+bOewZ9X4dm2P4UJ7wFI8x1pkDWE1tSD23FW+ls4R9IruiC//IQLjh/liw0GJAPg7I9sU6J7HOZGSGVHRkijnTxILwMYNW7GM6+G4evGK7edd2yxcy36IyXVIkRIoN4B4QaAg/edbfMJBsnFYybyiwCzMc89pivHXWEL6HGs2ly3qJ5iMpaO443U9wq6B9UFzXQcxD1O3Un20KSZddIa8UBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiDEzjExpjnYp6wsJckB6ehFVKQwfWnNLBQ7IthnPrc=;
 b=M+kQcdorAKO+0YgC+JAhSLa/gIBTgv4F+1PDKtrHQuZnlV0i+9uL+OWw5iZvtrQYhYto4n4Z/oe0Ms4bFI0VyKghF80z6klYu+ESoK86Y354hT5enDFWV6q1xI9nnw+nqLFvCe9vulbMg42kqDSXnGASo3nRi5VrCOeDmdeJQx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by DBBPR02MB10723.eurprd02.prod.outlook.com (2603:10a6:10:52f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 09:19:11 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::693e:dced:4695:274f]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::693e:dced:4695:274f%7]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 09:19:11 +0000
Message-ID: <1be60db1-f292-1074-5898-801380e1fb22@axentia.se>
Date: Tue, 13 Feb 2024 10:19:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5] arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in
 serdes_ln_ctrl
Content-Language: sv-SE
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 kristo@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, afd@ti.com, gregkh@linuxfoundation.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, c-vankar@ti.com, srk@ti.com
References: <20240213080348.248916-1-s-vadapalli@ti.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <20240213080348.248916-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::30) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|DBBPR02MB10723:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8541cc-571a-458c-6467-08dc2c74d6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4oRCcIzfplxy0OYtePZca/5wcmgbSwNbj9HZNptnHlv7dyRzhZ+ze/XHGPgA30gN1I9cxsi1FQ8MpcV+SqYO8ni984EyinIcTRvZGeKrBIKHG4twXxdrJbJEhIiaSG+ngNzCIsnD7bHfP8KioQ+5RFe8DjL/pBtY+2uOanLHLUSXdRFkZaN8myHk5khodNDf5MgfDp3PlsPMVUbdxLSCMWUhuad8BAj74lOqBR0hYlzBRf1CfB+JSEY43VxZUdlPMwjVsUNEe9VfuhFNARFlVjSyUVFU9jSfAgWZIdF6VNgVANTPAEmty7hNnhr1PUVmOET/YbjFO40V4ab3BXe0G+7gzxZuHA/BYButyBGSIu1Xq3im/8EP0ThYEKc5z+8u5XLsMOXNmD1harjG3pzLViCjVHsNKALU9+4o1jg7/h9e/ZbUce0PLqY7yxcA0nQ8CNuk+8xTrLIWV0gYdKL4mjgKGO9gfqK7zCMjZpDCoveTRBUpTOZgNaTwWYFnqH7PkCjAFANJfAxgoH0R/OxJRp7yR/eMVLAVJ9TPsNHpiZQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39840400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7416002)(41300700001)(2906002)(31686004)(8936002)(5660300002)(4326008)(8676002)(2616005)(36756003)(31696002)(86362001)(38100700002)(316002)(478600001)(6486002)(966005)(83380400001)(6512007)(6506007)(66476007)(66946007)(66556008)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REVmdUlQbUR2QzBwSVdCaWM1MGphaE9mTkZORVZWMlRKV3hITStMMUV4VmdJ?=
 =?utf-8?B?RXNQMVRsUG5uSnBhMEcyT0lxQkV2QVdsL2QrektzSWswSmhyKzFLUzZzTE5t?=
 =?utf-8?B?KzZMMEdOdDFqQk9OZDRDdjJDdWNReEtzNE5Pa3dORE54V3d2UGJ3T1Rmd1pl?=
 =?utf-8?B?eXNUUW5SaVpYMGwvd2VvUnB2Rm5Ob252cHF4elJySFQremVmdnRIQW94Vm1k?=
 =?utf-8?B?SlRLdTZ1a0VTUGc2b0VWWCtvOTVaQ1hpVm1NeEhGTWozbUN1QlY1WTRVMTI4?=
 =?utf-8?B?QS9sUGVTNkJEZG1RUUxVWWVlbHZxcG8wUHEyemRFcFpodjdySG93WnNHaU5y?=
 =?utf-8?B?dVNlRjl0UkhmOGdRSlBZNkpBbGp1RWZnQlg4S1dtZGxWb1RhazMxU3hEU2py?=
 =?utf-8?B?THIyeDZHM1l1cCtiQUU3ZmRrR1VqTk9LOHBPS1E3Z1k4V1ZnbG9WZENLVDBL?=
 =?utf-8?B?ZFJLdzduZ0RNWitTVGFldklYQjBVb2V5Yk52bEdNcUdrM0laSVRtQVFuc3BU?=
 =?utf-8?B?aXVyTnVSYXdDZjhaZ2RvSGY3UWI1b3JPLzI1T2Jrand2bW8yV3l2MU83Skdh?=
 =?utf-8?B?bVpaZU9oR1dZM0ExbEFtV3hSM0tzem45bUtib1FoRnFjZUdldTRHRFJrdE9U?=
 =?utf-8?B?bHYzbHFTZHBrdktyRTNzTjUzQWJDdHJuRkZsK0F3dytCVFRSdktWNVUyZDdk?=
 =?utf-8?B?Wld3cDBmKzR0Qi8valR2cEZaaEhpTnlNR3grKzhiNHBYTzdDelVyMUNqZFRv?=
 =?utf-8?B?eUVVeGFOM2RZZU1JZXVGYVlRZFhicXZDaXZIM2pFTmdBVG9hcjdRRDJnbFJt?=
 =?utf-8?B?TlZFcTJkemFkbUlBdzlFTXRHYkR6b0VUWUV1ODhOT0hGYVJqdkVSVzV6Q2NE?=
 =?utf-8?B?SzlvS2I3RzBUazRKR0Y5ZGp6alFFUUljbFJxdTRseTA3R1Q1M2FkM3VnVk5p?=
 =?utf-8?B?bUdKK05WNEdJRlRVZ1MzMTFlcDVnWGZ4U0pwb2RwRFRBcktwSVZUbnpXdHdw?=
 =?utf-8?B?azRrWEc3aVhXS1c2V2Q5SUdzVktENTJ4d0ZHeENWTFd5K3F3ampNNUgyb08x?=
 =?utf-8?B?U2h2MGN6QmpwTlkzRWhDR1ZFdUM2aFFoaWZJRnczRktFaHZ6RjF2M3FlWTZR?=
 =?utf-8?B?dkNHYlhXRmhhRE5Ybk1ydWNlQ1ZqeS9icUJ3elJMNEdzT2VnZDdRS1JOVGZy?=
 =?utf-8?B?MEpiM0FXMkZLU1F1MWE0VnA5R2RsWmlQSjlFNDhwU3Axb21vSjFsYXl5N3Rx?=
 =?utf-8?B?enpCUUdqT1VGYzZSeVozYnV2QS9XUmlKYTdYSTFVaVBtMFhUdEFIUnpJeUVq?=
 =?utf-8?B?SFZsVndiSDh6RXkvUERqRi9aSGpOS1dqa09SV2F4Z3JyaHlqNVZSTlZNWTVl?=
 =?utf-8?B?S2tveW9aTjFaNTNBYTVZeFB2dU02NzAwaGhreXdYeHZZbnFGdkN2R3krNTg1?=
 =?utf-8?B?MDlkNkFCaWRCNGpEclVWc1ZEZDRmdXlEMFB4UnRHZEQ4Y2t6R2txOTdjNHFa?=
 =?utf-8?B?alQ1TVNZdlNPT1J6aUdTcWxkNkZDekltSXRIMTQzOVREMUlUNWo5dGtsMVNX?=
 =?utf-8?B?Mmg0VURRWmx2S2theHY2blJvS05nRi9VUy9PNzZiWEN4d21maE1MLzFLKy94?=
 =?utf-8?B?N1g5bWprVlREYmZ4ZWxDY1B6bWg3U0srR0V2VFg5UE9hR1lvell0WXhSU2gv?=
 =?utf-8?B?SktBRlVTVmcreUFKVlMxRktFVjdlTHpiVkZTZzkvdEVtbVYyRVBGdGdPRXBu?=
 =?utf-8?B?bkxnNS82djU0cHNJdjMwcGhwMWo1RkRhU1lIMGEzTDBDY3RaN3hYMGlzRmp5?=
 =?utf-8?B?SmNLRUhmRjNoZ0duMzV4a3d0c0t6MWllSjVRNmNFdWRxeHNTM2p3elFEYjZK?=
 =?utf-8?B?VmF3cldqWldxT3NFejNlRXoyMHVRVENKdnlpbnYyYm9iNFdXSW1YNjB3Z293?=
 =?utf-8?B?clk3NTRidy9GZER3QnJlQ1F6aUJpcitiRkRadC9PZVRiekt2SUlDVWI0bElJ?=
 =?utf-8?B?eHRzc0dKMVlqdGxwb0REK1NqYW1aNEZpbFEveEJ3YkhvSUJlUkZ6TWROM3RU?=
 =?utf-8?B?VmxjVTRBNHE0aXZxVmJ5MUZ5S3RVOEVxZG44bHJzQ0oraGVjbjNYd2NJQUtj?=
 =?utf-8?Q?ljnd/r6FkoGmsJTDrSF//ngjL?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8541cc-571a-458c-6467-08dc2c74d6f9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 09:19:11.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VBSoLN+g4CTvBZJzUABk3hy0f5aVuGath229GnbEB0Y+Mh/vkjLs7H6udQoTz57q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10723

Hi!

2024-02-13 at 09:03, Siddharth Vadapalli wrote:
> From: Chintan Vankar <c-vankar@ti.com>
> 
> Change offset in mux-reg-masks property for serdes_ln_ctrl node
> since reg-mux property is used in compatible.
> 
> Fixes: 2765149273f4 ("mux: mmio: use reg property when parent device is not a syscon")
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> Acked-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Hello,
> 
> This patch is based on linux-next tagged next-20240213.
> The v4 of this patch is a part of the series at:
> https://lore.kernel.org/r/20240131101441.1362409-1-c-vankar@ti.com/
> 
> Since the v4 series mentioned above has open comments on the other
> patches in the series, this patch is being posted separately to unblock
> other dependent series which rely on the fix implemented by this patch.
> 
> Changes since v4:
> - Rebased patch on linux-next tagged next-20240213.
> 
> Regards,
> Siddharth.
> 
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index 3cb964982792..3b7f0eca977b 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -52,12 +52,12 @@ serdes_ln_ctrl: mux-controller@4080 {
>  			compatible = "reg-mux";
>  			reg = <0x00004080 0x30>;
>  			#mux-control-cells = <1>;
> -			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
> -					<0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
> -					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
> -					<0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
> -					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
> -					<0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
> +			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
> +					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
> +					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
> +					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
> +					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
> +					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
>  			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
>  				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
>  				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,

Ouch. I suspect there is a similar problem in
arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi:


	fss: bus@47000000 {
		compatible = "simple-bus";
		reg = <0x0 0x47000000 0x0 0x100>;
		#address-cells = <2>;
		#size-cells = <2>;
		ranges;

		hbmc_mux: mux-controller@47000004 {
			compatible = "reg-mux";
			reg = <0x00 0x47000004 0x00 0x2>;
			#mux-control-cells = <1>;
-			mux-reg-masks = <0x4 0x2>; /* HBMC select */
+			mux-reg-masks = <0x0 0x2>; /* HBMC select */
		};

Who knows what non-upstreamed devices and devicetrees are affected?
I guess we need to revert 2765149273f4 ("mux: mmio: use reg property
when parent device is not a syscon") unless someone sees a sane way
to fix this.

Cheers,
Peter

