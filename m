Return-Path: <linux-kernel+bounces-67305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D81785697D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DB0290BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830413473B;
	Thu, 15 Feb 2024 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YyMAqsfM"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CCD134733
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014312; cv=fail; b=LZyzeCl3nFVEKCzNfhfYLOs4+TyVwjRkNSN1vron5S85ndiSdraUD3cd7zjuuaZEUgVsb0Yc2mkmAjmLA1xyzIO491n/buB9BrvrwOn1N1Cdlpng3UwqB3c/FDHAtf58Pxc5EIBBJazK82IuPru3+zz/0znIswo7TeU7ub0GLuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014312; c=relaxed/simple;
	bh=aUuWaN35K46LvZG416+WEQydCrI3kPiM1wLPbkMWsRQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g2S8uL49An9vYTFaLDu1PlFWBlyq8H6f6jupydaMv4XieSU5W/9uhlCK34ysEqysDYIvVOSxu81pfa7XLNCdBxp9R1AUnLwgJpCXxUzGUjFRP7ooZhElhhit6lYw0ICwMcwBAVlRLL8a1JxVvXtNMrZRbv6BuJgiEevv+LQXBT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YyMAqsfM; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoL/AG02L7CkjmqwNQspnxAVjo8dizP+v8gCaDyE3nLfCwYDWGfra043qql1h2BxHqBg0qbpJNRL9hp/5zj5KH1pFiyLv5k/qN8c+VJSZDgyTBWJRmGsVkzYAm+K3syXH1GGb4S6FTm/1YchVDte0t92fVTmEINvc+ogpKoQqHoTJOJH6Ia8fRrC7CFgqPw0v7xG5nQqaVUQ/Sqbs67Nngs2vOJnYACh6GwlgoY40z6AW0KtcGOAbnNQeAmNqhXpVlGz7XnZ8tT0YKwdwYm9qlBeUbhdH/fvbEF5ILOuH64qQ9oet46kS4aVcStx7bbDwiCDEuwlzdEmBJNAYnagww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hwMSDle5gSWOIbga3WTQmkgdR4PZIPpwUWvSJ4cgSk=;
 b=Z6IVy94tmWHFjesdnJjB7hloY0c+MBRPan55izgtrYb1FJPQLcfCQwu7h4YgPAL8GdK/Ff6dzbMoP0ga78unlD49E57vnR6LnO5uecOs7Q+qVLAGv+8J5uL4bG+LSywbTbb09xkhTVa23DEZVS1AXnYuLKXNUvwtfLw2A2PCvDRc0uPOheMCl6t5HuXH78TBeFskUEkdcO/cwtifvrI7E1rfA504tOjajfIqBFf8s0dIrXPl3qZsOU1Ion5h/4J9QvExewL7St5HGkmkD/pO+1r8TTuzMxt1fG2EYpYynO8QNL/duIupayYUEm6sedRfyjBHj6FblKCyV/SuTthiZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hwMSDle5gSWOIbga3WTQmkgdR4PZIPpwUWvSJ4cgSk=;
 b=YyMAqsfMSAdkFWX7J80YP+h/wevWUgdHfBOln36DSMUA7/OxWedV8ML5fLEVq/nx3OwU0AlieZ99fP8fGLgNv+TAu1MG80+6Ams6sjmYYJ2+ku4awRV1KPMxfIl5mHjW8HBucxxLV+jxEeASCcCd8THSdGxP5TNON4UWLb2VhA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Thu, 15 Feb
 2024 16:25:07 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d420:5e9a:1eb:701f]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::d420:5e9a:1eb:701f%3]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 16:25:07 +0000
