Return-Path: <linux-kernel+bounces-9080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7195481C00E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A94DB2447E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805E276DBB;
	Thu, 21 Dec 2023 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANv8sFbj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC876DA0;
	Thu, 21 Dec 2023 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703193942; x=1734729942;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=aRt1Sc7N0h/pHAYHZodXuyNnDtiCFyg2GlXT1A6ezNU=;
  b=ANv8sFbjd5LHbbxsZngdB3m36kLHMEo7vWpdWcl7DkA86cwToOv0wMeD
   sPky8L+43VUObBEUpKiFDwXyg6/8EV+o6LoShFlYrlwC35AxRmw4ciD2D
   6KXxs8GOPwAJ3Z0UmvKEgS6IMNAkWXQW7vac5N0Xje6bT9SmCB/XNQSrI
   37EawIW0C+isgEIl1xWIt34Rn0vIrjUfU/7ADk31WIfGghiYJoWWlsBAK
   P4kqXSicEzrcra2kEwY5sTaqAHYYQkc0DPl8OX+3lsnvIqT8QSB+gYCrN
   nJpvsqEYZFQ4iWEAGVn1xPlT+zpaLGlI3m/fN9fGpzDlhZrqVgSEhHhFE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="399866092"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="399866092"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 13:25:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="25095361"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 13:25:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 13:25:41 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 13:25:41 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 13:25:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHJ6KAbVZ4O3j2NxFlV3DZW7lvaTO/zNZQ4tDYqwaeQPOh94Mqs6efOWaKbR9ViZ/Pe5oLjliRJMU/5GZ0mm8Cz/JY81bwHDSdPmwQBrVU8a6fyLhKQkMuwbrrGLhkx0Qs9fOVK8eNoHlGcVBPpzJz0pUH/YyB7qkSNmmoxC0QfBj04iEJguaKcyEor/2qi4N4LX1HEMCDPcCawwDcLQA1Ofs/q3rkVahM6OVVnv2Bg0LOEfXKHcU4LcFkyKL0sCBxw83VZwGCOqFsiWg2Pim4R2EGxDHaIhp8KyqqAlUU83R5RicYbMybX+aU06E5KMVGODLcSwvRiukCz5jDvyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTDlK41YPDfiFuaMH28YmniE0nQ9bGSbNslC5f6YE2g=;
 b=hcjJ54P7UNhnV0P9XA6a9JIq7czK+r1f6UVWrtLs5LTSUgO69eNV75on0kM+UL7W+kigURz83yqVBrxcaFRbCwci/JWgwhBQbicMuFdqwJQ7y4HVcnQgbp96QYXQ3qmFkGZ2/HX+jnhi8Gd4+Kb71OeR+amEx+qW52Kcbm++vLGZQ45bLLhZf7lRm69HzqsE5CgunlTuvUoSYqL0uvZxOZHhwYU7UBzmDzY/Blo0nRELvtoo0ikXlpxfKhN9AVIkkOrwXq6T6tmPH5ESNxoXpS0jkBLI3uwzMK9ZI/iDiwn3cS+zgoP83/PafKdE146qPwtCybg0XpwicDXtztnpKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB4983.namprd11.prod.outlook.com (2603:10b6:510:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 21:25:38 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 21:25:37 +0000
Date: Thu, 21 Dec 2023 13:25:34 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: Michal Wilczynski <michal.wilczynski@intel.com>, <nvdimm@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <rafael@kernel.org>,
	<vishal.l.verma@intel.com>, <lenb@kernel.org>, <dave.jiang@intel.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>, Andy Shevchenko
	<andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] ACPI: NFIT: Use cleanup.h helpers instead of devm_*()
