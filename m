Return-Path: <linux-kernel+bounces-138306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF17A89EF97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCA92850AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D99158A3A;
	Wed, 10 Apr 2024 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="42OGLRmO"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2116.outbound.protection.outlook.com [40.107.94.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D913D606;
	Wed, 10 Apr 2024 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743683; cv=fail; b=rjiu9P4PqxzkZ7htBiKfjcz+JlmupUWaI4cnIs26PjhESPtvrhGDQ2CIPdtLOm1RB4FX8VmlXy8+cIE7szS47FDvugOrbIbLjgM/NWvOvPlZmp8mctItS9bWrv2VcRj282qMTDhMzoh7Gp1QApvcF2kbZiukf41Ccone0PMcj/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743683; c=relaxed/simple;
	bh=+8qhzVNsYvkeiA4z/9ryrLUR3DkiRBrJeE8g7ruPuI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IbMeUITMPgsqiSbSO+IxS52QWaa5iNLwA3pVxPVAqS0DlmZJ7lrrcO4I/AprQkwUW3V/tthX0PE0x581P6SXzVqJSHw8AH8q3Hg3p4q3DoAPHrSb/YJoEROAw7BZEDsEBR+gRuThGn9scxfezix+3X9It+SajbS/+YlpKc/UAzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=42OGLRmO; arc=fail smtp.client-ip=40.107.94.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPGthrr4Sxb2RuycRpaDqBkjo8Rm1xlKie9zdhgfm8jEpGpx2SrXfBHc7VvZsHbsamXrnNpgQDBPoeRW3hy20U9Nshl9de/wJG9mq9bvLDvNi79807xrfcIqQ2L8uU1pg0xCaWVZE0cdbFJrPLjZHWYzqtrAEvVHpE0KQQ0AKD4J/9yAc9hdRcBnwApcutfh/b1/a4ZYV3kGNxaMsZXwbMOFoJF3Kn8MSEub6SOdqYjGKsM88SWMKaB0xA5f/c4cf9NSKCqkiB4wR5Cs+9MFMZgdYyRy/3PWDvyYqKBqT+pgwuiPExgIDI6WuwNyqmTOKKvcRX6mPs9mrMkXWCgpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPyjQxVo4QC4gP9HflVVRAxG21UlIb6NuhLHiEkLSo4=;
 b=fsS+8Ws3aGra6XL+Z3cXYxBh2Y0v6nCVR5tCmZAVrjqsISIxFXzxjDl65NTsAof5LetF2h0g54PPnz9Ur9vs8OcnXaPgPdDzcc/8IkK/7cC2yWidCZL9rhR3l7qf6OWMEvyZ4ZbpZgo1sP1gBFtK9OIvJW5X1FQ3frWqUv6Z5LNRr8hszTTnmgUKMd+dlU2kEt7fMaUkIVxNTexkZaNRhZLrZvPSRtzhwz2A/vA6CVYboXZZlkD7Hq7Kk6LN+FFm68KE6OFsjp1bdMFgMIvYfuyV+RRfI2ylG8kVxUuF1gIWIk7y0gLzpFvIwCUD923ZDGcnaT+0Gdx4siqaunkWAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPyjQxVo4QC4gP9HflVVRAxG21UlIb6NuhLHiEkLSo4=;
 b=42OGLRmOT74TnvVnY+DZvY9r1iAPjXjB5OCdXUUwJsk5RiRHmDr4y0c+ie95lyaK2VlTmEdP0nPvKq9XS9xKyyRFtMfgEMNdbTXPkEk2vcdHr9WIYguT+v7dk/4hh0AL/TkbESlZEW45oGrRiLtAV89D5qgsYoMybL4v3ZSktQQ=
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH3PR12MB8284.namprd12.prod.outlook.com (2603:10b6:610:12e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 10:07:58 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::ee44:e235:d5d7:94a1]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::ee44:e235:d5d7:94a1%4]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 10:07:58 +0000
Message-ID: <d08f02fa-7930-0d48-0f60-2520f890e7df@amd.com>
Date: Wed, 10 Apr 2024 15:37:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: BISECTED: perf test -v "Test data symbol" failing on Intel Hybrid
 systems
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
References: <ZhWTIuyB9p1ORbQH@x1>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <ZhWTIuyB9p1ORbQH@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::27) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH3PR12MB8284:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oWcojtFky4QThKGJcdHX2oHpCxmDiX0BhbgYOqnGncEvm5kV9YgF/39wOShM1DUeUQhIcpPXRKNmkDlLZOht/8EegTXLAuHXpD5k6igzjeQIgZu2Ng9M0i6MxVEWa5QH9RkwE9nP5B92DXWU5hNFqfANk0pppaY5Mh50wWZW4Rs6a4ZnmDdeIEAhjadtfCLf09HCpVz2rwARjf4k+8lAVABKlAn8YFs1thDbkvMS+nTQ2KC1JMkEruvh+dYfkb8ES0b6s2uV0ifd2ufYwVW5ChbCsfHgRFs8rpne3DbHU2G7Zo306ga6kUW+eVBl4Z29/OY4WmJxFj7MfWuDHX9JCxzL/1YLZYh2D2h6g7DHyyd5L76iyXFEypV0jGWxg/8Mr4QEpJaDm2LfV3U22HoxMzruds1n/oLAm0zGhygv+t5QsOJ/v5IU10k0lxmirq8mdpGKWu7KEzOeoHsDAipjF1yqwuwiO5B8gTBM4PXjwNONAVhHZItaUTVajT0f4FxQ6MiliG4htaWUQfwvy49RwrLIr/cUmgzZ6u7f+sofY2feAOox2+0R72TTnbIwrXBPc728j7I/ylTt/CxQhVTKW/oRMHm72YhgpQrXJ/u+oyc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enlzT3k4R1hOUnZiTUlVanRxckllemE1MDU2d1R0YkN6ZFRuR3pkSWhuK1Ba?=
 =?utf-8?B?UUttcDRvQ2ZoYkpGSjRIWEZlMlAvV2hhSGtvdXBoYml4SHBxRGNLL1IvRWhY?=
 =?utf-8?B?Uk45bkl0ZnZMcmZpeUpNWkxtaHUwSlM2QW1BdCs1a3UxRVJYQzJYZVlSNWdE?=
 =?utf-8?B?YWUyUzVadjU1bCtHbWR1bFlzSThMWkdkR2dmNTBIWnZHQk9ZNUtoVXA5U29j?=
 =?utf-8?B?S0xMOC9LOUZzcXNVbVFUSG5uT2N1YndYQmR5eTNuY2ZjdUQwcWpsZEorbTBu?=
 =?utf-8?B?eGVNRFJtemZZbFA0UlR5VGtacXd0ckgybDBsQ2JFOGcwY2RHdUdsUEhUWWF0?=
 =?utf-8?B?bFpvMXB3Z1ZDYWgrTTkvQ2F4WFcwTGVVdTBiY0lhbmQ5eVR1OXN6c09oYVl1?=
 =?utf-8?B?Rk9KRG10Q09KKzlUTmpCUDM2TmZiU0JtSmQ2dGs3WEFXNEVTZ0RnZ0thMzVm?=
 =?utf-8?B?M09zMEl1Z0N6YVBYQ1h1bCtSc2JYekFoWUR1RGdPcFdGMmNnK0hXamxxak1s?=
 =?utf-8?B?eFphanpDTzNGdGczVkxoUDdLUTg2RGVjOEdLclV0MkNkQStLUmlWMFdBdSt4?=
 =?utf-8?B?V3gvZFZScHRmcmhsYUFQR0JuTDBkU0ZmY0JheHVSUm5oVXFnYmcxOUhCM3BE?=
 =?utf-8?B?d1k4L1lwUmFOWXpGWDFHSW0zcFRCbkwrZXRGbXNBWC9UbG82Z1NLaEtZUzlG?=
 =?utf-8?B?cHZYNy9BUjkxSk1DSjdEWi9ibUNxQ0N2b1ZxQ1hhNFFPWUVtMU1iQ0szY2F3?=
 =?utf-8?B?Y0JQcFhYRno5VlgzQ3BlQTlXRlZhN0VkeHJsRnFuOFZmVnVSbTJKRCs4eld4?=
 =?utf-8?B?VFNyUVIydUFRa3NtaEo1TnlobnowVDhhMTFBK3VuNG0zK1dSUVY4cW5XV3Zy?=
 =?utf-8?B?VS9uN2NYYnUwYXVoS1d2b24yamdqMjFhMllDZVdOdEw3Zmh5cWRZcjhjenkz?=
 =?utf-8?B?c3lrdVdFMDlndDlEOGc5bThhSS9DMG82ODhDQ2NQUlo5dVJldkkvbkJFQ2lM?=
 =?utf-8?B?OVN0cVFyYVkyN05EcVlwRElKUXBiOFJ4bW1jdGhTcUxWQnBSYjBwUGhWV2N4?=
 =?utf-8?B?ajlpUlF0b2VBMk91MWhtSlo4TTdZMjJXZmp5UzFEZ2lUMHY1WG5UZDBiN01S?=
 =?utf-8?B?TitvUUFLaVU0bEpobGtxOXF2M1MrUWZ6dWlhMlMyazNicnYzeUI2ZVllWGgv?=
 =?utf-8?B?cytPdENvMWN4Z0dsbHdlTWRtOHdZUVRVNnRsU1A2aGQ5MWVHOGhJMkFQUUxk?=
 =?utf-8?B?aGxSMnROeWgvY0RyMC9OL2tVZUdlcUtpWWpZYVFkNjE0T2pUd0E2bmg2OGpY?=
 =?utf-8?B?djh6VEJsb1hSaWNvbFBya3pRUC9vTE9kQnB6NmgzdUlob2J5dEVUUjdOanli?=
 =?utf-8?B?Wm9QUldnVzgrV3FsZVZXRlMvWDhFVDJvb3IzL3g3c1FvNDVMUWdXMlQzMGRx?=
 =?utf-8?B?b2VONUFVUVpJR3M3cDRHQXg0SDNON1pTNjRZTFkzaUFLQXhXUHJyVlh5L0Z6?=
 =?utf-8?B?YWNUN3JaaW1zZThPMDlGNzR1QmJSRGNNYWNGK0tHcmFkb21CdzgwUmNReHpU?=
 =?utf-8?B?S2hDTS84cXAxRUxkTnVNaVIwSUw5dSsyTG9Sdis3am5LYUdXZS9sM2RLNEd2?=
 =?utf-8?B?WnRMcDFGSGd5anlhTTl3Kys1QWtCRWlXSFV0WHNjY0Y0UzNVVDVZLzFMcU5M?=
 =?utf-8?B?Ly9WYkpwenV1TUxMeVpvMXlFb2Q4MGJLWHczMzd3d0tRZ05BU1ZKOGZpWGZS?=
 =?utf-8?B?QUdDMlNWSFFlM3M5K0FYZlQ0Qm9SbWZFYmpETlQwNkVwSUh3VkVGU21kUGxW?=
 =?utf-8?B?WmF4cUQ4UGM0SU45Q1AwemM1aTVGZCtYQWpUZnVKc1hpMTFycnF4Ymg2UEl3?=
 =?utf-8?B?YURsSlNyakFGT3FkR0dldmlsQ2RaSEk4cnNFTjNBTkxUV3AvR1N3dUg4SURC?=
 =?utf-8?B?M2pYUUZnRlEySGZCSldiR1pPWWpzZEUzQXVGY1FyZWNNNHZYSTM5bFcvckF2?=
 =?utf-8?B?ejFPY0wxd21scE8rWWkxZi9OQnVBZDIycExWNE5pZUFiUmxvNExjV2F0dDJW?=
 =?utf-8?B?czNIRldoOTVSb2Mva1ZqWVlkNTd6ZDFPYmlRTTJJQnJaSm9mRHBBUmM0Umdl?=
 =?utf-8?Q?o0DihoUKe1zemr9eoKWyuNSwt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eee7b80-3816-4e95-03ba-08dc594618e6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 10:07:58.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lO/ARU5+d0DYOz5w/w2mJnpc03m9SaqGXLha9m0OJqPm6COGAzaiSD59W2ywNQFo6moFTR6IPWfX0wgDeGWTIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8284

