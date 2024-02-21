Return-Path: <linux-kernel+bounces-75626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB84185EC2B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1958CB232EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05F585268;
	Wed, 21 Feb 2024 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElA6xAik"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD31E520
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556392; cv=fail; b=eXIqIyaDjGkuy18XlmCuUjGuvww+Ev4c18avyZOfydsb2xfmJuorfbsg7o34UgSOhjmbM8iJOvZiQA17Z92ETaAEhFrs42lRODiiLYyzKkrL4SBHAnSDr8qQ3VbbMc8Yc8chV4/zL6u+qGOBSb9XrQ6XmPPdEoymjWxrISbTsIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556392; c=relaxed/simple;
	bh=ecxgIK+Wb8KGPNlYCavmQFPtnPO68jdvb9IYROvl8i0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ReC6RcYnbWZEsaXCuD908SawhuUbVtG36ChB9TjpPaVyUoJJTn51wpuTw3Ocu0SYxg4Y6vUs+VK/AeNILu4i9gbRBCQkqpfboH9EqFxQkxD5l3ZMZnJZ5eToGC7HLZqocgnwjZGdL9gB99avgz4MVLo5Z1/Fs27hCHh9EgXQXHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElA6xAik; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708556391; x=1740092391;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ecxgIK+Wb8KGPNlYCavmQFPtnPO68jdvb9IYROvl8i0=;
  b=ElA6xAikh9kywH4k/h0jWkw6opyrZGuB5mEbOuUPtTSwNqAuMT+OpCSs
   7lqTf90FAf3hZqO06+eB83oSJ5AiJLDQJvexRxFYT82Fbmp4NrgsYje8V
   8k+05Mm2bRWVtZ6tfT7CR4rM0FHWQUHSOUkNZPw12kiGUlHzu87AP7J+c
   xrcfyDG/HlGjLq6YCLaZZXPfOZJUE2j8kbeB1SJFNcQtYzS8tpHLtHWcV
   PMIFCKezJXDYmkfXpdBV9RK1WAfm2dkK9Nage0h9LX3bxySaavvh43mvV
   5Sd1HqvNBZdAauVUKVkWTiE/S0YDx1mltmN0ffLPnUnJkcU+KwczX6h4j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20181064"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="20181064"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 14:59:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5649067"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 14:59:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 14:59:49 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 14:59:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 14:59:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 14:59:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/DUjrhYOePBrVUoL2bcpsZQS8FHn8gBpe+0S1hQSVB4Z7P31dmbnx/nS5JM71+e21LF0K4cfWUrN3gu1hiwwixzQLmnjMXmo1h1XXdRPfzg6Aw83BhQ2C9qSa2bNbLvqrunyxW7DNujXC+1p3mb6ykLDSigP+tadsyCC+9CDB+2i/6GjjsPtLOWYEYqObas7ZJXS/A6A4+5GQRglsOe1+FXqcsX2n5gzAWO8I7kp5EmYHgDAkOMlpjz70ep0bUoBZDXaO3WNiJhGZmCmFagc2HMyHSA4pJmDpvHuvXvs/iBOYmnZYHlwiZX0ECZF3rSqjEcNzsoHUWNV/bqiRHlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15lgqJfYXk6UzUjE8QkDWB2v5aCgbV5P9f9syQb9l1c=;
 b=PBlSlnBBaQLiHO68iCXoV7aMUkv2mB270pu8Ba3fGm9EIXY3O5bYW8PdE3td0ka3pP0Hw/K7bejot87nD1BrGtxBNl5lmqz3ACck0g7g3xSsAPrm4yDmfjnizpP8H6sghN59auBx4LlVDWDrFQy8YuFSWMVb3U3UM9mA41hv70J2FLQw/VY+lE+sjQCksO6u8OC1ldxHe7UV8nMOrXtpaZLdy9Fsax07mUlfq4IH6A6+ox9+9aYARGlDDqDF2vvuXALo4TRUotBRPmdrpaGBuA2K5LRLk3kALD4VUz7IsukYYL8qbzDe5HXCvxmFnXJ08yQRaI1hsBme/AT/UDa0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 22:59:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 22:59:46 +0000
