Return-Path: <linux-kernel+bounces-106201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D053F87EAA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFAB28466D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1604B4C62E;
	Mon, 18 Mar 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MW89WZ7n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE604AEF5;
	Mon, 18 Mar 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771395; cv=fail; b=i7isxMeQIR1IO7OGuTJzxBSz3OqTvoVctq4USwU/MqZAEzvrI9jVm60rdYInqsMPeaZhnIz5AViUJV/J2I5LT8mPzLI9CL83/vB7TNAqMlWtkMdcs5NbFF6wiuFQY7qcZKVnCY7hKgNF0Tr495+VpY1+UxAW4F4RhMi7FHPNMyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771395; c=relaxed/simple;
	bh=QnO/hyN7eCdwb/GXCwqezkRy7P8pfy54oQYTNfn2obE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BcQPjuGdeqgAcQIzYk3RBPd6wHpIfH5365Wt4IY8d3AuNIrRfjL+rfBYAfBTyrLbeHXDgpfzxdGZGKyA1NLfhf6+8B//pHi0BjIDg2ETEpthy8Ij+KEGeYLSUa5tNcBQ+wHwy2zHvMnrWI9NWDv86hs32mSWvgK+Eixgm0RlVPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MW89WZ7n; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710771393; x=1742307393;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QnO/hyN7eCdwb/GXCwqezkRy7P8pfy54oQYTNfn2obE=;
  b=MW89WZ7ncT3ZGuIRcg7bssqwp54cCamfEbQ1Ytp3HlVkW7zaRd6aXYZz
   M5hUpsOOUWAjSOtRsxZD9yPflve64VNlCnmXRmrfiLBNPSE9DrZEdRSUJ
   5U6OvV8yoQfOW56pWqRapGf4UYLmsdMSCcpp25zxsKLHX3VaJbCskQH/R
   NzVuVvrAW+ufX9HDHlUpIWf5lc2J98zUyDnyanRSPylA/3FJKR+kxZk6J
   JWgnKJO1EhboNo+fIxYiszWRfV70sjfidX713PL7DF/JuDkl7DG5kmvNl
   YE1Cvud5cBnjD7j/C6N0q22N9ITLVe8+Gw0G+hLyt+faLcaU1kWbu1wtb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5715883"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5715883"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 07:16:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13870978"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 07:16:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 07:16:30 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 07:16:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 07:16:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 07:16:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltTPHCsPAnQ6xIC1porCAr97zEr/V+HdxK7T7+Fyw4NtITWstCdlusbpFKEuz9TNB8U70c+YcnLjP6X2l/rIvxnvweDIqLEA2yftv8/KggJLDE9AJlIMYFztEkCrV7MFVEiinJYArbcNEXi2RqqXxRHJKCz80zVTJQd9QxLB8vhDBoDsf0ZlPaOZvv0ZYtxL+Q8HuI/BE3boTLQc9ERPc1lp3BOgeh7BdQJ/gedKMSVNR5Nmhs2OjwxYpqBBBu4xykJ3SK8fXf3h3eD/v7qI7bsxlfiSXn/ai9qtjGvl64sqWrH15L8TMwDv8kgVKbpOX288NLvahnWT9CLNVcRMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+fwb/4kzERYMlGWAyV0loIwrLBRA/FhpG9z/0RRe/A=;
 b=gCc6W1mgmMx3ciKc/55s0bslJ9p37kiwNhkestuT/QznZhQjRPE3zTh1uie62LGkvP6ewywWwY65+WJAv9kgiQG4shrGdK9YWFEqcfVaG3jU3uYJBaWKA2nAUfVVd6XBVg57XO5+lO/3pHvP9rVGnKgPCcb9Xy7Bj7JlOMZzo6x8PsAuq5phk6U0uyu6eKl7x5ihxPET9KeIsVtwTV05KoCbL2cGB+2VJIcUa4tzfcOdHi5fFmPCj/okkn7DpBORNpghrHXOscc5o222/dOO95Rm0hyYhDE3M9HavGCG6OEPeAi8uunAi/WgcT8g37Lqka2luey5o71gCHQlLMNgHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Mon, 18 Mar
 2024 14:16:28 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630%4]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 14:16:28 +0000
Date: Mon, 18 Mar 2024 15:16:15 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jijie Shao <shaojijie@huawei.com>
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <rkannoth@marvell.com>, <shenjian15@huawei.com>,
	<wangjie125@huawei.com>, <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net 3/3] net: hns3: mark unexcuted loopback test
 result as UNEXECUTED
