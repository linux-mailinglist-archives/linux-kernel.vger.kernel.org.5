Return-Path: <linux-kernel+bounces-59906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8123384FD33
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1168A1F25ABC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996EA84A56;
	Fri,  9 Feb 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="axI61JW/"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AC584A45;
	Fri,  9 Feb 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508348; cv=fail; b=CndbioaXd3KNx0XUZWxAaxVB5t98FZj7LQa/7ZXcZLpma7faILRQSjj6tstIAwDKl9dZk2I4fyOpbN7sIEBfv8gPA3DLa5cHAlz9qiXTP/ifVW2UIpzHHddyW+0QU0E+3ZRIqhArF6yy8GKn6NSdGK+UI25QtjFHuTJduf0Rt1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508348; c=relaxed/simple;
	bh=NXYbZwCzr9tZU1DQjoeF47+ter3IrrQP/GRNvZa7btY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CguogAqwogAi8i0f8r8+HwR+BgisujWh8jgM43zO9b7bGFkVTQ52Sz0Me/P0F654x6AlwaUJQ2Uxvtw/tEcU3qmj45Q5pfxEh0lVjZCW2P5nu+B6b9Tu8ra4YUFrYeWvfVfHYbaq9rQGL2YppzcI9CuGcwB/l7pJXEcVFfhXm3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=axI61JW/; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVtERBwmslsBh05xQJf253ttDQeUPM3Wz0v10gzeUe0n+KyjrWR9sr5CwopzeeFPD4Et90GX3wNQUqA9WIxdcIXlovOF5jhoQmoqO/lCqUlShUZ6nGQxEfra6CJERQl5DSE3eV2R4bV1VQBASEnvR9se23gR+EpX1W4IXeBq5x8GBC6/shbIkdJrwIWMdB3a0Uhu9etFMN4Kw23TYrwYp0IGy0lYbnpWgaza65xYqqa8zbfPoy1DkjvJKu+ltFfQ09lMXOatLo1VPq420npACKEm+UqxrLqgVFwFhZeP/Sa8Oy2AgZQriWjBpr/isea+wZfOJss5JpV5k59NQ+JKTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3GEzTS9rpRVM1c7n3l2KIpmQQ9nJGqmxq9igy9wU6A=;
 b=g6xFL6gPri/aKL/D4+cy/mPWZ0qJzzagCwBu9Nbz7J1HYCb5y3ZfIExVfOQYwkCvhOhvJXwqNLqZQiY0ruYGycce+MLfY26dcK4rPI1lTN5AazQk7zS8jpxSAVyBRkSpJUnuOtfavSHgWrq6YaldRPZ1gboILKwVdN1+4NM+pXW3Yk3rOwWDV3sc9km/Bb4U2TYMW8jqXOOTEqGgTE9Q/AMRXmFnPAdD59DvnG76cw8EQ5bzhiG7BQw3UhRVc+6DOkS4jfHS224VVmySc8E/7b6aEINBjo/SM5u391CgMWAp2GkdMgreZmB3iEJpSmUAv5kaotcdOyq2xA6cqRei8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3GEzTS9rpRVM1c7n3l2KIpmQQ9nJGqmxq9igy9wU6A=;
 b=axI61JW/gZC1GNoe9IVAy4Ws0oH2B3td8bK5LuunOzjGAI00U4ptqlyy41JNgEZd18VhKqIeI2q7QECBAnYFP/mGGFakWG4gsCCEnoT+w8+30WrFZ398m4R7LO9gD+qes2FhKxuW2Lr6n/GBENzA42aZYGWEOrL3DaPyy81L/yo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.12; Fri, 9 Feb
 2024 19:52:23 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7270.016; Fri, 9 Feb 2024
 19:52:23 +0000
