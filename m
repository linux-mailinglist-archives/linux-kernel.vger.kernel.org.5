Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DE27DCAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343603AbjJaKXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjJaKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:23:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F709DE;
        Tue, 31 Oct 2023 03:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698747782; x=1730283782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H9zFVEI8p0zuTfe8FHV3+1kamecz6SoGtaFZrftgTiQ=;
  b=laaMk7GwZQxko8AmJR2s9k2ystMg1A2lE4FaEH6vZOoyTtpFz0vcT/pB
   q9pqQp/08+G5oOdVGBhvwJyuLftFke9yo+LRGbKZrt3yY+/4QvQqjt40g
   /dZEn7wmX87YILVW1+HqPNK4qkaJeQbWTrTEfyHiNyeUp494oWkaCWpCI
   HgToFdLMYZXOC7Ij8aVLFOVknQhYASu1f7ZS5ENVAKGdEkF+N6B8MNWev
   HSf/5FadAVUVTOv/7Tb2GFdX7Yl/afGamS549OpYDOqyU4uoe7YLMuKGD
   p/1MbmlUFJTL1EOAPdSBOnYy0vgGGDoz4/IpN2dD7i9BwMck3YJugDt98
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="388080242"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="388080242"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 03:23:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1805057"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 03:22:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 03:22:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 03:22:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 03:22:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 03:22:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRdJrtzuCM5mSead4lwoKh8K/o5Bnj0H/7ihpOat+M7WL0j8GFielCbDt9449aUrigPrnQCVUlFHhgSLbjHjeI+wEQvbXc3EbiDm8MMgIEgdx2tQRdpfOgeNgarlL+RYw7vAYdOuNYQzvcKHXaALZZf1Dh7aGlA2OePW2KRWg4QClPhj/F8awuc/V5Oe6LWGOzQqFMw1wZ/biUPJWyu0xWsySPyDnpCLtX+vfLvQkU+LMX8wOtiWDU0Wdsv5auyWRGdGQGsiCOd0AkMCpmkYsxWNOG+kpoiM0FD5KTjxXE0+oBLSWIaG+xAcq1D8OZOOh2kNtS3cbxIZyWJrhaQQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaHpICN7hR90rsMs3w9PFjYdmq5GcQsALrg0TyR7NWo=;
 b=Gb6rQ9QwKvd2XEPXbzFI6WpQzj+gr6nvTpwP32+YutxIfcv7PrI2gJFbwn5b0IFBQKS4oYigAfsmV7v3XH9CEMRLE08y7rvn1kvR4xcWakpUVsrMyR8SAdu1jyGbE5vFbHoNBACAZVkhat8JIdttJe1aGFtyqvRp6QI0r1aJE+Jf9dHNKaAP5TobvDmL4DWqaBf1wQsJUUbTiLkwMKMWwUKbWHSLqUzXs9okvmpZs9V4fPzyEWQhNt++jJLI8ZDIAJTGSvj8mOf5iYAPjo5LTk+9NC14NNKTYUhrdVYgBzMtWAoVPEbrdahn144okxSJjc73lNPs6bARUxYwkKLJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by CH0PR11MB8191.namprd11.prod.outlook.com (2603:10b6:610:181::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 10:22:56 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097%6]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 10:22:56 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Eric Dumazet <edumazet@google.com>,
        "dacampbe@redhat.com" <dacampbe@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 3/6] i40e: Use DECLARE_BITMAP
 for flags and hw_features fields in i40e_pf
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 3/6] i40e: Use DECLARE_BITMAP
 for flags and hw_features fields in i40e_pf
Thread-Index: AQHaA5P3bOgubmWSP0ePBzjqfldr77BjwIeg
Date:   Tue, 31 Oct 2023 10:22:56 +0000
Message-ID: <BL0PR11MB31228D74A9C538CDA9E2E8D3BDA0A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231020193746.2274379-1-ivecera@redhat.com>
 <20231020193746.2274379-3-ivecera@redhat.com>
