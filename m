Return-Path: <linux-kernel+bounces-69138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA18584EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DADF1C21A08
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C611D135A4F;
	Fri, 16 Feb 2024 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tU10yuhm"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088051350FA;
	Fri, 16 Feb 2024 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106976; cv=fail; b=p651pVqQlJv30anZ/3jyPdcwlpcPwj60qJT3k8NucHIw1mKaWXFnzgnEahAbdGnDidnqdp5X0q1EoENi7bv86LXhJh7WNdSEffOEHLldCL1UW/InJWIYNkLQJ9I/BuTllrKy05pOxoC8ZMVROM53LTJtsKGsQ5xpYf8d1Q1npKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106976; c=relaxed/simple;
	bh=iAvKayrX8QJrSRmwkHAdhPx63JbZqt35Hk/9enpYD10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ip63hxXVlh69jRmbXNh+LugbvrB8DgGXgF62ndPnXCL6TPhf9NOwbjPFUGJU/n2yHWCoJ0eQjz0WAJZmNgoPndr+lEURtohkY3pajGBZ2pYVKeYpJwer6xgFA0DLgWb1Jj/WVyVEzOdXEs3cj+obT5UB1spyZGuqRAibxuBSiE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tU10yuhm; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbWlwtI66PPb8R5BC2hCzjWo0exdON/yPuwYl0fIcUg+iwanXxk8g6kdXOLsQN1keB5idXf5CSI7738gUTfqJf6uIfE3DQvkr6rbCLWBLLdEJR57/WBo0Aul2SnnjG/zFVGDovZ31hvI1zAxpZZcDSunH4K538ESXJh2heQvoolcdZJQ08bnWyOQ8UGLQg8o+KpEz/VeD8omGIZZ2fdSv+dD0Sf0vjlOikCiF3mLAcg+4Fj6LOErZb2T5GKLaH+Eo7JGIh6q3Pumq65N61JpXdXjzNPTFOTTvLI9IRTAPykGb1uRz0llI0+OOl8bAiaKpaVE1EaSB1euMNw66YvkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkAXukFiMFs6ljePLp0g1Vf4GOHUZnyIOY39GLY4UZs=;
 b=m7DWkikKEdwqxfbs2vEa0gVXbcGcCr/xT1XQ6V9kBT63nHVL1OVewgsHnjqyGli4N0V30buv9+7HzLMtT9DUOsnTODkarnzLaQ6DL5gfwKWqHrkI7eOWo8RhHyyHRXgHkb8ZBQyIG2Tl16wN5g50ilAlE0KHEVvmL2XgGjsOYw3XihKuncT1SlDrfn73aqWct81bxfgjGXbCJWSZybuWT99D/1b+CdW40IdTuR1Yk9JkbrEmmVz5QcVPgg6JUOiOUqcRyKqR4uBEeaxe8JCATv9uuTIw6Xacyc4ffj+00dfGAhj5TSq1b902y+Of2Nf+XjTNmGg+J6aQBcsbgImXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkAXukFiMFs6ljePLp0g1Vf4GOHUZnyIOY39GLY4UZs=;
 b=tU10yuhm7z4Y756K6pc90g7nX6OsIxBjvziDSZ40Na7GieW+jhyc77nyRxre9pBQrq2jhhznq1XJ7F4Fq9a9mBF7+QRskudmxiF4vYJ4km4Cqz2FEplkS5Bzo4YWDXRWj/f0hDbdrQB6f9OdIqdlfvpeTYIhKIEKQyWna84Ob3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 18:09:30 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7316.012; Fri, 16 Feb 2024
 18:09:30 +0000
Date: Fri, 16 Feb 2024 19:09:25 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/pci: Fix disabling memory if DVSEC CXL Range does
 not match a CFMWS window