Message-ID: <6584ad4df04f1_5580229433@iweiny-mobl.notmuch>
References: <20231017082905.1673316-1-michal.wilczynski@intel.com>
 <652f5eddba760_5c0d29449@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CAJZ5v0g5buHjd+EqMsHtuN2vcJHSTCd-cCchvo-44iPi1cKk5A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g5buHjd+EqMsHtuN2vcJHSTCd-cCchvo-44iPi1cKk5A@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0057.namprd17.prod.outlook.com
 (2603:10b6:a03:167::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB4983:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4f65dd-7811-42ad-1061-08dc026b5fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djlbW+nSL6sE8ywl6DoR2W8Yx34pXrihJ4VdljK6Rjt1f2gNp2E2afhI3a0C5LqFRG5kJPEo+5UdaXohp0PoKmv2V/g/IrkdYnzxBcMs7W3juzZm4L5uCKBpox1ylFU4cY80NERRORmQoGZEfdk5q8VHavHic0q1zsfBW6j30126JpUBoKf8u25weFn26zPD+p/Q9bYpxCUJhcZcwuhphu+IYOXrEyhlnVFMmRyGzI179ZngoGSrKcOwcCwc1gt+jhPfBtTrJNxUSmz/5G3vdlQVzk0LoIwUkCo8n42AL7DWNKWRoT8ThwN/8KXn3D5ZnRF0A2R9OVAbfcbXwdDXFE7gqDo/P3hHgyYdxwXzjGCdC8MO0J5q7L3VByzNKgUvibE5kbUykWoCLQ34fykpDcW13UILcXstBoaKt2tbhyOLzqUccK1u3Pkwy8oWULEelnWsxLVJpp2SlLmH2aPoVMZvMu2layu64DG56F6YNINMq6mRznjPsmu5RZkX6+WqAuvq6XKHrSNDORLwdb+3db8IHItvalHoKsUbAnP6uhklfS2c3nMulqJIqKK2aBcy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(6512007)(6666004)(9686003)(26005)(53546011)(4326008)(44832011)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(5660300002)(110136005)(6636002)(66946007)(54906003)(66476007)(66556008)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUNHSlhCRjVYeFhyVGo0N1JBR2lFYVVISVJ6Z0V4bStOWWhMQkk4LzZuZ1hL?=
 =?utf-8?B?MVByNlBpb0IvTEEyeWVkelZ5d3FiZi9zc2tNbThiSXR5My9YcTE2L3JsMk1i?=
 =?utf-8?B?aUVraFR1V2ZBUU1pczlSUEFCcXdlVnUrblJvK1d3aTRsQ0FnaTVRV2c3QjY5?=
 =?utf-8?B?WGpxdkw4VnRvRzAvaUMyQWRkN1dKbTVPaEtaT1RtcG5wREljdFFoTC95WkdY?=
 =?utf-8?B?YnZ4RHdMd0J3VDNkdnQ3b0F6UmZvZ1BPdGxYUEtWQWJqbVNJUks1NGFlR0J6?=
 =?utf-8?B?WU8reFY2QS96RHlWZDJ4TElMRVBJb3pnMEFRODVoVU5MMEJCYkU5Ulk0NlhT?=
 =?utf-8?B?VzVPaFJlN3RDbWVaeDhXMDk3S3FlNUFsSHM2akdac0YzbkwrV0MySVNYbVpQ?=
 =?utf-8?B?eHRNbjI4U2IzYW5iTUIwR2owdUl4R2wwa2lHaUE4UE5MRVpWcGEwWGpwTzVJ?=
 =?utf-8?B?Vlphc0Z6QlVYYjNuOUFiYVE2Z2pZNDRIQkpjYXRCVnBxNXQrWCtBVWhKdmIr?=
 =?utf-8?B?ZWdtT0FsWkxqRFhhajNPeU9pcmM4dE5RWVdYMyt4bUNZS3V6YnF4K0xJTzhy?=
 =?utf-8?B?MVJKRzdiRy9VTHdGM3lMR0lhRDZPcGFSYy9VR1R0VDRuSnJ3M2FLSDZGQmE0?=
 =?utf-8?B?eWVtWWZoNzRXd1kvWVpnaTQwQ0dvU2VEUGUrM1pNNktydis2QkdHS1BWaFN1?=
 =?utf-8?B?Z3ZVdHBwQnVKSWxENGM2M0UrSHRkSDYwZS9PMGQ5ZnRCTkNEeW5BZ015d0dm?=
 =?utf-8?B?UTJDVm9adGpzY2E0N3hJcHcwanBKalUwdGNmd01ScWRZOUNsVEloSFZJbUp2?=
 =?utf-8?B?L1pKa3puMUlWWFpHaGlibFpTcCtadEhaSld1R3ZPUjZTYW50SXhQczhkMERK?=
 =?utf-8?B?MjIwSTNQUVlPZFdadDFKRFJ0T1JZbHMrZ2hHd0ZvV25jK0JNbWJWdnp5QUhZ?=
 =?utf-8?B?ckRBQ3BJenpFekVtdlZrSWF1Nis2clEweUI4T0hVaGwvVDNkYUVaZjhkRUtT?=
 =?utf-8?B?b251d090VmdnbDluNHhId1VTNUlUZTQ5Ujd3K3pyYkd6Y2JOYlB3RHN5K1dq?=
 =?utf-8?B?UWlwbXV6T2NOOEV1ck91L29yYVdaQWV5emVpd0JqNzl2aTlsTDhKQk9iY2hT?=
 =?utf-8?B?TzRCSWtPditua2Y5cFkralViR3dYNzJudkpzVHBZYSttbUdlS1FvNnBSa0tH?=
 =?utf-8?B?K0tORWFRNEtzbTViR2FRUVRhRUNHRWNveDh6ZG0wR2NTYUx0N3Zwb2ZFdURO?=
 =?utf-8?B?UVRJWkEvaUFlRkUwTXp6b3NnMzZib25mY2RKaW5DMm1yTjg1T29zZDQ5RFhG?=
 =?utf-8?B?eVhDVUd2b01GS0VCdDdSTlpUL1E2cTR5ZEhCN0podjVSeTZITTA4YUJ2VHp0?=
 =?utf-8?B?ZEFaWG4wWVIzMDJwWHlhZFUvZ0RTVVorQ08weDJJTFFEVStRbkxyM3BpeTM0?=
 =?utf-8?B?emd3WDc5aEtKaTZiSUJEOGh2M0FWSU16b3g1TklHSVdReWVaL1RQSWdFSENu?=
 =?utf-8?B?NGw2ZDZaQThPMXU4R3NxREhwQXRUNi82dU44L2k5Uk03V3ZEU203UEtkMnBB?=
 =?utf-8?B?TTQ2aUJwME9kNFZiaURkbUFjTlNrSzhHdzVsaUM2cmE2TGtja0kxL3RUSE9B?=
 =?utf-8?B?cjRSRDNlZUJVZ3M0UDZHZzZIdFZRclYyaWRsZjEyejV4WDlad3RKR0luSklL?=
 =?utf-8?B?ZlJWOXZhM0llMXFvTTFYaHVRSG1JUk1lTnNOUUZwaXE4VXl6QVNNWUwza0F6?=
 =?utf-8?B?dm1FMlhsejJLalZsNUg4Yk1kdE9yZ0pkNkpSL0w0NkF5V1R0V3J6UDIvNWx4?=
 =?utf-8?B?czJNRFJuVXJ0MGp5WDh5TDNOWTBPWmFpVGk5UFRSekF5TG5md1NIbUJzYnNp?=
 =?utf-8?B?OGY2aHhUekp0NW9LTDAwUTVCRWpqQnhoK3Z6THNSbmpLcDYyNnFaVDl2NTlV?=
 =?utf-8?B?TFJHaHNYRFBLTzJkSWhwS0hFdktDNkx0THdCQ3dhc0wvdE9zLzlyVHF0Z003?=
 =?utf-8?B?anRPTzdOY3BJMHFYMThBY1NEaUQ2L1FjRlFoRTQzLzdhSFBTbitTbTQ1V3NS?=
 =?utf-8?B?UGJNL2lXRU9QcktPRGhPR3liVzU5T3Z0U3FsZ2YvT0lxejM3cW95d255RXdl?=
 =?utf-8?Q?clQLjuBpW+zAopS95rjihCy/c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4f65dd-7811-42ad-1061-08dc026b5fc0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:25:37.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GfS/dmCRRC9eQ7vRs4JiSfv1NbuTK4stWvZDuYsg0UuR284i6V3S0QoCHFOOzgxzcwIgxGLPiYfn7B0R2L0cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4983
X-OriginatorOrg: intel.com

Rafael J. Wysocki wrote:
> On Wed, Oct 18, 2023 at 6:28 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Michal Wilczynski wrote:
> > > The new cleanup.h facilities that arrived in v6.5-rc1 can replace the
> > > the usage of devm semantics in acpi_nfit_init_interleave_set(). That
> > > routine appears to only be using devm to avoid goto statements. The
> > > new __free() annotation at variable declaration time can achieve the same
> > > effect more efficiently.
> > >
> > > There is no end user visible side effects of this patch, I was
> > > motivated to send this cleanup to practice using the new helpers.
> > >
> > > Suggested-by: Dave Jiang <dave.jiang@intel.com>
> > > Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> > > ---
> > >
> > > Dan, would you like me to give you credit for the changelog changes
> > > with Co-developed-by tag ?
> >
> > Nope, this looks good to me, thanks for fixing it up.
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> Are you going to apply it too, or should I take it?

I'm prepping the nvdimm tree for 6.8.  I will take it.

Ira

