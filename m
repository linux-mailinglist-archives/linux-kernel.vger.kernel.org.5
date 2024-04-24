Return-Path: <linux-kernel+bounces-157174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B928C8B0DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5631C23C9A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F59915F30E;
	Wed, 24 Apr 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gTJssype";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gTJssype"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1515EFCF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.64
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971773; cv=fail; b=B7oiD4qqLw2G6zzZKTrzlWANTmDQalc+skomXqnvHSzFLaBAlnT1w0KAQuD+b0cN1NNClk2crqEjrA95LdhJhzVdLvMreZRxL2g6OqVwjIvvZIFq7IdOUAQ8xrR99bttuGsZxudnPEJHnGxzGXBSWqcljaN9LgwhRJeA/ch8byc=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971773; c=relaxed/simple;
	bh=DdlukEQKMJfIiImmp0fBgOfg7o7wQqyQ9on8h5EoBNc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UzPg6qWnTI8EzSATl9GcPkFwSUjhpoyAqZANXJAqiBu4yD6LPuCtRRMiH7vMLVMWd2GFLAE00LOIjVGfpr5vT1jGInI1HNRDIq08U81SRQ2U3ItzP2hg6mv+tWhb1bXZwp7ieq72LS7ojnJMIRnjuWsW/hDIlYhz2p5r902WoTk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gTJssype; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gTJssype; arc=fail smtp.client-ip=40.107.105.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=iyuUgcRGvoa99edB93YWux9OoZDgKS/PEPJNWd6iNPyE3O3e6/yd1xjV5jFbU2Dd0nOuMWW+CkFSKU9rQL1qB+EvQRpTdQJDPkdzBys06Mg8Ul6jQrwujw1OOgrhnNangs4JzmMbpU2I+R6f0ivy2eH1yRUCdcc0AqdDVy+xW0vqpYIG/qZwh730hbyGhzwck7ZkkqVS+sSSJwW8nmrn5rUSGtHoMf5UIZlN2Ca/8owk3oUQVwW9S71KVePNh7QhCgdkuUWIEiQf6yOG5MvC4gDwXov9l0geFYXXkZF8n8GcFlFccG1M6UrC05gzgGYRbjFZAvrwHatxNTs+FNciYw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6lloV+q+mk5VF+9z5r1tPM+yd3bBr36SjeN7GlCisk=;
 b=jjLgushpI75bbuYQBNDtcipjw/xI1FMyXZs7NOK0/f3JZBzim5dRxg3DNpG2aWOS5PNq6+Wc8ErSM+mUcKUGD1ifnHQ7Bfxt88LhK4s93hZOzX7dBrRYhBrsLbFBeFYhu6+/hl6pS5AwgRz0jRuxVwCr5FgZUlPV5gsqiFCvFC/cT4a99Q44LBSZyUxtXvvOudJJyilTn24x3DbgzoK8/Bgl9EC8WxA1J6FBuzLBjYBoIN/NkiCnaOjNK9TWOj5kGwdN00qaZ+G1JYf1jUnl0mPUvmtgDbfBRcdEi/S4JefuLmtTN7SIOus1bmJoeyGzi5/X4JUADjFFjDCQUc/v/Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6lloV+q+mk5VF+9z5r1tPM+yd3bBr36SjeN7GlCisk=;
 b=gTJssype0CDH9QZaNP2ISHDGCbjRx9xVfjJY+AXvoaOpSAv4Ahe7bSch/0Lc9/qT9S916zFt4p8pdb1ylthOZcLkeSWe6aZnMfiPUOc8i1WPVmiOblhzF+9buyqBeOI7P2Qb9wwtiMKjl4vrd88ml2Yek1oF4r5qlM6hyyQTgv0=
