Return-Path: <linux-kernel+bounces-99245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF55878582
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9711C224EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B2052F8C;
	Mon, 11 Mar 2024 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="mBHJF1jL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="LAmMJtfv"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2099.outbound.protection.outlook.com [40.107.6.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDAD52F72
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.99
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174654; cv=fail; b=Em52DavbhrPOM3Qy9JJb8jJ8jvJqfZyXJ2Hxf0om+1DZUcm6m32eypRTW/ZBjbG50ZsJicATASgE9i8Dkm+Sl2V6NiQFu3VkaYkKopELi/jIKZbjcut8aToeYgwa+7jLn7jDDJc4YFJThcp22MdyoktsIxbhs8nUWsaO4buvpaQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174654; c=relaxed/simple;
	bh=bOH6U5GcCgQfQeLXC1sf8MFL28CYIkNu+zK1ca6L+XA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XzXlOi1ViMP8okr92Y2uvg6rIB0zW8jJwlyN0jRSq3havErs7bKXMSLY+gxKoqyazH532MkkmvtEhhcyX0jvzPJDT5C35+U0HvrUY4hedOHDPXVvg3viuU08CrIMuJb1PZUTcTLH5R0GyW0bcflTvcYVA+eUQONnODCNU56rV54=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=mBHJF1jL; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=LAmMJtfv reason="signature verification failed"; arc=fail smtp.client-ip=40.107.6.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=HX6AQtcYXGTHRRBUMMXJQUTDhlqI6ETmzQ3lygNx30XYLNXBZH37r94jqzGhdZiQS8ClETZ5/X/FYOCELrYdgv6rPjnPoBonrUsc00ZZvZOr94DqHpSLrxMpcKpI41NlURFGoJmww0KbibSQTJuLJ34pt0YuS0VKZgLK2dcmlwYgXZSXJcwqNWNcdkV3KzZvqTqMX15WXJlteqYdbTWeEPK8rXOnviIbwW3VOaX8pETY2QIW8RJX4wY5deBTi+Awcu7BGu2EqAJySx1Yn2eecrLJ3xy5P+WIInlUbI1jPtGZuijP4QmvckPGVnp5rRkpJpYTZRjxC+yet0XlQNCAPQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMl0YVFXbYPwRPAiswxcdDUQiv/UM6XOmCEKNNNdLEQ=;
 b=C4vRyHTJT5Ny7t0l87kYfTkG1vtCea+PI0W/1/E//uO3jlAX1sRJYF0cBO5o0ilgFvIksHICJzlBNLBUCRkhKMOi9mNaa/WxCofKDKoNLqWFhJGP1/ljbf0rGEGovG5F0wVSrGT3i8edZoh401u+f7CxY2T4EplMrKRvirQMPFNwePsGYd8haPYqy0GkkRPWymPUvoHAqe9owdE73BAegIvUmUr69NztErmY8P/h356s1cMvCv4extQAOuvdTdzHUCO6ojepS+YLXmvKYuAyuDXZZSfmPmkb5voQtI2lmaPvQF9MV9OSl/Vg3jxZcGsXz9OWnsg+FrcNWUFCJit15g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.84) smtp.rcpttodomain=alu.unizg.hr smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMl0YVFXbYPwRPAiswxcdDUQiv/UM6XOmCEKNNNdLEQ=;
 b=mBHJF1jLGSZi1Y873OSNcw5VqmlX2K42YvbbqJ786+aE4TSiyPN1zRzeLGfN5Fg5KjZ3wyI3HN1s9Bhy68SoDVysAxmgwo7p9e3R7vH6WD9FcShlIp49Or2YuoycvRIvfftnn8GLWlPG9JLY0yFD8FeB+yv2EQpXd4GINcGdOtRxtbRplGrmsyXgpFN8WmcWearE53MdzVjonZ1gbzyfEMOg9PfBu/o7e7fNJcqNOy/QoJygA72vtiIp419lm1tm39rSkkaA/g2K0lDw953mmJv6Nyy9q+E1Zo0EB4Zkdd3+IkqXmMauKqpjtvJhvyOz2A1Smo3lYWW5T+7hQenaOg==
Received: from AM0PR06CA0074.eurprd06.prod.outlook.com (2603:10a6:208:fa::15)
 by AS8PR03MB8394.eurprd03.prod.outlook.com (2603:10a6:20b:526::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 16:30:45 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:208:fa:cafe::8) by AM0PR06CA0074.outlook.office365.com
 (2603:10a6:208:fa::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 16:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.84) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 16:30:45 +0000
