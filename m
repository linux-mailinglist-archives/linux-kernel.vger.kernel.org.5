Return-Path: <linux-kernel+bounces-162448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC6B8B5B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706201C21680
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8D07CF29;
	Mon, 29 Apr 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ra8cVAYj";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ra8cVAYj"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4BF7C0B0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.46
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401216; cv=fail; b=RsZBRR8ic5kUQ7J4ZeApIjm1AR+CYfjomO2IY3BawoN0iEZH6d0pR7htCrwx46nhhF41LOvwa4wFs3B8/53qv0TsznudKw5n53u9/aq1W5gjE0tDcN0SuXtGvnlD6Qc9vW5kg7uTTPSujWs3cH8iA9X0W1LvTIqNXSaY1o5wWwU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401216; c=relaxed/simple;
	bh=EnqjcT/hwBaIN2PjXaY/V1eLwrnvPo++bsDttyEw1hs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cMtGIbW3Ta8lQf75nM2TRcatVPO3vrM2LwrRH+snrVpbETRY2aWXlVadfq6wbEchrvuHGyZt8hpExgpxWTZrw+eNNiSTRARB+B0Ep6LukntWwcEWwjPaV/AcQ8inndkcsmemH0Sivdk6OyQy2atU2KHTk1kn76Q9bmiAZaMxh4U=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ra8cVAYj; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ra8cVAYj; arc=fail smtp.client-ip=40.107.105.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ZInTvTqReq0PL4knvF4gy794ar3il6dm/fs+uc7iq9YERs0F4tOtGQ6P2TyyP5TKSRFJb5i7ULPcyDU8z8DsfEjP45u8ZJUlbdouWqWiLgu84ZHE/tTy6iP+YX6dZk5+nPayYdCrFn+cgwn9k+/o/b6h6emyQKIuR5A6qAN0bt5wI9yxU36gpTIMgXLY7jG0uLQW4xBXuZ8SdrT6BL5elS+2IjqAQuaOZC5t6AJfNq2su/sjFtvqlw3sznaUnZVy3wPEy7s5mdARTyocKMRN+X2DTEr4ssroNjMzWhvxMC5+3tVFvqquZQvnxpdnXBmqAjzJJdYG7hoeV+tWxsxR3w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHyxs6sDrA0oX+fatcGInY6OAmv+wzh0NgvbQKo88AI=;
 b=Ryf6943IFrxQkszSqOD+Dn7gY5t7FYMz3jNRe8SinSIonXwi7XThfVan1ayyy97NFC/dQcd3OCrYKVAGPd159rG9RGSq4kRIcEPfBofUe1q9Aih3GevFI3Dki1B7Ts8jkH//OKYIgzpid+hZD65FR0+Swa3QAeZpJX7RsKBikx/YxR6eUuklKXAGeifDfaFpysyrwfCR6BgxyfTRQ5FPw57SCN7O2apU70lA7Ad4u807uRwkhAAj8nPlMD5swTwvzq/UJzmCHXPI5p5EyrKR8uJuk7Qa0sTOTGCujueD4RK/83c9rTe/GHe/mgcO9OI5JowboGbiC3k94t8q2e8Rpw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHyxs6sDrA0oX+fatcGInY6OAmv+wzh0NgvbQKo88AI=;
 b=Ra8cVAYjPs44GgNdR98s3cTwY+xUcsYRuE/iSP2oHmjhgdCjUAR1QUNfuGvwwVXxxEF2R1LxA8OphJ9mVhYUURlFFvNyo+lAyknp2X2OZPh+bzaxMKK2ESR6C3wKHr7YhsbB2N3m1DeK9AH4qWDN6kZo3KqvilGGfBccLknHfSE=
