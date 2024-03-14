Return-Path: <linux-kernel+bounces-103024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D7B87BA0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A88B21101
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CEC6BFBC;
	Thu, 14 Mar 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="avw4sC7u"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69955433A0;
	Thu, 14 Mar 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407481; cv=fail; b=fC3U05NhRQxGwVI0eAusOcJX41L+McG56ef82H1JGh3EnMySz74FdQMZ2UU+SRn/QcoA4X1H5jSCvPM1fXlJzHzdEJur9jaO/IFEpMATtnsBb5zT/cwbRsV1k4AHHSMqz1rpHrINA/DOE3Ep3rrqJPlSR1jzzi2lDlGVTWV2xoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407481; c=relaxed/simple;
	bh=tAjYd1rMEgKphUkKLTelfHlWo2B7MYbGVvCF7RHkRxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xkdy5y3SV97lFKTf9s9zaFJaz3+LUN5GnGD3DmJMGASYJ1WbyHY9wZ9E7G9Q4BZklUK1+3QR910ysK7hypbvcg4gEi/Eq4065iHFoMPMJQL0CMUS3R3u6955K9lbda+4JcrlqdhVuGY980ONNr6BKdgZh3r79MFDit2Xglkk/2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=avw4sC7u; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIITBSgPayERPysyWCtd9lKZhQYNgb9cO+BPOe7r/gdV8w1weOAdzCFbot+0Fwi3zA4NFvZSinPxlFMDPe/gCB3z87kedul5ZqMnrymoQ5vdPQ4ZmAePGf3WzjhbJrtub7+9+nrnTwQYmpQRyQiqnGxyXYoM/3Wpi1s5lqLVzmhU/W6WA6+SV3G61+iO3vU9+qFdMrG7LQ1rLfQWaY2hwAxmRHSt97iX1jQqnzIOWcViBgW2jE/R/LAON9P5OczcPOcjxCQJoGO5Wf/pI72M3Gi3uJLgqUY1H5xLqgIdeqnyYdBebuiU6p6nDHpbYq6CAy+sE69ZsNELHhid7V9w4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnDBQ8s5MJFbFMtSCrPoyJM77ixbylzw8oLmWSxXrSM=;
 b=UXtgwRp+3ApslAqzmeLickyqX1UywLq1zOm/ITb5FUbRJHB0wl7A+5lmMG5GqpfNJ8UHKic4NkScGHcWbxeLCHd+H+4IjFy9idB765vOILXsxEu+vMIk0jPjMMmvAU1kY6IPNiDOUs2IXsc2MgEfiYTFYRIHoun/EbyqtkH7ZDmbNNVMr6jdZeNWzWvxdE35ZsOK5JQ9MniiFLqTcCOKCtDew3OYac7RmQ48WYb7Mb0SvcmwwGsM5swBauw0oZi6YDIuvCCrD41x0XNBQkfkEJ2PYKI6TctyP+KNuVTOj2+Mkxwu4L1jfKloQxwQF1eclS9DzRFUS1uyh6ldCY5WRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnDBQ8s5MJFbFMtSCrPoyJM77ixbylzw8oLmWSxXrSM=;
 b=avw4sC7uY3tezHU/jrOpUZjJ4KaTMAb0dRSdGxTx9u1x+4kS4ysgiJqf9cv/IMwgm+zg7VRoy6gof3KT1no8EhYylC+QUqKCDzYWXU/8bfq9840VUqPFowR5fGSHuqfOoLY9p0DMsYdaXELgfLdn4Y/P5taTgbmQ8c+XrBHGA1w=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA1PR12MB6210.namprd12.prod.outlook.com (2603:10b6:208:3e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Thu, 14 Mar
 2024 09:11:14 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 09:11:14 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Petkov,
 Borislav" <Borislav.Petkov@amd.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/7] cpufreq: amd-pstate: initialize new core precision
 boost state
Thread-Topic: [PATCH v4 1/7] cpufreq: amd-pstate: initialize new core
 precision boost state
Thread-Index: AQHadS33jvTE6aRZ70+LVFpSvqQdoLE28ucAgAABICA=
Date: Thu, 14 Mar 2024 09:11:14 +0000
Message-ID:
 <CYYPR12MB8655BD01782AC71FF60E94549C292@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
 <1bd9da56478c07fc2117b7c11f88eb517bd60f0f.1710322310.git.perry.yuan@amd.com>
 <ZfK9og1Bnj6BnSvM@BLR-5CG11610CF.amd.com>
In-Reply-To: <ZfK9og1Bnj6BnSvM@BLR-5CG11610CF.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5f3db28b-0ae1-450e-ac1a-f0d2e33506dd;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-14T09:08:35Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA1PR12MB6210:EE_
x-ms-office365-filtering-correlation-id: f5caee02-a4f2-4539-a0a3-08dc4406b335
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tURpNzZDrF9Kvw80ujS7cPQWcBzAOkVCc/oN3+58gwuJb4XNWD6lEwQLd9bAmj1quIDVBUiYLv0ngc6IV/UVTcqwknpz2Ad68T8TlYlMvSTxPo3UDCdMoFJJgiIJr9vPk2/sOgs90751AD1MUOJEa0yEdjnXFsjMY5hI3TzfWBtiI38gR8/85iBZ0ocnMbXMr4BdGP4fBZVbfdZqOvdC32+SG3L06Ada9qFau7X0S79Yso54C8D/l2JBeVcp8Q/YTZQSh6jO47bOclIpYuQeaKYyl5tANy6hMNfQw5ZSRFQiLFNRYlLAArhN8c2dJC792Xk6VDaBt3XOgJpFxmiWVnni6UVbig1GhvMRSJGKlAnGcjEGFVbz2UVAtvBRhBjxqt8BSwNkZJziv0ko+igJcU/vKpgYASPCRKHH4jx+UxQ1YFQ/wxkLuS/qUOz3tftR5hDCEXiLYp/3Za3tUGRoH9xFMJvZyiXhelj9VgqAAe6MyBClrpaPFanSNRCB4KBGpN2i7jiRr2OF0eawylzOedHaq/SrWMm92WiDmNAKplIwWIj7Imv4iNbfgko4YPmtTe3OnXf9xyfb1nEsw3UCWjBzhKkE/bKHJ8pWexOfeZkQn/NHXMVTYWXh1Uh28TkJEbeJrCwbKwjgM2p9sJQGbHlEuzv2pMqHa9kQuvNZ9aY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GxU6pLMiSefO/pdu+7RSi+PXPM2USzQj2CfXOEXoHnzvglkMJeMbcx5LG5z5?=
 =?us-ascii?Q?SpWal3DYKZBpWdUQNgF8fPOEyjLfDmfjz8wQPP2uz70PEvxtg9kCUrM1utV4?=
 =?us-ascii?Q?TDIL28BOrKnmEnttJhHZG3g4PpXsOF/2s3WHevVgJTGG8VSPKD/eC2br+y1e?=
 =?us-ascii?Q?LkzpStECaQv8poGS2S4se7BL8+gG8v/3659QAGtYpKn6w3qv3iSB5FKEEDdY?=
 =?us-ascii?Q?PlBk0Vkcr+u+kk1NKFNp4/hsqfi5fy7J6tQhiB9E7FwO0FUC0p7qMj44HTPT?=
 =?us-ascii?Q?PRqFJzqLalpNX8Qd+o9I/Ge8BRXxrpCENsDL1v7Ss0NhkVYDh1y0l+CgOjvH?=
 =?us-ascii?Q?BP1lIpXnV0W7vnYZEBuZyHOT99zn0/25EKLF3bGFkgTYk+FMEErmc8F34deW?=
 =?us-ascii?Q?4Hp24taXb0qk+Vg9fyDi68nAxXJw2dK1dcsMnaqXvIP4OEsdZlIG5pS/TWV0?=
 =?us-ascii?Q?0QD/Zw1bom6n3IiM1WBi/ALlYr8glfNwdIfSyQIfmy0Pir2oVdmZeTD1tHW4?=
 =?us-ascii?Q?tFiNuPAClkzqdqHiQM+GRLrDL1cFMZOSQwZeVY+sVAF7z4HCW2svD/oCbqIv?=
 =?us-ascii?Q?YJlbWqJ1lYNNvXZQKMt9013wZ1tb3c3WnWwsSu2lTcOYVtwgmeu18CzVZCqE?=
 =?us-ascii?Q?/Fh5UCUuSrP/TKk66tyvTVvFWWbxTKF8iHJY6xjbdLVE4Vq9RAGiZSl5tm3I?=
 =?us-ascii?Q?e+xavwKkeEdTlSyG6TqlZoD3Jq3wMTSSCh+R56cmmZAQmvBNOKG8onFeO5QU?=
 =?us-ascii?Q?j9UfhjUzrZvQewlMYlD8cAQn21oJPWr1sSM/01J0uj1Af5ccPvjJPRgwQun7?=
 =?us-ascii?Q?qeaJmbMET7WMUjOEt9B4Hp3lDRt/Wqm0c1Ez4dp52qHkWDanA7wHCjWRwIrL?=
 =?us-ascii?Q?CGJNdcgyXNZ1reO1/jL5DqWqQswCxU26pL5H9WTvSzXO9ZiF+MLtkwDK0lZY?=
 =?us-ascii?Q?PL5Mencc9+sQjwgiqY/g0tE+2sL9qzr/vnbzAA865mRH1L1f4+ayIitdE3BM?=
 =?us-ascii?Q?MrxlmGpVLFyNaesWussUO12+qAyfjSX+ygCUpJkOHH2/hbxVKu16TmSfncMW?=
 =?us-ascii?Q?3xH3Os5GRKy8/eUZwdZO4Kgg1IMwVqAXyGZysCW5457zXVETehNULNRUeZZo?=
 =?us-ascii?Q?gHFCrPDaZObYUTa+RXMVj8kOjI8bMIZVPEsRW+Bk9UbdTzrz+4ySwaZkhn9H?=
 =?us-ascii?Q?1A4eaZgq19vkddubJtosf7PAVQhruvZtevPsGLxCr/tgZirsIdedrR3OWJAl?=
 =?us-ascii?Q?lr0JiIawgLQ0COFlzv01D3Q/+sGrHbMKVjBgqyll1NUwpK+TSdl2phFe1KF+?=
 =?us-ascii?Q?Z5MikSTxB0z1ZsguZPMM7y+htszg24ohe50edFpmm39rxCxQyGzP+bAhlqXv?=
 =?us-ascii?Q?rQ6A1xKI8JNmm+OiPD5p7VKZ52Q13yTUp8ZEdekn+/gsFSvCytq2etutkuVS?=
 =?us-ascii?Q?Q3ar5MFGYoiaz22iJwY3B1PhGZaVHrLlnWIz7S2/C+V4MzQbe3+2EBX5RKXd?=
 =?us-ascii?Q?1wxEfWnmQVbfHrlEDvFnbkuql2VV7Cw2AkTrTL6niMSWv7CgOtp4PKeSn6gk?=
 =?us-ascii?Q?TVbNZpl5daNQDGD/Kn8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5caee02-a4f2-4539-a0a3-08dc4406b335
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 09:11:14.6610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsgLeL635ixQvM40UXHFmUYyoyGDmy+2IszcowiCZoX9SiorXbNU6cstGaPWOw3d28AGJh0X0fuEVp0m5++wuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6210

[AMD Official Use Only - General]

> -----Original Message-----
> From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Sent: Thursday, March 14, 2024 5:05 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Huang, Ray
> <Ray.Huang@amd.com>; Petkov, Borislav <Borislav.Petkov@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 1/7] cpufreq: amd-pstate: initialize new core prec=
ision
> boost state
>
> On Wed, Mar 13, 2024 at 06:04:38PM +0800, Perry Yuan wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
> > Add gloal global_params to represent current CPU Performance
> > Boost(cpb) state for cpu frequency scaling, both active and passive
> > modes all can support CPU cores frequency boosting control which is
> > based on the BIOS setting, while BIOS turn on the "Core Performance
> > Boost", it will allow OS control each core highest perf limitation from=
 OS side.