Message-ID: <17b1747a-8487-44d2-b79c-0da03b09c990@amd.com>
Date: Fri, 9 Feb 2024 13:52:21 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] x86/MCE: Extend size of the MCE Records pool
To: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-edac@vger.kernel.org
Cc: bp@alien8.de, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 yazen.ghannam@amd.com, Avadhut Naik <avadhut.naik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-2-avadhut.naik@amd.com>
 <75f48901-fbfa-4ef4-99b9-312800d20896@intel.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <75f48901-fbfa-4ef4-99b9-312800d20896@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:806:24::35) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 549ac24a-e4d0-4a4d-719f-08dc29a8a267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P2WSEGTIMk3OmoCDa9kLCgXdJKxYYmVNibMEhCb3TVhefuf+4zmt/+l01V9NFXhRcJN1FXomRS4JTHT0C73848yOiNedpsRMSGlEcwiBFn7gGvhiHrAu3EpBkF+I9B1RpX3d8DYK9NaOJlbAhgSu3OXlt2PctyOoIF+CHEBLKMUvHzYF6rzDShilvbJM18TNTZtU/eLlApz+ZF28qeF5rNU+6PoVWRKv6z7GE7mEealf0UMzHm0R1+M9e9HPc0Lq3+xuPojiWRGYyPUUj0LCxd64pdVa98vMMP+xBh5cM77+f05vE1DrbWm6lMWvSesFAZHoWlOdbFvJ+5297fziwgfazh6p/Z8u/ll3/GCXNr/qY4NgSHGkUcQr7GnGmUBo0/aQaIloRxiFP6kF58w7v5OZgqjC5et9BB0sjrU5JKFvuv5CvXJxxOIGPH52hiLogi5jHVW7JIG6uD2FkxtgB5N6FMdvySd0Q2oZb9sSMcn1x9ZmW7FZqXQUFGNEB3Y5HF+v/0KcVbLc8kmhHeU2yV5azmY01knf96ADVtF+yYT3vc5gUoY1NWveUAYJkG4Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(478600001)(6486002)(66476007)(66946007)(66556008)(316002)(36756003)(83380400001)(38100700002)(26005)(31696002)(6506007)(53546011)(2616005)(6512007)(2906002)(4326008)(8936002)(8676002)(31686004)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVlreTJhbmNSV3Evb0tEVzdKWVlmM3dWaWtTYUFuQjZLakRjZjRUaFUyTFVs?=
 =?utf-8?B?MGFPK3VKZUtpSjlwOG5wNmJYcmU5KzRlNEtvWDFya0ZkWlpNTnVLa2RUcHdm?=
 =?utf-8?B?MmtmQW9oWWwrMmFlb3d4MndpNTJKZnBlRjlrM3lweEUwWFo2dkpoWi9SR0h1?=
 =?utf-8?B?Q2VNUi96QklEWTI0a0s2MWhHN3Y2OEh4VjZXZVh1MTl1YzJ2TFNLK0lDWmxS?=
 =?utf-8?B?MDdwdHNxaUpmZG02azB6VjZVUHlrRUFmdm9xUnp4ektSdDR4RWtoWjVrendP?=
 =?utf-8?B?MTgvZlF4ZUVUck10WFRxdy9KZmNrak9TY1IySDZvbHBFazRHdmN4RFN5UGlq?=
 =?utf-8?B?QmN2VDcwTFVFdUVKeTh0TGtPOGM4LzUxL0loeVFuWEE2ek1QajVYN3czNW9z?=
 =?utf-8?B?Qjk1UDZsSXk4VWYrYmY4ajRWZXl6K1BHNWtSRU1uM2JQeWlaY1FCWTd3SmlJ?=
 =?utf-8?B?aUs4dnZKamdmTXY5SWhLU3RXT0ppY28rcy9KSzY5Unk4bTZzSGtmWXc3Uy9y?=
 =?utf-8?B?aUFYWGxGS2R1bmJTWlhaelArem9ZK2thQ1dTSTgzY21FWC83cTFCNnR1QXlV?=
 =?utf-8?B?bm5HUnFHT2tHK0dJelhPTDRuSzI1cEZ4YmhuTlI1aFVwTTFsbkNLbDdZWGJi?=
 =?utf-8?B?WWYrd09PajN1SWpjWjhKSTlGSjViSWJNTmsxNGczSGl6bW0yR0VSdVZnSFR2?=
 =?utf-8?B?SEZoQnRXbWhWUzhnVFlFc0NsS2dFd2ZNaVBlZkxCUHdDYjlUMG1TQ012TUp4?=
 =?utf-8?B?KzhzdFlnNW9KajIvODJBYVZocVhGWG5CYU1iNlUyNmR4VnIxT0pUd2dveGh1?=
 =?utf-8?B?TGtvTE5oTkRkUGt3SEYvV1hjNDlCNHo4ZEZyWVlWVkF6d2R1TTRqNTNpNlB4?=
 =?utf-8?B?ZFgvYlpnU2c4Y20wS3RFU1hzRnkxc05hQVRTcmRhU1Zpcll3Z0tuQWd6cDZa?=
 =?utf-8?B?amdVSzdseXlTQzhVb2p6OUdSVURmOXNsdndqRmYrL1hFWllEWlJpZmFmOUVO?=
 =?utf-8?B?WGxYcHRpZ3NXbEM1WDBkUXhMamVFWjY2bm01YVV3aWRpQVRnQ0ZkK3lYbDVv?=
 =?utf-8?B?bmhlM3JSNlQ1a3owRWJWejYwWFN4YTczbTVieEV2R2RYTHFMQkJqMjRhRXA5?=
 =?utf-8?B?WnFSR2h3UXQ0eGRUcGs0QnVpdzZDbmdpNGpUbXRJYkVwNEh0RkU2Q05GZUUr?=
 =?utf-8?B?VDQzakU1dHUyb0h3YTBjQnMreU8yakJ0Y1pHUEFLU1NmbWNOdVlIc1phSjZK?=
 =?utf-8?B?Z0lVUmRLbFV5Ky9yQllGZHpYMGxLelNhcWg1TkxFRzZzekxuZkdMUUlUREFC?=
 =?utf-8?B?M3k2Qlo3NjdybkVNd0tCWitiK0lNL1djdE5ZMnFzMHBQSm10TExoRzQzUkRI?=
 =?utf-8?B?UjIzeWdPOXdydVFPOE5vd3E0VE12RC92ZGZ1dDhPZGQ2ZXp6eTZuRWNMZHdz?=
 =?utf-8?B?cDRoT2VBaGpraVJoaGNFaC9yaVJ5SjZrcm9wRFNNQzNQQTZ0NWk0T2pZNkRB?=
 =?utf-8?B?bUNWZ0hPdS9zalBMT2VQcVg4ZElkektoL0VyY2FVZ3FNOVJMdGZKYlJPODNF?=
 =?utf-8?B?VHJiSnZHUXdJeUEyT0l4WFZXWXprUmV6UHpLWllHRG44bW05dXRZdEhUdDVv?=
 =?utf-8?B?aHJSSFV2WjR6cXBxUTlRc01TY3o3eDRwSlZxSFYvZ3FzVjBuVjZkMkhKelpr?=
 =?utf-8?B?SzJTa0VTUWdueFkzd2twVHlEbkZDc3o4WVVoeUszWFlxd1k2bDloNm9oalJi?=
 =?utf-8?B?UXdFdkM2c1p6czkrRDhsQjNXdzMwa0x4Nkx1WFBUSm94VFhDcVdVTUx0WmVL?=
 =?utf-8?B?QTYwczlWRjJ6akFkK2RtMFpEbCtQRjJZZ293eHNORkhuVkJ4dTJjc3l2M0JZ?=
 =?utf-8?B?YSt2Vm9qSFFTbGVvQkhhd2llQ1E5eDVodHpQVWJ5QXpiMmYzcVNRNVFGd0Iw?=
 =?utf-8?B?Y1RpMHFlMWVoZ1BPZHlzOTA3b21NcFRKbjZmR25uaFpCeG9PcXphSnYxYkJm?=
 =?utf-8?B?dTU2VDltcWZoZExvUnVDKzRkVzZJQUJ5aCtCSENteXZZdURuNEJyK2gzS0E4?=
 =?utf-8?B?YWV2N2FldUU4aGpMQUpJdzRNbWtqRHNiRDc4cm5CcmVObUxEdVNNM09HQTUz?=
 =?utf-8?Q?MLsUw47Bt0J/oFIsDBJt6os+B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549ac24a-e4d0-4a4d-719f-08dc29a8a267
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:52:23.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzyannCTFHOvXZH8+rGT0YKrdChMCgCFFTh4+MqWaZ536Y2N0CED4fOpWPmG6lqmqC+NWeL0hQa/AoxWG2zz3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449