Received: from outmta (unknown [192.168.82.132])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 418EB2009538A;
	Mon, 11 Mar 2024 16:30:45 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown [104.47.13.51])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 367422008006F;
	Mon, 11 Mar 2024 16:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ca4wQyyAUrb7KdzoKBVaN/ix7Tm0Web2K5hiJYaZehNOY3UeKOcY3jx7sGKKqvbSbhZzgW3jLOkd2k5SbkwolQnYZ+7NklrMrIPT6p1fw/LW71X1KOh4tYhSxgiQ2F99IAigPH9GDrRzZxdMMmoBTUch4JbmcK5ZtFFi8cAoWOWBstyUMpws9OEWdO1p2mT4u53kz2vbNY0AXpy/XJa/k/WIxClELh4+wH5sCJr+iXoRyiXSRj8UBdf+2Fk73Ytfuk6WpgLjhr2UqISklKvgQBE28prJPWbLw1MgnLF6R/VL7UMgRvhcqN7XQxzg9Z1G1YLKoe3bqzGqH94PwgHOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz36JtLpWg14Gc3LFSqKTHws3eWq96D50LfaNObr6Ag=;
 b=b9XWZhVhE8MNk/qMxHhpDoi7nfngWKEjqDCjDKyl4wMLHQmUePOCsUf2JmXPulwvStwQcRQQA00SFYyfLz7plAjHQIw1TwqD5dEQ1j8IpKxa+u395TnYeLqRAG+YV4tOumLVnVTfwZEm6D0eoaxVWv1DHCn3hTue6W0kcW44KTh4gmt30S3OLrYRUYw1+JLPv/zBklaBfOWGcJtHgPUVYe+nmfh1xs5IfPle3lJzsW22mR3AdcaoVfSu3XN6rijBIB42CN7f7Z4BfkskL19KN5mb6Khh+7SDr8lqwfVDmiglqP9LFkUOIh4Jat8KEU3WYdkJCMHsg7s+f8WNfsF9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz36JtLpWg14Gc3LFSqKTHws3eWq96D50LfaNObr6Ag=;
 b=LAmMJtfvdIi33+0WO4LAx5fs0TRGK9b6TWCeAclUxMSeDp7BfTH8gXWNEMv7oP/SUyb+1loWK9bEgTNH4rST6qDkfMVqxLuugpjkB5bzuGTysk8CpYJdiToZkpjGovvA0YLS45aRv3XUqaqeS8fgZUtrD9pwPkFYNV63VAGu5FUwN2d8idUeqBOdxnCaCN4H493fQf1qpHpC3wvDZCIdfwSXsabn3/0eAWhdUPu0xZPqlsCXmGPf8HGBXlOZXy4+u7hdSrqpYH4115tZnAaEj4GgHXs6t6M7kEVG+j1yQOwvVGNwaXazdkXyDqI6OG2c66mUYCQYg7anP9YLNICspQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by DU0PR03MB8854.eurprd03.prod.outlook.com (2603:10a6:10:40e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Mon, 11 Mar
 2024 16:30:41 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:30:40 +0000
Message-ID: <ab147205-41cc-4c1b-8280-000e638b6534@seco.com>
Date: Mon, 11 Mar 2024 12:30:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] KCSAN: data-race in tick_nohz_idle_stop_tick /
 tick_nohz_next_event
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
 linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>
