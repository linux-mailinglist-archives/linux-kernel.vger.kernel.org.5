Return-Path: <linux-kernel+bounces-149128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92418A8C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909A52822B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2F12D03D;
	Wed, 17 Apr 2024 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v+6x3po4"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42662134B;
	Wed, 17 Apr 2024 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382758; cv=fail; b=B/wePPEAGOAEWtr6mL0VwJwll3CMpK2v792Fd/WytNb1UyWjhRgVJiHa+64a88fvNnZyvUAeezPXUSLMQmZir/krstYQ0tMzMD05CLD054Epv+kEsfMNcaixuB7vOCSsbLGhaCjaa8/XLxlIw6ZVIXDa9ErV1Kk4mrnHn8db3lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382758; c=relaxed/simple;
	bh=+jHPi3yHGtNASNZOIbZbC4/flqigrlq0bnEzTPtfwKo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VyhMNhr3jrnJh0wOEWMbe01SLtYV5skuvvKo2wVU7qIqdQpBbcZZkLFdH7BroZyI7WvHNSJ4/+6o0YUEd7L432j8M+z1LNrKwpX6nj93zpqMauLjS9z93bge0UXWmG7WLXYif5rwflaJPKoHZa1Spb5MOvv/LE9YwlDGiYwOMtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v+6x3po4; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4o/MUh6arX2PydQRAFKzlWFuMbYATHn+7jyYMpg3m5+rFVMX6SaY7Q9ZpuUSJJMSczY4MQLVj/poLkJr972QXwKZk7xpUXA3vd+eF8SKBzW5oAd/6//Ks9Ut3fo/K0CxLNQk40F6sV/+lHvkrhV6Q2eCO/pCqXTxi+FFPLGkl7kbQP0jHb1oLhFXyIaP7NSzrqEQxXllxO9wDEt1cLbQmviW0FPcsp+i+6m73vroCrR4davwoYNubXIBqyj/ycDQbGFGMWD3Sc2XAnGGvEuoDRLm01Yy+sH1AVU9cF8HwXhEd7vDWwaoRHW1x4hdQr7dIC2P+kAPVNTZ7jjXa5Ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoCwV5TXsGWbW1OlWzci54qPVKTiBjHStmHyoBpclv4=;
 b=IN1u7JG0G6sJUvR5lZcyDO/Zl5f6tc+P5wG0JcupR3isG8wVeRrbGJKMtgBeZfFsLIpSQvd4CvuMadp0L474fQUuIvDB5J2Q3pr4vSpkZ+1puyXox7TZu2vT3gOcOzDX2j/vOql05BRTf8rxE2bsXB5HBwhxRySKGlql2khesMvYqDncVVBlw/nktFEUPcOqfAiXz8fxmt3gJSL54w/V2JTXxAO45SBBQ6HKPymTYBWPBTVOEg4bjbCzFu03/EoNwgKh52vck7RwiQXgE70DMQ0qzHZ1i/3a5jaLsa2VCiYiuHUb96KMKwDYpSR/ZiymKweiL0zzV8vfTGdEX6UcQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoCwV5TXsGWbW1OlWzci54qPVKTiBjHStmHyoBpclv4=;
 b=v+6x3po4nICEPyiMpeiEIgRjUDHVBANrgt93w8/4OtWxsrIKHwF2RMDlVdKXrVCkpi5iX/gF6TJVpJB9uuaeanR4FeuiQteXrb6/dQyUPITPy/KTaSwnZjC+EmjOVWCksgMx0i+cx1uvfwxc8LBm6zXtd12PjdSmpd58Mr+lzs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 19:39:12 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 19:39:12 +0000
Message-ID: <9d59d38b-af1a-46d8-81c4-b426d47d4ed6@amd.com>
Date: Wed, 17 Apr 2024 14:39:07 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 17/17] x86/resctrl: Introduce interface to modify
 assignment states of the groups
