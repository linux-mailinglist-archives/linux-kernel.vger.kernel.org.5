Return-Path: <linux-kernel+bounces-119353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38AE88C78A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A4F1C2B50F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2887213D515;
	Tue, 26 Mar 2024 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqFOuk/y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F213C9B5;
	Tue, 26 Mar 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467501; cv=fail; b=LbW0EINmoOhJJGdxztegjZ4ZHg6LXvfCxkfPdYHY8yODT8vOyuDdpfkN+Z1EeBNO7WGiQpP66VegCM0j7djCHCam9irD1Ch4lT7NCGPHsoDcGa1KBWRD7KRCXA4NPhd2S/w1S7MXMfIqiaFX+sLk2b8GQp9gZX6rFsr/HpXl28Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467501; c=relaxed/simple;
	bh=SIqjbEibrVVq7AqJzVVlJCwDDq0ntr6rw7S3r+XvM+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X5O8CmFOIVn7rGTvPAYM0jNW+D2pFgDpkszzJtf5uH7hKltbiuijxpmDiN0QyAzi7PCy0njJBh4vaLDQWT8c7KoyDV/bs8gX4zvRmPtObSr2zlgzDgc41YdWk2GU2+53UxUzEUHAUL++NOB4jykygAT18UeecvI+EoL+ktSO/Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqFOuk/y; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711467499; x=1743003499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SIqjbEibrVVq7AqJzVVlJCwDDq0ntr6rw7S3r+XvM+o=;
  b=eqFOuk/ysWHwsNtPiHji+8HOMTAuTC1rG8HgwM+z4bMFgMNotK1Mtw+6
   8zWssgjaMngnBj+3jCAQbwHxl9DgBHL2KNPa8GGMEj6wiYqfmIXNBRjCe
   +FMrC1xCStTBXtFdcElTrFwUk6SgmeFZSY+T/DJnbZFLs4JjWAQoXAT7D
   2MWMqLM8qeIPmhu+2xGteBiDfyJKdNK4cIjK9cNdsu8QYc0psWCG8BD18
   tUQWoCHBYePE4BZh9LCXRnmTxWGGksn2thTQpu3x3L0No0VCPQAKGYe0V
   tZZXdaq6FZbHTitBMsE9p9HYE0Aw2tL8KZ5EcBUgUOn2UWbNjDv1gRuam
   A==;
X-CSE-ConnectionGUID: 1CLzUu3vTCKCOWbCki6k4Q==
X-CSE-MsgGUID: DOGu6++LS/eZD0lfANOSRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6642456"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6642456"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 08:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20698389"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 08:38:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 08:38:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 08:38:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 08:38:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 08:38:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbOl2+9/w9mRaxfzIOntg6Qu0rTcJi9Z1XGjrwY6gAH52RV2vxtcnAn9tTIweYsWt2TibG5YwqiISEZjghzRmWQ4YinHyVUqqBJYpZPROn/l097aWDxgtZJW98c/QpQJXKmxot2ISK4o2lfhGpNQCtY5XEv0Ixb8eja+aCR/aw1LuQfm0QohvW5D76nFje9WwSekSnWD5HErHq+u4/f/8IMmKj/8SZlowAVZOlVoEHNK2TIy683WXNg5tW6/JJGX2k9BNDINJZUMWZZbSkNFIsObJGjHG25vWyNZmX8PfGYshh/9XkStmGEJOPn4R8/SRsbG6FmQUUlCs80PdnH4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9+17YK++F12uCdwyNPwpnFW95lEljiM25Z4r2aMy64=;
 b=c5IgDP1ox7CkU+uvPz858wa9+Tp21DsA94mb4E4RG5vyTXdiL1P9counPaXkxX/YnCA2DtVahgGGCb+DHqdjVu5bJ5OZQ3x1wYubUki/oaAK13h8vDFMno1CNV7d938gJtMRJgzBpXTMOGWI+jJ5LIDGquHxPg1uHdytYzPNXbTzCNxAjj5bWlpy7xokDzezgTPnCL7uJA4JZLIm8r1C6XszCtnMXca8KWXWMr4rWvafEtKXLe5z/1+0nY5I0pqwKCBJ4uomfK4EP34h1I9p/qFEUkCGwyYCcGb+CkVdH7Ppdg8e0SSAiB1BMMMpcQWu+nkrrSp06dmZ7OLzavgyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by BY1PR11MB7982.namprd11.prod.outlook.com (2603:10b6:a03:530::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 15:38:15 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688%6]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 15:38:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: ivecera <ivecera@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 1/7] i40e: Remove flags field
 from i40e_veb
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 1/7] i40e: Remove flags field
 from i40e_veb
