Return-Path: <linux-kernel+bounces-106951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186D87F5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6FE1F2222E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E697C0B2;
	Tue, 19 Mar 2024 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAY1URRK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0F7C0A9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816569; cv=fail; b=gUAOR9fAEcl1B7QjhoYHLsh18Ui9/JWWMw3L+p4KvPTlETQUzO6etUw3IP9MwZ90+N8pnCxJR/j+zeZ9Na2A18khuIAlbSpWSIhQvojyLqX7+t85McI1d13R+KAUigfp/IW+PZ6WsD8XOAWpLxab+LWbRp/4gM7/wdEc3BvRHJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816569; c=relaxed/simple;
	bh=7SXDgYIHn0NmjYfx25HEblNiypGqTS1EJOWg2FLOInE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lDAw/AnW+AzpFxTewowsLqN7VMdFJ1XHEfJPcpCacKF1mTPJ5CNvu4Pgg+tDazgIEIU5jkyfhHtL/1yH0ME3eE8u3fm3RZ07p811FxPIMAiSz/eaa0Ay3SAcQ6OZIdIn5NQslRMkhtqWLIrVMD7G7mDNdz+qB39+89JdUFoImfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAY1URRK; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710816568; x=1742352568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7SXDgYIHn0NmjYfx25HEblNiypGqTS1EJOWg2FLOInE=;
  b=VAY1URRKNFHmSGKnlQ0yzHJID5oEQp71QamyXZoQxhXeV2IUvpLXASbf
   nz9WbrMKNrZcoOVLzebV96cuLXNn2oisY9QDbrGrm6fPtdI6mVF//lZ+Z
   INzLnft2QctMag4m1+yHfedMt8ugiqW6ilRu74nYip4W5JL82+436b6pg
   CFfSmMOaKt0KNcLY/WpwHFhVwh9cgZb4ik9+kkjvDlGMCMc77DmoDBi+T
   lIDlXNI8UKWCnDlHiz/OGayv5gmuQ42boyPv3gV9PLwvSJtiabPgdFrNy
   mZcAN93RkHuu+qMLFl6EtFDiHaLjNms1IYVE/NV/v3oAVQfBBhiom0Ksz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="9466297"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="9466297"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 19:49:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="36790887"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 19:49:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 19:49:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 19:49:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 19:49:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Re1V1xIenNbNaOz4cqUbeVcRmpcVYZZb8xcCHaATPJ3+WsW1h2Q9LBz5TvN5/mMoh8IUDpzfF1MhqEdA7RFIPdeWoUi915r2cLXf4qhoZ8hspEAM9OSN7Wdr/7UqfOTnAqyjIl0Wy/0NU1eTVtXGrYJeHDfJSRF4BpEGqCBVucRyy/FSmXbAFtrLWgcy8T0K9q/wxH2//4FoVeDWIVhdBxwjQOAUc02eh756YN8CuGp+O/904QxStKSdQgLxhbOi87XHkqAKxpv1DTipU0SRbMKtyBHzmt8SDM12YoSYWuaWQN8xTLehb+BONjmGpP5qm6gsHrxnQfh4/fDJZtztIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQZC//rnSx2KYwTqY5nzYQ8RTr+qll1CoE3FQWdOZL0=;
 b=YpHdW7MAM2JQCVkeO9w6/CGKq8wauIFOY9TFCL0ExbyVXrCuxz/Q1g8k2xMPcdNkGFTy+qkbMdFZn5QPvqJ4J37+x8rV8kMYQwKXcDxH+JK7kUJu+ubSvZh7JZR2CoVgeBLO9ABUN4zMJiOoJ1cVDT7FdUvAGzlsDdIDjDboKgRdmNf42ywYhjkunclgzx9MdnRCVsS/w3DnmHyWGe7ItjB3PaC8OA7pHw+/HliXZNIyq0OQbGavUfrBtLtenR0A3uFdP5tENu3DhzDTWCdZIpbr+4zFylshRPkZwGKAyp2QUKX6OLcyd1mwboT7R7A0xevpSF0ExHQfIhoovj4cyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7394.namprd11.prod.outlook.com (2603:10b6:930:85::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Tue, 19 Mar
 2024 02:49:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::58dd:99ca:74a6:2e3e%3]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 02:49:25 +0000
