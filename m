Return-Path: <linux-kernel+bounces-159587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90EE8B30A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8085A28182D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60A813A884;
	Fri, 26 Apr 2024 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iNnPApl3"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10013A268;
	Fri, 26 Apr 2024 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113639; cv=fail; b=qGDjFf+EP7weDu0qdEuMXcwJ4DOZQDWxbgqSroAYgySu+SkzG5XtkIZgfjA+QQUcGmY0XpT4YIY0egtsQHzr1AYvD8+lcFz3R0fUFhjPn8w0R+fCL1hqySC2RLS5tDgGojG+XTCLP5oPP+E6wXs96BTgyyqYaPBzg4IXtvLJX+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113639; c=relaxed/simple;
	bh=ZQmbiBM57uetC1C0lywQ6FtmvdX5ug/TC5pam337W8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T/gehax0QoFWL0kP16/s0y3BubOxhNGeDoLykpGXN4UqBwrL+gsQsyMtS/gZBURBWN5MLZ9YaMWQbNyVUjfn+MqfecVoRJxF4ZnAQLFAo+64E8RT+x548g4m6zAA/QmyEaFVxMpm5OqtdNGj6nQCcTsf17gxADpz06bE7DjPRIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iNnPApl3; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oe19dfGFBLuHhdw9EP6V0WeMwxaWYkTGU5C7MpylR5sVRyLeSpkBG8WjK67+788FnL6FMy3TIKp7AzSP7KeH6NdoLflAJP5hCDdCu395UmSIqtxbhdC66zfb4z6Ed5zdWIh86bTU7QuXkz1Qo+SwzL0cSI50ytXPz5PG4yO1VkFLE451Rru0J9/ce+OUG0en2nlDwrhHALDEl+jSD6TtjjGTexh7bSn7S+WUJ0qcTVfqst+aODXfDnUnuSpsUAwT9VrurYyxVHyFjMefRIUF2qlrmnXJEL2uRrDhH7fNyy06MH2ddGTteaBqb0yFuPNBGqscoWcppXAtMJleMjLPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KehIUqN1i9P2k/hauYMSGFAbexoD3ZnFYU0aWqFEN+o=;
 b=n6Kr1WgulIff4hG3XzNBrsHo0XJ/j6kc72IW5xB7lY2/UWh+9jZLOusml2RPOcEnyHjQj1zS6dVzyOPbRVVW7WrmNfAF9hJE95MuLoDTcBdzANLtsKYOOTzFRIcAaGcPno74bbJEwFUu2gBJjiPXfQiRc4kQ/6guuFXfuesm2Rn/bVtoRS6bbJkk8EDng30zqGAHfqHKvWeidaTmhE21jZrpo+wTxElpbtHeZjRa5XUDnBQhwNp6mnlpTsWoFQrwuqQA43YElEKZU7Bw0zcZVLx2XoN/d4bIzpDd+j2t3zEDZXgvvQNL46Ypgb0MMaipsOsaaQePD6jsIf4On/W5QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KehIUqN1i9P2k/hauYMSGFAbexoD3ZnFYU0aWqFEN+o=;
 b=iNnPApl3LISlk1vnqLoI8tBdtaCJpzJrWvwVH4hKtwLomvSwmmC3IEE+W/H8EULV9dMH4JC42uoznnH08aJfXgY0Xy8+kWKx79nnTfQ12egq4btKeL6ybuX6WvlHNAJt+v9rOgJDseJ5GssGnUsS2e7H9IoFX6DqUpFk6Cao1I0=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.48; Fri, 26 Apr
 2024 06:40:34 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%5]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 06:40:34 +0000
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
Subject: RE: [PATCH v7 3/6] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
Thread-Topic: [PATCH v7 3/6] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
Thread-Index: AQHalVofCwa2vRobwE2RC+5zsRgs9rF1sBuAgARuVAA=
Date: Fri, 26 Apr 2024 06:40:34 +0000
Message-ID:
 <CYYPR12MB8655D0E3DF167C513083E1B69C162@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1713861200.git.perry.yuan@amd.com>
 <5a357c1ac3504f8a69def8834a6d9557b5d592ed.1713861200.git.perry.yuan@amd.com>
 <ZieUuaKRAPFr1EzS@amd.com>
