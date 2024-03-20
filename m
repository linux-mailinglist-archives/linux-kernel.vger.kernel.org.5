Return-Path: <linux-kernel+bounces-109072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8EF88144D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58A32820F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EE150249;
	Wed, 20 Mar 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z5MZPBT7"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657E4D9E4;
	Wed, 20 Mar 2024 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947657; cv=fail; b=R2cq3BL1yq1L8fDOC0QltmC38+1z/q/rSwXcO4jnraSErZjr95bLaCUSHdRBYWRsIVyBjkHRZI7XiZA8EvSYbArvF3M5Z8R6MeInWim/CPcTr6LfLrlbd6QpYR03bgdoEs9Z8JlEydPnJDyfJ4yJqdpxIwkstuM67JW7jyp1pTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947657; c=relaxed/simple;
	bh=SzMmzxDlG9qUJAxcfHgAIwaQvWBtFQA0MGiTF25OlBA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mk7Irrt5LddGm7u4inHAiHlMirm3dlxaa3XxUQjX1Ot202+XiBx9hmVbmKIeUIX89OKYIGhuQ/lBIiuSV6kMKeGGoGqO94648fxfJW0yI+I6HhYURDe6X0XNTC1stV8Rcp1PtLHpVRG7B4rEBT3AhQ+njmF3LPOZCIxMafnbL/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z5MZPBT7; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmlzivXs+nvzhGgXs9b08M/eq47cuv3M4j1ULqYHkCDZO6yFOBkRGOYYl9MY5iDWZDvqxoJAto1wXY4+0BAyczO+o7tM/0tEe2Jh9x0THla6bg8hCdXjJjJZWm/XLtVCpHnnwhiQYhcaTViADyNgSY6qC5XsElExifHgb9MR1mPvyP9LSX6fsNqKo25u0RCHryPMEB0pDbGBk9x6e6HNCfOMcYDnBbIP5LEDLtqEqWJLz4jdwLL5GcFNdxQSr2a/9+iZBtSqWJzKxjnpa+hN+CEC9jZpuNWVOci+HSR+nlrsou5ntNm9WLGHVcm/zzJwcx4Le4QFT9lQW0AaF5ZwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1q0rM4eiWMSQcZLoXqMGmNVwfPEn3JG7EmzH0R0nus=;
 b=a3AhXlXGtIQzPvM1sWv+PzSdPW6BVwuiTnMcPKd9+yPfq1dkREgmGOrlf1qmrIHHjQREQIMvbgSTJ0nVbt1FkCKCRvevhK/iIbAssNV7d+80b3m32kqPSNnR8UyJfyIBXfrgVhB+G5v4VZ9J6T/Xn9Ukx/BuVibuGhTEutpgQUv5yZFRWEZLEKT4TKbd9YFBo6NmdXnEQhXcG62s9z7E0ZXpQyNkirwP/PMd24D7A2Q3EWJkyrN8W8Xlz2Zfj7fum259TNFNPWQGIso2qzswmHIM7PHkIgBpuZ2dCFJi7Aur54O6Zoo+l2NJOOZLR0pdDvuERTs7JFJwnCeBCnxMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1q0rM4eiWMSQcZLoXqMGmNVwfPEn3JG7EmzH0R0nus=;
 b=z5MZPBT7s5Mk9CP5Rw6o55lE7RClvlElV/5hSbtZLKnGzvZcDMoqQuH/aPTxMfRo3pLh7YIL7t121nMLbjmt3I5WThaSMVagpCm1LiDecP5AZ1K5I64XUAI7m5kM+U8kwNfUVnFtfvWozUUFVcCvUL01tXm191YoV9mRCcmyP+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 20 Mar
 2024 15:14:12 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 15:14:12 +0000
