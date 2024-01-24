Return-Path: <linux-kernel+bounces-36272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABDD839E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD3A8B23C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B615BE;
	Wed, 24 Jan 2024 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MZkekyko"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2496B1104;
	Wed, 24 Jan 2024 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059801; cv=fail; b=czEnb1jYYQKtfibOJpL/na8JbbbAGsC3Xm0lt5GtbmaQ99eLD4oGAMHNY8HAx55vHST+EAIhbKB3JFHVC6lb+ug+QGIV7IcqVgU84m4B8S8QCv2Es24S+aQ09zUDVL4B0JkY+fARjvXhZqRGE1tMaoRaHLK5Q4QpwckTlOxKqsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059801; c=relaxed/simple;
	bh=P4I7Ia/w11Q/xRLJdlUGUL5pG6erQs9Vk4nELt96MYM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VWN3zqqAXHLubtcd2oPy2owupeSTqnhTuVANHH3QqUSrtR71DPzaKEtWEtXnIR7FqMgwNh6C5YxR8Td1glW8A3Ub50OtINx2jJjjOkTlidCEo716z4uLcPC/QIZ8rvIF2GDV1sbMa3iis0AqVdtbcfbUQi5PYNtT7ODFw296yBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MZkekyko; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/AuOTIi33dXiGziNa96Hn03C0hd5naN7C+3oI8ZIDRcJiSVnmAk6/29AIRa//tHHh71T8zPX8HdaP9W1ajfApV7C/r9nedYKK8wNs9ZnnsKNB/LovUu8R722z+931tk4sdOcXZlm8iIJMBbMmiMLNPWIbuh5oXRG43S+jj4cWCmBnGlEu16SNsSgry9YPgXpMyAtNzaKrhCWeQOFH7kYRUq1DEUyilkClwaew+FRebfGCaZwAUFDypbd5wxwXzIj5DQN1V9r8wJvXOn647r5DQSXbsqUWObuTITN7zwllHT1/eCunsSy0UV6N8ggfE8+UH3TeEQcimasaTQB+Pifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTAQgn3P2eTj3FFBK2jUKg8MaI+TANVXo8R6k9OaGfI=;
 b=GpcDZ/PBGNbkX3al86WeDBwCYklrDeSohtLTEFtoCEu1q//AyKh/EXs0YpvOaVgCqJ6X39EDMSTG08Zn9OvTJ8AGt0kessHsw+dazx0spVYcnv3ygleeIfx0GNpmqw4xkAnfWttVnnjk7lYrv2PMTkCG3oIft/HamuuRz/yczcztC9IqeAUesG8hrxAxtnE920DjwYvrr9F8B5rSqOMP4NxNaQRD25c2Rjrgg1om+ZmchzdV4IqcqCHxns/GzqUya/gS7yGdTn5NN/q6aBsYfOZ0htJoYP9ZxgklLW0ON/GTe6c3QKLuQuUca6yn+jq/40AsMR4TYDCLqqvraSJWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTAQgn3P2eTj3FFBK2jUKg8MaI+TANVXo8R6k9OaGfI=;
 b=MZkekykoTV2FsFN0P/+emc0Dof8sRVp2ekwEDVLWkfrE9m5zvptUY8xuBArGXGA0w4eY9FMNFAGHcEHs3jHuvGwTTeFKu1U5Uua8jb/HCpMf0u0kVVf0uxB02Hzy6qL9xqqTQlG4dvHCD1wUTbAcNs7Q89p7qlUTk42/V9n/ONM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Wed, 24 Jan
 2024 01:29:56 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 01:29:56 +0000
Message-ID: <be870e14-eeb9-4dcf-ba43-a72ef66a3d87@amd.com>
Date: Tue, 23 Jan 2024 19:29:52 -0600
User-Agent: Mozilla Thunderbird
From: "Naik, Avadhut" <avadnaik@amd.com>
Subject: [PATCH] tracing: Include PPIN in mce_record tracepoint
To: Tony Luck <tony.luck@intel.com>, Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 rostedt@goodmis.org, bp@alien8.de, x86@kernel.org,
 linux-kernel@vger.kernel.org, yazen.ghannam@amd.com
References: <20240123235150.3744089-1-avadhut.naik@amd.com>
 <ZbBV4EGrZw6hJ5IE@agluck-desk3>