In-Reply-To: <ZieUuaKRAPFr1EzS@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1b3a0961-3939-4cbe-8deb-68c358bf7b89;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-26T06:40:04Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|PH7PR12MB5880:EE_
x-ms-office365-filtering-correlation-id: 74302b50-bbc6-4384-a39c-08dc65bbc6bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YtaN3auTmGx+9raV8u/tPEbQe/QEKXIOcoj4rT9K68jxv4PPy7fnN1sxW6sy?=
 =?us-ascii?Q?d2EUw3PrPq3ONmxSa8LEX8IiB1sqvzn5Qfcj6aps2Jn9lxD3sH7DXAcGpubv?=
 =?us-ascii?Q?untdlEenWf52elnOpfr+G3WMVHZSgnOkgCish5F8qB5BSH3gG2KNIPqQMMpf?=
 =?us-ascii?Q?GmjV8jp3dqhbFkw0pFMMwoav77Htlwh1DP5BAylcNOSxMU+qBjLfjz/a2xU5?=
 =?us-ascii?Q?PcziAAxx5ABL92vpQrGvcdLSqA+Ubg0ZCEwtEtYAfWUpXxBSWNYL1stASSfo?=
 =?us-ascii?Q?w2DY7I6RddQl13GLyVh1zOnyyeRc19rIyzs0xIo2H70XBwEh2IA2a1IBDgkX?=
 =?us-ascii?Q?SSZ/GFUxNiAOZgHnQ1Dqpa7Dr6TNlfFk/UD4GDUUvwWonyQra2X5A4K3zwJl?=
 =?us-ascii?Q?TEYTTai3Yk9B5skkrrryPLGerflYfOUM4Cgl/6cO1Qw9ydGK09IZ8HPT1lVw?=
 =?us-ascii?Q?/zQeshgM9Heatzp0iICOX6C3cn9B+hN50LvWkj0RSQqAGsZfKsEfQl1gsst/?=
 =?us-ascii?Q?v0jytRwp5H1HZQsri8FZe7mVVllwGxL9dmt6LSbGoGpwvNkXcG+Yuil/nLwL?=
 =?us-ascii?Q?POBR6O/35kJzC37Q1dtLB4f70sieKZzFLOUuYoeiUFZRTvV2B5ciGuSipyK/?=
 =?us-ascii?Q?rEKBH7l5zDCkkZaX+zZFVUe8YIPp/RV+Gja6ciQo0ILikfDLz5gcXOwl5phE?=
 =?us-ascii?Q?OTdpvaaWcxj1hB8pFMNMOgIfyNzL0DrFvSqOwWJhw7h1EOG4xbYmVaNLyJGE?=
 =?us-ascii?Q?aQ9LpyJo2KlMPnMt14RmjXo/9X7qe10EUioc2G7+g70RpAA36URThl9PYwPq?=
 =?us-ascii?Q?yYinR6BfhTyDXe8jqIKVCuwbnrxito1dJM6U84l8S3WaDvK8MmoJ4Mg8rH3p?=
 =?us-ascii?Q?pmrXigu6Nq3noR5b7EVBTHOaAcsrTkZW5vWcPK9Ff+IkgVrIaQC+nGhGDW97?=
 =?us-ascii?Q?wvzSKerB71w4HpiIxNzCeu6wsWAmrtQQew+gVfh+8plelQCMlTe0Y1RUEoic?=
 =?us-ascii?Q?yip5bhVUmHMXYx69Avy4ArW1ZgulHnY8G7DeXmzyJBwvJty219xmz9YzXPEd?=
 =?us-ascii?Q?EztTPQ7yvqVaG/2S2gaAUYU6bMQo4/xzOd0FAfAYqh4FoKU9czbivgDZ6Rlp?=
 =?us-ascii?Q?DKuFzP6hN1lt5jZZyYMNOr81BZjdPwdlOCZGOKe9/CtaElLi1bGVCSg/04yN?=
 =?us-ascii?Q?TwFUIIDDEu6MbEsAsBgvs/9R4hUwoAGoaekgDpRoHvH+h9m/2bx2Co7QAsdl?=
 =?us-ascii?Q?xxJAYOqOKNixHWzyuw15zmjftD7ASdsW8H5LI4vjH7fjgvoLtm8v/W1ybF+S?=
 =?us-ascii?Q?oZ1MzrrLeynvJLxfW/eGzDn+yt4lxVmqCMs68BWTmjVhoA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0rL8/IVk2dqzEGf40OOKT97/YnYXqxbXGf/LaY+LiiJ1CXivfPBthPL9Go00?=
 =?us-ascii?Q?HFMS6CRBGZg5MqYBSawhGm7PQaMQWdB3E0BEn98MymSC+V0pX9tfcnzhf6Qr?=
 =?us-ascii?Q?ADaS7QN2LzkmbiSP65+tDhFxprEpStp+laq8urqDbsTSv1OBjNh9yzlUOQYM?=
 =?us-ascii?Q?MXwpeo7opyY4b5djrtIIbpJPpMW5bv2BnwC1u/IdE1u7ab/iS/zkXfMePqrH?=
 =?us-ascii?Q?YMrC9FF/JCQzd2g4jJVxp8IdOjsXVWGIkTlDEux4iX+ZkrqHiKMMys/3aIaI?=
 =?us-ascii?Q?xsEcFqKTXDKCB3B96JQKLgWAnPkHB6XJotTvBmMU/DqMdq8qJFdiQz9arLNP?=
 =?us-ascii?Q?wKbD25HKs94CpuLnoKmG7nTDaJb1UTdaq0JnUV+5cR1yE0shyLhOUNAcyF1M?=
 =?us-ascii?Q?gmqsEYtbuKDiTdJq/h2ZJPL5WzSP72uaUN+L9cSZHM+TqABakDVO+Fr1L06X?=
 =?us-ascii?Q?hog4F8JENrjPlJwKJLAZBhByNg0XAqL9yzDiVKYNWasQBZmEjEnnLc5tKYeE?=
 =?us-ascii?Q?d7u0uKsw+k71QK1RkbrlFRVNnOK28D7EwZH0FyU7UlV8JGVUiyk9Vo7vcCB1?=
 =?us-ascii?Q?5m2TEDfZJz2xn23GA3ZXfkGdlE0DY74JGcGbmOj3j7XY42kjohicgY1xPrjc?=
 =?us-ascii?Q?sHMFO2oWI2wX7bPcilsXflUbBUvBgrMbP2iokdJFlLXi3QX5UeEcWgw1vZxa?=
 =?us-ascii?Q?oAPzbueOgccVn5wau1g8cNT2+yeW6K8bOq6p64NJiWcwU53eoDanC/iKs/7M?=
 =?us-ascii?Q?0khv4d7BcOg7U3JFQluuS9+xVdYu0olcIFDVWr4frBe24prQRbZOGrxb8vCz?=
 =?us-ascii?Q?Z5Ueym3UTR/xtSgRjORL98N6CcPTrKzmK6jzjEytPG0lvBg+WlTYr3379hef?=
 =?us-ascii?Q?+9DYyP+63VQByzEB7s3UDT4UntliKFqd0azFhpIJ4Gm7GCV6bt8NLR4zTOPq?=
 =?us-ascii?Q?emuGCvdNC/GT+ssBpVPa45+Dev7wGdoQhgTGcn3MTEeGrQo1x+uGXteNhhh1?=
 =?us-ascii?Q?3GUCj2PzD0bQMcL0JTC78YJwKQsGF5YgkhNXnuN2Ddt4xQJsnimjLTDtLtpo?=
 =?us-ascii?Q?V0VoLcPWEiSjLE/mYbll8CZYl2IPwDy6+G9yijoZzUZOU/Y7BL9vstDIQaOZ?=
 =?us-ascii?Q?6ANCgTx7tpKvfSPfmupc7jymY/HI4f4jkJFU1qNRmv59HqzFdVsJCX6RzlFD?=
 =?us-ascii?Q?HYeqpx9ghUUseIpHbpm7enhoQqqR7knSIOOk1lvIV+BNuUaXxTqOnRFvYZ5p?=
 =?us-ascii?Q?sIIcq9WCQvmpWzseWqLWmwWebaJ9P0aCKq2AeJBIFh++PAV1aNmazZaL0v3y?=
 =?us-ascii?Q?RCALVbad8WFk3QSMQQbrVfy23CLKD5RRxa1bOUav8b+O6j1pcLysoIK/8csw?=
 =?us-ascii?Q?nDoLX9llGd0ufVKGkhLIXaDXd+uz0UejZVpdycwOhp1iJZgKg4uYZu4qFCyo?=
 =?us-ascii?Q?q1Ytvbm5PRqaGluBQl9t6CSAtXWaqI+mw5Q/2e7kZ4VdGwHwQ6M3kh3b1gTK?=
 =?us-ascii?Q?OCs+0e67SmmurzHS/IoLpsTQ9Pi+1E57AubPn7gzLTXqEIsXa19L6Ixmldhx?=
 =?us-ascii?Q?fNkny1gnZiIi+pH9kxI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 74302b50-bbc6-4384-a39c-08dc65bbc6bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 06:40:34.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FX+jTHEzSX0rzsjIjXFbj3C7LPI1D0yYgmWJtrPrI1MS166TuQ5iE+g7rceGnLiPXd6eqoiJ39NV5CPCegn4vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880

