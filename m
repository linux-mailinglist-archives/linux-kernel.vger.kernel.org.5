Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1298D782F80
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbjHURet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjHURes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:34:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E178D101;
        Mon, 21 Aug 2023 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692639285; x=1724175285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g6YtKp74vxbuBNw9SKQVvdOPwnD3MyRq7eSk+OUsPng=;
  b=HYznE48r/EE2DugM+4aB5oG2XbTrh9JF4qmnhwSZ87x0PPBg7sNQi2Fe
   TMznidgythUs17Y/0Fa1gAlMA5/FXoJYSIlmcXwyBdZMjafs06xZYEZjz
   DnMRFH4rK5YrePwx/ClZQ0mgjfwOZ5xICLvp+hh2rWJpZwRQ5k4fs0x10
   SVKSQRK2rJuxo8XVwelYlfStTs/kg8uaiejTEpWXU2QPI83GZhttOy+8Y
   6qo6QCCLagE73+OOJtdjnGpEDU3G2JryzO1eYgV9lvGMVJBHqzE0/DDxH
   NyBJ6RwUiA/HX+UL2JYvHQ9iKFFBtvnDNRYfLPbjmLZ4BYRn1iUxmHkCK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="363823543"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="363823543"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 10:34:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="765453630"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="765453630"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2023 10:34:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 10:34:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 10:34:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 10:34:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 10:34:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lN2ChDZLabnkt72COg2Yum0iyvK2iCpKD9+hZHfPLLMoB70F083T/ZwAoPxxJl0wmV8t00zTlDXz9jGe/FbvQamNv3mABAlkVXz3IQSJZdJoKlzpd7fn1ANnDLPc4/M7rJEPs5hjtyKzT4xGyD30bDqdSXM6rkQEYHlcqmz+GzItvvE9veXFQ9+xxq/DD+qjBo4dOYs1+Q6rsU3yzkHZYeqM4dudzsdfgCz/5iU8hp8dElEr/MKzRrOQixrOOKORbvdzcUR+WLkN/HkbKXyyg3w4rULfW1YU6O9uvYBUJT5H8j7mHKWve7DlhKGxIe4BpcgWQwEJgf+k1QtifiyCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGzBwzqJGnsg56Edh4Oo2s8aiqw9i2Owu/CPe4ryFZw=;
 b=fWaRM7FI8Aig0/W20CXkW3k/FtwEzUNQmMVz3UA2S/YhM21jHJJtKFZFJaKrKoMPtj7r9PjfD2MkTLaCEtIWqkcWuMFo+YOD5Wa0cwfnP+tqmka+gCFyco3xhDyO2ZhdW+A/rUlULiy2Rm6Ud30uJoaIp/wvRYHf6hAkZ6AMNqzb7dSmLzZRwubuHz70g/rKAgl7mXAZIeKEVTPPmJrl4TNNqL5thaeNT/huOnAsvESlNur6IHyUYTgRYaJ8wjWfIglLQrgZ0jcpr1KHocOScbMgXgvExZHdkPImfTR8ZDPYFUdydNeBRzW1ovOrRBu71ynJnL9XqB3W8w6t5mJ1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by PH8PR11MB7096.namprd11.prod.outlook.com (2603:10b6:510:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 17:34:42 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::da4:d67d:40ed:9786%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 17:34:42 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH 3/4] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Topic: [PATCH 3/4] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Index: AQHZzJW4ijJBPwTw+EyuNab2Xuk8e6/wVjQAgAS3/8A=
Date:   Mon, 21 Aug 2023 17:34:41 +0000
Message-ID: <MWHPR11MB0048AF9CAA00D2A57C8CC533A91EA@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230811210735.159529-1-utkarsh.h.patel@intel.com>
 <20230811210735.159529-4-utkarsh.h.patel@intel.com>
 <ZN+nXGr3S0OL3Edn@chromium.org>