Hi Arnaldo, Ian,

On 10-Apr-24 12:42 AM, Arnaldo Carvalho de Melo wrote:
> root@x1:~# grep -m1 "model name" /proc/cpuinfo 
> model name	: 13th Gen Intel(R) Core(TM) i7-1365U
> root@x1:~# uname -a
> Linux x1 6.7.11-200.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Mar 27 16:50:39 UTC 2024 x86_64 GNU/Linux
> root@x1:~#
> 
> Bisected down to:
> 
> commit 5752c20f3787c9bc9ff9411a70b3d41add85518c
> Author: Ravi Bangoria <ravi.bangoria@amd.com>
> Date:   Thu Jun 15 10:47:00 2023 +0530
> 
>     perf mem: Scan all PMUs instead of just core ones
>     
>     Scanning only core PMUs is not sufficient on platforms like AMD since
>     perf mem on AMD uses IBS OP PMU, which is independent of core PMU.
>     Scan all PMUs instead of just core PMUs. There should be negligible
>     performance overhead because of scanning all PMUs, so we should be okay.
>     
>     Reviewed-by: Ian Rogers <irogers@google.com>
>     Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> root@x1:~# perf -v ; perf test -v "Test data symbol"
> perf version 6.4.rc3.g5752c20f3787
> 111: Test data symbol                                                :
> --- start ---
> test child forked, pid 522202
> Recording workload...
> malloc_consolidate(): invalid chunk size
> /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: line 60: 522208 Aborted                 (core dumped) perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM
> /home/acme/libexec/perf-core/tests/shell/test_data_symbol.sh: line 62: kill: (522208) - No such process
> Cleaning up files...
> test child finished with -1
> ---- end ----
> Test data symbol: FAILED!
> root@x1:~# perf -v ; perf test -v "Test data symbol"
> perf version 6.8.g63c22868714b

