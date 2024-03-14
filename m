Return-Path: <linux-kernel+bounces-103078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4941087BAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E2AB23F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46E86E2AA;
	Thu, 14 Mar 2024 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kOUXqNhD"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4D26DD0A;
	Thu, 14 Mar 2024 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409953; cv=fail; b=WF9V/khdf8XAF/YSD93/19mieMHTnH2ITfDDh5gTEqbaudJUAzvL/vegSj33FH6lTfqssxMN6NTvTpCOCI3Lnry0doBprwtj4p1eoxqST26gGIzA7ryoAykyLRENCScomLgzHc6nh9CG5rDqzcOAoQe+7mn43yEhuuQXmnYrz9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409953; c=relaxed/simple;
	bh=UasPsfcfanAEqyR/eDbiMhwDcF3JlLQHor2m70+YyCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iEfavFqtY+H1mCB1XMxSsau7+Dg1kgv+2LVOEWltFGVtr6o67rUAsbVhkS3rEgPFfO1o82nrpoZzYtmBKpFbOhQB1bNWiPZHkr9mrPX5jaxTe5h5bJWtkJkGZDPE9ywo3x60Vic004O0YqFoCzHzdKQUxeb/R/C1lKHkCIx3PDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kOUXqNhD; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS6M5gMi6SvVgIfENE0q6gTyYFsmO15BoWGYlSFZ/DLawb8QkH/Z4uNZn+f+m4lEQV91T7+8hsZ7pcv9O7ZGlYH6TaW+Gqea5OeX9KP6qrpisZUcaei0kJ7t7IOtmhoxnDzX3UL7WRuT0jghZpPrSPQWXYX6JVfaGpwLjrQuGPOPbX/dCyPz37l4yWbBETbC8ykwjasQEXYapQJqdq9h6MvfehJmWP2fNeDz5mww4bwna29+EtXIwxtyZgGOHLRhTYp+LpXPQVTSBpZY7p/6tcf3NWLvXAAoBTUxXMNR9UayFMQw1FmFX7E4LDXD9Xa9+DXknBgUBBtfwT4m6VEsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WAqC0VXz8xG/jYiUANffQQPxVozZw5cEXoQ5ZjEEYQ=;
 b=jfIygR9zNXYfwKGu3neYEhJmn7IPxfrV/2IfiRjgLmX29ayj8bT9Hg5XOF6KxBZIm+HMOQHjg4hVBmURiKUdMy/ar/JSJC6jNGw4vQFsLBFjUHiNqpL4bIVoNDYVRZVDHrT84F4i1ITjJLehwll1Dm5PdNu2Tc1Wo55yg5DML3rwfNvLjwCF89F8bHUjDaDMEml+1gFKWE1h3u4w9beiAoxMw3eMkz+9dxR6hpxFiTwafObIiHQLz7EYuaQabvrt87bBmhMdClE0a6gYkk/CbeTymDQqztqTAWo+xXUiJZT+NhgDe3bls/O931OtqPjzx1nzh0xBcVctHi9p2ku+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WAqC0VXz8xG/jYiUANffQQPxVozZw5cEXoQ5ZjEEYQ=;
 b=kOUXqNhDgoU8Jx2hfR32rCq4swW3koyjD8yc6MBhsCYVsLWbfTW3e/qzYDCx2WBF8ZJLuWQDu+OdhNMul3YQw+BI2Z/zdfJ8GMUbIKCN8533+dqYusaYTNT3/3CDL42KMszcukpEdnAHtne8eDShiDeXi3v0vYzfmhFCmSyr9Xw=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Thu, 14 Mar
 2024 09:52:28 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 09:52:27 +0000
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
Subject: RE: [PATCH v4 2/7] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
Thread-Topic: [PATCH v4 2/7] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
Thread-Index: AQHadS35rKktthbOmkCHeUn2ExiRmrE2/UAAgAAAjsA=
Date: Thu, 14 Mar 2024 09:52:27 +0000
Message-ID:
 <CYYPR12MB8655FB0563561C73F294E4359C292@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
 <42a36c7f788e0fb77d4be7575aab9c937e1773de.1710322310.git.perry.yuan@amd.com>
 <ZfLGUHRBV+1ICzp4@BLR-5CG11610CF.amd.com>
