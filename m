Return-Path: <linux-kernel+bounces-91392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FCE8710E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D561C221FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6CA7C6C6;
	Mon,  4 Mar 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYgQxckB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E11C7BAE3;
	Mon,  4 Mar 2024 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593662; cv=fail; b=iLdIsf+RjEs/yt2H5k4rQi8QcBvp4l0/2DOYa3lwpcXwCPQKXYEOL7fUqqDjQtqtxMqRP8+n61qfC/RfxF97jpVpJzyq03kt8phRtV19yOJysiAeZShFANBdBBL7LRsOf1YzdnXUBw+16DqHGblHDfJHVl3tEYJ9x6YtV/huEyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593662; c=relaxed/simple;
	bh=34lP4tF8CdcyAAloeasFLDyOB0AfMTLzmeJhMKflfxk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uO62M4Hnq5HRC7sesAwO69Ywqhr7Pb3QeyUgxEbbgzY1uBxQe86yhLygC80YVl3ajGg6EbObxZt66wf12xh3FAioSm2abdY5xY6z5tOMaXxnvuMv4sornjH5BDBpiERPpjlQYMqaegpip3+iGY4vPN+cd0KVTiioArhYP+jwh10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYgQxckB; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709593659; x=1741129659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=34lP4tF8CdcyAAloeasFLDyOB0AfMTLzmeJhMKflfxk=;
  b=eYgQxckBDDsI4UnwWjRDGQ1UaaPF4aD1ZA1OQ0SqXSo+x0PIwW8HD7pA
   5AjVEfzEiv/4NxQ53Z7/Nyxh7oB/1y/V/1nAG3i8s0XrycS/8eg4a0TH5
   xy4EFBICmHRYkD5stpqgcgvre7wGcHXyC1U3pTmxmXV2UCVGDoeO+I4b7
   HhzAlGyEXQRbnzy+J+P92wnt1XXIFp+o2Jz1xEpQTSuNIF03d4hnUqx0o
   qFUQxw583kbQeBLP+TYK6Jv23Rhf4k5E3bD3hj4+9BnLzaW/Y5yUbZld5
   YLZEr6/vpZsF5oCS3Y0Syutj6nBXyCVPmujul5CA/eUkRf6ry3dlv8Hg9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7060156"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7060156"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 15:07:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="13831457"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 15:07:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 15:07:37 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 15:07:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 15:07:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 15:07:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4spuyrAVq7wsMfeGHigeKayElX1iULmDUWPPcjjaA3AC9+26KHrZvEWsLkubLgPR+u9Jo5ASGsjiAa+Ne2zcjdSjeiSc0+fMcB2V82IY9bJB34L91exHw9iATHz06omsU7YGVoGKSTH1BEOfhfnJWelepSt8UH3IrDsaQOYWnwqT3dkVqdgcYRh70e5/hz0fQwqdq5aw8g81NT+zAfIML/k8phW38cqI69V/oxZmpdjU0ceRYOAZ7mqyNPyopa+ZajhjZGlH110in9a2Pwo5YCRBiPek5ypkf63o7FoaA7TyV7XIQllvd+joRLHZ5VfbLu6rP7fYR2HxeAGElBlqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrtdCoSqkM22WRppImAHSwl01EFJfF+/7S+cwjt3i5Y=;
 b=Wd2VYUwG5dPMpflrCd9tbd/jGnCevbLVUrUUU8LEL0axvSZ/8+zKCvu9aOjVwsdAQcSNjOsfVFAKfhsw8sZI2NSAw8SU1hjpNU2gHOyuUQdEHEEsl91Sio4ZlwYXrCBY5Ade57jrDNx/8bOQ4oU2vZNHzVNY5pGaETniMEyFVj5BA+VfRviI40jZgDHexV8xj1pk7RZCzNkZGAVYFTK8y+2ONr1dyk1PIxkaeRVYJVDgogkUF//hJahjGOPeIYnE9B2CuG39EXk127ZXlnL83spi6k2G72qZA9qAMorl8yZE3gk3KhlGZxZC2KL33Lz4NMq/pmx9W73Gl9LwIZ3GOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 23:07:33 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 23:07:33 +0000
Message-ID: <12766261-26b2-4aa4-a735-c2380c4963fd@intel.com>
Date: Mon, 4 Mar 2024 15:07:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] x86/resctrl: Pass domain to target CPU
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "Peter
 Newman" <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <patches@lists.linux.dev>