Date: Tue, 19 Mar 2024 10:49:16 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Keith Busch <kbusch@kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [nvme]  63dfa10043:  fsmark.files_per_sec 6.4%
 improvement
Message-ID: <Zfj9LGMEjMEaN2DS@xsang-OptiPlex-9020>
References: <202403151552.e3809b61-oliver.sang@intel.com>
 <20240317203645.GB5975@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240317203645.GB5975@lst.de>
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7394:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRPOvS5zYKCPFE01VudM8wHLAAdOvt9eiLzpqCwsVlq61bdupZ3X5w1cWOOOMSYSU/XTMBNNOUZvV+adi4fjEfquCOX3eiZaIxfHrmTA6Ef4Djxbdy5euTLhsCiE2W1sp1w7OlgsunK4YgWGLen5thwgRq1FltXw6IPKznxaFssI/qV6lLwO20ETK69k+YJKT2p5vEgf9ba0B3O0jQyWMzS0EbVbWRW1iVM4hCgj0/bnORNY28H33qn2uSPHuvEdocZNGMbyyuLyH3TnWEiKB4vhC9dIBWZQdhzE3egpuiUFJj1osOEmx0TNm50QzRYlZvFtAoLF+XfUDW1lMP7nU3SfCB0tRKCdw++cyDCMNG0AeRFqtPRL/W+8wkVk3xqcItFgXK796QwCtbfxma5mnAn37xXfm+6DGOAAiCf2ijjSxlgYxsbptSWl1xTwzCkTOe9xPZR25rVB64XDF471+qULkMkh+m6CygXYMn3vmsrMngZkakzpeuybfHxO54rWw61PY8YiuefWtNjpCYjkjcW+SEPxuBkxN5HFQWqge1bPvrry0P5QdyVlK8MQS3xz7XBv3AkhuMQI+qeveHHdsmPvxC2LQvDPZOCI6Tmv8D4UWKgK6X4As6iFAjAd63ip
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+6mGVVwjaDxOcpjsS1EtMcwdhd0rG9ZqObffswz0oPYZG2tH8YhHTfBeGtO?=
 =?us-ascii?Q?uMJtDwnT7LAMSnlP/fqarJGx1Tp7YUSIuQ0RlrLkjOTBbd+1JlpsUtHF/U8l?=
 =?us-ascii?Q?Kr/QGuZeUOthjHd5211mA/o/4+ZixxqUmmZs54Qr8/RGH/eGxFcBCl/EyZzw?=
 =?us-ascii?Q?OKS4njdnafOKVFCA189BVxUrhVkS0rNOfugsEO3GRRhXUvv507XfPK5Ktanv?=
 =?us-ascii?Q?SzGRirv5eCUU9NOUYfxQuKekWgngXSazpW7kyZJlwuh82Imm7HGlRQZcvxMM?=
 =?us-ascii?Q?QFKjeFZS19kohsenq7AuxRgi64sDOVCfJR+a+6mXVKgXcCg6rsdZR36hDPY4?=
 =?us-ascii?Q?fB+6DRxDNkB+wSq6Wng0Sr+hhNh3M1as808Snb6qv2/0pM9jKVBkfrPAhkhD?=
 =?us-ascii?Q?uLdiMxszt7Gsu9RkHcaEJTJ/RJc6SB3lrNV5ulm460ITreOWV9nIekqnZnXK?=
 =?us-ascii?Q?+49KtNbqg49x8evya4l3D8Oj2Gnvc9XIGQutdJqokAUqDIJuw6Hxb4JvhmZp?=
 =?us-ascii?Q?1KEs/Q5zEgQkL/jNSKphoFVk53qygGMIY/QjZU187IAIN7+ZGUENrZcIKXHq?=
 =?us-ascii?Q?SXT+WNoGhyCZBNzL1ZabPFYBj/JD3JikZm6wr5pvbyAUq42VFxHcRrSn8snw?=
 =?us-ascii?Q?WyvBbXTdsEJDgq6R98ExJc+tA5ggZbYIux/n+c1wtGFiTB0mlSBFCG7fxsK4?=
 =?us-ascii?Q?OxeUqn87h9b5qzo37jQXheZK0VZz0e2427ladbw1ZU3IxQSu/4ZBNJQ3XJ5+?=
 =?us-ascii?Q?pboqRA9/6+41Qt/9Eo/51ljzRbIqvDZSamNI/Rt0hcOv7LofQL3iqDV9ABRf?=
 =?us-ascii?Q?hGxwvo3VznhoI9kXjwdlywQh+xlXvEbAIqZD0JAlw5ILRQMSPWg/k6GLI9LD?=
 =?us-ascii?Q?Je6Zp9+rkFJhCVr0+7ns0Vcq8qejnw48ZCWNi07WtdWF4gfco5ZjjFydpU56?=
 =?us-ascii?Q?Oxsk1bCBfx4MlgxFRjXDnS7gI+ZnoCbBdKW8yiPvqJ6HXCIboroOsUjfEQQe?=
 =?us-ascii?Q?JWG1EN1qQFh8UiYfagPcltb39RU/m7Fk9a46AREaK3w3sz8HgCz1zWK2OoRL?=
 =?us-ascii?Q?qkRl9TR09XrpzyxusYBqQHo5FNfmILkCop4B3Pwr5mgRhB5KDQvYhpAtdSvw?=
 =?us-ascii?Q?V9R/n/o4LieoIQWTwqM5rQab/lCAAZbdbNIFTYkbfUup0ueT5XsiiDOnruCZ?=
 =?us-ascii?Q?1EK38Q2gtVfaPs3V6hVzCuIMD5PJpqYyyZwCK2tLzXwGgmvETGbKz4cq3Lc5?=
 =?us-ascii?Q?A8ZxxIrAnY8EfYqVJ7RuS2/FiGlBIWjK5aWfx3Jr+Azn0dlxTbJOv6Q/6VTU?=
 =?us-ascii?Q?vHSlwf8rHQncSV+zx3antlPwa53NGZ51N/RIIaD1y4JLpB0j8kagqi0hLDnX?=
 =?us-ascii?Q?hKzIPcyAvS67vVaUcw20c1ofgK+ieNsXRpmZ6ueY7yBdEefOHD99XquMxX7s?=
 =?us-ascii?Q?LIhLxUgEMAMIrvdMppFTOIMekCWs1wv+JP56X3Vkb7a1N3WZ1nhs3PWV1tio?=
 =?us-ascii?Q?nqN8+7hLzy+JnaFp9iN+qNYXscpJt4xaXYo5AqNjSMf8QcAeDe9gsHr4qM2B?=
 =?us-ascii?Q?hJhjtcGmpxXurLj+AY3XKAoLYoxZk/4+GMuJgUoi9JNFl4/yfpfbrHJHcSXV?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e9dfd2-4137-4b5c-2434-08dc47bf3009
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 02:49:25.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBCAtT6xENTItun8pN2dUyP0frn20t+lJcqPLOZSJarywSps2JuNiGG4ILrKHJrzSVzu5JceG6a9NUvB7kOW7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7394
X-OriginatorOrg: intel.com

hi, Christoph Hellwig,

On Sun, Mar 17, 2024 at 09:36:45PM +0100, Christoph Hellwig wrote:
> On Fri, Mar 15, 2024 at 04:21:13PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 6.4% improvement of fsmark.files_per_sec on:
> > 
> > 
> > commit: 63dfa1004322d596417f23da43cdc43cf6298c71 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > testcase: fsmark
> > test machine: 96 threads 2 sockets Intel(R) Xeon(R) Platinum 8260L CPU @ 2.40GHz (Cascade Lake) with 128G memory
> > parameters:
> 
> That is kinda odd and unexpected.  Is this system using one of the old
> Intel SSDs that this quirk is actually used for?
>

yeah, the nvme sdd on this system is quite old (DC P3608 serial):

https://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/ssd-dc-p3608-spec.pdf 

