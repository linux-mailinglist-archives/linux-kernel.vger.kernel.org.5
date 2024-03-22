Return-Path: <linux-kernel+bounces-110991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A459D8866BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301EE1F24505
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E8E4409;
	Fri, 22 Mar 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F5tItSMD"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE365CB0;
	Fri, 22 Mar 2024 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089015; cv=fail; b=PW10r5X+KB0NuFlAKuaFtCFiVh+XBODsjOiAwfAnOuVvotW3UP/SMBnpdqOksN1k2GbFbvf4iKVPLiBNM8Tn22vV1H1cWv1z/w9Wcl2ay4GFueD+QFd2LnO4YFkxjkzLKX8IEYG4n/JXwpTwjixuAe9ZQOzrgl11/2M6kdUvmgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089015; c=relaxed/simple;
	bh=WHXrvNRLNXcCaiG7t6+p/+YH+CoHMikV/iqnzAdJCzI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PiXDcMkxyBmgi3qr9eBMhAQWNxWcjEEUSNh+Ck9jX0xPgORv8DWyIq3ShfU/tHllJ6bORkMTUuWnl9gwuvJ3dglqArYMHl1dMWsL8jetGx2jhR3IhLCqPVHd80RZGLGIs7q0QowT4K1Keo83RFG6uIJOGSoS0K0uk+I4PldfTeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F5tItSMD; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaLUIg1IqGk2f692yHTpOPHJedmt63gfz03A1U3Pal5PwGttdRf2lhIotkrw9dADqahAhS+MkloL0T4iBTQxoztSWdl5q4B0LLvJSXXclEhZdvV9HBlRMtYcm4nMbD9YHMlgffGztfl5jhueH9J3FpbU398KvufKinym+/1/L+akBR3Itt6RrVcN2kHhV0BIbiw2JkQy/C17v/0ZwZKE0JlsIsDzckCqMVd1p2dqUtU9/Qo4uYVGk3Hqvqj7ve0mokT4ikFY5KOaf4fnPM3XM8cCUKhA1RfB7wKkwM1JsL2ukjkIM1j8ECzAXVsGrct3tz2Ndv4esru0q+v96ZhGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsaMFMsD2ULf9elaV6U8AsyNyP66DWWKrVo3n6tzV/Y=;
 b=jSRULb4dsI+KlMY68aOToCvVguVWdMv3By37FCVN+MMjLG2mDETc+MtQVbpib/iswfmU4mMD9/VknxZ9Ylknnh8fhZLyT52XzfJEHyNShEhuT1iQtyCXCbNYH/CjkI4blBcxdJQonUPNR8llpgIcw/92jglWSvG/C+LxevehcdzbONfdiAB1d4Doke5IulFnD85F706+yBpuuSqwiLupxzRID6TD+hL1s1ISLZPkjIwKEpTEunStPsg4LNdDCVcKjatCu7Zs0pom1Ce3iPPbpyMvfvAj2hNy/xOv6jcA2liycJkIR0J5zm3HPz+kdslX77sURoC4HoSGWVTMPL6AXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsaMFMsD2ULf9elaV6U8AsyNyP66DWWKrVo3n6tzV/Y=;
 b=F5tItSMDo+7yYiRvPrfNwGiWObOn+fls76U9M3kKLy8vdn6/FCurP5UyYWiylYJZuVsKjlY+lJtfLnc/VkxEBsGC67nUtJd5P3O7+g+3kQ8hWAUUQRpKpEsIHdeySjWAe+GlqkVoon7VT18IJs9ZSClWwM6+MSx734CeElNR1Ak=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.34; Fri, 22 Mar 2024 06:30:12 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 06:30:12 +0000
From: "Meng, Li (Jassmine)" <Li.Meng@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "rafael.j.wysocki@intel.com"
	<rafael.j.wysocki@intel.com>, "Limonciello, Mario"
	<Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>, "Huang, Ray"
	<Ray.Huang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Shimmer"
	<Shimmer.Huang@amd.com>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, "Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 1/8] cpufreq: amd-pstate: Document *_limit_* fields in
 struct amd_cpudata
Thread-Topic: [PATCH v9 1/8] cpufreq: amd-pstate: Document *_limit_* fields in
 struct amd_cpudata
Thread-Index: AQHaedeIF0P8qpgvRkaCefGu5Oh+brFDUQUw
Date: Fri, 22 Mar 2024 06:30:12 +0000
Message-ID:
 <DM4PR12MB63512DD9463BF057F03B7E8EF7312@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <cover.1710836407.git.perry.yuan@amd.com>
 <4b00dae2cc2ed3146a747a7fc72438972c689dca.1710836407.git.perry.yuan@amd.com>