Received: from AM0PR05CA0080.eurprd05.prod.outlook.com (2603:10a6:208:136::20)
 by DB9PR08MB8316.eurprd08.prod.outlook.com (2603:10a6:10:3dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:33:22 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:208:136:cafe::4d) by AM0PR05CA0080.outlook.office365.com
 (2603:10a6:208:136::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 14:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7544.18
 via Frontend Transport; Mon, 29 Apr 2024 14:33:22 +0000
Received: ("Tessian outbound 9d9bf1c5d85a:v315"); Mon, 29 Apr 2024 14:33:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 915fb29781bcb95c
X-CR-MTA-TID: 64aa7808
Received: from 2733b371e86f.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C93FCFAB-51BD-4C26-8045-ABBB0B70E7D6.1;
	Mon, 29 Apr 2024 14:33:10 +0000
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 2733b371e86f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 29 Apr 2024 14:33:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLfMNy7d30gKtPz2MdR+Nm6qSYNbx4KoibqH5mwbuqboihZhPzZPYLDRwwxSPvE4dIdusu69mh3B6bMM3OxBfqNvxE2Aw2UZYNMBVLmQI4SsIvaGMb/8EOF16pRdaCEIBMNw3RlZNsg5AlnMloZDK/WwKnvb30Vx8MDFJRxsgDTt9svg86ff/eYQj1Zh0IXpX7qunmrKg5tpDk1zX0qE+n17e3RePFw7bTO596YGcAAA9ED/xg9W128/RYJaO/yINSFgYVCL562tolvCsZPB668PyQWL0HiwKNjxKB8wRXfm+ArVifvKH3IYsWqm0e0rbWZLrJQ0rlLbNwI6tSlagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHyxs6sDrA0oX+fatcGInY6OAmv+wzh0NgvbQKo88AI=;
 b=dSanMTYmVybJoWMP+K0If7ZTLpfoi/FUMGBYbK4x/SEayV/ljMMmEqO25pcDjbKh3jTX7hbtQ0G2LH9JDRL9lNL9pXUspZToB58/FRjsn/f5in3TNYPv2tnwYDmTJG1fDf6J9bbRxWEXQvgYtUBvckKlXRtAtt9FqYCYN6IeE8LmVH7ARfd6FVjsTEnmYV2eTlAZ6Jnxan57EdHC9VzKZt6YHNkIR5d2ZzT5+K0InnKJV9s/OepGIV7sDmvXtaaiFakqVt+h/4WN/QGK5Pb/PMPw5/rS8K2JB+S8b0ecxV6Ntc671pSPogvVqWJulf8goCrj8sXkPrinygE4mzaxyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHyxs6sDrA0oX+fatcGInY6OAmv+wzh0NgvbQKo88AI=;
 b=Ra8cVAYjPs44GgNdR98s3cTwY+xUcsYRuE/iSP2oHmjhgdCjUAR1QUNfuGvwwVXxxEF2R1LxA8OphJ9mVhYUURlFFvNyo+lAyknp2X2OZPh+bzaxMKK2ESR6C3wKHr7YhsbB2N3m1DeK9AH4qWDN6kZo3KqvilGGfBccLknHfSE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by PAVPR08MB9675.eurprd08.prod.outlook.com (2603:10a6:102:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Mon, 29 Apr
 2024 14:33:07 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:33:06 +0000
Message-ID: <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
Date: Mon, 29 Apr 2024 15:33:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
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
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240426093241.GI12673@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::21) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|PAVPR08MB9675:EE_|AM3PEPF00009B9D:EE_|DB9PR08MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: e78d3dc4-5aad-4f79-93d5-08dc6859526b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UmJrZlR3RXJ4ZldIa3R2c094L3g5MWYvUjA1VFZEVmtuT0dvY0FwTUl4REdn?=
 =?utf-8?B?WHNhUSs2amtSNVlWWDV6dTlPZjdUVTA1YmQyY1A4SG5pR1l1N2dmKzlkc3ZG?=
 =?utf-8?B?OG5pQXNEc1o5WTU1Q0lEQ0R0WHZnSFVBbHM0dmdTQ3lKcWFGZXI2OWlCZGRG?=
 =?utf-8?B?RElvdk9xRURDUkxxWVUwdGx6cGRFcFpKZWZNcE1RVEx0QlhlZFJ3SHNjQVRO?=
 =?utf-8?B?eFc3ZUF5dW1XQzhUWmpLdVJsRjZKaUo5QitReUZxQjl2TFg4UFF1WEZxakdJ?=
 =?utf-8?B?d29TRmVhQ0tRVEtSV2xNeUZmNXpDMGFpZmMzMGVYbWx3N3lnemxmZy90VFNP?=
 =?utf-8?B?Q3ZOQUhuRmszWGFId2ZpcUhkN3g4RVBwcVVLcHJ1bVRDbERIUGdHNGU4R0sz?=
 =?utf-8?B?YzArT28rc3hJTGJzVEUyVFgrWDdIVzQ0c2hyL0ZabkV2RzVJZ0NJdS9ZL2tK?=
 =?utf-8?B?djJ4UnMyUkhBVCtUa295YmF3ekdjaGMzV1FTaEpmTFJYT2pOWFpLUmhUcXJv?=
 =?utf-8?B?elByTCtNaDJHUnY0L2JKeGpFYTFxTEUycU9SS3k4MkoyVkw1Yk1QRFVYNkpo?=
 =?utf-8?B?bGtBQ2NoeGM4Ry9TRytGeittNXVJSUFaMXBMekhSamNRMm5CbTRrMHBQcXFQ?=
 =?utf-8?B?MWxFVU9sSm5YczlKcTNhaWtWc1dFcWF3bGZzSC90Z0hwSDB6WEdXQ3NReHlR?=
 =?utf-8?B?NGpkLzhUWDQyS0JUSXQrSG5Lb3Azck0zV2F2Q1VMbDlTNXdGdFpyTThYNm1K?=
 =?utf-8?B?MXZTNFI2TzJOcWxHRDlxbEl0ZC9ZUEVOdk1FdmV1dWU4d1cyMkJBcmZwYmZq?=
 =?utf-8?B?TmVpMG9pQTNHZEcwTm5GY1ptQWN0RmtxRFVSNlZwUDBaODFwWFh6SFkvTkdF?=
 =?utf-8?B?akJoai9rMVpuYzZnd2pEenp4NUJUMnBBU0tqNm4xc2JvUW5VdlFSODM1bXNE?=
 =?utf-8?B?dkVvS2NQNk43Z3VFWXEwY3I4T0NNMDNJS3FLWFlDYXNhamV2dnRBV3JsWEJX?=
 =?utf-8?B?MnphRjcyVS9wYWMwMEtuOFk2SDNpYzJNdWZnNkZWNEI0NnZjdDYxaUdVangy?=
 =?utf-8?B?SkpUdERhTlo0SXAvNFlsWm9vY3laVVFaNmphbkVvYmZ1TEp4V1pZMW5WUTRV?=
 =?utf-8?B?K3dHWEJEcDNXcEQwaldlQy91MUpsRHRRWVdkOHV6TjRVVEhuQjRPUURtQll5?=
 =?utf-8?B?aHhqTlF2MjB0MjgzREt4T0wwQTZ0aG4zUmF3Sy9yb0twSVY2dXpEYUVKcjdh?=
 =?utf-8?B?MzAyK0VLUHg4bDYyWmM4NE5OSS9hR0tsWmQ0MHZaRlcxcWRSd2JzNjFFc2hi?=
 =?utf-8?B?d3duc1lXS1VmL3llMlc4NnFPZHM2L2Q1aDFEdEtmYVNjQ3BZdjFHSENxL1Nz?=
 =?utf-8?B?TmZ6V1JBbWpzMUJ6bmxrQ216S2JzMXgrdDlZcE5VbktlL1ZZZkFhcnNtdEtQ?=
 =?utf-8?B?OEFEQkw4NDlxWnRwZFRQMG9Ed3JQM1NBZTdZY1dVdThaOUF1aHRwb2VlYmlP?=
 =?utf-8?B?WnJDZU0xaStyQnE4NkVIaW5WT1B2dUxVMGduS3IvNW9DUnk5UUtKb1d4N2FW?=
 =?utf-8?B?dGQvYjU1STlVUmNMQ0hydjZoWEwyQUxXdU04TXhkMDRkQmtjUkMxVm1iSlZF?=
 =?utf-8?B?RkMydnpQT3BrODRhQ1o2NzRYdEEweVRkRkR3aVRBY0tGWThiVjRSOENGZ3Zs?=
 =?utf-8?B?djlkL1VsMlJSMTdJVFpGQ1A0UE5mY2ZWSEJ2N3l0bjRsSWpxSUpCV1VBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9675
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bd00aa0a-0acd-4769-942c-08dc685948e8
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400014|1800799015|35042699010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFJvUVRlZHVRUmErdUpVelBraWVTMkJFQzUvSUlFS1p5Wlc0aTFRTHFHSGdj?=
 =?utf-8?B?RnpZbW5JSDRKb2luY21SZFVwUll0UFdFYzF6VkZnMEFsWDRLZTZSSWFSMjFu?=
 =?utf-8?B?UTV6cVVNazExK0tsazJFcmZLa0VURVpCand0QWU5anZ3c2FocGN5am50TnYz?=
 =?utf-8?B?dGwrcGUzRzc1Mm14eUwxdVZvUUdBSWJKTE13Q3ZRQjVjUER0dlM2ejBHbUJ0?=
 =?utf-8?B?S1hoQmdxUUpTR1JyR3l4WmUzZG1ETUcwOEJIOTlsczRyV2hZdGlKQU1hZ1hr?=
 =?utf-8?B?UVlzR2tPbUlzZ3dFdnRkNnFIVHlMa1pzclZLQTVyTlBhaVFEam1FR1N6T2x1?=
 =?utf-8?B?RE1KaWxvOS9ZajVnN0dES0x3SnhjdmdMS3RDSWlySmNPWDNISGY3WnpFcjJE?=
 =?utf-8?B?ZnZhR0tOQXN5S3VBd1l4bDJ0aGhGVG5GSlpLemhnK0NxbnNlMXdlNVV6RUdU?=
 =?utf-8?B?YkwzWVVUQ0h2K1pFSDVrb2RiZGtwSGwrTnZIM05ycVVTMWJSM1JucG5NdGxm?=
 =?utf-8?B?Zzh2RW51clZCYzBmN2U4MFlJWTdsczNoMHBMcFdscFhONzV1TDNiWFN4U25D?=
 =?utf-8?B?dUlNcW82eEVzTWw3NlJZZ2NZMzdEMEpQdzZTSWZzRHAwOTJvUEpMeWFDMEM2?=
 =?utf-8?B?aE0vNTl4WGhWUDhxQkg1YlZGZ0tDdU1xbS9uQytVRGlRQ0QwOXFIWkszVk5t?=
 =?utf-8?B?dnV4UkVkbkR6M2U3MzFLU1hGdGJwVEJJK2hLR0dNRGE0empqWE5tWWU5cHJM?=
 =?utf-8?B?U3U2L2IwYzhaaU4yVzRnS0FCSko5K0d5YW1kYWU0bzhSRzIrLzQzMFpWa0d0?=
 =?utf-8?B?ai9wNE1FVzlNVFU4ZEhFczVTUEhxc252Z1NDZW5Sb0JMekk3bW9saGdjU21S?=
 =?utf-8?B?S2ZiTm15SUxLUW13UG1SQkMxc20yK2srOHZjQ3kxTVE2L0NOditFOG8xOFdB?=
 =?utf-8?B?aGF2UmRNS2VGM3lKS2tnZkxvVHZOaE5pYW12dExWTDVrL2Rub1E1a2FQbGZy?=
 =?utf-8?B?OGdKN3RGVzhyR2dUK1dHZmNWcVVHYUhOcEZqWkgwUGx0YXVRelZHejRIeDBQ?=
 =?utf-8?B?MTBzRk1SMkM1MStlVjZHRVJmNlJ4MHArc0kxWHFmWjBYd1hZSUtTbERicnlq?=
 =?utf-8?B?WXpiTEQ3RVBNNmwzSndLczlsbGdDbG9rcGFUbkorVjg3YVhQL2F3WmtXZ2V2?=
 =?utf-8?B?UWVYM0VOUDVNZ2JHbk5reEZLbmViUzlaNXZZdDhaQXJIdS9hWmxrdktxUzM2?=
 =?utf-8?B?eGVhRjRYYTNYVG92TDhQOVB1Z2I2dTVUQnhaallybWhXWmVtbXBSUU5vZ0ly?=
 =?utf-8?B?VVoxMDNjR1hiOTNoaFM1NllPMkZ4cVpYVEpqeFpWVHNwMVNoWFZKWTJSS3ph?=
 =?utf-8?B?SUFqU0V2S1M5V2NtWG1kWWFtMkZYcHVjL2VtdisvRXBFQlV3RkVNUklZcURy?=
 =?utf-8?B?d3ROR0lOZXo0U2owK0xKRmlvVUd2WC85dE1UK0ZtbDB2VmVnalJZcUNPZjFx?=
 =?utf-8?B?ZUhNS01ZNVVJVkhGcTdMdU1mZFZFMldUejhBMjFSRXpmWXpxWXZyWUxxem1V?=
 =?utf-8?B?elptT2ZjaXo4Y1J1OFlPa1ZibnRYM2tiOUEwQmRvZXoyZ1kreW10MENxZXJV?=
 =?utf-8?B?dFBWYnNUR1lwemhqWTFMUmNpemVnTUpIZVhUTnlxTDBaK2pNbjREYmtPbXMx?=
 =?utf-8?B?MXBNd093bFJhSjkxSGFHOWxuMWpEdzlzbHdiZ2JKdnBVQjFCeCtlanBiM1FH?=
 =?utf-8?B?Z1JkcEpKNTRweGltYi9HZGVFTEczdGJtYTVUcSt0OXhBbVR0N3loZjNya0pV?=
 =?utf-8?B?K3NxUmFwc0JrcDl0UDdIMFl5N0U1ODk2OWR1SjhXQWlxcjlDRUZoRjZzQnFN?=
 =?utf-8?Q?1m8o/ruMtnXDE?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015)(35042699010);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:33:22.3146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e78d3dc4-5aad-4f79-93d5-08dc6859526b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8316

