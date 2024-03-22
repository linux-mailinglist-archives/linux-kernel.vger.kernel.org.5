Return-Path: <linux-kernel+bounces-111944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC609887316
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D028F1C2255F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8B6664B2;
	Fri, 22 Mar 2024 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kHoK+zE4"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F9664DD;
	Fri, 22 Mar 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132098; cv=fail; b=aSF7hCP3QcNJkfbGiNIhJ0EePFf4k/pduMoG+wonIB1aLvQ9/65ATvLwn2JhA9L6drwtlMoff2XMDfg++pWD4BHH08cmeeVMKTxnpbhDr1+Q9UkxHhvcLBKThorcnMNUyOE0YlIzQzZz3DfT2KhOwC9//lBwqF3och+1VhFN570=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132098; c=relaxed/simple;
	bh=Hqwx+WXwh8X8diMwC/nXphIY7L92VE364M+GxCNpNDk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jyRibLvsA16rhM/Gf509sDIBGjnwu9kKzV/LrHqmdtqp+ziaHDf9hdYqkUpyo3LpgRdsSlvOwQlkHgPSq5l9FaczebYrgNQAaQkYJL8SYZrJSaKLmik0D3d51/mngH/w5t+iXMGNNB//K2SHTt0P5QzyKOOEAhhESpgvfAYQJyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kHoK+zE4; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlRNeTTY0Ndp5bVuXBvyejbKVMXmn8P5lP9AlUM45up9JalTuxG8UAbyxm7KxxpLUzYttrGdqofYHzV7l5TnpdGu5AAzivhMWnmRc2Ftny+2iRs7l6EUGV491yVcjhm9S2JMOCDHdBO8BhyswOB1KpKhHwWArVOew1NBodcUkG0DnvGJ8y6jhCR1/U9Hi31JrAxyPjrKIp7QdQvTyODFYnsd9vGYv/mcZ+3pLP4U1vFRONH0o3j13+jHLBjAMrbNDwwrdTk6gUPo5XrTEAwiwTkz/qquzvvM6+3PSxbuDJz/tkaRySBpsbnmp/X7Cg/szyNAodPTuAOjmUJoUjKY1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuPEGS0+dTOwS00hxoF+qkwiKbkiPE2a3zh+RTAaVAg=;
 b=f1RLWnlJkGSAfPWTGgmmFYp8no8BHWryaol1x1ddNrPgJSw1SY9Rxwlw7VkXL/ODaIQqBrVu+60tkyUl2BHnTudDsIkY1T2Mcc3/GXyWsWc8o6fQI9WjQH/JU7sFVKtLK2VexXrz4EUCnsW4SYAMOkoHbrTK193tlTbtyCit39MSeNylHA5bhIIqbbs4GQXrlD9x/5Lm6fgdxhfGenuGYj+eNnI8wV2Bu2N8M7QYVzhmZeb8QDoyRI2OrVrbrSJJv0UotkFfKjmsSrWEOMES6nhHmcSyd9gaxGnPOxKxIJpnBmSyFnNjojerL0ZtaVlircj2P59qR4rSJ5Hmph/YSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuPEGS0+dTOwS00hxoF+qkwiKbkiPE2a3zh+RTAaVAg=;
 b=kHoK+zE4PIum+7+L4MAmejha2bmoZipZ7ET5q5ejIz3QqhcfuGLbBmEaiMq594VPikbkH23H53tJgkW5NLzIU5lDFk9WUla1Di090MUzOnkL1Z1kV1d6sqzQ46wiMsoeDrBre5Hj7BmiCNrnzXoIGXqGOwKVTAECAI1ZY/5JYKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 18:28:14 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 18:28:14 +0000
