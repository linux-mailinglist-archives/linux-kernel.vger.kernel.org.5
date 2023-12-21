Return-Path: <linux-kernel+bounces-9132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DF381C116
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D61288214
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015DB168DB;
	Thu, 21 Dec 2023 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WxmKgaAk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A53156D7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703197937; x=1734733937;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8kgaf/RbXkgCRbf0KA3x8NTvtRzZ9LwbBCEhVKw0MRc=;
  b=WxmKgaAk3YeVjprc4dlQioDj4yLL48GRFElcz1v9Wh8THL6SqYxS3KL0
   hGrIMdFkac4NJKo0fl1KvUuL2jjF5HbPGXGNC9pBBp2ATDHCqnhdchQgr
   rPRNwJ3ZZ6fKGalUKt9GNIcWAAyRo6dYIEpDbVw2NqOPbASsWWSWvs0nE
   2f92sMZvIU74WjUdPIkEI+tHJ7p85BSBaho2RsskUbU9cKbFU9sh4mISg
   7zeSAcDGxhwRUT1R064oscqIFAOuGxW09ghqoZ466jBPbCosr7kZU6ztb
   ZY0M2fRNLchMASQxjLt/5d8N6pnUcKtGvo6fp3vFRVCXdyzRy1b7D/YCo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="482226916"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="482226916"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:32:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="867458859"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="867458859"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 14:32:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 14:32:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 14:32:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 14:32:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCiBTWmSAZsGwZ4aX/WRWqROIgOy+aGXLG/LCjLxrQvnmJXdczfwBGuefe3brnN0388jem1CYbBqo9zWPLU5FdDxTgndrn7k/7fYuEdGO0xHrxo/Uy5b1zeP+PU0YxoiW5L5jyc8fuQTYDwLjv4pYJWzBLHldc8hDNLm6G67uSbI/mqAdUdVGYdGJFz22A0Zk+JmNJ9hFh4hl19PBtKvM0I7HEbhP2MkGMBRTc7loBf7IVHyUWWw0/txs3Jp0HtrE0fCZ2Zi4g7vfOtNXo6bCB19eLWH/MDfJT1rWyHh1UpNHXTxBWz6I/J5b8pxWNbV4g8YaAq3pxbre6fDAPdprQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5yTUFIs927eX0+xM3DqqU+4w3L8z3+Qsy00HpDhOeo=;
 b=IE7T25Fbu/SuBbmyhq7dkK9CSzKE9eGCTTy1lWVKE1lWS4u7lDS0iKVsun/JG+N6DY2wZ/F+RP07gIJdfU+/G2SzfxzmYADPUIFc7xMu0MnKNb7B1r2x6KAQrRi0EI8EDw9zqDz1nbyX1E42ta5TQxWA1Q8U0iDSfjABjI1UNbU4awQbkulTZ6Ygr2w6ytZE4EfDoKKFq3KxL9GL6FJsavAtRYh+oJpO42KS6mRer5oq/c7Tr51xUtakxfnCepR1bNALYcxGHAHKKcA0DRuIHItJNz5/9MpT40trOl80FOFxwmrGSSQTb8LbE3tpC0MunGDkmHPDqHLSvWzNYANwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8374.namprd11.prod.outlook.com (2603:10b6:806:385::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 22:32:13 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 22:32:12 +0000
Date: Thu, 21 Dec 2023 14:32:09 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, <linux-kernel@vger.kernel.org>
CC: Randy Dunlap <rdunlap@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<nvdimm@lists.linux.dev>
Subject: Re: [PATCH 3/3] nvdimm/namespace: fix kernel-doc for function params
Message-ID: <6584bce9d01cc_55802294dc@iweiny-mobl.notmuch>
References: <20231207210545.24056-1-rdunlap@infradead.org>
 <20231207210545.24056-3-rdunlap@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231207210545.24056-3-rdunlap@infradead.org>
X-ClientProxiedBy: SJ0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:a03:331::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e76bd46-21ae-4cf0-4968-08dc0274ad59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jc0i0wsNYcgH3q+c3LO/nectdPV0hlf0Vdf52dmIKYIX81GqYsCZ7a0pwFceQ08LzD5yyamB6orkVpcmmQzub1w/X6afB4mrZnMe18ofWDqkoIIIe+P1Cglk94t/xvLj0t7S8Z0F8+TtaZvrqR2MD1VbSciYjBdy8gj8J4A/PVW85yJ/H2SqN0+QSHGF7p48kFAu3IiIgs8jE24xN/V0tT0eT91uipXv/zEnRanUrW48WtcYoGAOygaZW9ZAUmCKgfS0taKEw5DkumSkqHZF0PApuMeOSpT4nh0RJRWasUCuglwhcH+LwysbEMRLMYgxiuio+xDeLE63HKn7KWKjEEo04mh8muPkosZN5294YXV8b4JdF2s1LVF/vnQeJWjP8H53y+rWFIA2MG3C/hJBcRKZiL9A4CzKzF16hSnzpaQCvms5ZsB7IFN8WkiWKOqkQ1WEZhgqIXkFcz1UA3PABkvKTEWKJz5Y7QSdbCju0JsInVNzEEdlmHSbNkcDu/tuwTkH9BginCQWicZFwfANnoEanHA5C5If3zFcJFQuUSM5V8Bckn47BGO1csdc3nvc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6506007)(26005)(4326008)(6666004)(4744005)(2906002)(44832011)(8676002)(8936002)(9686003)(6512007)(66556008)(38100700002)(316002)(66476007)(54906003)(5660300002)(66946007)(82960400001)(41300700001)(83380400001)(6486002)(478600001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HXJxEGuWNcRDKewT59u13ZIwFPqPLJIb5jhCKABIT1g7B7AAF6qD35UqcpcY?=
 =?us-ascii?Q?D3Xz6RTnyx1S3vr3G+w6vSLXCD7XpWbU1TxLHSrt/MpB5MD2Lm38tKJQroxh?=
 =?us-ascii?Q?KC4EBG39Uk2v0D0fTQ3zsPWkYzHL6zMZGGpBAem2qDH55FrPFuHSwqYRoBcW?=
 =?us-ascii?Q?sPVcilwYS1Wypfzt+7sRM0uZkAKBZ4EzqwR/pxMbWnOprHzRjk/0U+/7Lk5f?=
 =?us-ascii?Q?zn2GMDvUB2wiWry/AYz/5YWnN7u9UbsUavobSQGWLhAtQOJ8KSImzqrabqjP?=
 =?us-ascii?Q?n9IIybm2tbL5mCtLKHbxNhLmx890CiN0b+sST0RDuNTMBrOISDcu33ZPQeTj?=
 =?us-ascii?Q?XSY0XeoFZGu/YXI5vLX6J3e9tT5K53J2f/IJvWWVISYaHacYUGaGgTC3Mfos?=
 =?us-ascii?Q?IcfOh2QI/gHyyzEUiCRVODtkaL2F6qc9sqninDIVVmwshUKgVX39bNRoulS/?=
 =?us-ascii?Q?7sxKnxCibRf4Tz2d+SUoWLddqRKO1NlCcrSdSnliBbAN2lD/DeR8vFj7sgHz?=
 =?us-ascii?Q?wKMExEqNIjYiwNcE60zm74EOeUHzGaxqoPOwGCYz/LPBEdYnC/UOkABgD9jv?=
 =?us-ascii?Q?69Ep+QnFy8eRVfqf85fKreWBvzrB/3x58HpahsBCjCVHytXPlME4DC3beaVY?=
 =?us-ascii?Q?jKamCwYH/DiVtZBe+WpiQD+dviWx2TwkpGVeDs1XTQEx/ocFOau3+blf8oh7?=
 =?us-ascii?Q?z4csC6ROTyx7YDo6nfRuf7DVS39Kwd6F3Tjb0Viw0hP6tEXqQj8rbYsQqCkt?=
 =?us-ascii?Q?1brgrNw0fUhrlEHEjQMtgGgmYhg8BdoWDr+dKcP96zIgWICNOM5LG3YFuF3h?=
 =?us-ascii?Q?OGTK8eh+MmL6XMUgtSrYEzfepQYnsGN9PKKKfPZM7XxdJlgSq9yPj0+z2zAq?=
 =?us-ascii?Q?ocgv/Lcyi7pklysx7RyFNt875i2mZMaVvScgd08GJncZTEg/gAix4ynsXMb+?=
 =?us-ascii?Q?NRzqzrmT0Us76RzmmvZzzagS+mtQSsedl0qGuYohAKCnEe3Ww7kJGfF+TCUy?=
 =?us-ascii?Q?KSeMlbOXsTjlyFIOpyUaenH+tceKa8Itt8PrMEYfwcfHdNN5HY7/CC6bvG+g?=
 =?us-ascii?Q?UZ4RHOxcLCOdEj0NoBobd9IyAX8BYBYDy2bbWOosSG8lDSoS1zieHg5kFfJX?=
 =?us-ascii?Q?G7RxkQGOAVCi0Riu9SrOGE8pIpEcw8jqtEImaxKxQOmU5MQ2EjDucD4vwLkR?=
 =?us-ascii?Q?q6g8YoEoUk6X6B4voumzTj+b3w1pMU/kwskWVZFqX1UTuQtqV1owLXHL0j88?=
 =?us-ascii?Q?znLRo5nzvFFo7RHaBqlQIDLAkG6BLuVD4xqfVL/o+GC24MkX1s8uPXwmq3tv?=
 =?us-ascii?Q?qj1FDWLZ2oDFaLHTpcTdRqZC64aMilFoE7R9QFAvHz7dMYegEdVdQ8XVpkSp?=
 =?us-ascii?Q?M5MB1jceXzQB6yAJP2Lk9dOLGYIr+yVq21WNF9Z0eAVX5hk3sVRKQ6emB74K?=
 =?us-ascii?Q?S00twH1sxI/sKJqSasZbvxe54SqWx77rfz1i46+nLyct5wOTtckECLvnasLS?=
 =?us-ascii?Q?qNS9QOGRtXnnfqlIw8bqukhMXIWbbjDsCLYC0fi65RqvvPGQnE9vzREfIL7x?=
 =?us-ascii?Q?sBE4v/HV1wa5DJ0/6VKj3Wds6seGJu3cefKoD2y8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e76bd46-21ae-4cf0-4968-08dc0274ad59
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 22:32:12.8582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHveOWTThVW4GbVX6NzhU5/qKLvhUz6pE+mJfq6zzNcX4bJJx8w8eNpFVh+8ZReR3pEMB6xoUoEPvhgWlzekng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8374
X-OriginatorOrg: intel.com

Randy Dunlap wrote:

[snip]

> @@ -1656,8 +1664,10 @@ static int select_pmem_id(struct nd_regi
>  /**
>   * create_namespace_pmem - validate interleave set labelling, retrieve label0
>   * @nd_region: region with mappings to validate
> - * @nspm: target namespace to create
> + * @nd_mapping: container of dpa-resource-root + labels
>   * @nd_label: target pmem namespace label to evaluate
> + *
> + * Returns: the created &struct device on success or -errno on error

NIT: should this be ERR_PTR(-errno) on error?

Generally good to me though.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>   */
>  static struct device *create_namespace_pmem(struct nd_region *nd_region,
>  					    struct nd_mapping *nd_mapping,