Content-Language: en-US
In-Reply-To: <ZbBV4EGrZw6hJ5IE@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::18) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f1a336-4f7c-4e07-88d5-08dc1c7bf89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wRoBEIC0me3I+iioiWrWYemOz7T0oUsRRH5na0pBqgg45IllwZ1IdvAkSpuyN+AB2pGzrv90nrQMUeAFbb7V8VpBIbNxkqDrurmkuCxQigSNm1rNddivp6EWSiTO0RQbWn4AeLLLHxPpBwPVUP8aWsSErUewh3wR9KBSMQQIbgleCRHHXJCZeNCASmVWCDu4TF5cqPst7wDDJhxXdduNImkFNKfDU/yIuZRRaP84mhBv75qWc/qPDg/xjDKKVnb+5UUNAvA/tLZmqM1Q7zXFs7LwU742Aji8M0EfLUIxTPm4irRqcZjUp1+Tr1s/AwWfE8QW9Z+HApCZRpM5mKrVeX4eDIaAttuW+w5Cc+HYyIo6JWHXdR4rdV1ybzKW3iXL8nFNkuefpA4W5lgsukCVInQMpVYKZ6z8joR+TWWiljQ2PIbNsLp9Vljk1ELEfTpL8j/HJo4QZNHRNTgXIGE9nBluMm7yy6mjc70P3QQzZs/ogZwxRqgLtFi7wNVfqAWaL3PP/XkceNvA16gwLEljFaDSqqZ5qWc8sap4vBmimnLVJs6CRk3jCZReMdabDRzDuY6a+DFK4xwAB71fzAxhQNQkTMtR4c9MLgGjq+ZkCznlXIOH4AFv3LbhjFAKN6w2EUixW/VPZfzefp5exNUa1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(36756003)(31696002)(31686004)(26005)(2616005)(66946007)(8676002)(478600001)(66556008)(6486002)(110136005)(6666004)(8936002)(53546011)(6512007)(6506007)(316002)(66476007)(6636002)(83380400001)(2906002)(4326008)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkUyZDR0N3kwOFEyemNqaUxoc2NpZEorZ1FlaFVxb2NBWEIzNjV0V1ZsZzZs?=
 =?utf-8?B?SFE2ZnVYY0sybjVhZEw0aUoyenNJQWdyZStFdUc2dkNKbitDYjBMeWI1bUpa?=
 =?utf-8?B?cW1QR2ZHaTV4bUw5emhiUWZyNmhDNC9yWlIvQ25qVW9TdGhjYTIwOE5LQ2dF?=
 =?utf-8?B?cEpMZDErOEhYMWMxZUtWWk5KWWNlRG1RdFIraysrc1FVVXdXRmZURVZtc3A1?=
 =?utf-8?B?cm5JOVhrSHVSNlJIZDlLTkc1ck5zaEt2dG1Ibm9FSVBHaUcycG1UK042KzR3?=
 =?utf-8?B?RkNFV0FGVkNvT3dkQlZSeHcwWWVOOENWREEwM3pja2lTWGE0RDVYOUI4dFpM?=
 =?utf-8?B?RUxtSi9NZ0w0VmVaWTJkeS9LdEJkUjFnTE94empqTFRCWXA3Mk5uSFRrcTdp?=
 =?utf-8?B?bU9yM1pWeGtVTFVtTjAvTXRJQk9wQUlJK01OcGtIL2xvTWRIcm1TazloU2dH?=
 =?utf-8?B?clpHNjVZdEM4Vm1qb1hNazNxREFsaXJTb1R3aG9Ic2NsRTc4WTFpRWNwdlZV?=
 =?utf-8?B?YmZrNEtEcXZDMFk1Q2ViMCtLSEVZMjNzUmFOU253RFRoSU5pclBVeGI5YlNt?=
 =?utf-8?B?TGp5eHZLWTBMVFlJWW5MZDFVQTJlQjI2Zi83U2FHOU4rcUJPamc0Qlp4d0hk?=
 =?utf-8?B?Z0xETkhLYlBPSWFYbGplVUpTdTU4bVBBdFB3elFiMk1vSThta2UrMElZYlp0?=
 =?utf-8?B?QlZKT04vbk1mcFFlMzJ4M3dyRm80ejJYYnlnZFJxVGx1UlI4T2cwNHkxNENq?=
 =?utf-8?B?Yzh3dkg4R0x1dFFQUVdUcHJLcEQrZUpQN3AwdDVaLzJvbGdyenJBR2dlcEIy?=
 =?utf-8?B?RCs1SjFiQ3NWNE9YclBlNjJFNHJ2VHl5T1FvQytOeHhjbjQyaTIwUG9xVUcr?=
 =?utf-8?B?bGk2RnB5Z2Z0NFFZaWJsVTNUZGphaXlLUlJRYUQyVFdmSTJITjl4aDcxVWJL?=
 =?utf-8?B?VFRZbmhBaE55VXh5UnorVS9FY1hDU0NHcjBGelRmLzJ5NzR1T1hycWswS25h?=
 =?utf-8?B?cFEzNXZBSXFjUzRUSmpCcmtpQi8zM3dMSHdIQXBERzNkcXkrdmpSYnpaaHJu?=
 =?utf-8?B?ZC9PRWRsSXNLSXFPRHF3ZEFEbjZYRWdORWF3Y1hCNnNnemJMMnpzU01wcEdU?=
 =?utf-8?B?TTNreW4wTUpBak04VXN1TmJZY3hLbDkxT0dKck5YQUZGWFBiZVYrakNhWVlh?=
 =?utf-8?B?d2RWQTA4NmExRG5iVnJpeE5DRkhKNStaalVtQWljdEZZYzN6Q29WOURwQVdR?=
 =?utf-8?B?SXozalBJR3NqQVd5QlMrWWQ0Y3pSWlpXTGRlWGJ3dzArL2NMRUpOdEc2dFll?=
 =?utf-8?B?a2xTSk9iVEkwQk0vV3h0VDVjYm02Mm1UbnY5c1g4bFRzZEQvWTRIbDdzanIv?=
 =?utf-8?B?TTlObzhBTTFkZUFRQzZLcmUwTHNGRFNaMVIxZFZSMUdPMDcwekpHVmdPaUZn?=
 =?utf-8?B?eEUyUWdoZzNvenRkTmdMYWN6a3MxcVJpVWdsZ2E5UjlyNFVnM1BMR1R1RGF4?=
 =?utf-8?B?SGxtQWs3TzFzWFVYSDQ1Q0J3K1RxdWh4YVpVMTB4TndrM2lCazdRclE2ZHVp?=
 =?utf-8?B?OURraDJ1S0MwdXQ5bTFUZk0xTXN1M2gzVGI4RnRTSXpQN0tGM3kvVW9YM0JZ?=
 =?utf-8?B?NkwwYmMxWTlIdmlmWXUvaXY0WEV6MkpYeGxZMGs1dTNVSzhRb3IyK1loalRs?=
 =?utf-8?B?NVg4ZXNOMStyRUZHSmMwR0pZWUZ0eVk3YzRKUUg1enBGZjZCMmhIb1NuQTNr?=
 =?utf-8?B?QWwwMDFjYzhqNC9nM1d5Vks0TUFVdWE0WEN5SzMxZGNIenFyVnREZ21xa3RR?=
 =?utf-8?B?R1lDbGhTMVF6eEx6bmlMYldjZmN1RndRMVYvL0lKL2RNN2NBYXEwR01YMzhk?=
 =?utf-8?B?Q0JUR2xJb3lSd0IvSG82bkduYW9mbDMvVGw1a3Zkb0NkaTdiOFEzSElWUHNM?=
 =?utf-8?B?TlZ5am8zZW5yZkZmOENhTnNrMHBIM0pJL0ZwRnBSNWtQZEYxRGF0THFXejRn?=
 =?utf-8?B?ZC9saE9MN2VvL3pFUnB0QUl3cjBUMDNNNjlOVXFKMEgzMkE5NkgveHEwSUpS?=
 =?utf-8?B?ZlJuUUdnMkEvNTlYbEI0V0lERmVVUXJVcmptdzQyWXRJSXpIZ2liRExHM2Nv?=
 =?utf-8?Q?T/eUxm9sn9GDw48Rr5N2gFzLE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f1a336-4f7c-4e07-88d5-08dc1c7bf89e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 01:29:55.9985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oy4TdQX8YC7Ho4A/MEHVsuZbYhf9Y5PvJak0+aZzQuQM0WkhI4/beYYpHGwaBanT0f2RN/HAhzQj3TP7K8eYuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

