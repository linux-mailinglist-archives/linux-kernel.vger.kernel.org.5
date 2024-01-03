Return-Path: <linux-kernel+bounces-15416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B53C8822BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390291F24195
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BEB18E2E;
	Wed,  3 Jan 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5AGmIMt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47118E17;
	Wed,  3 Jan 2024 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704279317; x=1735815317;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ACLdN3p1NZATbRC4zDgSOSzdzulnzHgKbLBF6aR3kbs=;
  b=l5AGmIMt5K+rWpQQXlMvBPlj7qHiDiBUXu37rukGn1KeLJ9PE4NejP1F
   NkRdjg6J8Q69LlEGm6De6LC2GDuNzmIZsb4UPSdifWKH+DQAt1Nfo4bFw
   aF1FBwZg2vqKX9LtZDcWC2TnJUlRXpabQvJnNMqKdNGMwOsd1KJuC3HSs
   UdG1tj1YdYjVANZJNdX73dbTzuXRhTK8nxgVOxgt8ZKxcmCsljQEmEVqV
   XPtOtfH0B2ULv23tAC4bfdWKaqiYqp52HUAtcS/BunIcPffSgOPJnpQ1X
   oKyiyO1cpLKQDe9PLKrN9dMPMVYySr0aDLTWa4+231A6bP82NPyXJphQW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="399766813"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="399766813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 02:54:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="845849327"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="845849327"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 02:54:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 02:54:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 02:54:50 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 02:54:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OykeJCRsQpMQxIa+Dayfr8JvIrWzunqQc2THXju20XC6zMQLKYSFUVk3TUzHYXE2Ci5MgxEs+nTNG5IkyrBCvP2etcAiR5iRDv57jVHuTOYq5gXpVIhYz9YS8QkofgpFwWuUTPMCr115/m/n+hcFnPm1maLr39qMDVA6jUnCLEpz4DWfWf7ERD1MgswGLcs7LRvSgbXI3YzthWL2jaMSaWM8g+0BxQR4X4eEnRriEfrF7Clv8F1z687PqzhWcxx/47Zw/uwv5zNlQVe2gBk5Q+LVN2pEN8+ER88ao/cshn5DKqLZ53UJx3hfY8stchr3GxNom48N0h7Id4GBBoa4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3cmePzuS4qE+4DIvOepYLkhYEjFzfB3+YklvBYeKeQ=;
 b=KEW/jG0GWyD5ZZUrpgmMoMzNiZFcnrJOiIFmoqBrPRp0AwE8ovyY678wWR+Qyyml0QklQVlmiqSVs9JtdFDlAkcifmmarEKRRFdQMbZGpOr2wEvUMTrogey0j1UQOZWjNnLqlAHd2mmUfUAxSBIsEjxyZWbZVsyioNSRHgyXSyLPFH1M9CgqE5FRJwyH21emQarSCiU41slyONC1ezmxYQDTiBAZuPUyIF5DPVj6pPFGMzmZpGMt8oz4L6cBmk/sETdPdgkWJKuI+u/7as36mOEg9iXY4sh6nu6MBrOlxs1mCNPaeezMFnHmucw0oC8B5GddbwNcFNvibXIMOQg9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 10:54:43 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 10:54:43 +0000
Date: Wed, 3 Jan 2024 11:54:37 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Larysa Zaremba
	<larysa.zaremba@intel.com>, Piotr Raczynski <piotr.raczynski@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ice: fix building withouto XDP
