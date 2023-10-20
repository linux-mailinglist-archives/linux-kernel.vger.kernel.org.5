Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFDB7D1443
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377905AbjJTQmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjJTQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:42:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5FBD65;
        Fri, 20 Oct 2023 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697820121; x=1729356121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4w4DmqN1WGuD8eXXXXPogRmfT5CxLEvLwcVpGJdolM4=;
  b=i8B56Js5Z6PovXNgHjYe+y9ZJhD09FzVip3Yow/VI0YxHY28Izz6wwWd
   Lf/sE7ME6J4vPwJTHFhZpIoiAl9n1PEG/nxYFK2nGk4GzzCpGggwdiMrj
   wEhho2nyCkSckFbHEm6X136KxXJg8KnZjx0+Zk4uRxryQNqzP0hSxFlVz
   9XnzKoOuyHc1ODAS6xFTqsecg6tUGeOpcyOjOxfR9k8s2RhPtZZseewBX
   fHA+X1hgLHpnqoh3TvUYYbFVxh+g7xXbN/NHyjMOw13VycubppOn4I9st
   PGyn+MT2Wx21ANDp5/lgQB9OMTvA6XnJ+eQ7wKV+C5I21H+exuJjRUitA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="385419000"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="385419000"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 09:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="5154919"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 09:40:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 09:41:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 09:41:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 09:41:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 09:41:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3i7IZyLHx0WdTjZMl27uCTvVnEkaepCzPyjexBYAtZSXRVaVtt7RlZ4/JuRef/ZAephvwIhsivhic1gcbp5xy6j0dk7iV69t3mW/vzq8sw/luVJq3vZ4VwM7Ewn5mMjLI4276qCikEFypXNZ6evoFToOVxzjKl20EIldjMjfWd3RDTrvRbfXRg6W/DcX2S91S5E3ATuNUYRUUDbayl3yVWz4Dj5Zz9XfJj6ZFuAqJCvUP/7PkQ5L/NwcL7zpoY1jO5b6FfYblTKoN8oMyIiEMqQW/gIV+IBZt+DhpD7+rRs5EDPwBagwuuQz07V4h9SVYw+ibZsYld7IZN8ongjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWbekPMqjuJf8+zhjfr9u67YYsD9+Ze+duKuT0E0IvU=;
 b=O2F23Q3oRgU1lUxDVWCZBgSmSxypn67FQZG+ejZfUGagvPKW8/Z203ifhasN1PQbXK//nU/gC9/o6Pfs52GHEFo4aXAqrgo1hw3l1vqIzlp/LTNoaFroC2vgFuUpStRw4EC5VVa/+GsFcbZ83XQR0YrPqgqxGfLfVCxY4VW9vetuvEvvykF7oor9T+OnCo/UooT946wdr8uHVqbxwrfS9/1EZU5C1K0CoLuI5LEIWon3NjrAD7IC514nc93Rh+JMT/tDhgs+UP07HWGyzhyZuucUNxutywHFufdvlhg9xz9d950OoGy8H5zBo40lOnfJSA5g8HcZCHvJ0O9dX45dLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SA1PR11MB6710.namprd11.prod.outlook.com (2603:10b6:806:25a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 16:41:56 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6886.039; Fri, 20 Oct 2023
 16:41:56 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Catherine Sullivan <catherine.sullivan@intel.com>,
        "Singhai, Anjali" <anjali.singhai@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net] i40e: Fix wrong check for
 I40E_TXR_FLAGS_WB_ON_ITR
Thread-Topic: [Intel-wired-lan] [PATCH net] i40e: Fix wrong check for
 I40E_TXR_FLAGS_WB_ON_ITR
