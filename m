Return-Path: <linux-kernel+bounces-141423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3548A1E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62669B275A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE878C8F;
	Thu, 11 Apr 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljRoXzaq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE2EEB5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712857529; cv=fail; b=IMp2Q3XAo/KE3yjmhgp61NK6j/wX6tlU/3pcCCIJIfBXEZ4yvf/O0aUmUaEz3/IYBWWVVfzLk8//YZ39x7Z42rRttz9XLmpF95k/X7KRCDiCzpn0dYhg1UlKIMT55lXOBCouVUehx2yjl1UmptnuPkh561jz7mU82FmevZ4EOEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712857529; c=relaxed/simple;
	bh=Lbv4yr7M4HG2P0v8vO4PE9+QZmIlmTcNQOOJGlcH3t0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=InlBTC4xCylTrO1F+KA0R7gNDsCmIL/kmquRgPdi7c2hJe9TP3IoeMN7elskhOqb4YwwdVKtAVhlYqljbFgf6KEWGmFQ6RnyVlArFfPSrgHjLZl5Jv+TRnfCh5SJL78hoLsGKZgiEDfaGfBvs4nz4finB8at9QQNRlOopYzZWzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljRoXzaq; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712857528; x=1744393528;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lbv4yr7M4HG2P0v8vO4PE9+QZmIlmTcNQOOJGlcH3t0=;
  b=ljRoXzaqMRKk6tMYKAfTsMiqM0CENxCtjYTneS25VcdsR2yc0DMn4RTx
   VKcwQGYGfoRlb0R8lbeBb+6s9HDDYbZ7j20U7ryh0JyxaWiO03grcMfgg
   50PFCH4LBm+NwL2dx+rZwnwrJgMiOGy+bWBsJjR+Wzoc9ZRBwp3hHb5Tm
   4pG/JWi4k5nWp1lFJmWSxQbbma5bJZn6fZ/Augmfke6JSV6STQhgpC51g
   m4rYzygHmmNeyTlXKABpqAg/BO0aTRoe2WFRhYk66dnWNbu+f2IabppJH
   d3weqxbmNjsBjzgyf/GbH6i+DpZ4Ux9yAPw16e+8EJ/EkIy7B6MHPD0Oo
   g==;
