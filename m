Return-Path: <linux-kernel+bounces-166300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD428B98BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE121F2401B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E2F58234;
	Thu,  2 May 2024 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f3sgBrkd";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f3sgBrkd"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3AA5490A
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.60
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645595; cv=fail; b=IiUlgop3OmHOOLP/T8sC16u7tbPms49uWJNhRoNHt030qU7bjKNHm7CXr+BDTZX3AEN30pRYQRpMXYHMd8sixe/b4kfwZ2GOwxGOwMYQzdY07k+nkA7tkRW+itCnIyy+0L+IWoLwzfGAfhDjVcMFo3xdpsUNZPH+1nnLBJv0WOY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645595; c=relaxed/simple;
	bh=xwsHuJTXAQ8CmQ57u17bWhVqT2tr0nElTU4onuk/5Fk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q2QgF+FPvQXDcGOmzk0xPP1cN5yBv5EcV38NZ9JK64ekPhtzBY0M4jF9Z9OmtsTL+KENxw++1vjMGsDCSI3JJHswfpCgfu7q3pLunnkZ+XfRdXHgKYsfqV6ksxhJ25Tv23H2dBL20iHCHz2gtuzhnVpWGCY7ApV/9v8yiG2A3iM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f3sgBrkd; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f3sgBrkd; arc=fail smtp.client-ip=40.107.6.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=LBLsnjsaB15VSRsQzEHf2OJCoow6I8gAKCBsQQKYxCNeKEt1mZEEqnRPOBTiU6BNXfooJWQPN36kHoY5RHrSFPpCTonXGhhdJUH37nGVX2BtwNwltIJfbiHZGcpPQDEBo8QE54CUZY/diFh/rNJiRzxLuXrWzFXG4RUS2+r242xpSshlXkmUUY5XMs0w7vSZRWIOp/zDZjH6rOi4+oEvu99ppXUMB9CI2ypSUu26l6DknmXWkm+30x2A9kbnnoETOelCOe1SJG031BMU0DXVeWI/UIV5QoJk7RhODiFo9JZDaogggq8mAAoMMi3EzzNLU6dgMIIlq9OuVjzo9h96bQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT4u6rmL2hpHHOdVXLb6xG9loEiJEVZx0LNroJAMWxQ=;
 b=arLvz2SvE9234VIxR8uAPb7QocI0vOyaP9Xv5aNRSV4ss5RAnNgnoJHTGmtv4DDA6YoN3/Vj+SkoOcmFN3usYlJpy5oM7wu4HBCrR3KuckifhO1EFggEIAYZS6OwbsDZ3YDg5pUb2+tIhpsBkZqFj+L/BK13TqLe3XCjxezm4AeV9PsaxcZ7nBtvBKLpMjf88FeGcBKt2dxzCGdBEcimdtKkV+uos5rgbZ7pn5jmZo9ntL7pmMGUu0MpNq0rtfbThzOv35DmSbTPC+ub+g1XtW+tIb6VheEB+ys0Fp+09Kx+aMYFzukM/K28YQuGDmBaG+QVdD6Jnm4NZLSMr+VmjA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT4u6rmL2hpHHOdVXLb6xG9loEiJEVZx0LNroJAMWxQ=;
 b=f3sgBrkdU/JleJHVG6+Ps+lMkQzhgGsOV8AZcd/1GAEMPeQZQ4RAcCghX4Pu49nih8xzEzIBihdyyhQPN5GOpbKvPiAYwYZqhOQ3EZVifIq71P2nEAjPxGzp89Gpu0mSvc7m3wKwL3I+KYrRfxpnkyPZAg1N7XO9CBo7jmYRXOA=
