Return-Path: <linux-kernel+bounces-85585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B8086B803
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6D71F271F7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A1574426;
	Wed, 28 Feb 2024 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GPYsvnax"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF24471EB3;
	Wed, 28 Feb 2024 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148046; cv=fail; b=MqiMZuJe4IQChXYd/az/naxwtiEQ9nVznhL4rvuD02Z/KI1VnbVpaBHFOBCh27Ch7ciW6qUWEOOxpBzz9dnC0JOeAWnN8rTO99Z/CRj5NXr6L8eC6Z1OLxPFud0TWGggFKtU8fgn5SLEc4iqcM3M6Cfnz6bps+BD/sfjk1pLqdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148046; c=relaxed/simple;
	bh=GOS83P6vOBycFctguM5O7PyE+8zD4kdg//LnB8ehIxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rbL5ZuPt9a2XFKoSg6O1bEBzGWoedgUW1qxe24VGbtQnjO+aRL5g+7b+3DF52ddZ4s3csVy2NjQSmg1GUdvwuWM3dU1ppWifqkuTWjaifO1ReFcKWWSD+5QbgZEXbbxjc1mA3YHE1Ix2EglETb8mVk8QKzE+KSHU8ZRR1s8UKeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GPYsvnax; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3Ci0ei52gvyqXN/NkoavKaCteFNP9D/X1FZ9ECX4w9nn2c/b9kx5SnKtsIIKhoNG3iEqeZL6cMCF7hSv5qR/MZ2Az1E9w0OseESRPbh7H3k4bR9/30xRW8EC0SapuZbdbtbmosXzVt8z5G9UK8qlJCTSi/5a8mhgJJVp02D2tGCyEGz4QXOPt9ZEpi7+1UrWqL2IBPeuYNtz1CLDnaXZ+fDa5GLgTaVh2aOylTqV8asrTrfY/RkD1t7z6I5ja7b+DOkConZ0Lb5jCQDhlIfXLsek/8zHwbR21x3WczdgpVl/fhIHIzx+ml/lfhKaW92nFe8bL1pF5qwPkkYl/6MmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP2oIzSWiZmh95/9cmmS+RNC7RK0XVcac0w53VtUodo=;
 b=f5rzIKEPakLzXTjSBvjlTA9YoDyaGtWwEqQagP+K6jN8Oqd7eZifPZnKn+7MTSEMW292+FL9/MU1GCvoqaYnfQKqF2TPFpVZ6oD9jplKf7nzjMDxzfTvTvUMcYo4l2U8Ynd/KvmW1sN5hw9bCy29NLw5GAWYDbox53HHx1mA2NC0Ec7s+g910mN+1eA/DaYPBYssjj5ns4U32I/LrlBWWtKOCL5vfUnonezq1EPtEILaMxEUnTDnLYLAfW10+rXa96xUclOvGTSwfdvxYDzt5zrS/0y0tb6Pcm9lFQxkgF/5gvYHJIu7O9TdHObTbeXI7YLV23l/kZdi/VICS/hr6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP2oIzSWiZmh95/9cmmS+RNC7RK0XVcac0w53VtUodo=;
 b=GPYsvnaxKBq7YkcxpStFoX59VANLDWFEtK1IatIL5SQL6oOJf9oRIGMUOnQz/Kc/xBvs+ekd05qAVT9Ve2J7OSObFJJsXOYA+5ccxxgQeVgBfVTJoIWMluY9SrLEwfAKeGAWgWcEd20uCowLMoGGa1eub4RcI4jMBO6RIC/lFTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by BN9PR12MB5098.namprd12.prod.outlook.com (2603:10b6:408:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 19:20:41 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::14ab:832a:11af:bfec]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::14ab:832a:11af:bfec%4]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:20:41 +0000