> >
> > If core performance boost is disabled while a core is in a boosted
> > P-state, the core transitions to the highest performance non-boosted
> > P-state, that is the same as the nominal frequency limit.
> >
> > Reported-by: Artem S. Tashkinov" <aros@gmx.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217931
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 50 ++++++++++++------------------------
> >  include/linux/amd-pstate.h   | 14 ++++++++++
> >  2 files changed, 31 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 2015c9fcc3c9..ef6381b48e76
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -67,6 +67,8 @@ static struct cpufreq_driver amd_pstate_epp_driver;
> > static int cppc_state =3D AMD_PSTATE_UNDEFINED;  static bool
> > cppc_enabled;  static bool amd_pstate_prefcore =3D true;
> > +struct amd_pstate_global_params amd_pstate_global_params;
> > +EXPORT_SYMBOL_GPL(amd_pstate_global_params);
> >
> >  /*
> >   * AMD Energy Preference Performance (EPP) @@ -676,43 +678,21 @@
> > static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> >     return lowest_nonlinear_freq * 1000;  }
> >
> > -static int amd_pstate_set_boost(struct cpufreq_policy *policy, int
> > state)
> > +static int amd_pstate_boost_init(struct amd_cpudata *cpudata)
> >  {
> > -   struct amd_cpudata *cpudata =3D policy->driver_data;
> > +   u64 boost_val;
> >     int ret;
> >
> > -   if (!cpudata->boost_supported) {
> > -           pr_err("Boost mode is not supported by this processor or
> SBIOS\n");
> > -           return -EINVAL;
> > -   }
> > -
> > -   if (state)
> > -           policy->cpuinfo.max_freq =3D cpudata->max_freq;
> > -   else
> > -           policy->cpuinfo.max_freq =3D cpudata->nominal_freq;
> > -
> > -   policy->max =3D policy->cpuinfo.max_freq;
> > -
> > -   ret =3D freq_qos_update_request(&cpudata->req[1],
> > -                                 policy->cpuinfo.max_freq);
> > -   if (ret < 0)
> > +   ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
> > +   if (ret) {
> > +           pr_err_once("failed to read initial CPU boost state!\n");
> >             return ret;
> > +   }
> >
> > -   return 0;
> > -}
> > -
> > -static void amd_pstate_boost_init(struct amd_cpudata *cpudata) -{
> > -   u32 highest_perf, nominal_perf;
> > -
> > -   highest_perf =3D READ_ONCE(cpudata->highest_perf);
> > -   nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> > -
> > -   if (highest_perf <=3D nominal_perf)
> > -           return;
> > +   amd_pstate_global_params.cpb_supported =3D !((boost_val >> 25) &
> 0x1);
>
> Can we move the definition of MSR_K7_HWCR_CPB_DIS from
> drivers/cpufreq/acpi-cpufreq.h to msr-index.h and use it here ?
> something like the following:

That's a brilliant idea!
Let me add a new patch to move it in next version.

Perry.


>
> ----------- x8-----------------------------------------------------------=
----------
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-
> index.h
> index f1bd7b91b3c6..e5380cad903c 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -736,6 +736,8 @@
>  #define MSR_K7_HWCR_IRPERF_EN
> BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
>  #define MSR_K7_FID_VID_CTL             0xc0010041
>  #define MSR_K7_FID_VID_STATUS          0xc0010042
> +#define MSR_K7_HWCR_CPB_DIS_BIT                25
> +#define MSR_K7_HWCR_CPB_DIS
> BIT_ULL(MSR_K7_HWCR_CPB_DIS_BIT)
>
>  /* K6 MSRs */
>  #define MSR_K6_WHCR                    0xc0000082
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufre=
q.c
> index 37f1cdf46d29..7089aca6cc0d 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -31,6 +31,7 @@
>  #include <acpi/cppc_acpi.h>
>
>  #include <asm/msr.h>
> +#include <asm/msr-index.h>
>  #include <asm/processor.h>
>  #include <asm/cpufeature.h>
>  #include <asm/cpu_device_id.h>
> @@ -50,8 +51,6 @@ enum {
>  #define AMD_MSR_RANGE          (0x7)
>  #define HYGON_MSR_RANGE                (0x7)
>
> -#define MSR_K7_HWCR_CPB_DIS    (1ULL << 25)
> -
>  struct acpi_cpufreq_data {
>         unsigned int resume;
>         unsigned int cpu_feature;
>
>
>
> The rest of the patch looks good to me.

Thank you for the review!


>
>
> --
> Thanks and Regards
> gautham.
>
>
> > +   amd_pstate_global_params.cpb_boost =3D
> > +amd_pstate_global_params.cpb_supported;
> >
> > -   cpudata->boost_supported =3D true;
> > -   current_pstate_driver->boost_enabled =3D true;
> > +   return ret;
> >  }
> >
> >  static void amd_perf_ctl_reset(unsigned int cpu) @@ -855,6 +835,9 @@
> > static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> >     if (ret)
> >             goto free_cpudata1;
> >
> > +   /* initialize cpu cores boot state */
> > +   amd_pstate_boost_init(cpudata);
> > +
> >     min_freq =3D amd_get_min_freq(cpudata);
> >     max_freq =3D amd_get_max_freq(cpudata);
> >     nominal_freq =3D amd_get_nominal_freq(cpudata); @@ -906,7 +889,6
> @@
> > static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> >
> >     policy->driver_data =3D cpudata;
> >
> > -   amd_pstate_boost_init(cpudata);
> >     if (!current_pstate_driver->adjust_perf)
> >             current_pstate_driver->adjust_perf =3D
> amd_pstate_adjust_perf;
> >
> > @@ -1317,6 +1299,9 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
> >     if (ret)
> >             goto free_cpudata1;
> >
> > +   /* initialize cpu cores boot state */
> > +   amd_pstate_boost_init(cpudata);
> > +
> >     min_freq =3D amd_get_min_freq(cpudata);
> >     max_freq =3D amd_get_max_freq(cpudata);
> >     nominal_freq =3D amd_get_nominal_freq(cpudata); @@ -1367,7
> +1352,6 @@
> > static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
> >                     return ret;
> >             WRITE_ONCE(cpudata->cppc_cap1_cached, value);
> >     }
> > -   amd_pstate_boost_init(cpudata);
> >
> >     return 0;
> >
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index d21838835abd..c6e2a97913de 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -124,4 +124,18 @@ static const char * const
> amd_pstate_mode_string[] =3D {
> >     [AMD_PSTATE_GUIDED]      =3D "guided",
> >     NULL,
> >  };
> > +
> > +/**
> > + * struct amd_pstate_global_params - Global parameters, mostly tunable
> via sysfs.
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
> > +
> >  #endif /* _LINUX_AMD_PSTATE_H */
> > --
> > 2.34.1
> >