Message-ID: <ZfhMr6t0pQG+Dp63@localhost.localdomain>
References: <20240318132948.3624333-1-shaojijie@huawei.com>
 <20240318132948.3624333-4-shaojijie@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240318132948.3624333-4-shaojijie@huawei.com>
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|DS0PR11MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: a9895ab3-59c9-4016-eeff-08dc47560087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iu22neqfuCa2vHFDZC7tuX6jRVCdu8736g85+9C/WislxYTMdBW+Qd1lOtGeDSEySPYo6wz7yVr2jWMLR9vgYKFX89O/TprPz8+iGXeJBcXENUWhNp2v6wYMPC9Sx9ViXJ1NelbVnOFES5tJA0DKr9EzId+UFrXy/ysWBTUb21hZcgztfQrcSRqLwiIXXH/TEdHDfwoqeQiX5YPVzXaF9TyilQ5It5bbLjcRj7L9HLUZyjrl3IgeUXBYvoqoIi5F6Ln7CeCC2DdOWnWH/aUmFqgJtwsIPFyGq9TesIV3/QCEBYg1QxUsOrYqdQIcbKL45KC5wV9jJSHJorA7tBiaDFfJBb2857OJ2y2daQ9i1844N5N7pZrVPdkqenqWtrrcOp1FVdIIkBFt9yQ9v+4awVZ+Uzzx+TSY0WZ8TE3xmm1PlJWbWLlgLdU5anOdkMG2ARuP5GPAuvdzueKXhLxY/WW0AlCwmM9WAgLHfuuKqFLk2a2P96ntQ+KqOtC0jbz1nGPzdBe5gU89iruvaM/bRNa2uJXvpjXEb3GgohJOQmRnrR/hqFthhsGMZ721I6JR4Up1+zvekr2ybIzy8H4L7b0ebPLYTF9AgE7CSH5Vb6QGZwrI+gW/WcMBRKqsaoteAp5N6lc1Tuiv+6bMnrO+/xqaXrrfU9J/cO1VgzeP6FE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/XH/3sfHzoGm+ITWECqBHA9O82rcG/k/VuUc+rYeUohxdEJwOmV2LlGsgkoN?=
 =?us-ascii?Q?GL/Vh+yI2iqawTJMZS+On2IFaeTiFl3ym0BWwZd3ziscqJNYZUbEPkoYeEYp?=
 =?us-ascii?Q?4oKnSVs7LEduiUQGfI+oHFLvi6HEYrly0NyFdopuS+IJAdk9w8OCLXwOGU2c?=
 =?us-ascii?Q?vWu5VHLfTQgIicH2u4c6J+xJm4Pfk36JaV2MDmdVw9LPuPUqUOJl5X0xya1g?=
 =?us-ascii?Q?Cm17h/1SE8iSbikis2M4yDxkhFl/fDz0DGTW52B8R6n1hb8I1aOgb/xqO/Zp?=
 =?us-ascii?Q?dBBl/NmHq0ky2/CbLYAnvqTcUxgZQCLVdX2AZRvwFri/Wm38Ne0uwCxYfBla?=
 =?us-ascii?Q?pWa9tttgBs9cE06/JQd0DX63xx/sjbmI83BFvm5OZ7DFLKYCCtQIP8bJitA7?=
 =?us-ascii?Q?xVBFjp9FD2Zgd+paa50ZR8gFHkOLTHeaEYKMyU+jYpeauMQq8O6ZBpWShQe3?=
 =?us-ascii?Q?cLFZdaRqLoEoLXGFbRpgXbir1rvAXmmPstUyXSbIYCjGDmRAGL76pBRyxhwy?=
 =?us-ascii?Q?L4jDtBchXSAIdu2GS9eQ9FH5svZQ51g+EcfZltMJpHqMP2DVn/teKa0+wZig?=
 =?us-ascii?Q?eY+sPRZtJoVgU8S2umZ5o37sniiLqonsLo841JjQLlKavpOW6v2i2XYyGmUL?=
 =?us-ascii?Q?JqEKRvl8bFviOO3XGSY60uBcWIYLdP/V3eMM+o1v49DSn8Ia1Num0jR79nKX?=
 =?us-ascii?Q?/TIQMb8UuKU6DvAvsE29EEqAt8BIoGhuLSBVPVbLroLkcxawNK2LTLQenw/l?=
 =?us-ascii?Q?Kr7rvqKHfx83RV0BhvdliEILP5PmQV7FhvycgCtzQrld3ru18Vi2CFJrnr98?=
 =?us-ascii?Q?2WMzn52zXdm5f1JbDNONJMOchl13pqbJXjlm8qLs9Xa6PjvENgEGntX2Vi4n?=
 =?us-ascii?Q?OXW/vrE+rfsLOuRfXZ2LyPUM2trfk+Kn/DjA+j0MEH055La84TtDa5Sz7PmA?=
 =?us-ascii?Q?7Iubp4mhOpkZau5cFhezzQWOSOnahNGnxW7fwXrOtkph6SRifcYaP/e9p1u9?=
 =?us-ascii?Q?sIAqrpFy89l858FLFqTwzRrQxInvzwMisa0JIt+PLoKauW6+NKRX30NtpkTH?=
 =?us-ascii?Q?tsBuL06wxagMEukmd7yla1/ko94XB0EBvQ/FjrFvf8ZIbMMbAgUvXRec9i8w?=
 =?us-ascii?Q?ol8XB0ldkyBIxnjFjhMs7oti7U795EXemXo6Z4xlfXo/kDRpfdnTqjNsYl/l?=
 =?us-ascii?Q?AFn3DecFgxRgHHb1UvJvCEoXuGmRZ3LFMk2cmv0iZNsJxNl5uQW2DoYKGgYT?=
 =?us-ascii?Q?d/V6fpSaX69dsOYBSIUPebpHDhVN1dHdLE9sK+S6OZGVeKG4NWoPbFJ7CvAg?=
 =?us-ascii?Q?H3bbo+3dwP4hc8WglJUx0kTm30IXKG6eHbBg4hynEbIK0L4RfbDJjrBYKnAs?=
 =?us-ascii?Q?L9yrOo4A9Irn6VkdwNwaD3ng7bXhQiJom7Uzj20VBPvCcNUp1s4rqOiT5spv?=
 =?us-ascii?Q?aeR1H23xIggkZKzujm9NN9k6d7GpRLilWf/saxzCgurFHJJetPaclr61nvur?=
 =?us-ascii?Q?TXKImJ7O22A1pUiPKjKov85j4a5q5p89kz+JE3KRUaNCBS4zU4Wb9SlX7K5J?=
 =?us-ascii?Q?Uh7+uVluD7pzX6tm9LuGOfh76uIRZr0NIVt2R/GQu9MLKwsXPLTJm0VXUujZ?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9895ab3-59c9-4016-eeff-08dc47560087
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 14:16:28.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qteVdxyXepuFPVTY7tVGpAflToyTmDw0yxcpGNoGxZvdmXVCrvEtb4ksfjyrzBwYBE2AYW1fiL7DgcizoskTZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7768
X-OriginatorOrg: intel.com

