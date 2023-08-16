Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F977E1F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244664AbjHPMwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245375AbjHPMv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:51:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FC526B8;
        Wed, 16 Aug 2023 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692190316; x=1723726316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7QtjdUEsBLg85HibAGR37+R1cveVEY1Dlhk47WKtaME=;
  b=Tf55bWT7yGZH/RnbLDBerhD96xLVMOr28geRccIQvcG35kiNhP0Ttfss
   0PDpnWGfWuxjmDTULQLX2AvhcmvIv8m7ayaOH3s0Xxcx8fdoAkEFwesOv
   +rsFhbBFDjNtHjqoaSMpiz4n0xkBcbweXfCjnoLCa4DAKiPTqH/6frE64
   3DtvEAlF7G3bKldvYTz93T7zZo8Jb26ieuO83eT9w28v1sGE4rtqCK2L+
   jSPWiLzitRZxphuknlStaL8r/vtSbzn36w1w91OzKYgubL5V6xylp+rnj
   CdOxFSU5jxh7Mm9Xuy72WL0NS2/5kbb8w/6I97/C61LTsnDDMYVmQYWkX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436420320"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="436420320"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763617856"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="763617856"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 16 Aug 2023 05:51:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:51:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:51:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 05:51:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 05:51:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdTzRCmNGL+cC4KRNVGC20VDAWUU+s5aML2bSsMaq1BmlW36fY93sw1tp7W6issXfmBt6CnBYvPFFzZGOk/V8/fXg9HE7NqVRqJanmmB0An5QgQVvWCRnVgsvtV3cptUAHH+DkdTKUHcHk5dE/JtqpFO88Vr6dXcFJUmNyc1cYW7mxan8/Yzmw0Qg7Dejri5siT9Zrbln4pikt4wKzyBCNbeZVeY3tngplJRUDkD0RWkQctWEbdPDCIE5VGIjf4FiHYRkVf9B+dP0/uiEtSCzcNNaY1GdV7t5GzWppMTMVZjguGfRTLOjIuooLAFkKcW/sWBnk/gqpNNkDjMWd6qcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QtjdUEsBLg85HibAGR37+R1cveVEY1Dlhk47WKtaME=;
 b=i/N9CxpWX+QqWXPQwlBCGFVY+q97Th4V4vG75vaL0UGRM5v5tuyhvDJL4RWxJEbp3mSe5aHnXbj1Ba3/qZtV6vdUX5DGYKhWpf/w7F/4RncR3EYtg+Yp56ahwmJpn5ZEulZXjNRn+4g1JppPu2wcU0Hg+ORmwM4vQ4+wLFwf7Aj75FyvGTlLpGkRJI1uvLi52oWHtGUdOIT6ics0s3lyVWLhFuCIFlnHO6/Qzyh7Q6d7LNzkuy/CbkZu5dVeNsjXawz5h5Nrv7annzDrD/pqvwH8cEfdQPCkpGvDmK//a9fQgOl/BBRwCw7zMMrlVmkaf1mr7cpSrXnIXP+FXAYK0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by PH8PR11MB6729.namprd11.prod.outlook.com (2603:10b6:510:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Wed, 16 Aug
 2023 12:51:42 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a21:609b:312:5cac]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a21:609b:312:5cac%6]) with mapi id 15.20.6652.028; Wed, 16 Aug 2023
 12:51:42 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        "Lobakin, Aleksander" <aleksander.lobakin@intel.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Zaremba, Larysa" <larysa.zaremba@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next 3/3] virtchnl: fix fake 1-elem
 arrays for structures allocated as `nents`
Thread-Topic: [Intel-wired-lan] [PATCH net-next 3/3] virtchnl: fix fake 1-elem
 arrays for structures allocated as `nents`
Thread-Index: AQHZwWvbjGxOTRd/y06G0ToiKosct6/Z2OqAgBMk/BA=
Date:   Wed, 16 Aug 2023 12:51:42 +0000
Message-ID: <BL0PR11MB35212DF83A9AAF2E1D2D3A628F15A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-4-aleksander.lobakin@intel.com>
 <202308040130.E48094967E@keescook>
