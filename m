Return-Path: <linux-kernel+bounces-854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87655814711
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EA81F23B33
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616B3250E6;
	Fri, 15 Dec 2023 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiV03VCH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ABD24B52;
	Fri, 15 Dec 2023 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702640206; x=1734176206;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7EMotZN40ruX8d1xHpM5f/nkj/BXz2BaMzGLCXdzZiA=;
  b=SiV03VCHDcbozxNyz3lKANAUQfiV1a/86kAb5Ux5SbE74gsXl99xsl/B
   3+I2RKkYOTpDAuhWTyih5bQWOFJ75MM8J0Hod0+EoPah73wVZX6VrW+G9
   RyXO/PqclylUdHmC0VXMcon8QlFxo9q6f8fTANFkv5zI/BFTSRZvInapx
   4pxE3bo9JhWD2SReAcP+hL3YERz2SyoDS88l1b5uR0U6dFe9AHaItqOwQ
   VAhczu94ynGWD1jmTbKf0pxCRZ/oq+AzzzmMoWWohb4eA8SuYdBy8IYzW
   eIaa347890RcXen8I7aQZ6/Zr2m/RMR6bd3AMDyiSMyIY1r/iA/+K7DKA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="385683078"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="385683078"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 03:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="845095380"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="845095380"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 03:36:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 03:36:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 03:36:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 03:36:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axw4Ts83eU8bwcLcfGZP3X1a9wawktyp+R5mk2iOwvu6tg9vIqvYu1LQZqoFVQmHLL/JIsmTFoXrElSB3DW1ahxDFE8zE/8qbDo/h2CKQym9z55Fxl2z0VMO9FiptYXkbMYJ9pDXLEZcuBndmurg4w7/+XKVRdIJpH5TKcZcfTfhFuoJCPPxR29LTVRtqoe244WttZdErmA0oDk7kPkeZUOMmeoo0FR1z9wgdEd/FSJjCjbhD5s/M7RFoGj1sBfiZKkVA3ZSnmH+pbVqPFEOxgJX1fVjjfQc+RfqkiP3L/PgZ0f5Y9q56uyJHLRjukbr6UziQjuo6At/vo3bCV1A4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFmpappPuZ1418ybzB2pGK7lZ0JDNPqIiD5l5h9eK2M=;
 b=iUCL0jFAodUHUsNfey0812CxuCt6Cza169DGM6aKJhnrgPM9UCneO0QuyYuPI1UNKofwp2+R6jBvd96ZCH96GnUAxKwch38MWkZgW5wK/TUdnE/DqN5Owhbr/AWJYVg9UQ4bSAA4m7lzhN58VPegyRJYeA6WFO5l7XZG3Phdsh0vRn/7d1FQm3Jg9eCEV0UCCxtrUx0JSwGYDLi+lOnZGnNQ1WuafNG/hESHbpXXOqsIQM3SbLpXjx/0Yur/q+NWgsNrKmvG7XLHozLsc2EUXnhlKaIGbZyHlZ2R22v23J1as49NeUylIxYUzLkayKWNrqYzDX9C+6gKkRDunwEofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by IA0PR11MB7696.namprd11.prod.outlook.com (2603:10b6:208:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 11:36:42 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::8ba4:4bbd:ce09:b53c]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::8ba4:4bbd:ce09:b53c%4]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 11:36:42 +0000
From: "Staikov, Andrii" <andrii.staikov@intel.com>
To: Suman Ghosh <sumang@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Szycik,
 Marcin" <marcin.szycik@intel.com>, "Drewek, Wojciech"
	<wojciech.drewek@intel.com>
Subject: RE: [EXT] [PATCH iwl-next  v6] ice: Add support for packet mirroring
 using hardware in switchdev mode
Thread-Topic: [EXT] [PATCH iwl-next  v6] ice: Add support for packet mirroring
 using hardware in switchdev mode
Thread-Index: AQHaLPnzetDYteb6+UO8+iftYNcllrCltcyAgASFpAA=
Date: Fri, 15 Dec 2023 11:36:41 +0000
Message-ID: <PH0PR11MB5611546BBF797FB7BFB494EC8593A@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20231212125126.3297556-1-andrii.staikov@intel.com>
 <SJ0PR18MB5216B580A66AD4243C50A40DDB8EA@SJ0PR18MB5216.namprd18.prod.outlook.com>
