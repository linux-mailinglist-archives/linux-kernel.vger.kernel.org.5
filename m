Return-Path: <linux-kernel+bounces-58699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADEC84EA1B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A431C232FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D594C3BF;
	Thu,  8 Feb 2024 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ho/4VcWz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1DA4EB40;
	Thu,  8 Feb 2024 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707426572; cv=fail; b=IA0/U6mS63dU/W3BpY+YvpSF1GKRUKvp/VP85Az1AQuivWihBvbI4BVHK54qHMQkpSa/ciVRN5CHw+FWHYAwnDv2FYhcAVGI0k+GmNurlmq5i6bWPYGpkiyWYGjKpyMiarXqip+FgwfCyPTl/dCFhQvzdNNh6LwuCrEgWXNDFaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707426572; c=relaxed/simple;
	bh=5xu093wYWztwU1JQbUmgpsn+yYdWR09LoEI25rrKBWM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/1RyelxN8IzoSe9fQuaKmmoloHvkmTsn87ybZWrW2zTdXMOUk3qKZjEl3eEbkVhaKvDMB6tPFoMKRNpPncnCiBskz9mcSfhd9lY42yl/CP9bAllW3/k9K7zImWItKX1p7ufKyEjCdEwrCS/yC4WYgeY0dG3J4Hv7keE4NdJdjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ho/4VcWz; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707426570; x=1738962570;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5xu093wYWztwU1JQbUmgpsn+yYdWR09LoEI25rrKBWM=;
  b=Ho/4VcWze9NhHanngGKdmJZb8N4DWCxOhNMa+u+gio2oRMO8uWYSBhUz
   rfUri0noIMrp1VofFl+EsfDozy3nFtmcaR2T+zX/oRd2oVGwlQvXUbJxr
   ZekC2o/AqI80Slgh8lK1p3UxVAdQO/Ka6/k1QsrYTglbcko0vqNx7OsY4
   DmbUPo2+aGBoQQRCvmSJRcjWkTwHND6dsSiQALeZYHUiZlu5S9MN8XLsT
   GrGwAa02pjZ/NNxK2kB+QCWZ8eU69Q08RUZl54+r7pYCfZqCsSixifByt
   vtUb25JOOIGjPQMWgVc4XmWkLGS+GaU1mxwnYKkuU/+MlMpOW91Imt2jL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="26768637"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="26768637"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 13:09:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="824956351"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="824956351"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 13:09:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:09:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 13:09:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 13:09:27 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 13:09:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9fdCsXEj5JMEACofXT5f15GcYLRRIEvbJ6pyxpGAg12kagqWUuxgDTGgIUPh1ohH1oSJdWYT5v+BIimY1956Esdk4aKiT0pHzEwrX2cEB3/SfTy05YvwZf85x8EoFViH7zdqW494AKBAYvZcmdYzIlakeNfqq+C30iroQyzByaSzDOLQwff8gM5E9pc/FKjjyjxlsj3nJvHWGPR11Om7/+N0eh06rbpPAXuBdw+QKVghyyGL1J9mXeNTTGLtabqLS34v26/RR4WMk7yrJ3dRd2xPPah6sjyED1AQK35JlWybCoBbY9yJUQ8VmPZVclX/Nf2VtdnQZr30zcbtoAPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iS2+ZA9hufiJaVKpmMjK6uEhZSXNVxRxKA43S09oU/s=;
 b=mMQuTO7G7VqZ6Z0MR3yszPXOtMB4BIGO0zxF5UegbknDsb1PWEgfdIb9AaGQmA/g5dzw0/Z0lPj4TKumgNWdxVg+YKEMx6bM6kkJtvuXCIIleptz+uzJgzMA2fr+YxwwbVnzCW3iLicb7MclmQETVfgsKQyDnSKGVeVfnDbjLOcJlCKx1sO2dg4Sol2ebaO3n6NOmYMaqHxWr2cILWWTK0U4wqrBxk8aIuiQrbOSA+yzk4Y8K1+MYo4jkVaIaF8x+U3fLtZjfIiNrXrABEBybtInSOWpCxeDFJz/eaDu8jbd9LXiGvd4yGfl9ttNSAwsQOzDLfQkQ5VoFv5kWUr5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 21:09:25 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 21:09:25 +0000
