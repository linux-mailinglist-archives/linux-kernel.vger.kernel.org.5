Return-Path: <linux-kernel+bounces-31467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB5832EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85991C24870
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5183456455;
	Fri, 19 Jan 2024 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYWoBDG9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87655772;
	Fri, 19 Jan 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688321; cv=fail; b=bTvRyoMhHHU0a6Mnk9Vgqq1qEo3nO7OgkdKT8hovZ0hAQ54wKb2CA8WtBTDkThhVnGGeVt4wm1qSD3f3Oe3mAUFOVcdxmpef9Wp4Y/+js9/qNgUAIZ18KndAMWGmsZBBvspaiWNP0JoOjvPGfJ5GjZb252jlsWn4Xrl9VmMRjjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688321; c=relaxed/simple;
	bh=cBVYbdBIsgB3JxEZSyGleUNouftZ6iFchkbsPMoSgvg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DVgm/1lK4FpFiu2yNpzjf/KH74RS0ZbTAgoEdWrJxbzfPg+DH8/mk0NlTUCFdYgtnuQ0n7XzL+lhFRqAEPwqiGKdfSyda2gExSPdwS2aIR+3HMDSuaHcUHLJ6YlS32FoZ/LpFAMPD8hl8B6nEivhFmVgYxLYzdJP6OeQtWYVH8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYWoBDG9; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705688320; x=1737224320;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cBVYbdBIsgB3JxEZSyGleUNouftZ6iFchkbsPMoSgvg=;
  b=nYWoBDG9l64inOOhtwrZ8aYAjrgygerWEOQtwhxwduwiLXrzKoNQb1NX
   /fWjNtQSCdQOP5r1ny57mbe4MTzvMOupeeagSn17ruizHcN3wBia4Xb6t
   GykQn+3q500Hl20E9XWo9bvKHVGe5O18w8zsgoEBH9nSzPIY8pXuba9a5
   f0ZwTqPp2mSJHeC3C57nT2eV36LPEy8q5tgC/Kt7uNBI/UiQg+XHtiiqg
   a+U0EUTfnB31Cgu56PZIlW3W7TiBBaapdCovuPob7HX66CbjwQUfiXo1a
   ngK8sQz2AjxuKcN72++65VYNkWQZjVB6XRnZTMu/UCIN6rMjH3iEc448N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="702400"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="702400"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:18:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="641696"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 10:18:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 10:18:37 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 10:18:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 10:18:37 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 10:18:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G//qdkpAej4OcYbq0l6C6AdYavfl1EZaZjFWy4ZiP6eicxV+qnSJX/HYidfLQK4zuW8+NsYtOjb+kONf94tpJtZyZJPZl8PxMPkeBEcAifpnlimMpHGAoBFl87YemO4mQXQHPJSt8U5R0jV2mU6wUvm3PVJSGjX2StLzgNVThfbeUuYv7Ft2bMr/pyiGzsU6AbndzvlJLCyyFB9CUqiOqZ/XqMlXEL3xsbbuJqr+g3isAjFH8OFSqjgmJ90tsdJhVfSoMzI4J0BUDTTYRQ0pLgGDuOBt5F9ifRPePj8s12eCWsUloHW+K/iSD9cAIkW/ok0AmpVfQ7TZKtZGWoWRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eztorZKniYLNsgz9r9lEtrKDXam7Q2OKmAdoxRpvFtk=;
 b=JAsA+TF37G7XHq6B9lyOuT9wnrE/jlM1NItbIRY1dMiul8WMqurrCi7n1c3i0WlQBb8X9ev9jEWJoqGEEa7oVC6/YrdwfCU1eGtEMcAy53GTsy8BxzfkrQ4HXZ+UqJX5sPXPYFTFbB4o89sCV5laTENkb2HfANgO6C31uT7K/vA+J7jXkXjRHjBu2kFAvVkrBhwAixi/aWHD8Dl5LpGSjcR/i6BihBX5h9BX0LgO2VPDpXxzOUcmiCLo2C1ts7+NKuHu+40sT7CtmcdM6O2OUc4boO7vzYLhPFxzELVV54JjrCsvD5xEMDAf8LEKBSg0CycBZsW0HO6NEUirOnDy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB5486.namprd11.prod.outlook.com (2603:10b6:5:39e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Fri, 19 Jan
 2024 18:18:34 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::780:d536:ff24:3e4c]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::780:d536:ff24:3e4c%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 18:18:34 +0000