In-Reply-To: <202308040130.E48094967E@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|PH8PR11MB6729:EE_
x-ms-office365-filtering-correlation-id: 56bbbf18-916e-4f88-cce1-08db9e578a70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C2qz/x+lekBvI/u0dvHqeqn65nvaWs29JuuyEQsrZkLm57sPBO1tBk/RYtGiej+D1kitdYftdVaNtcZZe/LCHobGSR0FjpvyY4+ef+BL4kamy99274RdnjpKiwDrEmAUqvI6xCZWJj6kLDjaQEj/vteLdDmCH5M33PxtSpJD7Wd9CcUa5nFKyScrkzTlfNDBwDPMfgXO5WMPvmU3o9lythsPCEzcXUJqTj55b7GVY/fWmHITcRZSC1DQvsKLIkyvI0miKrXU4b4DeJIk0QOn+Zj8LSiuoRexs0lTYBwfMy9lrauMc8gxaliBwazUOgKdEMGZ+PFtA+fO1762WDjlJ5NtrHx0qyAP6oM2iHtUzOTozmpqBb0SqUaVNqYzbicxdmEa5jGPI6rnOAD+5gH+jAav9on75EQEu4GDeI9SLNFerFg7Xc26+rnqTeHYqA9ferAG2+s7Vb9EJTOYqc5wSRnihOII8a6+bxZjc3UpnQt5kW2Nmbmbj7EqdA27cuFB30VY0QolylmPiC7r1XNsENowXBvDZjWDrhGfs+l3Y7Fo/OjEFZhfEJH64b0i9T+mVTAW1y/nnNv3M+8kM6GPL4LyYADS6+OFIC79F/808vVrQcYdCpWNBNDv5deYkUb0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(186009)(451199024)(1800799009)(33656002)(86362001)(55016003)(83380400001)(8936002)(4326008)(8676002)(5660300002)(2906002)(41300700001)(52536014)(53546011)(26005)(7696005)(6506007)(71200400001)(9686003)(122000001)(966005)(110136005)(316002)(478600001)(7416002)(66556008)(66476007)(66446008)(64756008)(54906003)(82960400001)(76116006)(66946007)(6636002)(38100700002)(38070700005)(81973001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?kIPrYo3JPu0ycxykm/MbTrTabUu02vKOoIXtjq2A7udfHVBWnRktoko02I?=
 =?iso-8859-2?Q?2N++WTiD6UYcgmhjqVopN7+SoFWVmGEdSFZ+HPHgU4ZCVRZYKnNH6gqf/B?=
 =?iso-8859-2?Q?XzD63guIawoATWK1Xcgp6wglbBIy+0SVTDnhihmMiiX4ESt3uHAHmasxYp?=
 =?iso-8859-2?Q?Lxsvl3F6MNK+UuBeNtrweR5sigcutmv6CoospCTl3LgNbwTtWi7Bt2VHLV?=
 =?iso-8859-2?Q?RLUV5AuUMFBNVUj/mKUQ5qoSkd6n7BSc26Ja27Anfe0vLSDn9+8mJgTS2d?=
 =?iso-8859-2?Q?74XDvU+jmSEuItKDsfOVRrxkG+AKmyyyq2P3Yrkbt4ddtLBr1zvXR9XARU?=
 =?iso-8859-2?Q?6uYMQwhO7nn8FuzPyXAUOXtE73/jYtVbiZ4WpnFGw7q01hBWqoPPivi8Gh?=
 =?iso-8859-2?Q?ZSn0zhprpd1QRw5+XlalCysU/FbKta9nhvY7nUOxGm9CUodKxHV5f3Wfux?=
 =?iso-8859-2?Q?BTeO58abFYu3lYGtr/kXPfpbPUHMD6dDMBQFTcSsaL6B10z9YlfuGflvPh?=
 =?iso-8859-2?Q?GbhVjpKMkghO14LPrOhBKruAZDWTE1NS5uiFugtzajpCoWTWT2+0phyRse?=
 =?iso-8859-2?Q?ct11W/bPMaAXVQmu9eVDq9ebPhq3pbfjgv9Vgid9DPmeqWRMdgenYzkxAt?=
 =?iso-8859-2?Q?F0wwbfk7fhFQqzu0ogZGCs32FkM7+xh0Ndsyl6umOmif4QyXdJ0oNjvUl2?=
 =?iso-8859-2?Q?/cVQ2m04ss0OOpEcBxbqsd9RkGa5/3Wk73M3Y+kzpKhYSmRc3i2+xo6JZi?=
 =?iso-8859-2?Q?dHC85fnE9NpPoizoLzOukEHPyH+65cFmbwKF6wpFW/ZS3drwDYFiH8J5T6?=
 =?iso-8859-2?Q?ov4Mkf+QgLgucfYLSzEbxFAEEAk6sIGC/gysBscJgPDC1l7P0LPRpB1rMw?=
 =?iso-8859-2?Q?+cT8jd69rqTX0BOAniLFmGISfrbFosdsVAIviDJnrUivEgG+e8xyrTjEHb?=
 =?iso-8859-2?Q?Zevn7YfZLJIQo51ockT3pwkNK16SC73UUob6AZQwxOfed3fNbbFjSU3S3a?=
 =?iso-8859-2?Q?klNmu43CNYrN8nxfThmrXZ4T7YvkVKUYNX2ZEWJ4B12DKk9BmoNXuGQLom?=
 =?iso-8859-2?Q?E9Q2ymTu0givi7FS9ci1ui27nuqLJdsZay63M/fWyN6AImBTFMPyKRPX/c?=
 =?iso-8859-2?Q?ATyH+If4CjikWpQz2acVv19ekBGVKLQ1+H2yN3gMJhV6FC8MKaDQ4Z4sbF?=
 =?iso-8859-2?Q?mxwVC5RTXb9UtyTAsjbhOnQsk4yJRoNQatvKDjJDyp2W2qd/nCciwquxOx?=
 =?iso-8859-2?Q?upoZVyrh9i4SNnjDqPQfEZM7yw+Yqj4pjEJX71rWWulfCqEZv+e1TLl8a6?=
 =?iso-8859-2?Q?DWFsueE1tBm703qdXj5gM9MnuNCk8cnXJn+6R5nHV9DWr37Qvok3nnxErC?=
 =?iso-8859-2?Q?isY684ZfRjGkfOmGaJAZtknMNVMF9YwmE4UeofeAUgpI09UwB18Ll0TTob?=
 =?iso-8859-2?Q?yV3C9j2yYnuSc+ejZaJmbtKlUHZ8oDVWEzejjamb7g/2X5GplbVJp0i6Uj?=
 =?iso-8859-2?Q?T12368/hdTD1ia6eqU4IT64+jZlyUMBk4RgsyB9TYUAIl9VZwgf8ej/rYk?=
 =?iso-8859-2?Q?CVRCZofGr0wo4lPgasqigkSfAS50GQVK+BbGaUSUpLtkfpKs+PT9v1op4O?=
 =?iso-8859-2?Q?Lgl+fp9HuddJUnjJJXHpWLWJcRoWgLIkJLAgjaFak1/WtRB5vsU0U7Gg?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bbbf18-916e-4f88-cce1-08db9e578a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 12:51:42.5023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kdd6EukCDKcWAsDZWY14LCR5Gds+xjaZRP/O+a/CtVFLkdgxhq+0GLq7AMEvI933knxDTzOtEnbwySLulfUc13g1s3m+AL6dNUqaeipzngg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6729
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Kees Cook
> Sent: pi=B1tek, 4 sierpnia 2023 10:30
> To: Lobakin, Aleksander <aleksander.lobakin@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Zaremba,
> Larysa <larysa.zaremba@intel.com>; netdev@vger.kernel.org; Gustavo A. R.
> Silva <gustavoars@kernel.org>; linux-kernel@vger.kernel.org; Eric Dumazet
> <edumazet@google.com>; intel-wired-lan@lists.osuosl.org; linux-
> hardening@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH net-next 3/3] virtchnl: fix fake 1-=
elem
> arrays for structures allocated as `nents`
>=20
> On Fri, Jul 28, 2023 at 05:52:07PM +0200, Alexander Lobakin wrote:
> > Finally, fix 3 structures which are allocated technically correctly,
> > i.e. the calculated size equals to the one that struct_size() would
> > return, except for sizeof(). For &virtchnl_vlan_filter_list_v2, use
> > the same approach when there are no enough space as taken previously
> > for &virtchnl_vlan_filter_list, i.e. let the maximum size be
> > calculated automatically instead of trying to guestimate it using maths=
.
> >
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>
>=20
> --
> Kees Cook
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