To: Peter Newman <peternewman@google.com>
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
 <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
 <CALPaoCihU+mat2A-wNtTm=qbpya8ZqhDURsfZfjuHitch0WrLA@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCihU+mat2A-wNtTm=qbpya8ZqhDURsfZfjuHitch0WrLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:5:bc::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 105cda35-6d57-4870-46b4-08dc5f160ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rF1iwOw4Oxd/2zbIUielGGQavHJb/EAvZdbuGbhg41CPZZ/Ca1OM3R3v2q67tnc+1zypiCUepKMttCgNEvfumgb2oFcIzMKynsqS9QjdyINTykfhrfILYOcI6TG4oHpnRVnaPi4n19Lr1BYES1iD9ybrdeg8qf1vpg8DqZFi35eC6IXIYPk8wt+7nNuiWX0pYCXyfd9Y1rGqo5m0P0az+M3yGdhZuO+Zy7TLWaLBrVR3+W6Ej0MagrTx/6cMgR0ENmltjv7OjuPVQRUra+QyjFmrtni+3zYl/4VWeB189oLtjgW3GHFVIQfWyYrimr4ejR2b6aE/6r9YFOMbB05zgFMFeBLto7ZKmXLOPUwJ/00k4Fobft5dG/ngYZrwq/Ui3VsdMoQcn7Zvn9EmdMyLF93YQSuqX8O3SelwqyFO7uNfas2upjoHqtEsd8+geyWYaEg3QTjxxpDvTis5kqrHuTBoHZQHqMV4AmOel3ySo7kXGIh61lovvEz/rzMEClBNNXgb3qbyacVlt5Hdgh8KvAWfY9Nil39TMPlGapfZLFCPCci2a1Bv4lxpMHtWGLXqK1dHq0XqfhICWO1mo5QtkRgq4zT/1smWiF5nGI/jV22PwFqAoQsW7JqxpKaYiEua3wj7KgpffLuQByM05NUlh/8YENNMrYzvzJAhF7t97k4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b29oQWIyZXBZWCtueFlnQW9vN2lpUDdKcDE2YW9VdVdJbkdRaDJ3SnoyQjVh?=
 =?utf-8?B?L1J6RTVIRVhOWkc4MzhBVEE3ODhWK2VGc2hCZjh2RnRiS3ZnZU01KzV1ZVJx?=
 =?utf-8?B?enROeE0wdkFiUkhYMExnczlMa3VpUXdIS3gyM1RGSTN5OXE2ekx1MDJ3R2w4?=
 =?utf-8?B?Zm4yK3RMKzc5c3M4aUIxckluREhsZGY1eU5XQTh6Y0pBT0ZiTTIwYnQ1TldX?=
 =?utf-8?B?U1IvR2ZWekx1QzVqdGZHZ2NFaGdJTVBvZmd1WjhIMWUvSEhkRCsxZVQ5aVV0?=
 =?utf-8?B?MVlEbFpOVUg4SzdwdnBWdWxzd2hHd1FFRmVNZGZWVU0wcFJQN0ZOVTBGTkx5?=
 =?utf-8?B?Q3NqWEl1eXM4ZjhENVk4dm9kTGNOdWlRZVc4c2dRVnFXTHZsWTcrV2Mva0Mx?=
 =?utf-8?B?L040WkFJbk5Sd0kzMExGcWR6NkRKUmV4YytyRmJuZG03Z3RuSXhCaUNLcVVP?=
 =?utf-8?B?RWFFREhId1ZaL3NhckVjellBTFpFcVpiZEpISVJQMTh1Skw2RzVIVXFybXB1?=
 =?utf-8?B?SmZWRm5MNXJKdUYzTy9FMnFMQ3FqR0NpQS9od2JaRUcyOTV5TVJ1MzVLZ3E3?=
 =?utf-8?B?YUg5bFBJK0VHUHo0OWxrdDhCWDRhTnFlZkZyWEE1TnowSkRieUZCaGFjaVVi?=
 =?utf-8?B?MjBFOVJFRzEvc1pWVVFJZEt1TllWbXpNVkxxL1ZqY3JhenZqdGl0eXFIcllv?=
 =?utf-8?B?Q3BMdCtBMnNUNG01S01ETWsyN3BLbGd0dDVybUY5L1NjZ1d1Y2tUUDA0R21G?=
 =?utf-8?B?ajNLb3pFRjdlbG1NVVBrSlNDaitDR0Y0RVNEM3FMaXFvMC9vcE1QWUNOeDBT?=
 =?utf-8?B?ZDNxTW9NczlhWlE5aEYyUVFxY3VESWxScS9zejU5WFRPejIvbjNJRXpWVkYw?=
 =?utf-8?B?OFcvNWFZbndBV1dYTXV0ZzJtdFFQVWRPYzdIb2d6djJtOC85cHlyZVJ0d1Zt?=
 =?utf-8?B?S0R1NFNtU1JWZFd4blJMWFJEK3Vrb2xnSHVxUXBlem9EY0FvbjRvTTVlbm1P?=
 =?utf-8?B?NENhZ2lBcjVlMkVxcU9NYTRjNHFndmVtbXh3eFY3N2kzSyttclY4NjFXeC9N?=
 =?utf-8?B?WTVTdENMUytHZWpTRTBkRkRtWVo0cWV0UWVJSW9rYmFsakNjcmdDcmMvRUdO?=
 =?utf-8?B?NE5SS2ZyejJlbHNyaUE2c3lGdEQ2S3JiNDk1OE1pNTFiSFdPZHcramhMRFov?=
 =?utf-8?B?UmZaZzQyeDkwRHZVUTNuUTIrVUtkbDNNaWZ0UDhRZEIzcE5MMzNtbjlXcWtN?=
 =?utf-8?B?a1JtL2RhWlEyRHNYbUFVNUxhWUZEZ2FGdHRCVXUybTBrT2hqenltK0VwL0M3?=
 =?utf-8?B?ZXlGZThwWU9FYTExQzdGeTVkUkJVTG1qYmlCRnBwUTh4Ky9Dd2N6MXNwWVVq?=
 =?utf-8?B?S1NFMmM0QjFEU0pyWWMwa1hKWm10MlNpb3A1bXh6enBWYWlKa1BuUy9CMzlY?=
 =?utf-8?B?akFXNUNKVHZCbWZORS8rTjQweVBNem9FeUsvMTgzckNwMlczeTRPWU9rY2l4?=
 =?utf-8?B?TTZBbEtzWlhFaWVXZkZ1MGwzTlNwQUZLaXhPWXArMno1RjRZdlFxclZ5QS9V?=
 =?utf-8?B?eWk0eTVqMGhrK1B3bmw5elNHRm52SjRaRDZKZERWQW9paTNSRFczVitYSFpl?=
 =?utf-8?B?WFRjamdEcnBMT1ZZejVpRDZrNGV6Z3hjYnFVZXh5UXRIU1RwT0FpRnpLYkNX?=
 =?utf-8?B?MGV3QXp1YnBnQWZWOTViZjFQYVBjVmZ0czRKazJPVm5VU093SWJ2c3gxVUFP?=
 =?utf-8?B?RW9rRWlNaWtxT2NqRHhXd3U0K1FmalFkV3M0b28vQUhXcXY1ZWp4SzB3S2VZ?=
 =?utf-8?B?MU9SQll1aExTVmYzQWEvUzJSTGpiT0RFYVN4TStGaitCdzVZeDE3bGtCb0FL?=
 =?utf-8?B?dDdXeVNVN0ZYSHkvMVpSWDZkM0ZuZ1haTmFxQXg4WEVHWkNWMzZIVWpjdm5o?=
 =?utf-8?B?UHdUeC85R2lFVkF2OEM2czlkUVlSUGJaOXl0Wk1iU00zWXc5dTFHR3g3MFVI?=
 =?utf-8?B?eVVUSXJVTFJNYUJJcXYyZmwzcmVlTTJMZHErTTAwL0Q3aXB2eXo2QlJGQ1Qw?=
 =?utf-8?B?WGxLdGxmTVZHeHJTTWt5cnZwbUowVldTMzA0cXZWOWRGSitCQ3hUc3NtUGw2?=
 =?utf-8?Q?Gtb4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105cda35-6d57-4870-46b4-08dc5f160ec9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 19:39:12.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBf5cZb+9z7ZasR9duXAQRm2rS9xC4Bnhigt+zQCjaIxLCB6pgIu47xbkU+z+c/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