Hi,

On 2/8/2024 15:09, Sohil Mehta wrote:
> On 2/7/2024 2:56 PM, Avadhut Naik wrote:
> 
>> Extend the size of MCE Records pool to better serve modern systems. The
>> increase in size depends on the CPU count of the system. Currently, since
>> size of struct mce is 124 bytes, each logical CPU of the system will have
>> space for at least 2 MCE records available in the pool. To get around the
>> allocation woes during early boot time, the same is undertaken using
>> late_initcall().
>>
> 
> I guess making this proportional to the number of CPUs is probably fine
> assuming CPUs and memory capacity *would* generally increase in sync.
> 
> But, is there some logic to having 2 MCE records per logical cpu or it
> is just a heuristic approach? In practice, the pool is shared amongst
> all MCE sources and can be filled by anyone, right?
> 
Yes, the pool is shared among all MCE sources but the logic for 256 is
that the genpool was set to 2 pages i.e. 8192 bytes in 2015.
Around that time, AFAIK, the max number of logical CPUs on a system was
32.
So, in the maximum case, each CPU will have around 256 bytes (8192/32) in
the pool. It equates to approximately 2 MCE records since sizeof(struct mce)
back then was 88 bytes.
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> ---
>>  arch/x86/kernel/cpu/mce/core.c     |  3 +++
>>  arch/x86/kernel/cpu/mce/genpool.c  | 22 ++++++++++++++++++++++
>>  arch/x86/kernel/cpu/mce/internal.h |  1 +
>>  3 files changed, 26 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index b5cc557cfc37..5d6d7994d549 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -2901,6 +2901,9 @@ static int __init mcheck_late_init(void)
>>  	if (mca_cfg.recovery)
>>  		enable_copy_mc_fragile();
>>  
>> +	if (mce_gen_pool_extend())
>> +		pr_info("Couldn't extend MCE records pool!\n");
>> +
> 
> Why do this unconditionally? For a vast majority of low core-count, low
> memory systems the default 2 pages would be good enough.
> 
> Should there be a threshold beyond which the extension becomes active?
> Let's say, for example, a check for num_present_cpus() > 32 (Roughly
> based on 8Kb memory and 124b*2 estimate per logical CPU).
> 
> Whatever you choose, a comment above the code would be helpful
> describing when the extension is expected to be useful.
> 
Put it in unconditionally because IMO the increase in memory even for
low-core systems didn't seem to be substantial. Just an additional page
for systems with less than 16 CPUs.