In-Reply-To: <20231020193746.2274379-3-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|CH0PR11MB8191:EE_
x-ms-office365-filtering-correlation-id: 1c919050-185e-4917-dba8-08dbd9fb5963
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBJg1l1fQ+2uEoj1UApvYnklZR5EtSaMZzuvD/ugKWOZu7P/pkJT958bVMuXkpmwkZ5TNPqLVku1b0hdfJV7SMNf70v2nGTWfcs3Wcj7PedcuQkzEZ18bTr3bV/EZHvsqsr9uo+Yt/RLy6Aklk5xpRfeQETLAEJp9oQDKnbkN8WVM202EBxKs/G/kfvpRMgvGqsV76Xw/wqqZHmrkykL7iAjAu3XjQDoaY0iygWhBC0qYcW+hVsGLtDjXgPgbp+HCnVvk/t+Mod3rzRaeop6zhet02WETWHZYAeDz8CNUUC6kjvQR0gkjK1p3t22ZhLyb9KrtcGcJa10onJ8XYVqe+AAJWxxcoyz862MfrYjxwZG++BlpvX3Q9YUIXBQiTKz/6Caf9HBLnB45MzfwVXxtTE8d2hr+qlYZzv5U1a3IS2u7dnlRCalUjrZD2yZvH02p3KZfvrYTDilRI/BH/lvC0SdYluplwl0aZMI51t69PgffXr4iyPRFmB2P1+PiCeYU+FoI7qp4pCqICFW9+NNKt2b5kBFtw/PgSQD2C4S1jBdJf0DMNI5XnWb6vbM6+1EvRCW8NGbMsb5y82NiGF3YM7AxPXBxifwk+GiViu/p8fdvNfQIx7hyPVd6xiH4Nlk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(122000001)(5660300002)(4326008)(52536014)(82960400001)(26005)(83380400001)(33656002)(38070700009)(55016003)(71200400001)(8676002)(86362001)(38100700002)(2906002)(7416002)(41300700001)(64756008)(110136005)(54906003)(66446008)(66946007)(66556008)(66476007)(8936002)(316002)(76116006)(6506007)(7696005)(9686003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EQkAmR9QS7o7DkE6jJrGsplDeQcMYqwKuQmC9j1vDQKcCPZSSWqRsJ1isBkP?=
 =?us-ascii?Q?m9uzoDU0mLPfSwhj20+EmpYTDBkmDHfkxb/D4JHVD+I1RC6vTCGW+Lk/z2/P?=
 =?us-ascii?Q?8v7TEXoyj77NgOpnxmyqxyIou5zT5SBXLSL3J0qs3cnATk0mUreMl/yWTzwo?=
 =?us-ascii?Q?QWUngpcZN6IBCUvh1QTVNzFGrHJMhYy5Kq6rvBW+8Au+6W5bAerLMVYY4XCq?=
 =?us-ascii?Q?EIcXP3scRZIig1/hJEW7Ug4Ea/xDe54SV3vRJHO/mpa3oaxPB2opUD5kveL9?=
 =?us-ascii?Q?9l6j5zrD383byqyH2qnftHm4oQsJIDFiJkLcZ6bd0ua1NWEp/EnlnUV2CLky?=
 =?us-ascii?Q?BTnLiFqtH+4iMKaCkYtULzRuT9J9wu3pEnE/qYKJE1ZkLooghh+2mT/k8Lts?=
 =?us-ascii?Q?+lycFt/DHHYGYaC/V/G/WHbp9IWgYdOboHSiU4IpFBoc1k+MqjvF0/pzzmwZ?=
 =?us-ascii?Q?61h3JSR5EFxZzV/nbRIE70JUEW9g8syVe2zAcXZ7Tg3PEgKzNhjGJlyFXRRU?=
 =?us-ascii?Q?VqDFiHGzeqffd8GuZL56PCYfSarrulh5bRLN9h1yXePnEoIUH9tdFvfTks4+?=
 =?us-ascii?Q?pS8s/jwLbZoDBdEzxsHQyKt0gz+ihljbJkSxR1E64JFk0ZHeMC3/sIemN+cE?=
 =?us-ascii?Q?Jiih2c96ykAbqvavKFdQbwavqn5n8Aub8JUXUrW4m1fP8ztQUkgtM0m8uNH6?=
 =?us-ascii?Q?BeODfCkX9yfwzEwuvMPAAFr4dfYB2Kb/7T+NWdswssyPzUtm4/UriSMuh0Ui?=
 =?us-ascii?Q?uTU3YRMJvFa3Gl1RYf/DEpSegFoH4M/q1CegKuJj6DEQSLvw4LGipNz+notg?=
 =?us-ascii?Q?ZcAqNKzdepGK9HVaoCOwztr5/7Zrc8VOHLMB7asqstODTRjzizBr77iRwI6Z?=
 =?us-ascii?Q?1lqjGRIdQ4Awee0u//UGgbV++cT1LrHyi4CMBe0erkpDiezYzR6HB1vod0rr?=
 =?us-ascii?Q?jpLnk0ST/x9NchaFssu5iWv8E66pX9Aau+hvtv0rbQ7xveUIi3XEvhbGsj6n?=
 =?us-ascii?Q?8w47xHIUj1J62I3g2ESnPXuZfYaKtkvdpErDHLpCNLSp9BJIMra+uS84G44Y?=
 =?us-ascii?Q?90k1l3Pqejcf/W5OkhNb07T1pzo85rANBLwtJTprBQY1NMujwF5fJBfemTX7?=
 =?us-ascii?Q?TLvf7zl4vW8xbEoO4TE98dEyL7zrANlUHXlJLgo4aENDfw+N9RrhLZfMRymM?=
 =?us-ascii?Q?voWjTPjq7MxvxrTlXILfsUIyer3w+SOd+QUijg4GoLxdDZxYj76FzvFXfQtb?=
 =?us-ascii?Q?r3wjZa8nZJtYgKL0rIFifJ+lqv7AAymvl1Mwuxo51zGOzt0kxcOEt9aT38tS?=
 =?us-ascii?Q?+g0n6N0ZHVVZckhASrONaXGNjZD5uDJnvfrgr8zk4Sz7712d54AZGa/DsiKS?=
 =?us-ascii?Q?ptJhMPyB0XSJF7Gi4bXHeM5Fslq5Sc+JBp2z8lNLjMkBk1OZDQwZ5exbAFM6?=
 =?us-ascii?Q?dHoWHNwVC/9gz/SffKWeeFTvuHoIfXPuJ0E8TEHLNjXGOKMY5PJqTfkd/nyI?=
 =?us-ascii?Q?rPa8UNSYrfb0feYYXkPsSCRJasSfcrcQE0ReRRFz7jMdhZQZtMvOTBWIxIQk?=
 =?us-ascii?Q?1QrdnWy4NcyqniacWj+nhGgg7Hympx1iZj7ZXx41usBTmRM8tW2n4X0vr/Ri?=
 =?us-ascii?Q?1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c919050-185e-4917-dba8-08dbd9fb5963
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 10:22:56.2524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8iFEcRu2Lqs3bbD/2Trd25F/r6U+fTb4LV5xdm2+zOsMxtEs6OCaVn4bD7iI08gLnFQJtCeCaIVfIK9AwMa3jQeOMakIgugbsuMxCBaxiU1DRRencexOfvGl58DlOKbm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Saturday, October 21, 2023 1:08 AM
> To: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>; dacampbe@redhat.com; Richard Coch=
ran <richardcochran@gmail.com>; Brandeburg, Jesse <jesse.brandeburg@intel.c=
om>; open list <linux-kernel@vger.kernel.org>; Nguyen, Anthony L <anthony.l=
.nguyen@intel.com>; moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@=
lists.osuosl.org>; Keller, Jacob E <jacob.e.keller@intel.com>; Jakub Kicins=
ki <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller <dav=
em@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next 3/6] i40e: Use DECLARE_BITMAP =
for flags and hw_features fields in i40e_pf
>
> Convert flags and hw_features fields from i40e_pf from u32 to
> bitmaps and their usage to use bit access functions.
>
> Changes:
> - Convert "pf_ptr->(flags|hw_features) & FL" to "test_bit(FL, ...)"
> - Convert "pf_ptr->(flags|hw_features) |=3D FL" to "set_bit(FL, ...)"
> - Convert "pf_ptr->(flags|hw_features) &=3D ~FL" to "clear_bit(FL, ...)"
> - Rename flag field to bitno in i40e_priv_flags and adjust ethtool
>   callbacks to work with flags bitmap
> - Rename flag names where '_ENABLED'->'_ENA' and '_DISABLED'->'_DIS'
>   like in ice driver
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        | 165 ++---
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  24 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |   4 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 209 ++++---
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 587 +++++++++---------
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c    |  26 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  20 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   4 +-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  20 +-
>  9 files changed, 544 insertions(+), 515 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