Hi Peter,

On 4/17/24 12:45, Peter Newman wrote:
> Hi Babu,
> 
> On Thu, Mar 28, 2024 at 6:10 PM Babu Moger <babu.moger@amd.com> wrote:
>>
>> Introduce rdtgroup_mbm_assign_control_write to assign mbm events.
>> Assignment state can be updated by writing to this interface.
>> Assignment states are applied on all the domains. Assignment on one
>> domain applied on all the domains. User can pass one valid domain and
>> assignment will be updated on all the available domains.
> 
> It sounds like you said the same thing 3 times in a row.

Sure. Will change it. With the introduction of domain specific assignment,
I can change it to something like this below.
------------------
"Introduce rdtgroup_mbm_assign_control_write to assign mbm events.

By default, the assignment is applied on all the domains when a new group
is created if the hardware counter is available at the time. This
interface provides the option to modify the assignment specific to each
domain."
------------------

> 
> 
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 2d96565501ab..64ec70637c66 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -328,6 +328,77 @@ with the following files:
>>          None of events are assigned on this mon group. This is a child
>>          monitor group of the non default control mon group.
>>
>> +       Assignment state can be updated by writing to this interface.
>> +
>> +       NOTE: Assignment on one domain applied on all the domains. User can
>> +       pass one valid domain and assignment will be updated on all the
>> +       available domains.
> 
> How would different assignments to different domains work? If the
> allocations are global, then the allocated monitor ID is available to
> all domains whether they use it or not.

