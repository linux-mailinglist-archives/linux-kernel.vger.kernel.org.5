Return-Path: <linux-kernel+bounces-74058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8CE85CF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40CF1F2405F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0806839ACE;
	Wed, 21 Feb 2024 05:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpGTdatf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0E23C9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708492263; cv=fail; b=eEtqMAbij6tHHJaifoT3Zt5CtMGjaMD3bydiaqARRZvg/HteDu9sYqkYiyXkNysl5S8EFEzN8RjIMUKXX9TgkyxPfTOTBehEYjv1s7nCvxty1RgbmJgqYwTW0xHHKHYjl5nwlGzr+3WKuCpwKAA7R8/69jQ/gjiCbkFuTdIE064=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708492263; c=relaxed/simple;
	bh=iJh4pfdnZBKymkhB24zNxW331zPqAR39ENKzCWCPsEI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u9edt3FSskN0vqL6F8LQtpwe/+wlZXdZ6Os2HDKs1mxTXFNNMt8fmkMLXjJ+VSb82GeDJw9yrGYeAI3MRv4eW24Ec5Ve7WpytWHyq60ivr7wuddyrmPQiIZWNizTv1RG5rXM6QjcRphMYdvSlWC+SAKYTZwTK/xrcEBKZREIjUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpGTdatf; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708492262; x=1740028262;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iJh4pfdnZBKymkhB24zNxW331zPqAR39ENKzCWCPsEI=;
  b=EpGTdatf4V9Ug7rQO1U3BQvLzEDEPV0btMhko3B363AD0/3YnYG8Vikg
   fWiUj23ZbOXf8tTu9ni+p3a81uacF6kER8ilkarmUD8eCpuNvSUj3z5dK
   ZXTqqnKrBLzk5ZVjzLq6my7/V8LiXG/TXW2zsyW2sHgpTv7QDO6Ri+oty
   KYKbOmlrBFM23mLlueTU64Lpy7GeLCz9FLp58JD+SrDJ77/fdZkzFMSwr
   l4piS++i2TkFXB8erna51bPfHjLUoQg5nYEw+YOL0cGpU1pt1nF/gCQN8
   IoauWs/TR5Jt4A/Xha7Xu2C1CaVSmyGzUsovzz+X0kWLIvDk8kilOHdTz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2503338"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2503338"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 21:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4984802"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 21:10:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 21:10:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 21:10:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 21:10:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0okW1a2hoRHzPLqEKYlqt4ait3ZWrm/lT931KO/QwpCOVU2Z3AwGjCI/HuNPdm5RsZtxoGWysi/QZGELFs2vytla2GTpVHUPV0yacEDvxN9YwlBHNaxocyLu6nMltmQMbD+dbKDzJW47ZIGVVqFYtEdroLz1G/xJDltL8lSyaiz7ERTr+H6CtYnjhv97JLEn+IRGzAyf17fEUl1CDnVKeOAfb8Osj19JLWklnuMM3quj2FuGjq64yVPqMpNDPLECIdFFdRWUNo7ri9mAVW11uzngVtsDDp4xMb55kyhxcTguijIT7puiupCAVSCcpv8lR3Notb3FvV6HUAVGsqlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8HoJGopHUnJ/p+z2VmGZ6rYzEdErZQsAWafWdDJ/Sc=;
 b=j1ylTOitqywgqlwq/LaHF9/EBOG0l3VC1rLy+YmyCzwbIvDdOCQJM7kz8vbW4Ie5u0wqP52z/qtlZOgj4cK6XcAsa04qj8DMcXtSQYSHp1HuRWEcYE0uNNWoiXUWuf+nGhpWUrfOOqX92bU9cdvgJx22t8bHGFch/g8sLSqbcfmRMIB7g2fPWAUeq6eCF5Cvg2dThbdggJi9ngknadR7IXrK6ptqPPsTJ/MijFUItmJlH0IlCf+eSLCg8gsEpneKtYJnD/qBQXlcYg11w9c+SHIH7YGcNWCqBt0uXgYUFauGcKJdML8addj/t5S6pHXpV7UkKT6jK9l94r4pfDt+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8483.namprd11.prod.outlook.com (2603:10b6:408:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Wed, 21 Feb
 2024 05:10:50 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 05:10:50 +0000
Message-ID: <faabc0ef-6c81-4ca9-b96d-e2e679cfc1a0@intel.com>
Date: Tue, 20 Feb 2024 21:10:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Fix WARN in get_domain_from_cpu()
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@linutronix.de>
CC: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>
References: <20240213184438.16675-1-james.morse@arm.com>
 <20240217105543.GAZdCQr_nosDP4tGuO@fat_crate.local> <87zfvwieli.ffs@tglx>
 <ZdUSwOM9UUNpw84Y@agluck-desk3>
 <d409c32d-0f9a-4773-bc25-9d39de3c9e9b@intel.com>
 <SJ1PR11MB6083A759748EAF62EDF21D0FFC502@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZdVFDIJmctsNaGd2@agluck-desk3>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZdVFDIJmctsNaGd2@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:303:2b::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: a623291c-1c57-4cc1-0a44-08dc329b787b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WnbgDuOdBF6aTyJla3Ro6Xbquo+3wmKi2cj61FBx61XCbQWt+aeS6dfhTeBaMRqSfNqKDxcdHH21I2GVvXr2fK4BABOBzwVoX2ZKyDHQyAXv4sCzjdT8JWoQLxE2Fp0ECaLUeEIV29ra7alrq52tl6Cw5uBOvQBoJUl2Qt1HCOqYgNIcT90unkPBENvLodUuZt5o2resKiBcp8bINNpn+XuANVNq799gmER27l+PDHp5PsLzqZjXMqcsyWSSPv3xfVT52AxA9pSrYtmgrgHDfCcM0IE9w/ttD1tkbb6YUgOay5/L8ci985FUfqKG+D9EIp7VI1uVLpDiAr+fQ638nt0pB9G25E7H0ygtdX3KDD349sCOzVSUeam8snntHUyOYCTyoY6t3enj3wLi11/2vDu6favq1x+4RaqqNksIfqySsBivehpjL6QDAFRABcpeLqc9z5YZUzJ6mngABszvFbBO8t9LqO4VgKrK/IpAhthstfN+fW0rYeTDi74DUQ4u36beT7IfWNkb2KSJwlkDUnFhdKcmlsBghJ7YsmId5VE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnF5R1JXSng1cWw3UlZ0VTVCdHgrRU5VQVNLLzBBQzVZclMza1dZa2Fydngr?=
 =?utf-8?B?Vi9HbXhsU00ydTBXWGFneHVORGtrVlFaeHFPQW5sWDEwOUlOeklXNXlTUURY?=
 =?utf-8?B?bUJGVy9YcmJYN1IreXJJRWlXMFd6RjZUY2RpZCttSnQvQ21QY29EanBpaGFh?=
 =?utf-8?B?bDJvTytPUHFWS29pMUcrNFR1NWNrcFAvR3N6bDlickVPRTNFS1ZtcVBxVzZx?=
 =?utf-8?B?b0pCdVFyaFUzSVlua0hIZis2Zm5JMmpQRnN3QllHbDliVEhDZVJpbDk0QXRx?=
 =?utf-8?B?MTl0QVhwVFlkeisyWXhjc0ZvQjJLSU43SWlWemZTY3d3QUErRlJpbEhLRzRN?=
 =?utf-8?B?WldXYWorL2JsL0tvOVVscWJobjNzU3I3WW1sSzZxNndKaDVsUmtBVzBNTGwy?=
 =?utf-8?B?a2pEVXh1WlVFTG1zQm1DVTJ6UUs5bWVNejNVSGJqWHVBckFLb0pJU0xEa1Q2?=
 =?utf-8?B?amxzZ1ZxTm9YbUdrVDJ6VVRKc0VHVjRQbUZuZktKRU03Z214a3gzNElKWU1D?=
 =?utf-8?B?bUxrUW1QdzRhaitEODRmODJRNmMvMGwxMGZVOFgrcW81RzRZeTlzdGdxcTBh?=
 =?utf-8?B?a21ZUUtoMjZmMlJpUnYzL0lhakY1OFV4V2p1bmszS1BsdllrcXJaZUJDVlYz?=
 =?utf-8?B?NVdIaEVrUnJseStLaHlHWjVSeVQyV1B3dFpsblVhaC9URkU4c0ZZRFltNCsw?=
 =?utf-8?B?Z2F5eWtKRjZtY3VZVmRWa3lBSGtwR2hWUktmWkdEV2R5T09jSDc3Q1l0V2Jq?=
 =?utf-8?B?cXc1R3dKdGRoUWMwYjYvWWJmMEZ3Q0w2V01ZQUpVcmozdlB1ZWxrK2dBdVpv?=
 =?utf-8?B?R0d5Ry9hNDJLOFc1NDBXaXowTGN6OFNkSHFJSG0vRHJNR1F4cmZQM1NqNGto?=
 =?utf-8?B?NlJqUUh5bXJWa2RqaXkwOWNqZWc4RllTa1M5UW9WdTU4cmlqZjltckhvMVR0?=
 =?utf-8?B?YkVqS0k4dlhkenYwZHBrVjd3RWJaZHZraHBYcXdtQUxHZVJOQm9lTWFSaUxN?=
 =?utf-8?B?OVAxeE9wZndlVHh2a3hqaUh2VHhFRXRnR04wZ0djaVN6blNSSjJVZXlBRGJR?=
 =?utf-8?B?c3huUE93MGhrOE9JQTVRKzlCL3JrQWJEaXlzVXo3ejVPelJ4UXEzV2ZFTkE4?=
 =?utf-8?B?N0lrcE80cmZiWlMzTmsxMFROOHo3Z3gzamhFbk5VM3BlWXh6di9MT1VDS01t?=
 =?utf-8?B?eGxSdmhLZGhmYlJlSmVXcFdGTTJYOXVrVHcycVZYZXV0NlFUK2xRNlhicHly?=
 =?utf-8?B?QkJKTUpTK1lzVVlNR1VaOFVFSjlkVWdzM3FpeG9qcUxrSjlkdFZZN216aEJn?=
 =?utf-8?B?NFhQVlFCZVNtQUNnUVJNNlRWODg2dWRBcjlWdVFFVnZyY0NzckJCanJLUjlx?=
 =?utf-8?B?bGdRbyt4b202dHpwcXpYbG8zcUkrbk0vRmJnSmZWY0ViNXlCOWhMYW5ja29B?=
 =?utf-8?B?eW5xcVlRcStXUVZKNjcwRWlEZTd6clBSaDQ5bXNlU29lNDZMcHdZWWRub2tB?=
 =?utf-8?B?NGhaTWdqOWRZVmlPQTNXZklST1dvOGw1TkpibzdKVlFJek1ZblBFQnN1U3dS?=
 =?utf-8?B?Z2xmT3htWC9ZTk5Fb2FQeUZNZnlTL0ZVWjJLSmVJQkhFN3ZSREQxVm5hRzlK?=
 =?utf-8?B?NmsrdVlpR2VvdVBpMmJYRkIzT3haa2JhL0xNQzA0bnlsbVM3ZW5oMHFLS1Ey?=
 =?utf-8?B?Y0hlZm1GY2RQRnQrQjJJR2xjZER1TXZwRjk4K2U3R3NLUTExd3VqdmpHNHhW?=
 =?utf-8?B?RmJ1SVFXbTFNN1ZMTHJtTDVCeUV4U3VRa3dFb2FiVk52R3FtaXAxZHlnR2Vu?=
 =?utf-8?B?RjNMM2Y0QkZmTUFEVGFoelI2dStoaXcvMzk1WkhMQnNlUWFnQXc1emNFdjF3?=
 =?utf-8?B?OHhkTHNmaU9LdVBJTzNrcERrT3JvUW4yTkJGc1BGcTNnUGl5Z0lreWo5MjB2?=
 =?utf-8?B?eDhZT0prZmRnR1lVMkhoZmJoOEVoTjhjTnV5VUsza09UNXhLUndBYVN1NjNx?=
 =?utf-8?B?TEM3WXpMOHFzSDFLTWhXUFdzakVQb00rRm9Sck83TUxGRkdIMjVoS0hydUhp?=
 =?utf-8?B?aWM3NUk1ZldpbVRVNGVyQ1U3ZTl1cGd2azJCbFZsWlFjZU1FTnBNVWcyMHdQ?=
 =?utf-8?B?K0tQS0d5SHdZRzYySWVXV0xOL1hpcnU2WWFwL2srWldmbVpoaDRmQVJpbVhF?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a623291c-1c57-4cc1-0a44-08dc329b787b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 05:10:50.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEtgaP6o6mVGbhsYASf7jsrQPA6Go6Y0ii0BRIkN3msSK7CRJXz7iQs+wQ4Sc9uSblx5YJzSFcUmC+n1bSnVQL0cTbss9IRzpSQADCLtvaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8483
X-OriginatorOrg: intel.com

Hi Tony,

Regarding the implication made in the subject ...
from what I understand the WARN is a false positive.

On 2/20/2024 4:34 PM, Tony Luck wrote:
> reset_all_ctrls() and resctrl_arch_update_domains() use
> on_each_cpu_mask() to call rdt_ctrl_update() on potentially
> one CPU from each domain.
> 
> But this means rdt_ctrl_update() needs to figure out which domain
> to apply changes to. Doing so requires a search of all domains
> in a resource, which can only be done safely if cpus_lock is
> held. Both callers do hold this lock, but there isn't a way
> for a function called on another CPU via IPI to verify this.
> 
> Fix by adding the target domain to the msr_param structure and
> calling for each domain separately using smp_call_function_single()

This sounds reasonable to me. Thank you for the proposal.

> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> Either apply on top of tip x86/cache:
> 
>  fb700810d30b ("x86/resctrl: Separate arch and fs resctrl locks")
> 
> or merge this into that commit.

I do not know if it would be preferred to take this approach as
part of this work or just remove the WARN and add this
improvement/refactoring later as a follow-up. 

> ---
>  arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
>  arch/x86/kernel/cpu/resctrl/core.c        | 10 +----
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 50 +++++------------------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 14 ++-----
>  4 files changed, 16 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c99f26ebe7a6..c30d7697b431 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -383,6 +383,7 @@ static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct rdt_domain *r)
>   */
>  struct msr_param {
>  	struct rdt_resource	*res;
> +	struct rdt_domain	*dom;
>  	u32			low;
>  	u32			high;
>  };
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 8a4ef4f5bddc..8d8b8abcda98 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -390,16 +390,8 @@ void rdt_ctrl_update(void *arg)
>  	struct msr_param *m = arg;
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(m->res);
>  	struct rdt_resource *r = m->res;
> -	int cpu = smp_processor_id();
> -	struct rdt_domain *d;
>  
> -	d = get_domain_from_cpu(cpu, r);
> -	if (d) {
> -		hw_res->msr_update(d, m, r);
> -		return;
> -	}
> -	pr_warn_once("cpu %d not found in any domain for resource %s\n",
> -		     cpu, r->name);
> +	hw_res->msr_update(m->dom, m, r);

