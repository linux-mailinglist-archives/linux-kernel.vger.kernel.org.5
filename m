Return-Path: <linux-kernel+bounces-155090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283D58AE531
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FF21F240C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E81350F2;
	Tue, 23 Apr 2024 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VeTkxBpg"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC813473D;
	Tue, 23 Apr 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872675; cv=fail; b=AFmSo/CHWxVKEYIRqp8xyx2yOPPyKyl8yHu1aiD2Cl0+Aro8uE/LPPhbFtTrIgbGcllg1pL75UWe25VeC08tnu1llZWAE9ovQZRrrqFQQrwK5Nf0brvxs3IJw6aS1gzc2+rISnNhRJBGSHlJ6ZUvgmyT3Lf3YTpqzFBCyN5EyA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872675; c=relaxed/simple;
	bh=bvOS/2uuI8i4Knb/EK5dhoU3rWHjh6ro8i424jTH264=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b3VoBmePgyFH0eLbqcsqWaR3PX4DXKyG1GbGY8eHgRbDPaT14cxfHqse1Ni+esiZh7ML+VqaT0VtXv6yhewWgSBXkgdf8LGz0NoKyCJrhytPPkGZpmBvs4ASIvD7jXZnTaMTeYJo4849ONd+x0HvmNMzXkeUjfWff6mNd7bsAl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VeTkxBpg; arc=fail smtp.client-ip=40.107.7.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/v55eF88v8B5ErFY9duNKYyKAzba9nosJB87Fs8HTdvV405uJpBc54Y6XtsAjcLeLO4yHQgL2BoNyJKhMoAqdXSS7woFH40PTRg0AFPpRYqUuUolqO945oJGYlAJpINq1icSA/6exmVe3tPF09qLUhb9cOPVJHdCTetD4mH4vO/hXuePsc5JMJS2Y2KbwxfEBfgv2JtDzJ0xnpRJmQcSlxcqaQmEDuF6/7Gn5OU9owXGDJhmi84OGSlR1RL2jcu+ZfcBzI8kLVYPrAuHbhiAlw4W/4OnoicIbqIlZPNHVDp35i2cXp4HXQoO14KAniHWhpBqwBoVu1IhRQSsVYOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeM1fddYMOV6blfZ9b1Oi2+2cRxRNVFsILlkj1dXi08=;
 b=bmDGsep3y/RF1ao+2NFpw2HsBO1+N/BuMkUOhKiDPcdLWg41+qMQXIfpkKoyaWi/FmDfSaJW95/cKQSbh0SX2WizlNB9IO1p1fJdHVnZRH/VWSWA2ptX9ytUSYdYojOmE66rurOMDAfRO3ogk4ulgINxQkDD7S31nhwf68VNkYmeF0H94WWa68+TF/+g079Rh1Py1C99DvE9vjnZ3fFviS4z0dGmO3+l0aG14lCrXU9NMNvDTmaCUExcFvpixeda3lRdrEPRmDGI53v7m1pw/vSR+LEGHLLE8RmtjpkPLRo2A8L0mXXHNUFzkQyVsYxKa3OxGT899DOasgv1HhOPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeM1fddYMOV6blfZ9b1Oi2+2cRxRNVFsILlkj1dXi08=;
 b=VeTkxBpg4Sq1op3D/CA1/RsDv8LQMd6gzFd+QWqDbPTy8AzZOlU8xeZchlrFLoVF66f+85y9eo/GWy3bMGT0+o/cU4SAUnq+QlGfZUfJYhFDMuTv6I/kkxJsWbuK2K9FivQYCsIkhTsJOwQ5L1clr6aiCnPmYFLBgLHbqsdquiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DBAPR04MB7302.eurprd04.prod.outlook.com (2603:10a6:10:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 11:44:28 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:44:28 +0000
Date: Tue, 23 Apr 2024 19:43:17 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Will Deacon <will@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, mike.leach@linaro.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v10 3/8] perf: imx_perf: let the driver manage the
 counter usage rather the user
Message-ID: <20240423114317.hqb4cm2dzxzbosuy@hippo>
References: <20240415061320.3948707-1-xu.yang_2@nxp.com>
 <20240415061320.3948707-3-xu.yang_2@nxp.com>
 <20240419154913.GA3983@willie-the-truck>
 <ZiK6G3aM+K92lq0w@lizhi-Precision-Tower-5810>
 <20240422165153.GA6223@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422165153.GA6223@willie-the-truck>
