Return-Path: <linux-kernel+bounces-106873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8617987F4C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BC81F21D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E6AA38;
	Tue, 19 Mar 2024 00:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wf89nAff"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2099.outbound.protection.outlook.com [40.107.220.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0AF363;
	Tue, 19 Mar 2024 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710809488; cv=fail; b=XKc28f049m7gR9ECaClv83nqTErt1aEedF+/OSY9kfBkCc6Fw0UVN9EwO3OK2hrOVwcxUD/HFcKQX9ja2H4I1Uih7HxTsZp67YjCWXyiQ5eNdkHBNR5t0FU8Y/Ls05VWLZ7YyEdYB3mixJvAMfMSC9PwFuspFMoqKfVX3RODddg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710809488; c=relaxed/simple;
	bh=anFuRwCLJE0+xmI/bmM1fYUGfS6YNGFA1+5SHWb87yw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fri7wVgVSbFckJTfzMvZ0+fFkU3ZE+GkmBrMwTLa/8/e310sMg8AHg5utrwe8KD+nH/3lH9ZE2mgYeJFuaUrOXaOEPuiD/ocp17F1c5Vo3Pxg/J6KF5Im1e3YDbh860IC94+VSIcfUsmFiC79McURGcdzm9/G60Pz0m8+yJcy08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wf89nAff; arc=fail smtp.client-ip=40.107.220.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm81mchnlddXWwzMtM4aOy5jDdvHxTRLPXl2+JUibiYV8YO16qpnWIE0ujtk1NM4cBkNCqV5T3+she9oooW0lVsIflsmZOBU0ZT1U8pPu0sJyqLy6F4vdMP17SvW3qlyd/96wJXoyAydN0jFEyOVRgL0tYBjz7ENAoYiVCgz9x+Kj9CDzAAObgprczYe3785oA1DVGm8GegN+nUb8JwKyVXgzfR6ElNMnioo9PNTOSDpQtDwC9cElnzXn8QbpRQ3O0raEy97extL6dgjR9JRnJCxAYmU+R7xRT9zmYtwwp/NHVv0XbBYO0ZWE/9fYwwcA55Eh9WDecxbzoUdT44eTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oP0Z/+9NlkatBEYG/jVf05CQ1TsvTKAapzSXHeWfJD4=;
 b=Zl7/4LB1hD/qz7Di0ge5B8Podhai893wVpf7IkugtJ7Mdwx+ake7vtrsP45JUHvF/lwlHmhKkQbrddSNKGqoVg3YI0l1FDI3GszotpNoZDYFrcFzfMW09G79dUDmUK2zFVqKBlIG+zIagWn1ihGW6YY1LmgfQbxsB6Ix+rUzsP7wrIhQEK85q/YwU/AQ7O7GiMFkTZ2r5XYcmceNoYgGtpM8t+cLykJ1X47+ZuY5MyWXiGfWa6pe+clrmbsMBgpiSLlFZKBURkI53FeQxlM9ti1R8IK7Tp2x3FfEQhXNi+IxEHoAy6uenIZY2xsS1oJljMPZ6VT4juNPA08a2Ll6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP0Z/+9NlkatBEYG/jVf05CQ1TsvTKAapzSXHeWfJD4=;
 b=Wf89nAffujPzWyN0adgG6luyHMJdLt6/yOjV4KXedSmhtU3NlO5F6z4TcinYnWdJN1yWq1d4lk3q06IEdmATT27xJbLBVYOZ3O7iw+G1TtBDhipwxJIZedL6+LN059XjHf0P+i4hPJ3BfyEfcoFEJLaP2ZfotQrUOjm/dDVcEqM=
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 00:51:22 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 00:51:22 +0000
Message-ID: <14be0aa6-49b7-4342-9ca6-750c30c8e1e9@amd.com>
Date: Mon, 18 Mar 2024 19:51:19 -0500
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
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <3ca1c419-d185-4318-92ed-3c4e40dcf5bb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0045.namprd05.prod.outlook.com
 (2603:10b6:803:41::22) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SJ0PR12MB6733:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QUssROm+aCy3S36o2bQ7UwlA/Q6t25qLfKKzB9nYUW5CoANpvR/jeME3SPn+Zcinnrq7hP7XOvoQ65P69wiIloJKJIo0sbKhdwNFgZ2bJ6q3G9mdp0fm8QHf8WbGQm53KXzk2zNlZeT6XpC05y9WD6xxTb6vhLs6whNcT2t3tk97CvaXJb+P5xmxTKu6MQessmpAjKIVjs9BzARWHSn1jrYud5XzkoYNN40SrSp25u2ECVYqT/oa0zDyDEgHjrkNXZlh9Cki1BdrI7wG6goeUEn5+6S2+ezXjYej6iQobzObEoATN6F2plo+Zq8Eaka7wZmAc8uYN2Uwacz8JXJJIPtNEzBUrdRmerXF5OuNmr063VmkwKaWJ+oJmv0i2ztvFxfSeHLjycHIqOzeYpyH0tuK9fFclRZKlKuuB+jMYVkYdAIu8ugVeL+XhmeVgZiev/V/LF82ptzqdxIPzuFz4veD+cVf7S+vkubb2AENv71+R0JbmaVTHCPlnVXlCHdGySIdk9aKt4LymGoy1os1oyAyeGIgH7o8pt2ZwylasZwxVaSgA/C8Q6y+h3jr776TIDkSgMTnwGoX8mOPPgJweTxJMx3sm0QJQDjTudHC73/5DeKwpUSWdXHhwGv0liITm+e0/ZoTDIopDZ1H61fWnnQk9Z+wztPhzVtA62ue0FE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmtUSzlyc1ZjOEVEL0ViMVJjeURHeUUvcWdCT3NPTVJXOXZHRFBnbThhbVYv?=
 =?utf-8?B?S1VKTFRmNkZmcm1FeS9EcnBYMmpiSjJvbVF2U0Zrb1FmM2FoeEwwd09Eczd1?=
 =?utf-8?B?Snl1cVYzSW53d3hMYkFIV29WdGs0TUZuRUdTd29OMEhzR2NxdG8reHRpbWtP?=
 =?utf-8?B?OWRMWHBlWExtMzIvQ0RXeWNWOVUwSis3YjVWbnhMTUVydkdxQ3dFaDRHaWEx?=
 =?utf-8?B?akNLbUVzQ21LMVhLVlRBNGhOZFg2TVVSZVdsYkNaODVIN0ZqMk5TbHJ1aHBU?=
 =?utf-8?B?VUo0WDFtVEtMRzNQMnlCalRaVm5JQU04eEMvZWJCaVRBb1FUcDF3cTF1Q3pr?=
 =?utf-8?B?Y1ErTHU2MG1ReUtLb1FydEYzTldPWXd5b2hMK0QvMWlMZHdUbXJpRWFqTG9a?=
 =?utf-8?B?dnVrb3d6RGZ4VEF4OXdheDZ5UGV5NkI0UkgzQTk1Z29wMjVVRE9sZFpqTkVk?=
 =?utf-8?B?Y2dUMmM5NHFwSVdEYVZYUGlYUG8rWTQ2Q0VCYjl2c0hLSlpuRlk0ODAvVlln?=
 =?utf-8?B?MkQ1Y2RnYnRreko3ODFxaEQ1cXYxYW9mUllTclNwNlJnM2VEMHNqTmowQVVC?=
 =?utf-8?B?RWM2bHFvTzBIOWJkWVYrUmFQZmZkWm5STUlZbUhXWmtzbDE3eDJINmtLVVJj?=
 =?utf-8?B?MXlsTVNwdUlQWC9BTExEOHphSmFJcFZ2bDNLeWxGMy81WjFwZ1gzL0RWdENx?=
 =?utf-8?B?M252VVhxSU1yb013eUljb290VGdLbXlXT1ZIVzh5aU5OL2NQalkyWTN4d0tu?=
 =?utf-8?B?aTJoUVJxVHdYTnZVcVVwTmMrb3AvZk55blI3YURMVk9wSUhGdFJjS3NUVzN2?=
 =?utf-8?B?Y24rK2Q3WTVOd0p1RUJzWGx3Y2FqMm96TDJ2dk1GcnZpdnc3VXNFVkQrWkxt?=
 =?utf-8?B?bXZScEg2Mk9yQmQ3djFVbDRnZ09JTWJiaVMvWThsNmlYc3R4UUYyU0lmZFpl?=
 =?utf-8?B?ZUg5Q2xGVWptNStyUVhIaUhDK1NSQ0N5V01CR3l6REJFNkpVZS9obkN0OUlW?=
 =?utf-8?B?WUpZU2l1V1hrUlRacTZRUjE0ZW95QVVkQU1VaytzUjhYbXI1eGJuVGM4YjV1?=
 =?utf-8?B?S2kvWW9nQmVBT2xsR2U3c0UzUGRUc2ZpN3dTVkVPYngwM3RSbEtoSUhFcHVD?=
 =?utf-8?B?SzdWSlRjd3BjZXQ3MVhZeVBtMFRISUlDMk91MGMxUFJsd1BoVlFERTU0OUNz?=
 =?utf-8?B?UzJLcXFxMWQza2E4bEdjanYwVmhuenlFcXluNDlLRFc5V0F5Z3Q3Z1cyRXE5?=
 =?utf-8?B?V1ZJd2dIcVNEemVLM3ZLVk9obW9rNjBWZlJqeEJVb05oM3l0OGJib3QySm9a?=
 =?utf-8?B?ZXpmRkdxOHMzYjdTeFZlWjMzWjFhZnFVUW85QzlWbEZtQ3NKaXQwQWwvNlY4?=
 =?utf-8?B?UzRSb3lnQjRTNGx1QlVuVTE2dzFLUmhMMy9QTGl1aFlWL21sVFllSzlrK1FE?=
 =?utf-8?B?R0dLVHZEVzdqak9JSEMxL3YzQW13Vm92WVF1UXVkc3dUdjNKbTRDcUpDeDFN?=
 =?utf-8?B?RUJUQ0kwencwVzNVcmxYMlByWmdOM1FzWm5RSXIzVVJiaEloMEM5U0RhOVBW?=
 =?utf-8?B?SEUvTE5sNGxRVVBqdUlnZnU4Z2NrV3J0dmpEMlBYUy93SU42dkI0WTJYdW02?=
 =?utf-8?B?dlFtc2c0VkIwNGl3Y2JoNTh4VVdZTmdqUVpLeEppTytkN3V3a3FHNlQwTUdv?=
 =?utf-8?B?THhhbzJaQzRIOTZOeWhhL0tCOTFMNENXZkxLY3psRXo4RlNzVXAvckMzOE9U?=
 =?utf-8?B?RmtuRS9tbmFXbWJRRlk5Vzc5eWlNVTBjSUVxZmh5YlZiTjE0MmxtbVk5eGU4?=
 =?utf-8?B?NVBMSU02MXM0Y1RlZFZBOEFobEk0QTJGRzBxN2dteHZUUXl4cWR5amQyRHN1?=
 =?utf-8?B?N256NFA3STkrM1FnVEZYRjNBYzZObzlhdDVQQUkrdFh6eEpPUXowbzN3TmJz?=
 =?utf-8?B?bTl4SGg0eGNBZUR3eCsxSjJlUktOMlFacHdOZnNyNTl0aHJSWWRIMXZRWlUx?=
 =?utf-8?B?VU80UDFyMHNSVW42ZFE3SDBkdWRYazRTRENXK0ZmMzJpMmloL2VPTThQUmRz?=
 =?utf-8?B?dktJb2lMYmZxZjRYTDR4VHltV081TWkzRWVEV2NWZUVQUU5waHFoQlNid2No?=
 =?utf-8?Q?wp0fb2xLf/HKJHMH7V2wr1k2+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b690d11-b971-4b30-f63f-08dc47aeb299
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 00:51:22.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCw1p4ID2ep6kuYlyJbWOHrCgOH13tzEQoasrIuMymPQAOt2XdlZrA/CSWq7CfXM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733

