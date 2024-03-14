Return-Path: <linux-kernel+bounces-103094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4388287BAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD41A1F254DD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107266DD0D;
	Thu, 14 Mar 2024 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HgaFJ/l/"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049454316C;
	Thu, 14 Mar 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410750; cv=fail; b=anHw6N29Ka33sMomRDFVU/eg+wHWpzvnaHagZ6U7SWgrWbgoKzDkre0LFCOINoM0Anoim7650bJqei7Cc3OlhrtbvHBrNHavPwzdiAgtJt2Lyo6mdrZkILtl5N3o3x7tsN0HEx8lAzHH1jBOhjIPKndrY0F6G8pYnHhFi62e0vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410750; c=relaxed/simple;
	bh=EjM3WC4eVDMvwQj3ypIcG/PCm00sqKNPPuYp0FcpJjM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kN1Rgr/JaGRmwp64OW+n6LvtqPXQqkZ94R9B6mGOM2IdffyVBhDO3freeyYoYgENnAHBrRBkgc2K70Lid5jnFzTu92F8xwR6v2hekFNeDFx0LeAQjRnf6kw20B890gicr3fVQEBX09YNB6Ni2Ypt1/Hm8Xie8jVeLfHbpSPZt/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HgaFJ/l/; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEf1/GdLu3Ai5wRLCiwHM0aSafF/E9FThvN9/quuRLe08mOld/78QzaYWiim/RB2PfRCRJ+NPEDGAyyM9bU04SERqA4M5WYzQBa52bOg/xm3+sywquP5sfx+96EbAIOSUzqbTRaohD/5HxO+oAdFIn7yFaf36IfXPPdGH39Agn7KLMRczRo03SSGPHwXB3jJi5YERGVL94Wh0OTlTeslba81IVWSHkmkAOQwaX3iOZvnk09lZsGuS/HddqfFnfWOLAqyb9WXoFUkkA/bNjoXk/L4NtG2IIOgEj7LEA/zx2YB/FGJRCpIM6GRqvJrikxVwaUcMeNWRQ7SNZhIxuBYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FupPvTnO37NFbREBA7+/l01F0Ly0qrMHjJzX6Yaq2Qw=;
 b=NyWuDRMcEmEmS9lj3jt7NHrwponR4St6akDKu0y8cHKVuULpFdvFyObcQNYCcJ2/87g/lQOlTq815NVyjEENPt4XoYgkUHTzB7Igqa3p9foMMJgJg7LPst5hJIAEVydCTAc1DTcyrDDJ6sl7N/o70eJq4inwSg9mVc5zlnCSyp1uOOm+4AiZ4wG+jdJHO3QhKj6Zr+fFn3A5s0ZERdWspx6G9tcyncHTz0VbVlh97GOZ1rD+53PztIXgNOlNWlZx4s5iTJ/QTeQmOnd26a5OI/yvF8e12BSJldrwkkgAtemxXUfuTwFNxsk5RN72AboZPs80oSfsVdZ6byuvhOC2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FupPvTnO37NFbREBA7+/l01F0Ly0qrMHjJzX6Yaq2Qw=;
 b=HgaFJ/l/e8KsYn2P7AiykLuD9zY6QdlN+HF+DvV1QqCs74b4aXuuHwHHQRykJbO8ssOrIgMl1YGU7mrZ+7ZpS0GHA8SRw9M9K7hqbWuTJa9JOGbn0tapCck3Zu70lF7UUMTXrcWJ3dp3rUM59XDVPmTwYy0VLRcsDWjUHtBQSVE=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 10:05:43 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 10:05:43 +0000
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
Thread-Index: AQHadS1cQ+6BG6MgdEa4KJHWRzpmg7E2vEOAgAACa/CAADvygIAABcpQ
Date: Thu, 14 Mar 2024 10:05:42 +0000
Message-ID:
 <CYYPR12MB8655A6683875C95B044B78619C292@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1710323410.git.perry.yuan@amd.com>
 <08ed1f9f76a6a1c401efd8f426bdeb9681c4b4e9.1710323410.git.perry.yuan@amd.com>
 <ZfKPy7hlwiYm++AM@BLR-5CG11610CF.amd.com>
 <CYYPR12MB865539EE324D834EF5051A679C292@CYYPR12MB8655.namprd12.prod.outlook.com>
 <ZfLEG7tBk7aeETbc@BLR-5CG11610CF.amd.com>
