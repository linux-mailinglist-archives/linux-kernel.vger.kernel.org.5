Return-Path: <linux-kernel+bounces-136213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D215789D143
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88345286C99
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B100554FAB;
	Tue,  9 Apr 2024 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6i3oU+z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3C54BE2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634224; cv=fail; b=PHxBWI6V3mGlhqT+2sGr/LHDdEdeFW5MOVdOewbcMPnymPBsbhbtTG0pUbpMUtkYfWghPeqjOmOsyybwRR3oSPxR7TQjidOiPpep9TRePL2CbkEsS/eaBIUi3ZHDCsizlZSDtqeXjhjMZS3XwP8XtsG0RpVDh2vUrWAJtcAM9bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634224; c=relaxed/simple;
	bh=it/hOi2VaASeufLXdiCKc7EDiwZjEqJihTY2EgVlHkI=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kxjtY7hT3qViQ8q0eookLinFsVoMHbUXWSTH22nCqTveZB1PkTzKan9XmiTSus2KtGTByhVDWfsBs/hxSoExKLjlTkM4BmX4biuaEOpGKVH1Rmvm/yCfMtIjeW4ORh33cFuXENZDYJI1Ei7KCwxONuMt6oLZWlyjiYwdKbs8RPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6i3oU+z; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712634223; x=1744170223;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=it/hOi2VaASeufLXdiCKc7EDiwZjEqJihTY2EgVlHkI=;
  b=S6i3oU+zIHUc63lsea2XZ0HPGdPS3rb5+8+T3ZGZnMKGPDgR6ekCB311
   FrdXXjbqv+Qk+W43rNEXeyfOLFcQTi7EhUvkzLy35w2w010eDsjO+CKDZ
   u6dV3Rj0pskdQJilsGo1A8bMFl1rvuLj+f5TgEpM53bHOs0tPRAsAQeIv
   y/8QchzPXAnxTGNEjbG88F20VlAaakYIHn7PJNHatX9RKNw+cmMLa5/vY
   XE59YYwskDNwkKAsrbKK3qkA+v56nlM/1reNZHn7DXU4HlsKJwcRz8v4+
   QsH2ZiEhELWL2DCmSAQcthlDHMGEvILCyIUEmp+XvHATbqg0S+KJKuEfp
   Q==;