X-ClientProxiedBy: SG3P274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::29)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DBAPR04MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: a728fe00-60f2-4e41-cb64-08dc638abb47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?adsXlt+/HBP+U18qZJl4i9NatUb8jBt0fgS8T7ZuCgybgNp0zNJImYuPdQpy?=
 =?us-ascii?Q?VJkTK0uxGeo3S+BqS+MJNTOaTiPaGN3B5+3lnN1Fm5Mdd4XYkifB58id06UG?=
 =?us-ascii?Q?rsF7NiO6Alkd1Qd049vyKjGQVC3nrAdYs7ZzWAJZTlOEKvuDGaqGBtuSV2UD?=
 =?us-ascii?Q?fPN5eGD+B1xw+9Vk3TdlIiT2FA89Nc6ZAEsfw2G27FY8Xw2wj/s1lKjSBlbO?=
 =?us-ascii?Q?diqm2Fudxx7bko9j0eg4RxXIA6QDhXKzRM0k8e2F6Q3F59RxQxNXdvVp6h/M?=
 =?us-ascii?Q?A7Ymy9+FHQjllSfh70C9cStKdF6xdkdWUiO+cGMo8g6cnl8sShntEMmNt2TK?=
 =?us-ascii?Q?7d6HAm20OEGmd3cjh4HKr8qlsSgkSrxXNL7PEiBmAXE/iVtZiZL/QS3yZTM7?=
 =?us-ascii?Q?GGHFYQ7dI8hGkuFsNmKHNKyqzBZfvso4D/H+DEQjuxT0pT8eoF7KTdMfdLJX?=
 =?us-ascii?Q?ox90WH65NhpVZRGGMxtZ6CRJ9jYlTSgTX2PJYYWbDgm9szlcSdNmx/iOjZRN?=
 =?us-ascii?Q?cphVlsGEVUdqsQH0EwBa1dRrQyveO5X2BvovcB2DlOIFwCEX169UE8wDkwC2?=
 =?us-ascii?Q?de5pGTYSGiQvmFAznT2jEKTaFwrr7x6RywJVcU0gNVSjkhwEsE/ZO9tg3jb+?=
 =?us-ascii?Q?FR4Rs50BwUC0WXiIiai2pWN2lOy4aZ9k03DFWEecrVy/9DGb+/pLcAGMNCsC?=
 =?us-ascii?Q?D7FLLvDcEmAF3Vy6uhpcj6/XT71INLbZZGJtOEJRjH+dKP+chGnCvHMHCw/q?=
 =?us-ascii?Q?86HqoMtLkmqdysiqn2++nhtZqy58Ip33ed5CFY8iXt8RtaDjRPHLmHJLF9l6?=
 =?us-ascii?Q?dnUByOnQuS0p9FlO6E/CLQIWGpr+7yNIIaXZ4b2ZpwvKdjRPVJR4QIRXc8rG?=
 =?us-ascii?Q?s33cANFWVT5AI0QMJc6gg9L7yOqa40Ft+3X2KnNOpGvudl0ZnSQw/iGK1w4E?=
 =?us-ascii?Q?PJYcI7Gr0FuYbwf3NrDuIdZixLcA3rW1dJJPyI5a0Wv8tx9YtXulXqFafApv?=
 =?us-ascii?Q?jXIpsoHyOuVchTXZv//BsWjHq44IBcZvQVIri9DAxmyiFFPcOBIpKdPqi7md?=
 =?us-ascii?Q?5xPAH2kyJdbkAuAN0aNkHHNdz8ivkTlJKE/7jUJ3fQLGllsvnF5imr8pwE92?=
 =?us-ascii?Q?hFvjsmJVGXFiR0KW3fzuns19zu/fhvgARwUXF6g054yMxrIN5cAGD2oJZ4/d?=
 =?us-ascii?Q?Dx+c9kPloES7T3fFQa41i3kVz09lDRUxMlhW1G7i+0BCOtVruZRxSmsn8uEJ?=
 =?us-ascii?Q?yMAw/zazj01z3W24KTqD5P6RxmmReHW6eGVeSZ415UaG42LeuPg829GuZcV3?=
 =?us-ascii?Q?sZz9bWD6bz5BHvZROlvGILU/dvDEinAmMWJ/vzhogzzVgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mr+hAiFvRcVfQ3DsY3w1BZ0vIsAbN00kfLdGbs7UlD20/2gt++OzFXj1XPG1?=
 =?us-ascii?Q?RIEpt8xuV+HQ3eHePpFZP3P1szrppI0pmYok16iIwj1RHKr/rTMxzRbiexi8?=
 =?us-ascii?Q?W2SCxeu/DudD7Z6wy1esgsadHPaW/x16tfEvZLweTLmihYelm4NW8i57VYlK?=
 =?us-ascii?Q?RSax8+Y1rOvDhgYaCtQcpXJPvKTvYKexRao6w0x+QRe6j3+pmWHt0593xYWX?=
 =?us-ascii?Q?+xQdxNkWafLSqmppLuTvCMnITVw2KXRexnYBJkveb1OKQGWkqngAZ40FczKT?=
 =?us-ascii?Q?AboFwDtMTpXUP2GY/4M2HyozW42PbYsNh2gXYTJ9jsUZXbcGLVISb9ir+ws7?=
 =?us-ascii?Q?aHTSgShrLl3rM6+vIkmYwJQ+ef4H34Np29vO7L0qQ2Th+3ihven1ZHGEUVTU?=
 =?us-ascii?Q?sgnA78+3osew0fPYBsqgGfJcn1aD1PGc1kporI+mj0C3IYsMb7O0InJeEb7d?=
 =?us-ascii?Q?ZJLNm4jxRXODZOVVy4MxBVL0JaapnTGW2FmHPhJrwXzhTDsz5KLAqUVn7QPr?=
 =?us-ascii?Q?iX+6palmuUJv3x/K+99HpW3dBX0r4c6DOFWEkAdGCO5SQCgxYzV4KhzUTmZU?=
 =?us-ascii?Q?u4AG/EPFiLy8bvlYK7IVhzGa2QmTRUPqs+82pxL3EuGHrfWU8SNeXT8DfKBO?=
 =?us-ascii?Q?kBQq/wUpos0yvpmiRGW/IcwVcwxENYVDrVsgvPK2+uoCuCpiS0kKIhpKCdT6?=
 =?us-ascii?Q?i8sHav4b0PCL75oyzdzYLe810qnN2Z1xeJ54Crd/IOSeA3qWetPk2spDSUUJ?=
 =?us-ascii?Q?TyUTHXH2+/lqUOkfkgTz6PjvyFSBQljHqG+qVLMQu6JpJxfkv3tkWaAuDUuM?=
 =?us-ascii?Q?mSpGYvCR29Kkm9gwmqKsJpqDFl6AFbnafb+tjO5XvYumtZ7ksprEWPvElFbt?=
 =?us-ascii?Q?3Vb+WCx8nQI7P9bwNI96Z9Dpu3CM3jd1LCQJHBJbGROT8Y5F19zDGzDGh7zR?=
 =?us-ascii?Q?PyrXqA2ImMdvMhcLHw7jcIg+11WNfkWACwej4+pt9Fo8q9pNeB9OI5QF0q6f?=
 =?us-ascii?Q?OobbgqQVJSYX7bLkThWhgIFyRe66+915vg/0W/76pS2j7NbrPXkgbg1NecUO?=
 =?us-ascii?Q?rzWotIuBXE2feNWVcpqK68+feiFUC4fbBCT6VTS/8/a8sVOK9eTgut7lbfvv?=
 =?us-ascii?Q?AWVW405mE5ohpTbAmSiDH6SFlaRyjOxJTIQZmy/3ZF7opOOtA11rYtFtqPcx?=
 =?us-ascii?Q?Bgb4lEJvqJZBAa1oz7+fv4tmak1pwkJXSw24rEXCIcKq7KIS9s6vbJDg7YT7?=
 =?us-ascii?Q?dLucJ0TLMRvlmJH4u25EPhpLVW2DV3zpHOZJL7ULqmHI7rGGiSA+3A1amyhQ?=
 =?us-ascii?Q?5Rknrcii9h/5DgTrLIWpNsK7J04l/XwJjOXftIghs0qT6pMK10Ehbe9t1zT4?=
 =?us-ascii?Q?PpD6I7WS3RzCpIN7K+SXJV8D5m3Fx6kTZp7n+7B0hp+OCT/w9IuP6OxK0sCX?=
 =?us-ascii?Q?B43mBMHjyL9I1QTtIySRTaI5cWUIcojxRgmYh3IENeBemJvNYa1KebYCbl/V?=
 =?us-ascii?Q?O5f0OreuZc4iVIdGlCySnzsTcwBP+J+hFsVUGsWLX69118azc68C+JMoZW6t?=
 =?us-ascii?Q?G8b2HprMTOjBWG4VPgMDwrncIrfeG1uo5Th9JgBs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a728fe00-60f2-4e41-cb64-08dc638abb47
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:44:28.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCThwAGa4udlmKtJXqwWEkham4k/UYCdNFQQRqvgOvESl0VI+uhBRcsjfG+9KbpsjnwOMsF+uklhyNnO3+wcww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7302

