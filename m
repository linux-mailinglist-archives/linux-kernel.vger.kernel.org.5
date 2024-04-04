Return-Path: <linux-kernel+bounces-132048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBF9898F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D081F2B02B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEC46D1AB;
	Thu,  4 Apr 2024 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="owTxKCsu"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2129.outbound.protection.outlook.com [40.107.237.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7FB12D76B;
	Thu,  4 Apr 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259532; cv=fail; b=B+vVwbmLhQFWDUOKhMd7TE8IHhvjHNtzQuKKjlLKtrBfFtExlWAhMcZgnDIy71skfzD8cZxdL9WIrSqR88ow2iEolPUDKBun3C4NyNjBQaNwC6wW5Ue65S3a/S1jT7et+S+KwZII4f3mCKKvpU/YVMqMWQRRuuiMw1o9a23YlF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259532; c=relaxed/simple;
	bh=KR8cAexXFI2fDjuJ3aI8P4sgbI7Kubt8XLxuejUkMP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XhnwEYbkCyd6s8pbSCJfubSeFFa39p2S4cTwc6HdYx7+zWkukc9eLl4p5/1BkbulwwpvpaH/uteq2vIN0KTGITyF0D8f6/T7lqk7J7yyyGaOI2ttmrhZssi2mGETIAbtxrdNBzu1krumAki7xJNO7zMW/A4lKl14wB2U/sD8gzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=owTxKCsu; arc=fail smtp.client-ip=40.107.237.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUh/WjA2WQhpPlxVt0b7VAtHQ9r7SngJgWupQK3Pg35+Nbbb7UWhZJ5skF5PLJbjzRWqcEo0hPtKh3kouJ7u99SSKOS4WjJ/3m75+9cCGl38NsLE7NCxGEFtRxkkKKUlU/FKo8kGsypl7wSvK+cNvCyt/ljPZPSXuNYWvDOp9A2HT5YcMtwbHQF8URJlG9wUuxzhLDO/2b5S1kP09vYRvkkJBujwTTtEZrBQAvL6JSRO6i6khWOZNBWDpWXid4+cKTKifuJRxD8RgJbzGhfjnP5s4gl9Ru/6hihQzNhfheVqdkx/qgXDsiehms474h50bUkcWg1HgaoLgUxDOjQE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/CMUQOFkYNqFGd+JkUulm4Drr4qsPhY7JPV813+JX0=;
 b=Ef9mkGEYhaQKOPYhIYoHjFRDsV6MXVYXp+81mL0SZSMiNFhefhC7FgqszbZ3Jir7xfd9qZsjXVdXZZHY0E/597Ox9zaKvPV7IYgKtCJ3BbAp0V45KOJtd1bwYNFVR77o8oqgi07Th3ac3aFnGSKO4IqcLnf1rgFAvrWumIO+s9cjtjZ+fLWmJ3GIbSU6nLxj6nJECDwQwnVamaD0aP5dZSVtCBtGPJ40GkjBa0VJgTVzyfmvYKM08VhSekC4v3BshGfUhRIE0rtGMi3uGOVPbNtvvi37PtB2VMm22zVY29mmUSW3EDY+Qt4VW4kp3QSanUVbvE5ypwYnIkUiBU5p9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/CMUQOFkYNqFGd+JkUulm4Drr4qsPhY7JPV813+JX0=;
 b=owTxKCsujGpaahPxkVAKu7ko5y9qMoMhwk8F4ncSIuF5QRonTSp+zjhmXtpVQRaQE18thCVYtqB6ci2mqoopAM1RHfqbYd32Z8AzFooY0hvFOPnRssZnoCIsHWJ0cWf2c2oATzHPTdtZeF6+sscePNc6I6Krd9QCTUOTRaJu7ZQ=
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by PH0PR10MB5681.namprd10.prod.outlook.com (2603:10b6:510:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 19:38:41 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::1e22:8892:bfef:6cb6%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 19:38:40 +0000
Date: Thu, 4 Apr 2024 14:38:37 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: ocelot-spi: Use spi_sync_transfer()
Message-ID: <Zg8BvZbrwbi6uzLc@euler>
References: <7af920eb686b719cb7eb39c832e3ad414e0e1e1a.1712258667.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7af920eb686b719cb7eb39c832e3ad414e0e1e1a.1712258667.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: MN2PR17CA0036.namprd17.prod.outlook.com
 (2603:10b6:208:15e::49) To DS0PR10MB6974.namprd10.prod.outlook.com
 (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|PH0PR10MB5681:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OLrzTjgiK9YGft7EJo9bqZXKSQCrWH/YRuJHoy/EH0/djd7swmw+yrCpgZh6H9r48CR+xMq3FkNNhYvIJ1uJwoc54CbJj6wLa64mvadH8JNFRM9V73+uJTPGP4yuHcQlD7nCSMCxRg/Qd8FcWYLfKehFPGz/rYvepBl6O/3TzoG/qeT06eGcn/+fphJz1YY9qKn526r3WAeHgsZqrrymTNL1HhqVA6JZ+G5wtaO/61Nkrb+jEN4x9T+XwvsuxAbvJKaxpaZRi3W/OxED4wAWZgH5mBPV9+Ke3GDCZURA2ParmrkB0UTUqxEpJkiRBtarUMgzOf0c5d+EuxWVYGe3bN7INjGMm8oul9ps8MJMbavIRuV5HnmcEX7JGsh0lWVuDzyyPy0JMHxf+VPJxwAtye8W3Bh9nocvmvztDseMIhm7QXJ+tqLH5y4xMDH+ryF4QVhDYKe2PSoxqIItxLSAvO9y5g9PDSHXIfQgY6Iel5J6r9R/3Vc7Lk4pzKidMxiW2mFq0xTLpKv3MuUvqKnwgZWpgiI2dATu6+ZwA4xSrOk/OGqaKUyp+xZQnp98YcSc3lm9FCkn/LLLVRCcn+/LIMICzp6A+cf+fNiJ7l3dPd/44apb/w6j1r6bO8k83yFnVP7GXFgLQomHOKpuZpdp4XegVbq3rk8CRHpXqi+EBBM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TwwKzI6TdwgmgSkNlHyhd7qC8GsNoU8wJqJ3Y5TQFAz/9hX76HCazF8F54Pz?=
 =?us-ascii?Q?YTtoXoRDXbqwbN8yDf0TV66Bx+IUMlQnYAzzo5OLqKeTytQZBj1D689uWbuy?=
 =?us-ascii?Q?sHg1FBpOt3kGIYIbICFonhkxmvpqh4NKCAueP/CqgOlNcw14dGl2l9ucYNnL?=
 =?us-ascii?Q?gDo94EGnu8SXwq6c4K+O+3AjFWzBI4e60MnV8b3wBOYBezE/vL6qdUlb+yNE?=
 =?us-ascii?Q?83TEf75kfJ+XyS9CKWkmFzcJkwO9yXbF7YdDhY6vxOG1f9zeTxtOpbtJGgjs?=
 =?us-ascii?Q?wuH703tWc2C18y/r4/fE0AjRWxARtZZ2WE5ELU7Bgg1MgJ0apmpoJq3v/M4T?=
 =?us-ascii?Q?86Wv6CMZ5YcGs3DIbY9H5qffSLlUMU0luVIieloEd/9T1hmE8kSNsh9kWdBc?=
 =?us-ascii?Q?RsbwdRtvjwDR07vWOL3Q0uGyccIR+RBj+HXgYWrW34kZfd5uI9uYa9MXT9oJ?=
 =?us-ascii?Q?q2c9oc2e8DKyMD/xg7BBHyYtrBVYCoupC2ec0v01Vu6bkAm0mgfhmpa3AhcW?=
 =?us-ascii?Q?susuAhhlh3GmCzwCaOuLBNW7eVcmQtNX17dgj2XvJup5oV1J14KQb5zHYFf7?=
 =?us-ascii?Q?MbycKnI8U6dr5jHhOSG4AQreKlULyH+tvTCP1pMAzhCAZ5FdcroeU3wmaEO+?=
 =?us-ascii?Q?69puOy4VoZmpcteFWrBf+ryY4c5BmSnS1zG33u1kMAH6/4O3EzJswv6C9x8/?=
 =?us-ascii?Q?ZR0fS/Wionwvz7H7Tb7C/tEsgX6dlm1YzBOqV52olxkxD/Q7kHAEdvThwD9s?=
 =?us-ascii?Q?syOMIZf0jef3fAgrDyx5dTAArb59EnJgWJiE84J05B9Yc6V13B2xk2tdJRZv?=
 =?us-ascii?Q?KZo8EeTAw0D7jh0gcWIHdFf0HTxw6oz+rGc7STx/mMy3OLMInwmV29lG3PG3?=
 =?us-ascii?Q?+1SJ/9z8ODEgaIxdHYwje27F+mMqyb+r++8SJG9CtJsyH5PdsnvpePVlxwX6?=
 =?us-ascii?Q?WTgv39Va8UyB2EXGNadXviqtu9lmzD44FR6jvb6Dl55WjGfZ1ZqObeS/bo7d?=
 =?us-ascii?Q?wdKeOUs3/9m9jIeYeYAPdPZMk4G3T6nWQZrMyoCdileZ1RaXeGtHQFf5x3s5?=
 =?us-ascii?Q?zqPGqT/jYVuXePWaTcpWu2+n7NipFiCo88WSVyM1tqZUIabak6xwvhvwLxG+?=
 =?us-ascii?Q?/8+SFi9AE28ywDW9VmBWKx0IxCTGIer0zSBE+FOpwx9hXy7sDnkE7qJ5MybZ?=
 =?us-ascii?Q?XSPHzj/SVNZP39cqkWmAHnU5CgT3GP/2MWQYGcJnPQ2ismuskbLccISLPtST?=
 =?us-ascii?Q?lsJFh5lRI1wz7mFp3bb3XZjIwJgIjfaYEel8s52NWeQPUU2pF81geUlDh2QY?=
 =?us-ascii?Q?hW+5OZjtMg1XWzq6i657ax646dQBcsXZB8gHP8GEo+mqWOcS0Vwg/hZB+Em5?=
 =?us-ascii?Q?DVzEifrTMu3yrFPcBWLi3GKaIR2oGGonbLDXdfsgQSPsgQ2nOjPYsYwJrVn2?=
 =?us-ascii?Q?u1QOqxNLerLzaOpS36fezZZ0S5hgmT22rkLZpwsV7INJirs4i3enEd1ab7lX?=
 =?us-ascii?Q?dc//Z5S7i2FfVLimFDf13K5LoUR03setpCoPm4+pNU829kzK1DsmzDq1zNbo?=
 =?us-ascii?Q?d8qBFyMcRksPkn16CduRQie7wfFVsVdA53lrlejHJJ33uR+NUxOOSIHHNCb4?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad8fd30-5c13-49ac-edd5-08dc54ded451
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 19:38:40.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jee8yzdzx/iCDNmSLhA4fVlSBl3wjSBH3FQqeofIjE45g0ivPfNu/cmwG97B+w45h8DC9UyrbE5vxlLH68IDXNqEIrhoD2WQIqxc40jQh3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5681

On Thu, Apr 04, 2024 at 09:25:09PM +0200, Christophe JAILLET wrote:
> Use spi_sync_transfer() instead of hand-writing it.
> It is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/mfd/ocelot-spi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/ocelot-spi.c b/drivers/mfd/ocelot-spi.c
> index 94f82677675b..b015c8683f1b 100644
> --- a/drivers/mfd/ocelot-spi.c
> +++ b/drivers/mfd/ocelot-spi.c
> @@ -145,7 +145,6 @@ static int ocelot_spi_regmap_bus_read(void *context, const void *reg, size_t reg
>  	struct device *dev = context;
>  	struct ocelot_ddata *ddata;
>  	struct spi_device *spi;
> -	struct spi_message msg;
>  	unsigned int index = 0;
>  
>  	ddata = dev_get_drvdata(dev);
> @@ -166,9 +165,7 @@ static int ocelot_spi_regmap_bus_read(void *context, const void *reg, size_t reg
>  	xfers[index].len = val_size;
>  	index++;
>  
> -	spi_message_init_with_transfers(&msg, xfers, index);
> -
> -	return spi_sync(spi, &msg);
> +	return spi_sync_transfer(spi, xfers, index);
>  }
>  

Thanks! I am fighting an unrelated SPI regression, so I tested against 6.7

Reviewed-by: Colin Foster <colin.foster@in-advantage.com>
Tested-by: Colin Foster <colin.foster@in-advantage.com>


