Return-Path: <linux-kernel+bounces-79468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0A48622A4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7433283A3E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 04:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99C14019;
	Sat, 24 Feb 2024 04:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rlK9bJJX"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7F125A6
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 04:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708750242; cv=fail; b=U3+GGB0pyGjwoL1JxYMGWNMvp1jzYXZ5S5Xa8clV7uFD9TkBH4LHPPNH71LBhrdiIKzGtpVXF1JgOu583q99ZhIkpRXZvJ5oTMkWJfMOuxxSBxtqxkR+eG8+lD38M8J1C1BNLgWu3ABdj+/yE4hNtTZxIFSsmM/UmMqK+hLi9DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708750242; c=relaxed/simple;
	bh=e3CpwFZXnqiMdxGvMMXnlh2sWQhG6oWTP0syGPc5s+M=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kz/e4vXGR8k39dxfJVU1h/SkbH1L2b7Xz2AQJ3A0RTz81gIaO353pqUIVJ/Conf5LH7TFSgvhdQEM1LOtgWHw1hPUnyG3U+B8S4bAASMkR9sbx4LoH+uHmL7A/cpmwLDqTmmEFuMFee5a+fk4eVH9f/h98nY996Owd2RMK808a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rlK9bJJX; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5QE70PXTW9I++p/YHkSpXIXxRtUig+AifmBX0Gi+pO6A2+PCRkVfNT8GAFwGK9M22oPcDfjFdpU+ruLajfk47zjpre9A3V8YEKD2rxK/a7BM7O6wq168Xor7yK1o75hgAumegN7Q+qXmKwHPh6B/vWT4zliaQfMAnE0ACxbogG27em3FT25stmMt6+S6jpAHe4x5mc5s8mu+KMoH8DEfDrVOWMteWD65jQNaaxPfBEIhp6AziRb79ST34tD0/Sv9QVUQeBk9YVniSb6DkUJCglhsVccxq8KYmWJml4QlauP9sEu14GxI/7nA4g332QPWrTYDxHfAGYuFUJhs2XrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIHfvWBE3pXAMrSwe0vRbTAYzpBXA2imb/FvQiN6TAw=;
 b=a73Gv/C6IB4iOjQdclzurNhOTviGExZnmV2z/QO//RZhGdhkqwedsm+voB0yB7TZXxR4Hw72nn9At8qIg3qmuIfoWRnsY4qF8o6mFwnduY9v0ho2HZNTJeCXP9+e/OsUWUKK8VfTJSdAxF1RXC9cuHKYIlBNsxuiTkLiOQUfGCU12173laTpiSn8aVu+63YF+Ok88F6VcSzCffN8rGORdH4z6UOH3zswRtI81nQ1MefDZusl28FojHSSunHSfjM/1MLyy5S8Urp9EgAxrWBvvFavFIcIGOlsgYwMtQmAT4dDKsPzK06+IENclYANsfMxQxkd8AMkDwiJUQ6hll3wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIHfvWBE3pXAMrSwe0vRbTAYzpBXA2imb/FvQiN6TAw=;
 b=rlK9bJJXuEMZnbVw6SvMoZv4kb6/lTdF4ouTZHFUl5sLZSyvdR+5JJwgpH/n5OYV0sF/Jc0liuNXPeh+q2+gl0b1g7kRz07zK1KOkKlI2XwGw7kWPh4/8e/yaSGSBoxQJ+QQ/VekiZpQqS4awnRuK682WbYBY+2hWOnJwZxTsvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Sat, 24 Feb
 2024 04:50:36 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::ed30:7c14:9d31:bd8a]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::ed30:7c14:9d31:bd8a%4]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 04:50:36 +0000
Message-ID: <a94aa94c-cc0e-44e2-b409-d51189ef81ea@amd.com>
Date: Sat, 24 Feb 2024 10:20:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] sched/numa: Complete scanning of inactive VMAs when
 there is no alternative
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
To: Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Bharata B Rao <bharata@amd.com>,
 Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>
References: <20231010083143.19593-1-mgorman@techsingularity.net>
 <20231010083143.19593-7-mgorman@techsingularity.net>
 <ZSUX9NLa+DDjFLnZ@gmail.com> <15c17bd5-744b-9ae4-93ae-19150bfb85a5@amd.com>