In-Reply-To:
 <4b00dae2cc2ed3146a747a7fc72438972c689dca.1710836407.git.perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1f34902c-0e5a-4e22-9d93-4bfe882bab84;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-22T06:29:54Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|DM4PR12MB6061:EE_
x-ms-office365-filtering-correlation-id: 75fed6ab-7123-4493-8b5b-08dc4a398726
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6XzcelcEM4ftqBhN4k81/2kKJZwHwKovU/KJ/05JPCqwMgxcV7BDK1P5yEwp5Dz/wrvpE/uDBLusyhnedJ6nhGsIzWKUNKcU5GO64Ph0vkux4QqH1lfGvL7jC9/ylqoCRVhHQKmMWi+UBMXsgwqRVljizAaFgHW4WWDKipzkf9/G//qQdi2kt+hDdIH7cUmV4fUhWh4B6Dlt42sOFfbgCr55mT/2O3ZY9e6OqOecGWP5JSS8cm+f2iY4ifqURnWceE/zB90waCupzaMTxq2ObR/K2wbXKvWbHY4Q2O+/nTizH2pTQf30hxtvpjhjmnnDnNCEoCOYIQmkCrUn0DNur4AyRO8vRu1E/beYbRBp3Q7FB4LAE/rmgJpTbb6HSuciIqDnKR9l1cCbMpb3uLM6TRZKJ2PTlh0FYWGB3uOvQffMRRSwjF0oQQOJBoH3A120F8/bzt7AJGduhlTVfOmuNnpa5jpsrRxXz2WTMn2HvZN0zxDRRuP+1o0JIqG65xLN+pCMnnPvkj7m9ewhRkVpwEskVUMVMxtp6Ad2f2w2iNzdQ3HBDzvdnUxLOyJ8zSFlP8fw02pp/7UnuwRCBtRw6Q64xRpVS/gsBpmgggl2/vD6J6h0Q5fyE5IZng/k0nR2LyAxAAO4lSFEnOKXbU1VY5qAHVAVPjX782IRlwt6UEb5A4+vY9QIZ0m406M+vWftbTGm2tSjPCuctF37R8ADxfdTZgmFBlVRrFf1q9TUVZI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BVR45ctO7Cob/PKMP6NMlGDe18SBP0t8CFg+w5/+MrwZvf5F6YU3rrtl0rv+?=
 =?us-ascii?Q?uANLC9Y7+BOqorY2yC2Tlr57DBeL9a4vwPwQ1S0DpOImB0Q91VEBL/pKQ1f6?=
 =?us-ascii?Q?HUTZNCmwGGFlb5UZcCnvWETFqGp5FrWR2ELdG8XB11m90w0kCyrmj87OmnlZ?=
 =?us-ascii?Q?5B76XozEMetRYe7KtLFRsQuEDzTX30Msu/YHU+bVY6RtTu/3yZxAjQA1D0XW?=
 =?us-ascii?Q?WEZ6LPLRHni4tudSKH38WamQEK3xgBk0LwD0/YUERCIJ1c2blC4HnDOA2RXg?=
 =?us-ascii?Q?PEQWYnnmhUKZ8fw62ytQr4aHGxNSTwXYcmP8tcqsLK+B0QFX32mR/ZLaXAIw?=
 =?us-ascii?Q?5S/BLm1nGuaQsRd6JfLvSQvWH2R6WMXscMegbSFj22ngwZ0CxjwPIcbFO6hq?=
 =?us-ascii?Q?JoZ8U8rixwtFEAtau6l64EJilogxoB0agMOJIoI6niSidCQiEkU9qxh/KgKj?=
 =?us-ascii?Q?I1Gms9iFLxQmX3xya70T0FxV2OgqGUxtZBazDIGhYpcUTlBwfiKa9tpjGud9?=
 =?us-ascii?Q?nJwv2Z/c2Wo8VotowEh5b3O/vsC5CWQLCkyXVAXMyHIVxGYEy7Py9BjoG4uN?=
 =?us-ascii?Q?C9jsFQfaMGEzATrI2djjrTVpTwgG1qweS2N1g3e1mSxDnZFMN5DEYXu2Zryt?=
 =?us-ascii?Q?IFoYEs2smU+fajBsHr2RYN8w+7LHyzdy+DJhi1h9Tb5iNDH6rfltEj66X4HP?=
 =?us-ascii?Q?0b74HK3Fxc6XPYt6jIsxYza666rLnc1Xmt+4txiFiFEdYdAEM/Dijx8F4qkv?=
 =?us-ascii?Q?bwBMiUhcGTwLqselHQ09JEuSo9dp85+qEu0OS69ETkrPHcjQXkrNSc3vLHTK?=
 =?us-ascii?Q?pW1vaDa4Ngv2WaM4+wOdL7Wv8rT7aUCjicWxZNpAM2wcgr4jgd9SogW5Xw8T?=
 =?us-ascii?Q?B3yyEIO3lwJ4TDkWlu1rsAAenm0niMNh/sO/+F4fKSY92iBNtJvcuhIjxhji?=
 =?us-ascii?Q?F5k3kcD1n9XN6kanWNwDSOmADnh3LTTqWrAV1bPfv8q1IkN6bVtTalsy/mG/?=
 =?us-ascii?Q?wEIMd5d1rX4PnK2nZSM6XzJIK/991Fq245TOO1iw8RgjifHmZMBD7L13RDXY?=
 =?us-ascii?Q?Xl6KBckA02ZSJqi4MFZLQPyH5cUdJwIgkuKd0Y6pLb8fMg0eJNa0xWAWnqw5?=
 =?us-ascii?Q?5AAx7bWTnjVAv4C3tBcecRH7NE+UoV5tuMNdZ0IzlYB7WbdQfqmbcYXTpFZn?=
 =?us-ascii?Q?391dAXKGtM31KGXCaXvcHwYznFwDq+DIdYNjhh5U+Gcc05L6nDhyOZTmoN/6?=
 =?us-ascii?Q?4c2hbJ3yHOkl1lHo9Iq/eggs+qbHU2UjAgSgJK+TcvPTMCdhrNbZ408geMfc?=
 =?us-ascii?Q?n6QItRG+Fxp6xtOGFYB7S+TUMHHZGiFFyAB8Mswz47WWS0iI8+n2XdlQsC4n?=
 =?us-ascii?Q?8bZ6+dkStRib0PHnYULM+JMOvuzZf9IXeEBiugPgwNz2gX6Mncpz6T0NewX6?=
 =?us-ascii?Q?udJV/1DnrnnCNKO2AtSzQRHbUOyFuBhXgDdClmnkdHVwDA/Vyo819jpZrQY0?=
 =?us-ascii?Q?ByzHuvRaKhJkqq/zu0UquppiwmJYXtRebzDgwFtC3Qi+af6cLVafIsYfPpmR?=
 =?us-ascii?Q?ZrBZFBUkiKEKx9ya40Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fed6ab-7123-4493-8b5b-08dc4a398726
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 06:30:12.0626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zOAQqGN/ghTUJCAvTiugaGZyiwLWBii9VakqF5uQMeHdq6BpH2NxYB1ckZtXGWfwnnSl7oZJ0y8QDIqdgc97iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061

