Return-Path: <linux-kernel+bounces-110206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E898C885B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F834285800
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3986270;
	Thu, 21 Mar 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O/ijQ9Gg"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39013A1DD;
	Thu, 21 Mar 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711034021; cv=fail; b=P8QlfjH5YuJEO0dAi3hDJVevi3AZZ7D6cD96+wXnk+jQowr6m8eXpJ8B97N06bIhF3j5p9bIGvXnaJw/RdVkEXJvf5vrTKSY/XIo6S0bddJxC+wqZgdJYhTb6uWOk1FPPUBpHvDhiPnXnVkakv+tNjxoPh81R9BWHjcLPhY7b6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711034021; c=relaxed/simple;
	bh=6XPa5FkWNi94AJNapeBtJqGdHYf/1/JfSkfCHq8yWH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eg34YjU8p9ffg8w2tX4toKoy6mYkAFT5ct9gp5chR5N0fD3FplNjZhNi5Ze6auMqaneFhbenGH/G6jJe0s4aAZNp1J8APk8Qxti5bAVaUT5ZLc3xbdonyAkOLWAPQVjlT8V0MWwXxbiigXGf7nig1YzZEDSx9s85Ko6aOlaYxVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O/ijQ9Gg; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROxjSMMxK/aTpRRZBIcvflh8s7U/zGqxjfPC3MRimH+fVPJJhalgzMWN/IfgE06iR5u/yDVGF5uD0wR6V9bd3HODYAOQTLlQcKt9o5q6r5AAzvIsk2CYDYU+q/zkikw6Q5wY9Imf6J/dip26vnIx5lrYDBaGB70dynyqi9axouk4TFcIrncVpErchDfxUrpZIFQVOOy/xWBuhc0um7lyJMALr31WorRgLLIusJgjiTpMLkUkVTiQ0Ci73lruIKHEuGgaNYG6j5MeTaubWE6+CbnocdIkrPLfOpNG2mW+lANM4LASOC/kTPGOd68jAkUf8fy4eZ/fUeqMVDILpyWuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHHaAJmFHIS9eU8xiuzXigRSe3jvtvDv/X8VKcSOwk0=;
 b=UsgfcjaHmxyffV8zbdoxzBy3SNiL4o8iUtAoAJJQyq47+83Xwi4ESDmsiCukh2Q1N0RHBvWsX1+ADO3C6Sz/jgjJqJN0UdTkezGhZXCyvBumF8FH/TpUt9lKiobwquIc/PD6dequLrhpX6MI3iGqJ5/hT6EPR6QKkhudWJ2ndyP2ESQkizLoga4P2/GMV+y/AZCEPmNLNaeu3jFEkef57qNwIfujBtQNQ4mMfUuEv2MeiZibIpM0GzPivptVIR44yz7LK3v6wtxuYrUB0rAk4aOedIOUK/gQoGp9DPrqrsoqWa+jpIIayaOIGX0Zi8t8S5EfhCCNUXvpMPuPDKUaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHHaAJmFHIS9eU8xiuzXigRSe3jvtvDv/X8VKcSOwk0=;
 b=O/ijQ9GgIOEjSWW9pyvQE5/UFkzZC+ga4Vsb20g0Lhht/FOkCCZGR5UVu9q42pydrDqPwAGzfH1oT25LRcBdjhMsIU3Yuxc7RvYRbebZQw/qKHT5d4NEi2ie9nr2mro4WOE4xR6gpzz7yjFtBOSEPg9gfQhf3iR4h70jmMth6bE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 15:13:36 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 15:13:35 +0000
