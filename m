Return-Path: <linux-kernel+bounces-67323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC4D8569DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B88F28921D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E413664B;
	Thu, 15 Feb 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="czS/kJlN"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5612FB27;
	Thu, 15 Feb 2024 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015528; cv=fail; b=pWk88hoZ1ZImQM9wXgfvXKS8Au0GqbKdcvDftdNEUHqvQyLFpOmneLPA2NKw7DsYHwBJ4LDiU9ko/F1HWvzICsMO5q+Y14TO0BhPkRZnQbZR3AMvt8BsTab2tVTFmm+QPFn7ggiOxFUcCVRuXoMs1TWBBtbiUFPGaaX/uVg3ngc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015528; c=relaxed/simple;
	bh=lEiZIEh4l1Pzg41gN8ZF1pb0O6WpqU6yanm3S86SMlg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dTX8E7HQNcgRaDhn2okX+X1f8gOmMs/h6Fd4DrQom5FkfRwbqfvTxjbr4gNlZwzPfwXr9lszcZkbte2ANeqUFfrJpTzFd0P8FapX8OkK93rdvW+axy43B/yUauH/2uMqayTOAI6Smf+R+zv3FDlTyDfBRzrFzd1I41pTZblkg4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=czS/kJlN; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbrczpK9uoN2tfeWkXfq8j1LztEpHkAyawjqOQtuYIOFhakO9e5yBjXgtcfgumb3pk2CkgbgYY/bWAlDFAwZ8YmxW6jwamdFQhI1oBkOVfCLo/oJQ5dPRjZ9FxLY9SXfMbRMTMhLeCodrPGYtSr3R+b1q35uRJ6041w9trGKL52uotyX/tLCDydPdCiv1u5Zzds+ESDMPLd2tdqVuqyO4+SBWN2dzqG/lqfh/xgEOuqckz1zzJ3nUA6vlyZNzDZGpPf5Ck0CxyABEDYIrvw8ukN+3q+tEK2XsScOXd4YfYlpaPuS7kz5JlDnr42lURbS0RhbQCaJveswkEcyYjaUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA3kd2hbT/QH3z/uGrj3MRkMNir987+rE5C5rpOV7I4=;
 b=GM94RGQG/x7JUPhsKV1v6M+RAa2C1krNy7FU8d9pp5/djF2qBo38ahD1PUCFxtscvdGPXWmsAcZQu2Z/CIxjGZ6cMG1gRExbKDOupdWA8sXWy5FFBvg+uhO2McQc3/+LILrvvDXznCVJnXXoXgkoPVDPwolZlYTXEEBKVXIumfRgd9Al7L3X7W+5GJKsR7eNCHmUef0HxE+Z8yStYtBGTBGfXElqYWwkquQH93AKV34MGSTkBbRw8rnqWBQ6IiqKMCifKGyLp8o3C1GkFKa/qj9fjw+Kp89kBdNz49dbfrl/inkEQsSsAl8qUD4HsKmKW8RjOFMO87rBD8ZCy1NyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA3kd2hbT/QH3z/uGrj3MRkMNir987+rE5C5rpOV7I4=;
 b=czS/kJlNxfwpZ/QKGJjx7I7s0QtZuztnCdqpjw55aKPtIde93nerDV7yiT9OfRQXYnrw5GL+WvHD+OMlKUkmibvyh7jl+qa/hmNpRt+GhHCLMgjsHfUqzUzXC+zmmTKLkOZWQCpgU+ekWs9R8eMe0GIjNVuOTK5QnuSTAUi0T/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 16:45:24 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd%7]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 16:45:24 +0000
