Return-Path: <linux-kernel+bounces-95836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C898753B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 341E01F245FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C1912F59D;
	Thu,  7 Mar 2024 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GitGUik7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D6912F379;
	Thu,  7 Mar 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826693; cv=fail; b=Q1Ua/C7y0FG7t3NtGW/HQwlSF2JKq+kgjoGYC/paX4qNI2vg79JR8SZ+TgpLP6bJm9XxdsxHH8SR3tGowTVNd2UMoMg7kKi0b4vIO27/fUW936gA5m/ovEapoBLUtkk6vsbqNgxIzBGOAmP7SuVmSMLzcQHUo9FBNbWWLQ/SPAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826693; c=relaxed/simple;
	bh=W4XkMjlIXxY5LuZi7DqmFwCa0fX9jrkvKxNoj4AjQJQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M/jPlkHmTNigLDzJdt94GN/S0z2hgDZHw8x4N5VEh50ZexBUQSGv90RFXSAJhu7w4Z9tdofohA4OtUe5ugk8pRlICXu5r8ibqRyBTCk7Uy9G2PNuHuRMTptw34LDe8b43eGmq3DaiTXukd29eiDgcxAruU9lh8ju+f98S2KZlhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GitGUik7; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709826692; x=1741362692;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=W4XkMjlIXxY5LuZi7DqmFwCa0fX9jrkvKxNoj4AjQJQ=;
  b=GitGUik7m/aq2oD0OBAX3Gd4S57ke9uZwkcQ8nVxaNs9yMBMdMY1gdPg
   1AUSMZigB8DUz3zg8msU4ZaCGRN+OGKZmHtl3e/2tD5fa20PmDgBpipdU
   64SLR3edPLhDiWqIWYDANecFLtlvdP8F5yWApcY+wn2H8pbKO3RlMi5TG
   DM/hvCFiyTf1W19pbpPi8g4LU6pnZfxrGAfzyfMnNfpV1WlExNfg1tLmX
   CiFi8JrAb/ayPSE4wpSy867spr6HAbep0eh54nbMOviY6jeDlgRJG3xdP
   l8cd9b3O4mqGbIMeBS68zv9tAx0Nxtc6EtRFiuC4+XVcMB7LMt4fTs1CM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8259452"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="8259452"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:51:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="10072758"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 07:51:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 07:51:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 07:51:30 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 07:51:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcUJT8Kz/5tlUSM2OFWwFb4AMY54BbigbtbJYPW286X44tHLmhbJObZjyYi5s3shhEJKoYXIWLN4PaNsOe0rdmfpRZ9AX+ma7V6a8lG60eCb21h6c0pbrt4ABX5GweSSy7fLfsP/Qcxh1T48Hzsy5YCXPKrx6kBkTPYgw27Q8qNDXm0fgrdZn+gg4pEZb5wMmlxXeMfUAedcbbBto9KUMgZkxCwGxg+oZoue59VyZjV7yo/JKynhiJQSY77xXwYqkeTNQH10ad8T6yZuxrLdrXujYtPeDv12SE091GNsmelVdEbM6l/0XT/xwYoIYgBWzyAWKleHWxE9zMcG2r4rog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbJTxsSMX0sMcHsXXXmgI08zSTTQBMUUEFD9PUHZ1yI=;
 b=DhgGgR0KjAjgnL934ipcPKg6uGXxsLKByV1L6zbaRezJR3m4QGn6s7cttEbqVs82gI2BI5rWKedopyilIXzCd9QM+UnqER0vtQ/Vt7XznpUcmTYTt1wM6VrvTZbM6uHA3oxvZ7BntTxbjchiOjfhQ8FmIyjRnSilHgjh1RjaIgpFkHzRyMMTlf/abmDCn3IViIqOPXPNoHwMyUUI0tjm9qmjCG2jpEIsgILrx0Dea2nQZC0QNo1f63xhO3bqHXjLEUvR6kkZtzzEY1/oNiKQZyjnl6JINpc0ZWMddDWkjb+JA1o3q+3tBSlAlad9MASwi80zVJcuo9dPLvwrN4zVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB8283.namprd11.prod.outlook.com (2603:10b6:806:26c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Thu, 7 Mar
 2024 15:51:28 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 15:51:28 +0000
Date: Thu, 7 Mar 2024 16:51:16 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: David Gouarin <dgouarin@gmail.com>
CC: <david.gouarin@thalesgroup.com>, Madalin Bucur <madalin.bucur@nxp.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Camelia
 Groza" <camelia.groza@nxp.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net v2] dpaa_eth: fix XDP queue index
Message-ID: <ZenidKFF/gQefijz@boxer>
References: <ZeiNxaq3jzloO9l6@boxer>
 <20240307142402.906681-1-dgouarin@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240307142402.906681-1-dgouarin@gmail.com>
X-ClientProxiedBy: WA1P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::23) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 742421ae-761c-488e-8b14-08dc3ebe7359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0gF3LHRp9YsbTf9G/NxMAqRNEvr/AAO5QibxCoXCOEu2ovkNbueyHJQkILLE+V5xZlaLiA26NYmvnr01J2Dvio1MsTE0Zr8uOVCAuJzJNBE7FOA3Uph98kS1sboXOVS3Jxc9/WI9ZV4dx+qfZiigtsp/00E/kOP4ObNVxLglEflhtkEzAnlsuIaE76K0G51FBtccH6s2llghIpLqnLIBNVvKI2bYhuhUlsjnVVP7fLFjRtIuBOJsNEipJkOpWuuMbMKiBxfCtOVS+fEH4uMOcI6tciphC7LXT0ocKqzZfXNPnhYhZHXozL2VvhYIs4U0H7DDDbhuAVgEE9Ob16PauBVMGjGGBKVE4BBARKzS6t4m98SUYTH/VjCWwtxjbKYzypX9QvQZ51CaC/fHUlA08GALFOYUrE+ZAHF1fxmimtxXqOg0tejAK9uWJ4eCgcDZL4S5HwYu8w2kZdOdaM+NbGn0ER53s4RNG3c96/zyFHQmgd+EczskVgmFGMcnq5Ft61X3FuZxeSkVeia4baHBDXjAAOmIyZ2qooxnSSN1SP0Mg2LeeKO9iMQBSGwnor1ORSpY097MY+yCx64kPwrT+QpbgBoVeFqRp4oytDBK3aqK7PZPdcknUC8GDfSnDSrDhIE9b1+iRnIBEbu+aHUnjMV/dABN0vVP2fOP8hPvho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5eH5oYmVsBDY0mErDaNPEbugeB+S3btLqNd0bC86DeFl9oMojFfX3dcor+Rx?=
 =?us-ascii?Q?w2e0IWN44gGGI5rVRhu4zY2aSjBmf6ZjjqUe0bsaClDuASZk6ZXCQfDECNBv?=
 =?us-ascii?Q?+HM75xrreHk0McXJmB0/MxQZcLMkkq8nIVlGoGj0w3Wv+32LLv27CZHjGIBO?=
 =?us-ascii?Q?GbmmwaDE116KRlCHjF1f5wGIRSw1AMND9IsjHwXdBHbKyR+fVX89hZ8xePWt?=
 =?us-ascii?Q?6Q8VKEAF9T5ah5VGHknMqpQLQ/CT3RBq9+mCdgdFcSVRKCxw2JJrGcDm+WfI?=
 =?us-ascii?Q?VP+pV2WnerecPIrHY9nsa0orTtr2b1dM5SssH9Lvf/gljKUTQVYY8tApq0DJ?=
 =?us-ascii?Q?h7Uj84nYDEj2ck1j1ZkcXsiWFd0Y/50adeV12TeMJtZVq7AZxVXYC1VGOiUQ?=
 =?us-ascii?Q?cN7udX+uOmA+ZmGG80PpbVfYr3LKDE7QwV61n0kS8WbX4a47B6MxCQDQb75M?=
 =?us-ascii?Q?o0+cS5+2WsjRxAN4835bWoTAvxvAW2DW3AAfqdd7E4Me/sage3Q4dbHQ5z27?=
 =?us-ascii?Q?yGxuzqH3+lhz2KtEUAp1v4SZ/FeftFIHjNbACimzmNzSjiJQ791/tZNRfm3T?=
 =?us-ascii?Q?5Z4FdmT3zzyUGAjUe9NCWIqBKuKRsuUwlkMIdu6C8wftezVT/laGSlmn65Ql?=
 =?us-ascii?Q?JBuB6LQe2dt7fYK01+6pvUP9twNOLLudm1QRMRXW/0lSUlkb4mzwgpUx94Sv?=
 =?us-ascii?Q?nI0MAfQI2mibmExnxgy5+SYDqLZh+wPBwTkFSrLJLhI2U1cI3UjyfChNgE+z?=
 =?us-ascii?Q?WGlaG4LGfzIuMtAjx9D72ljb3oofNt4jkDF7g2P7nmNQBmOEDsj6hLtRbis1?=
 =?us-ascii?Q?UMlxabfM031UEcRWrFrVDyxuhYkwEyPV7LknwVkMAQko0jHiHMaoJdND0MTG?=
 =?us-ascii?Q?3Du2rczCHXeVs/MMblzDxPaLGsxERHJnLBG6wJDByBBGw2lMpV7smTK3anUG?=
 =?us-ascii?Q?vT3qZAOR5qT3ovOQnDwewz8HTd8TdLUbaqDQDySyI0IoVoUp379IZvWBhfzX?=
 =?us-ascii?Q?oL2+xH9QfA5wc1Y1GJUHLhE2eiM5Zj6zkSAkZ8gD780Sl+L0bUS7PNnd1kVi?=
 =?us-ascii?Q?0mLYtZ3x5PVIwPrV0D0sWLnw2E5PHvCe11Mxf7a2ELYnwWTIdqHYrh55D1A7?=
 =?us-ascii?Q?Gq4jYQUqH1FkbFRUvInHLF1kzQKLUvJAqb1oyz2fbOWpn9uROfh/AqI1uK/E?=
 =?us-ascii?Q?mKHujrm3kCupZQKp3CaSgR3aW3xq9Fm4UauWYCE0Ts0+dSVYu7as3G0utYpn?=
 =?us-ascii?Q?UBXYkLLCidkeng+VZw+e9eGETjDo965zwXLH629fD9pO60b34G2zkOLFH1dd?=
 =?us-ascii?Q?fNKGfzIXXpURBW0oKr9EEytLwo7L4C30VlfhxMFUJBxWqSDE0KhTPxFmOFer?=
 =?us-ascii?Q?t+95Rlwn8N/oax4SkKeTpDCEauyebmFW0d+UtBznSo8NFF4tYk65Pn9tyLcb?=
 =?us-ascii?Q?KKpDbTkJ6Q53UFI0mzc+4kle8cyQpAvoD6eQLqZzZDZRruEUK2BSTMKVcmmH?=
 =?us-ascii?Q?ucbTGiTZR8VDH/1MYoXc/Pnkd8LF+zvReonT3GataIBka6+9Sd4puI6gjwyd?=
 =?us-ascii?Q?L6f0IQOcOfn8O7DozipvK+H4Ovhx/eGY5ZMB0nmjz+cRZcnOLX8pnFL8QlDH?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 742421ae-761c-488e-8b14-08dc3ebe7359
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:51:28.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9CYabF8Ae0mZF9FrDmp5Wmj9oWVsPyODYo77f+dvSsPXjQdIxy/AqMO02PAdPEic3UBLsq4LsRix0DiDwdJZIdGJ+L5oAnS1NXe/6e3HG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8283
X-OriginatorOrg: intel.com

