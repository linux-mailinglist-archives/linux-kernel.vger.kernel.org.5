Return-Path: <linux-kernel+bounces-101368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEA587A616
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C4D282A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA493D548;
	Wed, 13 Mar 2024 10:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3j/O5DD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B133D0D9;
	Wed, 13 Mar 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326655; cv=fail; b=kl9zCSnPkwPknJ7zYSgLmp60k4yWZWfutcKq+q61XX5EewF1X5mdbdptoFLB4PWU0hD2Rhqb9EaH1JAhZlUdufs12T/eVuHSEuSdB0fZYm1+vlpPQriYbttVV3bJwMgJ1ngVa+33UxKWrfK0/EBclckje3uev6aZvmP0QStGfos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326655; c=relaxed/simple;
	bh=u67RRtu1Luf6ab0scLDV6O8dUa2q2unE1XAAaWAb1gE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tqocf2nQ+asl7C1rdt7ST6oLTu0/anVUnP0eJMJvvlBA77Nre2BP4WMnZPSLBYv7GQSjfA4og9wENgnE/9XznZw9tJyiP/O6m5yuFF/lDB/dSbLE+4PP7kTtfcHp36n5oNZPm5GQql3MdYy/56D8KuV6eMrNQqq/p9OeHznh/d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3j/O5DD; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710326653; x=1741862653;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u67RRtu1Luf6ab0scLDV6O8dUa2q2unE1XAAaWAb1gE=;
  b=M3j/O5DDGxqflGkOqepicrXY1Y5RomjxdQAJOE3+7+inoNU9+DC/8rZH
   6PbDDxysYFuElqC/3IZAdfk2ZweKzEU8otPjBixU7VnTHSIKLOROkjOQw
   D784rOz30L9wkr3Ma5n54oOEehl9DDFZbOokSHbZ3By4m0QhSaXcBQhgZ
   LMf7T4LOGg3MprZEWh60UirJo7i1MMiw3vrjBHQWlg9SCFejdxkWnnLky
   l5sJtvCsbE+/RQcMpZNMslwGIgGm5+sb/zVss9aLGyY2DJbVkmtVDnN4W
   fIzvAUM7XYCiPG8vlcItUVl2oMOvY38wM0dMqRHZKalJorpLS+6s/d97C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4930740"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="4930740"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 03:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16600891"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 03:44:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 03:44:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 03:44:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 03:44:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeKkIWBU5g4EQcBTVG/EL3KN9bKNPIVpN99LTlKQ6r9zZYN9HiPvHVkGaQGzSbyKEr1SQUEDxCqF3G8hmgSYr5bA6rfy2WncEaW+tv2498u5DGIhNUD3qJTyhqTKh6oKnYRCh4j0zRLCeuZlU1unB8FCKlja7tCdhwFQpWS01X0BtFBbKwhhE90YDfw8EHQa9optqkHgrkJkdPrIN9u50Q/a1lT1WC/06NQQ2UiKE1X26s7JCgMva2ST/jJAx6DA1sYsGymWq5U87+aOvMdggSK6KgXLN+nwYvscCVIrBwyzspZXztg4oMaucdzekkeGF7jTX3pUACB1KPKFwTuOgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8Aqei2X/7j673SLtYvLocVaZ+EKe85IwV95RGrXvLU=;
 b=Bds0PxUtjUKt0oA0WGTxN8gYylhd2+LMQ1aN4JEaXdtEkRbcvZrXreeqn2Sr/urge2MIbz314dCoXMNJMmUaXTbnNq6/CR5F3MspaZ8Dn3Q/Hgd8aEO5BWHLO9nCRPEzTXXueF6G18VgJtiLTHPKdKwL8KN2+s9I4f9Lzd6EueP8PGrvtLMv6JkQgVKTdVK8ZxPUwQ3klePEUbpC9To2D1yaAX2qqIONgA5sCIkmGzZT+mRrdexWUkpm2hzIAY/mQI8E8fbzalsL/bsh7aoRwABy9cyZTBL/R7OW6ObI9feh1O00Tr9d2I+yoQHEdB07irP9m6HFPc9YR0+0mWECbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by DM4PR11MB8158.namprd11.prod.outlook.com (2603:10b6:8:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 10:44:04 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630%4]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 10:44:04 +0000
