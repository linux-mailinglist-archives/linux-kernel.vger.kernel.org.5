Return-Path: <linux-kernel+bounces-153126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1468AC9D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CA828366E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781752F96;
	Mon, 22 Apr 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qdnf1JPZ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C5513C3C5;
	Mon, 22 Apr 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779449; cv=fail; b=YyNWn2vqZGXyh2uH20wPcuskprUxWY8W04xoHOzkSlPRQ7sEqNEqD1OOAxUoFkSIoRKtvevAMyHuuGcDIXTzadsNNZmY3fl4Rr8VCYwuxN7UCrLJ/IvjoqJg9i5F+6DwOI3nFs097Uq9dljCCS5aL3LJ1DU5UPhCocFJ2qIlTjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779449; c=relaxed/simple;
	bh=Ve5I0wj/HxT2sGEEPVZZw4yyViezjLu+NCZVQLQDV6k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r4Az+C2wnGLqzlKNTUVgzIX3BcVpY1mJqd/jo47OtxP38fyowgJZ774YeWD8K8PNcJvCIV9ng/bwuzGfj7bHDNkAVIJnk7+sxaWefxRRw1KkD/UbQp06YIMKnYGY4c8WG0gKfaE0fdDGqJkvKJQJTzegE5HZvqUYwv5pxtySmOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qdnf1JPZ; arc=fail smtp.client-ip=40.107.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJa6nbk8fqgU5f1iIoxl0j60A1g5Otx0fVZBObf/0eZiYgX9mjOxtkWFyrzhqN1L6U9G18DGmPUirOXWuOxznOrEH6GvdylXCc7pVlA/RyZKa35+Kh2kQVB1hpQQbkufd/wiVV/xeZlUsF6OkzHph+ttM1ZGHQDpcCJqmEToZSs5YAkW8bLG6SEb5Xp4TkJRYfTKq3GZczdkGzK0W6bVKzJMcw0QflgsBAZ1Pg4+sEfE/Qr//+CtUY9ljtSEr+fIMb2lm7S37MA1Sr2T/LOP9stEfTPsAbpzVoRDDHI9RMJISUnPmlW9qdgCOXM2nZIfVa4/XGvfxy+rDk3HR6KXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m625nQ07ZAr/EEjlTKnhz6Z06yEKg6Qd1k2JQi15UcY=;
 b=jVGTUCxaHcf/ZrXquJ02STA2/Eyz2Cer+A06LQyxJt2+PJqEtHBp6qSX81qkdejpuopdfFha/gh4G5xCwaNFdJr7qLt+VEVDxsc7QktUCUZ43IDI9MwevpK7Nn1qnNxH4YG+Aywqj3uT6r5C2seMtoeY+qaY4rJGxT/lQ21z7VbIjTEp07earOOg+jNF5itV6sIEIaxNo2o0E++iZmNdQrKl4HOjL4gKxRFuNix8RJml+VXsGbLebRKke27C0IjgAT7eLequsq65pJuxozN/4pudIex6eoxAd+vCk484XX8ALC4Tw0ufGWUZ87mWEuB9LLrXrAZO5hN+P2QBV7WyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m625nQ07ZAr/EEjlTKnhz6Z06yEKg6Qd1k2JQi15UcY=;
 b=qdnf1JPZXv4Jf1PfkI/dKq4zkG2YE8IpS1kggekdrwnfbCQvvLRC/BaEUevzjApjtEtq+gSf96+R9swBZBilyuuDAKdVfhGkqtSP+Uobs6RFZs5V6ZtlkO0ypaEcO+E2N78OIUjywC5EUlq6uWJMRSY7s/MstJjsBY1EZs37G5Q=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:50:45 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:50:45 +0000
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
Subject: RE: [PATCH v10 8/8] cpufreq: amd-pstate: Add quirk for the pstate
 CPPC capabilities missing
Thread-Topic: [PATCH v10 8/8] cpufreq: amd-pstate: Add quirk for the pstate
 CPPC capabilities missing
