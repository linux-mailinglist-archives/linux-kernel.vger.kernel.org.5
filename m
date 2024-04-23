Return-Path: <linux-kernel+bounces-155497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E80F8AEB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B041C2265E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A041613C90D;
	Tue, 23 Apr 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CxaINy1v"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7013BAFE;
	Tue, 23 Apr 2024 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887015; cv=fail; b=KksehB0fg+gPhqTPXYG2L4sFQywpucNFROohjMJlvn44tPeW8ixdHvif0vGkhBzcoQmIESM/x/tv8+30xpAoWNYaG+OTGizq8uPzjfCh3E04x8c5mDolXBhT/rT5fnA4CxgvxGlF+9ZR3s90vQel5RUYg8CKRgmzpT3jKpBlc9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887015; c=relaxed/simple;
	bh=rWwp489kSXBmabXMkP5Rwk02CqMDi2L5kBvIWzbBuRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fe46OG7jeAEgWU4f34g60rgTMk4BMpQ8N/PK+DcrZXWzcalQ/lCscPNQF/Y5r2WkiU7DRInLiStdALS6aRApQTdcfLkhb1JziM8wSGgSZgGs3pqJHe36n0x/o6nOoGe9B62wXlP+nQKuux8LpZG21CAJqIL++62vgnu6MNfySgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CxaINy1v; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgpSTGsxiVVD93OOoa0KErMghW2UDYtdD5WMGMyf9+2tQiJWEIWFPRqyMFpxfTHThRnmPwPwru8u1CtqgevGxuz2mH4lih+rkua6LPLkRbRTPmf4jcaFy1jcMNvnzwuUqHHNreisGXcfIWxwzCh1RyO35zCgKv4OQ75N5sTKjA+a+3QKrvNAJVGVhpOw9CpcoiJdxj/VIYp02Mn357UFuNBc9c4vt2tJTUNjLZvKgHE2PO+pbDsscwWpCIsEv0iuA0XdfG8UxgLPjGg7gLRX6tJ16WKkr+QQD1Wcsb2eyT5Uy5/FB93U6S5WPVbZMwKOuT1lJBnKjJ40Kg5ZJjtwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHcgC+melfSM9yvR6s1HFoaZPdFuaFV/htCIbxe5ev0=;
 b=iC2D3tm/+M0rvZqJyHjufr7h4FxacmFvQG08ryLCFXlObFYM5THE8csiQYJATU1B/d741t7e4ayR39gXuksll88l6DDABerD+p4jRHgslKPXdrzfAtoLw0L6AZqkr+sMmFrce2AJCwousDBYDTD+Csvh6rU68xYxQXRTUK8IQOx5wsUsWM4MBskHlhUkukr6ZSaNloXhzmpkkYYyG+UHbmgSZ0wr9MHejhK1cn8XT/QDr98qd0E76UK/RYNErVr0ktTjo4xBwZALXbSm1/4pQZYl9HL5H/4EXXZOO3ZlmC6jfWYYETf6/f6YhcvFMywJsXETPrEirmqroslJz5HGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHcgC+melfSM9yvR6s1HFoaZPdFuaFV/htCIbxe5ev0=;
 b=CxaINy1vmRaM4CWJFtFIbg+nkzjbZCw99Cg8LEF2Wwb+rJ6WLQUdHXWpH4HlRPzh13XIylahRo8cCILk0jXY6M39xIakPrfuKdU63s72yt6olYKs2uA1dQ1ByZB0CouNyj5jfFjors2OUENsUN8y1QkDbO5R+6bHDAxEn3FCnXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:43:30 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 15:43:30 +0000
