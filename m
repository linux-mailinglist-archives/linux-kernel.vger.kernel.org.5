Return-Path: <linux-kernel+bounces-119881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F1788CE28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940421C65B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FA113D537;
	Tue, 26 Mar 2024 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC5QrxfW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3BFC0E;
	Tue, 26 Mar 2024 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484376; cv=fail; b=MwxS4VuHK2g25VqkFHFOg5jqThGYY2gpb44blxzji38o3hxGhCoKGtX7e8xFECaS42ZkXYABtKrphZNLVdgjjqRK1mk9esjSzl3nc3bklwGyF/uDFIehZTDEG+XukJQRy4ewrbNvxeA6uWUnJFpdl0jneSa8+gItbPrpUNipcco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484376; c=relaxed/simple;
	bh=OSJO8mJ++H6tAAW0o4WNiUzYlujhkMCkArgAKcRNEOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lf0NKUIb4VqjivPczs0Qrgqmn8GuXl7X8kRdfo4kmqMiJq6SkQ6OEs6QcnLMCbfCVsp7A9Oerm5mxU2J0oo/3R+Of3yruC1In1hZ4AMhbbhHMK4ioNJHR1q+nsLvoOZo1lv0CP8ZxpRELGiWUoMs0KaA0Wc3ExbXHIaeDpkRPCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC5QrxfW; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711484374; x=1743020374;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OSJO8mJ++H6tAAW0o4WNiUzYlujhkMCkArgAKcRNEOY=;
  b=XC5QrxfWOJ1pPmY/BYNA5Z6hKZBDKQy9f+Khs6Gshn9+uxRClQ55Rrfp
   poxOE9Q7NTrvPfQveM0pAr/rJ8zWcB9heqIf68XopgLd8Fa9Abt2/f3j6
   EbDIWqrgQ/04HW7OnpBZnekijxQYneAkGQ8j3JQ+Rdn+dHw81XytbMfS2
   hbeiDTVNS/V14+ui0oHd7O0MwT0SJ/XKkZrxfqR8qt0k0w1WEBem9Cy/1
   Bz8bqKfAkwVqppWxcbbYfcmy0eodNMRgvx6milxE4DH+GfsmKFRcuOKOm
   xMvy/IiIoyuiwU2RVN6BwXHgkBB1RsC55UopQv+iTKpRmtAD4e5qXia/E
   A==;
X-CSE-ConnectionGUID: 8LcsHKFrRBeuJMKzA77L7A==
X-CSE-MsgGUID: G2UDCkuwT5iF+DT8Mi2fQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="7157406"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="7157406"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:19:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="15986763"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 13:19:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 13:19:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 13:19:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 13:19:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REPhhLIetHinbpTCsOIF29wxTO7xBPkmNpWRcCZBbjUASzmF7y1EkE4BxEMjpWXYEtHB28t/ntEY3flsbppkuvQSzyX6014tvlsp3Rp9a+WOWWEMVDD53fiGz5KPFzuAYt4kuJ3ebOK2ekxDKiylCGjcDew90m0LWQHKUghN1P3YdLMh2x1TNFGGs2PIzyBrc2uA4Cqk8YLlTencvMT8qSLv1cEaHfIPq+jWOIggOZeVTxxvmQFSR53qXXjaK5E1RvseQpDUB2FWSbUWLmpryVKwIK6G/dqZcqxe6sF+kyi0yHuGnmB/DLCuf9w9xW7RxB6mcp1pD/pzvWPuNwbsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSsmjI3tuWGmqrM2rdpKli2REas7iOYWmD58J2SyaKk=;
 b=RAI5CJpj03F9RBD25LmMn8z+Ismn+8nmEdPz6S0guh/6hY5zLIAOI9mln4IXC/FUBeWjrTqTry2k+96VSoQ/i+mR9wfNHY4iQZYNamYrx1vFDLxt6piwZIOUVinUcM36tXZPwzR+y816xlttOmFbolBe6ExkokVsvBI9eFEA6ugIYKZECwJ7Lll1FefVRlENB4cAuMcNYrLhpF2DMmBk5t2UL0PHvayYaHoSirM6WFeG8+M7CrXOCaO1SuVT03ZI9JwKomld4GwdR4YktZ96Sp2qNECkiUBg9HjIY4nIL78WVCqAnUzApwTC6y1/N3qb1H5HU9xaSJmgp9bYfhK4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by SJ2PR11MB7475.namprd11.prod.outlook.com (2603:10b6:a03:4c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 20:19:17 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::aaf8:95c2:2724:9688%6]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 20:19:17 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: ivecera <ivecera@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 6/7] i40e: Add helper to access
 main VEB
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 6/7] i40e: Add helper to
 access main VEB