Thread-Index: AQHafq1vWWXgVJRqCUK/nPdB4z3FMrFpkmIAgAqjlJA=
Date: Mon, 22 Apr 2024 09:50:45 +0000
Message-ID:
 <CYYPR12MB865553F67A7FF17276F7EE289C122@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
 <31afd5ae23f8b1d7c6a2f0efe593a368dee61224.1711335714.git.perry.yuan@amd.com>
 <Zh1ExGtyhGOsduOs@amd.com>
In-Reply-To: <Zh1ExGtyhGOsduOs@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=54f4da79-ca97-40ea-af6a-1d63228285fb;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-22T09:44:23Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM4PR12MB7502:EE_
x-ms-office365-filtering-correlation-id: 84173553-a321-4c2d-fd24-08dc62b1ae2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XMfPVEJUv8D7BcG4hmw7cLo8//rXJLQN4NBteU+i8N7+M03MbEjFMbXlWHwO?=
 =?us-ascii?Q?bBqmyInEnEx5K75oQQfcmQbIV3jvt5IHLRqGyODotNe3KAtiBJwUqEwfGmfx?=
 =?us-ascii?Q?05LVdZqSvMexyjdn7Y8pE+wuJuVj+o/85YH+edtSMxfaKGP8sLi3ex1xCTvM?=
 =?us-ascii?Q?K7e0selDQBHU+epmEUbQwFooY1+pwoplr27QgmzduAONGcSmQXAzDth2ofnX?=
 =?us-ascii?Q?Nh63IYcmin/x1bau3U+ljCUoTGhNVyOUkj6/2cgnGBap7XExRekCl8nxy30N?=
 =?us-ascii?Q?h+KR0q6rrJMMXWNF+bf4Dhv7Kw7rZ+39Ag/4kRTLhPxoHFTmyROhWYMLq1Cm?=
 =?us-ascii?Q?nqn6hpIxxg/dRfTqyqmh8eR4WJODi7qDWuFIi/vfmNznJxeZuxZMPZf8rxIL?=
 =?us-ascii?Q?PU8cro1C14kCcBElppo78Y3DWrQ0EuxVJcHQBt331CIiD1jsJZo5WkYfqsWC?=
 =?us-ascii?Q?vDf/QpEGLw3AmTx3d4C5JHSIMOBYgQhS/QrWlUs4/PGEW/3hlByBS2zrij5c?=
 =?us-ascii?Q?5oRrHFP2Trema/XpojepQX/KmisQ4ATeG82XdCV3PUf7w+dxiRIj+97hhE4p?=
 =?us-ascii?Q?Knizx/8pSggW6FEFOFPRO9FeN5O3T+qjLo/IDxC9V4/AcrETByQHfuZRJfxi?=
 =?us-ascii?Q?e+TGR7y11V2duCei5jPhr1aYhZNUScfK+EFwTH2xVbrNMFaTw5t2DzRIyfP9?=
 =?us-ascii?Q?rie357tZLIHmeYbKOBxoESvx9WOlTsjM2oORdn78syvFfFyKNZe4eIQYe+2B?=
 =?us-ascii?Q?XI6QROJeqOZURHgPsDhYZkyuI1WSCdYlK+TxMtKQ3aAXuoYM5Nu1KL7UJ3ia?=
 =?us-ascii?Q?2PyOmov4I6YMy3k+zDbyymaDEMjRPyo+CCjia2yBYcRuP+8c/+Tts2V55A+W?=
 =?us-ascii?Q?AKEAZsfjMe11RB9YgfR062eqdRP3vGREVD3BHwzXvHRQsJLsFkvgK5KAQwni?=
 =?us-ascii?Q?tCeOILo4DvRw2wBhkqtKIEy9QDadgxzM1/lRazCiD2niyTsdTOVovhClE9gC?=
 =?us-ascii?Q?JTSvqAbCygzgJlgP65S18niI4x7ZfBDb3SN52iwMnNWhKgYh4guX+FMXeOVy?=
 =?us-ascii?Q?VNoAHCHQkcCM3M57sv2db6nL9LBQEcRTA0XEKMNkDpWulg8UnrzEcwlYeIdW?=
 =?us-ascii?Q?17rUERsYnVNtQZwm1ZfHywjKQty/sADBI1n+Cei/qsok8sXUsGswcZxs1kuU?=
 =?us-ascii?Q?NxhxRrfkFC6IO83jNdsjY7ZUY/f5HDS8P3arMxKLV1HC88ifTST2LQbYtCV6?=
 =?us-ascii?Q?ZHL6mFdEN97fWkO1PovP+5jcZmNNG4Qyp68VAao6rudzFNpFRrUFdErqCCpA?=
 =?us-ascii?Q?KGt6zUvKO5slyBxuYThjf492mVN2tvwpDYtdmtSeFo/Y6A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KAkRWpR/ZZbzMmn9ednMB9Y2J15nG9gyd115dS4K9jsEgpeSigP14pqjKYPe?=
 =?us-ascii?Q?WcH4V8bVylSxoJ9rOQe5j2v4dLkLtnRWc2MSLE/OJl6MXatww448dLLj0KMi?=
 =?us-ascii?Q?0I4Us5bESGqfpigsIUNJnklJOy3ExOEN6LSRMBeUTbp1MyJuoswvKMxRfZd6?=
 =?us-ascii?Q?nj3Rt9ApAe3fEY7h3nI06qowtVVzlT9GYabbIyo3moQhtKPUrU/eKn2b10ry?=
 =?us-ascii?Q?Wiqd5Anoe58e+kjAHflr2THwRJaHWPKDztq6TVJYBmAm3EjAnJUC1k8/yyi5?=
 =?us-ascii?Q?Xkn6SZR7g6NRnxhz0mLIDtR0A2hs/GfCedVcjgU7PlgGtGfp4RNALSBhmKJ8?=
 =?us-ascii?Q?Xb3tOEFWQ4U0sqC1hb8/PvyNgXKNRt8awoaQ86N2qj5p/uDu81n9hm2xBmK8?=
 =?us-ascii?Q?N6CBPOO4VavyVhwEg/POgJJSH0nWtcr5LscwhURfbfR6CzUcAj8Fat7g7x/h?=
 =?us-ascii?Q?F3XgFKeUkqxSep0XynO5MBQnrf4OwEmABqJzbew8ON7sXcy+gMUwpdsd3Nux?=
 =?us-ascii?Q?zgSbaAEMalpYkdWLkATwR48jxHj67lf4H+70NUT6oK/ynn3xm74HCS2y/E8C?=
 =?us-ascii?Q?G5onEJDKvzVDcBbcCMSXvtazSyUDVW4lQ2HrivC3AYLptZpGWe4qwLuDY3cN?=
 =?us-ascii?Q?oO0qjxZf5/C64LLw+HdQ7fR4TFwAYiHpLxl3fvnUiynhfELirdYg66e6ocO+?=
 =?us-ascii?Q?tNs+UcG14YoXOTXoVnoBIAVJnrENhimGvzHBYixqGQ9F3DXyRUQy2wfMvxHs?=
 =?us-ascii?Q?1ch4UQzih4hSD43ndb8f+k61hsbC3QS5PZZz5P8oKTt0MlQDbRsH+lSMjhx1?=
 =?us-ascii?Q?oNQ66NmKRSDIQwFyAPZuw2HjP4ZQofFYac7o0pEjmHyjPGEx9zxbT2FkYYwc?=
 =?us-ascii?Q?wKX6MpE/KgIZZJ3Ln9ijAkahQbcvMvn4U0iPX+XPWLI4/zk7RPN1QMxyoczY?=
 =?us-ascii?Q?hRsKH69HrdgLkkY1vjZibhAcByA+hKK7YMaSHNggW/NQSNZ47kfrQ8qOSY/i?=
 =?us-ascii?Q?+htTRtWlavGYWM00PbCuePfMUBqXi/UrjOlg7NIGtHZ13V8hYRAD+Lh9E1ze?=
 =?us-ascii?Q?iKryMovyaSOEa3pXu2HvNgnRa6PFZwP6zS9+zquThelUENKBc6zXQ8Jz//dv?=
 =?us-ascii?Q?LJWL+l9VSBP592pXEc7zwbFAaYeJCFIWWuCOgJFBgkWcKCq4Ok2jFJwArTSp?=
 =?us-ascii?Q?rYrYZ0y8kClmjpJhHmk4dzLsZzl6BsC793pMLhQQUQLfxvmcC5r+HUIt4Xkp?=
 =?us-ascii?Q?AQ/W3859dCzLFN+xoyeS/XGXHnd+hDiOcf9XMEw+5aLLV0zJxNHGNbKOSPY+?=
 =?us-ascii?Q?/pWACekCSLO17VWX30EdaWiiybPsONOB3QPLVDs0z8hkJQemjf95b5EBTB+H?=
 =?us-ascii?Q?l6c1wKOmEiRpXbXY2y4N8sLwqV9FURJK/DbeWVHlw4A9ZvOuou0ZXGLzboN1?=
 =?us-ascii?Q?rUtr/fyKk1dRTe4+oNgb4oQofQf8CRYLe0SswIEAezc7I6F1mjLSGHONPDUX?=
 =?us-ascii?Q?J2Yh2pNMUTGcw/i/D36BUfR7yE4mDLRGzFfSm1GbZonJ0ASzqqIiK2h195D8?=
 =?us-ascii?Q?YJsFlvwHJmqF4bFeea8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84173553-a321-4c2d-fd24-08dc62b1ae2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 09:50:45.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXbKQA7D8pUjvUGcnl1D49IasE2jeIYmS5uJ/13sVcbGAhO3W3YzTx0hTHQhcGz6f+T+NbGcF2eRo87Y6CXxVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502