References: <20240228112215.8044-tony.luck@intel.com>
 <20240228193717.8170-1-tony.luck@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240228193717.8170-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0250.namprd04.prod.outlook.com
 (2603:10b6:303:88::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 666109f9-aa9b-4bc2-b7a6-08dc3c9fdfe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUhKClxV/pBAfFvlyvTJsuM7kVDg26FAdFLKvHsOFcfwKnLrscmawCap48HDCVFrXjF38S3PNtyCEN/MPjWxhE9B2abQkvVca+3t/U24uCGXJG29iUEV0lJXsyftiRk6QQhRH1Bqi34Y6lRwUZhncUAxjzhwYwms/Se+cUzCfjSIHL82PThEgcvEfKix2e1/4vza7J1FfR8cELH04byKnRJt/wf0XSnKzpq0xIkeFglDhkreGzD5Djii1zcRxx51+65/7d6JO7+dYTJ4DRRnM7ztMonp+uuw+EgdnKwbTDtc0oOpEpGlxPCMaoAaOl/kUYMS7T4zyXlF0qBOlxhxSYCF6r1UI1lg/oSLrFY4G6wA9zhbPoy2xUgZEK8dGNiEr9MjGIKQUBiWwZXTzNGkFfolAU1FhZPas/+paOLMtaG4I/ODRIJUFZuWHGdcIs03pbRE7AnqZIkpSVa+ml6XmkfkiITGEKjKPcQVfFy0m5ftM3B9Tn0Y15Eu2WcBok0hVwR0zudy9ZdGa4pOdCtD+nDU7kogRrQioS/cTt3F/FvXWC621/YfVYFGgKfbRxsbAAddeq2nR/psw1X4er/aOooF+bnL0o2lqZ+sntr8V817PWRPekdb7RqopHIeeAeqX+NJ5naVCpWE90i/jXDLK+Q7mC/0+BQRGpSj81xvZc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTcxYStrT0ZmUUJDdHVRZUIwbXlQRnd5NXpTY05CLzBuaDkwSzVoSlNEcFFZ?=
 =?utf-8?B?QmVBWW5YSVg5amo4ZTd3QU12WlU2bTRWZnVuNzhRTmhoTDdVSGhlOUtERkRv?=
 =?utf-8?B?K1RuODVCdm1LN3g5LzhhcFNQb0p5TEV1N2hMS1gyUnAxTmlkMnNWUkR3L2hK?=
 =?utf-8?B?MFJYWFJkS2tHMzZPL0I5SHRidFNwdGdtNjdzRnk5NTZ0QW9Wa1Jaa3Rxc1Zp?=
 =?utf-8?B?b2VadlVnUVJrRzZuandYbjYySUF5d3g0QjhSNkYvVFRyNUdET245NmNrWTFF?=
 =?utf-8?B?MVduLytjQ2xHREh1a1YvUnpOdEFsK0Q3cjM2K2FWSENldWwxeWowVllOQ1JC?=
 =?utf-8?B?MHEwWnRHYjB5aUZaNGlTQWkzemJTRHZFblptRXdna2FydEJ5M09UNVc5OEVL?=
 =?utf-8?B?d2JNdnMrSE40emU3Zy9rUGhXQjB6M2RiUUQ4c0JpN2sxbW42WU9tSmJNZWNu?=
 =?utf-8?B?My9BOTEyS29FK1NhMHowWk5GRml1Ui9JSk4wUzhLQ3pCY25PYU8zVXI4WTVE?=
 =?utf-8?B?dUd1V0o1azhEVDFKSGtjR1phWjBoNFpHeXlGdkRPbnZOSmdNVjFOR0U4U1F5?=
 =?utf-8?B?aVA2YnJrMG1KNFV4Z1V0aTNRbDJ1M3pleit5aFhKWEJ4dlBnZU5qQkt2eFI2?=
 =?utf-8?B?T3JmOTI1Rk5uNUlKRHRQR1ZIOXZ2VmRlRUc0SzlyVllQdzBIamRDMVhzYlkv?=
 =?utf-8?B?d3o0OEVvZUcwNXVFdisrMWQwN0NOTEtxM3ZCS0x6V2pWMkRDaWFhaEhQZWor?=
 =?utf-8?B?d3VYSENIVE9QUHBhYjdYVko0M3lrN0l0WDJ2My9IMFhrcjlSVnRVQVp3ZWxV?=
 =?utf-8?B?Slc2d2dTTkxnQU1jUWxXUzU2V3FLM01xa1VxOTVpKzBTOUFhSmNaVFR5RDJX?=
 =?utf-8?B?Ui9ITlkra2FEM1kwZmN3WFpFWG12ZjdLNXMwWlNhUForVy9mR2dOK0FqZkVR?=
 =?utf-8?B?OG9tQSsxU0NzQlZ5aVNSUWlYMElnM3k5K2dvVUd6WDV4Y2wwVHk0cVUvaXB2?=
 =?utf-8?B?YUxHUXBhWENuU3NSMFVCMlVGVVlIaFZEZ21KR21qdFJUc1B2bE5lRVlaQnRz?=
 =?utf-8?B?cHdTaVRQeXZRWjNxOVpncUkvREFDNWdxL0V2S3VjZTJGcmZkUERySHdsblBl?=
 =?utf-8?B?WTVWaE9IMHN5SHk3V2Q0UDZiRlc5THJEcDBHWUVlOWJvVy9wYXE2N04yWldi?=
 =?utf-8?B?R25VYSs5eW5BekdkZ1U3bzlONFhqaWZiZ0ROWTQ1YWUwUkh4S2VlamVXZmd3?=
 =?utf-8?B?Y0lyeW0wcnBXcDd5aXpMd3pubTNBcTEzQWphKzI4QUNWdVlBR0xnSEIxaUR5?=
 =?utf-8?B?UkVEZjFEZHYzdlNkSkRkNFQrRnhQK0x1SE05NGdKNnR6QlFUVUxzcnB0M2Jh?=
 =?utf-8?B?L0pGR2l2azJFcm1WWkU4YkFhR1ZabkVNNFk2eDIwcW9DZGJDUGZFdDVaV1JZ?=
 =?utf-8?B?azdhbmgwMDlWQ0Z4aDhzd21jMGpBcmlRZktsSUpMMnViTUhNNjltekZoalZM?=
 =?utf-8?B?aFpraVg3YXRrVkFIOGYycTN6aFFHMnBJeDNPUFYrV1kxaWhobnRLdUxBT1dy?=
 =?utf-8?B?Q1lKdjJBQnZyK3kvcmZzdkN3ZjZTOXUycTE2WXg2clE4ck1YSlRPWi9YUTdy?=
 =?utf-8?B?d0l0QnNwRFpsQ0Y2TSt1a0Z0R1JOV0Ywd3dJN0JVakd2NW0vMjc1MVY1L21v?=
 =?utf-8?B?R2pQM2VhdzV2dGs2MzVxRG9JVDJ3engrVlpIcVFheGxOMUFVOWJzakx2UVlk?=
 =?utf-8?B?bHR2M1BCdlpPMGVJVXRaeWVnZGthT0Y2VHh3dkRFNmtCLzFwTC8zRWE1eU5Z?=
 =?utf-8?B?STMxWHgyZnI5K090VUlPd29CRjE2NzRUVkpsWDRvZHAzcnBLd05SWFhmZzFm?=
 =?utf-8?B?YUVJRklqQUQyS0p2dk8xZmJFT2hPVHpWRWdBQWwzTXo5WHFwZGFWaHVjbEVH?=
 =?utf-8?B?Q216R1ZRdEp2R3ZrSk9tNUNCTmtnQngvampBck5tUDlDdGZxTXdqd3ZaRnNo?=
 =?utf-8?B?eVlaRUtKWC9Tb3I2NzlINk93K3hqU0lMZTdndllMcUlBUlFmWi9FS21CaFM2?=
 =?utf-8?B?N0QwWGs2OFY3b0M3Tkh4bXRWa21meGtZbEJDYjRNbm9oTmZydU43bzVvY1dy?=
 =?utf-8?B?d3JpOWY5QjJkdFk1N3pqQlVLeU1SbHkzUUp0WFdoQVErMU83NnE1dElqb29U?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 666109f9-aa9b-4bc2-b7a6-08dc3c9fdfe3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 23:07:33.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EMdketBqz+63707jCMksbqp7lKJv7GHYZXb/qC5skmRfj4U4lL2i/kF4X5tdHx3OhrsIwM25RQfCWnwc+cn2feXaE4oMj50+FWrpLZcW5NQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
X-OriginatorOrg: intel.com

Hi Tony,

On 2/28/2024 11:36 AM, Tony Luck wrote:
> reset_all_ctrls() and resctrl_arch_update_domains() use on_each_cpu_mask()
> to call rdt_ctrl_update() on potentially one CPU from each domain.
> 
> But this means rdt_ctrl_update() needs to figure out which domain to
> apply changes to. Doing so requires a search of all domains in a resource,
> which can only be done safely if cpus_lock is held. Both callers do hold
> this lock, but there isn't a way for a function called on another CPU
> via IPI to verify this.
> 
> Commit c0d848fcb09d ("x86/resctrl: Remove lockdep annotation that triggers
> false positive") removed the incorrect assertions.
> 
> Add the target domain to the msr_param structure and
> call rdt_ctrl_update() for each domain separately using
> smp_call_function_single(). This means that rdt_ctrl_update() doesn't
> need to search for the domain and get_domain_from_cpu() can safely assert
> that the cpus_lock is held since the remaining callers do not use IPI.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---

..

> @@ -315,27 +300,27 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
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
> +		msr_param.res = NULL;
> +		msr_param.dom = d;
>  		for (t = 0; t < CDP_NUM_TYPES; t++) {
>  			cfg = &hw_dom->d_resctrl.staged_config[t];
>  			if (!cfg->have_new_ctrl)
>  				continue;
>  
>  			idx = get_config_index(closid, t);
> -			if (!apply_config(hw_dom, cfg, idx, cpu_mask))
> +			if (cfg->new_ctrl == hw_dom->ctrl_val[idx])
>  				continue;
> +			hw_dom->ctrl_val[idx] = cfg->new_ctrl;
> +			cpu = cpumask_any(&d->cpu_mask);
>  

cpu only needs to be assigned once. How about initializing cpu to
nr_cpu_ids at the same time msr_param.res and msr_param.dom is
initialized and only assign it when msr_param.res is assigned?
I think that will be more robust.

If you agree and do this then please feel free to add:
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


