Return-Path: <linux-kernel+bounces-68349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D685791A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A1D1F255DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8698C1BDE6;
	Fri, 16 Feb 2024 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fCJxgZ2C"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6D1BC37;
	Fri, 16 Feb 2024 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076570; cv=fail; b=GdSP4h+EX9JEYSZA5D4ev8co785kCOvgdLAldDc7iCez/686pRdEC5DhHUCyssicHXgs0VTYSPdVbq5197fzAbDHj9HDwi7HDrXert0CmNm2rJH8fLqHBO/CW8Qi+5vIAi/QP7E6l0ssPD4w9suLjEm+Ax6D6rWcCH0shizAsbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076570; c=relaxed/simple;
	bh=BK4k2hn1dqKlzYnBOyAng/gM46rlAewyNjqvV1mkL+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eq5OpLsubYHsCN5k4t86waZp//yGlFjhrr8GSFfOaTZ3P1E8U0ST55MYJ2V+tfqmN0nTMFyyBw1+SfHsrBttsuTL5TDUyB+qai7Toc5e4J+PhvucJZ7YLw6yTLoLLZqa6hZp0xiPl2vigPKDxFMEXmGtZPX3E8UVm0TgN4z+PgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fCJxgZ2C; arc=fail smtp.client-ip=40.107.95.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKXuiTN3ozxyD7DGO15k7BHAY6P1xR8m7F0tWcZnUpjvKsMLKXKVyMjQwnme7EZBYMzP8b9yjiv4s5VLPnGAsyc/H8EqntHeU05eg/xBr+asGdr+U5SxvESQ8OP2y5jIKuBmwCh1GB+LzN7DevEV0sFH75c3cnh7PMtqDMaU0CU8VX7s1M0fIdU48qSNM+/7dQPJQQ2qZHHkLeIjX75L+tk+s8d9UUq9T8o7Oma3PhjbAv2FogUwH80UoRfJDvizE9QEV6EUuO31OJBAO5I6C84pHLVVO/GGuVSSFyTQqJntgTUeIhPMolZQ9SEXS+sSqQ+9k8BK9l7T54y9vHuLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIKO1my7v6sbPuRBpKJY2RiYsLv+qzPSZtWjSDKhZPI=;
 b=H7tG4GcudYjaUykczP+nP5jSuyHwnGDSF8qIGXCWGS4i+a2jW5HegnS2aZgRdprxcvNoMNWWcwdbGUh6RAMPaQiHrxgRHo5+67JbMGxzSC7MWJhliqgqYUlYYJ+ZCZr8HJ0OWWCAlEf8gJiQZI8tTltMLDJo+bChCOBQ0XsWgfbWjYAn4Z0MzrIbp0/919uNOfiiXvMJMyF9VxGOdbuqx1/heX0eLNxNAGzJH2mHCzI/jE5nxQXdJcVWEEyxvugY37AecrO/yfbBCi3QPCyLfgHg96ZY+bRQHJX4NfiyylkXPbAO7tRMP1vWQbKUHAjrEOGce35k1bB4ri4edi/sPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIKO1my7v6sbPuRBpKJY2RiYsLv+qzPSZtWjSDKhZPI=;
 b=fCJxgZ2CeT70cvPfaO/M6bVZxJgKgAQsIXmuVUBF1n65sUtYmkJ2NwiaKJvklk7qG1gn+gtKQaUGQyYcN8diXaKc7MLeBzqdAI2K75GJbZTRJOsxgLT0ldFpOPNiGVyvYMhgrRtXkHPkx+fNMOv7oQtnK/4TdW+dVVopLFwXbuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Fri, 16 Feb
 2024 09:42:44 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97%4]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 09:42:44 +0000