Hello Krzysztof,

Thanks for reviews. Please find my comments below.

On 3/17/24 1:53 PM, Krzysztof Kozlowski wrote:
> On 15/03/2024 22:15, Tanmay Shah wrote:
>> AMD-Xilinx Versal-NET platform is successor of Versal platform. It
>> contains multiple clusters of cortex-R52 real-time processing units.
>> Each cluster contains two cores of cortex-R52 processors. Each cluster
>> can be configured in lockstep mode or split mode.
>> 
>> Each R52 core is assigned 128KB of TCM memory. ATCM memory is 64KB, BTCM
>> and CTCM memoreis are 32KB each. Each TCM memory has its own dedicated
>> power-domain that needs to be requested before using it.
>> 
>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> ---
>>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 220 +++++++++++++++---
>>  1 file changed, 184 insertions(+), 36 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>> index 711da0272250..55654ee02eef 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>> @@ -18,7 +18,9 @@ description: |
>>  
>>  properties:
>>    compatible:
>> -    const: xlnx,zynqmp-r5fss
>> +    enum:
>> +      - xlnx,zynqmp-r5fss
>> +      - xlnx,versal-net-r52fss
>>  
>>    "#address-cells":
>>      const: 2
>> @@ -64,7 +66,9 @@ patternProperties:
>>  
>>      properties:
>>        compatible:
>> -        const: xlnx,zynqmp-r5f
>> +        enum:
>> +          - xlnx,zynqmp-r5f
>> +          - xlnx,versal-net-r52f
>>  
>>        reg:
>>          minItems: 1
>> @@ -135,9 +139,11 @@ required:
>>  allOf:
>>    - if:
>>        properties:
>> -        xlnx,cluster-mode:
>> -          enum:
>> -            - 1
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - xlnx,versal-net-r52fss
> 
> Why do you touch these lines?
> 
>> +
>>      then:
>>        patternProperties:
>>          "^r5f@[0-9a-f]+$":
>> @@ -149,16 +155,14 @@ allOf:
>>                items:
>>                  - description: ATCM internal memory
>>                  - description: BTCM internal memory
>> -                - description: extra ATCM memory in lockstep mode
>> -                - description: extra BTCM memory in lockstep mode
>> +                - description: CTCM internal memory
>>  
>>              reg-names:
>>                minItems: 1
>>                items:
>> -                - const: atcm0
>> -                - const: btcm0
>> -                - const: atcm1
>> -                - const: btcm1
>> +                - const: atcm
>> +                - const: btcm
>> +                - const: ctcm
>>  
>>              power-domains:
>>                minItems: 2
>> @@ -166,33 +170,70 @@ allOf:
>>                  - description: RPU core power domain
>>                  - description: ATCM power domain
>>                  - description: BTCM power domain
>> -                - description: second ATCM power domain
>> -                - description: second BTCM power domain
>> +                - description: CTCM power domain
>>  
>>      else:
>> -      patternProperties:
>> -        "^r5f@[0-9a-f]+$":
>> -          type: object
>> -
>> -          properties:
>> -            reg:
>> -              minItems: 1
>> -              items:
>> -                - description: ATCM internal memory
>> -                - description: BTCM internal memory
>> -
>> -            reg-names:
>> -              minItems: 1
>> -              items:
>> -                - const: atcm0
>> -                - const: btcm0
>> -
>> -            power-domains:
>> -              minItems: 2
>> -              items:
>> -                - description: RPU core power domain
>> -                - description: ATCM power domain
>> -                - description: BTCM power domain
>> +      allOf:
>> +        - if:
>> +            properties:
>> +              xlnx,cluster-mode:
>> +                enum:
>> +                  - 1
> 
> Whatever you did here, is not really readable. You have now multiple
> if:then:if:then embedded.

