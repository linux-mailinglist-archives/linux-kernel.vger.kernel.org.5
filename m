Return-Path: <linux-kernel+bounces-72913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B8F85BAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78841F245EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0116E67754;
	Tue, 20 Feb 2024 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BmRZp118"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FCB664A5;
	Tue, 20 Feb 2024 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428875; cv=fail; b=LxiSk0rZeu0wjCs65FucvxFZOTaUY166TyaEU+fdGoGWOE1rWIEz56DvmKeKI/p+Z9bL7zp61lzUNv19vRIHm8sR9vF85Pwk/PAIMFwkY3Vsfx+hu8pBKfMvC8mNOO2dmc8tePWCVcugivWzpvRNAo6AFkqo1bHbmYgkzSjuLjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428875; c=relaxed/simple;
	bh=fC6Lqmunjj2Tc/f/X8DDqasm19/+N8pPfh03Bj0e13k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TdhzrY/5XTrMzm8TkN+lCAheP22ZmNQqNMUQXCD28BTj9TASAToZwX1W7VRCKLRTSnEpDFr7GppTn8GiwXaC4C70JRuvzkwavFSNQkyhJ0EkcVFKDoptBUZyUlAfLRJ3MxpU5d51wfpbMYNr/CPxwgXnBB32+Sv7HmmdtSEK0eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BmRZp118; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOCQLth4JZB0HSrLRYNo5iTQty0D3YmnR4W59bE1TccPMTCmXzCbabiFy6iO+jkQSW7DsCW4baEs3F4b/L1jfyUdUqE2vvtyMudJbZcYwOMbpXvef6t2aY7Jf4fK+k5e5tAA63BmkQ7w4eJ/kqqkBwLTV6qfkIOuZ33IhHqHCS2v+eOIHZ/rApqxw9curzn1LUY9Dp2OVwWvymHeDKAFJaQGvcs64v8oGbCFLQb9aXPmzDFkGDcKmX9OXSzNNk3pv8pv32AB4YMHM8995qFopAaU2hu1/m1+X1L/bdQTMiNZvNx1OtNtlbmZJPemOS85UCl+yKOWxGoER5KcTEPOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9liMcf+q02E79vZScwE/CmBNOznPVbbo9UMfi1QGmZU=;
 b=P7P/wU34vg9MdibvDX2DxywAnXFieQ4+NVvrO4eVXCwc8752w2pEDFtwqYWGMriDGf91p90aJcUSWt2R9Ce1VUqi8ENLhLPempefuxVHYQH0NWrWRCJLV330TwzxNT6Uy8dlMmBdy2F0U/Zs4uk8e6c6g+MCZRzP8vJJQYgG4ymbgaoErJiAl5UGjxi5rl4oW7fCfEReHGGtF7MgThwwbQLn9nxaK6CB67rArQFShKv+KzA/xB4Y9KcPMQGGCjVFjXuBxbMrvcRoTMZkVLeL2HtnthlL05xQmPR9rmLPxFUpURfXJA7yY14FtKuDDBTlRRAl8n+bnQsC/JB7RcxVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9liMcf+q02E79vZScwE/CmBNOznPVbbo9UMfi1QGmZU=;
 b=BmRZp118jgFnXf3E8yBiCyvuxUh6v6eNgwkeBWUxB4y6CPKLE7x3ajr3K6AE0lCh3jHxgNxD6+sSMkZGDp5w5WiJlQJ/FwWBjSzP0OTG71+kFk2UIbyPRpquZ4J7owsoaVo97wVWLJ1KSUpgznOQRcg923WNaJwMeSsKVgGOWhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Tue, 20 Feb
 2024 11:34:31 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::84b1:5355:e3da:dc97%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 11:34:31 +0000