In-Reply-To: <SJ0PR18MB5216B580A66AD4243C50A40DDB8EA@SJ0PR18MB5216.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|IA0PR11MB7696:EE_
x-ms-office365-filtering-correlation-id: e01a9ebd-94f9-4ab3-8c1c-08dbfd621bff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cI2rauMT4XFjv/UOhYdFxDlB1vDB5MOZ0P9jBB9HBHJZSKztNF9ozCz5+3H+H/D6n0+nH/MTHXETWWtoAmSO7cr7ZodF/VKe2kZA/uDQi5ejyVyAJ/zbtm116Qw/wHJ062hiRGRXL+6PXdtiJp8BPCy4F7Xv1QoXiwiFsNQKHzLaGmrLMxmW9mgmT9vvJ+W0jBeuZu2GrEQ8zMQ+r0IATYhMYb8ygzjJyG5yB8QenM/KqFd6JqlCm4FtBltjhV2KBdfwYl+ctMFGG6P1WXOgNdqEsTQXzZF+8gfjYOiGByPuZ4e2NG64pPr8B4AtEtBPXx+sy/Tp8CyfNcWcADj5/uTVnIHOgsPdhBisLE3pOKqJVDm8kh3onzsP1mb55H35KuS4sTzhrydvdihKlzZzHyPV4L4fxBwB0uUwhADC0v9N+jyOnVuIDGNFKpjapvNGWT5BIB7IzrNA0rbrfkFRMsPZbohqAKCdi7QH+YoRp8xebs3ZKep+L1R1wJ4pxEbXk2e7rZT9hjfF94I9t67OPV8fshjVulORrz+vCRI+x9HvtRXDBC1J+NJ+Vf8fA9O7bKfXOVCAnRRLbMbDpoBgwh/CHO8GdOX6rSOru0OIPln6P+jInyhDNbmxrP+9zP7/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(55016003)(26005)(107886003)(82960400001)(86362001)(122000001)(33656002)(38100700002)(38070700009)(5660300002)(52536014)(71200400001)(7696005)(53546011)(6506007)(9686003)(83380400001)(8936002)(8676002)(76116006)(6916009)(64756008)(54906003)(66446008)(66476007)(66946007)(316002)(66556008)(4326008)(2906002)(41300700001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tJa794qP0+4ZBrbTp/FS5NL6BhbphHFZza7XyHdbW9jhhbc/iXB70LHCVGST?=
 =?us-ascii?Q?a0BmkVraTOazMabYAyW01Bz108Xw+ZpjG2FMHtRbRxmRnwKlX/7n5vSreT2f?=
 =?us-ascii?Q?MCW4kKLIVeyq1gQDNAxawpdsBEECXYoBYrfEtfdnpGe5PwLHBZlCPL+oZg6h?=
 =?us-ascii?Q?UJh07SeYX+HwZQ6yeFt6xM59tTrv2joiPBsga4QQvHbDAvqdBRyrklZJzqJN?=
 =?us-ascii?Q?+v6rOsBVSXn2O5rhJ6bgS1kqghZK4Og1klJbebVVCHQiTG5FEqlaT/xBE4Vq?=
 =?us-ascii?Q?EnPnFX0ovG5ySit/dyy+G/D8Ne3ORNCtr4DuccRG4HskagS6l96OEcZO13cL?=
 =?us-ascii?Q?uPghs7Ive5c4rxW/JFiqmJbtrtUhTxGChtMifi1ASmkiWFpgSZ/0TqDxBKRG?=
 =?us-ascii?Q?POnpS9Gy2EcerNLGyoxiBCXPR6/1BY8kG4RrfbmZ5Yj6BuIeJrr+j+aLQN2C?=
 =?us-ascii?Q?UScL6D01h02n7cf4VlLarm9i5Wz7C4np5ekr3XETlQvvHF/koFATCno0qE5t?=
 =?us-ascii?Q?yrU3itLrPMuRFtIWahd7zZbICdFl0eJKc7a3x8h4jwQIwNCxf6Qj6uf9NUwJ?=
 =?us-ascii?Q?q2qOp4B5M75Ne9KvYI8BzmdIqTeJXjgFSu0n42sNHKC5o5uVzj7YgFqKJHcH?=
 =?us-ascii?Q?6wx9H9YY9Pm3OYI6o9dwK5QsCwMmRp8c8Rz15O2pgRGgK5zAHWPuseRx5vHs?=
 =?us-ascii?Q?ygUSao8lkkSUGW+c22Ua4O4WF1nFrrV3uCHOiP807AYsEd55sGgWvvnmIb8l?=
 =?us-ascii?Q?g4Ku2YqRf5W2QAcqNCX7oBo6k8RqH1sW9EdPbE/G6IBBJ78eyRzoEHa3ZfV1?=
 =?us-ascii?Q?gktw3XVN6Ce2LIvcAzbV6SXoEmxVtN3eZUK654tCb+NtHA2PD4eO6oZp/oRx?=
 =?us-ascii?Q?Sh8IDpFjalgH+tIanaSRkyUL2J91YenIgb+DBYuR6zHoQU3Wr+Z+X1rrkpgE?=
 =?us-ascii?Q?tcFQuyQ/231ggLpUiVnUxI18pPI5B3Dqr8q7cl4gS9QAd9yYH9J1OEnQKHs3?=
 =?us-ascii?Q?dI0sONcyFi27+Px5lmGcGd7jgbAMcHspq48MUkKw29OKLzYdBIIzjTsZ/kYe?=
 =?us-ascii?Q?MvUIxoe1XAID7j43Iy01D4vrTe8vzJHIawN/x8c3e+ijZiyZXROo7vxjd02f?=
 =?us-ascii?Q?cpXxdHuk65fQprFUxSz9hnWIDUlIaR2Xdlqax+ZWEMVB+woGNGR9MFQY3NfB?=
 =?us-ascii?Q?zXuDAKU1W7QGGZLqnEqe/BsCNIyexgQ+szqbyNMhlvlTi/3fBMlkUmvk++iA?=
 =?us-ascii?Q?OtaEuDfjP3RVP6MA1/LsiuKrrk9aMptmWm+WGxPQLwptGcFT6ANiD91YKd0o?=
 =?us-ascii?Q?eblVAptbS1RIdcZ5/IlT258QwVSwQ7oPHOjrCrmPtixZKy4rrDkkKeECAscu?=
 =?us-ascii?Q?LiOez4tR8TsDfsozuQnP4EDPG38p340uniDMGLqjWW2/2Qz5Jh/+EIDw0eri?=
 =?us-ascii?Q?eJN4mL8sJXAv21chhOc/07vaHvkru1ooyV7l6fJbwIWUKg7us9SMFcE3UGko?=
 =?us-ascii?Q?TVxd4uAfiEKsUVOhaR3KX14wsdCMgOnBRY6xED529nSkz5/MBrepE0bWTBJk?=
 =?us-ascii?Q?BtUdit3+nhUYR1Q18YcukBzRPDfdlYeljzjOnZ1v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01a9ebd-94f9-4ab3-8c1c-08dbfd621bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 11:36:42.1370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OO39z9mZaVJeyeeAJLMf5KG0BMe4Cujd9UjCVALXNgB7ulXX5nOBFfnJLPgkHq0SbUcZXQ7s79QPXDWrZDPxMxuAOE1UVcB1k6X3bWXqlTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7696
X-OriginatorOrg: intel.com

>=20
>=20
> -----Original Message-----
> From: Suman Ghosh <sumang@marvell.com>=20
> Sent: Tuesday, December 12, 2023 3:31 PM
> To: Staikov, Andrii <andrii.staikov@intel.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Szycik, Marcin =
<marcin.szycik@intel.com>; Drewek, Wojciech <wojciech.drewek@intel.com>
> Subject: RE: [EXT] [PATCH iwl-next v6] ice: Add support for packet mirror=
ing using hardware in switchdev mode
>=20
> > 		break;
> >
> >+	case FLOW_ACTION_MIRRED:
> [Suman] Hi Andrei,
> I guess we have two flow_action_ids FLOW_ACTION_MIRRED (for egress) and F=
LOW_ACTION_MIRRED_INGRESS (for ingress). The sample command used in above i=
s of type ingress
> and that is not handled here. My guess is, ingress command should show "n=
ot supported" error from tc right? Please let me know if I am missing somet=
hing.

Yes, we'll return 'unsupported' since we currently don't support ingress ac=
tion for mirror and redirect.

> >+		err =3D ice_tc_setup_mirror_action(filter_dev, fltr, act->dev);
> >+		if (err)
> >+			return err;
> >+		break;
> >+
> > 	default:
> > 		NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported action in
> >switchdev mode");
> > 		return -EINVAL;
> >diff --git a/drivers/net/ethernet/intel/ice/ice_type.h
> >b/drivers/net/ethernet/intel/ice/ice_type.h
> >index 5a80158e49ed..20c014e9b6c0 100644
> >--- a/drivers/net/ethernet/intel/ice/ice_type.h
> >+++ b/drivers/net/ethernet/intel/ice/ice_type.h
> >@@ -1055,6 +1055,7 @@ enum ice_sw_fwd_act_type {
> > 	ICE_FWD_TO_Q,
> > 	ICE_FWD_TO_QGRP,
> > 	ICE_DROP_PACKET,
> >+	ICE_MIRROR_PACKET,
> > 	ICE_NOP,
> > 	ICE_INVAL_ACT
> > };
> >--
> >2.25.1
> >
>=20
>