[AMD Official Use Only - General]

> -----Original Message-----
> From: Yuan, Perry <Perry.Yuan@amd.com>
> Sent: Tuesday, March 19, 2024 4:29 PM
> To: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Shenoy, Gautham
> Ranjal <gautham.shenoy@amd.com>; Petkov, Borislav
> <Borislav.Petkov@amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; oleksandr@natalenko.name; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v9 1/8] cpufreq: amd-pstate: Document *_limit_* fields in
> struct amd_cpudata
>
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
>
> The four fields of struct cpudata namely min_limit_perf, max_limit_perf,
> min_limit_freq, max_limit_freq introduced in the commit
> febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and
> scaling_max_freq update") are currently undocumented
>
> Add comments describing these fields
>
> Fixes: febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and
> scaling_max_freq update")
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  include/linux/amd-pstate.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h inde=
x
> d21838835abd..212f377d615b 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -49,6 +49,10 @@ struct amd_aperf_mperf {
>   * @lowest_perf: the absolute lowest performance level of the processor
>   * @prefcore_ranking: the preferred core ranking, the higher value indic=
ates
> a higher
>   *             priority.
> + * @min_limit_perf: Cached value of the perf corresponding to
> + policy->min
> + * @max_limit_perf: Cached value of the perf corresponding to
> + policy->max
> + * @min_limit_freq: Cached value of policy->min
> + * @max_limit_freq: Cached value of policy->max
>   * @max_freq: the frequency that mapped to highest_perf
>   * @min_freq: the frequency that mapped to lowest_perf
>   * @nominal_freq: the frequency that mapped to nominal_perf
> --
> 2.34.1
[Meng, Li (Jassmine)]
Reviewed-by: Li Meng < li.meng@amd.com>