Message-ID: <74cfdded-be3a-4af6-b23a-eea2c5e748b8@amd.com>
Date: Tue, 20 Feb 2024 12:34:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains property
Content-Language: en-US
To: "Buddhabhatti, Jay" <jay.buddhabhatti@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "monstr@monstr.eu" <monstr@monstr.eu>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 "git@xilinx.com" <git@xilinx.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>
References: <202402192019160b9c4120@mail.local>
 <DM6PR12MB4465FAF7AB3F9CE15FAC6C879D502@DM6PR12MB4465.namprd12.prod.outlook.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <DM6PR12MB4465FAF7AB3F9CE15FAC6C879D502@DM6PR12MB4465.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0053.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::42) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 157af0e4-75ee-48cc-d866-08dc3207e7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k4yZIdwdZG2aBjuMMppIT/VN6dZtDT+/u17HFIQ0aTK0W74WYnVHKEcpYuL+FdL9w/0mEjdmr+9xj1UMQuaM8gJeVyHbsCD7xmtLAOm6EUh1SZ8mgolCQ+Zgzzy8EwyyVmcMFPRgxuRJ4Y+2tEzUo/UnlDMDyZhB9CXmTxb8rT50Eg82Ms5GqWdI86ErwjK9vhWkZd8oAYoE4cVhrzGTthqotccU1QgQ/Xg5vAVMrOaWJ6CR0hJ0zoMaOrKOB7/1mHNi8BkPXKn1tKNPmmZkfeQIKXljYCoS/kVORpKEPHRNSVSMbZMkMmt9RhdfeZckf6bAK2b67/OOn85tY9qbY6xtHMrVmyWSuLX28Q3JbB8ZS5KD8G8QFdN8TslzrArr0vcOJsWKwy7nldos+z1Mw5F+Z1B3QsxcceoY7J27GlBEQ3KoRLdkDvmA+0rzwnow3gNXt94RT7tMzpl1x+xYAWXhlMA9Q2T2hR13bFeRm5Ki8VZX97UjQnq9b9Ume04WM0lIp46TpAjbZi3uoslCyOzIaLSebbmCkFQE+Rc6gmM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTdMZlJROHE3L1RpclpxMVBwZEZZTklkTGRtRS8ybWhUMXFmQ2tOWW95OGpI?=
 =?utf-8?B?dlNjRzZtSTc5cnNTY1A5eFA3aG1UZmlGV2tMYzlXWXptSjlFVXZGMDhyeXJT?=
 =?utf-8?B?bDk4OTQ0MkMybFNTN0p5cTg0Q3M2MEU3b3NxWE8vayt0MDd2blNLaVROb0xJ?=
 =?utf-8?B?ZUV5OTFUV3BpejVFUGhSZ0x5Mi91aHdZanlTOThucGFibWRRWU9mcUN2endK?=
 =?utf-8?B?aUM5N2M3WC90Qy9hTVdXSDlkVGNQdjkxd3NkY3hoUVVOSEpIbjNmczVXcFM1?=
 =?utf-8?B?R3JjeW9od3E2aUtrT2pXak5UNitIUkNudGZnSEs2ZFc1cDl6ekRIYWl3NTgx?=
 =?utf-8?B?T1lyWEJPeDAvWkEwZjZnOXRCb3NtZ1F3N0l4VGZyNEJCOHEyQ2Z0ZnpTTzR2?=
 =?utf-8?B?b2pQcXZoUFFmU1h0VEV5bDNkSDVDNnZmMDBxVi9jMCttVXFVUUpmWDdyR2Nx?=
 =?utf-8?B?YnBmL2VFN1dJNlpXQkRtOWVQV1lENWUxUXc1b2hDc1psUm1qVUYxSEpMb0hk?=
 =?utf-8?B?S0FsYjk5THhYN0NBMHhIQUQwdnFxUlNuNnNvaUN4QWxpK1dKMWE4VnN1RGR6?=
 =?utf-8?B?a2MrN3lxK1YzTXZsaE53TXJlZDlWb0dLTXljQ1h6clp1TkpsandSbDBUQ0hr?=
 =?utf-8?B?dkFncVh6UTYvK2tCYkdLcTFQREhjdldDemFxT2ZabktwdmwzKzNrTFF3VUhq?=
 =?utf-8?B?NFpWOHQzWlhkc21sMkJPTE9VZnN6czZkdUxDVkxpSUZMK2VuT3BueG1NbUFa?=
 =?utf-8?B?Yng3Rk9qS0NXMEs1N2RQdjIyM2lkc0ZOcXhsUmVKaXhsYUl2V1pYVElralNR?=
 =?utf-8?B?aWg5Rmk4NXF3TDBoODBMWWVuZVNvK0VQbGlJelNBTUNuVTBhemJ3enorOU9W?=
 =?utf-8?B?aW01NmNYWUdSZEE3aGpQb1pSK1FmbUxpOTdVTXRGQnBLRk4rV05DK2tCQmw4?=
 =?utf-8?B?SE5pdExoQmhPWXlHQzZrVjgrZFk3QVpsQ2tYVnNGaysvUGpyTDRhVW10NC9H?=
 =?utf-8?B?N0hVQ21WZm1JZm1iZDMwZE00dE5BOGxya1RYcjdlbGNaT3NNNmtQeDMzd0tn?=
 =?utf-8?B?ZHFVN1BIT1VQNGpHMHRNSEQxNmpTU1NIQjRUZFNrWHZJVXJia2ErYkxYdkVy?=
 =?utf-8?B?aHBkNG4xNGF1dHVoOWdiTUdYRHhBTTk0d21QV1htOExVOE5vOGVxNEh1UFFi?=
 =?utf-8?B?NzlNbUZzaHpXclNBVVZ5L0ZpclJIcmMyU0duN1ErLzRQbnJ3TU5FWkVQMUFD?=
 =?utf-8?B?ZnFJYmlQUU8vcGtScmhCS3dwL2pSTkVqVEpIRjN5SDI0SHkyeldhSnp4bnBo?=
 =?utf-8?B?N1A1Um5uRFlRREFzWlkwTzR2TzkvTnlwOWlObVB3QktLbjIwR3JNUjlTUkJQ?=
 =?utf-8?B?WUsrKzRjNWxnVFBGeS9PVlVkcUdPMmJhYlVPOHZ3NmQxcElaVWxWcEFvQXVi?=
 =?utf-8?B?bElrN0lWeW9XVHJzT25VdW5IK2Z2WWt1Yi9BN3pEUmVGKy9mbWd6OTVRSC8z?=
 =?utf-8?B?ajdZV3ExV3JYZE9QLy9GU0hCVEVKRkdYY0ptbElmVDlHOTFvdTN1MW9qZU4v?=
 =?utf-8?B?WVRmTEM4RnFZbmVEVXA4a2hsVm02UVVLNklycnFaSFhGWDhHamIyZ0dNcjZi?=
 =?utf-8?B?MjhWMmYrU1Y4bG9NclhSMHJLaDdWZXM1QXkwN3VwbWlwdE5VSGxDbDBVMWdC?=
 =?utf-8?B?KzRlYmZ6MjE3M0d4b0hPaFA4c0tYY0p4MUUxaExkQko3NFhHWk9OdkNNbWsz?=
 =?utf-8?B?ZHRZRGN5N3hLOVVIUnBmQVE0Tkg4OUVLekc5RUNzMDRMSWhtUUhvdWV6VXFF?=
 =?utf-8?B?dW1SVFFwYXU2MXRPWlNxekR4cHhEUE5xVit4ZDJVcmYvTFhUQ2hZTFZTbTlN?=
 =?utf-8?B?YlQwRmg5eWl6eE1TM0hRRThXN2pGbE01anVLc0Z1c1JTUlFETHhlUlRzYTJ5?=
 =?utf-8?B?a2pNQjRPMmVKZXhoNHdFUllMSmYvUlNvVkh3bXNISWJneHUzTi9YNmVLMnZB?=
 =?utf-8?B?ek1VSVhHYk44bjczRkRFT2JwNWFkUnhIa0FVK1JoVDBpQmhSdkpISTI5ZVQ4?=
 =?utf-8?B?MW5abzh2dENxNTdaU1RlWHFiUHEwL05QQW1SRTErWDhyUk5OMy9POEUrT2dG?=
 =?utf-8?Q?Bn5Jr4tWngVwsmwdx6BBpXjtU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157af0e4-75ee-48cc-d866-08dc3207e7cd
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 11:34:31.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrYVBeSEOAJQe8GbEXTnn5vaN3kP3OK+1eeA8hsLCvYckQ7AtR/f5WXS7qbFn66d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806



