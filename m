Return-Path: <linux-kernel+bounces-119571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E7788CA8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D54A1C294DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123231CAB3;
	Tue, 26 Mar 2024 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnpL7+9f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F41CF8F;
	Tue, 26 Mar 2024 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473394; cv=fail; b=oSAmIbcl7pV5tOAnmtKyxufJon72qqPBe61IHYGmqKl3xUkJl4QDhtb8SFU1R8mPmgXU7+AvUmvawFvNWlOjKlTKglwnrkq2UPTQX4olcbUXh08Z7sJ9qaksqmFKu5YB60XCCAvYcmMecCDyWViVDpE0mv9iFVV0gV51WtVXihE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473394; c=relaxed/simple;
	bh=I/It2H4cX59NcoqROxfHoZqW++bnyE/IiSK2SgiuI9Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CEasg5bCMpIKi+x2MQ6kU+9GFaLrSTg/I6gXlllj+s5D57ueRq5shezUWMXwLcNs2WQNwzuPIbq2IKXSD8g0+pCeAr5waVCu9dDZpWYT75/6JcazVvnRjjAsbEoRyF5GAz1B2tml+ye7wdskiC9OqZHxoAZLnVEyvY6+2yFnavY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnpL7+9f; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711473392; x=1743009392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I/It2H4cX59NcoqROxfHoZqW++bnyE/IiSK2SgiuI9Q=;
  b=AnpL7+9fwDhPj6vdKqlvpVmpyusI+cp4tgYLJNjSuqCQm3ovqDYXTxad
   w8OBQAUUpkD6qPabnvSgvhN+YxoHJODsGTrZahc6JwEogTxUqwR0m1WLv
   FNQbqrxwk7UMWKzlL683sbROWhPkcE5FrsT425OJ7V+dEdzqnhGh/k2pL
   SnKYjKE4MTY57JfQLUFW8GDctKpGoUPYp8ZkQAvZNaT8Hqpx2ktgUKjS3
   5yTW/gz0KEd+VdWZ9ZV2Cwzk6b5fmAsxCYS+U6zt+elVg7YShuORNuCT/
   nKqapVoE81mTEJZp/QgsCyBZKJK9i9S6PP+CaFbel9922P6cukuCEyDo1
   w==;
X-CSE-ConnectionGUID: l3A7lOIoQ8aqvWTpxuB5fg==
X-CSE-MsgGUID: iTWersxOQB6XbHJ1FRtTTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6658559"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6658559"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:16:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="47038289"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 10:16:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 10:16:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 10:16:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 10:16:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 10:16:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kss0qaAb+cLsh/dQFd/XZH2RG1Ce2NstCC9X1d4a9v+BXhovdrDVxy2wRUM7KFypdc1zrcPiGi3Zy8DyDKZWV8g4A7uCjjsnjROvsp03BFa/7zie3+pUfCwlj5zoWujctp90S0OGiGyEuEr6aKr8C+JA078z5FxE5GyvEtqTiOqeIiu5FVcZGZusTOGAR6NHYnJtO4uRvpaQ0t/cx+rZzia1+cHxsTjthMilVf6UVPEEIrm9Mps3IJz7wtWjLvD53GLB1dx3/n9ySGGAbNrtnOaBugozhrdDysFtv6Rbj+W7zKFgFB7k1qaj1LOP1aJX3cbXOX1AGf2xL2fUeZQl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3WVgJwsEr9guSIfCKjz3JrGn7KZa/nY+w3CbfHL62E=;
 b=gzRdk0RAP+hLgOkRhsMeFito6vDdycacOD1ltua2CjdUvF337AD4L2oZsffGM/OHIAySuuPZOE+/q5RTIX/owCU5SuYeOyoeBFCPjxCcJaO8mMKt8rqcgnCmmBEeq7CZPgq3fRNRvXcK9GgjOjeSwz1rX8gSTM1coxNb20ff1VuFkNyqeZpGZeo9UHPp5APLXc17XF7M/1MMA+BvfzILOMvYwugwJknyYgCbCbz0ylJjijSkrBa8znLay/DnRXIcwgfKhjkPJ6+gsgbo/6lVBkxYFA7NDES/KDDoHuZMXkUrrmSSMDksBkERut4oMshcDtE0KbOzEHvl6l42sg26pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by CYXPR11MB8692.namprd11.prod.outlook.com (2603:10b6:930:e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 17:16:27 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688%6]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 17:16:27 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: ivecera <ivecera@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 3/7] i40e: Change argument of
 i40e_detect_recover_hung()
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/7] i40e: Change argument of
 i40e_detect_recover_hung()
Thread-Index: AQHaeUEKvHXv2L6sMUGIxq4FZ5bIv7FKT9Cw
Date: Tue, 26 Mar 2024 17:16:27 +0000
Message-ID: <SJ0PR11MB5866E0E090A73D9793D510E5E5352@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20240318143058.287014-1-ivecera@redhat.com>
 <20240318143058.287014-4-ivecera@redhat.com>
