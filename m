Return-Path: <linux-kernel+bounces-137417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ED589E1BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474D41C22352
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B025A156868;
	Tue,  9 Apr 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OEMhA1Fu"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2136.outbound.protection.outlook.com [40.107.223.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6D15667A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684659; cv=fail; b=SNeXEngdCwUsgXtIw4O7IsenDSl6OS7UaHGZlfySjSSVTNQ/dryIXTmNhYglqQnrq9lbR25JirzyiJm3IXHTLMard/4NFKSI5xDu6UGPO5zYU1PmBTIevY634sLeCtndykpVJ2RNMA3dv8lo+z6l3d2PQUgYT+XLX5wVAqqyxlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684659; c=relaxed/simple;
	bh=7JSnL0bvPzKZzE9Pg7ZBqS6B5/4UA7KhUeoVgpOQ9ME=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=FyVeRsl8JrDrQ4f7U/7bdNsRcVl/uw7zCJK/AFo5ZC25X/jwxNczyb/RBnMFZZ/5NKTOrQkfxM5SbsAfnPFtI2guU1Min5WoDJgUqzf/OHU6f6lacL9p5W72rXy/pY8xbCYmMrYcrBUbrKkK+i1aTxvt/wkesPq0AUT5dpC1Rdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OEMhA1Fu; arc=fail smtp.client-ip=40.107.223.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elSfvWAVVdh5MH7HV8WrTQXXNjRxUlkBSiEfScylNUfOfHqIgQAJB8QTPF5QZo8rTX4Tn1wT/m3d8BvICPgQBWpLXwIrtiNz93y8sj3WcqDz6A5hcQo+xXEvwKHCJzmcoJHb7gHo4CbEK9qhLpzvoPqq8tDOn7dOPw+dZdJr4G32E+mkiflzAnjSAAF1chdUbIHF1TkbuyPrGNdUl2JNXNf9TuDZl4SMlHHRtPSxLzkIBEvWb9GaDqQo0XO/Quf4RERbL/vddp4rqX+KOHFz074nI1wITiJLJXhcqv1NoR3tMwtXsPHZgAAWyTXL96NA+VgNmVc+pE4Mx8g+5yL1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIaUEgUWz4Rg0Lygka0iHiu4LMkTxpIiGLjzakT5xRY=;
 b=Rcghk8seLR34FaJm0bwh7ttAt3FiNL3py7MzDAbfBPQmvw6q/K6wcnPVIdaXUYs0ZYSg1oJZVhxOkyLor/Cm+PHJjvztF6XFOpGy7wMn/OVbsdWt26PKpg0eqRbr9T86kk/JkQ+ZIugot+B/Xk7z6P2177VaXtyNREom57Qvc6jF991wUrTYRx63GbWNyKKQMkq4T6vhPH9KQCG+W/tUCVwFtWLy8KTkqVYsRgRf0sWIIrQwtYwUmGqjsRjsNNGcvm2wAXXNRN50l/dQpiictavQQN3tL0kqQMN/e8+oaAEptfR/FdbbBGYhFqBgB7dmE/BtZ+euHzo3li7IjZ5uVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIaUEgUWz4Rg0Lygka0iHiu4LMkTxpIiGLjzakT5xRY=;
 b=OEMhA1Fu2U5p0AngDwWVIK0ZtOF/8QZwaiCgBu4gS3hJOBlV5xSiB4oh6iiw9c1T/e+P0MY4U2GShrcXtefbR3SQY4lEYMbIjf48xTqHSCvGBkF4msrpsU7YpKkh6DIucrP/Yk9OnsjIhGGkEDYlFmf8rWQ5L6GODCHJYEnHKkY=
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 17:44:15 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 17:44:15 +0000
Message-ID: <ac044150-ffb1-09b5-1f36-fdd6e259ba59@amd.com>
Date: Tue, 9 Apr 2024 12:44:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <425afa6512994b1ca1bb366eb7abfb24d65175aa.1711405593.git.thomas.lendacky@amd.com>
 <20240409170917.GCZhV2PWPhmzTHhMRO@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 01/14] x86/sev: Rename snp_init() in the
 boot/compressed/sev.c file
