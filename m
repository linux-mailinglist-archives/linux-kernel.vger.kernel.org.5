Return-Path: <linux-kernel+bounces-123300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97172890646
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEC51C3089C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8AB1353E1;
	Thu, 28 Mar 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="2MsMQ547"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2120.outbound.protection.outlook.com [40.107.7.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4641A84;
	Thu, 28 Mar 2024 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644483; cv=fail; b=DxUvVvhZ2qz7i+/WZ8wDiGMR2rj/fszfRRIa9Yq5xIUbMJf2hGYfSUa8tu8q/G+AdwiUJJeoyL+lqZoLN+TKQxK+z7FUFR+mpZPDn+CFC1GEfakQLT7BfIOgfLpu3r8C8R9m20wwPUSqET1WIAlFNT1ng9PaibvxihnXb3XVy+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644483; c=relaxed/simple;
	bh=7C2UW8vibpdfbPQli54dJt4Oh4puXD+9H7a8XXWE7uE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PRQ+/QIveh/SyVrqaiQnOPzUKrFJWDY6WXvScUbhfbzg/50GuuWnYTFmmerW/B68jpXeOuysM/HHKytYsYNA59FGPFCQqent4wBWBKlHs+/r6z9qA2X1C/Y9DthJ9KvzKqyKdkmGXmVp02rZ86QgMTsob61H6VmG38njkA0xMNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=2MsMQ547; arc=fail smtp.client-ip=40.107.7.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDcwIIQOxQXMJcew+PQnCIamxsGY3mz5hGWuuDF+M6T/53xvYL9ZyTrNg68Hh0bCiWKkyHL9XziAUzvntOpBPoys9gf5jlgEQ23FkQSSlg/I/ZnydSM8+DCI1/LJWLaj9rOpNPiwidcKlz6PUw+6IXZwGBddqIaRfWQvo48goaLnQuOaFDz2dPILmHUrSUgi6grPyDhmpyMAIA8QW5inZQlwKz0sF/wA4EaDdtpzObBcGP8GC6IPCCvWBHolI8ichJopb7KiK2ObAPhyyA270okIvBJbt7Ks74lU+ZdF9C3LHrHAXphpas3PGDDteRRMIanLPyHGXip9eB/F1Pqy/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VvWii6Ovb3OvYCA0nkoN+0k/qhcPCxH/MYSIjHFG9c=;
 b=f2iJdtiBBogyneMJiyaJG8G/VWOJa/4ehh0aJAY7aHociGWebWwEEcSHFARTC/wgen0C1V5f6124WNTDQK5a8D4LduNsluu71PIEvRsKsX+PJSfUURJyBW0fHcK86xD/e12ACkQC4C5k4wR29L/xBoiVGwyt+wWpLzeSdxHtLkxYwOJ4g5z3X3ZaXYy1Elj0ih6yLOuyaiSKJjYJiLvejlTHZbmCn3vIGQ3T1uSToMzgMAZjn2rPgOO0pNKAA7N7bcZ4kNZn9rrIeonKVzOKf4ip3yn/yEfkncTlz/vxvDGni4sJUGiu9nHc20PDDwFfZA0JcPm87CHctgO4W8KXEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VvWii6Ovb3OvYCA0nkoN+0k/qhcPCxH/MYSIjHFG9c=;
 b=2MsMQ547mnuwnkjzkUmFoCSH9NM9udNVka1+5AEcHry38ZSz4UFsn3AAFY3AaZNGSoMX6pSoTu7wUJIIMlDDs9s5uAKmIEo/KcUPHXaWDWzNrwodwAfLpnXzeF3E70EmiTGlVV4OkoO7Vx+LgiqDrS6HuSD7u/RE+nvUfgVARIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU2PR08MB10013.eurprd08.prod.outlook.com (2603:10a6:10:49c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Thu, 28 Mar
 2024 16:47:57 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 16:47:57 +0000
Message-ID: <91b5c977-2d24-4a31-bc8f-3ad7cbdb8237@wolfvision.net>
Date: Thu, 28 Mar 2024 17:47:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/2] usb: typec: tipd: fix event checking in
 interrupt service routines
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240328-tps6598x_fix_event_handling-v1-0-865842a30009@wolfvision.net>
 <2024032824-rasping-zone-7564@gregkh>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <2024032824-rasping-zone-7564@gregkh>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR09CA0101.eurprd09.prod.outlook.com
 (2603:10a6:803:78::24) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU2PR08MB10013:EE_
X-MS-Office365-Filtering-Correlation-Id: c00d054b-8471-464d-f08d-08dc4f46d243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dtpxceUgNgtJ9F7Cm+cJI8mR1jhm2v/y1XYvNGm8/ZsJQoXdXBcbxNgf3NrRVsUI+ZX4CDPbzeMH9Lhw0renjkxVebjptxAlgcrI5mdDCgkCEcTA3EzouSnscP2RnaSpZufnJ+XTw+q/xLs7WNNYuZmX3esAR2KKCDYa9DxasTWOBx64R7wTty4B19nqsX6kAK3gxVssr6Pblkhye5VFx0Meu1ZLXt42mHVEwdg5UnMBn55gGVdHapR3lFRaNz7Ml1/6xl9RRs0U3iJWG2Ju/NFTjdkH5D52xxskK7ciZbgdR40bru1oOnTLiGTZCIH1NXUF3tUPKmG8YnDFPHCVDfi8Yfu4VlnbQMgKzwl7TgDIEM0W27ON+mjVtwcImxNFtMBTjlH97NdeWLFXI5z55N4fuDsSwe5PnUI4IvcBYj66Ps89knMoG+jT4QIgm18r38jNNZq3K4+KcUNXlCkjHLNA0UVbtWZkSRl0xgbeob2hM9zHy3QOt7HM3bSExxI0/tIlEgOJgKBmDcKm+bOLvf8bdtnms8LSBGxGyXghzzjkg2cYmAKz9FlLrmrPuI9opk7c2c8lk8Sx/vcAVjTzy9FAZpdEqOffn0H6rpSWmWU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnBVY2dGZHZ0cTdtZHVucG9jZVB0WVh0Skhqd0NrN2VGc09YR3ZKRzg0ZTRx?=
 =?utf-8?B?U0hVMFI0ZFVTbzJVb2RyWnZ2QmFBbjAwd0w3anFUbEdjaHh5REFBdjhvMUlv?=
 =?utf-8?B?ay81dU8zN05xMXhLcHc5cHVnektvMnBIMmZMUm1kZ1l4NndmUzBWN3NaRVhj?=
 =?utf-8?B?RE9nbldFSmFPQzVnOGRDZ1pSNmlENFNtdlBDWWJlZ3ZoNHIrWVRxaEhSS3M2?=
 =?utf-8?B?RndrdmEwcVlkWFhqdzdlYk1KODhpdlVKTTdzYWhrcVhjWXhxWG5jNVJiRThP?=
 =?utf-8?B?S2lzVTFsK0Ria2lRM2dlUmZiYzBqNHpQaG9LTnByaXZmRWNsSzZoWWliNHBz?=
 =?utf-8?B?WVgxd3d4ek9CY09kQmphdG9UanF1UGlwNXFsWjY0aE5ienVoOXovOFQyMEgy?=
 =?utf-8?B?NTlJa2ZNSTRKUHV1Y0hXZHZoS2lVTXF0NnoxYnFaZUNlOXRxQURUT1U1RnBB?=
 =?utf-8?B?S2lKQUZZRW1CN2poeURwUUQ4WFhCQ3hwRHN2ZWlwZ1hUbFNHaU1Db1d2NjlZ?=
 =?utf-8?B?U0xXb0ZwS0VMR25BajZIMDRrazhjN09pSzJBbmhmZ0gxSzQyNFhNc0M0NThJ?=
 =?utf-8?B?NWFvMzBZeUcrNXl4MFhSeHF0L1ZjUEc1bWtzWlJObjdFWk1wNUhaZ0wrMHo4?=
 =?utf-8?B?T3ErSzRFcEEwUGtCVzc2T3IyRFQ4amNuRXVVTmhTdjZnR2dZdGVIN0ZId3pZ?=
 =?utf-8?B?UTh6cVhEenlVcnRTSmJNNjdVVzB4YkJnMHc4Y09sRmorZlBkZk40UXFyYTJ1?=
 =?utf-8?B?UG02SDB4d01hYzJYSksyclpGTjJrOVh5Y1dFb1cxZXNRNXVpTnFUQU1IYnVh?=
 =?utf-8?B?YjZDZFRzREhwdXcwNmdiVE9veDJNdGhRS0dvR3k3Q0Z5NVNENG1OVVpJYXlB?=
 =?utf-8?B?NXM4QVJwanl3aUtyTjJ4VXk5Z29BQ2FUbXFhUWppQjBSWEd1d1Q2Yzdvb0ZU?=
 =?utf-8?B?R3hLV0tpSzVnUnJHM2ttajVYQVpoR1R0cCt0RVdudlNSTVpqNmdrR0Z2NHdV?=
 =?utf-8?B?bE9Md05kWk9Lb0RZdmJwSDFJK25Td0N1NWk3UTRkbE5aMmREa1ZlMmdvMVFG?=
 =?utf-8?B?ZEFqak1TU1I1bFZUZG5ha0phQ2FKZmhoSjc0VmdwcmxIdmNJZmpSdHFMSkxh?=
 =?utf-8?B?aDdrbjRlclVFeTFyUnIrR3dZS0txaXVMQ0c0Y1NlWWVBSGhXb2srWm1QZGZo?=
 =?utf-8?B?YXRTcS9DVGhpUlJqWXF0MFhtOGY3NXJRdjJHK3p3ZmkyZXhDTTlqQWVxU2Z2?=
 =?utf-8?B?M0R4REZwNmVNUTE4NzZWcnFjK0NkTk1BMW5FSzNvMzlISnRXdmo5R092djB1?=
 =?utf-8?B?WXdzTWpqZSt1QlNkc0VXeW9LeFhDK0RnaitSTVltaTl3SWNDS1JoMzQ2dllF?=
 =?utf-8?B?VmM5WVlSSjlianJMWHk1OE5nWXdjdnZmYXNCU0lNcGdoZnNucm1yZUw3eGg0?=
 =?utf-8?B?VGR6aTFUdnB4MThQQWt6MmR6eStlb05jeUhiUnQyUGZzUVBrSFEyVmVDQmRK?=
 =?utf-8?B?OW5LTmRWVHQwcXJwVG1YNFZ3RkV0MmY5ZjRBSjlUSWlLSHRFbXpxeElGZGlQ?=
 =?utf-8?B?STQ5QUk1VW9uNFJaYUtSWmtOdisrV0tNTUdWbmUzY3Z6aS8xWFZKRFdYS2FV?=
 =?utf-8?B?a0JpYkYwblVUbUlxYkl3L2NJbWNJSmxSSnZHOTl6L1lJcHpaM2hCTXgrUExK?=
 =?utf-8?B?NEk1czJkblVJUzg4QUdINWVZVFRldlhMcXlHYng5MHJteDZWUkFMb3lmNFlL?=
 =?utf-8?B?UEY5c2RrVFlaRTN4UnV2aVQ0VHhneE1WRi8zQ1NSR2dHRHBrTFlOelNDWWN2?=
 =?utf-8?B?K0dlcm9wUW5FdUZwc3BabmpHNHI5OThpcVVzQmV3cXlLWCtCSGp5OFRia3Fm?=
 =?utf-8?B?UCtkTThoSytDbFhiaGJZWHcvSGsxQjVyRGkxa0JOVXBkT2dFSFJRcHVpdUJH?=
 =?utf-8?B?QytsRlZyUFhCaFQxZWwrT0s3VmNMV2N5MFJiNTBBSzFVc1MwUkhNOCthQkpL?=
 =?utf-8?B?RDM1WWtDUUZua28rYjNaMmY5cmxKMy9BMUsrL0VaU1hMbnZvMG83QUVEUUN1?=
 =?utf-8?B?YXF5TGw5TmlEcFNzMHh3R0FqTkkyaXNHK3Nia0lTYkRvTzlSVVBlN0g2WExw?=
 =?utf-8?B?d0Z6WmYyaHZGdXEwLzVZSXFKLzEycWJRRHdodk1xWVRFdGMyLytSbTVqNldV?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c00d054b-8471-464d-f08d-08dc4f46d243
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 16:47:57.4885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swId12ns5ww17Rco+9eWwF6R4qTlPN+PRHVervoXJVv9mnWJJXzxp7oygXZxLud3iYFDIoW6FEH1hj6fXQY9Jov9s/uVHtecSGqNOnWNfuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10013

On 3/28/24 17:44, Greg Kroah-Hartman wrote:
> On Thu, Mar 28, 2024 at 05:25:20PM +0100, Javier Carrasco wrote:
>> The ISRs of the tps25750 and tps6598x do not handle generated events
>> properly under all circumstances.
>>
>> The tps6598x ISR does not read all bits of the INT_EVENTX registers,
>> leaving events signaled with bits above 64 unattended. Moreover, these
>> events are not cleared, leaving the interrupt enabled.
>>
>> The tps25750 reads all bits of the INT_EVENT1 register, but the event
>> checking is not right because the same event is checked in two different
>> regions of the same register by means of an OR operation.
>>
>> This series aims to fix both issues by reading all bits of the
>> INT_EVENTX registers, and limiting the event checking to the region
>> where the supported events are defined (currently they are limited to
>> the first 64 bits of the registers, as the are defined as BIT_ULL()).
>>
>> If the need for events above the first 64 bits of the INT_EVENTX
>> registers arises, a different mechanism might be required. But for the
>> current needs, all definitions can be left as they are.
>>
>> Note: resend to add 'stable' mailing list (fixes in the series).
> 
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Sorry, I will add stable@vger.kernel.org right above the Signed-off-by:
instead of adding to the Cc list and resend again.