Message-ID: <ZZU87SZcE/6i8lyo@boxer>
References: <20240103102458.3687963-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240103102458.3687963-1-arnd@kernel.org>
X-ClientProxiedBy: FR4P281CA0445.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db51223-efd7-47d0-24d8-08dc0c4a6471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76vMmxhCc16MsJcs1v0DBeeX1o4hfvdFTs974cr+R+iDf1oxgCjpdlkd4+UvB/MoqLSi+rqDZFKZSBQldR6OiGhhGnKqATWsfeJyP0OhuE4Pyr/MIYoY6pDocQ/kGboQmqWhFCq3Z3Ofui/hWURNhkIZlRo5ZjwfDf+6Uo+f9ykHt+rFfohDpyMq1Ah2+0VVq4ALSFZk+otiXyPTLVynSC5OSz0Ao6G9xvMpBizkKSAseooRSuq+abxgW2ccRig4oEvGcpD3zZHopVPfw9hx9lgQae5yATI2EptwmFiZ5zP851/0vfYTn/ZLuAxeGnAmS/KWdBSWxaOfjLSZ8l3KBx4wg1lpQGWiZPXqFTwnCW9OgSqrnRvTSTYePT+s0e/MGR2ff0BhdAnAEeA0QADSRS4j3b3ffZLyRbRlWxLF1wkV4S7c67X1d4QaaxLwmi+cUYZysgUwGK7jeJHbJW5YXi9RPPTR8JTRuHJYvIv2OS0HU9ktA4+32OUcAzAcIubK9yZ1BDs7yJZDnxJYkWPvKYlPOQlcVY2luX9cMhfTnH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(82960400001)(38100700002)(66946007)(66556008)(316002)(6916009)(66476007)(54906003)(478600001)(966005)(86362001)(5660300002)(6486002)(2906002)(4326008)(7416002)(44832011)(8676002)(8936002)(33716001)(9686003)(6512007)(6506007)(6666004)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W1Wx3XkEdJ3koVR3cY3vU5PtR5qPAV5y4BBNER2WRy2FQpm1gQwavi2x9mcY?=
 =?us-ascii?Q?Ptk+1ncIPrtPa0WyidMmlNwRhyawaWYjbf+FktGpe5oP7RPeDu4j7Bp2HBtG?=
 =?us-ascii?Q?1eo1TGSYXt4iIeuwM26+ndwB7VSazC6u6zj1DegzqdRfLp6TCbf98UIa1lB5?=
 =?us-ascii?Q?yUElF+BS6HEf2Lb7WNPEWRrnRMJADS5e2jSqEXKvuxJQQzSKJwNB1phDU9GI?=
 =?us-ascii?Q?NeaOc4zoiW/Iea+FjwpzI/2CNjLzELia7TOA614HObZ4AQjnONjK3AQMCkts?=
 =?us-ascii?Q?TRFTLJ4rBBlpF+f5pCupXPOmaZJwv6vOGhs1Q8FtoL1AXAVMxYdRrvmTtAzT?=
 =?us-ascii?Q?J+98dHaLjQ1uziqNgGyIM1Rg1cil1NAAVCWwGeMK7zHxzoE3Ao8022WRBCM/?=
 =?us-ascii?Q?/4VPOtJqjM45MJgn8a1eNsTfhsDCb+1oVwOzzdP97vfeFypZgD82oYTtR+G0?=
 =?us-ascii?Q?kvjGRDyDj7ZYRJlG7r6henUTj/Q4YaMCQqWPJraWb9NruwnGmL+3Ge7Lck98?=
 =?us-ascii?Q?L2XwEMfbVa+DMsIitnZ8JZzU0lDSxWRN4aDEQAJ2YeRLvkNcBx+zQ8yRJwXY?=
 =?us-ascii?Q?T6Qqw7HTpF+Ox6i+GnBhiAX1Jk/y6rSdY3C1fCDLIjDkGT1rCFIDOAXAW+5Y?=
 =?us-ascii?Q?HEBYEpACtok/SUP4v2IevpzvcvQR5llH2ua+wCkfjtBhLA5wgUWmDYkCCNIr?=
 =?us-ascii?Q?3on47P9LD1PbVsLzsQZ4gMvmqlwtECsG2cSQYx6/6g5lf/9wnIJ0bLIRYWMW?=
 =?us-ascii?Q?joD/q1rlmE7AFF1nhenlmd97fv98qIGWulMrT7H1bT5Ekd6oURL38qKNB+mw?=
 =?us-ascii?Q?9LBx487Y3AQ3MsTLSIt23vwTffyeuJU0pviKkVieJ8bBh+caSBToKCabl4Li?=
 =?us-ascii?Q?2Qhhs6VDsaImp3UTk4IunxyzFTtFOyMoF6WI2u2MMuiRmunu/esrvqSQiDLz?=
 =?us-ascii?Q?yo3C7qMVDZh6mT0rjCgH35THtGuMwLjiqtXKt5+1Uy9+mo/64H4SXz2xdfnF?=
 =?us-ascii?Q?V3u4w5Jlh807HnWizrU1oZNt2V8P3Tr7nvUF4U2oN5jZb2uptRzOveoXoPmK?=
 =?us-ascii?Q?rnI+ksMALw9r5j7Y+LuC1cNDysUu4J067gJgGlyJbIVFgKK5N3+ybBLiboJL?=
 =?us-ascii?Q?/hJDcM9k1hy8iToo82fziEz0qYml5pWDIyOggSthxSMEqVCaVeDD8P7zkRqU?=
 =?us-ascii?Q?Y1l/NWXmSVpdtD19eXPgKn3jwd80jmiINgbwIMa4qmWwf1TMgVa6MTPGkDHw?=
 =?us-ascii?Q?cVaPKE1RmGQ/OajNEHDBN3/i4MYkwO50EdJtoEw/poB5X/q9+1sLahIhSFW7?=
 =?us-ascii?Q?5Blfq9GhfA2iihuhxjVTDMTZ/rUz/4xlBYc4H7xSqRixW1u8pUap0BqD6m0y?=
 =?us-ascii?Q?oZ5vPa/2bAKYjE/s0ubUkpn/trpdMbVIwnMdKvNQzetd60k4wWu/hQhV4o4U?=
 =?us-ascii?Q?06oZkFGGXCVx3YsEzNIG3KkFItheoSZb8RsE08DkUZZXEgFjB1VVhptoZn2I?=
 =?us-ascii?Q?qWhcp5kYNH/GnLdEDs8Zfe11kUGmeXO6R0hLrZGCsla9QgAsR4jhH5kVr+N+?=
 =?us-ascii?Q?hoc+aLldA2Gb4Us3rrtBg8bmfKWETP1KIfuOiwsYoj1CwYEPZ8sG9IA6tIyl?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db51223-efd7-47d0-24d8-08dc0c4a6471
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 10:54:43.3206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbZ0m3iEV8SDdY+qI4AhtCir65N21ZetxAXAq87JkjsrU+W/0IJopeNXuOd33aP1AhK+3Yzwy1zWMFAP42QdmIq35If5mesmMVOyu5YX1q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
X-OriginatorOrg: intel.com

