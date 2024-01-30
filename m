Return-Path: <linux-kernel+bounces-44569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B0F842452
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD82F1F24746
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B767A08;
	Tue, 30 Jan 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pNB6zqQD"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95906679E6;
	Tue, 30 Jan 2024 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616224; cv=fail; b=DVlY3RhFjDsUp4pZmbcBztCHCvYhmh6VexLFdUD27/zvbt4TdrVg4x0iNIhTKS69HF+TZRJLv7ayikGWSKmxVOSB6Cf8SZBayV7LlWQL2L2/M7LciUvSOy9qVOOZtG150+KF4PnrK/r4AFsAFcHxC5qg5y0uLhKzMO0r0ODChcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616224; c=relaxed/simple;
	bh=FuOi/uHNMbsjbvfzjatKjpO66f3pYMe8zeeg4sRT1Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EG9wd5FGvBnZVcg8g9bdD4xt2ENRL2Sw8CF+zX4HIiX1LW/L3WVi1jqNO/cwPsJlnQIrEAq9W1bB8C6V9tOnylO7HDkaL1TrTDH/1PmkRnUhWyXg/nbrg1zfF+GO2ILyBCtOu9KHDZmUj6jnEnVlVJFZebHM2v+XnvJHCRugjoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pNB6zqQD; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBJ2APzzG6W1kddyh6S3i3baPOm8zeH+akkc6WopfdA53LaYhhy08DexryGq4HDTa+YlfeYVA5gEuJjgdt1GDkJGqjNgJvSR4icYmV+CTgzcUM+HsUFF640b0DKEThMV8oFiX5r91f7gnY8UcqLo1K3l0XE/gt/W1M2cuAVRvUz8fCllVRzrmwkqIwFwvqaIduyW/t8rbcgap0Dy4oAneuh7nyW+3xLCnQAXZqLbG4Bd4llfwaIDYGQj6zeGSFavx9kjc+U5M+YCWc0QZFFHxtYpi8gWFjMHUWnuDhRvbGLapCKC3WCYm67MBLbVC012nPhDkVDOCvesLTWpGk1n5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwaoW742bVEOeuLDDUae5bKhjvL65eFUacQEXadq7wU=;
 b=AHNcfVgum3rYujJoIGe6IbR3/J77+VfJPKRpUng7EOIdbKuo3xj8HnM3wqqEuy3uU+TQXhFjJ5LEUBmoiww1vM4aCrjfpjcHj8Daj1ZnGf851nmpgMEEZjMBzQQLHhKM7sh8QoOvBNTxSfWnHbhrnEkOEqsbnvPwSfGZ1KEYmR3+/eW3QHauk2Jokbp1v4067FKoQV2UQ+ap/g4gTgBPH8qNigXctu1aLYzV4D25Tbd52ANYMs5XZqNQEaVftfKNtmwzGzM/tn6rWpjL6QHO9MD9tAmR9n8f0gWH7L0lF+LvlsnUHk2ZwNciuc4dBnQ+09pJUutriXH4g4VlEPlKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwaoW742bVEOeuLDDUae5bKhjvL65eFUacQEXadq7wU=;
 b=pNB6zqQDLmaMLigSx+kwZqlV4JUCqZ3LuMsjSKtC5ph5sCiwXZ9rL5mvcesKZrdi6nlMAwuOdTQshXmUA8CL5hzBM6cuOLQgCyrS/Uq+qPi5NV3YJ4c65legrYMEtocOHBDhPUhxIvD4T/e/89qAeYyG9s3sRCjAmyJJJ2sT0MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBAPR04MB7368.eurprd04.prod.outlook.com (2603:10a6:10:1ad::19)
 by AS8PR04MB8294.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 12:03:32 +0000
