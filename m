Return-Path: <linux-kernel+bounces-111009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775FC8866EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C80228638E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11851DDB6;
	Fri, 22 Mar 2024 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cgc8HtaT"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA1E79F5;
	Fri, 22 Mar 2024 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711089678; cv=fail; b=MPNcufAJr3k2PipYsb51GBZsmYwpkSWbrLqOdhvww2dntnCBALq0XUnwoUuDwnqcR6/G4mAER13XOrYZeHZluXFw8Z7gWz9UkQzVitOvSHSg1bj+ikajchUH1iU9StyukynmYBjuZbreAYhBu6jBbC9wcfH6eQ9fQ+Z+NtCh5+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711089678; c=relaxed/simple;
	bh=Yc7h0u8bxuod+thD6sbwHLVc/FlkSVGj8mHK36Ct0m8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tt8XR2JE2S/UKabic6U6xJpEW1G8hMeG1O6yg26IvgGaYQt638oO30Ld3bFJtZOEYCASSEU83oprYEnlrBdqexmv5ITh5va28nsXhMoTaRB/aoB50G2LyBbDOpxpaZQlt4E+estSf2iQxle94LocvZS5lHt9T3cvXtdC5msKURo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cgc8HtaT; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiqdazvLvXq3DVjwiE0OMUI2CdK9XVYZ+MZ+1Jtn+g7XmiFXL82RxgN21lC1uFmqu4kKfcMna/Fxb6EzaZC3PIDMEGoN5ukIi+I/ezBrGlLH1m5zAhPph0EBadZm5LGrIuO7uZ7E5ezMSv6/xKc/mtQu3AhSvy+cdpKI3Wtr9d3yZQONOwVQ+44MvUdncQ8glxVsm6I4fab0vggtqVpRBQadtUXgdcc2CDfuqPkq0w8e0WZFfK9hkJ0GR9NqpBbonYp/Z7fOtBMEcSTU6UbDclV/lx3A8KShi+y6jbh4O4cnltugBhwQR8/TWxtg/FFSrz0quI1/e90i2FJAfNnyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5AwUdVXmOFVxbPPv0kpF4h8BTTzbkxTf/coFfJ/tNo=;
 b=m4TsAeWFCfbjjHCkhzud5c0eAptYJX/r2i1vMbUu3/lZ0nOIdABZ2Kc00zXpJqnbAJKfU1j87Oi7wCd5xmTfmuhVbvUPKS1v0sKPHEyqbTpe/HPUf6Xpp3R6tuqDO5S3CMhORxuTMNnaMUeGuHy4F4zqZa8IgFsQ3JWgQLd+Tdik+k+QZpOY8FYUzyx2MQKR7WxyftSvj1c/aZThTAGuU59GyWGH2vPhQLuSf9NnpHFwBAqw6QKNE2G8VSUJirLSG+kuHgoHK11UmklD7NmhdAcdEAnsHmjqIOWchhLVfkHe6w6P2WirbGdeJUTuLH5gQyidJUQnQ6RFy620K0ZN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5AwUdVXmOFVxbPPv0kpF4h8BTTzbkxTf/coFfJ/tNo=;
 b=cgc8HtaTLdITE+mdHiUXMK8SIekEqcae5GARFc2d+F2IqDdyIlDBDjX6OaPrJC227g97896M6kVuQwFmuvHL+J3KEgsvfPDIx1MkTTHLbXOuxNhTJGQVDgemOKAobOrNmO0mAO69oskqeCuItG1C19bAA6Dkkh+eE727dIY5mMQ=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.28; Fri, 22 Mar 2024 06:41:13 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 06:41:13 +0000
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
Subject: RE: [PATCH v9 4/8] cpufreq: amd-pstate: Remove
 amd_get_{min,max,nominal,lowest_nonlinear}_freq()
Thread-Topic: [PATCH v9 4/8] cpufreq: amd-pstate: Remove
 amd_get_{min,max,nominal,lowest_nonlinear}_freq()