In-Reply-To: <20240409170917.GCZhV2PWPhmzTHhMRO@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:806:d1::7) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS0PR12MB7927:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y1rG7f5emSt4b5fWpTKJvCLnWSu6fRu1skjQdG5Lqo98Q30OVLZK0SauY4VJo9kleZ62tyjTjpbeuWm47cbvSxoMu6qiovywl+fQFQ6MAY+LcIJ0K60ndcgjFSUh1ov80KKcyQGotUvt5IVw+2lUs+/SF9s61uUv8QYQapdGJse+DVQqBUSkjEzvrtxFCIKkHcltUoTmf2s5CCzzFLo1nyUDL1Af4Qi6SzmAqcjrqsLOi7easH3FgRgvOweSEDw04A9nVrebD7WE5VrwQ/7xpRYT/Z/Tb5djRqqa6TVDgx4OAJ4Ufa/2LTuzm6jydFSvReRl1utVXLztL8xzLfAx2hX4FLNhgE2h9szRXTq1C3GnPwmdhacsMbm7UgSQ1filYN1ijECYb9MvkngJ+CdCM+VC6bmJkGMyaUgWPl03tLZjXhPZVfPtaXt6uXyhf4403R4GR6mbX+WetHacTt64IwBAIL6p4kE0qb0YEbwGJgBgQlg1+CTqzX+OrEqwMNald7FGi9NCU272T1zBzTKx0I+esp25Z0DrlgRmmceXNRNMBlQyuHYnsh1l8SeBH8UU6fSgLkaJBx1OlTzh09Lqw8rj00q9ftsTES5+QOWULjzD7A1K/Za0XvJ8AidTbcTJoDz5MxVQWEg1eRWent55phvJXmpYHl8OV0ZHbc5sq8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2MvRzBoS3hzR1NqdFFzVW8ydVI2UUNVMExkSWNxWTR4eTdYK0h3L3BETVM3?=
 =?utf-8?B?L1pQdDhzY29nUUZuMVJ3TWFZQlF1UGt6a3FGbDBXR1pkMUp4RWttU2hQeHlE?=
 =?utf-8?B?ZW41UGZ4czNTSGZoWDBTdFdHb3hLbXV3Z1p4c0daYldNU0U5b3d4YXVGVXN2?=
 =?utf-8?B?U2o0a2E3ZHduemVIMFhNYzJ0ZGpqUHBWNUtoVGxEbnhxYU0wY1Zybk9TQ1Z4?=
 =?utf-8?B?L05pTlhzT1BlbHhSZmxrazJ3VW0vNWJYalF6c2xqSUFSdU11Uk5INDJLd0xK?=
 =?utf-8?B?aE9kTHg1L0hucDNSMFRYREIwRVVqem9HcWFJb2ZlUUxIdkp2REZzaEoyQUtr?=
 =?utf-8?B?TEd2RFR3WWR2WFpXZEwxTHdUdTVUQWcvcmdRWmhvUnlFdVFIK3JkeERraVl1?=
 =?utf-8?B?QW5wNHViN1l2Z0FjNkd6dHVNODFSZkpMMHBOQzhDWXM3ZzhZMkFwU0RVSjFB?=
 =?utf-8?B?Q3Q1Vjhac2ZuMHl3bDA0V2xoRDZrMUgrQVFKZFpwdnYzai9qRVdlL1lsSDkr?=
 =?utf-8?B?eTFEODR4emJ5OVFyOWpEZlgva1hLY1BZaFlNUm1VMURvbnpMdTFKYzUraGVR?=
 =?utf-8?B?KzJ0ZEgvWE4yWDYydFViUmZyejdFRkgyOU83bWthZFFGOHBRNEU1SUc0NUdu?=
 =?utf-8?B?V09UcG80QlZSZ2FGQzNzdFJuUDd0aE5zQWNtOUFyZDFJNk0yZnRQMTJ4YlRq?=
 =?utf-8?B?OVVZUmpiTGo0MmxTTXpmTEYxWHZZTS9BY1dkSTY3RkJCNzRuZmIzMHhoYjZ2?=
 =?utf-8?B?WGo2aXFHbEJEdXQ2SEpzNG9JTCtqOVp1N1hOUmhGdHpNNFJITGlOTjFkS09X?=
 =?utf-8?B?ajdMd2UvUFUwTStncVBVMzFrTDJYMVlxbUxCY25OVkFNZ1liL1pWTnMzSWhn?=
 =?utf-8?B?eTlDU0hPcnZ1WjlKVU93N1liQkoxck13Zmk2dkZOampHUDR1OEVlY2VnaDUz?=
 =?utf-8?B?OXZDcVJQVnNmVmRpbjZRWmFpWHBqaUE5YzFoWkZuSU1BVHBuYUhUM1U0OFE3?=
 =?utf-8?B?Ujhmb0lyb1JTRmo0Y2g5VXdnRWw3Y25CU0hYQmNRZTJYQ0U0UlVMS040L01w?=
 =?utf-8?B?YVdweHRWb2JNRnZoc3ZzN2F3YzVnSXl5QzRJVjhydXNxdXhkNWdDUXBhSlk5?=
 =?utf-8?B?Y2QvOVplQTg0clYzRERsUEg1S2c0dVMzUVA2WWxmZEZVencrSU9kSXIxdnlB?=
 =?utf-8?B?Z2pQYTh4UFgvS1Fpc3o0ZGU0OFRoT1JrSmEvTkUrbjhuZFFYaTk2RWFsQ2RT?=
 =?utf-8?B?dVl1Q0R4Wit1V3ppZ1c3VXNEU3pnRnBNNEVMWFpwTWpuN2taTFlGc2hqdVFJ?=
 =?utf-8?B?dmhYRXJjWmRiVEdGczBCdU9SR2pRL3pvVXBJa0NtODJKWWE0MFdSejBkWmpG?=
 =?utf-8?B?bXJFMVp3QjJXb2VRQjAxeGdwaURsaTI5TjFzLzdZZDFSYlJicnpZVXVBZTA4?=
 =?utf-8?B?VDlIOFZjY2N0QXdYVTBMR1lKTlFPc0F4cmgwZ1FtTzhEUXBYNzkwdDdNVFU5?=
 =?utf-8?B?NUhzTHM0Y0xuUnJvWlBJQXg1Y0hDaWN4em8wcC9ydnpIWEF4Z1VyWXduSzlq?=
 =?utf-8?B?cWxEK0g1WWNvYXlBd1lXL29VVU5ERW91NXZnYzRJTWRxc1owT0lkYm5hVTU4?=
 =?utf-8?B?OFFpQTlXRTBWbVJtaTcrY3U0Ujkyd1MzemptVWZySG8zdStsZG9LSnhWQTFk?=
 =?utf-8?B?cUtocTl1NXI4dUNINHlPdHNaYlpaMzNTd3JrbXFUd2VZdUVHSExqNzRlVGRZ?=
 =?utf-8?B?UVNHWjVuNFlqV1RKVXo0UlhwdlJ4YkVlRllOMEp3dDZzdW14UUZEOG1Fa0li?=
 =?utf-8?B?Mms2VXhCUE16NlNHaExSaUpmY0FYbmhvZjdFVkpLMzZRa2o4QUVNN1dFNTZt?=
 =?utf-8?B?bzd6enNwWTdGalVPUmh3SDdSM0FrcHJTZ2hRU0MzR2ZBdVB2aDBDbXNCWlBW?=
 =?utf-8?B?blowazZDR2xXNEdPUGRPUmhrVUorWVYzeERmckJ3dUN1QTJxVDBvRERnYVJY?=
 =?utf-8?B?RXl5bGl6eVBTcjcwMHU5emI4Y2dBTkRRWVFseGdiSVBpZ3JSNEJZdC9jQ1Ez?=
 =?utf-8?B?YWloZXFFdUU2TjMwZXVSdkUvTEszeTgzNHovOXZXY2YxalJidldhMUxuOWsy?=
 =?utf-8?Q?5022k7WZrSeQ+uM2+3PyUk2wF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95199ec2-cb09-4091-7dd5-08dc58bcacc2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 17:44:15.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t41jwU2dXTEVFTAiA9g/0LqxjHKaryKajj9pNNEt07xOwzqF0qzkTGgRENd+uhN7rJo4uQsjOxtt4Z2e42Wd5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927

