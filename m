Return-Path: <linux-kernel+bounces-149513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833488A9247
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF05F1F228B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5F954BE2;
	Thu, 18 Apr 2024 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHvkEssp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9FEDF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713417164; cv=fail; b=egd3NnpO+SFkXI7VilJJgF1iCTA6bkPJ7HkbWUTUcfWKEkBTb6NNO0ZUt366AHr5TIflwdNCP3oFQGXIaPL710Qd1mbFPdhnIH2wLEh/nQ23mef6PsbA2I1oz+oI5OanlAdGdidecFkf94ZoyHH+URyIZafQhLXY9FvjZGQHkiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713417164; c=relaxed/simple;
	bh=MyVr3qy6l2TExUyg4SzXITFbncmYrh1/hNMSDE10+TE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nwGoit1VvATXfFWOF2u6bWniPsPaG+CKebjiULmPJYzH+neSrIpNl03RqVQghAO7H+eJoZC+eD+CV1cRA0S67NO59S/h/6alq8bUY8yaZNZQvATM/bFpCeRhAXkUPiZJcxfS6RDQIMAXaSqzNwvNP8bjmWeMf0EFObkmWDKiMEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHvkEssp; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713417163; x=1744953163;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MyVr3qy6l2TExUyg4SzXITFbncmYrh1/hNMSDE10+TE=;
  b=PHvkEsspEyFJjeUWU9ETv+KuTjsktMpGQR+6L/flSx/LVmzW/fvfuayk
   ApbRgxCjixho/f30vacjGyO4ji7s67z7ghb5AptSBQJvQx5dug6qBQyUc
   q6JMYcf/5T4PjpXwWrgG8WjKpJrJyqp2DgG1+8E8J8JylyMFGh+2wvE2V
   LVjaYBaeuaTedUq3UP0Fi2TwMEjixXGWw4ACZ4IMZdFGeebJ4VUXEyQQY
   65VHJaQgqyp3WH9qDl0kyF8tOs2fBqLHX0l922AepKritJZCSpb3qSWbG
   Xa/xngRrBDN7Grbl+F1u2rlajPL5GGvb4ZxGGjgNbPRVwjY3MI1CnZvlk
   g==;
