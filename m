Return-Path: <linux-kernel+bounces-102865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8243687B7D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5FBB225FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B920310957;
	Thu, 14 Mar 2024 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KmbyqivT"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746010949;
	Thu, 14 Mar 2024 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396570; cv=fail; b=ASzqZHtaKP4iPa/Tmrmpxdk3dPrtcVljz4JAQkoX3QRNvff4j7i7KyCSuYFg5+Nhi7CxsyWIAgP6wJq3oqWhPX8jOEcHA9zGebe3yblYCywkG0urPTBUPX/s50jRwqApuWVc5RRKm5zI6NFgHaNOyfeBtnzmj56gYMXlGKfkZdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396570; c=relaxed/simple;
	bh=98tPdyTJiO8QRa24JFCH4uBCHVs8sdlePd5w2Xnw7NM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WE7oieS3XLBssYZoO+OC47GLVb9x6No9piIdPGsQUB7TxTiXgTABedBzRvFmkE6mqpJypnC5WGDDv0L5CpizifE/idRFkpa9NOJ2aD8OmMifLRjozMVH4OwJKiQu1/fspKAlFVjea1NRkqVWgGiDXFpcBbRRMcUragjX0NtXNo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KmbyqivT; arc=fail smtp.client-ip=40.107.96.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLVw2bNQvA2/17U9By7XHZkNOuGBCPVfWoVyB0ZcepLji97eORI6c5S0qxmwj9Gh9pQFgGx/JRkIVQh7knxWf71L3ekSFN3fvs9+K6kvdb26tvmP44kNXwQ16Eqim402e+RIaHb6l97gjJ6s+w7sU1IG51zQA38PyxiYaSVi9NUSQTO2dgeZiUr8X6UPxuELQEmTxSRxQsr9S579GCZeW1Gws/YdU3CguEujU9f7roE8fIHWaCbHXStgPCsrV1k6g2hJv9FKUnw571Okowk3rzBHCvCZ9KqvF7sBEssu9vSaeHkW6IXtFu2w/ZBgZLNz/lzHN7+0APzEjA+wQjIITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+T4pd+wI3Qld/npArqaX4C7kEJoXj/Lj0fYPZZuk69Q=;
 b=LrcivbPioxtWNXNBZbxkIPNgbjzoQvvVh2Y5cpq3fIx9TO07S7pex8sm1q4sKIxpciLfZ6t4YZcOy1bwy2PGxnIt0HgidLbXy0surRgL18iukJ1RVGHbER2FGVj4ORMIB0WrMNUFMV9Qz/7CfU9OWkF0FZn3GfzIuZTfbucU7bihuzDR0YCvWhqHwp1NakNHJPcYlQm+YMH0K/sJ4DHZOXq6eJizUPkXaSob+82zE7Oz0GJCj1iSRCWfCroMJLlY0dsiUDqo2GP5GX2GMIRO31bOyfJ7dA3TGmo0LnAsn9HPuvHoJ9f2h8XnsNXQaqOj3Dhh3C89hPzI6A1/u/uYBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+T4pd+wI3Qld/npArqaX4C7kEJoXj/Lj0fYPZZuk69Q=;
 b=KmbyqivTaV386C9ftnAm4M8zziVWy/GrAzM6c/Z4PJlUI4Fag/Aqqj42nJ32d0p6mXzaQgvaNYBpIfj5kmPepd5Gy9KvrWcBL+xZjh3p0rWLN1EJ3FCMSJY6+5mCZxltVkj5s6Vw8YcLJ9l7/WXp6G5J49XT14gfR8VfCMptW4o=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 06:09:20 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 06:09:20 +0000
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
Subject: RE: [PATCH v7 1/6] cpufreq:amd-pstate: fix the nominal freq value set
Thread-Topic: [PATCH v7 1/6] cpufreq:amd-pstate: fix the nominal freq value
 set
Thread-Index: AQHadS1cQ+6BG6MgdEa4KJHWRzpmg7E2vEOAgAACa/A=
Date: Thu, 14 Mar 2024 06:09:20 +0000
Message-ID:
 <CYYPR12MB865539EE324D834EF5051A679C292@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1710323410.git.perry.yuan@amd.com>
 <08ed1f9f76a6a1c401efd8f426bdeb9681c4b4e9.1710323410.git.perry.yuan@amd.com>
 <ZfKPy7hlwiYm++AM@BLR-5CG11610CF.amd.com>
