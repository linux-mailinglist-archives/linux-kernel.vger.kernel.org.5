Return-Path: <linux-kernel+bounces-9180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C555D81C1F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93621C23A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637DC79483;
	Thu, 21 Dec 2023 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R99iyZAP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C879463
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703201395; x=1734737395;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BcOhRO6I286iZ1WzVbgjBpf3otSr201yRDNl5Spv0FU=;
  b=R99iyZAPSjoaMjOEs+OHkGRSxXQf4xWcKtfxvO9xBOfe++2eVpRQRvnq
   M+VgzlLDI5W8px/X6MN2/y0gYxlmVgM2YFP3cDC9ymOBJScWQyGmTsxoq
   IJu2YyuH/2zxBdfgzoCdnGMTubA2tXvqWZTmCpcInqDKAwAtuPqhlTxN0
   zpcNevRzK1flTVzc0t/xGmUh/q3n5abfz7Q5hEf+i8ZqL8cCIy5bU4Ftc
   w1cGUb1Mo1YJyBUq9KuCeM7qhXOT0JUaZWx7I5AOdzSvZ2btOI5ogbWQ5
   gu7PchSrqV5U0Z46W+UI3Os9/E24Jk7I2ScXOGV6I+rlPK7yO1kVB+QWj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="482232210"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="482232210"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 15:29:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="753090625"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="753090625"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 15:29:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 15:29:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 15:29:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 15:29:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 15:29:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExxAT3XeIYx2I4r1XXy6p/Jva6C+Av2uhgmjRxBhdiF/i6Fi0WxzCJR3rvS4sPGyUnSmpZKPiRMbHqLXOmeg2TR1yZPRe9NCiFB5oXDl0BJ3mQI58ax6EX5wh+7uZTSLyGK/HBS2KoKbFfnA/MHvPZ40dsxVf+fseXg1umFrbkRznFzy7x0a4+jVHey7/1YK1F2vh46H6tTuVpl+RmmSwozMhOXlay1KXtaYgwGErTRkbKPsg32ZSbhIdDFDmIyYTJBuw8wJ8yZKmrDYraVUkY3UIHRQh3kD5J/m3XYLTHuxrOUI0ccL0mlZsPjSOUxP7bx4gguDy2CLtOFpXDncNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8XASa0OZI1c6vKMgHvMf5f409RNUF/P0OwhbqjdBIE=;
 b=Qn0jJ8ezD2QqrHYxcy2LcrUKAqL8NVk9jcIp6UA37ZDE5KMWQKyyvrrtupyeh3opoD+vQwqanEQV/xqHDEgwzeHtzZ1bsSjTuC1bgHtmm++Wys6rwenNIKpacJTLh4sY4PFKWgqpzfXdRWtUHj0BLt9FRFMj/0JTrpLgii4XPDMUop1v6zwlgKPNZWIwu29dHeKO1UeslaLSMrKJEXbfEGw/TeH4F/xQ2he2tU8vgQVCsHYdOAEf16H5zQ6HWiis86deEeZAaOOWhm9EgSqV7zyzNuyKf7bOco0LSeJ+9p1h8TKis6KeLo3G+W4nrskpJCqvYrvyIxqnHv+6BJQ1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB7523.namprd11.prod.outlook.com (2603:10b6:510:280::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 23:29:50 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 23:29:50 +0000
Date: Thu, 21 Dec 2023 15:29:47 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, Ira Weiny <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<nvdimm@lists.linux.dev>
Subject: Re: [PATCH 3/3] nvdimm/namespace: fix kernel-doc for function params
Message-ID: <6584ca6af3469_58c5c29481@iweiny-mobl.notmuch>
References: <20231207210545.24056-1-rdunlap@infradead.org>
 <20231207210545.24056-3-rdunlap@infradead.org>
 <6584bce9d01cc_55802294dc@iweiny-mobl.notmuch>
 <dad49b21-f7f5-435a-88fd-6505add3acf4@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dad49b21-f7f5-435a-88fd-6505add3acf4@infradead.org>
X-ClientProxiedBy: BYAPR07CA0067.namprd07.prod.outlook.com
 (2603:10b6:a03:60::44) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8aed62-120b-4157-b824-08dc027cba0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YgioL8UfAZcqutyn1wbG58J5SJEHlRSnpDP1L6RfBFIgHbDj7+EX5JBf5uVdBJKOOOGCNykIz0uhK7bdAaVJQHdqxMxFxgu0T/A2LpU2J2OTkoIQo7FjWooYHRD0acxAUz/lXqXITWuUd1Da4qqTWmAp+hc6rkTo/IxEsueTddM3xfOJLKVP3V3VriDYBGMcqsL2hmgxnJP/+44uADqeY9Tm/NalYChIxu/SjghSQbdxC6UvtTkaNxi3BfXXJ8q+gXUTubLES51KLsP/LlnqoKdAygtVePtPfmnlkO3nh5SacaUZpAKZ4YvxqdqiIocURerhjsVRzZRrJ/wJqoM9TWNVMIJtmPf+x9d/ZxO8ZFHCUIyVW/hIdV08TJd+hvdtyAuUjT6wr+z73mTRU4DfeSHYhlyfn9bLRD+ExAVU6Bg9/U30R3GicdV4Pjaojq5QliTMJOz1+nHf6kIKSzee6lu8/AaH0g3iXanYvoTT/nwfRisGkjx5/KHq5B3OcPHxHEjNpPDu/vu1L01g1rG3uwJTg2KnlZYJoP5YVeOC9Aqvq8p6etd+r67JjikuzVSp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(83380400001)(53546011)(26005)(38100700002)(4326008)(8676002)(8936002)(5660300002)(44832011)(41300700001)(4744005)(2906002)(478600001)(6486002)(6506007)(6512007)(6666004)(9686003)(54906003)(66476007)(66556008)(66946007)(316002)(110136005)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DY/uzy80UVN+HxsSjq6dZjVq4+zJV7aZzp+/22w97jzbmVfqlr3oaT80lEFf?=
 =?us-ascii?Q?Xn6qM96EEZBldmrbHL8Bv8pkvvNxDa1Heelc0D7W0xxbKU+gN9C0szzedueR?=
 =?us-ascii?Q?5nbCkRtiFIDJ4sshxmwTgaPtI4KBQC6upRM41P0hXLMk/k4sPEDyThxPQN/o?=
 =?us-ascii?Q?gOTXTJ5sT2hG6hpKDhg0euUlktuseo4v3o/9b83otDjOU7cepyEInxvnhdhu?=
 =?us-ascii?Q?nkIoGsavQp5fJIYI9qGveHfbkD4q1WgrvcGCic92kVOV2TX3UmSiF9tzBngo?=
 =?us-ascii?Q?YdSeqBYXbVYxg8uYd39rJACK/+OeQ34Ssy+x/VRPVqPxMVFTLOw7H0cKJCC5?=
 =?us-ascii?Q?JejFPCMQvZOALbQHI7zPX2HXfFNgkrlduaGUYpM0bzMDENa+RKDENqNPvVj6?=
 =?us-ascii?Q?/mV2JJuHz8bvvNZhp0q/fxkaXQaXMnQ0SvD/baSiwm2/nOpH9tRLRIaYwUzo?=
 =?us-ascii?Q?nk+sTKo29sY19vUsWAcr9byBAj+pEQU+qMdLP0M++0SUsjkVBN8LeWslLePb?=
 =?us-ascii?Q?rLOdPsEWoextEalNUgyNPDe+QjkC2z12MHYAR6hibcgujOF09xdm3NTetuHH?=
 =?us-ascii?Q?troh9KSd6k2K2op0Nb7sN2LTGmZevdyECCf49nl6KUR4ndMf6BlKXOSFsuJ3?=
 =?us-ascii?Q?fkynccBLvbptS/Qdra3t77ePjSalczGz3CU50l08rBMlXSVPp8fJZGNxRSOx?=
 =?us-ascii?Q?ve++QbKL+ai+AHlxPzu0Tpq9RkbrBHrRqH9Evyc/fPF+QsUJmgnJ09Du92e6?=
 =?us-ascii?Q?GHqKDdkzj3d6PV459LsK4ClytxIexu+6wnoV6geMRhHdpMTZ9PZyKdcQ3Y96?=
 =?us-ascii?Q?qW3jcBXejHXTKEWxTHHlgs9orftvxic9BycOvn9QJ1B7Z7PV4L8yim0siC6Q?=
 =?us-ascii?Q?uTcXGTR8wRyZw8M47oL61KW25s9cSkOcjPX7aKhfD+Xa7Nob9cxY5qQy3kCP?=
 =?us-ascii?Q?Rztb9qZuoREqFMosd9HVAlh8lOglcRpKW2794GWrcojLfdrtI5mFLhs839zX?=
 =?us-ascii?Q?xqbiHAa7g+9yr3x4DnWpOvqoS5aN5DwKY8w/rzMSxwVDe+vwRzQk9k0l6EJf?=
 =?us-ascii?Q?EKfoWNBprPpsEITFcpHw4P4zvAmZnqqRQ0jJvlm/7emv/wDlfkEiYjRCjD5m?=
 =?us-ascii?Q?KYG4VZnR4NJ7+g/gTx1hCZnVR2l+a4Xsh4W627xyn8GUUTJOxTUpbMIr/v2Z?=
 =?us-ascii?Q?cV6OoGVEGuKL2AslX788YssAoLqKqX/nVa+mRa+5biU2fzbwY2KmXIidgZTO?=
 =?us-ascii?Q?BMIjU99SsyUmh0T/Mo8z6hVgGF1BfMX6aOEQ6SA8+Gfm5guV6yoM01hkcuJ5?=
 =?us-ascii?Q?FjGsArM97U/R7nFUgOqAGIUQi7gTnGSES3uGk4YMtnPWKU9ymTnBy97kd/66?=
 =?us-ascii?Q?M5PrD3tzLsquQgFAHpInuflL0oheeAyPzeeG/0sa9UEUCRvTm8QXo54laHR5?=
 =?us-ascii?Q?2vAgW28EtRIF0jRQPxRoJHHwOBy5f8bTERhHYe53y24V/a7BPWV+2109gi42?=
 =?us-ascii?Q?Uiwp0T8lHNTketKMcxTesorwJqPjtRCt4mksQhpiuKCxCTjebrEzRoCnwGvv?=
 =?us-ascii?Q?5e3uoWEmkUkWDTVBpFLIKGheGFqmV3hYlAbxoQu4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8aed62-120b-4157-b824-08dc027cba0f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 23:29:50.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYV9z9VIT2pScZOYwPdpCnV7ERaYxtHfsEAWyUEzw+XV7tegyqr1lDy3VWVldP9MqXgycKyF7XzR5rcYDl3AGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7523
X-OriginatorOrg: intel.com

Randy Dunlap wrote:
> 
> 
> On 12/21/23 14:32, Ira Weiny wrote:
> > Randy Dunlap wrote:
> > 
> > [snip]
> > 
> >> @@ -1656,8 +1664,10 @@ static int select_pmem_id(struct nd_regi
> >>  /**
> >>   * create_namespace_pmem - validate interleave set labelling, retrieve label0
> >>   * @nd_region: region with mappings to validate
> >> - * @nspm: target namespace to create
> >> + * @nd_mapping: container of dpa-resource-root + labels
> >>   * @nd_label: target pmem namespace label to evaluate
> >> + *
> >> + * Returns: the created &struct device on success or -errno on error
> > 
> > NIT: should this be ERR_PTR(-errno) on error?
> 
> Oh, for sure. Thanks for catching that.

I'll clean this up as well if you are good with me changing patch 2/3 as
well.

Ira

