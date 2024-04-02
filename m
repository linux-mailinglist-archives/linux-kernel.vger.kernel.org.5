Return-Path: <linux-kernel+bounces-127369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292DA894A69
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0CCB24778
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D87E17BBA;
	Tue,  2 Apr 2024 04:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H5b85Jr3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62071426F;
	Tue,  2 Apr 2024 04:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031833; cv=fail; b=JnmFE9p5hgFuTdTkqUbdyp1Xpy72HC5rftllKpgsQdrS07JVvS0bdwTwIu+jeJY/yUh1OC5uZ/3CTGmbDGO+5ZjFjZ29Assj7x0PoYl+7ql8VRaYzKvNDMnushvGhuAaUg8vKzY8j//10ySptyYCFvLb/wmRh+ZOQ9AF2hhLL1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031833; c=relaxed/simple;
	bh=/54bojvBZrBqDfk2Rb/p4UDKmzlwhg63T10IPGB84bM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PLQeZt4oyrClwkmZdNEuc0k6tJ91NSSfg81bFBjtXupkcto8HMQwLBAIzlsjBPFsrB8JnlvoC015+8JLamcv045C2WXIGEIsLtBOgNMcmuMh4u+FmaYPyaZVslrPsh57O+vIbTllINT6bIaMYny0zX1dPEBqwsmhp+ZNilKF5Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H5b85Jr3; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712031832; x=1743567832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/54bojvBZrBqDfk2Rb/p4UDKmzlwhg63T10IPGB84bM=;
  b=H5b85Jr3Trzzq3l5FvVwRK5yu7rmbCKuYOnmwuHvb16qObgoIb1KYYaA
   gH8oaK+3J0NKBvbwwhLxRMcxmMk2jeXfuCo9AlelBa91GdKzhleg9vpXM
   RIzrahH/xbDIBKHV14q0er7mfaMxTBnHa5PpDP+biHh0EkpKHh4l/jcYM
   6TJYrDHBJggpmRH2zNY8qb/nvfbXZmERX7NMK3Kivy9mjDoTZHEHHrs/J
   S+C9RVyZounJ1f+AYob6SZal8fP4jqHZGraUqGh/MRthYM47Rd7/jj5SS
   spvzyUX6O8ONBD4dNb7f84Jqpr6J+G1uew7OIgVlP2T1zOriMm24zWo6o
   g==;
X-CSE-ConnectionGUID: nWtG55HCQHCd8JQgCVideg==
X-CSE-MsgGUID: 3dlMHFPmSVm9T/u/hqHNfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7369038"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7369038"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 21:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="22595216"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 21:23:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 21:23:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 21:23:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 21:23:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 21:23:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLRDFQ2tEFa1QdGeil5vWGdJdZfvB5vRkFr2FU1z9rkG8L1vwjhzlP1apNGnaq34aF25W45hI/Y5CubzRNbKv6YL2NXacjZUOxU73FPqH7+LOzn9n5F8WPQjlxbgIkdzIZK2fmymTqFvu19WSEGuKqCj8yOuE70h4t/FeDZsvbsxdq+rBMMVxsBaJjRaWF4lAxm+eFmenh54zzq2jU5bi9dOvGUEe7Hmor/UX+fwTrCeGbw4oAT9Vugdqve+rrtGIUVP0SoP8vHV1ri3Nz8Q8ICiqfx1Scbh4ya4sIOcJI1wzn/n6eZVIFDxQZOj27wl4mY8iN2/J/Xnfpq2j1eZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5OldAeX5cn0E5UqiRjNc5nRZ9ydczCwy8akbI24LxY=;
 b=CXaed6KruEbIlN9odsOk4muS3uYEoKPd9NI1uCJlnT9Sco2Rrp0LU0pXJRnKnZxUAr6hTng0x8dz0G7nq2RPjb6+vQtNwYzlrGq7He5CRSEFKZoL/Oa3OWDeeSINvfjUXzS3mgJSTpkJ3vD+xdrZf6UhPf7vjv7IYxnz4sTiQ6WaYuDFn3lb7WGEHW1/QMlBSii/FK77JxafSOfe+lqd9p1/7ENgucIaYxyszo9MvrwAiOZ/dwKyXPLa/rXdU7+mDSGNKXVv9BHcjGSFWQHk9+pjG4xR4HPV8PzXwuOQ05042z3fsxDWXcZzRMVk/fOBgRQs9HfiB115Uri7CX1OCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB8419.namprd11.prod.outlook.com (2603:10b6:208:48b::22)
 by PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 04:23:42 +0000
