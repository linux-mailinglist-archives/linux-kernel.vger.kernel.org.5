Return-Path: <linux-kernel+bounces-136175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8391989D0C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76B61C23E9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619F3548EB;
	Tue,  9 Apr 2024 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfeeW2Th"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807A548E8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632428; cv=fail; b=REI0GvemlekaH8nMefil17q93rUum3gaGnEp3Gh0j1Jc9kAPB2k24JnqoTY/aoOG6NqVKxkIuOA6deJkHsYuS8u9nfHN7GCLPX3KlsPoo2SRsPvPEph13XpJmBlE1f+IA3rIuSPfn4Ohqb7C3OcixMM8mZhVZ6Rog1Lyo61dNkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632428; c=relaxed/simple;
	bh=0ALHgC36xiY0LdrTdsnSZznlTC9rEsJyjAroaFwLTYQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m5ehN/onz5IokQEOL1nHNMcQOZX+O0gMrofi9NWLy8XaEirABuFz/VCCRakR2dUwR6hxI/mgu93rpLv0eqIEV/vUacRg4SeI+RpBOwEeR5QZZUFTMdfJXbeen03/0H0Ue3RGDWoEb9+eLLi36OL1j0YMV1VANfhe+2xPUHpmwHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfeeW2Th; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712632427; x=1744168427;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0ALHgC36xiY0LdrTdsnSZznlTC9rEsJyjAroaFwLTYQ=;
  b=jfeeW2ThIR5vQieC1zIhx45AxJvanBIhC56iRm0YMAVFbgH5gEUOcGzo
   BISWF4KeLKVuMp4Src/WNk0uFt4Rpa72kskjL/dixXvQTXy/buBkjyAbm
   GNuwuQg6cFo1RZ2LY+44kgMEkfRwxj2XdvS7SinJjjXU59c4/F0wj2GdB
   GJqGI4eIbDEfquI/grLkxFvKYVHOzIRnVc8NDaKXigJNLZ6L4tK7p+rtJ
   ChBHQZHiZaXlmQSF/rijsg/UzTO2tIGCogHT2tCvZwD1srOjC5Mm0nDrH
   SWvyd0L1miFVmegSkPt9+L5akTyFDDmcTZHuc/nYqLbXJSL13PMqy+oUe
   Q==;
X-CSE-ConnectionGUID: Wf4EQsQKS5StfQxNuljDIg==
X-CSE-MsgGUID: W118Ap0QQpuLuh22wjV3Vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8164231"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="8164231"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:13:46 -0700
X-CSE-ConnectionGUID: XYQejQSXT0a95HFZLk4eag==
X-CSE-MsgGUID: xqi1KJGTSnScg6NymVnntQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="57554750"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:13:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:13:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:13:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE++hado1g+KSchT/s0MWMPpFngk1kmC9sEQTGxuzGrf8asug6rDVjxHRCumNu/iKSaZbuorCEuzht4FRVNbIS8TnvrCQDINWffXE0DP/gBU/uQ5eMQIPxmgcI1jFogzHVtAqNt9HS2YrWOE64Njs2K/KW7pXJDNHTZLUPEAEM78I/o8Pog8bp5LPuWVaRsnpjlI6WMJxE18yNUvAWZzvIK5mFSz6axuSsqHSafLiIVVYnRHdSmY6r5X+WKlD2/C/bX2SP8vok3Bh/1xL+xhijgpfChLtpsoC6pFtGLstA3X0vJ4tuL17okuPcf+MmQ2N/d5EOsBVYNtyuADv4fS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6moxvR7xV435uPMzxHpwchqr8YjiIstnP0iMHO64u8=;
 b=fb5xAIUwQGbnRkNUI3PY4q1WAX2HWoa6N78JtuKV5SbZ8q3QSQjwZtWuEINmJpzHOKuUGm6jQLPmPXK02m+/sODc5me0wvR1+5sESnLilmpu+7zZVxdGGCX65v2oc5BummsVG6tzSX+lUzr1CQ22s6EkHFx4SccO5RfkehiHqeaLM0TbtKC9Bm4d5+lB6upqE4XTG9Ms//SqGx7mTG4n6uVIAOWKkfGlXnuyrb7yPUlPS7Bd2rUP6kW9C9mNOFbKAnj/0M98t9WHUp9ub1p2uvkiHTiOCiUWntEsEz3t5IVLbLPTFffiXYPKjsJjizqmStLMj6jDze1aJql4+jWwYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.23; Tue, 9 Apr
 2024 03:13:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:13:43 +0000
