Return-Path: <linux-kernel+bounces-103828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8562087C505
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FE2282F62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD0876900;
	Thu, 14 Mar 2024 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b="LFUY6Upc"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2029.outbound.protection.outlook.com [40.92.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63C763F4;
	Thu, 14 Mar 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710454390; cv=fail; b=l3/ql/tVSQYyL1lnsxdlr4bZ/zvXOdNudYdV1tPjYymXVADd/uAu1w6iZUDLL9kADg27O0q97YQ/IHHi+ww7B4Khm2nqi67NcZ1hTeut+KNzeGx95WC9fxuEPVG7Ft6GNN61U/Pew6AwlGSNZEJ3wLMyQvluvonCK0G8m/z1AVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710454390; c=relaxed/simple;
	bh=lCh9akS8NW3VSlz/i7rw09wvYMIFTxQV44lMdlrnecA=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=j97687zGnWI/4qQhTRAwOCl01CPWDXEqtsLyke+1HgKIvAHziaE0JfGMENsVkor83wMVtrX+raHG7oTqRqkamdtvSQkSslPgeWXCA0FwPyiJ1pyi31r1JLnJcAETUEbQCpz6Yki39wRg8rF2ZgyUvma5gXWlLZa7R4O9cb/Drlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk; spf=pass smtp.mailfrom=live.co.uk; dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b=LFUY6Upc; arc=fail smtp.client-ip=40.92.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.co.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+0U1GbFo/a8isvW5itEeRYT9MB4P6+sDJfSKVAzzGfz9KpaYELcC+g3wSymKVyc4i/HyyP70aUeOxElTiZPB3F38EsR5eqDFOtL9SKGhK6hlFSYl7Ab04t5aZ5iEPadpFMAIWK5n3enm4vvgAJ3PhbtjvedxHxaDs2eVHiLOLNkgpngci0MxmvqcIpWvymZo4nqT8/DSSj2uKZzqSFm9kxJwqsqsbPo9W/+MjOIj9zSzFYcyaTJ5FXIDoTChtW8V5qi2NGArHaJu/MYlaGrJtBDUrKXChb1RLoM+KkyKQ2qIwDcQZK3qm6+CBksJb7v5vdQqg/5Li6a53iGPrvlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCh9akS8NW3VSlz/i7rw09wvYMIFTxQV44lMdlrnecA=;
 b=NjVdBef7RhXG6KBFKtgp92hA1BMsVxj2Q2QpcW2txoQJWrrtvPcaEtCVY8+BxgPIrtkqU2gGveo+tbLkZRn8DodosdwakQ4arfCykRev/RpGB/bG9CXa6NrDF9VXZ+azjneccu+y5F/daxOUxNFi8wLbAPQDEZbeIoBSfEjGiL05tjxwB0BbG5n7dkt9xRO8VoT1Qny2jCpM023+ynzznZ4OejVIS2yv6Gw+O3oDlOGrb+EqF6Tz8z/bztwlZQr/rT+AIEieFAjEAJY4K4Oo3YVB2pfQzlBky8akdui/gp5n0DrYJjRTguQ1Xx/2bDDvvJopkHf0SkrKlX0j9GGU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCh9akS8NW3VSlz/i7rw09wvYMIFTxQV44lMdlrnecA=;
 b=LFUY6UpcAepv0aXD8zdsyrLO+kARnb+zxdTfjtoJI9msTvTy4YIcslos46v0Upn6o2ivCUhzBPuXru5DGoITXdoxjejWgzzaRB88ECOfXPEiabudZEAkxDRaN1vQxsjyvO1Tlg/Y5SiM5UXXA2XJTRiYH8xZ369WbNdRGEjn3dgrxZDg1ZzMRQDdsVATuTcrh5fpHTUj/BDOcJMnatoHioiGaIeXkssdxNw7VN3Xu5+Hw+BrxeKTd39pTZir5jxmeUNhYgkGFGnsIW/tN92lln3IBzHE4xy73qk+26HmtYBcdZWP1NqxX9dJU8JIMjurTiUkBLTHvLuxzTFTEgnLhQ==
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AM7PR02MB6017.eurprd02.prod.outlook.com (2603:10a6:20b:1a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.39; Thu, 14 Mar
 2024 22:13:05 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::ddc7:1abb:f9c3:2ca2]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::ddc7:1abb:f9c3:2ca2%5]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 22:13:05 +0000
