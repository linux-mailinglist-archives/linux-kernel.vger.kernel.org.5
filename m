Return-Path: <linux-kernel+bounces-131966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F53898E09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50BF1C288C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2652131199;
	Thu,  4 Apr 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JeLTFA5r"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2121.outbound.protection.outlook.com [40.107.212.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72F12D775;
	Thu,  4 Apr 2024 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255716; cv=fail; b=GKkHOiP7/SGXW6ZQyOYEjJu+zzxq9doSRAZmriobLevW78WdiJbVNsy630J/DlcJm+iK0hana7Hsk68E76yAOzBtRALVJEtlYCg0SGzRV03PSnedsicF2kvB8w3Xl/+qJpZOhxouqTpDc4pRV+eWgjbWT6CtKm677/feLgpXB0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255716; c=relaxed/simple;
	bh=va6DriWkW5SqGhDpv4+BpbT4+3DdaqtkyQZZrt8afNI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P8vBxY2gwMhc06Wbdrot3jTY+ms9tW5qZf/MyJhHRD4jjDAjjGkPdoJ3JBEv7T4z0NSMwWkp7Z0RocG/Gt8CiCWZnYENt96cMZFaMK6kL0b1u5hS+IoamhSAeNEIBa4pa+LpwgJMaiH1tio18FldYhg96J8Jht6hswO16wVxkJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JeLTFA5r; arc=fail smtp.client-ip=40.107.212.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMKfyrr1hTsZ0imnL8ePfJDPePpgR/OokTriLAFKqpmzF1wnsKFuLnI2jtgpOlbYIqMrC+Z2rErwJMP+9eWDYpr8yct5cl/1c9v3wvhRxl2BNhtTveHv1esgs5S8iTjUXWTnuwYHJddn966NccQZLyaaJReWclWqW4dD039BXsuWaaVmKSDZTWbxDqSKE7YM3VlJfZaMHQxEECz4OLeRgBWrDL9DwHW0SnpFKDyeRejMP/3lflLp1Gb0i+k+56CN+CMf9msrejRMw8ux5PVPkR7yB5Vs+xYmdgz4UDQ9EULcRYKLU3NClGhLaKRg5bk9DUUT3Civ7EbBnAk9Y4zLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MtSJDkNT162Bc5l6hLKDqoYxFNdz+1uRgtPNPRumF4=;
 b=YSU1/3ZCQjrYrHjvVaziP4q9E9vNvAjIkCBJCE2heS6/9uifKsgAqDo7F6MZd07ScpgnlYfIRrIUMJv4/cimJcfN7O645vtT++BX4OkJqk72LLzrikFmQq76QVbysfHiDnoV1G+VzuJfIB2KgMBnish9C49RBJlzIMLS6mxwlMD5AfxfEauyuGuwOE2qcHQfFLOe7t/Q+69vYjlDElUxgaHwQy7KqGkNfJ7uqMC/S3HtcGoCcHKBJamAyqLJGpOS/bG9brGJej8zwp4/4eWggPbOLYh66ZKK7MNJzN/uD/nDZbovVAzdEwccBrP6TlIZMVMsaAGXILHcN10Inh1ZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MtSJDkNT162Bc5l6hLKDqoYxFNdz+1uRgtPNPRumF4=;
 b=JeLTFA5rwlKANjZXbDMWTlqmq9QpnMvmRam5k/h5UsLqOaV/UH9/dVXgEakkktCdeuwPO9Dl/NgltEkKOLGyhyRyKarJVN5mD3VgGa+Rh45RhyDMOEKJMDbKLjIgGv7TvVTrgvc4jsw+/48BrIceKFp1hnzjflGVzPzK2nDpHLw=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 18:35:12 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 18:35:12 +0000