In-Reply-To: <15c17bd5-744b-9ae4-93ae-19150bfb85a5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 35bbf783-d79e-47c5-d63c-08dc34f423fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BNGZ+vc10GzPPIExz4YllH7DaT6JiRQhvE+dsrcz+oFFF2FDYJEhHaLrOm+ePiq97bo4pV3uA6AkNECPwm6Lx/SC5ZoNc5mYPdYUyK13hDssAgIsxDyw6vNFLCBAGVVPTbpb/mQ8nhXuo+O03VdFCnnNqzTkUGg1IoebPdcjav4RSTQrHknSnuuizDk2J/Q+Rcd/O8TF5vR4ARQyyilR1CHzqL2hKkVrR0XRot7OqvoOEqbnZEVXiXzjTUCqnc5G1Rsp/OSWRFec2PYm+x4lUT8P7BevYw0avrVeinmNKe7yr0on2doQM3XEbeA1x98EAkyZGrSGZpoBPBiyslOSsN/vYfdL9e1JKF7T8x6pA/dMPaF/zv1zbL84HjCXaSt8R5OdZkqxy29j0mJOAfoL40OOzdiAZ/GetnPif6nmHAX8+4r4J4cHVNAiTaVsuiweG36yDC8/Tm8x6ity/oE3k6emxKQJCkIxYkEJPtGQF5mA/QWNZiCwxOnPcrW+WMpfYOmwmlJIXTGb9JLzzUJhTBIxDZgflSHlma4VteYjq4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmZMTWVpOFRZRG1GWjViTHp4endVUTdOQ2trWkdURG81cjE4SDVyNmFYM2ow?=
 =?utf-8?B?bGZnOU53Ym9LKzBTYm8yNXVtcWF3ci9xbHc3Z2pKVzdSU0VRYWhJeEtac1pp?=
 =?utf-8?B?dVlpU0RKMTFOQVJTNE10bHlsRVV0NXFPQkZPTzhnUDAxSm1pd1dCSE8wUlRX?=
 =?utf-8?B?RGpXSEtOb25ReW5wUEl5U1p5WFZWWEtLSGUyQWw2d3R5YzFnK2ExZUp4WCtD?=
 =?utf-8?B?L3dHK3crWlhKUmRpZnFweUFDOG9aRHcwSzZtdkk4ZTVWYWh5em5VdHcvWTJu?=
 =?utf-8?B?UzZJbXpaWHJyMkxPaFBpdlUwWHEzM3lhbkpiVFFqT0w3RkRDUWhEdFJuc05j?=
 =?utf-8?B?Y0lyZFVLUmdjT0ZMbkRpdkJzMXJSeUVyajFRS3Z6dFhtTk5pbkNCWXdIcUo4?=
 =?utf-8?B?OUxYVGkwSzU5SjRuN0tBcFowTW5tOTRBRnB5cWR6OHFyOUcza3dHZkhHdStj?=
 =?utf-8?B?YVkwcTJ5a3FJVjBNamJTaWttYmpKaUhub0kwNVNOVUxNQzJvRm9keG5HRmI4?=
 =?utf-8?B?d0xMSSttTS9yaDlYMDg3YjRwdTdZMGd1Skw4REdLenhUQ01SOTAzbEVJdXpo?=
 =?utf-8?B?MHdwWDNMS0JmSXZ3RWpiWTNHOXM3VGNFVWJ5b3hBb08xdkd3Ym9MdXdEankv?=
 =?utf-8?B?QTNGam03Q0JPaTF1SnR4RDNKUndOell0Zzc1QUNFa3dVM0pGbkdIcmh4ZXRq?=
 =?utf-8?B?NTUwRm1iREdxUHF6ZkJNSzluRW1maDY4WGFGaVJRUW4zL1NjZE84UVpQUkdy?=
 =?utf-8?B?dUxGQUFGWStod0lDMk1WMUdOaWk2YjR5UGNmTXhPU295bmk0RnVpL3ZVL3pD?=
 =?utf-8?B?cSt1azc2VjQ3d0Q2QWZPTExsR3dhTWJ6Q3NLRUpxUEx3NFJWd0pDRU8yOWpM?=
 =?utf-8?B?NGg3TjdKQ1dpVE41YTdiTXlSb2hpWC9hVVAxS2Z5YkJMZGRhZjFmd2M2UUEv?=
 =?utf-8?B?ak10UHNCWlkrbjd0RjJtb1FwdU9aUGpRWHhndUhVTUpUaXhrSmtuQmVWUEYy?=
 =?utf-8?B?WnowcjlJeklRQkdXTjZJRUp3RllvL1NUUGlzN1ZCRFZadTRQWEJ4WURXbXpx?=
 =?utf-8?B?eWJ0OS9OZVppLzQ5TktzeGlERVEvKzBtNkh6bE15YnZxdGZiR0NyeGJ5bHZm?=
 =?utf-8?B?Ni82Rm1NcmJHUktzVDd0YVFhc3cyK2pLdUhYbW5VeDFIdU56K2VqWHAzUll4?=
 =?utf-8?B?UW9OTnRGTHBNVTNMR244RFNGRmVnVnJyUzdCcDJpVDQ5bFVTWVNDL2ZPRkZB?=
 =?utf-8?B?M1UzM211Y292bmxHZXB3elBxcklsdjFRM2JvY3ZTOEkrN2pKN01pa2RsbXVN?=
 =?utf-8?B?RWdUK0NoOEdKTUo5RXNFRWpHczVhSjM0YngyeXhiM1FXSThaNUJHMUxnMjFJ?=
 =?utf-8?B?SjRUcHkrMFJkZ21XU0Z4Ny9IeTlUdHZ6ZjN2S1ovZHpDNTA2RVYrSThpM1ZL?=
 =?utf-8?B?Sk5tQTV4YzlPL1k4TUlodFQ4WDhoNDE0d0IwMWwybjJtaTdhZWorOHAzcXNO?=
 =?utf-8?B?aVB3SzlrZ2Zic2RjekZRWjFsblppOHFWOW4vVXY2cmhyN0xnOXdDSThENGFw?=
 =?utf-8?B?WWE4bElCS24vMHlaSjM5YVU4b3J4V2l0dkhkL1R1ZTAzNGZpVlpaKzZLTTZq?=
 =?utf-8?B?QmQxYVJ5dUpkZk4rTmJNckVOMGZRaTUvdVQwR3BacDZPVVFlTFlpdFMxL0dV?=
 =?utf-8?B?eHdGNW1Wd1VXWUdiU0ZyK0pPUWEyd0xnRDRieCs4dzF3anIrRXQ1bVJrZUVj?=
 =?utf-8?B?RlVYUXE0SUVBK0ttVzl0R2srUXlWYjJKMVhoM2xvUTR2Qk4wb0JKR2N1YmdH?=
 =?utf-8?B?ZE1xQmtUN2J0VVdYODZrQ2lWOFk1OW9wYm1nZjFQRUpxWlVQdDRHUWJ4Yy9o?=
 =?utf-8?B?ck5FR2c1RWcyd0RjWGl5bFFWek5yNVUxYlQzN2RNZUJFdVdEQWVHK0pZVkRl?=
 =?utf-8?B?eUdmV1pkaFkxZHFKRXQ5eVhNTmNWS1FWLzZ2eldvMEhuWmxSd3Z4OHkwM1Q2?=
 =?utf-8?B?VEdYcHM1TlZ2ZkJLQ3orZG9VZUpqWEVMZ1NMUStCMVM5ckVKcEgyR2didlVo?=
 =?utf-8?B?Qks0dGlwbGd3a1ViVXhLSk1WdjhzeUVFNWp6Q3VzTE0vZlo0cTE5T2RvNGI0?=
 =?utf-8?Q?ig1JF2MkCDxQzkHkJyZayFFgS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bbf783-d79e-47c5-d63c-08dc34f423fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 04:50:36.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUYwwB2ClZp2zZsyCp/CDnV17NxE7UE8XhMKXw/CIWSvMPMYkMBz1qSXtqM8b89BGz8jZWom5zkXwCvGPN6tEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540

