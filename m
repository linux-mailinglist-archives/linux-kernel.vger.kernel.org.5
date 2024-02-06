Return-Path: <linux-kernel+bounces-54947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426A484B545
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9742871CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F22134729;
	Tue,  6 Feb 2024 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsnF/PDT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA3813343E;
	Tue,  6 Feb 2024 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222506; cv=fail; b=UlIkRCgR2xLcy+6+4FHixzRnSOIgG/d2IY48iBGSRIJ6T6pZam4nCwBq1OltOk4TUlyO4oUUQrLnD2yyGYc4Vkb9/Zx5z6sAWvwPaR8c+wDj2X/oDFjW+pB+rmEWYsk/qXx+xDt1vf3qW48hG89PAj2D4fhrgmZgSxJLRe45pYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222506; c=relaxed/simple;
	bh=IeSRswem+wGUCmOYa/sUQFRFGmQv6K5SS2rwuRMmZZs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FzP8hlko+C7L9MuXHM966/EBcBOxuAidjsdOSLvVTFSfXIZKZzTuf0hYLdwI9X91ytr7ZdDglrMCeUubSVslGRoaE2+7UwVcuQK9woYq3RKf+9QP/W5mMQOt3YlxwnTVPWAHIzRYVRhkNIupsGKttP5urg5zbsiYkSM7QrSdboI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsnF/PDT; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707222505; x=1738758505;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IeSRswem+wGUCmOYa/sUQFRFGmQv6K5SS2rwuRMmZZs=;
  b=CsnF/PDT+cuQu0W9utwRk+fuIdSWaMv4AkuXxXsh/czjjlewumDi1mrr
   WEWZY7UCIxM9YxftigM5sb4Uzera7DQcuLz1IcrjuNsFxHrgqE5iiGUtF
   87MfBZJnXrCyCvgwudqDrlz++D5RNtXG0Vj9fo1Fiy+acXwriHFesqQk5
   21pJaBXkHTt4wMoTS65wlSbFczxY1S2NlxOxhxlEdXoRXEDQAxJ2M1daA
   j5jGDvRk9bCEAlFww8Ldq54TDhnjDUaC+yFZfDY4pkJYS4jyNZI5UjJmP
   MKMunwBARLqldYmDUQpHNZryFEdNzEqIhnlQmGRrwFVZCNREi3xslxr0W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4545487"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="4545487"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:26:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1037987"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 04:26:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 04:26:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 04:26:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 04:26:50 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 04:26:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dK+oYNNsWK3G/Hil2Oa9y/VvhndNci5aHfbHgzGxiJwidU95lRZOPA6r0w9cXcUPMAc8f2VkeAXWXJaw8H7F00/BG8AzI/ytEQjtKMqeE0sJgZkRhOayc291AA32zAHNmw/SbXuj4SakDfG71OdN89VESSM15sQb+ldjnCgFE/7ZMySQvQPw8NHlUeJASmrAimtUce2tQlwFFCgaBwK1qinfUUfPVGWxqvNyMZR+r/UgA2zUy+doQ+rsNMdJjogDVLDf4gEnLQ447c4ZP/fsQ9k28ab86wmmHeOpHOVLVX2qG1/dU9skvS0c9o8mkskt5eEn+5NIrN99NRQXFjpkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1F1VcoZpAv03cA2tSYyy+C5WDN02Sp5XuHEfHTr4T8=;
 b=XI7c7SZt9/1DpZrCzJpRTU51KYXgQBJLmTDJ00UTLIti00ubk+Soifk0y2fwG3oEBjBZEOTvZaHUKZMWKgTJ3ICzZn/pv0Ghw2q4JEEZBx4F9qRQjyy2khF4rJOa+U0oMjDlCNFU4Ku6ba46Gk8c9JQhuz2H1MPhCcMhja0k4rh+YIwki4TOZBdIzGrwnkg3BOsP+hiq2spykPHtSqBP/cQCMUQk+pKWw+Wg997ZbJvckN+Iaia0PMRaEd8mmp6nT017jxRV85Wkd9lDGKaSghvd3yu1EWshHPs2XldKD2i7ql3fRXiYipmxH3t7Ucf8qPrTcvn6AXBgqTgDxli2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by PH7PR11MB7596.namprd11.prod.outlook.com (2603:10b6:510:27e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 12:26:48 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::1819:577e:aefc:d65d]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::1819:577e:aefc:d65d%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 12:26:48 +0000
