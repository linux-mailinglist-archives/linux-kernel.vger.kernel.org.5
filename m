Return-Path: <linux-kernel+bounces-116441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43937889E71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9892A66CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E8E12EBD3;
	Mon, 25 Mar 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gi52Qiak"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A1158D6F;
	Mon, 25 Mar 2024 02:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711334714; cv=fail; b=RLY9Fcr+Aaos+vsPdAS+Z80u0eXgFNAoT5qn2vhPAeEOYbflLmsiQTShXUx/fiy0iH+7iYc5IxktEHib7QCt4oMF/YSB7ySaPh7KCo6CofCfmd+b6RNUs/IfPG0mON36yLRXt09BlUb1btdh2VpHhKFfI3apcifpEsqqF1P6oeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711334714; c=relaxed/simple;
	bh=NwH2O43t/snPvttdpiRHWCDdXMclWeFpxDL6Pg1vlOM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6lCXD5lEMySRatLlw6GzASfexT+E3Lk3FUeghjCl9eA84UlHvSNyqwfPiWfDDCel+l2KNZZvXo1gmc86stCwwJTYtWXwXjzsUMTjULLP5NKaVvsxWM/NAqhcgsJ09lK3nVPpCQXSL0KZu1Mz76aB8g247kzsZnF0jmlTHMf3hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gi52Qiak; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVdVGnjCmm6UMhiY+f6HhGhvIdN+2Yl9cC/pfrz1HtHtf/ueIU89FwdD9+vtJK8J7WLZEGWOhLd7Le+S/B2WV2ZB/zY/FhmX64Rgd8CWe5CYZeqyrJN1WwBzXUD+myHmnfCeON3F/R0FyTrIy+WVk0Xbn7E8eDYHLNc8kck5moVBrxYkd2oVKNfxzDnkgeQjdi6tJWqsl/HHFbqiqhImWoipzGNCUGPr/qiOiQF3xt2gTSgDv2DUzjH05C15UKiakXyaBk3nRoxZzGw8EBhcnnDNHM5jc+AeoP748kNaANV3DvM2a+4CI56gEQFeNE4WpGWDJoIfmSzwHo5o4awoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flMclZhDAGIH2wQzRHQcJMrRUvLUrjncOiqByEc0Zx4=;
 b=Mex94stF/jkVGVuYQdqCkwy6Eg4+gqU7tf/RJKFcYxF5uYtcidlbJTuc37v7b1CEomI9BvldkfZr0fYx0Xmf24uuOkj8x5koKmrMTeHdxgsM+2wM6Xwb6KKUISeDCvd2CR1m3nwZQ79gEizLySRlDb4nBPA++YvqvMKo8y5Bt8rvBtOuvalPf62O3i0abqsw94t2e4kAML8QV9Z1bjVHAlyzsfgTaw7ItXLXtqBUM1R0S/FkEkyCruT2NonQaqOXIuSNJgYXE35Y0U8xjERW4bYRDWDhl4UzO6jHzv9duwNqjn7n9tYfFUmhTsJ6NKLzMCkpluweO9cOE+aVynsKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flMclZhDAGIH2wQzRHQcJMrRUvLUrjncOiqByEc0Zx4=;
 b=gi52QiakFtX6lETZPexqZNMrlZbAPRSHyDK+ZIjcWmUqiRpSdO67h21ofRkTkM37oFFick8Icu3gJgMYn7iQ7MudMp1lwXyjCgq3r52VCGZpcfhSTY4t4Ryf/bjaO958ehR2gfZg2u97xUfEbyQ4hDpu4aGCYJGFq38lhedtzQM=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA1PR12MB6848.namprd12.prod.outlook.com (2603:10b6:806:25f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 02:45:05 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 02:45:05 +0000
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
Subject: RE: [PATCH v9 3/8] cpufreq: amd-pstate: Unify computation of
 {max,min,nominal,lowest_nonlinear}_freq
Thread-Topic: [PATCH v9 3/8] cpufreq: amd-pstate: Unify computation of
 {max,min,nominal,lowest_nonlinear}_freq
Thread-Index: AQHaedeL/Hxpmwm2r0WP6cjAfni8wbFHySVg
Date: Mon, 25 Mar 2024 02:45:05 +0000
Message-ID:
 <DM4PR12MB6351C2321B5CC581B158ADBFF7362@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <cover.1710836407.git.perry.yuan@amd.com>
 <a30932a44090a025c73ea0fc81fe0d998e9b6dae.1710836407.git.perry.yuan@amd.com>
In-Reply-To:
 <a30932a44090a025c73ea0fc81fe0d998e9b6dae.1710836407.git.perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=22d420be-691d-4716-b468-9d08038866f4;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-25T02:44:53Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|SA1PR12MB6848:EE_
x-ms-office365-filtering-correlation-id: 2041b0a5-26d4-4215-cd99-08dc4c7593a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NMcOspEQKtOEV/PfzmdS3zpOJh/Aagt0/ZxVD/tNG/42DbSiiUgFjv1VcQyQI/9yElxiYHCDr3P37JbJPIOpW5IrXjE6LDNdiZ4QTjqwQm3aX//a7P4IQO9THv6E77TPqHSHUDbA0+75VMFAS+/ggg394kwYMEL3jYIRRde13jne7OZ5LrUymNdl/oXSX/G/OhBEAnh/7x7rAphq4P+6z7em4IEwkxfFLaAxtJLJHDd5E/LNQoUMpYSHsFVLqPe4IlXBBZb9KwX95bm14pYGuBLyXap5oz/8fFKc+n98UoyACKR9P9cvdZCRiwsL6Bq1QfvwWgJnGzgMPZZLcMJ+vPBvxzfvALnPHNvcVsjGjHM2LpNZj3gI53UUMRqcOgLk9cUuB104+TxEij2leyaKBXtUYXALJmT9JcvhJahPErkGld9icrjFtWsWIuZwCmVS6vvSuIenw9XnKApeM4ZnO/uk9kFmZ7MLWhcecdtGxkapWNKDsiRN+Hdq8sncGKzGW1tjx/Zw+bKS+PWlmuB3wDmxeC5lSlYisiQxyA8TjoljN5raTfNncl9NjynVgYcM1svwamHTnrkGfDkHh+6zlS1CDMEUUQY8Cj3gRsGRwrK7vc9WX5nG0n0diK6jBLFE0XLqebUTcnAmlGdXRLiJuV29u2A98cTu+/8yfe9ydORiEk24dpq0/zwT90q+R2aaLJomPjx1jJpGemkYK6Mvx6WXwaolGqDhkD0epIiurd4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wbDkUfj4f3zljmXl1DsNhz6S6tC/vi8zqlR0eOIJGPMmtYILb4tDZOio6pRF?=
 =?us-ascii?Q?oeWY/7MFqcWZOdDaK0jSG07z7/sI/lXebxBZcF31oJLZoXU8RAQnWz/phspC?=
 =?us-ascii?Q?nFn0J3KpR0LR0m7BomJ9HP6iO+xQBTtGLq6UNXMBdks+7r+L9wDpFFEaghXr?=
 =?us-ascii?Q?uNSVYCNWjlBQxRTdMTIOHDzQoupxtf02cwg5xVvKIvU8iQjqlOtvk7bVefOz?=
 =?us-ascii?Q?DHudhmg1dCOt8Y/S8Vwzqa94eU1tvpL7UArYyNc3McEQJ63g//Tk2s2qTZ3Y?=
 =?us-ascii?Q?c7riclZDIUIraaJIY53hSBOR24UrdhguWZyzMcuzCgdlt7b+Z0llfgfgVfO2?=
 =?us-ascii?Q?MWx95qauuggjQinSesnselIuOhL/wpJQ5KxlqUTB16SdShBLBbXC0PlgFICQ?=
 =?us-ascii?Q?Ym843uTPlKFAIt/6Z9yhJevvPciKlS9IkiIx1UHYU6H5gIRmqHHvFIeCKp/i?=
 =?us-ascii?Q?wNfGuoUwWOqqT75WgnwxSwy9XkIzmxs1rZTr3o07tj0qVe3BcYf2A4v60xsT?=
 =?us-ascii?Q?eJIMIHxpDpQjXj2kAWEzYrYtw3O4bSHpJfmeXCRr0oqfmCVZw/UOCfKvkhN0?=
 =?us-ascii?Q?QKrsH0nAXcG6k0+heyxsJe+uyQIJDS1InmQ8vWhp/DSFgLaGe3VC75N55Ys2?=
 =?us-ascii?Q?uaf45SnqHcYBFCPrd8UeqBkYXAyDXJJIONHbGz36ZzyNvPnIXHkuA+qsJ9TQ?=
 =?us-ascii?Q?v1Bpq/XrXr/MJ1SQUMZVoO0AHvuq9wN4vGsszK3Sm5VQqCLOoOqYRX6PNXRg?=
 =?us-ascii?Q?4GAk5HoKQh0FuDIGi6Is8hRygG4TQ+5Zv6iUCNVFJH/1HbD7hQqm3VMSoWko?=
 =?us-ascii?Q?Jq3CkJ39xQ1Y/Jp3fHejaiWU/WPKhcVzCafjrSadWpgJzGHPg7/OEMB8ANT8?=
 =?us-ascii?Q?g7Sxmp/awbW4u1sjPfdACV8yp37LFkHmq0JAM0CazJZ2Rq50milYz7SY79uv?=
 =?us-ascii?Q?eCSu9bcpkkvFH5lf0ypYo4ayuaJTP+pPjjysYG09hC8WuL6+q8LWML0qaECm?=
 =?us-ascii?Q?/fmP5vYoWQAO+MQDD1pi5lZIaro4Lbbyu0e+owBKz2SGHYiKtZMdH7PC2Xnq?=
 =?us-ascii?Q?PHfRw+UcYqmzSCXS/qslFIB71bJt/zlC0GWsRULhRq9iuLHd7qltTG90cykZ?=
 =?us-ascii?Q?PAKgb4TKytsxsCEs3EAoLJPlK0vAIdx03JA8aS5t2SQ+0WTD57+soX4A3OQB?=
 =?us-ascii?Q?2pNRlbWLNYxmfAshS8gSQWjALz74ByCqtItzOqcHSNhcBx7fxUtu3TWQzA1L?=
 =?us-ascii?Q?quRsDJTv4HB1gXUQ+xeZlH/Yc4+5MctquRbsIa5FA3FEu05eq89fhBA8j5JT?=
 =?us-ascii?Q?zq9JxdGmxqTZyGFoNSX3flkMJ/ZFjf88l5cHpEpacrOxVs+J71HGLpai0Cu+?=
 =?us-ascii?Q?wsBBVsMwftgtMLHV/0DnkitOwu2xfi5E956tau5qSHeO+GK0c+Uj6LiOYUeb?=
 =?us-ascii?Q?TQYk0V5iR9TvAIFByxrZjf/IFBf3n+3W2f7qtbeF/gEjidg/7M1gN+0sbk+k?=
 =?us-ascii?Q?a7ktFFroN5fgRknhovIt3QReDrLZcqG4rkaNWarDKqxQiS8NfEuU23Vc05TI?=
 =?us-ascii?Q?WyO+5p9+CVLHBLdhQlA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2041b0a5-26d4-4215-cd99-08dc4c7593a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 02:45:05.1438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4D8JTe87FgosjC2YR7Pq/1BAstGm7RI5vACkW+0pOIUd4oUcHuCMHYQ58T+FyEmdHQ3PqeRdevBskJH4lr3f0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848

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
> Subject: [PATCH v9 3/8] cpufreq: amd-pstate: Unify computation of
> {max,min,nominal,lowest_nonlinear}_freq
>
> Currently the amd_get_{min, max, nominal, lowest_nonlinear}_freq()
> helpers computes the values of min_freq, max_freq, nominal_freq and
> lowest_nominal_freq respectively afresh from cppc_get_perf_caps(). This i=
s
> not necessary as there are fields in cpudata to cache these values.
>
> To simplify this, add a single helper function named
> amd_pstate_init_freq() which computes all these frequencies at once, and
> caches it in cpudata.
>
> Use the cached values everywhere else in the code.
>
> Co-developed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 126 ++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 2015c9fcc3c9..ba1baa6733e6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -606,74 +606,22 @@ static void amd_pstate_adjust_perf(unsigned int
> cpu,
>
>  static int amd_get_min_freq(struct amd_cpudata *cpudata)  {
> -     struct cppc_perf_caps cppc_perf;
> -
> -     int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -     if (ret)
> -             return ret;
> -
> -     /* Switch to khz */
> -     return cppc_perf.lowest_freq * 1000;
> +     return READ_ONCE(cpudata->min_freq);
>  }
>
>  static int amd_get_max_freq(struct amd_cpudata *cpudata)  {
> -     struct cppc_perf_caps cppc_perf;
> -     u32 max_perf, max_freq, nominal_freq, nominal_perf;
> -     u64 boost_ratio;
> -
> -     int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -     if (ret)
> -             return ret;
> -
> -     nominal_freq =3D cppc_perf.nominal_freq;
> -     nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> -     max_perf =3D READ_ONCE(cpudata->highest_perf);
> -
> -     boost_ratio =3D div_u64(max_perf << SCHED_CAPACITY_SHIFT,
> -                           nominal_perf);
> -
> -     max_freq =3D nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
> -
> -     /* Switch to khz */
> -     return max_freq * 1000;
> +     return READ_ONCE(cpudata->max_freq);
>  }
>
>  static int amd_get_nominal_freq(struct amd_cpudata *cpudata)  {
> -     struct cppc_perf_caps cppc_perf;
> -
> -     int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -     if (ret)
> -             return ret;
> -
> -     /* Switch to khz */
> -     return cppc_perf.nominal_freq * 1000;
> +     return READ_ONCE(cpudata->nominal_freq);
>  }
>
>  static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)  {
> -     struct cppc_perf_caps cppc_perf;
> -     u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
> -         nominal_freq, nominal_perf;
> -     u64 lowest_nonlinear_ratio;
> -
> -     int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> -     if (ret)
> -             return ret;
> -
> -     nominal_freq =3D cppc_perf.nominal_freq;
> -     nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> -
> -     lowest_nonlinear_perf =3D cppc_perf.lowest_nonlinear_perf;
> -
> -     lowest_nonlinear_ratio =3D div_u64(lowest_nonlinear_perf <<
> SCHED_CAPACITY_SHIFT,
> -                                      nominal_perf);
> -
> -     lowest_nonlinear_freq =3D nominal_freq * lowest_nonlinear_ratio >>
> SCHED_CAPACITY_SHIFT;
> -
> -     /* Switch to khz */
> -     return lowest_nonlinear_freq * 1000;
> +     return READ_ONCE(cpudata->lowest_nonlinear_freq);
>  }
>
>  static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state=
)
> @@ -828,6 +776,53 @@ static void amd_pstate_update_limits(unsigned int
> cpu)
>       mutex_unlock(&amd_pstate_driver_lock);
>  }
>
> +/**
> + * amd_pstate_init_freq: Initialize the max_freq, min_freq,
> + *                       nominal_freq and lowest_nonlinear_freq for
> + *                       the @cpudata object.
> + *
> + *  Requires: highest_perf, lowest_perf, nominal_perf and
> + *            lowest_nonlinear_perf members of @cpudata to be
> + *            initialized.
> + *
> + *  Returns 0 on success, non-zero value on failure.
> + */
> +static int amd_pstate_init_freq(struct amd_cpudata *cpudata) {
> +     int ret;
> +     u32 min_freq;
> +     u32 highest_perf, max_freq;
> +     u32 nominal_perf, nominal_freq;
> +     u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> +     u32 boost_ratio, lowest_nonlinear_ratio;
> +     struct cppc_perf_caps cppc_perf;
> +
> +
> +     ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> +     if (ret)
> +             return ret;
> +
> +     min_freq =3D cppc_perf.lowest_freq * 1000;
> +     nominal_freq =3D cppc_perf.nominal_freq * 1000;
> +     nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> +
> +     highest_perf =3D READ_ONCE(cpudata->highest_perf);
> +     boost_ratio =3D div_u64(highest_perf << SCHED_CAPACITY_SHIFT,
> nominal_perf);
> +     max_freq =3D nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
> +
> +     lowest_nonlinear_perf =3D READ_ONCE(cpudata-
> >lowest_nonlinear_perf);
> +     lowest_nonlinear_ratio =3D div_u64(lowest_nonlinear_perf <<
> SCHED_CAPACITY_SHIFT,
> +                                      nominal_perf);
> +     lowest_nonlinear_freq =3D nominal_freq * lowest_nonlinear_ratio >>
> +SCHED_CAPACITY_SHIFT;
> +
> +     WRITE_ONCE(cpudata->min_freq, min_freq);
> +     WRITE_ONCE(cpudata->lowest_nonlinear_freq,
> lowest_nonlinear_freq);
> +     WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
> +     WRITE_ONCE(cpudata->max_freq, max_freq);
> +
> +     return 0;
> +}
> +
>  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)  {
>       int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@ -855,6 +850,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy
> *policy)
>       if (ret)
>               goto free_cpudata1;
>
> +     ret =3D amd_pstate_init_freq(cpudata);
> +     if (ret)
> +             goto free_cpudata1;
> +
>       min_freq =3D amd_get_min_freq(cpudata);
>       max_freq =3D amd_get_max_freq(cpudata);
>       nominal_freq =3D amd_get_nominal_freq(cpudata); @@ -896,13
> +895,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>               goto free_cpudata2;
>       }
>
> -     /* Initial processor data capability frequencies */
> -     cpudata->max_freq =3D max_freq;
> -     cpudata->min_freq =3D min_freq;
>       cpudata->max_limit_freq =3D max_freq;
>       cpudata->min_limit_freq =3D min_freq;
> -     cpudata->nominal_freq =3D nominal_freq;
> -     cpudata->lowest_nonlinear_freq =3D lowest_nonlinear_freq;
>
>       policy->driver_data =3D cpudata;
>
> @@ -1317,6 +1311,10 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
>       if (ret)
>               goto free_cpudata1;
>
> +     ret =3D amd_pstate_init_freq(cpudata);
> +     if (ret)
> +             goto free_cpudata1;
> +
>       min_freq =3D amd_get_min_freq(cpudata);
>       max_freq =3D amd_get_max_freq(cpudata);
>       nominal_freq =3D amd_get_nominal_freq(cpudata); @@ -1333,12
> +1331,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy
> *policy)
>       /* It will be updated by governor */
>       policy->cur =3D policy->cpuinfo.min_freq;
>
> -     /* Initial processor data capability frequencies */
> -     cpudata->max_freq =3D max_freq;
> -     cpudata->min_freq =3D min_freq;
> -     cpudata->nominal_freq =3D nominal_freq;
> -     cpudata->lowest_nonlinear_freq =3D lowest_nonlinear_freq;
> -
>       policy->driver_data =3D cpudata;
>
>       cpudata->epp_cached =3D amd_pstate_get_epp(cpudata, 0);
> --
> 2.34.1
[Meng, Li (Jassmine)]
Reviewed-by: Li Meng < li.meng@amd.com>