On Wed, Jan 03, 2024 at 11:24:45AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added function fails to build when struct xsk_cb_desc is
> not defined:
> 
> drivers/net/ethernet/intel/ice/ice_base.c: In function 'ice_xsk_pool_fill_cb':
> drivers/net/ethernet/intel/ice/ice_base.c:525:16: error: variable 'desc' has initializer but incomplete type
> 
> Hide this part in the same #ifdef that controls the structure definition.

Hey Arnd,

this has been fixed by Vladimir:
https://lore.kernel.org/netdev/20231219110205.1289506-1-vladimir.oltean@nxp.com/

in a way that we don't have to wrap driver code with ifdefs.

Thanks!

> 
> Fixes: d68d707dcbbf ("ice: Support XDP hints in AF_XDP ZC mode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
> index 6e3694145f59..0d1aeb7ca108 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c
> @@ -521,6 +521,7 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
>  
>  static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
>  {
> +#ifdef CONFIG_XDP_SOCKETS
>  	void *ctx_ptr = &ring->pkt_ctx;
>  	struct xsk_cb_desc desc = {};
>  
> @@ -530,6 +531,7 @@ static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
>  		   sizeof(struct xdp_buff);
>  	desc.bytes = sizeof(ctx_ptr);
>  	xsk_pool_fill_cb(ring->xsk_pool, &desc);
> +#endif
>  }
>  
>  /**
> -- 
> 2.39.2
> 