On Thu, Mar 07, 2024 at 03:24:02PM +0100, David Gouarin wrote:
> Make it possible to bind a XDP socket to a queue id.
> The DPAA FQ Id was passed to the XDP program in the XDP packet metadata
> which made it unusable with bpf_map_redirect.

I think that referring to a member from xdp_rxq_info struct as 'packet
metadata' is confusing. I was trying to find a place where you are
actually storing this id at xdp_buff::data_meta. This is not happening
AFAICT. Thing is that xsk_rcv_check() picks xdp->rxq->queue_index which
holds fqid which is not related to queue number, right?

> Instead of the DPAA FQ Id, initialise the XDP rx queue with the channel id.
> 
> Fixes: d57e57d0cd04 ("dpaa_eth: add XDP_TX support")
> 
> Signed-off-by: David Gouarin <dgouarin@gmail.com>
> ---
> v2: add Fixes: in description
> ---
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index dcbc598b11c6..988dc9237368 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -1154,7 +1154,7 @@ static int dpaa_fq_init(struct dpaa_fq *dpaa_fq, bool td_enable)
>  	if (dpaa_fq->fq_type == FQ_TYPE_RX_DEFAULT ||
>  	    dpaa_fq->fq_type == FQ_TYPE_RX_PCD) {
>  		err = xdp_rxq_info_reg(&dpaa_fq->xdp_rxq, dpaa_fq->net_dev,
> -				       dpaa_fq->fqid, 0);
> +				       dpaa_fq->channel, 0);
>  		if (err) {
>  			dev_err(dev, "xdp_rxq_info_reg() = %d\n", err);
>  			return err;
> -- 
> 2.34.1
> 