X-CSE-ConnectionGUID: D0nM6Jk+QgafS6/6Oc+TgQ==
X-CSE-MsgGUID: 86Y7kl4wRK2HW+VJiS0NGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7808562"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7808562"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:43:42 -0700
X-CSE-ConnectionGUID: 9K96MJpXQ7yw1Hdww8JidA==
X-CSE-MsgGUID: OC0D7TUbSc2CMycaAx81xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="43289872"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:43:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:43:34 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:43:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:43:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:43:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Occi3iPJomUjl76rO6itQBDa7pIc9c8dnwQw6jJUib4YVMHRmr/cFhRjFENU9Ut1huKEcWjIiHGrrh9Oxo5DkDcovZRX7QrGpnXiarkr8+dr1BXThZ6gATTQXK2LBAaJFFD9/hh22n4Rcl9q1ff2GwL++b5WqngT34kv6tMzh7tdwASH9VxHpkXzEzlUa3rUBohWaDopBoAcF3WmLhx0GUV+uPKnXmNFFnBs1EcWMzcOic/YwHObsRgjyHBuUVm2IfcP5WNIgd3lNCM+UhvjUcAo/M5C8fyJvPUMTMAufztYHX/rYgymtPH7c5lXHQnGiHjEWNhbQUqyVCrCobIqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3iMOIMLSdgA6VCd8iAEpzFUMfl485tyfrthONpnor8=;
 b=n6xkIZjrFP5HPnOaIpZsFH57zliiDVqyOFMXejeEiHxVJh+njAhWwcEOBh2+GYcLUhV7ZNIbp6Gue7Z/n2YvU5YLpqD6xibfgl6MwRsXEYKPvMhMDWoY9mhbLXpld/mq5xwNO3Dd4t2d3SaLwLDKN8NsHji15jAHlakLFpsYaziVs05bapJkITV0n0OI13a4P1U87S6UGv7YtALxqT/gAytpKzY9dUzmzi3QQOoACEF/cPqdCyBK/RR9KDgHV1enhitVKYIxuyMXNC97br55bMecNL4lx5Jm8nGI/wOHvZWKiwbZHKtVNf7nXb/ZH+Hki62HHYzEzWG3vE6blPQg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4666.namprd11.prod.outlook.com (2603:10b6:303:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:43:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:43:32 +0000
Message-ID: <a8a95b4f-8913-4896-b01c-cbf80f931894@intel.com>
Date: Mon, 8 Apr 2024 20:43:30 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v1 31/31] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
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
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-32-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20240321165106.31602-32-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0335.namprd04.prod.outlook.com
 (2603:10b6:303:8a::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4666:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14paS/hL3pqUlLmMB84gSQDcTwsXeat8T1FqHUEiGjKcED/REp1VFx0FNyIxq7lxw0KUoPdtETSRZVogC9mKpq7dXWDknnXPgC4BIjJuPcrJtiWLuEPboC27xx974lEigziTTAeeymAQ2VpHGid6SdhN2FNmmTwtxubfwQCi7Atf8q3sAcIm2PLBblHBgcesfL9SXHX/iV7G1a0zoch4RcyLkvo8DF4yCYWUmzN/BJV3uwcS97yAQEk/pM7waD5uuAKZr+AXlS4mRbJOyM7v5B+qzePZTc5Qb5BpEMlMCF+UUR15WIEcllmd4zDXr713NmyWFQSrZ6KurnAPrzEF5mD2ioE7myG5NxsldMdMi2QsFyq4PUs7oNPtExzeMUmLdrTU0tla1hJN39UNNMHBZqw/N3AQUoaw3G7c6Plr/0ZMt+MzOaURQd4pdH0RQ96MBbm9ATnI3Adnnxe9VUvZBTAdmbP7/a5gPC9ezalV8/zgLkXFSjxtj0KQTc++qQwgbYSGGq5o4TuPite7hIRp1r0k3W8cZEgJVLJOE17k00fX1HyLhIUy+QTC+J6H+7f+H5qa9Dr4OV5TeNGc2u0EsKcZcmOf2iUIb534q3veDZkQ34ayDBP+viJnytiZ0gD5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1dLMkpzZStyUy8wNTRUR2ZkZFNrZGFhN3pWK2s2NXRNNjY2eUJwbXNsWWxE?=
 =?utf-8?B?OHR6bGJaaEpTcEkvcnNmSlo4M09XeHBEaFNZS3BqUXU5VStNaCs5ZEtZMUZ3?=
 =?utf-8?B?UTBIcG9yUE5iV21oRHVnNDMzTDMxKzNTMXNncVp2ZWRHYmZqYUpwd1RpUGtx?=
 =?utf-8?B?ZGxURGM0SlU0RjRRd3VFQkcyMzFCbzFBYWhEQytSbC83Nmdhcm1LdFNNeVdE?=
 =?utf-8?B?SVZ4RnZzc3Jocldxd3VIYUZrMzdwZHR4ZGNkci9kMlU1MHl4T3NjRERsbWlh?=
 =?utf-8?B?TnZ1SmhiVGNmNXpSOWRCUnZNSXVPc1d0NEtUYUVrQ0xLQkFRcXJFT2dmNm9O?=
 =?utf-8?B?Rk5MUldNZ3ozQ3dUZW5ja05BanZWcW0vRkZxMnZ2TDNhTk9oRyt1b0lUb243?=
 =?utf-8?B?T3dET2hJaFNlelpMV25RUGltbzFRUkFLSFM3V0UrQTRVM0R3UnlMZCtaaWsv?=
 =?utf-8?B?THFSTWhGckxIcktBcWtiRnlDRnlYMkJXWmxKckNwaENWeGpOTDcvQmNMbWx1?=
 =?utf-8?B?WTJvcUxPRnByWUdCSy9FQkZMd3ByTXorajVuL2Q5dnJETC9naGx6UCtRaFpL?=
 =?utf-8?B?UW45RUR4NXRYT2NGN1grelRmSlZONmFDVFNGZms3WUdyT2kvaWY2R1Z6Q1BU?=
 =?utf-8?B?Q1hhc0FPSWdVMXpRWVlad1FmemhMayt6SzE2dTJmbHJ5Z2cvaFlwMTRud1hM?=
 =?utf-8?B?b1Q2ZWlMUzNIcU9RVzZIRjQ3ZllzRE1IS1Jsc1Y1bFZpMXVJRzV1VGJTajBu?=
 =?utf-8?B?dDI2Q1FRTk02dFBkWU1uNDdxSFpEaFh0SXB0bHNacHZOZlhVMEJSS3ZTbW9i?=
 =?utf-8?B?SDgzV2FaeVhTeVhIbWNlQm5QUmJERmV1TUhzRFZWaHZFKzArb0F2NGVyWWQ1?=
 =?utf-8?B?N0ZBQjJYRjZDUlNjVkFwMFUrS0d5UStMVm1MRVRnY291WEE3eHpHTGUwZ3Vv?=
 =?utf-8?B?OTROOHFnWHZmNFNUTEpydWluNWdpcitOd0gwM0FWc3kyeldQcEZsTGF5eitq?=
 =?utf-8?B?Y3VOUDhjOGxOdGsyOXExbzhjOVA2cGUzR1hCMzRyRHhwbk84SDNXSkFlM1Er?=
 =?utf-8?B?V0lmanIzSjVvV3NjWS9EL2FyWUI4MFhqdDhYa2dBeHY0QUF6NXFIdzFmck01?=
 =?utf-8?B?WnVMMEkzWlNTeHEwRVd1U0srcDY5bnk1RSt1akd6MjN5T1luR242a01aNkRT?=
 =?utf-8?B?dmIxdW9ncjNPck4ydEVVbkFXcC9uTVJYRGtqOGpLU3pScExJamJhVXkxSU8r?=
 =?utf-8?B?WXVrU3NEc0ZxVVFwTXZrQUNITWVEb296YzNrem5Yc2NOVHgwQWJLelgwWldk?=
 =?utf-8?B?cngzZHJxd2N5RERuMHVKT3UyRW5lSk9IemJvL0ZzRDBDbHY2eVdiOFBEeTRD?=
 =?utf-8?B?ZVJEVVA2NlJSK3p4YytxeXMxYmdLc3VOZTgvMTZFVVlFQVkwL2wyV3dmWCta?=
 =?utf-8?B?b28rUGR5UUwxTUthWnB5ejJlY1FOLytUZ3Z1OFZOYWlSWS9HaHoxdDJXOGdX?=
 =?utf-8?B?dlhGNGRlME5ZOUFJS3pJelBSZGFtbENnSWZWaXpjQUVqMzkwdTRTU2xrWTJv?=
 =?utf-8?B?SHlwV2ZHYWZOTDh6dHBJWEo3M2VXRndEa2dUaGlDMVM4K3RLMkpGenJ1WTFh?=
 =?utf-8?B?ZzRJU05sVFBXd1Q1M1BkbStlc0w1OGlnMDJ0QkFsOHRacDVYM2Q2R1owdjdQ?=
 =?utf-8?B?QjFxRDUwM1daM01PK05BWExPWWNOZk9VMFpLSlc3eEdZR1ltcWc5UUxkdzRE?=
 =?utf-8?B?R01QOWc1UC9Mekc2bkEwS3lrdm9hZmg0MFl0ZHVDVDV0cWxQWWt3WnIrR1RB?=
 =?utf-8?B?NCs2cS9RSVVvTytoWUFEMTArNTVGeDBNQ0w0Rm5Xa0pSelcvRXZXT2pqLzlN?=
 =?utf-8?B?Z25rbVVTcElMOEY4WTJQSlJuZE1handJQjBsQWk0TS92NEh2OEJZcmkrOGpO?=
 =?utf-8?B?SXFoUWJNbjF2R2I3bmg0Ymg2cFpBMHpvVWgzUERmU2ZvdlVKR0RKaXYvOGMv?=
 =?utf-8?B?K0JmQlFYVGoxZzRLcmVtblUxeFozZVpydVRCWHd4ZmRGZ2xoZFVONkhOdFNZ?=
 =?utf-8?B?aGc1c1l3L0VIWEZDSCtueWxtN3NIUzFYL1BpMldnWkErZllFMmNPZW9Tcm5y?=
 =?utf-8?B?YWI1YXpMSHg5NG1uWThwbzdQYTUvRGx2cUFNWlVucUJpSG8vYlQyN2JIK1p1?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cffc8170-7925-44f1-6295-08dc58473a7e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:43:32.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CElZmbV3u2sNRmHCJ6SPMI6bj0k8zfBXSvXiUU7PEljbhvw21Rh08vRkbiyWErrLbunZ/5wRmAGRSPn4Sqnki+SVUKYIDRQH5+7dwhNdMpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4666
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:51 AM, James Morse wrote:
> resctrl is linux's defacto interface for managing cache and bandwidth
> policies for groups of tasks.
> 
> To allow other architectures to make use of this pseudo filesystem,
> move it live in /fs/resctrl instead of /arch/x86.

"move it live" -> "move it to live"?

> 
> This move leaves behind the parts of resctrl that form the architecture
> interface for x86.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Discussion needed on how/when to merge this, as it would conflict with
> all outstanding series. It's probably worth deferring to some opportune
> time, but is included here for illustration.
> ---

For reference, there are currently two series that are ready to be
considered for inclusion:

https://lore.kernel.org/lkml/20240308213846.77075-1-tony.luck@intel.com/
https://lore.kernel.org/lkml/20240408092303.26413-1-haifeng.xu@shopee.com/

Reinette

