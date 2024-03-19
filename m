Return-Path: <linux-kernel+bounces-108104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3693A8805FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC52A284BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5565A0FA;
	Tue, 19 Mar 2024 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXP9LcCQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2091CAB2;
	Tue, 19 Mar 2024 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710879499; cv=fail; b=mxVF7l7hQGQ1lbjwuGnhToHnwyXvOOs4ZKrJyJFUsHk+n51eeG5VKxEy2Svm98Hyf7jNYIG9HZ/Lxs9Wa76waHGXH7wvJZ7022ryBp+DWCOGYg9xjmHI8HhtX/ydIK8AgXKmT3MHpj/b2egVaHmagPdlzzCueauek7xJrdSYOB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710879499; c=relaxed/simple;
	bh=VY8Za2+C8jXIZsKFt8+GDo0qzCd94bCWqF0A+YqBC14=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ioiTH6OgHMxrslLFuPLHGiI5FCM6OzqYG5nz3uRcXnIDJ/a3qZ8hXjgtiT+zbyyBPYoZBTHwATegjK++gQbMRVaX6wqUfTVzjWpr/0KuonyqiaGmS4fp+UT1h5q4gC/QS7rgkKvsaQsqT8pEV5yxRGT2jwxW+6LumyH+03IfCs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXP9LcCQ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710879498; x=1742415498;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VY8Za2+C8jXIZsKFt8+GDo0qzCd94bCWqF0A+YqBC14=;
  b=HXP9LcCQo3bIxO4ZnauGRpQl+WdREArg+adRYkqel1b0cdRYcIhUiDB4
   kOwy4Ec3TmLzPoZd5nZSYMI/8lyrVqwuseZ7rJXT0/66S8aeYDpS/FKpO
   jTebJ50CdKDiWohusJzcn8ix9I7JC9GVf3AHYuZnt7he5gp6GaEDRoNvm
   9C8FZJvYQPpMAXLabb9qnk0UO1NpHG3IMdAk0WtABxV7AfwBvwB3fwKSk
   aa0QrSzRZ3TnH8d8FZZCXb9Z8bMjnAEFBEwZ1ScborhsFj05zUQFA7DHo
   1u29zYYuIVQ0N2eqe2ancsB+3eHy9zPZNexc2xUgX0FLtOWmnVr20Sz/B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="8722442"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="8722442"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 13:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="13925207"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 13:18:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 13:18:15 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 13:18:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 13:18:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 13:18:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNkRw8pvJDFsw91TGgdcZzq5u4psA7JFFp88qP5imHxe3y5ZYdU8cgwV4d/f712I1BjbLWPXMi7yGBrT2R6Nubvxv4PwSKVbKenTrEFzZutVtxoDgGeIVIvvkxlWygPIl0TOBUVDs0yNuifTDkeZ20jCDrGrcbqk32gc4Gc+OWoJFKikGLcM/3w9Uzlm/bSqS/e6eoLDnVOxCCKRTqZiORDts1F01YpV0RWnYXEh6ET9032KeCA4+sNOdowzP21OEFV5zdxILoVPyk/aonqgZYmXlLpp2HhGtpEAZEnBgdAy5wvY0u9mmgh1nffjjYkTd1HRXPFvlxnRzHROjlU9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VY8Za2+C8jXIZsKFt8+GDo0qzCd94bCWqF0A+YqBC14=;
 b=IMtJ4xovD7U4TRB/6Jqg1LOOnOh/lUaa2TPSWk8Em+F/ya/jp+clA3vMlKZmloG8p7jo6BY3+w1ITAiRf286QEMQJ14dacEae91RpQ1KJ5kqT7+mzUdOEGtlNdf5yLoKql9XpVyrr5X/Vexs22hsEBatlZjcBATfNnrTng8gL66yFmBdJ3STeHqT3m/ZTtwJHJs6kbtXh2C9iR/+NoiKhOId8RRGu/Zg0zOYtNamYwPRGz2JDH0dD+7IobPAFCy2VtGqnkpcM3A1Riis0iOi9QASeUAM1SMLdSoB/iuttOmJGoTXueWc+hjP8hjU3CnrOpvOeR61XA0zHctRseGW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 20:18:13 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 20:18:13 +0000