Thread-Index: AQHaeUEYt+84mLTn70qqCpbBCRaKQ7FKgywg
Date: Tue, 26 Mar 2024 20:19:17 +0000
Message-ID: <SJ0PR11MB586605D3E31B3E4DB29CA120E5352@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20240318143058.287014-1-ivecera@redhat.com>
 <20240318143058.287014-7-ivecera@redhat.com>
In-Reply-To: <20240318143058.287014-7-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|SJ2PR11MB7475:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8IUtHNJ6NuKilBSYRWznXOwihywCMRjGMwlUNYrT9cIwAJpsUZ/OKR/OLyydXRGih1vkENb3ZdRfjMh/SiGdicG2Unq1nIY0c9H2Ql5JFWyagQfIC9RzUcoOfpA+sfAE1j88wAP61qIHCVUcnkECCxRAv35LhwQjeF+rUBm9znqqvSpWY1aEZ7RRn7WO2onU5KpH4jDJ3/gnCwDeM/tLIyP1sOJHnZglXr2+AkoJ3yt7AvSiwrZdVzfbxXPf1k4hjk5SWnlWfYSdzymPzMN/SfrtufVwM8kMz+4iXFjFDe6cUpVYqWDqcZP2warbddbSG6ePacN6PggP6zNqknAo8tNNaljOP/OK9T99ggYfm+pfGZuoki0zNHW1l/+NMmCQn89vPliyfLHHuZCqqWlLXKkop5C5l4JoJd+J90HZsA2OtJ9QFy5cYZhr27GxlgA83lBR0iUNQstHImgfyf9xfReY3F6nuZenE4Z2/86iOtUbop8R6rTwTt+ErOsCZVZDsm1c6YGw1LIORiVFpJbQN4T+GcM6WLAmFk7gzgvMmFHOA8dpFWm8UaX04G9RJUNixCVftc97pmk88BABMyCylD9O2SkjGfVDYAZb1INWi0piEcu+t3bHhi6R01Lk54T2hEfJmjFB0cA6dzxiC8O7MfDl0EZd4XtdPxPXwHbc2Dg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?13NOUA/OE3fEj0/vRVyASoMBLgZkNqcdobWsDXHSVixA8xhzmVe6e6N6Yxw2?=
 =?us-ascii?Q?nOv9tgznRYuTbKZ0iFsUCQve0ZHtDXAziHdyjC011sl08iFa/BhcnlVqnR10?=
 =?us-ascii?Q?DW9P0CRl6CxdRX+9qOwAuVvEMtyvijP+nLUhHAVftFOPmM1zDILbNmIJR1Ru?=
 =?us-ascii?Q?noUxPZxJo+z1GFcYoOpnEAHQQmsc7JscTe/TVCP5/fv4D22w59/Lf62Ms1Pm?=
 =?us-ascii?Q?Vg7qWCy6eKdHmE0B11F08LQCnA2aAfqWddokJ7DTSdru2SYq67xbGyYBhwZj?=
 =?us-ascii?Q?gRszwiVBNIxtBvmLDXNYNxVYIxuB0/unofCLWbQVuBkQz2Qis7FX7KdtygK+?=
 =?us-ascii?Q?9wsvTlShzVlWWXbNCYWV0tk5+TZfWytEGeLN87U6jvyL0oAsIPtbMFRdKXNT?=
 =?us-ascii?Q?jVzpQbkHJ7dvMn6nM1YQG/GzE9m4PQr9jxKSgr7+lG/3dBuexVnLIbzr5Ou1?=
 =?us-ascii?Q?fAPwtCvsu7OD06mSPLdUja9yuwq5AMsbYIZlPIXhkkJllzpMxE4lnozpR53J?=
 =?us-ascii?Q?UzanGZQgffuxAxvHFgkRCApry1eR88bR1tMGkaeaJgkv7h+IlqNTGIKUbYOo?=
 =?us-ascii?Q?LcixtfsSm/Sr1GXqFnM6fcSmKJdyi0jSscPEgHA+4oJKAxV9tch2KO007bfg?=
 =?us-ascii?Q?7lawVhzT7R5zmxFgaMyd6Uplxo/Qz4QM5T+8kqhs60B9dv3mlgGlaJ4yP/l9?=
 =?us-ascii?Q?jXc9eU758jR9S9rJ/rRCZV9i2Hp7rb/WxEgsZ2iomWX6U6O8lPGSBX7DvoRc?=
 =?us-ascii?Q?jY+95Bj84LzGmm2+hUMz03mfBI7lDPqkh/tBHSDUC/JUvMRbykBKprm3jaqK?=
 =?us-ascii?Q?fE/ZOrXL8gMGXCmwMgTWS73vMn0Fx12WJJgF1oI5NoO26yiqn8P4EfmKF4vy?=
 =?us-ascii?Q?mrY9pVcdWj94aQHk4Thj7ElYpGaXpZnjibvkzUfl81pBp7CmDv1U4YW0bDl+?=
 =?us-ascii?Q?6ylOu0Qoe1fDyaoU3QHyEvB8RyLUhPuWWPkJgK1VSDNuUlwdndRyllV+l46y?=
 =?us-ascii?Q?eqtLHQLtl3HM1OqkAGeegeDc5UkXjNtqivYYJ6fbOKA/biPu1ZJvCHjEuaQv?=
 =?us-ascii?Q?rXM1FKAet/7liU8wdoX6+bf0/8xtNnB/pti6DVpFh69HH/1cju8pkv1pi2AZ?=
 =?us-ascii?Q?qMz/KDwwHw1R7acHkbrsLW9tFG936m1rAqjPscwn5cfnBFSpI6SZEdqzcduP?=
 =?us-ascii?Q?hp6L/n8OEzXekntGzNOzmtge0QLGBk5CVkCoDPr7F4Ko17Z4Odpq8cOs3zKr?=
 =?us-ascii?Q?KHMsEdvZCZN0GcZTwnGH8qK+bg4CU5XJaB9VI++QWJWQ4saAjPNE9unnErrf?=
 =?us-ascii?Q?JnOLDHu374SVySJ5GwEAItQBhWWRqHkOxXV91/tkPE7rUiI5M7+8ko2xHSxe?=
 =?us-ascii?Q?Ug5EAPtewdKBBNk8BLnrSUF1Rf2hTFVx/Ipch3ulWAmrkJNdX4W0q3wUI7lP?=
 =?us-ascii?Q?4SlwOPxpCp/bgwRQu7r48eYHURQ/dlzubkXtiLfdJFI6A2flM0aaZRPxjds6?=
 =?us-ascii?Q?tFOiTE78n0+60OdBvAWxWAGd/aMhSxRSGbJWdjfKQ/80mXc6mqdKxxPCZmC1?=
 =?us-ascii?Q?Ogwecm17JIoJnZlLe6qnyCkX3X+7OOpz/pav46kEoWYDnQxs34cJoolovZBE?=
 =?us-ascii?Q?Sw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c3d381-e599-4155-e71a-08dc4dd2033c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 20:19:17.2208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nxsCHDxWc5279gcVj6NBfVWiXX6W1P5XzqjT+p/df4UIh8RuNQV1KPanX/D3avorcqQbbZa9vOP80+AbRiR0PRlQ7X4xLV/IZYITBJnEac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7475
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
> Subject: [Intel-wired-lan] [PATCH iwl-next 6/7] i40e: Add helper to
> access main VEB
>=20
> Add a helper to access main VEB:
>=20
> i40e_pf_get_main_veb(pf) replaces 'pf->veb[pf->lan_veb]'
>=20
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        | 11 ++++++++
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  9 +++----
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 27 ++++++++++++---
> ----
>  3 files changed, 31 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> b/drivers/net/ethernet/intel/i40e/i40e.h
> index fb0b913692e1..2f135db416cf 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -1401,4 +1401,15 @@ i40e_pf_get_veb_by_seid(struct i40e_pf *pf,
> u16 seid)
>  	return NULL;
>  }
>=20
> +/**
> + * i40e_pf_get_main_veb - get pointer to main VEB
> + * @pf: pointer to a PF
> + *
> + * Return pointer to main VEB or NULL if it does not exist  **/
> static
> +inline struct i40e_veb *i40e_pf_get_main_veb(struct i40e_pf *pf) {
> +	return (pf->lan_veb !=3D I40E_NO_VEB) ? pf->veb[pf->lan_veb] :
> NULL; }
> +
>  #endif /* _I40E_H_ */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 5cd0d1b45f01..4e28785c9fb2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2425,14 +2425,11 @@ static void i40e_get_ethtool_stats(struct
> net_device *netdev,
>  	if (vsi->type !=3D I40E_VSI_MAIN || pf->hw.partition_id !=3D 1)
>  		goto check_data_pointer;
>=20
> -	veb_stats =3D ((pf->lan_veb !=3D I40E_NO_VEB) &&
> -		     (pf->lan_veb < I40E_MAX_VEB) &&
> -		     test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags));
> +	veb =3D i40e_pf_get_main_veb(pf);
> +	veb_stats =3D veb && test_bit(I40E_FLAG_VEB_STATS_ENA, pf-
> >flags);
>=20
> -	if (veb_stats) {
> -		veb =3D pf->veb[pf->lan_veb];
> +	if (veb_stats)
>  		i40e_update_veb_stats(veb);
> -	}
>=20
>  	/* If veb stats aren't enabled, pass NULL instead of the veb
> so that
>  	 * we initialize stats to zero and update the data pointer
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index d6dbd0fd79eb..2e1955064abb 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2480,7 +2480,7 @@ static int i40e_set_promiscuous(struct
> i40e_pf *pf, bool promisc)
>  	int aq_ret;
>=20
>  	if (vsi->type =3D=3D I40E_VSI_MAIN &&
> -	    pf->lan_veb !=3D I40E_NO_VEB &&
> +	    i40e_pf_get_main_veb(pf) &&
>  	    !test_bit(I40E_FLAG_MFP_ENA, pf->flags)) {
>  		/* set defport ON for Main VSI instead of true promisc
>  		 * this way we will get all unicast/multicast and VLAN
> @@ -9916,6 +9916,7 @@ static void i40e_veb_link_event(struct
> i40e_veb *veb, bool link_up)  static void i40e_link_event(struct
> i40e_pf *pf)  {
>  	struct i40e_vsi *vsi =3D i40e_pf_get_main_vsi(pf);
> +	struct i40e_veb *veb =3D i40e_pf_get_main_veb(pf);
>  	u8 new_link_speed, old_link_speed;
>  	bool new_link, old_link;
>  	int status;
> @@ -9955,8 +9956,8 @@ static void i40e_link_event(struct i40e_pf
> *pf)
>  	/* Notify the base of the switch tree connected to
>  	 * the link.  Floating VEBs are not notified.
>  	 */
> -	if (pf->lan_veb < I40E_MAX_VEB && pf->veb[pf->lan_veb])
> -		i40e_veb_link_event(pf->veb[pf->lan_veb], new_link);
> +	if (veb)
> +		i40e_veb_link_event(veb, new_link);
>  	else
>  		i40e_vsi_link_event(vsi, new_link);
>=20
> @@ -14892,7 +14893,8 @@ static void
> i40e_setup_pf_switch_element(struct i40e_pf *pf,
>  		/* Main VEB? */
>  		if (uplink_seid !=3D pf->mac_seid)
>  			break;
> -		if (pf->lan_veb >=3D I40E_MAX_VEB) {
> +		veb =3D i40e_pf_get_main_veb(pf);
> +		if (!veb) {
>  			int v;
>=20
>  			/* find existing or else empty VEB */ @@ -
> 14906,12 +14908,15 @@ static void
> i40e_setup_pf_switch_element(struct i40e_pf *pf,
>  				pf->lan_veb =3D v;
>  			}
>  		}
> -		if (pf->lan_veb >=3D I40E_MAX_VEB)
> +
> +		/* Try to get again main VEB as pf->lan_veb may have
> changed */
> +		veb =3D i40e_pf_get_main_veb(pf);
> +		if (!veb)
>  			break;
>=20
> -		pf->veb[pf->lan_veb]->seid =3D seid;
> -		pf->veb[pf->lan_veb]->uplink_seid =3D pf->mac_seid;
> -		pf->veb[pf->lan_veb]->pf =3D pf;
> +		veb->seid =3D seid;
> +		veb->uplink_seid =3D pf->mac_seid;
> +		veb->pf =3D pf;
>  		break;
>  	case I40E_SWITCH_ELEMENT_TYPE_VSI:
>  		if (num_reported !=3D 1)
> @@ -15056,13 +15061,15 @@ static int i40e_setup_pf_switch(struct
> i40e_pf *pf, bool reinit, bool lock_acqui
>  	/* first time setup */
>  	main_vsi =3D i40e_pf_get_main_vsi(pf);
>  	if (!main_vsi || reinit) {
> +		struct i40e_veb *veb;
>  		u16 uplink_seid;
>=20
>  		/* Set up the PF VSI associated with the PF's main VSI
>  		 * that is already in the HW switch
>  		 */
> -		if (pf->lan_veb < I40E_MAX_VEB && pf->veb[pf->lan_veb])
> -			uplink_seid =3D pf->veb[pf->lan_veb]->seid;
> +		veb =3D i40e_pf_get_main_veb(pf);
> +		if (veb)
> +			uplink_seid =3D veb->seid;
>  		else
>  			uplink_seid =3D pf->mac_seid;
>  		if (!main_vsi)
> --
> 2.43.0


