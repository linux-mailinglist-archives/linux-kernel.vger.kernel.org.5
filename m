Return-Path: <linux-kernel+bounces-106221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09A287EAED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F050E1C20EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759C4E1CF;
	Mon, 18 Mar 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idyaFRuf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8416D4E1B5;
	Mon, 18 Mar 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772033; cv=fail; b=QYLGJiIMRxJdT4T8C+sfmGYXOqIcBwlpCBc3XNEW6HuU4zH2wr0tMvB3HBo+6D06V1PDWFziWTCHLDUkMoq7P3dtwX4UeSUYBKA5mmZ4t4m8N2qLQ5eNDb842O/nIj5dlBe6MsVP1zDRUcxV/FSD/jx4t1icly+gcX6blk/YH1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772033; c=relaxed/simple;
	bh=Xpa5upDwARzKIskLCcrGwYsvaUE5BcbdVGary5ZjNuk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RYQsO9KvogeROXlYrnR2IDxf7bDPCSi3LypV7zSVz5pcX75RN7oAsbLYQkY5BdTViy2+2sk66skYZvgw4k2ZCLtoelH5YN5JliGZHPPcG+9qzStK0DEF3sMjksOYO7Fy9RoJX0LMKHxpQ+znxskAN5yhN3/KMYSf/KvajQeSvCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idyaFRuf; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710772031; x=1742308031;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Xpa5upDwARzKIskLCcrGwYsvaUE5BcbdVGary5ZjNuk=;
  b=idyaFRufO9Vu3K5JkMoGyU3pvIfM0yiYHfUDFwcPeWvhnNmTMhJ4Mszk
   DtLLGekEQGw1eFncclHny7aZkm9KXpRebgJx+tE2MymicSSTovpD8QtCI
   WYHB/Mq81OAIphPYAVVa7vIZxG9aK7P2VvH9cgLkXEWEPn8SUv5AywdYH
   /DXHLVmI0uyPN1tHQhz96vc4dIMyJWzqfRi5CMzx6wkal5zSTPdXx/vlU
   +MzzHmcekB9fuKm+QGBQL5mLbqgu+pFisx9tRks++LNLgspl1BbOJgDOV
   7Tn5hpIgog7rvyJhw3c2VoGkkNtIFJGH+b9efDeqbRP6BUcArp9Y8DPn+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5420683"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5420683"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 07:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13435363"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2024 07:27:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 07:27:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 07:27:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 07:27:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 07:27:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCiSXEgPLWP73t2M+JOKOGtJAcNGADQzPmiCC1Ll58mmE4P7GYajjahIkKvxzLmDVqY3Hhee3ZSkUfL7KHrP5go3xuvM9J6QHwJ1Fb/Z5Qc/0NwMMoV6gn8xJ6Qjcgimrap0i04Sa9fgwZ6BEaL9xfNRhEggEPhHCFVkJU+ZNDU2kIlvID1Rdu4tSuXsF66THgP1jdwn+0lZ0YgPau+eTg1Og71yuuroWt5eJkGfr06slaSA16pKb4UBlfHKtVy4oiwqM9MklGTcWY9LlzGMjBGOhGj1omT/XQ9agmyeW0hzNeP9EuS5h5Io9DCp4iqs5bmqTNhmCzhhAH+dyviVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLyxj7UtevsTeD5sXrzQT2YYz7us3j+M36lvPyb806k=;
 b=Gwh7rom2tzdXEk1pVtpHWnXlZ3tQmVqBv83aDUnPR3cMSuaVnn2X6D6H3XzbFIMeAiYsbmEmcI6qxDvEjIWpr7JCKih2v7idtwEKAcGrlXwUbWYtsAy8KP50YveZ8pREktE3tomTbdZNKZghIY3yu7CzL9MSEB1xoyp6ma2aEuTP/tm2odPGKQ5J8q0oSFSohTH9dNU7CFZ2Ps+Hr3H8kEE8nMeWjbt4igjYHTt1JEWWc7QQCempwun1h8iQ2KPgEnjF2nsLuvVCC9EjwfKXLNLKEKTBRyFVNLTtTLGq9+8oqkGH1hO0QyMb+aBjVQSZMBfHtlsdBJPFF7hMaod2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9; Mon, 18 Mar
 2024 14:27:01 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630%4]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 14:27:01 +0000