Message-ID: <09b0768a-4534-420f-9774-50e250795dd7@amd.com>
Date: Thu, 15 Feb 2024 10:45:21 -0600
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v10 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>
Cc: andersson@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-remoteproc@vger.kernel.org,
 michal.simek@amd.com, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 ben.levinsky@amd.com, linux-kernel@vger.kernel.org,
 mathieu.poirier@linaro.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240213175450.3097308-1-tanmay.shah@amd.com>
 <20240213175450.3097308-3-tanmay.shah@amd.com>
 <170785205177.2155555.1311787541370066483.robh@kernel.org>
 <b931a24c-f676-4ddb-bb7c-e7a509d5dd4b@amd.com>
 <135e3154-2a55-40ac-9ba9-2de00833b903@linaro.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <135e3154-2a55-40ac-9ba9-2de00833b903@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0074.namprd04.prod.outlook.com
 (2603:10b6:806:121::19) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c20ad0-4609-47ac-4c6f-08dc2e45819b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0r0JEsIUCxVGNldJWq98SuaKV9CDnS+qL+6OcDe5BOaASO47qbLgmuHfBzjtwdcFwpBG2yYXXtDhtFwitGBOzmzDjHe63pJDpjf+B4p0Q5Yj/tCdR2snOqWQUvXvgsPx3xr+jlCTSDJo4uM8uk9iRGSPLiITz8bZaFeUOwyAn3ASkXpXZufyu0D28vInTNmTSRKvdWvIXzTgb0Exznl1FyCmcD2IDLMhHOpdFho1tIpq5oJ/CabYkCTmy1JmFxqsWgBkbtpsNgo5UWNf24e/8jZkCrMyHLkKo65rA8NIfNP0E2t7QNlZYpnYeEtrOOm6AAOdygjEXF6z1ll2QltUSWTnhrHQlhChBHEG4+9tDhNzr4SJVqhkcBTJypAuM9RTGb4jBsaG0FH92BapCI5Zm0UMRNP1pkVkxKVhDwSBT3i2tb4VEAmG0scxLa9DoqYYkGKgb3cYlWPuCft8Uk1GRggbJxzQkQJfyFtN538Gu4fenZ9Z7AYPWfE2tG2m07VSME5xl4K+nW+701lqGQ7KNIR3cI6ZTUlrf5/JCOpg/by3OiR/gdQL5o6MexeObKJH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230273577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66476007)(26005)(4326008)(41300700001)(83380400001)(2616005)(8676002)(8936002)(66556008)(6512007)(66946007)(53546011)(6506007)(110136005)(316002)(6486002)(6666004)(36756003)(38100700002)(966005)(86362001)(31696002)(478600001)(5660300002)(44832011)(2906002)(7416002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enBTc2pyb3dqcjVZL015MklvMHlFbDFrQTZjZmhDRlZtYmtSV1BLbUZPeXBq?=
 =?utf-8?B?clZ4bVh4NlVIcGQ4QU1XT0VaNXE5Z3p4OVFHRkpiK0FpM1dDZUQ3UDZ3b08v?=
 =?utf-8?B?Y3RtUlVhdE1aOENUZVBIREdUOEtUT0VGZnVVaWRNZVZGQlQxSFM5OVlHdytV?=
 =?utf-8?B?MEhRTWNWZDE1WFZoTWl2VGRNNUlJT3ZJNGE2VXJudW5NQmlJcDdVVThCbVNP?=
 =?utf-8?B?dlM3QWhka2VTbkI5ZHUyYnYrQ3RTY1ZDSUk4UE5GNEwyNTZueWF3Rm5yMk5i?=
 =?utf-8?B?dGJsd2tPNTlXdm9DTzIvZ2s1OUdFdGRUV2NFaHRWTEwwY21vdGlGR1BPeU5S?=
 =?utf-8?B?V054cEg1bVFsdy82QkowQlBpLy9VRHNkSlBHK1hyYWlIN2hqQ1NwRmRFUWIz?=
 =?utf-8?B?S1RubjhvRTcyazRFa2NmbmdZdDdXVmJOTWh2UU5EeWozOXNFYVBaRm5Ja01K?=
 =?utf-8?B?bkxUeU1waWgvQ1JzOVNUWStCZHRTVjJWTDdVaktzYWhjeGpiMXBNbThPVE4z?=
 =?utf-8?B?b0VpcXNoZ1hXRzBlSWlRM05jclRHSjlUazV6N3g5d1NSWHdPMVhtWEUyaGFu?=
 =?utf-8?B?RWhXWkZKNzRraFZGcWxUMk1pRitRREdNZTcybE9mOUlCbVRsa1Y0SVNBdkxZ?=
 =?utf-8?B?SDBwSGdxQkhlMUxORytDa0x3bkNhaG9nUSsyZkU5UHEwVXhpR0hoZHY2amxC?=
 =?utf-8?B?d0ZYQm5SaWN2NVVxdEQxaWg4cWlIZUZ6a3RrSlg2Y2wzbDUzbjNHS2ZjMjgv?=
 =?utf-8?B?OTR5b3ovbEhLMnppUUtsdDhtVEVGS3I3OWkyS3Z2U0xudXlrQU9sMERGNmVP?=
 =?utf-8?B?bDJtV1g0M3ZhSGdDb3IwbFI4RGdrSUY0eis4MVZlRi9JNGx2ZWgwWUQ0RW1w?=
 =?utf-8?B?bExRMmN2UTNkbHd2R21hQzZzVjkrMmZKNHZnNkc1Yy96ZUROQzRPZEJlcE1C?=
 =?utf-8?B?MGxDL3J2b2dJWXVrVnVkUTB1d2hyaHo3QjMrbitmN0MvcTMza0RTSmd1TEl3?=
 =?utf-8?B?dGFGbmw4Vm9ZSnlETmhlcXhZbFNtM2FEV3NnK05wSW9oU2x1WFhsU0NTYlFD?=
 =?utf-8?B?NzJqWlBrdFdrQWtnRjl4WENnUEFsNkNBekt4c0Q4SmtVcTJ2em81cTVNV2ZF?=
 =?utf-8?B?UHJzbVR5cWwzNHNBUGZraTBWcmVScUV3eVdob283czVnYktUSFJMNzV2YnNq?=
 =?utf-8?B?VEdiMmtDS09IU1JSR2dpeSsweU5ZWHNRY2llZERqVnNQWnd0K0NKYmcxN3kr?=
 =?utf-8?B?ZUwvb0ljTVhiMUhzMFNVOS9oTHVJRFNOVHBoNnJFTW5zZkVvMUlzV2UxUzRY?=
 =?utf-8?B?RldPL1JJSkozL25MR2FlN3RiaUpWVnl3VDVGaXBKcityM2l6RnpDNVMyNHEr?=
 =?utf-8?B?VGtTUnRoemxxbFcxeU81THR4MXJIc2xXQUtycHRQQnpqUkk2NHlSUlVrT0Yy?=
 =?utf-8?B?UkV6UTVHaHVCTmJPVm9QMHdZSUZURU5JZnpGemJYZWpreU10R0ZnOW5kaTNU?=
 =?utf-8?B?RFF5ZFFKL3RFNkNVaGJHYkRuOXptdUU3Wnk5eVhlRGp0bEk5OEh5aEJrS2pH?=
 =?utf-8?B?SEZMOHRqbWVxVDliRitoRHBNb0toYmYwY0VZeDZGVXpIZGFta0t3OFFEWm1C?=
 =?utf-8?B?VFQ5Ti9UWmZreWl0eUZCYWRVVVpoRXlSVkR0RGU4UU5KUndFbHRYZ2V2T2o0?=
 =?utf-8?B?TzBVRWxLcFVibVVQVjVZWVBUYnQzM081UWtNN2hWVXI1em91a3R3QUpERHR6?=
 =?utf-8?B?c1NSL0k2MDZGaDVGbVdEZ3hmZmtNZGoxWWFONDYvQ3VyL1NCMnJhbWVHZHlv?=
 =?utf-8?B?NHNlZjJLc3BTQThEaXQwNFVQcFp4NnV4WXBLS3BDS1lKQS9kY1JxNytFWkE1?=
 =?utf-8?B?WG5mRTcxV0lyQk0rTVdhMVlncGx6QTRDS04yZDQva2h0V0ErTmUzNHVWMVVF?=
 =?utf-8?B?aks4WlJkUUVCK2V3WFIvejg4YlQway85QlhtTlVHbzVjOXNpUXN5bmJhOXA2?=
 =?utf-8?B?OCt2dkF2OUM4MVNwWVlEKzAzUjNpc0pEZ2llQTBIQ0J3UFhMVWptN2ZuNFlB?=
 =?utf-8?B?YU4zNU5rSGhSeUV5T3Y5eFlMN0ZLUjJFQ0drUnRwQm9GMFFhRk5ZdS91RW9E?=
 =?utf-8?Q?3OT8If1lmzmFJ+SmokIbG+pen?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c20ad0-4609-47ac-4c6f-08dc2e45819b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 16:45:24.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22jkE02zne0OPnzasJNbD1zx8/wsUKmZErSrIBcD+3WiTn3rYbGE+z3sukmXxX3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870


On 2/15/24 3:06 AM, Krzysztof Kozlowski wrote:
> On 13/02/2024 21:37, Tanmay Shah wrote:
> > Hello,
> > 
> > Thanks for reviews please find my comments below.
> > 
> > On 2/13/24 1:20 PM, Rob Herring wrote:
> >> On Tue, 13 Feb 2024 09:54:48 -0800, Tanmay Shah wrote:
> >>> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> >>>
> >>> Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> >>> UltraScale+ platform. It will help in defining TCM in device-tree
> >>> and make it's access platform agnostic and data-driven.
> >>>
> >>> Tightly-coupled memories(TCMs) are low-latency memory that provides
> >>> predictable instruction execution and predictable data load/store
> >>> timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
> >>> banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
> >>>
> >>> The TCM resources(reg, reg-names and power-domain) are documented for
> >>> each TCM in the R5 node. The reg and reg-names are made as required
> >>> properties as we don't want to hardcode TCM addresses for future
> >>> platforms and for zu+ legacy implementation will ensure that the
> >>> old dts w/o reg/reg-names works and stable ABI is maintained.
> >>>
> >>> It also extends the examples for TCM split and lockstep modes.
> >>>
> >>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> >>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> >>> ---
> >>>
> >>> Changes in v10:
> >>>   - modify number of "reg", "reg-names" and "power-domains" entries
> >>>     based on cluster mode
> >>>   - Add extra optional atcm and btcm in "reg" property for lockstep mode
> >>>   - Add "reg-names" for extra optional atcm and btcm for lockstep mode
> >>>   - Drop previous Ack as bindings has new change
> >>>
> >>> Changes in v9:
> >>>   - None
> >>> Changes in v8:
> >>>   - None
> >>> Changes in v7:
> >>>   - None
> >>> Changes in v6:
> >>>   - None
> >>> Changes in v5:
> >>>   - None
> >>>
> >>> Changes in v4:
> >>>   - Use address-cells and size-cells value 2
> >>>   - Modify ranges property as per new value of address-cells
> >>>     and size-cells
> >>>   - Modify child node "reg" property accordingly
> >>>   - Remove previous ack for further review
> >>>
> >>> v4 link: https://lore.kernel.org/all/20230829181900.2561194-2-tanmay.shah@amd.com/
> >>>
> >>>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 192 ++++++++++++++++--
> >>>  1 file changed, 170 insertions(+), 22 deletions(-)
> >>>
> >>
> >> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >>
> >> yamllint warnings/errors:
> >> ./Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml:118:13: [warning] wrong indentation: expected 10 but found 12 (indentation)
> > Ack. I will fix this.
> > 
> > However, can I still get reviews on patch itself so if something else needs to be fixed I can fix in next revision as well.
>
> Sorry, I have too many patches to review to provide feedback on work
> which does not build/compile/test. First use automated tooling, like
> building a C code, to detect as many issues as possible then ask for
> reviewing. Not the other way around.

Ack. I will send new revision fixing the warning.

Thanks.


>
> Best regards,
> Krzysztof