Message-ID: <b2fb5b9f-ea5d-4dc6-8c42-cd14c90eaa08@amd.com>
Date: Thu, 4 Apr 2024 13:35:07 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 07/17] x86/resctrl: Add support to enable/disable
 ABMC feature
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
 <0db75c94886da62b8da498ef159d8fe27b0b3811.1711674410.git.babu.moger@amd.com>
 <CALPaoCgRtYLnzpkL6uVjb+LvBbxD8ANRuzACP1UQ=rkzk8TCqg@mail.gmail.com>
 <a7e7f220-99f2-465f-bc36-aadccb891190@amd.com>
 <CALPaoChsU-C6fhjfLFEmxCXCdY-0PL-Hk4pHYs=TZ9PN6UFexw@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoChsU-C6fhjfLFEmxCXCdY-0PL-Hk4pHYs=TZ9PN6UFexw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8719:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LPWQvSlHZeStcSFcneLyZGOvV/AH3rfE0t30vR0XtBfqCwp2aYKLKoBbW5/w5bN1PXot8XeO174/EB/F7G95KIQbCdLhQfB8IpNyUKGmt/MmB1Y2HDc6AKyJOcj/ONcnrXgY/z+q2mxxSJWG7ADHhON9JZF+Oxc2zfT06JSLJ1jAxWRL/07HGGGKshHAvwfuKRtFiNZeJUdGNM+mQUxgyPwvwW52/lx116BzEP43K4Z8G0ceUlF65pK/ah7XUxwZ7xytNF+nUsWV1PR9GYzChRdp7DDfpSQ1zHsCMK0F+LnwfPCvaLiFrVtjpWKmprMMyL4R3JU232upX+yjHhE5RfdswuDvPLsn8uhfshMW4u3cKO09fjCKFib7vXw9tAJVyGADq9YMhykVaAWe/8s2oF6VCOtd7I3QPbyO50mqKJOitrlEUEjkTTz84fmnFfcgCzOcBECF2zQ31vGhjS8jh+gkhUlv9jbO0EDInKWHfsaYguYVCEDGhoSnT9AiQki+sjhpE9RhJk5Z03DZ5HwdMrU7NmjYRl1m8I2R2XzpomSMcE1O9OLRmp1UtrCJqLemOiAZ5N6s4R2FhrPRe0aqlpMvXZieh3d64HOvKH9INOV+0A1KIB8XWzhynaxU8s6lO8n1Ot0AreB/JWUYACRtN2egPkRVLSGcU2V8cANDJA4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmF0WUpVQ3VOWVFSWFQ2SFhTSHJIYXlKQmFEWm1GenAwRXVrakR2aFRWKzdi?=
 =?utf-8?B?Y01RZWhQZXBnRWpMWmxSZ1kremtuRFhZb1cyRnBKM0JPNldHMTlET3NwSkgz?=
 =?utf-8?B?NSsrN1ZuV283TFVvN2I1VThCbWZUVUUxNkNVdS9mcmlleUkybVdxb0xaN0ZH?=
 =?utf-8?B?VDNzL3JodmFPNlpZUitibzlVT3FQWlFuTUR6aExLUWdHbTZEbk5sL2ptcmtF?=
 =?utf-8?B?ck9PUW1VcG5jNUx3VDFESXhCVzQ4WlZIWVF1NFVEeDlxazBBK09RK3RFQ1RO?=
 =?utf-8?B?dEE4Ynp1RmRSdVVFSUE3Mis4M2RXZFRJY003Yk5VQnc1SmVsSmV5dzBReit5?=
 =?utf-8?B?cFhQdmk4K0FQcDd4WkRkRlBDcFJ3eGU2ZlpSRmlkVDZKRWgxbzBQWHllc2ZV?=
 =?utf-8?B?TGFZUml3bFV1ZVFubVY1VytCbmRpVFNheTM0VTZGa3MyaThjbEQ0d3p3YmZW?=
 =?utf-8?B?VGo4ZkZyT3Q2SUZnSlhxN0psNndTSDhuN0VrUVR5QWdFZkU4NmppODI2L3Iw?=
 =?utf-8?B?L3JHVXFmQldVek1iRjUwMTVvMkJTenJIdUZlOTM2UUJGWVJxamNtRUJwZ0ll?=
 =?utf-8?B?YXRKek9JRWtneGgxb1B1MG9IMlJxRmRZQUNtRHkybFJ3WlFtZDhTNkQ0UGlp?=
 =?utf-8?B?bzRWdFFDK1F6V3AyeXZMaXZ0NGJCNlNmTFRHa0NRYmR4SjhDSTdaZE1Xbk80?=
 =?utf-8?B?azdHZDNQTERUejBDMjduMjVBbnJxVk5Wa1IxWXdpZXlZWUNmVTJXL1ZJcml5?=
 =?utf-8?B?cXJnRVZUbElCcVFlZkhoMnlmZXNJQ29GeWFVREtXYi9wa1BaR2JxRU5mcnN5?=
 =?utf-8?B?QXlwUHNIendJQTd4TXVTZVBONU5wREVVZUp4UzVhZDRKcVdRcHBoOXhQK2Fi?=
 =?utf-8?B?Q2phdjBxNThlbWY4SU9RM09ab3J2eDVmUHR1UDE3TEtaNGV1enhKeWFHMnZU?=
 =?utf-8?B?b3QwOHBBNkZ5S0dKMHZsZm9BZndWd1RzL3AreVpNaWVPM1JWTjlXYUFzc3VP?=
 =?utf-8?B?dnNKa3NZdTRISys1ZFlLWGkyOXU3dFZhaHpvQ2FlcWVLL0lFMlNjS1VLSGEw?=
 =?utf-8?B?YUhzSVFJcExmczk5eGZiM1d0YlhRYStaM3phejJHMnZHNktUem1xOU5rUExz?=
 =?utf-8?B?OWhsWVc5MGlDUFNYWU95U0RYNEFKMTI1a2JKL2pYM1oyOTFQc2RqRzVxY2JM?=
 =?utf-8?B?SWxSNWFkT0k0SDV4OVQ0c3E5RXhLTExlVzN0OE5FRkNaTGk1eDlEZzRIeG1x?=
 =?utf-8?B?SVRQMUw2aUVaY3orVnR4MTJkRlEyRnZ2THd4TU5ZMjliNi9kYU9SZm5aZHBo?=
 =?utf-8?B?Q295T2lxZmd5OUxpdEc4MmZoZ09YcG4vdzlnSlVjR0dXbHk2NU9xdCtGWHF0?=
 =?utf-8?B?NTZzcVhpSHJqUlhzSE1WMGJwZ21YQ3dtaktQL3MrZVlxZS9kbHZDa1U0ajVP?=
 =?utf-8?B?Q3lHTnk3cXhDWlZ6VXZOWWtGQ1A4aWlRYzVsS1BXa3J0V0lITXBBSGVZRHB1?=
 =?utf-8?B?QkIrMmtqRmdNUDd2M2E0Yzk0WTZxdUJiM2kwL2gxZDYrVUgvYkY2WjlabVhz?=
 =?utf-8?B?TE0wR1NLME9tOFdpSVlhRE1LS1cvZjBTcFYySnFkMUxCTGlpSnpadHJkQ0ty?=
 =?utf-8?B?UmQwMnR2d1pFLytrRUF3SVdMc2pFTWZYOFR4UTFCbUNJLytlZjM4MStiMDYy?=
 =?utf-8?B?WS9FcHpSbVNOMTlZbVpzcVptY3lBcS9QRlJJSUpyd1VNU2hoMGVzUEJrb3Jy?=
 =?utf-8?B?MEc1VFQzWWNmRGpIMEFDckNUbmlGcSs1MG5rdm9ma29Vd2pWNFhNQWNaVTRp?=
 =?utf-8?B?Y3BOazFBb3crM21TL3pkenNMeXdVL3BmbkdVdWJtaWVkUzNzWnFlL1JDMG9t?=
 =?utf-8?B?VStxeDdTRTZXLzlYSnp6UnRQOFFORmJiaW1WbUlKajBVU3A4bzI1ZkNsU2k2?=
 =?utf-8?B?NlNkU3d3L1ZoOFpyZW1SdCtuUmNIWXpxZXlhMEJULzMxQlg5d1J6cm9lUVdp?=
 =?utf-8?B?TlRkMUNKTzdObnNtVGJ4TEs3L2RhY05SVTNBMWhieHFqcHA5dy9ybXozSE9P?=
 =?utf-8?B?RjNwMGltZldIRTByQXlSd3hjaStYUkdQZmZ2L2RUa1FsdlRpUVluWGFLUExu?=
 =?utf-8?Q?Rpec=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ba6ab7-ad75-420f-dec9-08dc54d5f691
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 18:35:12.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +y6o9/g+Pj8R2eWUFXXspYk+Goyq57Vn/A5FSNKLDxCd0Oo++yDPLDnSJ0ylcsZd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719