Message-ID: <21b9dc5a-31fa-45d0-b0c8-f61eb3adf985@intel.com>
Date: Fri, 19 Jan 2024 11:18:31 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 3/3] lib/firmware_table: Provide buffer length argument
 to cdat_table_parse()
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Davidlohr Bueso
	<dave@stgolabs.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Len Brown
	<lenb@kernel.org>, <linux-acpi@vger.kernel.org>
References: <20240108114833.241710-1-rrichter@amd.com>
 <20240108114833.241710-4-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240108114833.241710-4-rrichter@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e3711c-3f8e-4305-dff1-08dc191b0c62
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //vCNzRFkxtunPkzPo/A1JpqBOrA/4djQSfCpRZY7hCW6Uti7MIncCYRNg7Iatldi5KlFv7d5Tjs7OFlDAH/4O4EI7hC8HwPlt07IQP7FqHeQoTBdr9HBVTU5LtFFDEEruxTgE1vGh5tUSLaeL/by7PlglkS4EyLGBrilMbIVoLBSeGXPGMlHiXcXn5A2puRuVq0rGSRrgojg1NAUsP6t5VrwP7Oz2xHy26adaoJT6qiSbUZ9ULgreEorFNopSnYum9Yc5X9ArbvGumUpB0kVHIGcMYFc2xzGo0kfD2RxJnqSVBPHirVN79nhyu7aW18CrtKLo+cS9gtYyxzZj8NEhDMHff8LzFq5uOAiQTLwvmIi+rj/utRd9gYwkzHJ/2YdwfzhoE1mwnYHKQ9Pn4Ar+Nry3Dp5eLsmzFjzRLs9e0LhgH6YxwiE8XtMLivgLZyxhED5YlgyKCl6Z9qrvQKo9au04t85PutLFCRFh5IuPnCluthHpep6q7m3wKyf7Z/QaG2INsHrXFZ4ekaUne5IX8jNdgVHBCJ+ZZTuciXeiq1Tqd3uHteEqLw+AZjn8tfZ3Jh4vZmkdFypxe1QPmMUnHJRjtL4YMEAp8ATL3MganhLvZIih0cxXx3RS2kZelU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31686004)(4326008)(53546011)(6486002)(8676002)(83380400001)(2616005)(5660300002)(316002)(478600001)(110136005)(66476007)(6666004)(6512007)(6506007)(66946007)(66556008)(8936002)(44832011)(26005)(38100700002)(82960400001)(2906002)(86362001)(31696002)(41300700001)(36756003)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDFPVkJBVmxiN2lPc2c5KzkyNDNDQWRidUFRQklhQ0lZTXRpUE85MUh6TlBT?=
 =?utf-8?B?WkRaR0FCRkY5WDlrTksvUFI2bWtpeWM1dVk3cVFOTEhnRXdrRk1BN09PQ2d3?=
 =?utf-8?B?OU00MDJiMy9WcERXY2dlYnJiTG5ua252SHFuNjNpZlpsRDRvOXd0R3VISkRW?=
 =?utf-8?B?ZEtWVC9XVGJCRU5DdktaZEtHdi9SMEtiN3dwSWVQTy91R3JCeTUwUVVsWDdH?=
 =?utf-8?B?QzRBNXN2cWZNRE5LaFZrRHFiYjFodHM0alZHeVMrc29yYm00SzF3QkdOeW9R?=
 =?utf-8?B?UUl3aFh4bDh4MzI4K05RWStnNU9vQWgxZWdwWEhjZk9KeXhvSDg2K2VxZDB3?=
 =?utf-8?B?MloxM2sxTVRuVGh1Rkp6azZyaURHUjYwUmk5N0NSandtUFVBNm5XS1VtWm1Q?=
 =?utf-8?B?bS9LOHFMU0ZuWFZsYTRqQXE3QUJxSEdWTlNEUVk4T24zNVlYL3JqSU95V1Iy?=
 =?utf-8?B?b2pmTnR6ZW9HN2J3VXdrSVN1a1NjSzdvZ3o5MDJCSUhQalRrbHppV0lrMU9Q?=
 =?utf-8?B?d1hnVnZaZkc2KzNKd0phSU9KRnpXZlA3d0ZON1dMV0ttV3Vta08wbHB2SjZu?=
 =?utf-8?B?MVREN0M5VlkxbFRWOTh5Y1JWOFRyNURWcWlEWXlROUcrMEtkUjhCcE1UcmNo?=
 =?utf-8?B?eXlKV1Nid1IyTjdwekRJck1mcjk2d29TWUZsck9XbVRNSnE0L1hZZXVDVlF5?=
 =?utf-8?B?VkFJQUlUT1JYa2YrbUc4NlRMMnkrMWtoMEhuc2l1d3E0L1IrNXk5aitqU0FX?=
 =?utf-8?B?eUlSTXk5L3FRTXJFRnlLQ2ZIQnBjQ2MzQkthRjBJRkJ0cTBISU0yZ3M1Y2ZF?=
 =?utf-8?B?d1Y2RmRkUVdZdHJxWGlCMG9HY29QTjNkYVZONW9GTmNmRjNxcW45WkpDZTJw?=
 =?utf-8?B?Ri91TE82TXg5Z3Y1ekM1V2ZCY1pQaEdvWmIvV0l5dXhMeks5L2pwVFl1N2xD?=
 =?utf-8?B?UFh5NmVvV1Z1VitCWlpTUnVzakF2NEEreUQ1aUxocitXYkJ3SW1WbDNmRXp0?=
 =?utf-8?B?citvOXBtS0hmNUw3UUNaczRieldVbDNrN2phSTdLbi9jb1VpR3NQbGRldWpo?=
 =?utf-8?B?cmthRkN4RHVpUll3a2JCN0dpTVEyVElMWUNVQWVEU2VsQTRJK2l1S2g5Q0lF?=
 =?utf-8?B?cVZ5SkNEZ2FvWTM2cmZ6OG45T3FCRzFrMVcvb2dJRGdlVVA5aS9XeGRLY0lX?=
 =?utf-8?B?ZEIraUkyQlorR1FjQzdDZThBNlJWUjBneUhOQlljU01tVlo4S3dPaGdaRzc1?=
 =?utf-8?B?ZDh5ZHVLRHJlYy9pcHQ0Sm01K3JBV001L2M5Mld2NVVOaEd2bWxQUTFMNUpP?=
 =?utf-8?B?VUgxWnF5Z0Q3MDMvbktZSDJxZkkvSUZtdmtnTGhHTU1CQ1NXM2M1R21FSUZu?=
 =?utf-8?B?MlVyYWxrOEhsUktkZm4yRDN1alR4ZnhlNFNGbXNMMGlWdHJXWjRFY0hsaGtl?=
 =?utf-8?B?SVErMDRxS2N3a1ZaNVZvRkRoQldFWWg1M1ErNENGTnZUazVPNkUwV3dray9k?=
 =?utf-8?B?YnVCUXZ3UzZNSUlTQk9JOHN3QndUNWpTYitUZTlsNUljUmpYTndreGJOTXdB?=
 =?utf-8?B?dkgzWWRINmozWnczMEQ5UkpKSWt6ZEFqNlFJcjl2aEp5NzgxSFlVU1Q4cW8x?=
 =?utf-8?B?THdVcXJVc2VpZit2MThQeWdFVjh0NGZKMndMVWpjM1RjYUwrREh2TG5EY0Er?=
 =?utf-8?B?SlI4VDRCVldhOVdkZFZJRFZYMXEvTlJwak9YeWg1Y0FhVVFONDQ3elA4bUEz?=
 =?utf-8?B?YWpMVlprUkw4cXJJK3NXdis4RlNVQWNVbGwzZWRZQ0VEdTg2NW5CcElUcnNz?=
 =?utf-8?B?NzlXNmtTVTFTb0s0MFFIbis5T0JvcG41RlB2bTQwZDdDRVFWNlVoSklCS2RB?=
 =?utf-8?B?SnlSSWFMaWp5RUwvSDFTVS9yZkxJbTRhaExhQUI0Mk8zOGFLUkcrSlpOaEUy?=
 =?utf-8?B?WDJkalhWYXFLMVlOajl0Mmc5MVlIazZDZDhKanVXK1FhaGpZR0lhL0VGeWtk?=
 =?utf-8?B?dVg4dzlRc0FBNnhPRStwbHRESDZINHNRR1dta25ULzZNUUtOSWpBckdqMFpY?=
 =?utf-8?B?VnNkVDZLQ2F3MDhHcmJsRCtwWXVVK2Z3M0JqeXVndTRtaEtTNUVkanNybHky?=
 =?utf-8?Q?+7ORKFuchuYMayRlijAWAVBuM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e3711c-3f8e-4305-dff1-08dc191b0c62
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:18:34.3551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uU2BDhERDMgtB5UY8H0QznR4yXRsWbFqlRvpgtIaFKF1dC7vyVHlnrVZIqJxbtyI+ZCkQQXY86vsMEju1Jb8Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5486
X-OriginatorOrg: intel.com



