Return-Path: <linux-kernel+bounces-104764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E90B87D34C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE5D28400C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04C54DA08;
	Fri, 15 Mar 2024 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7cS1BxB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAEF3BB28;
	Fri, 15 Mar 2024 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526071; cv=fail; b=h1jiCelC9mOZuPTw9oXqYk5YQbmvpok3vHeReLqKGevr5mUV60EjLPx9APnlLANOmMAL/+nTLHwZQd6YyHPC18qtTaR96SVRQU3u83B8qOnwcb4Ami3x8ETD2+Q2lR8IG5gnr82dPF3eNp8C6GJLcEtRhMOgJaR2zySf1r1JPHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526071; c=relaxed/simple;
	bh=xlWrouHBdglBjVQeMVWXsuECb0fYbU++ipfE3dtAoHc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FR4J4suFRHrX1E+uxUJPmMN/DTLMonITs9fDe7qiYUb6w1sp14/A3yhU8D7su01TeApyZbJQUpxma3LDE/FC2YK+xi5IKz3bK80rAQplt0VmcoNoUMvOAjbAuK3OGNyGCpFH7BZL+RKR85P9orldw01Su2OWi62dqT/Z/MDX95A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7cS1BxB; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710526069; x=1742062069;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xlWrouHBdglBjVQeMVWXsuECb0fYbU++ipfE3dtAoHc=;
  b=O7cS1BxBuTOqNzkVfd2qVLEGjh9sMtzPgbNwd6uHDJ+Ye1v3xcCXBFr2
   Vh9j5uH9NmmFpc61s05b0nnabVyR5AGZKT1Kcbd5P9tizYj0os7sFp1XY
   M9NXy897VaURt7mz+z6y/l6HdDHvNCGBE0CFuVbRlKlaPWMcxFOhRVC5R
   7JCahVBmKheyRyvM7y+jbw7wp1qGFvRnPOjApsSya09+iT1koCluZySZ8
   GpX4x3Orn/RAC1Yv/HWnwHP90Xv8d1e8udKdM4tea0Q9taCmNKnaTHKAb
   cZsQAZIWFNqOlJI5ac+pbVY8cE2Wgza82CzVTPURJOxXXGr64Rc0tkPR5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5272141"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="5272141"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 11:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="17350919"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 11:07:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 11:07:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 11:07:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 11:07:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 11:07:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzA7HmUSZta1C5Q7Iz9nRQxCDVnFFM7fRGBVbv8pqAWFhGJd45064tF18olkwWzi5ySpe1JyeJXbrSSRkSVi7d8PFB1MLxGlnbe20i62fbYckJyhg5ql/uhsDcoyKMJCIqk/oBtdTCD8PXytctYFm+VX6Y7+yMYYsXfTliR48+oyw6kAnbK7KKyPuH6nbuGfTi43QcylkJ25FYzK3WO2WFa6TkWCeFNnnD6XR77njJIW8NB4F3ftcgSzb56tDJWGfB4Q8Zkm69MQjVU7qioLY/G54mMCf8XkRY0iuvXIbPqNDvXOF4iYk9atKIXWKoBZw9lRhHArQTnyj5IXArEHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1z46fSESbAAXXRYMgvXBKnQ3qa1wutPTNyICeLsXj0=;
 b=Im8buyQ+FLr1dg63BWjSxaopqVFT+Kwy7qe3JhHYSoDEd29TWKnzVTx48JOtYy9tv0iBvBtG7eFlOGESITlgIZInwUlpL1okOOkIsWpI+c0dfAv2YU9lNflwWO6atAWthIXpAlNIcJYGRoa92rVRtlx2aEEt4n/lbISb20gtoNbJCIRuz7phXDMVySPLkCvkS9OsKPcioBOoDKvuV5uuGqHEUpVa3Fd7DZ2o9D9eeJichBPlXeR21DGyMOVxm7eeF/QIhVYTdhJCo/nMSC4LiEUUjAzPOIDq+KYXKQxmY9Yzuer/R3uA9IumpJr7+m30c2nwA/JG8MDA/x6bVmMOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Fri, 15 Mar
 2024 18:07:44 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630%4]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 18:07:44 +0000
Date: Fri, 15 Mar 2024 19:07:32 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jijie Shao <shaojijie@huawei.com>
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 3/3] net: hns3: mark unexcuted loopback test result
 as UNEXECUTED
Message-ID: <ZfSOZG5vHbIY3IFU@localhost.localdomain>
References: <20240315100748.2913882-1-shaojijie@huawei.com>
 <20240315100748.2913882-4-shaojijie@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240315100748.2913882-4-shaojijie@huawei.com>