In-Reply-To: <ZfLEG7tBk7aeETbc@BLR-5CG11610CF.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=19e6443b-7d4a-4916-8465-7b0e1434b406;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-14T09:52:54Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH3PR12MB8727:EE_
x-ms-office365-filtering-correlation-id: 503da987-c924-4084-4520-08dc440e4f4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NhKNDbMLK1yO+1+u/1vIBlgkvJ0v5E5pUAnsxNrCNwkShjBFH1vUp3Ws3gfDpL64tOhPfXpLzFZNWEx0JH9g2szm7cJ2TP7Z5DAxbuQcCkuk8YUJ8CCgIPSBvv1ysSxOC4s4VF+xCXv3gGCi76DgGQP7mIG65vXQFxlnhiaI1bKFAT0fdzeiQnc687GS7hrhdU525KifOjW5nKyrE+QLveScgtODk6XdnmYFm0CGRlq4STtLdjHLRbdBv4Q5JCjXKs+y4JM0AZ060MBaCWTb29F5pWRXwVz3mHWcR9AuP5cfPXWU0aaY3pYNwYp+MKil2bVtWR6J1LkAdSFWUJglupJEQEYr7BoHQZ0ri4mFZhUshBcOcM0PfqiHp333hK/cdeD019a+92eOzyuRoTEWDqS8Ng93nTHG1uI1l7Apg05Mv79fkrI1D1hD+pVeI6ZoGFOTeHESovgo/YI7I87BwL66kRvfVbxrlgrVexmJhgF0MmaRLgVoCUjcB9oeSlqhNkTCTRMpNTtYmygS/ufs0Z8/TKP6eiJpQyHg0GGKGxbBipRWDxzcRgmjg2s8iuDhGSjE8/UDHn5+uqCABlM6mAX3k6oxjMRHQhIY7xsRKITDlWZ+E6LB9O8VGjCapYnUjmqsNrzBma9MT4BgRy3v+4fQM8YVzfKqidUKupEVlMu5wcO1x9srFwD97vTKnS8b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FELFTSiErh9rzNbitTUQBdnMpoJRkGZfzZHiXr0qf/IinxQhyTKZeAlf/FqQ?=
 =?us-ascii?Q?Br8FqYI4x+El6vNxeY9fDbMrUj41T+RfmvzzKdO/0npHibP7vhVE1Wc1xLWt?=
 =?us-ascii?Q?7d/CqSiKxygU7639TheiSc/gCFsP8TJ1Sh3Uk0MiqsIud2EMcGW+IKxMSGR4?=
 =?us-ascii?Q?+DkMf/h/ZQu3991UkckypqlYiU2rgB8PrGnhbkX6QkHTeKbWDWMLHx8NL24s?=
 =?us-ascii?Q?UOMOQXmmyVaxBLTRHIU0HibQoofIlV/Dw4XPXbfptN/8xYAsCH481eOu4wIB?=
 =?us-ascii?Q?m92Zuf6HKobKf89W1q4OyBvQcXBg3Al7PT2w+RQDebM3lhz1UFfzC39aujH0?=
 =?us-ascii?Q?koeq3ziVzLmKZL8OuMyUHzI3YlICU9biqJ43l0pEJJT2UwquuAhZF+QexvyF?=
 =?us-ascii?Q?Cphmbpu2ZMvzXU5GeYsUfiR9kFq6vfxCQd5Bon8NDYrg5g4toE7Cn3xecI+R?=
 =?us-ascii?Q?eTnzHMetV4tug7/68pOn3OS5ZcZ7qfkJeK84siiQpZZrLeioDG8X+zOYLAmJ?=
 =?us-ascii?Q?vyn98rYq1bHtM4/tJGNN5ofql/v5n+uABT5voDC/5vzFtMYK9wxiwpVBLGya?=
 =?us-ascii?Q?NishVPExbEaVuzD0GLjGGRtmFU/cd4kovQvO5BMZIF9jmaqueXcUjDPNfabd?=
 =?us-ascii?Q?Gqk/H9YKUc3j4VWhh1P3Pje1l6de/JMP/YA2qv/Vbt8cyvsvTGQLlUC2489e?=
 =?us-ascii?Q?9LqCSyUB1saTjIzvk6Aq7YbgveiD//vtRR8+NFJXf22ZfM8ZPB+2BVXDY8hj?=
 =?us-ascii?Q?zNPRSak8xCNLKLpmUntHLNi1aCpDM/PX08H1X3FPPnCHKZQYnxOetAVTUa7M?=
 =?us-ascii?Q?gP+U+Ps6KTAQeOpQrLWDxqxpk0VgECrHxhtapBw0pnJI+HqxVk5w3GOrN2O5?=
 =?us-ascii?Q?tQ9bRLKa0zVY61VpZFWcuRA8xmLivady35Gm3roval3wCq1JfA9QRS3Awy0r?=
 =?us-ascii?Q?AOAhKYdkWmdO2U9EDeVb2IJQvpHyg6n0qTgWl8ZuPbJmHE7lu6DQ/M8VdMAz?=
 =?us-ascii?Q?jpTWA3a1qfOPvltNuoDF0kQFy2g/H0S/uXx5MhUCU61MtTL4YntAWeA+KXRi?=
 =?us-ascii?Q?Aj2wYY8UNi2DQInjT5MLa7uV/3p02Sgu9tpnXRWZ6av8AMJcRjKV2N7K3VBW?=
 =?us-ascii?Q?t9vsGPUj1E91bJ0WhAD1KxmEadw4Bqwvc3nOufDifwtHhDQ6MmvfHUzzhqLW?=
 =?us-ascii?Q?1g3Wuvpsv0hwZ9qjSD9B/o8Yskm3u8ReeB89FlH9WBOZD9yLTE6zAnTLcuR9?=
 =?us-ascii?Q?T84P5o+K5uwuZVkm22j2BHzUoOH5ViOVJq693aQrHo7fMqyBWs2/XeHPzQHf?=
 =?us-ascii?Q?CwbgU0KMUAxgIcMe99yglIkAI0Bi/5kSTxHnu5qBWR0/hVOGkht8u5iGsrq3?=
 =?us-ascii?Q?Hn7FAObmp2YJVpYe7bF0nUdMD3rYVc85e5xduD4I2aLwzpcECGpeaR2JrwMZ?=
 =?us-ascii?Q?KLsv2c1yaR7CkhQDcB2KykYcaTqJ9/4Onm1RAFQCr6gt4rlhjFsBiBvLWngf?=
 =?us-ascii?Q?NMDZFDK0gtDZu0dGjOQ6IH6/1KahEJDe2ADlcyPYDzEvNe3bwyE8uEP+U05N?=
 =?us-ascii?Q?tmPfOgMMtX81bln3R9c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 503da987-c924-4084-4520-08dc440e4f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 10:05:43.0135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3zQNSz9zCFy2eD1QRgO6uGZx6oPVLYkzSKVnx01qm4yBT+bivBE7hkG3qNpzvO0u8uN+kHhcKYPTc1zln2Slg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727