Message-ID: <Zc-k1TDk1hfvakQS@rric.localdomain>
References: <20240216160113.407141-1-rrichter@amd.com>
 <65cfa34b741ea_5c762946@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cfa34b741ea_5c762946@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR5P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::7) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0672cb-9de0-4a9a-8c9d-08dc2f1a6be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dplh0z5vOhFDGRhdxuT/ykHCpsBS3aWvM07oXdZxRDhBq/Y+iFqE/W/SHGNUB+RnpBWBsSgvwMj/n5+DvqcH96lhlkIHJz/OqkDpoMPM7UEfyFPIUy7b16h9Z/S5NDJIPEDEK2PMusHB8ShsMNKzy7jRlThNz8+DCAElpKNKSy3Y6tCqOOwKvtVpTmAy1RB5mhi6r7ihs1nO0MX1pMOPXWw4eUoApGxwdGl3rADgV3ZO0+LdTqR1xXR5ILIvyYTKXt/ty8OUqWR+/Oy/vyY4AodPgWel1Dtwb61NlLxv43by7TIPi9dL0MWm2Kjxkg66NlMJoynrkFn3fI2e5YkCVh4r9P9xtpgNxTJw1LfaFsK+uwBpVw6x6UQMgZxQs+JD0BbbhQpeUoc+q8QG+4RFun3A/dhKJeNalpPuPnafRxBuhSNc29hG0lFwsLST6ootZh1+2FYVoxgWnyiB/MaFsghVCt7wSLud0Xx8dkKJKroz5fWgGXuO6H6DyVcMcjCc8hjBCC6sFJ3LXb/rhogNQi+y8SWFFmqs1uAWUuEtSfa5OkwsxX2WsAK2YVX5nwut
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6486002)(6512007)(6666004)(9686003)(478600001)(41300700001)(4326008)(8936002)(8676002)(66556008)(2906002)(5660300002)(53546011)(6506007)(316002)(54906003)(66476007)(66946007)(6916009)(83380400001)(38100700002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sqfnwJvGGL3w32Oi0wQx9899U0P4Ny+2r4g8RazqmVot8nxeXV5YH1JK9aFP?=
 =?us-ascii?Q?WoNZhoYSQJ2ZqX6uhVeTliK3qviVMvIor0AZy4wK7D28BK2LN3NRI5gdiyOR?=
 =?us-ascii?Q?zYELBxZPKLu/9fTPa0pkEbY0K0gEN4kxrmbJA/V7DBMJnOHBlznWPDZpHdXY?=
 =?us-ascii?Q?OahQX912TE+OWtWpvnbRdRpWFR3JdPryMvscYIePQsanrBm/X+OnHuVZuvUH?=
 =?us-ascii?Q?ga6F7cKT4vdsJX6P+8hsMUtUpt+i64cHW5B9O6LOF8unc07Pv0SdRwxBCtUo?=
 =?us-ascii?Q?MBOAidAGbT3CG8gaJ8ndp6mEneyiuMGZJASNnHTq9e4xcKw1CPIoczdGnY6Y?=
 =?us-ascii?Q?Xfm8Av1AVZoRWQ1EjhvJwOYROsGqtZctd9TbvQymAPkzCkQNFXm/OSdAln92?=
 =?us-ascii?Q?qDuczsgkmHz1ZuugHkXrm6tKOgLXjFjz3FmtAY922Oe+NVPBM6ZOerEPfRoX?=
 =?us-ascii?Q?hbE91wP3nbydat7rZZCQzGzmuyGnj+KejFGtkTav+RXNr4TbkgJ2wdgpR22B?=
 =?us-ascii?Q?ejdsjItTNGzj/wILRjH0T2gEjyRzv783+aiR5EiEfh7juZGzcyqb5AtEbDLf?=
 =?us-ascii?Q?jVJVPwPZeLuWpQ5s/bTuukWZ/fUtmW1pWHo1W2fur6yiHag7RV9fq00x1dIh?=
 =?us-ascii?Q?4c+z9n3GC+9mF4Qnh+KhrIW+RMY5OXzEDUBa0wzIwHzzU6fFAcE7Wc4nTau7?=
 =?us-ascii?Q?/wrvQwzmsmaCCAfF9UZ0uCLJXihQ4o9MXLgE1jDz3DWuFsd46Q2PYbI25Yi0?=
 =?us-ascii?Q?fsUWcl8PCagMmOYh5BjwZZgbAp3pQoDj8hmBgickSUDywRR/5UnjMPHtoU8C?=
 =?us-ascii?Q?2ahiDfd/+NSwcqXZz6Onic1BrfTEnmIjAfm9QWCzmpP/xWcboHbUTPmUuUb2?=
 =?us-ascii?Q?yO2Zmw2RqkRgmXs5jQFxYLZfRxccndwE1QXRsnpPhWkMpDDcG8awuhhDInj0?=
 =?us-ascii?Q?Xvv6xN2p+KaBz37BaUKjMaK5SyslNFwP41/008S6fwlJeVX+I6e/ebUOMWEV?=
 =?us-ascii?Q?PKfAhsdeY0gjYhTETgk3BjOipFMgn6s9TW0B61Sx8ixVWNdqURosZrhHXXwW?=
 =?us-ascii?Q?0NDQpMfj4t2QTkb1fcO2/SGzYiRdaj2KRIj2XpjdyfcH8FR95FV1nyUKwkD2?=
 =?us-ascii?Q?xUTGp6Tir7nyGf4uHsdJm3cSttYd+s2il+ffotf+jKne0liPxdvMLh7gM/Ly?=
 =?us-ascii?Q?nUhcKEcnsim/bKrt+UfgdxXceffdDFQX4VEM/hT5Lq3KHe5CxI4Rp2Jxx62+?=
 =?us-ascii?Q?0hVmrBG0zttHZBOI34CyJgI5CLUxZ3LAXD13HtgG/8qdi2aSNGBJ5zRjqVj6?=
 =?us-ascii?Q?r8sMfO3c/Qwm1ifS555Dpt1St8TVAMGW20fcneurO89uzUczT4nIlJgJ1ADE?=
 =?us-ascii?Q?yZE0YNWnViG6c7sLp++UlzxVVNaQdPdEBtBjFhlGLitu09ZSdmU3Icw/AQWC?=
 =?us-ascii?Q?17dXYuNwpo6KkUrqCqPQZGmNWljRwzPqsGzoMbuwW90BYW9eaI+qnmuAFgbh?=
 =?us-ascii?Q?IgwzxKTgTkmPah2oKpGylGqzKFwWs+rLzMSW7X/PWyt7j6ANH8u00DcK77P+?=
 =?us-ascii?Q?FDw9RixK71mKBnsTxDS5A6whH6gFu0L1xvPSvRqI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0672cb-9de0-4a9a-8c9d-08dc2f1a6be9
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 18:09:30.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4S+FlNK53UzuL5qLyv+vF4/tg7qTswZRpocMYZ4L983dgN4X/H5NUgq5STiYdvwZhjFG8/giExGVoeZnJ7V/dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583

On 16.02.24 10:02:51, Dan Williams wrote:
> Robert Richter wrote:
> > The Linux CXL subsystem is built on the assumption that HPA == SPA.
> > That is, the host physical address (HPA) the HDM decoder registers are
> > programmed with are system physical addresses (SPA).
> > 
> > During HDM decoder setup, the DVSEC CXL range registers (cxl-3.1,
> > 8.1.3.8) are checked if the memory is enabled and the CXL range is in
> > a HPA window that is described in a CFMWS structure of the CXL host
> > bridge (cxl-3.1, 9.18.1.3).
> > 
> > Now, if the HPA is not an SPA, the CXL range does not match a CFMWS
> > window and the CXL memory range will be disabled then. The HDM decoder
> > stops working which causes system memory being disabled and further a
> > system hang during HDM decoder initialization, typically when a CXL
> > enabled kernel boots.
> > 
> > Prevent a system hang and do not disable the HDM decoder if the
> > decoder's CXL range is not found in a CFMWS window.
> > 
> > Note the change only fixes a hardware hang, but does not implement
> > HPA/SPA translation. Support for this can be added in a follow on
> > patch series.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/pci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index a0e7ed5ae25f..18616ca873e5 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -478,8 +478,8 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >  	}
> >  
> >  	if (!allowed) {
> > -		cxl_set_mem_enable(cxlds, 0);
> > -		info->mem_enabled = 0;
> > +		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
> > +		return -ENXIO;
> >  	}
> 
> This looks good to me.

Thanks, Dan

