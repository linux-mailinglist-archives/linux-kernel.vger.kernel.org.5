Return-Path: <linux-kernel+bounces-45139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E8842C17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555491C2451B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A2C762CE;
	Tue, 30 Jan 2024 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="yeelb3OS"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF3762C0;
	Tue, 30 Jan 2024 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640446; cv=fail; b=TIJy3nsNfaB8DHTfG+RO3GhRZeFn7grwcNZ9Etk+VyHtotN3ZxRNy+tiDTRaVPpfPIn6HOUI+d+/sK6mMuyjQ8VDmWojcIj8pt14daTE/lJ/reK90n4Seifh1a7TMbvjPVxhpEKnoRkTdL69OwXbnDoNvozlZ+PLDlkoyY6HLSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640446; c=relaxed/simple;
	bh=HpBBY2K190BjQs/M73ocrACa/+i6MpJpuNmgsivMtaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uelhgyTYq4qTVbdBAiz2D0NzNyRqVKs0uusKTuoQSBmNPEUCBBwgTyEmdFmNHgmKXyvu8KnU2QP6FXHYcI0Apxhx08lkzNYpiGYk191t9qzv/7V0oV5AhcJ8ioBpMo0DjEPYaElaA16N+Bkwu/Sdwhjlaa9B5lkuqkm1vtIKPtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=yeelb3OS; arc=fail smtp.client-ip=40.107.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuDpobiic/ykCq1qgwhjHIGBjNYQfmrXyU2yceev1WJBYZPzfGhxzONv4pLydVUE7yJp/AdfJk9QPRf2QekHK8RzvAw03vfbIJ+EnvTXwIn5ZJR0RsD0ex2i1Vqz4NyXI4kVlQv3ioN4Ge8ds3eXvbVe/j8QBViX1tufa68A8XaQwMKVLm1RdW4F6fEcxLUFJknlGXXNSOnadHgNle+oWqoJnM6o5ZsbTPVIGuiwbmROYveo4XJyFErILW5SjqeWvaTayHI5OLNzoNjIt60w/OSEqFFYvl+y3U0WvXKd5Eq/IoPDwpOv4vQTtykCDxPGu7iEtKkWS1KPJkQVjmEtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcdtC12bNWrNYeV7PUILagdiHRWNbV/VJliOjsTZeEo=;
 b=J2dkG8c2bE0OL8awYg2knf14Jqaz7/1xawPriX4UHRSIBoVvLP+Wd1+uzulUE+LrKvq9VMtZWbE340vwpMdZC052GQV6dI1/MDrCM+NMZWiW3dZrtsBL/NYL43WTaOhUtOquZ/2I+dkDQzqSn6svX+sAeyZL82BXIEf1fy9PyVr47lhRZrVLqdZcz5k4XMxl4H+3DhIbIk55WWnolqEUINF6IsDFinfIUZNGHbIivb5zws/OaJNiwunzETT85ulfslQ2jghH2WVeeMtA8z+7YqwMAQfLjat4uHQXwL/xzPJvqjOmWEmQosQoqRpEh0+sVQ7MKCpiW0U5MKfmeY2nFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcdtC12bNWrNYeV7PUILagdiHRWNbV/VJliOjsTZeEo=;
 b=yeelb3OSr1m+65TnVD6GDyfgNCM8CJHvW4zp4i5iZLXZC81eIf26A2wMg75cfUWZgpPUrpcUlx8Y4KvJUEpvznfn/B6pKTG9YxBlnhO0n1OfdbGPJNgF/3s/TSTxzoWzw37xvIRSKEUQ5K+ABMSsrkcptRDlIjlT9ggmxByhTRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAVPR08MB9795.eurprd08.prod.outlook.com (2603:10a6:102:31f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 18:47:20 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 18:47:20 +0000
Message-ID: <4413be17-467f-4c3e-9cba-2bcb51371799@wolfvision.net>
Date: Tue, 30 Jan 2024 19:47:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: misc: onboard_hub: add support for XMOS XVF3500
To: Matthias Kaehlcke <mka@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20240130-onboard_xvf3500-v1-0-51b5398406cb@wolfvision.net>
 <20240130-onboard_xvf3500-v1-2-51b5398406cb@wolfvision.net>
 <ZbkfsVr-1pOTa1ic@google.com> <2024013024-borax-enjoying-beb5@gregkh>
 <ZbkxUlFSKlUkcHaC@google.com>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <ZbkxUlFSKlUkcHaC@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAVPR08MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e091281-0308-465e-1892-08dc21c3e389
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NQwktNw15T7Ljsem842BSYZu3uzYVn6RTZD1sN3u3ytuMOybmMiJ58L+04L5j1u7aOnttLi/0HtYDnsYQuIYtV6DjOVVoQTRzvGIFHBpE+xjdUXvzM9g/jb4dOh3ZHBFQz3EkS4wa0raJKAFftH5PZQP541MA/qAdKQ6VrScV/8Ro8Sc42uVPodtIAbecHG+to7VdxCNkWYwC+TlJt4jUh+qYjHhNbFfAP69I6720XO8Zb9vYuvg1BmD8GNhiG13Qq1rrzffRJhvio/FyCHvxc++9hZX6kO2KvZhZLFlvGeqfCXDO6FjVoSssYLyeRiV3JOwN3WQfIPS8lFqzCyqwjA8yJfosq2z1AaWAWg9pl+eu3PCrpYMMd3f7LgphXYW8/FaLae7t7L2c92MnSqWjuu5tE5tx7i0UAvf+ZP4BnSwywlNHYFiSk5mbL8nHP7lpakwnpVrh3VbyWlfKnU4lEtcVpp3Ald1laOJZVUk1EA0+K9aI0q2g1W4ZG5CdOiqb9uevlP5y87YeJzJpXr2GulE3b1ULMjMT2C7oHlsL0U5b8aaE4t8f2vgYtz5qohodCc6lhYsq5bm8XVq2XgkJGSPZE+5CEnrwdn/ZbmaALQBgqCXtXsoqd7IZUkDLgcbP+e1m0GuTpAWrMQdRsv6Og==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(2616005)(31686004)(316002)(66476007)(6512007)(54906003)(36756003)(6666004)(110136005)(6506007)(6486002)(53546011)(83380400001)(478600001)(38100700002)(66556008)(8936002)(86362001)(2906002)(31696002)(4326008)(44832011)(66946007)(5660300002)(7416002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjJBMGlaSnZPYzEvMkVhVjRJRDRrM0dKZlBZMDhWZ2c4NkJ5eGlKcFp1Z3ZE?=
 =?utf-8?B?UHI0MnFzMnYzRmJEbWZhUis0TDhVd3YrSnVKY1ZZaGFzNXNLdWI5N2daREZh?=
 =?utf-8?B?SHpKS1lMNlh6UVY2Szl4ZEJpTURmd1ZINXZMUzAxM3dkK3JlVFBOT1Z4THBh?=
 =?utf-8?B?R1dsVVpXT1BCR256YnN2akV2VFFHemlTdHNBaDlKU2NXcUVJMFR3VXlUbktt?=
 =?utf-8?B?SEV4TDV3Zml6SFBQRVR5L1ZXTTNJaVcyUkpXNlZUYnRaZDEzZ2h1RmZRWnpC?=
 =?utf-8?B?ZEJPWmJQeC9LdUhUa3AzNXJjM25MNTM1ZGpNL0hKM25aa0ZhdHlvSDdmbFNs?=
 =?utf-8?B?dS9wUHdsamQ1bmNoU1R3UjZzbDBuRTdhMW5yVjNXWXRjQXdaclJQelBKbk81?=
 =?utf-8?B?czY3SExiOEg2aGN0K2p3TEFjVmZUVEhCTXhaS1hjRytpcWhqVVY1NDd3eHIw?=
 =?utf-8?B?cmhUWGNVaWdVRkhlemZuZmhBUUF3N2NwaElsV2pQTXdnbjR2KzVoSlQrQW5J?=
 =?utf-8?B?Q3NNTGdzVlpTWWhvRUJsVjlmc1RmejZRSHJ6TnlUNHpXbWVSZEZuRWdxT2hD?=
 =?utf-8?B?MEtmQTczbFlkSlc4NThNK1hJeWQ1OUgxTEZubmlaeUFhaWhvVUJoV2doZGZC?=
 =?utf-8?B?Mnd1RGE0azBPV1d2Qm1EYk1MNEFVWHYxSFRHZCs2TGpwNVh4T201a00wZ0FP?=
 =?utf-8?B?OTRwaXkyR1BZVUJsY0o1UGxDN3hVTlAwVWlHYVpqSi9TcGFlQTlIakxIZzVH?=
 =?utf-8?B?R1JPZ2NNYVU0VXY3QVc3RnREdEhycUpHME9EYWU0emtLdWR2Y1VON01hbVZm?=
 =?utf-8?B?ejJTekJIRllraE9vL3FVbE1mKzFYSXA1MVExWDZzenhHN2J4OHJzdWswbmpW?=
 =?utf-8?B?Qk53NnVCSDJJQk1JY1pkMWMySGhneWMrcjY4Zkx5NTlxY1VEMzZqRVh3RVZN?=
 =?utf-8?B?eWJHcEtDRkVvb2pOeE1aQzZJSVR1RWJQeS83bkNDN2FUekM1WEVZdm8xVzlT?=
 =?utf-8?B?Y0NjNHF1TG8rK3BHS3d2Vjl5VzNFWFltS0U0WC85TzcybXhpSEZab3BjUWJt?=
 =?utf-8?B?S1Vpc1RwdCsrVmY5eGROTUQ0Nm93VHA2amVqMFg1c003M1R2dTZMYlBPcDFx?=
 =?utf-8?B?OVo3ek5jRjY3dlhXem1mZkxuUFAyQi8vMjlUSzRZUCtoUDh2WWxvbk1DbWUy?=
 =?utf-8?B?L3B5TCtWSVpQNUZDQnllM0g2c0gvRllBaFdCOVBYTnhQUkRQV0R5M0JWeDNq?=
 =?utf-8?B?VndEZEI1RnNhSUcxS0pieTRyT0xSYkFGZDZHRzg3YW1DQ0YvNHNxS1lndEZs?=
 =?utf-8?B?UFdObE4wU3h3Q3lMUk9IS0VaMC96UWFHeGFGdTVmbGE3SDhFR2Jqam1ubUpw?=
 =?utf-8?B?VnJKbCtydC92QXZqcThrdXBob3pkQjRnbzlZcENRZmtsaG1lNHJ6NURNK0Zj?=
 =?utf-8?B?ZXMzeTVDdFUxT1BBa28ybG82VnhwMEFiaVlHUGlldWlHNUxHS0c4QTM3Umcv?=
 =?utf-8?B?Rlp4S0Jlc1o0bVJKVllMdzZZazdhV1ZwN1VhQSsvNkczQldBQ3BpellWaVhB?=
 =?utf-8?B?OGlBYzZGSDBKUnJtZVBrWFRScTd2ZUN5K08rZitGWjlYODJuelQ4WTlzMlNZ?=
 =?utf-8?B?Y0p6cS9mbHU4bmlFNHN1VHJHaEZSVGNnRnNTbEdScEdWVVAxZFJPVGJyZnND?=
 =?utf-8?B?N3RlOHNHT0JFS25kdk54T3F6WU8xMzdZSzNvQTNpbTFBSDBNYk1Vd2srMGtj?=
 =?utf-8?B?QTFyZkV6MzhlQml6VmpzNytsUmFlUWY0aHFyRkNXT1hqRERwQzVFUlJvbXpN?=
 =?utf-8?B?SjNwalJzK3VPUHBvMS9QRUtUWUxoWENFR3k0Snp6WTl2RTBFNlNlZTRta2ta?=
 =?utf-8?B?VzJXaVdLbTN6Nk9uU25ta0tzZDUyYzI1UlR6YVhJZVZRemlSMUVWbVFnb0JG?=
 =?utf-8?B?cnRNRVpjUnRsT2ZvZnZNOTNaallDOHNqQ25iRHpKQ1BzRzRwbjFzazArUEc0?=
 =?utf-8?B?Tk14UjJWQW56NklCVHNXSkliTXIvS1JxNmp5Rnpudkx1ODIxTzhTT2NxV0tH?=
 =?utf-8?B?S0wvNkFtdnJieGhtZklKQUVKZDRUOWhRRDZtU0hlT2dJZGtpQi84L0lCU3dn?=
 =?utf-8?B?bHB6V2taakxYQm1TbU1WaWJnTCt4NldHcGpaYmFUNzZ5NkhZZE5rc3ZvNkFw?=
 =?utf-8?B?UTlpWjBMa3JLQ0R4NGlmYWRienZXNXI0T3daUkR3M0UyRlBDUFpCRWplMUdZ?=
 =?utf-8?Q?QvdJjBm2WpQW3RbtPnQeXQJfP8wf2GydqTgOoiJT5Y=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e091281-0308-465e-1892-08dc21c3e389
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 18:47:20.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOQKQ8A/YTgDzlomlYClKq/HphR0mVU3mJlvJ8ieRjuKP+Q6uzzZFvVCAjo6d5yh1PVWPlCqZhI9jaRK/bcYUKBKeOdnZtW23fRz6cssDtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9795

On 30.01.24 18:26, Matthias Kaehlcke wrote:
> On Tue, Jan 30, 2024 at 08:19:40AM -0800, Greg Kroah-Hartman wrote:
>> On Tue, Jan 30, 2024 at 04:11:29PM +0000, Matthias Kaehlcke wrote:
>>> Hi Javier,
>>>
>>> I understand your motivation for using the onboard_usb_hub driver
>>> for powering up a non-hub device, it feels a bit hacky to use it
>>> as is though. Re-using the driver might be the right thing to do,
>>> but then it should probably be renamed to onboard_usb_dev (or
>>> similar) and do the hub specific bits as special case.
>>>
>>> Greg, do you have any thoughts on this?
>>
>> Yeah, this worries me, adding non-hub support to this driver feels odd.
> 
> It is odd as long as this driver claims to be hub-specific, but truth
> is that the hub-specific bits are a small part of the driver, I think
> it might be worthwhile to consider adapting the driver to other devices
> if there is no clear better solution.

The driver was programmed for hubs from the beginning, and that makes
non-hub additions look weird, but I wonder if the other way round would
have been seen less odd: a generic onboard_usb_dev that ended up being
extended to support hub-specific capabilities. As Matthias pointed out,
most of the driver is generic, but I have to admit that adding a non-hub
device directly (without any renaming) does not look 100% right.

> A possible alternative could be a separate onboard_usb_dev driver for
> non-hub devices, with a similar structure as the onboard_hub driver,
> but without the hub-specific bits.
> 

I was thinking about that possibility too, but the new driver would be a
renamed onboard_usb_hub with less functionality. Its only added value
would be that it keeps onboard_usb_hub only for hubs. But if that is
exactly the goal, I have nothing against an onboard_usb_dev driver for
the next patch version. Adding a device-specific driver for such a
generic power sequence and resume/suspend support might not be the best
approach, though, especially if more USB devices with similar needs arise.

>> Why can't this all just be done in an individual driver for this device
>> itself?
> 
> I suppose the reason is the good old chicken-egg situation that the (USB)
> driver is only instantiated after the device has bee powered on, which is
> what the driver is supposed to take care of. For the onboard_hub driver
> this was solved by having a platform driver that is instantiated by the
> parent hub if the onboard hub has a device tree entry. Probably something
> similar would be needed for an individual driver, and the generic hub
> driver would have to call the equivalent of onboard_hub_create_pdevs()
> for all drivers of this type (or a wrapper that does this).
> 
> m.

The XVF3500 does not have kernel support so far, and once it reaches
normal operation and registers itself as a USB device, the communication
is achieved in userspace. What this device needs from a driver is only
the power sequence and eventually the resume/suspend support, which
makes it a good candidate for generic implementations.

Best regards,
Javier Carrasco

