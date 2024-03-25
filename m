Return-Path: <linux-kernel+bounces-117900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642AB88B115
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B1F1C62847
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8755B548F4;
	Mon, 25 Mar 2024 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="epfcJMtT"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2125.outbound.protection.outlook.com [40.107.223.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B0B40BEE;
	Mon, 25 Mar 2024 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397551; cv=fail; b=fwRWrljdL3fVR1rZ3CDkNDpoKGhZvoa6EElfXZATRDpwY5IoaaZ2ws7QXK636Z9NiLGopnoH67NnLTAyVqNuQe7Vp5i+U28RLUrZQ6h13v6/u8lHgU1LACjWm6w2L2qqHhtPGgWcVmyQIJITtosljdLKnrt0m43W1W6rYHmN6KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397551; c=relaxed/simple;
	bh=XXSr47lZuyPp0LvA6TwoNnosremqe9aik7Zltfx51L0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=okcnKbYcwxsbpfbhZWj19aVlcwdzRVSoyyLO5kwVOxUsvAHQgeoQTg/58cpJq8cm1/F4q4MiU63vUUu5wZcKQ4BeCGvdH/D+DXcdIo95+uikCc8N1pYRDQG5ZvJVwX1pYZ7o/PGKwKa7Q/2FuGl9HJ4xf6pcIdOCKHC9C57HUz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=epfcJMtT; arc=fail smtp.client-ip=40.107.223.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Obd2Vov8HSBl35wZSC6csGHYwSnFNeV8WZtU4U0wPwMbb1Cs6Pj35caLY+WbOmg26s/WFL9Z5G5k99mH4ZuXqb85B+S6clktdUBAi3c7ChS8Bzj0SGhuGsRmqB7oUz/C/kDzuxV2JHah+J+jbEb3o1mxo9gREsOS54LFLjeYtgCjhVzxtCUf/CSoc5ZKfyqTKXlXhMMpHHgVt6RPAH1W1SsyNMGvz0VEgzgFASlPwRgh577GoHBfNVwGoHkh/mWSS/GvD4qhj8HXIR7ZmBPVKZ+k53lJU3OhSFLueGeooF33c7XFHLNkX1Zteh5zP8QvhjqcjpRB2wl8p51ytLGNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYuEwavJIzYwvNq0aLKMNvBleib425wGv8j5XBwP++U=;
 b=m4F3Ca+8G1P5TH4aCrblY1nEFm6Va5ScHmTNYrgqyk6uUIiDZC/iVqj6+7renlex3KAMJtRc462I4oEj/2P2f9uDQmY+xPYBrsohZ497tvMNHxQdN/ZCa+7FzscTNhF2NcdMaXbJwk2WB2nFooL3JGQYDtotb39o5sRMMJyZwoLnDkiOixUaVdv8dMg7vcITOT26kFcVqzKWF1/0M0x5mmB4+MzCXNx7kYeN4GDuLM1sGfiwcEV5o4Nz0/wmdz1dDmKEq0WN0wq7l05akyoQeSkTxylIJMgHMw02sgwfO8FkG9FdOBHJyRBSsmYhkJ6uMwsSWv5RVZxfqLK8jGqS/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYuEwavJIzYwvNq0aLKMNvBleib425wGv8j5XBwP++U=;
 b=epfcJMtTBCeo3BwW2rwl+vY0UX2Bsuzz2iY9bIi4OIQKVg1fcGYI3Fa8yzi8PdOsRyPfvm0kWAQuhGGhpNZyUGg58Q+M3UxnVnZJBnFmtCy/xvUZltH7CTrg5pmEMaUJhnS12+ikkAJ2wYX5A+GkKobHcTLrl449jY5/RIBBqv4=
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 20:12:23 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 20:12:23 +0000
Message-ID: <9e68a369-2667-4dd4-b715-ca1e13948a8f@amd.com>
Date: Mon, 25 Mar 2024 15:12:14 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 0/2] Update mce_record tracepoint
To: bp@alien8.de
Cc: linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 tony.luck@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 yazen.ghannam@amd.com, Steven Rostedt <rostedt@goodmis.org>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240126075800.1174583-1-avadhut.naik@amd.com>
 <20240208121013.1946ef7f@rorschach.local.home>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240208121013.1946ef7f@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:806:f2::17) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CY8PR12MB7265:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Ac7BxpOWpDUMyOdWGkPmekST4uqoBdGiaKv9di3IlIPzpOTx/+K2y1sZVcgVFHxnxlixm51a89OL7ayu8OrEUt6cEcd6OOXTjrWv25nF3F3KtoHbhZ8wQOZFiN0gurhW+H8K/YMHESBhMXFiKeWXVr/LJuw9o46sM3llcipzyrwvUIJUtuaqMw0FFv+13wBTUtd0ReYp1Q2dLNicn3xVn3Dhs0+DjIrcNRnjTASkzDZZabsiEhM8gmbJfx6Rccahimd1Yfmi0ILVUv9waDc5sD8/uIWorYIP5uMIFqRNRY7GvvOsvhzgQgKwyU7Rd9yuhHg4WVCLyNAYdaJJvXVmWJACmdScAOpilHNRsBnatP2TVommNgoYYzkFYphoQaCR0zjs57Vsw+pZh62FT9eYn+m8yIa56ZLPb4bIH4XKlRLCD63oMosXraByd7tcANbRaYZQ2C/23fvHDE2UdbmgM+nUkCdYo4aZcEO1kBmLTNn8JAJnKBdYOiKtFs6hIC1wYbHjomzHJO0hbkqhZQmPf9/KnrRa3TnQ1J4a9xKa4YMB3+MdcO8UgPYwE47ZsCn/cb5erwnckQxZzh4e2gqiPLRD5/3boYliH6wpBhvo1dMerlwWEsE0ZGFOIqMX0+TQuVzZtcnqFotXwO+iU+Ki9foJWQ0kZRsHudm/XPARv8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXRDcGtVdGNEME8rVkR1NEp6MjBJb2lzN2hMZ0dub0phaG9wTDBoWmRQK3VR?=
 =?utf-8?B?VGs5ZE96bHlRTDR3dVlNWnQ0aWNGQWhUUE1aV29OVWkxSHFwbFdTSzZITnpO?=
 =?utf-8?B?T0UvdDJzZjR6eERNanJnM1ZHTkpFdUpjNENKcXBhUUUxcjZHNmRxeWR5WnBX?=
 =?utf-8?B?Y0ZPVXNLYVB5ZHd6R1NrNUtqQzUrbTcySG5YTkkrZU1zdnliT2kwc3JhQXd4?=
 =?utf-8?B?QisvL0U5S1BIcXgyWUVmZ0N5MHJNSFdqSzNxRFV4YWUwQUtOWjdTZXVOSGJl?=
 =?utf-8?B?RGFtdFZrWm1uckk1MHJ2anlsOEMzVzNYNVVreGR0aWs5eWZyUTVCcndGLzMr?=
 =?utf-8?B?UDVLWlYvbmYrdVVjQXBreXU3Q2ozVnU0RmNQemtmMzdQTlVoL2xSQ0daK2xz?=
 =?utf-8?B?UmpwQjVaNWZHVEY1OWhUckpKL3p3VmFrYTZ1TlJzVEN4T0hEcFNKcFZ5a0hm?=
 =?utf-8?B?ZnVid2RDM0FNL3lIMHhOblQ1eHZleUtUQTExZkx3RTNwdHNtbkxRQ1k1amNK?=
 =?utf-8?B?bHcyOUR4dXhkUUR1UDVMVnBRMTR4RVNMWmZJQVpLOEhWWmx4MGtsQTJ1UG5w?=
 =?utf-8?B?TjE5MXdWVExkY0J6YWRMbEVXOUZwOVdjcmJXQkpKQVpjc1RuNzFqQkhZU1Va?=
 =?utf-8?B?WlZzTklLcnV4VEZTQnMvQWRHbGdXdUlxUTZnRjdORDZzWWlSOE5pRDBWZDF6?=
 =?utf-8?B?MHNxaFNZZlljNUx4eWNrSEdVc1ZHSWNQT3FOWUUybFlOb0VpSW01ZUxUOWZm?=
 =?utf-8?B?eVVmQ0E0bHFOcEFzd1FMclZrZTQ1bHBtSW5MbWp1V0V5Mm5YMFFkeEg0TGcv?=
 =?utf-8?B?ZGhtUldNUEFWbDdUcXNFNUJCT3d3ZFBZK3A5Ukc3T1BjRk9TWHR6enZ4QnZK?=
 =?utf-8?B?dHpnVXdWNWU4eUpWelBCVzIvRHhYa29tTnIrVHFrYXI1ZWw2aFJKL2hPUFNP?=
 =?utf-8?B?Uk5XUEtienp4d1gwVGh6czB4RzQ3djRteW1lZ0tCZ1R5dE1La2dhWW4ySEJ6?=
 =?utf-8?B?TVJDMmRmTmZ2SlhHTWV6b1hpZ0JWdTcybjF4MmhtVHBqVDI5N3FlQVRicWtw?=
 =?utf-8?B?MjRVQnoxSlprc1VpLytSNEVMSUYrOUVTM0xBRzZpdytmMEZ5WUYxMCtTTG1m?=
 =?utf-8?B?T0JDSkxwa3Q5c0lVNXdEbnpGQTd3YUx0ZXoyNWRlRVUwcThreHB2a0VOZ2Ju?=
 =?utf-8?B?dkpKTk1uRHZaWTRvV1FqZ3FNUUg3Q3FsYkhUd0xTTzExbVljOW9qeGN1NHV0?=
 =?utf-8?B?aVZNRjlYWHNTekMyVTNrdVNUcnJBTlN2V3BwV29Mb2tIRmZicXI3NHBuVEh0?=
 =?utf-8?B?b1BLMVc1cjNHTXlnOUZWdHlZZmE5K2hvNERLdlJPOU82TzRQRmtWMkozRmpM?=
 =?utf-8?B?bTl2YTlaYUFuMEFYODBjVW1vNDlBbExOVlcvdzFySEZoR2FKRzFVOEN0MHJw?=
 =?utf-8?B?OHZUM0sycFp4L0FSVE5jTkdXcWxXZzhLNHF6allvMkZEeURvdVo1b1Q5OHFQ?=
 =?utf-8?B?ZEI0eGlrNGpDRkltdzhFMjBNM1hGSmE5U3ZzaDlZOE0xY2pqWTlsSG9wQWJI?=
 =?utf-8?B?V0ZzWmxpeURObnZnZnNHSmxMNXhsODFTeTd4Njk1TDVhK3U0eU10TE1mR1Mz?=
 =?utf-8?B?UDVGU2ZZUk1tL3RjNXRsTnN0NEhzcmNkY1BkNjRHaE1TZStDVXFkekpoZjZ5?=
 =?utf-8?B?VDFZSkNVVjR3NlljOWFkZ1duS01qR0pHdmw0VG04Tyt5UVpZemlhWC9YRzJG?=
 =?utf-8?B?YXhLek5TQ1AyTnI3RGtPNmxBRWxEWFJtV3FpYUNKS3JqV0I3RlFVSlVDUzNP?=
 =?utf-8?B?UlVibUgyUCtjQ0c0M001d3h5VVdLUFQvalh1UUMyanU2NUNJSmlnalk5Tjh6?=
 =?utf-8?B?bEFadFVSRjkzN0Z4TEx1WTd6NGJkQW85Z0FLbnB4VllnTFlCU1V2OGZlbFk3?=
 =?utf-8?B?b0JDZU4yOC9LSGt0ZHNxYXVIbnFvWWszbnJzZ3VKdENWTUVMaU9tb0tKamdm?=
 =?utf-8?B?QWtOeFdqNVNYZVk0L3hhZTZFUXZXYno0V25zV2tsaVZiaWVOSE5xUkMvKzZC?=
 =?utf-8?B?QklxUUNBczVZSW42bk9pYXRmaUtVVG9aRXloYmFVL2xNYjFzWS9Sd2Z1V0tV?=
 =?utf-8?Q?JYJ9N7su7Bem/0DFp5u/6HZsy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a546452-6ea2-4561-7311-08dc4d07e1c8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 20:12:23.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNsYOOug1swQAS2twUdDcy9Fh5y8obWuuvIrACJuopsafUrdzOnWukU6W25YQN0qk+hC1e7xu3RNxOvsrUHjhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265

Hi Boris,

Can this patchset be merged in? Or would you prefer me sending out another
revision with Steven's "Reviewed-by:" tag?

On 2/8/2024 11:10, Steven Rostedt wrote:
> On Fri, 26 Jan 2024 01:57:58 -0600
> Avadhut Naik <avadhut.naik@amd.com> wrote:
> 
>> This patchset updates the mce_record tracepoint so that the recently added
>> fields of struct mce are exported through it to userspace.
>>
>> The first patch adds PPIN (Protected Processor Inventory Number) field to
>> the tracepoint.
>>
>> The second patch adds the microcode field (Microcode Revision) to the
>> tracepoint.
> 
> From a tracing POV only:
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

-- 
Thanks,
Avadhut Naik