Message-ID: <e744b564-e5d2-48d3-91fb-8178344baf85@amd.com>
Date: Fri, 22 Mar 2024 13:28:10 -0500
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
 <091c5ff9-dce9-4c63-a2ca-39d570e2f0a5@amd.com>
 <b224cd7e-ebd0-41ef-b1e2-64f76d246307@linaro.org>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <b224cd7e-ebd0-41ef-b1e2-64f76d246307@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0035.namprd05.prod.outlook.com
 (2603:10b6:803:40::48) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b09db3d-7b71-43b5-5049-08dc4a9dd5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	011FMHvfyrVIp/BntQGDOv7pPOfQSHdHuSkunjzWeVbWzp3vuebhZGYk1D4h4BY+OBrg5dIyyjew2roR1LxZTXFT0fFj8Lf3CBuj9/T/TJId5rctZqLLmpjmtcJRKKzEkld7bI7dxtJ4XPYa1mKfU3U8z3VAkLfFu/eE9E3mUy2mQ1rDW65J4TfnksJcMq25DohMsCV/pVYtF0vtG3PM4StBJk0lQ63vBX5tBxas/GRI5+PnpNO05EWe2jQQCN2PwUAbRXGDE2vByyaZD+NvMcYlZ+jULUIXerGnZ4/S+21REpYxZwwB+4PZwQKlJj/ePhZZjaoY8rxJstJsGRsl4E5kjf82u9uhVSlACf3fB6DwDnAKnA+1fGDjwYzlf6x4qfMYkuUsicqOFZk2anFkTSVWxXlPEOancuViOfqxPoXm/XpXa1POMuarCnZg/jEdHJ279r5NOVah4+1Y2treXBGFI4D8nryMPIA8RfFeoJYPj6eSY+/OnrqOUEFfrZDquxF82hJGtivjw/qGmpgCEoiOGjwR5mqRrcwjNamHcDOG5L1C+Hr85xx3LNBxfDY93OVlZTz6pPtwHOugA9+E+yJzpBWw0k+mP6Ran0pQutTYbEWhA0PIsUUVV8BrcRYvIZO/1lMbpg/JMkXzDAqIyPkiydM2MDfsZGgmon4saKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVNzY2plQUNSTXdGbTBDSy9icUYyTG14ZjY4eG9WeVppOXoxZk5QOXQrKytM?=
 =?utf-8?B?ZmVxaGZVNjhnSFQ3WldZM0tJb2dTZDg1K2hQRFVSTEtrNmVscmp5em42Uk45?=
 =?utf-8?B?K28wa2NxdzltQ0VvTFU1d0s4MEpDVlZsak91eGc5SUJuUVlzQUJUVExjc0l6?=
 =?utf-8?B?Y0x2QXhxQVVXSjNidlNJaWVqY0lZYkJqN1VTK0k4aWdFV1lTVERXYVVicU9T?=
 =?utf-8?B?dDlrRWJaNTVicDlMaUk2T2VBcE9HRU4vU0pRS0FwRUZhL0oxaUxMK1ZZQ2wr?=
 =?utf-8?B?K1pKWkR0K1FFM3Zmb044UnNXUTA2VHZpbks5L1RrbkVMQVVmWlBQRndQWjM0?=
 =?utf-8?B?TGxtVE8zb25aS1hxbHJ5Y25IeXorU0YxaGs4Nk1QdEcwa1VZUi9WWmRUNjhT?=
 =?utf-8?B?ZkNTL0YxL3hXcmJhaFFJN0c5Z1dBa1lyZEk4dGZpMjQ3ZWVmcjRoK01FeWdZ?=
 =?utf-8?B?bTBOY2QzTDZuaVJtdXdMUzhubDRZWjVDRmRzVEdwVThibUV6QlRxbnVhR0ll?=
 =?utf-8?B?ZFNBQlF6VVg5R2JBUGsvb2Y4Wm82NFV6NFJIbUVaUjNBM2MrdlhFQUcra1FZ?=
 =?utf-8?B?R1hEcU1xMUhmVVkvalY0alh1MWtTNlovNHRrMDdVbzNKb1Y0VzlSaE1pVlN4?=
 =?utf-8?B?dW1HQ25kN1RCaUJuSmptanBEd3RHWDZGb0hUMW1laWZyZGJENkJoSnkzQjVu?=
 =?utf-8?B?eHNmSGhVSm1KT2c2NWFWVTBYenBGeUlzNHNYM1R6b21KV24rNWtSS2dnQ1No?=
 =?utf-8?B?WnJsWGRLaFBub0ZiL3Z6NTlJYklCRjBYV3E1YkU4ZFdYZjVhSHVXa0hrQzdL?=
 =?utf-8?B?bmMySEF2U1lNNUpDYXFiaU8zODRPYU1lYjFyMzZab1ovSW9oaTFSU1ZnZ3FT?=
 =?utf-8?B?VmlTZkI2Y0M0RWxGcUdjNE95bEZJSFZpMkRsVFMrWXluUml2NklRY0h1ZnRu?=
 =?utf-8?B?dmp2aW1XbS9ha3JNT3F1cmtWYTlBVG9qc1d3S2g0TWpheU0zNmttYzF4V1pn?=
 =?utf-8?B?dEhHR1VlbitpWG1zS01TdnUxbVJURmpLTmI5ZFpYUTlqcWVXdGlqMWtmTE5i?=
 =?utf-8?B?QU1EVFdyS2czSXEwdVlFb2F4MCtIaVhxREJtTzcrUjNlOWt1dGVodVc4Ty8y?=
 =?utf-8?B?alNGVnRzdTc2bCtzemRKMG1maFByaWtrVUVuSUFoOGJuTlJwQ2hCbmVMeW82?=
 =?utf-8?B?eUZtRE0xQnlGci8vMmZDbjZDdmNIdkdmYUc4ODh5bndDRE9FejB3b1EwNDNk?=
 =?utf-8?B?Nnp4TTRGQjhTNGpEclJuNDJrN3QwSGVqLzlZL0hXdmFELzdZeE9ycS9rUlZC?=
 =?utf-8?B?L2ZFcVZweE9HM2FuWFF1eklrd1NKT0hEU1ZYbkNpVHpvcm91ejlGYlNUY1F5?=
 =?utf-8?B?K0U5QVREUVc2TDQ3S1BBdE9XbWM1RzczZ3pJK2VSemRFdGZPbFZscFYyWDN1?=
 =?utf-8?B?ZGJSVnVvRmlDU05ja3lRQWZOdXIrd2ROdjdhQUNsYlZyb0JXVjdlRjVDYzhj?=
 =?utf-8?B?NVBMMThDZWxJRUUyWjlWZnN5ekErSU9tUStycElRUVExaTlNb1dIOGE0dzVp?=
 =?utf-8?B?QTkxSi9GVzZFTDVMS3I2VE1naDB2QUNxVmo0OEdQdlFqNFZjQ3BqMklqQjBB?=
 =?utf-8?B?Z2l4aUpVM0ZPalQ3UzJRWjJDUTFhOUFOSEJiaitXbzhxTFZVbnJqcWkwNS9E?=
 =?utf-8?B?MGZDemlqdDBicHRIcjdhR0J2SzA5TGQwWmg4ZkRyeEdEWm5icmRVUXVKTU9n?=
 =?utf-8?B?VEpXdStDOTFQUkhsTjVzbElvQklCTDJkU0tTcGFBU3c0MlhTakhDeTcyNk9t?=
 =?utf-8?B?YXdEQ3Nwa1pqSlZOQ2Ntb0t5TVBpWWdOcTIxaFovY0N0ODE5K1Z4M05jdUI5?=
 =?utf-8?B?SERKcktwUmdrUytjajhaRmdnL0puaWYwM0JUbDdGeVlHU0NhRFJQdHgwZG1p?=
 =?utf-8?B?dVNvRXBMMkc2WFU2VEZaaWhxUWhOV2hKblZqRUN4eE5oUkoraFhUSUNiaVZo?=
 =?utf-8?B?ZmpuSXdFRVhGQ05KbFF2UmVITFdtOVIvazFURUloRmRqSXBMRGJ3NlcxVFZJ?=
 =?utf-8?B?aXNSbDgremxkRkcySDY0K2dDMFlQRlJybnlIQ3BSaGJibEhkak5WTUdsYnA4?=
 =?utf-8?Q?OkKsrQduhy1iEuPxopY/JlosS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b09db3d-7b71-43b5-5049-08dc4a9dd5c5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 18:28:13.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVx9bd2tddfr9igRoWn9WDKoL8Py6j3SZ5E+KEy1CqJoMWpPBkMZtbeKnk5XnFos
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295



