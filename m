Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C428B78F038
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbjHaPYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244888AbjHaPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:24:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9BAE72;
        Thu, 31 Aug 2023 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693495477; x=1725031477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ISnIAiV3sQftjSWrFLSe+1rRrZSVhzSvoVMhGj2UrhE=;
  b=Swaif+gNlzbqJqA/Ln0ocIWswj9QN8GXqXa60MaENYuxxmztN5kx7PCJ
   4bIHEVc/4aDA6v2f0ECzPWDLcLAVmRYm5Rz5PAwqO3SGbO0Qajx0bC68j
   hL1sHpxx8NfWtWHpc68KWEJazROuth1zygLoiCsygOya847B7790EiIi6
   CSYfr8u1T4CrCYFrzZ39hDSc/stlqEaKXZDLUsbDdiAzcYRrzciL/XD1O
   JqxLhZfyHFQCjoHNKlDCMaDPqsIJ05eMlziQP3jllOgoEKmS2Kdd6kkE0
   JYmEUUwPlQr2jIDODra8vHJLniSOHouCyhm1MT+2I2NGeqXulahYJBCbo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375918107"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="375918107"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 08:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="863124066"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="863124066"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 08:24:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 08:24:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 08:24:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 08:24:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 08:24:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMujJZuI6pbTMIEU4yuUt13ro791/kIoqNHJb7jTvccRnAGqZpbRogYqOfUzRBLJLrGbdy8myVdYKXsgTNKgkreXm7qZqw7Pp2nkj8/wMGULtySdVB+5fmMHaz1cg+C33n3IrbMYZwMJf/8imXXVmUkyjB814jPMFp0HILbqLTUzy8HJMkW//m6Ms4uueCYYOubQ83GepAXNHbvs/JOHugs03+8T+Vw/DENlrkCWlm8BclKQX19G48A20DJJvCDogrYSbHBAnzeac999vaT400/+KPgLOU96eajqTmP6RTNuUIOotv8E2Tt1+CD4hwVSAGXwX3Wv1kCc+cqrqkMeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDXxd16qXkgFz+LNeohJN9KL1jOaX5JObMrOWx2xwf4=;
 b=WDN0Sh/e8qXeVNOALkaiwqJpTA+FELq+Z6UFtdTXk588Wc6sv0mUd/pu1yZUhgi10u+g21M8ZQUXtUyHNbD6KF9QDoyUk6Xom1aqUrQ3/zT4T6BQdrClZeaaEIOxpQLw0tDbzHWtvBNelPpu/XpOPpBzhzvByiH1KDt5TR5PLrKxjM6IcqEk2Ec7esqhjplQkEJfbfLdFXtmedoD+hfqFGEInjnmS5DP2SEgnATlQWuBBuMa5wCNqwMv9Eco/XxHHqiuCrjKM7laX0hFJxyD+6sLhJ0rCGj4SwzF2IxxtXMk0+DRbKv23fEYShk/3vZg5zUL3EK6EXU7vkWNNBarSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by DM4PR11MB5517.namprd11.prod.outlook.com (2603:10b6:5:388::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 15:24:34 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786%4]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 15:24:34 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v2 4/5] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Topic: [PATCH v2 4/5] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Index: AQHZ25LloUpSuUlFqEqhUDSvXhP6krAEhr0g
Date:   Thu, 31 Aug 2023 15:24:34 +0000
Message-ID: <MWHPR11MB0048D87555CACAC4DC7DF1DFA9E5A@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
 <20230830223950.1360865-5-utkarsh.h.patel@intel.com>