In-Reply-To: <ZfKPy7hlwiYm++AM@BLR-5CG11610CF.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=50bc6ddd-d363-48c4-b0f2-be1022208f80;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-14T05:57:37Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CY5PR12MB6551:EE_
x-ms-office365-filtering-correlation-id: 277b8399-6ccb-4c6c-64c5-08dc43ed49f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EGINzYFrrdpQ76OxXOG4RgPdneTus1BnfmBEIm2t9oLRl87RUPuKLwQcnI0YthL5l1PMbX48kYSxGzyjBT/Vf1ZiK7AQ1HlgesRFqWmkiNy/VziObVdPDLI3u1nNI7Sl5Of6uev5skc9aOb5/yHJCEHVd697/IViAYWKyX9AJTzhIzULa51AHgRSE/g9pulFWPl4lkCHCrdiq8H/XJxsvsBb6E4t0x2nIWQXn2wkpiu4l4qodpofxbPBo1mtcFkI5Zr7S7D0la9yGUPCYJerJE/NN2dLKwztPfgtzDcVXycR9CY+MJB10llzBDLMIFCI5TY8+aUlBeGEVoiTpUBsE1ARdjQIB1zQs2KTo7ohpypwkYJqQ6D4ypVOliXiEIU37LrKXEWFWL732pulVN0Vf2Xb8S6FBlyh6pBkGWBdWxGYROaouSU2Rb5Qr8FG9o+5NreqTMPWLlvwqWBvj+aro+Yjh9Uhvp2VtAtn6WZ5nRqTT7ZrCnEORq2IpHiRt/4ExusVmfvU08aVUv3oLWeZfB7vbNQr2AOtReGq9YOsb9U24FGH/FECySAT4QQJ4oE4PAMe92SlohR70WpL1GlMjgK8ksm9Sa6euhBznoTJZLf2IBSJKOyNLbRf9hNkPn1kG3N2pjBOyr59II+f2VdaTEnikGZG3IndPM+lSnjH8NKZWs7QpLMuBs+ISA5za6Jb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fyOD3aDIzkPb5daOXfMo0LKcp7YtsG0EyJxgDC9/bH5/1uvOu+huZei1Cioe?=
 =?us-ascii?Q?0If95W504UqRCEfXZdDv+pLYBXSldtJ8i8QGadXf0o6EFg9xe+EyYC2qnV92?=
 =?us-ascii?Q?poF4hSRYB8VULld10T4ZvNMLx5IJbVahfNe0zA0Hdnl6jyMnbUm4HbmKqFi7?=
 =?us-ascii?Q?lw0mCKBriw9xjB14L6/TtMxgjIBtc+uJx+gxbS94UfdKU3UE8e9Y5AGYs43R?=
 =?us-ascii?Q?mlyMeau4eIop2d3P0YVUUgt3EkJn+39s63fzhgIi6K5iywbONOQuijrzr0ol?=
 =?us-ascii?Q?0BTmHRWzEx++6T6+hP5qR+vINWCRH3Y1iWYsL8gAYuI2zrfCPOb0i6Ba1PZk?=
 =?us-ascii?Q?p50ia5nDnbeNkyJM8k690zpai8TBBUC6WM3yqO/yh8DD9tmLjCLfJALTapau?=
 =?us-ascii?Q?RCLQEgUfiqZLz+J8MxpTuHANhVDeR/kM4Mbj6z0inAZbn0oqyLKO6mvKm7t9?=
 =?us-ascii?Q?Vf3YlwDYU+KynWGTvhG3ESK6g2NJLGX0fTjwTC7I1odYQH4VI8L4CuVb3wGL?=
 =?us-ascii?Q?Kaq1z+VyO+b4itpPZ9G77zMTyIFpxBj24Xqhr17fAM7lxI05VWL0Zjyaz4lt?=
 =?us-ascii?Q?8AhJ3seq1PzE6zu7++PtYw14uWvSXYWN04mvWw84EXEsTvZeuFfhIocOd+t2?=
 =?us-ascii?Q?iJbEaPxNFn46WEKkFMTH78k1adyXopTPpWm9uZbIKs302gHBxbk09ZDYQj/Q?=
 =?us-ascii?Q?4F4IfE2jfWK8YNdqVf6PyFlgjp6R8cxVk6hUWlVze06FhwMJAmbhQppdaVWl?=
 =?us-ascii?Q?x8TpE9zLXIOrxT5aisj/8OlwyFI4C5fEvGzB3fvfieu+sKUEsH62nJ0fX1U5?=
 =?us-ascii?Q?vy/8yRU+ACK0tGvQxPlygWWWk4N4J2HuWNKbAIoaWWsLUrOd+vKzxE3eMRof?=
 =?us-ascii?Q?KgMUUb+2sfnmqPH+27FF5/8V+AKvRcVghpi6Zi9At38dFh43tHJHFNls8pJU?=
 =?us-ascii?Q?ia5ksjX+WPQMOw0JmV40hymLxB3TILyuAVySDSN/CFwqpVLd/FTjcVVQ/5wf?=
 =?us-ascii?Q?G8ubihHpLJfO3xYTLQpxA2GBsvUvRn0tJMwAGkfbfkw4yuxKbVQH2MsufEKI?=
 =?us-ascii?Q?IAw5OqqHosGbA5oc8JQ0r0QV9MPj3ThDFbtFlwbYvnSkKA2LQSV8Iye0bge9?=
 =?us-ascii?Q?5jtizNGw5yN9nPN9rGOtn8jnT5hBe08vGy38lhpxcZmMfbi6cicKoSFbFXbD?=
 =?us-ascii?Q?l/meqAIjQe7gBErNfn7+YGQPnpIVmtI5LPbI1dBD8yT0ARaqlNU+aNo1o2KN?=
 =?us-ascii?Q?vbKaVGsYgwffEcJO/aNJ+vdeVKssO42Kr47DlhPDSzRW8hiKUn3tTCp7MsCa?=
 =?us-ascii?Q?rAb+9iCxLM3YzoizLlcbCNL+dPXgcnpUW0h1+otqObS4WdSGfOsPI28SmFP6?=
 =?us-ascii?Q?GQFcxNXlWTB7obeWLETjUpbiq4FAwbmTkLDuJzvP18iArvHNQCiOGQeAqoxN?=
 =?us-ascii?Q?xemqkn7XCQLyo6waHCPgVlWTXE7OMGGi61r1vvTdBlHjyk8e8ilF5m3s1MPW?=
 =?us-ascii?Q?YI0BLMQa/Nuy1hohtrOwAE0bycwqJnCIcDNWNhVk4Y8+MucndGiBoHPpHtlO?=
 =?us-ascii?Q?6CazyHnjBmUtpgWoJYw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 277b8399-6ccb-4c6c-64c5-08dc43ed49f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 06:09:20.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8DYLYgIINGZzDowSB/rka5BcLgvywpqcNqCy+Zu772MJ7gXzfWnwdQQIwv4eqzM0hbwx4BHipXnGM6byZodrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

