Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9307775CCA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjGUPwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjGUPwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:52:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ADD3C34;
        Fri, 21 Jul 2023 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689954718; x=1721490718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iAJ1nHNnCKZNUH34gcXM0QFm+0pDD+og0LXL4lHRpds=;
  b=QbValAu6qxgMqXjjpeGiva9Zc5BJ5PdAmBdDYDBOELFr5PPybnF4CoUC
   ZXmq/yfEehRPDlD/vKJ/Oh+wii/OCxcZHbG6KKw8JIQ+/1cTsktuxI/CO
   kQoSiBB8+r8fFIxZb/kf+IHFg1DvrW/d5EJjfAUyXt2Uk//4T6ZxIoCBL
   2cYPGuB7q88yJVbyDBp64Ce7GdNxRE+NsfBCzQxXNkT6cn7kgm/bbrnqM
   fmv0hTMGJ3L2QkWkibe27GFe0KHdywxumagj7FVArah15LSNLBJwOsTHF
   l4BcmTn2lUjsnij/qY37ThiwGQir6CUpWOGbct4wFNTHfOsI6+tRf54c3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="365945091"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="365945091"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="754502419"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="754502419"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2023 08:51:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 08:51:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 08:51:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 08:51:39 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 08:51:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEheEje+mbUYy5SaxShNb3n5JMfk1flnw6tQdTeOUWPHr5JFGpqQ648Y5P9/rGHxo/Ks9lTMA74fhiJU8lQUjdERV8IdL90P8ZmKPOgCrQrkM5ylcmcLZFDDMYnsQSfx9P9GDqfjKIZfnhETmRI/y1hUZbIg1fy7CO28s1PexfsW2g2eXD/IjioSXIFKrhPdCpyQLKccIbExRtQIZOAY+XCjEBkxeBuWa+zJHrJT0s2rKAaEl+9pc/9gJvCQZhozFN+uUIuM9MPE5JnSximeJBsHSP5xkXjaZbkoJvEkoDfFhy2qKmL6+IPRMjbVcNFUTsUnJGB2dYzvBR5OPWu6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfA4NTHRzi5tqzcutZFAH4mejHQ3RwY9P2NQOPTUsBw=;
 b=SHLemqg+o+LjYJBuvGRV2t/WJ97+O9mBF2aDOlgvUqp9ADAhW3ZK+iYrqTVsokHlaMmTWkJ6+NJ+Qm37YAb7A2yjWpUa3CDVNAWKb4mWnKtYHs4uDGvjBpmj1vm5PYYhszD/BV9GYYdPSMCUFMJybL4iWTsdW2/RxXHD7iDnSLcMKl8BrTmm5GP7h5IsvYNtDnV+AmGYTZGDf7uDl4aCj745q7PYxvt+/tEBKib20Vz65erUtl567bKYip4T27Ctaoog0sENXZjiMNtAWSz04xy/GjMw2i8oViyGIBAXuIhkvalrmf72wJLOBYd+pHRn7BHTwXH0+Kwpuw7oQ16RxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 PH0PR11MB5783.namprd11.prod.outlook.com (2603:10b6:510:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 15:51:36 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::542d:f32a:14b:1531%3]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 15:51:36 +0000
From:   "Ng, Boon Khai" <boon.khai.ng@intel.com>
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
CC:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tham, Mun Yew" <mun.yew.tham@intel.com>,
        "Swee, Leong Ching" <leong.ching.swee@intel.com>,
        "G Thomas, Rohan" <rohan.g.thomas@intel.com>
Subject: RE: [Enable Designware XGMAC VLAN Stripping Feature 1/2] dt-bindings:
 net: snps,dwmac: Add description for rx-vlan-offload
Thread-Topic: [Enable Designware XGMAC VLAN Stripping Feature 1/2]
 dt-bindings: net: snps,dwmac: Add description for rx-vlan-offload
Thread-Index: AQHZu5xgG1a+wZGOqU+EmB1OiRdona/EAemAgABXzQCAAAS/gIAAAF2w
Date:   Fri, 21 Jul 2023 15:51:36 +0000
Message-ID: <DM8PR11MB575174D30E383667BCD4F3F1C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
 <20230721062617.9810-2-boon.khai.ng@intel.com>
 <ZLpbPxy4XHEGyU6I@smile.fi.intel.com>
 <DM8PR11MB5751E1290649A690A0B50F7AC13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <ZLqo4SL+OAovs2In@smile.fi.intel.com>