References: <40ac9903-469a-b1ea-4339-8b06f855450e@alu.unizg.hr>
 <3993c468-fdac-2ff2-c3ee-9784c098694c@alu.unizg.hr>
 <83b3c900-d4eb-457f-99e6-cb21e0eae4cb@seco.com> <87a5n4rfhu.ffs@tglx>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <87a5n4rfhu.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|DU0PR03MB8854:EE_|AM4PEPF00027A66:EE_|AS8PR03MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b59124-4a13-4ab9-891f-08dc41e89a36
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 m5NvIk23iIX5mwtVGxJZFHZWVGF8iHN6xXyeKJF53i2M0ggTRa5g+tSprtFQrnYIi0jk8J828bug1A89Pp1+R9nEalxxyrgMD7Ocd4JKdR2jC77zHIVTVawQktQzsMeZnsYWYR7c6nIeezsKXGM3grCLoYjcr3f1k1ZiiGnYs9hBem6O1usFsyubADZEWiGwd4YTAAFemhm9vegGtSa8bWBulIrPZA+vplwRpB3oBDkZqutnlmenT8mKsBd/zFjTjikDgLWv7q/nmXVHShQHDPzMeKz7oRJiB1RnxT4iCA7jc+mJ4RZNFap75XIFjDW9NyZ1jjQWx1Q8tMvFuvvkGfkRJXu+a1iEUbso6HMRdesfyp6wClSaKryAoV8ntPnL/kH+wslSLK/HuW9QkbslrbvuZSlRU0S2fGBX14vrK756cFN9zQef6QRgt3lnOGk3xvtGPi/GSOpuUD3Gh7Eh04NkTiEFpNuYZkkIRWUaSIeM+KrQfyxaXqL1VqYGdt9UI2CCamEUbm+JskY6oYLOhkSZEVaHvRwx5i4vo/wda66egVRk9l5gihF2piWNOyY3AqRgz/42NEmxu5a4PKDh0cIVxKE2ls4C2vRIa/3qv79W2fQmz0DeiNWbICSc3FRSB71u5SQ1HcgSmUeS4igcuGTH+BQzJwy5MY269mF/6K2yMXESse3wQhmzrf/TYgnun99hZs0cWkYkuaP3ajp162ymsnX1kEDuaJ/r969i9nk=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8854
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	50f588ab-fc62-4f2e-7af9-08dc41e896e1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cuenmYHrUME3Llm0pMBLdNLSXSD8wWhjXwHYc6ZmHHSAcCsrNlgyZG4mZV5l6Jx//QJtnEa+oOFD5jrwof5LCqZm+HcpbqVCt4Vx+o9cRW8j/gaFg61Nr0fh6NTqWvHgYW0D9uIpoioacug00DU5JRYgAykMCa9KnaSoKihc5rIva1qNlCUSgpgm+DfSVQ28VCgp9zpU0qG9czy4LHGVAXO28VJcv4HLMMTQV8iBeIZe6fpjZPEbqPDc0TD0982Upk2VxKNC4fwj0vdSHgGvnOg70epdk0MC+8wYVQBHBmThdsgieuaWCJapnJaAgqmeVBSPAbOYxt2YGLQ2gNHmNv4q/s8PDtmGJEWQDpRUaP2rGcbziLHuW1M41ylXyyUfm6mGfR2jWjQheKK7qZW7Zo94AwROwHHvtJtI5EkfaZsWH2hdMwJqP+Xz4Gp26oKBrjBwMambH34f7P525whzSGG4olZzHNN33B6JX6rgMjEhXVTCGmlEcKcmiDI4N7v3dgG/isF0He6mGtcpVV30lH83YI+JKFiT6p1Vx+iw5ToJ2v8apZdSh9IPUmqNjjQ9i2TfrEOHi4QTs2Bk0ft9YqZ4dRKMT80L5CYtwvRblhKDTYnldZ6Wmtn/+HM878wOG2o75OA7Y8VDkrQTiJCQr745NnRw2aiN1dE2ok2FMiV5BwFGPpUFX8lZIqmF/w7XBhbDy5JHWMe1pQn0g8Y4b2/do1kXxFj1RvVldpoumhjCfXBqrokHS0hsn09QGhkx
X-Forefront-Antispam-Report:
	CIP:20.160.56.84;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:30:45.4782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b59124-4a13-4ab9-891f-08dc41e89a36
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.84];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8394

