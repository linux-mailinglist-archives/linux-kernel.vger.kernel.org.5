Return-Path: <linux-kernel+bounces-122457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E2E88F7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38491C2368E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F6D4EB46;
	Thu, 28 Mar 2024 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v0MSh3wW"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FF1134CB;
	Thu, 28 Mar 2024 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711606668; cv=fail; b=Ull6oUcclQJeEjnRJDfe5iyimW9zKp9bw7mNWNIDDDP/iVI0yAzMyn4ywRbU/9V+GXk5KvB54LpdtsI/0nCKIbmPaNsqxRjXWzdDGtCG55Wh7jFuqE3WDO8+Kvx+34dwSGgfr/HLYfOxuZkacZwcX0IGLUQ1OSCjG+8gjJM7HdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711606668; c=relaxed/simple;
	bh=S5tnwpCXYxkdiJhoGVDTaHbVWZ+ODKwkNWSzz8N1Ooo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hUauX9KW5Aix7IfdqHFM+pmBpbW12VuaP3nysN3uT4dG5ZQ/EWgLOAzyBow3ycIwVS00JN0kkcqoCpdUC2mLy8vBMmbLMAPDHGEn6EuljGMiHQhObEELRLOGUH2fFWkh3OSgHjaxSbvHYyVPzZuJi4r53lkzhyT4i1pTaHnyQbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v0MSh3wW; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH+bxK/LU7eV1Un2EgGGWJSM1Bok80yjR6CrctAVwPVm1Yyse8glipBnXKHdYcouTs3JpU9hFfrYv1Fmhm71ZCrT8WZyJpTW3I3DrIcyvoqrmWK2xecZRc7NCJJU6g1bpSZ8NPT4RNhO9Q+4qdXph+aRe6j+hFfv688AzsiHOtHjoQZgb042xz8k796CBrPY0Ew/KXnZvJO/B2EXP/jO3dIHYytJsUO6G/xH+wiuk3ZJtIBwMW5zGXnF64QFbUV+pISz9ZcRUeTUlqovoGsS6C83NKmNnJJLt94ZTfLh1NTKXgOhtiERbERWLQk5rwUo+UmwSiRCAVFW8vek7UzPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGN9q3Hl8+pD5e/9uOL0uYuWVQh9jZMxuNDgCfrayNk=;
 b=eIzjYVoqMxGsN/HbcKkrxPG/MtgNojCvScxNCtyHvFyICK9WyPb+Y1EKvZKec8lhJSbi3Ary7OxtfN7VO0/zlqWDAXn0bFZ4uAkP5QaaX23/IcUwQYcBr2+L1AciXdF6Xkd5QR4EY/2tRK3p0KG5zg0BcT5NM02PToENHprDeB3XZ9L+K/S2pB7VSrNp+p/nUpL/APl8o/jPUnMBI3ExN5cPTgUjJygTghq6SkUlmZQcabCBD+blagS9jGzM3HEDuxVPtmYG5GY+BOWoi9IaM+QTk1o4hNHgOuFjecdRadu5wY0ag8vXRPm1kyCD2VbEX8mFx8+lZhuaPizHWLmpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGN9q3Hl8+pD5e/9uOL0uYuWVQh9jZMxuNDgCfrayNk=;
 b=v0MSh3wW5tLtyLVd598eeFwYIu3LD1xLIMg7mXBW2+DfQbYuW4aIeB6xkw4gj96ZxKc2sMe9h0e8rXasYfWzz+q04lp+10nPio9DX1mmlzvfmKncU68u838uJJgaaUD2DM4eKclgkLI8Tw3n2T7gYRNTFRRWy1ljDTTIkphf5rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 06:17:44 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%5]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 06:17:44 +0000
Message-ID: <d63a6e47-204f-44a4-8789-d4e41de39ec3@amd.com>
Date: Thu, 28 Mar 2024 01:17:43 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 2/2] tracing: Include Microcode Revision in mce_record
 tracepoint
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Avadhut Naik <avadhut.naik@amd.com>, linux-trace-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, rostedt@goodmis.org, tony.luck@intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
 Sohil Mehta <sohil.mehta@intel.com>