Message-ID: <75f48901-fbfa-4ef4-99b9-312800d20896@intel.com>
Date: Thu, 8 Feb 2024 13:09:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/MCE: Extend size of the MCE Records pool
To: Avadhut Naik <avadhut.naik@amd.com>, <x86@kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-2-avadhut.naik@amd.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240207225632.159276-2-avadhut.naik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|MW5PR11MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 27531e4e-b79d-46b4-4d65-08dc28ea3a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKsW8mUdSqe6zHY+NK4wtNyCXJ8/xme+YTfNl3Y1J6hdbVK6HEQ3+xXc9RzF6Aunc/eMAZrmAk3O4d8ALv9SAMZUbclSx3ogQe1Pc+4NRolxSp9UOnyV8lcZhvqMlksT9MS+UDSJTnvV9RYKdws6/C3IyhcGl8R0tOv2BqR362/p5sX5jLZpoYJxE5SzYEbIH75JOUnD9zRm8T/c+4QgFh4qYZL+VXc9ZddZVLAEvPrmdNdF7jWRJrgyc4sVyn3zDEVSISFXIlortFwgj1tSmEMp7HihrDHms+iuHC7as+vKn3QSCEvy3l49aShbaqBs/hprSDpfWfpLT64qiviwd+rCBCTpPdG2VvSfurZWwaQL8vkEIbt1P8NXqn22fy25mRUn9vgh0CNfEoUO39NMr1Vgv/G5GH/0gXMJ4mYKJ/Rsg4ncq0PP95mYfPVSRu8wv6FFDmVNVvXze2IdwflFVvAIlM/X7no2Ebc1PY9mpGaMcsrRb290oCKuT7E1nXuFRNKI4Dr8ciFAs90egpuwWTxUaABeU/C0vs/mgWuaVtXvb/6oE1PbUoGR29FQKgmT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(41300700001)(83380400001)(6506007)(53546011)(6486002)(478600001)(6512007)(66476007)(66946007)(66556008)(44832011)(26005)(2616005)(2906002)(36756003)(5660300002)(86362001)(31696002)(316002)(8936002)(4326008)(8676002)(82960400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzM5QjdETnZvdFlWL1F3WnMwbXNqcys5WUxFcW1lTmRnSDJBSFcraDFhS2Mx?=
 =?utf-8?B?ci94NzFYT1UrdDVRUkpOSGxWMjVKMEtuYVFvMTZMeWhOcGVJdEUrTFdmZmVO?=
 =?utf-8?B?TEpzQmFYNnN1Z2REZ25oYWpDNWFNMWFTNC9zekwydGJDc2dpelY0a1B1MDhi?=
 =?utf-8?B?YzFzdVljWnNGTWNiZS8rSS8zaDRtZ3RTbHMwb2E1Njh0TEd3SXREbGdLWXEr?=
 =?utf-8?B?N3pFS1NzZFFyek9jUVhsbXBXRWp6dWRLV0ZuQWFRd3AzNDlrUFFycFZMSjVU?=
 =?utf-8?B?Uzk4TU5KRzNvalp3a1paSDlubkZrWDB0ZnoyWm5WWDhiRFJWRlk2VmRlVnV0?=
 =?utf-8?B?eXZVa2RuUFk3T0NtR2xQeTFsMjVUTUozL0FuYVhVVjhQV3FOdWlYMTNTaktG?=
 =?utf-8?B?ZFI4bmJrZXhid1hKTnYrbWtTRlZ4YTd4YnhaczBGRmFlMml1R2Y4M0J3Ukc0?=
 =?utf-8?B?bWNlcm03WU5KVkVRRTdXRE9Cenh4aVpxMEZyQnB3ZUtXMnF0UWIyK0RlU1h1?=
 =?utf-8?B?SWVqRUhvSGNjUWdlOEtRZ2NjMDB1cThXU3ZNM2luL0ZyV3huS01EMUk1TUxU?=
 =?utf-8?B?QzdtUGlRd2lLbHMzZmpnd0RkWEtOcDY4dll2REVXYkpneWdPemV2Rnk3cUpn?=
 =?utf-8?B?UVdwWHFGclN6NGxtUFRWSXEzQllwb2ZmcEp2RW9yK2daT242NG9iZHZWN1di?=
 =?utf-8?B?Z3Zpb2FBSzJjVjJZWmwvRTF3Qks5YUJLdTlLQ0VOU0t0RitRcFNKRytmcUxs?=
 =?utf-8?B?R0h2cUI4SW54SStnb2RVWjVIS0hOcTFvbXg2dW5yTDZ2VktaeENla1FRVHI5?=
 =?utf-8?B?NU5wV3pnZDF4b2k2VWRXNGRQcWlPanMwMVd0L3dtUDBjcjlHbU5Rdk1yVm1a?=
 =?utf-8?B?M1hOMmdhZDB3d0FISGFuYUZycGpjUVM4ZTMvY0NGVWFrSVk2TmdUWXhMdGcr?=
 =?utf-8?B?akRBR3RNcldmR1VCSm5wZHljT1VyZlQ5YUFWbVFaeG05S2hMSEpzRFQ5S0Mv?=
 =?utf-8?B?Rnp4ZVIyMFhrWGZ5YTd0ckxjRUdpeCs4TTdVUUllRExLRGZrbFV3dE8vaUJW?=
 =?utf-8?B?N2RqbmN6OWhZcHhoNmdaNHIyamhibnhuV2RMRkcvaEhIQSsyTWR1ZmJSbU9Q?=
 =?utf-8?B?NDd3ZFdPaW1LVmFvNUludExWOVA0a1hWV2wremJNcEpVVzhqWVdoQnpraFhH?=
 =?utf-8?B?d1F3VjArZWs5M2Z4djRMczFyWis0aGY0WURDMVZiM2FJVERnbnRsTUxnandE?=
 =?utf-8?B?N0c4NFo4K2lxUGJBQWNrUnQvMDdQOWRCbzJjUnUwaEJ0QitIckF0RWZVRnpV?=
 =?utf-8?B?Z2tpVnVic0tJKzhaODlWU3ZiMWlMMXNzKzVaQU1SVVhBU0FpT215NnZOSGxG?=
 =?utf-8?B?eXpvZGUyY3FNRlJ5UkVod3kyOWVjb3E3MTRKc2J2WDFFQTFaTktWVGYzQnRU?=
 =?utf-8?B?SnJadVB5bVRBdDJMZHFSSE9rR0lVQ3dHNlFua3g2SzdXeitGc0xXU3dCMFBq?=
 =?utf-8?B?Tkg5bG5ROXM5Vlc3Ky9KR0RZTnZURUFSaTlIUm5Oa3paUndWRVFIVzlpdnhE?=
 =?utf-8?B?UjNaYzI4S1pjbU1FKzZHK1Z1OEtGMVcxbVRYcGNoeFNSZ0VMT05rOUx2Z3JH?=
 =?utf-8?B?dDVIYThTeE12MVZhQTJ0N2Q0eWR6cWR4OG54MXVMMEE1TUFIN1JXSDRBWEdm?=
 =?utf-8?B?dDE0UEZhVXVXUXVwS21yTU5uVG9qc1VCaDk4cEdiVjBSeTlVM3JTT05XUmdH?=
 =?utf-8?B?RUlZSVEwbDgxNVZaek9hS3IrbEFyQmc3Yk45Ynd4OG5OeStndE11c0tudmhm?=
 =?utf-8?B?RWY4UFBMcmtZbkJCOGx1eWZFb05MQ25HNitoRysvaVo2MTBJZ3JvYVhYU2J0?=
 =?utf-8?B?akwyL3pqZ3A0MEpHRmgyUkFNTjdGMXg5N0dvSkNQdmlzTkJqOVJLcFlmSlZB?=
 =?utf-8?B?cThGTEh5OVBON3NHazltbnlFaDIwWDZvN3NNUlYyVDduRFE1b0JodWZJckRx?=
 =?utf-8?B?R0hsdm8zNzVwUkgrMHpzK1NKeWl4TzdvcStYOVk1SDBjVGlzK1ZNZyt6UWlB?=
 =?utf-8?B?d2l1dUdHL3hxSUdpYTNUYzhsNHVVdmRPVS9FOEpQYmYwbU1lK3lMdWF2eWtq?=
 =?utf-8?Q?hYAfLtEVmFGpraxYXVAdEDXcW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27531e4e-b79d-46b4-4d65-08dc28ea3a81
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:09:24.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UT+1RfXCR299RkYywRDwNslSyBixdEXss+pPnZJ75hBaqIZQbjqlimqRIRfn+NyXHuKrE5hrUuyD3X+IhbeMyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
X-OriginatorOrg: intel.com

On 2/7/2024 2:56 PM, Avadhut Naik wrote:

> Extend the size of MCE Records pool to better serve modern systems. The
> increase in size depends on the CPU count of the system. Currently, since
> size of struct mce is 124 bytes, each logical CPU of the system will have
> space for at least 2 MCE records available in the pool. To get around the
> allocation woes during early boot time, the same is undertaken using
> late_initcall().
> 

I guess making this proportional to the number of CPUs is probably fine
assuming CPUs and memory capacity *would* generally increase in sync.

But, is there some logic to having 2 MCE records per logical cpu or it
is just a heuristic approach? In practice, the pool is shared amongst
all MCE sources and can be filled by anyone, right?

> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c     |  3 +++
>  arch/x86/kernel/cpu/mce/genpool.c  | 22 ++++++++++++++++++++++
>  arch/x86/kernel/cpu/mce/internal.h |  1 +
>  3 files changed, 26 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index b5cc557cfc37..5d6d7994d549 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -2901,6 +2901,9 @@ static int __init mcheck_late_init(void)
>  	if (mca_cfg.recovery)
>  		enable_copy_mc_fragile();
>  
> +	if (mce_gen_pool_extend())
> +		pr_info("Couldn't extend MCE records pool!\n");
> +

Why do this unconditionally? For a vast majority of low core-count, low
memory systems the default 2 pages would be good enough.

Should there be a threshold beyond which the extension becomes active?
Let's say, for example, a check for num_present_cpus() > 32 (Roughly
based on 8Kb memory and 124b*2 estimate per logical CPU).