On 3/11/24 10:48, Thomas Gleixner wrote:
> On Thu, Mar 07 2024 at 14:43, Sean Anderson wrote:
>> On 8/18/23 10:15, Mirsad Todorovac wrote:
>>
>> The justification seems to be in tick_sched_do_timer:
>>
>>         /*
>>          * Check if the do_timer duty was dropped. We don't care about
>>          * concurrency: This happens only when the CPU in charge went
>>          * into a long sleep. If two CPUs happen to assign themselves to
>>          * this duty, then the jiffies update is still serialized by
>>          * jiffies_lock.
>>          *
>>          * If nohz_full is enabled, this should not happen because the
>>          * tick_do_timer_cpu never relinquishes.
>>          */
>>
>> with the other assignment being in tick_nohz_stop_tick. I'm not familiar
>> enough with this code to say whether we should be using READ/WRITE_ONCE
>> or maybe just data_race (as would be implied by the comment above).
>
> It wants to be READ/WRITE_ONCE(). Something like the untested below,
> which applies to -next or the master branch of the tip tree.
>
> Thanks,
>
>         tglx
> ---
>
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -7,6 +7,7 @@
>   * Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
>   * Copyright(C) 2006-2007, Timesys Corp., Thomas Gleixner
>   */
> +#include <linux/compiler.h>
>  #include <linux/cpu.h>
>  #include <linux/err.h>
>  #include <linux/hrtimer.h>
> @@ -84,7 +85,7 @@ int tick_is_oneshot_available(void)
>   */
>  static void tick_periodic(int cpu)
>  {
> -     if (tick_do_timer_cpu =3D=3D cpu) {
> +     if (READ_ONCE(tick_do_timer_cpu) =3D=3D cpu) {
>               raw_spin_lock(&jiffies_lock);
>               write_seqcount_begin(&jiffies_seq);
>
> @@ -215,8 +216,8 @@ static void tick_setup_device(struct tic
>                * If no cpu took the do_timer update, assign it to
>                * this cpu:
>                */
> -             if (tick_do_timer_cpu =3D=3D TICK_DO_TIMER_BOOT) {
> -                     tick_do_timer_cpu =3D cpu;
> +             if (READ_ONCE(tick_do_timer_cpu) =3D=3D TICK_DO_TIMER_BOOT)=
 {
> +                     WRITE_ONCE(tick_do_timer_cpu, cpu);
>                       tick_next_period =3D ktime_get();
>  #ifdef CONFIG_NO_HZ_FULL
>                       /*
> @@ -232,7 +233,7 @@ static void tick_setup_device(struct tic
>                                               !tick_nohz_full_cpu(cpu)) {
>                       tick_take_do_timer_from_boot();
>                       tick_do_timer_boot_cpu =3D -1;
> -                     WARN_ON(tick_do_timer_cpu !=3D cpu);
> +                     WARN_ON(READ_ON_ONCE(tick_do_timer_cpu) !=3D cpu);
>  #endif
>               }
>
> @@ -406,10 +407,10 @@ void tick_assert_timekeeping_handover(vo
>  int tick_cpu_dying(unsigned int dying_cpu)
>  {
>       /*
> -      * If the current CPU is the timekeeper, it's the only one that
> -      * can safely hand over its duty. Also all online CPUs are in
> -      * stop machine, guaranteed not to be idle, therefore it's safe
> -      * to pick any online successor.
> +      * If the current CPU is the timekeeper, it's the only one that can
> +      * safely hand over its duty. Also all online CPUs are in stop
> +      * machine, guaranteed not to be idle, therefore there is no
> +      * concurrency and it's safe to pick any online successor.
>        */
>       if (tick_do_timer_cpu =3D=3D dying_cpu)
>               tick_do_timer_cpu =3D cpumask_first(cpu_online_mask);
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -8,6 +8,7 @@
>   *
>   *  Started by: Thomas Gleixner and Ingo Molnar
>   */
> +#include <linux/compiler.h>
>  #include <linux/cpu.h>
>  #include <linux/err.h>
>  #include <linux/hrtimer.h>
> @@ -204,7 +205,7 @@ static inline void tick_sched_flag_clear
>
>  static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
>  {
> -     int cpu =3D smp_processor_id();
> +     int tick_cpu, cpu =3D smp_processor_id();
>
>       /*
>        * Check if the do_timer duty was dropped. We don't care about
> @@ -216,16 +217,18 @@ static void tick_sched_do_timer(struct t
>        * If nohz_full is enabled, this should not happen because the
>        * 'tick_do_timer_cpu' CPU never relinquishes.
>        */
> -     if (IS_ENABLED(CONFIG_NO_HZ_COMMON) &&
> -         unlikely(tick_do_timer_cpu =3D=3D TICK_DO_TIMER_NONE)) {
> +     tick_cpu =3D READ_ONCE(tick_do_timer_cpu);
> +
> +     if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && unlikely(tick_cpu =3D=3D TIC=
K_DO_TIMER_NONE)) {
>  #ifdef CONFIG_NO_HZ_FULL
>               WARN_ON_ONCE(tick_nohz_full_running);
>  #endif
> -             tick_do_timer_cpu =3D cpu;
> +             WRITE_ONCE(tick_do_timer_cpu, cpu);
> +             tick_cpu =3D cpu;
>       }
>
>       /* Check if jiffies need an update */
> -     if (tick_do_timer_cpu =3D=3D cpu)
> +     if (tick_cpu =3D=3D cpu)
>               tick_do_update_jiffies64(now);
>
>       /*
> @@ -610,7 +613,7 @@ bool tick_nohz_cpu_hotpluggable(unsigned
>        * timers, workqueues, timekeeping, ...) on behalf of full dynticks
>        * CPUs. It must remain online when nohz full is enabled.
>        */
> -     if (tick_nohz_full_running && tick_do_timer_cpu =3D=3D cpu)
> +     if (tick_nohz_full_running && READ_ONCE(tick_do_timer_cpu) =3D=3D c=
pu)
>               return false;
>       return true;
>  }
> @@ -890,6 +893,7 @@ static ktime_t tick_nohz_next_event(stru
>  {
>       u64 basemono, next_tick, delta, expires;
>       unsigned long basejiff;
> +     int tick_cpu;
>
>       basemono =3D get_jiffies_update(&basejiff);
>       ts->last_jiffies =3D basejiff;
> @@ -946,9 +950,9 @@ static ktime_t tick_nohz_next_event(stru
>        * Otherwise we can sleep as long as we want.
>        */
>       delta =3D timekeeping_max_deferment();
> -     if (cpu !=3D tick_do_timer_cpu &&
> -         (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE ||
> -          !tick_sched_flag_test(ts, TS_FLAG_DO_TIMER_LAST)))
> +     tick_cpu =3D READ_ONCE(tick_do_timer_cpu);
> +     if (tick_cpu !=3D cpu &&
> +         (tick_cpu !=3D TICK_DO_TIMER_NONE || !tick_sched_flag_test(ts, =
TS_FLAG_DO_TIMER_LAST)))
>               delta =3D KTIME_MAX;
>
>       /* Calculate the next expiry time */
> @@ -969,6 +973,7 @@ static void tick_nohz_stop_tick(struct t
>       unsigned long basejiff =3D ts->last_jiffies;
>       u64 basemono =3D ts->timer_expires_base;
>       bool timer_idle =3D tick_sched_flag_test(ts, TS_FLAG_STOPPED);
> +     int tick_cpu;
>       u64 expires;
>
>       /* Make sure we won't be trying to stop it twice in a row. */
> @@ -1006,10 +1011,11 @@ static void tick_nohz_stop_tick(struct t
>        * do_timer() never gets invoked. Keep track of the fact that it
>        * was the one which had the do_timer() duty last.
>        */
> -     if (cpu =3D=3D tick_do_timer_cpu) {
> -             tick_do_timer_cpu =3D TICK_DO_TIMER_NONE;
> +     tick_cpu =3D READ_ONCE(tick_do_timer_cpu);
> +     if (tick_cpu =3D=3D cpu) {
> +             WRITE_ONCE(tick_do_timer_cpu, TICK_DO_TIMER_NONE);
>               tick_sched_flag_set(ts, TS_FLAG_DO_TIMER_LAST);
> -     } else if (tick_do_timer_cpu !=3D TICK_DO_TIMER_NONE) {
> +     } else if (tick_cpu !=3D TICK_DO_TIMER_NONE) {
>               tick_sched_flag_clear(ts, TS_FLAG_DO_TIMER_LAST);
>       }
>
> @@ -1172,15 +1178,17 @@ static bool can_stop_idle_tick(int cpu,
>               return false;
>
>       if (tick_nohz_full_enabled()) {
> +             int tick_cpu =3D READ_ONCE(tick_do_timer_cpu);
> +
>               /*
>                * Keep the tick alive to guarantee timekeeping progression
>                * if there are full dynticks CPUs around
>                */
> -             if (tick_do_timer_cpu =3D=3D cpu)
> +             if (tick_cpu =3D=3D cpu)
>                       return false;
>
>               /* Should not happen for nohz-full */
> -             if (WARN_ON_ONCE(tick_do_timer_cpu =3D=3D TICK_DO_TIMER_NON=
E))
> +             if (WARN_ON_ONCE(tick_cpu =3D=3D TICK_DO_TIMER_NONE))
>                       return false;
>       }

This fixes the issue for me (tested on 6.6; tweaked a bit for conflicts).

--Sean


[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>

