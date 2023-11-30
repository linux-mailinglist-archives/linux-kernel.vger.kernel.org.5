Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CC07FE89C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjK3FXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344496AbjK3FXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:23:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F63BC;
        Wed, 29 Nov 2023 21:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701321794; x=1732857794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PUZ00spTewTS5lawZpzKaCBvMwTxQBXn9Ql51ayyJLo=;
  b=QkoU04EblV8tCwqls6fmJTcNdiDhkM/lUyxub3B6kHVVPaEoo7EyMREf
   Iq/stVitAYo+xZfcJDh8XL24DZ32i+3w/a3oGq+Xi/djI1/hFxgFvY0np
   eUN2H5qW7NzSoHSG7VM83ySuFbeL4BdMu4yf1uBMgzBQKvi6hJpSEtII4
   O6UkyQCKUb5Q2nGmSxlmOC4Y0J69GS3ALtDFvLvBSxXmxcMB/GVApmiee
   1Gvg4L7hGOZVDH1F77QCIM15X38D1FBqyfaIPsGvMGzoM/u5sht2AgTdH
   iqwhsmS9q7y5WwwjkrNMpRCq6FrfsmUvun//4LK2RAJcH8t/K3RkIgOIt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="390429506"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="390429506"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 21:23:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="772936757"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="772936757"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 21:23:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 21:23:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 21:23:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 21:23:13 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 21:23:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHwwb7Ca/FD3mUbDhfUq38fPcVscTypbQfyWEu58ODf7Bo1cHdCcnCfemEWi+ulaQKE7xyOvL5U2D9ymuFXsWzOrZZRUeromo7P/RccNA61MCeAAIA16XjA47jKpgqs0IbM8hXaaGIP+V3gU84VRfW9FulwglP3UbQ1ry3XtQkzdfPzjoC8MnHdKzdOeg2/NszLom8wRwJ571ATMvXamhZvUnUBY1PTEktCPsahx9LnaQXmR6yeeWc2DtRFvQ+Zfe8TIUAkOiXdg5939eqRkPSpa66aOywgdPoQAz5rc7pgEpJUny953McVjgDD6kuurk2oDlYBy0Y1Z1a2ftaUcdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBdDvVDqITGxtg7rgf4YHLSJoIcFljumjxMkcPJAdTQ=;
 b=a2k/lGGEEykesv9zFxnraMmJXhP2W467dYqmN0u3TSDY3XHAsYBTT5d51nG8F5LeurodX2Gl94CyomyX1GTGpyMPRrw56BzoEYcD+USJadsLwL0eIyNURUlowd65jZQ2/CaDZOW4PuquMnTOKh4feUVTXwcKz9vL1lWjuTPrHn0tByoK9B9nB30OYTpWCV+DWPffNj0b/S4wTlyvyEPhoAPidGfnW2oKgUgcAzwdudAiqPCAm2OF1MUIwVuzPrvLHuahZOXR+pkXKEK+ynn1GBOsMXnRrW9c97HadsAwOWagvajVdUQe3hfZe42WoiKR1LRT8ww9OhcuReOiwYQP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by DS7PR11MB6198.namprd11.prod.outlook.com (2603:10b6:8:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 05:23:09 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f%4]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 05:23:09 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC:     "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Simon Horman <horms@kernel.org>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH v5 3/5] i40e: Add helpers to find VSI
 and VEB by SEID and use them
Thread-Topic: [Intel-wired-lan] [PATCH v5 3/5] i40e: Add helpers to find VSI
 and VEB by SEID and use them
Thread-Index: AQHaHueZIXDan26oM0GJQd1ShUCnwLCSWAEw
Date:   Thu, 30 Nov 2023 05:23:09 +0000
Message-ID: <BL0PR11MB3122416C6364DCDA0BAD8E06BD82A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231124150343.81520-1-ivecera@redhat.com>
 <20231124150343.81520-4-ivecera@redhat.com>