Thread-Index: AQHaeUD928WY4jyDa0CC6tJsTuW2g7FKNJXg
Date: Tue, 26 Mar 2024 15:38:14 +0000
Message-ID: <SJ0PR11MB58666E6D308913A475BC94F7E5352@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20240318143058.287014-1-ivecera@redhat.com>
 <20240318143058.287014-2-ivecera@redhat.com>
In-Reply-To: <20240318143058.287014-2-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|BY1PR11MB7982:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T414RrgmciVi5Ni8T9OvUpj3mtIR7UX6vCSrpdoUZGxCaZMIcWMeF596XpN77KF0PyiypUUbji+rCJ/k8ZdQNIU0zypPosCHx2giBrGnymMy55NU4DkcQDlzaghJ5MZ+OQkPEg3cJCbSGuO+54OlfUgaDPIqfvPKgC2LSIG+bkkT8fz8jvpUfNIA/8B0+croqKUqUlmGGKoVTNTklgpcqKlQMNUL2AyuxiLlXGOc+9xkTxV9haEdVdBBEtkx5sILSDf1ffeJnZjhNhJqxSakMneJo7GdZX+YXsqW96dXDrYxP6+graxcgKZzoiUVpAFp4VnKa6epE0QLidcG7Ad+DA5lmgLqj5baSn6aghWF+Jbdhl3eS7ZnIF3FA2N42DVbn0XvYPJIbEPMq5kiTeDB73VbztqOdYdN4KW86bgpwWUauDlCFBJWXFHEtPZ6eFAikWF3GStj89ts/pGWLylkl7dKpYOs+Taa81Kr+i5DqHav+fETAeKbuInDKMY/7kHTsLcJXWBtKS6ceC004MbmooRSSXx8nN+RwZqma0bfySs+npDXkrv5O23GTih53rdkziUL5uy6O/8WF5QY00IHYHhPMAJ0iRUbFQsBOjq4akHF/q9PAwUbI6y6T532LEnTuTarsQ2477ZhedY/+pOlKBdNTzn7EayfMmqqKiQJ7Vs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R4aOtDobZvq2JnYtpZSHQT/EpdLDxI3qWb+kpuhAj6yq9NbgPhDSUi/4thbS?=
 =?us-ascii?Q?3uJdunb5xw+OOJ+EbaJ3hCdZJvq8IF5LrB4qkr3dTiYo7x9XocADtyqzsiha?=
 =?us-ascii?Q?aObPrwQtgr2p+g+OfirJEDKRySwmZr1uud76Od290vSsfUMXSl8WP5O5A36h?=
 =?us-ascii?Q?OQPgvkAaD0yIFXP9XMp0KjFogVo1SsECqupkwrRMfoVlJQzoOfEa6+/6fFeg?=
 =?us-ascii?Q?m9oqgGHL/BuFTiZ1VEqwNLek0TVufaMNo9rqA7r3nykDLaQH16KggkXhvNOP?=
 =?us-ascii?Q?wO16YaQkfE95+XCcfjyi48EqCXMOf6KZyCQzPiBBm3bcnNx+63/DBfzticq9?=
 =?us-ascii?Q?rhmXJQyxyM10EEkUkUSXV74hjHXz722rd5ATo//aHU0SGfEHylCIks/Z9t6Y?=
 =?us-ascii?Q?lHIFG/2k6vRHGpmrouiVqFaeL7wYPTltSnyxS8Btp9CI8f70ir2fcvYImyRa?=
 =?us-ascii?Q?RMJfcJFogvOYa1RNVFk+cVUzTUh9t+hWu8etBkM5uYq3BXLTtUey1KPBq7ht?=
 =?us-ascii?Q?ICnsiBcso4PnyBJ3x2AMfaKPmPe0DumYEEScERADnLVYyEaDXlM5u5E3B4cb?=
 =?us-ascii?Q?QNg1p7nzZvbo8anoz2wlgBXqPeDMNCkucjEtm1ZY01F5uW62YfgUEiFp2gSk?=
 =?us-ascii?Q?TkJnGqbRfAa4seorPPWQe4xEJ++2aIfSCOd8mv9WcFyQtKDALf7CkjYSleXI?=
 =?us-ascii?Q?pqGsKzkJUI4B9vsppyhgx3jkMGa7TFRn7FvVx2O0msvNyQnuTiEroYaZ1gLb?=
 =?us-ascii?Q?7lfvnSFJivtR39LFllAq4C1N2KkOkMs74zAqromOiSqRDl5VuQv0srHxu6AE?=
 =?us-ascii?Q?zHCnYOL/+jnY3Rgp7WJBfUtElOMZk2XLrCbOr+2kcyIsSekwhoBdqXADJhX/?=
 =?us-ascii?Q?Aaa6mFnVPYgnBOHOvc8upaFUurfks/Vrh4mqhTo46YrlfV91vO42LbZYEhMy?=
 =?us-ascii?Q?dwb858k500IfeMQiAD+aNDwVzLLUJPNpPLBJ5cLFlr25c12wR3eQN5mtd/8L?=
 =?us-ascii?Q?WZYUJze9A3v+QsrhjMz81DdgZBMlnzxByNe6wuhN5M0lfVkV5e88LNj5fumZ?=
 =?us-ascii?Q?kjhjI9F64N378yOsDL8hZi7exiFuYfaFVJP95GXC4XfnP9+SwfD7ShpojyVS?=
 =?us-ascii?Q?EX1sKuI3uu3D6x/P9EXZgE12LvpOXcY7/yF4cKzPCp004C8l5w4CT0unQvPU?=
 =?us-ascii?Q?/oDtaQZrBqE7KrT1V65HmXiMbNqNTEvZfF3FObi+X1I5Mzzso/KRGcD0cdQr?=
 =?us-ascii?Q?kyu66ddsgsBVyqWbEeL5EwUxK1kYLKe+KbD4Ga9RKq3ek6T/90CX0Yqj/fdy?=
 =?us-ascii?Q?lqokMwU4BL8nilQNPv9M0JE9ZCDSSBxkQEslH4AWIBlcSYZ10SusckeLx+HX?=
 =?us-ascii?Q?Gaon+5UQCHUrjK5sPJdhEDOqE/a/jqGj3HN4h5pMyTzAiZ9f+sWKvmJl6fpa?=
 =?us-ascii?Q?4tZRd2C7oCPzNyYlVO1LyYdWc4a9Slv4MY2aXscuQFxjUTetRf9Y/awn92QB?=
 =?us-ascii?Q?rjHc35A6qow5CUFrvpcsavKUYxp1x+LZNDaO265InJ8AsMEcyCr4a2hs5MxI?=
 =?us-ascii?Q?N3YzOmRD+104dtP7xmdXaNa8x2qmEHkXEz+3Zyu/MHRuykcUAWoj31qJiWJ4?=
 =?us-ascii?Q?pQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4d8ac4-be96-49e1-432e-08dc4daac082
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 15:38:14.8945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LPvv0Z38bffE2zWxjBneN37WT9H1QrYzr7E9dIwWywYYgLcO4gX31dJQGrrg9IjdDQfoZHNxhRB1ObHyJDYtMf9bUjJVda5rzarNwbzxscA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7982
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
> Subject: [Intel-wired-lan] [PATCH iwl-next 1/7] i40e: Remove flags
> field from i40e_veb
>=20
> The field is initialized always to zero and it is never read.
> Remove it.
>=20
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