In-Reply-To: <ZfLGUHRBV+1ICzp4@BLR-5CG11610CF.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1b1a6b28-7ac6-4d85-bd4b-f9610ca910a9;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-14T09:43:34Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|BL3PR12MB6428:EE_
x-ms-office365-filtering-correlation-id: 3d1b6178-8afa-4875-d045-08dc440c7541
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wYs/71GWGeEMgzG3zHx8LmjKe/q7ReKvnimYd8XEjj4u5num9YCJb7DDL9Crx2GAEJ0M3ij8a/ECuSVF2WWZ9UB1rS+06yUNZPUyY3noQmJ1ccJS2T//z0CbHdLb0rg8PB0ouyceUkkbMUv1YpziJhFdXUDemq5NvQkgzm1MiGyCzJBqXMtoekklX+tuvTZui0HD2zngAY115g2RtyPRsVtNSOD1xcgO9jZVkgmYg2kxp2bW6szUDJ89DmSuEyvpAkQcNQiZ1vKIfOGPrfjEUtXQKBeX2pN91aJEN2HCsH45RT2baG192OWn7/N1ysAa4gYX4oaz+ti4rQkxRyu9tzZuOACOlAUA6Z5x5csK6Ho37gzZ2sT+TK03dHZF40C2v3sxOt4EoiZbOMqBLILYuk6LN8830azHKOBsMM+UCa5adkzyglSClUUnvTEjRPuDgM8oGrO51WgxD1ZmIIEMCslasxv+xQPqSgARDdD701GIAMqSXcp0gntS3CbvMrrCv1WuW2Lj33s5IZEy79qU7RIxDtegmqbUXfaujA68LYZjqJ42U71kMXd3WHoYj3EtGekV0dYHaFz8phnKngzyrxGW//RbOCpnN+eTilIjH5sMW+ckRrZ0hUfAyDjPNWKn7MzhWtfvqtDQQmjIsiDcxe8HeL9YbS5aDqfnolvYXO4IT1INfRLzzL/0Wj3oaHPQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GH3/y3NkEBZrYpz25g2ZeTZ13ErUjMd5jZZt3jWwzKi0kZFajnKTt4ZH4fUS?=
 =?us-ascii?Q?kMmOtN3e99FUZnZWMLwmiDXAY9+7b8k9KzZYuBrWMI+Mv1s5ryX3ApzRk/Yx?=
 =?us-ascii?Q?Gj4Nt3dO4mV60oZwNekt1Pqf1oR/545F+fu1WQnpSMYyiOlvr6sAnsbxK3Mq?=
 =?us-ascii?Q?kbRkL6kxhtOjLzTz6dzLqSvgIHRnn0MVpNtreoeUzijhhheqiPq2qEet3KyG?=
 =?us-ascii?Q?5sTWDyyOT9LPOIx/k6rYlzDksFmYDyqAnIg87RLSSnCRCs7wxTlzlccodq0G?=
 =?us-ascii?Q?ykm8hUkt+eCff4a62ghuQjLJEB9WAzpwhN+lvA/DXpMu1lQq66uDQwoEUux2?=
 =?us-ascii?Q?deSFOjuvI96i9KYlaogwgTcQRYqgT5zu3N3a54L2IF3wVTsIufbe8hs4t6hA?=
 =?us-ascii?Q?GRwMlDeMl0yp8wo4JbWjAutH0KFYWGpOIyivima/HEE16M3VsGVAJRt+Ii+R?=
 =?us-ascii?Q?g+cees+joXzBlM2pTHggMh0ImO8wP5pJLguzOIG+dYFOLumrHpKsBgONHXOb?=
 =?us-ascii?Q?ypbboxzdnOeBkn7o477Ga+kd84hRBE+z15E9Z5vmZZa3LihzGGBGOpzHUa8w?=
 =?us-ascii?Q?URK1t+hIXQi3Hw5lgVGVKr68k+iYctP92R9CJ4nv/MXZv+WtKWAz1dm5Vl/l?=
 =?us-ascii?Q?rdhREQUbCT3PRnKm+6HucbcyVNoTo4dpO4N2ylU36nqTFhCwHdEVQ1aHEUwZ?=
 =?us-ascii?Q?8f/bYJUsVQumWmNfenIyTb8PQPSp+bD5vZ3WpX1shrILZOwFqOW8A++PMkJp?=
 =?us-ascii?Q?l8HnZUeMViP8Gzi6NUhnJmWjmu99P50MtLFEEvg9C+prlG4qTfdBShjyn7Gn?=
 =?us-ascii?Q?pOCttnbCOskCtHttoB5lWb0c2Gl2E+O9PV5AjznvosVmiX0++BcAwlDiI+A9?=
 =?us-ascii?Q?8ZZHrm/2+G8zCoh3VB9jkF8bqAvV3levQtBJ8iw3TGkNteMLmLUUm5JkvWQO?=
 =?us-ascii?Q?QY3DCMw0aZspvZQktQdk8eBdFWEiFAwgrY66kq60yUg5KJ4Qfod5Ey04k0kZ?=
 =?us-ascii?Q?gNvN4w22oPUsKMQ1Cbg0VC3pJ4eshtSJTEKRyn4I9nLO3cfRrDWxcoPK2cLI?=
 =?us-ascii?Q?bS4Eqh4xjHG9IkQXoOmPL4cA4a178fvLxtVjlGwJ1ZPKQ10wmDibBRgk/Hjz?=
 =?us-ascii?Q?7rdSffvNvAS4d5Rvz+J0eqjch/T/M2iA9R7DdiqPzez5p90qlLj7rrrcbQtZ?=
 =?us-ascii?Q?ZG7bxgfYSNLdrltvZzQl3N7zebug61l7NQZnhtXXCM8ELQiLJcbjrohC8Ei1?=
 =?us-ascii?Q?2NmiHgjs0LYfJbWxUpHGs7pd5MQGA1cgy6GHmQdsd4RUrfrUfHQdMd1yY47u?=
 =?us-ascii?Q?nHo7Mp/4RInOjlvcGQtOWNZWas+UiznBik8YrjQlIeMThTG3azEnWkMbjQH2?=
 =?us-ascii?Q?3d7ZBpvT9IwY8XghF7pyVduW92v2w0uQK9MrfXI11YToeLKBaocosdL9quwH?=
 =?us-ascii?Q?ONRfns2PXgx8jvebhfyispF0dPVGGglelm8fRkNfZEK+yccc6R5P1Ut4UGtm?=
 =?us-ascii?Q?TjCCar0QsBHqKTpJ5VpEnmju8x8GGOdPpobd/Y0y7C7sypYSFtqoX6QQtDLK?=
 =?us-ascii?Q?SNiHJMOyQHqtY0xGbnE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1b6178-8afa-4875-d045-08dc440c7541
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 09:52:27.6986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJyw+KIeWQ5IJI5x7l6xr/KL/Jh+sAPQgT2tZk7gAYHOpVESgYnh6rLVE9gfAtYncmFagIsqNTV/WQLabC0ZZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428