Thread-Index: AQHaApPHpmigQRrPXUGFUsGg1YZwsrBS4yTg
Date:   Fri, 20 Oct 2023 16:41:56 +0000
Message-ID: <BL0PR11MB31225831A8067308582AAC79BDDBA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231019135342.1209152-1-ivecera@redhat.com>
In-Reply-To: <20231019135342.1209152-1-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SA1PR11MB6710:EE_
x-ms-office365-filtering-correlation-id: d7d9ac45-541a-4a67-1a6b-08dbd18b7904
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XzEsM4Ak9UpDNksZbil4qJdJ4ZGh1MTo6IKG8MrOPp3T3Cyg2SJtDIpgOnPH3teMd+IVYrKbayZK2hwIe/xed9yG0kgtQGEiz7iiRE5yl5X7o3UIvD5q4VN4w1B3PFtn3Y05HBV3jR6LMF8j1c57rRCOmbnh5GX+Ft5sDasWN3sFmzqx770R5vUliMCwjubzYcnUBC8f9Fj4fsID6IegiYnQ8m8pvCR2+N3nCiCpFgJ1LqyT+QqumSjmk3pjHSCAfEthYtYv4yCF03ybAqVraoF35h5K1+nHGdb2E2FSkqWZKJ8AKudjti6lejNnOddv1bcM+dtzO2yyzCp+I7lG5CQKpJUC6ErAa/TCVVTXTZ/Et2w8PbJvrdwCT/VOxWTAF65msF4mBRj+AM+9dsPX08rbq5O1BjTdoYzDaYun7kqouR3Qqa3y1JbhGhLmCvpfcKV2Fr0sU/SB64gki/+q0+09b3G3Z5Gmea6FRjYQNHeTOAH/gGtNSoOpk+d2GDQbP0iPlQPSNJ2at9799o2Hzxp5FW98bfI70Flz1GSCEfQwZibnAehRXnR7/5kT0O3QIiLyRgAxpDuC2nfxN4yM2ceF94kP7Gjz9H4LQpM4bGHPzIbOSxhGBL+umQOQWIV3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38070700009)(478600001)(110136005)(52536014)(6506007)(53546011)(7696005)(9686003)(316002)(5660300002)(64756008)(66556008)(54906003)(66446008)(66946007)(76116006)(66476007)(55016003)(71200400001)(83380400001)(122000001)(82960400001)(26005)(2906002)(4744005)(33656002)(41300700001)(4326008)(38100700002)(86362001)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Avcfgtq+q4FOg7M3sHlbV4zA5Tr3AByqh6GMwCI5Q3WWoPdL5UTUxe9MWZJ?=
 =?us-ascii?Q?0ydLxuUYesEXyJuQaQ3Huny/vC/B1/4v7+1mDwuStAfZgfGAfM4wgJU2jSXa?=
 =?us-ascii?Q?vH/axCC3Lx+VIM/f6KdcRbhwTlKhZb89B38Yc2CWQhT7grlQ6ck9bTCHOACE?=
 =?us-ascii?Q?xSOrsvPblymPtu/22mdwRJihZuURm8Ukb5Q3H4aQ3uVU7OgVQMHhH9ioGRfr?=
 =?us-ascii?Q?F95lgk8Ca2U+rB5z+zrPV4VyWSMLB+S2bhmnDgMyPWi8Ep+beXzpofanDED3?=
 =?us-ascii?Q?hUlkuQzUuRP7o6XYHlSLGDxvKx81Xor3iFlKYYYPi2fnaS/8lgC2iuMW58lO?=
 =?us-ascii?Q?KNJ7ex8F17pxleOi3MQENbM8gSuBdu3EexVFQ8eYzvqimtx5Iap6BdFrsXXF?=
 =?us-ascii?Q?wvW+/KTwsVZnB0cX2W3tRfAnV22ITVvvToE2ysPcdJ4iCh6ThmRuQHVJoEhx?=
 =?us-ascii?Q?jnrCeuJfm9lra2vYAn5MOY4e7M+tafcWInM1qrX0AnEDLoivRNFEJW6iR94n?=
 =?us-ascii?Q?XvlJesha8C+E+u+j1RvgaLiM/2Z/hfO7/x9HAWJtkmJKawJe7QWclhryrX5L?=
 =?us-ascii?Q?uCVJbDckNqJhiDcYBHq75/AT2TfFZPt1O4jDYN0CCO5vB24cP2CbSzCgBsKx?=
 =?us-ascii?Q?RF7jxX8gbXbe4PlHMGFzUoqS0gr+SYM3HDoKWz8BDUfNYX+kaLix4i6kc9Nz?=
 =?us-ascii?Q?tpyBqghWppq2OWYBizyEgPTAHDIMbut476fQrgZzSvNjA5xYtWtfHNu35Qf9?=
 =?us-ascii?Q?oH41mWT2KIHNU0ymYTjUH5zYfZ029CUuzxGfkgec4wJY/FEqLMpyjpCIi15y?=
 =?us-ascii?Q?Z0RJuP7COQx+ImTYL+9iUbI1yskICR9Wz2uIQYF8Zr9ycnsaJGbildfUFyAk?=
 =?us-ascii?Q?8aZ0ipk+tnIZ+fd6Ib7DxLGf1VJBzNIaUqA5GbAZdMe4PuuQjOQOY7UXK8/R?=
 =?us-ascii?Q?3E6dQZbt5mLvMQKMz+pH8qTBhinMgf9WT21VePKjLGLrMOjWc0xgZClAQrqY?=
 =?us-ascii?Q?KUci+Ua4NO2UTCkLH7SammFuA9l4+Yj+/O8kAn3AeOFuCRSFgnPEAwUWRbGR?=
 =?us-ascii?Q?EdivCIVhI5+FTuBWcobtMrEQ8PH1teOtDSxqmXu8X19bPrmgEuwxicXi1k3Y?=
 =?us-ascii?Q?e6expbGrUxi5oQJx9LUbhqosG7LULO1VJsT7A9h9FCPLxAHWxKnCdSa//RiO?=
 =?us-ascii?Q?h/09SWGp4yEfsJN2nUdLP94Plp6vrZsPoemZu1pTU+FIjI0by+urirsEBmAq?=
 =?us-ascii?Q?mvEvcyQ2TjMc2VFKpomu6nVZLkLpi3tbiEyTeA4z/gd+Ah/zBouPfKz7leBZ?=
 =?us-ascii?Q?qraC6hMI4YG/wlwzLOC0fDhrHEvcaoTuRXHQP28EwOD6eMiOJ1LIgKKfkYkR?=
 =?us-ascii?Q?dRjPv4wehMMh35qrZJhuMOtOPBtAmv2FlSFizNfagtH82F1aINMeiEVbSNhc?=
 =?us-ascii?Q?87TQ+5wuwrW87IUj+TkgCWs5g1EnBvAawEvTY3/MHR49DLPw5VpLlFUzMt1w?=
 =?us-ascii?Q?NKsMidCvMt8VQiDujtlyupMZMJ+1+NhquuhJRiPEtBTC6b4S2rgtIAPWtiDX?=
 =?us-ascii?Q?3MXYT6vzK9Sp9gWPl++lutmNLWgZFKURR/pX0eKUGyN/yTJYb4dIq/20Pb2Y?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d9ac45-541a-4a67-1a6b-08dbd18b7904
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 16:41:56.3637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLyhupEikD96PRAU3I6b+mCicuz9EkN0kT8Sw9sb1m4P5cbFbJmZlrXj7CUBQRT81FdWKgkftiD+LNzJKQfWSn+YXAnZLzOBiDvxWFxNOGsgglDvuASawba8+Qf1UBCg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6710
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

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Thursday, October 19, 2023 7:24 PM
> To: netdev@vger.kernel.org
> Cc: Catherine Sullivan <catherine.sullivan@intel.com>; Singhai, Anjali <a=
njali.singhai@intel.com>; Brandeburg, Jesse <jesse.brandeburg@intel.com>; o=
pen list <linux-kernel@vger.kernel.org>; Eric Dumazet <edumazet@google.com>=
; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Jeff Kirsher <jeffrey.t.k=
irsher@intel.com>; moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@l=
ists.osuosl.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@red=
hat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH net] i40e: Fix wrong check for I40E_TXR=
_FLAGS_WB_ON_ITR
>
> The I40E_TXR_FLAGS_WB_ON_ITR is i40e_ring flag and not i40e_pf one.
>
> Fixes: 8e0764b4d6be42 ("i40e/i40evf: Add support for writeback on ITR fea=
ture for X722")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