In-Reply-To: <ZN+nXGr3S0OL3Edn@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|PH8PR11MB7096:EE_
x-ms-office365-filtering-correlation-id: 1b275cb0-15a2-4c13-78d8-08dba26ce71b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3CX1J7AR9oeHwxE4tw9+S16wRkhpwqSovas/wka7Xtp/nsF09xrDZ3shGi6h6s9HiCo4aZta6Ytd0lzhBwuyE/iXgADqtkEe8UTv/bA5NVb0FArvTz/9qGiSL+AkxjJUUvCooWcrsn//wtN+T5DM/gWZwvrRnvoItTnpX73pFxQ/bgNw1iHjXYIjJ2uryLb5eA5MkjsxDmcZ4xJ47NTEwj3OtgAWrBbhSzu3HjtTHTlz4bmcKrII7XTypUirKTrMvISxTpkRhrdKTz76YTOOLVOIIsWH3rqJ/3o0Sq0YLViBwg9JJCwyl3WPmyJRo9EkYuYVbpM+J6SQSYXWMSGgoP4hQmPOPcb6ZwAp6jEGi1WbUgtjWT5hajaNNfKn8zFW8j66cD1f2HxLHiPZ1r7/t+JgI3IP5n1lgLSyeN2e7KX15kFMlFtJNRfH6SWUDokZdb7MKOYZkzVEKFSmEOAuWtbWMu46L/KRELWMeX1QO4XT25ggtE3HgTEugiLjMC6ic14imdxRD1rzaBmOddymR5sgqKFurQs2WvETwAEMWTSp8Z+ZEvGGKf4xvzxoq+rm9iwtB1aNVxglcpW/PK+YPF55i+oqS5/g7AKtzgTALvnTQZdRx0HrXZyXcDZ12r9G0IKEiY5O3SyHBgOSJPUCAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(186009)(1800799009)(451199024)(26005)(9686003)(66899024)(33656002)(122000001)(55016003)(38070700005)(82960400001)(86362001)(38100700002)(83380400001)(41300700001)(316002)(8936002)(8676002)(66946007)(6916009)(66476007)(66446008)(64756008)(54906003)(66556008)(2906002)(52536014)(5660300002)(4326008)(76116006)(71200400001)(7696005)(6506007)(53546011)(478600001)(87944015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fZElZ0OxEacaSWmqgUY3VsV+7I6mjzlDB6p0nTtxdnKhetwxKVdWSoz/jtji?=
 =?us-ascii?Q?WqePDEUKnS0sSO/iu3s5iADmgcEfPb2vUTjqssNSlJfLMwKO7tZgehDB5++1?=
 =?us-ascii?Q?rjY2YCEz+LTQ5oxv+lHxlxyS3TWOVgtbUPQ+j9gwBFzQn3sIOkNXMM03LL72?=
 =?us-ascii?Q?487dmJGX/rJ6JPr/YqXtOjvVW8D/a4INZ61lD/E9if4XxfporMukc20ldyPZ?=
 =?us-ascii?Q?1CQgMFE2jKoEWxvbNp55r9T8HHlnomYlstrY4zrYCRP3SgdVGsTOKqMlicUh?=
 =?us-ascii?Q?D9rhxI/yi3c1dtRNdQ+kbQpg3ef0d//KfplO2cMCZcfx/fj1RUO6UbA7bMcm?=
 =?us-ascii?Q?nZlWuyWS0oWy2bMMryUOGyRoUn3EcUMs3z4X67e18F7ndwoCQNFqybVGSkef?=
 =?us-ascii?Q?aXXmH5jaLHBVSn/a6JZWF9sLZAR3ioA7xPLKlNfdj8nzmcZItHUW7WpJ5Sq6?=
 =?us-ascii?Q?Sej8TLHz6pJiDocPkLaPeceiaSgo1VFIUvRWGS+4pfhShhlSgcL4XaDhVXQM?=
 =?us-ascii?Q?/XrGRMnnAyiEg6Szg8Vx3dsineyvI2lot7dclIFtTHjh6AF36czT3lot/t5n?=
 =?us-ascii?Q?ci4reCS6nRypducBFCK+5HKy0d99HgmQ8Oqt6Gz0Ug2hzBsGMovFftHF0y/b?=
 =?us-ascii?Q?IrR0emj2SSu4Po/kV0pbQ0huchI3cLwyzP6WSDa/Rg9UJMKRyb6OSLEYcrpw?=
 =?us-ascii?Q?q1zVr6m+oIFcozmiK/bDXYD/3o9R9IXMzaoGiWNJjNqKnk/1RP0bqCyUoZko?=
 =?us-ascii?Q?87gF7y12Wda+GsMuWd++2Sdyy1XSQXl3pZ1ep7sfYB5W1pSs7URj8xJxaC1J?=
 =?us-ascii?Q?pMn/8W7ugO4FvhTyuJDIN4MRroKcTuq3IEsoPc4ECojhFcgCN5kCntCGgM1P?=
 =?us-ascii?Q?oaN2uwSnIJKP6oJlGTbNJEnqfCJS9Qa0XEZdwO2tT3hvP2SzLBvsdXWrxZet?=
 =?us-ascii?Q?89LkI60uiCR6Z+rkDCvMNPVisQpHGYXcZmUmZpFusocZdkeJsVhfm7ZoN+/G?=
 =?us-ascii?Q?g3qAjdSmaeg20A2+NaTo3Ao2ypv6f1sbhzpZRXnFY1IAu/Zy3n/UZeS7bXPq?=
 =?us-ascii?Q?S14yFs2S3zZ03TOQ9d8ugRLkIvDlxyikvE0t+4LXeg3Ha+DLkV6oy3Svn8Ng?=
 =?us-ascii?Q?+G94u5IImS9oFn794NDxfFLIr9OI84jna1fPdPCcqM+PVRVhEDTTgN/KyJe5?=
 =?us-ascii?Q?3roMx6jzZ54JZnTIYDhUh8/kvRFj99XNKlXDKmOBGV2GVj3jyHXWPSfQTttp?=
 =?us-ascii?Q?cO019qFo7g/kY/v0yOMBhiip5u4wadlr/k3CVTeLGhjvuAyU+UHyZ/GMFKZ8?=
 =?us-ascii?Q?B1lC6Nm9OxDiLB/jw5OAGUg+3yR/ZPeNKz0MaBSCpkDl8lKChEsv0X4muvQy?=
 =?us-ascii?Q?gqyXNBFKyIkLFgqlzxg/qgBgrt7+negnhAe768IufVpHSs3Rqh6QKOKWWvi4?=
 =?us-ascii?Q?Q47ZmgpSHPmVKODl7ZYylmG9LdQQljIY9EpXueFLflAnhuw33TQG98Fv06N5?=
 =?us-ascii?Q?Son9Ea/12PerhMPkV3o2JQz1tiu+uQZX5fBuM96K7T+7N9gd1PNtcWBVdOwj?=
 =?us-ascii?Q?e3lePFtVxBvLiFc057nmVuz3U/DaDXwWxutJnvHU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b275cb0-15a2-4c13-78d8-08dba26ce71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 17:34:42.0073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7muP4dLQktQgc2HrCdSFhb3QOXRxZBuTaCv+ZDTqot8iuZ77UPsOBAHg5aELeSK4q/ru56sjfMJ/zAYJaH9a94gn78CkMq5YKuwBezE+38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7096
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for the review and feedback.=20