Received: from DUZPR01CA0307.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::23) by AM9PR08MB6084.eurprd08.prod.outlook.com
 (2603:10a6:20b:287::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 10:26:27 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::1c) by DUZPR01CA0307.outlook.office365.com
 (2603:10a6:10:4ba::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 10:26:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7544.18
 via Frontend Transport; Thu, 2 May 2024 10:26:27 +0000
Received: ("Tessian outbound e46bb127ed3d:v315"); Thu, 02 May 2024 10:26:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ef96d2d44f8ab733
X-CR-MTA-TID: 64aa7808
Received: from 439314e4520f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id B389284F-4021-47A2-8B20-6DEA2F0B54CF.1;
	Thu, 02 May 2024 10:26:20 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 439314e4520f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 May 2024 10:26:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X98CKdXoU66WXGjn/4wwaWPjOeh3H1LmxsJAUPZdNfqy8hn59JHUDEXXfYjsUAI9HOiByMEJpSiCN+spfk3yEwNankVaU9S3Q/QWs90JjsO+dz5B1JNTxBzArXRnjKK6d8TMHaWLCHbgss09iwRCSHETM5F6ivq1VBRaU4ZUsHswM9DnKSvIIlZ7zaeXutiDKqZs0jNEGhPpasIt2lXfbtM6aDAELu3fu4Ead3lYThR+OZDDcPffakqGESwAwZleUOvShFW3JkWkZSBVbE5m7yyIGiZeXp3ehNQi0jThpRWSU3v5HYt3Y79m2pBh6PV3Fw5Yj3q7/BJrFkxNaeutwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT4u6rmL2hpHHOdVXLb6xG9loEiJEVZx0LNroJAMWxQ=;
 b=miGv95OejtpRnNdbrKlQp9ejy1hpi5ifLTrRIg8Npu1ZMb15VriJtdFK5n9rcYsAAmcmEnwrz4P6szo0J1tRaTCGYtbiULw4BeuMfTnAyk+LTgRkCGFt/rBuFmPZpiQhhlBWBKwfB/hZJ8J2Ca6UPtLCUZ8zbO9nEHfTMi8BXTWN6tBScNt0xgKpCDXkJEpcvlFt4jmc6eMeHInYGlwY4Ch/QJo9TuZZdOn3EswRemhTNk2e4omg/aTnSL7FGtNY67myrh3aRndx7qBIbVwPpmL4ZYSONRCxmh0rHfz+GcxNhQPsHcjURMLfSSZWaQ8tEAz5ddMXNimEHq9fKuqC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT4u6rmL2hpHHOdVXLb6xG9loEiJEVZx0LNroJAMWxQ=;
 b=f3sgBrkdU/JleJHVG6+Ps+lMkQzhgGsOV8AZcd/1GAEMPeQZQ4RAcCghX4Pu49nih8xzEzIBihdyyhQPN5GOpbKvPiAYwYZqhOQ3EZVifIq71P2nEAjPxGzp89Gpu0mSvc7m3wKwL3I+KYrRfxpnkyPZAg1N7XO9CBo7jmYRXOA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by PAWPR08MB11195.eurprd08.prod.outlook.com (2603:10a6:102:469::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 10:26:18 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472%4]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 10:26:18 +0000
Message-ID: <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
Date: Thu, 2 May 2024 11:26:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de, nd
 <nd@arm.com>, John Stultz <jstultz@google.com>, Hongyan.Xia2@arm.com
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
In-Reply-To: <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0303.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::14) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|PAWPR08MB11195:EE_|DU2PEPF00028D0A:EE_|AM9PR08MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f5ba1b-bb34-4cc3-a11d-08dc6a92535d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dWFrSG1pc2R1TmZLQXdzRFNCNitUbC9qVWUwSnR2Z3FNZmJFQk41U2c1OGhW?=
 =?utf-8?B?aHNtU3dGS2w2NDdVQmkxcHJPUC9jczVEdEdxMGRaSHB2SWo2VVZHMVlLcHhn?=
 =?utf-8?B?cC82dk5leGNpY3BIbFZ3QVBhZTRQMWJMTExCTXZaYTZxYXpYblBLODliNnFJ?=
 =?utf-8?B?OWdONm45MnV1SFZTVjRjaEpCZ3RFMUZoVWJxdncrdnlpN05oVXh0WVI3N3B3?=
 =?utf-8?B?NUdpQTJIdE5KaFpKdkh2aEgrTUFhcEJOOEhRT1dNMTBmeGJBU3NMQ1ZZclBR?=
 =?utf-8?B?R2ZMRmQ5K3pDWTh1REtNWDlIbENWUFRYbWdaUHNYNUh5OHZ3WW1lVkduVTlM?=
 =?utf-8?B?V3NwZ1VxN3hyOGhkQUlEWTByNFdJYnhzTzg1SVpyMjVQb3VCczNkY0EvYTZN?=
 =?utf-8?B?Z2o1dm0vTjF6UmNUKzhkU0RBWnQrOER6UGtvVXozTEo5WTFRZXdWYVFyRTk3?=
 =?utf-8?B?STVuU0FWOUtWNUo4elgzdDFYOTgzdXk5V082eC8wQ0FuMFR3aGV4Y0NwK0hq?=
 =?utf-8?B?ODZPUTV6ZDdIbkxMbFdTaDZRY3dJenBiZlJ3bHpKczFjWGpjWkpGTzNPb2pp?=
 =?utf-8?B?QklIWXFENXlWeE1oOFpWeWpUQW9zc2t1bUVkYXJKdk42eTV0ZHVXYzFoR3Ni?=
 =?utf-8?B?NDVtOHQxS3hIM2h2V3kybk5vODJtREFGM3dBRTFJbEVtUFR5ZlhJdWFvZ2lF?=
 =?utf-8?B?aERQNVIvOUN2aTcxSXF0MzRuS0lMbmhnYnZ3SERoZHNjUDd3WEdYL291VTRO?=
 =?utf-8?B?WWRoTGZpRnA3bmxuSEo0WS9aRXFPUG9qQVpNM3pzR1k2alJkc1VvNk1Jc0pW?=
 =?utf-8?B?aW9MaXBocmxBVVpMaEN4NjY4K2xsdzU0eGU4bk9IdUpZZE1OdFppdEtxUmN0?=
 =?utf-8?B?R3dhcGhtRGNqbVZ3Yzc4cS93bE1YMkIxTVBYQmZTMEF3b0RLajJETm5JVUVw?=
 =?utf-8?B?cEhIQzdHMXNGUHFNbnVHclRuTlo3dDJNaUp4aEp0N2IyRFdDVUtBN29acHNS?=
 =?utf-8?B?TlMwNjlaVlhNc1F1UTkrTk1jOGluMVQzUWxMak9RNzVRVS9ma3lmRDdsSkRT?=
 =?utf-8?B?VG5VK3ZVa1B1eXFVa0dTRFlXRWJCUXpWVTF1cW4rZTQ2S0VyVHVuaTNDbUp1?=
 =?utf-8?B?YVF2MGdjaXY1cnowU2R0cFNpWjIxQ0xDYkZReXYwbWdzSXIvOUlnRmlLbjdH?=
 =?utf-8?B?WDY2dGRzcEVqbHNzalBJUGgzMGF2WER5UEwzcjVPMnNtNTJ2NUx1QldoV05U?=
 =?utf-8?B?cmFjTmwwdDMzbUFVZ0xQNUFYcU5TZ0ZlUzFXZmlOa2Y3RFdSelc1ZXIrRFph?=
 =?utf-8?B?K0t4eVhKTFlmSTFEOVVpOEVzVHFrNW5vN1lrRHBMT2JUTE12Qmo0c2hpRkhl?=
 =?utf-8?B?QWdNVVRYcWN6NDB6YXowTzIvTlRPM1lxMXJYaXJCalRGYzlxa2ViSDJXYS9x?=
 =?utf-8?B?NW9TYkRrN1lzaWZlS29vdXA0VzVtQ3lDU3VLdTJOVTVUdlZyWWtCUGVFM1J3?=
 =?utf-8?B?bTNyVG43REE2Ym4zYVZreHR2cG5Za3hUMjJoMFFub29oU1QwL1hMZGtQZ2Ur?=
 =?utf-8?B?R3JDRGhUSFRYZUNWVUtoTWV0Q2V6RnBXSmwxSUliZ0swbEU2MGtCRVFKVmpV?=
 =?utf-8?B?Z3hJYjNjdEtLSUpMcjlCS3pOaEQyOU9DOWxwNmpzbWVzS1dLNHdESzE5YVRQ?=
 =?utf-8?B?enlibXZOM2RtSlUyd3pBVHUrenMwTFhCOThoYldQZUs5Tys1OEUyQ2xBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11195
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3a4187cd-5612-4024-157b-08dc6a924d6d
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkFMeXRyVlNXUGZoV3NML3UwbTR6MUMrdlJlZnFydUtUMHJxdW52RVBFYmR1?=
 =?utf-8?B?YTVLWjN1SXhlWVBRTmlaYnVvZHpmWUd6RDhtYjBiRlJDN0FibXlsd2xjZ3lX?=
 =?utf-8?B?eHQxNlp6SnUra3c4TnUrMDVBenNHL21vbFh3VVBzQXJhZFV2eXI4RkVwVElE?=
 =?utf-8?B?QnVwM0UvNzhIbDdxNmZTWWt6d1Jyd2RzajlIeEFqQVdwSUJKN0FhS0VOcmRB?=
 =?utf-8?B?NE1OSllZWW0ySWw1cjNMelA5OGtSV2F0RmkvdW9uL010aCtuK1FRMWVaQzBm?=
 =?utf-8?B?MTg2aWYramtEZG4yclI3aDQzYUFWRjZ4KzZyZHorYUVMbE5McGt6NU05ZTVp?=
 =?utf-8?B?Tm5LNnhHWUwzYUVBaXh1UFBuNEU4YkdObkJzRzZ1YjF3TVlYSVhac25WSUdx?=
 =?utf-8?B?dUVVaGdDeHh0MlZSNFZLempENWFBRGpVUDFNcythQit1dGl5YVZ3RzNOeElT?=
 =?utf-8?B?V1orNzBRNU9YWjBIMjRRK2pLczZHa0E1QmNVVVA4K2xERm44TEQyMTBtTjhz?=
 =?utf-8?B?NkNHTVRuS3JKa2psQUNJMXYwTXZFelNpRUFqNWdWQmh2SXFZOHpTMmEwTHhS?=
 =?utf-8?B?NmRmdXVBM29DSmUyOVRrckRraE8zYmU1Ny9ha0dwb0VUc0U4TW9wUVMwZlBt?=
 =?utf-8?B?S1FTaWlRenZhQ0lGOHpBVnk2cGFndHAwTk9ZYlhFUmRReFJ5cG5XZEdmeDYv?=
 =?utf-8?B?aWhiTkRUVjhneG45KzJUcUxGb0RIa1pjeEQ0NGxySFVXYk96Y0FvYnk0MkhM?=
 =?utf-8?B?SlJhK3lTWW01enN4cENkNUM4cDZwK1R5djZpY0tFTTV4VE4veXV1dXl4cEtD?=
 =?utf-8?B?bFNEVis4bFZsb2ltVUs3aDZ1eDlqZUpyQUVjS3Vkcmk1MUc1cDlUZEpVSlZW?=
 =?utf-8?B?UDBxcGp5N1Y5VEcxK1NuRXBBcUdOdi96UnNOUEpVcmljTXVNcW9obTh6TWVR?=
 =?utf-8?B?TU0waXZWVlRVcEl3ZDIveGNvZGtkNUN6eHEzWlg3SHNnOWVVWllBNFFHSU14?=
 =?utf-8?B?L0ZVcXVDelkvZWxYYVArUWNQN0tkWDQ3MGthVHRERTBQL3RtZmZaWnhENWJT?=
 =?utf-8?B?TFl0QitzNW1pR1JWZDdYcHJIc052cDlOWm9zRVlxREZpSnRaVDJMVU9aRTBV?=
 =?utf-8?B?K2hKUmdpdCtjTk5NZC95dklleHYva0ZHQ2VGL3VzTnhjUzdMNGFFRmUvWDlD?=
 =?utf-8?B?ekxYeEd4ZWRFbkVrY1l4L0UvenZObVFybzFwcnphcTFvVC9nemxwUFpoTEdi?=
 =?utf-8?B?RWxYdWJmTHRWUFllZkQ4dEZnV2FVRHp2WDFLbENHRyt2U2NzdUsrQVd0RURZ?=
 =?utf-8?B?ZE1qVTh2bjlYeXozaG9rVWxxdWI1N054UTRRZVpiM0VEZWlZeEUzcUgySEsz?=
 =?utf-8?B?RWE5bmo5MkJXQTAvazBUQURMREZYMW4yMVNHMjdlU0Q5d1RHOHFzaHpBbEJM?=
 =?utf-8?B?cVZ6K3o2ZWRLSTV5d0JYMENpb3ZTZnltdmxsNnQ0UUtxWHd6YWVneUlqUWZy?=
 =?utf-8?B?NTlhcmVmNlZyaDNtTHU1Z3RHTmY1UGZqeUhNbFdpbkI4dUluL1FNZm9XWVYy?=
 =?utf-8?B?cUxLNVJtcFhOdnYyalNMYjRBMS92dVNtTXZobTZzM0JUSTNmcXhXd3RQVzRK?=
 =?utf-8?B?TUpKLzR2N3B0ZnBvaFVjbVBJL0xIUjBSakZNSVEra0pzV1dnUXNDREdpRlkw?=
 =?utf-8?B?aXZhN3QvNzdMa1FUMU1HRWVMRzJKT1Y0RzYzK3dCNzNObEsrektEbXpZZlB5?=
 =?utf-8?B?aU11ZmhrMXV3b0JlWGUrbHFVWERNemhmSnk4azJXNnBlQ3R4N2pYNzF4MXlF?=
 =?utf-8?B?NkJXRmhOaGpqUG9sWFdlaUdDNkRSQXNxZkZ5YVNqK0ZLV1d2UzF4QndVLzl6?=
 =?utf-8?Q?h1TjKHRg3qbJm?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 10:26:27.6182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f5ba1b-bb34-4cc3-a11d-08dc6a92535d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6084

