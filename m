Return-Path: <linux-kernel+bounces-2084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617A88157A0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE19B20F3F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE46D14005;
	Sat, 16 Dec 2023 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/sE8UMX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E513FEA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 05:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702703017; x=1734239017;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VfakdAIz/YOC1nXQFdVRwsTGOWFM4O+In1VZWRLW4Ec=;
  b=M/sE8UMXaPs4NdJTAm1HOzJZHsX4QMWuIexLVY4f1gkJ2dNiFVDa5MoN
   j8PIaKxkRzTKzRVRZ7uJIRHFNCAz0LOJRYuh6mP308C4wjpU9kkCxP+OW
   c1vFmD7dzXBvkR5L7Mhsvqw5Kk/XL1jVCohgMMsQCEzOGra3vZL8Rvp0H
   hzz8CHzqxEz2Aw1jxFWM5CExI4Sd8CWenwhzDi9hZs9QZ2a0Ve+P5TVdg
   c8Jkzl7WlRnUXxpFmR9RmBrD5UZ6DBeIc+VmPRv/bAcUJkJWNa6cpjbHl
   4Hl2/jj4MmDQtIGQHr3Bp72G9BTpW4+XwDYejGY9hPwoJ2Sae100aix9a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2535050"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2535050"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 21:03:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="778498725"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="778498725"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 21:03:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 21:03:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 21:03:34 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 21:03:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ju5LJTrvNeF16yDY/MZxLxUe7yTVIENcjn6FZT7K4s7nW39NTZ6gYqDUr9a+3dnfFK6lG80krOcuiaFK8uTiQQuDLS4l5ZhUCu+H7+vX4nEV8RmtmfmDR9CmEY3ieGnBZx9Qr/IZ+tgg8aBBKayW76Fmy/qEpViCgUgcg3RNJ4GkdO4ZLXgZxb9kYoz+r2r2Mty6DjadQt5cVMj38vVBZMhG3R9X17u6C18ibI23eBVV6Xaj5gJcw4ekfIirLIbcTWApZNSiMWqdJBe8TP2tOjRv06QqrKSzR2R40ioxD2Fk0BhsqT5V5z7O3SPruNdpVYFZN96Xh5vvO2iE3v6IvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otg8FGnS9dweH4ewsSEwag0ox3lPDL7ciIGEx8SrZoM=;
 b=DCe9+Ka/BbCjeJnh/iTNJdViWQgbMeK4xTQkjh6CceXjt2Y39XFqJWB+Wp0cRdRWb7kZ0zHl/o3W1AL9v+iXJOZ+EM5tUVcBURMqG5VBxPt47jiL7R6BoPLAGZaV3FPHvIkAgKhBtpDO3jn4x8XzFp7SzISfh7I65WBw3pOOSmlOaQ24lvbL+pV2ocjdev9kIrpaoxnNROPdsbhMCgj2+VliEwPueWFtVEY5NEl7sL1mLeSy5Cyy4LBrSC/toewYb7fRZln6/ILLXbiIzDkIj2HJPeeFYTjw8qFSQoBX4Xn19NXIQU4XfUkJH3p4cjlPH2nYLg2aPVaIlhHKNStE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6147.namprd11.prod.outlook.com (2603:10b6:208:3ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 05:01:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Sat, 16 Dec 2023
 05:01:40 +0000
Message-ID: <25e75e7a-7cda-4099-8331-8fb1050a9dd5@intel.com>
Date: Fri, 15 Dec 2023 21:01:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
Content-Language: en-US
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-11-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231215174343.13872-11-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0273.namprd03.prod.outlook.com
 (2603:10b6:303:b5::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9ee912-63ea-4712-01fd-08dbfdf41737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5INP0AAsdFWfSiHvK+K3oIyLvk6hkTt7hGJp6dfSHbM8JIy2r9UwRRbg7kkAgwHumvxhl9nF/puPNDw+Mei58ksnnbEkvsXCcI6or0r5AT4tjjozNI6RJA9BX3y8FKoRjYEmWUGvWGmYBySSwGdQ4pZ2qIr3/HlVlXi44+RV9xYvzL+PJyEj8qFvtmCC3jmKPE81PDMf8wUaBv8yxzIDyxAgtBhXkHl2CFdh6nK1cKu+ptwYQDF7Tw0DiouFPcghaW8ciPuewxB/XEt8Za4P12HH7oPvmU/U0cGW2nVQMQUGUcMlgM8Y36dxaW6Gy/NMF7X/g13xfRaEs6u8OXHhAfqZR2W3BOd94dfuPVvGlrPlTJR7KRVywG607u79c5OG3jt3VMPje9CNs/Koh0m62/THEHxAV+CNKvDAbiLZlbF2gviTNGC6u1YT7thHZFJajXdIkJKqi/oVO+1ZFNSZCjMkwVwEck4eheR00oZQR1yCYDJBtNKgrHI2PYaFBfg5yv9ycwcNsTTu2NhqtI0GYiWrrBm1Tqp6O7/KlOpQj0c2Axw1lvSy36OGqJ5G2q2p3EW4J9rbxp+UGsGRipZMXidzKxZBBh9/U8JxRnzRhTfe0X7uyjBZ9fruwsEIcs+iEb9naz+McrBQfjIDSILWvFVFkR1FCuSIfIlVGyqs9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(478600001)(82960400001)(86362001)(31696002)(41300700001)(38100700002)(6486002)(8936002)(8676002)(4326008)(66946007)(66556008)(2616005)(66476007)(316002)(54906003)(36756003)(7416002)(2906002)(26005)(5660300002)(6506007)(44832011)(6666004)(53546011)(6512007)(31686004)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEJRU0lPTnREZ1g0cXk2bjlkaGlFdmszY3NaQ2VrVVRoVVJiWWs3NitpTUlz?=
 =?utf-8?B?bHF4YmM2bmtzRm1HTk5uUTFWU2dKNy9BTzl4VU12RlBPemtPQmg3OGZoek43?=
 =?utf-8?B?bHJJSXVlS3lxR0lSdTZUdm9ZM2I2M2w0OFJkc3lwcVpNMHoyRzFJL0YwNzIx?=
 =?utf-8?B?c051RkcyaHdxS2N3T2Y0aHErSHBsY3o2RnlFY0h5azJzYyt5Rm5jUFQ2S2My?=
 =?utf-8?B?UDM2UWNNdHk4TEczVW1uM21zbDlJNmFEZ3dFakJ6UzdVS2llQW05aGNlelpy?=
 =?utf-8?B?RG5YeWhOZjFmWjRaTC9BejRLWUxxVGdlTmtSMWVuS29KUXVOSHVqd2Z1YTVE?=
 =?utf-8?B?VmwxUnhJbUp2d1VQTFozV0RVK0lWZnNSRjNNOTdoZnFDK2lVZDdaYjhkNXhp?=
 =?utf-8?B?ZWQwTDY1OU44R3Q3MTYwZ3VPSTVmOHBZZHZSRzFEUXFHTkd2Y0dEaHU1NDR0?=
 =?utf-8?B?a0FoWHM3eWtsWi84NUVWWml4L0c2em80Sit2VnNXV0QwOGtCbWlnblV6bXFr?=
 =?utf-8?B?MlFqbWNsL0lCeWNQNkp0aklhMjlwTTREelM2eldkSmh1cDNGSWQwQjJScENP?=
 =?utf-8?B?K3U2WXplUStpRTllMDNLMm5nelZpUXBUNUZ3LzllZzNaMjN6V1NvTWNPWkR4?=
 =?utf-8?B?TWNFcUtNaXFDR3k0YnROblE3d1B5ZkREbWJsOFZUbC8yUW1rMXhETEhKd3Va?=
 =?utf-8?B?Q1k5Und0aHFpWWxiUlBudVFCVUJxZW1VdzZGYi9xMEJKVzhCaFRmclpMLzBa?=
 =?utf-8?B?L2huT1R4UnNIMHVVNDZQUzZBVUtrQ1NsQnA4N2tPSyszbXJXbThiUytzdzNs?=
 =?utf-8?B?WWpudzY2SUNobzVYYWlUVjlkRDVuSzRPQzNnQ3kvN2JwdENrMHZ5VWhybCti?=
 =?utf-8?B?MEUvREJLd1Y0WVJFZ0NtZHhiOVFZRVFhSjVRSEhBWlQ0dkU3eU5KMC9XbExP?=
 =?utf-8?B?SHBpN0FrV1QwYllzVWVkZ0RvNzB6UGU0bWxuenJGSkJ6VzNvZWUwcW1RTzFB?=
 =?utf-8?B?WUFKVE51MXd1ZmdZdENSOTREZ3lsUW9tM3BpVVFiYjB3eDY4ak5XdUFpK1R6?=
 =?utf-8?B?WTFyOHdwVjNZbjZobVhCY1ZCRVlHZVdJVjZSalN6TDhtQ3JnZXZaVG5qclFa?=
 =?utf-8?B?LzA2ZURFSHdJbjNxTXBoZUk3RTFVZTJkRklVVlpseUtmWk1VUFZBTlQxRGVk?=
 =?utf-8?B?M2hNa1FqbjRmclN6T3lSRHBJMXlXdlB0SU1oSUxyZkpsRzc3TXkwMVBrZEZh?=
 =?utf-8?B?NzVTeVg5RVVKaExSalZ5ZU1IUFc4UjlTVmxZdUNLRkM2R2ZqUzBTY1VVQ0hM?=
 =?utf-8?B?d3BRL2xYNWVUVjVKQ2ZtamZjdklFMEpkaENaSWdtNnFtVlNmR2h1MzJSVUtY?=
 =?utf-8?B?dTk4R3VmL3gyNjdMRFN5VFIrU2JZNkRyZVBwbUxDcjVDTzFHMEVNZ2RKNDlj?=
 =?utf-8?B?QzJkWXBrQnU0RXA3SC9sRm41UkpVNlQydHFtZFowZ2FEYWQ3Z3IyMTRpdVZT?=
 =?utf-8?B?RGpSSjRPTmVJVG1MeE92QVF5Z2kxODBzZlBWRFpDVUsrbk1ZWmxOZG96d2RY?=
 =?utf-8?B?Z0hFU2F0YXNKa1hRWlBhQjZ2UXZaMGhHc1M3d0hUTm9ka2FvNXdBRCtmNUIz?=
 =?utf-8?B?WmpCMk4xU3pkaDZ2bVNjNzJVTWx6K21FdFZta1dLbG5NNXdDdDRkeFlRZkNl?=
 =?utf-8?B?TkpHcHpES1pKVlZwUjNZbHZuUDljcUMrQnZZRkdySDRpTUxUdUkvV0NoWDlX?=
 =?utf-8?B?NmVCZWlzYlhLWDZmMi8xTWQ1bFJRUC9UTWZFdlNUL0NGWEd6WVY0ZWgyUisy?=
 =?utf-8?B?TTNWZ0tVWE44Mk45cEdVSEpWWmFkN084SkdDM1JHaXVFR01qKzRJNEs4SkFk?=
 =?utf-8?B?MHZNK2xkN2lYTjQvZVBFSWw4b2RvdEYvc3JTNUk3ZTMwckxPVHdZMGxxTVhv?=
 =?utf-8?B?ckFPdUdpSzBJNGRnOERFTTNOQlNxSUpSdXM2L2xHWlJtRmRLSEVMWVN0bWlC?=
 =?utf-8?B?NStiNFJ1VThjemIyb1BqcDhuWWNjSUIvQitvcGloaFZhLzZLRzJpRm5SS1Jo?=
 =?utf-8?B?ditBdE1ZekxqSU5pSUFldWIzZ0xqbnVWbGRwdWc1aFhzai9qTnE5OFBkWTlu?=
 =?utf-8?B?Z2lFVGVrT3FUYW1mUmZaQlBxN1B1MkxOd3hGN1VYSmM4VzNmNmliZ3hMWTVX?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9ee912-63ea-4712-01fd-08dbfdf41737
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 05:01:40.7903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJiUEqNvUh8HIo/z0HwHT6lkOA2NhZ4Wqd4bM9SweB33O/ZWDnYvLY5yeI6l9A70W1CoHrfdwYb74TayG8qxSxUK7egf7Cg55sas3xOmoIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6147
X-OriginatorOrg: intel.com

Hi James,

On 12/15/2023 9:43 AM, James Morse wrote:
> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
> used for different control groups.
> 
> This means once a CLOSID is allocated, all its monitoring ids may still be
> dirty, and held in limbo.
> 
> Instead of allocating the first free CLOSID, on architectures where
> CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is enabled, search
> closid_num_dirty_rmid[] to find the cleanest CLOSID.
> 
> The CLOSID found is returned to closid_alloc() for the free list
> to be updated.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---
> Changes since v4:
>  * Dropped stale section from comment
> 
> Changes since v5:
>  * Renamed some variables.
> 
> Changes since v7:
>  * Made comments over closid_num_dirty_rmid() not a kdoc comment.

(This is an example of me not relying on you dropping my reviewed-by tag
to take a look at new changes.)

This change is unexpected and does not have anything to do with this patch.
Instead it just seems to undo a change that sneaked into patch #8
of this series.

Reinette