Message-ID: <72f3caa2-30ec-4191-9477-2d2a5e7f2f4b@amd.com>
Date: Wed, 20 Mar 2024 10:14:08 -0500
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
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <6f2ebe09-8ce5-4388-a01a-84ebc271472e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0144.namprd11.prod.outlook.com
 (2603:10b6:806:131::29) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e23ba6-e43b-45e6-1c83-08dc48f06609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4ENLHERMy9P2xQNGhflJD78CsCyoFfLMY4sG2kkDFEwOwp73QooiNPithWaL0386GRWdFfLs2xprH7SZQ/q6V21DU0whWZTxfnKPGQ+wiCpOHqX145e2az2Fy/iI4MQmC9zRwfjIjUMa0HQBGmn3vFjA/e7/JGUu0L8JrHSB8/lxSpOQsw4nIgQdEGQZEQHn2xVupaqGE4d84u9GT1UuPsX852R24aZ0HswhGUQRQ++z7cj+/hxrx/5rlT5Oririn9yNHnIZ4l9ofZ3Gq+ZZ7+KtkMbMCwFkEii/0KFD2GnEowButLguyHmcdKnT4eBRALF+A1JsWGccZxI8vqgJ+7Jk7+DTxG5udkXSYeACvHRCRdV0R9BqvjP5wbei8Fd2J/f2y0+k+OR4Ke+8ExH4xMmTBiHbasLEo/W2gM6nn67b6G9wr7ckEairwxG66tuILt2pSGuNT+xLuvNJCaCNOhHeBaZeI8wdudKP8ZXUqpI5hYSe1J+lYMOjH7/jfuoiLjTKAmnwn/9JLMYED0mw9WdfvkeQ13lx4hqcw7GKtbaKnes+4nfiZvNGT3UN7bUVznLFb+dSdLV9y8lytCYabXAO9tUumKHY+/3bfee+ETAVHjOxswJfP+Yzh5VkwHi/Qgut8DysAgp7eLPdFGr2V/ArJn87mE6vVO7h7kQy6nk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1VZVmJ6U0JqdU9COVFJTnNyMkt5RSt3RlpQK3R1S3FKQXZkWnRPS2UyM2dJ?=
 =?utf-8?B?c0FpNm5vZjFLWW45RjVRaGgvS2ZIUC93QytiOHFoVlZWRUl4ZUs0YmVUMENM?=
 =?utf-8?B?RFR4RHdHMCtFMjVLaEVoOXA3R1MwWE91cWFFL0FuMzc3R200ZGloUTFCWFZx?=
 =?utf-8?B?cUh1bnkvU0E5ZWpPVmdOaEtnaXZFMmQ1cXV0c245UHJXZ2tEQmNRYWtqckQ0?=
 =?utf-8?B?Rm01RXg4UHZFM1J6UUJSZmc4OEFveVFuQTJPVmc2VGkwR3pETjZsRW1NS004?=
 =?utf-8?B?Q0tjWGl0RTZBclRPb0lKZUU2T2s0K1AydDFXd0tmWVl3KzZHdXY5cTZHdXk4?=
 =?utf-8?B?d1ZVR1N1TW9YdmdjcFptUTVwTFRNbDRTV1dSMDlacWF2aDFRSUhyNnl3NTBh?=
 =?utf-8?B?SFFWMHZhZVptQ3hzcXMvSXlwejBjV09MSzM5RTlHT3ZVMzhlNERHdXNTZ3BK?=
 =?utf-8?B?MGsvalJnMkoza25kV3JXN0t5SW5KS25nbis0S3VvZC9JM1lkcE1UTGVYOEsv?=
 =?utf-8?B?N1JPdUhWcGRqVFkxbTN3UFpmcTBzL0g0M0hqZHZaL2xBMHFxTGIrMm0rWXQ1?=
 =?utf-8?B?SkRkSmpRKzJZWElXdnhWR0Q3L3hhYkoxUE5Ib0VqTzZab2V1cDlTdkNFdUg4?=
 =?utf-8?B?WHRwdHg2azdGN25qMTg0VWFNbERTS0lYR3kyWGNKYWRKWHVQckR1djE1VXB3?=
 =?utf-8?B?Y2xmWE1kOGxHTEthUDBxdWxvQTRaL0xwWFZSOXhOdmNtTHhqTGZ0SE8zcVdJ?=
 =?utf-8?B?RlBETnZSZndycEQwNGJxMnl1QXBZeURoUVh3di8vWEkwMmdzK2wrVW9vQlNG?=
 =?utf-8?B?bHAycjZBSnh5OGdnZ2g5THBZWWNoemk1V3pzTzB4YWw2MjJaQUNHKzV6TkZv?=
 =?utf-8?B?RGxPcEhPOVRrR1h4SGFHa3V3bXp4Q0tobXVFZ0o4bk1GZU5ISWgxTFlNZ3lE?=
 =?utf-8?B?b0RWbUxnMlJoRGI0bTJLaENuaFY1OGJQOG55WnlOa0xMaVZPR2lDNm1YNWFh?=
 =?utf-8?B?OTZaem9ROTNlczd3bVpMaFVhby9HR2tKcXEvSjZ5Q1R6a05KZm4rNnJoakRI?=
 =?utf-8?B?ZE5BS1NXcWIyMjFoeklmeUFBai9mbHUrVE9IWmRSakhWTXQwQ2NaMWZYYXcy?=
 =?utf-8?B?VTJZNmhlZXJMRTBsMSs2b2d5cDBJZHJTMFNHTzM2MnlUcDBLd0V5d0tzWjl0?=
 =?utf-8?B?MFdLZWFiQ01EazhtZ2NWWEdydTFNZUN4WThRR1lLdHNTc21qSHdNUmFqTXNz?=
 =?utf-8?B?UGRhT3BuSXlHQThDNm1sRXZ6UjkwbWdnRFVST3BXTVU1MTlaeWttbmRGRkwy?=
 =?utf-8?B?Z0E2VXhxbktwUWFRcXVkblA4RjNnT2pNT1pzSkxRMXdqNndDcy9SMUpxODJY?=
 =?utf-8?B?aUJWM3RiamVXS1hYeXZRakFUUlB4SjdNTGJBQy9TbytEc3NYSHJuYXB3VTN4?=
 =?utf-8?B?VFVnSzdzMmRUKzFla0pNTjZNY0xaenI4S3Fzck1TU1NSeUpGMlBjdkxFNlhJ?=
 =?utf-8?B?ZWc2Q25icVBkWU1zMTJZQzVtK2dtMXVkK0pHVzdBSUh1OEJaNmpEbWNHTnhS?=
 =?utf-8?B?OG8vOW80dkY2M1I1S2xOTWpXcWV1Tm1MZXU0VkxFamdZMFNwYTRVUHJaN1FW?=
 =?utf-8?B?SEhRNkttaHVZdmFFM0NvSGlsa0dJS215YlNReHJPYmRlYURjbVRneFNqOFM1?=
 =?utf-8?B?eVJmTElPRE1XSWJHaHlDTmgrY0dOMXVXNmdoT1c4cFU3ZExNMzVta3VoZThG?=
 =?utf-8?B?ZXVQYmhXOW0yN1M2VnIvOTNGRXN4SHNlTTdlS3pPWVZUOXJId2dBSkpPcEtx?=
 =?utf-8?B?UU81RUg3OGJJMVZTSjlaSzljYnZ6OEliYXM0eWdqY1VBTUhBZlpiZFlvcEpK?=
 =?utf-8?B?cER5RDRycTNWRTFsT0MzV2dCSVhqRmdNWFdSOWJBckZ1dTU1YmU4b3NLRGxs?=
 =?utf-8?B?M015d1FhNk52OHNJaU90aWhzaHlEdWZzZWtUWmhHY0VSQUxlUXVxRmliZk1u?=
 =?utf-8?B?ell4ckpYVTZ3dUJZQ0lrTjFKcDF0UCt3T1NDQnVsSEgrNDdyTG9KVjNaTUxm?=
 =?utf-8?B?T1dqQ3pwMS9TK29sWkdETEhmQ3hkWXM5K1hDaXFsQkM2My9ieG9WUjY0dGVn?=
 =?utf-8?Q?c5M0TsTl5vDcE6l+r2dAJ/Fz2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e23ba6-e43b-45e6-1c83-08dc48f06609
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 15:14:12.2899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHix/c0e59m4rEg7GfVodXdAyB3EIMZO2DJBE/e+BjEXg/jBlhbE40A21zm8oxWT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016