In-Reply-To: <20240318143058.287014-4-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|CYXPR11MB8692:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5vv1UeGdQPIClI6gTfo5FAj81dRt+ghpa6vfPWE1onyq5qP3KT8rOUY1oGrusRik4xvmhRbj0/NZGw66J9DC5qSGo7TbWSPmHdzG0ssGfk73u4vG1+n6l5DhoSx9mzI8es1oUXVzSz4LKfjBW9aQMEfaZ14w5B4s2IY7oMN78NE/OJ3L/Jt22/pRhRlbWn8zVaaGUb7liCgkmuu97Aq7oZc/owOg7FmCCBcO9MvsAtU7zLC1lePkwQ6bJcPF5OfTpWrdnaIayE5cuDzL3LJ8dK3WFw7ohfIxRGNFiU+QkJppOvbw/g567vrr3583KiwbwHW3QJ4HChLQFdd/30hfMuLDffD4T3f8yp91Fvdgz6ljYoxcHbhRuEIK+C/iGBner+nfwgOlam9nYLetlwDK+SV2CRKMpSvJgL2+xkQsaKsmaVuASmhTkPu2ZeWKzaOtjFjszcQumKU8TkPQsa7fDmEcowU+y2iqriUzH229clhhJZ/DXubanuHOaHhVYonqR6Efcx4RsvrvQHC9TQklIGUicC2QnCqUPxB+Q3fiVhSMvY9rilIHeH16ynrZIrvMkjIavg+Komo56EI1ziIC0xUK9ed6bjVsUu4/3dQvg5WwaMQUhPvCAGMR4py/D+rhkgM4toQHrirumVotydUICQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+ypsXHEJSNYFGS0K0Po3HyTGiVMF4zFIerDDSx+aee9XY19xk87lmrTDQUno?=
 =?us-ascii?Q?n7korGIPqsWgiQAes3p2dDFWvL3KUUN4oxb+EaNDZnQXcfNovX2b3F/Z+RgJ?=
 =?us-ascii?Q?be9JznvQceGzCBBF0GXPRUshxRP+W6xBe3kKzyWW9va1Dzdh3natcy5vPi5x?=
 =?us-ascii?Q?OK3t3J+De0KhrwYq3V+c5UAEvhwpYQfcsRhiXZTM+AMPZsA5ZA0/eJMq+tdD?=
 =?us-ascii?Q?fgDfW41823p585TnJAbZDuhu25eVgC8Q5Q46jXTYigzAxJ1uL4qm+wsjtLqU?=
 =?us-ascii?Q?1oAGZk2lh1JsjYmygEHlnHlu1okrRzkhsoUoIMDYAFLalr+XTlegXyPz3lLA?=
 =?us-ascii?Q?yCn9dh9d0p0wz+WdIgg8afLT1JF/Kk419+zJZ/eKRCKq69zaTO2FebC6zEXJ?=
 =?us-ascii?Q?jPIzm3RtoaxTPv3LDaL04R337A5TbBpoqHnZXSG33CjZfIJHOsnGu+NOXKkA?=
 =?us-ascii?Q?eqSinjckEFrNkMw1Gj+Eg9lSxpcVERgnEDMdnBszwKpvyjd73ZXesgS4qNBu?=
 =?us-ascii?Q?tA5PFYxwrfypvJwtX+VDIGuUwgdf5meo/Movzo62ScrWdgWQQFZMVY4xTexD?=
 =?us-ascii?Q?bHFP6w8nSfnWrGJsUcB+xJHUWm8p4/3pG+UmrAyTFfg/mhn8uQ8cBgmk7vGF?=
 =?us-ascii?Q?5zsuU1CtqculqMY7O2dw/MD5ior1E+zjlhGzvw2Et7rEZdxFIS5FBADDVcNl?=
 =?us-ascii?Q?SZNVSodKVX+7JBq9h1oj70mmJuOc9T4+crYTK2BJF2rllVgbrOpYYC6+Qm/T?=
 =?us-ascii?Q?2AnHYWmL8qKzzuobRjvg7lD4B4DOdR+J0V8lLS4TZhTsEHnru8S6oz+3tQ6m?=
 =?us-ascii?Q?BHJ1uNIyK/RDea3UUbUCpdjzLNrqH5cTu1XeVtPkmmIUvMZXJ4QUk9Ft8X62?=
 =?us-ascii?Q?B40lDnmWFTyfCkPXpS8mQqXv4IDIXdPonOF7C2VBB/4wM29i6/Tz6v8hsVu9?=
 =?us-ascii?Q?ELcs89UOgjyjjGejU9kQKDT9iRuiszMsER9ciM1UFIRf2KVdWL6JknH7yYXO?=
 =?us-ascii?Q?pYPbQ+Jwp5Agd6Uk43CVN6DU5gmFe1HU+Y2z0cU9qibBMwhHO4dHW0Snyglf?=
 =?us-ascii?Q?q6ExT7ABPp1PN5Mx/laIotsVt7f33x2g37KOyMOtMkE37qtheP8sLSJAT2iL?=
 =?us-ascii?Q?9M+ZKaYoyaJ90LcFyDL01Eo6IHWJZXdG1CIwH/dZFvvorXgKLthwox2kAltl?=
 =?us-ascii?Q?YeHxMxYj2pHtfzx5Yfko7tkLbg7TS0Dc9hmXu+NHU/t0hW4oQv4dgJKR3jV3?=
 =?us-ascii?Q?n/i3OsVP2xyLL/4LoHvj/J3eF/gfPeQ8DSX2msr3jBDlcYeZTWwD9LA/mLnw?=
 =?us-ascii?Q?n3p6cW4cn70d90koeZHGvGXjvWDi2Lsf/E3x1rdoXO3GZtX1CVXryArB2fVj?=
 =?us-ascii?Q?/DwgPTvbh4TYMCz2w39UpZV75mx+pVVAwHysHjXAbiP9O2t+NptVfIAiY4QV?=
 =?us-ascii?Q?lg2RA+61y6B37UIShYJktln7H0r7h+prulDKM4j6BFGVD6yGi8nxLfXvLfQy?=
 =?us-ascii?Q?T+TSebWztYb8fGaTJ72D7rs6xq4t6B87nRyj/l7X/NklkZ9Pcsrrh3bUrK7T?=
 =?us-ascii?Q?xbSq9h8x3c5Gntc068VSMErr+MhbeJTVY3o9v/R3riiYrPISegCMuNbV6F9c?=
 =?us-ascii?Q?VQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9b19d3-5dae-42bb-aa69-08dc4db87897
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 17:16:27.1743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaBVskYTPJ2lOFyEvYtdZ5brJlj8EWmkxPa6edDmPX/K0AswxtwEkqC6MT1qV2kSd0zCeH8XjERucQ9JqT336cseWyTECpITWXZDRnt777Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8692
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On
> Behalf Of Ivan Vecera
> Sent: Monday, March 18, 2024 3:31 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: open list:NETWORKING DRIVERS <netdev@vger.kernel.org>; open
> list <linux-kernel@vger.kernel.org>; Eric Dumazet
> <edumazet@google.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; David S. Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next 3/7] i40e: Change
> argument of i40e_detect_recover_hung()
>=20
Please change title into Change -> refactor to make it obvious you don't ch=
ange any functionality, but just refactor.