That is correct.
[A] Hardware counters(max 2 per group) are allocated at the group level.
So, those counters are available to all the domains on that group. I will
maintain a bitmap at the domain level. The bitmap will be set on the
domains where assignment is applied and IPIs are sent. IPIs will not be
sent to other domains.

> 
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 9fd37b6c3b24..7f8b1386287a 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1011,6 +1035,215 @@ static int rdtgroup_mbm_assign_control_show(struct kernfs_open_file *of,
>>         return 0;
>>  }
>>
>> +static struct rdtgroup *resctrl_get_rdtgroup(enum rdt_group_type rtype, char *p_grp, char *c_grp)
>> +{
>> +       struct rdtgroup *rdtg, *crg;
>> +
>> +       if (rtype == RDTCTRL_GROUP && *p_grp == '\0') {
>> +               return &rdtgroup_default;
>> +       } else if (rtype == RDTCTRL_GROUP) {
>> +               list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list)
>> +                       if (!strcmp(p_grp, rdtg->kn->name))
>> +                               return rdtg;
>> +       } else if (rtype == RDTMON_GROUP) {
>> +               list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
>> +                       if (!strcmp(p_grp, rdtg->kn->name)) {
>> +                               list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
>> +                                                   mon.crdtgrp_list) {
>> +                                       if (!strcmp(c_grp, crg->kn->name))
>> +                                               return crg;
>> +                               }
>> +                       }
>> +               }
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>> +static int resctrl_process_flags(enum rdt_group_type rtype, char *p_grp, char *c_grp, char *tok)
>> +{
>> +       struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +       int op, mon_state, assign_state, unassign_state;
>> +       char *dom_str, *id_str, *op_str;
>> +       struct rdtgroup *rdt_grp;
>> +       struct rdt_domain *d;
>> +       unsigned long dom_id;
>> +       int ret, found = 0;
>> +
>> +       rdt_grp = resctrl_get_rdtgroup(rtype, p_grp, c_grp);
>> +
>> +       if (!rdt_grp) {
>> +               rdt_last_cmd_puts("Not a valid resctrl group\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +next:
>> +       if (!tok || tok[0] == '\0')
>> +               return 0;
>> +
>> +       /* Start processing the strings for each domain */
>> +       dom_str = strim(strsep(&tok, ";"));
>> +
>> +       op_str = strpbrk(dom_str, "=+-_");
>> +
>> +       if (op_str) {
>> +               op = *op_str;
>> +       } else {
>> +               rdt_last_cmd_puts("Missing operation =, +, -, _ character\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       id_str = strsep(&dom_str, "=+-_");
>> +
>> +       if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
>> +               rdt_last_cmd_puts("Missing domain id\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* Verify if the dom_id is valid */
>> +       list_for_each_entry(d, &r->domains, list) {
>> +               if (d->id == dom_id) {
>> +                       found = 1;
>> +                       break;
>> +               }
>> +       }
>> +       if (!found) {
>> +               rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (op != '_')
>> +               mon_state = str_to_mon_state(dom_str);
>> +
>> +       assign_state = 0;
>> +       unassign_state = 0;
>> +
>> +       switch (op) {
>> +       case '+':
>> +               assign_state = mon_state;
>> +               break;
>> +       case '-':
>> +               unassign_state = mon_state;
>> +               break;
>> +       case '=':
>> +               assign_state = mon_state;
>> +               unassign_state = (ASSIGN_TOTAL | ASSIGN_LOCAL) & ~assign_state;
>> +               break;
>> +       case '_':
>> +               unassign_state = ASSIGN_TOTAL | ASSIGN_LOCAL;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +
>> +       if (assign_state & ASSIGN_TOTAL)
>> +               ret = rdtgroup_assign_abmc(rdt_grp, QOS_L3_MBM_TOTAL_EVENT_ID,
>> +                                          ASSIGN_TOTAL);
> 
> Related to my comments yesterday[1], it seems redundant for an
> interface to need two names for the same event.

Yea. I will remove one of this parameter.

> 
> 
>> +       if (ret)
>> +               goto out_fail;
>> +
>> +       if (assign_state & ASSIGN_LOCAL)
>> +               ret = rdtgroup_assign_abmc(rdt_grp, QOS_L3_MBM_LOCAL_EVENT_ID,
>> +                                          ASSIGN_LOCAL);
>> +
>> +       if (ret)
>> +               goto out_fail;
>> +
>> +       if (unassign_state & ASSIGN_TOTAL)
>> +               ret = rdtgroup_unassign_abmc(rdt_grp, QOS_L3_MBM_TOTAL_EVENT_ID,
>> +                                            ASSIGN_TOTAL);
>> +       if (ret)
>> +               goto out_fail;
>> +
>> +       if (unassign_state & ASSIGN_LOCAL)
>> +               ret = rdtgroup_unassign_abmc(rdt_grp, QOS_L3_MBM_LOCAL_EVENT_ID,
>> +                                            ASSIGN_LOCAL);
>> +       if (ret)
>> +               goto out_fail;
>> +
>> +       goto next;
> 
> I saw that each call to rdtgroup_assign_abmc() allocates a counter.
> Does that mean assigning to multiple domains (in the same or multiple
> commands) allocates a new counter (or pair of counters) in every
> domain?

No. Counters allocation is at group level which is global. Will maintain a
bitmap at the domain to determine if the counter is assigned or unassigned
at the specific domain. Please see the comment above [A].

> 
> Thanks!
> -Peter
> 
> [1] https://lore.kernel.org/lkml/CALPaoCj_yb_muT78jFQ5gL0wkifohSAVwxMDTm2FX_2YVpANdw@mail.gmail.com/

-- 
Thanks
Babu Moger