On 3/20/24 2:40 AM, Krzysztof Kozlowski wrote:
> On 19/03/2024 15:42, Tanmay Shah wrote:
>> 
>> 
>> On 3/19/24 12:30 AM, Krzysztof Kozlowski wrote:
>>> On 19/03/2024 01:51, Tanmay Shah wrote:
>>>> Hello Krzysztof,
>>>>
>>>> Thanks for reviews. Please find my comments below.
>>>>
>>>> On 3/17/24 1:53 PM, Krzysztof Kozlowski wrote:
>>>>> On 15/03/2024 22:15, Tanmay Shah wrote:
>>>>>> AMD-Xilinx Versal-NET platform is successor of Versal platform. It
>>>>>> contains multiple clusters of cortex-R52 real-time processing units.
>>>>>> Each cluster contains two cores of cortex-R52 processors. Each cluster
>>>>>> can be configured in lockstep mode or split mode.
>>>>>>
>>>>>> Each R52 core is assigned 128KB of TCM memory. ATCM memory is 64KB, BTCM
>>>>>> and CTCM memoreis are 32KB each. Each TCM memory has its own dedicated
>>>>>> power-domain that needs to be requested before using it.
>>>>>>
>>>>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>>>>> ---
>>>>>>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 220 +++++++++++++++---
>>>>>>  1 file changed, 184 insertions(+), 36 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>>>>> index 711da0272250..55654ee02eef 100644
>>>>>> --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>>>>> @@ -18,7 +18,9 @@ description: |
>>>>>>  
>>>>>>  properties:
>>>>>>    compatible:
>>>>>> -    const: xlnx,zynqmp-r5fss
>>>>>> +    enum:
>>>>>> +      - xlnx,zynqmp-r5fss
>>>>>> +      - xlnx,versal-net-r52fss
>>>>>>  
>>>>>>    "#address-cells":
>>>>>>      const: 2
>>>>>> @@ -64,7 +66,9 @@ patternProperties:
>>>>>>  
>>>>>>      properties:
>>>>>>        compatible:
>>>>>> -        const: xlnx,zynqmp-r5f
>>>>>> +        enum:
>>>>>> +          - xlnx,zynqmp-r5f
>>>>>> +          - xlnx,versal-net-r52f
>>>>>>  
>>>>>>        reg:
>>>>>>          minItems: 1
>>>>>> @@ -135,9 +139,11 @@ required:
>>>>>>  allOf:
>>>>>>    - if:
>>>>>>        properties:
>>>>>> -        xlnx,cluster-mode:
>>>>>> -          enum:
>>>>>> -            - 1
>>>>>> +        compatible:
>>>>>> +          contains:
>>>>>> +            enum:
>>>>>> +              - xlnx,versal-net-r52fss
>>>>>
>>>>> Why do you touch these lines?
>>>>>
>>>>>> +
>>>>>>      then:
>>>>>>        patternProperties:
>>>>>>          "^r5f@[0-9a-f]+$":
>>>>>> @@ -149,16 +155,14 @@ allOf:
>>>>>>                items:
>>>>>>                  - description: ATCM internal memory
>>>>>>                  - description: BTCM internal memory
>>>>>> -                - description: extra ATCM memory in lockstep mode
>>>>>> -                - description: extra BTCM memory in lockstep mode
>>>>>> +                - description: CTCM internal memory
>>>>>>  
>>>>>>              reg-names:
>>>>>>                minItems: 1
>>>>>>                items:
>>>>>> -                - const: atcm0
>>>>>> -                - const: btcm0
>>>>>> -                - const: atcm1
>>>>>> -                - const: btcm1
>>>>>> +                - const: atcm
>>>>>> +                - const: btcm
>>>>>> +                - const: ctcm
>>>>>>  
>>>>>>              power-domains:
>>>>>>                minItems: 2
>>>>>> @@ -166,33 +170,70 @@ allOf:
>>>>>>                  - description: RPU core power domain
>>>>>>                  - description: ATCM power domain
>>>>>>                  - description: BTCM power domain
>>>>>> -                - description: second ATCM power domain
>>>>>> -                - description: second BTCM power domain
>>>>>> +                - description: CTCM power domain
>>>>>>  
>>>>>>      else:
>>>>>> -      patternProperties:
>>>>>> -        "^r5f@[0-9a-f]+$":
>>>>>> -          type: object
>>>>>> -
>>>>>> -          properties:
>>>>>> -            reg:
>>>>>> -              minItems: 1
>>>>>> -              items:
>>>>>> -                - description: ATCM internal memory
>>>>>> -                - description: BTCM internal memory
>>>>>> -
>>>>>> -            reg-names:
>>>>>> -              minItems: 1
>>>>>> -              items:
>>>>>> -                - const: atcm0
>>>>>> -                - const: btcm0
>>>>>> -
>>>>>> -            power-domains:
>>>>>> -              minItems: 2
>>>>>> -              items:
>>>>>> -                - description: RPU core power domain
>>>>>> -                - description: ATCM power domain
>>>>>> -                - description: BTCM power domain
>>>>>> +      allOf:
>>>>>> +        - if:
>>>>>> +            properties:
>>>>>> +              xlnx,cluster-mode:
>>>>>> +                enum:
>>>>>> +                  - 1
>>>>>
>>>>> Whatever you did here, is not really readable. You have now multiple
>>>>> if:then:if:then embedded.
>>>>
>>>> For ZynqMP platform, TCM can be configured differently in lockstep mode
>>>> and split mode.
>>>>
>>>> For Versal-NET no such configuration is available, but new CTCM memory
>>>> is added.
>>>>
>>>> So, I am trying to achieve following representation of TCM for both:
>>>>
>>>> if: versal-net compatible
>>>> then:
>>>>   ATCM - 64KB
>>>>   BTCM - 32KB
>>>>   CTCM - 32KB
>>>>
>>>> else: (ZynqMP compatible)
>>>>   if:
>>>>     xlnx,cluster-mode (lockstep mode)
>>>>   then:
>>>>     ATCM0 - 64KB
>>>>     BTCM0 - 64KB
>>>>     ATCM1 - 64KB
>>>>     BTCM1 - 64KB
>>>>   else: (split mode)
>>>>     ATCM0 - 64KB
>>>>     BTCM0 - 64KB
>>>>
>>>>
>>>> If bindings are getting complicated, does it make sense to introduce
>>>> new file for Versal-NET bindings? Let me know how you would like me
>>>> to proceed.
>>>
>>> All this is broken in your previous patchset, but now we nicely see.
>>>
>>> No, this does not work like this. You do not have entirely different
>>> programming models in one device, don't you?
>>>
>> 
>> I don't understand what do you mean? Programming model is same. Only number
>> of TCMs are changing based on configuration and platform. I can certainly
>> list different compatible for different platforms as requested. But other than
>> that not sure what needs to be fixed.
> 
> You cannot have same programming model with different memory mappings.
> Anyway, please follow writing bindings rules: all of your different
> devices must have dedicated compatible. I really though we talked about
> two IPs on same SoC...

I agree that Versal compatible should be added, I will do that in next revision.

For ZynqMP case, it is two IPs on same SOC. In lockstep mode and split mode,
same SOC is configuring TCM differently.

How this should be resolved for Versal-NET ? Driver avoids such TCM configuration
for Versal-NET.

If you would like to see v14, before further discussion please let me know.

Thanks,
Tanmay

> 
> 
> Best regards,
> Krzysztof
> 


