Return-Path: <linux-kernel+bounces-88880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AAF86E7E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528FE289147
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA82110F;
	Fri,  1 Mar 2024 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izN7NKW1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AF3443F;
	Fri,  1 Mar 2024 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316116; cv=fail; b=qFs+lPIaEjl9dsl0P0u6hPMaiI/Xnr7DnmNFt+mSRsyoKF3/edju35+kKdBWzdRllKohRpztxDyo2seRBDIlEYAiZsctciflClPG2nWUTHPJ9MVZzG0Dbn30tJMN1jVCUshPFdwPpdFtepijin7m4FyJBAnjPJkgXHLj7Kf51sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316116; c=relaxed/simple;
	bh=Ov4HrMAZ4KL7bkw+60WAldZK5XjD6qWH4d5fYj4pjH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VT88G3kSrKTe44I0uZ6z3NAo9Q1cT2pUSmjuv1YvywV599A7piWjSfhwSk+9I6RJvAxwdoDCW9kFFt/v0q0wDR8VPQx5qUnOo7rd7tXIogOPyckeCZqDl1eqX5ES9nBKLI10Tzl6llVDF7ggOiOhjxu84wa4uKg67cLEE5bGs7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izN7NKW1; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709316114; x=1740852114;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ov4HrMAZ4KL7bkw+60WAldZK5XjD6qWH4d5fYj4pjH8=;
  b=izN7NKW1huXh47K9KTX5wRmztU9qd+njOy87rDEeH+LHUILup4Wy0zKD
   PDx6XTtC2LdKbgcyc/3Sp+U0DPVOCuqQ1DybyPpsUwskHbH0DcE0ccftt
   92L4AVrGz1Bjlg+o5YAqkcOLOwCF86+jG1AjFxu3TwUNmo7tNAiXsxDzL
   QP5dY6BE+zo9wbC+cESmXeQuock2koSTy/+HqZ8qWe0FFAxJVVsYTH/LJ
   n/sgSaFWmRusfRJ4KABJElPAoLZD3B7X+pins0jGkXPeOuE3F/7857RG6
   v4D7DvlfuIN50jtAN+z8QCN7WzxpzuYDYeJbNheUg09TZh9ipy91RtXRh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15277779"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="15277779"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8319589"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 10:01:19 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 10:01:18 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 10:01:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 10:01:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 10:01:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUyOKq4eHGpOgfkVFlMDLmdAia7lENAbcNrkkwpOx7pStPuRMyNApDNlsBUCxubcNcIvLtDf9iilzl2+TXxImjtf8BCq1Z120a9QhrUQ3KVZmgjv1AtPMLZUjBBWUMVRZ0tqWnSi/ZIrvCyvmbOe/3xxI/JsxhmWUqRugRK82o0Z0jqbaV/lnvDXGrAuy7LgcVvQVCtpvC3ur9kk9zqGkeBycx33k7h3MB5dTN6c/pavQfGulZNLp5fEeLqqKocSSKcbDxkZ2tKNGe1xjKB8Qsg6tefiWN7pT1J7cMiS5iMPib4gdlgKkfPfI5jMR2nfYQW7AZE9jf6l2TuWsmRYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d56gaNpn+/t8cWMT+dnzb52A1UBehULo8n5U+zzMXzQ=;
 b=Kp6aBm8yEUqz/xZQns1IgtZi6lxRxbnBfXkXLbVyWQnZP9KlSZ/bf/DnSAycBo3dd8kkhqKs8lHi9M9PZJWVSmgcgO+8BPNU+KCELuDo6yxLZqH6xsG24urA/K5y5RQYSVKOk94U5PZDRXN7sS0YJJlfjAVTvRfxwfzCU62zjNJjBz/+3MfO97+A+jUehRaIhesaMoyY/bxEqY/TpE0NO7BI9zrqKEPI3TekvcoiRb3SQ9d9QtlZKgg28QpndxtMxrxBG/VIf3t7ZPTLbSE2uDl4z1bw/s2Bwho1dv4wz3DqknmCNrDVIVOot3I2BpAcFe3TIR+Sib2qXo8VHp/gdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by IA1PR11MB7823.namprd11.prod.outlook.com (2603:10b6:208:3f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.15; Fri, 1 Mar
 2024 18:01:14 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7362.015; Fri, 1 Mar 2024
 18:01:14 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Takeru Hayasaka <hayatake396@gmail.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"laforge@gnumonks.org" <laforge@gnumonks.org>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "mailhol.vincent@wanadoo.fr"
	<mailhol.vincent@wanadoo.fr>
Subject: RE: [Intel-wired-lan] [PATCH net-next v8 1/2] ethtool: Add GTP RSS
 hash options to ethtool.h
Thread-Topic: [Intel-wired-lan] [PATCH net-next v8 1/2] ethtool: Add GTP RSS
 hash options to ethtool.h
Thread-Index: AQHaXVfYPrQaFDDbUU2tyu9IZKEtzLEjR9cw
Date: Fri, 1 Mar 2024 18:01:14 +0000
Message-ID: <CYYPR11MB8429FCD568EE2AF90AEE2CABBD5E2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240212020403.1639030-1-hayatake396@gmail.com>
In-Reply-To: <20240212020403.1639030-1-hayatake396@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|IA1PR11MB7823:EE_
x-ms-office365-filtering-correlation-id: f3533fb3-782b-44fa-0b0b-08dc3a199602
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mua4hewVYRLs5afyqki1HOut3v/7ad+cvIatgmFxJDldQJ+GFjeymrlsSAqltEUd+84f5BMrKz9KhxpfjBRWrRWExbr4pifL8WKTAFWC4IILc2XakCk6bPq9oU9AmcJLBiiVnP3j79ZzXyasxBLweyyygrJ7nj6kgNz3PTXh1Ve7r6T6O38Sw5T9TxJZ1LdRkB8+mFyLosZcGSyLKSPDUdvSlZf9nhP8kB7OWYqni2npSn3i5Of5hCmYGh0Xb7kTJJHv3A5pdAmHXjn5KW/7AUttI4vBXFAuWn0jZ8HSorbT/j8k9EV2a9/hX3TrNhH3dUiW7yh/3vKnE/0TNRJBoOcvj0IiJWnFq4JM7GsqmJvSJ2IijXbPtT14gPdFooprEIrHGEOQCI91QwgqlN0PasR36G8imUVupCiOkRIHUVeha7fhEmr6yrZj+YmbD/q0t4Ch/lgLwQUQIBL9nrX+NUliZS1v90P2TUNCJc93n6or1+CpjoQ0F7Yv30xLXfvWFzLl6X6R+oNsRQugImXCBDZN+Dx1QzoRycgBVpXjrcPc6iUXvv2Cw+P68e+dLfoV6Mdnly/M9Sd2aCE0mQxBfDmk+SCBQJirxqml3itRvTsjfVNw84pb+DlWxhkwuk59B99DgVQoKjBy96J+Eimj9m5oPLmeyCvD1gKFobrYt/lCbuqPU9GgtHMkPCLdMB/dtdT/+ORVG3CCH9zaqvdlFRK1TpN/7TDxel8sd9Dk2UY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZRwN+TGb1PaHBaXB00oE3vf+FkXKYWmhxBEcwTBQNvQx9t/fCJzzOLJ3Ulfq?=
 =?us-ascii?Q?lE7MhieSfUoT+UgxQLkRtBSo1iycL0drxcT3nwHuUaiJ2iLFB31j6pmSKz/U?=
 =?us-ascii?Q?E8TLaekPZMkmQh4mM3I6i0xiGLmH1O00C+WAC5GLYKXaXYf0qHOQQ8v9QyRA?=
 =?us-ascii?Q?mOxY6ro0zX/fLdrZc56c6N3YZULly5Xg4WfxF4oi79fXyXsTgzhhqIe0MMVO?=
 =?us-ascii?Q?YRj+3xLZmZgTVxwuUAfMh2cEQ+PRUi3Q3Qugwq1Puv9CLxONZUQIXxho1+Ku?=
 =?us-ascii?Q?JEQGeIlGYU1sezp5un08iLJmNGRwFAvpjZr+rXprfjmEUzFnmlt61FjSUpsj?=
 =?us-ascii?Q?OhY6FwFo6eVlL65XjtHdngjPwofpUDhIG6wMMVqWMYqr3bJ6jEUP78jE4X0S?=
 =?us-ascii?Q?rD5yd4cEFahs2bcUgQpuEsn/CWAj0P8FFy/1JnnDzadwTNM6JfBRSemPFVJH?=
 =?us-ascii?Q?6jMcCjY/ZzRdrlYFPExd2SrEwn1MxXOh6JjPgcSfOH5bG9bQ2FOj80LjrrlC?=
 =?us-ascii?Q?aj9/XoykHl1o9MP7BL1wvtOwPoetZwZzgU52f4tr5TWetUGdauSwhouL5e/n?=
 =?us-ascii?Q?KWnfUAZ9q2WEFOfhqEVowuRVSQ0uODA3zsiOGl+Lr+sQYw+m0EvLqPs/X8As?=
 =?us-ascii?Q?AL7VqngPPUU1nTikEf3dEXe8KMd1BbcATAOIGh+bYb/1Mj/855xYtHAH5ciJ?=
 =?us-ascii?Q?gOFFqkKPcC6Q4psqLe3RPD9eXIL++tWfN7Wp5lIchOyts2EQCYoexwomA8kh?=
 =?us-ascii?Q?1qGUJ5ceCEvZ4l8ndGePalaZz9E9n1gCsdKd5aPmT+XMIY3dll9ZzxOTeTDf?=
 =?us-ascii?Q?RUCJF876tOoSixdQuBExNWx5ByCDTpJlL6sig3i2iutbBSQtTWIJtPXIsj9X?=
 =?us-ascii?Q?eAc6s0IX/2PSpp3QppZ2M2J5zbOUGQbze+D0ZODMkf89w/glXfBVQkZbUYU1?=
 =?us-ascii?Q?vLAvecPQi3/3mbn1SVDGWIgnx6gfaQueoNCj0sPF0vPBNptkwNGweevu67OA?=
 =?us-ascii?Q?xcS38DAXkJ+Yic1L+/0xht75OY9kub2e6h85WRe3wEtNRV2KLZG1E69sc7NR?=
 =?us-ascii?Q?IEFpkM/OGt3XKfraKwP9InfYBNvKYTZ6UUVV5e9DAXzJEzlFuirTBu4l2cJc?=
 =?us-ascii?Q?JI9Ng8x6MC9tUNPBZQjZ3pM5X6zRLA4mpxBcYQo77WZl57GqRQ5TmBqdkWcf?=
 =?us-ascii?Q?fF+K0Eppxdv1qZkB95KvvdHZcGKSTg7ZozbAqMyMRacwgoZoOPHIHx5TksK+?=
 =?us-ascii?Q?VEl91YeW+tGPJ8axC9/TIqzPn+lleV2d1dWtcSyGq531+IozprurDgizKcR7?=
 =?us-ascii?Q?7eWMnWlz/Ar268YwaMglFlA3isu6y3ZHLW5IbmQrsFH38Kg99YOfb6uwM628?=
 =?us-ascii?Q?scNXKxcOu7N+Gi84TiCZy6ZICSWUkn2b+n+VWWf89vSsfzbbD+uxC0iFje01?=
 =?us-ascii?Q?T90LkfEWn/OdIr0VlvRV1iTaHjDlQ8kTcLaAqXl5QLIG0384765n9KAP6A+2?=
 =?us-ascii?Q?JOsOgL1D38m4z6chEjnHWKuOLQu0LpnnrTZesbOpaGttDVNtl8pApIpyB+JP?=
 =?us-ascii?Q?+Uj05iMopCjaVXN8mWDIqMMDkSKqlGX8HMsQUQ5hG6YrlfuxE6U8MPb8VFvc?=
 =?us-ascii?Q?KQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3533fb3-782b-44fa-0b0b-08dc3a199602
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 18:01:14.4737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qXoezBoizyVrzQCkFSTUg2QRPkeIpvBZvFBZHoub3rPiesgf6JamK73c0kPD6eTl+iwlsNsJ68ypttBadeNc2+S5g1VS7H8JEB7nMeJ8pNmnqbzBfuDR20KE/AuCdll
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7823
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of T=
akeru Hayasaka
> Sent: Monday, February 12, 2024 7:34 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <an=
thony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Eric Duma=
zet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <p=
abeni@redhat.com>; Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org; vladimir.oltean@nxp.com; linux-kernel@vger=
kernel.org; laforge@gnumonks.org; Marcin Szycik <marcin.szycik@linux.intel=
com>; intel-wired-lan@lists.osuosl.org; Takeru Hayasaka <hayatake396@gmail=
com>; netdev@vger.kernel.org; mailhol.vincent@wanadoo.fr
> Subject: [Intel-wired-lan] [PATCH net-next v8 1/2] ethtool: Add GTP RSS h=
ash options to ethtool.h
>
> This is a patch that enables RSS functionality for GTP packets using etht=
ool.
>
>A user can include TEID and make RSS work for GTP-U over IPv4 by doing the
>following:`ethtool -N ens3 rx-flow-hash gtpu4 sde`
>
> In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,
> gtpu(4|6)u, and gtpu(4|6)d.
>
> gtpc(4|6): Used for GTP-C in IPv4 and IPv6, where the GTP header format d=
oes
> not include a TEID.
> gtpc(4|6)t: Used for GTP-C in IPv4 and IPv6, with a GTP header format tha=
t
> includes a TEID.
> gtpu(4|6): Used for GTP-U in both IPv4 and IPv6 scenarios.
> gtpu(4|6)e: Used for GTP-U with extended headers in both IPv4 and IPv6.
> gtpu(4|6)u: Used when the PSC (PDU session container) in the GTP-U extend=
ed
> header includes Uplink, applicable to both IPv4 and IPv6.
> gtpu(4|6)d: Used when the PSC in the GTP-U extended header includes Downl=
ink,
> for both IPv4 and IPv6.
>
> GTP generates a flow that includes an ID called TEID to identify the tunn=
el.
> This tunnel is created for each UE (User Equipment).By performing RSS bas=
ed on
> this flow, it is possible to apply RSS for each communication unit from t=
he UE.
> Without this, RSS would only be effective within the range of IP addresse=
s. For
> instance, the PGW can only perform RSS within the IP range of the SGW.
> Problematic from a load distribution perspective, especially if there's a=
 bias
> in the terminals connected to a particular base station.This case can be
> solved by using this patch.
>
> Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> v2->v3: Based on Harald-san's review, I added documentation and comments =
to
> ethtool.h and ice.rst.
> v3->v4: Based on Marcin-san's review, I added the missing code for GTPC a=
nd
> GTPC_TEID, and revised the documentation and comments.
> v4->v5: Based on Marcin-san's review, I fixed rename and wrong code regar=
ding
> GTPC
> v5->v6: Based on Marcin-san's review, Undoing the addition of unnecessary
> blank lines.Minor fixes.
> v6->v7 Based on Jakub-san's review, Split the patch.
> v7->v8: There are no code changes. I've resent the patch, including Marci=
n-san's
> patch, because PatchWork did not interpret the patch correctly.Simon-san =
told
> me. Thanks.
 > include/uapi/linux/ethtool.h | 48 ++++++++++++++++++++++++++++++++++++
 > 1 file changed, 48 insertions(+)
>

Hi Takeru Hayasaka,

Functionality wise its working fine. But the ethtool part (tab complete doe=
sn't show GTP)=20

Please find below logs.

[root@os-delivery ~]# ethtool -N eth4 rx-flow-hash
ah4    ah6    esp4   esp6   ether  sctp4  sctp6  tcp4   tcp6   udp4   udp6
[root@os-delivery ~]# ethtool -N eth4 rx-flow-hash
ah4    ah6    esp4   esp6   ether  sctp4  sctp6  tcp4   tcp6   udp4   udp6
[root@os-delivery ~]# ethtool -N eth4 rx-flow-hash gtpu6e sdfn
[root@os-delivery ~]# ethtool -N eth4 rx-flow-hash gtpu6u sdfn
[root@os-delivery ~]# ethtool -N eth4 rx-flow-hash gtpu4u sdfn
[root@os-delivery ~]# ethtool -N eth4 rx-flow-hash gtpu4d sdfn
[root@os-delivery ~]# ethtool -N eth4 rx-flow-hash gtpu6d sdfn