Date: Wed, 13 Mar 2024 11:43:54 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Duanqiang Wen <duanqiangwen@net-swift.com>
CC: <netdev@vger.kernel.org>, <mengyuanlou@net-swift.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maciej.fijalkowski@intel.com>, <andrew@lunn.ch>,
	<wangxiongfeng2@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: txgbe: fix clk_name exceed MAX_DEV_ID limits
Message-ID: <ZfGDai79gJ2IGA1O@localhost.localdomain>
References: <20240313080634.459523-1-duanqiangwen@net-swift.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240313080634.459523-1-duanqiangwen@net-swift.com>
X-ClientProxiedBy: DBBPR09CA0045.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::33) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|DM4PR11MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 697ee2fb-9452-4f21-12f8-08dc434a8077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWs9UJvM2SwLohpJEKOvINae8GGm1isSK1fuGzxd3966jHC2ycLPEMJzP9GssCi9x8gvAzOH2d8bBgLrgOgYx7gHvCIlcuf6kvu058GYzjBKaOYIitUlW9l8joEoJDaKI+KAW/+MHUay0fi2mzeOrGM1US+x8YrC07K5PGTn5C2LRZc4PiJt4xZEoRO0GhyJYg8iA58TKku9r3TfSlcJ3X/THImZTCX47vexCJmjA6pkpRQJTRtcr99VZ33sgFQ201NEoHZIKViVNV4wrPrDvjD63vbcLAEcb5TsD+K2qGKRtIWdqIfzEBQ8KHUH9RaYY12kYeYPZsu5XU9OOZH0dEArR4BZ06jRnu9+lehA1p0NbybCKdXgpCVPSAvhxsHAvBsd20Rt3xnlvfdZVZ7TDYiKYhbBWlHf7SEL7Bm+U+oX0oCV++Viuq9917M+FuR7uqKPUmwZdLAf2xCNyOCqGdyr9Q7F2OKCTCr6A5RxBViY6E6XMrQ/b3CU6dK6vMUUIyCBvCK0Y0JVmq/lx4FX+SCCaHcl+DcWLD23vcShE/pP7dhNZF2axfuLDax92g6ch7bqr2Q7/Oe6B5+Sgn0GujN743dzppq/sqCdXjGXjFMX8oKTyCHAaAOaBVkXQ9EC9iY8i9VAz33/Q3AG9qAlIFrHpZnC5kfuRwSACwUpiFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OeTedRERXgGtTQQszC2p90dgorM2wGBKEbRRp3wp1YVGgiTcjAwnoWJPstRZ?=
 =?us-ascii?Q?HD7TEkGBFthnkayreoNonLfaUT15LeLmBpoh5A28IwFzo0XMm3B5lmbrMr2i?=
 =?us-ascii?Q?CpEpgJFQ4EMwAkxUQKDW3IdAwHgk6UOp7dwH6jAHElyBpDuZBWfFVlHWNFsn?=
 =?us-ascii?Q?YnpFrWL1cqXzHXASOHdvN5SINBEoGBCm9o5zsYIPqiPO20mf85VXdNSgNia2?=
 =?us-ascii?Q?a1q9DCABNY5oYCgG2zdVagxKHo7hOpVkBm0EYA/10o7/rs10IjHX0rwOiA6A?=
 =?us-ascii?Q?wRL8Npz+H8+Z165+zVcGnrJa+jT3HxcCvKFM2w/AcOazdRqOIIU/RvlMURYP?=
 =?us-ascii?Q?0B+a7zlb2izX8gLv2/tWEqs5zcNM6+oMYHwZXB6Wxm+PjcMCDWUgeCv6yFlP?=
 =?us-ascii?Q?w+nzjRYdl363d51570Cq2dw2Vy46M389Oaxcb7bj+VyqbI0Ie9sOfFjeevgO?=
 =?us-ascii?Q?kgeX4FmQAtDn0YwvCiTZ9e7aus6ICjOR4GTY5DbS7mUqZVdUtAe13xNPBTOu?=
 =?us-ascii?Q?+7yBzPyZHwIN8M/sVyN82kKjyzqsBVBTpejnf2/GmWGSnuLpwyD9JT0xq/Dv?=
 =?us-ascii?Q?CRQmP03VfAW6H9od53gDE4nPqwZW588sFeuADKtBOmxbhGMRk46yQemD1CLH?=
 =?us-ascii?Q?FQdpjSxrpRssr1Ju0IMkl0L5JcG2PgHBJt9eyTHs+7X1A+c/Gt4vBMrbI1Fg?=
 =?us-ascii?Q?APdDe87+bT1YKl0A71C8LKJTLVlZTcwr2iI5awcaHyCy65UGP++CbNkMT6D/?=
 =?us-ascii?Q?9TfLm9JMs9KNJ0jZH/KB3mA6v/pP2yB79LL7PxAZkQCyobniSEpC6kl8jJYJ?=
 =?us-ascii?Q?jBKg/wAfmeYzmUyStBwGbRov5r94bYPaWijcLeDVH9T2c3OBPF/z2tcoCXec?=
 =?us-ascii?Q?OoWYhC5llfnOQtnwqomKQTi5KrKHjbO4+OFy75e850M0eNTAouSEA0rZYamf?=
 =?us-ascii?Q?U7Z5LPwo9JqrY93Q5QA7MvsqZQjra9xIu6ul/Fi/ZRB1a7mOGdwlFpKKAthA?=
 =?us-ascii?Q?X9ljIY9dJPjz9fqMQvMtPei5epQjnn4y3mGVGCAuRDQZ88yttR9bPnKW3Jl4?=
 =?us-ascii?Q?lc0ntJ/G0BtJ6GpPn7NxXZ+RC6EcCqxIAf2jeGj86etT/MLvOuUBkyLY3BIN?=
 =?us-ascii?Q?9RJ7SmudQeco3Vx3U3TniEgns4yH2+q0M7c72tdW6AJeCtJw9hihiekGPovu?=
 =?us-ascii?Q?dGkvfwhnwgTc44Wvssje3Q4A6+z4EKF1s5/hdQaY7b7BVN/u/WOPlRn2ihYs?=
 =?us-ascii?Q?N1O6YFerI03CLyUbwpRCVyuogXNjw1rvMFs/V1AjU1C1JjPOxUTDaiWfNCcW?=
 =?us-ascii?Q?mEVtcMTEXOIp5iav1JGUidf3EvGbW/0PjCLQQ6jpfLyMmhptOTsi7Lu/+hcG?=
 =?us-ascii?Q?OLWmsig4DrnrpQc5wJFfkmAL5tdRsmQVx8K/qItHvjl/Ppm+ZSkdVLgiIv5i?=
 =?us-ascii?Q?rXa0ZUAHK0t6BgFHEYhJwZW7cVdggVVIcIrUEcoEPM6iUFKYSV+ZmI33oWB3?=
 =?us-ascii?Q?pBfc6qAWQRG4jwVnRk+vfPWHaOF8Qxhw2hf06ZnUpegyH7HrT27Fwavmwmr9?=
 =?us-ascii?Q?k1gjBHYiqdN36eg90LcMS6ad9oLX4anuY3mk5sqf968HKy3sSUn5+EfRSCit?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 697ee2fb-9452-4f21-12f8-08dc434a8077
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:44:04.2992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvkmExg5XSlVtxDgpVhHfkjTUwFPOTth3LvY7KGNvserA35Ipvjqx9DB4FdY3s7GqxAaH8baP76+JlfvByy2FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8158
X-OriginatorOrg: intel.com

On Wed, Mar 13, 2024 at 04:06:34PM +0800, Duanqiang Wen wrote:
> txgbe register clk which name is i2c_designware.pci_dev_id(),
> clk_name will be stored in clk_lookup_alloc. If PCIe bus number
> is larger than 0x39, clk_name size will be larger than 20 bytes.
> It exceeds clk_lookup_alloc MAX_DEV_ID limits. So the driver
> shortened clk_name.
> 
> Fixes: b63f20485e43 ("net: txgbe: Register fixed rate clock")
> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> index 93295916b1d2..5b5d5e4310d1 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
> @@ -571,7 +571,7 @@ static int txgbe_clock_register(struct txgbe *txgbe)
>  	char clk_name[32];
>  	struct clk *clk;
>  
> -	snprintf(clk_name, sizeof(clk_name), "i2c_designware.%d",
> +	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
>  		 pci_dev_id(pdev));
>  
>  	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
> -- 
> 2.27.0
> 
> 


I believe the patch is targeted to the "net" tree?
If so, the fix looks OK to me.


Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