X-CSE-ConnectionGUID: Pc3mPOugRDy8YngOCLfFng==
X-CSE-MsgGUID: uBvuO7aYRPmWcqVxE7G5TA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12778041"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="12778041"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:12:42 -0700
X-CSE-ConnectionGUID: k9oCm7OcSuGso7nJ+JZM+w==
X-CSE-MsgGUID: 9N3SfdExQ9qQgkYq3R6Tbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="27625963"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 22:12:41 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 22:12:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 22:12:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 22:12:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB4QJ3/MaxCikO6nysLGlCUdhXTMvDBXT5FwLWl1Vn6+W8DavKJt6Ci5AeWUAwA6acPB7Kd7VPsdkSk+hLnZPyiqYVWUFJr6z/9dWr30mKwjRGxpRv4jsW+y7/BzfIvlMwdbuidfn+NrcCpDJSYaoetXM1/4RVJ9OBbPwJCZ/hPFTSj9RftaRTiUoUv9BZEsiPS1dHTq0wlRU42UEQL102vqNs53kEPUYjVfMCwfA2/ayQ97fwme8iz7bq0eyTVhVL1iiINGjeQcSDT+PTjNL8DVVMm16uT6qOziXs10Wp0WXLGDF5UZIzWyeVUYRc1g29BZKxnGFhMit+oMBdwGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h4aMHiXw/BFinsJmST/D6ivQxD91ZkUYyK/lcH0gRk=;
 b=WCfRSRcBdPVl6s25jhQUkuR0c++nt/gtgHEwRI5DrwnAg71vb1RZEIcR0VaeSX1eCpeOpXIyg/DtJ/2mxkpB8PjpTboY++Q0Mglbxdj4CGAPxej5OTB9d6IE+J9uYbfj/2JJtRJikDJOv24UQrPNBTSqvPftYlV/uG47zJGX4oKRz36I8i8nKiChilYt/C5RodZ+6RuUQHfC+IaZ+AfV2C+yJHg54tNOBIno0hBzVcGhmMC+oU9ZTNbdztXyTHqj/fxBLp9owPzGHyEO8rhxjwAcfoOOCCRFasj7VnYlvCLLR0L46ouyzEmatH2e45ENxI/vNywpY6jmbOuMa6N7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5212.namprd11.prod.outlook.com (2603:10b6:806:114::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Thu, 18 Apr
 2024 05:12:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.049; Thu, 18 Apr 2024
 05:12:39 +0000
Message-ID: <069c0e2e-81e1-4343-8a9f-21f1cb74bde6@intel.com>
Date: Wed, 17 Apr 2024 22:12:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/31] x86/resctrl: Remove rdtgroup from
 update_cpu_closid_rmid()
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-6-james.morse@arm.com>
 <6bbff669-cbe5-4284-b64a-4825a541b35f@intel.com>
 <ZhldWJVck7VmU3G3@e133380.arm.com>
 <0698418a-aede-40d6-90ce-dbf6e8796916@intel.com>
 <Zh6kchkH9Dy+ywXc@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Zh6kchkH9Dy+ywXc@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: a795e9a5-c436-4542-31a9-08dc5f662ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnekXYxWhzk5gMwWE3aIz4nvhbP7EmXmKnUG1V6uBjTFiwdoljmiBiowh55Q3OAyEegruiVIq/1An0c024sXE6RnbS5XGjSMka5sOAz8yoLaKjy0f8+kKsiBzjoBjz56TlMpPbZi77pNs/R/yIuBf48T2ggxdMK9wBR20vmJ+k4q5PMIV1UM6Sb6pjUkUzaSB2O7ejRA8bxA/mwvyMwwNIRAz3lPD4sT9nW0Vhq9ubiX+A7io9Eg6XLBDy9bFEKN+7YBMRNWKs1/A6NooLFx241QwfgUUm66ZpZrsvrj25slvmvVmrR1QFQPl3J6buv6f0zFVrzEhtfG/msLy4ll9Fe+KoSSMBG0qRZOXIvG9cgK0JSi3CelT8u4IDj5E4+6a7/TwhDNH16bv4FSPqZ8gK+a5JiSSOzdyt87loMdn+XjTygPAxBEV2RncS464VScEfAQT1O8RLMA3vFGcsvoFCocniGRS1LKDQ6Xaq41u3JjMq9590hYbEwMT25VeXK9UIlnMqVEqjR2iY6Rcj8htx1tkrNLfjYn6Hbt3OidPsvbBfx8glz5xj+F9Jwgenk/yn0M3r9oTfGKk96M+YvrOaj0g0Co2FdeqEu67mWceP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlZVWXFvdzN5NldrbnNmMGtLaVNEdmN3QkgyQVd4bDZlZ1pqSFRrS1JPakFY?=
 =?utf-8?B?d29qbUVUaUVkWkJXSjFQN2oybktXZTJ0REFFT0FSdVhmZ255b2xkY3NBeTA4?=
 =?utf-8?B?Vk10Rkk5eHd2eFpLY1FYbkFQbkk2WGIybVgvRnlGYWhMdWN4SUdqWGpHVVgv?=
 =?utf-8?B?blFKZEVCa0gweDV6clc0NDRjb2FCR3J3QVNzQkI2WUZJWHQxT0xuQk11WnFw?=
 =?utf-8?B?WjNDWXpXdklVeGxISEZjWFpGU3RqUWJyTkZMZ29TY3V6TjNsdVZobFlnd2tT?=
 =?utf-8?B?N3YzRllST2NIUVFUREIwbzNLMTNCc3J4cmpyOEZhcUxUV2RiZDZrb0xSOW5U?=
 =?utf-8?B?Rmo3SXBvTWJkZmtpejdublJUcFFaYno4dWtTS1pObDVHem1DdFhBTXMrSkdV?=
 =?utf-8?B?dGpEaWhzMzZ1UWVwVjNicms3M2JRLzZVb1lYeTFFRC9GWlg5S1RicGFnTkhH?=
 =?utf-8?B?UGdYdzI4UE9VMDhCaGlqeHgwV3hKY3I5MmNJUUU1ZFB4VmowMzFhWHhKYW1O?=
 =?utf-8?B?UUg1MTZyNno1VTd2dmFsQjZlT1NoakFlK2V0T1lnR0hZRDgwWVhQeVhaRWZm?=
 =?utf-8?B?VVVBdUNYY3gyS0tTelU1cmE0ekptVFdlWXpFNGpvR29aZEF4V2t0cHZyQ1Rn?=
 =?utf-8?B?S1FnUnFZTHFNWnB0NncrUHQ2RHUwSzFlbXRBQ2tBWFJxT0ZVUjByekhLeUxp?=
 =?utf-8?B?Rk1qczRHczVEZGpJaEdveTNCWlo1Q21jenh1Wkg4MVdEdU81ZlBnUFZzZS9M?=
 =?utf-8?B?WkR0azB4MkdNNDJzR0gzdjNlNWJ1UjhPdWV4UERDWjlTL2doWm9yQlB2cTJT?=
 =?utf-8?B?anowU2gxMmROYmRMUWhVcStwRGh0U2tac2JKUDJxRXZ6Vk0rVVhVd2xUTVRR?=
 =?utf-8?B?NGp5UnNUM1M2NjJBSDBFNjRtMmY0ajJKSHhINVlERCt0Q2FPTjVEekVHdkUr?=
 =?utf-8?B?bkFid3NYQU1rdEF3MFA3YmpnQWs2bzlydWVqVUtTd0hqd3F6NlQyZ2ZuUjc3?=
 =?utf-8?B?U1N1ZWsvdFQrYVR5czFQeHhjbzRGTUxkRk50QWRnaStCbnhWWXFEY1FzWGlY?=
 =?utf-8?B?d2RzbEZvOEYvMFVsQ0hwcktCZ1ZFakhyUGxoZTlqbUJINEZhMnArSkdEcThT?=
 =?utf-8?B?NHFMOGNSYVhHak9kSjRlWU1BczAxL3dERk16TWFzSEpCZ2o0UktDaDFMaWo3?=
 =?utf-8?B?R2FFM1N2YkZ2V1JrR1hSOEVCNWlrQzdxN2x4U2cvSU84V2JDZHU5OEtwNlZB?=
 =?utf-8?B?SHloVFNLRXhkNklwcGEvYXh0U29tNFI5bGhIeVBLK3hIS1prRHB1eHNmVjRo?=
 =?utf-8?B?ZzhMVGUya3ROSG5GZE5yMnlyeHVpUW51aVlhclpxaW9LRHNsWTBqa3VmYkta?=
 =?utf-8?B?c1NPT2ZUdnZKazkyN2g3c3pDSEhyYm1SU1pyOUN3YUxyWjQrSElqWmJjT3NZ?=
 =?utf-8?B?NzV1L0VZdE1Iai9qUFJnK0M0QTE4clFTc0V3MUQ2N1NaOU91VEZ3ZkdHVnIv?=
 =?utf-8?B?amwwaDNVb25FVFkzMXU1WW9IbVZsNkNmOTh3WlNOWXZvM2tlUlQxRit3MnNI?=
 =?utf-8?B?Y1lvbEpmVTZ4UEI5Skhvc1VkejUzRUgxRzd3cDlqVzkvQkpHakwxMDZJZ091?=
 =?utf-8?B?TEhrOVRSaWg0T0FWK1ZJREU5cmNMckVLOXM1MWdUL3R3cHFXcW5oaVV4Y3BQ?=
 =?utf-8?B?MFhyZ0x0OGdNOW9aTHNkMnp6cVh0aER5OS9YME1ZQXNsK290TGE4RkR5TG5Z?=
 =?utf-8?B?T3lyamMwV2pidERXYWpiWGRHZWZYcmpNMzZrZllWdnplSmw5U2Z3SnBjYm9w?=
 =?utf-8?B?S2lEL0JDL0xrOExhREVIMW5SQ1BaOElOWVdEZTlVQ21LeGFYWk5IR1FDMjhr?=
 =?utf-8?B?M3JOb05NOVRZZUFDK3VzZnVvUHVpY29ZaHhSbTlyTSsvbEd4STljRGRoL2Fm?=
 =?utf-8?B?NkJRZHlja3k4ZFdPM1FkMGtoU2d5c0hTclc2VHFIVWFLcHU4OTlVME1EeXRX?=
 =?utf-8?B?OGFTNkdBSmxKUDZLYm5xYUdRZXFlcGRpSzZ6cXZGYmQ3MHRhNUkyZmw2VjdI?=
 =?utf-8?B?enNiOFhBb1J6djdTbU1tS21PK1M4YmsrckRyMERqQ3NWR0pIa3RVWlZUWkRE?=
 =?utf-8?B?S3lmWmlQOHJUUDBXRXBraFlpSlRHVUFmUEtXc1hIUFZ6N3gyWGJjV0tXR1BY?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a795e9a5-c436-4542-31a9-08dc5f662ace
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 05:12:39.0569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lngrRq/RS7sv+TmR12b1XH1/qR+S2Vnstnr6M/w1ReTD/WxvyDeRLY/lT+EKSTbaNIUBIoXTw7qD0v5q354vZReDPF5OKra82r7ceVTbQyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5212
X-OriginatorOrg: intel.com