Hi Peter,

On 4/4/24 12:36, Peter Newman wrote:
> Hi Babu,
> 
> On Thu, Apr 4, 2024 at 8:16 AM Moger, Babu <babu.moger@amd.com> wrote:
> 
>> On 4/3/24 19:30, Peter Newman wrote:
>>> This looks like it would move to fs/resctrl/rdtgroup.c where it's not
>>> possible to dereference an rdt_hw_resource struct.
>>>
>>> It might be helpful to try building your changes on top of James's
>>> change[1] to get an idea of how this would fit in post-refactoring.
>>> I'll stop pointing out inconsistencies with his portability scheme
>>> now.
>>
>> Considering the complexity of James changes, I was hoping my series will
>> go first. It would be difficult for me to make changes based on transient
>> patch series. I would think it would be best to base the patches based on
>> tip/master.
> 
> I don't need you to push the patches to the mailing list based on
> James's series. I was just asking you to try building locally on top
> of the refactoring changes. You are putting in the effort trying to
> make this code portable (i.e., inventing new
> resctrl_arch_-interfaces), so it would be sensible to check your work
> locally.

I am really no focusing much on  portability in this series.
I named it to match it with resctrl_arch_set_cdp_enabled.
Yes. I got your concerns. I will plan check against James changes in next
revision.

> 
> However, I am the main stakeholder who cares about MPAM and ABMC
> working in the same kernel, so I can continue to give feedback on
> portability as I compose the series' together.

Agree. Please continue your feedback.
-- 
Thanks
Babu Moger