On Mon, Mar 18, 2024 at 09:29:48PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Currently, loopback test may be skipped when resetting, but the test
> result will still show as 'PASS', because the driver doesn't set
> ETH_TEST_FL_FAILED flag. Fix it by setting the flag and
> initializating the value to UNEXECUTED.
> 
> Fixes: 4c8dab1c709c ("net: hns3: reconstruct function hns3_self_test")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index 999a0ee162a6..941cb529d671 100644
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
> @@ -418,18 +421,26 @@ static void hns3_do_external_lb(struct net_device *ndev,
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
> +	/* initialize the loopback test result, avoid marking an unexcuted
> +	 * loopback test as PASS.
> +	 */
> +	for (i = 0; i < cnt; i++)
> +		data[i] = HNS3_NIC_LB_TEST_UNEXECUTED;
>  
>  	if (hns3_nic_resetting(ndev)) {
>  		netdev_err(ndev, "dev resetting!");
> -		return;
> +		goto failure;
>  	}
>  
>  	if (!(eth_test->flags & ETH_TEST_FL_OFFLINE))
> -		return;
> +		goto failure;
>  
>  	if (netif_msg_ifdown(h))
>  		netdev_info(ndev, "self test start\n");
> @@ -451,6 +462,10 @@ static void hns3_self_test(struct net_device *ndev,
>  
>  	if (netif_msg_ifdown(h))
>  		netdev_info(ndev, "self test end\n");
> +	return;
> +
> +failure:
> +	eth_test->flags |= ETH_TEST_FL_FAILED;
>  }
>  
>  static void hns3_update_limit_promisc_mode(struct net_device *netdev,
> -- 
> 2.30.0
> 


Thanks!
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