It looks redundant to provide struct msr_param as well as two of its
members as parameters. 

>  }
>  
>  /*
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 7997b47743a2..aed702d06314 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -272,22 +272,6 @@ static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
>  	}
>  }
>  
> -static bool apply_config(struct rdt_hw_domain *hw_dom,
> -			 struct resctrl_staged_config *cfg, u32 idx,
> -			 cpumask_var_t cpu_mask)
> -{
> -	struct rdt_domain *dom = &hw_dom->d_resctrl;
> -
> -	if (cfg->new_ctrl != hw_dom->ctrl_val[idx]) {
> -		cpumask_set_cpu(cpumask_any(&dom->cpu_mask), cpu_mask);
> -		hw_dom->ctrl_val[idx] = cfg->new_ctrl;
> -
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
>  int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
>  			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
>  {
> @@ -315,17 +299,13 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>  	struct rdt_hw_domain *hw_dom;
>  	struct msr_param msr_param;
>  	enum resctrl_conf_type t;
> -	cpumask_var_t cpu_mask;
>  	struct rdt_domain *d;
> +	int cpu;
>  	u32 idx;
>  
>  	/* Walking r->domains, ensure it can't race with cpuhp */
>  	lockdep_assert_cpus_held();
>  
> -	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	msr_param.res = NULL;
>  	list_for_each_entry(d, &r->domains, list) {
>  		hw_dom = resctrl_to_arch_dom(d);
>  		for (t = 0; t < CDP_NUM_TYPES; t++) {
> @@ -334,29 +314,19 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>  				continue;
>  
>  			idx = get_config_index(closid, t);
> -			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
> +			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
>  				continue;
> -
> -			if (!msr_param.res) {
> -				msr_param.low = idx;
> -				msr_param.high = msr_param.low + 1;
> -				msr_param.res = r;
> -			} else {
> -				msr_param.low = min(msr_param.low, idx);
> -				msr_param.high = max(msr_param.high, idx + 1);
> -			}
> +			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
> +			cpu = cpumask_any(&d->cpu_mask);
> +
> +			msr_param.low = idx;
> +			msr_param.high = msr_param.low + 1;
> +			msr_param.res = r;
> +			msr_param.dom = d;
> +			smp_call_function_single(cpu, rdt_ctrl_update, &msr_param, 1);

When CDP is enabled, could this not end up sending IPI to the same CPU twice, each
requesting CPU to do one MSR write instead of sending an IPI once to write all
needed MSRs?


Reinette