Which tree/branch? I don't see this commit present in latest perf-tools
tree.

> 116: Test data symbol:
> --- start ---
> test child forked, pid 526540
>  954300-954339 l buf1
> perf does have symbol 'buf1'
> Recording workload...
> Waiting for "perf record has started" message
> OK
> Cleaning up files...
> ---- end(-1) ----
> 116: Test data symbol                                                : FAILED!
> root@x1:~#
> 
> Further details:
> 
> (gdb) run mem record --all-user sleep 1
> Starting program: /root/bin/perf mem record --all-user sleep 1
> 
> 
> This GDB supports auto-downloading debuginfo from the following URLs:
>   <https://debuginfod.fedoraproject.org/>
> Enable debuginfod for this session? (y or [n]) y
> Debuginfod has been enabled.
> To make this setting permanent, add 'set debuginfod enabled on' to .gdbinit.
> [Thread debugging using libthread_db enabled]                                                                                                                                                  
> Using host libthread_db library "/lib64/libthread_db.so.1".
>                                                                                                                                                                                                
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000611860 in perf_mem_events__record_args (rec_argv=0xea8280, argv_nr=0x7fffffffd6bc, rec_tmp=0xebbda0, tmp_nr=0x7fffffffd6c0) at util/mem-events.c:213
> 213					s = perf_mem_events__name(j, pmu->name);
> (gdb) bt
> #0  0x0000000000611860 in perf_mem_events__record_args (rec_argv=0xea8280, argv_nr=0x7fffffffd6bc, rec_tmp=0xebbda0, tmp_nr=0x7fffffffd6c0) at util/mem-events.c:213
> #1  0x000000000045c47f in __cmd_record (argc=2, argv=0x7fffffffe420, mem=0x7fffffffda20) at builtin-mem.c:152
> #2  0x000000000045d69b in cmd_mem (argc=4, argv=0x7fffffffe420) at builtin-mem.c:514
> #3  0x00000000004ffe38 in run_builtin (p=0xe08aa0 <commands+672>, argc=5, argv=0x7fffffffe420) at perf.c:323
> #4  0x00000000005000ac in handle_internal_command (argc=5, argv=0x7fffffffe420) at perf.c:377
> #5  0x00000000005001fb in run_argv (argcp=0x7fffffffe23c, argv=0x7fffffffe230) at perf.c:421
> #6  0x00000000005004e8 in main (argc=5, argv=0x7fffffffe420) at perf.c:537
> (gdb) list -5
> file: "arch/x86/util/mem-events.c", line number: 208, symbol: "???"
> Line number 203 out of range; arch/x86/util/mem-events.c has 93 lines.
> (gdb) 
> 
> 
> 
> (gdb) list -5
> file: "arch/x86/util/mem-events.c", line number: 208, symbol: "???"
> Line number 203 out of range; arch/x86/util/mem-events.c has 93 lines.
> (gdb) p j
> $1 = 0
> (gdb) p pmu->name
> Cannot access memory at address 0x64ffffff9c
> (gdb) 
> 
> 183 int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
> 184                                  char **rec_tmp, int *tmp_nr)

