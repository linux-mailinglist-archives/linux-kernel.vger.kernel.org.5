Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A0177E1E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245305AbjHPMtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245309AbjHPMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:48:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C2E1FDE;
        Wed, 16 Aug 2023 05:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692190121; x=1723726121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cA8BGxua304PV2yiRJUDeEBr1RQdpPccyntEfMOCfX0=;
  b=Gf6ENR4OcAPWeJ4U2/wx+rNqLy9c5XWP1NxKjgQ0G83V6jnOJVeuGiBu
   lWzL4mCfwqfOq4sMDU4oEZV6fKNgprYf/7900srxROdv/Q5CV+TuiUDLm
   k5nwrgJRdnCEsZSNHR7dydug7Zq2CK0fdQg3d05rihQ3S461l4+m0oewQ
   Ai51yKxPH8n9n8l6mxUmII9+08yeuisQ/a2B5PsWWz5x8IvtBluu1UVNL
   cp+J9m4sQMySsH++qd2gZWieDh5P+LqwdFnmujdJ5P2QRT8PZZgGhJApu
   Ik7gUlRiBJADG9AV6YlnluUtYQibDF701FQMsDNpoO3QvZtLCWJjaB7RS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458875471"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="458875471"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 05:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="857812191"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="857812191"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2023 05:48:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:48:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 05:48:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 05:48:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 05:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKwjBjRX/e8FzXFPTeJs2NtY06prDD6M5IjauY8whg1ldnQolyUI6WxMhIO4hM9jQW+9EKpx43evdDdJC0yGD2zo3Ex8AegRl0JiH183FVhTsQMFKZghDQDexucasfav2/YN9mTLvwRSVjlxrO/Gz6IPy6KDLQ/oqW7JVDmZOgpnn7nhvFPLZRAllzPVmbYA05kw2k19HxfvHZX2MnqGNzIpP7WNT1+NL+QUxkdKmdpLvt9kh5AubQ0+mrgLNcOn6O33F41CO+AOG63mYw6G408GzsKfvAU+E80wSgvGitJiAj1YPeCaIT/WXedkn24T9XzbwXRs3G01lfmY3URYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cA8BGxua304PV2yiRJUDeEBr1RQdpPccyntEfMOCfX0=;
 b=GjROLwiRO6sErGFLYu4i7SmY8x2D3RPLe7oMDg4VVB8CL+TBivyEONs9lnOfzYY9SGfwjk/ydBu8kuRpnDN+VM1SeRtNu1/c9yabEg5l1XDQyonHgqSa8yZesXModchZfgu1b03ym4MgrniyZ8ha+VSH97/lkqPQaOkdBPl9fWolJIDf4KcFvFASTNKamGH1wGq4KtPvw3R/euyg7JvYLJtqW9WMYKPEax7ivqAzhyJa0R6kwKkSwAKTxzJhjgkBKk6AFUKw27jri92G6uwcjOudHHzkEm5mN/FrUkyqEsvuR/r4HLTEsWtrRsFjBdEUWCcwl8OvzxPYLB38Yq3tHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by MN2PR11MB4760.namprd11.prod.outlook.com (2603:10b6:208:266::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 12:48:37 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a21:609b:312:5cac]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a21:609b:312:5cac%6]) with mapi id 15.20.6652.028; Wed, 16 Aug 2023
 12:48:37 +0000
From:   "Romanowski, Rafal" <rafal.romanowski@intel.com>
To:     "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
        Kees Cook <keescook@chromium.org>
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
Subject: RE: [Intel-wired-lan] [PATCH net-next 1/3] virtchnl: fix fake 1-elem
 arrays in structs allocated as `nents + 1` - 1
Thread-Topic: [Intel-wired-lan] [PATCH net-next 1/3] virtchnl: fix fake 1-elem
 arrays in structs allocated as `nents + 1` - 1