Message-ID: <091c5ff9-dce9-4c63-a2ca-39d570e2f0a5@amd.com>
Date: Thu, 21 Mar 2024 10:13:33 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/3] dt-bindings: remoteproc: add Versal-NET platform
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 andersson@kernel.org, mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
 <20240315211533.1996543-3-tanmay.shah@amd.com>
 <3ca1c419-d185-4318-92ed-3c4e40dcf5bb@linaro.org>
 <14be0aa6-49b7-4342-9ca6-750c30c8e1e9@amd.com>
 <b1320ddf-bacb-41e3-9709-e90df18cc1e3@linaro.org>
 <d112481b-4331-4c0c-9775-407ac4a601fb@amd.com>
 <6f2ebe09-8ce5-4388-a01a-84ebc271472e@linaro.org>
 <72f3caa2-30ec-4191-9477-2d2a5e7f2f4b@amd.com>
 <5025fb10-3bcc-43b1-ae85-b556f1c0415f@linaro.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <5025fb10-3bcc-43b1-ae85-b556f1c0415f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:806:f2::7) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: d48d0144-d07b-4a1b-eae4-08dc49b97ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T8fe/oRIteynYdAxAB7Xf4NePcDBeeCSYZ5I0b4sF01BcusY7kKiOqy/obT3WQakZrISlsoFKs+g9CfgilSPhkWXjCnMypFKdzPerRgNGjYrA/PzlhP6t8vUL1Wl+zByVCV2Uwy+pZsZN0RTi3GdV0m1Y2Iw1Y1UORZJRyAS85wA0GBrDRt9UiWS/c9A0WlIduN+OORBp3NDPoNdfY/kOTK5KkOcLYu/CUftUHCpEGyb4jt88oXPFnXhTFwId9f1x4bTu5JclJboTBM8TywByoD8KUea7G3mODF/ihRo7Jh0DYA+pRlyByRkdPNyahbDQTCU4SWii0fQcTKB/6OxwJkchFeQ9H+9eM87gLDThUymd7ipR8qMX4VIi51TTSQz41R5p7FFVzZoLkVUVgwhz24UaWkHaNahX6E4cZhHQ4sIUih4jEkFfsLcYm3/HlGlplcUA77i7PY9d9UJ7yxSDMe/wd8gWEX/hOYTmHdo3HY+T3gnC3JpboZIdmyvMppcuJNHemXchQaPANljUn979wSsMrYi/W/YD6BBOKq2zzn7hWjDXNzhAZzlEn3VbeXwaTvPlmSBWM1OyxniNNoD1PgjoxHegg/sFVDuUcv6INbKazy852fQCscd+Puem1yHh0DvNAXXcJCAcQEVNmFGqTqgqHXXv6QNG87RjeCNGRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVRyZ05hYWR2THMzcWpsUXhWM1RhUXQyUnVKZVp2R3FQWkRkdlBaYjR4Nmg2?=
 =?utf-8?B?T2JXYmZ0OFI5aWJ5ZUFxajJtL2k3MDNxM0pCTGdZQjBRSVRRY0JwaXhCR2V6?=
 =?utf-8?B?TzNMRCt6eDZzQ0NkZmRWd0pmNjhqQnMyVEgwd3pOZ0pHYUtNQlM4RWxkejRL?=
 =?utf-8?B?NWN0bVB6RUp3ZW5vZmQ0ekNVR2FEbE1jaS9ISWt6djVvalJuMjVCUTdiRGVu?=
 =?utf-8?B?T0lsRTBtRElvSnpJWUM5cDhoajJ2cFg0NDRPZFhibFNkOTZSUkdMV0k2c1pt?=
 =?utf-8?B?eDJHOFJrWWkwSFlnQWt4dkJOd0tzdXR4cWlSSGpkWkxUUUN4OWtoL3h3VXJP?=
 =?utf-8?B?T3dEOFNMK1hSc0tmM0xiWHlRYnVna1VTVFRxSTRlUkIrWVZacVorREd3NEdx?=
 =?utf-8?B?QlRJK29KL1R0d20vSlI3clRNdEdOK0pzT0t5TzYyWUxmS0hTbi9Yd3N0V1Zr?=
 =?utf-8?B?T0FLOEY5b3p5dVBaQ1o5Wk80eDJtK1FMNnM0OEZaL0pDRWNwTHdwRWE4VGZr?=
 =?utf-8?B?WldJQ0d5eGtxWjM4UTVERXhIZm9qaTZ3LzFKdG9DTSsyT25kWWZ3QXNmbWw4?=
 =?utf-8?B?ZkNHQTF1Q21VSVo4c09jVTA4VTZ4TEplK1lGV1dzTDNrRlo2aVZCMit5SmdE?=
 =?utf-8?B?L0FVWUxpK1h1aVdQVjY5eWEyaEZlTUg5MTUvTGF4eENOSVhrcWs1dGp3emF6?=
 =?utf-8?B?UUVodUxDL1VERmE1K1kxTldCOFRNL2tqU2w1OUZ1bUZ1bU11cFBXa2ZSZmRw?=
 =?utf-8?B?WHRXV05vbVRKMnNQMVBvUHBDWkZrY002eUIveDRJRlRBczYwaHJnZFZFRWFY?=
 =?utf-8?B?eTJLM2wyQXVRSlRLbmZjb1g2Y3ltZmZvY0RsNkpqaHZwYzNKMFJLdy9IMlNy?=
 =?utf-8?B?SlBTVnlqcHlITmpDelh5Sk1NaklzRjljSTFYZ0NwcE11TlVzNUFnbnBubWRP?=
 =?utf-8?B?SU5nbGc2dVZ1UEhxbmdGL1MxWnp1OUtTTzJtbExDWW56NEpDaE45T2lWZEZt?=
 =?utf-8?B?bzRWUFF3aXFSTHpIQ1JkNXNLS1RVb2JGNm4zUDBPRm54aFlGRXp4Ukg2VUIr?=
 =?utf-8?B?N0NkN09QVTB5NnJ5SmcwSXJuRVJES0lqcVI4S0ZnZUxqZlduaUdoVklnWUlO?=
 =?utf-8?B?elpoY0dJR3ZYM05pL21EbERJSTlHT0N0dWxZMWJwdjhzWkRtc1JmWnI3MHUy?=
 =?utf-8?B?RGV0MkovaGlKQ05zOXFGdEVwZ1lZNHN1Y1NqR084YmI2ZmhJVWFHMk45ZW5V?=
 =?utf-8?B?Q1pKb21YSy9hMHA2cTRYNmM0cGxNUVdGWGhRU1NSMXRLdENkVmtoY1JvUVgr?=
 =?utf-8?B?cFNNNDJnbm8xQjI3N2tteFBEeGdwc0dpOVQxVUVvOCtQWGpyNEEyNno3Z1Z4?=
 =?utf-8?B?NUJ1eU9OaDJheGZMWkhleG9HbTkxMnF1dm5YU2tEYVpGekliQzVWZFRPbVNI?=
 =?utf-8?B?K1VVRy90cFI1QkNFUEZPcEE0WEZIMDBEVy95WFpMNHFvbURJVlNJOEJ3VEtY?=
 =?utf-8?B?SXlndUd4M1BIYytvcTZNRlBtSmdhNDNDOGVUSyt5VFBDK0dYYnJyNVBaQzdm?=
 =?utf-8?B?SDlhN2tJL09xNnpMRTJndnRGWDkxclh6UHpuRWtBTHR1N1lqZVZJQnErUHRG?=
 =?utf-8?B?VVNRRyt4QWlrZVF4ckJOOXhZL3FjSUpFYkg5V1hGekxpaFpENW5ublpmbVdl?=
 =?utf-8?B?WDU2VTNKMFF3ZFhUNDlWMzNnNDBVNmpPL25KNGhKcVZhTkgrM0ZteEtqeTJF?=
 =?utf-8?B?cjc1YWhJMFE3NVVIcnhNOEMrcjZ1UXIyckRjT1JIZitnL1NQV1RaemhQR2R1?=
 =?utf-8?B?cHV4ZWpBalViakhRcnpKWCtCZTJ5Q3JHRjZxNWorbzA3VkZ6cWlRbG14Y2M0?=
 =?utf-8?B?SEp2SHBvdEpmRHo3bEdobEFOcFpiWCtKOUR4RFBNYm9JOW1nUWdKa1VDbGJw?=
 =?utf-8?B?aVp1Q3NrM3h1eTFNZ05kbDhMOHBncTZ6dlJsNFowbnByS0xETVBZeVFPZHB6?=
 =?utf-8?B?K0hJd3I0YXcreC9JZktGK0ZVbS9rQ1V5QTZLWER6TDdLbm5LOWROK1Y0OURO?=
 =?utf-8?B?NW1ZUFBaTWc1MkVQMFNZL0o1c2JpVDkzM2JHM3Q2WjlSMld3WFNtRm1ZNGRZ?=
 =?utf-8?Q?4xa7iTdy3FHxMsHpNjj9p5slh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48d0144-d07b-4a1b-eae4-08dc49b97ac7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 15:13:35.9192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd0oyZUacA93rTvlB/9+s00jFRfoWHQ6u2Q0XFR5IJ2NHk9v2ppCICqf3sNGVee+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918