Received: from DBAPR04MB7368.eurprd04.prod.outlook.com
 ([fe80::5795:6dd5:bf:6ca9]) by DBAPR04MB7368.eurprd04.prod.outlook.com
 ([fe80::5795:6dd5:bf:6ca9%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 12:03:32 +0000
Date: Tue, 30 Jan 2024 14:03:28 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Simon Horman <horms@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, dsahern@kernel.org, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH net 02/10] net: fill in MODULE_DESCRIPTION()s for ocelot
Message-ID: <20240130120328.rmmbgeywvj6jvqkm@skbuf>
References: <20240125193420.533604-1-leitao@debian.org>
 <20240125193420.533604-3-leitao@debian.org>
 <20240130101134.GG349047@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130101134.GG349047@kernel.org>
X-ClientProxiedBy: VI1P194CA0036.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::25) To DBAPR04MB7368.eurprd04.prod.outlook.com
 (2603:10a6:10:1ad::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7368:EE_|AS8PR04MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: b3891d5f-cd9e-4a76-4bc4-08dc218b7a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h3g4NVWLUYwqkb4U32n7MW9ihHRzla9ICYuSfpdLxeqXbTHE7gtZuB/RFvZs6I37VGDsvDQit3S3rUMFzin1zN/RxfG0NVetuETnPZe+zEw3dpttl6BlOzHRxHQXvLVg40eP5K5WleHinwpAYAUVtuDNWBrMSGKZf6BTisSWdwwvWO3DNHlditX8J5+ELLkgt/Vu6A/Gr1LP02JZEFtxGBnIgg6dxp4j1H1xolYdqfbaATDf0d3q6okQTGu9yreRM4bqePFIAJNeDUEAKguhoGs9PFiscaaPWsDUWR9TNMpx8LcS2+awapku+s7ZZhIW+njWUtTWsvpT8JqASJr75iIowKHLHMPZZUsbs6vdIH8scH14U6CJ3+RiJmCHhBtqcjhb4VjFslvuipwrkkPnGl0J9YZeRV+mZBv10OHKJSm/c5fh+Q6PTcxtj3+XrXMFUr/GMcIiyoQ6K44KcN2fZL5OnxWHO0z2c+8ssgfapqPuVD6ZgkVGWVQfR/zu7Kr6VcCrhk/nPlxUsIueA5RqVuk4l3v2WAVPPv9XwBnXFn/Z1mymRU3FvFKgoKXgP7dC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7368.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(376002)(366004)(136003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66476007)(41300700001)(6506007)(9686003)(6512007)(1076003)(26005)(4326008)(6916009)(8676002)(316002)(54906003)(66556008)(478600001)(6666004)(6486002)(8936002)(38100700002)(66946007)(33716001)(7416002)(2906002)(5660300002)(44832011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?br4hfnNYn+wOC+emar7wSKajtRiRyKi2OW24Uva95G737pR1Xvq+/MJALBXt?=
 =?us-ascii?Q?9dHHfV9so9K9sJWwpB2piwNZy9s+ChVmRVoEepASHuhXqcetuTafY5afX+Za?=
 =?us-ascii?Q?GE/9MXJ5RbBbs2LLvfa4kxuDhBvRygHS5qtA0lpq9uUHi+Kvv22EO7rPUvQE?=
 =?us-ascii?Q?gq01+0EdyvDb+twUpb7YtCZhfJx9j2PNM3Bp5ZXVBLOJfyJCw/R8wN2tAfye?=
 =?us-ascii?Q?20lAKGFiwgmucVX9K2agV4n4zCCcOMowLlDH97sCAOMeugzoBJlm/D4oZTMG?=
 =?us-ascii?Q?uSwrD4EhtAOD9dafeqtNYmYRrXj7/USrjqbsq1w1oKdbhb1QQlJI8nTLuQ6Q?=
 =?us-ascii?Q?pUW4oMQmpcRJQqFvqwE87nEP/i51NRaLSBBxZHmTjMYwQpTY75NIo35dKi7T?=
 =?us-ascii?Q?Oo2YLSxcMZzqfbf+4jRjGA94zTGh/xgJL/SfZq1dp2cEvRwAToA1nvOwzKyu?=
 =?us-ascii?Q?YkY9avWAoSdfSXPMD/C8OZ9eUb8Zz4d/2nySx1kfJYCpzxIiDQfYye4UoHCY?=
 =?us-ascii?Q?BCJENjRIxCpb7P9UBPTlFHNz0K/AeTz3LJFYpnbqhngyjnQ3Wlc441QsdJpL?=
 =?us-ascii?Q?P9mnz+0oDyPoD0lg1nagRWFvwx60MxptJFJxEDtsUHcgQeNf7TCKDtigake+?=
 =?us-ascii?Q?wXHoGobSIoa4tvRv3pMjFYu+DTHSnBHETITS1JXSFO8N2gJ82itnA5Z2rBSN?=
 =?us-ascii?Q?fqS5MgatmFOO7+wdMJuRH9MtdJiJAQDGzCH/Pro0MY/xM+qSh6YgaiQw2jqJ?=
 =?us-ascii?Q?3UYYBRPbHUiAaG4WT8yriSHTTHTFhlt/gj+hnQOSo/LkXFXbOuQD4fxj1p/0?=
 =?us-ascii?Q?vRTCWj5wd6mtTgt4DQZAaLKZGA0Y+ZnzNJFw5OwZEJE3vTp2QNkYpRyWtiCr?=
 =?us-ascii?Q?lvDhC+socgRnXqjAbD1UPdprRXlyuuw3oziX9e+OOqLBXSH9cc4BHYwrppmP?=
 =?us-ascii?Q?2jxA/XPn8cUFMGn1H+9P3rgi2IBdrPu7yWm+qQky1HJY0lLFqU7zyvNngYNf?=
 =?us-ascii?Q?NefGFIUHMOiEKt5qwi2jKx2xMzIS0mKQ+RF5M9IRC+58cwadHGusrLDZDxsr?=
 =?us-ascii?Q?yBWbZzSFmWrqoW66KKvFu+Yo3qVgvVhGi+nfMw9bFNwlCOrymIoy5BxsrD/g?=
 =?us-ascii?Q?wNYqZl3LdGcEJAGLzAhKPziASD5f0O39gUOtHwOgNps79K3gr4lJSUA3Id9p?=
 =?us-ascii?Q?CM2fLDUkGnd/oM2r1qGdNa0glskIv2CpvpV6bGVD4mRqo3Hz1wZhqTyQTgz8?=
 =?us-ascii?Q?NqQhyatBZC1RDBz/iWtZbYvy4VELvCefQ90XNpuS594Uv/7QZBVtnRzJ4H/f?=
 =?us-ascii?Q?VlwY2b70qgoMJu9A5T6uIC0GXva28/HBI6ewnPgHF83xnthtTgjcw+JcrY5c?=
 =?us-ascii?Q?5zR6uHC2YeIRfdfg9dTzRTis6cFgYNXupP9yFv2pquoCp9uA7g6cjv0B726P?=
 =?us-ascii?Q?UlUVTy8dHo+2Indf9bX+inj4+0gj8t7+LJURdkrbVJldAW4ky7cr3ckYqCaX?=
 =?us-ascii?Q?ZwFccn69NHpOIfUuZyTpzOfG7aUf5OxhIH7o2ShZNvl74QKs3adVwweWNs1E?=
 =?us-ascii?Q?XnD/Rgnq4zNIpjLv+kVcnrGdcIcTaypU3B7355geR7MDMKu1lCdutQrH/RbC?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3891d5f-cd9e-4a76-4bc4-08dc218b7a84
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7368.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:03:32.0858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMP3qYoYvp0dVUdOFlL5LUGtmLqH4/NNYlSPduEvesnMfiQnsiwKConHPx0EvERE3C8lJld91dTAx4nttMGdAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8294

On Tue, Jan 30, 2024 at 10:11:34AM +0000, Simon Horman wrote:
> On Thu, Jan 25, 2024 at 11:34:12AM -0800, Breno Leitao wrote:
> > W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> > Add descriptions to the Ocelot SoCs (VSC7514) helpers driver.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  drivers/net/ethernet/mscc/ocelot.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> > index 56ccbd4c37fe..2194f2a7ab27 100644
> > --- a/drivers/net/ethernet/mscc/ocelot.c
> > +++ b/drivers/net/ethernet/mscc/ocelot.c
> > @@ -3078,4 +3078,5 @@ void ocelot_deinit_port(struct ocelot *ocelot, int port)
> >  }
> >  EXPORT_SYMBOL(ocelot_deinit_port);
> >  
> > +MODULE_DESCRIPTION("Microsemi Ocelot (VSC7514) Switch driver");
> 
> Hi Breno,
> 
> I really appreciate your work in this area.
> 
> WRT this patch, I could well be wrong, but I think this code is also used
> by Felix (VSC9959). If so the description might want tweaking.
> 
> Vladimir, can you shed some light on this?

Thanks for pointing this out, Simon, you are correct. This would be better:

MODULE_DESCRIPTION("Microsemi Ocelot switch family library");

Also, the commit prefix for this driver should be "net: mscc: ocelot:
fill in MODULE_DESCRIPTION()".