Received: from DB7PR05CA0010.eurprd05.prod.outlook.com (2603:10a6:10:36::23)
 by AS2PR08MB9149.eurprd08.prod.outlook.com (2603:10a6:20b:57b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 15:16:06 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::3c) by DB7PR05CA0010.outlook.office365.com
 (2603:10a6:10:36::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7519.19
 via Frontend Transport; Wed, 24 Apr 2024 15:16:04 +0000
Received: ("Tessian outbound af213ececc3d:v315"); Wed, 24 Apr 2024 15:16:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b7773b1543ad9280
X-CR-MTA-TID: 64aa7808
Received: from 457da6610e1d.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id FDB5D29B-4007-4EB8-AC2F-5F31AAB4ADCE.1;
	Wed, 24 Apr 2024 15:15:52 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 457da6610e1d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 24 Apr 2024 15:15:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5+G+X8sbFrtOYkL9cTsbhiYopoJ82FsJRtd60ahzolNxL5rvUMasAHTicqrfHvpQq9GXt+AASbe17JIQHLoeA8gaqWtnPV6N1T/Gctfx3Elu0FK1lNfw2lJ4S+hwj9Fi5wTf2S+Vo4hfPHS3Ziuh2dAsyARsv8kQzQjEpQyTLzePuNC+3kCrR0QzyZIf/EhD0nSiPK8iM3lAnze5t/xK6vM/PgVmqRj0ARsLtGNgiWRA1vm3oGgZZ+50uTIrnZJr/RiT8ppTJqLkTP3u6zBaKGafh0f4NFSroLK6OXkdpgdqEqD8Hg+gGpuzUE7h+Z/m0QCgAB1mxo/ot2zaqjpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6lloV+q+mk5VF+9z5r1tPM+yd3bBr36SjeN7GlCisk=;
 b=Cp3dc+MrRjtkkLMNHQncE2Duvk9PY3deCzdtJkmaCL1ybJvBSLBy6IhkA75qFDf8hZN8i+aFE9/ijNv6YnvJpd7O9PhQSAyMrCTOXlantAG5B8NiSjYMtlMXJp9vOuTDiGO4ng3AM1Ja41r93RULxhZrSTzBurKqalf90qzC4d9c+LaliXNZqvWML6zeVvz7m2d31fpcaRUWUk//y+YK0vB6YSW/AKo6x3/aJchEWibEnJM1zUUaJwQpxqGoUXFhk86ilM9Qdrf3KSKIKJP+giyySuh60Borj54AjOybHA+Ora01kaCvhuDeE5cfju+fGV20Y8NJqjMqOM5SxXYvZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6lloV+q+mk5VF+9z5r1tPM+yd3bBr36SjeN7GlCisk=;
 b=gTJssype0CDH9QZaNP2ISHDGCbjRx9xVfjJY+AXvoaOpSAv4Ahe7bSch/0Lc9/qT9S916zFt4p8pdb1ylthOZcLkeSWe6aZnMfiPUOc8i1WPVmiOblhzF+9buyqBeOI7P2Qb9wwtiMKjl4vrd88ml2Yek1oF4r5qlM6hyyQTgv0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by AM0PR08MB5409.eurprd08.prod.outlook.com (2603:10a6:208:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:15:49 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 15:15:46 +0000
Message-ID: <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
Date: Wed, 24 Apr 2024 16:15:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
From: Luis Machado <luis.machado@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com, tglx@linutronix.de,
 efault@gmx.de, nd <nd@arm.com>, John Stultz <jstultz@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
Content-Language: en-US
In-Reply-To: <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0034.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::22)
 To VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|AM0PR08MB5409:EE_|DB5PEPF00014B9C:EE_|AS2PR08MB9149:EE_
X-MS-Office365-Filtering-Correlation-Id: b51c264f-a694-49d7-8ed5-08dc647175b7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?S1p2ekd0NVhqd283US9yamFjaEFPN0hGOVJSVlJ2V0E4VnhkclJmaGFIb3lq?=
 =?utf-8?B?Ri9INWc1bUNHYlp4ZFdPcmZDT3ovMkZOaVpiTkV4cE9pTkl1ckhya0g2VEt5?=
 =?utf-8?B?RlN0WTRjUC9YRGpxMFVaRHZodkdkZkJZbzE4ZE9nKzl2YnZUTTZLRC9hdWti?=
 =?utf-8?B?L2thTnZhcE5KM0NxVzN5V0xRZm5TOXhrRWJaQ1B2aHk4VTlTWjI5YVZUUFJG?=
 =?utf-8?B?RFNSR2RHekxtd1kvY0hPeS9tZFVmbkRtSWF5cWRPVFlia3pmVjU0MnlwM1M1?=
 =?utf-8?B?SVBEdFlZSDN0YUVuc0hPTllpaVU4TjdYa2l1TVR6OE9lLzNmMjBKNXJqV3Jw?=
 =?utf-8?B?TlJjZDZDOUM4QmxFZkhjRm9Pd2k1MVRTMy9kaFdhdi8zclZxZFBZeUlJMVRV?=
 =?utf-8?B?bG9MdFFvT2FjVkRGUVN1OTk4ZTEwN0FQMXlHR2ExeFlzMWgyQzJ3cVZHRitp?=
 =?utf-8?B?ZVNPWHV2S3JtL09IWk9sR01FKy9idUtDTVE0Q1MvQTNoem96Zlladmc2SGkv?=
 =?utf-8?B?cDJIMjFYeWM2WTVpZ0FMUGI3NFpyektVbVBtMUJPd3JvU21tSGw3SlFERm1v?=
 =?utf-8?B?SHY0aTh5VWZxWHJLdFNTU0hzVHdpejFXc0FYdTgzamdGRWtqdnBnemdqSlNI?=
 =?utf-8?B?SDJUSDVZZ2JtL2VRZzJ0dWEyZ2JhQWJwZUNEbDNEQnFMRkRmK1hlZHp6bGU0?=
 =?utf-8?B?UDFHQW16WWVHdjNMWGVpaXIyQTZMVFFuT1ZycTBJUXhGWVFjYnBWTkU5dVo2?=
 =?utf-8?B?K0RyZHFndGVuU01PalBzbHFianNDR3RGOC9NTmZrak1ZcDhLZ1FkQWw5anZy?=
 =?utf-8?B?N2VLS2poMWplWWRaS2drczVxYXFYaC9WTUNhQ2kzbUg0dzI4MlZ0TW5lUnQ0?=
 =?utf-8?B?Zk9GejhzU1JXV3drMzJUeWZZSXI5WGdaUTcxTlNNUEh3anRMZXBianVycitj?=
 =?utf-8?B?WndpQjU2TnVEQ1hTYnpRbUNMOFdhMG1TRkFGMHBBTytKNDNTT2FVd2NQRCtI?=
 =?utf-8?B?cnFNQmRnejIreUxZdmppVHZodk9Va2lXTVkrc0lvNmUwWVhhMUh2cWlHLytE?=
 =?utf-8?B?WWhRbC9lb1NuVnlyM2EyaXd2aFpLdmw4QktJN3BtWnBYYnZMTnVVMlhxOThz?=
 =?utf-8?B?MmVFUS9yVXRaNDN0RVR0ZUJqOEF4WElLR0Z2WFBMemtLcksvV2RkcGVSVUhO?=
 =?utf-8?B?WUdDc3pWdFN4M2tuMXFjd2xWMEo2TlA5S09wTHdvWFo0RVRXdWdiSGtPcU5C?=
 =?utf-8?B?a1oyRDB1TjlaSGNuNE8rRGI2bjBqdnBTaHQ1cDNhQ1FEWnB6WFdwNzRlb1pD?=
 =?utf-8?B?ZVVUSlZYaEg0VTVmb1A0N3RhblhmdmFtakhtdnlZUC9jdW5VbVMxMy9xNWZI?=
 =?utf-8?B?SW9QK1dESUd6NWczSmNwU1hhdEFTRCtqK0ZQV2lnVUFIaTF6Ulg3RFJhL0pF?=
 =?utf-8?B?QWt4QlBTaC91QzRjb2xTRkR4eGZlS1U3bDBtaitVS01JVUtMYmU1VjBVOXN2?=
 =?utf-8?B?ODlCWUFmaE5JN3dBZkFPMzZ0RUx6QzE1SGx2UUNtN3JpRWVNdTBRMG9zdzd6?=
 =?utf-8?B?dktsNUE4V3NyVnIwYm9HSVNYN1VNMEk4NUpQOVB0RGppSFJkT2lJaWV0S3F3?=
 =?utf-8?B?cWw3QXRVdklqMGNUNUExOHcrMm9EaFBTT2pZdGx0ZDlnUXpxSEZvNGEvUUYv?=
 =?utf-8?B?MUZ6NFIyRjVHYk5jbzY1K29RR2dnblA3UVVDWXdsWENIUiswYmp6SDZFUnlR?=
 =?utf-8?Q?MG0KKFN7+ofFNNSIS2ooSNlE+OUAO2Ugv5Yq7jU?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5409
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	699ff5c9-bbce-4ec2-c7d5-08dc64716a31
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|36860700004|376005|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkdRMVF1N1ZEZVExbjlBc1B0VHEvand0NHVxY2pvb0xZU1JUeUlVTG4velEy?=
 =?utf-8?B?RDZzMFZOVytwZ3BQeVZYZ0NJSG5nTzFOTmV5N2YrajB6bHBoS0V6V1Ura0R5?=
 =?utf-8?B?UUhtU1VIY3ZkcWNIaVJ4RzMrMUFPWVdhZ2xYYnh6cmRlQ29xczlNclJmWS9J?=
 =?utf-8?B?aEV1RlprcmJST2kwVi9jUkt1Ri8yUHFyNXNoVEdnSlBkSStpK3dXREorTjZk?=
 =?utf-8?B?eUIycVp1eG1wZ1BEdzE5cXFkbTlEMzd1dDVWQjhaRTZ5SjdVd1Y2VGMwTWZs?=
 =?utf-8?B?NklwMGFDQ3hzeU9DVVRVNUxJbndldnhtN3FhRGRPd2orTTVLemNUNk9VZVBY?=
 =?utf-8?B?TEtiZ2RkRzhhTmIyclZKeVZLazRmTVNIMFFJaGE1UjFGdE9TY2lzcGM4SjY0?=
 =?utf-8?B?bGJSdVFjZXpHMzhZeVBqV0x6MWQ0WkNHbnBDUlU3OFMrZ3hEVm5vaXhpK1hH?=
 =?utf-8?B?T0orbXljWTJJZ2JqSUNQZnArcGJtR3ZlMHAwWUNyQ1VJb1gxLzZnQURPOXhp?=
 =?utf-8?B?aFNIMlRVMngvTVN0ZVNBVWlBUUdDVTB2Yk9sM2F1N3hiVkhlOStJZXJGNGRi?=
 =?utf-8?B?V0VxcVM5TjVLY2lPQk5vVFd5UWFWY0RZRUxJSGZSeUdDTDY1dCtwN2s2eTky?=
 =?utf-8?B?dk5LMGc5Y3IwRlJlR0lxQkhIVGRiSVdEVmliNGNEbGdUbm5TeS82Sm9ENVdI?=
 =?utf-8?B?eGJEV1BBbkFmVG51QTRqNlYxa3ZDWFBJSVNsYTNRZWRXcGhxdGdkNnNIWWZZ?=
 =?utf-8?B?ZkM2c1RIa25WWCtSeXRERlNCQlR5MkdFWk9KUllwRXF2RzNOUFpFNkhVMGRr?=
 =?utf-8?B?enpxaWU0bUIvTDNNMUk4cktwVGV0NnZkdlBOVVlvcGpBS3oyeVFacmFKN2FL?=
 =?utf-8?B?d0JSc09PcXh3TUZpRUFUUzNRd0JjaVJXVlNJTlhQRmJRQUlmUmFHdVErZXhI?=
 =?utf-8?B?cnU1OUNLNGtqRmg2OExSV2Vvd3luUXdQam5kZVM0UW1qaG90NzdzNi9pUHJk?=
 =?utf-8?B?eEpFQ3FuOW1yNEh6V0daZVJucXJLZ3BIYlNiYUJJckJ0LzVDVmNhbnNtcnJH?=
 =?utf-8?B?Zk5kZ0ozdWptaEpuUWh1aUw5RDJaenJNemlDTVlwNWRROUlhempqTW92MXNI?=
 =?utf-8?B?d3VwREFiZnd2LzJkWmtyZ3dCZElZeC9tbnE1YmNRYkl4RWtEbnJkQkc0L0pw?=
 =?utf-8?B?MzlUTU9ReXAySFJpekNkWjdPZFJGRFowYVdITmJLdmpGY2drdFJhNVk1d0w5?=
 =?utf-8?B?NEpIN1lMbE9FU3RsSC9NdXJUM21FcHYvT3g4dkFyeVNSUlRRQlBhejNoaW9Z?=
 =?utf-8?B?VlFyUnhxWWx6NE9ZaEV1TG15TlZtZlRIN0VRNURQMCthRGFtQ25nRW9pSFQ5?=
 =?utf-8?B?WUJYd2lOUlpYTGhVWGNPNFhLN3NVME8zR0tpcUN5WkR4WmZWc0dnVDlpWVJD?=
 =?utf-8?B?ZHYyc1dRNzZWMHNuZWEwY3ZvdDJtMGpHVFd3cFhMT2tmbjlpK2tIT3VtMEFY?=
 =?utf-8?B?WjB5dy9xYngvOVBZbGgwajBzVWs5RDMvaStFdnRtam54cUQxN3FZSlhFa2NT?=
 =?utf-8?B?ektSNy85aVpmS2dmMUF4TzVCcWQweUZXRHEvbm9Tbzk1aUJ1UjFDVVcvRWlM?=
 =?utf-8?B?aVdHd0ROVng5R2RMUllJUW5LbXF4V2tHQ283SWxMYk1XcEhNdm5veGNUNG9t?=
 =?utf-8?B?WEVaV0JzOVZ0UWpwNmN1byt2Z0VjRmJDTHVNWkt4aHIwVi9YT0J2NStHZWdD?=
 =?utf-8?B?NVZUT2diak90S0d1aVY2WHc4a2VLZ2xyT3U5WG03RWZlbW1TWEZTaEJ5eGpD?=
 =?utf-8?B?WUlXbzJMQVJUMGo0T3U5R2tWNnRjL0s4SUQzbkV6U3NhZWlTSXh4L2F6anJI?=
 =?utf-8?Q?ssG4piVnWV+vz?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:16:04.8657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51c264f-a694-49d7-8ed5-08dc647175b7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9149

Hi,

On 4/15/24 18:07, Luis Machado wrote:
> Hi Peter,
> 
> On 4/5/24 11:28, Peter Zijlstra wrote:
>> Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
>> noting that lag is fundamentally a temporal measure. It should not be
>> carried around indefinitely.
>>
>> OTOH it should also not be instantly discarded, doing so will allow a
>> task to game the system by purposefully (micro) sleeping at the end of
>> its time quantum.
>>
>> Since lag is intimately tied to the virtual time base, a wall-time
>> based decay is also insufficient, notably competition is required for
>> any of this to make sense.
>>
>> Instead, delay the dequeue and keep the 'tasks' on the runqueue,
>> competing until they are eligible.
>>
>> Strictly speaking, we only care about keeping them until the 0-lag
>> point, but that is a difficult proposition, instead carry them around
>> until they get picked again, and dequeue them at that point.
>>
>> Since we should have dequeued them at the 0-lag point, truncate lag
>> (eg. don't let them earn positive lag).
>>
>> XXX test the cfs-throttle stuff
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Playing around with a Pixel 6 running a 6.6-based kernel with this
> series backported on top, I spotted a noticeable performance improvement
> on the speedometer benchmark:
> 
> - m6.6-stock-* is the 6.6 mainline Android kernel unmodified.
> 
> - m6.6-eevdf-complete-* is the 6.6 mainline Android kernel with
> this series applied on top (along with a few required backported
> patches).
> 
> +-------------------+-----------------------+-----------+
> |      metric       |          tag          | perc_diff |
> +-------------------+-----------------------+-----------+
> | Speedometer Score |     m6.6-stock-1      |   0.0%    |
> | Speedometer Score |     m6.6-stock-2      |   1.23%   |
> | Speedometer Score |     m6.6-stock-3      |  -0.22%   |
> | Speedometer Score | m6.6-eevdf-complete-1 |   4.54%   |
> | Speedometer Score | m6.6-eevdf-complete-2 |   4.95%   |
> | Speedometer Score | m6.6-eevdf-complete-3 |   6.07%   |
> +-------------------+-----------------------+-----------+
> 
> Also some interesting improvements in terms of frame timing for the
> uibenchjanktests benchmark. In particular the metrics of missed
> deadlines and jank (late) frames, which seems to indicate better
> latencies.
> 
> +-----------------------+-----------------------+-----------+
> |        metric         |          tag          | perc_diff |
> +-----------------------+-----------------------+-----------+
> | gfx-avg-frame-time-50 |     m6.6-stock-1      |    0.0    |
> | gfx-avg-frame-time-90 |     m6.6-stock-1      |    0.0    |
> | gfx-avg-frame-time-95 |     m6.6-stock-1      |    0.0    |
> | gfx-avg-frame-time-99 |     m6.6-stock-1      |    0.0    |
> | gfx-avg-frame-time-50 |     m6.6-stock-2      |   3.46    |
> | gfx-avg-frame-time-90 |     m6.6-stock-2      |   1.19    |
> | gfx-avg-frame-time-95 |     m6.6-stock-2      |   0.24    |
> | gfx-avg-frame-time-99 |     m6.6-stock-2      |   0.48    |
> | gfx-avg-frame-time-50 | m6.6-eevdf-complete-1 |  -30.45   |
> | gfx-avg-frame-time-90 | m6.6-eevdf-complete-1 |  -48.44   |
> | gfx-avg-frame-time-95 | m6.6-eevdf-complete-1 |  -51.32   |
> | gfx-avg-frame-time-99 | m6.6-eevdf-complete-1 |  -52.48   |
> | gfx-avg-frame-time-50 | m6.6-eevdf-complete-2 |  -30.32   |
> | gfx-avg-frame-time-90 | m6.6-eevdf-complete-2 |  -48.16   |
> | gfx-avg-frame-time-95 | m6.6-eevdf-complete-2 |  -51.08   |
> | gfx-avg-frame-time-99 | m6.6-eevdf-complete-2 |   -51.7   |
> +-----------------------+-----------------------+-----------+
> 
> +-----------------------------------+-----------------------+-----------+
> |              metric               |          tag          | perc_diff |
> +-----------------------------------+-----------------------+-----------+
> | gfx-avg-num-frame-deadline-missed |     m6.6-stock-1      |    0.0    |
> | gfx-max-num-frame-deadline-missed |     m6.6-stock-1      |    0.0    |
> | gfx-avg-num-frame-deadline-missed |     m6.6-stock-2      |   -3.21   |
> | gfx-max-num-frame-deadline-missed |     m6.6-stock-2      |   -3.21   |
> | gfx-avg-num-frame-deadline-missed | m6.6-eevdf-complete-1 |  -85.29   |
> | gfx-max-num-frame-deadline-missed | m6.6-eevdf-complete-1 |  -85.29   |
> | gfx-avg-num-frame-deadline-missed | m6.6-eevdf-complete-2 |   -84.8   |
> | gfx-max-num-frame-deadline-missed | m6.6-eevdf-complete-2 |   -84.8   |
> +-----------------------------------+-----------------------+-----------+
> 
> +----------------------------+-----------------------+-----------+
> |           metric           |          tag          | perc_diff |
> +----------------------------+-----------------------+-----------+
> | gfx-avg-high-input-latency |     m6.6-stock-1      |    0.0    |
> | gfx-max-high-input-latency |     m6.6-stock-1      |    0.0    |
> | gfx-avg-high-input-latency |     m6.6-stock-2      |   0.93    |
> | gfx-max-high-input-latency |     m6.6-stock-2      |   0.93    |
> | gfx-avg-high-input-latency | m6.6-eevdf-complete-1 |  -18.35   |
> | gfx-max-high-input-latency | m6.6-eevdf-complete-1 |  -18.35   |
> | gfx-avg-high-input-latency | m6.6-eevdf-complete-2 |  -18.05   |
> | gfx-max-high-input-latency | m6.6-eevdf-complete-2 |  -18.05   |
> +----------------------------+-----------------------+-----------+
> 
> +--------------+-----------------------+-----------+
> |    metric    |          tag          | perc_diff |
> +--------------+-----------------------+-----------+
> | gfx-avg-jank |     m6.6-stock-1      |    0.0    |
> | gfx-max-jank |     m6.6-stock-1      |    0.0    |
> | gfx-avg-jank |     m6.6-stock-2      |   1.56    |
> | gfx-max-jank |     m6.6-stock-2      |   1.56    |
> | gfx-avg-jank | m6.6-eevdf-complete-1 |  -82.81   |
> | gfx-max-jank | m6.6-eevdf-complete-1 |  -82.81   |
> | gfx-avg-jank | m6.6-eevdf-complete-2 |  -78.12   |
> | gfx-max-jank | m6.6-eevdf-complete-2 |  -78.12   |
> +--------------+-----------------------+-----------+
> 
> Bisecting through the patches in this series, I ended up with patch 08/10
> as the one that improved things overall for these benchmarks.
> 
> I'd like to investigate this further to understand the reason behind some of
> these dramatic improvements.
> 

Investigating these improvements a bit more, I noticed they came with a significantly
higher power usage on the Pixel6 (where EAS is enabled). I bisected it down to the delayed
dequeue patch. Disabling DELAY_DEQUEUE and DELAY_ZERO at runtime doesn't help in bringing
the power usage down.

Though I don't fully understand the reason behind this change in behavior yet, I did spot
the benchmark processes running almost entirely on the big core cluster, with little
to no use of the little core and mid core clusters.

That would explain higher power usage and also the significant jump in performance.

I wonder if the delayed dequeue logic is having an unwanted effect on the calculation of
utilization/load of the runqueue and, as a consequence, we're scheduling things to run on
higher OPP's in the big cores, leading to poor decisions for energy efficiency.