[AMD Official Use Only - General]

Hi Ray,


> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, April 15, 2024 11:16 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Shenoy, Gautham
> Ranjal <gautham.shenoy@amd.com>; Petkov, Borislav
> <Borislav.Petkov@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer <Shimmer.Huang@amd.com>;
> oleksandr@natalenko.name; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng, Li
> (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v10 8/8] cpufreq: amd-pstate: Add quirk for the pstat=
e CPPC
> capabilities missing
>
> On Mon, Mar 25, 2024 at 11:03:28AM +0800, Yuan, Perry wrote:
> > Add quirks table to get CPPC capabilities issue fixed by providing
> > correct perf or frequency values while driver loading.
> >
> > If CPPC capabilities are not defined in the ACPI tables or wrongly
> > defined by platform firmware, it needs to use quick to get those
> > issues fixed with correct workaround values to make pstate driver can
> > be loaded even though there are CPPC capabilities errors.
> >
> > The workaround will match the broken BIOS which lack of CPPC
> > capabilities nominal_freq and lowest_freq definition in the ACPI table.
> >
> > $ cat /sys/devices/system/cpu/cpu0/acpi_cppc/lowest_freq
> > 0
> > $ cat /sys/devices/system/cpu/cpu0/acpi_cppc/nominal_freq
> > 0
> >
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 53 ++++++++++++++++++++++++++++++++++--
> >  include/linux/amd-pstate.h   |  6 ++++
> >  2 files changed, 57 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index ec049b62b366..59a2db225d98 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -67,6 +67,7 @@ static struct cpufreq_driver amd_pstate_epp_driver;
> > static int cppc_state =3D AMD_PSTATE_UNDEFINED;  static bool
> > cppc_enabled;  static bool amd_pstate_prefcore =3D true;
> > +static struct quirk_entry *quirks;
>
> If we set quirks as global pointer, while the amd-pstate is uninstalling,=
 should we