Message-ID: <ebf6eb21-8dd8-4ca7-afe1-7149817c8f34@amd.com>
Date: Wed, 28 Feb 2024 13:20:38 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v11 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
Content-Language: en-US
To: andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <20240219174437.3722620-1-tanmay.shah@amd.com>
 <20240219174437.3722620-3-tanmay.shah@amd.com>
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20240219174437.3722620-3-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0035.prod.exchangelabs.com (2603:10b6:805:b6::48)
 To BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|BN9PR12MB5098:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8cfca0-b4d4-45b2-e99e-08dc38925a36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eP3BgXgGpfZ5TrBFoqmiR0u+lzU03N4etdAQYgtrv0Top72VznIbMwKDmrHKrAa79qAvW7lH9iDUZrR3oloRgjevod4it/XUqZIvLKyQsRbnLUJ86y0LRrarhiNCO1aUZgIPwsNn/Jir49KsLK+KV0c77z5m2s8c0j8AXG8NpowtLBkMWQIMggkyHQOhvh/nstYYL32JhkPboue67HcOdEuF0VwZgWMNz8lXQYikd8/oDZ8a/lYGbq/lKHmVVfG+Yy2Pcbm4fYIeITUyL5NAQw2vgurgoUOEx5upzoG9Kpeo+DaqSoDKbtAG+N204Se9PMblSyQG1ZGyRlkhylqnoXKIiGxQn+FMc9kAfINh6tGbC3kKV3Q9qQdMtv3lIXlDLZsEvbxpUVJGsBvxOxWL76w0WHcBB3WnlB+fsYHGZwLQNLVr8J+d6MqoRrp2rsQACFooju57TpmmKRhMgJ98N4mYoX2Woz64o9ZHT8h5IfBzYzzo2/RHdcTI8cml5TLzwVvmbUKMl0cmPjq98QeA0B+IkHG5hWFu/asyYJsO2Np6huv3PRq7iDb2RcGWbprRAUZyqk0g+aQ0HucsjI7TSBqnuhf90jcJtNarQ5gLVozWuBXsx2qGHz6JsxmADJrq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czVUcmZwcysyWXl2b1U0aFVmVG44QlQ0bTlxekZHaEFNUy9hcmJzTHcxbVlT?=
 =?utf-8?B?VElEeVF4NStFQkF4ajZ6K2pOV21JWWRRWllIaS9PMHYwc2JTYlVINFlMV0VW?=
 =?utf-8?B?SjNDSnRPRU42dHZibW5EdURSZkovaURKSGx2V1VjYTdQSjNGUS9keXU4QlBT?=
 =?utf-8?B?cGloNFBVY3dURlR4MDBUQXF6VHR3c2N3VTFCUXhqSVhpVVBZZDBoNXd0Z2FR?=
 =?utf-8?B?dW9wUDVjZ2RFaDRzRHNsbkN5amxpYlJaOGtpdHZZc3RSb0NDa21vZEs5RnVS?=
 =?utf-8?B?ZE83eVU0VVpqSVB0ZUh2Vmhib3BzQk1IQmVIemVXdWlET2tnbEpPRGdLUy9X?=
 =?utf-8?B?MnBiMkl2MjRvbW1TZkM1Q08rOVcreHArL21rM0hxZE9iY00xQXoxTktPa2Yx?=
 =?utf-8?B?RmpUcUJnbXF4bzN0TWxSTGlrditqbGVCWlFoaHJMZUVPZEVhTnh3TllqZktU?=
 =?utf-8?B?NE5nME4yMG9LeEVUZGpqT0lXNGR5MXNwQ1FlZk55RnB3OEE0NDlPSDg0eExu?=
 =?utf-8?B?dUxYMnFoTzlmQ0phR2hKMHVtUjBrQnl2cDNSQS9Rd1hORGp4enBQeXZqNGU3?=
 =?utf-8?B?clRkYjA5bjlWbFh3Z2oxUzhMYkFlU3BxREdSUFMxbDd5NytVSllaWFZuVm04?=
 =?utf-8?B?MGYzZEdkOGNkbnFmQUVVQUh5dkFhQnIva2k1bjFWbG9FaWpNSGJEY0RRaUJ3?=
 =?utf-8?B?L254cUEySGJ1cm1YdGdSaEZueXhPU1Q0d1hDUEFRNUlEcWVJVFV2aUM1ZXVy?=
 =?utf-8?B?dlE2Y0JNSC81MFN5b3N4bUJwNzBqYnhFZGNxbXJQOHhoYVk4YjdoQ3AxMFI4?=
 =?utf-8?B?WXFyOEpPWkNJQ1JRamF5N1NKNlVleFluZStIbE5oL0ZKaTg0UnduQW4wM0hP?=
 =?utf-8?B?VE9WQ3pUcGkxNmYyblNhdDNRaUxqLy9kU09IczVaWmMzaDk5TVdmcldSL0xU?=
 =?utf-8?B?UUQycEVKNWdOK0JYRUF0SnljaCtwV0k3Q2xKR1ZoMXR6cGlxdlZ1aWVrK29n?=
 =?utf-8?B?ZVo3dzM0MUx0ZExKRDJRbDNFRHNhcGxmNTBhVDBzVGgxV0s4aUxlN2RERnVG?=
 =?utf-8?B?NkJjUzR4ZmFVWVRmaVNFbTNEc3M3ZGZrTllydC82ZEVjR0lZWGpKZUlrRDZp?=
 =?utf-8?B?eDU1Y2k2VDI0cCs5S3NpMEVYZzVrbGRCMGlDNy9Sa01aOXZydzMyaWRYQmpa?=
 =?utf-8?B?UHpIa3FWdkFCdGJrYndLWGNQRldTZXZMcDNwbm5zU2tYVXJ0azNKcUxqTEx4?=
 =?utf-8?B?N1RxQzJKQmNySGhsY0g1dFFQMU11TTVpS0dKMWx4UVRCN2ZpUDJCd1ZTSjJ4?=
 =?utf-8?B?dGljb3V1T1hHQTUvcXorQ3JtZVJ2YU1lR1Zqbklmc3FVYnpmaVo5a2JTNW5j?=
 =?utf-8?B?eXZNTEJxZHNoMktCem1yRGpFcTlhRHkwc3dYTTk3QTVseXJmUnVaZlFYaFE0?=
 =?utf-8?B?NjdzMkNtTS9UVkN5UDZ1M1A5Ui94cC92bnRaMFM1SldKOUpKeUFGNDUvNFJ1?=
 =?utf-8?B?ZDFrSlk4dVBzRVF0dGduZStEN0dYSE44RmEwc2NMeXpuV2NKWXB6V0w0UG43?=
 =?utf-8?B?SmR5QTVQRzFOT2ZQa2dkUk5sTVRGUmUrVGZZalkxdE1vZHl2RVVmcEZtRzdn?=
 =?utf-8?B?c25aRHdHTm9zaFdXU1RsVklReGxqM0FadEtjY0tyaERmUzVta21WU2dxaHAr?=
 =?utf-8?B?KzFzY2JVdE9rUXRZbks1SWFFbWdiaUQ1d2dmd1dESFFid3d4RFkyQnhjQ1FG?=
 =?utf-8?B?ayswNVpydEsrN3hjalYybHE5L2pGcFNOQ2VqUFVyREkzY2xTZnRhc21Gak15?=
 =?utf-8?B?Uzd5Rnp5MUNkS1JVQWN6TUI5S1JXT042bmI4djdGMlR4dmVReEFmb2NJVktG?=
 =?utf-8?B?MTUxQzJ6MlpNMGJBN2ZpMjZnbWFQbGlxSERCbEVKY21Mc2dTMnB1dFN1YmFT?=
 =?utf-8?B?aktSVnhRalJadEYrR0czcndMWmFCSHhxVUplQzZBV2REQVlhNHQ0U3g5NE85?=
 =?utf-8?B?bjEwREVhcGpXZnJKQUZYSk1jcUc3TXhNZEQ5YkZMbllXMC9nZ1FZSisxY1NN?=
 =?utf-8?B?b1NJZ05nTGxveWtFQUVsbVRaVFRRNEhKRG14VVllZ3ZqN1dnc3g5SnltQlh3?=
 =?utf-8?Q?d8ILyegIqJ6ZFmAWgvpGnwwC2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8cfca0-b4d4-45b2-e99e-08dc38925a36
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:20:41.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENY0FoyWvDuOdHSFZ2fP+u/mOOoMT5oEWYLx1XxJOwAE5C1Gmc6xjKYrjFiE0n1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5098