Hi,

On 1/23/2024 6:12 PM, Tony Luck wrote:
> On Tue, Jan 23, 2024 at 05:51:50PM -0600, Avadhut Naik wrote:
>> Machine Check Error information from struct mce is exported to userspace
>> through the mce_record tracepoint.
>>
>> Currently, however, the PPIN (Protected Processor Inventory Number) field
>> of struct mce is not exported through the tracepoint.
>>
>> Export PPIN through the tracepoint as it may provide useful information
>> for debug and analysis.
> 
> Awesome. I've been meaning to update the tracepoint for ages, but
> it never gets to the top of the queue.
> 
> But some questions:
> 
> 1) Are tracepoints a user visible ABI? Adding a new field in the middle
> feels like it might be problematic. I asked this question many years
> ago and Steven Rostedt said there was some tracing library in the works
> that would make this OK for appplications using that library.
> 

I think they can be user visible through the "trace" and "trace_pipe" in
/sys/kernel/debug/tracing. But you will have to enable the events you want
to trace through /sys/kernel/debug/tracing/events/<event-name>/enable.

AFAIK, this (adding field in the middle) shouldn't be problematic as we
have the tracepoint format available in debugfs. For e.g. with this patch,
the format is as follows:

[root avadnaik]# cat /sys/kernel/debug/tracing/events/mce/mce_record/format 
name: mce_record
ID: 113
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:u64 mcgcap;       offset:8;       size:8; signed:0;
        field:u64 mcgstatus;    offset:16;      size:8; signed:0;
        field:u64 status;       offset:24;      size:8; signed:0;
        field:u64 addr; offset:32;      size:8; signed:0;
        field:u64 misc; offset:40;      size:8; signed:0;
        field:u64 synd; offset:48;      size:8; signed:0;
        field:u64 ipid; offset:56;      size:8; signed:0;
        field:u64 ip;   offset:64;      size:8; signed:0;
        field:u64 tsc;  offset:72;      size:8; signed:0;
        field:u64 ppin; offset:80;      size:8; signed:0;
        field:u64 walltime;     offset:88;      size:8; signed:0;
        field:u32 cpu;  offset:96;      size:4; signed:0;
        field:u32 cpuid;        offset:100;     size:4; signed:0;
        field:u32 apicid;       offset:104;     size:4; signed:0;
        field:u32 socketid;     offset:108;     size:4; signed:0;
        field:u8 cs;    offset:112;     size:1; signed:0;
        field:u8 bank;  offset:113;     size:1; signed:0;
        field:u8 cpuvendor;     offset:114;     size:1; signed:0;