On 3/21/24 2:39 AM, Krzysztof Kozlowski wrote:
> On 20/03/2024 16:14, Tanmay Shah wrote:
>> 
>> 
>> On 3/20/24 2:40 AM, Krzysztof Kozlowski wrote:
>>> On 19/03/2024 15:42, Tanmay Shah wrote:
>>>>
>>>>
>>>> On 3/19/24 12:30 AM, Krzysztof Kozlowski wrote:
>>>>> On 19/03/2024 01:51, Tanmay Shah wrote:
>>>>>> Hello Krzysztof,
>>>>>>
>>>>>> Thanks for reviews. Please find my comments below.
>>>>>>
>>>>>> On 3/17/24 1:53 PM, Krzysztof Kozlowski wrote:
>>>>>>> On 15/03/2024 22:15, Tanmay Shah wrote:
>>>>>>>> AMD-Xilinx Versal-NET platform is successor of Versal platform. It
>>>>>>>> contains multiple clusters of cortex-R52 real-time processing units.
>>>>>>>> Each cluster contains two cores of cortex-R52 processors. Each cluster
>>>>>>>> can be configured in lockstep mode or split mode.
>>>>>>>>
>>>>>>>> Each R52 core is assigned 128KB of TCM memory. ATCM memory is 64KB, BTCM
>>>>>>>> and CTCM memoreis are 32KB each. Each TCM memory has its own dedicated
>>>>>>>> power-domain that needs to be requested before using it.
>>>>>>>>
>>>>>>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>>>>>>> ---
>>>>>>>>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 220 +++++++++++++++---
>>>>>>>>  1 file changed, 184 insertions(+), 36 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>>>>>>> index 711da0272250..55654ee02eef 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>>>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>>>>>>> @@ -18,7 +18,9 @@ description: |
>>>>>>>>  
>>>>>>>>  properties:
>>>>>>>>    compatible:
>>>>>>>> -    const: xlnx,zynqmp-r5fss
>>>>>>>> +    enum:
>>>>>>>> +      - xlnx,zynqmp-r5fss
>>>>>>>> +      - xlnx,versal-net-r52fss
>>>>>>>>  
>>>>>>>>    "#address-cells":
>>>>>>>>      const: 2
>>>>>>>> @@ -64,7 +66,9 @@ patternProperties:
>>>>>>>>  
>>>>>>>>      properties:
>>>>>>>>        compatible:
>>>>>>>> -        const: xlnx,zynqmp-r5f
>>>>>>>> +        enum:
>>>>>>>> +          - xlnx,zynqmp-r5f
>>>>>>>> +          - xlnx,versal-net-r52f
>>>>>>>>  
>>>>>>>>        reg:
>>>>>>>>          minItems: 1
>>>>>>>> @@ -135,9 +139,11 @@ required:
>>>>>>>>  allOf:
>>>>>>>>    - if:
>>>>>>>>        properties:
>>>>>>>> -        xlnx,cluster-mode:
>>>>>>>> -          enum:
>>>>>>>> -            - 1
>>>>>>>> +        compatible:
>>>>>>>> +          contains:
>>>>>>>> +            enum:
>>>>>>>> +              - xlnx,versal-net-r52fss
>>>>>>>
>>>>>>> Why do you touch these lines?
>>>>>>>
>>>>>>>> +
>>>>>>>>      then:
>>>>>>>>        patternProperties:
>>>>>>>>          "^r5f@[0-9a-f]+$":
>>>>>>>> @@ -149,16 +155,14 @@ allOf:
>>>>>>>>                items:
>>>>>>>>                  - description: ATCM internal memory
>>>>>>>>                  - description: BTCM internal memory
>>>>>>>> -                - description: extra ATCM memory in lockstep mode
>>>>>>>> -                - description: extra BTCM memory in lockstep mode
>>>>>>>> +                - description: CTCM internal memory
>>>>>>>>  
>>>>>>>>              reg-names:
>>>>>>>>                minItems: 1
>>>>>>>>                items:
>>>>>>>> -                - const: atcm0
>>>>>>>> -                - const: btcm0
>>>>>>>> -                - const: atcm1
>>>>>>>> -                - const: btcm1
>>>>>>>> +                - const: atcm
>>>>>>>> +                - const: btcm
>>>>>>>> +                - const: ctcm
>>>>>>>>  
>>>>>>>>              power-domains:
>>>>>>>>                minItems: 2
>>>>>>>> @@ -166,33 +170,70 @@ allOf:
>>>>>>>>                  - description: RPU core power domain
>>>>>>>>                  - description: ATCM power domain
>>>>>>>>                  - description: BTCM power domain
>>>>>>>> -                - description: second ATCM power domain
>>>>>>>> -                - description: second BTCM power domain
>>>>>>>> +                - description: CTCM power domain
>>>>>>>>  
>>>>>>>>      else:
>>>>>>>> -      patternProperties:
>>>>>>>> -        "^r5f@[0-9a-f]+$":
>>>>>>>> -          type: object
>>>>>>>> -
>>>>>>>> -          properties:
>>>>>>>> -            reg:
>>>>>>>> -              minItems: 1
>>>>>>>> -              items:
>>>>>>>> -                - description: ATCM internal memory
>>>>>>>> -                - description: BTCM internal memory
>>>>>>>> -
>>>>>>>> -            reg-names:
>>>>>>>> -              minItems: 1
>>>>>>>> -              items:
>>>>>>>> -                - const: atcm0
>>>>>>>> -                - const: btcm0
>>>>>>>> -
>>>>>>>> -            power-domains:
>>>>>>>> -              minItems: 2
>>>>>>>> -              items:
>>>>>>>> -                - description: RPU core power domain
>>>>>>>> -                - description: ATCM power domain
>>>>>>>> -                - description: BTCM power domain
>>>>>>>> +      allOf:
>>>>>>>> +        - if:
>>>>>>>> +            properties:
>>>>>>>> +              xlnx,cluster-mode:
>>>>>>>> +                enum:
>>>>>>>> +                  - 1
>>>>>>>
>>>>>>> Whatever you did here, is not really readable. You have now multiple
>>>>>>> if:then:if:then embedded.
>>>>>>
>>>>>> For ZynqMP platform, TCM can be configured differently in lockstep mode
>>>>>> and split mode.
>>>>>>
>>>>>> For Versal-NET no such configuration is available, but new CTCM memory
>>>>>> is added.
>>>>>>
>>>>>> So, I am trying to achieve following representation of TCM for both:
>>>>>>
>>>>>> if: versal-net compatible
>>>>>> then:
>>>>>>   ATCM - 64KB
>>>>>>   BTCM - 32KB
>>>>>>   CTCM - 32KB
>>>>>>
>>>>>> else: (ZynqMP compatible)
>>>>>>   if:
>>>>>>     xlnx,cluster-mode (lockstep mode)
>>>>>>   then:
>>>>>>     ATCM0 - 64KB
>>>>>>     BTCM0 - 64KB
>>>>>>     ATCM1 - 64KB
>>>>>>     BTCM1 - 64KB
>>>>>>   else: (split mode)
>>>>>>     ATCM0 - 64KB
>>>>>>     BTCM0 - 64KB
>>>>>>
>>>>>>
>>>>>> If bindings are getting complicated, does it make sense to introduce
>>>>>> new file for Versal-NET bindings? Let me know how you would like me
>>>>>> to proceed.
>>>>>
>>>>> All this is broken in your previous patchset, but now we nicely see.
>>>>>
>>>>> No, this does not work like this. You do not have entirely different
>>>>> programming models in one device, don't you?
>>>>>
>>>>
>>>> I don't understand what do you mean? Programming model is same. Only number
>>>> of TCMs are changing based on configuration and platform. I can certainly
>>>> list different compatible for different platforms as requested. But other than
>>>> that not sure what needs to be fixed.
>>>
>>> You cannot have same programming model with different memory mappings.
>>> Anyway, please follow writing bindings rules: all of your different
>>> devices must have dedicated compatible. I really though we talked about
>>> two IPs on same SoC...
>> 
>> I agree that Versal compatible should be added, I will do that in next revision.
>> 
>> For ZynqMP case, it is two IPs on same SOC. In lockstep mode and split mode,
>> same SOC is configuring TCM differently.
>> 
>> How this should be resolved for Versal-NET ? Driver avoids such TCM configuration
>> for Versal-NET.
> 
> Binding should describe the hardware, not what driver is doing
> currently, so the question is: does your device have such properties or
> not? Anyway, you need compatible per each variant and each SoC
> implementation.

Thanks for reviews.

Okay in that case I believe I should add one more property to current bindings for TCM
configuration.

From our discussion I conclude to following next steps:

1) I will send Versal and Versal-NET support as part of previous series (v14) so we get
bigger picture in the first place.

2) Add separate compatible for versal platform.
Use device compatible string to maintain
backward compatibility and not machine (root node) compatible string.

3) Add tcm,mode property in bindings and each device must configure TCM based on that
property only and not based on compatible string.

4) Versal-NET will disallow tcm,mode property in bindings as no such configuration is
possible for that platform.

I hope I got everything. I will test and send v14 of previous series accordingly.

Tanmay

> 
> Best regards,
> Krzysztof
> 