[AMD Official Use Only - General]

Regards.
Perry

> -----Original Message-----
> From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Sent: Thursday, March 14, 2024 5:42 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Huang, Ray
> <Ray.Huang@amd.com>; Petkov, Borislav <Borislav.Petkov@amd.com>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 2/7] cpufreq: amd-pstate: implement cpb_boost sysf=
s
> entry for boost control
>
> Hello Perry,
>
>
> On Wed, Mar 13, 2024 at 06:04:39PM +0800, Perry Yuan wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
> > With this new sysfs entry `cpb_boost`created, user can change CPU
> > boost state dynamically under `active`, `guided` and `passive` modes.
> > And the highest perf and frequency will also be updated as the boost
> > state changing.
> >
> > 0): check current boost state
> > cat /sys/devices/system/cpu/amd_pstate/cpb_boost
>
> Could you please elaborate on the need for this new interface when
> /sys/devices/system/cpu/cpufreq/boost exists and is being used in the oth=
er
> cpufreq driver namely the acpi-cpufreq driver ?
>
> The semantics of this new interface seems to be identical to the existing=
 boost
> interface.
>
> I am ok with the rest of the patch, but please explain the need for a new
> interface.

The new cpb_boost can support all amd pstate modes including epp, guide,pas=
sive,
the old boost interface only support passive mode which leverage the cpufre=
q.c
Some customers request to add support for the boost control on epp/guide mo=
des,
The legacy interface is not compatible with the new one, with new interface=
, it is more flexible
to add AMD specific control logic to the driver.
Meanwhile, putting the cpb_boost into the unified amd_pstate directory, it =
makes more sense to change
the feature state like status and prefer_core,  there will be some other in=
terfaces to be added.
So based on that, a new interface can work well and support customer reques=
t.