On 2/20/24 11:51, Buddhabhatti, Jay wrote:
> Hi Alexandre,
> 
>> -----Original Message-----
>> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> Sent: Tuesday, February 20, 2024 1:49 AM
>> To: Simek, Michal <michal.simek@amd.com>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; linux-
>> kernel@vger.kernel.org; monstr@monstr.eu; michal.simek@xilinx.com;
>> git@xilinx.com; Conor Dooley <conor+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Rob Herring <robh@kernel.org>; open
>> list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
>> <devicetree@vger.kernel.org>; moderated list:ARM/ZYNQ ARCHITECTURE
>> <linux-arm-kernel@lists.infradead.org>; open list:REAL TIME CLOCK (RTC)
>> SUBSYSTEM <linux-rtc@vger.kernel.org>
>> Subject: Re: [PATCH] dt-bindings: rtc: zynqmp: Describe power-domains
>> property
>>
>> On 19/02/2024 14:11:50+0100, Michal Simek wrote:
>>>
>>>
>>> On 2/17/24 09:26, Krzysztof Kozlowski wrote:
>>>> On 16/02/2024 10:42, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 2/16/24 10:19, Krzysztof Kozlowski wrote:
>>>>>> On 16/02/2024 09:51, Michal Simek wrote:
>>>>>>> RTC has its own power domain on Xilinx Versal SOC that's why
>>>>>>> describe it as optional property.
>>>>>>>
>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>> ---
>>>>>>>
>>>>>>>     Documentation/devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml | 3
>> +++
>>>>>>>     1 file changed, 3 insertions(+)
>>>>>>>
>>>>>>
>>>>>> But Versal is not described in this binding, is it? I see only
>>>>>> one compatible.
>>>>>
>>>>> It is the same IP only as is on zynqmp with own power rail.
>>>>
>>>> Then you should have separate compatible, because they are not
>>>> identical. It would also allow you to narrow the domains to versal
>>>> and also require it (on versal).
>>>
>>> I can double check with HW guys but I am quite sure IP itself is
>>> exactly the same. What it is different is that there is own power
>>> domain to it (not shared one as is in zynqmp case).
>>>
>>> Also Linux is non secure sw and if secure firmware won't allow to
>>> change setting of it it can't be required. I am just saying that Linux
>>> doesn't need to be owner of any power domain that's why it shouldn't
>>> be required property.
>>
>> I guess because the integration is different, you still need a differente
>> compatible so you can forbid the property on non-Versal.
> 
> [Jay] RTC has its own power domain in case of Versal and ZynqMP both that we double check it.

Thanks Jay for looking into it. I should definitely update my commit message to 
reflect it. Do you still want me to create soc specific property?

Thanks,
Michal

