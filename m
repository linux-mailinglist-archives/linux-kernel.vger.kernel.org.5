Return-Path: <linux-kernel+bounces-42939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B98408EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B8428A1D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BA5152DE0;
	Mon, 29 Jan 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MgvadNBZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5A66B27
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539787; cv=fail; b=ZUJsGVYpCtVnqLM1+5+KRDizc2SfJyqvwftIUOTRlnbLhmhxkVwB1K9vdHc50vUDgpHkjBXYKH84MY/L5Qj+8Ols/C9jqMeSPHIT8z2UqAwyKdSGx0sFY8O7hklDyrX8AbruNNA/hYPDb4jNNZdhT2Vt5XKFHoho/KxxjRCfiIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539787; c=relaxed/simple;
	bh=Vh2h3JDAP+qdf7orrFflJ41QDqUFiMQO3OVxrmvUKgA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l6hnJ9eUQdiLAOhQec5aUaDgh0TjOh7eq1HkKPx54+RVeNg561feBmcuvAFfkX833D7SIhf9R4X6jtbko576zdjQ21jln5seByc5K/jKP0nxeOCtM7EyDJQP+RoWXvZO29n3L6Q7/TkHPDMST6wccgRkjXyIBJN8cdd8VikJrAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MgvadNBZ; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706539786; x=1738075786;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Vh2h3JDAP+qdf7orrFflJ41QDqUFiMQO3OVxrmvUKgA=;
  b=MgvadNBZ7cPkXXmc/awU4/ZjGeinexdoD+jW0O42f4svIZntiE0cMDnu
   zOD3vx4feE9CTNIBIV3jocpaMJ7/hiYaBsDqHDFmlB4yAOVcoZk3LZ6+l
   Eq1kzzqJ6n+hvRJk4usJMP97vjIu2cXfzhnzbLlmWPRwFrBwLDOKW0EXi
   HbxnvkQFxrTvBisbo9cJOHYpcDfHjPE8yfR8v5e+ZOPaNmFixZhJV85WV
   x7cmN4TDCTl7iSOngaldkkMdspcoIcz3ZhHbHh4vG5Kbi0jIe5GIyhOfa
   N6Qbc1kGwbDizEvAkQCp5p3mpWhMS/s5EpWeRbm1AGvh3aOJbM628U+5R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2831727"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2831727"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 06:49:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737421538"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="737421538"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 06:49:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 06:49:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 06:49:44 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 06:49:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9AkoqxS3Whl5Z2Xpp7nJc4GOMwzaIUWQCQ1zb7kABZ/0YE4c5VVupuET5+M3pVZP0k1LMeoJVgcKB3zOoD0f9saT8BBXfBk2ExrNcBQUh5CgOr/HUSED5LGToiFWwNhq4iMsFm+xRtWGAEyAPjNpjQk/qJGzuqkwBl5gKpyUJ/MxsQIGVamepJf0GfmZ/d9aOy9Yw5vUCecY9PFQRrFxRyX9giY38RiK30mNrRpm/lnPpGPGMWF0E/sfVE8YvP4eE6+DJa5uSvsJ0Yx4Wt0CYGp6mnDOUqbh+as6cbqz4dUGF+T4IsrZo4wlLexQgR+C0Nucy0R6GtkyGOzY/6OdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epICro8KSYbGRjOgwCVbyxNcdWgGSGYhykPU22kDjuE=;
 b=D4XuVR9SxoEbjeUsC3JgaehPh/xyr8xaOHXyu8jyl/M7TNt6WZqIf30ZzsqcM25fP2S8NyKe4pANybz/FZnmqQEEvzkl9/+lf049dFpAsGp7YYoEVF34Dpdt+53PZ6Dq+G3xFughUxqw4SBEqldXpezAwDq+dHf3A4qL7nzvyRzkVhaxDV7X+nAEbum5hnv5Dz+bdRrr19y7XZCoGelXvCv+vdIO1+XiypdVa9maKhEXTYY1jKHK2oWQCdcDp+FHJfayLYrthrxr3LlDjzFv23YysiVq6O8+qr7VelOX7f6fzlf1Job9ZduMmOxWNwAx5hCu7UEpYttSPGn+r4uCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 14:49:37 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 14:49:37 +0000
