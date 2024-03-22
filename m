Return-Path: <linux-kernel+bounces-110989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC258866B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937BA2840DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9E1D51A;
	Fri, 22 Mar 2024 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hhrlZRZR"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408DFC147;
	Fri, 22 Mar 2024 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711088940; cv=fail; b=iZoSxr1aErFU08wKU7O6MqsnGmhrWI+9CiuhKLWJ+yNny/rrDuV2TyDQ2X6H89guBXy+/Zy1AGGe7XPSsCN8ibeqhcYwALdlInK21VtBVjJGcSkwDbO6/YYz0XeqZ72tCATWgT7ZrRp6REZuACxuovxevabLQehtskjTjUXvrds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711088940; c=relaxed/simple;
	bh=4HG6MXzx0ezIkoj4R4GlQGvXYRRyqGNEWUJlxK1tALo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HPWYvkSYitId6T7sjFx8NFBST+RBKhAWAs+O0c0WHMDyjD6qpoU3dDT9zCx8lGtOPc/mu8LRkOTcEyEPlsqlp+T3mGq4s3qB2XeNMYbFfd7xnTCSSRCZ0Qt/aMXVAsssFJSxSJ3wlKjPRI93UuqT9vtir/lzoaH9BqsQ8qqe8dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hhrlZRZR; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCmK3z+7GWb/kZFzlaSPKpMuI0XandkAqBeVc2fZvC+rAkt5b7njX6e1u9MEbRJwxgaCAJwmS4DsnJP/qgzrwNRCer49hj447WdidPZ78DzAwtqiNnNnmI7pKJEFh6nOw08ykKUHDyG3Hc8fiPzKU5h5wpPTiR777XFpLYQV4VAOCkoSgg/5S04Rv2I0nZlB/7uOkUQ6ksGmcN0V5s2cPOMISPYeO8DxjGuHBtW0QpKW8yDNzACQPw6caxiwVjDMt+kfr4oTr4dkobkzhYOtAvLgQSA8yQBsx/RIC2f1+QOL9CCPrqK90V6s9u+qn7wIyRKUnx/lQYp2S7MqJRQ3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jG7+ZZR/Mq9emOtFtpGDtcf7aFQlGFEDLVUKb7pkBPs=;
 b=nsyq6CYRwkHvAdGfzxFfnyaoBMYLV3jQjbXVTk197ZecjAMGV/xGIFOhaOU0zZdc/8sI9Jqpdt8pFCxdK8JqHvKuhoi0wrQ87NYbDUCPkEqNGC/AVAa5H58hxm9q4kHgb6w1V1HUloyDNiR0SfyqNd6yPgFMwvdS5WmkObj3hp7J4mxQNBdxh1kGdheKm8eXZCZwb0QXXTg8DgsW9VbVuuo8IX1dNe/yDCO3hKJwt1ejTLZU1DvBEPxrIhSmNdSoT/RKCOpETtSERboQJPdubL6L6BnmR3gtlxNk7iAVMkRey4K6i3JUVasjWoh51B+H2jBNEQkSJCJvwW7m914xbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG7+ZZR/Mq9emOtFtpGDtcf7aFQlGFEDLVUKb7pkBPs=;
 b=hhrlZRZR7SNOedam9N/xhO8Y2Y4YVIlGgiP9Owhjgu4tkYzaXY1l7KhJey8cPH8/qdRtCKs+QApS0M08CyUSHoKyGWD1zg9/YZLEaDpp62u+nqpC6ihfiGhh4QLjNg3cqT1Mi8tBiNa3VNqlFsMawtxrvhwZFkbGxKC6xd2RRyA=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.34; Fri, 22 Mar 2024 06:28:55 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 06:28:55 +0000
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
Subject: RE: [PATCH v9 2/8] cpufreq: amd-pstate: Document the units for freq
 variables in amd_cpudata
Thread-Topic: [PATCH v9 2/8] cpufreq: amd-pstate: Document the units for freq
 variables in amd_cpudata
Thread-Index: AQHaedeKaX3JaSZoFEGf7rETmpahVLFDUKyA
Date: Fri, 22 Mar 2024 06:28:55 +0000
Message-ID:
 <DM4PR12MB63512B4DC68397182391669EF7312@DM4PR12MB6351.namprd12.prod.outlook.com>
References: <cover.1710836407.git.perry.yuan@amd.com>
 <0ee190df1d882d826faeeee28a000b06eacf6034.1710836407.git.perry.yuan@amd.com>
In-Reply-To:
 <0ee190df1d882d826faeeee28a000b06eacf6034.1710836407.git.perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5e9b33b2-136f-4568-a275-18e64abb86cd;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-22T06:28:39Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6351:EE_|DM4PR12MB6061:EE_