On 10/10/2023 5:10 PM, Raghavendra K T wrote:
> On 10/10/2023 2:53 PM, Ingo Molnar wrote:
>>
>> * Mel Gorman <mgorman@techsingularity.net> wrote:
>>
> [...]
>>> Both the number of PTE updates and hint faults is dramatically
>>> increased. While this is superficially unfortunate, it represents
>>> ranges that were simply skipped without the patch. As a result
>>> of the scanning and hinting faults, many more pages were also
>>> migrated but as the time to completion is reduced, the overhead
>>> is offset by the gain.
>>
>> Nice! I've applied your series to tip:sched/core with a few 
>> non-functional
>> edits to comment/changelog formatting/clarity.
>>
>> Btw., was any previous analysis done on the size of the pids_active[] 
>> hash
>> and the hash collision rate?
>>

Hello Ingo,

I did complete the hash collision experiment you asked long back, But 
did not report soon (Year end time) . Sorry for that.

Here is the summary:

Context:
========
Currently in VMA scanning we hash the PID value into 6bit value
so that we can use 8 Byte long variable to record which PID had accessed
VMA to optimize scanning (HASH32 method) suggested by PeterZ.

functions used: hash32(PID, ilog2(BITS_PER_LONG))


Alternate was to directly use last 6 bits of PID (PID_6BIT method).