[AMD Official Use Only - General]

> -----Original Message-----
> From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Sent: Thursday, March 14, 2024 5:32 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Huang, Ray
> <Ray.Huang@amd.com>; Petkov, Borislav <Borislav.Petkov@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng, Li
> (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v7 1/6] cpufreq:amd-pstate: fix the nominal freq valu=
e set
>
> Hello Perry,
>
> On Thu, Mar 14, 2024 at 11:39:20AM +0530, Yuan, Perry wrote:
> > [AMD Official Use Only - General]
> >
> >  Hi Gautham
> >
> > > -----Original Message-----
> > > From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> > > Sent: Thursday, March 14, 2024 1:49 PM
> > > To: Yuan, Perry <Perry.Yuan@amd.com>
> > > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Huang, Ray
> > > <Ray.Huang@amd.com>; Petkov, Borislav <Borislav.Petkov@amd.com>;
> > > Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> > > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> > > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH v7 1/6] cpufreq:amd-pstate: fix the nominal freq
> > > value set
> > >
> > > Hello Perry,
> > >
> > > On Wed, Mar 13, 2024 at 05:59:13PM +0800, Perry Yuan wrote:
> > > > Address an untested error where the nominal_freq was returned in
> > > > KHz instead of the correct MHz units, this oversight led to a
> > > > wrong nominal_freq set and resued, it will cause the max frequency
> > > > of core to be initialized with a wrong frequency value.
>
> What is still not clear from this commit log or the rest of the patch is,=
 which part
> of the kernel code expects nominal_freq to be in MHz, when all the other =
freqs in
> cpudata are in KHz units.
>
> If nominal_freq is in KHz as it is currently, how does it cause the max f=
requency to
> be initialized to the wrong value ? Could you please elaborate this ?

OK,  here is the story.
Actually, the original capability values are Mhz like below, so the driver =
need to initialize the nominal_freq
as the as-it-is value, then pstate driver will calculate the max frequency =
as needed.

feedback_ctrs:ref:103751311076 del:87445442175
highest_perf:255
lowest_freq:400
lowest_nonlinear_perf:124
lowest_perf:30
nominal_freq:2801
nominal_perf:204
reference_perf:204
wraparound_time:18446744073709551615

