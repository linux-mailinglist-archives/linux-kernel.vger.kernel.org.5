Return-Path: <linux-kernel+bounces-156197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593108AFF17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4182858BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129CE144309;
	Wed, 24 Apr 2024 03:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OEFwsYDU"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F245C13CFAB;
	Wed, 24 Apr 2024 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713927897; cv=fail; b=HMlqOuFzWgu6KRwmt+RXw7FDu4n1nnBTA/KS9hIoBFro/XvtyM+oRn/E1f0O6B6G5Yc7WNwSiewRKZlyVk6Zs16rLimIaBktIYyMWIFOMMn4DWmePP8nqwVc3ggkwgnlwIWCzssN7XR4QjvViZN/gqbpHbnPGx2Tr0KYvsBvorE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713927897; c=relaxed/simple;
	bh=FqbecaJ6tgpEct/EA501RkZkWaW3FuUoSFYQ/UHNHM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fwyh7W/LxrPTFCWKJVJf9FCKcOmbtbV60iFYeYsRbpd1+p0IWPahPWVYxbu8aE3yLFEeVUjsYYreEwfyDdZ/HYT0IYfsKq4klXDhaViUwSlhnkK2O7tTBw6UzNmGgrgvZRB7OOtbPztFF+WlfaH2H6pIPswGqL7p8ow7rYIjqzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OEFwsYDU; arc=fail smtp.client-ip=40.107.102.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sjc40PPyW/AweI4nTMgKv0hjeCI1mb38Coh/Yu1Mae6YdTwiMrdcsNwsQ8e03FeoGwiS4M5tkWmWlJ+d5At5yfUB8Xt8kQEexL44t48ZaEb5F4MgkLh9M8cSGBQkuWMKwkNMtzLBcJmeVU20TwBm9I+cHA0sIEwyUfFOMBSvEgRpPGQAO1t5n+3iwD0zDaCXsaCKtaEN7epevs+J44gBWCajb6cMRJ3ESg60uJ05AYEZL2VT1B3nI4zVMT/Z2M3mckp5mXe9u6plBllUgODUNnSxli4lxY+0iwSk4DmOCO+AACs4qqeGvErZzuDqx3VJROrqTzBt66iZMDTe7En2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKFURNGRGNPlnRtMjN3mN1EU5PPn0d75a7fmUFSmfxU=;
 b=JevchvLO8m01IydbChAIcAED5/tbjOuTn/a8GVW0A02tM7twhHLSNddlv0vFBbeLQ4NcdsFO7DXAiqhO3gVe4OvQPH/2/sHC1mPv0Ukwfzv665meabRK3joIV7zMdFq+jE3c8pgfdtoZcT6KkGlMjYVbEtijZuDsokoId8Bu+B0y7RF/AaypLRjYBvJvUL1maq23351d/hzMoKmqPzoORnlT8mGeYrGJoRkNc1bidc315PtT+CKb02HtyiiQbCngomUC5pIV7lmVCSrYo2wuqgJGhNJpoVkB8nFMXKHUSdCf5L1p0g0jz8GkJwqHFV8trFiSNTM9PLciXe/6lpN1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKFURNGRGNPlnRtMjN3mN1EU5PPn0d75a7fmUFSmfxU=;
 b=OEFwsYDUfEA2JKxhg3J7KlHR+LNZ4F4L8OzIAAMh6H2Bh3i1B/lfu1QuaOfXw1a0NfdvtDNDTA4BbjWF+/aKe0MHnWTUxF68DbHGp++7uGHutxVJXsV+IpqjGnDWxN9xGlncbSXPVre3Gx/3v0ZfPbsulbipEJiYDKKtYJRaxhM=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 03:04:52 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%5]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 03:04:52 +0000
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
Subject: RE: [PATCH v11 1/8] cpufreq: amd-pstate: Document *_limit_* fields in
 struct amd_cpudata
Thread-Topic: [PATCH v11 1/8] cpufreq: amd-pstate: Document *_limit_* fields
 in struct amd_cpudata