Current experiment evaluates how the distribution or collision looks like.

Experiment:
Main thread
  - Allocates large  memory.
  - Creates n thread that that sweeps allocated memory for fixed iterations
   (n = 8,16,32,64)

(All these threads are created without delay)

Note down hash32 value for the threads generated from trace.

Note down the PIDs of the threads and extract 6 bits.

Generate a hashvalue-frequency list.

Notes:
1) 8 Thread experiment will have 8 thread + 1 main thread hashvalue so on

2) When we have large number of threads some time all the thread may not
get the chance to scan VMA and hence total count may be less.

Observations:
===============
1) PID_6BIT generates hashvalues which are crowded.

2) HASH32 generates a very well distributed hash values (as expected).

3) There are no collisions when total threads created is less than 64
in both the cases.

4) When number of Threads created = 64 we see more collision in HASH32
method. But false positives did not seem to be an issue from the experiments
so far. Also number of collisions are not that high too.

I think we got lucky in PID_6BIT case.

Overall hash32 service the intended purpose.

(Ingo, I have experimented with extending total PID info stored from 64 
- 128
on larger systems, will post it separately with the patch)

==================
     iter0/8-thread
==================

PID_6BIT     HASH32
(value-freq) (value-freq)

0 - 1   5 - 1
1 - 1   14 - 1
2 - 1   20 - 1
3 - 1   29 - 1
4 - 1   35 - 1
5 - 1   44 - 1
56 - 1  52 - 1
62 - 1  54 - 1
63 - 1  59 - 1

==================
     iter0/16-thread
==================
0 - 1   3 - 1
1 - 1   9 - 1
2 - 1   12 - 1
3 - 1   14 - 1
4 - 1   18 - 1
5 - 1   24 - 1
6 - 1   27 - 1
7 - 1   33 - 1
8 - 1   37 - 1
9 - 1   39 - 1
10 - 1  42 - 1
11 - 1  48 - 1
59 - 1  52 - 1
60 - 1  54 - 1
61 - 1  58 - 1
62 - 1  61 - 1
63 - 1  63 - 1

==================
     iter0/32-thread
==================
0 - 1   0 - 1
1 - 1   2 - 1
2 - 1   4 - 1
3 - 1   5 - 1
4 - 1   8 - 1
5 - 1   11 - 1
6 - 1   13 - 1
7 - 1   15 - 1
8 - 1   17 - 1
9 - 1   19 - 1
10 - 1  20 - 1
11 - 1  23 - 1
12 - 1  24 - 1
13 - 1  26 - 1
14 - 1  28 - 1
15 - 1  30 - 1
16 - 1  32 - 1
48 - 1  34 - 1
49 - 1  36 - 1
50 - 1  38 - 1
51 - 1  39 - 1
52 - 1  41 - 1
53 - 1  44 - 1
54 - 1  45 - 1
55 - 1  47 - 1
56 - 1  48 - 1
57 - 1  51 - 1
58 - 1  53 - 1
59 - 1  54 - 1
60 - 1  56 - 1
61 - 1  59 - 1
62 - 1  60 - 1
63 - 1  62 - 1

==================
     iter0/64-thread
