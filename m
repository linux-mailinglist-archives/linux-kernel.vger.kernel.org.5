Return-Path: <linux-kernel+bounces-149784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD838A95D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97871B22359
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F71C15B125;
	Thu, 18 Apr 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RyeY1WSd"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24DB15AAD4;
	Thu, 18 Apr 2024 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431881; cv=fail; b=sR/B35D/2HjrT5UIvvT39gRcfdNkQL2ga8cvu6CFFfh6sl8ja6WukQ3IZ55Rm6x1kvcfsBqnb9x7APXQLWLDMpMny4PDi4U5LHE588yD5Es3wbjVj++3Lh4VNcIt/FemQ8h67tL0x1oLjUsgi6HriuCPTWolZhJenDxXJsoTLV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431881; c=relaxed/simple;
	bh=vW6Wl7CipcFmxD4jpj/2VTZH5/UJyNgJ40TzQ2utwh4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t7Yt6wxt3cGdMNPy/O1YQ0JzCXr88IiR54EuOOqb4s6GBE/fm4Ayv8v/L6mmJ8K5gJBCJZ3bIYXqrtdGeZe0LauqH23/VrhprcDljSkIzn3VybNjhD8s6OCHr9knNy3vlyl/60uzqT4CGmh75jUvWTug7iAKfDocx+Hi0uJF/Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RyeY1WSd; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KR7NlRMfrllEYILaZs1ItwEpFV6ddPOQs6a5FnETzpSzK2lR5oslEviBpCl6s+CK+nV9j98nxiHrq8tJsru4Cmueqd8A/mGsPANoPzdQ+lYei2fHMkqhKVZFZxGcnLNevtnwNIdNNobmcwLzKkX9KvTOHYfVR+LBPGVmO+dwEoJTELmGYrmqfyONi+ZyCGCzp+e8/q1Ja+OZrFW/MR7tlthROSEMum6tB5Nwy2shF9tOdhrslFBJfFrgEN4Xndk4ZHlWhyD+KykWx6J38I1+FZlNbsVhgiyCHA7CCKiU8aJMmKvtb1rtJDCIrirhewk7aJ3HTedVfkRcjP1zsqobYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN1Kbm57xnFJ9ORZJ1uXeewDmOTPWINiUsdfa7equ+A=;
 b=NIUml9AYW4MlHS014SPtYMhRXdM6sZwOkwoiioXvJlz6pvZ0Pe3jmflcQ9vWc00LaXvypTZWIgeswLH0AZVcM5z5SQKy/WFdMLKN9BBVPqilAEeWl/vEu0PUEXxzF0IiselqKuCXOgq0h06fwoYt9qXyf+6BpV8fBFXpYwwQryfHHmi3FUlr3qKc9HV461rGlva+iPKlJmZTpTw2DKILR5um6aVQf9u9ECoxGuYbYiNKbWwxvugrGqsa7kzpW8OHzpjexeNscjrKYcvW3YX0zO/NJy/V3ibcwnqLr0QNsJDlXjtzszhgvsSRc22zu0EHLAWwaljiq74sT5l2WaCZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN1Kbm57xnFJ9ORZJ1uXeewDmOTPWINiUsdfa7equ+A=;
 b=RyeY1WSdymlpPLgDC1uvX3oJ6nJjdvRy+tz9WRMqkspt08YNIhEifsatpZ93d7umnqf6PfrHuMy8P9B7p6027VZNXk7twVfjZaYNX6fNggzV5VnMoZypr7Vc3zFUacq/zWZgiIzzpcSwIpZ8xEJhZ3WJBUhHmilpv57u9s/gJ2o=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 09:17:55 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 09:17:55 +0000
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
Subject: RE: [PATCH v10 1/8] cpufreq: amd-pstate: Document *_limit_* fields in
 struct amd_cpudata
Thread-Topic: [PATCH v10 1/8] cpufreq: amd-pstate: Document *_limit_* fields
 in struct amd_cpudata
Thread-Index: AQHafqj7zTlF2tpHFUiWMFmrMWzN6bForYQAgAU3JwA=
Date: Thu, 18 Apr 2024 09:17:55 +0000
Message-ID:
 <CYYPR12MB8655D251FC00EF8207C771BD9C0E2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
 <6b8432f302165e686a01ffe7d1d98852d5e88609.1711335714.git.perry.yuan@amd.com>
 <ZhyEwE3Hr8Waf620@amd.com>
