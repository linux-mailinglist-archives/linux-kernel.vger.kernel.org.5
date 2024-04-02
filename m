Return-Path: <linux-kernel+bounces-128440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180DD895AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A43A1C22059
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED1315AAA8;
	Tue,  2 Apr 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="iWB9Tv8c"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2090.outbound.protection.outlook.com [40.107.21.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B817582;
	Tue,  2 Apr 2024 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079606; cv=fail; b=agzlWQkqqUQsTLLpoAEyhg/Djslu/UFEqXJ92QZ6f85dIWzBfmblbuKbhWgx7igP8/6ntzeagqrN5wetjEceTyb3+44W97sExItLbCWflSUYUyKcoUZ3SwUGn/M9qMdhK7voO1BwO3L0yFGjgxNhGoEEFYze2OVWrRQl5M2mb+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079606; c=relaxed/simple;
	bh=ndkyf17d88GtLZDqy4uKf555E+qOTfwQm+zGIAeLT5I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FL9EeQckaWYipXdSDj2RE37FiGMK56Ou9twvkHeqTJvUxzPCL1du432YorYNNJ2dCt3/MWLgnXeH3gxE9y1ttgWUDPdk4euVCP+MLa2gKtfZEgdd+q8+WVrCUco91tuOyil1IY9FnVW070tnDvvq7woUuqR/8c3qfFH6gJtwY1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=iWB9Tv8c; arc=fail smtp.client-ip=40.107.21.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAchN9emMnRbmioItN7G2Pn5dXXNz3ZOYTT8tCqJxQA/ki4e0QroFSJtfBzjQi7ZwHeBp20CgFSosjKHzIoKPO/LdZ54ERRwYzQBvbM8w7R4FvtNMNZ/q0DlRSRPZ5IGNDvm+/5n7QJadPWbaySFByBYkmagCw/o9mUcRLmzF18pyV2gTo1P8BdQzyn1VSXaavj8dRnibnhl1wDktg5p4eVMx/6MHI4wbuXPaSXse73TaxmcjvrYZw3vMFYGboztVE74r9t+6kQxvv3qRdpiBNF/0D1veeKbCFwwdYU2rg5qcHys0UHWWHI95eheWJthSs+adVuDnWtMX6ovcWAYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0+1lhClaOQP6shGr/eyxHY4NYspTPZyZx97ZYV9y08=;
 b=hrKWRdFxBdXJf0SvAQOfXOv7ZfYsahWpfGPqskJGxlP/qWOTmUccDyX1PlHm4+l9WCP25BnntiiQGkIA/F7hGDIiLvXGfjhAl88MN4wmg4WCXgDfTWE1RVlUf2kcLslIP2kgx9evmbg3eONbyOPMTu3IgorNuf0F4XoaQfyXYE3rFr82ny3U8y2w/+tt0EOkGOWhPqh8z5QDSHBKYjzZKK76YINlY0p106R4QX9ciAYJxBxwnCAefRRyzqm8eZ2sWXDHwYQNa2oHu8vp9OFz2yNDqXGOVZ2wYx2oOnJdI1qZIDA/23LlxaV+r+PoPFMgZbn5gPcmlzuC9LS899Eokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0+1lhClaOQP6shGr/eyxHY4NYspTPZyZx97ZYV9y08=;
 b=iWB9Tv8c2lUDXvtA0APE772kxIBSmbuGOLncgJdu1d7rGnvHhBMZhq4SGF+1cLgvBQuILIwwNZeJIK6pTS7wWqquPK8+QHzg7OTi+xN6xzssPvvQiClNd0dHh1XZvmNhKPwQ0AaI9j8g30p5H2WnAzP4lUN6o5PUksRiW6qxbD8=
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PA6PR08MB10568.eurprd08.prod.outlook.com (2603:10a6:102:3ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 17:39:59 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 17:39:59 +0000
Message-ID: <82e0f16a-8f25-4e69-97bb-ee3c78f2b183@wolfvision.net>
Date: Tue, 2 Apr 2024 19:39:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/2] usb: typec: tipd: fix event checking in
 interrupt service routines
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abdel Alkuor <abdelalkuor@geotab.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>
 <ZgvcJPTJS7d4aYgr@kuha.fi.intel.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZgvcJPTJS7d4aYgr@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR0502CA0030.eurprd05.prod.outlook.com
 (2603:10a6:803:1::43) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PA6PR08MB10568:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vifVaKIRQpOcazOtStNaCj2NYEcBwEFxlRe/uWaFXVPvlK6DfVz0xgRdLbanLXo4JL6uaRzUfzTdsu3x1yZnlfC/E2ew5qCwQXGJVhvGMCfY7XNYBuYvOJnCtK5eQ4mlUkp4zaHWODHLmICaTFk28xsXf+voA8BslKj1fZqjLQlS190GYmN3thvVhRthVmngWrN+gXYpsqkm5zd6BkyshbH2M7QROWTEcv05dIeGA7t59IYeQOjwiHikICpkquncIt29xxKxh8QNSfLkV6wz5O0Us7nmBxW5CVYMp9n35nyiQm9QNFDOAPS87i3DIwKsNVafh3O7Z/RubR6aNY0g2dHFoH/myE3eiN7pUIHMtNq6QZWFOyUGb+0uCNEtALV8cnMXsmuaZXzhaoPX81QNxDw1Esoa2ESLhmefoGMOF1enOrYSePZ1Srfh4HlMlPq+bSeNI3qef8snmOv7t0tqiSOKBLpbh6pOOQDCLENUNN4veaVDAdikPWThIkw5VgDfttgQ2UNOIlf2mziROmvhLe+bDf9Mb7MYTmcCCuSFA7A6uHVyrXFH0Rgs6wtsczP9+STQDAve5c03VuYpZeeilb70snwj1GGIOGIiBBBxAME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTIxcWd2TXVPd2d5eHJ3eWFFbmVXeTVpWFhEMmxQRTRvZDYyUEFzUGVTdFdK?=
 =?utf-8?B?dXdRUXVZVUZSK2JyTmNBamhWU2twQTlxbEw0Nkt4RFVRYTUrcnQ5L0xhdjlW?=
 =?utf-8?B?WmdIVmQ1UFhJelNNZy9pRzZTb1BUaTlmRkxFZWIzMUtLbXpzQldqUDFrN1d2?=
 =?utf-8?B?WkxSeWxvOTlKN09BRHd1TlRpeWtUUXlzNVZlaHZWd3RFMlpnRnd1aitzZ01t?=
 =?utf-8?B?MnNtZTA3TFRsSU1LYkwvVkZ0Wnk3UUJkK1hGaDg4bG05N3pDT3hoR2hpWUh5?=
 =?utf-8?B?RTJ6V2VDZTNjRDR6UmQ3SHNEbWtoWXJteEhjLzd4NHJndHpKYWZuQktCcnBu?=
 =?utf-8?B?REQ4SnRXdmNSRHN3QjU4dFVrRWkzbTlmWkFsTFJNRExLRUQ4QjBKZnVCb3FZ?=
 =?utf-8?B?M0FlVURGOTFkNHR0dnV0WTBiaENWa3ZTcnhESFhHZ2ZLbTlPR0pjb2xHTFNa?=
 =?utf-8?B?K0lTSjlkT0E4cVc2dVJLQVEydjRRTmdIeDZLZ0NXSll4QWRGbHR5UmwvN2Vu?=
 =?utf-8?B?Uis5V3F1SlFOdTdCZjRndmN3Y280Zjkzazh3cURnTFAyWmI5U0xQazdIc0pH?=
 =?utf-8?B?QU5EdHBWL2FyME15bG44ZFhqSWZNc1V0SjZEZlFrWUxHQThDSTE1TFc0TW1P?=
 =?utf-8?B?bnBkMytOZGRsOVIvbC8rWkRZZy9ndnNFcUl1clN1T01EQXNPOUgrVlJNbGZQ?=
 =?utf-8?B?MTZTM2E4UDN4Z3R0WXBWTVdRUXVsSDBxQUZhOUN1YUlucVF3MzNuQldtNWE4?=
 =?utf-8?B?SGQ5T2Y3Q1FqaVZNZW5zQzlJODhNY251SFZVNEFML0pzZ1dFbC9ocFZNUHV1?=
 =?utf-8?B?RFZ6ZHFmTVBJQWRuRWtCME9KY1pKbUhtZk05Y1VZK3J3S3YxSGZaTkFGQWIv?=
 =?utf-8?B?OFNNekprWVgyY2sweTNEYVl6ZzZCY2c0VTJweTRtN1lHVGk5eFdiRE0yN1VN?=
 =?utf-8?B?SGxsa2tVajl4Q0s3RjgxQ1lrM1RvbmFTSDlXZCtZUE5DdEdYZGZrOU1TRW1B?=
 =?utf-8?B?TlZiMzNDQ0NOSldhUEF2NnR3MitVWXZkQTkyNjRqZzU1WDI5WDlhWVpza0ln?=
 =?utf-8?B?eHlwRnhYeDRGYmo5aTBCeitLdkoxNllhVDhZVzNBV3JWemdvOFBoaUNqNUVY?=
 =?utf-8?B?ZDBOSWtvSkFZN2RHUktJSEpyK0NPN0txOEtieVpVRjY5T09ySFU2OFJQZWJQ?=
 =?utf-8?B?emZ4ekp0b3NXeTVLa0dnbytTcXVyRGM4Vko0M0lHcUg4YjcwcVJRTm5RYWwy?=
 =?utf-8?B?QkFaUm1EZXlNa0pZVTYxM3YwSWkxREhURjlnNXB1NTI5OTh2Z0pCVkd6MUlm?=
 =?utf-8?B?a1ZmRTdnMCs0QUFDUXJFL3FZdy9LOEVKZytWTWpEVFRNczFTcERIcDJ1c3Zx?=
 =?utf-8?B?dGY2RXF1dndZVHFIT1ZmZ1p0NENVQjZJZ1BoUHg2emoxSDZPejgyd0VyOSsz?=
 =?utf-8?B?NHBRTlhIeUMxeTVQMThWbTl2NDlLdFlkcUpXaWR2c1gyUmd3U0dmMGtQTmEz?=
 =?utf-8?B?MEpBdTk1T2IvQ29RL21NZ0IrUFk0MGMvdkhCYkJMWlpZTnZ2VGNJQ0pHdVVB?=
 =?utf-8?B?aVF1Q2xpbGt6aGMvQWdlbVd0SWpLT2JST2wyVmpEcXlXWC9aTGhzcnVyZ29O?=
 =?utf-8?B?VTV4aGNKS1pHbDEwT3JJLzlWK3JnYnZvMmtXN2Faa3UzRWtKVjhFMVRiK3dh?=
 =?utf-8?B?cEhQMTZDbWh3QnFMY1RydDdrUjZES0lycHJFcjZsY1FKbjRtUnJOeWNTS05l?=
 =?utf-8?B?Y0VhZFdmVkZqb0JMRXd0WEZsN3VwaUpYMGhjY05wbGdSZzZHSDJLc3hkRi83?=
 =?utf-8?B?OUphOG91MDFrVDcyNVBZR3JCYk0xYXUvNmVkMW1aM1F3UlhGOW0xSUZUY29q?=
 =?utf-8?B?THNzK3hVM1VndDhuU09zYy9jN0dGTVhOb21Ddm5qMHRSMkxJQUxyRlFKVW1B?=
 =?utf-8?B?cFFkL1VCK3owRXl6czRiK2U2Z1QwTmRVQStNdXJpeHlXK0JpK1ZWM0IvMVRC?=
 =?utf-8?B?QlJrYUY2enlJK2Y2YVBzcjE3UFFXK3JFbVVjWlh0VHdiV0Z6bmlic2VMNlJ6?=
 =?utf-8?B?UjFHem4zaXBXcHJCZytTZGRJd0x5VHBCWkdWaDRXMWYxVUM2eGxVUW13UHVI?=
 =?utf-8?B?VExVaHFrYU1wZE5UNUI2ckVySkhBZTVFOGVMWEJ2TW5GeGZ0Qk5TcFpaUHlk?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 530d2136-080d-4735-aa1f-08dc533beb01
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 17:39:59.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6JZKNhpev/TmRTZnkGYihb5gUrI1KdkvfJUxClwVQIL7k0jZqxR1U5cI7vIb6Mosq9ITGG5hMZgQAMeu8Yzpw6rqUhAqpBMmPxMVKERtrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10568

On 4/2/24 12:21, Heikki Krogerus wrote:
> On Thu, Mar 28, 2024 at 05:55:50PM +0100, Javier Carrasco wrote:
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
>> Note: resend to add the Cc tag for 'stable' (fixes in the series).
> 
> So this should be v3 (or v2?). Next time please follow the guide
> when submitting patches:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
> 
> thanks,
> 
The first resend only added 'stable' to Cc (which was wrong) with no
modifications at all, and the second resend (this one) actually modified
the commit description to include 'stable', which should have turned it
into a v2.

I will tag the next version as v3 to account for this, thanks for the
feedback.

Best regards,
Javier Carrasco

