Return-Path: <linux-kernel+bounces-33059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D45D08363D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0597F1C24C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B673CF62;
	Mon, 22 Jan 2024 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g7qPD8jT"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F93BB52;
	Mon, 22 Jan 2024 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928427; cv=fail; b=ATT5NkNyYY9ds3aXH0ITf9aOtzuQl0++UkyBzSYmHAgU6AL5FgSjAskOrd9zyYZnjHuoy19FJ4ayg642ngSIuv1HWaeBrB1RUsbxnNeaQ6RwDEK5Evw9y8jmmNtjhK7z4RYpubbMSCVkfkxcEFX1SrhqLLAS+GCTqX4OxUWO8eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928427; c=relaxed/simple;
	bh=OwPiKbtgYhFxn+z3xaG0plZgh5MMtR2M79ePzaNQSz4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PjPKfaUTpb3719fr1S+5ajSqYRNNl2mCv/9iCUZ2blMlni+Jv5lXmpuWrLGgh1uOgTDcnKvp5Anl6fARnYzSv8FIrQ2Y1L1WxFFHnjxCa7BDUzhNftilxE0V7RNuKsgh3AK421Mw6fMEkGCnu9lgQC1n6dlTZVkRVtp1MIbcLco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g7qPD8jT; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUUV4tnGk2C0FWAjNo9APKN6LYKmnPOsHXX5ozS8UnQA+ucL2sRYplZs+ArFH6C7RkclXiNW3zpJqryne3hgQhdLdcap5sfcYapy/8nN1KvRw2uPpE6rVJwoUjKXrom/yrkXJ1MxrPHEyP1uSmorekpIothgWvWK8cD9iYp2nfvcE799BX7EOXNPlyqJWfruQTIAQAcPS47DImfsr/BHBF4N+XkhBvChM/IZX+nrr74tjOAQDE3kS7r/fk7voTvAb6oJMqCbXOatd4q53C0Mem0ChjUFooWgTe43D7+AK4o75W3KnlGnBq5srB0rMZE30VtF1mg7eZbTDRiCMJfNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a56DSSoCIkng9+vwC2uqU3cKsMoUFh9QlgQTIq+Huc=;
 b=YSqUrnlGPxSkF6D1dfcTeL6SNDdvnJnfMGzW7Wqo30ttg0KWGaVsPhpBjqBSALUOqeKxO6zw1oLdFB0i1g/CPD5zTCuQxerI/fh1QAwCt7aM4AzLrAP9d19ukiW0APSf8T9EwFAzEzdtgyKWQADnuRQcs815vuXkmumfH1hDO1I5PhKOfPXg6BybWHq5VgZfO/6pYMk9gp/K8XhAgrJb3sZQLDkK5sqos71ulwor9SWJDRsqgaFO4HHjq8IuBVQFPWr0Mci/i//BQZwZNz5b/7L1WgRkvn8+DuI9rxoWICpk+Bd7FLd26Z60mhT68ivES22KcbbEc3h0zOlNphKToQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0a56DSSoCIkng9+vwC2uqU3cKsMoUFh9QlgQTIq+Huc=;
 b=g7qPD8jTDckIDlnc4fy5DpAGsP8C06bzCx6IavMrI3Mrk6z5AL7LeGWzv7xZlyKi0T+YEdrtyDHqATz8r+9Xs9O1+kHCtBQRne1qRfgTw/bp8fECPNjQg77KuElhv4L3gj98MthT4qJNAQGon1yRjQ/Sl2dDKSn4JYtHprG3OwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 13:00:23 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 13:00:23 +0000
Message-ID: <5e985d4e-00f3-4748-a808-5992f5561a8a@amd.com>
Date: Mon, 22 Jan 2024 14:00:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: firmware: versal: add versal-net
 compatible string