In-Reply-To: <20231124150343.81520-4-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|DS7PR11MB6198:EE_
x-ms-office365-filtering-correlation-id: c1d9e33b-11af-4849-934a-08dbf1647101
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4o4peMbDrNCJoNpDHXChCTsuFwfqEIZlCD+NWg0Yof5QS+YTMGoQ6lBd+dfUA6OOPyx1piz/GToV9mTHrgCOIUfBzYt5li0JjpyhSawVGcEQruvD7YrvGrhyTAPNRjKTPgDyarAbr0Lk6iMGSMZ7Yv4phJbuMO3+VA4FfOViRXIdltmsOYtKQCR1z2AAgeohYCMOvFOx2Bf4uDJ4Ty82TMn2h559QV2DddCw7LWrnF0elisCjeRStuvB2LXx9o6tcgqLvB6pNEABTX/eXitdPIOEikjXihetElo7ZVRRDpoSV8+vQBkKtfMqoaJIq523d5Gk4lUz36l96C4SJ59kvICmrrI51+VsESQOQsfsOc8MYyvPbgPmYcVTxtUrZX4Ew8wS/9j5edQ+2gK8EFKIaKdgPzNeZsREMrvbjHrpYr0nNpaiYEVvWJTgb8EqnEZZpE2GOx+nxtW/jL3VLJZ2kALlhILEqZA2VNWTa0Q3nDzYDGV+iK9GOmC3Rq5ad4gup8HdqjvSQSlJlqthhQLHXmP+aB2vvlas/+4ARVy4IUWTHNiy230o9cpNqdOeWfb95ADX7SB4jW0kF7X9majTsUl2YqWvwVEIUktCChGU9hxv4rVMOiNEiGwRK6vXq10bNoSkhgKNGYTYacQX9QfS7Groa4o/LJ+soKSJLOF6K5Tar/p0pRLeDZEC34fbHno
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(478600001)(71200400001)(9686003)(26005)(53546011)(2906002)(5660300002)(41300700001)(83380400001)(7696005)(110136005)(8676002)(8936002)(66946007)(52536014)(66446008)(66476007)(66556008)(6506007)(76116006)(54906003)(316002)(64756008)(4326008)(82960400001)(122000001)(86362001)(33656002)(38100700002)(202311291699003)(38070700009)(55016003)(37363002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ldkc+wL3gu7pJjSHDQDv/eJtWVXPg4iSdeS8FAtcD5/hO+NUvlVGB8eae6gW?=
 =?us-ascii?Q?bro6YnieIuiUSOiV91g/zTt0ElGmdbc/ByplmWAQ0KrQZIOJ4BGdhtiFTT3X?=
 =?us-ascii?Q?pOSHqvC/MtuAb/gO8vP9mpcjs+gsIpG6cgMGEYyXDH/6tB9kwar7mai5+Bvb?=
 =?us-ascii?Q?ZYawgKBAyMrqjr6/3aeejL4wr5OfRJhOWNnN6xSMh+421/C2XCFr0eJqOLM0?=
 =?us-ascii?Q?7TNXlvDnGb+VVuJCd53EynkAOfkVVAqnbyF0W2ky85wSYjGK36pST30cnlVH?=
 =?us-ascii?Q?gS0q/Kv2NN5we/yD1Eytr9K7RkjZ09w0rd4f0wV4OeHQv3YT6DOjsReTXihF?=
 =?us-ascii?Q?9k80mWnUM9del5GJf5dhzElxxqHjumYDEzenRtaNEKrwA9YMuEhoYr6KSXOg?=
 =?us-ascii?Q?BKgqSEHdft05s4sXb6/Z/AItdxQdQ2Fkea722HOryl0He15u9K4ufo3wM3qF?=
 =?us-ascii?Q?iGxpVK2A/VFlt4gFUOoOrDVnRVGzdxYaUBL7b3V05yW6MJ4zUc+ZkN1q8sdA?=
 =?us-ascii?Q?XYuEFquIXTBaYzjKX2LNKRqsBAw161ml15Mu2ED2CE11X7hPLOt5STMZDtCJ?=
 =?us-ascii?Q?0fbnJ624hfGKB+xmk/pIxx+HdF0Jtc9bFa/XRYCpMNsZ12bNpHLM9SLEEzOG?=
 =?us-ascii?Q?JjSKDsxEoU/jWkMKzuwveyJPWu1C03vXha1dvM+OeLhPix3fGKblEJtnEG9y?=
 =?us-ascii?Q?fd1flq8YldLWbO3e3sHUvu2fqMkP2vvUrsZYTYI8PHREXNPTkjYMjUd4tY3S?=
 =?us-ascii?Q?5woJvGK/didgJqQBjFlAIFwcVC+QZSN+oiiA+tfprbhQ2fSPMM9f5cQoLPnc?=
 =?us-ascii?Q?u3IwTIEPQCExEi8TfXupCnTYTDPAxXiSbcE5vXnG7GNDjIA6wNO3/V7flUIq?=
 =?us-ascii?Q?yeae1X6lCFqRD/MpxTu1TjTfvhYX5vzD+dh/0kjclHd/fl/ipthvVykInRt8?=
 =?us-ascii?Q?m6iJyboq1o+YzNEQRtrcrzpBZjQviTz9o7Bm5biV5jKTuLx460Kw/5L8yV7I?=
 =?us-ascii?Q?g4HJe3H2um9uoY2zhwAmUXNQ1NjfrHigKlaKMuYnSbLnO9bLBEhZy2sPa3N5?=
 =?us-ascii?Q?Y0qyhxFBn/CSPviknU99X2c9Jnb1cOYWU8y1cew3R/MuiTQm512Q8B67vSV1?=
 =?us-ascii?Q?vphQQy8A6BrBU+eeDuN0SR9/aLpJTWCuhWi4x1IoRvaQcXzAXUXl8l76zSMq?=
 =?us-ascii?Q?+7DGqz8yYlMSXVRwUS5DR3iJD2ybWpwDR9t/YsNlqcDzx2l3Gl7ZZaQsrKSS?=
 =?us-ascii?Q?9BitljDjnziQqPUQZhHS9et8AGF8EvXByYfPpR5J4LB/NHR3L2T9caJhvGJm?=
 =?us-ascii?Q?i/WAVJCspvYpISPwxortX8SoY5sGOCcn5Hc53qHgxLOwIyPE5GtoRK7g8voo?=
 =?us-ascii?Q?OVHRbEnoqBOzGkssynUeDJ1aC1V9lc9Q+cWL+RIPHcC7uvL1jbC+QyFFW1zb?=
 =?us-ascii?Q?JJBYxF6ftutV+6vkm6FmubBz1NP/31JDkANKgl13eKaFgCRmzGGGRIBfogKm?=
 =?us-ascii?Q?641JPF4Ayf5pPOC8sgaJN4UlI6/xVhpTDkLyRmRu1a5xTgtdW49F/FUuk0gM?=
 =?us-ascii?Q?LX8YCmjRUf0kfIkunDCgZkF3zh1/a2kx4UbxD+aMIpFOKqe3su5RFFwDV0UF?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d9e33b-11af-4849-934a-08dbf1647101
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 05:23:09.7807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/BmtKFXndDthRNRQBj8X/ONt4rHwRfRAy/ycehxIQ+8IjF3TFVYYAx7Ncx7RNev9XuJdvgGKMaCrqdUNnnc0er4Nt6txOPz33WmyjmVpcjxL/me8xa0ExE5/5vqpZ/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6198
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Friday, November 24, 2023 8:34 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; netdev@vger.kernel.org;=
 Brandeburg, Jesse <jesse.brandeburg@intel.com>; linux-kernel@vger.kernel.o=
rg; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <anthony.l.nguyen=
@intel.com>; Simon Horman <horms@kernel.org>; Keller, Jacob E <jacob.e.kell=
er@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat=
.com>; David S . Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH v5 3/5] i40e: Add helpers to find VSI a=
nd VEB by SEID and use them
>
> Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
> VEB or VSI by their SEID value and use these helpers to replace
> existing open-coded loops.
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        | 36 +++++++++
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    | 38 ++-------
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 80 +++++++------------
>  3 files changed, 68 insertions(+), 86 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

