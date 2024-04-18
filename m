Return-Path: <linux-kernel+bounces-149780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6898A95C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6703AB2219F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F5215AAD7;
	Thu, 18 Apr 2024 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FnJQy1Wm"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DA4158858;
	Thu, 18 Apr 2024 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431736; cv=fail; b=Acte8y+QpF0mbxIwg/yQSWjLl72FK4cT8rcOp+RC3C6FAUUh9J8X61tRAfYKVkI7dq7CZIoFNR+iXLdlM430UpOzyE/564C4EnTC3r7zvgiNqVsN984Fo0noIUwrV8zuylA9WijAPmm/VETxLeQYpPCUDq4KfSu//9yKcNKdwHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431736; c=relaxed/simple;
	bh=L2HxD5g3MF0V9RADclts2bKuPKMfzeciROqWgHN3JKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dE+ZYrYHmEZdKy0WLfUbCZqh57UKz9dIIA68BZjmbPKxbr0ePjDDLG/1LcWSY2OkH0CoSC9hk3PHfNYsaQEZfoHkmEZvGinUO59IcZrQ1a09+VwTp1qCdwmmAv6oy+rCqTekqbIkESt+A+TTd5vxHwMw9h4CbhauNn6XoEUUULk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FnJQy1Wm; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtD9hAZstF1Ij25FeMbWSPCRy3dUx1bpBqBVMZM5O1YiGynxHRnPxYVSR2cyvn7vHntQUn9QCe3pCApZtmwoAe7R1p7fFdTSq+F5EYAty2nWv7+8SVAHrwsLUOMVPhmGRx0G6Nonw62GnagoCvoPmNOz64hXUKETMzyjK/We59lTqd01vDwTR+Z0sgT/W0DlCFY6ZFuYcWrOLntjoUxTa+I6RKL7h7vMI3ubGDUGZkSg/Kwxm9/THsFneXA7mkxvqCCK2pePLrRvELYP0s8Ok8df5DWIVNl4TsC9mFJtrmK3k9yXnRHRzX8YI8InYZkaOEDkca8RYA5hE95P1xEDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANvIptWtVm7JYRAqpgtD2rWLqklaqRb6dbyubt4Aakk=;
 b=KHE2aDwMuMXW3TEyJoge6BtXxWreeQVX9huPYlzS/wNBfi3nat8WpuroA/jCbuHOJflpKBDgyZVJZq4r8JnJRiTEILzmuJi/7+YskdfcHxsyLcAw7+5CSbpQ8IojLCgYfHs00bAVDbytUY8iF0z8J744ZQ78snznuEwWV7S26s9fg3FJqRkXICEjdi9sGdV9Q4tJglsG/lNSoNKCFWmbUkNe2oUsIG5cmpN9TDF6giMnr9FVkcQ5uzWevPB9AXlU1A/LwieEDyzvEBPeBxx4FftFf0WFBeDO386LU0rnB807HOcj1w06um3Q+YIfqVftEmD05H/OrHwzTFK6Btz+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANvIptWtVm7JYRAqpgtD2rWLqklaqRb6dbyubt4Aakk=;
 b=FnJQy1WmDPohXB03HgsU1fJEvf2Wgut0aR1o5vQ+ezGKQgbOReb3CltZpIdR73ZRarnaLPSmlbnllDf0ZaSYDp8+hjBgvQ5SCVyl931zvlQdCYgYdSfbhemt0InaY5zOpt5DZdNLjOxLkZimMO5bk3yHDCAbs4wpunSQg5SZZkI=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.55; Thu, 18 Apr
 2024 09:15:31 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 09:15:31 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>, "Du, Xiaojian"
	<Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 3/8] cpufreq: amd-pstate: Unify computation of
 {max,min,nominal,lowest_nonlinear}_freq
Thread-Topic: [PATCH v10 3/8] cpufreq: amd-pstate: Unify computation of
 {max,min,nominal,lowest_nonlinear}_freq
