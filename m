Return-Path: <linux-kernel+bounces-104730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5A587D2DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01291C22481
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D2D4AEF1;
	Fri, 15 Mar 2024 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpD1tt+2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683B247A67;
	Fri, 15 Mar 2024 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524053; cv=fail; b=VsWZVocgAfcUYA9Yi7CtYCH26X0+v6wVy+3X5Wb9H+RUA6V9nuI32Gw7vE/lwj7Z7iYeYcmD1szJjsrG06ScktxObyCKN092SuXo+9vCz/xSKT0FZ6fiRffR2UxF+bIl/17WRyW5elmnT/rkml4EIccfd5DXC9ZLa+f6vjuojQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524053; c=relaxed/simple;
	bh=MlnHAG/Uv87dkG/URr57wHxzjrmq2ZzhNAg2k4/fVSY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IsAkfmqIGxpNViR6Tk/1fmuEUqpg5AibEgpKKrUTWoNlSEf7ChmXZYgvbwUqgPT++mvXE8QsY2NxoiGNegvu9beuG5AIFyyAXyby2VCiZkFT665jyJSCCt/xCIypCJR7+rlU1mNSIJ03P8k4gsPwoh31mFTfccVN30XUhqPPo0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpD1tt+2; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710524050; x=1742060050;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MlnHAG/Uv87dkG/URr57wHxzjrmq2ZzhNAg2k4/fVSY=;
  b=hpD1tt+2EMyn87ev23iEUZGzLna9fqG2vU86BJI9yiGkUbnQcfHrrwlD
   ewpts5yVKCi00jsoWNDdTT+5apsmzLuXs5sTAv7lKhmg9514C99kc6lAI
   OMGEXKki8/KrhwCCGaZdpY3Qr0vfIVB7zof7oELhuT7FYo9aMrEwHQFv5
   yTw+Ng26hDMy209G+Y1F26Keabr0nRAbtrKyHkturQhRtCFmA+AWKZOmS
   ns2FP/nBRnh9vgjIYcjjulYT5fNu5b/HyewGgRjM9oIa8UNljhxoIiMQf
   BbwroqpPBwJAQftVQKxQVkuS3hpx4Co6MvSKmdIDhMIOgIV/KkSRjEFJ8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="16807865"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="16807865"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 10:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="12665068"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 10:34:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 10:34:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 10:34:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 10:34:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 10:34:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzjqK+P0xVg8oM1DdWLpKb/XELIzcJjHU+k11nzQQ70X0Ufcwqr2jtRblz7SYScH6K7hFYqWdLErsQqGFyzidFZ+uWh1AC+rEpPnKonoOdK3Uu6BLyhJm3RqGzN55kFeT+QhChYe9q0nICF5gBjalKHjlCrJgFM6D6YLjd0zSTi3yr+HuxIi2IRvLbbByMou5z85MSWT7TfrfCS3x7Eiw40h80mN9Wi7UzG0A6CLdhMNk+67uZ4piQdJ89gWQkk4TKw3eM1cF0NpxAk2e7yOg/KHdnv4gMbn9rqwzD5A6cvaB9MEeN3jkiVu0Kj0cxMNMY1PhAXTaUSUfEiMs7HA+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDg2O8s36vOex6FkpP443EtpqqJeqWmSfmLR3pJn0DY=;
 b=LGw4/iAAOTztc5s1n7ds63lArPEMcj5cpYDEY6BFKJutRzd3CgP5+gLtlpEcZ/BUSyL+WauHTs3OK3OdjROq9VcEUy13bwTMH5/lM698nt4k1byHz3U0w5EQt8iNKgulzBJoWUwoGlaK68HwXuQqw3SM2XZp9DJmjjT2Z77wGDwIF7wIGeQ5mlNLm2rvGJXdPft0UGndeW+kOixVfkOPXf1KKRoMwlHwy5Q7+hJGDFJHVc0XnjuAlZcZcrGye0Wmj9lSJFMmFIiRveJhR15R27IJfcnx6tjaMDweO3YmKJWzDXWbqpxpZxtCviB8V6j2ZVa5fkef6Yx9LW4cmJEBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by PH7PR11MB8526.namprd11.prod.outlook.com (2603:10b6:510:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 17:34:05 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630%4]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 17:34:05 +0000