In-Reply-To: <ZhyEwE3Hr8Waf620@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=70a4cd2f-13eb-4e4d-9d1b-9a767e9d2867;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-18T09:15:45Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA0PR12MB8373:EE_
x-ms-office365-filtering-correlation-id: 82f15f04-f8ff-4257-84f4-08dc5f886e61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 X/Gl8L/RezNotEpvep1Ir7jEH6eCCgg80PsSQ78mhxC40YL52VmtRCqHpPIQpP15PHUkMKgiYtVRcSPU2PPuLwTNHRfRTRUGi5+8M5lVJVcNpEfz6iicGvxRfQJ1/cwFpY+AtjU4lG4gyF7wt5OtfCaOGh90ocVoWo7SnZsWxSfDB5FrftmG+UkRD0aSE3x9CKsXXwMjs2y2S7oGNENkT0UD6euqnaRukM5rzedkccHvWsXtF9NBVc0hMk/YUtqs6FsY5lsRlBi4jBLTNh6zm50TadUOdDew2J8T61/iP4U/9Klrhsp/ERdbW06RWUVsQe9mhXnx5U/zfBxl+7DgkHaNaxIpFMSJeoVCG0Z+fLWC9ZCDmfdteB5xiwuR8OFQxnZwh/TMR3cyfDgUX6z4V4jb0p6n+XhmT6niLi2hJE5DHJgRPvph2FdoxTka8oRXO4yCK7hAti/3YQ/MUC/HUvIICAxhaSo7wLOwS+nJLcEwpZfFYYJG53d/cELapFRfVuRjVnhv6KF0pMgzt9cAaX830+eik1Ayr18mTj8mRMSJ6jlHkzLGW6AKRTKSFPTCp1g6p+0498X8Y0Q4pWLLjAbU0lYUKvA5Dy8Z26v0D10LmI/OrFrfAZsZoXXKPhNHHRvCZrP0fsxHvgJuBqh50C2XSeGFSVnuVV/tyqnkGIcniytU6gsSTop0TMCZU27TmKQ/aaObFQeTWJNu5LDsHzS+QUq7f+HJdSNWd6NMq1A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i8NJvUNeGVbJp8FK3tdIDArvz0ULpcjyjac/cRIMosMPJVa0FLH3J0yRZuHn?=
 =?us-ascii?Q?GKSII+qFdBgcDUl5HMGb/+2ppwPVBdzII6R1PeJO4J1qenswSCkMQEhy98F1?=
 =?us-ascii?Q?9Z6kmpBycDIBbO70F47F4xschW3iK6aUnWzit9r9mixaZNjpEqJmaArZWFBo?=
 =?us-ascii?Q?sHVDARlAnpL5CFndIRNIFMGP4VHOJPleO07AYpf2rYFpkg6blpH+a8hA7woa?=
 =?us-ascii?Q?OWqLq21/w2Ik0lwf8BJcMH/MElWMrkShuOD9x1bYFk5K0OFacDr9No06x9Nu?=
 =?us-ascii?Q?6Vt7fJyvlbHzLTbdnZh3boKR6Gy80OEMY/YfN2kdrz6/wVKwzwqM+sf12ju8?=
 =?us-ascii?Q?KYivmaEdCU/xHAdEyCk5ID+UDd4lbdA5CeFVEqQYUWPF9E4LsHKzQy8vg3Dl?=
 =?us-ascii?Q?dXyUHlUYIUoLxWKEDejRV8ZNACQMdaajS2FMiDQyK/gBiJFm+YDvzPdMe91U?=
 =?us-ascii?Q?u8CGgSiNPLr1CTdFTZ5eTuptv84+e32KtUB8ENI59hgp7wAZ63MgbHvcPOQP?=
 =?us-ascii?Q?MM6J4Ux6n/AbfhTe41ZXbMlxJZ/nzQpsKG14ISsKbNJd3KBUBvhIGyZx9VCL?=
 =?us-ascii?Q?Lg51EinE+iyAhwajfVQGf50vshAPpWQQ1Otcas7AwS+Ss8Tg3oVW8bqlaDiB?=
 =?us-ascii?Q?W1+sLbYlDX0aMP8NBH01Q6tbkbZ2B+2HPUV0n3+MEQgi+CNfX4AEgmFHHns1?=
 =?us-ascii?Q?lE3Rum5s6rXxqOBcAZBprRDn4IVPGCWsyjkgYEZuUA5jzVV4l7LKdwvV9OEr?=
 =?us-ascii?Q?b3uOR3VG7HYYvRhFiGRaixKxtsJKfIfBVyWCXhAQILA9jD7gikUgyZBRr7XU?=
 =?us-ascii?Q?hAsQB2jv6bRu3+HHwAtOOhp9OTFt3Dbg7vKfdtlM6N22CYb1UA95Q4tvu2c+?=
 =?us-ascii?Q?FbYGo2R7+oc7PozuLNx+LtJlI+byqwDL2unUWkaQ82Es+/U6yQZDUQszytv9?=
 =?us-ascii?Q?ZNoKL/FYrGw0tafqLs0xFaKo5GJZol5opV6x6IvHB0rw70YFdBXSgIuUyiwk?=
 =?us-ascii?Q?AxTH6b+/nae/XSuwJBV2OB7zgxZq+gNNg0d2bbc2EoivdmI9LtAe+0jq3AtC?=
 =?us-ascii?Q?/7WAagos222jcJrhd/mQqt2Aqd0V61xZhQcWzOiFMoCT8yRzkieJHqeqLoHp?=
 =?us-ascii?Q?94mrMVDTdnCRZrhbK9xega/jKLo/P8Ey7nZnKExN8fMOGBNqZTumxOTLvCp9?=
 =?us-ascii?Q?8dVlh4c90wH2MyEnU6HCrordSVApGqFj769vi9ykyspxMPzntoHHD8pNKvmd?=
 =?us-ascii?Q?9QeBJkgvP5JYO8jmY0fKMefGEVItcJBNcBE1k90dEbQ4+oNFfBUsUX78UGv/?=
 =?us-ascii?Q?APatzNL1lZmWOZNtVxy9eFHnELd1fXVzAELLJCzhaYp6AkO8zPkPOCYyE+TE?=
 =?us-ascii?Q?A8gJrFhB979dWCKUHJc67dCVXRnOlapIssnQgHwdxXLY8bIb60tOQALfCyhW?=
 =?us-ascii?Q?3KAnqkSZt/iMwwZhZYIqmhOImaCEbTqAZlHg1ANrJue+UNZZLbNsuS406emG?=
 =?us-ascii?Q?N01uA0eLllqFk/d01pvLlO+H/1TYFFbM30rhivBzfjN2o3c6ENzfD5wxxjKC?=
 =?us-ascii?Q?ChbQ6Kgj2k4PP6mkA6VOmaslhViKblNDs+N1YsFH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f15f04-f8ff-4257-84f4-08dc5f886e61
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 09:17:55.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5L50Gtv1m0tuaGuNtC8zZIVsNTXzL35pztCBRrcg0vRzYXHtQilnUoKtvGxRDwANzk1I1u1JEJHfuYBWABHVfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373