Thread-Index: AQHalVRil24b/vgP/0msprinE0VvN7F1pcMAgAEWeEA=
Date: Wed, 24 Apr 2024 03:04:52 +0000
Message-ID:
 <CYYPR12MB86552AA09FD34391E05D7AF89C102@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1713858800.git.perry.yuan@amd.com>
 <c50374885172571e1c25d95552dec8467c37ea24.1713858800.git.perry.yuan@amd.com>
 <ZieMAr//Ofu1ZE0G@amd.com>
In-Reply-To: <ZieMAr//Ofu1ZE0G@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=725b6b7b-dcd3-4f3d-87b6-a8c01b6248ee;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-24T02:59:38Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DS0PR12MB8503:EE_
x-ms-office365-filtering-correlation-id: a6ff666b-be4a-4ae4-e305-08dc640b4fc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?55d3fuCpRtscxAWP9NL76DduMmv/ftzCOgcAHNI+FxPgSn1V61hqhIZ8k2QU?=
 =?us-ascii?Q?y9dwzZ2volAxEToXjvmi9QsG/bAjA2zklx4KVKtjb9W5+NqfOKSt1wrLiOqy?=
 =?us-ascii?Q?JZRnyOSHzqfGPI0Qj5o85JMKR5ZOHhexf8pYLezSzNRf8ZUqwVkM+7dMXwNh?=
 =?us-ascii?Q?V1bt2kDyaV4hRcm+7oEAxdH4RMrUFoFgBG85sMtzC49TYxx+elNKa5fKcnZu?=
 =?us-ascii?Q?1+0+aiJwNX1ShbESUNq0Oey4qqELKErVWAx37BKm1wTsJqNE7sAavJsEkXX1?=
 =?us-ascii?Q?JBQbCLoP224jor9aFanlz73Rj8GkXtFlan0JfDAzr+KWQQUEFU/1kQQqqnZZ?=
 =?us-ascii?Q?3X/c2HN0rLDk8P/tHp6kcEeaNW9OMwNy4eCvO2Bd1/odVFg75AdUW/pHV8/O?=
 =?us-ascii?Q?AOCvVLGveDREMhEMsKpiQdAFuXaTBJmV1QVTGY3NmABXZHaShUjpdFpbIvtO?=
 =?us-ascii?Q?VjaVEATI7pAXRV+s8PwZJgfSV02d9Q99yyNScAFWTX6T5EwSySpl5pugz0v3?=
 =?us-ascii?Q?znf9Gv/cQ7m/uUabnz6Ghyo8RDwTbZMsf3Zvpj+2p5pAH+/q3hc/QNvSDyco?=
 =?us-ascii?Q?z2kY30gSOMo+vWBG9o26jdzW+ceGQeItLVr1G+fbQJdgImjwHqqYDAPYEpKH?=
 =?us-ascii?Q?BDGVb+r+1gsD4TOkqVSSihVh8eC6TwNB1aJdIZx4xH4Rqh8JqC8GpupKjj9T?=
 =?us-ascii?Q?wF5E6t+D1UsklJSBXiUlbJVRofS0Wifm9VPs/D6Z+E7r7QIJjpbA47TdVDyY?=
 =?us-ascii?Q?1FXPNLhODfGOYa7Ur7cucYfoX1OlrcQCWxU/6gdlafMuBRxYgqdrE3mFhkWn?=
 =?us-ascii?Q?qMlxiuapcF27gEzzt+ZDeYL5T9sAY6SkcH19V3X9JTzMyIBVYEltnW/B2540?=
 =?us-ascii?Q?37DoEGeuG90WtWm7qXkTe0Z99s/NDEkrfrvOjlc2dRp/Hj3ktxnPd7F1xkGN?=
 =?us-ascii?Q?XGmpA3k0y9X3J8b58zfzgql8FDvb3gvlTlvt2o2nfl1VeALv1jRvmu8aI751?=
 =?us-ascii?Q?BPRT8zcpEmYqGq7P9QPqrv1VBwCkC1XFAmJ1Xbo4k4h4WQRL5Rkt3QKVvXNs?=
 =?us-ascii?Q?+XOZ6IqDCXe22p0AydPVAadczwpOd50JqiAzWv+zj/eGBiz8kZVrCF6/Gs7O?=
 =?us-ascii?Q?LX54RPUq1dP10KotqNjuGH22rpGBCUGHY77NPjWJ3leLVCqBkCnhCNTH14GV?=
 =?us-ascii?Q?3l2nkpCddUqZQgVI54O/oWuKdr1u00YT2PpdwsfLH05tN6Bq9L1XUCw9VfQ6?=
 =?us-ascii?Q?zQcuq03+onaATS9UVKtNWJ8azcKMDQCSRaCahH+7M6YBkB3FxMEt3J6A3O77?=
 =?us-ascii?Q?yI4+uXeGtwy9VzQuyhymKAZyzi0BejhSIx8q0NUGQHVaJw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mZeNs41LHuBdPn/YwXCA/gS2j6ZvGuaAyYVEcYgfnxRlLgC0UvoRPAs+6Zu8?=
 =?us-ascii?Q?P3iZysK/Drnt6jZrlUc1LKdNmVoavRXKyPVWFs6cqY7ty+6FnPtPHBQJ6vuv?=
 =?us-ascii?Q?bsY7ofu9x20RCEMJbPILFnm78Sog+e50HAn/pvwIsooevJEwQ0NM4YSCyOZo?=
 =?us-ascii?Q?yATE1SEH/MaSS4UgG0Fmyg16kHkXw4iBli678EKwMGgf5CIPfBNk1vpWeyk3?=
 =?us-ascii?Q?2dK2upbsxtwnEmGEj9PM5wuNuJJs+NymSXavEewyfYCujalwS6YLch147HDx?=
 =?us-ascii?Q?MIIfZTmeXYuOD2R+Sh0llTBYjdKwF77utJ3RILmLKveTqYyiSZ80yV/zqlCV?=
 =?us-ascii?Q?ZmAdPg0+1MHRu2xozqtUqhu6YGKFFuNB+wU5GV76m2i4hvFn74ibs/aPAddN?=
 =?us-ascii?Q?dcLjT5i+bGqlDTQ4NNCUUVYIlgA1pWT9wN+Zjpi/iO+vnu4L7x3alexfWQ6F?=
 =?us-ascii?Q?V9GkcpoIWtYLLDM4q8MP+LSBRNiZkP8VHkaaS8zui8csA4eiktKZz0GuPmX1?=
 =?us-ascii?Q?lVVQMYAEAr/keKyBwsOPyGl8xjr09RSBNxQy7J1Xv7sTaJmVmTphDNrY9pns?=
 =?us-ascii?Q?X8ERCezzML6F8ZUtSep1AtjRWq7drHOzsmDc3l4iXe3w5r2vIg93S8VLSu0v?=
 =?us-ascii?Q?BdW6Qidk9A+DLAswDIZRwseCjxaPCSpMb6CRXHejT2p+dW5CnPtX+B5sc9rG?=
 =?us-ascii?Q?ujWWlGGVMGM3e+tw3o3olCV/VJLL0bdO3Du/FmAIQ/Zs/Bke0mEYq7G7uCMa?=
 =?us-ascii?Q?9/ku02MI/DHidwSp5WNJ3UwRAysHoc3QWzpsVpZkey9KzcMYuzhNlML4TqF9?=
 =?us-ascii?Q?3qagePMOdZbUdzMLWwtuvu6xslpwCZBMDtFjfk+xNXiWo9k/tRVerfKcJzNb?=
 =?us-ascii?Q?uA2+16cR8ECNNN1Xi71A651b40BZH3OzANn/t8NJyJ6HKY8MWXcU4VqOb5DX?=
 =?us-ascii?Q?VjN/SjGRrb7R7/sXpR/qOwXtmEijl+aSy/bopTIog88qFc+VKtOI+2RWzGV8?=
 =?us-ascii?Q?4pcWdgyAYvDb2v6zYcu679R/szil2tLj3abP2spbErUHCGcGXmtM0Q+3FMLr?=
 =?us-ascii?Q?ZUA4O5hGoccrYPaJp6Bq3gTQFwD+Dm5GQ/2Rcja9Yi6al2voRzyTLzsQ9pIY?=
 =?us-ascii?Q?i63lAjijhEt3Trf4Otkjnodf8fnTjstz1J5dzYT++w0QAcnQDJkp7YEMRUpQ?=
 =?us-ascii?Q?LfSKrZDjwFKZDGh+17RO538dURYBx9liSbodt2Y7au4XyRmnSWvKy4indg/6?=
 =?us-ascii?Q?T2VxkaO0Ju9CVaWSHBDZQFWASa3VaDVK50rvctRp+WwEVTsPO701nIkw6TV7?=
 =?us-ascii?Q?9/mJSko4VnlRXci8lrLp2VetOxNTi1DGIgwEYzoo/bgbb60+O4mtlIRQblT1?=
 =?us-ascii?Q?jPePkW6BCXfdmJq2D9kp6OLRbRMeuh8Buraml/EvLVgCVZ1tqE+SdGS3lTqG?=
 =?us-ascii?Q?6a+UntXpNV/Q6YHLOAN0eX1dmlg5ikD2jzkq31pwnIqf+FUCGOrnVjuSQp4I?=
 =?us-ascii?Q?AYwxWCobZsYYJ0C2v5a667SaHMygsnYEIJu2l9O1HpDQeXO3LP9PmHziMFKV?=
 =?us-ascii?Q?6l3eUMCUvtuJvwW76Zc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ff666b-be4a-4ae4-e305-08dc640b4fc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 03:04:52.5413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b7AIQ4hbkKOw4q3HxjU3ryXWN1k2NX6e5XKo+InqFSK3A6qETV6Kwo9PUoh3fe12xx4NUjw44tAfzqRgqTGguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503

