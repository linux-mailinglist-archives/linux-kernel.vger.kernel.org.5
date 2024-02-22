Return-Path: <linux-kernel+bounces-76350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D8485F5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36D8B23361
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9D83D97D;
	Thu, 22 Feb 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3RAvoki"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A623F9F5;
	Thu, 22 Feb 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598754; cv=fail; b=YiprDa4UVKvps+dgSUSrKuQHJGA2QvMGnKI/j+2BjxyfxwUaItrbwVMhaTCl4C2nnuvhwQDiZVsq2/2z0OeFvvC6PFNyD4zzpmPkSFR0pp9Rvk9gTlllUE9KWxCYYOyPleWj0BJSfXt1lNfWrddoPia6Pma3gkLSU3d3bCwZxaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598754; c=relaxed/simple;
	bh=TG/377xVTkJwhrgDKWseFFbFiLwzVl3YHpEb53TPFQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t70o1J0qHDjh5b0/kShOuSdEkoOnp3TrXgW7mMUcsgirVZz3H9SzpbMQTj6BSZTXt24rRDYcAORnd3HT40hp0QSl3ks74K4FfpEdWlcugf8mw3RIggA3cDbwo9DaT9L3UK++qWhgBMGu8/waMFkgCltRKq5pI78lxN/jH/a6riI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3RAvoki; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708598751; x=1740134751;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TG/377xVTkJwhrgDKWseFFbFiLwzVl3YHpEb53TPFQk=;
  b=K3RAvokiQyZeck0U7jjx7qcuoUy+AfGOmtqOdggrM2I6AuACNgBOU61e
   YQqPhpLAtCcTvRaHhBdt4ik8je3ZvnOfzSQB1JmyaASlHXa49MFMsEJYA
   P/rGdKLbgmmzmICEZ1MxIggxFQ9gzaaAJoi8J/0wcAtzii2Eyt3wUD/S4
   QYf39udhMUyV/3sl2733XUFE8QfvauU/PKQvROyksXMwtL+9h4OJ8w5Fo
   suGYDvOfswkYgy7IgKpsWYZc0yIiYa6EGv4+oBmTwoZch4u97MU+5IcV8
   +vG9CB7FjH01M8Dd7mFoZw6w67kfQOpMIsdULVvcYmSQ0Kod3nTY74HAu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="14231783"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="14231783"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936832333"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="936832333"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 02:45:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 02:45:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 02:45:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 02:45:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NaXEIEUvfzVqxRS5LIZzHSCHOShlvdcNZe+UkFFOkSRpTkrdti+fQz2l2kjJ8YzwdIs/oVNhQ+yUJf6F7m+WG8PEr1Kh5vT54YXFSi4Y34XK9pD0tKAhXSVgqG4GZRZ6tbLgGDPPDJ9T0x9wWx2TnzKF6XytyulWNLsLkleCV+dqd868eCJPWTGyCDyzEMTJhYj5V7+ndleMyKbYLiCQB9NIdn+fm56OoxAJs75r9LnfpACpT957FoEUHxtVRKEXaI6PqML8KUwDn51vej6siBn6SjOFT8QFuScYDKqwfbfjMr5zoSnd5tqQT1SIUnoymLtbDnC+BLJb2/nbuOfykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtP89FP2VtAdKgj26HGo9VeKA/QIjS8XN6RH8DaECrM=;
 b=PfrtNP7sdDdo9Nm2bMF7UDn0IkZ4yPrvqjLROsh4nxPBU4d52DTDKZ1lwIzb8ytDRUuaNFZc6JgxsUat3T9l0jgKdcsxfmVqSgc4cOtOEDDkxlCL8hsvv99Fleag4E2K5Rs4VKrgAyWaoymvtBc3/yACva/KeveuAzkXTuVa8NuqHjDvapIhNjb5e9Uq2Tkj2l/uZVgzGD0D3dqM02fpF4Ypd6jrarwvl1ypX3sFCsQes8WifKvaS1Vkb6HKLlqptpxO2Z9P07s9ECXRay2ZVcSa/gfbvTdgvCPyldqU10ncyzjZDzbNkKt0qfRyobxRiVctmfSJJEmt3AJm/ukovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 10:45:42 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::d4ca:a743:64d:6324]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::d4ca:a743:64d:6324%4]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 10:45:42 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v1 1/1] igb: extend PTP timestamp
 adjustments to i211
