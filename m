Return-Path: <linux-kernel+bounces-149778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C71AC8A95BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EEB1F23587
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E314815AAD4;
	Thu, 18 Apr 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5FuadTBU"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034FE158DD5;
	Thu, 18 Apr 2024 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431581; cv=fail; b=C6BpXC8uaHmYetHinVoYg0VAPm6dFIXtla+kwPGPd44KOi/uQLkmtxIetC1b9NPvDPV5+SvSNvgazQOhZ/hzur3dzDpzszAGwwG2Vd/Y93Ajg13p9paL8VWs7UAbhUvCKNQrW8Fh39a4V3pHCi+FyEHQazJgw0HU3BBuGuO8IKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431581; c=relaxed/simple;
	bh=GOJN073ewCRBX7DhvK00AvZTy0554LGWueCiRzyMLRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RavUUnpQ5rr8Qx/OAFXEddbb15UGX58DQsyWCw6f5P67LzIKEkf3wKHUM0ehKMK0Jr5sApdGKXJdNsmGyl84bNlGOiMBILY+VBMHLTem9TxU3zCcr82X584UlMvY13yUzuP7HP+LgvP0LatkZlHN9JGY8bf98S6DfyqkeBO7wks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5FuadTBU; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdKfddh0r7bpAvYjhJHraUrbdkysQ9XfB54TTc9WsDCmk85uRmW8H3BOOcuBhuipPFcptgbn04t6LpUEOQ9E5rKJf4ODqf44bsfzjQsNOkSg/5LsHAQfFGPiyjCar1vE1ek9jKxWSfSCUAAs0iGKYgzsG2knJP+rWEJtuB288GLTMoE3HmObpZ8G51+kKNx16w7bGYxpGgNNYkpCHxiT9AW3y5Tij5R+36sI5HEqzshFHpY1gjy13I2t4MfhZtreNMNjhEQLsojsobPGBf2XnTYML2mU56Zw1jG9iWb0ed3GJuyXTuu2WgO8fKlHKwzgOZA/soskVYKqdeSiLdmwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7t0JLkiMyT0uvr3clgnRf0lhf2YfyKWxH2Wr8WwBtBI=;
 b=mtHMXCB07ceqpjv+Q1F+tkkoK49yn9AhZBjFOTwLudyeAjwMZjD4Q/oLoYfOrnj0Uv3FZ5+VhtpSDMR7pl2I1Eb9Q9rqoSmkxtLu8Roy9rr/KUG7rG1KffyhJkXuiKGqM1jFIQrRE+jOjHH/ywfK/LPqcepmjFZZAF8RB5vJC0S3IDsEAFhS6Qr0XWIbFIqcsRYbkpTg9kV9Qiq6Lrr+8Ei1Vt3jb28GYES/5EpVVmVEPnskS/jVDMsDfpnXwz0ptPpZh/jDTPnVzC1MBTsBiplDn7fg/g2/6mHqcUXj7Srz6VFrXhQzjo+lgE3WCUamJHYfoIeRl72j3sA2gme0nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7t0JLkiMyT0uvr3clgnRf0lhf2YfyKWxH2Wr8WwBtBI=;
 b=5FuadTBU+RUMXzoa8jqZ02Wd9TSdt/TP+6Fy75Wa3dRgd2uw1fq1FN5JZRMiKcerNNwGM14dx9Tw+tlEJ5LWXHxVEIeSo2heb4DlopMl+QaoIfGEqQFgiUQItsv/Qgorx6eCr2q+51qh+1poX6XAKM8kITEQmaDD9nJR9QNYjEE=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.55; Thu, 18 Apr
 2024 09:12:55 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 09:12:55 +0000
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
Subject: RE: [PATCH v10 5/8] cpufreq: amd-pstate: Bail out if
 min/max/nominal_freq is 0
Thread-Topic: [PATCH v10 5/8] cpufreq: amd-pstate: Bail out if
 min/max/nominal_freq is 0
Thread-Index: AQHafqlY2qQ26ls5VUGx4r/FI7TAtLFpjaMAgARV9LA=
Date: Thu, 18 Apr 2024 09:12:55 +0000
Message-ID:
 <CYYPR12MB86551E90D79E0324845D8C9C9C0E2@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
 <c2809391c877dd5842389aaf87bf2b5fce5dc866.1711335714.git.perry.yuan@amd.com>
 <Zh1AwtnewmweX3zr@amd.com>