==================
0 - 1   0 - 1
1 - 1   1 - 1
2 - 1   2 - 1
3 - 1   4 - 1
4 - 1   6 - 1
5 - 1   7 - 1
6 - 1   8 - 1
7 - 1   9 - 1
8 - 1   10 - 1
9 - 1   12 - 1
10 - 1  13 - 1
11 - 1  15 - 1
12 - 1  16 - 1
15 - 1  17 - 2
16 - 1  19 - 1
18 - 1  20 - 1
20 - 1  21 - 1
22 - 1  22 - 1
23 - 1  23 - 1
24 - 1  25 - 2
25 - 2  27 - 1
26 - 1  29 - 1
27 - 1  30 - 1
28 - 1  31 - 1
29 - 1  32 - 1
30 - 1  33 - 1
31 - 1  34 - 1
32 - 1  35 - 1
33 - 1  36 - 1
34 - 1  37 - 1
35 - 1  40 - 2
36 - 1  41 - 1
37 - 1  42 - 1
38 - 1  43 - 1
39 - 1  44 - 1
40 - 1  45 - 1
41 - 1  46 - 1
42 - 1  47 - 1
43 - 1  48 - 1
44 - 1  49 - 1
45 - 1  50 - 1
48 - 1  53 - 2
49 - 1  55 - 1
50 - 1  56 - 2
51 - 1  57 - 1
52 - 1  58 - 1
53 - 1  59 - 1
54 - 1  61 - 2
55 - 1  62 - 1
56 - 1  63 - 1
57 - 1
60 - 1
61 - 1
62 - 1
63 - 1

==================
     iter1/8-thread
==================
53 - 1  8 - 1
55 - 1  17 - 1
56 - 1  23 - 1
57 - 1  33 - 1
58 - 1  38 - 1
59 - 1  48 - 1
60 - 1  53 - 1
61 - 1  57 - 1
62 - 1  63 - 1

==================
     iter1/16-thread
==================
4 - 1   0 - 1
5 - 1   6 - 1
7 - 1   9 - 1
8 - 1   15 - 1
9 - 1   25 - 1
10 - 1  30 - 1
11 - 1  36 - 1
12 - 1  40 - 1
13 - 1  43 - 1
14 - 1  45 - 1
15 - 1  49 - 1
16 - 1  55 - 1
18 - 1  58 - 1
20 - 1  61 - 1

==================
     iter1/32-thread
==================
27 - 1  1 - 1
28 - 1  3 - 1
29 - 1  5 - 1
30 - 1  7 - 1
31 - 1  9 - 1
32 - 1  11 - 1
33 - 1  12 - 1
34 - 1  14 - 1
35 - 1  17 - 1
36 - 1  18 - 1
37 - 1  20 - 1
38 - 1  22 - 1
39 - 1  24 - 1
40 - 1  26 - 1
41 - 1  27 - 1
42 - 1  29 - 1
43 - 1  32 - 1
44 - 1  33 - 1
45 - 1  35 - 1
46 - 1  37 - 1
47 - 1  39 - 1
48 - 1  41 - 1
49 - 1  42 - 1
50 - 1  45 - 1
51 - 1  47 - 1
52 - 1  48 - 1
53 - 1  50 - 1
54 - 1  52 - 1
55 - 1  54 - 1
56 - 1  56 - 1
57 - 1  58 - 1
58 - 1  60 - 1
59 - 1  63 - 1

==================
     iter1/64-thread
==================
0 - 1   0 - 1
1 - 1   1 - 1
2 - 1   2 - 1
3 - 1   3 - 1
4 - 1   4 - 2
5 - 1   6 - 1
6 - 1   7 - 2
7 - 1   8 - 1
10 - 1  9 - 1
12 - 1  10 - 1
14 - 1  12 - 1
15 - 1  13 - 1
16 - 2  14 - 1
18 - 1  15 - 1
19 - 1  16 - 1
20 - 1  17 - 1
21 - 1  19 - 1
22 - 1  20 - 1
23 - 1  22 - 1
24 - 1  23 - 1
25 - 1  24 - 1
26 - 1  25 - 1
27 - 1  26 - 1
28 - 1  27 - 1
31 - 1  30 - 1
33 - 1  31 - 1
34 - 1  32 - 2
35 - 1  34 - 1
36 - 1  35 - 1
37 - 1  36 - 1
38 - 1  37 - 1
39 - 1  40 - 1
40 - 1  41 - 1
41 - 1  42 - 1
42 - 1  44 - 1
43 - 1  45 - 1
44 - 1  46 - 1
45 - 1  47 - 1
46 - 1  48 - 1
48 - 1  49 - 1
49 - 1  50 - 1
50 - 1  51 - 1
51 - 1  52 - 1
52 - 1  55 - 1
54 - 1  57 - 1
55 - 1  58 - 1
56 - 1  59 - 1
57 - 1  60 - 1
58 - 1  62 - 1
59 - 1  63 - 1
60 - 1
62 - 1

Thanks and Regards
- Raghu