References: <20240327205435.3667588-1-avadhut.naik@amd.com>
 <20240327205435.3667588-3-avadhut.naik@amd.com>
 <67ba2ece-6b46-4ae1-a944-a38f84360d0f@intel.com>
 <20240327223522.GDZgSfKj1CVyZ0zfxs@fat_crate.local>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240327223522.GDZgSfKj1CVyZ0zfxs@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:806:d2::23) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ae279e-da56-4e7d-054a-08dc4eeec7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jVIFZKWnP7a6QzdLKVD3yCyQizYnsp1lKqRAO+8zZFTpkZ6vAczudiHyHL5eEwDHhuKYPOaW7xuUGbG2kIDrddWZk/fAoByfFgkjieinFf9OKijsr9EQi8IaXhp/RQWWygOZ+RZTF/+4/FnGGFfY3GLO2s/bkcSG3mKtweWu9t+vw5Zo+oDvoyJTtM4c9+WTDYaldCgMtvFa1URcDVEGh1676NMmGvxSXvi0Z4MGK6Nf5TcmHIOWbYMsKe1p1S9jJK8uKH4T+2OWbYY7mngMpNvQ11ba7Xw/Qsnh5rB75MmN96obHCyobODlESK6GUAJHDo/dHgqx4soGxPhXGeMKzSnItZZ4PH0/Ame5oNttHioXaLvWclnW111RojvzUg/4kCudiUVXOmWJVvLDNr3rhn2Jmyp6ra8yOiWnKkpGnzfHIrqf+cuZJpLrqlZUPUGEtn5kl8Edw7LMNjMwQX3lhXlIBmowSaQvwcp5ynJiSfN58TMz+seei5ZoACAQgaxZkM/yxo59nTVY6kKYBGHne/QZnF4qcdeCFUj/GBqPIEomv0/jGlV5J46vOYJ/TM1DVL2OjwFOS1PVUMbbQ5+GKW8WFvOcTcI4zFdHg+3IicI2emJO947G+zbzvyFUcoQf3IcVOrdkciNmULuQWByMJHHVrJ+aX63NEZJMEoiPgc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmJDcFNpTHorN3dqZHFYa1laTFo3TDdSdFF3Ymo2SEZRU043Y3htYnlHemNJ?=
 =?utf-8?B?MzJwdk5zSmlJVE51R0VLVEdrNXRBT3E3bDJwZ1RwcUFvT1BQWmphcS9laGdh?=
 =?utf-8?B?MWh2VVYwa0xBQnlZUEg5NGZESDVtdFBEOERwTEFkdWN3YXpwUDJOQXl5WDZ0?=
 =?utf-8?B?RldXZ3NHL3cycnFUcXVUUWxRMWdvYXFIekczeGh6NEMvUDhyQ0wyQTc3ZVhM?=
 =?utf-8?B?V0ZPb2REWWlMM05ZSnR5UC9WR3BnVndWb2tTRkducWxIemh4eUpQcGFKcDFX?=
 =?utf-8?B?NkVhY0ZPN3lVSTFXaldmUmpPNVZ0eGY4M0Y0c2FQaWlDNU1YK0l4RFVKMUtS?=
 =?utf-8?B?Z3hkQm1YNjk4c1ZPbVhSMTZSOGVNWEtad0FCdFJZMVcyWTBjTmlYQUh0Y3VZ?=
 =?utf-8?B?NVlLWGZQMEhmRjZYcWl5aDV6dWgwZllmNlhra2prMmZxVDY0WW9kbzRuRHZF?=
 =?utf-8?B?dWwzbDVmam5HUXpTczM2YU1FNW50cGpCRWVGdzFIb1FTYy96MTFjdVcvTG1o?=
 =?utf-8?B?V2lzUUlvVFc5YjdBenFlY3R5eFNmSEhFMXREZ1djMEk4QVlraElLL1F3Y3N1?=
 =?utf-8?B?M0tmM1ZvSDBvdEtoUEpxdnpXTHB1TXNIajFNR1hPY0lmSFdsWDBBalRCT1pZ?=
 =?utf-8?B?TUpKZCtEdktwVnFIbzZsRnBMUlVyTHVWT0F5d3h6blRxRVgvUmJ6eFF0d0p5?=
 =?utf-8?B?ZUlsRWpzVVQydWhYa3RKOUxnNHdCTW1LNEErK1g2WlA4blcvUmdIbHRJZ3py?=
 =?utf-8?B?WFpWVVdBczBHUkxoSlFKaUh5b2RycmZmWW1WNFY1WHhXVnNmVlE1ZG9QVWUv?=
 =?utf-8?B?M0d4aEhGaU85cHB0N2hsU3c3dlNQWVBNVGU5L2pBc1J4eWthMUg5aGFtZEhy?=
 =?utf-8?B?b3FKMGt2ckZVQ3BaS0lveGV5UXFmOWhIZm9sRTlFMVg2bnQ0WnhNcEdlVys3?=
 =?utf-8?B?R3JRdVpjUVV3TTVkRWI0S08rY2pWaEMyQjZIWEVScU1HODUwYmRkaFAvOUNR?=
 =?utf-8?B?QmtjN2hiUU85MHRhZ3pQY0FNRUFKWTNhaURUV2Zmc1N1dzNrNTJ3aC90RWZJ?=
 =?utf-8?B?dTRjN2lXbjFPVGgrNDFkbk5qeGRiYjFsVUpkMHd6NGJKZEd2ZUp1NW1ldmVQ?=
 =?utf-8?B?emQwc1UrVWxUajNTQmtYay9nU2swN3VKeitRZmRMTDVoNGpJaEtKRnM5ZG1N?=
 =?utf-8?B?N2hIWXFiRkFNcU5DbHNJcW9ISkVTZGwyQmVFWUdaeGtZMTZTaEVDQlRMZVFj?=
 =?utf-8?B?TXN6TFR5bFBCc3F0TXBzckI3ZXdIbG5tbk9xQ0tvSnFCaHdLZ1g5Ty9xYmtu?=
 =?utf-8?B?eHR3QmluNTBWdzJrRmNDNi9ONFhkSlk3MHV3M2hjWHNiSEMrNHdscHJqRUZU?=
 =?utf-8?B?UVhEbVFxV29UbSs5eUV0N254VXg4VGE2WFlVTDA2SE41TDdkcEVSaHJSQUI5?=
 =?utf-8?B?NkhCQnh0Rjg2d1RPOTlKaVR0TTlyQXdaTjV1Sjdhb0ljelhsUnZBM1JTcXJt?=
 =?utf-8?B?WGFCZ1BUMXRyRTk5NXFpNit1ZXl1QUhScVp1dXpRQ2dGalpISnp2OGtFcVk3?=
 =?utf-8?B?UnFJdlVnTzk0aHYzQjdpVm53WXVQcEk1KzFJOXlXbmdyWlgxMHAyREpYZmxm?=
 =?utf-8?B?ZDlLTkJQYTFWM2ZYenFRa05yM3JZSGdqZlNxTVo3TFI5V0RDV2VHajFndnRp?=
 =?utf-8?B?TFZLVzVDN1doSVJZZ1dXUDNob3ZGOFBlMU5ya1pYOE52NzZNRUY3NU8vN0VV?=
 =?utf-8?B?bDdiUEJLcE5ISmNrQjBvVmhiZE1aa3lCaWtTYm1CdHVwbzM4bzc1aENZMk9k?=
 =?utf-8?B?K0JOZ0hsd2g4bENLTUhlL0k2cUNodGdPaGNjU2RuTFMwZS80Q21xM2d3ZDB4?=
 =?utf-8?B?TUE4K3U1Q0I2czRYT3lENHhUenNUNDFBZ0RtMmY3aWg4T1Y1eWdydnhuS2lV?=
 =?utf-8?B?UjJQdkRGcVR4RGRScjB3UGljRUJ2U0dzNUZKTE9sZjJySXlicjkyMjN1OUta?=
 =?utf-8?B?VG4ySU5Obld5OStVZEJKQi8vS3pKYzRNYnpiNkNkcmw5aDVsNnJCZFlkOVZY?=
 =?utf-8?B?QjNNeS81eTdaZFN2Y2Q5R0NNWWdCVWNHVE8zZmpPRE52K3BuRHhHVERONWlQ?=
 =?utf-8?Q?VF5cjZ8r2k2j/I4firdxO/UEk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ae279e-da56-4e7d-054a-08dc4eeec7ef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 06:17:44.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1IhU2YPDyAdnEO4WPleIvzP+0cj+Rnr4lTsz0qNoF3vhMunCq91YvHTz37SrcH1jXAtWY9Hc4jNx4yNYakDRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581



On 3/27/2024 17:35, Borislav Petkov wrote:
> On Wed, Mar 27, 2024 at 03:31:01PM -0700, Sohil Mehta wrote:
>> On 3/27/2024 1:54 PM, Avadhut Naik wrote:
>>
>>> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
>>> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x, MICROCODE REVISION: %x",
>>
>> Nit: s/MICROCODE REVISION/MICROCODE/g
>>
>> You could probably get rid of the word REVISION in the interest of
>> brevity similar to __print_mce().
> 
> You *definitely* want to do that - good catch.
> 
Will do.

> And TBH, all the screaming words aren't helping either... :)
> 
Are you suggesting to change the ALL CAPS format of words which are
not acronyms to normal Capitalization style? Like Sohit suggested
in his other mail on this thread?

Somewhat like below:

SOCKET -> Socket
PROCESSOR -> Processor
MICROCODE -> Microcode

-- 
Thanks,
Avadhut Naik