Content-Language: en-US
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 sebastian.reichel@collabora.com, shubhrajyoti.datta@amd.com,
 naman.trivedimanojbhai@amd.com, jay.buddhabhatti@xilinx.com,
 nava.kishore.manne@amd.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <1705406326-2947516-1-git-send-email-radhey.shyam.pandey@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <1705406326-2947516-1-git-send-email-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 254d44af-ed2f-4527-fad9-08dc1b4a1893
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mVuCEDkgRPReq84DqUdh4miCGD6C8xlzM/vgPGpL/3ZOmz20YASfnqzq1L/TO4cklmMhJZTyjbHS49cYUeioQV9yDgRBgreg+RCIFq49lHwbzaUR551F3Ifq2J+ofFQlGHL0wltI5A2OfyRxsJDR+hQE3B0OHTLVUQX7Ur7Spq1XahZW27FHGDo1Nd8zyUGPOu7jrIRjkgLA6EPZaidgPlzc0VFb4NknWSbuTv6rd2+0KyFOn1TZDFzTh16b0QRY785d+NDiOgsoY4F8s8I53hELYtjwhR1RYnRCNh4sgxKbKdhykVdPOwfUc5JreAhbeIgMBldROkkwyfWXLAW2YCTuvsX+bolzE8LX6A1tb0BB5dS6EhmZX/O8OMjbwGmot+e118ulBnlMPBG97gBg2WNb0mgfwImWuypi0B+mH8n7FWoQ+XqmV1Ho2rUZ4AtnniegQ5AfhQYTSiJrtvc9ljCfwuEeoflrkeasRV586EnXGOR11k2QnOFK2V3Un+5TO/s3HBDdGgiv2W8lmbS6hR8o5P1uQSrJ7ZL/QiwcDBHPHvoO+qT9WT/qFLRa8bVFiyxGf6zW/9p6OuVXQzEP68oUvAVHTY+IGa7yHOhnd73gj5JkrgqXWleDN9ICmkcxKj3DWoFmqZuCgk6Mur/RNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(6506007)(6666004)(6512007)(2616005)(53546011)(26005)(36756003)(38100700002)(86362001)(31696002)(44832011)(83380400001)(5660300002)(2906002)(66946007)(41300700001)(4326008)(8676002)(66556008)(8936002)(66476007)(6486002)(478600001)(316002)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTJCYm5QZTRlbms5VmtHMkRJWFFCOTBZazdnTWdVSnZoSlFpOVRqRmxJQzdz?=
 =?utf-8?B?SGtic3E4Y0hsaFQrR1BHU0YwaldReTVFaUQycWZXMG9oSjFYR2V6MnBNT2Mz?=
 =?utf-8?B?cTB1WU1MczVyQkZNamY1YVhzQ1BhUkJ0TWp4RlVCZ0MyVnphblNtZHYzUnND?=
 =?utf-8?B?TUNmS25mK2Q2WlZyZmRmNEwyUkd6bjljOEJ6bjZIem9mSnJzMXlPTWt3Njkx?=
 =?utf-8?B?MEhvcVZCakRuQ2NxYnBrVFVVeTJLWHlHUXBJdGtxeFlMYXlqQTZzZXNETVFE?=
 =?utf-8?B?ZDhEQkVrUVdLUlV3NDZreTEya1BRQnRrYlhleXdxaTgzbHJzSjlXOFpoZkJw?=
 =?utf-8?B?eG1XVmhyWjI4Yk9XYkVvYjU1SmdwMVljQUxxWGZvUnczYmpmZUxvYmpGT0dY?=
 =?utf-8?B?dWdaQmFidXh0QU50K1VxZGtyOXcvVjN0U0NNWnY1b2RvOVo2Qkl5Y25OOFNa?=
 =?utf-8?B?aTN3L0RVT0h3OXg0b1liNWJqTTRUdytldnN6eTV2SjRyVVpNY1hpWHhrSzdq?=
 =?utf-8?B?MFBlNGF1M2xMR3YwWGxGZVVLNUJseFNMaUIwK1VnM3lrUTZ4dnVtOFBGU2dk?=
 =?utf-8?B?RFBxdFV5Q0ZCZm1uaDlqMGg4d0VrUW1EM3R2dnBHaFZ1TmdPYjF4OTV3N0Jo?=
 =?utf-8?B?dkdkQ1VMVUVaVFBTalJwY0Y3Sy94TlJTb0FuUzNOVUMxNG85UytwQzhKN241?=
 =?utf-8?B?NWpSa1pnK3lPeEozQ0dub3FuRGp0akUzUkZFbWM5ek1NMU1uQU9XMHhsM1dH?=
 =?utf-8?B?ckNKQ3RyV1MrWXZwS2xDWmdPN3hsTlNxMzh3a2RIMXcyOXAxazY4VUI2Rzlm?=
 =?utf-8?B?K0MyaWxibURrS0grbDRlTE5iKzVFWmlMWExXalpnTVkzQzlxbWdNdHVhN0Va?=
 =?utf-8?B?ZndzRTA2U3dkdlhFU2NMMVovTWttWEEwRlJxOW1BdXl4VjlxR0dOMHBOWUk0?=
 =?utf-8?B?K0g5eDFwdTFqVVYzZUJXenlKYjR2d3M2NDRmVm52R0ZScFd0WXNnVEQxbDV3?=
 =?utf-8?B?UHRxcmlRTUp5Z0FBalFXWHIzTzBMT0NnanFJRVd5VzFsd3h1elFlSGhHTXk4?=
 =?utf-8?B?SWZBdGZXaGg4YWhUUkdCYzVmNWFKRUNzUzVQOUtsUUJwTjVFZisraTl4K2lp?=
 =?utf-8?B?SDJTTk9ZVThrVnpYTEQ5S3F2NkRlVGpjbkpTQ3BObmdRL012T0E0dDhSMmZl?=
 =?utf-8?B?ZUhYdXRhUUc5OXBFeXdjVjN4RDFqbERsbzYzY3NNVkNVMUw1S2Ixb3FNT2s4?=
 =?utf-8?B?bVFLazgxdFJVQVI5NHN2Wm5hNmNCYlRvRUpESlZyNU9RYXZDNHJkM1dsL1Rx?=
 =?utf-8?B?a2NJUmJWNnV4amx4RFpPazkxdk4yQzUwYzVEYjNlMStsMzBuZzY4cVdRRGdC?=
 =?utf-8?B?ZEhEcEI5OFY2OGRRVUpUeUFvTlZTbWl6Yk52OVVXTU9nZitvSkxGYit1Y3gx?=
 =?utf-8?B?OXlvVmovTmwwK1VURmczR3ZFVzYycytSZ2J2MkdmYTY0QU8vbWZzZjdDZHM1?=
 =?utf-8?B?R0lRQjJNZXgzb1kxeXJOc1paeWliUkxpYXpzWEo3M0tyWkRPd2xyTXpoZHhx?=
 =?utf-8?B?ZWY2QVBJNlFWN1czZ3JlampsdzYrejl5dGNtbEhqR05SelQvRUMvaUpFRjZw?=
 =?utf-8?B?MStQd0tjTFFhYU5yT3JEVkZ2R3BOMWVhc1R0SEN4eEZCZmlLQ3lFTFpVZTg2?=
 =?utf-8?B?cU9Wam5iYnpsMndHNXZlRXlrOWJSVEZ1T2JHMkFBdkhPNTBka0p6emhXaDBh?=
 =?utf-8?B?SVVPRTZwV29acXFOV3ZKM2RjMW0waUxPM2FMbnc5d1R5d08xcUIzRnJLVU5T?=
 =?utf-8?B?UW9RYURCSmh4L3J2dEhSZTNaYysvZnR0a1hDNUF5bXJKUVBSVy9jdmE0K0lV?=
 =?utf-8?B?TEZOSDJBNXU3VFVtTE5IK3IxQUFqZFoxczZDblI3allTMkNYMjNDSmpiTjFv?=
 =?utf-8?B?UVR3ZGxucm8yazVpK1pvRGhxb0Y0Y1V5SWRpRHhWeW12cTFzWDNxTVBVaURM?=
 =?utf-8?B?cWR6R1J5ci9PMHpiR2RRSGZDQnZVc0JUVGVvN05SZ0RuU1Q0c01MYUdCaVJG?=
 =?utf-8?B?THM3TzRHWm1QV1AycWZueUVIRGI0QTNjVGdkQTF5Sm9MVldHOXpRRmtHdndw?=
 =?utf-8?Q?k0vG8hw1n0ko1n3SAilONT1AP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254d44af-ed2f-4527-fad9-08dc1b4a1893
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 13:00:23.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCSKmidreWRIUgkOq9WCRBS7p/vgmVsfzWFW81TTXql4NNV3mH8iQBuuryShbCKB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452



On 1/16/24 12:58, Radhey Shyam Pandey wrote:
> From: Jay Buddhabhatti <jay.buddhabhatti@xilinx.com>
> 
> Add dt-binding documentation for Versal NET platforms.
> Versal Net is a new AMD/Xilinx SoC.
> 
> The SoC and its architecture is based on the Versal ACAP device.
> The Versal Net device includes more security features in the
> platform management controller (PMC) and increases the number of
> CPUs in the application processing unit (APU) and the real-time
> processing unit (RPU).
> 
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@xilinx.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes for v2:
> - Add Krzysztof acked-by tag.
> ---
>   .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml      | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> index 8e584857ddd4..cd9fbbb62552 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
> @@ -26,6 +26,12 @@ properties:
>         - description: For implementations complying for Versal.
>           const: xlnx,versal-firmware
>   
> +      - description: For implementations complying for Versal NET.
> +        items:
> +          - enum:
> +              - xlnx,versal-net-firmware
> +          - const: xlnx,versal-firmware
> +
>     method:
>       description: |
>                    The method of calling the PM-API firmware layer.


Applied.
M