This function is quite different in latest perf-tools tree. Do you see failure
with latest perf as well? Unfortunately, I don't have hybrid machine to try
myself.

> 185 {
> 186         int i = *argv_nr, k = 0;
> 187         struct perf_mem_event *e;
> 188         struct perf_pmu *pmu;

This might needs to be initialized to NULL. struct perf_pmu *pmu = NULL;

> 189         char *s;
> 190 
> 191         for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> 192                 e = perf_mem_events__ptr(j);
> 193                 if (!e->record)
> 194                         continue;
> 195 
> 196                 if (perf_pmus__num_mem_pmus() == 1) {
> 197                         if (!e->supported) {
> 198                                 pr_err("failed: event '%s' not supported\n",
> 199                                        perf_mem_events__name(j, NULL));
> 200                                 return -1;
> 201                         }
> 202 
> 203                         rec_argv[i++] = "-e";
> 204                         rec_argv[i++] = perf_mem_events__name(j, NULL);
> 205                 } else {
> 206                         if (!e->supported) {
> 207                                 perf_mem_events__print_unsupport_hybrid(e, j);
> 208                                 return -1;
> 209                         }
> 210 
> 211                         while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> 212                                 rec_argv[i++] = "-e";
> 213                                 s = perf_mem_events__name(j, pmu->name);
> 214                                 if (s) {
> 215                                         s = strdup(s);

Thanks,
Ravi