On 1/8/24 04:48, Robert Richter wrote:
> The last entry in the CDAT table may not mark the end of the CDAT
> table buffer specified by the length field in the CDAT header. It can
> be shorter with trailing unused (zero'ed) data. The actual table
> length is determined when reading all CDAT entries of the table with
> DOE.
> 
> If the table is greater than expected (containing zero'ed trailing
> data), the CDAT parser fails with:
> 
>  [   48.691717] Malformed DSMAS table length: (24:0)
>  [   48.702084] [CDAT:0x00] Invalid zero length
>  [   48.711460] cxl_port endpoint1: Failed to parse CDAT: -22
> 
> In addition, the table buffer size can be different from the size
> specified in the length field. This may cause out-of-bound access then
> parsing the CDAT table.
> 
> Fix that by providing an optonal buffer length argument to
> acpi_parse_entries_array() that can be used by cdat_table_parse() to
> propagate the buffer size down to its users.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/tables.c    |  2 +-
>  drivers/cxl/core/cdat.c  |  6 +++---
>  include/linux/fw_table.h |  4 +++-
>  lib/fw_table.c           | 15 ++++++++++-----
>  4 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index b07f7d091d13..b976e5fc3fbc 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -253,7 +253,7 @@ int __init_or_acpilib acpi_table_parse_entries_array(
>  
>  	count = acpi_parse_entries_array(id, table_size,
>  					 (union fw_table_header *)table_header,
> -					 proc, proc_num, max_entries);
> +					 0, proc, proc_num, max_entries);
>  
>  	acpi_put_table(table_header);
>  	return count;
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 6fe11546889f..012d8f2a7945 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -149,13 +149,13 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
>  	int rc;
>  
>  	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSMAS, cdat_dsmas_handler,
> -			      dsmas_xa, port->cdat.table);
> +			      dsmas_xa, port->cdat.table, port->cdat.length);
>  	rc = cdat_table_parse_output(rc);
>  	if (rc)
>  		return rc;
>  
>  	rc = cdat_table_parse(ACPI_CDAT_TYPE_DSLBIS, cdat_dslbis_handler,
> -			      dsmas_xa, port->cdat.table);
> +			      dsmas_xa, port->cdat.table, port->cdat.length);
>  	return cdat_table_parse_output(rc);
>  }
>  
> @@ -511,7 +511,7 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
>  		return;
>  
>  	rc = cdat_table_parse(ACPI_CDAT_TYPE_SSLBIS, cdat_sslbis_handler,
> -			      port, port->cdat.table);
> +			      port, port->cdat.table, port->cdat.length);
>  	rc = cdat_table_parse_output(rc);
>  	if (rc)
>  		dev_dbg(&port->dev, "Failed to parse SSLBIS: %d\n", rc);
> diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
> index 95421860397a..3ff4c277296f 100644
> --- a/include/linux/fw_table.h
> +++ b/include/linux/fw_table.h
> @@ -40,12 +40,14 @@ union acpi_subtable_headers {
>  
>  int acpi_parse_entries_array(char *id, unsigned long table_size,
>  			     union fw_table_header *table_header,
> +			     unsigned long max_length,
>  			     struct acpi_subtable_proc *proc,
>  			     int proc_num, unsigned int max_entries);
>  
>  int cdat_table_parse(enum acpi_cdat_type type,
>  		     acpi_tbl_entry_handler_arg handler_arg, void *arg,
> -		     struct acpi_table_cdat *table_header);
> +		     struct acpi_table_cdat *table_header,
> +		     unsigned long length);
>  
>  /* CXL is the only non-ACPI consumer of the FIRMWARE_TABLE library */
>  #if IS_ENABLED(CONFIG_ACPI) && !IS_ENABLED(CONFIG_CXL_BUS)
> diff --git a/lib/fw_table.c b/lib/fw_table.c
> index 1e5e0b2f7012..ddb67853b7ac 100644
> --- a/lib/fw_table.c
> +++ b/lib/fw_table.c
> @@ -132,6 +132,7 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
>   *
>   * @id: table id (for debugging purposes)
>   * @table_size: size of the root table
> + * @max_length: maximum size of the table (ignore if 0)
>   * @table_header: where does the table start?
>   * @proc: array of acpi_subtable_proc struct containing entry id
>   *        and associated handler with it
> @@ -153,10 +154,11 @@ static __init_or_fwtbl_lib int call_handler(struct acpi_subtable_proc *proc,
>  int __init_or_fwtbl_lib
>  acpi_parse_entries_array(char *id, unsigned long table_size,
>  			 union fw_table_header *table_header,
> +			 unsigned long max_length,
>  			 struct acpi_subtable_proc *proc,
>  			 int proc_num, unsigned int max_entries)
>  {
> -	unsigned long table_end, subtable_len, entry_len;
> +	unsigned long table_len, table_end, subtable_len, entry_len;
>  	struct acpi_subtable_entry entry;
>  	enum acpi_subtable_type type;
>  	int count = 0;
> @@ -164,8 +166,10 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
>  	int i;
>  
>  	type = acpi_get_subtable_type(id);
> -	table_end = (unsigned long)table_header +
> -		    acpi_table_get_length(type, table_header);
> +	table_len = acpi_table_get_length(type, table_header);
> +	if (max_length && max_length < table_len)
> +		table_len = max_length;
> +	table_end = (unsigned long)table_header + table_len;
>  
>  	/* Parse all entries looking for a match. */
>  
> @@ -220,7 +224,8 @@ int __init_or_fwtbl_lib
>  cdat_table_parse(enum acpi_cdat_type type,
>  		 acpi_tbl_entry_handler_arg handler_arg,
>  		 void *arg,
> -		 struct acpi_table_cdat *table_header)
> +		 struct acpi_table_cdat *table_header,
> +		 unsigned long length)
>  {
>  	struct acpi_subtable_proc proc = {
>  		.id		= type,
> @@ -234,6 +239,6 @@ cdat_table_parse(enum acpi_cdat_type type,
>  	return acpi_parse_entries_array(ACPI_SIG_CDAT,
>  					sizeof(struct acpi_table_cdat),
>  					(union fw_table_header *)table_header,
> -					&proc, 1, 0);
> +					length, &proc, 1, 0);
>  }
>  EXPORT_SYMBOL_FWTBL_LIB(cdat_table_parse);

