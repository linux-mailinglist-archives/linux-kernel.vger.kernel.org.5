Return-Path: <linux-kernel+bounces-44625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9AD842537
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A68B281DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF8F67A10;
	Tue, 30 Jan 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="LDZdTAME"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2119.outbound.protection.outlook.com [40.107.22.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEEC2E844
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618749; cv=fail; b=XHRU5yovnrxWvp+q1Pk/goWdO1usF7IDmL/oHDEBB9nEGwR0VWZAETu2xwvXvjSxbcxdXK+5BxFGclH7VdcOrX48uSwgPf5MwRyOe/29MjQqkIGmlqXCn9/PqbZumIozJDJ/wBILA6L8OzIJ4JkHzifd+EU45WbII+cZ5uzd0GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618749; c=relaxed/simple;
	bh=ZbjIWTWbR93iH8pcJR1gHtF0CWAnaS7VVAHbN4uW+Is=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jsJrZSDXvpuWorqZ+uOQ741eR2cC0W7a/E8Dv7y2TFJueHcuR5/E9n0tlnM9OF5SAtvsfuJaczxr5bYCEvnmSaHSLmnOdeEclv+Me7TnOBIp9jds8BrP3JELc9qlTWr0hLwY6jGobKcOltQb7Xrcj044+bZ8He1FjxgaqHCO8qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=LDZdTAME; arc=fail smtp.client-ip=40.107.22.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxAE2uVfdbvEBmlJh+aZhIjxvrSvxGVFd0QJL8U389LbSXIrx7y/Cq5OqSRoCyVIBE0nrzWmq3EFeh6Nxmy0goD9GMciMTSYbdjzmg8fjbzpHzJRbNmz8fBD7Hp5oNS4u7wA+BGRGVricgXTMJw5KtsHwKAD2KgWgLOr1xkSXpYDk/AmMSmyAX1bEl22WzAPLTMut1TwraKJYfQMA4vVYmOYDIAY/93HWJAqBStNl3FV2yHxdP9utbJBZ5nED30O4EWgvv0U2VrWO4EdabhQAX1vXwTi7c0Qjhareo3Kq4F3UGCHDN3SsDgx6V5dt9axFVUvR7E22qqaXEcDsyuVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VrS5GSV83VH9kuiua1yHVk5WRymX0zGfRYRT58rgN8=;
 b=GIdWFqZrlfkloU5GGKbrQ/OeI0xJA0DADa+kyHsY+YEDfUjU9+pT/jdUk9+huPiM7JUHV5Kyb+dcpc7N5B+Dd7f/DC/RWDPtt2fwYFrqwuCb0QHh3dcffHwF9ERLD4HeiZYZdAmK0/q31VGa8Fe2BGjU42FGdiDjz6iulMtJdlxVvZegebWoJZhOrdhSnVy9r9y1WEMfrr3ZYdX/OjohrXrUr1JbI/9OphtLlAUjD2WwQL4NpSHxvFsZyjio9rfNZ0j9c+YmkAeuKJp2v6aMsyH/nwWU5lBquP1GiYPrLGtnNKQ6FdNltBsnnJnsyORKKAvVBN/X/qw6c17/zKHKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VrS5GSV83VH9kuiua1yHVk5WRymX0zGfRYRT58rgN8=;
 b=LDZdTAMECDreALdzYiLGL4d7ZrYhY9DoRx/DFsxv1jIwLKyN1XCIGy/v+5sjgsu5ujt7OwOMvHwfuqYYl2fBBCNYI1MLEnR0eZR/506c+fRgwuFkEk/7xTJwnmyviN4W1nqGkDmCCwuX454KSBLUyP4vo32krrfRBU9HI+ZAFe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAXPR10MB5229.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:276::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 12:45:37 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 12:45:37 +0000
Message-ID: <5c30afe0-f9fb-45d5-9333-dd914a1ea93a@prevas.dk>
Date: Tue, 30 Jan 2024 13:45:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [eventfs] 852e46e239:
 BUG:unable_to_handle_page_fault_for_address
Content-Language: en-US, da
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
References: <202401291043.e62e89dc-oliver.sang@intel.com>
 <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home>
 <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home>
 <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
 <20240129174950.5a17a86c@gandalf.local.home>
 <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
 <20240129193549.265f32c8@gandalf.local.home>
 <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
 <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
 <CAHk-=wi6m7d-nivx10Lo=aGhbdk2qg-8SzjtDd9XW01LxGgAMA@mail.gmail.com>
 <CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAHk-=wi+WbXZcc2Sx1i-MGV2DfG4eS4Ci+mrqi-PBSLSnww6qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0095.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::13) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAXPR10MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d97feb-2541-40e4-8d8d-08dc21915bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f3vnirkfAakIdhd0VqcubQMx4fF8VqoLpzzrZ63uINOgKpYavGzVWUn4SwiJa60zDBL3vXT/2I0EAVXc77mM/ClbnSoQbljg+2bENwEnSPWBD55z20+G2QmcN+xuEb/PzSSJ4n5EYXbgJXvkFHyn70icxkE+i1lq75IouAYoP2KyaetDiZX8fXTC4uBDZlzcs4+YNwnvXZw9XqJ+MdAKAZgVTh3Nmdo5FMdCRFobp8ApjxfDLwDSaCyrg03iA0QIKr6TpkmpFVNXbtcBpUI4wJyW0L073YqqScjOeplUL1pYyjT+ygaMR6ZNnxOCGTuCFwfNNq8mKnj5mmeB+HmRQAn1hyUkzCPiDWkS+5ksXcRBrMHGeEB9l+lKOfSRM9r6jw637d7fwWsq2mCmh+fTW9ihezGPEjomte5/h/EAqhGcmevR4My3MlqjALAUgFXj/DxhqKcaQwCXCLNzdbIQBQLB21XjiOnT4xGycmTUpRUAj/hgtoxZ+7dS8RM0YEJZbeuSWbD5OkWoISPsZVrb4MkizFVtAjmkMSx5Tr37Nj+9Jgu5xx6LoD4N96I6VoLGJaJhpVuc1khFBv2YVucYWyYO0xWAdNoTEYhG8nudhDxVV3LzRNZXZSp6thJNy/d8ChprzEqz+1RpmyuVLMIAAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39850400004)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(26005)(6512007)(2616005)(6506007)(316002)(6486002)(31696002)(478600001)(86362001)(110136005)(66556008)(66946007)(66476007)(8676002)(8976002)(8936002)(4326008)(83380400001)(44832011)(36756003)(2906002)(4744005)(38100700002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXBseWhYNUpXVFVpa3JYell6RnNGcXh5TjVNVSt6Rk4zUnhmRmxIdktXTkpv?=
 =?utf-8?B?VXhRRDVHdC8ydkRSS0loZHByYWd3QVU3N1RrVUVSYW15WUZYMTBja1lOcUJH?=
 =?utf-8?B?NmFmK2ZNZzlQbDNLZTNmTm4wcHkyWTRVS2NPQ0xTUitqMy9wV21YeDBQcG9C?=
 =?utf-8?B?b2RBL1k5TVhOWXFYRkdCODZldzBtZjd1Wjk1RDV3cHRsTXVveGxhUldWS05k?=
 =?utf-8?B?eGQ0enJHT3Bqc1VBNnM2UFJKS1EzT2hwU3JlMzFLenF2MzVaeXVxeVlsVzhN?=
 =?utf-8?B?eGZvSHFLZzVLczJJZTR1Qk5BSDE1OC8yQ0pqWmdGSm85RmRjWTdtcEhmVzl3?=
 =?utf-8?B?em9KYXVzblFjVXR2aUNnYzFCWjVTQm1qQThVMWsyVlQwRGYvS094S2tMTnEz?=
 =?utf-8?B?bHpnOXV1eXl6TXZ6R1pvTVMyNjg1VWNXRU90STZhY2ZYWDh0VlhiWEpyMjh6?=
 =?utf-8?B?Y2czQWs2S3QrTmJiQzc5R0RodWVWRGk4NmZBcnFqOWZ1NlNPMjUxOFpIcnpv?=
 =?utf-8?B?MEY3QVRXaDlpdUJzZjhYcXJiNE40MHVMQ2dzUm96OVpIekJtUFZvMnRTTzN4?=
 =?utf-8?B?MUg3aHpnTFNSLzZ3Tmxua1h5Y3BKNWIzeXAzc01KUVZFVTUvQ05ONHVtRHc3?=
 =?utf-8?B?Wk0rRTY1YW9XNEJkRFJNaFFnMG9FU3UzdVVaNnBWOU1JU0J5bEJxNTZhK2hz?=
 =?utf-8?B?UGZhdktNMFd0dmFUeUxLcjZBemVseHRPdGF0ZUxMRUdVK1dKOGFiaXJWWW92?=
 =?utf-8?B?VDM2MUVodHFVQkdKdWN1azBsd0VGb0plRlBzdVBUbE5PMysxVHIvR1ZoMm9a?=
 =?utf-8?B?NUZVR3pMVDRsRW96TTQ4WFZYeXNoTGVCa0VaOXVveEVmMGpreGJMSm91R2tY?=
 =?utf-8?B?L3F6VHVBcnRJM0wzWDNQdUxaeSsvSTQyNkRxcnYvS1U4dVVjNHlhV1dsSGIx?=
 =?utf-8?B?RWxCbGNtMGd5MWVRMjU5ekpySGZxbXBmdFdNQTRIaDhHTzJoMlhDK2hFdXFD?=
 =?utf-8?B?OHo4ODE2ckJEWTI2LzRPNnFXZVdvbVQ1NmxjUlZyNllmYWRyU29IS1lTaytq?=
 =?utf-8?B?Mkx1WENxOHlYaE9UbGtscEdaelNzV1JjRVBvQmZnVWl2U1RadDdKRkk5Qytt?=
 =?utf-8?B?dnFBOVRjaUtVRCtMeWNZTVVDTjk5WnJmNWdrVG9lRnhxMFM1enN6dHlVL05s?=
 =?utf-8?B?cVpLMGZlbkd4OEYwcGxUeXh3RUR1VkN6dGd5NnZ1WFNXV3BvSkRkaEVkVTBY?=
 =?utf-8?B?WmtBbW5hQmgvRFhQWGg2OWJocnNsL2pxQ1J1aXFxK2JXbkI0ZldwSDhQK25z?=
 =?utf-8?B?K1JXTTlOdU1KdEN1TGpFcW92TTFXS2lNWUpnTkpVN1hSUjNYRmJUOXJMWEZj?=
 =?utf-8?B?cXVmSVQrcnZHSGMyU2hSK2lEaThlbFdZclJhcHhuWTRyWFdSVXd4WVh2aVho?=
 =?utf-8?B?ejRra2FZUGo0d2U1ZVRTbk9UVFZrUzYxOTNEZWZLcm5WS09xU2lnNnhZbVJw?=
 =?utf-8?B?cHRoQllUemI4OE4xNmNtWG10RDNFZU9mRWVCNW01UXNoZkZyMzVvbko2WjlB?=
 =?utf-8?B?N0Zvbk9VWGpEb0lDRkJCUnVIWHpNMURic3lrQndlU2ZvRlFNTjR1TTNlZkRz?=
 =?utf-8?B?ajBBbEtlRUsrWnRzYVF0VVZTY0VuWkwxTTlPUUNLT3JvTFd4N0NmUnY1aC9i?=
 =?utf-8?B?YzcvMVRtVFlNeEZoL2drME1Bam5DMVBqYlJ3M0J5SW9PakluNkJtSU1YUFZZ?=
 =?utf-8?B?NHFyekJsNzhscDRTK2MzWkZWOThGNVh2czR0OFNrRWF1T2pHMVN2cWNMOWx6?=
 =?utf-8?B?WEFTU0laV0FTRHF0RjdxVmVNN054Q2VlM21pTUgxK2paWitiMVUrTzkvYkhq?=
 =?utf-8?B?cGpxa2UwRS9lRzZkSyswMUorTlQzcFBzUHMzTWZ5WmxSeVZxVmQvY3dwUzJy?=
 =?utf-8?B?b25sZ2U4eksrRnhJMkxRelMvaDUrMVoxR0tORVZISXpiTThJWDZaVnlGdWRo?=
 =?utf-8?B?eC9OWnRZSlUyT1VUbWg4VTZvVUIybGJMZ2VTK0o4bUQrQkdIeENzMmRFZWgx?=
 =?utf-8?B?R0J4ZCtxc2luZ3dVdXM4TUw3MGVVMlhLUlErRXZnMXNYZjVJMzZrM0RPNDcv?=
 =?utf-8?B?eWNuemRUd1VGb1R5ZDdzK0oweTNpYnpOYjJldmhWV05GKzVzOXZVZGtUOTBk?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d97feb-2541-40e4-8d8d-08dc21915bad
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:45:37.3249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zUr88vbYrgOJnqeGXRGlNxE2zKYXMDIgnODoZVjtdK7TFtnytOq16qcX31JMwtApGlJ6dJy6pKGw8udgR9UDzA8tbhW4SEFit3Zp2N2Ijc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5229

On 30/01/2024 10.12, Linus Torvalds wrote:
> On Tue, 30 Jan 2024 at 00:43, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I'll go back to bed, but I think the fix is something trivial like this:
> 
> Almost.
> 
>>   +     result = ERR_PTR(ENOENT);
> 
> That needs a '-' in front of the ENOENT, otherwise you have a positive
> error number and things go wrong very quickly.

OT, but 'git grep' suggests that drivers/soc/apple/mailbox.c might need
exactly that fix... (there's also ext4, but their custom E thing is
already negative).

Rasmus


