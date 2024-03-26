Return-Path: <linux-kernel+bounces-118443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EFB88BAEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372E32E18DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9F612DDA4;
	Tue, 26 Mar 2024 07:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V48D904S"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2111.outbound.protection.outlook.com [40.107.223.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2974BEB;
	Tue, 26 Mar 2024 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436641; cv=fail; b=tWXLyf7eCa7lBU0Gl9RwyFWgemNYo2mlgtemFznpjzkT+Lo0S7FHhtC2xHJkQwBJS5CK7Hs9DZYg6fVAO0dj8Ue4tS6jTo2nhTPg66/UGmqn3CrKU8bcnq6nU/6WhPIiWOGPm5q8EYnq0zQtn8s9jOqHgMp/iQhzGev7lYaThzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436641; c=relaxed/simple;
	bh=lBFdegKlOTlM1EJuMChaOYyKN2Xr8Nw/6n1nl9Ykh1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DjlR736ndvYm4FTCkdA0JjizY7WbO/Qe/CblJA45oOAKkEEHsNUneCsipZeJwN0DNTTnC6RG/Hj/jI7L9CZTOsxM83ry3GN7bxnymJx0j2CrT/nTHjYI46D1MyxuHZFviz3+NxgSlIidy0FoXTGN+jNDIrpc561feNkFeZsoDpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V48D904S; arc=fail smtp.client-ip=40.107.223.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSJB/U3mTSyBRADDHVmZscYHdjf1PAIbpeYjhdV3Uof6T1lCruQ6MGyF2HwKXa0mdiyKYRMfOO62SHqETod3oshCQG8F70yW5e+Lds65NeVCZ370JZbB4c/hXeu1wtQwX+JyetpJ8YH2m+6HrzseQs82+hdii0VkUrNvQZqU74Gsc33R9N8VzlSpXJeRJQl0Pp1FFZGmvaNIOCtj9hzP7tMVsYyVgkoO7yXw6hItJZcupVyJz71DlT/dMOglkEgt+qwJ6D1Sh6WaHL6Q7uxPd/mlMi9CorRWyCfrevU7GQmApdccqntmDySME6TCZfn4NY/XgcP6rxs2u3FvklTkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkwv+VHYfgo0FKo+NvajvBFg+NZapIcP1AM9XVm8LZI=;
 b=VE0z/Im3Lr/4+ahC5ig3ReYFfDiK7dDkEyHO2jsbXRYCNrFKs5+/+W2hw80wy1jL1/bYd0iWGeC7Pe+C2udTRh1Dcjpg2c8sIA/IgRqWJMTFTan4cboDyGYNe2eOixoqs8PLrY6uaZ+AEQ0TrykBRm3e/KOnUxepiTA9Q07n9XbqbHQtQ3AerVNH+YoNNC/XT5RvX+ccwKcTsb2+PXX8KnPo2bhXiuLHHd8LM2KwAex0g0XkKun/SUrGiNlyU3XCrqwMlrIwXdfaGtAJoVJ4DGWYebeOSwquJ66e7RliRl+8GLbck2r2KdRB+zGSHsGxofHb3P3RD7iPD/Tt6+Lpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkwv+VHYfgo0FKo+NvajvBFg+NZapIcP1AM9XVm8LZI=;
 b=V48D904SgSdhOd8bbUepbBOqQDWQAo9nz/9VSGMGGGupj9hR+UN8nk/0OsP2IZWERXDlw1pFc5kfrUj70GV5rF6MEnIo7grLrYtm3qIqUDXZ+MsU/zPm9634OkJ3Jj9DyEm9ymyyDx1/9JeHyfP/7JpKf+o8qui1ZMgzLbS2bM4=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Tue, 26 Mar 2024 07:03:57 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 07:03:56 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Petkov,
 Borislav" <Borislav.Petkov@amd.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>, "Du, Xiaojian"
	<Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 2/6] cpufreq: amd-pstate: initialize new core precision
 boost state
Thread-Topic: [PATCH v6 2/6] cpufreq: amd-pstate: initialize new core
 precision boost state
Thread-Index: AQHaeR0AhHEA5t4b40SQV4IgRB7JvbFAgksAgAkiAGA=
Date: Tue, 26 Mar 2024 07:03:56 +0000
Message-ID:
 <CYYPR12MB8655837DD1E6707D5B6991159C352@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1710754236.git.perry.yuan@amd.com>
 <f43f48b02d42a651028f0c4690caa6e953e8bf45.1710754236.git.perry.yuan@amd.com>
 <ZfrJQF4z9i/yj1bp@BLR-5CG11610CF.amd.com>
