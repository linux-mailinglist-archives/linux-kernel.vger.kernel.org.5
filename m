Return-Path: <linux-kernel+bounces-37734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D0283B498
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC71B1F2437E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC673135A4C;
	Wed, 24 Jan 2024 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/HXF7hj"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE039135A42
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135031; cv=fail; b=IQiG4nASOfII1Tr8182cuJxCFxwZph1AvJ3AoHIj+M1uxsB9oUFfOkr2RVgcWjbpd8XJuAaU5sjv6ij8TjpXXCGL8RP+thh1a1+/DSQOtok8UoZ6Jc5qM3aXE1Q/AtCyi8PpKOY9YkXYHYxL1g3z/EQvdhyD+JT6ws3QhHepdnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135031; c=relaxed/simple;
	bh=eCGYjM3/oW0542znfrl8sHhqLfPlJjuDHQnnVVKzfOI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ajZNeO/kZ/6xs+A8VHZjDMWzzprNMzZzuxasuJ3isE31ar71XmzdPbZGXZD/TLGCfZiSZt1TzYRF55m1YLg7W7vtTUvTk3s4OkD0naV5g/iinWWoY2VW9WNaT4j5BY0Hu1Scdy8+2/F+M/Wv62rZVgbbuUw206fWwoPDVBWh2/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/HXF7hj; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706135029; x=1737671029;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eCGYjM3/oW0542znfrl8sHhqLfPlJjuDHQnnVVKzfOI=;
  b=X/HXF7hjvNof2nWHQU2ecREXqsuyuLCe8o3AwXSDkm7wfI7CAoSxaGnb
   q+yefzC+MkIf4sLXEc45/19hV1jwfC9qDWD5EdbfFHeVCy4pBV6uP8ujV
   jxaJOWON1NVA0Pq0t5ApIAtcv+MN3WA6WVebHyjzFJxax6+RPuWFTVaYC
   jhLSLf5qr1ACwm103vMyuhgGObIgv8jl89ttB9z/Da/9Docl5/mGlsIkZ
   OQEfZRiKlX+9RBA75gNWZ3X3ZAPKiu9N+rmHRCdDCGd4bkirb/bVGSMZY
   O/gqhNeYQfBVEKkijL/0leta9SVyvBnSYFfj5en7EA6bvErVXRYItL0ci
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="392402228"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="392402228"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 14:23:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2069459"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 14:23:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 14:23:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 14:23:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 14:23:47 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 14:23:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUn0D7v9cyNLu7H2RaCWWxCysMtHeP7U3O8K94nSWpOlmQkCecheShwk68jaN3fpkNzdn331YiXgTk11eOR6p8m1qwFs39OWi1vW5XAD6ID/BwlHonTCOfsfArKEtaUOGpQxBKVp/FEd6J7bdWk2NwwyT2LEzBcsSVNTgXs7URPFvn8RqMIct9wmOMoHs1hzxSJDm/Sk/dGld2vLXy6/IRMR8hu7UsMxS1OVn9JgLOZH2W9rIN8qdxYZKjyGMpNNPHv2+8wGsE9YYQuPadNAg1NLzONxw38wWPbCxy3w5NkNEDD0Q9q28UpyjJFGpsouXDm3AvpfvxPf/ZmzGr0rPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s87oMwSJ06CI/1wcLYeQW6aKDKJCE+EdzXfGhxMShKk=;
 b=m9kBw9hS08dvyiDst3JCM3SQoTtctjpHqhTDqVGCA15FvmBGiQpTByjs4Y/D8TLxpHqVwc7VBzEDOkSQFZ8/9BG8icQNdxh6t2rpxkORz57zxtCdAFVeAcZMPHoJ1FtUSzR6tJWhM+GqWiu+x7pPeojNZvW9v6EgT1Fp566UY2MKamDiI4smpdlBChOj7VvPgEoqYm/6L9xzj8rMHaJ0OmK+lP4B9qjj8XRbgoAOgNYn/4Nn47vM1n/8kR0foGE8qunK9/8/ltK2TLDDryj3MM27JpEgVt1z+NshHQF2sRCh0tBKoVeW676xo3jy6rNxScPqsljCzAFwMWhUBiIpmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5936.namprd11.prod.outlook.com (2603:10b6:303:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 22:23:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7202.034; Wed, 24 Jan 2024
 22:23:42 +0000
Message-ID: <6fb89a6b-031c-451e-80f7-58c277eda265@intel.com>
Date: Wed, 24 Jan 2024 14:23:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] x86/resctrl: Display the number of available CLOSIDs
Content-Language: en-US
To: Haifeng Xu <haifeng.xu@shopee.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <peternewman@google.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240123092024.1271882-1-haifeng.xu@shopee.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240123092024.1271882-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:303:87::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 867e654b-b949-4f1b-ced2-08dc1d2b1f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ZaZFLQzFeJpW4+s6mjAjm7yknUmbcw3Ks0sxVwfq55p+r7flk9DxNeHZ7E8OrzKicz+BdYFjfEXNdI2UcuPA+kZbW1MyWB/U3E0Ug3Ugbr9NxcdJe8TXZ7Lquhl+O59jahLOkt1CSNIjwqMxFzLX1llHYVIgJuD459LDOVVQilMcVWcLmm7bcVLmVWjaClkpO36GgKAw8E2kgw6le5ApGrrG/dreQjtrhxNrsyay0BOq7DaHPp9QLsci2bqh57l1Pv2PG47274tXSRykwDwfn7BRmYOLSOS7gxhPSmuSRsvJ3RtWSiIkY6+eDYQgUYJfxA7d70X0rnxeGBk+Si09cDQpXfJ5zbGEfyM0mLKcIcwkjVu8guZU3HV1jVdKmtsgRls+klX6RWW4ZwT/2KccAHzzX9rhvRRtHqFUi9EfZ7J/bh/j3t42uEIHoyPxOJkBhy6gH94vOXIKOiusQd3GGrYRiJ/f24NSa7nv+G8i9D4FVV8DgR9MfFtO9MBZLg+E9196f80bojhfMd1/qHvCuMwnNhT/k4/LGfae6NUkEbjwK/+0otYXsgPVHYQgMi51uMdFU0WMNRN1J/pZ8dpsUUoNCYuUgZhxRkfOATJudjDiCfx8mWo9+RqNcvuNvEaSfebB3T6Z4+kHgEv4/w1Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(83380400001)(6512007)(2616005)(6506007)(6486002)(8676002)(316002)(44832011)(8936002)(5660300002)(26005)(6916009)(66556008)(66476007)(478600001)(66946007)(4326008)(53546011)(86362001)(82960400001)(31696002)(36756003)(38100700002)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk02ZGZIUWlVNlNZZVI5bjBiNCsxS0FBNEgyV0ZFVmxLUHZkaWlLQzhEdmUr?=
 =?utf-8?B?U2tZZlIvSXB6U1ZwY0JDS09UMzdpTmQxQ2JxNGtNZ3VuTFptWStTNVdQbEdh?=
 =?utf-8?B?WmV3dHRxNmJySTNKTmtMTUJ1SFllb1AxWEE4b3Z2Y2IyOERzbHJYamZ2T2J5?=
 =?utf-8?B?U29vbUVYS09Xb2dkaDZ1cmUrYmlLSzJVekNoN0lZb1FRZ204VGFYNmRKZnJV?=
 =?utf-8?B?Vjlia0lBZVRUQzdZd2FpRzZSRWZNSnBoQmh6WkNGYTJteGdWbjE2ekQyaEFz?=
 =?utf-8?B?cHUrVkRuN0VqR2NoT1ZFMnNaeml6UDJNU0ZwWi8zWU9NbXZPdHJibmZSQUJt?=
 =?utf-8?B?THVxaHF0dnYzVWdLL3RRMlByWTNKbXY5aURtRVpWNklMeUxIUTFQRU5yRThG?=
 =?utf-8?B?aXBoUlA2ZFd5aVJBdzRvNVd0cmdqNmdZK3RNZllpOWhOZzZsQ2RwT3VHUXhs?=
 =?utf-8?B?UlNleE1JRzJWWTBnR29yMmEwTm4xRkZWTGZScmNHRmpieEw0NDJLVEFKZ0JG?=
 =?utf-8?B?M1FEV3lCa0Z5T0ZzRHd3UUFSTXF0RDhGSE1Yd3o1UFM0ZlpVQ3JLZHN6SXY1?=
 =?utf-8?B?V2hlWlJNVjVLOGpRajRPdmVuWGpzaHkwVjBnYi9lL2pCcnJ5WnpDTkd0a0l6?=
 =?utf-8?B?OW44cnYwOXJabDVpV2s2QktBNW9jaU9ld3d5Zko5WWNmbWN4aUdueTFUQjdl?=
 =?utf-8?B?TU9PMkMvanl0QjNPMGtQdVhkc3lEZDNDZDBTYm9SUlpLajE1SUEyclQxT3ZP?=
 =?utf-8?B?M1hPV0JWT2p3RDVDRTBVcTNmeDRKc21UYlQyZVhjZGxxNUVsUEF3QmFsQlZa?=
 =?utf-8?B?UnRKNDZJc0RIeS9NOFNFKzhkTHUvTEk3OWZIOWhjbkFWSnUzQUJReUtOUXp3?=
 =?utf-8?B?TmJxajJzaXJheDFaaUdaeS9Wa0p6RWRzSDZZU3hOSjlEMVVCUlMvQkxMQSto?=
 =?utf-8?B?TUVQS2dDVUFNQzA1Q1FFTVlrVEY5bVNqNTZRamNtVmFWZGV1QmRLelYwVXpU?=
 =?utf-8?B?MGVuMXlTc2psRTdaMlVhNTh5b2o4RXRMMHRiZUlWSTAyUEpuLzYxKzFUczdL?=
 =?utf-8?B?UHhlMVdiMGszQVV0cExIUzNkUytMSVI3U1JhRmpQeUJxeDVyeEFRdldoTjdF?=
 =?utf-8?B?d29rY1MvOVpVblM2N1lhZGtuVElHdHdTbEhaeEt1THVhSit1RW1VNllpZTlV?=
 =?utf-8?B?L2JmSk9ocnBIUzlnbXpNcWtYYThTanVnUmtkbnVqVHVXcGVndUc2M1haL3lN?=
 =?utf-8?B?emYzdGQxSTJwNjM2enpyNGlaVDVMZTVwb3pwUWNBWlJLc0NjZXR5bFV5ZW5X?=
 =?utf-8?B?ajZkclgwNTFqLzV4S2pnQ1hjVnUzRVZmSnhEN3k1Zi82ZWlBbmtabml2Qzl3?=
 =?utf-8?B?NnlUOEtuTXA3c0xzUWp6aEluVU1kaVhERzNnTEUzNFR4OXRVL1NsYmxXWnl2?=
 =?utf-8?B?UW5Wd2hNU25DUUJlVXZPcFo5QkJYU3FHS0lNMnR5WnN4YjdYVzh0eGlmV01B?=
 =?utf-8?B?VEw5L3pBVDZBTWJTalAzUEFFVS9UcGducER6L0orVFRxWnRySkhWS1lFZnla?=
 =?utf-8?B?Kyt0U0pPZTJQSDdBck5JalhoektPNWg0NUJMWEx1ZjVCOExHOTEwbE84QnFO?=
 =?utf-8?B?UXQ5d0xxT21IMnVpSzVJYmxEYW8xNzArR1QrWmgrYnBFamgvci9ia1JDSHNh?=
 =?utf-8?B?Ym9jYVNMUDhCeWM0RUttcVVNVWVsMnNiODZHM1cyaHU4T0tYdmtrQlVvQThn?=
 =?utf-8?B?NlJCK2tmdERHWDQyTjdoRjZ5LzVBa3FQWjhUc1lzTUhObkE4VEdsa2d5cHM1?=
 =?utf-8?B?NlpBQjNPeFp0N1N1TmkwQms2VUFhUDVrcXZzalRkNjR5RFk2N2VYTVBpWUky?=
 =?utf-8?B?S1VqT1JldU9xaC9iSFpBY3NHV2Jqdm5KTkpvSzY3eFZZSWNBUm42dkl3RGpV?=
 =?utf-8?B?SVpmZ2k1dDFzWXVsM2Zkam00eWphcU5mUytLQjNzN0JkQWV1NHVyVUdXVC9j?=
 =?utf-8?B?VE9IRFlKbm5rRVVraXZnU2hGcy8yWUZEdkxuZmNZRTZCRVhjQ0Y4UUZLc01E?=
 =?utf-8?B?V0huQTAvT3JONEpBUGdhOGhuRUdURFY3TEVKTGl1OTRjOGlEb0cwMTFrdnU1?=
 =?utf-8?B?NkM2Qk1hSFErclh3c20rLzdtTU9OU3VmL3R4eHBjU0lBZ0hjb2RXa3oybkVW?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 867e654b-b949-4f1b-ced2-08dc1d2b1f4b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 22:23:42.7100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbIWGZA8JY0s2Jf9C4l5hciTBdYQwD7Djh4y7+CqxOlEoP55z4YfZrX6fg1PmgRsTMNYJDgYd8QvcHsRzX2b64S0oewjTd1eF1HP1M5DZ/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5936