[AMD Official Use Only - General]

 Hi Gautham

> -----Original Message-----
> From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Sent: Thursday, March 14, 2024 1:49 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Huang, Ray
> <Ray.Huang@amd.com>; Petkov, Borislav <Borislav.Petkov@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v7 1/6] cpufreq:amd-pstate: fix the nominal freq valu=
e set
>
> Hello Perry,
>
> On Wed, Mar 13, 2024 at 05:59:13PM +0800, Perry Yuan wrote:
> > Address an untested error where the nominal_freq was returned in KHz
> > instead of the correct MHz units, this oversight led to a wrong
> > nominal_freq set and resued, it will cause the max frequency of core
> > to be initialized with a wrong frequency value.
>
> As I had mentioned in my review comment to v6 [1], cpudata->max_freq,
> cpudata->min_freq, cpudata->lowest_non_linear_freq are all in
> khz. With this patch, cpudata->nominal_freq will be in mhz.
>
> As Dhananjay confirmed [2], this patch breaks the reporting in
> /sys/devices/system/cpu/cpufreq/policyX/*_freq as some of them will be
> reported in mhz while some others in khz which breaks the expectation tha=
t all
> these sysfs values should be reported in khz.
>
> [cpufreq]# grep . *freq
> amd_pstate_lowest_nonlinear_freq:1804000   <----- in khz
> amd_pstate_max_freq:3514000                <----- in khz
> cpuinfo_max_freq:2151                      <----- in mhz
> cpuinfo_min_freq:400000                    <----- in khz
> scaling_cur_freq:2151                      <----- in mhz
> scaling_max_freq:2151                      <----- in mhz
> scaling_min_freq:2151                      <----- in mhz
> [cpufreq]# pwd
> /sys/devices/system/cpu/cpu0/cpufreq
>
> What am I missing ?

https://lore.kernel.org/lkml/42a36c7f788e0fb77d4be7575aab9c937e1773de.17103=
22310.git.perry.yuan@amd.com/
Changes from v3:
* fix the max frequency value to be KHz when cpb boost disabled(Gautham R. =
Shenoy)


The previous problem has been resolved by the new patchset of  cpb boost su=
pport

+       if (on)
+               policy->cpuinfo.max_freq =3D cpudata->max_freq;
+       else
+               policy->cpuinfo.max_freq =3D cpudata->nominal_freq * 1000;


The frequency values of cpuinfo are correct on my system.

amd_pstate_lowest_nonlinear_freq:1701000
amd_pstate_max_freq:3501000
cpuinfo_max_freq:3501000
cpuinfo_min_freq:400000
scaling_cur_freq:400000
scaling_max_freq:3501000
scaling_min_freq:400000

Perry.

>
> [1] https://lore.kernel.org/lkml/ZcRvoYZKdUEjBUHp@BLR-
> 5CG11610CF.amd.com/)
> [2] https://lore.kernel.org/lkml/1aecf2fc-2ea4-46ec-aaf2-
> 0dbbb11b5f8b@amd.com/
>
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ec437d71db7 ("cpufreq: amd-pstate: Introduce a new AMD P-State
> > driver to support future processors")
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>
> --
> Thanks and Regards
> gautham.
>
>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 2015c9fcc3c9..3faa895b77b7
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -647,8 +647,7 @@ static int amd_get_nominal_freq(struct
> amd_cpudata *cpudata)
> >     if (ret)
> >             return ret;
> >
> > -   /* Switch to khz */
> > -   return cppc_perf.nominal_freq * 1000;
> > +   return cppc_perf.nominal_freq;
> >  }
> >
> >  static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> > --
> > 2.34.1
> >