In-Reply-To: <ZfrJQF4z9i/yj1bp@BLR-5CG11610CF.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=321139b1-f89a-4e87-a96a-e46e4b694d5d;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-26T07:00:18Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DS7PR12MB6021:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fU+iHIWCd6Cb3Pq9Zn8DT/AK5Ed60bJQFGhVWiqInylkf6wlauf4vrYF2nRWceFAuA7D2sqG3FjYPCscNR2U2UQ+neYY172uv/0yXRnPm4sl1ksiKbyzlTYd1J8DZGzU97Ew+EttzLSiy1DFAwsPNLLLoN4Av6NNeim7+C95vU9y2NbDcDT/IS0WRwkW6XbEBCedjtzCNW8kEp1ODdGZUjD5k/CqE2B8rFrcM9Ybbq/oTC6g/4NVTtKJZvaLe0Cz7BtQmVba8ddDRZ02aOMrF2C3V95kRgyfFAiHWsqAe2C2Ipb+84EuBRu3Rb4/Zkh6laIx3g+LFJShnFhcyajZ0JkyeVQ9Ohn//r1xttApsobrTOD5s5WRDMgWbpSdiqkfQYvJp+Fg65pkKb+qrv7ChXsobfufVIAcqVzjz2H7mIQm0llacaBFZgFROmq6idQxa1YNpMUoPLsq2X/+TMhpj41GWN4fRZSk2jvIp9uAFgLPiJkIljI+IN4cgRmMna7n1V6rVe6+ttzgp8o3sNrxmGuxCPBXt7wVgtkA08+q4fN4rD/G2zk4u6DyMYT6REKtl1G7OsbA49xcPvC9CY0pMFKWjJ3tpYZSWILH+i1m930=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gN8ZZLup0pnMVZ1vrHS3GSZfYB1ynKng4KZj3qW4shDtXa+tAr/nLvj//XgP?=
 =?us-ascii?Q?6EU89kbEHiLVjIj1KIF3HUDCvC8MKeRcLnuC1P62chjqqaak+GXl/ueZJ+Mp?=
 =?us-ascii?Q?FM7MYMJ5mmL8jLcKN2/ev1UnvgxkTY0g+aAM90eJ/rgJVDhJiqPI1vknAFQu?=
 =?us-ascii?Q?8wRyrSYxaKwIcP7nNa3FaPSohhW1CjoyszOrMpGaY7g0bzSktQDNcXTq/t0M?=
 =?us-ascii?Q?/PK0Sh6yB+NQunnzTCrRQQs8eylZyiqMYCEKMDpfjinrnFoBFDIItqnIOIj3?=
 =?us-ascii?Q?gUQMSuoXmkS/kgLLSYQRd2VFvpHsJa6CIhKcU5UOTlrJzZelgfvr3JzZLBe0?=
 =?us-ascii?Q?UiTaNbZ6GnU22itzf5O6u7Ov3QVinl2GOcngdQZDTkt5ZzkqYJW5/UYucScX?=
 =?us-ascii?Q?EFFRcNTgl14M7fe1E3SuVbU0IKw+j5uI+1x0Hi1qsY7a6LtieM5o7gI00G30?=
 =?us-ascii?Q?9A/7Ee2YwGVdYgRkaKSiiwil3vfCCAo4kJku2zNOXxUHAlW3EMS8vvPXM+8x?=
 =?us-ascii?Q?DDpHJmR+8F8lnMtJmLxEamD7bIWKlE4WEkRg/8JjnXE2JJW27ReliDdstps2?=
 =?us-ascii?Q?atT/6evoGvWuGOCvuueQm2OtS/guhgDU8vFoya28Q9XmgSjFo/TC21Z9gkkU?=
 =?us-ascii?Q?OAgxRfZd1TXbH8MINLKHv57FGQOb7U4gMsVGY8LSpAEQXLu0QI2Kux2qDQUC?=
 =?us-ascii?Q?aWIXWJtVYhTBkPLKwSvxq+08wBsgXkjeaveDzhNastZ46xRax5KsEWN8ewWS?=
 =?us-ascii?Q?L+sLAvj3O/GX4NoswMMRCzXgLe0kGS44HCQKsj1g5zOXanmnCLZvOZMqb1MM?=
 =?us-ascii?Q?gzyZ4EdFLftBGdOR2PqOtx1VLI8jMsMh6Wrm7rik1EYjYzJTtue/IPPTpxli?=
 =?us-ascii?Q?um0J53oWjiNaRm3E7ymhCxcj2rY5XWYAyVvukUL2mejpj74LzYx3YObfyftf?=
 =?us-ascii?Q?kMsKDhqQ5u+o5DpYDn0JZsVjVBhpRCYBGZSOVMxh6ACh1OD90vZt5Yf4j54Z?=
 =?us-ascii?Q?oAXN0aze8DIy2RxeR99OA7yLAD3l/2EEuxe21LpFBsLJnJCEO/XSDl8zctyk?=
 =?us-ascii?Q?DRIHtBE6jfUSUlLgbH+B5wsLbHCTXP00QTbdNzqtnIKd3TTLrHu7cuz+hSc/?=
 =?us-ascii?Q?eL6FJo0GRH5oLo1A9mM945umxrCYfP2iKkYg/mmyHRsrZCl+E4l6pp0/20aq?=
 =?us-ascii?Q?EXcYg/cOUo3J2rZYTbII0PtiQlKKK07cn4lP8NWNmpfaTwOJZK12qZALpcIl?=
 =?us-ascii?Q?skomjI+/b4dhIL/PRTkD+0lXdrKaeuz4fD/6HQnDAdGRSWHH33MA9ggkKcGO?=
 =?us-ascii?Q?6D+SH4FIACILoGGMgHbybf896VcJO6o6NhBZX1EMt+a/C97r1dMgNBmO8I0T?=
 =?us-ascii?Q?F+GHkfqcRpj+wTcdxb++KwjZUQWd6BOVBalvZFWOXpLTh788tpZz4NwjyHrV?=
 =?us-ascii?Q?+7OzcHkfeifbebmhgZKQi5zygmWKzflEbTJMV/OND9jxJYo841P+9IsetZYD?=
 =?us-ascii?Q?V7I7Y91wWz5n+JA4j9L20OvbphPdFNYSwn5QH1KFf+HxlnFpTsAjVjzvYOqV?=
 =?us-ascii?Q?Rg/jLiRsjAx2EEVEFMA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c75bf112-f887-428a-1a91-08dc4d62e7b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 07:03:56.8568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEajUJdmY/VrpN0Ym945LwGvstsoeMW8KymfbeIW9AQ7ypyLMIKF8QFsDwbAA46O3f/Hjx1dJeXjxR4uNs4Eog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021