Received: from IA0PR11MB8419.namprd11.prod.outlook.com
 ([fe80::f1cb:2c2f:e082:c0d]) by IA0PR11MB8419.namprd11.prod.outlook.com
 ([fe80::f1cb:2c2f:e082:c0d%4]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 04:23:42 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: ivecera <ivecera@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, "edumazet@google.com"
	<edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 4/7] i40e: Add helper to
 access main VSI
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 4/7] i40e: Add helper to
 access main VSI
Thread-Index: AQHagBy7tyTWoKp9wESRnDcwE1a3JLFUaoNQ
Date: Tue, 2 Apr 2024 04:23:42 +0000
Message-ID: <IA0PR11MB8419AD852982EB278FBC9FF5BD3E2@IA0PR11MB8419.namprd11.prod.outlook.com>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-5-ivecera@redhat.com>
In-Reply-To: <20240327075733.8967-5-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB8419:EE_|PH7PR11MB8455:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5U34VJLRtRxZWxG6317T8CU/qQwh3TDQgYyQkvFZDmtRfO8HpHzUwIxRzB+y1Tzoq/SwhicVxMGlqTdOV+t5fjol02VV4vS4a1oflC74nYM0cvlANdDUvTOr6Ew2u15rpcjMzAyTYopdj8x+VRYIOwgw1Zuy1sSDXEVco5fCJSrJtpxldeGcVBUdwjUHR7YGxhVbsPys5+zYna2ePEpXEHvAh7MpSWlKcEY8c7A16XAkpguH4jsEqmy3snyVbYymsS8h6RBs9naqbSo1DjTd4z8xdh8oLfEYqWwvavxNVumZtEamsLTrh3DJZRrF2jNKJxjJNBUn312F/iWhcHY9WwISE9VXXUR2vHhKUGtroISYg5xfiTvaJflSUX4uQ5lFSEpTEjzydsUNthvB68/cou099EsW3TkZVet+mJfIBYic8EIa+YAEAp9PAauxbRbFbVfQ6kKeapB09xmbzUeiO4MDtMdxJT+fL+MG5LPJ2kg56OjtgTHfbgjBwSqEbacex+4KnwyoqiJwnE/rUDO3B+piYS/+nj2A/mkBhbzUPwJsbZD07R72vv+qXh2H6CazcDT/MxUwQ8sdC/r7XoT73ldM9VUqmi6quB5bs+bPNJ2vdR9j/DNXT38ZDQPOMCYShgOfmVoBF/B/+4AERhf52jX+qqTzoB1B7hxAdtWhNmE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mxsqkUj2X6vRjY6nAxEAfrjpXXEgvwaJIraMVlQAgCdkwm+S2GPbngZbGATz?=
 =?us-ascii?Q?wLrXe1PwCQZheuUagO01wzbqAez4GpOrzlqnbMG+vXoJJWRWyIZzo4qhSQ8b?=
 =?us-ascii?Q?JNN+1Md5GepfPiGg2xq9kSHvdJA7Lm3wKsfJ7PoG5PiPTYBuNlQy6nvBTQ3e?=
 =?us-ascii?Q?r8fo+lSsT70JQPr24GayPgbV231cLiOiZFw+dnI0c8+IRg5FfsWaAoahaph9?=
 =?us-ascii?Q?9nsRpiRwRLPUT7Hev4uQZ7XacthINg+L3TuYB31Je2oKaMNHZuLKfoc4A4mq?=
 =?us-ascii?Q?HuZlLV3PCJMfBKae1MgxYfclXeChecKlSCfWJaR8VdC3JT2IaK85T3UO2IMl?=
 =?us-ascii?Q?jqngEffjbSUz52Edb4XqbtDCe84ACuiWzoIeYR5XgBRScKEfNBiFkEDyDQc+?=
 =?us-ascii?Q?/sKd0L3VbsTWhq+KHr+6NFm/ldx+bYMw44PQJRQgC3kikwtzl+50cASdExqf?=
 =?us-ascii?Q?cSBGhVi5mwgpgA1kWjvGk1P6UAoKftGRpQzs52T/WzvmsNsCZz1qdaRm2bDK?=
 =?us-ascii?Q?6EMIRzsto4x9b1h0kpr7HaNHuOKXwhRiYYz8B10ig0kIAuKDfs6UsoNaMBVW?=
 =?us-ascii?Q?qehe1hOs75EGR2VO59csuMKzj8WttphM9NAigEHAAU8RxuIsZuECymrjBh/X?=
 =?us-ascii?Q?G7rdW+vovmGx5skY22MwhC9cS3Tsy3E73w4fAlGYx2SIuWkLwc1l6JnT13ne?=
 =?us-ascii?Q?Dl2WbEZkSsQEVjExOYRBt6XnRjMw2UujzWhx+/OibsPDS7a55fAas3kp5I2Y?=
 =?us-ascii?Q?Idy0R9KyrIJtEiHAuU2HzsdADSjbcDgLJYkgG4XMHANQNcnMnYc92yEm5z2E?=
 =?us-ascii?Q?RFzAHOyumzwcJ5C1QH3kuejuWwUVgfU5e0dJbVGhncWInRs9ca75DnAxwUn1?=
 =?us-ascii?Q?qmFK4FjWOiCRKO1deckCAOo5b8BPTw7JRm17jaEJIa5rn7xNdgRwKx0QM+Q5?=
 =?us-ascii?Q?gqya5HlMsXwhaQvZg700Uy9L8gWY6SBL5QF4O7weCsyM8eJKL+FmKXUAgRK4?=
 =?us-ascii?Q?Gjp3+9xSske44Yjp1YHLxpD0U41ROvxyfsc3TdNSHIKmluOWIhumsgursdE1?=
 =?us-ascii?Q?JtHXMA+tpjJ55Nr0L6GZOSxv9fpWwg1T9EFSYff1a1pAn7kuF3gddwjY0XLU?=
 =?us-ascii?Q?PsQnErJzWYDbbvtDKt6nAVoXgQxmgDQgncIwALzEyNM17AoowcT7xEsKW5dM?=
 =?us-ascii?Q?oTled2moqE0BNhSjZdrIu61RsxAUROkuBYs90HK/GaBZwfR/cdaIquP2dO92?=
 =?us-ascii?Q?XIyJk8BSKamSSD/5R5tApWrkAFVhA7A23qrGl2vwTKejaQAAgjEXDzP1Ncr5?=
 =?us-ascii?Q?bbGSLKRFr3GL3Frd75Gh3Orjy4kSRJRqn57xtU2mGTKBQA+xyBgzsRUUASIv?=
 =?us-ascii?Q?h9UyYSIYNnlzYvZ8GHFKP3gCLwrXS6haJaLtk3UlksyGOnWZTw3d2BbQQQpM?=
 =?us-ascii?Q?IqJOhyte7CR7DjlffmreRYKwpYH+5NH2mHe9m7EIKnCkmONG0K9+55XiBWEX?=
 =?us-ascii?Q?/lp7H+hdGEQbVgOdDFi1eDqWkEQToRBFY8cp+Qw+jx1Q5tnj+cPiPBJYt30/?=
 =?us-ascii?Q?U6nrDGONV2+oJrPEZ+tIAAZ568z2m4ZWIlgjDrVeo6uy6VoJZ7p3tCKurAIn?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8419.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8b0b6a-ff9b-4202-d30c-08dc52ccadda
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 04:23:42.3334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pt3wOesdvcAxGPfmTtko0tnhXcoSBvABX/IkQnh+3sv1wxNLc4Gi+HC2bRJjk7A4Behs4i3RcAkIN0FqeZZakiEJjwMOrY9V3+ypTYuc1RZ9uX6CVCc/lw+Uv3Z8iWsw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8455
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, March 27, 2024 1:28 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Loktionov, Alek=
sandr <aleksandr.loktionov@intel.com>; edumazet@google.com; Nguyen, Anthony=
 L <anthony.l.nguyen@intel.com>; kuba@kernel.org; pabeni@redhat.com; davem@=
davemloft.net
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 4/7] i40e: Add helper to ac=
cess main VSI
>
> Add simple helper i40e_pf_get_main_vsi(pf) to access main VSI that replac=
es pattern 'pf->vsi[pf->lan_vsi]'
>
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  11 ++
>  drivers/net/ethernet/intel/i40e/i40e_client.c |  10 +-
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   3 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |  32 +++---
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |   8 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 107 ++++++++++--------
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   6 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   8 +-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  14 ++-
>  9 files changed, 116 insertions(+), 83 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