Date: Mon, 29 Jan 2024 08:49:35 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Yury Norov <yury.norov@gmail.com>
CC: <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, <intel-xe@lists.freedesktop.org>
Subject: Re: Re: Re: [PATCH 1/3] bits: introduce fixed-type genmasks
Message-ID: <yro4nl7ryt6ckxpkctkaao6sd7j4533w2u66ae4kecpu6riszl@lj5sspyvapwq>
References: <20240124050205.3646390-1-lucas.demarchi@intel.com>
 <20240124050205.3646390-2-lucas.demarchi@intel.com>
 <87v87jkvrx.fsf@intel.com>
 <gvkvihpcc45275idrfukjqbvgem767evrux5sx5lnh5hofqemk@ppbkcauitvwb>
 <ZbEsfl0tGLY+xJl0@yury-ThinkPad>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbEsfl0tGLY+xJl0@yury-ThinkPad>
X-ClientProxiedBy: BYAPR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:a03:60::16) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|CO1PR11MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: a0485262-0f1c-4df1-52e0-08dc20d983bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7E8dcpD6uWrSdLBVp+4hoGt/Na4sITxnDBXuMMQ+wz5K9Q/gU7nQO34lUMehvY18Lvni3P+c2JGa97Vi4YobY1rNb8vAF6mJwXfobYgEiKpeJXpg6jdzGkYw5tF1br+loQpOYUqNnJwpj0PZJdX3u8WjzXQn8sGQnh4/kk1VLph7W0xia/5S6/5fjBBSqcdW3GsMWQuItbmVAS8VPeeL3GfSQfpYDggPsB6I0vKCyKE0dPQoDYzzfy2Fp5JCCP6Msj1c5+iPz/dsqGPsuKIFDUwFto4n6Gq1J71sdMJ4vMqDwdTcu3QTlTwlsO60qlci1iulHLcvBPag+Xjd5XIvyU8ABmhvYbj3oPYPbqztltpLvnHdktgssoHx7ouAjivhqu1eXmQuYj2e/Lz3wj/C42fLQ5Nly2TNAjxbSYYj7UtdZvqELZxU+hffr7jaRpUCa8KSjzBb1IEzmfTgC+k7SxVySWdb3023DcpDonDvJ+1G0dTRM/jgRwLIxco+wWB6oNFWCkjvxQJosgNIO6+kFDUgqJORxhjzBQ8iX4XCT5Z5SsOURI0nt5VSQDoE1X0j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(26005)(6506007)(38100700002)(4326008)(5660300002)(8676002)(33716001)(8936002)(41300700001)(478600001)(2906002)(316002)(6486002)(66556008)(66476007)(6916009)(66946007)(9686003)(86362001)(82960400001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3YrTTR0T2ttZkFTVjA5MlpPcWxlSkgyaDJIN0oxUVNkOUVyRmI2NDRjb2Y0?=
 =?utf-8?B?ang3UCtrOG40KzBHM1F6TUxDK2l6SjNSUEIwREJRdE00N0UwRWpYQnErMlV3?=
 =?utf-8?B?bzZXaTdLR1RUQUJlaWc5UjhvZUFsMjJoZUZTRVV6VkQ0SVIyQkIzdytKRmhJ?=
 =?utf-8?B?S0NWQUx6WnRremlmMVI2N05wVWx0VHYweDJ3U2F6RGRNcHZabEV2ekpuVGJj?=
 =?utf-8?B?YzU3c3FuWUxOajNLdm5vRGdyVERFbGtURW9iOGhIbUNSTnJRdG0zeTZQOHhV?=
 =?utf-8?B?ZEx5OG53WGlBVXFwVURJSWRjVDd5cWUzclQzbTFxOWpBd3gyNTZubU9nKzl1?=
 =?utf-8?B?dTdtdmNtTXA3bm9qNitNNXNHdDJ0S2xnakxaa2I0U0xVREJUTkVTdEFrdExt?=
 =?utf-8?B?cG9RVWJQbk1TZEVFdHhqME5WYUViWEM1MlJGT1JqWk90QS9HSHRFbndoanpZ?=
 =?utf-8?B?TUp4bzRLd3hwN3ZTWGM2b2hqaTJwQ1ZMQzNhdUN0YjMxaTBjVXJ4RFVqQ2hD?=
 =?utf-8?B?a2U1TUpCUXlZMlliVXZyaE0zUTNQNlFyQmxrb3lNdFBIcmpzdWg5bVpCclhz?=
 =?utf-8?B?ZG1NQWI4OS9IWE4yQ3NWMllqeUVGNWVyQ3dOUUlCbDkyRGxMc0F5WFFTUWxi?=
 =?utf-8?B?M3dpTnhMdldaTXhWR3EvVDFtODE1SkhmdHFqb0hoNmQvekE4cXhySEVCRjBw?=
 =?utf-8?B?M25UbHF0YllqakZ0S2V0SW50MTBQQ3luMzRxU2s5cWtNT0I1WGttUjlEUVlH?=
 =?utf-8?B?VzhWT0ZXcnJGajVQbC93ZUc5NU5oaWJITkxtaDdXbWQwV1l3eTZmSkZ0VXBV?=
 =?utf-8?B?cTZYK1o4TGp5RGVwSzkwRnlMT0hISDAzZTZINStWaDFubFRkWjRkUEttUCt4?=
 =?utf-8?B?djcya01GZDFXb1MwRURuL1J5MmZURGFDUXJ5RGhuaXBGVkp2ZDlSa2pxM3FL?=
 =?utf-8?B?NUFoWXBYVDZxeWl4L0ZWQjdtenNHL2V4Z3Y1OWRJY1BDQ01nYWtRWVNuL1dl?=
 =?utf-8?B?TS9kMHdZM1hxR3hkUGljcFhTQTBxOVFQZ0RxWUF2Ni9ucUpINTI2RklwWlFG?=
 =?utf-8?B?SlpTZUNjMlljd3ozZEZLRnRBT2NQS04rb09iZ01FSjRYRmFyd0RsSnJpQ3hk?=
 =?utf-8?B?UXRic29GVUJXU1NsMWlTOURXc2VYRTBXRU90ai9uY25uT05NSU1IU0s1YjUw?=
 =?utf-8?B?R1NwU2ZGL24wenBKeE1hTSswQTN3dGhmeUhwL3BPWVk1UXoxbG9BVHVJNXI4?=
 =?utf-8?B?RVhVU0dScjJ6clk0amc2ZUZwNkJHMnVXcFRjZ3c1cDdWeVRQRFBVUHdBYjBo?=
 =?utf-8?B?QURBNjdFaTNWbGZFWFhJMUMyZyt2YzhEZmcvMndMa2gyZGxUdGdZOHRZSk5S?=
 =?utf-8?B?S0dVMlR0aEhlUU5jQitlM0FQM1RoakNSUDR0Um0vREV3VDhZeTBIVStmcXYr?=
 =?utf-8?B?VUUwYlF2ckhZY3dKckNZQkphcEVvSjNENXo1TEg3dmQyYmVTaXFhckxWTnlm?=
 =?utf-8?B?RE10WE9mTys2b1pQVFF1U3ViVDQ0Q0M5QmFLeU1SeDZwVzU5d2dPOHhVT1Y0?=
 =?utf-8?B?Rm5MdTNhSG9Yc3cybFNYUVVHb09TWXRDOENHZlVLOTJmbzZCMjZoVW1hWS9h?=
 =?utf-8?B?VnF6TWdUTzFvSG5CVHE5TWs4bVhGelZXRnhFazBPWXZnNHdxOEpCak1oN29O?=
 =?utf-8?B?N0I5NXZ5VVJwMVZKVWJDcW8wYTA5dTdaa0VyalFBMTRzeVFNRFhyVGVxOHd6?=
 =?utf-8?B?QUJUVzdmd3kxZDVsTlFZM3RpdmNvNUdBeW9yMThOK1NGaUlURHd3akhmdDAv?=
 =?utf-8?B?aHk1UWR4d29JYmVZNU5ZNmF1ck5Lcld6cTBMYkRpdytSS3lwS0J3eUhmLzRu?=
 =?utf-8?B?dVVIa1MzNkRFOElKaHBZQVpMUXl3TG5lTFBIUVpScFZLMmFQUGV1N093MkUw?=
 =?utf-8?B?SzdHU2dYd1QrRGdnV0FYMEszVFo4K3RWaFBsRElkUlFONEV4bTRzOWhieUUr?=
 =?utf-8?B?MllNOG14MVJPWkxXcGFWMTRrUTZjRDFhdFlBQysyUVA4WXJjMHYxMFhMQ1Mr?=
 =?utf-8?B?aE5lL2JjS1IwTnNNeGdsTDRYWnNjZXFkd3JsazZ2NDkrSGpwSUtDTkdvT09Y?=
 =?utf-8?B?NENIdnRHajBhcXNYSFNabUVhU3ZsRWJPNlNUcmZseEV5Q1RidVhJczNYdkpY?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0485262-0f1c-4df1-52e0-08dc20d983bc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 14:49:37.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptd06JQeTmXx1egCB1eKk/h6CTSrD/0GfKskxqZfL08wV1lMGJuBhp4AvTH7wGr1677AOAGACP3UA+BiDLNh1u+dE81IacDxeti7t9RSWHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5057
X-OriginatorOrg: intel.com

On Wed, Jan 24, 2024 at 07:27:58AM -0800, Yury Norov wrote:
>On Wed, Jan 24, 2024 at 08:03:53AM -0600, Lucas De Marchi wrote:
>> On Wed, Jan 24, 2024 at 09:58:26AM +0200, Jani Nikula wrote:
>> > On Tue, 23 Jan 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>> > > From: Yury Norov <yury.norov@gmail.com>
>> > >
>> > > Generalize __GENMASK() to support different types, and implement
>> > > fixed-types versions of GENMASK() based on it. The fixed-type version
>> > > allows more strict checks to the min/max values accepted, which is
>> > > useful for defining registers like implemented by i915 and xe drivers
>> > > with their REG_GENMASK*() macros.
>> >
>> > Mmh, the commit message says the fixed-type version allows more strict
>> > checks, but none are actually added. GENMASK_INPUT_CHECK() remains the
>> > same.
>> >
>> > Compared to the i915 and xe versions, this is more lax now. You could
>> > specify GENMASK_U32(63,32) without complaints.
>>
>> Doing this on top of the this series:
>>
>> -#define   XELPDP_PORT_M2P_COMMAND_TYPE_MASK            REG_GENMASK(30, 27)
>> +#define   XELPDP_PORT_M2P_COMMAND_TYPE_MASK            REG_GENMASK(62, 32)
>>
>> and I do get a build failure:
>>
>> ../drivers/gpu/drm/i915/display/intel_cx0_phy.c: In function ‘__intel_cx0_read_once’:
>> ../include/linux/bits.h:41:31: error: left shift count >= width of type [-Werror=shift-count-overflow]
>>    41 |          (((t)~0ULL - ((t)(1) << (l)) + 1) & \
>>       |                               ^~
>
>I would better include this in commit message to avoid people's
>confusion. If it comes to v2, can you please do it and mention that
>this trick relies on shift-count-overflow compiler check?

either that or an explicit check as it was suggested. What's your
preference?

Lucas De Marchi

>
>Thanks,
>Yury