>  drivers/net/ethernet/intel/i40e/i40e.h         |  3 +--
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 13 +++++--------
>  3 files changed, 7 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index 2fbabcdb5bb5..5248e78f7849 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -788,7 +788,6 @@ struct i40e_veb {
>  	u16 stats_idx;		/* index of VEB parent */
>  	u8  enabled_tc;
>  	u16 bridge_mode;	/* Bridge Mode (VEB/VEPA) */
> -	u16 flags;
>  	u16 bw_limit;
>  	u8  bw_max_quanta;
>  	bool is_abs_credits;
> @@ -1213,7 +1212,7 @@ void i40e_vsi_stop_rings(struct i40e_vsi
> *vsi);  void i40e_vsi_stop_rings_no_wait(struct  i40e_vsi *vsi);
> int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi);  int
> i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count); -
> struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags, u16
> uplink_seid,
> +struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16
> uplink_seid,
>  				u16 downlink_seid, u8 enabled_tc);
>  void i40e_veb_release(struct i40e_veb *veb);
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index f9ba45f596c9..6147c5f128e8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -867,7 +867,7 @@ static ssize_t i40e_dbg_command_write(struct
> file *filp,
>  			goto command_write_done;
>  		}
>=20
> -		veb =3D i40e_veb_setup(pf, 0, uplink_seid, vsi_seid,
> enabled_tc);
> +		veb =3D i40e_veb_setup(pf, uplink_seid, vsi_seid,
> enabled_tc);
>  		if (veb)
>  			dev_info(&pf->pdev->dev, "added relay %d\n", veb-
> >seid);
>  		else
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 663b2237eb4e..2f1604ae78c7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -13138,7 +13138,7 @@ static int i40e_ndo_bridge_setlink(struct
> net_device *dev,
>=20
>  		/* Insert a new HW bridge */
>  		if (!veb) {
> -			veb =3D i40e_veb_setup(pf, 0, vsi->uplink_seid,
> vsi->seid,
> +			veb =3D i40e_veb_setup(pf, vsi->uplink_seid, vsi-
> >seid,
>  					     vsi->tc_config.enabled_tc);
>  			if (veb) {
>  				veb->bridge_mode =3D mode;
> @@ -14394,10 +14394,10 @@ struct i40e_vsi *i40e_vsi_setup(struct
> i40e_pf *pf, u8 type,
>  		}
>=20
>  		if (vsi->uplink_seid =3D=3D pf->mac_seid)
> -			veb =3D i40e_veb_setup(pf, 0, pf->mac_seid, vsi-
> >seid,
> +			veb =3D i40e_veb_setup(pf, pf->mac_seid, vsi->seid,
>  					     vsi->tc_config.enabled_tc);
>  		else if ((vsi->flags & I40E_VSI_FLAG_VEB_OWNER) =3D=3D 0)
> -			veb =3D i40e_veb_setup(pf, 0, vsi->uplink_seid,
> vsi->seid,
> +			veb =3D i40e_veb_setup(pf, vsi->uplink_seid, vsi-
> >seid,
>  					     vsi->tc_config.enabled_tc);
>  		if (veb) {
>  			if (vsi->seid !=3D pf->vsi[pf->lan_vsi]->seid) { @@
> -14791,7 +14791,6 @@ static int i40e_add_veb(struct i40e_veb *veb,
> struct i40e_vsi *vsi)
>  /**
>   * i40e_veb_setup - Set up a VEB
>   * @pf: board private structure
> - * @flags: VEB setup flags
>   * @uplink_seid: the switch element to link to
>   * @vsi_seid: the initial VSI seid
>   * @enabled_tc: Enabled TC bit-map
> @@ -14804,9 +14803,8 @@ static int i40e_add_veb(struct i40e_veb
> *veb, struct i40e_vsi *vsi)
>   * Returns pointer to the successfully allocated VEB sw struct on
>   * success, otherwise returns NULL on failure.
>   **/
> -struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
> -				u16 uplink_seid, u16 vsi_seid,
> -				u8 enabled_tc)
> +struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16
> uplink_seid,
> +				u16 vsi_seid, u8 enabled_tc)
>  {
>  	struct i40e_vsi *vsi =3D NULL;
>  	struct i40e_veb *veb;
> @@ -14837,7 +14835,6 @@ struct i40e_veb *i40e_veb_setup(struct
> i40e_pf *pf, u16 flags,
>  	if (veb_idx < 0)
>  		goto err_alloc;
>  	veb =3D pf->veb[veb_idx];
> -	veb->flags =3D flags;
>  	veb->uplink_seid =3D uplink_seid;
>  	veb->enabled_tc =3D (enabled_tc ? enabled_tc : 0x1);
>=20
> --
> 2.43.0