But I do get your point. Will add a check in mcheck_late_init() for CPUs
present. Something like below:

@@ -2901,7 +2901,7 @@ static int __init mcheck_late_init(void)
    if (mca_cfg.recovery)
        enable_copy_mc_fragile();

-   if (mce_gen_pool_extend())
+   if ((num_present_cpus() > 32) && mce_gen_pool_extend())
        pr_info("Couldn't extend MCE records pool!\n");

Does this look good? The genpool extension will then be undertaken only for
systems with more than 32 CPUs. Will explain the same in a comment.

>>  	mcheck_debugfs_init();
>>  
>>  	/*
>> diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
>> index fbe8b61c3413..aed01612d342 100644
>> --- a/arch/x86/kernel/cpu/mce/genpool.c
>> +++ b/arch/x86/kernel/cpu/mce/genpool.c
>> @@ -20,6 +20,7 @@
>>   * 2 pages to save MCE events for now (~80 MCE records at most).
>>   */
>>  #define MCE_POOLSZ	(2 * PAGE_SIZE)
>> +#define CPU_GEN_MEMSZ	256
>>  
> 
> The comment above MCE_POOLSZ probably needs a complete re-write. Right
> now, it reads as follows:
> 
> * This memory pool is only to be used to save MCE records in MCE context.
> * MCE events are rare, so a fixed size memory pool should be enough. Use
> * 2 pages to save MCE events for now (~80 MCE records at most).
> 
> Apart from the numbers being incorrect since sizeof(struct mce) has
> increased, this patch is based on the assumption that the current MCE
> memory pool is no longer enough in certain cases.
> 
Yes, will change the comment to something like below:

 * This memory pool is only to be used to save MCE records in MCE context.
 * Though MCE events are rare, their frequency typically depends on the
 * system's memory and CPU count.
 * Allocate 2 pages to the MCE Records pool during early boot with the
 * option to extend the pool, as needed, through command line, for systems
 * with CPU count of more than 32.
 * By default, each logical CPU can have around 2 MCE records in the pool
 * at the same time. 