[AMD Official Use Only - General]

Hi Ray.

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Tuesday, April 23, 2024 7:00 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Shenoy, Gautham
> Ranjal <gautham.shenoy@amd.com>; Petkov, Borislav
> <Borislav.Petkov@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer <Shimmer.Huang@amd.com>;
> oleksandr@natalenko.name; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng, Li
> (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v7 3/6] cpufreq: amd-pstate: implement cpb_boost sysf=
s
> entry for boost control
>
> On Tue, Apr 23, 2024 at 04:40:56PM +0800, Yuan, Perry wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
> > With this new sysfs entry `cpb_boost`created, user can change CPU
> > boost state dynamically under `active`, `guided` and `passive` modes.
> > And the highest perf and frequency will also be updated as the boost
> > state changing.
> >
> > 0): check current boost state
> > cat /sys/devices/system/cpu/amd_pstate/cpb_boost
> >
> > 1): disable CPU boost
> > sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> >
> > 2): enable CPU boost
> > sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217931
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217618
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 99
> > ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 3d86cd7c9073..49eeb38fcf20 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1291,6 +1291,103 @@ static ssize_t prefcore_show(struct device *dev=
,
> >     return sysfs_emit(buf, "%s\n",
> > str_enabled_disabled(amd_pstate_prefcore));
> >  }
> >
> > +static int amd_cpu_boost_update(struct amd_cpudata *cpudata, u32 on)
> > +{
> > +   struct cpufreq_policy *policy =3D cpufreq_cpu_acquire(cpudata->cpu)=
;
> > +   struct cppc_perf_ctrls perf_ctrls;
> > +   u32 highest_perf, nominal_perf, nominal_freq, max_freq;
> > +   int ret;
> > +
> > +   if (!policy)
> > +           return -ENODATA;
> > +
> > +   highest_perf =3D READ_ONCE(cpudata->highest_perf);
> > +   nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> > +   nominal_freq =3D READ_ONCE(cpudata->nominal_freq);
> > +   max_freq =3D READ_ONCE(cpudata->max_freq);
> > +
> > +   if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +           u64 value =3D READ_ONCE(cpudata->cppc_req_cached);
> > +
> > +           value &=3D ~GENMASK_ULL(7, 0);
> > +           value |=3D on ? highest_perf : nominal_perf;
> > +           WRITE_ONCE(cpudata->cppc_req_cached, value);
> > +
> > +           wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> > +
> > +   } else {
> > +           perf_ctrls.max_perf =3D on ? highest_perf : nominal_perf;
> > +           ret =3D cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> > +           if (ret) {
> > +                   pr_debug("failed to set energy perf value (%d)\n", =
ret);
>
> Do we need cpufreq_cpu_release here?
>


Yes, the issue has been resolved by v8.
I have made one new version addressing the feedback.
https://lore.kernel.org/lkml/cover.1714112854.git.perry.yuan@amd.com/
Please help to take a look.

Thank you.

Perry.

> > +                   return ret;
> > +           }
> > +   }
> > +
> > +   if (on)
> > +           policy->cpuinfo.max_freq =3D max_freq;
> > +   else
> > +           policy->cpuinfo.max_freq =3D nominal_freq;
> > +
> > +   policy->max =3D policy->cpuinfo.max_freq;
> > +
> > +   if (cppc_state =3D=3D AMD_PSTATE_PASSIVE) {
> > +           ret =3D freq_qos_update_request(&cpudata->req[1],
> > +                                 policy->cpuinfo.max_freq);
> > +   }
> > +
> > +   cpufreq_cpu_release(policy);
> > +
> > +   return ret;
> > +}
> > +
> > +static ssize_t cpb_boost_show(struct device *dev,
> > +                      struct device_attribute *attr, char *buf) {
> > +   return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
> > +}
> > +
> > +static ssize_t cpb_boost_store(struct device *dev, struct device_attri=
bute *b,
> > +                       const char *buf, size_t count) {
> > +   bool new_state;
> > +   ssize_t ret;
> > +   int cpu;
> > +
> > +   mutex_lock(&amd_pstate_driver_lock);
> > +   if (!amd_pstate_global_params.cpb_supported) {
> > +           pr_err("Boost mode is not supported by this processor or
> SBIOS\n");
> > +           return -EINVAL;
> > +   }
> > +
> > +   ret =3D kstrtobool(buf, &new_state);
> > +   if (ret)
>
> If get a falure, amd_pstate_driver_lock will be always locked.
>
> Thanks,
> Ray
>
> > +           return -EINVAL;
> > +
> > +   amd_pstate_global_params.cpb_boost =3D !!new_state;
> > +
> > +   for_each_present_cpu(cpu) {
> > +
> > +           struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
> > +           struct amd_cpudata *cpudata =3D policy->driver_data;
> > +
> > +           if (!cpudata) {
> > +                   pr_err("cpudata is NULL\n");
> > +                   ret =3D -ENODATA;
> > +                   cpufreq_cpu_put(policy);
> > +                   goto err_exit;
> > +           }
> > +
> > +           amd_cpu_boost_update(cpudata,
> amd_pstate_global_params.cpb_boost);
> > +           refresh_frequency_limits(policy);
> > +           cpufreq_cpu_put(policy);
> > +   }
> > +
> > +err_exit:
> > +   mutex_unlock(&amd_pstate_driver_lock);
> > +   return ret < 0 ? ret : count;
> > +}
> > +
> >  cpufreq_freq_attr_ro(amd_pstate_max_freq);
> >  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> >
> > @@ -1301,6 +1398,7 @@
> > cpufreq_freq_attr_rw(energy_performance_preference);
> >  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> >  static DEVICE_ATTR_RW(status);
> >  static DEVICE_ATTR_RO(prefcore);
> > +static DEVICE_ATTR_RW(cpb_boost);
> >
> >  static struct freq_attr *amd_pstate_attr[] =3D {
> >     &amd_pstate_max_freq,
> > @@ -1325,6 +1423,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =
=3D
> > {  static struct attribute *pstate_global_attributes[] =3D {
> >     &dev_attr_status.attr,
> >     &dev_attr_prefcore.attr,
> > +   &dev_attr_cpb_boost.attr,
> >     NULL
> >  };
> >
> > --
> > 2.34.1
> >