In-Reply-To: <20230830223950.1360865-5-utkarsh.h.patel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|DM4PR11MB5517:EE_
x-ms-office365-filtering-correlation-id: 1c6ff42d-f7e3-4584-a7e2-08dbaa366194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ra0m/CriG1+i689cNe5DgF8d6Uoa8YlkgLTMfdxv0fIvMtyD5vFkCc5Jl9JN/B5dyWnfEjmwKV1tx6BNgagTec/ceADM5KYH1K8JUeKXLqgtGUXnUOKa82693LTTHwDJsxJ21+VoG0aZKsov0Nl4cC6Yizu7zcNwXrs+Pt910uxHE7PY+Cmf+ux9EUrqO348tqdBkkLdIWnIepA0bVjiWnnw64I0FyQjcnjMiiIL68NUuZTl5foUqTBLEbsIusXKEMU5F9sELN/mhYPQ8tp4GXLl7nBOqDrZPqLYGrX0S2y0Zkzdl3G4dwXAbzQuPkcVv8FengZZX58ITm9Yb8nMRkfCEVkmL28vOm6n96sjtPm7b6YI4jlZOHDka3HuAV1PzHb1Es6Fu3bsQc3AC2IPJdWVdpigjwnpfSWdlhLjNXskTuJHVwnNpU2KGvH8DC+vmB67LoPiGOVoB6IgyzfNEJeW7Bicr/8HD32Tdh1dxB+2ViRG6+kq4MCHL0GrRKSBkKwtJQhOQt+rpfRiR3rL5U84gbh7CNkEO8XalF2Sv8+uXtxDug6Ds7J79rtlrUdXd/shlGbAnyEzDWBZen9jX+fIfLUPNLQHZLVOW10OuXBZeu9rUxr69javz2nZG2qQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199024)(1800799009)(186009)(6506007)(7696005)(2906002)(9686003)(41300700001)(76116006)(110136005)(71200400001)(5660300002)(52536014)(26005)(38070700005)(38100700002)(66946007)(66556008)(66476007)(54906003)(64756008)(66446008)(8676002)(4326008)(316002)(8936002)(82960400001)(122000001)(86362001)(478600001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MFagmfKylMI7nW7eeZyM3Tv0wr5M049lSKjWU31F9jvwzuK/gPMuEAFxXNSu?=
 =?us-ascii?Q?5jLxF2tAMNCsr4wYFeyCBi5fRY9aKVZ7rFmSK2MSgdl0bvrkFMwVE5nx71XA?=
 =?us-ascii?Q?SbhV8IC7Wp8sFGmztelDk8x2z8SZBhXprZjeWovHd1SZHQUW7Sg5iskNp6ZA?=
 =?us-ascii?Q?vQJWV1Q29gx1PyDzyBkf28ErwZF7a+WZgO5iLhTcvNKSgZEGCepWnS84q9jT?=
 =?us-ascii?Q?BEPMyFfVZ8TIzWlyAbg/Iqd536Vj0zH1Ekahz+pavxWZiZp12+FSSFDtznDJ?=
 =?us-ascii?Q?gkh8eu6ofCxKpNeDVRV2xPlBofOqWkGQkrojggownesz9EOGDHR/bvJDfiAX?=
 =?us-ascii?Q?h6r3e/lJkLgBH2t9xTJj89B0xxR6r2jpn1rhuuEVBF93HygZDvdKU4fU3d1g?=
 =?us-ascii?Q?ap6VMZxkAFIf+akyc/0pUaMYiqRLBUmUq/9oN7mT3UtQ/ksP0saJpAcFyalq?=
 =?us-ascii?Q?P5zai5sr1IiyeuswllsXpewFhKfVgwkN4uQ0JmskATiijfg2quaEI5YFFTlH?=
 =?us-ascii?Q?7NsVPKlpzTy1aRlX/wRimWWyy1/cMh2rk0e0EkEgyRWOXXTZ3JSBPAc1tRaE?=
 =?us-ascii?Q?4zBS6skiwlWUgqqk+jOzk/fmmPc1tNro2ofRzT2sX2ex3YDf9IbQvfKFPkrT?=
 =?us-ascii?Q?bn7coZ/lCjJc+Bq3Ux004TKKFEULZgLB8S1NxI1N9ASL8xIGfV/ew2oPGdDX?=
 =?us-ascii?Q?UzV5fynz6JoYWRtF6JCrAhBaSe9yHAQE93sWicAkwfKuU4rUpJoauWkXuVzB?=
 =?us-ascii?Q?w1m2C595xMcSqGQlZ/XXiV5f1aWM7+BWA8eNMVT5KNyML5n7DdpTP5iwvPsQ?=
 =?us-ascii?Q?7GRodw2J008RexdaSQEuskca6BI0opRNxUl2DUCo7QL0qji4fd0OkHuEkRx1?=
 =?us-ascii?Q?9CKPw4ZkpYtgjQDmisLnqwk6aIsae/Mh26gQ5ochzvQfY69cJ1U8AV3FoN2U?=
 =?us-ascii?Q?0g5phzExpfqivS2aeKWAA3jVIUrzwcdChrChSUoAbA9YrAViWNFoWMYeKuRH?=
 =?us-ascii?Q?fDRuJK5OPpeJGwEg6DrnwpDS//jYYY5fj6GJQgTUgOptOBhQBRGixCpMQ9vD?=
 =?us-ascii?Q?DLqtqpqzBEXysW1NgxuhWEIPLXxbtaLcFg37xNQVEq4C5AjI6ZeDPzv7BMLt?=
 =?us-ascii?Q?wXbCJoXZLrHoxywYBnmne3m2nkAw3YdkVQFYbVBZuvgo0KMNz6euZMKvlvBD?=
 =?us-ascii?Q?9Ut6Iq+OmhHQrC7Hf3Hj7vr8p3OnW3gp+waSz8HVlLY4sxVEbgdAQdJ5qKyM?=
 =?us-ascii?Q?QkFsFU97uq/RarwCkxgxzZ4Ms+QwOt5dz3PSBvZ8/XWn197XO1gifQMxgM21?=
 =?us-ascii?Q?REwkRW7od7kLzAKKEJx9KZRWbuvmm3PCnv6O7HQWMQdahJQIH/6GoDLco9mZ?=
 =?us-ascii?Q?ENJQAT2zvDkIgSzCos52ZhFefdgYw0PgNOjvBpItEiwPKoc8C/SLqzs+wM0X?=
 =?us-ascii?Q?mJoo9yuUgGECQTeVmFEv5xU7Oksu5G63C0lvgtlIZQMi8UnPt7M1L90lLqYj?=
 =?us-ascii?Q?y37zAWbNbAJrbAcU0SqierAZ2bjaihaXDI5SZLDNcCHbq7lm1C4MNHWBOr8Z?=
 =?us-ascii?Q?oRRWgNyI6+tJbxH52sDNh8kOLN9Y2J1mlqNheg8C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6ff42d-f7e3-4584-a7e2-08dbaa366194
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 15:24:34.4662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8C4UikZENvfCVE6hDJS93MX+nnUCrA0Xp49pQh9lC6Fi1JTvF2/I9QZg2M61m5DOwewxjLJ1jZdYL6TPYdeR+vXg4MPrFU1Nf9sr8WEPIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5517
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>  drivers/platform/chrome/cros_ec_typec.c | 31
> +++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_typec.c
> b/drivers/platform/chrome/cros_ec_typec.c
> index d0b4d3fc40ed..8372f13052a8 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -492,6 +492,8 @@ static int cros_typec_enable_dp(struct
> cros_typec_data *typec,  {
>  	struct cros_typec_port *port =3D typec->ports[port_num];
>  	struct typec_displayport_data dp_data;
> +	u32 cable_tbt_vdo;
> +	u32 cable_dp_vdo;
>  	int ret;
>=20
>  	if (typec->pd_ctrl_ver < 2) {
> @@ -524,6 +526,35 @@ static int cros_typec_enable_dp(struct
> cros_typec_data *typec,
>  	port->state.data =3D &dp_data;
>  	port->state.mode =3D TYPEC_MODAL_STATE(ffs(pd_ctrl->dp_mode));
>=20
> +	/* Get cable VDO for cables with DPSID to check DPAM2.1 is
> supported */
> +	cable_dp_vdo =3D cros_typec_get_cable_vdo(port,
> USB_TYPEC_DP_SID);
> +
> +	/**
> +	 * Get cable VDO for thunderbolt cables and cables with DPSID but
> does not
> +	 * support DPAM2.1.
> +	 */
> +	cable_tbt_vdo =3D cros_typec_get_cable_vdo(port,
> USB_TYPEC_TBT_SID);
> +
> +	if (cable_dp_vdo & DP_CAP_DPAM_VERSION) {
> +		dp_data.conf |=3D cable_dp_vdo;
> +	} else if (cable_tbt_vdo) {
> +		u8 cable_speed =3D TBT_CABLE_SPEED(cable_tbt_vdo);
> +
> +		dp_data.conf |=3D cable_speed <<
> DP_CONF_SIGNALLING_SHIFT;
> +
> +		/* Cable Type */
> +		if (cable_tbt_vdo & TBT_CABLE_OPTICAL)
> +			dp_data.conf |=3D DP_CONF_CABLE_TYPE_OPTICAL <<
> DP_CONF_CABLE_TYPE_SHIFT;
> +		else if (cable_tbt_vdo & TBT_CABLE_RETIMER)
> +			dp_data.conf |=3D DP_CONF_CABLE_TYPE_RE_TIMER <<
> DP_CONF_CABLE_TYPE_SHIFT;
> +		else if (cable_tbt_vdo & TBT_CABLE_ACTIVE_PASSIVE)
> +			dp_data.conf |=3D DP_CONF_CABLE_TYPE_RE_DRIVER
> << DP_CONF_CABLE_TYPE_SHIFT;
> +	} else if (PD_IDH_PTYPE(port->c_identity.id_header) =3D=3D
> IDH_PTYPE_PCABLE) {
> +		u8 cable_speed =3D VDO_CABLE_SPEED(port-
> >c_identity.vdo[0]);

I have wrong macro name here, will correct it in next version.
It should be VDO_TYPEC_CABLE_SPEED.=20

Sincerely,
Utkarsh Patel.=20

