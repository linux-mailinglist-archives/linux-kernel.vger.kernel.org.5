Return-Path: <linux-kernel+bounces-104747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BFE87D30C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F761F235DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC9E4CB55;
	Fri, 15 Mar 2024 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fo7RUFQt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3904F211;
	Fri, 15 Mar 2024 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524954; cv=fail; b=XE+NmKaA7fCyZFu7xXmMdqRZ/Xy/Bx4B+Ms4ehS/aXOxmO4AcgYECXGPiBUTgNnhMzLG2WaKnYB9W/8z46uiLbfle9ozw2eOgw/VssO1IHmA0A4C0QiYwt+OVh1Zk9Qnr7Q2BIDNGyO1ueDPxn+0OQZzro9gwBpo51SBqJLKPQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524954; c=relaxed/simple;
	bh=Q6eYF3qSNNZLZ3BEP539kb0+ffxScfzaCYCsVyfZBdo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hy3b219ltCPVuSMG5Y9qLJn33zSqGIL1FzYNUI4F/2MSI+d6ktkGvIt1JIDrUaJqbiLE6sE9ZYrqL7beIDn39R5ipJZcNenVo0WOVd8awc9l9UDi2lLdnAZLjNqNuc69QjZ9Ed/YYct4Bmt71TesLvRHnmsy+5kKSORwn3BioH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fo7RUFQt; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710524953; x=1742060953;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q6eYF3qSNNZLZ3BEP539kb0+ffxScfzaCYCsVyfZBdo=;
  b=fo7RUFQtqkcMfqI9w2PEkQw6Lw2nJZEmxjSCR1VH805rjpl+SWvePZ+u
   KjcuZqp650SHLFk4uTQlJOEbSBupEYocNRPvQPRayDyWNSD6bHWrmbrgY
   0a5e/yGx+Y8Ug5EV/jLbWgSwnSBMS8mH+Ssmn74gJmkh6IGWU4YlVmPaL
   qZVLDNgPXxDFPE0VAF3178fnsvUPP5n3StYiS8nmM9vpINInkZfq1+ii1
   TSAD8G4kKjtN1Fd6tYWvC2dCqVyqK3NrAfOI151NVNI0xxHKU8W12Q85N
   AgFXrCMoGV2ZJHDkBRE8d6buiHNQ6MUO5lFyBWlBRlQV/9pZs56wqdWw4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5595353"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="5595353"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 10:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="12815404"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 10:48:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 10:48:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 10:48:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 10:48:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 10:48:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA37RhSKlmdKkDxDA3bSMxeuoYp/YeneKvEJrY1UoMwSn5Axr7wJgy4SYW89CXOui1GJnyxZ8ToT1VP3mnlfFi/TLIF0T4RHyOms7FXFCLxydE4Ido7NWEUdFavwdazQyx3iV8l+syoq1tcOH5EKV1vaFPSwGTploTlSbWvM2zui7W6uqoK8hbW707pTduihLggZ1pJgMXqf/Zl+F2UcoURtjMQr+KhliJ9uMy/La/rhx37otKkfhMOy32teJzXfuFTz/mjEdpCaHS5o25oHFBT8DFmeCYvuhJobgPJ2zGKUnxBp/8buYDBCQUybQjCakGxfTuOPEiNqIiJpMWk2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFqOhrrd3tqlWdIwsrD37QlNYFYdZ8JDQeVIIhRM9dg=;
 b=DzuhC/ecnq1lT0HV9cRLay+ovgtclRD0EH+ClU5L9HNXeb47XwFPmYeKu3dV06sckNwP8iJ16CsBULbVegDMo29N149A041MI2U3UebHEEvaGE63dzQoB4DQlznQYP0/rWqeOqUjEfD8ZEs6HPfd5anUjTmwQBj9O3Aps0ufPvzUAnHH0kYMrYRwEQaPhmhgyc7OR1qDBRM0T1pEiTgWBOR4ZUyc8Os6U1Da7Nmx9EshDtQrFXvNa+NSUj+8uQCGSkZi6TJ/oaS/hbU9CsC6/dRHZSM4xmZK4Byz/K/zxGs+ILMm7T0SwcYihk0fgyxsGRB/ahfkpRGNiU/p6vUkig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by PH7PR11MB7571.namprd11.prod.outlook.com (2603:10b6:510:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 17:48:56 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::d48a:df79:97ac:9630%4]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 17:48:56 +0000