Hi Will,

On Mon, Apr 22, 2024 at 05:51:53PM +0100, Will Deacon wrote:
> On Fri, Apr 19, 2024 at 02:38:19PM -0400, Frank Li wrote:
> > On Fri, Apr 19, 2024 at 04:49:13PM +0100, Will Deacon wrote:
> > > On Mon, Apr 15, 2024 at 02:13:15PM +0800, Xu Yang wrote:
> > > > In current design, the user of perf app needs to input counter ID to count
> > > > events. However, this is not user-friendly since the user needs to lookup
> > > > the map table to find the counter. Instead of letting the user to input
> > > > the counter, let this driver to manage the counters in this patch.
> > > > 
> > > > This will be implemented by:
> > > >  1. allocate counter 0 for cycle event.
> > > >  2. find unused counter from 1-10 for reference events.
> > > >  3. allocate specific counter for counter-specific events.
> > > > 
> > > > In this patch, counter attr will be kept for back-compatible but all the
> > > > value passed down by counter=<n> will be ignored. To mark counter-specific
> > > > events, counter ID will be encoded into perf_pmu_events_attr.id.
> > > > 
> > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > > 
> > > > ---
> > > > Changes in v6:
> > > >  - new patch
> > > > Changes in v7:
> > > >  - no changes
> > > > Changes in v8:
> > > >  - add Rb tag
> > > > Changes in v9:
> > > >  - keep 'counter' attr for back-compatible
> > > > Changes in v10:
> > > >  - add some explanation about 'counter' attr in commit message
> > > > ---
> > > >  drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
> > > >  1 file changed, 100 insertions(+), 68 deletions(-)
> > > 
> > > [...]
> > > 
> > > > @@ -245,8 +249,8 @@ static const struct attribute_group ddr_perf_events_attr_group = {
> > > >  	.attrs = ddr_perf_events_attrs,
> > > >  };
> > > >  
> > > > -PMU_FORMAT_ATTR(event, "config:0-7");
> > > > -PMU_FORMAT_ATTR(counter, "config:8-15");
> > > > +PMU_FORMAT_ATTR(event, "config:0-15");
> > > > +PMU_FORMAT_ATTR(counter, "config:16-23");
> > > 
> > > Although these mappings are advertised in sysfs, I don't think we can
> > > change them because userspace could be relying on them. I also can't
> > > find any examples of other PMU drivers in the kernel changing these
> > > mappings after being merged, so please keep tthem the same.
> > > 
> > > If you need to expand the properties to be 16-bit, then you'll need to
> > > split them into 2x8-bit fields.
> > 
> > I just see tools/perf/tests/pmu.c: { "krava01", "config:0-1,62-63\n", }
> > So I supposed "config:" supported below format
> > 
> > PMU_FORMAT_ATTR(event, "config:0-7,16-19");
> > 
> > I just want to confim with you because I have not found other perf driver
> > using such format yet.
> 
> Oh, wow, that's new syntax for me too! Does the perf tool parse it
> properly? (and what happens if an older tool sees the new syntax?)

I've tried the new syntax with different perf version (kernel 6.x, 5.x
and 4.x), all the perf tool can parse it properly. Then I'll use this
syntax for my patchset in next version.

Thanks,
Xu Yang

>
> Will