Thread-Index: AQHafqlOStDko7smtkqhbMmpukPdgrFpjFKAgARXt+A=
Date: Thu, 18 Apr 2024 09:15:31 +0000
Message-ID:
 <CYYPR12MB8655C0C64AA779F8FA9E09159C0E2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
 <31e4c97f791837c97c0b2caca61bcdfeabc3f97f.1711335714.git.perry.yuan@amd.com>
 <Zh0/p4tzcqxQvnm7@amd.com>
In-Reply-To: <Zh0/p4tzcqxQvnm7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5d47542b-47d7-48af-9eed-d3fb5d10099d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-18T09:13:30Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|PH7PR12MB5735:EE_
x-ms-office365-filtering-correlation-id: 8f7e3e2b-f897-45bc-8268-08dc5f8818bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HD9ZRV7RbxDx75mYZEc3ahq3dObsqLh0nEBOV2amG4+P8pU/rh/Tt2ZjUTH+ipwZprpd7ADE6hKOCRH/RGh7g/4Xx+l5yas93zSfMqyDAyp9pdsxT2UNzjoGC4Y+gOh/IB7UOAtSIt8mRabD4B4nSuY04C494pLI20fHlHFA/v63rYXIrGwSmUUtgIzO6A3NbZ8lo89mFdbiLz0nMWbNMg3tgjwNct0CHbGjP+mwg+pt8seRjc+q1Z2OMPIDCA3B0xYY142e96UL1U+w5nPdrNA9AuQPgFKhSJF3zEk3cn7kmYHMxu/AS0y35UEFKARWMSxsjd11z6FMMYoxCdw8B+c5uHQ1/dk2RHP/KhJ4BliKLolW+g1Q91ByS0rlD271DizSeMIIwW+kEEZTBfExx+4PTNp8oPp4KQks/wth2rF0uE1cImeT9slfuLvWrzD++lPfkEu8kBxa1Pe4vzRJi0fKkqrRg5n53DrhmeXPDJdvYfkAjXPiNDgWfBk2tAQpOtVqb55mb6ZhAjhycU2w48X/3Bk5UH3O2CkD9bBMhAJX7Zfvh8AlQ20whegNGcbdGFOQr6hVJYhU1KBOfX/Lh6tI9SP8UaQCs8+MHEw2Ce9qLAnbpFqkh5kN3xqlJHjxLujl9A+UwFFw5RuF23Nw/d/2gwvfj+wXrrlo86+g6F1ygLdK2EvPziE7yecPFAzhn/oVZl9Kevcl9hfxeRTPoQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?p54D24KfjY2D9h9hSDgdvYGYtOCeYo517TCPUYnv6cLL0fOpRa1Qsq7s0Ia4?=
 =?us-ascii?Q?zECA1kFddtP78qR+X/jOLqlSd49OBAtnFXl/WsTpOhR0zGDHi9slm0HbnXS0?=
 =?us-ascii?Q?faIMHzplFQu02AVt7q6RCBKsGSrtkFDJ5slX74ZrDvapVRX5I7h2la3iRxnU?=
 =?us-ascii?Q?rYqXGTqXPxTnPf+7/5D/vr0mpWpYFjEfdoIifC+lG+xPoiDBkxy14cJDiWPq?=
 =?us-ascii?Q?RtCw1WaqEjBnukGPXV2fS6hqqwVt/H+NDEE8sd2wpEchSLSMVSIYM20itRZd?=
 =?us-ascii?Q?kGe/BvOCBX8ROzvRln6jEQfs45FlSEmF3YVYanulVgXLBr/TQpOYlkVAu6oj?=
 =?us-ascii?Q?F9zc+M8qX5RwQMzSfqw4PnxtK6kPwYCVgPW3ToFO5sqPESkFgrJcpS6wAytm?=
 =?us-ascii?Q?PNVzwx89fPGPyXdK+dgMg16X1EA5KdTBDR/HKBZ3jtY+T+FAJuxseIn55bWo?=
 =?us-ascii?Q?3pQAi3P4gIhL/TzEJBBEmpjJwfXCGJuISFkn29pqdgYFGuNffFpLikJoodvI?=
 =?us-ascii?Q?82JW8YemjnM4BtkkTtZWXRwGvP3gt1a/myS2yyTHZhlVcYrnIJhVp3BaZ56M?=
 =?us-ascii?Q?9ulICZA42RyeaptVrXNsKn8sb7k8boCljWtAYqpAOGIJ73UU08zuOhc8Fw5m?=
 =?us-ascii?Q?5Sp6DMZ6ge2mymzVaaUqyUDQgIXcT6q+3zHQrE2ZHTzTEqo/L09vHiRAPJFD?=
 =?us-ascii?Q?64LaL5f5usVC5LLyuhGw9lRlWLmDBropXQMoFcszA6DdmwNNcIURDj2VOfE3?=
 =?us-ascii?Q?473+gk1NyEizuZfJCgmX6EH64OzrtXKdjwS5vGU487qa/L6o6AYuH15w00ue?=
 =?us-ascii?Q?XpM6wFc6gXRGa8VeHrPeYIURJfkGpgqinU43N8nfkZ8mQJyPPoqUhOVxQ0zz?=
 =?us-ascii?Q?m9pE5B/c8n2nFSXXFF6tlYDbwRpIQBlQrs0DqIJpYjjGtz3TDXF4Xw2oBm8S?=
 =?us-ascii?Q?zimlaSIZ8zKxqASCnap8zDI+MQUcIBzjDx6ezJEkMuJAvXmkVFl7oJJI20+W?=
 =?us-ascii?Q?8LTejEwuyaVNxXUa7TSHm9gEHv19jaauw9kcNVmqZgVCxwklgskITITyDq8s?=
 =?us-ascii?Q?qeoqGZvvue8UNRTaV9K8rkWbSdLWJQhs17ZX3WswACkqX87vI8NI9f1dC0g4?=
 =?us-ascii?Q?1F78eAOCd2jPtRAGO/YjqZsPI5KiN6lw469nOWUJPxu686SQjRTeTtQf53Jl?=
 =?us-ascii?Q?oeRcRakrayMyiH4B5LZsKyefDPR/cMFoxhb6Q7vkH5oWl0PtXGqwSA9Lj1Jh?=
 =?us-ascii?Q?hX748iWWae5Cedst8xhDGjjuQq9Em7G4c5mlte+6k/Vr7+wbYJH0JrpF6kuV?=
 =?us-ascii?Q?+r6zJXHjVi2iOK/8mDQS8XT3211LJX+XK3HcsUYIAs6lzwJZMJYdl3LlchD+?=
 =?us-ascii?Q?dk/nTJ9KjgeC6tLFiPbzrFJ19JnIypI7OZWgnpMOglYneyghP28LIakzgxxh?=
 =?us-ascii?Q?Lmh2cjyCzIcvIAtXJZsC4Wn2ZiKX+C2h9vhpHFNpI/NySgAPsXEX3A1BB6Zc?=
 =?us-ascii?Q?8ieeSIPoCnBKRJ95k/R3qnqoIoFaXxJJt+ggTe0C/cvp5id/ZeJlvwISgcIE?=
 =?us-ascii?Q?miTBT+SdXd8LVfKzg2bnLrp74pwsbm7+3ZxMR3gu?=
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
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7e3e2b-f897-45bc-8268-08dc5f8818bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 09:15:31.4946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtDb1l8xrXQ3826T9CcRRD0OYO+pvW7bF7fXkFMVzewmmCcYTmWMo27mjCN5uJDkMq3zH0u8h6ub7pLQ/jqzCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735

