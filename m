Return-Path: <linux-kernel+bounces-107667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAFC87FFD0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF01A1C22AAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFBE41A88;
	Tue, 19 Mar 2024 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vBB0dGcV"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2125.outbound.protection.outlook.com [40.107.93.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05A54273;
	Tue, 19 Mar 2024 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859328; cv=fail; b=skaZq9fEpiCmOSeXEL0OVnlUnkzXD2ENTlNf5SWckxDlRXy6bKbpriL92xCE19R2CfIeT0Sj9N8CvzaPg8wkPximrPTTMgDkKgMd4OD1JYC1KbXUl9pMHkpYXIlicAJAGlPTDiH3Evqa/Im/ni42Iz+y1T8k5EQPmwM4J2z3DZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859328; c=relaxed/simple;
	bh=Cztm7QnUnik7MNVOft05S+bYhGlHwmkGMTzFuo3/mhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kzu7eZ0NanjQ9X3PgetfTspGvx5V4j6z5HGBAKby0mLpGMKeuLuevXFlEl6SCdI1Vt9GAPkg7p0cHOEhX6ebV19C+KFX2dsWgqFxv8fUmzNDmrYUOvlOvbdRwlq1eXh5HvB5fuUKhAsorRkPXUjZqMBavufTVZV+xkbLEAD67CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vBB0dGcV; arc=fail smtp.client-ip=40.107.93.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHJTR6qykadVHexekJog9i4YQzYKYpnT8uNlVn5q1uM2LqkZ7OHHat8hf7Zcckf3PxWn4SeXvyzeI1QaBuqcMb14LZ84iBZ1KEB7h9iW17pPVX1Webd99UJttSAUcMU4TDVcyDHqhtEh037bqOP71yP7GkWX/O4PedWX49QYlZTN35/pTian/m2q7E2vyuXjinsJTyzSeyYr+RCRKEPdJj3HLpf6CXR0MzNjeYJ3W+wRzP3ZM4GTVymYqfi2B3p/zihNsM7EgjdW1OxzqtEO8WOfZkNeiLtUeQW8Z4qiHk+uejW6uRM8Kz4P+IHLneN6tFQybPN1n2Y2XAURNw76iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdE6emH0Icx0Zk3pe4canEW6+8+styr077KgwYNrK/M=;
 b=GszXx+59GjU6JznIwF3STT17/5d92zGi//3om8WuAHlFbE/PvaGOBAbG5to6ME4zNP3Kn3XxWhN37K7hUoR0vLgxNVGSvpdVkQIgq3Lb2df+VB4bBxQ96CAbTArjB38seNM6XPtjuigPYRZsTbkxAOcoEUh7NIj8OjmIJO6fd7gUk0+sRzCVe7Abr5U44S5Vck2e0tw3E6juRqUBwqyJ9p1OvpJcKjiQXYgNWZqnLgg98foSn81E/TM0NNd2QZ1Yhy6UzJ0NEXBVqTQ+U73RuAP/oQ5NVlYp017CdBT3ny6m/OUhzxGXAJn1GoVXcyJWFdAHsXq3OZiM2oDQyuBMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdE6emH0Icx0Zk3pe4canEW6+8+styr077KgwYNrK/M=;
 b=vBB0dGcVJpQ1YYeYRwG6FFUo3ZK+T83a6q+bAZqOUx24DJ3BuNUGl5D5hp5WUiK3xM18L8z0dJZqZIRJIbWWQN51b91oOyg7pgIAWDD3UOuSEpJTmH74lqUkTJkQ7q8U0puKdJXayoxNx5R7v86ejYwbaVr9DH+EYujAUX6uWs0=
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH8PR12MB6747.namprd12.prod.outlook.com (2603:10b6:510:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 14:42:04 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:42:04 +0000
Message-ID: <d112481b-4331-4c0c-9775-407ac4a601fb@amd.com>
Date: Tue, 19 Mar 2024 09:42:01 -0500
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
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <b1320ddf-bacb-41e3-9709-e90df18cc1e3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:8:2a::23) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH8PR12MB6747:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lyRk1IUpAP4ezoXCfjMEX+YuUuCZ1Nrwst7bjFzQHesK2eZQ8mMyjzL9Z9xFfy8mu+bW4e9liJVeT0EV+BVz/LhTH5rlqsPOrhG6w2Jw0U9lKOKdmn1diL89Cvw9eMSwo9bdgLUejulHy9aTsaiNMLoRq+KGVnrXSU9gy8AeLvezV9rnvx3qx8h8Kbu2mRpRRazGEZFSd695aqD/7fSYX6AhD0VENrAY2dAL6biBGzMIWeE4pOKJAJN0XqF/3iD9dpGCFKoyvA19RimeO6sQSCQZ0iONmeQL+lYTIgdXAqkD6gxXJFoKhSGRS5oNTaUL7zVXkZoG2zR7VOsnCs00HTpX/ioeTdFnInhy9l911dXp/1rS9X4FpLWTk8IfvSGzwImFyPzeZkog74MD0iiTe/jB8CYlqNac6/FPa06+/9/myHaz6fF7W6/6EFeZ4PnpGNvyZ46B2jh0ldBK6zjurg3D8acP84ddEZDsu1PqOJ6pJTKhDs+Uu/E3i+BpDxyVw1Ug2QC9eH/0SoTz3T9Lj9A6RONXdLpSXVpSUNbDe2p+tU5d0Iwu6cS2DsOCrZ0lmdojD1Hgf95tV6RlzHML508qyZQcsKkzrBrewDo9FLPSETU0m09jv6Nig7lQdNdGSuhc/1VcoiqiWBNkeAXpEPSZOoyXCCaDRClVZMlqLlI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEtWSlpucnprYUhpWlJJdzFMUnNUbnE5K2VtY2VDalRmSHhnVkhKVFpsdCtv?=
 =?utf-8?B?a0JySi9WU252dGlVMnozZEpJWm5iZG9QVmVlY1gzRUN2dCtBYU5WOXFQS29H?=
 =?utf-8?B?REl0TjZDSkpLN2hJQ24xNHoyWVpueW1QMkR0Y0l5aC9JYnIzb3hSdFBmc2dw?=
 =?utf-8?B?SEx0QVNHWmpYSWJTempYWUtMTVNKcnZCM0RRa1Ewa04rcENEMSt2REJwcytq?=
 =?utf-8?B?QzJoMVdzV0lJTFVmTmxDaCttcXJvaE5OdUZORnVFMWlPVGxkMjVOMWJPdmZT?=
 =?utf-8?B?UllWOGNmTVhRY002QmpqSEJZRDB2U3AzaWtJRTV5ZnRma2g3dnZSUlRramRD?=
 =?utf-8?B?OEZIVDBGb1lhZ2pHQ0g3OEI0OVA5NHUxM1NyejEvWjJ6VnpyVmQ4ZitTVVZm?=
 =?utf-8?B?SUxTYndzSXdBM1RpVW9aM3ExaWxMQ0R6bkcrV3NOUTVIZmV1Y0l2aGl6NFBX?=
 =?utf-8?B?Lzh3QnZhWllYQTYxd2d4cGdIZGRSdFhHZW1ZYXBYSm9FYTlobzJ1NnBiZmhj?=
 =?utf-8?B?U0tUNDgvbHZnRURxdHQ4ZHQwZGEvTlJOYTAxcGdXWnZtQThPOVJnSnlJUnhS?=
 =?utf-8?B?WHhJQ3NRbFRrUDhTa0FPTjdkTTdqcDB4Yk1yREEwMGNjUTh5VFYwSVhpM2U0?=
 =?utf-8?B?cHVkTmMzdk43WGIwMFN0UGlxOHlYcURrRTVRUnlYeXpMZVl3M0lUaXRreGl6?=
 =?utf-8?B?M3VPNVVYdTkvalp0MmdScXVIa2dlcTl1Wkg0bit2UUdzek53dnJ3SGI2Y0M4?=
 =?utf-8?B?NWxRcEFBTFo4dmEzR3VuWTR0eVY4R1YwR2JoTmk2VUt5SGhnM3hHK3ltc1p1?=
 =?utf-8?B?Y0NXODdKOHREam9yMlp1UHk0cXRJRFFlQ3F2ajRIdVhYZGFQTUw0d0ZMK0xV?=
 =?utf-8?B?N3RTRWJNd3JHWWlsS0cyOTRwdjQ3bVpCaEh3VURuVU1jNVU0SmlXNUlFVktm?=
 =?utf-8?B?aGhTa0JrN2VEcEZoUUZyVVZUZmFsR25IN1BSVFJDbUg1UWE3SEJMNnhsWDN1?=
 =?utf-8?B?N3BaZ0xqMVBjQUNJbEhibEtROFl4RnhvRTRpSlQ1aXNYQnlmRXhqYUZ1US9h?=
 =?utf-8?B?dWxuY2VYZ2hpMkxmbS9oS3cyQWJxOXRyYnlwa1R1T2tsdW9LeWVzMDdRalV0?=
 =?utf-8?B?S3N0TXRaZm9DVHF5bmRBTmJSZ0Vnd1hsVlBjc1VFQzhXQ0h1aFExUFBtUFQx?=
 =?utf-8?B?a0o1R0t3d3ByVnNLS04wQkVCaEZ5N0Y0Z2Yvd2Rzd0NXdGgxOGE3NmdqUFFi?=
 =?utf-8?B?c1g4YWU1cnovVG1WeG5kWG9KbFNwRjNYbEdaRENVbTlVeXdJYm54NjlGRU8x?=
 =?utf-8?B?OXJlTVZncXVzVVNCeGNjSmw4dFpkbjVPYUYyKzBRS3pRQXFKcTFnQmdBK1Uz?=
 =?utf-8?B?TUcxM0ZIYVJLdnZ4czMrdXdLelN3T2JHMmpPUzBLZWdlS2RlbHdyWmFrbjZT?=
 =?utf-8?B?NDVGbWxYM0xhWEFOd3NoSldrcVJpeW1tSS90Z1NYQWFOamV1ZC94UWovakN2?=
 =?utf-8?B?aUZSMjBOOXp6YTNtY3ZWc0ppa3dyRndvQ00xaFFHdlJuajhwWHlaQmpUSU1J?=
 =?utf-8?B?SENSbHdIS0VsVWlXamtHeXJZd0JkcDVrcHlwczNkeWNnb2ZGUHZCVEIvMkZ4?=
 =?utf-8?B?S1pwMHJ1WENMekZETHNHZ2NTb1hTNzNSb2oxc0FEdlFKVENHbDZSU0d3ajBT?=
 =?utf-8?B?Y0Z0SGRVMFI0TWdzS0NMNnZHdGh5Vno1UDdjRE8vUDk1ZC9vemhpSjk2WXBS?=
 =?utf-8?B?OVpaMXJubG50aVJVWmtPMVRDRFM3WnlhS2tEeFJWUnU0bUJaSGV3Tlc0SE9x?=
 =?utf-8?B?SVE0SHNWOGUyaVBzd1FWQUtYdEVCNy9xcEZ5bnhPT3dkeGVUMFZQZFZWWkRF?=
 =?utf-8?B?VllPWGMvYXUvWVZLZllVM3RDUHNiY0hzUkxjaFdSa3F3TXhXMkl2NzFjMEkz?=
 =?utf-8?B?ZlZieHBIQUNoVmxCMlpUWjNuem40VmorS3NJSzh3Qy84VVQ4WWlYazdZaDBJ?=
 =?utf-8?B?WmpINVFnYlFVd0x2azlwV21HRjdyUVpxTW43OGptdS84OWhyNENpNVlGRG1T?=
 =?utf-8?B?NzVUVWhsTTlmQzlJcXVYQnNNemZadUJtaFlJdXdQaU0vbE5XOTF1OFJtRVlo?=
 =?utf-8?Q?zLLK4p6BzlYiWz3xhwHp3fFIb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169397ac-ef4b-4f8f-1534-08dc4822be99
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:42:04.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YiybOsVZDnpVBiL2kbwh9h8trDLsLYETZp4DcrC29urQWSheC/RcGGdxwYCm8k1U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6747