X-ClientProxiedBy: DUZPR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::14) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|SA1PR11MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 758c79a1-7fb4-479c-4f10-08dc451acfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQX292oC7fYzrOYu+RhRbhw1q3HTdUGisZGLxOLlF/g/TN/w8bHx2AG0sCuOK5EaMXleA9hOsB8VLpc2KAGn6uU8GMvuJqVwPKsbTwybGx0B2B/jnUwvT0gZnRFjSjkno0dUN3Ly9pA2FnfzosodgLqNNzpog8ugYdGwpDvjpj565LjOJWbvLm9HmKLychIFIcOmU2bMh8U+eJNiRUijMXTJgWESMiGrYIqtsdlwDq6nmWfr/pObc6O/Uc9+jZxk1nF6uPR4Vv1ScVVmaG0Cn8dQIMsQ/NtccW8pT3fAkIM6Fsd9fln4qg7kHPb04xdvncTRuvO8CpMhsm/7/2LS2JOXCKMH15wwarB7j+RNCCABolTDIE3Uy+elpKClKdXnF7TgtcBCNzXKVXWQ0I1rwGz2su5hBflbZmK2AZ+FZvGT6OpDwy8Jh4UMTh3hNpDvVCFKQB0rVYEv8YOjttjbZV9IwXUa5HcK1wfe+VDnMIcec6aaI7JyUM3CZSBxunYDgJPrKD3PlTZTQ8hozAcdELBXsZLmeWBEDGpmwJrtiN2JZJ6XY0EQ0VndkbPnEzjHaHL4VDSOKfZ65jkebSpoJ17BQxAyzAgepCfBYtJC5Mk1vStSHtZGlE3gs0l2xNR0UIxm8zePcp3HrNl+bfgK2orr67TCnFenXEh9NJqgLoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SLeNEzz7XB/GG72HFDP55ZUfbDVOTQGrOTDWo5OtQ0dFyIkXe2A462pdQOnm?=
 =?us-ascii?Q?9YasPOFG3as+LNMNw5naFsuAh6BVHs/ouLCOzolYixXabKoedIn9jh736kRM?=
 =?us-ascii?Q?GSFe+i/jjGYw/wy7Hnc0t1OC6se/8au+2mOKn16HEjkMKeEnG+qOSt1JwrGo?=
 =?us-ascii?Q?/8zaaMqPjEC/hhXQg5dBWzkr3og4mmJI0k0jrTW95EzF2F+k7dWs7FVFpN3M?=
 =?us-ascii?Q?JtsFmTwlElqDErPWbD78gA74+rmAo0UqJQMyhnS2AFNS/3PUiCu7nqcTDTB+?=
 =?us-ascii?Q?5yhjuF8Lof77lTvCh/heJSnunHYY2Rqeeh5A7o2/ipyQNS5AZWDx+q3X+tvl?=
 =?us-ascii?Q?ArsRdCOSjgTdLbI5yFHCOsoDyGIFjYkARqCuUh+fbg7Z7eoSWVRosp5k0Lm9?=
 =?us-ascii?Q?35FwGuN7E7Wa47eMbTN7d5cSZ3He1UQhK+1CtwSKAfTEvV158u+xxlBM1JZO?=
 =?us-ascii?Q?eHo3wv8Rk1FjArLLewASSvh0Wtzzk3djbnOesg576QVJ42TSRvs8u616C6Gj?=
 =?us-ascii?Q?yUgPxt8DWGvOZmQPuuppyFB4Sgljks9VoetYDom6zzLVLByaLXmwMf1qsFTw?=
 =?us-ascii?Q?Fb849Av+BS2v4V9OU/mf3g+y/2VHh6cdm63wcp0coziCOfWl7HzyJwZIs17C?=
 =?us-ascii?Q?rlEocVXtLNGWVE5iNJCNQ3gFYCMfoziBajoXjddd3TCYwjQwLZrkWrRe4OzM?=
 =?us-ascii?Q?+aM9i69JiyAK/EJUV+RBmbx/ZFGZs/4iB/XQad/GsYp4SKuJ3bQNyvuPITXV?=
 =?us-ascii?Q?H2uKyeyfHT+SU+4m2loyvq2aw6GrU4bQQ4LMYOGL4btLFZs8SUYlOC6i5GFa?=
 =?us-ascii?Q?+WB1HWrgFtmTMuonipaA8kIH/Z79PLfYM9qJAzxJ+1R7peZJUVIiCzsDZiA8?=
 =?us-ascii?Q?sYjE0rkG5IGl19yubiZJAXu3jxe0W/M0P7We2uI6AmvTlUa+gX3ID7Tr+rbD?=
 =?us-ascii?Q?8qG7fTTVs3gvqYshELla6crvRoQoEM//T3V4Oqpds2D4OzpwC+Q9k4YZ6ox7?=
 =?us-ascii?Q?gOdUivSx5M3yoPQf+knxNRiAIKrw+aEzR4L2uhC2FPezTywoNoYpOkknX2oK?=
 =?us-ascii?Q?Ezz1JfzwZbjST+irug6Px8fyF/Hd/RDF32PAsA7bYm/BSYzekyE/XE2s9eSH?=
 =?us-ascii?Q?fI/O9fj85ekejf85O1mM0oV0TEZcAjQSpyQ1I1aIBaiR9Sc6CzH1ygNozbQQ?=
 =?us-ascii?Q?gzhADfAnvbwUMuGH/1I18zp6SPGU+7SqKDih0us09JUxwNkt+aknsSnVZkmS?=
 =?us-ascii?Q?U1CuDf6aG1+i3bWQkhCkYnVxCHjzIIGAVd65t0QmPw4L8THIVojeVSYyYxBV?=
 =?us-ascii?Q?pU/RXNRAcOoN0iNAc5C8agziSyRAtiKZSwn1SJACo+SnIHdqiF4sji2cNUA8?=
 =?us-ascii?Q?Bo6NB/YAZczgJD2OYCMgkLy2Q+cstNbWMhpbHwPSe32s4wOb2BUsmlymnUOf?=
 =?us-ascii?Q?18vRWIr2N8Dd23vvSqM5VJ7+5PIpZCgSAJN61QknsYKP5RG5psezor0pHi02?=
 =?us-ascii?Q?E/YQjF4x2kyoLoo7lGdGNE1kt9ZZ4PkPFgze2n2wm3NnXl03ut3u0PmkIDaS?=
 =?us-ascii?Q?U658ibvO/SHH4XSPRbnK4guYAsiJHc+p4i7qUz1qOF0FEft+SIAgehjJyzEV?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 758c79a1-7fb4-479c-4f10-08dc451acfe6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 18:07:44.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4dp5CXG6H+aqX4k6RjT0CfEUJXwPtBlYL8D7j8rW3TGLEjJC7r1xJcFOE7ARhrkZyLUqmR+FMi0Ep6oTP+0Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