Customer  request:
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217931
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217618

Perry.

>
> --
> Thanks and Regards
> gautham.
>
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
> >  drivers/cpufreq/amd-pstate.c | 97
> > ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index ef6381b48e76..d54399ebb758
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1208,6 +1208,101 @@ static ssize_t prefcore_show(struct device
> *dev,
> >     return sysfs_emit(buf, "%s\n",
> > str_enabled_disabled(amd_pstate_prefcore));
> >  }
> >
> > +static int amd_cpu_boost_update(struct amd_cpudata *cpudata, u32 on)
> > +{
> > +   struct cpufreq_policy *policy =3D cpufreq_cpu_acquire(cpudata->cpu)=
;
> > +   struct cppc_perf_ctrls perf_ctrls;
> > +   u32 highest_perf, nominal_perf;
> > +   int ret;
> > +
> > +   if (!policy)
> > +           return -ENODATA;
> > +
> > +   highest_perf =3D READ_ONCE(cpudata->highest_perf);
> > +   nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> > +
> > +   if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +           u64 value =3D READ_ONCE(cpudata->cppc_req_cached);
> > +
> > +           value &=3D ~GENMASK_ULL(7, 0);
> > +           value |=3D on ? highest_perf : nominal_perf;
> > +           WRITE_ONCE(cpudata->cppc_req_cached, value);
> > +
> > +           wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> value);
> > +
> > +   } else {
> > +           perf_ctrls.max_perf =3D on ? highest_perf : nominal_perf;
> > +           ret =3D cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> > +           if (ret) {
> > +                   pr_debug("failed to set energy perf value (%d)\n",
> ret);
> > +                   return ret;
> > +           }
> > +   }
> > +
> > +   if (on)
> > +           policy->cpuinfo.max_freq =3D cpudata->max_freq;
> > +   else
> > +           policy->cpuinfo.max_freq =3D cpudata->nominal_freq * 1000;
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
> > +   return sysfs_emit(buf, "%u\n",
> amd_pstate_global_params.cpb_boost);
> > +}
> > +
> > +static ssize_t cpb_boost_store(struct device *dev, struct device_attri=
bute
> *b,
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
> > +           return -EINVAL;
> > +
> > +   amd_pstate_global_params.cpb_boost =3D !!new_state;
> > +
> > +   for_each_online_cpu(cpu) {
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
> > @@ -1218,6 +1313,7 @@
> > cpufreq_freq_attr_rw(energy_performance_preference);
> >  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> >  static DEVICE_ATTR_RW(status);
> >  static DEVICE_ATTR_RO(prefcore);
> > +static DEVICE_ATTR_RW(cpb_boost);
> >
> >  static struct freq_attr *amd_pstate_attr[] =3D {
> >     &amd_pstate_max_freq,
> > @@ -1242,6 +1338,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =
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

