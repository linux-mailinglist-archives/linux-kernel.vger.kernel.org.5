Return-Path: <linux-kernel+bounces-157972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9068C8B198D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6168A1C211EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232B822F1E;
	Thu, 25 Apr 2024 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0iSQQStJ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799E17550
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016069; cv=fail; b=YT4cQ/XRbZS7ncMfXPyH/K3qWYlm8oXBn29W/Wt7qyMZ55ZZnmi4tFA8psAZ3PaugSlGPA2/fQaGfnhmRCRlIl2dUrK5jZGxXScIY3V1KifmEjYebTVDgy020Q714T+DLUeF1jJbn1/AN0LHjeyq8KxJwuPDAF4XqjA+urQApCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016069; c=relaxed/simple;
	bh=SnzSDI49P9nQTaRnPOZ3hybg+4wutyal4o5pVFmtyqs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kvMhTGMe4apGZXNa5sRdYKZxlZoqPY/cRhsC9WJIyPI0KsQoFunKmag9iHIMUP6AaxbeWKhaQEty6QzB4Kap+qJ8JTan2c7zcIQfX6ggWiEFUDNL+EvSVYHitN/Foktl+atoZHIgPBZMNg5drE2BLcP8wVezkBJiHuI8zWpiiVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0iSQQStJ; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiBPF9EcuqaOXxtZTnQCAqbtZLZQmG3CyyUFh8QihkYQBqjkK6uP7aYOQ4YzmwjTBo7f/rwwQUqld1FOUGZ7QI//Neqb391xdcTDrJL4Tps+CgqQpy8GxtYANziMv0yTDqz25+6xfVOqI9UlJWMxqD5iEspki1bJVTux4tDnbcw+sqFJqbNUIQG0q1R3QblpUCHge6zaIV3WlkfWHwE3vdRkV92u4MsHVIVVxOk69qJPg/9+hWTDMvCRuJuq5+nEAOHa/2peucq1GQiroiDWHvg2UwyhvM8psCCtp5BL+PKfKaTTRI9B/WzLp7/F+F5X6+GAC6SsjVWgrq/N3eRnVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwWFfiqltcVflZ/7rka2T6hF2VC6HIWmbp+5BmBQbjE=;
 b=Wb1taY5xGTUzndjSVp5YPiOL2JF6BvkAFk1H90MtGxoqJRPvV4FkH85ouy3TrCJzZSCAhtIiPRv1zNOC2/lp7Ff44HsNwqkNjFNC5EZQh02nM+td1/wVdYeSLb4Ia75wKm5gfT2S2+C+pCNVYpWZEV2L+dPRr/ff9YuScPoDH3yCMhCi1xPCdhLS3OUslcSlj2rDln7agfwnGbTw5DsRuMf2V6lvhIgqRfGqp96fMYmzkQXQEOszXFK/sBVnxwhDtyOGJJU597iQfi8fTS0E9c/vnijqahsawnFnQ0vhVLrhkF4RC7321SVbov2rGaD3VCUhUS0an/hw63y6bZd3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwWFfiqltcVflZ/7rka2T6hF2VC6HIWmbp+5BmBQbjE=;
 b=0iSQQStJdOeNGiwlcliiw47Z0orgFOXfGjLrYS1RaCiuK64qhXKeUfzgk20and/Fq1rzuRRS4JEFJeW+aBQdhdQWEzYkB3loBLnmkr/4/ELp2uEuzwU9xHReLpLNxyOzsxNBNncVAlfXXtWcAJ0hmeIKJxGNcjOo08+atz4lImg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 03:34:24 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1%3]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 03:34:23 +0000
