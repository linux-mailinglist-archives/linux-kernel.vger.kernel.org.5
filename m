Return-Path: <linux-kernel+bounces-49919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F289F847166
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15880B244C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F29A4776E;
	Fri,  2 Feb 2024 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K+SmtxQr"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1547773
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881793; cv=fail; b=Epx+zBl1Z595jlFdCUG5U4BLZHnKcRBcCISyqdEttmpwl4pw4uB2m99z00VqAkLpxU9dCdaMLHudxpBLU3VMj1g6VUCk85HdHE6yfg+nrvh5qQqGWDqSR3nrHvrbvX5lQrLOg8MUhRVWzA14fX67bvDe8HslhZlYgkme06CWm3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881793; c=relaxed/simple;
	bh=rrWh5Qmy1ELqDDHSZgJQJ7sZkSJ5zoFJtaMYgY4wPRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qeN2/9/gQ2ZaX/yjd0iZyGQmaDi6OyWt8QGXbdTchU7ctpi6pkfNFLvpwwxYspChStQDN7hxWiPxgzr+VuFdzk5GoR5U9QZdoOawNFJQPsNpzrSLfIJI+yxK6J1oILp1QIIHL3zJL4JFPysMaV1jeLNBE0cht/2U1tbFcdPOgiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=K+SmtxQr; arc=fail smtp.client-ip=40.107.8.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlIoY9nqBC4HvV2crTgAQdwDzGBdgWFl0xZNdK4t+hwLL6bch9KbEP4VUrnXBqpVGsRtJ5MLKwDIxNXW0vDxTnHTGw4O0m+WrygMNEnUyeAMOGHwRtnE5YeDkHwx3pgkXt9arsD2Csve0WpZ0Kbs1R8PNmaOj1JWzrPLCiDQXhwpo6HGlIlH9XmqxzFpnCwG+0Zu3cshfLBC0kmDOdIupPnJG6WeZ2OM8m8qjGZCOPIKYmGJHyEh7beSj6NYhGbYhLY2BMRHb0AjchTb8MOZjIeFLs1e5v6lti4+IZXAkfP/qbw67fqi92fMR8WZm8DHNXkQ3Zdqy8nZLwVOabo6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrHnFJlfRkjLwcGwJfuUAwucRXKQUo+BZRl3Hsc4Ljg=;
 b=LKFIXMrcd1Zujh4HkjBviJ7w4/kAedPCggbR/jmYOGlQL/7fZ4TnKnJjY0muzt9Brr6EuUiHvv8I0lXe9iA8EanyihnINzGsGo3LcHvMEPF8HP9UI+XshDpkCyNAgPjXnv/+l/20oLQm+vmUAyg8yRkMiSf+zOkLK9dBsK6+JbSr+qwNuln7sT+mnJDsdadzsK8fWMvn8vYpjKGh5CptLdAMJSKjheSLZLUlgzDgI53IwobmQ+f5ZkuvVGysBZhE7VPO+AB6pthz4QRVGSPlJCMYOfxcpuzX4iyWDIEDmJqZwJ+tbZRA6VK27U19hclPxwNBSPDMdzCFPW4FHOg8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrHnFJlfRkjLwcGwJfuUAwucRXKQUo+BZRl3Hsc4Ljg=;
 b=K+SmtxQrrfhQrJIdgliX1K+altDX4cBJanryHxIHNdnKKtAp8BizQoFvRGeL53xAEz4haE+MlH5jwLBNiGAKJquUDCmL3H/YpP18aFhxWWxM5kxc6+dA4B/lo3BKi3dzHgS8cJrMIFiq++bnK0opMprN1sZDilh0YAxkIaAxurQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5333.eurprd04.prod.outlook.com (2603:10a6:209:4a::22)
 by DBAPR04MB7430.eurprd04.prod.outlook.com (2603:10a6:10:1aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 13:49:46 +0000
Received: from AM6PR04MB5333.eurprd04.prod.outlook.com
 ([fe80::6598:2fde:a297:aaee]) by AM6PR04MB5333.eurprd04.prod.outlook.com
 ([fe80::6598:2fde:a297:aaee%7]) with mapi id 15.20.7249.023; Fri, 2 Feb 2024
 13:49:46 +0000
Date: Fri, 2 Feb 2024 15:49:43 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] drm/imx/dcss: have all init functions use devres
Message-ID: <20240202134943.gl5q6464ibpxvfh6@fsr-ub1664-121.ea.freescale.net>
References: <20240124111904.18261-2-pstanner@redhat.com>
 <20240124111904.18261-4-pstanner@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124111904.18261-4-pstanner@redhat.com>