[AMD Official Use Only - General]

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, April 15, 2024 9:37 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Shenoy, Gautham
> Ranjal <gautham.shenoy@amd.com>; Petkov, Borislav
> <Borislav.Petkov@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; oleksandr@natalenko.name; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v10 1/8] cpufreq: amd-pstate: Document *_limit_* fiel=
ds
> in struct amd_cpudata
>
> On Mon, Mar 25, 2024 at 11:03:21AM +0800, Yuan, Perry wrote:
> > From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
> >
> > The four fields of struct cpudata namely min_limit_perf,
> > max_limit_perf, min_limit_freq, max_limit_freq introduced in the
> > commit febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and
> > scaling_max_freq update") are currently undocumented
> >
> > Add comments describing these fields
> >
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
> I think we should use "performance" instead of "perf" in the comments.

The max limit perf should be OK,  the perf string is more meaningful for th=
e pstate driver performance level control.
Thanks.


Perry.
>
> With that fixed, patch is Acked-by: Huang Rui <ray.huang@amd.com>
>
> Thanks,
> Ray

Thanks, will pick up the flag in v11.


>
> > + * @min_limit_freq: Cached value of policy->min
> > + * @max_limit_freq: Cached value of policy->max
> >   * @max_freq: the frequency that mapped to highest_perf
> >   * @min_freq: the frequency that mapped to lowest_perf
> >   * @nominal_freq: the frequency that mapped to nominal_perf
> > --
> > 2.34.1
> >

