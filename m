Return-Path: <linux-kernel+bounces-46108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08B843A72
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300A61C2858F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70256773B;
	Wed, 31 Jan 2024 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1FwP3b2L"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16136340C;
	Wed, 31 Jan 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692172; cv=fail; b=q469oPY5cqfrjUhrlfDpP7lQ72YT9TFjseZIFoqQnApYnRhN4DfcinIDpRNM8YUsuxThlV7lNp53baTheC3wWDcFU51ghcZ1zlnpvvdz7yGCrdnWJfPsRf4tm4ZLlE1INJnD4SKu5Pn6IturjCD5/kttpI0eqgnwOMZdDLNaeZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692172; c=relaxed/simple;
	bh=TRqFEaL4lrynw/YHaxphhMkz0JhpOTUNpu9Wgmk/vCg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+kxtzEWl843s1ejCwmMMG4mQ5w7aZBGXSWe3Fnxvc+QExKiEE1iu8byQEVug2HB3w9hH8wFzqGCJKaQV0QoRtOocM7bF4DBN738pZbIv52UOBsyyAW92jodQSoAuWa7P70zcH7xKGb9wqZsgOey8XjbzL8zTMfgc/qpe1tjUno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1FwP3b2L; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkLbZZNq/PeSva9+yM0EQe7ych5zOIJO85cYlXqXA4sxYYtms5U78kJWbNZBnUlbycOKlERoHHgNViobJ+lf2vHDqSw+68o4a3OR5+vKxPAC2lm7ABtkiYVLI9Wd3RqVL5iFn+OqvIa1kpb6xiziSAP1kqxBT1kMf7dfKlzmQu+Oz2eF/wobai07dmMNGhLgu3Uet9xP4OUpzupbPUVru7D7BDu5brlj2d4g1WkC64JZ+0uv8OoTt46IvCoBCNRi2oHCP/oWM63c1HpEUbxdzCfV7EV7E3YbXtpCxMC8oedD+eW7WKsAhgLpaBvDoWSWY2TuwEj6WurXb/38KuzTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0NwDkIoRj6fDBOYzQquQ9+afoYU/ONJ5jQKpx1eZgk=;
 b=iEQn8lG4Dzhck4BKwXWM5tW6yhLQXxi4OQDjeMny0nzJTdNf7drGA5mp1NH12wdlu32FyakFrW7A8Q6AASbaKQNjoHGx+VcWCVNFM9N+jfhHnwsyGARtl/4KHCAYlaTa+TD9qYodafhuX172MRW+ZG/0i/q3jb9rUsqWZCSrCjwf20a9Y9oOCqXYynfbI14jMLCuEo5Hc4nIQvz/XbbYGGxGXPoEHr3+UR65gVlhjBPpsHEsNUNmh+Y9ErIqDNEUvZgnOB98lThUHBj+aTBVLWxJon+wfU5977PB8AgwZZjydqIX4mQ7suTDf31B4GbE3LrnZIDmdoJA9yetZVV5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0NwDkIoRj6fDBOYzQquQ9+afoYU/ONJ5jQKpx1eZgk=;
 b=1FwP3b2LyYWAUohrtRTc7WTw7kGwQdo6S5I/zR5cgODPg6ZaPFBCXX4zEnNc5OC2cGR/Le2crXbUstCCOsoBQD71dXW1bDiep/T9WxZFmB3xVcmKUi88FBlNznP62VZhO5ztEnZJSwZsw/lBhxtHSLa+BXRF8YGo03eaO2uK+/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 09:09:29 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 09:09:29 +0000
Message-ID: <537eb07a-07e8-4af2-ad83-058e010f892c@amd.com>
Date: Wed, 31 Jan 2024 10:09:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: soc: xilinx: Add support for K26 rev2
 SOMs