Message-ID: <8c4de476-bbd9-840f-4c23-4b84f3c7986a@amd.com>
Date: Thu, 25 Apr 2024 09:04:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 1/1] sched/eevdf: Skip eligibility check for current
 entity during wakeup preemption
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Tobias Huschle <huschle@linux.ibm.com>,
 Luis Machado <luis.machado@arm.com>, Chen Yu <yu.c.chen@intel.com>,
 Abel Wu <wuyun.abel@bytedance.com>, Tianchen Ding
 <dtcccc@linux.alibaba.com>, Youssef Esmat <youssefesmat@chromium.org>,
 Xuewen Yan <xuewen.yan94@gmail.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <20240325060226.1540-1-kprateek.nayak@amd.com>
 <20240325060226.1540-2-kprateek.nayak@amd.com>
 <20240424150721.GQ30852@noisy.programming.kicks-ass.net>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240424150721.GQ30852@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::10) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: e2cd2431-c41d-4525-9503-08dc64d899a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGdIS2ZOTlNNRHcwbDNCTjZyR2pvTWxCaTZkU2tRNVg5Z1Y1TERrTlI0K04y?=
 =?utf-8?B?bk9mSXBCOFpPc1V3Q2Z2OEp3YmpzRjI3aGRKQnZQblVOWU0vSnUrYkI2Sngw?=
 =?utf-8?B?YjJMTXZEYlVTWGdqbDdPeDBWaTBoVlA2d1ZqUGUxVEhXS0YrZ3NHVUkzWUdM?=
 =?utf-8?B?VVd6cjV2dFB6TStNZ2tWVXV2SHdadUJ3emFzNU9qSFpCbVhxVjF5dS83VTB6?=
 =?utf-8?B?K0s2MjRUeHVVZzk2eGRpMmsrTW9DcU9jSU1UMEJ2NDhrU054U1JFOTFINHUv?=
 =?utf-8?B?b0J3UHlUM2lzMzZBT3BTeUFkZDlDbHFiQ2ZNVCt4cGc0cTVLTDZPZnc5R0dQ?=
 =?utf-8?B?VG1nNG4rc25ORHRVWjdac1c4Tjhkd1dLcUtVU010cW5FWUdibmZabmlQU3VM?=
 =?utf-8?B?REQycjk1bXBtTFN6VU1vQVBGdGdXWFFDNXVZa00vZFhncmRNRjBtVVREQXNp?=
 =?utf-8?B?b1pyOFgxK0EyVUJRdG9adGJkUldpbERldmxWSEhwR29JR0tiRndTNnBVd3Fo?=
 =?utf-8?B?TWtPZzlyRnNOaDdFcVVmdW05TnpMQ2JwaDhhQW9Oa3lYVnJNNS9paG95TkFX?=
 =?utf-8?B?c084bGxQUjNLRjVWbFZQL0VpR25OWmM2R3RzdHNBVXAyOG9NMlFKSGxCNzdO?=
 =?utf-8?B?KzhEL2pzLzZiOVpyd0lOTS9MU0pNTE9abmV0QzVKK0JTY0h3MmdJVHlZZE9v?=
 =?utf-8?B?dzhnbmNGRm4rOHVncE9OV0JTUGNLV05ZMVhqTTM5dXpQdVlQeDlWVEVqbTRH?=
 =?utf-8?B?LzhiSFZ4OTJPNnRrNEtvRUlBUDUzYWRldVJ5M2xTOVk5aTNFaUNDMDdVRmNI?=
 =?utf-8?B?TWJsVGhFLzU1Y2FjUVRjUnRLSTNiZG9YNU1FMFJJTlE0MmdKclQxZTRTMW8x?=
 =?utf-8?B?cTFGbFZzdWVWdG1WZy85K2MxeGdZczZpSm16RWJ0Q3dObzFpUmhWWDVLZ3g0?=
 =?utf-8?B?NHNxS0R0MFVuRnZPa2FRZVB1eEFQdXN4OXgvbHFhZm9yeFFVcC9PZlhuemQ0?=
 =?utf-8?B?OFpzbDdEajNVZ2tqVUswUmpobzFrdzNaNThBb0d0clJkZ29nd2VTTWFmaHpu?=
 =?utf-8?B?NmxMWnlPWThzMjZnbkU2aDFJSmNudWsvSGpIditLR3Q0b2MxOW5JRDhaMG9p?=
 =?utf-8?B?L2k2a2xFb1V3RkRlRFpxTkFJbExHOWhuL3ZDSmFXME1DamlseGRrMmJ0THIy?=
 =?utf-8?B?YUtrYlNEVmFaOGwzb1YrSmNTRTd5a1JUMlczMlZ2V0Q0MkpHeHFWTXFmVmFx?=
 =?utf-8?B?NkNJZVhLdVVaaDhMQW1oUC8xekIwWDJoVmM1TkRocDd0Nm1wZ2lQWjRVZjJj?=
 =?utf-8?B?YWFhVkFMYnAvWjdlMUNDd2ZtVW5GdCtqd082YWx4QjN1elRPTlp5aUpoNTd5?=
 =?utf-8?B?Wm5ZSi9samorYkNLeHdlb29Lc3BVbHprQWx1dW5mSU1EMEduenh5YjNUT0E0?=
 =?utf-8?B?QzVKT0RCNGtPaUlNa1pGcmhQT0dpaHJmNFVwcURxcWlGdDhvejZQdWh0S2hC?=
 =?utf-8?B?aUZNRnNjR1JZbmFoSGxBOXdjenlLVmhYTmE5YWVnZi9IaDJUY3ArQTlyeVYy?=
 =?utf-8?B?ajYwL3FNL0x3d3BuckIxL0t5ZE9uYklXa3dDU0Vrazk1NkJlNEdBNFRtMWNB?=
 =?utf-8?B?TUd0UHNQWkFsaTlRV0NvUUx6UFBYVXJNN2tFVysyRS9weE9xT21ZZk5VaG1N?=
 =?utf-8?B?dTBQWEwwRlIzMjE4MFdKUzQ4c3lUYU5ML21WZ3Z1RFIvdDVsdFh3bVFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mi90S3p0UHY5dmlTOWwxN2hNNUUrbmNwMnJrVlhvU2ZVRWRrNlhhek01Y0Z6?=
 =?utf-8?B?N28zMGcrTjNOUDRqd2x1Wm9RUVk0dC8vWUgvMHhwQnVOWk1hQ2NjdDRSdzZv?=
 =?utf-8?B?TWtPa05yQllRKytRK0J0WURBTnc4TE02ejNhNUpnTkVtRG1GWDJtZVFYeEJI?=
 =?utf-8?B?clBpM1BNM1JjWjYzRzNobUwweGRNdGdnK2o1UTRJY2JVbUVjb1BoUFhhMnF3?=
 =?utf-8?B?ZUM0VjhERmtOTG9ON0pxbXRLRXV5ejRiMzlGM0EyTHpPcThOMHptNVVWTHRX?=
 =?utf-8?B?enVUUGhDQlZlekkvajB6OXUrc21tenBZNGkzM2hoVEw2TGFMOWpxakRVYVNJ?=
 =?utf-8?B?VzZ2OVJHSWJLZWdqdFZEdmowRE9zaU0yVVdSbUFNOUxCT3M0SnVxZDM0R2Zm?=
 =?utf-8?B?THpDYm14ZFVKL0dPeFJhQ2N0d0pKdi96RlZvSmx4OUVjR3N4eEczUjZvdjRU?=
 =?utf-8?B?U3lEOFF5dUpDaWJOVC9rRDJWSGZiRFd6VDRuS2VMRkUybVVVTXd2cFFWcmZ4?=
 =?utf-8?B?c3NNZDFZSTVoNXdvOVpLdGg1T3lBdTBlR0IzZjVIc1RuOHB4ZFZVNzhwK2hQ?=
 =?utf-8?B?Z0Y0RCt1U2tBYi8ySk1ZeDVqaS8wZ2EycldQSTFRMGNhMTR3OHEybjlXTXZo?=
 =?utf-8?B?WTh4R3lETzNLZjNSSmUrVll6ZUY4bkY1NzJhYmZJNFdmY2dWdlExa1ZvTEdp?=
 =?utf-8?B?U2gvT3RvRVlpMnhCc0dXbWpGVGs1NUp2TlhrWmlBM2EzR1M2aWVGRzNVWFBY?=
 =?utf-8?B?RU5EeFdEb082RWRreC9rdWJibWF6RElTYjA5RUt3b0wxcW9FK3RqVFg1dWc4?=
 =?utf-8?B?dk1PeGthQmo0VzZ5ZXRsRURXa2tFWXRiQ1BWVTJILzg0SUF5d1kvWUpPTG9q?=
 =?utf-8?B?RThhVVFlWGxmYXFNdUFkamVCdU9CdFhtdm9sVGhacGw3NUsya0hOTER0dWU3?=
 =?utf-8?B?dktwSG1JcDVVTEwxNWFOMWcxd2dUaWwwZ3RNZW52Wkl6RFJBbmxLeWk1N0Yr?=
 =?utf-8?B?bGEzSElBdktFZWxQc0R5R2JFMTA3MHFJdkE0ZzlVTnplWjI2K0x6NFZiNXF0?=
 =?utf-8?B?QWQ4RVJKRm1JeENBNlRnRVhxN1czTWxCa2RIVmxacTI0WDkwdXF1QklTRHF2?=
 =?utf-8?B?VHNtMUhIZ3hDU0xzVWFkNUIvdytkUDMydVNtSDlCaDFLMG51Y00wQ3ZzanZn?=
 =?utf-8?B?ZllONmNBeVVJOWhJdW54NkgzNklobytCQUVmRWEzVHFReTlGTHVTSi9VWlJ2?=
 =?utf-8?B?TVZROXpEbzcyYUFlemxURXp6SCt4S0YxaGFWTXlRZFhHYU11RkJmclc5L2wv?=
 =?utf-8?B?NWtBeHpEQzlZTlY4Wk51cFBQTko2QVpYOVhScUN2NCtUZTdWcm9ONkNFTWJ5?=
 =?utf-8?B?K3pJeUlaa3dUSnlMRjkxZk9UV254cHp6a0RKbXhPL1VpOEs2R2JJeEdHc2d2?=
 =?utf-8?B?SElkclVmTzNMVkFoN2NxSmVjbkVuU21Oa2RFekNacEJxRWVnQVQ2cHAvZXdk?=
 =?utf-8?B?YUhVb0NyNDA2dFdLTGNGbllVUGhEdTJ5L1grTVhMdHNOMEx6dE9LSHR0Wnd4?=
 =?utf-8?B?N1dQQ2NGbno5Q1VZT1ozRnlGWkF0M2poVmhBdXJxRlo4WExnbnFWZ2F6dFA4?=
 =?utf-8?B?ZTdUV0RmS3V0cUIrU2tBYlNqRHp5bWhHUVYyM045SE5rUEsyUTVUTHkzN1Vk?=
 =?utf-8?B?ZkRhMmFTcmNsR014Q1BzTFBKOTRCWXRsM1d5RDN5MC9acnZBb05lUnZHcVZh?=
 =?utf-8?B?Z0pLQUdKNWdqL2dnLy9odlR6SG5oTEs0R2xlMW1iNlV5U213TzJnS0FtU0Mr?=
 =?utf-8?B?amc1S0xNeG80WExmRnYxbU13QkdhUzg5b1l3KzlHaXhqM0g4WUhyOUtBZ3Bl?=
 =?utf-8?B?dDRybSsxeHdVeEhJUkp6NU41Vm1JaWN2T3VScGZKNVp0UmVhbzlFNkdDdDNa?=
 =?utf-8?B?M3kyYTBLZWpPRjVXa1E5c0VUM0twa0xEWERQZDhMaDVBYmNjNUNUVUhRenN0?=
 =?utf-8?B?S3FNdHE0VSsrT1lzclllSzhsSXJRSUVCa1UzU3VQMWZPTjZQWVNLNHpHU3Bv?=
 =?utf-8?B?R2ZURHNDQSs3K1dDWGZFbHNTb3NvUkVnUGtqUTVTcllkcnUxTENLR0k5dzJj?=
 =?utf-8?Q?WYTkx6t05O5JIB8isOj1x6R6Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cd2431-c41d-4525-9503-08dc64d899a3
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 03:34:23.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QleCneEmi5oEoUdXs29t9Sq7yfA1nYXvt8DTsYVL9J76eL4pGVBsUwb/0vs9DkCfwpv/a0zVQ6CYffDlUqh5SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