Hi Dave,

On 4/16/2024 9:16 AM, Dave Martin wrote:
> On Mon, Apr 15, 2024 at 10:47:55AM -0700, Reinette Chatre wrote:
>> On 4/12/2024 9:12 AM, Dave Martin wrote:
>>> On Mon, Apr 08, 2024 at 08:16:08PM -0700, Reinette Chatre wrote:
>>>> On 3/21/2024 9:50 AM, James Morse wrote:
..

>> Do you imply that this would maintain the order in this patch? It does
>> not look to me that it would but I may be looking wrong.
> 
> I'm not sure without looking again, but since this discussion is not a
> good use of your time I'll just go ahead and implement the change at
> [*] above, while restoring referse FIR order, if that is good for you.
> 
>>
>> sidenote: the "on_each_cpu_mask()" in update_closid_rmid() can be on
>> one line.
> 
> I guess that might have been split to stick to the 80-char limit.
> 
> Due the the small size of this function, shall I just rename defaults_p to p?
> Alternatively, there are already a few non-printk lines over 80 chars, so
> maybe we can tolerate one more here?

80 chars are not enforced so strictly that it impacts readability. You
may refer to how update_task_closid_rmid() looks for more confidence in/
motivation for placing this on one line.

> 
>>
>> ..
>>
>>>>> + * struct resctrl_cpu_sync, or NULL.
>>>>> + */
>>>>
>>>> Updating the CPU's defaults is not the primary goal of this function and because
>>>> of that I do not think this should be the focus with the main goal (updating
>>>> RMID and CLOSID on CPU) ignored. Specifically, this function only updates
>>>> the defaults if *info is set but it _always_ ensures CPU is running with
>>>> appropriate CLOSID/RMID (which may or may not be from a CPU default).
>>>>
>>>> I think resctrl_arch_sync_cpu_closid_rmid() may be more appropriate
>>>> and the comment needs to elaborate what the function does.
>>>>
>>>>> +void resctrl_arch_sync_cpu_defaults(void *info);
>>>
>>> That seems reasonable, and follows the original naming and what the
>>> code does:
>>>
>>> What about:
>>>
>>> /**
>>>  * resctrl_arch_sync_cpu_defaults() - Refresh the CPU's CLOSID and RMID.
>>>  *				      Call via IPI.
>>
>> Did you intend to change function name?
> 
> Er, yes, I meant to use your suggestion here, so:
> resctrl_arch_sync_cpu_closid_rmid().
> 

I'm a bit confused here when comparing with your response in [1] mentioning
a change to another name. 

[1] https://lore.kernel.org/lkml/Zh6kgs1%2fbji1P1Hl@e133380.arm.com/

> Also, Babu Moger's suggestion to rename struct resctrl_cpu_sync
> to resctrl_cpu_defaults seems good, since that accurately describes what
> is specified in the struct (and what is *not* specified if NULL is
> passed).

Sounds good, yes.

Reinette