[AMD Official Use Only - General]

 Hi Ray,

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, April 23, 2024 6:23 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Shenoy, Gautham
> Ranjal <gautham.shenoy@amd.com>; Petkov, Borislav
> <Borislav.Petkov@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; oleksandr@natalenko.name; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v11 1/8] cpufreq: amd-pstate: Document *_limit_* fiel=
ds
> in struct amd_cpudata
>
> On Tue, Apr 23, 2024 at 03:58:17PM +0800, Yuan, Perry wrote:
> > From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
> >
> > The four fields of struct cpudata namely min_limit_perf,
> > max_limit_perf, min_limit_freq, max_limit_freq introduced in the
> > commit febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and
> > scaling_max_freq update") are currently undocumented
> >
> > Add comments describing these fields
> >
> > Acked-by: Huang Rui <ray.huang@amd.com>
> > Fixes: febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and
> > scaling_max_freq update")
> > Reviewed-by: Li Meng <li.meng@amd.com>
> > Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> > Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > ---
> >  include/linux/amd-pstate.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index d21838835abd..212f377d615b 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -49,6 +49,10 @@ struct amd_aperf_mperf {
> >   * @lowest_perf: the absolute lowest performance level of the processo=
r
> >   * @prefcore_ranking: the preferred core ranking, the higher value ind=
icates
> a higher
> >   *                   priority.
> > + * @min_limit_perf: Cached value of the perf corresponding to
> > + policy->min
> > + * @max_limit_perf: Cached value of the perf corresponding to
> > + policy->max
>
> Perry, you didn't address the comment in the latest version.
>
> https://lore.kernel.org/lkml/ZhyEwE3Hr8Waf620@amd.com/
>
> Thanks,
> Ray

I had explained why the perf is the better words used here than performance=
 in v10.
https://lore.kernel.org/lkml/CYYPR12MB8655D251FC00EF8207C771BD9C0E2@CYYPR12=
MB8655.namprd12.prod.outlook.com/
if you still have concerns for the single word, I can change it in v12 as y=
ou want.


Perry.

>
> > + * @min_limit_freq: Cached value of policy->min
> > + * @max_limit_freq: Cached value of policy->max
> >   * @max_freq: the frequency that mapped to highest_perf
> >   * @min_freq: the frequency that mapped to lowest_perf
> >   * @nominal_freq: the frequency that mapped to nominal_perf
> > --
> > 2.34.1
> >