Hello Peter,

On 4/24/2024 8:37 PM, Peter Zijlstra wrote:
> On Mon, Mar 25, 2024 at 11:32:26AM +0530, K Prateek Nayak wrote:
>> With the curr entity's eligibility check, a wakeup preemption is very
>> likely when an entity with positive lag joins the runqueue pushing the
>> avg_vruntime of the runqueue backwards, making the vruntime of the
>> current entity ineligible. This leads to aggressive wakeup preemption
>> which was previously guarded by wakeup_granularity_ns in legacy CFS.
>> Below figure depicts one such aggressive preemption scenario with EEVDF
>> in DeathStarBench [1]:
>>
>> 				deadline for Nginx
>> 		   |
>> 	+-------+  |			|
>>     /-- | Nginx | -|------------------> |
>>     |	+-------+  |			|
>>     |		   |
>>     |	-----------|-------------------------------> vruntime timeline
>>     |		   \--> rq->avg_vruntime
>>     |
>>     | 	wakes service on the same runqueue since system is busy
>>     |
>>     |	+---------+|
>>     \-->| Service || (service has +ve lag pushes avg_vruntime backwards)
>> 	+---------+|
>> 	  |	   |
>>    wakeup |	+--|-----+			 |
>>  preempts \---->| N|ginx | --------------------> | {deadline for Nginx}
>> 		+--|-----+  			 |
>> 	   (Nginx ineligible)
>> 	-----------|-------------------------------> vruntime timeline
>> 		   \--> rq->avg_vruntime
> 
> This graph is really hard to interpret. If you want to illustrate
> avg_vruntime moves back, you should not align it. That's really
> disorienting.
> 
> In both (upper and lower) nginx has the same vruntime thus *that* should
> be aligned. The lower will have service placed left and with that
> avg_vruntime also moves left, rendering nginx in-eligible.