Date: Tue, 19 Mar 2024 13:18:10 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: RE: [PATCH v2 2/3] ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
Message-ID: <65f9f3027ea4e_7702a29462@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240319120026.2246389-1-rrichter@amd.com>
 <20240319120026.2246389-3-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240319120026.2246389-3-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:303:86::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbb2ba5-945d-47ac-1cde-08dc4851b416
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMyY5Jw+zlypfyzdO4p0Xf12hPi0YoSs/RTSKrQUSFdTXH8ogT9ZDmtEKdHYhOMcKhugPNAsHlAibqvS/KVWSaoV3E/mu8LBvrLiM742PFFHBWgcaOmIaYjpzHL9UtzZglBTSZvP6bUxBXnypqxRB8cDuwK4iNd0L6Ilvw8rVybRdGGZ+QHc/aBrXlx+QVAaPQ9sQuUxV60tIL3pfn+RusGVf67FRYav0pqbySPIfv11vkd8KtVAkqCcnnfwEoCzarSUzNyWbaMt1iZ1Qb0NWBHFlLmQtjkljWj6ErNLoNoWh3m15A7eMo720Ab6xWB/iDxbofvP13PJ8zn2vlDKAv2347MEqlPn5mlWikLFFqyn9G/C8+9vDN00cuKIogrrA4VXVpTUklH6jTyf1Y7UVduEXNAtutDon5s2VN78A4v/qwnM/x74lF1Qdg15bdpmG/VbO3Amid1U+ijy715pRN37kg6E9mEVRN+kwAe7wm+lMGjOcvkDMFaIswFoF3V7/JBHGP1pLl/KkF2wu4mHjFLeAAlnZtBRROkal4vnvQkXwR7QsE6itM4Hod4d4VArHto/M5lPiyO20r4OkFZHNHDZ2L0V6c11u2sXsSZilCCP5R0IYQgxsM64QWVJXXLfO/QGGJUca7e0dxuAGIcHDoW6zTEOdXjaOO5xo75ywYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w9zz6uacAuabDoy7zmWJda1Sz0tZ25KXs8v3bTQxFBaQItN0xa16oGyLd7qg?=
 =?us-ascii?Q?IIGx1ZT9NYgnf5mRH24oGKgVmYr8Er8iDp/n7aW7Ihh+e5znvLaXykEpJYTq?=
 =?us-ascii?Q?AjILoqRQGT5/iXQ21mhBvnAC2yE5mzr2AvVWA0sD7nL0QOHW6/BOWF+cSf9n?=
 =?us-ascii?Q?Lky9B6RnZZxshDc7RB7zKbZgypzF99JX08BjVZyDoPByWxKLiy7xjmEALgt2?=
 =?us-ascii?Q?rR0Vm6WSUFdX1l8TUVdCz+i6FzroNEpOPuurrzepdjok+knKnFhrVO0FilDi?=
 =?us-ascii?Q?4yB7Xn+ju+w1f+g3tHd237tJitzSTNMwAw9evWObGd5nRo5RcY49upwOg7HD?=
 =?us-ascii?Q?a+m0rjfFvQnfHcPI/OAfI6QcuRms4ICiUMyBmgH1YgkJmmzN/G8cXT2O8KgQ?=
 =?us-ascii?Q?e0jb7OPXEy5f30tlTTfdlU/XRaAD8sBSAPEUyNuzSN0KTyll5sF//2Yq8ddJ?=
 =?us-ascii?Q?sEtK5JBVpd6Fh7KbuzJs9EXzsDnWJyHDyjkzTRiBRaq291PTFzT/yPYRdt+Q?=
 =?us-ascii?Q?bw+Bef+P76XYsih4kCwXxlP1Y8yBAFl6aZzfQeyhxYnWL9qNmEFYH2Qeswg0?=
 =?us-ascii?Q?Owp3JA4CaPx8JTg0Hq/+cREDtLsc1mUuMgKEAU6wR78SM6dfFFSU/6TUhyO0?=
 =?us-ascii?Q?3iJPz/wNM32GY4fAmluUfWh3SI41YEaHBOq6+cadsO4ugpLp7ccm+AnqrutI?=
 =?us-ascii?Q?PdEjSIL/fvYYYIMMePoPaLQgG7aRB4gX4PDDDHviNO+kcw2lJid/E/9c/IQm?=
 =?us-ascii?Q?ielgecZRgNAC7+aBOtIp9A7mDCHZKivD3JACqrQCeRsgnLzl2K3DKbGBydqo?=
 =?us-ascii?Q?2y5CCL29iNdcf//hrZVO+Du700Gh8zSlPfF+9nTlb1RbWNytL74LPqe0mFx6?=
 =?us-ascii?Q?6xMgH831A6djH6iZah9F+OkJ3HW3ZnRJRJKsiBYgvuu/pbLi+K+PXBK94L3p?=
 =?us-ascii?Q?MnCxsP2vWTi/1htNT+ZY1AAyh0ZtcIq8gm6QuVFIvBvYOpdnNuM7fBSh5CaM?=
 =?us-ascii?Q?dIGDnPdWWEUxq+D9NLQQlmk+a7KCpS5yZ5ajbJcyl63axm3m9SAQ9NggKjRl?=
 =?us-ascii?Q?y9LqhUvBXEjjWmjQURXSpcO3P8mQrBWSdai7286q0pdeBHTqTz+QuD4CMGmS?=
 =?us-ascii?Q?kjionpIpCEkRuy/ZQ5HQACJlkO4DVHjiqZXfEg+jpDwpFfzUdzwvLFYjQtO4?=
 =?us-ascii?Q?s4HJn7al0xcMZuNJXKms7duW+Cl4Iz1lYNSudzJzTv06i0zYPkEi6ZILY4PB?=
 =?us-ascii?Q?waYSRKnSQmBVcoDfR3Y8mG+tR0WAGzQqyg4HjYi2+Ln8Iw9OEGzy/iCHroZ6?=
 =?us-ascii?Q?G5Lu+YQbIe+vSqS+Z86KJuoaLmKwdJ06vTifd/WZOg5bv9ulF2NrKobeiE9k?=
 =?us-ascii?Q?ztnfx8ytHxVno0XnSZhoWgbdo92HRPtaYGICO0V1Ai0UhVT2hiltARKxTYOU?=
 =?us-ascii?Q?e5Qm4xPWvuI26FdopR8m7on7Ib84gELBZFL8i1swqi3eswz3nVUf3nFMOmg7?=
 =?us-ascii?Q?txow0pxciLvobPSw9bofBDLTgnC/t4ZNnTDcgwooHGFb0K1S7haqFGPqPJ9q?=
 =?us-ascii?Q?yNZV3Goufqn/efMB6x62kcUcCRSvAJzm8g2qba9SHIizBZKreVI/kS8qQdIY?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbb2ba5-945d-47ac-1cde-08dc4851b416
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 20:18:13.1758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3z6kloExsXhEqBhjkbXNpuBK6aKJc8zUXLRn9wUtYR3eErJ1216MIGxz+1Ti0Ngm6Edlz5dsFeb1FYDqqPHAwhFOPkOdhvJrPW1l2Pr6dY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com

Robert Richter wrote:
> The CEDT contains similar entries as the SRAT. For diagnostic reasons
> print the CEDT same style as the SRAT.

How about move this to pr_debug()? We have lived without this for a
significant amount of time and it is not clear that CXL debug scenarios
have been hampered by not having this in the log by default.