Message-ID: <89745b84-5ead-4694-b14c-341ca5a688f4@intel.com>
Date: Wed, 21 Feb 2024 14:59:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/resctrl: Fix WARN in get_domain_from_cpu()
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
 <ZdVFDIJmctsNaGd2@agluck-desk3> <ZdZPht8hY4J9uIOz@agluck-desk3>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZdZPht8hY4J9uIOz@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0182.namprd04.prod.outlook.com
 (2603:10b6:303:86::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV2PR11MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 35eeea86-8b40-4919-e2a5-08dc3330cc5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bp2IQgbsf0G+rUDvl5XZ/7C/9nyK94m1Nu6uMNqK8WcQ2f542T9K3pr4coRT/fYydnwo628q/oeTlyX6tUWaIAvD1ABBIzVjAJ5jKIc1sp+8t8FZC4A/7neyhFnnValASgVAQM4rbw7y/sdNEy5Zkav4Vrqpq1xMabInvujG12QIKt6rFzTRisWz4hdidpK3ev9RARIha0mwOmA4FdzEyxdx1n37EKbq2WSrt5s52lw7+OxgGdf36wgdWeMNbVkcjiLfFm13bvoQmrypFzpRqqK+MEoUN49NUZXoGtGKIh4LsPiGZix27Sz8g44mqFo63dDE0jeLPqNjcnMRGmRjtXHis8MolTroLaLwAgGW9gfjlMrb+ReLNdFvH0sSiwE8kef5HSC9YauMmV/JUvcYbIRtFT/OQb99TehvdQ/TcujgWSAHftFVvY+qZgE1aBGpaUolp7TFIw8+mN5zkjM8/UlqnhXtuRIcTg0nwoTtyh8vEPZClibpDol+LNiPBO0Gkd650WI2/7NHCfRUW84Fhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vnp0ZmUwY2NuTWpVa1VDM0ptQjVYaGtuaFlwMFNIV2RoTFpEcnhTRWZqQXZu?=
 =?utf-8?B?SDQ3MHBCQ2xlY3VOVVl3Wk9lRlRWUk9WUHhhOGJNbm45TXhSQnpML0NRMDBR?=
 =?utf-8?B?Z1htZ3JlQWZkOUtZQ1JZeU1KOENZeGdrWVc2dXRCQVJvU1lQcVpabERFdEt0?=
 =?utf-8?B?QmNBTHNqK2EzLzFKYmtqbUFWOHpIK2poNXpKK2lhYTBVT2hvQSs1WE5ndmVt?=
 =?utf-8?B?eVI3bm44N3cyOUNJb2pzSDU0MFl6ZmZSZnNqekE4K3hSRmIrRmpNUCt3MUE4?=
 =?utf-8?B?RHFsNUhzQlFhdlpUSFB0WGJmK0VQMVJGNlBmajZJMEJTbC9DVHdrOFloZnFw?=
 =?utf-8?B?NDhaRWkyb0h6cWNYK2VxQVNyRUppeDZZMi9qZnFQeGpXaTNiRU5LNVRETXhS?=
 =?utf-8?B?MkRKbVNNRjRGZWFQN0VkTDJVQUZEZ3poS2R5SFZCbTZoU2UxdEl4ZHBaNG5I?=
 =?utf-8?B?d3REY3dKTEdBbDVRM2dzT0NvR3dFenFidnRPaU0rR0Z4R200WGFrcVdTLzR5?=
 =?utf-8?B?Q1FQdDVOYnFNRzNiV2JicWJNT3VIeHJuenJyazBqT2JLL1lONjdCejJnMlBC?=
 =?utf-8?B?aW9rUjd4bGQvR3hqRWhxakFIWjZ5NktuWWdORCt1SGVrWkFxUUswZTc2cTJr?=
 =?utf-8?B?Z29yQjBWeVROK1JRUjdsNnNXVi85NThYMkNncmhDTnhxWk5PL3ZkbGhqRmpl?=
 =?utf-8?B?aTd4SThYVFl5MlV6SkxwbVlSWTNwdFZWRHRFaDNrS2NKTkNpOHdRQjdyZlVR?=
 =?utf-8?B?SVJCNFhLOUF1a2hKMFQrV0xTMkpWNFh6STJMRWVWOWZlYWNqTnd3YzJrbkow?=
 =?utf-8?B?aFpEalZNSnZkM2RFcE10VHhwa25iVEloSCs5UCtsbmFWRXNicHFIUFh1RlRX?=
 =?utf-8?B?ejRybUpJUTljWXVxVFFrM2x2eXFobG4yclBja0dsYVFka2h4TW1pdFpTM0xS?=
 =?utf-8?B?NFJYT3FqQUtBaW41dTVob01TOThzL0FlR2VTdisremJMOGZWUFVlakZCanRn?=
 =?utf-8?B?OUhYUkxOaThnTXc5aUYrQy8xMFY2R0FZVVVaWU9ld29TSUpmS21NVDl5T0xO?=
 =?utf-8?B?K1BPSlA3cEVIV1R1Sm5ZbFNUWmJWZ3NpU1dmU21DUm4zSXVkWFN3M09jeGJD?=
 =?utf-8?B?UW01VHVOb1RCaG9QSlkyNGdLTGowUXhkUThqb2lKY3lWQzZCYjUzWXhiQzl2?=
 =?utf-8?B?WGJRQ2wxSXlZL3JwdlduV1N1TkFwUXVrYkw1VlZSVHRvUE9qUmJBOHpsL0pB?=
 =?utf-8?B?bHZEd2p0UWM4a1JtYWdVaTd6aUxGanJQWmFWbGlzR3dGY1V1azdTb1J2RkhX?=
 =?utf-8?B?cHBWTDErNm91dUF3ZzdldDJRMDhyQ1QzQ2dCNDY4a1NyMkIrN1JJbUsvemhB?=
 =?utf-8?B?RytkWjhHUFlva1ZTcDhwai9PejFodVlkQzg4RzFwN2k4enduTWY0Z0RWS1RJ?=
 =?utf-8?B?c3FOOHF1VDJVbFcrdkxRa2lkSjNvbWw2WjBXU1pQSW5xRHZIeFhoS1cycmhn?=
 =?utf-8?B?elRYdEkyS0xPUTlob3B4MHphekJJbEx2Mk5nMGplR1A1QkxwdVFQemR1bkRr?=
 =?utf-8?B?N29PTlZvNVB5M2VORzFVTUhzamxJcSsyVCtFUDdoczg2WHZ4cDI2NHVHaDNw?=
 =?utf-8?B?NnVqd3A2UGhXY0R4TERMd3pIRmd2anRXQjdVU1FzdlVkWVVoRXlHc0M2ZWpR?=
 =?utf-8?B?eEJoMk84QTg3dExjT3BHbkRFcWsvUnFFQzVjZkJsaEdnYTB6bHZ0eWJsZmxi?=
 =?utf-8?B?WmVWeW1YSXNhVXNzc1VXbzl5RXVpcGtlSXhpZ2pJQmdwQnBTQXA0a3grUkxO?=
 =?utf-8?B?aEtqS0puRDlzbGRRMkthWkFleWpGeXA5eEpsWDdITDcvZzFhaVZRZ3R6dXdF?=
 =?utf-8?B?RkZCVWVRVmgvaHZPZy9udHlyYVRFcExwdkJDaFNtMXNMdHhtcm9ORSthbmY4?=
 =?utf-8?B?aW9DQkx3U0F5Z1lQTjFOZzZIVm9Pbnh1aUVmZ05HNFFXWmRpQlRBRTRkRDN5?=
 =?utf-8?B?MW1iM1lmWFRCUWJCTzdBNWtjT2RzQVZHRlQ5ZmJ1aXlWTnNxaFAvTEJQWkUy?=
 =?utf-8?B?VWJPS0d3SG5sdkV1YVNWV2YzdWJYTVg1VHAvdTl4SzRrZkJCL1Z3MUR3TmNC?=
 =?utf-8?B?bjFpenlJSFFEamU3dUNkVFZMaEJ4b2t3TVRHVFJtUnFLWVJTSFh6QVdHd1gv?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35eeea86-8b40-4919-e2a5-08dc3330cc5a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 22:59:46.1090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tw6UTbYmxq7n0hvRAtWJaHq7TqBcHOLXkhVQei1W0EgEkvM2yOk1l+nT5PEhrE5bKv5yt1FENG2nRLM07JkiwXY7IFo+UXcomeJK8xw3WUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6045
X-OriginatorOrg: intel.com

Hi Tony,

On 2/21/2024 11:31 AM, Tony Luck wrote:
> reset_all_ctrls() and resctrl_arch_update_domains() use on_each_cpu_mask()
> to call rdt_ctrl_update() on potentially one CPU from each domain.
> 
> But this means rdt_ctrl_update() needs to figure out which domain to
> apply changes to. Doing so requires a search of all domains in a resource,
> which can only be done safely if cpus_lock is held. Both callers do hold
> this lock, but there isn't a way for a function called on another CPU
> via IPI to verify this.
> 
> Fix by adding the target domain to the msr_param structure and passing an
> array with CDP_NUM_TYPES entries. Then calling for each domain separately
> using smp_call_function_single()

This work contains no changes to get_domain_from_cpu(). I expect the WARN
within it to be removed as intended with [1] and then this work can build
on that without urgency. As I understand, to support the stated goal of this
work, I expect get_domain_from_cpu() in the end to not have any WARN or
IS_ENABLED checks, but just a lockdep_assert_cpus_held(). 

Do you have different expectations?

> Change the low level cat_wrmsr(), mba_wrmsr_intel(), and mba_wrmsr_amd()
> functions to just take a msr_param structure since it contains the
> rdt_resource and rdt_domain information.

Could moving the rdt_domain into msr_param be done in a separate patch?

..

> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 7997b47743a2..09f6e624f1bb 100644
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
> @@ -304,59 +288,50 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
>  	msr_param.res = r;
>  	msr_param.low = idx;
>  	msr_param.high = idx + 1;
> -	hw_res->msr_update(d, &msr_param, r);
> +	hw_res->msr_update(&msr_param);
>  

Is this missing setting the domain in msr_param?

>  	return 0;
>  }
>  
>  int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
>  {
> +	struct msr_param msr_param[CDP_NUM_TYPES];
>  	struct resctrl_staged_config *cfg;
>  	struct rdt_hw_domain *hw_dom;
> -	struct msr_param msr_param;
>  	enum resctrl_conf_type t;
> -	cpumask_var_t cpu_mask;
>  	struct rdt_domain *d;
> +	bool need_update;
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
> +	memset(msr_param, 0, sizeof(msr_param));
>  	list_for_each_entry(d, &r->domains, list) {
>  		hw_dom = resctrl_to_arch_dom(d);
> +		need_update = false;
>  		for (t = 0; t < CDP_NUM_TYPES; t++) {
>  			cfg = &hw_dom->d_resctrl.staged_config[t];
>  			if (!cfg->have_new_ctrl)
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
> +			msr_param[t].low = idx;
> +			msr_param[t].high = msr_param[t].low + 1;
> +			msr_param[t].res = r;
> +			msr_param[t].dom = d;
> +			need_update = true;
>  		}
> +		if (need_update)
> +			smp_call_function_single(cpu, rdt_ctrl_update, &msr_param, 1);

It is not clear to me why it is needed to pass this additional data. Why not
just use the original mechanism of letting the low and high of msr_param span the
multiple indices that need updating? There can still be a "need_update" but it
can be set when msr_param gets its first data. Any other index needing updating
can just update low/high and a single msr_param can be used.

Reinette

[1] https://lore.kernel.org/lkml/20240221122306.633273-1-james.morse@arm.com/