Sounds good?

>>  static struct gen_pool *mce_evt_pool;
>>  static LLIST_HEAD(mce_event_llist);
>> @@ -116,6 +117,27 @@ int mce_gen_pool_add(struct mce *mce)
>>  	return 0;
>>  }
>>  
>> +int mce_gen_pool_extend(void)
>> +{
>> +	unsigned long addr, len;
> 
> s/len/size/
> 
Noted.
>> +	int ret = -ENOMEM;
>> +	u32 num_threads;
>> +
>> +	num_threads = num_present_cpus();
>> +	len = PAGE_ALIGN(num_threads * CPU_GEN_MEMSZ);
> 
> Nit: Can the use of the num_threads variable be avoided?
> How about:
> 
> 	size = PAGE_ALIGN(num_present_cpus() * CPU_GEN_MEMSZ);
> 
Will do.
> 
> 
>> +	addr = (unsigned long)kzalloc(len, GFP_KERNEL);
> 
> Also, shouldn't the new allocation be incremental to the 2 pages already
> present?
> 
> Let's say, for example, that you have a 40-cpu system and the calculated
> size in this case comes out to 40 * 2 * 128b = 9920bytes  i.e. 3 pages.
> You only need to allocate 1 additional page to add to mce_evt_pool
> instead of the 3 pages that the current code does.
> 
Will make it incremental when genpool extension is being undertaken through
the default means. Something like below:

@@ -129,6 +134,7 @@ int mce_gen_pool_extend(void)
    } else {
        num_threads = num_present_cpus();
        len = PAGE_ALIGN(num_threads * CPU_GEN_MEMSZ);
+       len -= MCE_POOLSZ;

Does this sound good?

-- 
Thanks,
Avadhut Naik

> Sohil
> 
>> +
>> +	if (!addr)
>> +		goto out;
>> +
>> +	ret = gen_pool_add(mce_evt_pool, addr, len, -1);
>> +	if (ret)
>> +		kfree((void *)addr);
>> +
>> +out:
>> +	return ret;
>> +}
>> +
>>  static int mce_gen_pool_create(void)
>>  {
>>  	struct gen_pool *tmpp;
> 
> 