Sorry about that. I'll keep this in mind for for future illustrations.

> 
> 
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>>  kernel/sched/fair.c     | 24 ++++++++++++++++++++----
>>  kernel/sched/features.h |  1 +
>>  2 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6a16129f9a5c..a9b145a4eab0 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -875,7 +875,7 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
>>   *
>>   * Which allows tree pruning through eligibility.
>>   */
>> -static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>> +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq, bool wakeup_preempt)
>>  {
>>  	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
>>  	struct sched_entity *se = __pick_first_entity(cfs_rq);
>> @@ -889,7 +889,23 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>>  	if (cfs_rq->nr_running == 1)
>>  		return curr && curr->on_rq ? curr : se;
>>  
>> -	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>> +	if (curr && !curr->on_rq)
>> +		curr = NULL;
>> +
>> +	/*
>> +	 * When an entity with positive lag wakes up, it pushes the
>> +	 * avg_vruntime of the runqueue backwards. This may causes the
>> +	 * current entity to be ineligible soon into its run leading to
>> +	 * wakeup preemption.
>> +	 *
>> +	 * To prevent such aggressive preemption of the current running
>> +	 * entity during task wakeups, skip the eligibility check if the
>> +	 * slice promised to the entity since its selection has not yet
>> +	 * elapsed.
>> +	 */
>> +	if (curr &&
>> +	    !(sched_feat(RUN_TO_PARITY_WAKEUP) && wakeup_preempt && curr->vlag == curr->deadline) &&
>> +	    !entity_eligible(cfs_rq, curr))
>>  		curr = NULL;
>>  
>>  	/*
> 
> So I see what you want to do, but this is highly unreadable.
> 
> I'll try something like the below on top of queue/sched/eevdf, but I
> should probably first look at fixing those reported crashes on that tree
> :/

I'll give this a try since Mike's suggestion seems to have fixed the
crash I was observing :) Thank you for suggesting this alternative.
--
Thanks and Regards,
Prateek

> 
> ---
>  kernel/sched/fair.c     | 60 ++++++++++++++++++++++++++++++++++---------------
>  kernel/sched/features.h | 11 +++++----
>  2 files changed, 49 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a9206d8532f..23977ed1cb2c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -855,6 +855,39 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
>  	return __node_2_se(left);
>  }
>  
> +static inline bool pick_curr(struct cfs_rq *cfs_rq,
> +			     struct sched_entity *curr, struct sched_entity *wakee)
> +{
> +	/*
> +	 * Nothing to preserve...
> +	 */
> +	if (!curr || !sched_feat(RESPECT_SLICE))
> +		return false;
> +
> +	/*
> +	 * Allow preemption at the 0-lag point -- even if not all of the slice
> +	 * is consumed. Note: placement of positive lag can push V left and render
> +	 * @curr instantly ineligible irrespective the time on-cpu.
> +	 */
> +	if (sched_feat(RUN_TO_PARITY) && !entity_eligible(cfs_rq, curr))
> +		return false;
> +
> +	/*
> +	 * Don't preserve @curr when the @wakee has a shorter slice and earlier
> +	 * deadline. IOW, explicitly allow preemption.
> +	 */
> +	if (sched_feat(PREEMPT_SHORT) && wakee &&
> +	    wakee->slice < curr->slice &&
> +	    (s64)(wakee->deadline - curr->deadline) < 0)
> +		return false;
> +
> +	/*
> +	 * Preserve @curr to allow it to finish its first slice.
> +	 * See the HACK in set_next_entity().
> +	 */
> +	return curr->vlag == curr->deadline;
> +}
> +
>  /*
>   * Earliest Eligible Virtual Deadline First
>   *
> @@ -874,28 +907,27 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
>   *
>   * Which allows tree pruning through eligibility.
>   */
> -static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *wakee)
>  {
>  	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
>  	struct sched_entity *se = __pick_first_entity(cfs_rq);
>  	struct sched_entity *curr = cfs_rq->curr;
>  	struct sched_entity *best = NULL;
>  
> +	if (curr && !curr->on_rq)
> +		curr = NULL;
> +
>  	/*
>  	 * We can safely skip eligibility check if there is only one entity
>  	 * in this cfs_rq, saving some cycles.
>  	 */
>  	if (cfs_rq->nr_running == 1)
> -		return curr && curr->on_rq ? curr : se;
> -
> -	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> -		curr = NULL;
> +		return curr ?: se;
>  
>  	/*
> -	 * Once selected, run a task until it either becomes non-eligible or
> -	 * until it gets a new slice. See the HACK in set_next_entity().
> +	 * Preserve @curr to let it finish its slice.
>  	 */
> -	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
> +	if (pick_curr(cfs_rq, curr, wakee))
>  		return curr;
>  
>  	/* Pick the leftmost entity if it's eligible */
> @@ -5507,7 +5539,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
>  		return cfs_rq->next;
>  	}
>  
> -	struct sched_entity *se = pick_eevdf(cfs_rq);
> +	struct sched_entity *se = pick_eevdf(cfs_rq, NULL);
>  	if (se->sched_delayed) {
>  		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
>  		SCHED_WARN_ON(se->sched_delayed);
> @@ -8548,15 +8580,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	cfs_rq = cfs_rq_of(se);
>  	update_curr(cfs_rq);
>  
> -	if (sched_feat(PREEMPT_SHORT) && pse->slice < se->slice &&
> -	    entity_eligible(cfs_rq, pse) &&
> -	    (s64)(pse->deadline - se->deadline) < 0 &&
> -	    se->vlag == se->deadline) {
> -		/* negate RUN_TO_PARITY */
> -		se->vlag = se->deadline - 1;
> -	}
> -
> -	if (pick_eevdf(cfs_rq) == pse)
> +	if (pick_eevdf(cfs_rq, pse) == pse)
>  		goto preempt;
>  
>  	return;
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 64ce99cf04ec..2285dc30294c 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -10,12 +10,15 @@ SCHED_FEAT(PLACE_LAG, true)
>   */
>  SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
>  /*
> - * Inhibit (wakeup) preemption until the current task has either matched the
> - * 0-lag point or until is has exhausted it's slice.
> + * Inhibit (wakeup) preemption until the current task has exhausted its slice.
>   */
> -SCHED_FEAT(RUN_TO_PARITY, true)
> +SCHED_FEAT(RESPECT_SLICE, true)
>  /*
> - * Allow tasks with a shorter slice to disregard RUN_TO_PARITY
> + * Relax RESPECT_SLICE to allow preemption once current has reached 0-lag.
> + */
> +SCHED_FEAT(RUN_TO_PARITY, false)
> +/*
> + * Allow tasks with a shorter slice to disregard RESPECT_SLICE
>   */
>  SCHED_FEAT(PREEMPT_SHORT, true)
>  