Date: Mon, 18 Mar 2024 15:26:55 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jijie Shao <shaojijie@huawei.com>
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <rkannoth@marvell.com>, <shenjian15@huawei.com>,
	<wangjie125@huawei.com>, <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net 1/3] net: hns3: fix index limit to support all
 queue stats
Message-ID: <ZfhPLzmM+1r1duo1@localhost.localdomain>
References: <20240318132948.3624333-1-shaojijie@huawei.com>
 <20240318132948.3624333-2-shaojijie@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240318132948.3624333-2-shaojijie@huawei.com>
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|CH3PR11MB8381:EE_
X-MS-Office365-Filtering-Correlation-Id: a5148dbd-4c40-416f-1ec9-08dc475779cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5gCM/T/U0MpTAAnfYovleSRWlTxddGXHVTh6qvbOLYXcpUr3kYCvxc5cgZR2q9+d/29v6e9PoMP3SMFN+2fvK/lxvGU0zHnke9Xro7EmF2sXmVkEYBNusVVdU08moUiB0XlqrC13bdM3pUcdAIszd99KYQTy2A2JCqES5MnVy6TYDhoS9rtbFenI/8d5BbKfSC8xGusU+KnidpZzm3ThBgnUVNmwNRqLCVDxyp9Xshb+bQRtBhYcmvisMI211Gp+/dulKu/JVfpoSMszGOcwxoRFOgJBB2YL+OZgaRZytTBGZh2X7JCA56FwweDVFwYvDwWgT6yitJvc8g9QPCcozLU0QEkISQZKvltiGRjD4wwSrsOCzE+VwRgW6ymAkal1nSdYOUPnDYtFAS/Ty16Y/MK+KOFVquHfWqfghOIxGHbBBAqUXSxphMttnfKOntRJTBFR3V7NscfkzvsEUFNCaEJdICwWVhZTFH6Z+zm73AB+y0kqHzJJn+uj1mW8TZ9oau0HH+8cX8DjlS5Wlf3j7lrjBh72xYAlOgEpQPDYE4TnA6L4b68u4QXCJGjCt0p9lFETPJOYqiZk/xsmnUmBKnM69FPs6kl9X2aosSTdwT+JGl6AboXDPGWTVVPLxNLaQ+EkFlaz5QPn/xh9ErgTwMl54T/wQoxY5/C9j5hZ1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NR8AKvwkLWUvqIZI+Xe4puVYDibE51q95ZHjnZZByIzU3FBjbM2oaE2YJwck?=
 =?us-ascii?Q?KIbrBbf4oELIR9ozn9Yct1iFXxcq8ZbTc98QoGaJoTw4MDgj/2lvgOW7iPmg?=
 =?us-ascii?Q?2Voosla1xpD2QjX4E7g8RlCAxsZkXrBFjMbypgHdHifqJL6KlxVRqOu0O34G?=
 =?us-ascii?Q?d8opEVAjKAJ08x4uQA3OiUHJ3afOuEvSjKYSvqDynVT9LRbl+D7ZWnR8XsM+?=
 =?us-ascii?Q?adDzx7+eW6P0a0PHuIG8REVq052fzsoVQrvwfFJeZY8CXeh67pjyxYO1MF/3?=
 =?us-ascii?Q?K5GkTQHoKVHV1HrVwFuTs6YQ9+HBCPAESYNVkzxvWQ7FW79/Jw+S5wrHYTlz?=
 =?us-ascii?Q?62S8ORVO908gmFBpWTzJQIoSSEXX/WRHk2Dwr9bskm0zxKLecA/z3JF5AGbd?=
 =?us-ascii?Q?gytdJM9sS+I4ABNI4GBe7KGcUWOgqYyOlUhYl/FyLG9K7xM+CN/lv1h0WpwQ?=
 =?us-ascii?Q?XCFo4keJBugS0qFmD4yDpIUsku2E7wpD+T5TSvQjIGap5ywNjBJWpJL9wiHQ?=
 =?us-ascii?Q?ZiNQZo1+CZZwe9ns5TH3irZ9jzklc83w+An6niuSJvXZMT6eYwI+wSRyyEv+?=
 =?us-ascii?Q?g4egPuxDzUeIyH/Hgz0BxYFfAaMbeWv8xs/zJNdqBKnb2DeJL9HbYETZSlv0?=
 =?us-ascii?Q?Wype478NlBFxvNwO5m4HOuCsSPfoaZ8TOl8rRmNPRHfO4+g1tvowgUTPEM9r?=
 =?us-ascii?Q?oazk24ariRniDQgtpL1qeMi+jJQlfgwgJwZC0zZrprTl9t6ov6KFPENvctBQ?=
 =?us-ascii?Q?3gnqNPhqorqUUB/cQR4YT4b4r0seADODl9AGSO+5HVfxaxCDtsibvOQaM4i0?=
 =?us-ascii?Q?FH0qNUQt+IRjCir/Vo3loHx5IgWzYPvrRObAH5GXlGl+oFWC1dDFEgQaSrvw?=
 =?us-ascii?Q?AuxLbC36uTHfY3YSijBP9BQVBS+vA+FWet7HWRslfNr7xgSS+E203Mrgg8Vp?=
 =?us-ascii?Q?e/vhhDKg7o5LJqIgiH3dKtQHoyQyVanVmwh9JdPvE+VULDlBPWiaEgz2SryP?=
 =?us-ascii?Q?bPnKV3eFgMRB0gdc1GuDGJhTTKAzRwcs7TD2eYCjIzv3ZW1fl0K+bL5ZsvA0?=
 =?us-ascii?Q?S7yc+V/sjXNW53FpadCCMLB1X7aeP9UENL883u3cWimmgoJbpQL8b6GETx+o?=
 =?us-ascii?Q?stxAPxwggNumNfHhdH5+CKTf0bN31AQGM63MQ05d0bUURt8bctDqeHtLwtWq?=
 =?us-ascii?Q?P2iKjtbptmeiUVfEd6EG6j/+FAiHOfuQYO+ajhOrPLzsb43pKOvX5+U8CsOg?=
 =?us-ascii?Q?ZQxDlHxAzGwgZk23bL42sAcR24/KZG9KlrEmwGh6zbB4lcSnHvbUGpLhLQlT?=
 =?us-ascii?Q?fPmlJ56HUxjp/F0cLaQcstsbzjle4RNq+Hheb8677Q+p9U3CpndzAgA3/7by?=
 =?us-ascii?Q?/AjyANhGK4rTeOzER9BVCzbHVLn+ddeRo4WIvTj3Goknw09q0GghwwIYWC6y?=
 =?us-ascii?Q?2cRUnds/P/gklTt3Ew3rglIUzb6OFoHfVMqDLUmQeCnQeaqVp5OPol587wBB?=
 =?us-ascii?Q?rhtEvVHIL3iQ2XlXSzt0Z6GVuA+SVRm2MX7Z9WaoyzfCshTT4pTDqF4L9n2t?=
 =?us-ascii?Q?bTmJVxPRfKRKE/k2SK9mXYP5i6Mhj8ylKZMDbpU5gMH2NiqYTX2SHaQUX0ql?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5148dbd-4c40-416f-1ec9-08dc475779cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 14:27:01.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ZFYaGpTZC2jLF5AY293+Me3G5l//kDNcz9Jc+5Ik7SdRO0GdHcgMyfLr/U3zLtcGXvybaNd5QRTffjOJVpM7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381
X-OriginatorOrg: intel.com

On Mon, Mar 18, 2024 at 09:29:46PM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> Currently, hns hardware supports more than 512 queues and the index limit
> in hclge_comm_tqps_update_stats is wrong. So this patch removes it.
> 
> Fixes: 287db5c40d15 ("net: hns3: create new set of common tqp stats APIs for PF and VF reuse")
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
> index f3c9395d8351..618f66d9586b 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
> @@ -85,7 +85,7 @@ int hclge_comm_tqps_update_stats(struct hnae3_handle *handle,
>  		hclge_comm_cmd_setup_basic_desc(&desc, HCLGE_OPC_QUERY_TX_STATS,
>  						true);
>  
> -		desc.data[0] = cpu_to_le32(tqp->index & 0x1ff);
> +		desc.data[0] = cpu_to_le32(tqp->index);
>  		ret = hclge_comm_cmd_send(hw, &desc, 1);
>  		if (ret) {
>  			dev_err(&hw->cmq.csq.pdev->dev,
> -- 
> 2.30.0
> 

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