X-ClientProxiedBy: AS4PR10CA0019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::19) To AM6PR04MB5333.eurprd04.prod.outlook.com
 (2603:10a6:209:4a::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5333:EE_|DBAPR04MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 1661f66a-33ba-4a5b-597b-08dc23f5d141
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pKn7RjW9FjU4JIWuFN9t8/gDvNfB4KFJMxd33bDttSolCAPOjpr58j9UGkqWq9tvEeA8xEkYQHayJKcosWQLqpN1Uno0n2wqWMER5Zg3iOsxn+wZBTN2dmumVI6tDdpdrFLhYVLIX3UZNKwCgxWyzkxOGvB71bPr9orObHovvHXyVafbjQL+XM1nMpVYuTUp2xHyJ/lxulFDRaRpSiKLEIJ1dbzD2SX/RGVEe33hYXbNY/kxiC+CpVGcLwh+rlacnWlN6dzh6E8U0DCfPqPxkva887sKlAeropMqHP2dyJX73WMtoN6psIry5mYCV47yd06MQXB8TN4xXFpmrzfM9WENzT6ljVy4C15mxjneQZYQO4lwxhrzjzN1kHHWfrmsEdBDWrjc8N6nag1hlNpmG8OtpBxrF/GeX3DWwS1l4LAPJqsfnXg65F+idisXzaJySVzQT+G74F1MaWO5BahQvspVJt47DAzNNn/SD7fGQR9Cqnspj0YOUlUpi2JRHC9al4XxqcfN+aL9S+l6jlpyWELZ+EhclAlIu4h/7GrXL03+Zz4xc10ChNETKb9ph3+t
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5333.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(1076003)(41300700001)(6916009)(66476007)(316002)(54906003)(6486002)(478600001)(6666004)(9686003)(6506007)(6512007)(66556008)(83380400001)(38100700002)(66946007)(7416002)(30864003)(5660300002)(2906002)(86362001)(8936002)(4326008)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KZh18bJYS6bq7jMZ2pPPSylwhzxl4o3b2/uBS8NlrAE3QCXsA5moAJu4kova?=
 =?us-ascii?Q?kucpi7bcrlH6vcbDjUlYMy3AQwYp+ZsvRABH4yIJYxHrlFxoTHHbSg19fF9K?=
 =?us-ascii?Q?8+uxC5fR82HJuG+vxmAnt36Q/ZOsBjEqLytl6BLxDjceLBwYUEecSk0iXUz+?=
 =?us-ascii?Q?hEEH1z3fbB43OvGmaF+b8thXjpSJqbupLYPLE2sq81057Fv61rX96ApkkDKx?=
 =?us-ascii?Q?Tt8VQ5f5ZRZ1KJVs0ttaXdHTCmDmqzUpYHW1yQVIYRX2XSsWcbaiDuOOoioT?=
 =?us-ascii?Q?UpPJD1aou+dknLmmPajvgFdAgT5oPwFiKJwdTciJ5yeLW2EFAJRoAWx2geM1?=
 =?us-ascii?Q?qGwMucGpFubj/UDbvprBfaDM6tdjSr7KPLvpiv5iC2mSfSk4B2MGvifUEvWz?=
 =?us-ascii?Q?/EAz+zZaMGdX1K5JK1UHAb+ohT2m4NbQRqBhoYPg1CoEjnxp6E2T8UEIoCQz?=
 =?us-ascii?Q?Cvtwh85mtYHxgOum/2+2K891o1q7mATIMeyqFYA76Eedu/YpfHuHzxm9fjRR?=
 =?us-ascii?Q?jzte7Cg2v8QN18oAmvD/yI71nV35c3jZKfRRs/ws0JnBAV/1u+urPYrxNcus?=
 =?us-ascii?Q?j0SxuhI5PKVer++i3yXPS4MK1rkPRznHiS8/5Kcs6Y6eobr3HMUo+uicGOpi?=
 =?us-ascii?Q?8bti0NwZrZzeaa4zRx2VC1CaDt4ktK4ucZpH5AOPbKlO7NKAx+iBYVcATq0I?=
 =?us-ascii?Q?TVQLL9ANmYsAj2rUzSR0tEVSjYl4PLHFHoPcDlud5ZFp7ui17y75pOGR7dCX?=
 =?us-ascii?Q?fF2VqRgnfibW3BRAKByZWPdIj5fIsUg5IXK8tRQF+2OT4B1YvvSb9ukMLNtp?=
 =?us-ascii?Q?qNkJ5Da8jILj/1r9QbZY5sS9SplilRdZVqN3IIjgcMQLdUXIB+C+d4CFWxXj?=
 =?us-ascii?Q?VyhR0F6VY6O1b4zscLncZE8gIX4PdcJyqr3SLyWScmvuAYBMMjbb6yw0Ct21?=
 =?us-ascii?Q?yJ4JYNy/u2xh3xu9t2/0NUjz1CLtHEI6Oab8cNRETxvT/7kPRdx3nEjCs19q?=
 =?us-ascii?Q?7a9U3O9ISzSSUwJWfajDTm8Yz/SbQoVlyk3M1H6pJgnOknaksLnIEO5CLi4q?=
 =?us-ascii?Q?MfuXAIvcUR6Yw9g8Xh6esqWz9zKZ4XvSy6EusyvjhR3JykTpRU1gTYIUgJY7?=
 =?us-ascii?Q?9ZIeK2qtWgAjWv2nEIXQX1/SZQ0w65baNLIfWy476a8Pte9hqHlmrptzGloe?=
 =?us-ascii?Q?g6aat8W9PTmBktS5i3q3CW7WE+QiLlH07+o4K98L+RKxttFdoGIjctW6H7Y3?=
 =?us-ascii?Q?4NagXzpFr1q41kreHWk6kELrtwRAT7hY5FO4TVMdeDfuDMWWUISHdCCLy60n?=
 =?us-ascii?Q?80Kyh/rPM0KuR7mOG1NEIfVkK4rromDIz7Q7uWaAamT9FCiIT9GILhAyx+Y5?=
 =?us-ascii?Q?x/Jp6pG8WZDAXJOrpq6s7KDl0T763gQblmptQZd5AsZH/skZb47JhjKA3Q0i?=
 =?us-ascii?Q?cZHj04e5yse13MnhenuXLpOZNygDgLBEb9yZqU3REf5eBvNZde3Ipj4TA99J?=
 =?us-ascii?Q?isbrm+kV1mO5r1Kgzd2geKhzf2jrOsj6W7x1cgnf+7N683I/YhMGQmhhBoWj?=
 =?us-ascii?Q?UfI1xOLoHd23BGYUaOGp/Ro3Tb9qAh1D9YuHIP+P0Ni544Mprst6MMbDg8T6?=
 =?us-ascii?Q?kQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1661f66a-33ba-4a5b-597b-08dc23f5d141
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5333.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 13:49:46.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +S9oqhMOU4UYSQWqPNu6Xjr/XOCT9lQpJst/41n6G4HRtYOY42yyrYnSZ6q4sSshQzsGVDP4mMG7FdFiEPGbNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7430

Hi Philipp,

On Wed, Jan 24, 2024 at 12:19:05PM +0100, Philipp Stanner wrote:
> dcss currently allocates and ioremaps quite a few resources in its probe
> function's call graph. Devres now provides convenient functions which
> perform the same task but do the cleanup automatically.
> 
> Port all memory allocations and ioremap() calls to the devres
> counterparts.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Thanks,
Laurentiu
> ---
>  drivers/gpu/drm/imx/dcss/dcss-blkctl.c | 13 ++-----------
>  drivers/gpu/drm/imx/dcss/dcss-ctxld.c  | 14 +++-----------
>  drivers/gpu/drm/imx/dcss/dcss-dev.c    | 12 ++----------
>  drivers/gpu/drm/imx/dcss/dcss-dev.h    |  1 -
>  drivers/gpu/drm/imx/dcss/dcss-dpr.c    | 21 +++------------------
>  drivers/gpu/drm/imx/dcss/dcss-drv.c    | 12 +++---------
>  drivers/gpu/drm/imx/dcss/dcss-dtg.c    | 26 +++++---------------------
>  drivers/gpu/drm/imx/dcss/dcss-scaler.c | 21 +++------------------
>  drivers/gpu/drm/imx/dcss/dcss-ss.c     | 12 +++---------
>  9 files changed, 24 insertions(+), 108 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-blkctl.c b/drivers/gpu/drm/imx/dcss/dcss-blkctl.c
> index c9b54bb2692d..803e3fcdb50f 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-blkctl.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-blkctl.c
> @@ -42,14 +42,13 @@ int dcss_blkctl_init(struct dcss_dev *dcss, unsigned long blkctl_base)
>  {
>  	struct dcss_blkctl *blkctl;
>  
> -	blkctl = kzalloc(sizeof(*blkctl), GFP_KERNEL);
> +	blkctl = devm_kzalloc(dcss->dev, sizeof(*blkctl), GFP_KERNEL);
>  	if (!blkctl)
>  		return -ENOMEM;
>  
> -	blkctl->base_reg = ioremap(blkctl_base, SZ_4K);
> +	blkctl->base_reg = devm_ioremap(dcss->dev, blkctl_base, SZ_4K);
>  	if (!blkctl->base_reg) {
>  		dev_err(dcss->dev, "unable to remap BLK CTRL base\n");
> -		kfree(blkctl);
>  		return -ENOMEM;
>  	}
>  
> @@ -60,11 +59,3 @@ int dcss_blkctl_init(struct dcss_dev *dcss, unsigned long blkctl_base)
>  
>  	return 0;
>  }
> -
> -void dcss_blkctl_exit(struct dcss_blkctl *blkctl)
> -{
> -	if (blkctl->base_reg)
> -		iounmap(blkctl->base_reg);
> -
> -	kfree(blkctl);
> -}
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-ctxld.c b/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
> index 3a84cb3209c4..e41d5c2a3ea4 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-ctxld.c
> @@ -202,7 +202,7 @@ int dcss_ctxld_init(struct dcss_dev *dcss, unsigned long ctxld_base)
>  	struct dcss_ctxld *ctxld;
>  	int ret;
>  
> -	ctxld = kzalloc(sizeof(*ctxld), GFP_KERNEL);
> +	ctxld = devm_kzalloc(dcss->dev, sizeof(*ctxld), GFP_KERNEL);
>  	if (!ctxld)
>  		return -ENOMEM;
>  
> @@ -217,7 +217,7 @@ int dcss_ctxld_init(struct dcss_dev *dcss, unsigned long ctxld_base)
>  		goto err;
>  	}
>  
> -	ctxld->ctxld_reg = ioremap(ctxld_base, SZ_4K);
> +	ctxld->ctxld_reg = devm_ioremap(dcss->dev, ctxld_base, SZ_4K);
>  	if (!ctxld->ctxld_reg) {
>  		dev_err(dcss->dev, "ctxld: unable to remap ctxld base\n");
>  		ret = -ENOMEM;
> @@ -226,18 +226,14 @@ int dcss_ctxld_init(struct dcss_dev *dcss, unsigned long ctxld_base)
>  
>  	ret = dcss_ctxld_irq_config(ctxld, to_platform_device(dcss->dev));
>  	if (ret)
> -		goto err_irq;
> +		goto err;
>  
>  	dcss_ctxld_hw_cfg(ctxld);
>  
>  	return 0;
>  
> -err_irq:
> -	iounmap(ctxld->ctxld_reg);
> -
>  err:
>  	dcss_ctxld_free_ctx(ctxld);
> -	kfree(ctxld);
>  
>  	return ret;
>  }
> @@ -246,11 +242,7 @@ void dcss_ctxld_exit(struct dcss_ctxld *ctxld)
>  {
>  	free_irq(ctxld->irq, ctxld);
>  
> -	if (ctxld->ctxld_reg)
> -		iounmap(ctxld->ctxld_reg);
> -
>  	dcss_ctxld_free_ctx(ctxld);
> -	kfree(ctxld);
>  }
>  
>  static int dcss_ctxld_enable_locked(struct dcss_ctxld *ctxld)
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
> index d448bf1c205e..597e9b7bd4bf 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
> @@ -109,8 +109,6 @@ static int dcss_submodules_init(struct dcss_dev *dcss)
>  	dcss_ctxld_exit(dcss->ctxld);
>  
>  ctxld_err:
> -	dcss_blkctl_exit(dcss->blkctl);
> -
>  	dcss_clocks_disable(dcss);
>  
>  	return ret;
> @@ -124,7 +122,6 @@ static void dcss_submodules_stop(struct dcss_dev *dcss)
>  	dcss_ss_exit(dcss->ss);
>  	dcss_dtg_exit(dcss->dtg);
>  	dcss_ctxld_exit(dcss->ctxld);
> -	dcss_blkctl_exit(dcss->blkctl);
>  	dcss_clocks_disable(dcss);
>  }
>  
> @@ -190,7 +187,7 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
>  		return ERR_PTR(-EBUSY);
>  	}
>  
> -	dcss = kzalloc(sizeof(*dcss), GFP_KERNEL);
> +	dcss = devm_kzalloc(dev, sizeof(*dcss), GFP_KERNEL);
>  	if (!dcss)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -201,7 +198,7 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
>  	ret = dcss_clks_init(dcss);
>  	if (ret) {
>  		dev_err(dev, "clocks initialization failed\n");
> -		goto err;
> +		return ERR_PTR(ret);
>  	}
>  
>  	dcss->of_port = of_graph_get_port_by_id(dev->of_node, 0);
> @@ -233,9 +230,6 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
>  clks_err:
>  	dcss_clks_release(dcss);
>  
> -err:
> -	kfree(dcss);
> -
>  	return ERR_PTR(ret);
>  }
>  
> @@ -253,8 +247,6 @@ void dcss_dev_destroy(struct dcss_dev *dcss)
>  	dcss_submodules_stop(dcss);
>  
>  	dcss_clks_release(dcss);
> -
> -	kfree(dcss);
>  }
>  
>  static int dcss_dev_suspend(struct device *dev)
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.h b/drivers/gpu/drm/imx/dcss/dcss-dev.h
> index f27b87c09599..b032e873d227 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-dev.h
> +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.h
> @@ -104,7 +104,6 @@ extern const struct dev_pm_ops dcss_dev_pm_ops;
>  /* BLKCTL */
>  int dcss_blkctl_init(struct dcss_dev *dcss, unsigned long blkctl_base);
>  void dcss_blkctl_cfg(struct dcss_blkctl *blkctl);
> -void dcss_blkctl_exit(struct dcss_blkctl *blkctl);
>  
>  /* CTXLD */
>  int dcss_ctxld_init(struct dcss_dev *dcss, unsigned long ctxld_base);
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-dpr.c b/drivers/gpu/drm/imx/dcss/dcss-dpr.c
> index df9dab949bf2..072eb209249f 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-dpr.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-dpr.c
> @@ -135,7 +135,7 @@ static int dcss_dpr_ch_init_all(struct dcss_dpr *dpr, unsigned long dpr_base)
>  
>  		ch->base_ofs = dpr_base + i * 0x1000;
>  
> -		ch->base_reg = ioremap(ch->base_ofs, SZ_4K);
> +		ch->base_reg = devm_ioremap(dpr->dev, ch->base_ofs, SZ_4K);
>  		if (!ch->base_reg) {
>  			dev_err(dpr->dev, "dpr: unable to remap ch %d base\n",
>  				i);
> @@ -155,7 +155,7 @@ int dcss_dpr_init(struct dcss_dev *dcss, unsigned long dpr_base)
>  {
>  	struct dcss_dpr *dpr;
>  
> -	dpr = kzalloc(sizeof(*dpr), GFP_KERNEL);
> +	dpr = devm_kzalloc(dcss->dev, sizeof(*dpr), GFP_KERNEL);
>  	if (!dpr)
>  		return -ENOMEM;
>  
> @@ -164,18 +164,8 @@ int dcss_dpr_init(struct dcss_dev *dcss, unsigned long dpr_base)
>  	dpr->ctxld = dcss->ctxld;
>  	dpr->ctx_id = CTX_SB_HP;
>  
> -	if (dcss_dpr_ch_init_all(dpr, dpr_base)) {
> -		int i;
> -
> -		for (i = 0; i < 3; i++) {
> -			if (dpr->ch[i].base_reg)
> -				iounmap(dpr->ch[i].base_reg);
> -		}
> -
> -		kfree(dpr);
> -
> +	if (dcss_dpr_ch_init_all(dpr, dpr_base))
>  		return -ENOMEM;
> -	}
>  
>  	return 0;
>  }
> @@ -189,12 +179,7 @@ void dcss_dpr_exit(struct dcss_dpr *dpr)
>  		struct dcss_dpr_ch *ch = &dpr->ch[ch_no];
>  
>  		dcss_writel(0, ch->base_reg + DCSS_DPR_SYSTEM_CTRL0);
> -
> -		if (ch->base_reg)
> -			iounmap(ch->base_reg);
>  	}
> -
> -	kfree(dpr);
>  }
>  
>  static u32 dcss_dpr_x_pix_wide_adjust(struct dcss_dpr_ch *ch, u32 pix_wide,
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-drv.c b/drivers/gpu/drm/imx/dcss/dcss-drv.c
> index ad5f29ea8f6a..d881f5a34760 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-drv.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-drv.c
> @@ -51,15 +51,13 @@ static int dcss_drv_platform_probe(struct platform_device *pdev)
>  
>  	of_node_put(remote);
>  
> -	mdrv = kzalloc(sizeof(*mdrv), GFP_KERNEL);
> +	mdrv = devm_kzalloc(dev, sizeof(*mdrv), GFP_KERNEL);
>  	if (!mdrv)
>  		return -ENOMEM;
>  
>  	mdrv->dcss = dcss_dev_create(dev, hdmi_output);
> -	if (IS_ERR(mdrv->dcss)) {
> -		err = PTR_ERR(mdrv->dcss);
> -		goto err;
> -	}
> +	if (IS_ERR(mdrv->dcss))
> +		return PTR_ERR(mdrv->dcss);
>  
>  	dev_set_drvdata(dev, mdrv);
>  
> @@ -75,8 +73,6 @@ static int dcss_drv_platform_probe(struct platform_device *pdev)
>  dcss_shutoff:
>  	dcss_dev_destroy(mdrv->dcss);
>  
> -err:
> -	kfree(mdrv);
>  	return err;
>  }
>  
> @@ -86,8 +82,6 @@ static void dcss_drv_platform_remove(struct platform_device *pdev)
>  
>  	dcss_kms_detach(mdrv->kms);
>  	dcss_dev_destroy(mdrv->dcss);
> -
> -	kfree(mdrv);
>  }
>  
>  static void dcss_drv_platform_shutdown(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-dtg.c b/drivers/gpu/drm/imx/dcss/dcss-dtg.c
> index 30de00540f63..2968f5d5bd41 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-dtg.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-dtg.c
> @@ -152,7 +152,7 @@ int dcss_dtg_init(struct dcss_dev *dcss, unsigned long dtg_base)
>  	int ret = 0;
>  	struct dcss_dtg *dtg;
>  
> -	dtg = kzalloc(sizeof(*dtg), GFP_KERNEL);
> +	dtg = devm_kzalloc(dcss->dev, sizeof(*dtg), GFP_KERNEL);
>  	if (!dtg)
>  		return -ENOMEM;
>  
> @@ -160,11 +160,10 @@ int dcss_dtg_init(struct dcss_dev *dcss, unsigned long dtg_base)
>  	dtg->dev = dcss->dev;
>  	dtg->ctxld = dcss->ctxld;
>  
> -	dtg->base_reg = ioremap(dtg_base, SZ_4K);
> +	dtg->base_reg = devm_ioremap(dtg->dev, dtg_base, SZ_4K);
>  	if (!dtg->base_reg) {
> -		dev_err(dcss->dev, "dtg: unable to remap dtg base\n");
> -		ret = -ENOMEM;
> -		goto err_ioremap;
> +		dev_err(dtg->dev, "dtg: unable to remap dtg base\n");
> +		return -ENOMEM;
>  	}
>  
>  	dtg->base_ofs = dtg_base;
> @@ -175,17 +174,7 @@ int dcss_dtg_init(struct dcss_dev *dcss, unsigned long dtg_base)
>  	dtg->control_status |= OVL_DATA_MODE | BLENDER_VIDEO_ALPHA_SEL |
>  		((dtg->alpha << DEFAULT_FG_ALPHA_POS) & DEFAULT_FG_ALPHA_MASK);
>  
> -	ret = dcss_dtg_irq_config(dtg, to_platform_device(dcss->dev));
> -	if (ret)
> -		goto err_irq;
> -
> -	return 0;
> -
> -err_irq:
> -	iounmap(dtg->base_reg);
> -
> -err_ioremap:
> -	kfree(dtg);
> +	ret = dcss_dtg_irq_config(dtg, to_platform_device(dtg->dev));
>  
>  	return ret;
>  }
> @@ -193,11 +182,6 @@ int dcss_dtg_init(struct dcss_dev *dcss, unsigned long dtg_base)
>  void dcss_dtg_exit(struct dcss_dtg *dtg)
>  {
>  	free_irq(dtg->ctxld_kick_irq, dtg);
> -
> -	if (dtg->base_reg)
> -		iounmap(dtg->base_reg);
> -
> -	kfree(dtg);
>  }
>  
>  void dcss_dtg_sync_set(struct dcss_dtg *dtg, struct videomode *vm)
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-scaler.c b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> index 47852b9dd5ea..825728c356ff 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> @@ -302,7 +302,7 @@ static int dcss_scaler_ch_init_all(struct dcss_scaler *scl,
>  
>  		ch->base_ofs = scaler_base + i * 0x400;
>  
> -		ch->base_reg = ioremap(ch->base_ofs, SZ_4K);
> +		ch->base_reg = devm_ioremap(scl->dev, ch->base_ofs, SZ_4K);
>  		if (!ch->base_reg) {
>  			dev_err(scl->dev, "scaler: unable to remap ch base\n");
>  			return -ENOMEM;
> @@ -318,7 +318,7 @@ int dcss_scaler_init(struct dcss_dev *dcss, unsigned long scaler_base)
>  {
>  	struct dcss_scaler *scaler;
>  
> -	scaler = kzalloc(sizeof(*scaler), GFP_KERNEL);
> +	scaler = devm_kzalloc(dcss->dev, sizeof(*scaler), GFP_KERNEL);
>  	if (!scaler)
>  		return -ENOMEM;
>  
> @@ -327,18 +327,8 @@ int dcss_scaler_init(struct dcss_dev *dcss, unsigned long scaler_base)
>  	scaler->ctxld = dcss->ctxld;
>  	scaler->ctx_id = CTX_SB_HP;
>  
> -	if (dcss_scaler_ch_init_all(scaler, scaler_base)) {
> -		int i;
> -
> -		for (i = 0; i < 3; i++) {
> -			if (scaler->ch[i].base_reg)
> -				iounmap(scaler->ch[i].base_reg);
> -		}
> -
> -		kfree(scaler);
> -
> +	if (dcss_scaler_ch_init_all(scaler, scaler_base))
>  		return -ENOMEM;
> -	}
>  
>  	return 0;
>  }
> @@ -351,12 +341,7 @@ void dcss_scaler_exit(struct dcss_scaler *scl)
>  		struct dcss_scaler_ch *ch = &scl->ch[ch_no];
>  
>  		dcss_writel(0, ch->base_reg + DCSS_SCALER_CTRL);
> -
> -		if (ch->base_reg)
> -			iounmap(ch->base_reg);
>  	}
> -
> -	kfree(scl);
>  }
>  
>  void dcss_scaler_ch_enable(struct dcss_scaler *scl, int ch_num, bool en)
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-ss.c b/drivers/gpu/drm/imx/dcss/dcss-ss.c
> index 8ddf08da911b..0df81866fb7b 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-ss.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-ss.c
> @@ -83,7 +83,7 @@ int dcss_ss_init(struct dcss_dev *dcss, unsigned long ss_base)
>  {
>  	struct dcss_ss *ss;
>  
> -	ss = kzalloc(sizeof(*ss), GFP_KERNEL);
> +	ss = devm_kzalloc(dcss->dev, sizeof(*ss), GFP_KERNEL);
>  	if (!ss)
>  		return -ENOMEM;
>  
> @@ -91,10 +91,9 @@ int dcss_ss_init(struct dcss_dev *dcss, unsigned long ss_base)
>  	ss->dev = dcss->dev;
>  	ss->ctxld = dcss->ctxld;
>  
> -	ss->base_reg = ioremap(ss_base, SZ_4K);
> +	ss->base_reg = devm_ioremap(ss->dev, ss_base, SZ_4K);
>  	if (!ss->base_reg) {
> -		dev_err(dcss->dev, "ss: unable to remap ss base\n");
> -		kfree(ss);
> +		dev_err(ss->dev, "ss: unable to remap ss base\n");
>  		return -ENOMEM;
>  	}
>  
> @@ -108,11 +107,6 @@ void dcss_ss_exit(struct dcss_ss *ss)
>  {
>  	/* stop SS */
>  	dcss_writel(0, ss->base_reg + DCSS_SS_SYS_CTRL);
> -
> -	if (ss->base_reg)
> -		iounmap(ss->base_reg);
> -
> -	kfree(ss);
>  }
>  
>  void dcss_ss_subsam_set(struct dcss_ss *ss)
> -- 
> 2.43.0
> 