> -----Original Message-----
> From: Prashant Malani <pmalani@chromium.org>
> Sent: Friday, August 18, 2023 10:16 AM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> heikki.krogerus@linux.intel.com; andriy.shevchenko@linux.intel.com;
> bleung@chromium.org
> Subject: Re: [PATCH 3/4] platform/chrome: cros_ec_typec: Add Displayport
> Alternatemode 2.1 Support
>=20
> Hi Utkarsh,
>=20
> Thanks for the patch. Please include the chrome-platform mailing list to =
each
> patch in the series; at the very least, patches which touch
> drivers/platform/chrome should definitely have the mailing list (chrome-
> platform@lists.linux.dev). Otherwise, we don't have enough context about
> what changes are being made across the series.

Ack. I will add this mailing list.

> >
> > +static int cros_typec_dp21_support(struct cros_typec_port *port,
> > +				   struct typec_displayport_data dp21_data,
> > +				   struct ec_response_usb_pd_control_v2
> *pd_ctrl) {
> > +	u32 cable_vdo =3D cros_typec_get_cable_vdo(port,
> USB_TYPEC_DP_SID);
> > +
> > +	if (cable_vdo & DP_CAP_DPAM_VERSION) {
> > +		dp21_data.conf |=3D cable_vdo;
> > +	} else {
> > +		/* Cable Speed */
> > +		dp21_data.conf |=3D pd_ctrl->cable_speed <<
> DP_CONF_SIGNALLING_SHIFT;
> > +
> > +		/* Cable Type */
> > +		if (pd_ctrl->cable_gen & USB_PD_CTRL_OPTICAL_CABLE)
> > +			dp21_data.conf |=3D DP_CONF_CABLE_TYPE_OPTICAL
> << DP_CONF_CABLE_TYPE_SHIFT;
> > +		else if (cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SID)
> & TBT_CABLE_RETIMER)
> > +			dp21_data.conf |=3D DP_CONF_CABLE_TYPE_RE_TIMER
> << DP_CONF_CABLE_TYPE_SHIFT;
> > +		else if (pd_ctrl->cable_gen & USB_PD_CTRL_ACTIVE_CABLE)
> > +			dp21_data.conf |=3D
> DP_CONF_CABLE_TYPE_RE_DRIVER << DP_CONF_CABLE_TYPE_SHIFT;
> > +	}
>=20
> I don't understand why the conf VDO is being recreated here. cable_vdo
> should already contain the necessary bits. Just use the cable_vdo that yo=
u get
> from cros_typec_get_cable_vdo(); it will have all the bits set correctly =
already
> (the EC should be doing that).
>=20
> The "if" condition should also be unnecessary.
>=20
> You are already doing something similar in the other patch for "active re=
timer
> cable support" [1]