Hi Peter,

On 4/26/24 10:32, Peter Zijlstra wrote:
> On Thu, Apr 25, 2024 at 01:49:49PM +0200, Peter Zijlstra wrote:
>> On Thu, Apr 25, 2024 at 12:42:20PM +0200, Peter Zijlstra wrote:
>>
>>>> I wonder if the delayed dequeue logic is having an unwanted effect on the calculation of
>>>> utilization/load of the runqueue and, as a consequence, we're scheduling things to run on
>>>> higher OPP's in the big cores, leading to poor decisions for energy efficiency.
>>>
>>> Notably util_est_update() gets delayed. Given we don't actually do an
>>> enqueue when a delayed task gets woken, it didn't seem to make sense to
>>> update that sooner.
>>
>> The PELT runnable values will be inflated because of delayed dequeue.
>> cpu_util() uses those in the @boost case, and as such this can indeed
>> affect things.
>>
>> This can also slightly affect the cgroup case, but since the delay goes
>> away as contention goes away, and the cgroup case must already assume
>> worst case overlap, this seems limited.
>>
>> /me goes ponder things moar.
> 
> First order approximation of a fix would be something like the totally
> untested below I suppose...

I gave this a try on the Pixel 6, and I noticed some improvement (see below), but not
enough to bring it back to the original levels.

