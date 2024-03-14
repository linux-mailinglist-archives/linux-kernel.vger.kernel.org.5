Return-Path: <linux-kernel+bounces-103105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE9287BB16
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3595C1F22EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0712E6E614;
	Thu, 14 Mar 2024 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IlyQDSEM"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C896CDD6;
	Thu, 14 Mar 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411320; cv=fail; b=F1Kb9n1iMv50E1Uc2nnYn/wUIgKr6BU26+v4w0zoVbd6ORmdbSgZVITfC0HyIsQekCQhKJ9s4VlJY86wOATuRhIx28aNWmvNDsdkufeb331dfPu7SZoEd1ZHHXFWmiKPyv/en6igHhw8RDC1+sjzNPyh0hp+7meukzX/kLa5VMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411320; c=relaxed/simple;
	bh=J6jbKnki669PiEzctZd9/2zLXUxqXXgqWlHpQJVLzCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LWgQUx0peuqNmhLoP+MNY90DDHZS5TBUoolngzxyhROMy7V8ryGPlsvEbENKc+SkIPZy4DP/pOr74xTrxDHFu6sdIFSeLJGTUp/z/trgEVsim/npYoCgW++JbYO8rohrkREMNPP/HwbGauwVbLWAY27W94Uc64r1YmBSHYlAK8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IlyQDSEM; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jzi4bi+XO1vv0iCFpsrpkvyadva9QNXY6jlKXcOgqxDeg5h6Gq16haoyJfT05eKdXKzmCq6jyc/AY0cTC2QwbCHSxWnUiMOvF41P+IMMo6TZYV/oNNu6sMSxud2NaAOb3Lnk2lpZK+VgO48lzVSxfthmOAcbEQ6KI25f+AIBwZAxyyVupG72/ohhQQxXAQrMIkVgwTSryh3m4n1HDfJv5lWJunzX3yPo5U4Ckx3bOsqgpN/DOVLzMCW9yUoWKwpuvqQ97Awa2Ss7IC8U+nI8XP0bFbxH9J5k13jpcojnbCaWrqq3hXR6o/pRL5m4HKYWCCuE5Y7SwvXiJGWX/RYFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2npNS6sBt6md1UnXIX/MtsXBwSVhoQ7VDuj7jfhiq8=;
 b=ItCPYKSAVAtYjoWfooCX5DB/akl+LKMi8gESyr17yeoJPZgMn/MDumn+Nw3n2clauweeUxf1lFBdXL6GDzb/kFKWrijAr22mtL5qmvHoOxxDPxEQ9XNBd3CvANA4AYgWi+dJROsdXc6LzEs39R5XAK6NQl2Ksq2ZIy8Uf2/zz0+DH7bDcqHetfvaktGCznNynGvvxYLNkC6N+G3kUQhJBdkLFPAPpajVv88ZOhKiRuvskpA1+JS7vVrkLasNFrK69dXHU631pDppdRjKzhvmvSdUb/+WEiOSiKXoHMejHhHh+lfhpDxPivGc7MHiZQC+C3Wso5jVxQMqQq7koXBIAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2npNS6sBt6md1UnXIX/MtsXBwSVhoQ7VDuj7jfhiq8=;
 b=IlyQDSEMl0AyRVgEp0Q9xumGzLTL9zxYYkVPHO1ngGqGryv+wu8eC332xBm9apEvPZQv28Q5tZ+Xyfa6M5CMIDN8bBHFvPYPSp7KPyYqR6veq0TyyqSFPYh5P5YqHcTn8NK5L6Q34XxBR0k0ks2UD9cOWhm92Gvoq/h7IaZuHWE=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by PH7PR12MB7161.namprd12.prod.outlook.com (2603:10b6:510:200::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 10:15:15 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 10:15:15 +0000
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
Subject: RE: [PATCH v4 6/7] cpufreq: amd-pstate: remove legacy set_boost
 callback for passive mode
Thread-Topic: [PATCH v4 6/7] cpufreq: amd-pstate: remove legacy set_boost
 callback for passive mode
Thread-Index: AQHadS4eQHEd+FtCq0O58I4g5fFpnrE3BF0AgAABW6A=
Date: Thu, 14 Mar 2024 10:15:15 +0000
Message-ID:
 <CYYPR12MB8655EA9E757280E5602B73AE9C292@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
 <c9653c82afd9a11a7d3fa466f60d64d7e457968c.1710322310.git.perry.yuan@amd.com>
 <ZfLMSIptCObdf4pS@BLR-5CG11610CF.amd.com>
In-Reply-To: <ZfLMSIptCObdf4pS@BLR-5CG11610CF.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=57ca65f5-4925-4b7a-9363-83b6dc47999e;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-14T10:11:54Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|PH7PR12MB7161:EE_
x-ms-office365-filtering-correlation-id: 282385b5-f78b-4bf5-d093-08dc440fa478
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FTm/CMIpT5Nnu4Z6M3dH7+V+S0pXooGtS363mjb78IDZ0XZelnS9bAzs5O+DTh7hppdbNQbOC7uVjbk7Ocv7PJ3+XTWkQTZcstqxaqyIzumMjGN4wziRTIszfbH9MZiYtevEH/nKqaE/pYlTdLkTk4lZjAcy56NH6SJERBfQ5rVMiy5f1WiIqtwh/KnAhZ4f+2Jy/xwcVlqhcIk0Izd2eRBmdZF4Q/JOrkI+am1mb2oefVIhvaNefGKiuodgv1L+WpVt25rHGul0n3W+BIRIJE3Q/gbK8o92FH4hrEjevekhNjtpHO9r/1X5lP1qCjqFo4AZy4ezGB5VPoqgLrKo7O30Fy2wer1ZrLzFUNldBNvwVfzi11IpHA31XaTEjzJOOnObQZqKL6zH1Jmp9JpsowGLOPT91qjt0v2o9KU04aD/iupc7xpal7J30EQ8ENkQV5ed20pNXVWZWhbeFXvT22vLKpvTut8qsw96meFt2uAtsi9JpXrAGqIozj729cgJcqNBuQ2UQ9z+PqovwSQXuD44eUlNIvOOs7G5RxSWL+t19thuO4EU/CINnDIaYnT0T7zypkwNkDJNinA0mbZqk8ysefDBX+yZ6K+tB3t3VOZQxnOTqb0m3WoACdx9XsUv/6Pg2Lufwn5tk9DLRPr1TRcbeWUX422TFIX8EwVADQjPS1l+TeNsvB8r6rdK+vPyQtrRx6X2v6zVJOPjIzWXAQuyoecrkbzYlLny8wdZO/c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9o7fiZPWjzb2qo8Mt3Fw+A9JVczRuKpg5pXMrjWv4EtR+VE6Apy1ZQ3aPBCC?=
 =?us-ascii?Q?yEgtMsdz8iqZ4v8h7k9xAGp4nLJdnE1S2ioqpwA/y0TI7FKWUOKYYhGGmCVC?=
 =?us-ascii?Q?U3lrbuTaFDRiHGjiieMKFf1yuAw64LuyI5Qp3VVQTong4SVHHM0uSOWlmRab?=
 =?us-ascii?Q?JYst5NCvWG0qxuz+hxTydVuhx/4xC1RvEr9mcUi5sHnusZyNdK1GCbULRgC+?=
 =?us-ascii?Q?ZM7ZrVi4pcSF6D5kRTyoPeR2PdsfwsdPvPLz8K+0aglTHQpdHUcdb6nrdUFF?=
 =?us-ascii?Q?EvPAXWXlt2DzoWIoFY4c8VbYp2HqcGVmkwPNW+Eue0iWE9zNGEBxBx0HEBAf?=
 =?us-ascii?Q?ixUT6cd+lfN/PvynIGiPVhuA9YITZteUNr1WIC7/bnVfFYqUCpRCVB887v6u?=
 =?us-ascii?Q?F0qfM2+0NV3fByg/+aczLsbJC567+5fJDv2Hnr/311bdCztANf8SIMtWdA5v?=
 =?us-ascii?Q?iTUz6xL5MDTIMTIiRf584iwhyVjTYJqSY+1U8PzWNN0JjwV710H/DOh4AmbD?=
 =?us-ascii?Q?gSQQH9mBEz8yPwR2UbmrjDQrNCB+7afSuPj875WI3/Q+x4dAqtxfftwH8U7G?=
 =?us-ascii?Q?a8n2x1+7iS5mfaHYT7x4io2aISu4VNE9aqgMc1vwfDwb0I5ItdIcYoyJFQhv?=
 =?us-ascii?Q?D72emC5FkdI09l0FQXHYQEkJkK/yzsmICOqCbfU1oPcfWKwjMY0a2DCdsvNC?=
 =?us-ascii?Q?COOTjcNP8HS/9Y5Laiq+lBDwExX3HU1RRYLQFMUo+IJvnB1Aa5eVsAjA/WFJ?=
 =?us-ascii?Q?xdIXB6Zd5llAnv/MVFfo9HCngOVgfv/Ch+bsFE3Dl+Ohcqr1yWw+PVIkmhVh?=
 =?us-ascii?Q?UGNkgWJYgyScSyiPeWPZcabaEPP6m/8zPpFP6/ZIviDj95oXMOGnvc1Pax4t?=
 =?us-ascii?Q?+2hT+c4QTCLQ1PIZHWaSGG2By00viByUcW86VFEKi8DQRcf4gK/j26+E9ZiQ?=
 =?us-ascii?Q?aSywTDorYIuFVddkdMIFyqIrWLRR0zYACAi9CJSCZM0WN3YFVOM71othZT83?=
 =?us-ascii?Q?zwBbWh+S3dlm7gqF+9w7JrpobZSx8tUAGwPlunnlMCor02lfVMIq3PXfBdKS?=
 =?us-ascii?Q?m8YRc75Kb90WJSVlEuYf+eMXV9iMHcYLQ6CzWj9wPMMTvO+QCPvSavIb2Z1z?=
 =?us-ascii?Q?Qys6lZg8gFmouBanLXfM8nJFUbD6C7LqXovkw/Yms0MkQc4plv0diXuQhf+z?=
 =?us-ascii?Q?aaNvURGKOSwwP2/kb7r3Fp911LpxyefxXMYcmfE6DvMhqenTmxFbsPANF6JG?=
 =?us-ascii?Q?mYudKBwLHl0cUno135l9k5qEx4uu9T5dryrSzKULhxrIz/jXmyqeh78ZXvxJ?=
 =?us-ascii?Q?R90p4Ri5l0QoCIEkYJgK9FDfpmnsWiuZj/Ygbb3PyJf27K6gWl+xwLm7YtCG?=
 =?us-ascii?Q?0fDPa+MX69ft1MQihDzsMJ46j49I8c/2dNRxxuwkVrjOl8bMTii3YYFlYTkI?=
 =?us-ascii?Q?Mo+gl/nXYSLt3ugUiUUkpBHPBwLt1Rl1RR5plU7abgDNy8dI/Wko4jedheMg?=
 =?us-ascii?Q?9GW5O+BI67HlLTyL0mwH/930IoVGg0LDUbQGfq5Ed2f2pEwG+jNYrsFkdiPB?=
 =?us-ascii?Q?4LAXCLhKj93jQKvmhco=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 282385b5-f78b-4bf5-d093-08dc440fa478
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 10:15:15.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 81Pf5hvfkSRmjoNuZmkEZFiuTPSbLd7hkr2Kn1Ep1L/8w+mAeLFKreLCSVPkZdiyLXUGo+crDN8wYhYDB/BsKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7161

[AMD Official Use Only - General]

> -----Original Message-----
> From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Sent: Thursday, March 14, 2024 6:07 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Huang, Ray
> <Ray.Huang@amd.com>; Petkov, Borislav <Borislav.Petkov@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 6/7] cpufreq: amd-pstate: remove legacy set_boost
> callback for passive mode
>
> Hello Perry,
>
> On Wed, Mar 13, 2024 at 06:04:43PM +0800, Perry Yuan wrote:
> > With new freqency boost interface supported, legacy boost control
> > doesn't make sense any more which only support passive mode.
>
> Why is the legacy boost control restricted only to the passive mode ?
>
> Can we not add .set_boost to amd_pstate_set_boost in
> amd_pstate_epp_driver ?
>
> --
> Thanks and Regards
> gautham.