On 4/29/24 15:33, Luis Machado wrote:
> Hi Peter,
> 
> On 4/26/24 10:32, Peter Zijlstra wrote:
>> On Thu, Apr 25, 2024 at 01:49:49PM +0200, Peter Zijlstra wrote:
>>> On Thu, Apr 25, 2024 at 12:42:20PM +0200, Peter Zijlstra wrote:
>>>
>>>>> I wonder if the delayed dequeue logic is having an unwanted effect on the calculation of
>>>>> utilization/load of the runqueue and, as a consequence, we're scheduling things to run on
>>>>> higher OPP's in the big cores, leading to poor decisions for energy efficiency.
>>>>
>>>> Notably util_est_update() gets delayed. Given we don't actually do an
>>>> enqueue when a delayed task gets woken, it didn't seem to make sense to
>>>> update that sooner.
>>>
>>> The PELT runnable values will be inflated because of delayed dequeue.
>>> cpu_util() uses those in the @boost case, and as such this can indeed
>>> affect things.
>>>
>>> This can also slightly affect the cgroup case, but since the delay goes
>>> away as contention goes away, and the cgroup case must already assume
>>> worst case overlap, this seems limited.
>>>
>>> /me goes ponder things moar.
>>
>> First order approximation of a fix would be something like the totally
>> untested below I suppose...
> 
> I gave this a try on the Pixel 6, and I noticed some improvement (see below), but not
> enough to bring it back to the original levels.
> 
> (1) m6.6-stock - Basic EEVDF with wakeup preemption fix (baseline)
> (2) m6.6-eevdf-complete: m6.6-stock plus this series.
> (3) m6.6-eevdf-complete-no-delay-dequeue: (2) + NO_DELAY_DEQUEUE
> (4) m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero: (2) + NO_DELAY_DEQUEUE + NO_DELAY_ZERO
> (5) m6.6-eevdf-complete-no-delay-zero: (2) + NO_DELAY_ZERO
> (6) m6.6-eevdf-complete-pelt-fix: (2) + the proposed load_avg update patch.
> 
> I included (3), (4) and (5) to exercise the impact of disabling the individual
> scheduler features.
> 
> 
> Energy use.
> 
> +------------+------------------------------------------------------+-----------+
> |  cluster   |                         tag                          | perc_diff |
> +------------+------------------------------------------------------+-----------+
> |    CPU     |                   m6.6-stock                         |   0.0%    |
> |  CPU-Big   |                   m6.6-stock                         |   0.0%    |
> | CPU-Little |                   m6.6-stock                         |   0.0%    |
> |  CPU-Mid   |                   m6.6-stock                         |   0.0%    |
> |    GPU     |                   m6.6-stock                         |   0.0%    |
> |   Total    |                   m6.6-stock                         |   0.0%    |
> |    CPU     |                m6.6-eevdf-complete                   |  114.51%  |
> |  CPU-Big   |                m6.6-eevdf-complete                   |  90.75%   |
> | CPU-Little |                m6.6-eevdf-complete                   |  98.74%   |
> |  CPU-Mid   |                m6.6-eevdf-complete                   |  213.9%   |
> |    GPU     |                m6.6-eevdf-complete                   |  -7.04%   |
> |   Total    |                m6.6-eevdf-complete                   |  100.92%  |
> |    CPU     |        m6.6-eevdf-complete-no-delay-dequeue          |  117.77%  |
> |  CPU-Big   |        m6.6-eevdf-complete-no-delay-dequeue          |  113.79%  |
> | CPU-Little |        m6.6-eevdf-complete-no-delay-dequeue          |  97.47%   |
> |  CPU-Mid   |        m6.6-eevdf-complete-no-delay-dequeue          |  189.0%   |
> |    GPU     |        m6.6-eevdf-complete-no-delay-dequeue          |  -6.74%   |
> |   Total    |        m6.6-eevdf-complete-no-delay-dequeue          |  103.84%  |
> |    CPU     | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  120.45%  |
> |  CPU-Big   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  113.65%  |
> | CPU-Little | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  99.04%   |
> |  CPU-Mid   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  201.14%  |
> |    GPU     | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  -5.37%   |
> |   Total    | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  106.38%  |
> |    CPU     |         m6.6-eevdf-complete-no-delay-zero            |  119.05%  |
> |  CPU-Big   |         m6.6-eevdf-complete-no-delay-zero            |  107.55%  |
> | CPU-Little |         m6.6-eevdf-complete-no-delay-zero            |  98.66%   |
> |  CPU-Mid   |         m6.6-eevdf-complete-no-delay-zero            |  206.58%  |
> |    GPU     |         m6.6-eevdf-complete-no-delay-zero            |  -5.25%   |
> |   Total    |         m6.6-eevdf-complete-no-delay-zero            |  105.14%  |
> |    CPU     |            m6.6-eevdf-complete-pelt-fix              |  105.56%  |
> |  CPU-Big   |            m6.6-eevdf-complete-pelt-fix              |  100.45%  |
> | CPU-Little |            m6.6-eevdf-complete-pelt-fix              |   94.4%   |
> |  CPU-Mid   |            m6.6-eevdf-complete-pelt-fix              |  150.94%  |
> |    GPU     |            m6.6-eevdf-complete-pelt-fix              |  -3.96%   |
> |   Total    |            m6.6-eevdf-complete-pelt-fix              |  93.31%   |
> +------------+------------------------------------------------------+-----------+
> 
> Utilization and load levels.
> 
> +---------+------------------------------------------------------+----------+-----------+
> | cluster |                         tag                          | variable | perc_diff |
> +---------+------------------------------------------------------+----------+-----------+
> | little  |                   m6.6-stock                         |   load   |   0.0%    |
> | little  |                   m6.6-stock                         |   util   |   0.0%    |
> | little  |                m6.6-eevdf-complete                   |   load   |  29.56%   |
> | little  |                m6.6-eevdf-complete                   |   util   |   55.4%   |
> | little  |        m6.6-eevdf-complete-no-delay-dequeue          |   load   |  42.89%   |
> | little  |        m6.6-eevdf-complete-no-delay-dequeue          |   util   |  69.47%   |
> | little  | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   load   |  51.05%   |
> | little  | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   util   |  76.55%   |
> | little  |         m6.6-eevdf-complete-no-delay-zero            |   load   |  34.51%   |
> | little  |         m6.6-eevdf-complete-no-delay-zero            |   util   |  72.53%   |
> | little  |            m6.6-eevdf-complete-pelt-fix              |   load   |  29.96%   |
> | little  |            m6.6-eevdf-complete-pelt-fix              |   util   |  59.82%   |
> |   mid   |                   m6.6-stock                         |   load   |   0.0%    |
> |   mid   |                   m6.6-stock                         |   util   |   0.0%    |
> |   mid   |                m6.6-eevdf-complete                   |   load   |  29.37%   |
> |   mid   |                m6.6-eevdf-complete                   |   util   |  75.22%   |
> |   mid   |        m6.6-eevdf-complete-no-delay-dequeue          |   load   |   36.4%   |
> |   mid   |        m6.6-eevdf-complete-no-delay-dequeue          |   util   |  80.28%   |
> |   mid   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   load   |  30.35%   |
> |   mid   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   util   |   90.2%   |
> |   mid   |         m6.6-eevdf-complete-no-delay-zero            |   load   |  37.83%   |
> |   mid   |         m6.6-eevdf-complete-no-delay-zero            |   util   |  93.79%   |
> |   mid   |            m6.6-eevdf-complete-pelt-fix              |   load   |  33.57%   |
> |   mid   |            m6.6-eevdf-complete-pelt-fix              |   util   |  67.83%   |
> |   big   |                   m6.6-stock                         |   load   |   0.0%    |
> |   big   |                   m6.6-stock                         |   util   |   0.0%    |
> |   big   |                m6.6-eevdf-complete                   |   load   |  97.39%   |
> |   big   |                m6.6-eevdf-complete                   |   util   |  12.63%   |
> |   big   |        m6.6-eevdf-complete-no-delay-dequeue          |   load   |  139.69%  |
> |   big   |        m6.6-eevdf-complete-no-delay-dequeue          |   util   |  22.58%   |
> |   big   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   load   |  125.36%  |
> |   big   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   util   |  23.15%   |
> |   big   |         m6.6-eevdf-complete-no-delay-zero            |   load   |  128.56%  |
> |   big   |         m6.6-eevdf-complete-no-delay-zero            |   util   |  25.03%   |
> |   big   |            m6.6-eevdf-complete-pelt-fix              |   load   |  130.73%  |
> |   big   |            m6.6-eevdf-complete-pelt-fix              |   util   |  17.52%   |
> +---------+------------------------------------------------------+----------+-----------+

Going through the code, my understanding is that the util_est functions seem to be getting
called correctly, and in the right order. That is, we first util_est_enqueue, then util_est_dequeue
and finally util_est_update. So the stats *should* be correct.

On dequeuing (dequeue_task_fair), we immediately call util_est_dequeue, even for the case of
a DEQUEUE_DELAYED task, since we're no longer going to run the dequeue_delayed task for now, even
though it is still in the rq.

We delay the util_est_update of dequeue_delayed tasks until a later time in dequeue_entities.

Eventually the dequeue_delayed task will have its lag zeroed when it becomes eligible again,
(requeue_delayed_entity) while still being in the rq. It will then get dequeued/enqueued (requeued),
and marked as a non-dequeue-delayed task.

Next time we attempt to enqueue such a task (enqueue_task_fair), it will skip the ENQUEUE_DELAYED
block and call util_est_enqueue.

Still, something seems to be signalling that util/load is high, and causing migration to the big cores.

Maybe we're not decaying the util/load properly at some point, and inflated numbers start to happen.

I'll continue investigating.