(1) m6.6-stock - Basic EEVDF with wakeup preemption fix (baseline)
(2) m6.6-eevdf-complete: m6.6-stock plus this series.
(3) m6.6-eevdf-complete-no-delay-dequeue: (2) + NO_DELAY_DEQUEUE
(4) m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero: (2) + NO_DELAY_DEQUEUE + NO_DELAY_ZERO
(5) m6.6-eevdf-complete-no-delay-zero: (2) + NO_DELAY_ZERO
(6) m6.6-eevdf-complete-pelt-fix: (2) + the proposed load_avg update patch.

I included (3), (4) and (5) to exercise the impact of disabling the individual
scheduler features.


Energy use.

+------------+------------------------------------------------------+-----------+
|  cluster   |                         tag                          | perc_diff |
+------------+------------------------------------------------------+-----------+
|    CPU     |                   m6.6-stock                         |   0.0%    |
|  CPU-Big   |                   m6.6-stock                         |   0.0%    |
| CPU-Little |                   m6.6-stock                         |   0.0%    |
|  CPU-Mid   |                   m6.6-stock                         |   0.0%    |
|    GPU     |                   m6.6-stock                         |   0.0%    |
|   Total    |                   m6.6-stock                         |   0.0%    |
|    CPU     |                m6.6-eevdf-complete                   |  114.51%  |
|  CPU-Big   |                m6.6-eevdf-complete                   |  90.75%   |
| CPU-Little |                m6.6-eevdf-complete                   |  98.74%   |
|  CPU-Mid   |                m6.6-eevdf-complete                   |  213.9%   |
|    GPU     |                m6.6-eevdf-complete                   |  -7.04%   |
|   Total    |                m6.6-eevdf-complete                   |  100.92%  |
|    CPU     |        m6.6-eevdf-complete-no-delay-dequeue          |  117.77%  |
|  CPU-Big   |        m6.6-eevdf-complete-no-delay-dequeue          |  113.79%  |
| CPU-Little |        m6.6-eevdf-complete-no-delay-dequeue          |  97.47%   |
|  CPU-Mid   |        m6.6-eevdf-complete-no-delay-dequeue          |  189.0%   |
|    GPU     |        m6.6-eevdf-complete-no-delay-dequeue          |  -6.74%   |
|   Total    |        m6.6-eevdf-complete-no-delay-dequeue          |  103.84%  |
|    CPU     | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  120.45%  |
|  CPU-Big   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  113.65%  |
| CPU-Little | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  99.04%   |
|  CPU-Mid   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  201.14%  |
|    GPU     | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  -5.37%   |
|   Total    | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |  106.38%  |
|    CPU     |         m6.6-eevdf-complete-no-delay-zero            |  119.05%  |
|  CPU-Big   |         m6.6-eevdf-complete-no-delay-zero            |  107.55%  |
| CPU-Little |         m6.6-eevdf-complete-no-delay-zero            |  98.66%   |
|  CPU-Mid   |         m6.6-eevdf-complete-no-delay-zero            |  206.58%  |
|    GPU     |         m6.6-eevdf-complete-no-delay-zero            |  -5.25%   |
|   Total    |         m6.6-eevdf-complete-no-delay-zero            |  105.14%  |
|    CPU     |            m6.6-eevdf-complete-pelt-fix              |  105.56%  |
|  CPU-Big   |            m6.6-eevdf-complete-pelt-fix              |  100.45%  |
| CPU-Little |            m6.6-eevdf-complete-pelt-fix              |   94.4%   |
|  CPU-Mid   |            m6.6-eevdf-complete-pelt-fix              |  150.94%  |
|    GPU     |            m6.6-eevdf-complete-pelt-fix              |  -3.96%   |
|   Total    |            m6.6-eevdf-complete-pelt-fix              |  93.31%   |
+------------+------------------------------------------------------+-----------+