Message-ID: <0cbc22c1-a35c-4ad8-8f3b-f7a7b034d944@intel.com>
Date: Mon, 8 Apr 2024 20:13:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/31] x86/resctrl: Fix allocation of cleanest CLOSID
 on platforms with no monitors
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
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-2-james.morse@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240321165106.31602-2-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0043.namprd16.prod.outlook.com
 (2603:10b6:907:1::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4783:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsVUzXx4rusvUs1oifTbwKXaHhDhUFlg1fk1sGOJXwE63OVnCL4k6GlTzj/K/pVRQpkKWieyTyaTjwdVyhzjjb+j9ofXjE93M2DALv/LCD4wZn7Q+++J9hfYr7CPoXvDfK4HW8F37BqHmbUXz5a/7frIcMTFtjeh8pYw0BdW8OwN5VgImVg97CHoXlMRjc/7Ss0Io8zG5IQSwWs3eU2V58wTSd5jX9GEAk8hRa6w/tPYwW+XpCc5ti48dii7wCrcJVvQ19NVBrPni5CNeRbYfYcJG8lnFq89m2IAes8pTxg/sSlXrYravcO2/mDnGBBe6OTGpUbAZEk6OItiOcICQ7y5zMsdzoLyoIG31yD4Gqm8Lp0htFpmnwLemuQkaLPAQgiSvZ2E9PDXA3d9yKQSQrmwsW0PKLgRbxHdXvjs789EtcfzcdM1EJjA43h2HUDiNFOKlyf/HQutmv81h0dH0pK92lQKw+6v5vuedFMAfrSTMIUSDZ2dyu2Qt4Y89iNlTXZjstfrhHyRtX4xFnUZOqX0KbCP/RzvLocYr/mLpfI1WD8qGKIAF1je0BKWwF4WkPZwrfJuNX6xHnB9QFR9a5yGHmTEdbXZxhOXLo7q04OdQ94I14RqYlsTEpZUP/QbNDabBvElOlXN/rEwg/gw9gmCUJ1bVjM1N4zJwjgCuEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sld1dFFIWnlaU3AvbTVZTjh6R2FuZXFjL1l6bDlhN2szMHZiZy9QQ1dFNStS?=
 =?utf-8?B?UXZYcm85ZzBvVXI1M3gzeWRzQXlYbTI4by9leElTdGdkQkxTcUdITXBYL0p4?=
 =?utf-8?B?MDg2Qzc2MGZONGlvMkdoQ2l0OVNyaVdTbTMvd0NxenJvdDVhRnVpYlNPN002?=
 =?utf-8?B?TTBweURMazZmUndkWVdRZk5veW9rbWk4akZZbmwrc2NaRU5SQS9kQ2pVTkM5?=
 =?utf-8?B?RUs4dWlCaXB5ZkJzMSsweGJQbHZQWDVZUkVndlB6MlJrRlNuZUE2aFZjNEpX?=
 =?utf-8?B?MGxKK1V2d21hZ3VDNDNQNWUxMDVqQ2h0MmhZb3Bxakt5enNta2E4VUx2M1g1?=
 =?utf-8?B?QnhYZmxYVjA1ZEl1RjV1b0pIK1BnOTZ0R2x2Z04xbWgwdmNJeWZpVVFaK2VT?=
 =?utf-8?B?RFlxaDdjZDVkS1IvOWhZam90WkRLVExLd2hnRlpBRFoyWld4L2h6N25YM0Zx?=
 =?utf-8?B?d1NIQ3Y4cWFmbldSYWdSYVFNUmx6bmM0YmNqZjBTQmQ0Ym9jVWhhTE5aTXhY?=
 =?utf-8?B?eG1OT25FYzlZb3FtTXYyeVFaRlZoMlcwWnhqdndWMzZnMTZUc1FQSHRuR01a?=
 =?utf-8?B?dGVXME8xM1B6WGZpZjI5TTJpZ3ExcXFENkM5Mnp4NzB3d3pIN3lpcXdPTksy?=
 =?utf-8?B?akpMbHRSNWVaN3dZaUFhWU1VdGo4Z1NCUmgxT3hTWUJ0YnVrRi8rd29iaVJL?=
 =?utf-8?B?dFlWbzYzQ3B2YlJ3VGFOWXFXNzBzOGtzVDJIekZiQUFjMk1PQTA5bzhVWUo4?=
 =?utf-8?B?RnFvSzVzc1gwL2J0VVVHQUN6YWRvSjZ2d0hyTFlQWXJITVFhUkQxY2NqRTUx?=
 =?utf-8?B?aE84dHNSaWdDNFNITTQ3eXhJWkNUR3FEQXNnemdUaUVKUFEyOVdOakNGY2dG?=
 =?utf-8?B?L3pGVDVoekpuVXByNkd0RmxsQnF0ZE5mMm15d3N1SlN6N2tYdFBYY2RYeXBK?=
 =?utf-8?B?RnJoeGlHb2NmakcxV1MyK2pwSzdRV3BhY0cwbEtDRG04aWluYkVyQlJqRG1O?=
 =?utf-8?B?c213UnNuV1V0eC9PTGdUYm0xODlsVEJmREZrQnFsb3A4REpKQ1BnZ1liQVNi?=
 =?utf-8?B?UE83V0VZRmU1VmZvbG1jRlR4cW1pRFROTUFLeXY2aTVObHpvQVRrajZRdmxR?=
 =?utf-8?B?RmIvNS9LRk5OYzRnazlnUXJZZm1yOGNZYjFXcUtUVkpwdFpsaUFRV0FkeWZZ?=
 =?utf-8?B?eWhiNktYekJMbWxaeWdUR1lmaHZZVkZXeFlHSjJvbGw0TmJ3NkFXTGw1c25z?=
 =?utf-8?B?em9ZZWhJbUtuVXVyM280cTNCTlB6VWRNOXkzY0k2SmFiYWdMa3hrUVFlbW5D?=
 =?utf-8?B?UW9odHZPSGl3bFlYYnkxb2JKa2swZEt3ditPN1ZYRVpnS0gzbmorbTBjTmR1?=
 =?utf-8?B?dnJpWVR6dWl0azlMNUcwN056UTB2N0d2em9lRC8rd2t4Sm5SVHVrMFBnWHd2?=
 =?utf-8?B?OEZJZC9oTlFLMHBUaGdzRkYzYXU3YzI3c000WlpDNTUrQStRMmZCNEFWTmVG?=
 =?utf-8?B?RjdST0J2QmtYTEg0RXZqZUI0dHg0Q21RVlg3MjU0YXorODU4Z3ByVEI5aStw?=
 =?utf-8?B?QjVZYW1lWmU4WEhocHF3UWYya2YrempHS2d6Q3dkaHMvQVIraGtRNGxSVW1Q?=
 =?utf-8?B?cWw2M2U0UTFBdUE5eFpyMmNTSmJLaThHRG94VWV1K203aFhKenFNNkZ4UFkx?=
 =?utf-8?B?RjlTVGlPN2U4WHNFelRjWjdDaHJUNEpBdVI3NWpnNlhjZlhCbWtFMlJTaFI1?=
 =?utf-8?B?bjBadnZVZ0VUTU9Yd1A2aTN1NlZOODhvSVFWdW5GSFdBcHpIcHozS21SNW9i?=
 =?utf-8?B?NmdsNldXc1ZFSml6TVMwelZEb001a0ViYUFlTzNjU08xcVpCQzBFZ2VkMUN0?=
 =?utf-8?B?blJCanN2d0VuOCt2ZmloaTFXZGFMM3p3VjdMMFNUcUFCOUZBS05zWHZZR3pS?=
 =?utf-8?B?RHliL0hqYSsrOWE4MFRTZXZzczlnL2EzU213R0xPeU1pdTA2VkhMM29YZXZj?=
 =?utf-8?B?cWVEbHByMmlNRjhlNldUVi9vaVRJYmlQRFJHNUl4ZXRjT1FIWi83cEovcTNB?=
 =?utf-8?B?S1FjV0dHa21jMmVUY0I5OFJkRGJjM091ZUpYWjJCbWozaUlOc01wOHF5aG0v?=
 =?utf-8?B?YmFHWFczS0hiY25kamxOQnd4Y3FUcUtYcDh5SG5FV3VXUVl2bE9EV3NlSjhP?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 934535d9-d317-4a54-a603-08dc58430fe3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:13:43.3329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YUniORiL0+Pef3Y6IE9yVNZ2WlGtqAiIKI//usn87EWk4T4UCCdP5TcS1exJYBWWlAC7TuzQD8zsoITpeIu8E8rfOFWAL+E+AdczWOdSUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:50 AM, James Morse wrote:
> commit 6eac36bb9eb0 ("x86/resctrl: Allocate the cleanest CLOSID by
> searching closid_num_dirty_rmid") added a Kconfig option that causes

Please see section about "Fixes" tags in section "Ordering of commit tags"
in Documentation/process/maintainer-tip.rst

> resctrl to search for the CLOSID with the fewest dirty cache lines when
> creating a new control group. This depends on the values read from the
> llc_occupancy counters.
> 
> This support missed that some platforms may not have these counters.
> This causes a NULL pointer dereference when creating a new control
> group as the array was not allocated by dom_data_init().
> 
> As this feature isn't necessary on platforms that don't have cache
> occupancy monitors, add this to the check that occurs when a new
> control group is allocated.
> 
> The existing code is not selected by any upstream platform, it makes
> no sense to backport this patch to stable.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 011e17efb1a6..1767c1affa60 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -149,7 +149,8 @@ static int closid_alloc(void)
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> -	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
> +	    is_llc_occupancy_enabled()) {
>  		cleanest_closid = resctrl_find_cleanest_closid();
>  		if (cleanest_closid < 0)
>  			return cleanest_closid;

Patch looks good.

Thank you

Reinette

