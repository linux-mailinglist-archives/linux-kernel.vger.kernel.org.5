Return-Path: <linux-kernel+bounces-37370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8783AEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDB31C22D23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B77E785;
	Wed, 24 Jan 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="WuVEICY1"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C827E780;
	Wed, 24 Jan 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115440; cv=fail; b=GZEJNVuEGOjkqAA9rH6/XK+bmAzY2LMMjBhXKgw9zv+owV6AYT5+MIzulMyGb/beu768vFJCEofXJY1LG5Gqv/1EXjm5AIP0TjYOFjs8xkhg+n1kpWyQOP4O0oAs9Hx0sbMmvKqWVA74pRMFWlfT8PRHBnQnLw33/XeMS6v0uwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115440; c=relaxed/simple;
	bh=zlLUDPEJK4ccRnhmGKzhXsexemEeg5NIlTc+nJ/syRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GnsC5wCI71zGBRpHVESY+LYIn0QPxPkPgj4VrOEqmJX17EKSWqfLeB8Zg1x/xKkYq+FJyLkzow0allMpzJ23IzvCkjSB5xj9Arkjo0LeSnium5hJIltxid8bWwABvnCAZwwmIO8CT5Qoj/CEodGeqrLBwT/kJjRRpF1Q8OcTvBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=WuVEICY1; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwnlAtDqRy1HoIvKM1yfmT5UXEtRwaykYigYf6AJNNrVnEaKAM4drjQHRKd6FUv9nsMrRfwoJJyTpfutX8g4iZwWTKlWM2ieHdu85iO5tHgS9EOt9riwJnTa2MtlWF/Qmy+kfiQDsEVxpzEbZN5AioSMiJUq7q0IfW9vhlr5/cQdai1xSJZwUgLFX8Cx4qcflnwZy9i/1a4qfatbq8GjyrKkihhTCNbpePVkntAz275tO7B+yXDCVr1IgGhfOhyCloCico6gSXgUnVucWLHFNKVY6ryD1esDaYT+j9UAIPuuijIaME9LFzO7K4y4IiaCZcHyYIRjr6l4be039Rq4gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxf9P+CRBevJ2MEdaLNHEv55nbKT+Un8kqjs8/dKulA=;
 b=YiYcbKREDtS7HtpgJdXebUaqpwtK0tFZFLSduxmgQA5D+p87Br/Wes/oT393zs5LZCiRDfu8YKYpuzIbyp6MdQeD0djDMyg0Sui5GwaHjGKpeO3isTWzyY0P8LSdvn0OsVKuUvy1B/UNWDJotM2FN9njNxFXnMebyi3AeuGXsASl7l1MqtcE2r56oukm8rtPbwQmQuS1wq/xAK+oXsPhm6k3fI55yCKXJTObMrGTMbnXeqqzOW7Kyi5w71sBZXGN1OAZ0ExBOc8Gzh3FqdXxQLUZi+gtozA7dD1Rg61HjrRSNbulvXPldJygFV+pfoc8l/rBqUSBJM4jO3ubFQ0v4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxf9P+CRBevJ2MEdaLNHEv55nbKT+Un8kqjs8/dKulA=;
 b=WuVEICY1sx/VZr9jK6gGLecTkYuEfZkvtZcEpusNn61Ko2qloYA9JemJGBSB8FCwCVJD4YTK707Ugsu90u9yFeUAjayDC1YILWMQxCTXhfbzY+trjwEBDSXv1xDywgzh9JW262XpOtoAtvzq/W5hQXd+4BrRuOxYCDNJL8nq+MY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from PAXPR02MB7263.eurprd02.prod.outlook.com (2603:10a6:102:1c5::18)
 by DU0PR02MB9194.eurprd02.prod.outlook.com (2603:10a6:10:466::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Wed, 24 Jan
 2024 16:57:14 +0000
Received: from PAXPR02MB7263.eurprd02.prod.outlook.com
 ([fe80::788c:574d:7902:4a41]) by PAXPR02MB7263.eurprd02.prod.outlook.com
 ([fe80::788c:574d:7902:4a41%3]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 16:57:14 +0000
Message-ID: <f081bad4-2828-4d2f-bbe6-165ad2ba1655@axis.com>
Date: Wed, 24 Jan 2024 17:57:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: cap11xx - stop using chip ID when configuring it
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZXlCRsnOu_L8xeTC@google.com> <ZalnEZ83M0jlQI2s@google.com>
Content-Language: en-US
From: Jiri Valek - 2N <jiriv@axis.com>
In-Reply-To: <ZalnEZ83M0jlQI2s@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::30) To PAXPR02MB7263.eurprd02.prod.outlook.com
 (2603:10a6:102:1c5::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR02MB7263:EE_|DU0PR02MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c1a249-2120-4a3e-9720-08dc1cfd83e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qOyLtSuT392D5L6kImXkBoJze8+IXvc8AdfLarsxhNpIAYpvIn6ATkmtLZzXlZk+1PXOSfjNgHVqn3bco973ewL1Faj4mwSnviEDZsag6RNfj67b68LL5dDPU/2JhD0oCXLuW7J5vnbvpVj2jz/rerItTBolFaqirQ32hhcopZlTb85+MlVNkRto6XBuByOFlIu2+5m9IV1Hm4yD8RkM/5afgBV1N2XUtY92IcjP2RdVAGxAL1Pi2B2JuvSDBHSgBuVdTVbW/BO0AtKEbqywzGzurpqHlP9NqiJ0O7Fm1VCJcEwYUEr4yzhJ4Vaya9Xvv+8GCbEbqRGv3A2xrf5JlLm/HUYAvRHI/EEaziSK36w2tCC8y1f2yAdHrJrz/VfCwhRidmSSStq6jrfAsMCA2Mt7nYDlJa7iXNFZ8niSiYng7heFM8wFszPz1saKFTTJPKozTJ2tRReM/JpHkxjT0+O5GF2IC2W4h7JjL/3YszVyfwRX8eUmCEA8kYh2adrykMs24wIYFTgIux6rGZpka5gnIxqBaht46d9hU+GaxdQexJpIpgV74swtLaZzfPuOVCDJMSSDtvKLkzG90tL1oWU/Y5YS1uC1yn7P/8ggf5XV8di9vn6J4IkZMq4+Pn3ZoZTVjJf36JM9FZdjcyZ30w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7263.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31696002)(36756003)(83170400001)(38100700002)(4326008)(31686004)(83380400001)(42882007)(6512007)(6506007)(66556008)(6486002)(478600001)(66476007)(26005)(66946007)(6916009)(2616005)(316002)(8936002)(2906002)(41300700001)(4744005)(8676002)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1hSYnljbEY2cE4xc0RtL3dUT294Lzl5R1NxSzJzakV1Rk9CSkRlSk4rZlVi?=
 =?utf-8?B?U3ZocWtkTDB0ZUdMdkRpUllFc3o4TGEvUkloajR3M1pydC83ZXhKb29MclZ0?=
 =?utf-8?B?NWxNbHdRSWpxNDNTdjduOHo3Wjc4T1NqOHRRWnFpcjc3MlI2V3Y2TlRYMXA0?=
 =?utf-8?B?TWNia2lqZGwvdk9aMFlpdnA4K3JYNUZVVjF2NGltZGJybTVlS0dORXUwMXZC?=
 =?utf-8?B?eEdrUDM5K0UxOWxEaDIwMG9PMHh0endkS2VVUXViRlF4ZkgrbFlLU3FJQ0ZY?=
 =?utf-8?B?cUdLbjVSSlZNU2daTFZ2ODZVZ21DTmIraDFCWllydFpOMDQ2b0t6SSszcXlM?=
 =?utf-8?B?c1l4UEtpVy81bUdRcWpNVUZEM2krTDJuRHB5SkZCaEFocVRTbVhVRWdEclFm?=
 =?utf-8?B?aVRjNWVxL2hQdi9hUVE1NitSL2RNUndYN1VSeTB2OGFYZVg4Tk9GRjNoYVFk?=
 =?utf-8?B?NXpjT3pWYkVHVHBSa3RmQWYvZmVqVkdqdWlEamNFUWpSM2ZzTTlObmZUVWhl?=
 =?utf-8?B?TVh3MUF1MkJvdzRvWmxMZGthcW44dzlJSzBldVRiQUZqRFoxL2pPdGpJc0hz?=
 =?utf-8?B?bzNUOEFUZHVxdldqV1lhemZDbVJrWit1R3B5N2cwc0pPWE9CL1ZjRUtXN3lO?=
 =?utf-8?B?U1ZxRnhGUE9uSkNYcm5yQkVNY1diYmJZMWx2a1R2ZTgxYXVrdjNFZVJRMlUx?=
 =?utf-8?B?azUvOGNBbzdHdDArbXo5Unh4OHNSNWlMWDJOY2VDZGNONWNvbU91Y1dhZ2Za?=
 =?utf-8?B?L2pVMTM0cmN0S1N2N1hTcml3T1pLYjJycXVNZStYK0xHN0t3M0dsWnh2OVV1?=
 =?utf-8?B?SHpaUGxlT3ZKV2tGTTcycXN0U0xnT2hiK1h4akEvZ1VmNnViY093ajREZFFJ?=
 =?utf-8?B?U2lzRW9kbHpGVy9pY24rd3dZaGhPWVNBQ3Q0UXN5dWV3eXB0ZEFHVURwS2E0?=
 =?utf-8?B?MFZzamlmNU9wOTVXQkczNG1IUW80ZUkvUlFGbkVlenBpWms3YUpMbTJ0TEZ6?=
 =?utf-8?B?N01JbWVqTE4xZ2dBN2pyb29BVTdRTVNZNm00MVZwQTJ2elBLOUxXdXlzY3px?=
 =?utf-8?B?azBaQU4zaGZ4YlJWVEhYQm9yTlhDeHR5NU92U0FucnA0N1c2MnVyT25jajhw?=
 =?utf-8?B?SlRodW1Ga3JRNVF5L2MwZDN2UFB4a3c2dG1ZeHZaTWg3dWdaRk5zYVNYOUNv?=
 =?utf-8?B?NWlhOExHenlRT1Q1Sm5nN2FNb05PUWY4Rm1GWjlqdmt1OGd2LzRKcy9EMERh?=
 =?utf-8?B?eTFjZkxFN3ZnOW1LM1JVQUNjOHdnL1VjakVhcjAyRWgzZ2E5bFNLZ0xmSkpQ?=
 =?utf-8?B?MGo5NUNXV09ER1N2MXIzL09QczB6cHNYNUMyZ3NHVFNMT0cvZVhYYmZpNWwz?=
 =?utf-8?B?YmFLc1JxbldjdHZ0cUR3VENuVm9DMjY0d200REo1K09zcXFiTGN3Q3E1ZTB1?=
 =?utf-8?B?bG9xUkNFV3lTYjhGUmp2Mmd6aEZEUDJWMWJDU3JPaFlLZDFJTE8wbGlweDJO?=
 =?utf-8?B?OEQ0ZFliaWVMMUV6eVdsV2k3TnZ2aW91RzczdlJweERmaWtNcU9NZVcwMHNE?=
 =?utf-8?B?R2JYaEJzdDhubm5MazFuYzJjeEZYWUlGc0dxcitncURGOVo2blZkblhsY3Jo?=
 =?utf-8?B?aDJqUVVYRnRYSysvdUNTUW0rVlUxcnRxK2djbEFWSUNjeHdnQmQxS2loT2wv?=
 =?utf-8?B?SExyd3prUXMxRzhvd2ZoMG05NUJxREU3NlE5bzJrQUF4ZDdIQWV4MTBubTlQ?=
 =?utf-8?B?NWpab0ppeE1OODFGT1pZTmJwdThNaXp2OCtjUThBRmdpWTZGakpsTk1ackNp?=
 =?utf-8?B?VzU1MUQxSS9CcUw1Y0JvK005SjlkRFZaK29GNGgwdlI1Q0ZkUVBXSGQ5Wk9V?=
 =?utf-8?B?K0V6TVBSWFhQQ0kvU1dIUldaQ0Mwenh6aEJ3NDNTWmljd1I0R0xOMk5XVHlE?=
 =?utf-8?B?L1lGRHp1MXRXeis3Q2hCc3JxTlI5VC81NjZ4RytRejVBNnNKS0U3aEVnN2pP?=
 =?utf-8?B?dFJPU0M4WTZjYmxER0VGcFdZeHRka3BmbFZMYTRwWE9LVmQrRGZ4NGlMbFl5?=
 =?utf-8?B?UEp6UGEvY3ZtN1ZHQmlzeGkvTnROSE1vTytneER1a2I0ejE3ejMrVS9PSTNJ?=
 =?utf-8?Q?JLJZhWpBIArPizLdW8Nc6IsQK?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c1a249-2120-4a3e-9720-08dc1cfd83e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7263.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 16:57:14.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCYE8lPkGfWabf/UcU3HsfP+2MTLp6fgq0ci21v3jpt9P/vRcT/aOicTQ+CQM6zA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9194

On 1/18/24 18:59, Dmitry Torokhov wrote:
> On Tue, Dec 12, 2023 at 09:33:58PM -0800, Dmitry Torokhov wrote:
>> struct cap11xx_hw_model is supposed to describe the chip capabilities,
>> however later code changes introduced checks against chip ID.
>>
>> Introduce new capabilities in cap11xx_hw_model and use them when applying
>> chip configuration, and remove the enum for chip ID. While at it, rename
>> no_gain to has_gain to match the rest of the new capabilities.
> 
> Jiri, if you could give this a spin on your device that would be great.
> 
> Thanks!
> 
Hi Dmitry,

thanks for changes. Looks good to me.
I verified the functionality on real HW with CAP1293.

Reviewed-by: Jiri Valek - 2N <jiriv@axis.com>