> Commit 07d44190a389 ("i40e/i40evf: Detect and recover hung queue
> scenario") changes i40e_detect_recover_hung() argument type from
> i40e_pf* to i40e_vsi* to be shareable by both i40e and i40evf.
> Because the i40evf does not exist anymore and the function is
> exclusively used by i40e we can revert this change.
>=20
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +-
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 ++++++----
> drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 7fed7fb69d4e..1ba28893f49e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11274,7 +11274,7 @@ static void i40e_service_task(struct
> work_struct *work)
>  		return;
>=20
>  	if (!test_bit(__I40E_RECOVERY_MODE, pf->state)) {
> -		i40e_detect_recover_hung(pf->vsi[pf->lan_vsi]);
> +		i40e_detect_recover_hung(pf);
>  		i40e_sync_filters_subtask(pf);
>  		i40e_reset_subtask(pf);
>  		i40e_handle_mdd_event(pf);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 1a12b732818e..e35a08de16b2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -860,13 +860,15 @@ u32 i40e_get_tx_pending(struct i40e_ring
> *ring, bool in_sw)
>=20
>  /**
>   * i40e_detect_recover_hung - Function to detect and recover
> hung_queues
> - * @vsi:  pointer to vsi struct with tx queues
> + * @pf: pointer to PF struct
>   *
> - * VSI has netdev and netdev has TX queues. This function is to
> check each of
> - * those TX queues if they are hung, trigger recovery by issuing
> SW interrupt.
> + * LAN VSI has netdev and netdev has TX queues. This function is
> to
> + check
> + * each of those TX queues if they are hung, trigger recovery by
> + issuing
> + * SW interrupt.
>   **/
> -void i40e_detect_recover_hung(struct i40e_vsi *vsi)
> +void i40e_detect_recover_hung(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
>  	struct i40e_ring *tx_ring =3D NULL;
>  	struct net_device *netdev;
>  	unsigned int i;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> index 2cdc7de6301c..7c26c9a2bf65 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> @@ -470,7 +470,7 @@ void i40e_free_rx_resources(struct i40e_ring
> *rx_ring);  int i40e_napi_poll(struct napi_struct *napi, int
> budget);  void i40e_force_wb(struct i40e_vsi *vsi, struct
> i40e_q_vector *q_vector);
>  u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw); -void
> i40e_detect_recover_hung(struct i40e_vsi *vsi);
> +void i40e_detect_recover_hung(struct i40e_pf *pf);
>  int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
> bool __i40e_chk_linearize(struct sk_buff *skb);  int
> i40e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame
> **frames,
> --
> 2.43.0