X-CSE-ConnectionGUID: jINBcNXETBqugZT41++YvA==
X-CSE-MsgGUID: bNHPh47HT4GgiJqPij0m/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="25739205"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25739205"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 10:45:27 -0700
X-CSE-ConnectionGUID: EfSIu9myQoyvsAZaY7YeZA==
X-CSE-MsgGUID: f1OxKvE7RBO7xO1tRm6E9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20891449"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 10:45:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:45:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 10:45:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 10:45:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 10:45:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1C1HXZnxpv+PG1T1vmmhvpVP0ttzt1DO+NrwauR7kULcQFbAXksYX4mcKmE3rB4pBV8f911wYnFiJ7FldbJZW5rqzmVuT1NuPXsJzJ02knsV/71fjAvDyf64wTxvzfw4KaVC5xe8ri5GJrPEg/zA99l5zIKsBDAT/xGM8sFp99Ek0dpRv2QUOR2Wg+tMysj21Wm3H/P8H1aMmAbqGIDFPX02HZSITtTHj0iMG/kVws/MDS8DfSQQDn6niMRmzndYyNUZcCJnuKv8Yx5yL6Br5UD92gI4GnjDHsDG5xDIAOIHbmlJqaLu42dO8G1Wb33p8M0tKVa+nvqrn+aXgxrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wWxw/aGKNKSLPGzf7CXTRHjMBEN56EDLYLE73J8QN4=;
 b=ZxQwL+J6DwP4gmSZV7et1OVntCyRVrqkhaVXUhnzKhU+DgUauYh4jUHsXFYWtqseHtRGF8fWUJxtQOhlcc/nxXANnlDxKa64CIxgS25uiI1ykTHd85Tdr53Oc2B+z3ZPQTwgUA7flGE0qi9WumdiXfBBCRexyd2EwHpFEALYwmjalaca5YHzBkqWN4rI3N3RL9cTflr0cn0cnAypyVcGYioGaxrOJUhPRpoB17MOmmidLAowdnv6wgmjpR7zcZBj9YMk84Le68ckdyUuA886BJXDGGVz/0mrcBKliOuBrEn+Fr/B2Iw1yYcjnI61ChWzapf3sxIXpRms/63i4w/+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6432.namprd11.prod.outlook.com (2603:10b6:8:ba::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.26; Thu, 11 Apr 2024 17:45:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 17:45:20 +0000
Message-ID: <be03a7e9-fb0b-4edb-b22e-4452255992ad@intel.com>
Date: Thu, 11 Apr 2024 10:45:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 31/31] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
To: Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-32-james.morse@arm.com>
 <0aaae9ce-00ae-cd0b-ed25-4d52d1620ab5@intel.com>
 <Zhfz7KHJeXYNCw9/@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zhfz7KHJeXYNCw9/@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:303:b8::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a080fd-9b4e-43e4-e0bb-08dc5a4f2856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjaCHAVWLv18IEw5T0t7Sd3qh9+CYdFX3uiqc+kuBpu8Ow0KqZVYPXv4WGEpGUvc0Us+F7XLT7RAQtItUFje0XNhGmGruNc3Ju4PMHMnAzaXnX5UvEHm9Sm7gwZqeCjbbOjVRRb3318G0mJ3JnGyxS1GYVbpT+vTNqDKbmOJiD5QOW29Keuew1SpGRVxddXvIdgblD0v1fWlAkBOBdNeviBfxGiT4NNm0yBCR7wbhdfbsVGweOiythKqSTgZ3l3voE5T5t0gR5DBHG7al+Z5HboZbR9Pm1gxnvGeKCYzblgBTowSCQnM7wH6A1iPci+wu1zGV3TZ/IZjQYOcACpnn9i3Ge8HxPxxXqlIdfe2ZSP9byqlgWLskZ+uvf3f4qGRQeKaS+ilUKBri4GxHQ3+kobbBednftOGZnwnTt8koimLALeToI89tiJ6CJr5qPaP0KDYBz0aBHt7Cdc7wLcPrfNgxF90FbdS0PANrwuSjOsd587edsj3oqewyJBnQ8NnxgkTmWkRs3I28jgdmHcdWrCARY/reEQ58PEHkTUcGEMSsyUWBbzralYC26TWzE4VW54BVl7lozWNCFGdmNlpXYItDUwAbMST6eNYnWayJXlgUTkpEUJrGt8rYcQsgbFpLLZb3DHapMALlVR98XWDMfuDEiux2k4hsuM0ftcBYHA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkhvZGJjamZoQkVOZWdBdHlLQVFSWDhPbTFXNU9PbXhqVDdMMFVEMDBvZ0Y4?=
 =?utf-8?B?RXUyZXB1d0VUZkx5c3BzdEZnNW5VWWVKeFNEVWU4UnoraFRXeGZyZ3dTb0M2?=
 =?utf-8?B?V2t1dWRVMXdvQm9OSlllL1ZrRDc3ZWxaVUxta3R4LzhpZ2V4dTNLMGQ5VVR2?=
 =?utf-8?B?SUdSV0hISXlkVVJsS2VwOVMxeUFTdWJyUEtFRW5BdWQ3ZEdRc0U3dFZOSnZp?=
 =?utf-8?B?QVhNRmRqbmVMQ3ZPeXZ0VGtSVG1kTmNETWJ6WFlGNjJOa3Q4TXBNMS8wYUFM?=
 =?utf-8?B?NWNjYXpMb0I5RjBxSWFoQWoybm1ySGo3cnhSM3NkRHdpa1h3cDBvVkdvUHNX?=
 =?utf-8?B?VEVsTS9ucnN6cDh0eEQyZHVNaEdCTUdYaEZ0aWMrOUNzQ2NXWXFIL2dqZk5I?=
 =?utf-8?B?SW9ucDJxRjdud1VhVnRuZjRPY0FHV2U4d1lDQytXUSsrd3VVQU5MRGVlNlY0?=
 =?utf-8?B?bTZDc0Znc21yU3cvSFl6WEFKYXUra21zcThKL2FRdjNaZlBIcjljL3J1NmxF?=
 =?utf-8?B?dTdHM2wzS2FLNWlOeTRHVWNLZlAzTWZaTDhsYjhVTlVGRjhoWDNLK01PU1ov?=
 =?utf-8?B?KzQzRjJMQ1VkcDUybUxTNVhJK1VoNXJoOGtmUmYzZHlBZXR6L2FKYjBJeHRl?=
 =?utf-8?B?YlVhWGRyQzlWUEtPN0JEbmRxdWlSdDI0aUNHd1pGMm5rTFBIZmJjZFdkZnVh?=
 =?utf-8?B?WncwZXd3MkVpdGZxRUFVU3c2TEtjOVFCTXhEeFpKQUtvdU1wOE5WbmlVczA4?=
 =?utf-8?B?VnhteTM3VTJ2Q2Y0VlQxS1h1bCsvdEx1T3NJdHNjaXpscGZ3alBRRERuamR0?=
 =?utf-8?B?b3lPV1NLY05UU1haSVlGYnNtMU1kMGtoclptOFVETDdnS2xvRi93R3MwMEo1?=
 =?utf-8?B?d3Z1Rm8wcXpxeDltNnRtMXdST0FJZWd0SWhrOHBYVE5xVSszWmpQUkt2cjR6?=
 =?utf-8?B?ZVVEc2V3ZjExZ2pOQXRndER5NGNoUDhISFYzMmJkVys0RG9SVjB5REdPeXJ4?=
 =?utf-8?B?T0NHemlpQlloWmEyaXFhNThqK1lCVDVxZVJjSHk2SjhPNTF4TTFNeXpvakUw?=
 =?utf-8?B?aFpuMklqQjR6SHJVWDVtdmYyRnExcW1hUHdNQU9RUitZODBWNDI1WlFmbnR6?=
 =?utf-8?B?THRDdnUzVm9jeDJwQmZSVGg3S3ZBbjN1UWhmTzAzRVZzQXlnaHM1M3dpVE45?=
 =?utf-8?B?Q2Evajg4ZXFESUtIU1QyeVplM1ZvMHA4cEpZNjFlSWlUU3NET01FQkJMUG1p?=
 =?utf-8?B?NDJCeU1rU0wwdGt4c283Y3QyVTR4d1o1aGNIRjk0UHF6VFNEZThCbTV6UWYr?=
 =?utf-8?B?T2FzN0NUeDhVYms0RHJibjJRQjNmVm9mM0lqeVJVZWVWNHFHYWEyMTNjOFVt?=
 =?utf-8?B?ckhPeUxQYUI4eHBRblduL091TDV4SVNZT0NNWDhaRG1HS3BhVjMwSEs0NTM2?=
 =?utf-8?B?UHlBK0pKRk9iWWZ1NmVYaUdxYWpDWlFCdWZsbVJ6SFBaSDR1T1VNN1ptTWVI?=
 =?utf-8?B?UitiK3hpQnhWbHcvVEp2K2lSMFVsd0d1YnQwbVg0RExzZnJWSldTOEJVU3Fs?=
 =?utf-8?B?bmJLTkFuQ3ZHbzV2QWRoRWdLSWhUK3lnOEtZOE9Jclo4VW1LL09xVmtib3VU?=
 =?utf-8?B?b0RIc25JbzVYMGd6RG9EdldhbUh0Q0s3SmFLU3ppdzBQNDA4OUlIeW5WYm1Z?=
 =?utf-8?B?bFUwZmw4ZEVvUFZuWmN4WWtyci9SQmgwOGlYbGhoWDR4ZWIxc1NJNmZUY0pJ?=
 =?utf-8?B?WXNNaXVpWWpWWEdoNnQwVlNyTXIxRUJDdHBXZnlWOFB3K3FzT1VETkJuZUVY?=
 =?utf-8?B?UkQ5LzZQQWN1YlZRSkttdnRuZUdlVWlVTmhiUCt3R3pzdDlnbEQ2YU1ZbFZQ?=
 =?utf-8?B?QmtYU1lHVG5kVXZWbFRXOFNCK3lraERhd0ZwZ0ptUmptK3hiVm1SbEJPcy9I?=
 =?utf-8?B?R0lpellPUk1GRDN2QlVEMGhKazNkUEFzeW9QVWRkZTU4dTc2ZHNmVGo3WFJB?=
 =?utf-8?B?UmlaeEJrLzJkMEdhbTNxYnVkN1ovMEVFQkV2NDhLZFp4K2ExaWlTeVZLd1p1?=
 =?utf-8?B?c3V2SXBTbHZBZEVzZ1J3QVVXRExiWlpFQk16RWQ5bDV3TUlnMVMvZW5NaXFE?=
 =?utf-8?B?YWs0R2FGSENxa2hkQUhxUkpORmxEVkJHUDhNTjJJdzAwOFBBQTN3NEwvRldt?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a080fd-9b4e-43e4-e0bb-08dc5a4f2856
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:45:20.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +oxSRPIFEjS6Ioj5FTkumX97IxWy1LIhhDQsah64IJrbi6sZwdxNm9kb+1DLz9TH0pTduKkF+c/XqH5sGgn4Dqsdb0RVjwZGoqLl+bL9yTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6432
X-OriginatorOrg: intel.com