For ZynqMP platform, TCM can be configured differently in lockstep mode
and split mode.

For Versal-NET no such configuration is available, but new CTCM memory
is added.

So, I am trying to achieve following representation of TCM for both:

if: versal-net compatible
then:
  ATCM - 64KB
  BTCM - 32KB
  CTCM - 32KB

else: (ZynqMP compatible)
  if:
    xlnx,cluster-mode (lockstep mode)
  then:
    ATCM0 - 64KB
    BTCM0 - 64KB
    ATCM1 - 64KB
    BTCM1 - 64KB
  else: (split mode)
    ATCM0 - 64KB
    BTCM0 - 64KB


If bindings are getting complicated, does it make sense to introduce
new file for Versal-NET bindings? Let me know how you would like me
to proceed.

Thanks,
Tanmay

> 
>> +          then:
>> +            patternProperties:
>> +              "^r5f@[0-9a-f]+$":
>> +                type: object
>> +
>> +                properties:
>> +                  reg:
>> +                    minItems: 1
>> +                    items:
>> +                      - description: ATCM internal memory
>> +                      - description: BTCM internal memory
>> +                      - description: extra ATCM memory in lockstep mode
>> +                      - description: extra BTCM memory in lockstep mode
>> +
>> +                  reg-names:
>> +                    minItems: 1
>> +                    items:
>> +                      - const: atcm0
>> +                      - const: btcm0
>> +                      - const: atcm1
>> +                      - const: btcm1
>> +
>> +                  power-domains:
>> +                    minItems: 2
>> +                    items:
>> +                      - description: RPU core power domain
>> +                      - description: ATCM power domain
>> +                      - description: BTCM power domain
>> +                      - description: second ATCM power domain
>> +                      - description: second BTCM power domain
>> +
>> +          else:
>> +            patternProperties:
>> +              "^r5f@[0-9a-f]+$":
>> +                type: object
>> +
>> +                properties:
>> +                  reg:
>> +                    minItems: 1
>> +                    items:
>> +                      - description: ATCM internal memory
>> +                      - description: BTCM internal memory
>> +
>> +                  reg-names:
>> +                    minItems: 1
>> +                    items:
>> +                      - const: atcm0
>> +                      - const: btcm0
>> +
>> +                  power-domains:
>> +                    minItems: 2
>> +                    items:
>> +                      - description: RPU core power domain
>> +                      - description: ATCM power domain
>> +                      - description: BTCM power domain
>>  
>>  additionalProperties: false
>>  
>> @@ -386,4 +427,111 @@ examples:
>>              };
>>          };
>>      };
>> +
>> +  - |
>> +    // Versal-NET split configuration
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
> 
> Don't add examples per each platform.

Noted. If we go with different file for Versal-NET, then example should
be included?

> 
> Best regards,
> Krzysztof
> 