X-OriginatorOrg: intel.com

On Fri, Mar 15, 2024 at 06:07:48PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Currently, loopback test maybe skipped when resetting, but the test
typo: maybe skipped -> may be skipped

> result will still show as 'PASS', because the driver doesn't set
> ETH_TEST_FL_FAILED flag. Fixes it by set the flag and initialize the
> value to be UNEXECUTED.

Fix it by setting the flag and initializating the value to UNEXECUTED.


> 
> Fixes: 4c8dab1c709c ("net: hns3: reconstruct function hns3_self_test")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../net/ethernet/hisilicon/hns3/hns3_ethtool.c   | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index 999a0ee162a6..6804ac5725d4 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -78,6 +78,9 @@ static const struct hns3_stats hns3_rxq_stats[] = {
>  #define HNS3_NIC_LB_TEST_NO_MEM_ERR	1
>  #define HNS3_NIC_LB_TEST_TX_CNT_ERR	2
>  #define HNS3_NIC_LB_TEST_RX_CNT_ERR	3
> +#define HNS3_NIC_LB_TEST_UNEXECUTED	4
> +
> +static int hns3_get_sset_count(struct net_device *netdev, int stringset);
>  
>  static int hns3_lp_setup(struct net_device *ndev, enum hnae3_loop loop, bool en)
>  {
> @@ -418,18 +421,29 @@ static void hns3_do_external_lb(struct net_device *ndev,
>  static void hns3_self_test(struct net_device *ndev,
>  			   struct ethtool_test *eth_test, u64 *data)
>  {
> +	int cnt = hns3_get_sset_count(ndev, ETH_SS_TEST);
>  	struct hns3_nic_priv *priv = netdev_priv(ndev);
>  	struct hnae3_handle *h = priv->ae_handle;
>  	int st_param[HNAE3_LOOP_NONE][2];
>  	bool if_running = netif_running(ndev);
> +	int i;
> +
> +	/* initialize the loopback test result, avoiding mark unexcuted loopbacki

syntax: avoid marking an unexecuted...

> +	 * test as PASS.
> +	 */
> +	for (i = 0; i < cnt; i++)
> +		data[i] = HNS3_NIC_LB_TEST_UNEXECUTED;
>  
>  	if (hns3_nic_resetting(ndev)) {
>  		netdev_err(ndev, "dev resetting!");
> +		eth_test->flags |= ETH_TEST_FL_FAILED;
>  		return;
>  	}
>  
> -	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE))
> +	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE)) {
> +		eth_test->flags |= ETH_TEST_FL_FAILED;
>  		return;
> +	}

Can setting that flag be optimized? For example:


  	if (hns3_nic_resetting(ndev)) {
  		netdev_err(ndev, "dev resetting!");
		goto failure;
  	}

 	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE))
		goto failure;

[...]

	if (netif_msg_ifdown(h))
		netdev_info(ndev, "self test end\n");
failure:
 	eth_test->flags |= ETH_TEST_FL_FAILED;
}

>  
>  	if (netif_msg_ifdown(h))
>  		netdev_info(ndev, "self test start\n");
> -- 
> 2.30.0
> 
> 

Thanks,
Michal