Date: Thu, 14 Mar 2024 22:13:03 +0000
From: Cameron Williams <cang1@live.co.uk>
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: CH341 RTS/CTS flow control disabled in driver?
Message-ID:
 <DU0PR02MB7899EC8515D8FF35B4D01465C4292@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN: [pfQQ0Cbd2oXBm+pGErYRTd13m+yhSs8r]
X-ClientProxiedBy: LO2P265CA0089.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::29) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZfN2b6Uzkh9VlVyc@CHIHIRO>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AM7PR02MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: f7345db0-4acb-4d47-d0c1-08dc4473ec2b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ber5TmOKH8/FEHZbVc1KyPpaARYKFR4tzaS7LYtuCFMwim5X/985q5tJ8VXwIA6qcqT5DaQv1tODxOWm3vZ8oJfE6TStPUAr/ZED9MboP3pYhLKZ8a66/9GhCIASi+UJQ+jwAVkIG2XJaohM4//TwxU0a2v9E3rdyz442GVfYWsimasn/M56emMrAy9EGUtDe7pRpmo3gaSq+FSehlSPM6tSVOKMKQLj1uNQ84wvqCtUrj1k3GzQQV5slD/V1ZoluZ/iu2ufAeyExY7UwCxAjI3hwt8Ul6KUWgFzvr6v12KA6RYZQkmoM4tZh1wn1+k2mpL9NuY8BamW5vkxHgcmA5RVwe9rjT0jE5cafFnNHBO+/H8O4zpGqUzKNyw/Czr7zewaZSkpJHszNA+voedh942b9mGaLvuSsoNYDVXNJfPbSGVN/bIVrpMrG2rQIKceL72Hgo1xJA+so6zrwfgenQcPZ28Jjx8VWaQHXI1ZisV3K42OIjS8PpzpQpO/5+PpUQ9dsJblZ1DosYlJJu19jfI5lu6IZIq9UUOJ76xg0MFnvEzXmvSFE+U4HiRDe0uS
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+4pdAPMpsg2PeOJpGk2yGndaINt0LXR4sxdJ/hMlvRMNQyHzaTFq/vXEFGRN?=
 =?us-ascii?Q?Dd79i6Scn86DY+xcYTki+QdcKQYGygC4SRCDdOJJZSdMCJG38hQApJrJnZ7b?=
 =?us-ascii?Q?konXfdtwO75Ksyi1Eek6b8fCAHYmP9gVg/jImV9H1pWtJNIoVkLv1KI5KaZG?=
 =?us-ascii?Q?uqNFMRyQRyTKlbkO4qS53OQ1A7PIAZSHW/4Gie7zLNI4o+3KnwhSWTdkhUo5?=
 =?us-ascii?Q?P3nnYt6ZAhCtfe9jgH9kjjnLYOrO2fDPioDbODzSoGzmRHBW68oi+xT/iUs1?=
 =?us-ascii?Q?V+gH8rcmaUA/5m4aVg4w+eaRgI90OqgqWHvsUzUbtOxF6VNMgoLI5snNtIg5?=
 =?us-ascii?Q?eJIR6cDlbuxgeDeubFCQTfzAA8Y9UcgCmYH6QJifK9Ow8Ay/KwGLx3GyI1H4?=
 =?us-ascii?Q?nsL+KLz57WKQ8wp/WxpPQbueDIzECW4mrkgTYDNAIepziulR1Kst5vZXOPrG?=
 =?us-ascii?Q?F/ZgTrWjgR74FVyiCU+HAQ/dHhI4vTsNvvYTg8smPA/cPZpOlvXfmQ6p4rAW?=
 =?us-ascii?Q?dfwMtyzfXvLMmteS7IH2aeX/hw9A6tdo1PfhdQ4Z7DlJAb94C2E8bMoLP1iu?=
 =?us-ascii?Q?gk6Pj4qFNF/SM2DFfQa93J2I+3Pim+s8eDeOqYN7pGStEa8WagonJyxRtSxO?=
 =?us-ascii?Q?45+tlDUGOkkqpx5dgpMKIFCqphaP8Pi6kz8SSFKp+8hmZpKe1SEKGru8asfx?=
 =?us-ascii?Q?PBCBqX7hG19SQJPuz+zzeGY/7yQ7xofbd9w6LPMkXL1NbhP/kO9uvSQGdb4Z?=
 =?us-ascii?Q?BDaKr4oA/Hf905IqMQyJrfBlx7KvfWPAzGSh3TznwVF1MwqYiiA5IBI4v50X?=
 =?us-ascii?Q?fBOy8PQe6Jl2DWSNjkxUO4KQ6UX7G8m2f2iD43wRtYxaB764WfyR5PSMaoHS?=
 =?us-ascii?Q?ZoNUyoQfhJzfjsyzgDWtq6mGRa6FeLroazoE55IX75KLKCabeRLtYloZFyiN?=
 =?us-ascii?Q?eOAaBGgTFSynJ3ttXqeWZDZJDlDJYnz95nWi1NyjSUyiAS5MpAEUIZoKpRYM?=
 =?us-ascii?Q?tDeriu6uHbSi4UjtbZkwXpTXON03R4hFMEVJx7t8G7N1U8ISD3Lp2NMKHSXp?=
 =?us-ascii?Q?6SYZT868HUv3oc+jCKufhrDZg82W88hLXJhveEZKCOSvDWKKwq10NMIKtva9?=
 =?us-ascii?Q?XM2wTE0NSI/NiTRlXPcgUrJM6+lewmhhZ4gQKOZ/XzRUdcVs6aobIy6DzSPy?=
 =?us-ascii?Q?2a1HbRCNBEQBojyFhdvlKhI0/Ba6X4aQmPpaWw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f7345db0-4acb-4d47-d0c1-08dc4473ec2b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 22:13:05.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6017