Date: Fri, 15 Mar 2024 18:48:43 +0100
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jijie Shao <shaojijie@huawei.com>
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/3] net: hns3: fix kernel crash when devlink reload
 during pf initialization
Message-ID: <ZfSJ+08L+Tr3zeGU@localhost.localdomain>
References: <20240315100748.2913882-1-shaojijie@huawei.com>
 <20240315100748.2913882-3-shaojijie@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240315100748.2913882-3-shaojijie@huawei.com>
X-ClientProxiedBy: DB7PR05CA0070.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::47) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|PH7PR11MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2d3b77-6d3a-4dbc-a2a0-08dc45182f84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mmf1wsuk3mmqVCkoX7caHmd3Bjpgd9PcEknekhSqMRaIIiPg1cebDj3M1VJC5kEsMCPX3KaoljKSc1sagMHcsgerrkEdKfb2QXL/GGKT4WMl1Y1Dxby26+f6U6vN3Ib85qy4b9VURNJYkQbCAsLOG+UwF7LH2mbLZO8OX4kRF9TfhW9Wm3m8tR1c29ToYW+B5nEbPYCEvmpdkZ1KXhifnP/laOdoxLl5XXRacBoZnLQhpmSbXR7kvvl7lC3q1tjyb2TN00vXBvQhcUsDqkMRwBTs6w0WVc19B5up0SJ1cGY325tZTXGKlp3rUgmFOw4nnB3XPnmPKYeZmRraKSWm8SErpEX3k8XzEdHnFbzE1nDUfcHsup18DuKtB0WmRa0nP9/CeNns9fiJugM2Ob4v9jcMYeGAEsAG6qc5e5ZgtaSKAAeLCLb//kMoBUTjXA1QTUwmiqBQr3BKHYb1lPM9mlaxcNjT8YxCakBWxojQCpxIeeDFoIG7VgxAGdvlFW2KGaWb+z2o3qm1/rctUfRCVNDgw2ez6dYhXTGqv/hh266Vxnzt+ocFHCXmzgfuciMIhzpunwHBF4kQyryjKWOQynfjxQIFSXDqVqGEia6f7B4mIf8nh5ApFnaU5vg/IoGzHhVI0qXwh61ulvVvuJsmuWjEOicGQKArHUjp9JVkxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ctEiPkPevlabT1a1mxqGdwn3+2JrYQhXGQuF15gVhuIoywd6ClrIfgHWreA?=
 =?us-ascii?Q?1rk4RGpyLW24RmhPF3UPQD47ACVzOsTRucZz+E+njGzRDLfU/Gwpp2siM3PW?=
 =?us-ascii?Q?h8jqbWi9Vf0xtUGHe1WfLVsmZ8JcIBtNYBBUGrYbpjBETHJT6hL2mD3KXcWn?=
 =?us-ascii?Q?FGY68iGT0i8PG0GdiOynrAalxGnBkuZ4TYVzLUmZ/cUcDk1P+b9q/CHRS1kX?=
 =?us-ascii?Q?ofmrQtmH3EeJ5/3zJxVnaLR053df3x4DZlrWXHzys3GCUUbC5ZL3bUvCZjLk?=
 =?us-ascii?Q?lqrcOK58xTUoJjkF65kwkotUPRzK1T1XN87/wy7iYwg5YmrTLUwUVDs41Uw4?=
 =?us-ascii?Q?bjBiTdLjTdcjEisdyVclNXTEig/qGBJSI2QVsf7/uF17mqYVNPiQ1flyLJOP?=
 =?us-ascii?Q?G4p6Jg9zAZwcUfeMCHbFDrnbIbz/NEYLH7yWNJUdhHA/VUEfgko/v5rq0xau?=
 =?us-ascii?Q?tEGp6/8rzAc5YHdL5ODzm9WmaMx0HsL4S7wis5nOLKCpO/jMSfJAkI8DSpQx?=
 =?us-ascii?Q?lLMj+2CJM6qt/LD8q5GaxD4Bsq6Ji4szZiHnv3293FwtzIorpkaSAJPMS+1n?=
 =?us-ascii?Q?bVZk+VaxU3pOa0CWuxucTm7Qpt2h2nTHmQStEU1bn10RvxzmG88tXm1ZX+hb?=
 =?us-ascii?Q?SKxrYI2Q9QUj7iuRYmTyhcx87NwyZrqK17IlwvkFLg17filg/oQdShPCa3cC?=
 =?us-ascii?Q?UgTZefxc4tOF3XSjLaeQ6CX+5E4KVfLt6aSaRUPeHWsDf+my1WoLM6PgWWK1?=
 =?us-ascii?Q?GIxFR2SKvGjFxJ8OlpST3LCeuFjHQr5iCT/vcJO474gdN8G1PC++EXv6y+/g?=
 =?us-ascii?Q?QcOBVvfxywKrR7LTCrmHPq0LCdq67v9CgzTCLShC73y0uzS7Yeo9chRGfH7i?=
 =?us-ascii?Q?PyEPiMzHJ2TVb0qOUUvmZR55LByvSV31UqNeL7vCPqiYuL+ZrcsJN7O1uEV4?=
 =?us-ascii?Q?iTpYLZ4loCCdUiBTy/Aw/LOtQjMF6G/2019uiUhdBn1ZuTRH3t3p9WSOn9ES?=
 =?us-ascii?Q?DwPVA4u6HFL4AM9lEz/1RyDRIPeSEfGcVzOXmhVRGVWk+xmOVzYoBKRgry/0?=
 =?us-ascii?Q?KwkDgzhnLgGmwLmSme5rgQnYmvsbJ40md4B2bcdBJsVkwlKMA1CtgXuwXLn0?=
 =?us-ascii?Q?CFwrdiojjq+ehTdqAnOZudKC+vpYzq4zcTCAKFdN6CfoBctTTVwMzLEcMuwY?=
 =?us-ascii?Q?9QsdfvSjRUn4UZWHIqjbrFv/QObz7DdPPzGjydsJhOq5WRNxAHZrnponzNoU?=
 =?us-ascii?Q?1vJn1+nYKsPvL6Ndncs66YKpf9kQyHyUUdDV1Bh1AXJ04MV3cCaM8uH/DuKZ?=
 =?us-ascii?Q?tCCdnXoIE+JeHLxe/iqUmW0KxceRglAg8nGzlsEcsRyn6PjHhAYR0+YpV3g7?=
 =?us-ascii?Q?93WqNFl0VzR10hrWhKxf6xOZST1G8FRw8uVUwMiK64bmoG7tcCR/K13A5Yzd?=
 =?us-ascii?Q?IOtQsPxudqmPie+0c07VBtu62u8Nh2seDZywar3Ax+5eYlxJxmGy7Kc1qo5V?=
 =?us-ascii?Q?Mn4r6NlTpII+Gr7iBLPh6lgo0iQlnWgM+yVi7G9RnDRTfjoooTnqU0ONGMnl?=
 =?us-ascii?Q?0zzJ+vDZa5IeKYz/3cH70abKNX13gwwr7LALJeiAKXnxf2ujD7BoJNIA2aRT?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2d3b77-6d3a-4dbc-a2a0-08dc45182f84
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 17:48:55.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDUPnAx1xPTdpGehiGUlx5Z/7KIcU/D0bKqGE1/BzrAFNIIa+dfll7tWopVR6ZLWGLGf9aOsbB+vC97kNoyqtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7571
X-OriginatorOrg: intel.com