On 4/9/24 12:09, Borislav Petkov wrote:
> On Mon, Mar 25, 2024 at 05:26:20PM -0500, Tom Lendacky wrote:
>> The snp_init() in boot/compressed/sev.c is local to that file and is not
>> called from outside of the file. Change the name so that it is not tied
>> to the function definition in arch/x86/include/asm/sev.h.
> 
> That part I don't understand: I can rename the function without making
> it static and it builds fine, so where is it "tied" to the function
> definition in kernel proper?

When it's not static and has the name snp_init(), then it has to match 
the definition in arch/x86/include/asm/sev.h, which is really intended 
for the snp_init() in arch/x86/kernel/sev.c when called from 
arch/x86/mm/mem_encrypt_identity.c.

So, yes, changing the name would be enough except then it remains not a 
static and you can get a compiler warning about not having a prototype 
for it if the -Wmissing-prototypes option is ever applied to that file 
(I don't believe it is today because it is in the decompressor code, but 
that can change). And since nothing calls the snp_init() in 
arch/x86/boot/compressed/sev.c from outside of that file, making it 
static was appropriate.

Thanks,
Tom

> 
> Don't get me wrong - leaking kernel proper symbols into the decompressor
> has been a pet peeve of mine for a while now but this is not the case
> here, is it?
> 
> And yes, the patch is fine - I'm just asking...
> 
> Thx.
> 