Date: Fri, 15 Mar 2024 18:33:58 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jijie Shao <shaojijie@huawei.com>
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net: hns3: fix index limit to support all queue
 stats
Message-ID: <ZfSGhhn4pkhlZh7G@localhost.localdomain>
References: <20240315100748.2913882-1-shaojijie@huawei.com>
 <20240315100748.2913882-2-shaojijie@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240315100748.2913882-2-shaojijie@huawei.com>
X-ClientProxiedBy: DU2PR04CA0314.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::19) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|PH7PR11MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: c3219793-44c7-4eb1-50d0-08dc45161cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a3HGBxcETkQJlUduq0spQgjPcu5bEko2LbEcWRkColtFkbXqqhnnLVVFAbMDNaARAP2CkIPHNCME8Mbu5253spIlhC/uXp8a1WSZLVLksPFYiKT15Ceehe9HjjU6CpQ602F/Tpm8rJI0IsSjz0YjvBNdtL+7z++338UeWsh9CBy5dmpLsLUO5drmt8ByrBMqaUrJy+tpycJKoesWSnNJnaXZjABgOweSjS/BvUQkQOWP1FzQ+OIeTeN+tfmCkvYGjkXjxtLrNpy1h7eFDTIoG57pKLaLtPrvzRp+mhr8YzTP3RT1alYyKlixJXq7t5LT/n2AxiZr/aTOsfYWBvzGhM91Q5ipzZvzHZzZ9wdnHceivPZClo4sZapDeNmFVZjhNXzVS5FTZ6L2NK/t3vBx3dLMjVnONfXnpZhtKftFw4VgWCfdeoRXiYdctPUxCauRcRxdT1fEK7zWXShSw/6daXQUd3OxDLpMH7SnYlxbi8Jfrxvep8qFlr1qz71OxFL6VNigCcOl3tXchLQrR/zvMUjNMWthLbnCHLeHXBFaPE1jI4iVSxndpVaKYwagvSyOLjHgx+ICj4uVoGlo/GW1eIfWOwoj6j43DhfATA1SIiJB4TmTPDxaWqyCjXJAOnny51E04Yg10TJD08I0WCilDDZAfbYHfhBNS6sMkHO34Tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4W7sWFM3o7Mta0M7Xo1DorWLIAdYPT6PuldN3yn3cpu2wS1W8q6/ExkIt5YC?=
 =?us-ascii?Q?riQVC25e9dvfAKYaV4SYNZClz0B0WnG8kaz9viRV/ynhJN1NZoBPc/C+LeqU?=
 =?us-ascii?Q?qOvalws2n29MrH3VH4ERoa/eUhOF2ebgElEJbPC8eHbFmiKCL7j8DiF9Ni/h?=
 =?us-ascii?Q?D+gsyxai7WnYob1fJ6oDEu3/TysL7zwauMSAzGJmMJ56wunpmAtn3vASs2wj?=
 =?us-ascii?Q?nWFfDS12kJLsdcvTvZE2Qtre6kni5+2vvKLI810DIPBYv8GPN2lSkns086Ea?=
 =?us-ascii?Q?OLyKhdYcFft5itb2xr/r0dmQm2kF+kdfctjORpH5KcuEDZJqrWmGGLuleL6l?=
 =?us-ascii?Q?ammpy+NZXe6VW0uAMJtgsA8OI0jeY9hA2F7n8Mveqg5qbr9JDDIkZ4x90ngY?=
 =?us-ascii?Q?RRWyQfcWgyjy0tHRMqwTt8vTH7Do2lWOfAvntXDNjhKDjKRkAG4R7QQXK7vX?=
 =?us-ascii?Q?zTLE1Wabo0lxCelkTAeGzyAO6rMerQJpfjxas3VVuYRc6xMP5Wm0qwRMiNAx?=
 =?us-ascii?Q?BC96jLHIY+ta4TUfCEFsm/MkoAZWz6z+GzZQUsNqG8LDPR2NjldvZ2jVPN2j?=
 =?us-ascii?Q?HRjt9aLNreaC++PYio2QnKfpErjVX2EWXSfWZbJEoOmSixVascCmTwc72M81?=
 =?us-ascii?Q?LyTGB6tDd9JUTcmpjjfTdFeudzF62UUFaN8ETjGYYh3QZPXLFQyXuQ95fKxU?=
 =?us-ascii?Q?Q9yhkaTFew1G1dzzKpTLRohdD8L1BxtyankpB0Qs35xpeeggY51OpWUMFekY?=
 =?us-ascii?Q?mrEuoQnSa0HAYjZuMy5wIW0Z1quRIfNh2CM5JNsC6oz62npcuZqEuBBMozEJ?=
 =?us-ascii?Q?dgoNJi3fJUeF6vZtgTqOXfpExGH6pZzGwire4qjKO/FLo9Lp06c0LkrjFSdv?=
 =?us-ascii?Q?SCvaMLAwlLimZf8OrYWfmyZRSn8K6HSZzaU2u36V//4jZCpYfJ38dzamygDa?=
 =?us-ascii?Q?GLEV15305wFtqHoigZUF4r4K8gU8wGVxqmA1AkktPrVXHK8VxCe10DGc0fxm?=
 =?us-ascii?Q?EcwDjYf3jvrkKBAh2p72Vs1oYCL1jycmMAApxyBW5Z3108EdxEH/Z+9DNJIx?=
 =?us-ascii?Q?dYOujLv856cUSHeowcRE4Vd1IwYs6Ivtd+oBm1dkC9ie7DGiGHb2YbzF4vXF?=
 =?us-ascii?Q?ri6llrrKGGLCJujm2t608UmXNSFGZwXmQKdr+E8TkZfMCzC0r9aNk92B5htC?=
 =?us-ascii?Q?y/esRZ7jeu6S58JrVqOymY/IkdHvEnjaKqyyYvHc27Ookrb7egBmsr6Xz/Bx?=
 =?us-ascii?Q?fNMDRbQfuyAXr6q+5SA7CfQy5SLQQeQ+s7Wqztz/lXl2AlgLXE0JXm+26zKu?=
 =?us-ascii?Q?gOTVotEYt9S90AbRB+Spaq8vxA/VYWARe7j7hcjuIFI9JUwfL44arKphZ43N?=
 =?us-ascii?Q?edG3dgRQS5Rz4gf8yt44FGM/DgDRtB5u0juP3DWrr8pxsV2Ppfx5HKJOfV/V?=
 =?us-ascii?Q?oKiwaMgoJShnm4hJmv6SYowxDRfpxvRPVCNx8WUtHzGBkC6doKypmc7yPG4i?=
 =?us-ascii?Q?vP4rdsJb6VNEJ742LD9bIc1OOvOv1UthDPpa8az04vM1VHAwfdocktDAyCoD?=
 =?us-ascii?Q?fQy2FhO185l50MeicDwxCVtjZvbtjRWy2fwbn7MBrxCsH29iWSAmrJ7UAs10?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3219793-44c7-4eb1-50d0-08dc45161cce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 17:34:05.7215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0dGpnNoKZkcIfwardmO4d/s5ksI/Zz12vNNbVMUMdHvQ8TNyYoQp2hKPkgxfHfPIZPEsKMRbft7Qv6YZ/PYyvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8526
X-OriginatorOrg: intel.com

On Fri, Mar 15, 2024 at 06:07:46PM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> Currently, hns hardware supports more than 512 queues and the index limit
> in hclge_comm_tqps_update_stats is useless. So this patch remove it.

typo: remove -> removes

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
> 


Thanks,
Michal