On Fri, Mar 15, 2024 at 06:07:47PM +0800, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> The devlink reload process will access the hardware resources,
> but the register operation is before the hardware initialize
> done, so, if process the devlink reload during initializetion,

typo: initializetion -> initialization
Moreover, I would suggest to fix the syntax of that description because
it seems to be not obvious.

e.g. the register operation is done before the hardware is initialized
(but I may not get your intention)

> may lead the kernel crash. This patch check whether the NIC is

-> may lead to kernel crash

> initialized to fix the problem.

Maybe just: "Fix this by adding the check if the NIC initialization check" ?

> 
> Fixes: b741269b2759 ("net: hns3: add support for registering devlink for PF")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
> index 9a939c0b217f..80db4f7b05f6 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
> @@ -40,8 +40,9 @@ static int hclge_devlink_reload_down(struct devlink *devlink, bool netns_change,
>  	struct pci_dev *pdev = hdev->pdev;
>  	int ret;
>  
> -	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state)) {
> -		dev_err(&pdev->dev, "reset is handling\n");
> +	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
> +	    !test_bit(HCLGE_STATE_NIC_REGISTERED, &hdev->state)) {
> +		dev_err(&pdev->dev, "reset is handling or driver removed\n");
>  		return -EBUSY;
>  	}
>  
> -- 
> 2.30.0
> 
> 


Thanks,
Michal