Message-ID: <ed59671f-6e0b-45a2-bae7-38f7b4b7e625@amd.com>
Date: Fri, 16 Feb 2024 10:42:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains property
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
References: <94726c90ff519185767475f672d70311472ea925.1708073513.git.michal.simek@amd.com>
 <5a81f16b-8ece-4263-b424-4dd6cd6e386f@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <5a81f16b-8ece-4263-b424-4dd6cd6e386f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0027.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::40) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 33093986-2e24-4f28-be4a-08dc2ed3a059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jVk5fLr1ZuueXDb8eP311PZ0VPGPbOY34UANPAhBVOhpfCI49EkYhgFOINFAKkVpI4r463qqF5XofbGQ35R0s82zyXYi2KgmCkfemACPDdJcbr9f2U5xPoYxE7fnWQTmDYFOPwpV0nG1APjPiaPluMkPyqkyJ82kp7RcBaYjN8lNHpigbEuAHGUSqiybp5zRqV7Ql0N0zP7bSy95LaIJ0fjESv/ZhjJbznEBKC6Vh0DSk+VBc4y8RR7/lEgw3jIAtMMLIzEjVbMkU7ObJDUWN0Per0HeDsuFXJwjYVqIbFphpi3vuM3FGJ1/pa2SOXFhMgLY+jnwt6JCeZZadc/DPaI1NDIVFV7q4znTLBUNdnwD1HfB5eBjMIOzWBmYxfScFIlsGvhFO+SteMOq+nDP8nnorZkCNpzssd4OO0PZzm+N0pB1XOXrEaa8hoSlZ45ivPMJz8ndYyFDx8ChB8ZE6FVBW+5GwhdU03nAI5RYi+BBnWO3zQbKO8G1bHdIFwdqFQzzfPN3tuwrsaiziHIb57vuEb416U37nNiu36riKf0ReOK3oxjsafLYdbfxbHBv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(7416002)(4744005)(6512007)(2616005)(53546011)(36756003)(478600001)(6486002)(26005)(6506007)(38100700002)(31696002)(86362001)(6666004)(5660300002)(4326008)(8936002)(66556008)(66946007)(66476007)(8676002)(44832011)(316002)(54906003)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N001TktwbWhtUGdSektaaEFDMkpLOXVmdFJ3TTY1eW5Lby81emNZMHpPRi9i?=
 =?utf-8?B?MXBVRnpDVXlmcDJpeGNESXZJMk1uemxacHBFaThhMnpZOEZtczhXMUZ3SXUz?=
 =?utf-8?B?M0tpditmckNiQlJWc1h1VlEreEV2SityeGtpbFJSRC9SQ2R1QURFV0lJYk5n?=
 =?utf-8?B?dkZMOU43cFQrOXV6TWNOQUdlaC91Ym9QeFhLTHlwVzJQZ0xiQm02RVhlbjNm?=
 =?utf-8?B?VTBhbmxJVHZ5TGgrQlZhUWg2TnFUQ3RudzFiS3lWZnRiekpwbWJZNUFHOG1P?=
 =?utf-8?B?TDYrOWlDY0t1SE15anFXdHRwQkVFTGZhTTV2a1M2d3RrdzVWQmx6d2lCWERK?=
 =?utf-8?B?TGpzakZMYXkxU0tkVlVJb2t4RTNrSFYzanZuQUNISTZ2OGRvb2hmbzZaM2wy?=
 =?utf-8?B?ay9TMU5SMXY4S1c0L2V4cktjODNaNGtERnpycWJkSlJmbGREZk5GOXFvbGdn?=
 =?utf-8?B?MTk5R0phZTU4bXBFVmw1am0vSUQxdER1dWNUYm1zZEtTb3lFVTkvZGJuaTFO?=
 =?utf-8?B?SmxPWTRNa0xvdldSTkpqSDB1ZHdaSkxRcGJkb1Z0bGdBbGw0MFJOOXUrcFA3?=
 =?utf-8?B?c253MG5QTmhBYjFFczNlUjV1SGsvZTJyWENtYXdyTEpJZldrUytiOTJCbyt3?=
 =?utf-8?B?MzdibmtaRjFicjRWSUJUWktlWlpFWnBBWUxuemltNk8yVTVYSFhTOWlsY3RP?=
 =?utf-8?B?YU1GcWp6K2hyYlVOaDlPbmI1bUhzaDVxZWxCUnNLdGVLUG5WMmFGUlBkaVBK?=
 =?utf-8?B?Zkc3TjJOeTVETDZmb1JVWmVMVS9qRTQ5QjUxQlppRmFZbUNhSjdqdFJUWlU2?=
 =?utf-8?B?RGJ6dlh3aUhxaUViSWxqN2dvaEFiNUJLVHRTczcxSEdsL0N4SUVYeUtRMCtn?=
 =?utf-8?B?eGFMZjVLbGJvTjMvMzdRVTBXY0tQeVlrMWZZbEFlWjRtQXYvamkyUmRma1A3?=
 =?utf-8?B?RWcwSGVuMi81MTJ2dU5HN0NralZqL01DcFYyUGhLT0U2WHpSMERvTEIraDZN?=
 =?utf-8?B?VUpWS290MlZkdnRta2p4eTZYU1R1bWF2d3JqckpXWHE4YnRncFRMUWJTaUlS?=
 =?utf-8?B?VWdOa05pOFhuejlYOGxYdTVMeWdjTEhyTFZyaTl1Sm9Nb0lRMm5VOEJORHpH?=
 =?utf-8?B?WjYxOENSL2I1dFdBZzJsck55MUkwaVBDRzRZdnJYWGhPa2ZTeUIrT0pBL0ly?=
 =?utf-8?B?NEZWNXRYZjlpWXdJb0RSTm5MN3NOMHQycEQrRGtPMnlIVHE2czdlLzlIM3B3?=
 =?utf-8?B?ZW9veVN2c09XME8rVkFKaUsvRE45V2R6NGNqb3NRb0xIRTFPODFNSmhBVG5D?=
 =?utf-8?B?L3FmY3lyZ3ZjVk1kNWZNWWkwZUczS240YnJ6WE5XY0hwdkJjR252UytRVkJ2?=
 =?utf-8?B?ZlFDV0R4NlZWU0lScE4vNFZ6eVBDMm16cGprMzhWVGYydCtaMlBoUjZ2aXRN?=
 =?utf-8?B?MWlGVUVuSnFPRVErSzgxaVY4WGo2ZWhWWTdGZDZaRWFQWTZFZ0hUanBtRFJ6?=
 =?utf-8?B?STl0ZXYvQmpuQTdLNk1jT0NFVThSeHk2RFdJeUVhblkzRzJZRlpKVVlWbENN?=
 =?utf-8?B?cE9ubDhFTi93M2VkcmQrc3dhS1pFcmtmSVovWm9RUEtaOUU3ME5wQjczVDBC?=
 =?utf-8?B?ZW5FMGFKZDV6WENoVjRpclU4cS9kTkxGUjFUdjkzRUs0aHAwYXMwSnFyMnlQ?=
 =?utf-8?B?elV6b0hMaWVKR2xPWWtNWDQwSzdCTytmWVpRQzZBU1BHOXlNUzVib25KUHB2?=
 =?utf-8?B?STd4SzdxQ1F1aDNaWEtUZmVnU1JZSnFIQWRwRXBTRHVrWUV3OHpmeDBsc0Jo?=
 =?utf-8?B?ZkVLZHV4N2J0RnM3aUErbitmUWdvbXI0Vk1idVdDT3lMRXF1NkdKTkxqZmRW?=
 =?utf-8?B?MGhQWHFQWHVZWnU1MFZTMGNXN2xQY1VjdDRNV1RFTEN0ZXVjQmdscFVhK2FO?=
 =?utf-8?B?cXorMXRib3hJd0w1VzZvTnBZUlNOalRPYkI0TjNZUDRWNFZaUjNQV1VuQytX?=
 =?utf-8?B?TTQ4eWliV0owdVMybkZyVEp4QVVkbVA2THZsWnBEVVFVd0VNbmVQRWxqYkxp?=
 =?utf-8?B?OFJlUFN3R2xjYVRmcTl5a2NLQmcvbWlobEtIR01pQXZoYUZ2VHJ4cmR1eVdC?=
 =?utf-8?Q?bTcMElgWnsyB/xt87IzyPPTEh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33093986-2e24-4f28-be4a-08dc2ed3a059
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 09:42:44.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxmJx02YinwrJ1A7K5DyTZiOezFipNsEGmUUufkz9JKY9Ec3xiyoh6nTO3OvKcQd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210



On 2/16/24 10:19, Krzysztof Kozlowski wrote:
> On 16/02/2024 09:51, Michal Simek wrote:
>> RTC has its own power domain on Xilinx Versal SOC that's why describe it as
>> optional property.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
> 
> But Versal is not described in this binding, is it? I see only one
> compatible.

It is the same IP only as is on zynqmp with own power rail.

Pretty much with different firmware interface on zynqmp you can describe it too 
(and doesn't really matter if it is separated in HW or common for more IPs).

Thanks,
Michal