"if" condition is necessary because there are cables (LRD Gen3) with DPSID =
but does not support DPAM 2.1 and in that case we need to check TBTSID of t=
he cable and use the cable properties e.g. SPEED and Type. Since that infor=
mation is already available in pd_ctrl, we are leveraging it.  I will remov=
e the part where it's checking retimer cable as DP2.1 is anyway not support=
ed.

>=20
> > +
> > +	port->state.data =3D &dp21_data;
> > +
> > +	return typec_mux_set(port->mux, &port->state);
>=20
> Note that now you have reversed the order in which the muxes are set (whi=
ch
> leads to subtle timing issues with Burnside Bridge and other similar reti=
mers).
> So please don't do this.

Are you suggesting to add same order here?
ret =3D cros_typec_retimer_set(port->retimer, port->state);
	if (!ret)
		ret =3D typec_mux_set(port->mux, &port->state);

>=20
> > +}
> > +
> >  /* Spoof the VDOs that were likely communicated by the partner. */
> > static int cros_typec_enable_dp(struct cros_typec_data *typec,
> >  				int port_num,
> > @@ -524,6 +550,9 @@ static int cros_typec_enable_dp(struct
> cros_typec_data *typec,
> >  	port->state.data =3D &dp_data;
> >  	port->state.mode =3D TYPEC_MODAL_STATE(ffs(pd_ctrl->dp_mode));
> >
> > +	if (typec->typec_dp21_supported)
> > +		return cros_typec_dp21_support(port, dp_data, pd_ctrl);
> > +
> >  	ret =3D cros_typec_retimer_set(port->retimer, port->state);
> >  	if (!ret)
> >  		ret =3D typec_mux_set(port->mux, &port->state); @@ -1196,6
> +1225,7 @@
> > static int cros_typec_probe(struct platform_device *pdev)
> >
> >  	typec->typec_cmd_supported =3D cros_ec_check_features(ec_dev,
> EC_FEATURE_TYPEC_CMD);
> >  	typec->needs_mux_ack =3D cros_ec_check_features(ec_dev,
> > EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
> > +	typec->typec_dp21_supported =3D cros_ec_check_features(ec_dev,
> > +EC_FEATURE_TYPEC_DP2_1);
>=20
> This entire feature isn't necessary. Regardless of whether dp2.1 is suppo=
rted
> or not, the port driver just needs to forward the cable_vdo it receives f=
aithfully
> to the mux driver, which can deal with internal details (based on whether=
 *it*
> supports DP 2.1 or not).

I am Okay with that.
We thought we can avoid unnecessary check for the cable_vdo for DP alternat=
e mode on platform where DP2.1 is not supported.=20

Sincerely,
Utkarsh Patel.