[AMD Official Use Only - General]

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, April 15, 2024 10:55 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Shenoy, Gautham
> Ranjal <gautham.shenoy@amd.com>; Petkov, Borislav
> <Borislav.Petkov@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; oleksandr@natalenko.name; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v10 3/8] cpufreq: amd-pstate: Unify computation of
> {max,min,nominal,lowest_nonlinear}_freq
>
> On Mon, Mar 25, 2024 at 11:03:23AM +0800, Yuan, Perry wrote:
> > Currently the amd_get_{min, max, nominal, lowest_nonlinear}_freq()
> > helpers computes the values of min_freq, max_freq, nominal_freq and
> > lowest_nominal_freq respectively afresh from cppc_get_perf_caps().
> > This is not necessary as there are fields in cpudata to cache these
> > values.
> >
> > To simplify this, add a single helper function named
> > amd_pstate_init_freq() which computes all these frequencies at once,
> > and caches it in cpudata.
> >
> > Use the cached values everywhere else in the code.
> >
> > Reviewed-by: Li Meng <li.meng@amd.com>
> > Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> > Co-developed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>
> I am thinking patch 3 and 4 should be squeezed together, because they are=
 all
> refining frequencies in cpudata. But I am fine if you want to continue ke=
ep
> them separately.

Yes,   we would like to keep changes in two patches,   then patches don't n=
eed to get review again in v11.
Thanks.