Message-ID: <ff44adad-5be1-bef4-098f-ee363fcfb08e@amd.com>
Date: Thu, 15 Feb 2024 21:54:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [patch V6 00/19] x86/cpu: Rework topology evaluation
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>, Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>, Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20240212153109.330805450@linutronix.de>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20240212153109.330805450@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::19) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|BN9PR12MB5163:EE_
X-MS-Office365-Filtering-Correlation-Id: f159ab97-e4f8-4634-ada4-08dc2e42abe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+sfnZddAbhV98T9jlz3U8xeGqg5VGYHuVhKprnm7plD0tDncgQXGmvP+tlcOvYkiHqONtLSwVJmOD9X9ggk5FRALYZYqv7PcRYSPjqpKiQN62ZbBBCp/Swb3PiHjQsdAwU31FgfM3X7wXupBteORg7QF4ahp4zOE82uptGPZH9tkl6hvO7ygB5sB84UEyKPBmp+x41sWkNl9QhVyU1Bpb1C/RG7Ep/VRYNe76vyg3R2ce/+DKWKG1xpxnoGOdcMl3eoS+VwNpXNXjX2fCRl05/qpfSp4xB59QoYOhup473ocexR6bUo9pFWHGcw6q/yKw8+Cgo+nbwwYrdH5xFv5pr2cTvm3JXkdrREjzdLUrvHP7NRyK3cn3LXj/G3P5paGKnIVQAUumgIN2WhsCkKPE80f5ZrpP+X4egGSdkRWzEVycMH0HZfy/2mDJJvXWUDWC0UxywTDegSdG21ylSKNKs5WEXvAFgKR4Wz0j6ZqCJK104AC2AolktaSLCxCZ6qTq/G5Ts8nS80KpNC+fFRTiq17CIh5sbp0kzz0juypNDg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(26005)(41300700001)(66946007)(83380400001)(8936002)(8676002)(4326008)(53546011)(66476007)(66556008)(478600001)(110136005)(54906003)(316002)(6666004)(6486002)(966005)(6512007)(6506007)(36756003)(38100700002)(31696002)(86362001)(2906002)(7416002)(31686004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0ZtSWkyd3NhL2dHYlpDSVlhYTJsR3JxUXp3Y3QwQklIMUNHQVE0R3ZUbmpB?=
 =?utf-8?B?aVF0OGFiQzJhRUdlSHkxcHEweFJQeS9xOW5hOE9KWXk1U1JxeWxMNGt1MkRI?=
 =?utf-8?B?UytOc0NEU052UWovSGdFaDNldXFubGZPc1JuRTVwN2daQTBpdWZuK3hVUW45?=
 =?utf-8?B?ZDJ5MmR0a2lXSkJmV0hFV0s2Wm5ZdGlTbkd1dUk3K2Mzb0pDNzc1bHN3L1p3?=
 =?utf-8?B?YjVvOHlqMWRXOFg5eXRoYVhYaW9hWC9idTVPSmN1S1drSVVpMTNxckc2dm95?=
 =?utf-8?B?L2VDVDU0U3czT0cxb3h6eGMvNE96ODRqb1JHclFtVERuakUzSFNtWjIwMjBv?=
 =?utf-8?B?bi9HaFVpeGp5VFhDbGRQTFRpNDJoTFAwMHV6QXQxekxkZTNnY1VzTFgxN3Fl?=
 =?utf-8?B?bk9sNjVWMCtVVGo1MnVGMU5pZHh4YjlpYzFQalVLVysrWVoyUDNsMmhKMkFV?=
 =?utf-8?B?STQvVlNLbnFKNXZnUzlVUzFkZHdnTHBxOHNwaWdHNmxmeGhaWDFXaEduL1VX?=
 =?utf-8?B?K3kyZ3Zvc2N0b3FNMUZLK0wyUVdBTGlRUHE5MkZPd05LY1U5Z2dGdnIva1M4?=
 =?utf-8?B?WXZIRk9SMDlDVWhObEhQMXN3eGtpc01WQmlKbmhuQW11UUpzdUdiTkd1S3dB?=
 =?utf-8?B?bDdEOXBXekl3aDZWRE5FYTNBYlVYSXJzSEt6c0tWSGVsRWhYeEswZ1B4dk9Z?=
 =?utf-8?B?Q3l1QnhwaXhFSkxaZ3RNekIzRGdRcC9JTlk3emJUZFF0UjJUbm55UmpGVERl?=
 =?utf-8?B?Z1RjTU0xWURnTUI2RzU1R2ZneVZxWUxNeGFyYm5IMEZWdVVXTlpqWEticEZp?=
 =?utf-8?B?aWF5d0Z4bUNLMXk2SEdRQnNVbWozWmNTTEk0a0t6eXFGVHdEZTc1cGVhT3ZN?=
 =?utf-8?B?S3A0ekVGc2xJR3Fld0YxYVZEc0VvZjJ0WWtnQUJ5blJpbW0vc1M1WCtDeDlV?=
 =?utf-8?B?YVg4UVorVTFuTEN5L2VoYnhtSDh3SVJtYThWMU02d3JSTWRDajRHMjdnVGlS?=
 =?utf-8?B?bk9kdlNBYUF5L2JSbm14bmtyeGE5Q2NoZmh3aDd2RmNQQk40cG5zdEZuWTdM?=
 =?utf-8?B?enRyYTJ6NFdhdHdnR0pVZVA0RW1zWnRIeU51aTNMUmZlOW1NQkpubzRMZ0dl?=
 =?utf-8?B?K2JWYVRCTnlCbWs3YTJtcW0wM0VhbDM5SnN0NFFYVkZzQ21TU2xjNnFmYnBl?=
 =?utf-8?B?WFVjT3FIK1RWdFNGd0duVHpTKzBjWGR4a0R5SXo0RWR3dFRXK2tPSFlGTGtL?=
 =?utf-8?B?UU10S0J3Wk1iQWh3U2JCWkJYNmc4aFk3dE5GOWpTUFBoNDcxOFFaYUl3OUhz?=
 =?utf-8?B?OFN6THBtZW9FeHRkMHJtMVdGUDdBZC8xbm1hM3kyMlEzQS81V2lJQnc4Kzhz?=
 =?utf-8?B?cTErQUljQWg0eURPNnhiTFp2eGtQVnBBNEpsOGVDeWk0WTgrWU5la2xpOWpn?=
 =?utf-8?B?MTM4Q0VMNkhmNm8vcGdpN3hMNGFFTXltZWVrNXhzWWdoUWlwdnZyM2RGK0c2?=
 =?utf-8?B?eXRhZHUyWGQ4VjRoYVB4eUR5c2o2bWFQaDZTYnA2blpnNm1BOXY2YWFFK1JZ?=
 =?utf-8?B?KzhrZFV0N0NXU2hyVWRtdCtQNFVPbUY3ODVnMUUwR1JPdWdEZXFFeHdBVXZ5?=
 =?utf-8?B?OFM2c1kvNjlUcnZnL1Irekp1c1VuOUpCV00xUDNNTjRSYkF5aG1wRVhLZmpn?=
 =?utf-8?B?Y0ROZWt0Ym95ZlU5SjFVNzkvSUVka3U5NTBWMHBOdDZWUVNHbER6dThOK3Vr?=
 =?utf-8?B?ak8rbC9LWUJZN2hRTUpwZzJBdGhFV1JvSmtHcnQwR2MvdEN1VitzV1VXblRp?=
 =?utf-8?B?MGxJRndiaWxwRDNRUXFDTGduN2ZWT3hlcEluekhkdTZONzlwd2ZNcmo1OWZ5?=
 =?utf-8?B?c1hXRHNQeHVrTXdqZE5ZNGpVeTVqRE1VNUM4RXZpbkdoODlGNEhZK0tqUll0?=
 =?utf-8?B?WkU3RmZMZ1F1NWEvODU3VEZndW8xL3RuMU5XaEpPMnRWSy8rQzNlYzh5bXQ2?=
 =?utf-8?B?c3VpMytsbDdyaTEzZHpFU2ZXOUROM01ZUG9FZCsyL3B3WnQwc2xydXBqV0JM?=
 =?utf-8?B?U1NsWTZBLzFSeHU1cW9BQldDazBKczc5akR0djRhYkx2bXBRQ1doNEFCRFl0?=
 =?utf-8?Q?KiICy0FZLIuPZD9+VzHLxnESw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f159ab97-e4f8-4634-ada4-08dc2e42abe1
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 16:25:07.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7Dg0IJBpusL/pmowmL8z+mQdYUet7Cmr+yM3MtQOKOVR1zV33PXTR/PTTSMA2wYInOCX5XFYnm4jKkGpl+fpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5163

Hello Thomas,

On 2/14/2024 2:33 AM, Thomas Gleixner wrote:
> This is a follow up on V5 of this work:
> 
>   https://lore.kernel.org/all/20240117115752.863482697@linutronix.de
> 
> and contains only the not yet applied part which reworks the CPUID
> parsing. This is also preparatory work for the general overhaul of APIC ID
> enumeration and management.
> 
> Changes vs. V5:
> 
>   - Fix the AMD leaf 0x8000008 parsing
>   - Update to generated CPUID leaf structures
>   - Address review comments (coding style, comments, changelogs, boot_cpu_has())
> 
> This applies on Linus tree and is available from git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v6

Tested the above tree comparing the values reported by
"/sys/kernel/debug/x86/topo/cpus/X" and
"/sys/devices/system/cpu/cpuX/topology/*" with those reported by
v6.8-rc4 on the following systems:

- Dual socket 3rd Generation EPYC System (2 x 64C/128T)
- Single socket 4th Generation EPYC System (1 x 96C/192T)
- Dual socket 4th Generation EPYC System (2 x 128C/256T)

Happy to report the values from the sysfs and debugfs with the series
are consistent with values on v6.8-rc4. "amd_node_id" and
"amd_nodes_per_pkg" introduced with the series are consistent with the
values reported in CPUID leaf 0x8000001E ECX on the respective system.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> [..snip..]
> 

--
Thanks and Regards,
Prateek

