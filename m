Return-Path: <linux-kernel+bounces-33064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60528363E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456271F2483E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835F03C6AB;
	Mon, 22 Jan 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K6URJC1A"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC453CF6D;
	Mon, 22 Jan 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928532; cv=fail; b=CUO1TGB+2rYFNe6zP8zxZtRXK/B6+TYQdaHdXF+ZzdOAOM/WMPdJcN4XdrWvANUqZhQkLdZYWJjQZLzDyjAuhYyPFqpPigHwHiE7BB3ITf1CHdjZ+fItI98+wGWVTNOj7bZbQqEdlYvjJQAFu6Ay94CFlNKcsvk7k4iV3YexxzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928532; c=relaxed/simple;
	bh=ITg7rjIMme8eqq2ha9LxdeJjoQ+PenGW/tFS3dLq7eI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q5LjRQCnFGKY6qB8vQ6HpszEesyWDNh2THWfD/bP79Q/02NakLVpW60HBNlEVfUkt2taaPK/OteuhG2i3CuPdRFUK+/iuc3BXKFrA9IdEHq/v1PQv+iVcZl+WfDk+uFP69VegK+ojwE+/0hLL+1wdBBzfN+T5qKJO9cBQQJpe74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=K6URJC1A; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVuuvs+KiDIodMEvJBw0h5UOJ3S9ozuN0vdWVuvjrshGgxUTcmzPZT+sCOs5G8xQk+v19uxyhNvKteA+xEsVZEQcXADdculvCiigLhhJNwCq1WqS0DzGlva0NGNujRnbT2ZCPdcEeAruMhQ8mQjHZ4C7BfSIBBJbd+eSoC2FNzszqhDfDjCiaQTvfTiLTI/Y13g9C9C6Dw00XtCLEW8Wi1ZT5AQW9lkaYBDemAAVpF8UnMzMm9yJDBY+Plbjj4czG2tPQWrSQf6foc64JcceJi9X183zW4ga3wB+CCTHtzMfu4GSc9dcxCj7Ny9uxE+ufUpfITzqpe7VyQqXbY6/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR7dxerb/6zCzzRQi8EknZg2xXOt3vtDC/D93QPl1UI=;
 b=BSqqrtjmQ1hg9Ur/UfFVNUTxtN5sX4kqRIZhZ0N3kC9XHxZ9SSxrdzCPpOox9kLJ4DS7fOoCfE5KLHor685/DVXzPMQRIIo2v67iLBEDT25PxtW6xJ74Nww0CC2oAlzjXypY6DLActYigfNuWeY/tE+MOtp5kqvSjRXwhLiCH3YR0j3KeHZuvH1lXOpgj2wE+cXz7U6D6YugT25iDy/zN7v5fMgxTdGAkiCgJ+GcWXhrIP0PuU2/PpqVSAgPONde5hhP1/5Dyl/PGKdDj0zzOkBWNx0umfL6yha6cHezCT4vOTZdItCCk1+LkFwlHgyq0epE8lzRcRFjVuD/uopYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR7dxerb/6zCzzRQi8EknZg2xXOt3vtDC/D93QPl1UI=;
 b=K6URJC1AJyYzbdElHUbCS8xRI6PH4/0+nvP+nYFaPM75QBAgizsW9B+Rwdb0nMsjcXCav19wXBmNUlhnEJ5sKd4Zpxy1wMyBo7T204KNxNZJCejWXVD0cMr9/jEJdlJ7PEezdIZ216jAiH9I3VU76+bJzVsmp/7zHWQgsksGHWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 13:02:08 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 13:02:08 +0000
Message-ID: <4a5c810a-ad59-44b2-8926-4d34204649d3@amd.com>
Date: Mon, 22 Jan 2024 14:01:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: firmware: xilinx: Fix versal-fpga node name
Content-Language: en-US
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>, Jassi Brar
 <jassisinghbrar@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Brown <broonie@kernel.org>, Moritz Fischer <mdf@kernel.org>,
 Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>,
 Rob Herring <robh+dt@kernel.org>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Tom Rix <trix@redhat.com>,
 Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 devicetree@vger.kernel.org, kishore Manne <nava.kishore.manne@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org