print fmt: "CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x", REC->cpu, REC->mcgcap, REC->mcgstatus, REC->bank, REC->status, REC->ipid, REC->addr, REC->misc, REC->synd, REC->cs, REC->ip, REC->tsc, REC->ppin, REC->cpuvendor, REC->cpuid, REC->walltime, REC->socketid, REC->apicid


Just quickly tried with rasdaemon and things seem to be okay.

Also, not a cent percent sure, but the library you are mentioning of, I think
its the libtraceevent library and IIUC, it utilizes the above tracepoint format.

> 2) While you are adding to the tracepoint, should we batch up all
> the useful changes that have been made to "struct mce". I think the
> new fields that might be of use are:
> 
>         __u64 synd;             /* MCA_SYND MSR: only valid on SMCA systems */
>         __u64 ipid;             /* MCA_IPID MSR: only valid on SMCA systems */
>         __u64 ppin;             /* Protected Processor Inventory Number */
>         __u32 microcode;        /* Microcode revision */
> 

synd and ipid are already a part of mce_record tracepoint. (They too have been
added in the middle). Will add the microcode field in the next version.

>>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  include/trace/events/mce.h | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
>> index 1391ada0da3b..657b93ec8176 100644
>> --- a/include/trace/events/mce.h
>> +++ b/include/trace/events/mce.h
>> @@ -25,6 +25,7 @@ TRACE_EVENT(mce_record,
>>  		__field(	u64,		ipid		)
>>  		__field(	u64,		ip		)
>>  		__field(	u64,		tsc		)
>> +		__field(	u64,		ppin	)
>>  		__field(	u64,		walltime	)
>>  		__field(	u32,		cpu		)
>>  		__field(	u32,		cpuid		)
>> @@ -45,6 +46,7 @@ TRACE_EVENT(mce_record,
>>  		__entry->ipid		= m->ipid;
>>  		__entry->ip		= m->ip;
>>  		__entry->tsc		= m->tsc;
>> +		__entry->ppin		= m->ppin;
>>  		__entry->walltime	= m->time;
>>  		__entry->cpu		= m->extcpu;
>>  		__entry->cpuid		= m->cpuid;
>> @@ -55,7 +57,7 @@ TRACE_EVENT(mce_record,
>>  		__entry->cpuvendor	= m->cpuvendor;
>>  	),
> 
> ... rest of patch trimmed.
> 
> -Tony

-- 
Thanks,
Avadhut Naik