In-Reply-To: <Zh1AwtnewmweX3zr@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=570a3b71-859b-40c7-be74-6eafc05079d8;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-18T09:11:55Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|PH7PR12MB5735:EE_
x-ms-office365-filtering-correlation-id: 4f4b1332-a697-4264-9d09-08dc5f87bbef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 R1JuVzzEKcd9l1c80yrXSutIboL7cp9w0O3c6PXPV1csGrkzQF41ksGzhB9mMKtI+TcQtNzLZn46p02aXy3N0RNCWrTAvjeNrT+eLjIJh57GMQ18hsslOphuxWacTP14Ax3iRXP5jjTtj4cJ98C0dl2axBO/OXV3fv+IYIAwr0QIiRLXMLnEF7xL2ekW3bxvw3vvPchTeeeq/k2e7g4mSvfQ6FzMImMIv1l0lxhGJph2HOJrnKMXglNdTUD8/H4Pflvh1WYIeSbTsY1zbGzxu+UHxPXGqfBylD6nBrl/0t24m0cVPGVlqcLPiO2XU6tMslx8GO4m2yaoxK79iDKOkcDxCKjJLVzJ60TDFz3tbdRn92iIuxx3M8ZMs2oudFoEV5KttdD0Sdvar678GgZa3+tG09+ROc8+YdklvDjsXtXrokFvKDvo9pWGmIOAXyIPEwunQPd+GqY9eeEBWpCPLrsAnjo7ZKxKW7x9iZrn6y2C1SYGV06e6X5ppFQQENtNsBwFqVLJOfuAIXQxUF1zjrZKRCUqEl0BJmltJLBsoeSrz4gZXjH/FagyF9VfcUz4ifpOvafxbT/MyWLQqQt/r72V7Z3ft+QnIGUntnUjnhu7E25QTdgC1/Y4xjmThDWKOhYrAxLcU1WsL9HETDJbBkL0KOv29QiNq9404849j9LrHoZ8OuLbnwbql5b05zoiBEnD+7E80BNeBmKgWmslGn0rqKtztTAN2/QyliKFJdg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4iSWze+S8ZeaeprDmZ6Wo3TB6M8vlgoxHPT4wkcCvnP1uvCtT32SEV1X0IOS?=
 =?us-ascii?Q?ViJZkPcSqpkdOhJ12CVkOInfDljPMGoLeF8NpCT8+k1bk8ExWunSSh3CAdbq?=
 =?us-ascii?Q?DQ3Kf44gEg9S9OAM4fw0DsegiezXH4tJVKUN7FQXfR5VtphT6eYMMjfzUNZV?=
 =?us-ascii?Q?ZqD5WsO1RYkbO4rE9RnMQ1vNBcQ8tcnyb+Mjmo8C6cnHwNreZeYZjMbi5P7U?=
 =?us-ascii?Q?by8N/8FOMks9gi5V0DmBNkDKF00dsUxcka0nK8xtBd9VgXIH0kFjYIydhFR7?=
 =?us-ascii?Q?HdJdF7QgYwDCP5uKYsJOAFXFdjhoK2BcpyJGNMHQ1zgJEfpA0btFarLdB2xp?=
 =?us-ascii?Q?O2UgK3nuY9H2jqJKdNbQYnv8rQIQpgRtT0/H8nc3YX9ABlp/vZ3OqB4gdAbN?=
 =?us-ascii?Q?AB0Azozc0SnjQ0dvb8Sm35etb7I0v+sZdR0YIoQRsxAGvzzAMtvCrcUpUKKi?=
 =?us-ascii?Q?bZjLlPZ1xYIJlIwiLrDSmYL54xrhzZ52uIOEBwfhWWMYVhLDxuFIQh0r3ijD?=
 =?us-ascii?Q?xtqqg8ItciJOHNTMYApPG779btiMHVaKWO1OJrEc28IuR5+2bmHhPC4HLSJX?=
 =?us-ascii?Q?3h0a6c2k6tIKz3ZcYHW24E8ZrCif/XfnKpqmiSNm051qkMEu86VjbInHXJMp?=
 =?us-ascii?Q?M1zXiuMKx/OE/Wk4WuT1e3s0NDBm1kQUb6HE+U9rBZbJm7fhR35fVvS+vVnl?=
 =?us-ascii?Q?fueMhGuKvwiPjjv7EEJkBHDkq7RTsA7XaGZCCIKi9nHEiAtudkias6/nEJL1?=
 =?us-ascii?Q?hX35ff8EG67nKsQslSpxqMBGZbHKopmWZn8XrhUOra2OsI8D1DrCBLZyvNiB?=
 =?us-ascii?Q?cdPxfmx0vhld7pms9GR+3a4iroWHX5cx2LG7yeiAGN+ak8Cek+E3y8DCu+it?=
 =?us-ascii?Q?+XWQBDihD06otIfCP+FuqHVPcFFBwZ8v1dsWwxTbjyBN152LThjrq00y/EEy?=
 =?us-ascii?Q?j9bwx/1LJU1fonL5qUKKXyIjamXDy0YKplqqN4ZzD0MOyu994eCOYewprZQO?=
 =?us-ascii?Q?U0GF0KMVFIoq/L/0nuKNXvAKRYe3MedXU9yGVzK2GVmcBFwRBFD0rjQemOFU?=
 =?us-ascii?Q?gbM4Y7lttgytduhk7yg1JSffmLd/MknRijyg3aLKijv3sOy8WpgbC5aXd5HE?=
 =?us-ascii?Q?x4AOAujekEAz0L+6EBBxv/BmHY/ceUzzpZUmr8Rbycxoxy1BJQv7ijTQtWYt?=
 =?us-ascii?Q?NsgXtxVGjKnfmJL2V4F4AeTxW5+ZhcDX9E0NnK4kVqm/pwt8Nv2r6HEedKH1?=
 =?us-ascii?Q?ILmF0MPCroEXyXust3DBxFO1K3ufJq1qDHoRbtfQaZ+i0Z/hwhUZBVuW7kGe?=
 =?us-ascii?Q?Vr3rh4OhUkcNoS3wBSrh9axnxjOM4PlQtgAv9GigDnvKiVu2dvInHV4VpZTv?=
 =?us-ascii?Q?lVdqUxQXtZGOpnNSxrU9YkX+teBbvlyWJdEvO/yQ/zgus0+IMiVi1QneUew5?=
 =?us-ascii?Q?b2VMrwDXsDglMuDbmzs/B6jpsmljcrOJJ08KwOtTFfDhAPiOB+Z0sIT7Mztc?=
 =?us-ascii?Q?a8bGhw1oiohI/r0p07TbYiBq7LOrH1QoKvhh/cOxGAUGZImkCh/W227ADNhW?=
 =?us-ascii?Q?OuT6KwvrP6MqUmz487ORjSPaM7Gr+0cpwaHuOZi2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4b1332-a697-4264-9d09-08dc5f87bbef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 09:12:55.7734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fhDlIkiMifvd4q+zxVB7w2j+EtorexuFur9VtM55b7mGOeb+Qh41sGiHkKpSQ0+YgKR7GqeXulGofjDnK6zPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735

