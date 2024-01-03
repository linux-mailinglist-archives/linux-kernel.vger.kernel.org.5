Return-Path: <linux-kernel+bounces-15914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F54D82359A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106211C236A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220A11CABE;
	Wed,  3 Jan 2024 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vq0ok77g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC21CAA8;
	Wed,  3 Jan 2024 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704310255; x=1735846255;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9YEAu7z5cF5cm/CTjODl5zeSsp7Sgzw4zw09LcvFPmY=;
  b=Vq0ok77gNFGgElIWctwIidK5A8Z3iUhNnC5UdvbDsI51g34HFgMXRtRa
   qHtgtOJJ1YvmEDEfsRe44ffdrUqekn0JfE/I+ovnizvGOr/hNnfBTcesd
   NhXxJp7ldQ1qACoGw05cIEdz6RVZlO4e65r9u94l1BEIwuMcTdXuJsZL6
   U9y+JwmKrhFtnnNNmT2WRPzmOtedoUMf1zZZMIlupKY+Zmq3rvcFJWZ9u
   UgsW9kM1o4aYqbvfVCZqpj9YscX7NFyMox7vCRzeV3QhL84xeZHQue00E
   ow9jZse/X/0WR9qZCFGA7s3zasBt3A5AcxP52xsBQ6vNlvkg2J6R1I9MV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="461361061"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="461361061"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 11:30:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="14586148"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 11:30:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 11:30:53 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 11:30:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 11:30:52 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 11:30:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blqdNblRAHdGkQsVTUPLdlVrTjgNRpVK8Qm8lUqNo/2AbJjtdNtlFMsd593+5mBjpup4Ixa7hdjIrz5Ap7++pv9JaIApcjgG3at3Lzf7AR+SMmvlRAeH3T8e60mzwS0TY00XvF+ab9ERO5jyq0F6/qT7JwaQghwILBPKrBXHa2ZIZuDvEKynC8484baxf+QL17kDEG866C+neDDE/f4MJuxSn2LjuEAIAkEiabEYHN3y9Xq/G/f7FohyLaGqIxI/N9vjf2JC5jKSe2StdvXoR3TtkoB07F88gYMSIXrvg/rmJd5ZHrMY8M/I+AuWBSCKL0tsAgerledmM7zAaj9rdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJaiAJFWdGpjZAo5bd/61OoNhxs6FETtZ1zdek9wJAY=;
 b=cHV0f3z15Rk9KpGq0tOdd1xm5whxXnJUpMfaE4iIf/NR30mL/4KcNrV4emTIsFn8H9omDeF/Bqu2MGSn952ghqIdibnmPSAqyAyvU4cKLxsoNUufDd4tycmZcnNdRjkDSjs3+5lWUWV9SV3UbJrLy07v0SoK4HENVCBehbZ6UdH64myYjMDSq8U/2/9xeLh2Q+r7y223xWzbItx6jzxBkML93oUYSpBAm6X2bJh6IgQiXl4Um4diySlhfw74B16azFVVPzRObgN6jnvscmYcuQPW5NwnXJDcXg3sb5AqnWNoLRDtsfKTWwhkvgFYRq7F3FjXWZNSa1ZXsV6P7ZRsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4644.namprd11.prod.outlook.com (2603:10b6:5:28f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 19:30:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 19:30:39 +0000
Date: Wed, 3 Jan 2024 11:30:36 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Dan Williams
	<dan.j.williams@intel.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>, <ira.weiny@intel.com>
Subject: RE: linux-next: duplicate patch in the nvdimm tree
Message-ID: <6595b5dca6bfc_8dc68294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240103152345.116ce8c7@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240103152345.116ce8c7@canb.auug.org.au>
X-ClientProxiedBy: MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4644:EE_
X-MS-Office365-Filtering-Correlation-Id: 36603b33-9eb9-4e69-7d9b-08dc0c9277ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kb7dtUKbusEKCs/g4lvYqa8B+BuABGu2V6hhR65wZfuBif7zmfEbS9yWfshFbnqBv/KReAwbeMxlQJR3xdBPrLJMGEvHgQghhBlSpw1piMKyx2zqDOZZITbfVGqlL+dow5wUJ+PO49J2AvN1yuUJu8DeFuOQq39KOqwkBp5F2ELiAzvjNHqX5ztIT7vubQ6l5KKCYoekv0BOEt5oC5PaXJ2Rvj9WkSQE5lpCylJl/fHUR1pmk5/3R4QAqAGDoz7SYjFj+KujlPHiBLgU7laE9Ly5+a0KTsDiaanSyHwEtVnlhcdXgdjaVplyQGZGmvj8Cob4Yf1G8zdjyptEB1WE1Ia5LZNNw33g0mt/fLsT7MUglao/bDACYlhJh9rUy0VhnUT4fr/Cq+gT0SC5Af9SiKVQqd9okUYrAdRLw8EX5XsdzWe6W2bLg4S1XZ4uPuwCzszX23AkVCqto6tlohhmBnM6XJcS55ock4QxQURcdMxfHPyaZGkCw4ZLskmewuuGmckfy6PrXmeyr/editsF0e0Rj2qSxaxTnvFYCGdFtbV5y8QXb9Sac836KrNlX/64
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6512007)(9686003)(6666004)(107886003)(6506007)(26005)(82960400001)(38100700002)(86362001)(41300700001)(8936002)(4326008)(110136005)(2906002)(5660300002)(4744005)(8676002)(66476007)(66946007)(66556008)(478600001)(6486002)(54906003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e2yhwg3jHfKzL/rJYLpIM733+gOh82kh4IGDy0kAd3/nUVumRZ5YjY/4Ncur?=
 =?us-ascii?Q?5kRYjrml6imaexSeH4gHytMLJTXTRUvJvUdMLtrzFHodJE8Ig3oREitSUtLz?=
 =?us-ascii?Q?ibPfLvOPlBTp8lUW1VOwLkfOoqvZlNX6yw3JxGVazD5ocJpL62zDR92ca4sr?=
 =?us-ascii?Q?PWLu5V1bDR4AijJDzzEVgGk0LpOf3wlTlvUX/+OJGG4Y8sgHB3sjyfFfdEso?=
 =?us-ascii?Q?12gAA7YO4BTt37vVFqgs9ReR3BVAeW7K+B3Xh9mzMzCcQKeFemWV0pjpVMOO?=
 =?us-ascii?Q?0d1hiiWcOQl5Ia470+GDalm/xJfR2SOScUTDDsZ5xxz6eKNFqFbmBLlgaDcf?=
 =?us-ascii?Q?GbkmXi5d2r9mDh4AG3Z1a6ChvvU84jJ5ZJnmPo6kSXv6YVUTuZxVQKyDFxQi?=
 =?us-ascii?Q?9LiyKT1Pp+WnazZHc4LVAAbViWLbo5xoDk8VKOhaobYmPGBY/zCQ/dWZLBQg?=
 =?us-ascii?Q?8sH2nu6LjVB0piM1CCc7oArAE4pWGBKFUl7pLqaICGCVXDNKduxlHy21c3WU?=
 =?us-ascii?Q?SbizRh6k3C2iGCidnRJEw5qwDSIGZ8NgCdmv4xMNY6FGa8euy3o022qB46Qc?=
 =?us-ascii?Q?NtG8re4PuxJk+cRsJ0Q6PuI42TVRJWQTHyzWK7e6lMQFU9LGm5NLNAaL42iI?=
 =?us-ascii?Q?CzSwlvo8bxT0zmABkg2YwFJC00Ra+MZcygtooPYSyCtIPi7V4BtNy6WPFmBV?=
 =?us-ascii?Q?dDfEgAdTHeZXpuf6H1cnr5bCPmiJBtsJM8KyKfgBOcBBGEuRXleJn1gbLKDa?=
 =?us-ascii?Q?oS6iet15KG+k7sy21IVzKJOoNTP3MbPzxxWTJx8Z+wceVR8038p8oANJpQ5E?=
 =?us-ascii?Q?tglcADrOZHmcqb615q6NLTWYRlXGLTTpI3aa9ajM3s4VvCj7iMzylQEOQ/E0?=
 =?us-ascii?Q?20x7wFRjR/CDY+g1Etnh3ho6KsL58/pqJxgUT/ZA1VG51rL4bT4W0lZDpbyu?=
 =?us-ascii?Q?/Ig1A57tCmOGMJOjsodEPTZ830yD2303xX5q9foGaeCltsmcHHTLw4oLlszB?=
 =?us-ascii?Q?ea6jIZKQh9DOqwq1cmZZ62QK+ku5iSGYhdoqyJmMReThZJIHvUeoesXuqyyX?=
 =?us-ascii?Q?hjdPPNslfVPPHpqCMBpw3+xdWJirgS9KW2XlH1mBtwoHJYfoREon77Ms7kUI?=
 =?us-ascii?Q?hcMi7uum0vYOEPl+JqECmAe+a0xICMDdIOsU+8LqifpoqqFLL353ZJdg/U1B?=
 =?us-ascii?Q?cWm2TwILxNyyOT426PWEREv5qeDRwwPyhvKRTrFx5OjjE3zc0pBo+DifjmWY?=
 =?us-ascii?Q?b5ifJPja246AG03uRqJaUDxzljocZrLXtzmJtP1uLaZ9LMv3J/L0viP2vZOz?=
 =?us-ascii?Q?DSCHLWcw1f2ZTggQxnVDnrfhuJpWdTGUYA1Npx6Izxw+kKAol7rJxwf8Ppdf?=
 =?us-ascii?Q?f49a6N0tqFMwFChrveaS1uy5h1vjNdDlPmamYk6NXJTX2VtbbT3fnZwq9/X2?=
 =?us-ascii?Q?X7Gtt8VapxVn8r5oqfoqY3kh+u2CEkm+Kv/t3fvtNbcutqX4fXdizbRishdO?=
 =?us-ascii?Q?CkhEJ9rWgqfr7fi28AltSkSTzgffHvTE9Dk4X7fR7H3VsEkWFqiZ8U1PrgUj?=
 =?us-ascii?Q?R2IMelEdNS6kZVg8GGB20o21Z7mNjlkQgkh6ZVk354cxPuK4Bvi6tlHeUhSF?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36603b33-9eb9-4e69-7d9b-08dc0c9277ae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 19:30:39.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnTfQBRaKFX4oGa/AWIgB1IXmKjeQUskMb+M2AxC6kFDGd2yzD/4R6ZORUMxwf2L1lkIJZeZeMGAI0BZDjOgtgp8glrtWh/sth6KTHAcwYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4644
X-OriginatorOrg: intel.com

Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the char-misc tree as a different commit
> (but the same patch):
> 
>   ce2fa3e597dd ("tools/testing/nvdimm: Add compile-test coverage for ndtest")
> 
> This is commit
> 
>   fddd9e3e4e71 ("tools/testing/nvdimm: Add compile-test coverage for ndtest")
> 
> in the char-misc tree.

Thanks for the heads up, Ira can you drop ce2fa3e597dd since Greg took it already?