Thread-Index: AQHZwWvPNvMJy2JQakG3i582ytItx6/Z2AsAgAB5noCAAB4IAIAAAQyAgBKMUPA=
Date:   Wed, 16 Aug 2023 12:48:37 +0000
Message-ID: <BL0PR11MB3521F65964AA8F824211B8528F15A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
 <20230728155207.10042-2-aleksander.lobakin@intel.com>
 <202308040126.ADDA993@keescook>
 <49b0d7bd-2bc1-c994-7780-35554a399242@intel.com>
 <202308041029.74FF3CCD@keescook>
 <d89e76ab-4db8-9307-6c31-628df3b4fd94@intel.com>
In-Reply-To: <d89e76ab-4db8-9307-6c31-628df3b4fd94@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|MN2PR11MB4760:EE_
x-ms-office365-filtering-correlation-id: b060f4c9-64ae-4674-3f47-08db9e571beb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nitBjzObeP086P/wX382tBKFq0Ec/2zTKcxJ1ziqhMe+Cie/2QAUlDl7ixWAUTJB7TZwaG3Yov1d5qP5rsG8J64vJ2Ow6xjzADl9fVbbQ1kezIZWEFFwFmg4hShwpucV9EkeW6euptU5zmkg/SVGXW8aQQV/cpwtKDV9eXac2yOrQMNkM7aHKIp5y6986vAjh81eINWUb53X28UpuIhFAkUTWg2Uo+pOVSTGUYCdCLUxfk6HXe0KvRUmCw20ea9Ay6QN+MCONkqT8sjni/u8KOqPZTlO6UEZ+7fD2I32D4zg3blC9ZH3o7jm4mdkll8TB2oPYqbHzrYElMkwiLh2eaYnq+rbACjrK+SCkmg3nwBnSuFvU1v8mO3Z6SsrwKWrp/fRwRHbw+wCjAleZUjysVTMOe33jQVzlF36Gm10gqTprTdf9OZEslt7lnCA+S4QgEUN9FxEt3xOTRpXeRBCJ3v7rpF+gPVMUUIg2MlyBXDz70BRW3e/rcOg2NpC6hMv3p8Xde2VmPzpm7wCv6xAOcKkYiuJo9Y6PyZDxf86HFWDzasBLwxDRbSYhKK7CTjtI6uFVC5bQU88sMBhxtdrDJxMXDcn7GluCAv/zMuqkzhrpGPM9uQ00tYFssnFtXZYxcUuDzjX5dC3/LBggf8ATYEWRIIT5aq2Y2qUisOKcso=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(76116006)(66946007)(64756008)(110136005)(66476007)(66556008)(66446008)(122000001)(966005)(41300700001)(52536014)(5660300002)(66574015)(38070700005)(38100700002)(8676002)(4326008)(8936002)(82960400001)(2906002)(83380400001)(26005)(55016003)(478600001)(7416002)(86362001)(9686003)(53546011)(33656002)(7696005)(6506007)(71200400001)(81973001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?Y5sF7FzA5RVW7m2yIaO2Yn2bO5ztVAdDmHB62KIIl4hGmesAhVXzAPDyb+?=
 =?iso-8859-2?Q?RFatYwCfbEHieufCNnydfzFq7TNbitXm6aC6H6MbZfF5Dm4OxANE/CHq4t?=
 =?iso-8859-2?Q?FYTYz7hHhOARob0AZmdCfAga62bn9seyVvsPCNnHeffOXp+GWYcunWMZ6O?=
 =?iso-8859-2?Q?Xrqf4gwLj7i0J1c057h8+jFn/moMJM9WdPOgDz90ZyAyRrB2uMkkFJsNy3?=
 =?iso-8859-2?Q?q7BSrlzuOvwFKWIrCopmqwhk/ZR4Gby5rWsKBZ2xlzXaF0iWgsGM0ag9Ke?=
 =?iso-8859-2?Q?RPJdskZhGOakX0fKE6bYBhub1AV5WtASKsmKT6ZcRPVapidt3m7YYt02gn?=
 =?iso-8859-2?Q?aLEPXahAaCfc5e2BZTl7Jp2Fxcbqw0XmiMVKNX2+nCbw5IPZlLO1XnEQQ3?=
 =?iso-8859-2?Q?AVfEXmTmoY7ysy+bOeLQM2sJeZVyQB+eFQ9bqjWULIBQL8mOQEqzCd8k0f?=
 =?iso-8859-2?Q?mYnPqcO2KOyE/VgFVAVo6ZCxo+DHMjWU+K8NHW0Mp2mjlNc/HtrQG+Qmjb?=
 =?iso-8859-2?Q?4IZsW1f489ynt4VLgahAEcCtFOJPaKPUzCHL+j4HcrEu5cL5WfXcs33JDW?=
 =?iso-8859-2?Q?DGwzZyB/Cs+0eGJcYrWXXSnhUYMaKuWxbw4RhGJb4e+mqi97WTdPcFnGeB?=
 =?iso-8859-2?Q?e2cqw5CNXKtKSgcJ1HGRFQ2e2/K/HuaiWTE1BfBv0X/agLzVN5bv5jcJb0?=
 =?iso-8859-2?Q?rDv3zubrEMrqynyqPlYURWm8K1chTuSjhcKE5gGBusZVq4UDe6n7+8RowX?=
 =?iso-8859-2?Q?BxxkdvlbSTifmKBYJBzvGNDcww/jjKbWex811W72A0X2OmzFGbhIQjA1IB?=
 =?iso-8859-2?Q?cEX5KwbdTqyFG2bvEARj7oZC144a8D+2rDTpwv9FQ2uJxmWPmkMZhka1Rn?=
 =?iso-8859-2?Q?mAZbEDHV9IiuqF//n2nwZ/C9GsZKptjtOMiYnzJLOl5Ca8vb841xeuYhKH?=
 =?iso-8859-2?Q?GIuMp8OUXcE1uac2JBp5msB4FxlqYqT8eCNC1Icf8Mlg3Q9cIz5PxrIjve?=
 =?iso-8859-2?Q?dWqtl/wB04/078aSkkVoxNQ9ah7HzcRyGnEYKnOlninaQ9n2ZS21oFhOAw?=
 =?iso-8859-2?Q?nO7Z4oZUUOktnm5t6rkrXg8IfpjkIcDjx4zLC65hM6Vj2r4Shx8zQ4sP+0?=
 =?iso-8859-2?Q?Sem8vCmdkOs96ZsoX6WXGzq3DfthJbU+GA0m32UKxhUYdqPI5169BNYx30?=
 =?iso-8859-2?Q?Z+m+8/yHZrODT1oMJwtoySd3JASp9lUvYgDIagsJs3wTVwEIr0j/325XQz?=
 =?iso-8859-2?Q?B9CqCKkFjpnv8S9Z0uwY5Cx5XSVN74KkVquDbL2YDiHLN0Q0UfTALOLusT?=
 =?iso-8859-2?Q?Srsh5kOC6bLM2+GUkVYmdmnMMm0zUFCUzh3t9IqZltqCQBoWwuFULYXf6X?=
 =?iso-8859-2?Q?3MTC0McLMv9kZEHPsPMBZ7RxPkzLPTRLQyOoY9k2LmN9cUzbxL9U4UIGmf?=
 =?iso-8859-2?Q?PFkzq1x8pc+ouf1ya/XJOUd9be2zm1XQQcR8Pmu06adZQZUVLlPOo4FRcq?=
 =?iso-8859-2?Q?2XeDc0+n4ntY3LX+jWB+novUtTFwyH1kIpwMDsB5HKXRyA2VCO9p/2jWPp?=
 =?iso-8859-2?Q?ucNNojXP0uNvsrDaCOh1uC99HqAkye8LDMcPlTdzcxMq7BZv58g19Oxy9m?=
 =?iso-8859-2?Q?KIH8feW3OGuoxzS/wr0+2OYef3M+pcZsvTrRdbHbAuEvVnP4IKKDWDpA?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b060f4c9-64ae-4674-3f47-08db9e571beb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 12:48:37.0356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ki54/wuJY1B8065I/qoU8jtbYBA/qTZj47KbFmiVd3i93adyDeUDsu81LeeON2MLTfLYfQ2+6OTqaBrgfBNOBzpa1GEzVtzbsesJOCCAbTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4760
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Lobakin
> Sent: pi=B1tek, 4 sierpnia 2023 19:34
> To: Kees Cook <keescook@chromium.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Zaremba,
> Larysa <larysa.zaremba@intel.com>; netdev@vger.kernel.org; Gustavo A. R.
> Silva <gustavoars@kernel.org>; linux-kernel@vger.kernel.org; Eric Dumazet
> <edumazet@google.com>; intel-wired-lan@lists.osuosl.org; linux-
> hardening@vger.kernel.org; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: Re: [Intel-wired-lan] [PATCH net-next 1/3] virtchnl: fix fake 1-=
elem
> arrays in structs allocated as `nents + 1` - 1
>=20
> From: Kees Cook <keescook@chromium.org>
> Date: Fri, 4 Aug 2023 10:29:48 -0700
>=20
> > On Fri, Aug 04, 2023 at 05:42:19PM +0200, Alexander Lobakin wrote:
> >> From: Kees Cook <keescook@chromium.org>
> >> Date: Fri, 4 Aug 2023 01:27:02 -0700
> >>
> >>> On Fri, Jul 28, 2023 at 05:52:05PM +0200, Alexander Lobakin wrote:
> >>>> The two most problematic virtchnl structures are virtchnl_rss_key
> >>>> and virtchnl_rss_lut. Their "flex" arrays have the type of u8,
> >>>> thus, when allocating / checking, the actual size is calculated as
> >>>> `sizeof + nents - 1 byte`. But their sizeof() is not 1 byte larger
> >>>> than the size of such structure with proper flex array, it's two
> >>>> bytes larger due to the padding. That said, their size is always 1
> >>>> byte larger unless there are no tail elements -- then it's +2 bytes.
> >>>> Add virtchnl_struct_size() macro which will handle this case (and
> >>>> later other cases as well). Make its calling conv the same as we
> >>>> call
> >>>> struct_size() to allow it to be drop-in, even though it's unlikely
> >>>> to become possible to switch to generic API. The macro will
> >>>> calculate a proper size of a structure with a flex array at the
> >>>> end, so that it becomes transparent for the compilers, but add the
> >>>> difference from the old values, so that the real size of sorta-ABI-
> messages doesn't change.
> >>>> Use it on the allocation side in IAVF and the receiving side
> >>>> (defined as static inline in virtchnl.h) for the mentioned two struc=
tures.
> >>>>
> >>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >>>
> >>> This is a novel approach to solving the ABI issues for a 1-elem
> >>> conversion, but I have been convinced it's a workable approach here.
> >>> :) Thanks for doing this conversion!
> >>>
> >>> Reviewed-by: Kees Cook <keescook@chromium.org>
> >>>
> >>
> >> Thanks a lot!
> >> You gave Reviewed-by for patches #1 and #3, does it mean the whole
> >> series or something is wrong with the patch #2? :D
> >
> > Hm, maybe delivery was delayed? I see it on lore:
> > https://lore.kernel.org/all/202308040128.667940394B@keescook/
> >
>=20
> Nevermind, my mail rules did put it in the folder other than the one wher=
e
> the main thread was, sorry :s Much thanks, I'm now a fan of _Generic() to=
o
> :D
>=20
> Olek
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>