Hi all.

I am wondering if anyone knows anything regarding the RTS/CTS lines on the CH341 (maybe CH340 though I have no chip example).
I have two CH341-based devices, both a generic 3V3 uart and also an all-in-one type device with SPI/I2C.

From my tests, neither of them seem to have RTS/CTS respected, and I don't believe they are fake?

My test procedure is as follows:
1) Have nothing connected except TxD/RxD via a jumper.
2) Open `statserial` to check the status of the lines. On all devices, RTS is set to 1 and CTS is set to 0.
3) Open PuTTY, ttyUSB0, 9600 baud, RTS/CTS flow control. Data should not flow as CTS is not high. Close PuTTY.
4) Open PuTTY again, same settings, but with no flow control. Characters buffered from step 3 should now appear thanks to the loopback in step 1.

Alternatively, for step 3 and 4, set Picocom to use RTS/CTS, send some data, then disable flow control, and the buffered data will now flow.

Using an (albeit fake) FTDI device, and PL2303 based device, they both work as expected.
A CP2102 doesn't like to exit with stuff already in the buffer (just hangs PuTTY), but thats a separate issue, and at least it is respecting CTS/RTS.

However with both CH341 devices I have, on step 3, the data flows regardless. Checking in statserial, CTS is indeed still set to 0.

Is this intended behaviour? Looking through the source I can see RTS/DTR should be supported, but it just doesn't seem to work.

If anyone wants to look at it I'm happy to help debug.