References: <6779af2f9cc21c912f10cf310388d99b980800b2.1702996281.git.michal.simek@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <6779af2f9cc21c912f10cf310388d99b980800b2.1702996281.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0166.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::23) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 348f267a-75e0-4939-ee24-08dc1b4a5714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	THlZ71xbJZP+Kh2EcdSJmwCgg/tv5StSgbbQtUDiLovHSY2IP8rgRwO3GWmyUMD4Wu5rcl2KDlZg9bqQO42JwI2/p+NfkSDE+6AT0ABNF/RXzcXxnBEfwraqMt6btQ1eCigP8Ndwk/DMfrO1zFcGZG0u6ZDwsTIfGdxfzZitfplOLLwnCHkLo1OuFQnh5dvOBPE0PDRryh6wJVGGGvDIkyyo6gLs2wh1pS+uZFLCzV58fp/Wsqd7QLkUC+agA9OiecyoKrCwqcAFOQbDcHNKAGYbOq0V+M68mWOBiYoW+9VftptYCSNmRgyP/yulYipU4+R1umNz9uWhsgJuK1QZyX0UUsvrpqoGlT5KuLHky94NP/nudJtmXFfFJiGCjIujvw81VtMLvnLpZ4ZnNry5MIb+s2rgOmVCSgV6aX1qbWSBpTJaUsf03Laww8JXOiFUlexcBt5tv8XbG6EjV7RnMRlPQpM9IL43ZFrRqlzApGF03rpdl5ih6z86VehY5SjXWy/9LstCnK0XLH32TOVCA6IxfvyzfJmjqprbZqkB/ALPKpRF6jejrubwDdcSitzRtGhXLAOvoxTrOIW+MVgoGzhufgeE1eLCwHhEwYOsdN5Uwkm9p6/JuSWIMtbdUWPvFDSQZxkMhz8CJ2856/S0Eg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(86362001)(31696002)(38100700002)(36756003)(26005)(2616005)(83380400001)(66946007)(66556008)(66476007)(53546011)(6486002)(6512007)(8936002)(6666004)(8676002)(6506007)(54906003)(316002)(478600001)(4326008)(5660300002)(7416002)(2906002)(44832011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHZiREJvZmpOcGVYOEpQQTFKNEdtenNzL0tkMUtHOWlOVDNzYUtlY3FFeEZ4?=
 =?utf-8?B?T3FMTThWWXIxTWd3eHlIUXI5RlpnM0pITGhjR1J3THN1TjNEcTg3a0R1dCtS?=
 =?utf-8?B?TE9PdzhhVk5IeUZrTUd0UEgzOEVzbkxPOUE1QUpiS2RPZFZlRDZFd0NINjZq?=
 =?utf-8?B?OXR3eWxleEVFcVhhd1B6REJON0JsQTFWdzdEYlh3bm90T3FHS3ZZUDBoRmZ3?=
 =?utf-8?B?cDMvWklYdGk0VXEya3VQWWdWbnIxNjBnYVExUzRJNWlHOXVzTys4UFJMQ1ZI?=
 =?utf-8?B?L3h5bGtoM1QySmdldnJBUU9icnl1TEQ5R0RqNDEzWEJyKzY3NFZ5b21PMXlP?=
 =?utf-8?B?UHhWaEZuK0xOSWg0RGlRMzRkQ09JY2ZFNFZmbENwZFBDVXBMZjcxamNEaFk2?=
 =?utf-8?B?Wm16dnhsM3p1T1dRL1VCSUdpZW5ScU5BMjBEeHlDUndIZnRINzNiUFJLN1ZE?=
 =?utf-8?B?SFd5TFpPNHFFbm5ROEpZcHlPSmVqNG1mdFF4NFFOODliYk12Q0NPQW8rbXlC?=
 =?utf-8?B?MmwwbmxNYldXZnNRR3ZnMjdFc01vWG9vcDlhQzFPRTYzWm1CdjVsQjMrTURl?=
 =?utf-8?B?T0Y1ZCtaQlJ3bHViWHU0ZDYreDRSMGhIcEJmNG5JdlZ4L2UwZlRXZENaZTV0?=
 =?utf-8?B?VVY0MWxETkJjeVRsYVFnTE40cmdvZ0oyMXJycUc3bWFrOFhJeGVoREZGc3FP?=
 =?utf-8?B?TVFEWGRVM0VTdDRNQnUzWWVOU2lnY3RCZWdIZ05ka0h3UzBaNGt5RGZTeU51?=
 =?utf-8?B?S2hhckhQQ1VPSURITzltcVhQaWlTK1dNcHZHamhXUXFCdkdIUjhDUkxJMDFn?=
 =?utf-8?B?M0owMFN0MDNTR3lsWU9sME9kSldPT1FzOEFadmZiVzRQQ3g2MGpuWS9vcWo1?=
 =?utf-8?B?ZW5FQnBCOEtUMW9vaHpFbTlPYldUREdNdlNOMFVZRWw0aUE5TkpxTWVUT21F?=
 =?utf-8?B?Tk8xZllBUzY2b2Z1bzAyRnN3anl5K3J4TVE2cWs0bWMwMlcxZmh2Zzh5TFda?=
 =?utf-8?B?SGg4TVJ2ejBIdVFxeFZ3cXlTWk5jSEIyWGpwNWI1MnZDRnpPT0VpY3FBTGlT?=
 =?utf-8?B?Mkl6bjJCZXdsODFkWTYxd01EMWs2d3RCNVVTWWpYRmVZYWxJNW1pdGgzQ2R2?=
 =?utf-8?B?Nlo2dFZRaFpzUStzYkdEZlF4REtrRVhvcGpOZ1pqbHRtU3o1VnFML2pTSTk1?=
 =?utf-8?B?Q0pJNkpMallSZGJaM1dsVUxhMUtsaGYxS1lwMTRlRDY5Y2V2d2VLRlUyWUV6?=
 =?utf-8?B?R253N084ak5IRGRYUDllcFZLcGZtb0JOOW1uVFRHZGNNemQxMXd3N2s3anow?=
 =?utf-8?B?cnk3bDZNbC9hRXZ2c0Ira1RKWEpON0dQREllK3FXMjlyQTJhOXdpT1c5WnF3?=
 =?utf-8?B?QnJVYXZNeTBXSkdPV256OXlyVkg5Wm40ZXFBc2c3VG9WMW5rdHhEOHJkWkwr?=
 =?utf-8?B?ZHl3TlBxU21tZGZMazFSelZBZWFsTmViV2RDSDZNK2VTZUJiRmFPYzFoSld0?=
 =?utf-8?B?TW4vT1crcFpSTURGem5QQnVOSEZqTjAwbFdxa2lCQkVIN0tudlBZejd0Qkk1?=
 =?utf-8?B?R0FWNytpVXk4QlBsYTkrRjhzZ3ZOaDViTjFqcTMrRzZWYUxxQ2hEZUlEcURl?=
 =?utf-8?B?bXd3MGFyZHN2NDZDK1BmTVFISW9wNE1CSzFRRVJOWVBjVkNLbUVYYU5LWmJr?=
 =?utf-8?B?VnNiN2RxS1U5elk2Qk80UUVzU0dMZUZiam1nOXZEb2xORDltMTM4SlZaQnJw?=
 =?utf-8?B?RkZGZHVibi9aUVBHSTNQdHVnc2xkSWl4dFdqbDF1bm9ZZndxcWJSOFJrMGpK?=
 =?utf-8?B?dmg1c3pEZ1R5QnpsdmtpdjJoaEttLzd3ZWZzUzVrTGN5THpxYmZtN1JiN2Va?=
 =?utf-8?B?REI0MTVqMnVTY01HWmx4RWRjTVFnU1BxTEN3K1o5cUpabXRtcDFxWHZ5Z2F1?=
 =?utf-8?B?TWtwSGRXUm5Ld2pmc0xxR2VSSy9lemo1dGVZc1NSeC93eGdYMjZ5OHpYenJY?=
 =?utf-8?B?UVhyVm9oeWZBZzRTMVNMaUhnMDFhU2JSVktqZ0M0Vy9RZmVmK0lBVW9FYjFD?=
 =?utf-8?B?QTd2Q0JVUzFRU1J3ZllUc0FFZWZvQjlNblgrTDY1M1FXQ0lFU3FGQ25VWDVD?=
 =?utf-8?Q?eO+XxI39ObW7pxniGvIErMF1l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348f267a-75e0-4939-ee24-08dc1b4a5714
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 13:02:08.4527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4qYZD+u310phcnkRBk4TyFb33wfbzKDcmwHf03BBmQeVmRL4N0Kro4K2pj5IbEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628



On 12/19/23 15:31, Michal Simek wrote:
> Based on commit 83a368a3fc8a ("docs: dt-bindings: add DTS Coding Style
> document") using underscore ('_') in node name is not recommended that's
> why switch to dash ('-').
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml        | 4 ++--
>   Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml  | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> index 8e584857ddd4..3d578f98ae2c 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> @@ -41,7 +41,7 @@ properties:
>     "#power-domain-cells":
>       const: 1
>   
> -  versal_fpga:
> +  versal-fpga:
>       $ref: /schemas/fpga/xlnx,versal-fpga.yaml#
>       description: Compatible of the FPGA device.
>       type: object
> @@ -84,7 +84,7 @@ examples:
>         compatible = "xlnx,versal-firmware";
>         method = "smc";
>   
> -      versal_fpga: versal_fpga {
> +      versal_fpga: versal-fpga {
>           compatible = "xlnx,versal-fpga";
>         };
>   
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> index 26f18834caa3..80833462f620 100644
> --- a/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
> @@ -26,7 +26,7 @@ additionalProperties: false
>   
>   examples:
>     - |
> -    versal_fpga: versal_fpga {
> +    versal_fpga: versal-fpga {
>            compatible = "xlnx,versal-fpga";
>       };
>   

Applied.
M