Content-Language: en-US
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <90e1a393154c3d87e8ee7dc9eef07fc937c1eaf7.1706019397.git.michal.simek@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <90e1a393154c3d87e8ee7dc9eef07fc937c1eaf7.1706019397.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0101.eurprd04.prod.outlook.com
 (2603:10a6:803:64::36) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 9092b9aa-56f6-4668-cc65-08dc223c544e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EjHp3i5LVcI8uQyh3b8F5dP6lUhKtkXzWw/AEciE38o3FPRciD3XbemHx72/ukyn0umVbutz/5wlV/bwYBbfQnjrsPxwUgGKWQRsrUq0eqByR9FQqc1FswScvTgE5r3spGItdkDl1DKVdeEjYFV7Rc4n7SI+l3daQZaizjm0wN5LuOD6faN6eVCdODL0DCVLW8KMLJWJkL1ky0K5dOWvy+tyK9LqdzbkcdYVu5PJQfPu4Y6fNDLQua/D9TRuawBrssXT1G8dA6UWJO5/rqfwKODgMa8m0dQ/X3nNoh8m+Xnp4DISmkUcCaPeomx+f+slTk2ZgoGuHofknQtsJupHkJaABJbAITHGDbgjmPh4pADItBHj4TSO/IUjc2dmrwpw6NMGQ1gAK0pYwXpaNQfWMjlDb+4oFXi/mc0KEYLP+lnXDlTXCh1s6a/MKQT5wNF0kBGD8Eh8Pk77s+hnBXUiZoLAvaPJyThfQbIcD/2uvLMS0ssE/k9P23C9WcV/GWi3Oy5SQ4FI1OV7PpUI14gWkR1JfnydHNtTgfgrR9fY3/0SF2CoNtneB8vxoWBDI5nqSDlF2i97K6SrrxnVfBi/DVaY8kY/8Cmo3qsvVOYrkKDvaEwK5FahSgLaON/H/DTNWkUPINc5VTqq+GGja1drbA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(2616005)(41300700001)(31686004)(316002)(36756003)(6512007)(478600001)(53546011)(6506007)(83380400001)(6666004)(6486002)(38100700002)(54906003)(5660300002)(31696002)(86362001)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(2906002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3kydTRIOGF0ZmxTOG1WV05qaWpQMC90bXpldkN0RFozKyt5Vzh4SGUyd2c1?=
 =?utf-8?B?OFdEcmJPNUNvZUlEUGZjcFA0K2R4SllrNTJNM0RYalkzbW5aaG9QYTduOVY3?=
 =?utf-8?B?K0xTTkxaZlZXTFowZG5xRUlsYjEyRm5XazVSMmYwNTN5RGJMSDYya2dUc3Ev?=
 =?utf-8?B?L3draFdLdkNPbFc4emZacUhORFhsaXk3NDd2WjJmclJRTWpJYzlVTHBUM1V0?=
 =?utf-8?B?WnEwSnZVbGNBc0MrZGFvWEJsMm02d2MzYml2SXlIbktYU3hSSGZlU1hxSkxG?=
 =?utf-8?B?WXNRaWNQZnFtLzJhRER3azVGUWN3aHM3RFBnNVEwNnhhZS9qMFp0Z3I4R2dL?=
 =?utf-8?B?R1A5Ukxmemx0eE4xMExQM294bHlSR1ZxNGVqQXhCQkZXaDlZRUl5RmlpS1Yy?=
 =?utf-8?B?TEJTTks2QUFMR0JKL3crR3pNNEZXbk9PVGFIbGdQL3p1YXhaMk96RWswd2ZH?=
 =?utf-8?B?ZWVWRlpBUHc1WDFuQ3hndURFaXRkSFZoVGNBNmI0ZGd4bkFkcS9aNEdkVXV4?=
 =?utf-8?B?Vi80USsrVk1BQ3JHVDBlblQ3L2xsSXhZRGo2OFg4SUROc1V3aE90dmRGWUJN?=
 =?utf-8?B?L2UxUmVXSVN5THlseFlteFAvK1JpeVdTRU55OFFPd3g0akF5dVRpZWF6Nkxk?=
 =?utf-8?B?T0NTa2Y2eXcrMDRaY1NrNUVSVnFnOTZmc1lJMGt3Q3E0YjRxZlo2MmpzelVO?=
 =?utf-8?B?Ty9WS21jbkwzdndYalBhSXE1ekQ0VFJZcDlLOUVLZDlYM1czd1djd1F0V3hp?=
 =?utf-8?B?TmRvdDEyL2VSYzhxbkJ0SnJpcGRzVWEzZzgrZHVqK0xaZzQzMXdqVE1aaWZP?=
 =?utf-8?B?WmhzR3Rod1FHSFlWMGE2OXJMSllMQ0hET1E2MVNodmp3c0crU1F1RTJ5NFdI?=
 =?utf-8?B?QXFuMzA5WE9jYWw3L1hqd2FiRUNnQUw1ZmpNakI3ZXlPR3VaZmN4eUJBOS8v?=
 =?utf-8?B?UlphOUd5QWg4LzI3d0dHNVZiT0QwYjZBMXh6RnhyZTc3NjBqamJjTGNWbmpu?=
 =?utf-8?B?L2xud0ZKR3ZyM3R3SXhqQTB3dG1PZG9ZTUpYL3ZXQi9tOUNzU3VTUFgrdTds?=
 =?utf-8?B?NHA3UXVsWk9MRDJjQmFZbGYraGFZUmFxREZrZlpsS0VlTm5UUTJkaVdLYjBH?=
 =?utf-8?B?ZkdhbVN6eVhRbG5NVG9IbmRxdjNrWEJmVVowK3ROdkRMN3E3NmZZT1E5YTQy?=
 =?utf-8?B?cUZMdURoU09ZNit4TFZzbHhObGtZZ2tUek9UcXdsdldHQUpCcE1mS0gwQTkx?=
 =?utf-8?B?VkNqM0ExOVFSZnVSRlFsMG1hZ3lqUVNXVWRJcStiRXErUC9PN1J1TWJLdVFw?=
 =?utf-8?B?K3FRbFFJaGNpOFJJVkZtcGk0T0liNTRpTTdVYytDdFM5RDU2WnZOTFpVaDdJ?=
 =?utf-8?B?TkNVT1E5MlZYbDFNUGFpRUpycy9CSncrR0tNVWtlUThNd1lYTXlucC8yREkw?=
 =?utf-8?B?dGU5TEkrbFBXTE03V1pOVytKbHBoeTJzNW5xcWZRTTBTQ2pqOG9KSi9PR1pq?=
 =?utf-8?B?blQwRUF4MXpmUEVSWEVkS2FlYzFzN0tSUVlJbzBVWElyYmR5UlBmd2FmVDhI?=
 =?utf-8?B?c0MzUysyWDloYVpJU1R4RnhsOXRYS25WZCtYRWRDVndvckpBY2JvMXVYZk44?=
 =?utf-8?B?cXRsQytCUFU1N1plUTE4SkRNd1lvVkFQcDVKSWdFcHR4dER2TFVHS09zYUFj?=
 =?utf-8?B?SXNxVko1UThuTGc2OTlYd2V2Y3Ezb3ZiV2lxUWd6T3VWYWoxMHJvcittM0di?=
 =?utf-8?B?bit6K3pDTm9GZUd1SnNrdmltZUY3YzhOQXJUN2YybkxWYmFVWVFvcTAxUGRq?=
 =?utf-8?B?V0x2OHhIQVBoTlMzeTBvckFsWE9ZNS9tRzJzWTZ5SXJNNFN1NWcxQmpGUURM?=
 =?utf-8?B?bTBhWER5UWJyQXhIaTFETEZ2c0dkSmZCUlVWTzZDZUpjVG8zK3hSUGhuQzRX?=
 =?utf-8?B?Sm5zRVBmNE52eS9vbnV3YnlmbWxseFgreWk4ZTMwa0FkdFFOSjFoQS9udzJH?=
 =?utf-8?B?SW5jR3dOM3V0RkhjTE9reVd2Z0tBL0wvMWRwb3h5MnFRUHpyUyttSlh6MUg2?=
 =?utf-8?B?aTkxVVBNZXBpRDFCblFwbWlxbm5SR1RqK2hkYk95S0hzZmtKSFRubVJOOG10?=
 =?utf-8?Q?UxzAmN9BXDHmGrMPRpsJ2wiO4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9092b9aa-56f6-4668-cc65-08dc223c544e
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:09:28.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LG6fv5KmJyMRxqKulBvirfgGksdBxIfMGMK/jl79GLIzdpyJZklOoGqu2eWo9Jt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258



On 1/23/24 15:16, Michal Simek wrote:
> Revision 2 is SW compatible with revision 1 but it is necessary to reflect
> it in model and compatible properties which are parsed by user space.
> Rev 2 has improved a power on boot reset and MIO34 shutdown glich
> improvement done via an additional filter in the GreenPak chip.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v3:
> - use allOf contains structure to avoid random chars caused by
>    additionalItems: true
> 
> Changes in v2:
> - Support older combinations
> 
> I want to support all versions we created:
> All of them:
> -rev2, -rev1, -revB, -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> 
> rev1:
> -rev1, -revB, -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> 
> revB:
> -revB, -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> 
> revA:
> -revA, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> 
> And also single one are permitted:
> -revB, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> -rev1, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> -rev2, "xlnx,zynqmp-smk-k26", "xlnx,zynqmp"
> 
> I didn't find a way to pretty much all the time force that there must be
> both "xlnx,zynqmp-smk-k26", "xlnx,zynqmp" that's why there is only
> requested to have xlnx,zynqmp. If you find a way how to encode it please
> let me know.
> 
> ---
>   .../bindings/soc/xilinx/xilinx.yaml           | 36 +++++++++++++------
>   1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> index d4c0fe1fe435..7c75dbb4f307 100644
> --- a/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> +++ b/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
> @@ -117,20 +117,36 @@ properties:
>             - const: xlnx,zynqmp
>   
>         - description: Xilinx Kria SOMs
> +        minItems: 3
>           items:
> -          - const: xlnx,zynqmp-sm-k26-rev1
> -          - const: xlnx,zynqmp-sm-k26-revB
> -          - const: xlnx,zynqmp-sm-k26-revA
> -          - const: xlnx,zynqmp-sm-k26
> -          - const: xlnx,zynqmp
> +          enum:
> +            - xlnx,zynqmp-sm-k26-rev2
> +            - xlnx,zynqmp-sm-k26-rev1
> +            - xlnx,zynqmp-sm-k26-revB
> +            - xlnx,zynqmp-sm-k26-revA
> +            - xlnx,zynqmp-sm-k26
> +            - xlnx,zynqmp
> +        allOf:
> +          - contains:
> +              const: xlnx,zynqmp
> +          - contains:
> +              const: xlnx,zynqmp-sm-k26
>   
>         - description: Xilinx Kria SOMs (starter)
> +        minItems: 3
>           items:
> -          - const: xlnx,zynqmp-smk-k26-rev1
> -          - const: xlnx,zynqmp-smk-k26-revB
> -          - const: xlnx,zynqmp-smk-k26-revA
> -          - const: xlnx,zynqmp-smk-k26
> -          - const: xlnx,zynqmp
> +          enum:
> +            - xlnx,zynqmp-smk-k26-rev2
> +            - xlnx,zynqmp-smk-k26-rev1
> +            - xlnx,zynqmp-smk-k26-revB
> +            - xlnx,zynqmp-smk-k26-revA
> +            - xlnx,zynqmp-smk-k26
> +            - xlnx,zynqmp
> +        allOf:
> +          - contains:
> +              const: xlnx,zynqmp
> +          - contains:
> +              const: xlnx,zynqmp-smk-k26
>   
>         - description: AMD MicroBlaze V (QEMU)
>           items:


Applied.
M