Thread-Topic: [Intel-wired-lan] [PATCH net v1 1/1] igb: extend PTP timestamp
 adjustments to i211
Thread-Index: AQHaXnX7LHUJjwhdN0+PA/6ztTiNULEWO1Fg
Date: Thu, 22 Feb 2024 10:45:42 +0000
Message-ID: <CYYPR11MB8429AA8901034899AA2681B7BD562@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240213115410.415573-1-o.rempel@pengutronix.de>
In-Reply-To: <20240213115410.415573-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|PH0PR11MB5808:EE_
x-ms-office365-filtering-correlation-id: c4f0b9fd-910c-4b93-2e23-08dc33936aca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3vNbNe0blhDciuODPPD6ScMLW0HHLK7xHw+GXkusyJs/x7SVW3XSzKZxf1YRPTBzGCMy4Q06XNe7jZAi8Y5x39EnljRnXUfZwqHprmjlY12VuS7NMQiNKa4v2UqtDtH2zULDbtH0lXj3CzIU5sxJYEYlhmAFTx/7pRVvk2jVuIDzg1Y5HLC9aqWEdQerfpoewucW0vKdrhgAc0j7dzHQnxSrJvha8gI7f/uxOatAN7r+WHC/qnOXC/AMWWZL6Y9a7t0JIVmTtAvnq/yk3l9KdMW5l/0rXTbo0dw4sss6NKVuluZJrw+/3Lpas0eSbOZhft+J+ANWa8fgy1V/QKYxLNwW3MSAh8PRjckjE1uCII0EVFjSWZ0q60Yy5650yC3+g14ZH1rfCUz3THcBw7elezZ8sTo2RBnpERNAh/eOhv6I8MCyYsCI93WnI0flv8PLS076d8EBGBYgLCSuyKOoXzOgapUTeTP/JZ3qLtY892xH4+J+KVSe+QZO12hVE+5zN7sj4vlZT8gTEjIU4dxh3We38nv0p6SOs3bDt8wZAH5eDFaq5cn0mCcj8pvSRWEunK70ok47JWpadjvPJAVETAkFhFolU4c5r2CAOkBxQzdgVT/XHezKp8YX9gJxElVT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0sGGgnEENX0PKvfh3sVztLlkxOk3rdX5UpJpVr0cFsOI+mrwAav6l+97f0aB?=
 =?us-ascii?Q?djhpu6Y6ErkInNoSSeoydzVjYqEsw6TOJ1o4ozw9M2naDFr9nTMCxOPNi7C2?=
 =?us-ascii?Q?6afVo0Tmtfv0533yugs/3gPb7kKC/Y3UBsIWT2pdWbnEfLksJHUEXIlQHr1W?=
 =?us-ascii?Q?hMEZ1NzRdSBKWyD50QTqhby92YfgxrqG6LvakmqnxO2rnSXgLTUsd389miQO?=
 =?us-ascii?Q?FUunQb9YtMRb3S+Cjb7a52T6QFkxzSqp0H/r/UVe7ffuqfRj15K9e1sEE+cd?=
 =?us-ascii?Q?yntCvcvGPgtwEnfaE/O9UG7s5RnlywB+r2kU7G2lTXyijPKgVxMmS1D2pf7B?=
 =?us-ascii?Q?kHWGpBTsSOw1Ji8g13tEIflqYtzi8VducMIqqkaHBP6UbpvlcQYyhx48ps8k?=
 =?us-ascii?Q?mVqwaf77qamKegbT8xT7bWK5q0YY6J8/G3rvAuGmMVJI/XbUZMvPznSp2yl1?=
 =?us-ascii?Q?Htt5xD90D/PmujBclVeZW46U5TrNMEgd9EyR3Y74TyRFUXQsmf6V2DxrvrF2?=
 =?us-ascii?Q?ZRjKeOtILPQA0aUT83tjPmONbd8U3+fVoorEWJrN3eiy8JgArbR04PlK01Zh?=
 =?us-ascii?Q?bUC3jafrM1kFqAHf1rbNYZeni4mc8/OUW4n77DSkGEu+Uvok132bGfdpoK8b?=
 =?us-ascii?Q?OETsK9/bRwzHz8hlB5ac41MbBENuraZwD7i5gEaOjcyYxqu9nfNIPnY+44iw?=
 =?us-ascii?Q?/v3oiW/ZBMnDGYzQ2UFsJzPDvnxj3hhW0lEkGdOdpYBvtkCJSLP97TAQT3Kq?=
 =?us-ascii?Q?OadojG2ctVZrifwLj3kppz0SuLuyvovOkAEm4bQfyYVQfc5J8AX1YRe7ksP7?=
 =?us-ascii?Q?v/iw4EVNI1i3ExxmPgxdFBQ8AnTJJKScMdjyzH/d8TrHln6Xxz4WLXm16/Fk?=
 =?us-ascii?Q?n9qdtQX76w3uIRvUAoBhYjK+0Vn6l6TKMlOHZZnIFtYsh8+l+oGhBgo/49+0?=
 =?us-ascii?Q?0uyzi3Y0euY1zBhG8wfNV+vjb0F9ZBkFHsUN8RO0AyxlbH7Zk9ZXGpE/khnp?=
 =?us-ascii?Q?prcKaxb3lniuxpSwfjdLbwNwkAyuG2lbUz9Z/jwzKVgCWJ6rnfCseNUa+TGS?=
 =?us-ascii?Q?kXSnmqNpkgES+hJIen8XoYu5HK9NYMRHPoWJb9F8L3/Ortoz46JyJWXGrI/H?=
 =?us-ascii?Q?96oYhkrbR76Vyfl/aljfvz1YbMUMDta0XnPovW6HKq+Brva1qg3NyITTyQwA?=
 =?us-ascii?Q?OQZR36R7qRAjSPmt5TLlroQ8LtsUKvpxDfbm4pyD6yxlNBMttMQzD4rv6gP2?=
 =?us-ascii?Q?fFeTcBbFxQz7dXESRpWjwVHyWh2lMu5IMNZtB1xFixV1ckjvNHKUtE/WRbih?=
 =?us-ascii?Q?d1H3AMVSTq/qch1h+9cGM4/5/zlX1HV3TxH0V8cEQyoVc9DWCadVdFGtDdb/?=
 =?us-ascii?Q?J3SsuZTIJS3YWnmj6EiGYsJUA5dXmFX3hfnGFquWJrCkS6oOyYMuQWh18Shq?=
 =?us-ascii?Q?+OI5QEXBSaJzo8Cg9gUrFwbbvfGBm3jHehAMPFL5WkFVNZpZBuQZjLzZSOG0?=
 =?us-ascii?Q?mP+KyHi0iH9xawHOiYNZKpS+w+piLwQvmzjfg78lx4TnUPVTCxPWYYZwsLSD?=
 =?us-ascii?Q?LmgncpIeK4+DopZjIr65YPH9fnHLjvBFA78gj97op5IhSnbBA8uQeqB1Wdw8?=
 =?us-ascii?Q?AQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f0b9fd-910c-4b93-2e23-08dc33936aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 10:45:42.4538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gfsPGPo2bsJQ7xiFvJyWWnBK6YmfARwXf6vPz4MwKMjK99LE1OdGSGrbmlSJJo7zwefIdIy9a0uP+cqJsDmMTZn0oIzdI0Lr/PLJXtUHYIS3/LcNJMbHe4vsbAYCZt1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5808
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of O=
leksij Rempel
> Sent: Tuesday, February 13, 2024 5:24 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <an=
thony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Eric Duma=
zet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <p=
abeni@redhat.com>; Richard Cochran <richardcochran@gmail.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; intel-wired-lan@lists.osuos=
l.org; linux-kernel@vger.kernel.org; kernel@pengutronix.de; netdev@vger.ker=
nel.org
> Subject: [Intel-wired-lan] [PATCH net v1 1/1] igb: extend PTP timestamp a=
djustments to i211
>
> The i211 requires the same PTP timestamp adjustments as the i210,
> according to its datasheet. To ensure consistent timestamping across
> different platforms, this change extends the existing adjustments to
> include the i211.
>
> The adjustment result are tested and comparable for i210 and i211 based
> systems.
>
> Fixes: 3f544d2a4d5c ("igb: adjust PTP timestamps for Tx/Rx latency")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