The previous driver did not use the READ_ONCE(cpudata-> nominal_freq) at al=
l.
We initialize all the freq and perf values in the init functions like you s=
uggested in the other patchset.
 if driver still use Khz, below code will have problem.

        nominal_freq =3D READ_ONCE(cpudata-> nominal_freq);
        lowest_nonlinear_freq =3D nominal_freq * lowest_nonlinear_ratio >> =
SCHED_CAPACITY_SHIFT;

        /* Switch to khz */
        return lowest_nonlinear_freq * 1000;


Now we can read READ_ONCE(cpudata-> nominal_freq) without reading the CPPC =
ACPI again.
The nominal_freq must be in MHz as it is.

Perry.

>
> > >
> > > As I had mentioned in my review comment to v6 [1],
> > > cpudata->max_freq,
> > > cpudata->min_freq, cpudata->lowest_non_linear_freq are all in
> > > khz. With this patch, cpudata->nominal_freq will be in mhz.
> > >
> > > As Dhananjay confirmed [2], this patch breaks the reporting in
> > > /sys/devices/system/cpu/cpufreq/policyX/*_freq as some of them will
> > > be reported in mhz while some others in khz which breaks the
> > > expectation that all these sysfs values should be reported in khz.
> > >
> > > [cpufreq]# grep . *freq
> > > amd_pstate_lowest_nonlinear_freq:1804000   <----- in khz
> > > amd_pstate_max_freq:3514000                <----- in khz
> > > cpuinfo_max_freq:2151                      <----- in mhz
> > > cpuinfo_min_freq:400000                    <----- in khz
> > > scaling_cur_freq:2151                      <----- in mhz
> > > scaling_max_freq:2151                      <----- in mhz
> > > scaling_min_freq:2151                      <----- in mhz
> > > [cpufreq]# pwd
> > > /sys/devices/system/cpu/cpu0/cpufreq
> > >
> > > What am I missing ?
> >
> > https://lore.kernel.org/lkml/42a36c7f788e0fb77d4be7575aab9c937e1773de.
> > 1710322310.git.perry.yuan@amd.com/
> > Changes from v3:
> > * fix the max frequency value to be KHz when cpb boost
> > disabled(Gautham R. Shenoy)
>
> This CPB boost change assumes that cpudata->nominal_freq is in Mhz which =
is
> not the case until this patch. So is the CPB patchset dependent on this p=
atch ?
>
> --
> Thanks and Regards
> gautham.
>
> >
> > The previous problem has been resolved by the new patchset of  cpb
> > boost support
> >
> > +       if (on)
> > +               policy->cpuinfo.max_freq =3D cpudata->max_freq;
> > +       else
> > +               policy->cpuinfo.max_freq =3D cpudata->nominal_freq *
> > + 1000;
> >
> >
> > The frequency values of cpuinfo are correct on my system.
> >
> > amd_pstate_lowest_nonlinear_freq:1701000
> > amd_pstate_max_freq:3501000
> > cpuinfo_max_freq:3501000
> > cpuinfo_min_freq:400000
> > scaling_cur_freq:400000
> > scaling_max_freq:3501000
> > scaling_min_freq:400000
> >
> > Perry.
> >
> > >
> > > [1] https://lore.kernel.org/lkml/ZcRvoYZKdUEjBUHp@BLR-
> > > 5CG11610CF.amd.com/)
> > > [2] https://lore.kernel.org/lkml/1aecf2fc-2ea4-46ec-aaf2-
> > > 0dbbb11b5f8b@amd.com/
> > >
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: ec437d71db7 ("cpufreq: amd-pstate: Introduce a new AMD
> > > > P-State driver to support future processors")
> > > > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > >
> > > --
> > > Thanks and Regards
> > > gautham.
> > >
> > >
> > > > ---
> > > >  drivers/cpufreq/amd-pstate.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/cpufreq/amd-pstate.c
> > > > b/drivers/cpufreq/amd-pstate.c index 2015c9fcc3c9..3faa895b77b7
> > > 100644
> > > > --- a/drivers/cpufreq/amd-pstate.c
> > > > +++ b/drivers/cpufreq/amd-pstate.c
> > > > @@ -647,8 +647,7 @@ static int amd_get_nominal_freq(struct
> > > amd_cpudata *cpudata)
> > > >     if (ret)
> > > >             return ret;
> > > >
> > > > -   /* Switch to khz */
> > > > -   return cppc_perf.nominal_freq * 1000;
> > > > +   return cppc_perf.nominal_freq;
> > > >  }
> > > >
> > > >  static int amd_get_lowest_nonlinear_freq(struct amd_cpudata
> > > > *cpudata)
> > > > --
> > > > 2.34.1
> > > >