Thread-Index: AQHaedeLF8cF/D0dzU+K4mjvMP6a1bFDVBzg
Date: Fri, 22 Mar 2024 06:41:13 +0000
Message-ID:
 <DM4PR12MB635184F2B66E07212446844EF7312@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <cover.1710836407.git.perry.yuan@amd.com>
 <a7fafd1a6af77329e943403705c10e3c141864e0.1710836407.git.perry.yuan@amd.com>
In-Reply-To:
 <a7fafd1a6af77329e943403705c10e3c141864e0.1710836407.git.perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=585b81a3-d5b6-4a8b-bddc-520803af41e5;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-22T06:40:57Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|SA1PR12MB8948:EE_
x-ms-office365-filtering-correlation-id: a28187da-7862-4e80-238e-08dc4a3b1122
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tDR/IrjD5KtiCES0qGL0uI/rmZtmAkugxVOPyTYPXlYprTKl1c/Dm3vn2IOHJubBhHMtTC2XFcsoRt6D+Papd9lU3z2lcGyNnxzJNqWGIsNJZhDje8Wad7HLoVz0gd3vnQI1s5+/gvDjXurG8jgbXfrQilTOJDBDX8qHPnIYekmARe/79z8XYFacTK2PEz8t+DlJ4X/U6CbhWis8LYu/uBVXVn+w2Q5OGx133RizcSQChmCi/ZBlWuo9mDUpbm8Wisx88fiCN/01JFmrC6Bgy+cntAvoyz+YUeu6hwQyU4Sgq5gifM6bgal9NzaHte7PHVtb5uCeyOo6x84b0QV95PDOVAeM+fU4Rp0kruM0/2dlPznq0KWacvhTuo1dEQzxg/T19PFrXg4zms8UUq2qasWU13SiYy089CGUtKVOpCeezMAjuirKXRtpan98U1RgSfIKvWSzQL2/U6yG0U0qjc3le1LsmWia4WdqApnLShcBe2yz4Z3rxOeybmiJ8tBYr7Zq7D4+774L+QJIyCtdHlHCqcjpOF3XwDKKsaEhzjEYK96ETdglqn/LEZMD4jZvExyPVG9Ho8Kshb8zzDnAgtEDroucLl2BcAiQu/9NYYz8IVIS3MVeMDm3KrPPWgTb+++uFivuwL0oXT0sxNNLUNLk2EdzyhidgP6BYaaE8zZOd4DGMiOlv0harnIBz3wITFeahs5TD9viDKwD8hIsAikM+IilG1MYf7OTw50d1d0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pVmgwFgSjI/8ysmlYeSV12tXqJyduv5zMGgdAKhyZIJ/oOsK0T4Fou/Zl3mF?=
 =?us-ascii?Q?am29hmleWDFgUL1IH/M0G3YBV4kM3LE4dDi6zLsxowEXHq40W29jjdFcNVNJ?=
 =?us-ascii?Q?OK2f1PlMLONo2XWxDR6lBnmc4WiHWUanbSwn4IEpCqO/XEpqTS/tpKl/NbAI?=
 =?us-ascii?Q?d74tYSgzYs4wC5WLOM/y2rdboZWzzkahP+3p6S6ujqz2Trwu96n/AZEtZjTP?=
 =?us-ascii?Q?UcAaQ5yZCx5xayoyIOc6ttLBLyrU65fAQbjg7y52VWPFJlecseIMgGI4TTMV?=
 =?us-ascii?Q?CjC8HcVpKpxhR/POWEFvpqXmDeSDUWkhG/Dr8ypoYKPIg+u4Dfq50ZGyRnIj?=
 =?us-ascii?Q?GURCIZmbcOTB0u4tH5T43OmafmlH8d7wZnsNbCxCb5Y2CDGLmlWFw1di9K69?=
 =?us-ascii?Q?TjksYPjm4ciEBTGFsbeKxfz1e7xZkC0OtTBvGmfgpVOvLhZcIY93+gCUHn0k?=
 =?us-ascii?Q?aR84Ng1EXpO7d5PeknuTwzWY3y3+5NgiqtZ09iaYf6R7CL1sow19mOwmMBZ+?=
 =?us-ascii?Q?LaZRe0a3hyCdwL5ruQ8EmDnaDUi9mXUi6tBC8MS4Utn8NEKQwgfTZZYw0V/f?=
 =?us-ascii?Q?eeeFrP3/ABbfoEiyYPCiZRpKKnqxAJO2b2/TaPAP34o6Rhlt0xMO0q84GUhX?=
 =?us-ascii?Q?XSvOACnTBh0yQF4PP+5nlWhk+lxAGl4VgPkKKJ7TI/2691Mzs8ENBe1/lJaS?=
 =?us-ascii?Q?dZz6T8jPnEs6u4W/GXTJmtPsXLGCJKf1fTPa/DWeL0QobFBWOrFZx/cxAhXp?=
 =?us-ascii?Q?bIKKcjM999s6ycDRNHUVycONMYj/qLS19R4ZtdzA9IgNr+wpY2uHgp2eQsLe?=
 =?us-ascii?Q?eO0B0tx8cXJEd+C70FhWGZ+G2zdarJbNwz+jLCjONuqjnYfJ8V/3wH+B1jxT?=
 =?us-ascii?Q?FANU7PFGvqLJFzb6KoGlu2f1POkerKEQXSrH+c1tu0gipltz5sQuMGCa8r1n?=
 =?us-ascii?Q?Qck1vHhDSvrBnquJuUgI9LvttlWaq/r4ZaMOGdeHbRo3buHY6dzZRdPEfZqF?=
 =?us-ascii?Q?hhlHFFL36q3EABkrOjLVmDUgVwJGDMBFA9m/ps74qCtb2c0RIiFr5FZWo6ay?=
 =?us-ascii?Q?k+kr/qA7JC3+AhjQdklaIXGaidipgaPd/q9QpBZO5rLQro/vOUbnoyFbjJKg?=
 =?us-ascii?Q?Cd+IU1SWCBPq/k4e0eJIdlRFfzjkYrLcjGudJBjZ4YIktGtaTD+wvBgLvjBV?=
 =?us-ascii?Q?DUOX+lC7MZukej/vJQXPPeAym9o/JgeOUq0i+MwJXqJXNbrnzYc4Mi6z+X8I?=
 =?us-ascii?Q?vZSFOPM1roalQ4n2zDIgyfiDiTIlPJvg2qd0+xdnAuT1vkHXh45MYfX0Mo/u?=
 =?us-ascii?Q?SYIvF03u/pHcGeSU1Wnlk8MbTtnvVvMTClzXx6cI0MsvBqCXrRamvUcq4BNm?=
 =?us-ascii?Q?O6/8vOzoneird+gAbUsLjCN6QIhG2toFkXXIV+HLuPArVZ17Kq9RuEEU4AHB?=
 =?us-ascii?Q?SXcc21MC7EopmnoWecUavPA6XCIxLuylPhDTR8QHQ4DqpUEQMCALq0siwoVg?=
 =?us-ascii?Q?dRl0SSnuxm/WSvTquJjP9GqG664xtxhazkF0pn2Bjq9sFd0CeUK1FOi+GHXc?=
 =?us-ascii?Q?ZTPYhVfqRjo8AMwrR6s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a28187da-7862-4e80-238e-08dc4a3b1122
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 06:41:13.0486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owqDdtgQ79RO5h3Q5DsZ+5UQh9uAv1SlgXSHS3yRV2yRzKatUeD3gwY+K+Q2NP+W3uNTQC8QrVhCKU/NULzu2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948

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
> Subject: [PATCH v9 4/8] cpufreq: amd-pstate: Remove
> amd_get_{min,max,nominal,lowest_nonlinear}_freq()
>
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
>
> amd_get_{min,max,nominal,lowest_nonlinear}_freq() functions merely
> return cpudata->{min,max,nominal,lowest_nonlinear}_freq values.
>
> There is no loss in readability in replacing their invocations by accesse=
s to the
> corresponding members of cpudata.
>
> Do so and remove these helper functions.
>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 40 +++++++++---------------------------
>  1 file changed, 10 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ba1baa6733e6..132330b4942f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -604,26 +604,6 @@ static void amd_pstate_adjust_perf(unsigned int
> cpu,
>       cpufreq_cpu_put(policy);
>  }
>
> -static int amd_get_min_freq(struct amd_cpudata *cpudata) -{
> -     return READ_ONCE(cpudata->min_freq);
> -}
> -
> -static int amd_get_max_freq(struct amd_cpudata *cpudata) -{
> -     return READ_ONCE(cpudata->max_freq);
> -}
> -
> -static int amd_get_nominal_freq(struct amd_cpudata *cpudata) -{
> -     return READ_ONCE(cpudata->nominal_freq);
> -}
> -
> -static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata) -{
> -     return READ_ONCE(cpudata->lowest_nonlinear_freq);
> -}
> -
>  static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state=
)  {
>       struct amd_cpudata *cpudata =3D policy->driver_data; @@ -854,10
> +834,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>       if (ret)
>               goto free_cpudata1;
>
> -     min_freq =3D amd_get_min_freq(cpudata);
> -     max_freq =3D amd_get_max_freq(cpudata);
> -     nominal_freq =3D amd_get_nominal_freq(cpudata);
> -     lowest_nonlinear_freq =3D amd_get_lowest_nonlinear_freq(cpudata);
> +     min_freq =3D READ_ONCE(cpudata->min_freq);
> +     max_freq =3D READ_ONCE(cpudata->max_freq);
> +     nominal_freq =3D READ_ONCE(cpudata->nominal_freq);
> +     lowest_nonlinear_freq =3D READ_ONCE(cpudata-
> >lowest_nonlinear_freq);
>
>       if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
>               dev_err(dev, "min_freq(%d) or max_freq(%d) value is
> incorrect\n", @@ -960,7 +940,7 @@ static ssize_t
> show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>       int max_freq;
>       struct amd_cpudata *cpudata =3D policy->driver_data;
>
> -     max_freq =3D amd_get_max_freq(cpudata);
> +     max_freq =3D READ_ONCE(cpudata->max_freq);
>       if (max_freq < 0)
>               return max_freq;
>
> @@ -973,7 +953,7 @@ static ssize_t
> show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
>       int freq;
>       struct amd_cpudata *cpudata =3D policy->driver_data;
>
> -     freq =3D amd_get_lowest_nonlinear_freq(cpudata);
> +     freq =3D READ_ONCE(cpudata->lowest_nonlinear_freq);
>       if (freq < 0)
>               return freq;
>
> @@ -1315,10 +1295,10 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
>       if (ret)
>               goto free_cpudata1;
>
> -     min_freq =3D amd_get_min_freq(cpudata);
> -     max_freq =3D amd_get_max_freq(cpudata);
> -     nominal_freq =3D amd_get_nominal_freq(cpudata);
> -     lowest_nonlinear_freq =3D amd_get_lowest_nonlinear_freq(cpudata);
> +     min_freq =3D READ_ONCE(cpudata->min_freq);
> +     max_freq =3D READ_ONCE(cpudata->max_freq);
> +     nominal_freq =3D READ_ONCE(cpudata->nominal_freq);
> +     lowest_nonlinear_freq =3D READ_ONCE(cpudata-
> >lowest_nonlinear_freq);
>       if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
>               dev_err(dev, "min_freq(%d) or max_freq(%d) value is
> incorrect\n",
>                               min_freq, max_freq);
> --
> 2.34.1
[Meng, Li (Jassmine)]
Reviewed-by: Li Meng < li.meng@amd.com>

