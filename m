Return-Path: <linux-kernel+bounces-151878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD94A8AB524
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BE61C211A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B1212D76F;
	Fri, 19 Apr 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g/ridY8u"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5C13C909;
	Fri, 19 Apr 2024 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551915; cv=fail; b=HEF3DUGRAFWt4/ODTnsRPblltxrYB/dot4t2clPYWMx3WHa+onoD14HwW5TqKMdnr8FLQEfrW7AgPLE1Mf5CS/TeDNb3wBrOa7FJJwEcjxlO8iX0IbPQXS2aNnJSBFCGrbUThu/bKWPGxsfnL6ZuSFyaZ0AkGLcfPHrZOw/DmiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551915; c=relaxed/simple;
	bh=HRjgMCDM4ga+ViVPQn7/kzgBs3O1Pc9TQtPgLvEhRp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PtOtVwlzefQnu49T8LzqxQMO7q/8sLwxfmTSuzEfAjQ7Hqxr8NyEGPMqqm4tsN8Bvvd91wL+DScHUnjHgP/0OTc6v4871Xbj8dq3PES/Pf6z53h2SU2EWDJobliK1SGJldCW66/D5Fq7TkWBa5k9ndUCVBC7mDOrXzx/vQ/fDRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g/ridY8u; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+oucWl/Ifl2MNAcKwtDajtlns+pXBDKJ29hate6lUk8bn9uaQS5hObrhR8fqaOryUP7TO8TauMwxH+FJOC/uod0iuzV9QEpZfvumqxZfkqHKCgu9u1Rjy1l6xqI3bg3ms3Qtdufgd2YxkjoGIBggcGxYvLhJlF/J/VfTdCMbfkeVay/OvMl2EzsyCOnCFVLxxiLNKLPfqf+/PdQDWWaKzkibbOYB6Wyl6k0gcbFGeYlnqfcihY02tukbuzCQMMQnttN8eXW+JRNYukphgoiA/QoAhKNwSiSmou82lee87YCdPTvqxiaPG473rRVoipsah8y0u7R+FHgUDRUj/UqHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/2UhnmaK3y6QZh0QO8hueIS6EiXDjLHTN3CgRa62uA=;
 b=g8SF74B3gWcWtGKn5BI0gk7fVSvt8+q+LWmR7pQ3QRAiQiCyUF+gtKREZsuHKmCEL7mwQoh0gh0Z9lonOD9Ek2rH4D/fvmUprOmegkWj2xtU/JRVPusElv1MdDot2VwmmrXEBky+4tXjNiA9Zvlqmh0lCdjsQzzNp8rBS4Fhc2I0rumu4eet9DP0H+JVs6upivL4iMGod8VvinNBzQqHkppS5PXh+Jdif7IQxgzbvseS69LS6ZZWHMPcsNjxAZIcxZiNgdeAuuorvXjTfs4ttzEYfq5EQrZ7Tefkg+sPBAu6jDMkiF0dAQj5cPZZSbVKJwXKJWC/J7xSwjLYqsEFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/2UhnmaK3y6QZh0QO8hueIS6EiXDjLHTN3CgRa62uA=;
 b=g/ridY8u+VwtYFBn5qisM49VQ/MwLdtpuIeGtuOhf18vvCAvkjbYmuu4hYzUhSVh3ceQuM+DuvEuAZL+7YIA2UuAS11BD0+9VpJ3a+FGMp2Eg4sdqAduFREXW2F9wRxaduLxk+dlNDcXJCiBD8TU7D6CYZwRycn+lkv7NWCBDcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7127.eurprd04.prod.outlook.com (2603:10a6:20b:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 18:38:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 18:38:29 +0000
Date: Fri, 19 Apr 2024 14:38:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: Will Deacon <will@kernel.org>
Cc: Xu Yang <xu.yang_2@nxp.com>, mark.rutland@arm.com, robh+dt@kernel.org,
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
Message-ID: <ZiK6G3aM+K92lq0w@lizhi-Precision-Tower-5810>
References: <20240415061320.3948707-1-xu.yang_2@nxp.com>
 <20240415061320.3948707-3-xu.yang_2@nxp.com>
 <20240419154913.GA3983@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419154913.GA3983@willie-the-truck>
X-ClientProxiedBy: SJ0PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8e2442-e847-4381-72b4-08dc609fe854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gZmbppELz9Zw/QQJuqpNlwiltLPKjdiuF6KdZCrb8PndNoq3OiU2SLiDcYaF?=
 =?us-ascii?Q?ajHuuVE+68NEAW/BnFlmHLsRcKH9fMCZyxeGzS4fe+cWsyHZgo6R/dfnthG5?=
 =?us-ascii?Q?U7NbmasIVP0A2VP/U2dy8BbLhEn9YI9ewjcEeFFgTgLSAdnaCOeXDscbo3Zg?=
 =?us-ascii?Q?2zRAm6Is3zJXc0xcWkwknMy1RAAahMZzlXnlUXyCYlufwKArMQ6sf2l0rndz?=
 =?us-ascii?Q?8o+0l7EaMcT7oAD1AtHT4okzmIeEHZP5xnP5s4JZ2SY2b96uerClnIH5bKHl?=
 =?us-ascii?Q?R8NAvd1fN8CIdUpDGzZYtIH7r/sfQ9Jbf9ttm2h+54w/kCxVSN0O4qgWMvfS?=
 =?us-ascii?Q?zmLZTnHGVmVCixbxX8w+6yYAL9cV/Y7btptEiSaWXiLcbDVpO3rq0Pg5DGz1?=
 =?us-ascii?Q?78GbScspkAbDkRXwyJgQGQjH6s3KmXXa0giQZ3SgU50tyYRdUxdH7OsqaebG?=
 =?us-ascii?Q?kT6dVaMEmhvduz9L9s6K27fTcyzhRsIqqNPztwJ+HyxaexA6qR7PVbH73RTt?=
 =?us-ascii?Q?m1Pj8lCqBW97UDDIDwn4Rd0QHGIaiTvig1I5QoUvgepbR/LaumCTibw+NRoP?=
 =?us-ascii?Q?k/NtPXKpG67yy4fyUE7h9V6K3GDhpSfk+3YmeqOKhxDW753+vDAd3Ne5GnBC?=
 =?us-ascii?Q?ItP7lhToRyrDY5bXfXeRDnVUcDeTyABhTLepA+yNWNdvzZ+jfs2+EyEfXfAX?=
 =?us-ascii?Q?M8sD4DYgvHkAnBEKeGA7TwcTw7RKg6VWk5cUg234P3Lmj7xXSyrApjVQd8jM?=
 =?us-ascii?Q?J23eRbH4N/Pz4Ljzj60no2JwxU6snShzTHXCoFadSOaUlBrpqwIA6llsloNX?=
 =?us-ascii?Q?tO4bzLmcsupV4vCAT6uSs4lm6rofKJop2usR41NcBurXslbk1B34kM/qNA4x?=
 =?us-ascii?Q?6Xr30WdU1n2avy3aHY+aa5zEWjHunGFLdHDMl7JItDwkyINHIpaH2Qq/dGhn?=
 =?us-ascii?Q?rV+KYpi5mFXhNb4t9kB577+nWjOdmTFImv/5f0ibg2z/ddvb+U6wHUruXAAw?=
 =?us-ascii?Q?r23eB2CxDkFKHxKB3PDznB667mXkes8NOERKpIlN35EKVSGq2/Oy+qFY9LCq?=
 =?us-ascii?Q?W/eUizWojd2Xwq3bTeIOyPsu62xDRE6RR0WQT5yK+LIrc7VAYtVnB398sRKX?=
 =?us-ascii?Q?M8QUVbp2LLStYWRlO1AKuc7kiLntNEVnn5eFyeKPmkWN2f0IFoCzQC/6RduV?=
 =?us-ascii?Q?hQqU5sfVRFOxWiLomQg/kJhpoisE9cnRb4/LKtB5P2Njx/G5yTpNDstO6jQV?=
 =?us-ascii?Q?tAuTANvHVWzvRT7xcVJLs5AG6jSQFpgPRZ4/qwfq/aNEmKgj5z38sK4xRuwV?=
 =?us-ascii?Q?/k8F85lDuxErscmCLRmgY2NRZZvb8O4eozLTax7DfiQafg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aeEilhOQ8um4mv1MsN5dEZk6rv+FsR1y7lrYi40FARa2If9nW858eZmDZdvK?=
 =?us-ascii?Q?2/X6gNcF+8S+XVviXsXh9bdzgm97Y0Xz98C4JpSo5PyEOIIhNgkOIFBqZyld?=
 =?us-ascii?Q?PizMaE1X3JFBcAd3p8oBy0caz+vW4lurgDUph+WDOyjdQDDweGlD1ipYcdMu?=
 =?us-ascii?Q?JbpdoHtHlBI5gCQ/ZTG6v0GIs8o0iBkg6yft3tHMVJe2Nl5GxDiYEpJLgL2k?=
 =?us-ascii?Q?RS5TuxWwBJmQOod5vRSlV8AB6mRbweSJ6FQ/Q9crBUmYjVwIFx+qSPuS9tT8?=
 =?us-ascii?Q?CzDb+e+H+Vs+XVRieAAR3bqXIm7ALceFtMCgLR8+oLgBZ4wfTpzAZZRLzvJn?=
 =?us-ascii?Q?hQYk0g7yPsjmdx/DLBKaxYwRG2CPxQ4tpD8QtDm+rGtuI1LV0FYIJ7It8vDD?=
 =?us-ascii?Q?ACR/hXQcHwqbsoYnsMVhiLQeuRFcVLDPQcisphqujP8YBLPui80xsJcJ4y7i?=
 =?us-ascii?Q?usN0Pe6kWSdqxdRbQr2eOfF9NoEuw5gvjFOUnAnSuWM/OkjR77sJ6SNTokz0?=
 =?us-ascii?Q?fo4j0H0F7qwvy2uHjtROaSBt23JHbemHq8C6EWoJNxCE9NNOODTeWI5Z49Cf?=
 =?us-ascii?Q?ImgeftpSnBep77T3C5Ga9FnPVEmcuzG72dMOYdDmC6pCk7kntmLTXekKaoNn?=
 =?us-ascii?Q?9d+dvE8ZiBWvIBNHZAPxXjc7UAj2ijnStel4AS97Kex8dJyR472/IWwvtxQQ?=
 =?us-ascii?Q?AlNcOTTuZk95BALs5Uj7CpuslUdEV+qnW0GG2KJgZhl8SUnfJHhs+J+Lkq2r?=
 =?us-ascii?Q?pEthvWSDYGeGKfmDkwK6zvgTlcaoFjuJAMZ5uesC+wNbyxAN7PwVu0RZ8Sny?=
 =?us-ascii?Q?mzLus8m//uNSFiWiuDb9SQcC1QTE4mkOpks9Vbw6cGX1AnW6dm4vRbi5qbP8?=
 =?us-ascii?Q?fuShjyBb00m3d5nWuRSyBesSGPomO7LBBNe9rtxxO/u3ut/Cs5G3nxF8+9yu?=
 =?us-ascii?Q?qwkVqKvGj3IB6WjL2bmUGqkaqAI6fPwYZ5MtGq7f7/nnp/YDMfzLkgCSgGit?=
 =?us-ascii?Q?9ojlQ+ZyyritiPVAMVSww44mApFFMuFiW1xdaa0FujhsIYekhNS89E2mxD66?=
 =?us-ascii?Q?bRu8kqKGcLPBYl+XlXK/Dam96xcnMqIY7M745i08S4KIYL4N3+nWmbeY7yrd?=
 =?us-ascii?Q?Bww6TnmP6R3V1gbzFehFHwnAQAhyV9u5OKVR9Bmxf6txCZBnkU5edNYkRwpT?=
 =?us-ascii?Q?YGDwk9nXeOHFQ2JUJ7Kbjx/YPcph84/T7ryNUx4Gp/N04CUvnjTZSZUZB0Az?=
 =?us-ascii?Q?8hBgU9L6UjI6Y+PtgaIr4DaMCw/MerqXUdL33qavmi9zDYq8pYpyXMUni4Es?=
 =?us-ascii?Q?YUiBJLHoGwxfKldL9t70XGqxSBtjgy5p67AReIoNydvMW9xLT1FeKTTy6e66?=
 =?us-ascii?Q?gOYsCxQtVSOtUypRFtSH02/oDGDrdZLw+xlNI2TeIjYyIMOY6nB6iIG+UuGr?=
 =?us-ascii?Q?Ii45fEgasd8Fb3viNzhIPzAqsMuMpsJAPtiQP2Ay63hP+rCGZGrjmmIqMdAt?=
 =?us-ascii?Q?KFFP1TahrPS4q/o3gWIjg058UXffzDZr5BHffWAFMS6fQwqbfMo83drr8mkU?=
 =?us-ascii?Q?NC3S0n6ysttMx//VrCxNmkxaX73s5HGo/3a2tcif?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8e2442-e847-4381-72b4-08dc609fe854
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:38:29.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMi5nErwqjmukm+ZdiGYjvMyJKYB4ZuQn/8nersTKFyDZ32lASiBHecLWoeC13jj9bQxf8pVH7hPSIO+i6eEHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7127

On Fri, Apr 19, 2024 at 04:49:13PM +0100, Will Deacon wrote:
> On Mon, Apr 15, 2024 at 02:13:15PM +0800, Xu Yang wrote:
> > In current design, the user of perf app needs to input counter ID to count
> > events. However, this is not user-friendly since the user needs to lookup
> > the map table to find the counter. Instead of letting the user to input
> > the counter, let this driver to manage the counters in this patch.
> > 
> > This will be implemented by:
> >  1. allocate counter 0 for cycle event.
> >  2. find unused counter from 1-10 for reference events.
> >  3. allocate specific counter for counter-specific events.
> > 
> > In this patch, counter attr will be kept for back-compatible but all the
> > value passed down by counter=<n> will be ignored. To mark counter-specific
> > events, counter ID will be encoded into perf_pmu_events_attr.id.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > 
> > ---
> > Changes in v6:
> >  - new patch
> > Changes in v7:
> >  - no changes
> > Changes in v8:
> >  - add Rb tag
> > Changes in v9:
> >  - keep 'counter' attr for back-compatible
> > Changes in v10:
> >  - add some explanation about 'counter' attr in commit message
> > ---
> >  drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
> >  1 file changed, 100 insertions(+), 68 deletions(-)
> 
> [...]
> 
> > @@ -245,8 +249,8 @@ static const struct attribute_group ddr_perf_events_attr_group = {
> >  	.attrs = ddr_perf_events_attrs,
> >  };
> >  
> > -PMU_FORMAT_ATTR(event, "config:0-7");
> > -PMU_FORMAT_ATTR(counter, "config:8-15");
> > +PMU_FORMAT_ATTR(event, "config:0-15");
> > +PMU_FORMAT_ATTR(counter, "config:16-23");
> 
> Although these mappings are advertised in sysfs, I don't think we can
> change them because userspace could be relying on them. I also can't
> find any examples of other PMU drivers in the kernel changing these
> mappings after being merged, so please keep tthem the same.
> 
> If you need to expand the properties to be 16-bit, then you'll need to
> split them into 2x8-bit fields.

I just see tools/perf/tests/pmu.c: { "krava01", "config:0-1,62-63\n", }
So I supposed "config:" supported below format

PMU_FORMAT_ATTR(event, "config:0-7,16-19");

I just want to confim with you because I have not found other perf driver
using such format yet.

Frank

> 
> Will