Date: Tue, 6 Feb 2024 12:26:40 +0000
From: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
To: Lenko Donchev <lenko.donchev@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	<qat-linux@intel.com>, <linux-crypto@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] crypto: qat - use kcalloc() instead of kzalloc()
Message-ID: <ZcIlgLvH08xlmmXY@gcabiddu-mobl.ger.corp.intel.com>
References: <ZbeguDTmVrP9SnDr@nixos>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZbeguDTmVrP9SnDr@nixos>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-ClientProxiedBy: DU2P250CA0011.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::16) To CY5PR11MB6366.namprd11.prod.outlook.com
 (2603:10b6:930:3a::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6366:EE_|PH7PR11MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2331dd-0d6c-42e0-b876-08dc270ee39f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnKOKB9Cu8Mp+uwrqiWnP1TyALMHMIdfInZozp8jaLAkhO3ykwcEHXTwiJcvMbPqLwbqBcy03oCLBtYK6D92KgNH4cuT1AjGa4B3BE+d6avnC2OSzlGJw/VxX3/ex/sW5ke3f6bZgXVGd0tFckRHeDJLIYCqlTRIiChUsb/NHEyVv1BrH6JtiuawyOWAT0i/ya7uTQ263Boe7CHPjSSzcUZPpJVp/1qJ3G/UTbVnW9zRE2O1/uwOqZY6JZCj2f8/nEk2Fqg9fAUU7WdqrghlBQ3K6sONcdXt74TXnVPtB6grlIBw3v3Fn9P+jz3eJtmQEYobs9XMM06vTQIpMDn574U9+fwNCu6OEK81CwiwfOKwPDvYgZOj8Oavzahlebo/2btuHFHseEyAB4aO70VG/yohmvQaAsPa4iU8YXCFA/xfuBuyPvRwS5Xo9AsaBvTcCosIj85FN+MTEN6xmZhDsc3dCRh9A7bsC/iJsHMcbVpu/ELdkUmRx8mbxqdDIJHWg5XJqr1EPQ59FFtSzP+g2hKf3c74dTm5FSw45XarXQQiZ3attv0SiDTZtKoAWe88IDSeA7HskjjXUj3NiQ3NAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82960400001)(86362001)(66946007)(4326008)(54906003)(66556008)(66476007)(316002)(478600001)(8676002)(8936002)(966005)(6486002)(5660300002)(6916009)(2906002)(38100700002)(4744005)(26005)(6666004)(6512007)(6506007)(36916002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kcy1JW2rWIiuiDBuPfBK5RucAjkdsGSKbXS5aUUv5nnXzF6rvjiIiLuLg6Eu?=
 =?us-ascii?Q?EeqCCt0j76srmxV19qwifx4f8ixvxt/4Zw+dNDnMDYZWnczuXu/xYv1YFZ2f?=
 =?us-ascii?Q?mLKjvxh8OnzHU7YKdNuNcg/iZis3t3eRnc3GzxGv0lwf2tDRJjedfSVlXl44?=
 =?us-ascii?Q?7bs19tr+OjpjNBwDKqY9QwZJuQGH2UDUIIk4xLzeheVi0ZPJnLuCudICBy4A?=
 =?us-ascii?Q?+ks4PU/JCuLfceVd55BYeD1DwDM7kvgUdCHvPquf25t7HbI8LV3qY6k9a7mq?=
 =?us-ascii?Q?kjDcneUOealjvzbQY/rurShp4QewbWWksjjv0Mp42SrgHzZDGWEbocI3p1mG?=
 =?us-ascii?Q?YKbzz4eBlOQaVPLlmMlzlGeS09pmQQfQt3Jhsc1jDgLLrCzyc2LOtyu7taZP?=
 =?us-ascii?Q?QD7bV/WpEKcNeA1fx1+xu1rzSRwFOI39cUdmeCsREfXHUWOWxCuRF6iXKeEx?=
 =?us-ascii?Q?5NiR08kBpQEHZ05nL9zUp1qQcgx08w9GSg75nzy7D//zbz+0oZRiIAOodCpb?=
 =?us-ascii?Q?IMyxtm27gftViSoDW/QDWklzRUjpmGFKE+bJKgrRJ0Ljfp0nNO9LVd8mbltf?=
 =?us-ascii?Q?QL6TEpvAMwc27ATA8ZCD9ZaO5O8NuDpB1WH/3FNzLukjhcajn1B01kLA4jU7?=
 =?us-ascii?Q?mGnSSCQP098NWWbPBnSuHAOcfQ7frOWODDLq9b/s62mGaYClXPRbuyj6gryK?=
 =?us-ascii?Q?qC8TVf7vTG2p/Q7ejIPqccxPz4UtCnn9w7DRdXRkwieIF0odMguGoriRCkkI?=
 =?us-ascii?Q?rC0GBL/guhgaGdkLyOS/GlhH3OuMIGfG8sK+8pL0BpEj3CBBwwDpd6uJmYDm?=
 =?us-ascii?Q?6BVwdF3NpER4k/xFB9CpOIW9ZTi5SENXTvI2CDE2f57/rlOtSZ5EirK1NSBA?=
 =?us-ascii?Q?M8j5ZJSZaZ7ExAcVV3Rpm1CvujGLQEU2K0Ilx4wksEqZtpYlKv0wdULxvJXm?=
 =?us-ascii?Q?OmOemsFGRMkqPs3IDPfz/9TSokVeUIEJveEy6ToO+p22rjzVedHlof1h515D?=
 =?us-ascii?Q?FqvDXW5TuhTdCZsBhKRuN8qFXRnq4M9YbZoNCp+H1PCRq5RhrrfyYO4lSHOs?=
 =?us-ascii?Q?Iza6JJXXNuVJFMKrI3/hS/8mefZyah66+ucyP4JZKBuF6/c2i7T6kWEUNYMH?=
 =?us-ascii?Q?n6IyFktAO+vvjXQe0lE7gRKIq7saE3ukpuNAN7JrzUEC6THgED8js4eWAB9O?=
 =?us-ascii?Q?+9ybtO9K2WI4NQdxHLv2+ACpDMMcbcr0VNOYdHq40wnsJW2O9/zytS2QucdV?=
 =?us-ascii?Q?/cX4Ry8x87kS5KKE8QmoR7UzsyvkK5hZlKx78yPGMePyoq4qemcbqJb+70l3?=
 =?us-ascii?Q?YdoTypsPBGn8jdZH+a6X6SH5xgLqyhowVbsu2g9uL/IlKmKXYL9Lg2KOpJ4W?=
 =?us-ascii?Q?AdDGAfU/HFUpKN+SnJETPtrDKTyEL3tstYrmneIba4HMM8Kb2CvWIOMd0qOd?=
 =?us-ascii?Q?UypyF7P5Q8oLSzkGMyH48tCfZHEncH9Yhcy7JHT2FSh9iWoUFVkFlsHldy9/?=
 =?us-ascii?Q?Gc/mcZSLqV5aba0Qzr84o2bbTSJp8zMnSKuyoYmWysMDNFOfF73RCgQ4PLX4?=
 =?us-ascii?Q?2tUVQ509M4P2SkvuVpHCYDHnUF47TZoZPaaoYARtCiJk5xxNSVOcoF+mY3/n?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2331dd-0d6c-42e0-b876-08dc270ee39f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 12:26:48.2644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WunrFlIx2i24PfnsZo1QoHZLiYVicXL7rOplXRNGsCIqm1MuNKdyok79lGU+CZz9qvRkE6VjSUAYGQ46LXR+YtnAgXcJ5sQ7/qLhAOeYkRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7596
X-OriginatorOrg: intel.com

On Mon, Jan 29, 2024 at 06:57:28AM -0600, Lenko Donchev wrote:
> We are trying to get rid of all multiplications from allocation
> functions to prevent integer overflows[1]. Here the multiplication is
> obviously safe, but using kcalloc() is more appropriate and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> 
> Signed-off-by: Lenko Donchev <lenko.donchev@gmail.com>
Thanks for your patch.
The same change was already applied to the cryptodev tree about two
weeks ago. See 4da3bc65d218 ("crypto: qat - use kcalloc_node() instead of
kzalloc_node()") [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/commit/?id=4da3bc65d218605557696109e42cfeee666d601f

Regards,

-- 
Giovanni