Perry.

>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 126
> > ++++++++++++++++-------------------
> >  1 file changed, 59 insertions(+), 67 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 2015c9fcc3c9..ba1baa6733e6
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -606,74 +606,22 @@ static void amd_pstate_adjust_perf(unsigned int
> > cpu,
> >
> >  static int amd_get_min_freq(struct amd_cpudata *cpudata)  {
> > -   struct cppc_perf_caps cppc_perf;
> > -
> > -   int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > -   if (ret)
> > -           return ret;
> > -
> > -   /* Switch to khz */
> > -   return cppc_perf.lowest_freq * 1000;
> > +   return READ_ONCE(cpudata->min_freq);
> >  }
> >
> >  static int amd_get_max_freq(struct amd_cpudata *cpudata)  {
> > -   struct cppc_perf_caps cppc_perf;
> > -   u32 max_perf, max_freq, nominal_freq, nominal_perf;
> > -   u64 boost_ratio;
> > -
> > -   int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > -   if (ret)
> > -           return ret;
> > -
> > -   nominal_freq =3D cppc_perf.nominal_freq;
> > -   nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> > -   max_perf =3D READ_ONCE(cpudata->highest_perf);
> > -
> > -   boost_ratio =3D div_u64(max_perf << SCHED_CAPACITY_SHIFT,
> > -                         nominal_perf);
> > -
> > -   max_freq =3D nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
> > -
> > -   /* Switch to khz */
> > -   return max_freq * 1000;
> > +   return READ_ONCE(cpudata->max_freq);
> >  }
> >
> >  static int amd_get_nominal_freq(struct amd_cpudata *cpudata)  {
> > -   struct cppc_perf_caps cppc_perf;
> > -
> > -   int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > -   if (ret)
> > -           return ret;
> > -
> > -   /* Switch to khz */
> > -   return cppc_perf.nominal_freq * 1000;
> > +   return READ_ONCE(cpudata->nominal_freq);
> >  }
> >
> >  static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> > {
> > -   struct cppc_perf_caps cppc_perf;
> > -   u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
> > -       nominal_freq, nominal_perf;
> > -   u64 lowest_nonlinear_ratio;
> > -
> > -   int ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > -   if (ret)
> > -           return ret;
> > -
> > -   nominal_freq =3D cppc_perf.nominal_freq;
> > -   nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> > -
> > -   lowest_nonlinear_perf =3D cppc_perf.lowest_nonlinear_perf;
> > -
> > -   lowest_nonlinear_ratio =3D div_u64(lowest_nonlinear_perf <<
> SCHED_CAPACITY_SHIFT,
> > -                                    nominal_perf);
> > -
> > -   lowest_nonlinear_freq =3D nominal_freq * lowest_nonlinear_ratio >>
> SCHED_CAPACITY_SHIFT;
> > -
> > -   /* Switch to khz */
> > -   return lowest_nonlinear_freq * 1000;
> > +   return READ_ONCE(cpudata->lowest_nonlinear_freq);
> >  }
> >
> >  static int amd_pstate_set_boost(struct cpufreq_policy *policy, int
> > state) @@ -828,6 +776,53 @@ static void
> amd_pstate_update_limits(unsigned int cpu)
> >     mutex_unlock(&amd_pstate_driver_lock);
> >  }
> >
> > +/**
> > + * amd_pstate_init_freq: Initialize the max_freq, min_freq,
> > + *                       nominal_freq and lowest_nonlinear_freq for
> > + *                       the @cpudata object.
> > + *
> > + *  Requires: highest_perf, lowest_perf, nominal_perf and
> > + *            lowest_nonlinear_perf members of @cpudata to be
> > + *            initialized.
> > + *
> > + *  Returns 0 on success, non-zero value on failure.
> > + */
> > +static int amd_pstate_init_freq(struct amd_cpudata *cpudata) {
> > +   int ret;
> > +   u32 min_freq;
> > +   u32 highest_perf, max_freq;
> > +   u32 nominal_perf, nominal_freq;
> > +   u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> > +   u32 boost_ratio, lowest_nonlinear_ratio;
> > +   struct cppc_perf_caps cppc_perf;
> > +
> > +
> > +   ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > +   if (ret)
> > +           return ret;
> > +
> > +   min_freq =3D cppc_perf.lowest_freq * 1000;
> > +   nominal_freq =3D cppc_perf.nominal_freq * 1000;
> > +   nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> > +
> > +   highest_perf =3D READ_ONCE(cpudata->highest_perf);
> > +   boost_ratio =3D div_u64(highest_perf << SCHED_CAPACITY_SHIFT,
> nominal_perf);
> > +   max_freq =3D nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
> > +
> > +   lowest_nonlinear_perf =3D READ_ONCE(cpudata-
> >lowest_nonlinear_perf);
> > +   lowest_nonlinear_ratio =3D div_u64(lowest_nonlinear_perf <<
> SCHED_CAPACITY_SHIFT,
> > +                                    nominal_perf);
> > +   lowest_nonlinear_freq =3D nominal_freq * lowest_nonlinear_ratio >>
> > +SCHED_CAPACITY_SHIFT;
> > +
> > +   WRITE_ONCE(cpudata->min_freq, min_freq);
> > +   WRITE_ONCE(cpudata->lowest_nonlinear_freq,
> lowest_nonlinear_freq);
> > +   WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
> > +   WRITE_ONCE(cpudata->max_freq, max_freq);
> > +
> > +   return 0;
> > +}
> > +
> >  static int amd_pstate_cpu_init(struct cpufreq_policy *policy)  {
> >     int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> @@
> > -855,6 +850,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy
> *policy)
> >     if (ret)
> >             goto free_cpudata1;
> >
> > +   ret =3D amd_pstate_init_freq(cpudata);
> > +   if (ret)
> > +           goto free_cpudata1;
> > +
> >     min_freq =3D amd_get_min_freq(cpudata);
> >     max_freq =3D amd_get_max_freq(cpudata);
> >     nominal_freq =3D amd_get_nominal_freq(cpudata); @@ -896,13
> +895,8 @@
> > static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> >             goto free_cpudata2;
> >     }
> >
> > -   /* Initial processor data capability frequencies */
> > -   cpudata->max_freq =3D max_freq;
> > -   cpudata->min_freq =3D min_freq;
> >     cpudata->max_limit_freq =3D max_freq;
> >     cpudata->min_limit_freq =3D min_freq;
> > -   cpudata->nominal_freq =3D nominal_freq;
> > -   cpudata->lowest_nonlinear_freq =3D lowest_nonlinear_freq;
> >
> >     policy->driver_data =3D cpudata;
> >
> > @@ -1317,6 +1311,10 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
> >     if (ret)
> >             goto free_cpudata1;
> >
> > +   ret =3D amd_pstate_init_freq(cpudata);
> > +   if (ret)
> > +           goto free_cpudata1;
> > +
> >     min_freq =3D amd_get_min_freq(cpudata);
> >     max_freq =3D amd_get_max_freq(cpudata);
> >     nominal_freq =3D amd_get_nominal_freq(cpudata); @@ -1333,12
> +1331,6 @@
> > static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> >     /* It will be updated by governor */
> >     policy->cur =3D policy->cpuinfo.min_freq;
> >
> > -   /* Initial processor data capability frequencies */
> > -   cpudata->max_freq =3D max_freq;
> > -   cpudata->min_freq =3D min_freq;
> > -   cpudata->nominal_freq =3D nominal_freq;
> > -   cpudata->lowest_nonlinear_freq =3D lowest_nonlinear_freq;
> > -
> >     policy->driver_data =3D cpudata;
> >
> >     cpudata->epp_cached =3D amd_pstate_get_epp(cpudata, 0);
> > --
> > 2.34.1
> >