Utilization and load levels.

+---------+------------------------------------------------------+----------+-----------+
| cluster |                         tag                          | variable | perc_diff |
+---------+------------------------------------------------------+----------+-----------+
| little  |                   m6.6-stock                         |   load   |   0.0%    |
| little  |                   m6.6-stock                         |   util   |   0.0%    |
| little  |                m6.6-eevdf-complete                   |   load   |  29.56%   |
| little  |                m6.6-eevdf-complete                   |   util   |   55.4%   |
| little  |        m6.6-eevdf-complete-no-delay-dequeue          |   load   |  42.89%   |
| little  |        m6.6-eevdf-complete-no-delay-dequeue          |   util   |  69.47%   |
| little  | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   load   |  51.05%   |
| little  | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   util   |  76.55%   |
| little  |         m6.6-eevdf-complete-no-delay-zero            |   load   |  34.51%   |
| little  |         m6.6-eevdf-complete-no-delay-zero            |   util   |  72.53%   |
| little  |            m6.6-eevdf-complete-pelt-fix              |   load   |  29.96%   |
| little  |            m6.6-eevdf-complete-pelt-fix              |   util   |  59.82%   |
|   mid   |                   m6.6-stock                         |   load   |   0.0%    |
|   mid   |                   m6.6-stock                         |   util   |   0.0%    |
|   mid   |                m6.6-eevdf-complete                   |   load   |  29.37%   |
|   mid   |                m6.6-eevdf-complete                   |   util   |  75.22%   |
|   mid   |        m6.6-eevdf-complete-no-delay-dequeue          |   load   |   36.4%   |
|   mid   |        m6.6-eevdf-complete-no-delay-dequeue          |   util   |  80.28%   |
|   mid   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   load   |  30.35%   |
|   mid   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   util   |   90.2%   |
|   mid   |         m6.6-eevdf-complete-no-delay-zero            |   load   |  37.83%   |
|   mid   |         m6.6-eevdf-complete-no-delay-zero            |   util   |  93.79%   |
|   mid   |            m6.6-eevdf-complete-pelt-fix              |   load   |  33.57%   |
|   mid   |            m6.6-eevdf-complete-pelt-fix              |   util   |  67.83%   |
|   big   |                   m6.6-stock                         |   load   |   0.0%    |
|   big   |                   m6.6-stock                         |   util   |   0.0%    |
|   big   |                m6.6-eevdf-complete                   |   load   |  97.39%   |
|   big   |                m6.6-eevdf-complete                   |   util   |  12.63%   |
|   big   |        m6.6-eevdf-complete-no-delay-dequeue          |   load   |  139.69%  |
|   big   |        m6.6-eevdf-complete-no-delay-dequeue          |   util   |  22.58%   |
|   big   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   load   |  125.36%  |
|   big   | m6.6-eevdf-complete-no-delay-dequeue-no-delay-zero   |   util   |  23.15%   |
|   big   |         m6.6-eevdf-complete-no-delay-zero            |   load   |  128.56%  |
|   big   |         m6.6-eevdf-complete-no-delay-zero            |   util   |  25.03%   |
|   big   |            m6.6-eevdf-complete-pelt-fix              |   load   |  130.73%  |
|   big   |            m6.6-eevdf-complete-pelt-fix              |   util   |  17.52%   |
+---------+------------------------------------------------------+----------+-----------+