Hi Krzysztof,

Ping for reviews. Also have question.

I am referring this patch from patchwork link: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240219174437.3722620-8-tanmay.shah@amd.com/

Patchwork shows that dtbs-check was failed, but I am sending dts changes in next patch. So dtbs-check failure only with bindings patch is expected.

How to resolve this? Should I send dtb changes same as bindings? Or we can ignore dtbs-check errors for now?

Thanks,

Tanmay

On 2/19/24 11:44 AM, Tanmay Shah wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>
> Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> UltraScale+ platform. It will help in defining TCM in device-tree
> and make it's access platform agnostic and data-driven.
>
> Tightly-coupled memories(TCMs) are low-latency memory that provides
> predictable instruction execution and predictable data load/store
> timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
> banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
>
> The TCM resources(reg, reg-names and power-domain) are documented for
> each TCM in the R5 node. The reg and reg-names are made as required
> properties as we don't want to hardcode TCM addresses for future
> platforms and for zu+ legacy implementation will ensure that the
> old dts w/o reg/reg-names works and stable ABI is maintained.
>
> It also extends the examples for TCM split and lockstep modes.
>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>
> Changes in v11:
>   - Fix yamllint warning and reduce indentation as needed
>
>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 192 ++++++++++++++++--
>  1 file changed, 170 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> index 78aac69f1060..77030edf41fa 100644
> --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> @@ -20,9 +20,21 @@ properties:
>    compatible:
>      const: xlnx,zynqmp-r5fss
>  
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges:
> +    description: |
> +      Standard ranges definition providing address translations for
> +      local R5F TCM address spaces to bus addresses.
> +
>    xlnx,cluster-mode:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [0, 1, 2]
> +    default: 1
>      description: |
>        The RPU MPCore can operate in split mode (Dual-processor performance), Safety
>        lock-step mode(Both RPU cores execute the same code in lock-step,
> @@ -37,7 +49,7 @@ properties:
>        2: single cpu mode
>  
>  patternProperties:
> -  "^r5f-[a-f0-9]+$":
> +  "^r5f@[0-9a-f]+$":
>      type: object
>      description: |
>        The RPU is located in the Low Power Domain of the Processor Subsystem.
> @@ -54,9 +66,6 @@ patternProperties:
>        compatible:
>          const: xlnx,zynqmp-r5f
>  
> -      power-domains:
> -        maxItems: 1
> -
>        mboxes:
>          minItems: 1
>          items:
> @@ -101,35 +110,174 @@ patternProperties:
>  
>      required:
>        - compatible
> -      - power-domains
>  
> -    unevaluatedProperties: false
> +allOf:
> +  - if:
> +      properties:
> +        xlnx,cluster-mode:
> +          enum:
> +            - 1
> +    then:
> +      patternProperties:
> +        "^r5f@[0-9a-f]+$":
> +          type: object
> +
> +          properties:
> +            reg:
> +              minItems: 1
> +              items:
> +                - description: ATCM internal memory
> +                - description: BTCM internal memory
> +                - description: extra ATCM memory in lockstep mode
> +                - description: extra BTCM memory in lockstep mode
> +
> +            reg-names:
> +              minItems: 1
> +              items:
> +                - const: atcm0
> +                - const: btcm0
> +                - const: atcm1
> +                - const: btcm1
> +
> +            power-domains:
> +              minItems: 2
> +              maxItems: 5
> +
> +          required:
> +            - reg
> +            - reg-names
> +            - power-domains
> +
> +    else:
> +      patternProperties:
> +        "^r5f@[0-9a-f]+$":
> +          type: object
> +
> +          properties:
> +            reg:
> +              minItems: 1
> +              items:
> +                - description: ATCM internal memory
> +                - description: BTCM internal memory
> +
> +            reg-names:
> +              minItems: 1
> +              items:
> +                - const: atcm0
> +                - const: btcm0
> +
> +            power-domains:
> +              minItems: 2
> +              maxItems: 3
> +
> +          required:
> +            - reg
> +            - reg-names
> +            - power-domains
>  
>  required:
>    - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
>  
>  additionalProperties: false
>  
>  examples:
>    - |
> -    remoteproc {
> -        compatible = "xlnx,zynqmp-r5fss";
> -        xlnx,cluster-mode = <1>;
> -
> -        r5f-0 {
> -            compatible = "xlnx,zynqmp-r5f";
> -            power-domains = <&zynqmp_firmware 0x7>;
> -            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
> -            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
> -            mbox-names = "tx", "rx";
> +    #include <dt-bindings/power/xlnx-zynqmp-power.h>
> +
> +    // Split mode configuration
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        remoteproc@ffe00000 {
> +            compatible = "xlnx,zynqmp-r5fss";
> +            xlnx,cluster-mode = <0>;
> +
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> +                     <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> +                     <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
> +                     <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
> +
> +            r5f@0 {
> +                compatible = "xlnx,zynqmp-r5f";
> +                reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
> +                reg-names = "atcm0", "btcm0";
> +                power-domains = <&zynqmp_firmware PD_RPU_0>,
> +                                <&zynqmp_firmware PD_R5_0_ATCM>,
> +                                <&zynqmp_firmware PD_R5_0_BTCM>;
> +                memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
> +                                <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
> +                mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
> +                mbox-names = "tx", "rx";
> +            };
> +
> +            r5f@1 {
> +                compatible = "xlnx,zynqmp-r5f";
> +                reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> +                reg-names = "atcm0", "btcm0";
> +                power-domains = <&zynqmp_firmware PD_RPU_1>,
> +                                <&zynqmp_firmware PD_R5_1_ATCM>,
> +                                <&zynqmp_firmware PD_R5_1_BTCM>;
> +                memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
> +                                <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
> +                mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
> +                mbox-names = "tx", "rx";
> +            };
>          };
> +    };
> +
> +  - |
> +    //Lockstep configuration
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        remoteproc@ffe00000 {
> +            compatible = "xlnx,zynqmp-r5fss";
> +            xlnx,cluster-mode = <1>;
> +
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> +                     <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> +                     <0x0 0x10000 0x0 0xffe10000 0x0 0x10000>,
> +                     <0x0 0x30000 0x0 0xffe30000 0x0 0x10000>;
> +
> +            r5f@0 {
> +                compatible = "xlnx,zynqmp-r5f";
> +                reg = <0x0 0x0 0x0 0x10000>,
> +                      <0x0 0x20000 0x0 0x10000>,
> +                      <0x0 0x10000 0x0 0x10000>,
> +                      <0x0 0x30000 0x0 0x10000>;
> +                reg-names = "atcm0", "btcm0", "atcm1", "btcm1";
> +                power-domains = <&zynqmp_firmware PD_RPU_0>,
> +                                <&zynqmp_firmware PD_R5_0_ATCM>,
> +                                <&zynqmp_firmware PD_R5_0_BTCM>,
> +                                <&zynqmp_firmware PD_R5_1_ATCM>,
> +                                <&zynqmp_firmware PD_R5_1_BTCM>;
> +                memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>,
> +                                <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
> +                mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
> +                mbox-names = "tx", "rx";
> +            };
>  
> -        r5f-1 {
> -            compatible = "xlnx,zynqmp-r5f";
> -            power-domains = <&zynqmp_firmware 0x8>;
> -            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
> -            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
> -            mbox-names = "tx", "rx";
> +            r5f@1 {
> +                compatible = "xlnx,zynqmp-r5f";
> +                reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> +                reg-names = "atcm0", "btcm0";
> +                power-domains = <&zynqmp_firmware PD_RPU_1>,
> +                                <&zynqmp_firmware PD_R5_1_ATCM>,
> +                                <&zynqmp_firmware PD_R5_1_BTCM>;
> +                memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>,
> +                                <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
> +                mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
> +                mbox-names = "tx", "rx";
> +            };
>          };
>      };
>  ...