Message-ID: <4cd220cc-2e8e-4193-b01a-d3cd798c7118@amd.com>
Date: Tue, 23 Apr 2024 10:43:25 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Dave Martin <Dave.Martin@arm.com>, Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <ZiaRXrmDDjc194JI@e133380.arm.com>
 <CALPaoCh5DDmojnkUZPnACkq_ugwKnqCnwLHj2sV69TSTzpAL9g@mail.gmail.com>
 <ZiervIprcwoApAqw@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZiervIprcwoApAqw@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0095.namprd11.prod.outlook.com
 (2603:10b6:806:d1::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d13aabf-6231-400a-fa01-08dc63ac1fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3dqQW5vVXEvUk5MYVVZcmkrNnhvRWJYcGdtNnlLamFCazA3WC80N2JCcEo1?=
 =?utf-8?B?Ly8vTUVUMmw3aFNpNitMQXUySVR6UFp1VlR5b2U3dVMwS1NNdE43SlFnNy9H?=
 =?utf-8?B?MGxEVDhubTB4NWJXNmIrbVAwS2lUNzNOOXVCNXlKWHRaQUlKYTVPeXZaVU9W?=
 =?utf-8?B?dGl1QzR6TjJISjJCT0hMRGNBTmluSlJmak9oSitSQno2SXFZeWpoSmhTZVRB?=
 =?utf-8?B?bVdlbjFnRGprQjlsS0NiMTBEeGVYTnJOU0dIUloxWERhV0orM3BBMlc2ejNN?=
 =?utf-8?B?TnZ2MWN5TEJoVGYvREpVVWduNXBHUE1Bd0V4MFFHZUxoQmZpcldOTEx1TkZY?=
 =?utf-8?B?UDZQRkFoTHFVdmhmVVVySFp2RFNGTm5PamZZQkw1MWgyUHFLRnAxRUxnM05k?=
 =?utf-8?B?Sk9jaGtmc3N6RTdlNFpzZFl1MzByR3hZOHljOVRTTXVQb0VwWDU2L2M0QkN1?=
 =?utf-8?B?RFdtQVJVcXBVWjRXdUtzWldSZEZINXJSUGtMOW1LNHQ2b1JmTHlNRFg1Rk5j?=
 =?utf-8?B?OU1VaCs3MVgvTVI0bVcyWU15eXVyVVlKYjBWWis2RWYrdmoza25KYTllc1N0?=
 =?utf-8?B?SHlUYllFcm85K3VhbHRmQjhQYWRHeHQ3K3hWbjJ0UTdRYTZFR0FYL3JHSzRY?=
 =?utf-8?B?M1pKYThZRVNTUkpwbUI2Ykc0cVZpMmxnMDZJRW9aTW92bjE0UnBGQ1RRbXo1?=
 =?utf-8?B?ZkhRa3V4Z3ptSVhMZEFGRjhYSVdSK2FRL1V3L0w5aW10dTVKRm5WdGxuSUxw?=
 =?utf-8?B?UzhKOVZZQ1FhRXBDRnhBd3c2eW8rMWMwRkZCNDVETENwc3A3Y1BRZXE2aGp4?=
 =?utf-8?B?MEFFWFRZclVMWlB5cENjenZ5U3pIajdoMUlyWXpESE5YQmRMczFhSFlRWENw?=
 =?utf-8?B?eG5NcEpkeEQyTzByNDdMTUJwbHd0aWhHTlJod0NUTEF6cW82dnBlVU1BZWlk?=
 =?utf-8?B?UGZET1F3R0lpRHdISEVUbWc0V0JBM2wrVUhWRjhsZWN5eUd3MGwyZmhrNElP?=
 =?utf-8?B?N01xcUtZNC9oTFk4NW13Y0ZrMmk1SDluU24rUkgyaXpCSTh5SHg2SUNyNFlE?=
 =?utf-8?B?Sno4NVJ3L3BHNnBzU25GZDRibFM2SVF2bHZ0TGtwNnpqTFZ6QzZnTXhJdHpE?=
 =?utf-8?B?akNXQWZDZ2NpMXM1aFJNZWpjekJTelhZbVhRVUZtMUJ6RWFTSGE5aUNyMnBS?=
 =?utf-8?B?Z1UxVHN1cG9lK0ZGYnFsdnd6TVFkWnFZVUFDS2lzYThIdk5lQkxUelh0elhD?=
 =?utf-8?B?WDZaK1dTMSthZVhFYWhxK0RaY1hCOTNDS1Y4RXczVFFSbWVnZzlSV3VlT3Mr?=
 =?utf-8?B?ZHEwaU9JbGlwcDJJZjJ4ZllYMjJyZ0ZmR0xzL0JITGlzRXJrWC8yVkNhMUNU?=
 =?utf-8?B?NWNQT3N2YlJZd2NEeXJlZ3cwTGtmdC9kczFKa05SV2V1QXN5QlhtL2wrQ1BW?=
 =?utf-8?B?VG82UEhrZ1pKc2FyZXkrbCtiWDVLTllacmxQRnJJVGVhRzVJTlpSRWFYRWdV?=
 =?utf-8?B?R3hvd2xyVDUyTm8vVkx4T0FwMm9jU2ZYakpLMW1iZG9aU2kyRzNCSEZpUHIr?=
 =?utf-8?B?U1hjWDZ4RnRCUmZGMFBVNnlHOTZWYlplS0pvYkZ6cnV4RFMzZnpuS1RjTzdt?=
 =?utf-8?B?OHZaVjBwV3IrWFJsdU9LUGNUVHhud01iWDE2M3Budk1HMEU3U1J5RnVVaEtu?=
 =?utf-8?B?Z1drdXFXb0VvS3c0d3hWdnVKSVluSUdRb3lzS3lZcFlqSDc2QlFtWFJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm03aHpJZXA4RDU5Wk0xU3ZmN1BnbHhHWHF1NE01cFJxbVJzdTZEb3RHMkhr?=
 =?utf-8?B?cXlOalpHWE5HMXRSY0w5aFBiUDRkZURaczJpaTFlODhQTk9ZNnYxOE9kM1Zi?=
 =?utf-8?B?WGxyREVaNDV1eVlQdFBkV09jU05GbVR6REF3NmUwdXFmWk9Dc0d5eFJiRmtm?=
 =?utf-8?B?cm9uWkJTVkZWTkhJVGw3OXRoLzZNTnFXR1hJS3N6bVFwZW50WEJCdHBSOHB5?=
 =?utf-8?B?NTI1TVFEOHpZakxGMWUrMG9aSHVuN3pVZ2dVMWVNK2FaVnJSMURkd2s2eDli?=
 =?utf-8?B?b29YcmEwMEdxV2VCbkcweGpabi9MWENlaFZrVCsrMVpzM0J5cHlleDJqSk55?=
 =?utf-8?B?MDFpYzZHUTdydTBuTmo5V0VoMlJkMDBjeEg2Zmp5Z2RhNUZ1K3l3K25tRDJa?=
 =?utf-8?B?eEVvOW43MnUxMFhjcWgwRTIvRmRuWkQxRFFEQng3eVVFZDV0VHd2SjRVaVkr?=
 =?utf-8?B?QXo5ZS9HK0QrdTRmVlRtbGVCNUluMlluTkJ6MHVwVmtwZHVlMEJsdGdVM1lH?=
 =?utf-8?B?d2ZFR2NBVGhldE5vUWVlL2pNNmxURnVmUksrQXFYd1BZY0FRTjJvMkxBTUlV?=
 =?utf-8?B?ZnJYdlo2dmp5dDJQcUNadWxNanhOSGxqTWxsUmNSKzNDTTJVWlU2bXltOXFR?=
 =?utf-8?B?UGV6QXE3R0FlTndEVXBXcFc1RVkrNzRxNWE3QjlhbnZ3VnNPeVV3K0JhVDQ3?=
 =?utf-8?B?Titxd1JvUk00aS84Mm8yejdXbWJONm1VWWRSeGVVSStzMGtsRDVnYStKa3dG?=
 =?utf-8?B?elJ4ZFRNVnZ2QmZ2OU1DM0VCRkxXTmczRWh3T1hhWjhlZnZNQUV1VlVsNHNL?=
 =?utf-8?B?MzdabldySWxPVEgxSS94cXZWV09BcjFITHdwQjliZ2FhdXc1VW9oRmZMaXZR?=
 =?utf-8?B?UVlsODZ4Q21jNG5uL1RmSkFBQldiYXFrU0plOGlyZjJLY2pZVEZsR2Z0VFd2?=
 =?utf-8?B?OUhUeGZrZzlzYWx4YXJwRnlyeUdHdkxqTG8vNXdZUTJWdS83djZZc3ViNG55?=
 =?utf-8?B?azVJRXB3M0JKRyt5QkRBbHBIS2FaRVFySDBRUmVCTnErU2NGdVFIcy9oYW8w?=
 =?utf-8?B?ZDZsZXl2d2pvTU50Nk9TVjBCaSs0ZW9ITTdFbmt2OGsrbzBwcWNJOFZYSTFR?=
 =?utf-8?B?QkNiZUF3SWhBTWpMTnVVNVhRV2dPMFVPRHkvL2NvSnV5K2cyNzd4YlNBZkdz?=
 =?utf-8?B?MkwxbkZ5MG1LaUVOQXhhcm11dlh1U1lMMm9MdVBUV0dDVjI5clg3cmVCTzNp?=
 =?utf-8?B?RWI2YWg0Rk1EdTBKc01iTnZxTCtheHhZTmtoZ3JsZ3R4UFZrKzJ0WmRJVWcz?=
 =?utf-8?B?VU9COHRJZm4xcnlMU2V0MSt3MkZNUG5MTjlKSzRNWnRZQklwdFRSNldRTG1F?=
 =?utf-8?B?VGpaejhRMUdMWmFaMDJkSDVlSXJWckh5VW1QZHA3T0NZcTBRY2pDU1FWVVBR?=
 =?utf-8?B?cFBsZGQ4bURseGRrUmVBaVJkczVDUDhIbC8rd1dwTTNtTUdUVXhSeXI1aEJq?=
 =?utf-8?B?SEZGcFdKTVpTVG1zWW4zbjd5MWE0ZnNscHJHUkRNTytCQ1hQNit5cWFIT0lz?=
 =?utf-8?B?Rm1vdHd6SDlWb0IvRUVMVUkvREVSenBWTkEzbSt0Q2w3bFRqUnVFNUdQRUlq?=
 =?utf-8?B?RHZkZkxSaW9TbS9ROVNIYTdjaUwyVFBQUnJpQUk0RVdWa1F2K0dmaUlCTENo?=
 =?utf-8?B?WE1YUVJhUi84SUxYdXVUVTJqQTVQWTl3ckt4Zzl5RlhoZEJWTm5Ja2JzV1lL?=
 =?utf-8?B?bzd0T1lCbFBsYW0zRzhxNGZqUUZqVmQ1eVpiV3RGZXc1empoRUZESW9YMDcz?=
 =?utf-8?B?a0xwZitoMzNPL09RUE1uZkIyQllUVFZhV24vSkY0OXNlR2xHemMrNUU5dTFZ?=
 =?utf-8?B?TWQzVVpOSFVIVWNrZmg4N29BbnlERUxwc21xekR5WWpDczc0LzRFSWJDSlpa?=
 =?utf-8?B?bkdrVjcwRVdvRjRVTXhJcWJtNUhFVmgxbWM5S0g3dnVUTzBacitBYnk4N2dQ?=
 =?utf-8?B?dWRrcHlXSm5EK1d2SXN3M3E3QnZIaHBPM0RaQnc4eXpXSVltUzZaNGE1cEVO?=
 =?utf-8?B?OVdGOFlZU0gybGZ0M05VOUo3bkRGUGN4eXMyV2tSclBmREJXSWtJZnVxa3hB?=
 =?utf-8?Q?R0fY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d13aabf-6231-400a-fa01-08dc63ac1fc8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:43:30.0205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QemCMceRqx6qkJaqA0VVs0lb0gxvbtfgapU81hpsy/nxVWII0h9TVCkyzVIccjkT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646

Hi Dave,

On 4/23/24 07:38, Dave Martin wrote:
> Hi Peter,
> 
> On Mon, Apr 22, 2024 at 11:23:50AM -0700, Peter Newman wrote:
>> Hi Dave,
>>
>> On Mon, Apr 22, 2024 at 9:33 AM Dave Martin <Dave.Martin@arm.com> wrote:
>>>
>>> Hi Babu,
>>>
>>> On Thu, Mar 28, 2024 at 08:06:33PM -0500, Babu Moger wrote:
>>>>        Assignment flags can be one of the following:
>>>>
>>>>         t  MBM total event is assigned
>>>
>>> With my MPAM hat on this looks a bit weird, although I suppose it
>>> follows on from the way "mbm_total_bytes" and "mbm_local_bytes" are
>>> already exposed in resctrlfs.
>>>
>>> From an abstract point of view, "total" and "local" are just event
>>> selection criteria, additional to those in mbm_cfg_mask.  The different
>>> way they are treated in the hardware feels like an x86 implementation
>>> detail.
>>>
>>> For MPAM we don't currently distinguish local from non-local traffic, so
>>> I guess this just reduces to a simple on-off (i.e., "t" or nothing),
>>> which I guess is tolerable.
>>>
>>> This might want more thought if there is an expectation that more
>>> categories will be added here, though (?)
>>
>> There should be a path forward whenever we start supporting
>> user-configured counter classes. I assume the letters a-z will be
>> enough to cover all the counter classes which could be used at once.
> 
> Ack, though I'd appreciate a response on the point about "_" below in
> case people missed it.

It was based on the dynamic debug interface and also Reinette's suggestion
as well.
https://www.kernel.org/doc/html/v4.10/admin-guide/dynamic-debug-howto.html
(Look for "No flags are set").

We tried to use that similar interface.
-- 
Thanks
Babu Moger