[AMD Official Use Only - General]

Regards.
Perry

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, April 15, 2024 10:59 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Shenoy, Gautham
> Ranjal <gautham.shenoy@amd.com>; Petkov, Borislav
> <Borislav.Petkov@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; oleksandr@natalenko.name; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v10 5/8] cpufreq: amd-pstate: Bail out if
> min/max/nominal_freq is 0
>
> On Mon, Mar 25, 2024 at 11:03:25AM +0800, Yuan, Perry wrote:
> > The amd-pstate driver cannot work when the min_freq, nominal_freq or
> > the max_freq is zero. When this happens it is prudent to error out
> > early on rather than waiting failing at the time of the governor
> > initialization.
> >
> > Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 132330b4942f..6708c436e1a2
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -839,9 +839,11 @@ static int amd_pstate_cpu_init(struct
> cpufreq_policy *policy)
> >     nominal_freq =3D READ_ONCE(cpudata->nominal_freq);
> >     lowest_nonlinear_freq =3D READ_ONCE(cpudata-
> >lowest_nonlinear_freq);
> >
> > -   if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> > -           dev_err(dev, "min_freq(%d) or max_freq(%d) value is
> incorrect\n",
> > -                   min_freq, max_freq);
> > +   if (min_freq <=3D 0 || max_freq <=3D 0 ||
> > +       nominal_freq <=3D 0 || min_freq > max_freq) {
> > +           dev_err(dev,
> > +                   "min_freq(%d) or max_freq(%d) or nominal_freq
> (%d) value is incorrect\n",
> > +                   min_freq, max_freq, nominal_freq);
>
> I suggest that we add one comment to remind that should be the error of
> ACPI table or BIOS.

 Ok, thanks for comment,  will add one more comment in v11.

>
> >             ret =3D -EINVAL;
> >             goto free_cpudata1;
> >     }
> > @@ -1299,9 +1301,11 @@ static int amd_pstate_epp_cpu_init(struct
> cpufreq_policy *policy)
> >     max_freq =3D READ_ONCE(cpudata->max_freq);
> >     nominal_freq =3D READ_ONCE(cpudata->nominal_freq);
> >     lowest_nonlinear_freq =3D READ_ONCE(cpudata-
> >lowest_nonlinear_freq);
> > -   if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> > -           dev_err(dev, "min_freq(%d) or max_freq(%d) value is
> incorrect\n",
> > -                           min_freq, max_freq);
> > +   if (min_freq <=3D 0 || max_freq <=3D 0 ||
> > +       nominal_freq <=3D 0 || min_freq > max_freq) {
> > +           dev_err(dev,
> > +                   "min_freq(%d) or max_freq(%d) or nominal_freq(%d)
> value is incorrect\n",
> > +                   min_freq, max_freq, nominal_freq);
>
> The same with above.
>
> With that fixed, patch is Acked-by: Huang Rui <ray.huang@amd.com>
>
> Thanks,
> Ray

Thanks for the ACK.

Perry.