Hi Dave,

On 4/11/2024 7:30 AM, Dave Martin wrote:
> On Tue, Mar 26, 2024 at 12:44:26PM -0700, Fenghua Yu wrote:
>> Hi, James,
>>
>> On 3/21/24 09:51, James Morse wrote:
>>> resctrl is linux's defacto interface for managing cache and bandwidth
>>> policies for groups of tasks.
>>>
>>> To allow other architectures to make use of this pseudo filesystem,
>>> move it live in /fs/resctrl instead of /arch/x86.
>>>
>>> This move leaves behind the parts of resctrl that form the architecture
>>> interface for x86.
>>>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> ---
>>> Discussion needed on how/when to merge this, as it would conflict with
>>> all outstanding series. It's probably worth deferring to some opportune
>>> time, but is included here for illustration.
>>> ---
>>>   arch/x86/kernel/cpu/resctrl/core.c        |   15 -
>>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  505 ---
>>>   arch/x86/kernel/cpu/resctrl/internal.h    |  310 --
>>>   arch/x86/kernel/cpu/resctrl/monitor.c     |  821 -----
>>>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1093 ------
>>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 3994 --------------------
>>>   fs/resctrl/ctrlmondata.c                  |  527 +++
>>>   fs/resctrl/internal.h                     |  340 ++
>>>   fs/resctrl/monitor.c                      |  843 +++++
>>>   fs/resctrl/psuedo_lock.c                  | 1122 ++++++
>>>   fs/resctrl/rdtgroup.c                     | 4013 +++++++++++++++++++++
>>>   11 files changed, 6845 insertions(+), 6738 deletions(-)
>>>
>>
>> checkpatch reports warnings and checks on this patch. Please fix them. e.g.
>>
>> CHECK: Blank lines aren't necessary before a close brace '}'
>> #13340: FILE: fs/resctrl/rdtgroup.c:3184:
>> +
>> +	}
> 
> Thanks for spotting these...
> 
> However, this is a "move code around with no functional change" patch,
> so I think that it should paste the original code across verbatim
> without trying to address style violations.  (Otherwise, there is no
> hope of checking whether this patch is correct or not...)

I agree that this patch is too big for it to do more than just move
code (please see next comments though).

> 
> For the above example, see:
> 47820e73f5b3 ("x86/resctrl: Initialize a new resource group with default MBA values")
> 
> Other than code that is moved or cloned from previously existing code,
> do you see any new style problems actually introduced by this patch?
> 
> 
> Notwithstanding the above, this series will conflict with a lot of the
> in-flight changes pending for resctrl, so it could be a good opportunity
> to fix some legacy style nits.
> 
> Reinette, do you have a view on this?  If legacy style problems get
> addressed in the moved code, are they essential for this series or could
> that be done in a follow-up?

On its path upstream this series will be scrutinized by various checkers and 
to ensure a smooth merge I would like to recommend that this series aim to
get as clean slate as possible from the basic checkers.

Could a patch addressing these legacy issues precede this patch instead?

I do not think all need to be addressed though. Some of the spelling warnings
are false positives and the camel case appears to be the custom for filesystem
parameter code.

It is not obvious to me that all are legacy issues though ... could you
take a second look at the "WARNING: Use #include <linux/resctrl.h>
instead of <asm/resctrl.h>" ones?

Reinette