[AMD Official Use Only - General]

Hi Gautham,


> -----Original Message-----
> From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Sent: Wednesday, March 20, 2024 7:32 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Huang, Ray
> <Ray.Huang@amd.com>; Petkov, Borislav <Borislav.Petkov@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; oleksandr@natalenko.name; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v6 2/6] cpufreq: amd-pstate: initialize new core prec=
ision
> boost state
>
> Hello Perry,
>
> On Mon, Mar 18, 2024 at 06:11:09PM +0800, Perry Yuan wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
> > Add gloal global_params to represent current CPU Performance
> > Boost(cpb)
>       ^^^^^^
>       global ?

Typo will be fixed in v7.


>
> > state for cpu frequency scaling, both active and passive modes all can
> > support CPU cores frequency boosting control which is based on the
> > BIOS setting, while BIOS turn on the "Core Performance Boost", it will
> > allow OS control each core highest perf limitation from OS side.
>
> Could we reword this portion along the lines of the following:
>
> "The active, guided and passive modes of the amd-pstate driver can suppor=
t
> frequency boost control when the "Core Performance Boost"
> (CPB) feature is enabled in the BIOS.  When enabled in BIOS, the user has=
 an
> option at runtime to allow/disallow the cores from operating in the boost
> frequency range.
>
> Add an amd_pstate_global_params object to record whether CPB is enabled i=
n
> BIOS, and if it has been activated by the user."

Sure, will revise the description in v7.

>
> >
> > If core performance boost is disabled while a core is in a boosted
> > P-state, the core transitions to the highest performance non-boosted
> > P-state, that is the same as the nominal frequency limit.
>
> >
> > Reported-by: Artem S. Tashkinov" <aros@gmx.com>
> > Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217931
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 39 +++++++++++++++++++++++++++---------
> >  include/linux/amd-pstate.h   | 13 ++++++++++++
> >  2 files changed, 42 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 59a2db225d98..81787f83c906
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -68,6 +68,8 @@ static int cppc_state =3D AMD_PSTATE_UNDEFINED;
> > static bool cppc_enabled;  static bool amd_pstate_prefcore =3D true;
> > static struct quirk_entry *quirks;
> > +struct amd_pstate_global_params amd_pstate_global_params;
> > +EXPORT_SYMBOL_GPL(amd_pstate_global_params);
> >
> >  /*
> >   * AMD Energy Preference Performance (EPP)
>
> [..snip..]
>
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index 6b832153a126..c5e41de65f70 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -134,4 +134,17 @@ struct quirk_entry {
> >     u32 lowest_freq;
> >  };
> >
> > +/**
> > + * struct amd_pstate_global_params - Global parameters, mostly tunable=
 via
> sysfs.
> > + * @cpb_boost:             Whether or not to use boost CPU P-states.
> > + * @cpb_supported: Whether or not CPU boost P-states are available
> > + *                 based on the MSR_K7_HWCR bit[25] state
> > + */
> > +struct amd_pstate_global_params {
> > +   bool cpb_boost;
> > +   bool cpb_supported;
> > +};
> > +
> > +extern struct amd_pstate_global_params amd_pstate_global_params;
>
> Will this be used in multiple files ? If no, it is better to define this =
in amd-pstate.c

Yes, the var will be used by amd-pstate-ut.c which can detect the CPB state=
 for unit testing.
So we need to expose this


>
> Otherwise, I have no other issues with the patch.

Thanks for the review,

Perry.

>
> --
> Thanks and Regards
> gautham.