In-Reply-To: <ZLqo4SL+OAovs2In@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|PH0PR11MB5783:EE_
x-ms-office365-filtering-correlation-id: 91aa0bc9-cdec-42d2-8f79-08db8a025d76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dJ1PUDWfiQpcCWWpcHLX/VtmSvp9OjFSgS/IaFJdXl3Jvo9sJEHp2DSTEoWwxiOWG0JCJAoS+OP55ur/R9iOdgL8Uiz3sdzsfWzU8j5/ne/FbVbj9BJZXnZ6eRmz5h3vliBVhEDK3xW7lXMB9aTPtVXEDEOrLuFg08rWkaz2Ohkd1ryWnFOGrh4PPRxF+997KJ40QMI4H6BWXsuaslde3rbpLoyS9LSvpbnLNdeVThLuva7TsWNB/4FC8coPyV2Rx99mBJHYN84GNCumXpOGzHKjzRTNT3faiA/+4tzth20j8V/2Qq6Uc5OLvTAp1Qvix5DTOtCwVrq5jvnaeIkv+OfY8CP+CpV6Ufm8moqZg70EwYoadBO3bc6Jt0KyevVRkRRLfpF6HHPcFVi4d2xxck4Lcvz+1Vp8uu0GgMrVVSLmfkb/yGNU0o8WeWkwTSkudNHAPQU/FA8RD8TV7IgHMcku4GxGVOsILQswzZm+drlKpievg0k7DQru2lGWw2BVTT8lYaBoIDDGsuAAtsRUQ0XtbZZJN9DUF4eZvLxTk33+jni7slFPnvvNvGYWG1yKquDQl7p1pWMiUB90Sxj8NMxuE6AvjId9hD+TobSoc8G7PQZxAdy8FE0aDlecpYWeF7MkkvK1L2idF0J3JP4VgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(122000001)(55016003)(6506007)(53546011)(26005)(186003)(107886003)(2906002)(64756008)(66476007)(66556008)(66446008)(4326008)(6636002)(316002)(76116006)(33656002)(8676002)(66946007)(52536014)(8936002)(6862004)(7416002)(5660300002)(41300700001)(9686003)(7696005)(71200400001)(54906003)(478600001)(83380400001)(86362001)(38100700002)(82960400001)(38070700005)(168613001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?epvCdvgfDB2POCmXhFiUR/mBtHUlEHz9Z4VHA4MUfpWYrLaDMtDyALB5mERt?=
 =?us-ascii?Q?fBuQ4uIKzI2X403jooX1hBexAdaj63TPQIxXmfnjnFCMDktldd0No1LusZtN?=
 =?us-ascii?Q?S3Ft61bw3qKfbn7Kg2OfeBRVV4Y1kqYeyD/YrMyALk9UkD7VUTaGDV43SfVv?=
 =?us-ascii?Q?hXvxSo9d5xqbwdjebgBbOzTXDk1NApuevayuQgen/yDVqGfhNd0UT7gKFcYi?=
 =?us-ascii?Q?xa05q/3CrAZqHpa+TZ4pH6lD+eqYn5MSWpmhKxN9REBgRSqNdcZHKYdvKXNv?=
 =?us-ascii?Q?ayDxfFt0YZzzCeupNqBDX/oQVzbCVnc9b30wnFKlYYGTiz6/Uy4L9+anGH6Y?=
 =?us-ascii?Q?GXtI8LTKw3T4rcXGWRgAoMTPB94OLz6M3/WwmvOq2I+qbL316YO9bcdHukxl?=
 =?us-ascii?Q?oB5eh/MwQ6SWbAG1/FLVwiNhfB7RCOBITiK/rGZhaZp6IxN8aazWCUFlQdAs?=
 =?us-ascii?Q?J0ZO77EUAxj9vvI4+2/Cqc06ZpVm9ag//gYuslTyqAIroulakhykdWcVeq/I?=
 =?us-ascii?Q?ciBZbyRdwvVL5QLHQb7FwARN0Ll8mxTwjxaRRU8MRVEhBO8MJLMcDwxir1Mr?=
 =?us-ascii?Q?qxvJF+tnz5ioGk7M1V0p8iaV5buJO/jfFki69HJ64FT4liU9kDCezqELBPpV?=
 =?us-ascii?Q?9JiqqYUc4jyHN4xjfv/6BCf5ZttBbdlnAHn+Tu+6+YAq6VVgQIpKLrYATYl8?=
 =?us-ascii?Q?fSwjxxr4Fr/uoLTxsAKregpCGTNIEFLnNUSpNCoL5r5rxjXqNGG7fg6XbsXU?=
 =?us-ascii?Q?XroI8VYQPOadtrFFg55wz4uOjYqYG4OdZqsLRDf01ERefIpASn8qQMUuBYOC?=
 =?us-ascii?Q?X5p4R3pbGWX2ncxRROS2kvZAB1BxQ9t4ORrWtbwGrxmLU3MconkAeTUqa52H?=
 =?us-ascii?Q?GZ1Rw6jF7/XEvWY5o4clLiC/0afMLdvvXmzU1cICiuvC8CGu6H+DL8hWEjyv?=
 =?us-ascii?Q?/XI6WCuuZR761qJVHpU2yAfIa914tVgAfBgwrhOfQ3Bnq52dhNbva1Ga5o+x?=
 =?us-ascii?Q?IcKsg70pwoHToVDyfh7340DJnvZRlZ9R4AfiBGUQnttOib3/J26y09cPwev6?=
 =?us-ascii?Q?hrhDbN6OQw1EdKZ13oSWJWqzPW6XUgSlCeOq04qEkpWBpeuvdzLyrnRoeRXy?=
 =?us-ascii?Q?SMtj0+dDY9SoNdLCnIGz54RiQrlhsqYjjpoeNc8hJouppUsZXYRJKSOtVz91?=
 =?us-ascii?Q?Znl6ZS/JvvEGNlgSOTWBFjqMzsAcjZS6FyC1uQV6T3uQncm3O02k8oFPMkOh?=
 =?us-ascii?Q?GgcRoOLcY6RvtS/ejKjT48xigk9wffTkMi+0BPcdv+pQzScQNNsDVyx5iOjl?=
 =?us-ascii?Q?xAZD+cPo8uSaNGsBU/iGc55kJiU6mDAa+t48HwWz2uFL05w0Xwpq78Gp98cu?=
 =?us-ascii?Q?JT43hSgU2AN4+Ui3QDLjRDp5nq0oKTFqiGFzjJcSvfkJAY1wqh1BYYioE1pI?=
 =?us-ascii?Q?/IpICoxyUNiAy2gXbW6SahAI9LWlR6pxiYntuSjC8EY4JQct5hCC8x2nt2Gl?=
 =?us-ascii?Q?AAfkl9donHWduabc4TlGBGvm55WlTdUzQWT30rU1z0OzmZnutX87VnQw4b7E?=
 =?us-ascii?Q?6hGZQAe35O0HqEGt0gqXwqHFdbHyUy6ru0lz6WTV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91aa0bc9-cdec-42d2-8f79-08db8a025d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 15:51:36.5591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h+Sj5Obf71gKV/kzJRI/EzWQwO1EdYa7HlQfV6biT5JzgSifo+K9Bc51CgRrjJocltgSAZrDfjjS6b+A+efYaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5783
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Shevchenko, Andriy <andriy.shevchenko@intel.com>
> Sent: Friday, July 21, 2023 11:49 PM
> To: Ng, Boon Khai <boon.khai.ng@intel.com>
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> netdev@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Tham,
> Mun Yew <mun.yew.tham@intel.com>; Swee, Leong Ching
> <leong.ching.swee@intel.com>; G Thomas, Rohan
> <rohan.g.thomas@intel.com>
> Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2] dt-
> bindings: net: snps,dwmac: Add description for rx-vlan-offload
>=20
> On Fri, Jul 21, 2023 at 06:35:44PM +0300, Ng, Boon Khai wrote:
> > > From: Shevchenko, Andriy <andriy.shevchenko@intel.com>
> > > Sent: Friday, July 21, 2023 6:18 PM
> > > On Fri, Jul 21, 2023 at 02:26:16PM +0800, Boon@ecsmtp.png.intel.com
> wrote:
> > > > From: Boon Khai Ng <boon.khai.ng@intel.com>
>=20
> ...
>=20
> > > > Reviewed-by: Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
> > >
> > > This is wrong:
> > > - I never reviewed DT bindings in all your series.
> > > - My name for the patches is also wrong.
> > >
> > > P.S. What I mentioned in the internal mail is that you can add my tag=
 to
> > >     the code, and not to the DT. Sorry, I probably hadn't been clear.
> >
> > My bad, sorry for interpreting the meaning wrongly, I will remove all
> > the "Reviewed-by" stamp from all the DT patches on the next update.
> >
> > However I copied the Reviewed-by: from the previous email, your name
> > Shouldn't be wrong.
>=20
> Oh, this is a bit messy. The address for the kernel work should be Andy
> Shevchenko <andriy.shevchenko@linux.intel.com>
>=20

Ah okay, got it. Will update that in the next patch.

> --
> With Best Regards,
> Andy Shevchenko
>=20