On 3/19/24 12:30 AM, Krzysztof Kozlowski wrote:
> On 19/03/2024 01:51, Tanmay Shah wrote:
>> Hello Krzysztof,
>> 
>> Thanks for reviews. Please find my comments below.
>> 
>> On 3/17/24 1:53 PM, Krzysztof Kozlowski wrote:
>>> On 15/03/2024 22:15, Tanmay Shah wrote:
>>>> AMD-Xilinx Versal-NET platform is successor of Versal platform. It
>>>> contains multiple clusters of cortex-R52 real-time processing units.
>>>> Each cluster contains two cores of cortex-R52 processors. Each cluster
>>>> can be configured in lockstep mode or split mode.
>>>>
>>>> Each R52 core is assigned 128KB of TCM memory. ATCM memory is 64KB, BTCM
>>>> and CTCM memoreis are 32KB each. Each TCM memory has its own dedicated
>>>> power-domain that needs to be requested before using it.
>>>>
>>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>>> ---
>>>>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 220 +++++++++++++++---
>>>>  1 file changed, 184 insertions(+), 36 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>>> index 711da0272250..55654ee02eef 100644
>>>> --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>>> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>>> @@ -18,7 +18,9 @@ description: |
>>>>  
>>>>  properties:
>>>>    compatible:
>>>> -    const: xlnx,zynqmp-r5fss
>>>> +    enum:
>>>> +      - xlnx,zynqmp-r5fss
>>>> +      - xlnx,versal-net-r52fss
>>>>  
>>>>    "#address-cells":
>>>>      const: 2
>>>> @@ -64,7 +66,9 @@ patternProperties:
>>>>  
>>>>      properties:
>>>>        compatible:
>>>> -        const: xlnx,zynqmp-r5f
>>>> +        enum:
>>>> +          - xlnx,zynqmp-r5f
>>>> +          - xlnx,versal-net-r52f
>>>>  
>>>>        reg:
>>>>          minItems: 1
>>>> @@ -135,9 +139,11 @@ required:
>>>>  allOf:
>>>>    - if:
>>>>        properties:
>>>> -        xlnx,cluster-mode:
>>>> -          enum:
>>>> -            - 1
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - xlnx,versal-net-r52fss
>>>
>>> Why do you touch these lines?
>>>
>>>> +
>>>>      then:
>>>>        patternProperties:
>>>>          "^r5f@[0-9a-f]+$":
>>>> @@ -149,16 +155,14 @@ allOf:
>>>>                items:
>>>>                  - description: ATCM internal memory
>>>>                  - description: BTCM internal memory
>>>> -                - description: extra ATCM memory in lockstep mode
>>>> -                - description: extra BTCM memory in lockstep mode
>>>> +                - description: CTCM internal memory
>>>>  
>>>>              reg-names:
>>>>                minItems: 1
>>>>                items:
>>>> -                - const: atcm0
>>>> -                - const: btcm0
>>>> -                - const: atcm1
>>>> -                - const: btcm1
>>>> +                - const: atcm
>>>> +                - const: btcm
>>>> +                - const: ctcm
>>>>  
>>>>              power-domains:
>>>>                minItems: 2
>>>> @@ -166,33 +170,70 @@ allOf:
>>>>                  - description: RPU core power domain
>>>>                  - description: ATCM power domain
>>>>                  - description: BTCM power domain
>>>> -                - description: second ATCM power domain
>>>> -                - description: second BTCM power domain
>>>> +                - description: CTCM power domain
>>>>  
>>>>      else:
>>>> -      patternProperties:
>>>> -        "^r5f@[0-9a-f]+$":
>>>> -          type: object
>>>> -
>>>> -          properties:
>>>> -            reg:
>>>> -              minItems: 1
>>>> -              items:
>>>> -                - description: ATCM internal memory
>>>> -                - description: BTCM internal memory
>>>> -
>>>> -            reg-names:
>>>> -              minItems: 1
>>>> -              items:
>>>> -                - const: atcm0
>>>> -                - const: btcm0
>>>> -
>>>> -            power-domains:
>>>> -              minItems: 2
>>>> -              items:
>>>> -                - description: RPU core power domain
>>>> -                - description: ATCM power domain
>>>> -                - description: BTCM power domain
>>>> +      allOf:
>>>> +        - if:
>>>> +            properties:
>>>> +              xlnx,cluster-mode:
>>>> +                enum:
>>>> +                  - 1
>>>
>>> Whatever you did here, is not really readable. You have now multiple
>>> if:then:if:then embedded.
>> 
>> For ZynqMP platform, TCM can be configured differently in lockstep mode
>> and split mode.
>> 
>> For Versal-NET no such configuration is available, but new CTCM memory
>> is added.
>> 
>> So, I am trying to achieve following representation of TCM for both:
>> 
>> if: versal-net compatible
>> then:
>>   ATCM - 64KB
>>   BTCM - 32KB
>>   CTCM - 32KB
>> 
>> else: (ZynqMP compatible)
>>   if:
>>     xlnx,cluster-mode (lockstep mode)
>>   then:
>>     ATCM0 - 64KB
>>     BTCM0 - 64KB
>>     ATCM1 - 64KB
>>     BTCM1 - 64KB
>>   else: (split mode)
>>     ATCM0 - 64KB
>>     BTCM0 - 64KB
>> 
>> 
>> If bindings are getting complicated, does it make sense to introduce
>> new file for Versal-NET bindings? Let me know how you would like me
>> to proceed.
> 
> All this is broken in your previous patchset, but now we nicely see.
> 
> No, this does not work like this. You do not have entirely different
> programming models in one device, don't you?
> 

I don't understand what do you mean? Programming model is same. Only number
of TCMs are changing based on configuration and platform. I can certainly
list different compatible for different platforms as requested. But other than
that not sure what needs to be fixed.


> 
> Best regards,
> Krzysztof
> 