> free the quirks as well?
>
> Thanks,
> Ray

In general, if the `quirks` variable is dynamically allocated during the dr=
iver's execution, it should be freed during the driver's uninstallation to =
avoid memory leaks. If it is a static or constant variable, it does not nee=
d to be explicitly freed.
In this patch, quirks is used to store the pointer to  "dmi->driver_data", =
 I will add your ack flag for this patch if you have no concern for this.

+       quirks =3D dmi->driver_data;

Perry.

>
> >
> >  /*
> >   * AMD Energy Preference Performance (EPP) @@ -111,6 +112,41 @@
> > static unsigned int epp_values[] =3D {
> >
> >  typedef int (*cppc_mode_transition_fn)(int);
> >
> > +static struct quirk_entry quirk_amd_7k62 =3D {
> > +   .nominal_freq =3D 2600,
> > +   .lowest_freq =3D 550,
> > +};
> > +
> > +static int __init dmi_matched_7k62_bios_bug(const struct
> > +dmi_system_id *dmi) {
> > +   /**
> > +    * match the broken bios for family 17h processor support CPPC V2
> > +    * broken BIOS lack of nominal_freq and lowest_freq capabilities
> > +    * definition in ACPI tables
> > +    */
> > +   if (boot_cpu_has(X86_FEATURE_ZEN2)) {
> > +           quirks =3D dmi->driver_data;
> > +           pr_info("Overriding nominal and lowest frequencies for %s\n=
",
> dmi->ident);
> > +           return 1;
> > +   }
> > +
> > +   return 0;
> > +}
> > +
> > +static const struct dmi_system_id amd_pstate_quirks_table[] __initcons=
t =3D {
> > +   {
> > +           .callback =3D dmi_matched_7k62_bios_bug,
> > +           .ident =3D "AMD EPYC 7K62",
> > +           .matches =3D {
> > +                   DMI_MATCH(DMI_BIOS_VERSION, "5.14"),
> > +                   DMI_MATCH(DMI_BIOS_RELEASE, "12/12/2019"),
> > +           },
> > +           .driver_data =3D &quirk_amd_7k62,
> > +   },
> > +   {}
> > +};
> > +MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
> > +
> >  static inline int get_mode_idx_from_str(const char *str, size_t size)
> > {
> >     int i;
> > @@ -812,8 +848,16 @@ static int amd_pstate_init_freq(struct amd_cpudata
> *cpudata)
> >     if (ret)
> >             return ret;
> >
> > -   min_freq =3D cppc_perf.lowest_freq * 1000;
> > -   nominal_freq =3D cppc_perf.nominal_freq * 1000;
> > +   if (quirks && quirks->lowest_freq)
> > +           min_freq =3D quirks->lowest_freq * 1000;
> > +   else
> > +           min_freq =3D cppc_perf.lowest_freq * 1000;
> > +
> > +   if (quirks && quirks->nominal_freq)
> > +           nominal_freq =3D quirks->nominal_freq * 1000;
> > +   else
> > +           nominal_freq =3D cppc_perf.nominal_freq * 1000;
> > +
> >     nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> >
> >     highest_perf =3D READ_ONCE(cpudata->highest_perf); @@ -1662,6
> +1706,11
> > @@ static int __init amd_pstate_init(void)
> >     if (cpufreq_get_current_driver())
> >             return -EEXIST;
> >
> > +   quirks =3D NULL;
> > +
> > +   /* check if this machine need CPPC quirks */
> > +   dmi_check_system(amd_pstate_quirks_table);
> > +
> >     switch (cppc_state) {
> >     case AMD_PSTATE_UNDEFINED:
> >             /* Disable on the following configs by default:
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index ab7e82533718..6b832153a126 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -128,4 +128,10 @@ static const char * const amd_pstate_mode_string[]=
 =3D
> {
> >     [AMD_PSTATE_GUIDED]      =3D "guided",
> >     NULL,
> >  };
> > +
> > +struct quirk_entry {
> > +   u32 nominal_freq;
> > +   u32 lowest_freq;
> > +};
> > +
> >  #endif /* _LINUX_AMD_PSTATE_H */
> > --
> > 2.34.1
> >