On 3/22/24 12:44 AM, Krzysztof Kozlowski wrote:
> On 21/03/2024 16:13, Tanmay Shah wrote:
>> 
>> 
>> On 3/21/24 2:39 AM, Krzysztof Kozlowski wrote:
>>> On 20/03/2024 16:14, Tanmay Shah wrote:
>>>>
>>>>
>>>> On 3/20/24 2:40 AM, Krzysztof Kozlowski wrote:
>>>>> On 19/03/2024 15:42, Tanmay Shah wrote:
>>>>>>
>>>>>>
>>>>>> On 3/19/24 12:30 AM, Krzysztof Kozlowski wrote:
>>>>>>> On 19/03/2024 01:51, Tanmay Shah wrote:
>>>>>>>> Hello Krzysztof,
>>>>>>>>
>>>>>>>> Thanks for reviews. Please find my comments below.
>>>>>>>>
>>>>>>>> On 3/17/24 1:53 PM, Krzysztof Kozlowski wrote:
>>>>>>>>> On 15/03/2024 22:15, Tanmay Shah wrote:
>>>>>>>>>> AMD-Xilinx Versal-NET platform is successor of Versal platform. It
>>>>>>>>>> contains multiple clusters of cortex-R52 real-time processing units.
>>>>>>>>>> Each cluster contains two cores of cortex-R52 processors. Each cluster
>>>>>>>>>> can be configured in lockstep mode or split mode.
>>>>>>>>>>
>>>>>>>>>> Each R52 core is assigned 128KB of TCM memory. ATCM memory is 64KB, BTCM
>>>>>>>>>> and CTCM memoreis are 32KB each. Each TCM memory has its own dedicated
>>>>>>>>>> power-domain that needs to be requested before using it.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>>>>>>>>> ---
>>>>>>>>>>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 220 +++++++++++++++---
>>>>>>>>>>  1 file changed, 184 insertions(+), 36 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>>>>>>>>> index 711da0272250..55654ee02eef 100644
>>>>>>>>>> --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>>>>>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>>>>>>>>> @@ -18,7 +18,9 @@ description: |
>>>>>>>>>>  
>>>>>>>>>>  properties:
>>>>>>>>>>    compatible:
>>>>>>>>>> -    const: xlnx,zynqmp-r5fss
>>>>>>>>>> +    enum:
>>>>>>>>>> +      - xlnx,zynqmp-r5fss
>>>>>>>>>> +      - xlnx,versal-net-r52fss
>>>>>>>>>>  
>>>>>>>>>>    "#address-cells":
>>>>>>>>>>      const: 2
>>>>>>>>>> @@ -64,7 +66,9 @@ patternProperties:
>>>>>>>>>>  
>>>>>>>>>>      properties:
>>>>>>>>>>        compatible:
>>>>>>>>>> -        const: xlnx,zynqmp-r5f
>>>>>>>>>> +        enum:
>>>>>>>>>> +          - xlnx,zynqmp-r5f
>>>>>>>>>> +          - xlnx,versal-net-r52f
>>>>>>>>>>  
>>>>>>>>>>        reg:
>>>>>>>>>>          minItems: 1
>>>>>>>>>> @@ -135,9 +139,11 @@ required:
>>>>>>>>>>  allOf:
>>>>>>>>>>    - if:
>>>>>>>>>>        properties:
>>>>>>>>>> -        xlnx,cluster-mode:
>>>>>>>>>> -          enum:
>>>>>>>>>> -            - 1
>>>>>>>>>> +        compatible:
>>>>>>>>>> +          contains:
>>>>>>>>>> +            enum:
>>>>>>>>>> +              - xlnx,versal-net-r52fss
>>>>>>>>>
>>>>>>>>> Why do you touch these lines?
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>>      then:
>>>>>>>>>>        patternProperties:
>>>>>>>>>>          "^r5f@[0-9a-f]+$":
>>>>>>>>>> @@ -149,16 +155,14 @@ allOf:
>>>>>>>>>>                items:
>>>>>>>>>>                  - description: ATCM internal memory
>>>>>>>>>>                  - description: BTCM internal memory
>>>>>>>>>> -                - description: extra ATCM memory in lockstep mode
>>>>>>>>>> -                - description: extra BTCM memory in lockstep mode
>>>>>>>>>> +                - description: CTCM internal memory
>>>>>>>>>>  
>>>>>>>>>>              reg-names:
>>>>>>>>>>                minItems: 1
>>>>>>>>>>                items:
>>>>>>>>>> -                - const: atcm0
>>>>>>>>>> -                - const: btcm0
>>>>>>>>>> -                - const: atcm1
>>>>>>>>>> -                - const: btcm1
>>>>>>>>>> +                - const: atcm
>>>>>>>>>> +                - const: btcm
>>>>>>>>>> +                - const: ctcm
>>>>>>>>>>  
>>>>>>>>>>              power-domains:
>>>>>>>>>>                minItems: 2
>>>>>>>>>> @@ -166,33 +170,70 @@ allOf:
>>>>>>>>>>                  - description: RPU core power domain
>>>>>>>>>>                  - description: ATCM power domain
>>>>>>>>>>                  - description: BTCM power domain
>>>>>>>>>> -                - description: second ATCM power domain
>>>>>>>>>> -                - description: second BTCM power domain
>>>>>>>>>> +                - description: CTCM power domain
>>>>>>>>>>  
>>>>>>>>>>      else:
>>>>>>>>>> -      patternProperties:
>>>>>>>>>> -        "^r5f@[0-9a-f]+$":
>>>>>>>>>> -          type: object
>>>>>>>>>> -
>>>>>>>>>> -          properties:
>>>>>>>>>> -            reg:
>>>>>>>>>> -              minItems: 1
>>>>>>>>>> -              items:
>>>>>>>>>> -                - description: ATCM internal memory
>>>>>>>>>> -                - description: BTCM internal memory
>>>>>>>>>> -
>>>>>>>>>> -            reg-names:
>>>>>>>>>> -              minItems: 1
>>>>>>>>>> -              items:
>>>>>>>>>> -                - const: atcm0
>>>>>>>>>> -                - const: btcm0
>>>>>>>>>> -
>>>>>>>>>> -            power-domains:
>>>>>>>>>> -              minItems: 2
>>>>>>>>>> -              items:
>>>>>>>>>> -                - description: RPU core power domain
>>>>>>>>>> -                - description: ATCM power domain
>>>>>>>>>> -                - description: BTCM power domain
>>>>>>>>>> +      allOf:
>>>>>>>>>> +        - if:
>>>>>>>>>> +            properties:
>>>>>>>>>> +              xlnx,cluster-mode:
>>>>>>>>>> +                enum:
>>>>>>>>>> +                  - 1
>>>>>>>>>
>>>>>>>>> Whatever you did here, is not really readable. You have now multiple
>>>>>>>>> if:then:if:then embedded.
>>>>>>>>
>>>>>>>> For ZynqMP platform, TCM can be configured differently in lockstep mode
>>>>>>>> and split mode.
>>>>>>>>
>>>>>>>> For Versal-NET no such configuration is available, but new CTCM memory
>>>>>>>> is added.
>>>>>>>>
>>>>>>>> So, I am trying to achieve following representation of TCM for both:
>>>>>>>>
>>>>>>>> if: versal-net compatible
>>>>>>>> then:
>>>>>>>>   ATCM - 64KB
>>>>>>>>   BTCM - 32KB
>>>>>>>>   CTCM - 32KB
>>>>>>>>
>>>>>>>> else: (ZynqMP compatible)
>>>>>>>>   if:
>>>>>>>>     xlnx,cluster-mode (lockstep mode)
>>>>>>>>   then:
>>>>>>>>     ATCM0 - 64KB
>>>>>>>>     BTCM0 - 64KB
>>>>>>>>     ATCM1 - 64KB
>>>>>>>>     BTCM1 - 64KB
>>>>>>>>   else: (split mode)
>>>>>>>>     ATCM0 - 64KB
>>>>>>>>     BTCM0 - 64KB
>>>>>>>>
>>>>>>>>
>>>>>>>> If bindings are getting complicated, does it make sense to introduce
>>>>>>>> new file for Versal-NET bindings? Let me know how you would like me
>>>>>>>> to proceed.
>>>>>>>
>>>>>>> All this is broken in your previous patchset, but now we nicely see.
>>>>>>>
>>>>>>> No, this does not work like this. You do not have entirely different
>>>>>>> programming models in one device, don't you?
>>>>>>>
>>>>>>
>>>>>> I don't understand what do you mean? Programming model is same. Only number
>>>>>> of TCMs are changing based on configuration and platform. I can certainly
>>>>>> list different compatible for different platforms as requested. But other than
>>>>>> that not sure what needs to be fixed.
>>>>>
>>>>> You cannot have same programming model with different memory mappings.
>>>>> Anyway, please follow writing bindings rules: all of your different
>>>>> devices must have dedicated compatible. I really though we talked about
>>>>> two IPs on same SoC...
>>>>
>>>> I agree that Versal compatible should be added, I will do that in next revision.
>>>>
>>>> For ZynqMP case, it is two IPs on same SOC. In lockstep mode and split mode,
>>>> same SOC is configuring TCM differently.
>>>>
>>>> How this should be resolved for Versal-NET ? Driver avoids such TCM configuration
>>>> for Versal-NET.
>>>
>>> Binding should describe the hardware, not what driver is doing
>>> currently, so the question is: does your device have such properties or
>>> not? Anyway, you need compatible per each variant and each SoC
>>> implementation.
>> 
>> Thanks for reviews.
>> 
>> Okay in that case I believe I should add one more property to current bindings for TCM
>> configuration.
>> 
> 
> I am not sure if you understand how IRC works... You sent me message on
> IRC about this topic and shortly after you quit. So how am I supposed to
> send reply? IRC does not work like that...
> 

Yeah, I am referring related documentation on IRC.

>> From our discussion I conclude to following next steps:
>> 
>> 1) I will send Versal and Versal-NET support as part of previous series (v14) so we get
>> bigger picture in the first place.
>> 
>> 2) Add separate compatible for versal platform.
>> Use device compatible string to maintain
>> backward compatibility and not machine (root node) compatible string.
>> 
>> 3) Add tcm,mode property in bindings and each device must configure TCM based on that
>> property only and not based on compatible string.
>> 
>> 4) Versal-NET will disallow tcm,mode property in bindings as no such configuration is
>> possible for that platform.
> 
> I really don't know your SoCs. What about Zynq? You keep using here
> names all over the place, but I am not Xilinx maintainer.
> 

Zynq doesn't have Cortex-R IP so this driver isn't needed on that.



> 
> Best regards,
> Krzysztof
> 