x-ms-office365-filtering-correlation-id: 6d8b9679-780c-42db-4339-08dc4a395954
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IH+clfSEd9r66P15V03aE1oFouucmYAsr4yJTYd4EgJi2YsKosU7rMgkTWGXTTbp+tZI6SfkpTSG5ZQbEUqCv3PQgUBHriesqkI2sPZAqTJZ1xYctyLEA4+Q02CGBMUXJL0MSCGnYUbJVTuStU8PXdL+iz+WZ4cAVk3xpWIX0EQsUBRufJgmG52M7IW3mRysWyadW/lbIkh0ZHbj9Ju32CSgvP7/BW4io6azEyU3+lrrt5O03WXDVAOgGnITfpXA6xnhHSdSQmJ2xkMFv8ZEKlpeTALOoMNACDW67pfhChlM44jVxNDXaOFZlTxiSmJBvpB6Knd40OKYg3QGnLY76Y/u0+hyUiz1itO1J/I+sRWF8zq6Fq5SyjKwtNPXQkLolAfe+IgW0hodgCMp3acNT9WdfQlaPwp/EPDUcQP+ZKdYK5H9Or14J2cMt2FRUsMwrRL/MJY7dM+NXlO/hYIUi5DS/L6rjkTJue7ymRJywgS1ZhOudwcLVpdzhu+f7kjUeaIQMqwX0gXTNDlw5MkhMtG5UMR1FElMd28eUSMmsomjpXenv/czDrklJMpomKwNESHXvx8g6sVWFhj6tzG8Kpa8VVduBJ6srCJBUotkrbRE0lNOTLwehjOBVKqxFUL4LoZfC+7nAZZlu8M84guHDIybWIcdpDdpiImS1LchnBhvKrsdluUXfIXwoHvbhK2W9hJ2XH+okwROvyXUMdhV8RJfdqpNauGde3MWUQbFNJg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HWZQiXLHkh/hJQAKPMhcjgV45KSpQQxc6HMG+Q8Ps0FodwC8Erjr13PfC42N?=
 =?us-ascii?Q?C8Wz5rVvx35TkWj/nbTL4vtiGkpawkio4XHFXj4iQ+JAsTE5RPDXufAzIz7f?=
 =?us-ascii?Q?o4YwBbxHigI14oJ9lGJPOGwnvR/n2psIfrdTu8tRkDcVD9ddG3LnPwaZkx+y?=
 =?us-ascii?Q?AvNUVpMDaywyzqB7eCaOzN9hLBffFqisaqJlnwPdf92RFvVloAzxKz4EAvwP?=
 =?us-ascii?Q?PEcYdCCriv3ATwnA17A6nJdIB6ysGjI7JAFza7o53S1KOi7Qavgqc3m0kebC?=
 =?us-ascii?Q?rqv8DmNfIY3pUQel8LZj1kPlaFcWVPzbxn03drdcA6A2HsTZcxeyDiKchsgN?=
 =?us-ascii?Q?DN8j0bX4ywx1bRr11GLgZHEr5gK1yP9ZkVz7QrPtnuRhvFfpn4z5Gyh2MeXx?=
 =?us-ascii?Q?hcFrDnG8FWRQuY5/o/5AHv/3JIYfKA4URsQxQnjtgf1EnbLyvGtcTDfqt+Q1?=
 =?us-ascii?Q?/MZ1Hlyt6F0chh7AB8odoMwXdnTjP3b1aJvLxjGLVD6yXPh7SgUSrsgAN3dJ?=
 =?us-ascii?Q?wFtNRaULrFQJH7c3zFf8vruAl7J2lUruC45CDMCkZq7WuSWG/B54/ihhjZOU?=
 =?us-ascii?Q?ztQbk3RIJYNCFx0Yp8vATc/eGNJzlEOsYFYACvNSWHFxAwDvF4IJlds8wJsr?=
 =?us-ascii?Q?2hVUmA2S0HIRZh9RUAXNHe4uYlvjosIjYaSiitxEjg5DZHPMWuh2g8elyrgW?=
 =?us-ascii?Q?OVxaJPKB5Ak9509jd4L3zLhoXi4dNzAmpYRHrvGZFvqO/cUtJZpMxyIrsb3b?=
 =?us-ascii?Q?dba9yseicsjJeh4ClpNBDG98VvEvTMZBKRb63MkXCG4FkBD7DBiA31TegKlF?=
 =?us-ascii?Q?LBhPJZE4UoH0NOUl12koIcc5wiJd+2J1z0CnPRm+2Y4TMzmeTxPSK7bXli+u?=
 =?us-ascii?Q?VPI8dFgeNxMQTvBpXKFffNJbXYoiwQsrcMbLG7EwMrOf/Q6kkNnT3npPiGgR?=
 =?us-ascii?Q?hXjXWmiLAqpeecpoZt7oLZb/tL0GL7dXQLjZuB+jB0CpIWyijqnvWAOd2z6z?=
 =?us-ascii?Q?qqLA5tw+ZPQPDyEma4O0S3CDClE1dIoZ+tMB8D9xhKDfZyy593LAXM7eIeDN?=
 =?us-ascii?Q?jOUDGd+Ak06y75Z9mw5kG9oWfmBpdipLFLjNJ0Kapti3ElY+zdxSWPag8qFm?=
 =?us-ascii?Q?3GHpiniAzVNGCk6EkKA7fxbtKR5BgBPuqUOinv5qquGZMRMuGp4OP1gPQOeW?=
 =?us-ascii?Q?Mqn8H7G7yRLBGa+62kRmu8ZnPnZx3tBq8sw92hQs5jCy1RQtnjNM/br4O90R?=
 =?us-ascii?Q?HgfzU6sBnn6H+8hOAglkUaAsQPOzTQ+VTuqjZeQo7L5dN4sj/cr+xwKtSzT6?=
 =?us-ascii?Q?FbEVjz0VZbiv04u9us1+bwmPfofky0S5xZKi3Da9j53ohEbCTkFjw4E3CCgC?=
 =?us-ascii?Q?YnoX2YA+ifS5iFulzuIkeZkkV+0sL67MpePRQav3T6COV9fCayulY6s/yn3w?=
 =?us-ascii?Q?ZGgnaWBiFMkJIrhld94+h+OwsseL+A6n/IZQiKdow4PziXLgmfodbJRAWurs?=
 =?us-ascii?Q?GHERcHm3S6aDYy8+5wVoYmf3PhJIyLOEVTmTZbkJIUbniwH5T1SaEGgYhjlD?=
 =?us-ascii?Q?IuohEplV8AuUZZMBYHA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8b9679-780c-42db-4339-08dc4a395954
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 06:28:55.1580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YdeCYTLg+mXf7JCrJMs+1KxqeUfDeFFC2CLV/eXFTa8wHJ8oauMCUPtAl4D469/OTK9rw5RGjj7vKpHV8moJSg==
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
> Subject: [PATCH v9 2/8] cpufreq: amd-pstate: Document the units for freq
> variables in amd_cpudata
>
> From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
>
> The min_limit_freq, max_limit_freq, min_freq, max_freq, nominal_freq and
> the lowest_nominal_freq members of struct cpudata store the frequency
> value in khz to be consistent with the cpufreq core. Update the comment t=
o
> document this.
>
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>  include/linux/amd-pstate.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h inde=
x
> 212f377d615b..ab7e82533718 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -51,15 +51,15 @@ struct amd_aperf_mperf {
>   *             priority.
>   * @min_limit_perf: Cached value of the perf corresponding to policy->mi=
n
>   * @max_limit_perf: Cached value of the perf corresponding to policy->ma=
x
> - * @min_limit_freq: Cached value of policy->min
> - * @max_limit_freq: Cached value of policy->max
> - * @max_freq: the frequency that mapped to highest_perf
> - * @min_freq: the frequency that mapped to lowest_perf
> - * @nominal_freq: the frequency that mapped to nominal_perf
> - * @lowest_nonlinear_freq: the frequency that mapped to
> lowest_nonlinear_perf
> + * @min_limit_freq: Cached value of policy->min (in khz)
> + * @max_limit_freq: Cached value of policy->max (in khz)
> + * @max_freq: the frequency (in khz) that mapped to highest_perf
> + * @min_freq: the frequency (in khz) that mapped to lowest_perf
> + * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
> + * @lowest_nonlinear_freq: the frequency (in khz) that mapped to
> + lowest_nonlinear_perf
>   * @cur: Difference of Aperf/Mperf/tsc count between last and current
> sample
>   * @prev: Last Aperf/Mperf/tsc count value read from register
> - * @freq: current cpu frequency value
> + * @freq: current cpu frequency value (in khz)
>   * @boost_supported: check whether the Processor or SBIOS supports
> boost mode
>   * @hw_prefcore: check whether HW supports preferred core featue.
>   *             Only when hw_prefcore and early prefcore param are true,
> --
> 2.34.1
[Meng, Li (Jassmine)]
Reviewed-by: Li Meng < li.meng@amd.com>