X-OriginatorOrg: intel.com

Hi Haifeng,

Thank you for sharing your requirements as well as submitting
changes to support them.

I would like to start with a high level overview that applies
to all three patches you submitted. This relates to customs,
formatting, and style that will help your contributions get
into the kernel.

In your next submission, please do submit your patches together
as a series with a cover letter. This means that your series
starts with a cover letter (think of it as "patch #0") and the
patches are sent in reply to that cover letter. This is described
in more detail in "Documentation/process/5.Posting.rst".

Regarding the patches themselves. Please read and follow
Documentation/process/coding-style.rst and
Documentation/process/maintainer-tip.rst regarding customs.
The former is a general document that applies to the whole kernel
while the latter contains more specific customs related to the
area you are are contributing to here.

As a final comment, please ensure that your patches
pass a "scripts/checkpatch.pl --strict" check. There are more
details about this in "Documentation/process/5.Posting.rst".

While the documents mentioned above should get you started there
is a lot of other valuable information in "Documentation/process".
Consider the index in that directory to help you navigate through
the available topics.

On 1/23/2024 1:20 AM, Haifeng Xu wrote:
> We can know the number of CLOSIDs for each rdt resource, for example:
> 
> cat /sys/fs/resctrl/info/L3/num_closids
> cat /sys/fs/resctrl/info/MB/num_closids
> ...
> 
> The number of available CLOSIDs is the minimal value of them. When users
> try to create new control groups, to avoid running out of CLOSIDs, they
> have to traverse /sys/fs/resctrl/ and count the number of directories.
> 
> To make things more easier, add a RFTYPE_TOP_INFO file 'free_closids'
> that tells users how many free closids are left.

I do not see this as a change that benefits the kernel or user space.
It sounds to me as though user space is planning some behavior based
on what it knows about the current kernel internals and requesting
more information to peek into these internals to make it easier
to do so. The kernel can always choose to do things different
internally, but it is required to maintain a consistent interface to
user space. We should thus always take great care with new interfaces.

From what I can tell user space intends to use this "free_closids"
to mean "how many more control resource groups can be created". This
is not a contract that I think we should enter into. There has been
discussions aiming to disconnect the number of resource groups
from the number of closids (effectively letting resource groups
with the same resource allocations share a closid). This is something
that the kernel may still do at some point but sharing "free_closids"
knowing that user space intends to use it as a "number of resource groups
remaining" counter would make future enhancements like this difficult.

Could you please provide more detail in why this is required? User
space should not need to keep track to know how many groups can be
created, creating a new group will fail with ENOSPC if no more
groups can be created.

Reinette