Whatever you choose, a comment above the code would be helpful
describing when the extension is expected to be useful.

>  	mcheck_debugfs_init();
>  
>  	/*
> diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
> index fbe8b61c3413..aed01612d342 100644
> --- a/arch/x86/kernel/cpu/mce/genpool.c
> +++ b/arch/x86/kernel/cpu/mce/genpool.c
> @@ -20,6 +20,7 @@
>   * 2 pages to save MCE events for now (~80 MCE records at most).
>   */
>  #define MCE_POOLSZ	(2 * PAGE_SIZE)
> +#define CPU_GEN_MEMSZ	256
>  

The comment above MCE_POOLSZ probably needs a complete re-write. Right
now, it reads as follows:

* This memory pool is only to be used to save MCE records in MCE context.
* MCE events are rare, so a fixed size memory pool should be enough. Use
* 2 pages to save MCE events for now (~80 MCE records at most).

Apart from the numbers being incorrect since sizeof(struct mce) has
increased, this patch is based on the assumption that the current MCE
memory pool is no longer enough in certain cases.

>  static struct gen_pool *mce_evt_pool;
>  static LLIST_HEAD(mce_event_llist);
> @@ -116,6 +117,27 @@ int mce_gen_pool_add(struct mce *mce)
>  	return 0;
>  }
>  
> +int mce_gen_pool_extend(void)
> +{
> +	unsigned long addr, len;

s/len/size/

> +	int ret = -ENOMEM;
> +	u32 num_threads;
> +
> +	num_threads = num_present_cpus();
> +	len = PAGE_ALIGN(num_threads * CPU_GEN_MEMSZ);

Nit: Can the use of the num_threads variable be avoided?
How about:

	size = PAGE_ALIGN(num_present_cpus() * CPU_GEN_MEMSZ);



> +	addr = (unsigned long)kzalloc(len, GFP_KERNEL);

Also, shouldn't the new allocation be incremental to the 2 pages already
present?

Let's say, for example, that you have a 40-cpu system and the calculated
size in this case comes out to 40 * 2 * 128b = 9920bytes  i.e. 3 pages.
You only need to allocate 1 additional page to add to mce_evt_pool
instead of the 3 pages that the current code does.

Sohil

> +
> +	if (!addr)
> +		goto out;
> +
> +	ret = gen_pool_add(mce_evt_pool, addr, len, -1);
> +	if (ret)
> +		kfree((void *)addr);
> +
> +out:
> +	return ret;
> +}
> +
>  static int mce_gen_pool_create(void)
>  {
>  	struct gen_pool *tmpp;