The new interface is more meaningful to amd-pstate driver, I would like to =
put the control interface into unique directory like intel dose.
There will be other interfaces to be added, put them into together is more =
reasonable to control and maintain.

Perry.

>
> > so it can remove the legacy set_boost interface from amd-pstate driver
> > in case of there is conflict with new boost control logic.
> >
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 1 -
> >  include/linux/amd-pstate.h   | 2 --
> >  2 files changed, 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index d7afbded6e3d..4a24db868cb1
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1689,7 +1689,6 @@ static struct cpufreq_driver amd_pstate_driver =
=3D
> {
> >     .exit           =3D amd_pstate_cpu_exit,
> >     .suspend        =3D amd_pstate_cpu_suspend,
> >     .resume         =3D amd_pstate_cpu_resume,
> > -   .set_boost      =3D amd_pstate_set_boost,
> >     .update_limits  =3D amd_pstate_update_limits,
> >     .name           =3D "amd-pstate",
> >     .attr           =3D amd_pstate_attr,
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index c6e2a97913de..7130b297c522 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -56,7 +56,6 @@ struct amd_aperf_mperf {
> >   * @cur: Difference of Aperf/Mperf/tsc count between last and current
> sample
> >   * @prev: Last Aperf/Mperf/tsc count value read from register
> >   * @freq: current cpu frequency value
> > - * @boost_supported: check whether the Processor or SBIOS supports
> boost mode
> >   * @hw_prefcore: check whether HW supports preferred core featue.
> >   *                   Only when hw_prefcore and early prefcore param ar=
e true,
> >   *                   AMD P-State driver supports preferred core featue=
.
> > @@ -93,7 +92,6 @@ struct amd_cpudata {
> >     struct amd_aperf_mperf prev;
> >
> >     u64     freq;
> > -   bool    boost_supported;
> >     bool    hw_prefcore;
> >
> >     /* EPP feature related attributes*/
> > --
> > 2.34.1
> >

