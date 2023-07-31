Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416A8768A71
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGaDwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjGaDwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:52:20 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C68170C;
        Sun, 30 Jul 2023 20:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690775532; x=1722311532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HqWH9TKOybvop5bf22K2WTS77hD9Tcs9JiyvdInFju8=;
  b=j46BVIKrUCK08plxkz2HNFrVewJr/ruzyMse7jevgrT0W2kBZuvnmHW0
   yipXNVQ10gIWwBZm8hLyvFuDZRc6HBWyIInJicJc63cvqSDYrZWv48cXK
   rh037e2M6Yj3gSKpsoGTEc5KjDtQOfxFXYd6uoAD82zTwTglGQ1XmFz9k
   qF+1uI5PPxsp9P7FQQ2lWhF5xD5gHDHHBuGdhQBzwAWXWz6FcynHu8+Lw
   MORIYbLN8ytKLxjhstBCnGkZxKSr34uTEYEaJ+DFlPMsC2V0WKuEH82i4
   NHkBSuCLkWuoP2a6JJAjWUKod1A99IgsYdevs9qXdYv+tkgnvwLWR2e8Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="432723602"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="432723602"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 20:52:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="851880862"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="851880862"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 30 Jul 2023 20:52:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 20:52:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 20:52:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 30 Jul 2023 20:52:10 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 30 Jul 2023 20:52:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbogzmNayo7mCKZ5OdWyuXIC3egVOkqkXIWq/G9SOhkzgj6UvcMD+owMzWDKRahMqzEOXFpp6BVT2/vX99RoIDs4YdsZBe9OmRxMI7an1upjcPlUv202+VXRqIQGZQ8Sb5/6o3IDJw/ZpkCM2SiTERTM6mq8ewQgXRXZR4v+N1UtMQwiEouQBH0EA70WHpKWPfQeyrTasW7F5UlT0EBXKPvNPKvEBhtHeJyBUK2IpwX7yBGGccnlCYAdb+lqeTG6AmHURq8cRWH8r30cj2bhLApNRkGnWaHDzS4zBa51hDdOnpfweu7F91BR3ve712j9VjQa5zZgw17bK1SRnBhdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqWH9TKOybvop5bf22K2WTS77hD9Tcs9JiyvdInFju8=;
 b=O8v12mm0XhFQcgP0Xkmp2xLbMvHqbcW0dWIOzI9zooSXd/FJhjnHvdoTUMJqs2RKpMHimAlv9fpRHXX0qD5r55aE3j6g7+sISWLp/1AsBPuFEbLukqMYoS3sQGRfvYFa4ozHIs5PUsvgs74hK9PW85yRzmUPa8QvUNpBc8J9N9favO4U67SkvqhXzD6vOqqk8JFzoHgSGQDLuqmISq6eH7/c1duiMI+b4bSlMSYyRm3Jom7gdNd8VDbULJDCvDngEl4fiVuSX0RWnICLCp09OX1X4Vq1+k2t3KroO8HROfX7tdDhVEWYpU4TqeFWC2ZoKeGwdg4F3pt6TbowE7nt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MN6PR11MB8193.namprd11.prod.outlook.com (2603:10b6:208:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 03:52:03 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ee97:2e55:ae8d:2809]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::ee97:2e55:ae8d:2809%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 03:52:03 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "pmalani@chromium.org" <pmalani@chromium.org>
CC:     "bleung@chromium.org" <bleung@chromium.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Topic: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Index: AQHZuR/m4IKFgl1ovU6TI3vwoe4fN6/KvHFw
Date:   Mon, 31 Jul 2023 03:52:03 +0000
Message-ID: <MWHPR11MB004898B3B175BAFC4A6327FEA905A@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
 <20230718024703.1013367-2-utkarsh.h.patel@intel.com>
In-Reply-To: <20230718024703.1013367-2-utkarsh.h.patel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|MN6PR11MB8193:EE_
x-ms-office365-filtering-correlation-id: 4e6556f1-93a8-48ed-b4ba-08db91798065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FiUMs+HViWSiOCVhKPpV63E62di8HvXtuIdWAXbMs1pugq+2rnhheJe9YN9+k4gctSdWgYTPcwSQ8vt4Q0dqeRQZ7esqRagDhnkoIPxjDwOJCZx0CO1T8K4o5h1ABAOV0uJ+ATS1BzwJ8jBnAJ/VM47M/jUYALNXr8cgzo303s2R/lgHaCBIYlOQD3AlofSaGsm05/7N9IodQAU3VWBaXp+LKS1XbK7rwuAUSa+gCyqwq6aLcQKS8CPIw/SHFGDhHPyG2lINOxdWx3rnHiJ59ai0+VdPk6aDWyuojMNuU18+gKoyrRPEymvcFigjfMdTqnVPILItApFyDQrSuBt1K46EF2v0doBxCLBUVKmYO+uZiLRDfLVzaJs/q9dMsMiholdP8An5INH0T/FRAMPgU90v/DjK4LtjS6d6/dU8+NjFt1KheAhH69kNckk0rj+R8gFIWYuu8SSrKu1pnqvms4hqJ1VK3NQctDqjPKsLidaVeaWGbsCpl/WtWRWzWEUYsCgaI8m4d+qLLu8GhVxQBwKX5lb6MMZTKpLnVWtjOgEoJ3PCamdyMHS8sXoWgmQNSo8JGP/LMREbBD0aA/qWFREOhTCcY8hc3LvVFeCabYla2QAHwykrhn/E85aqwmsw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(53546011)(6506007)(26005)(54906003)(82960400001)(478600001)(110136005)(186003)(71200400001)(122000001)(7696005)(66476007)(66556008)(4326008)(66446008)(64756008)(83380400001)(9686003)(66946007)(38100700002)(76116006)(5660300002)(4744005)(52536014)(33656002)(41300700001)(38070700005)(2906002)(316002)(8676002)(8936002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BzYJ8LpXhDqz4V4is3Gkkfkt73LzsvQR10ZgQjXhsDPSW4hiLnUUY3crCeqp?=
 =?us-ascii?Q?IDtec1GvKtaCvibBpyH4RdddNs1nr6/EAvWKxa6EG8DkpOuLXRKBkPFYBIds?=
 =?us-ascii?Q?4MMjyoT+c/IbRuSj6b5PKXZ6xQOv/T1QWdChYMJ4bIrR6i2WYEcAkh6irltj?=
 =?us-ascii?Q?xgkUzTYsMxAwUPqveFGHlUzMByW/XKtq/l/APfKqeRutLI3VEteIzQXbP3wT?=
 =?us-ascii?Q?RZlkkFIrWH2LNjQqE539vBSkskChrKnpLxMXpdXcotlbCgV9/5Q5iQgwNp4E?=
 =?us-ascii?Q?qkEnMYtBvzvkOEeK4fxeuqG+5EgDnpemsgCkdRx1evZX8xy3g7Wngs8UqvNd?=
 =?us-ascii?Q?FRSIPXQimSgcOToAu6tNkxlCuBDaL9gaYyTE6sJuGFFFQESip3tN4m8xW8Rs?=
 =?us-ascii?Q?0Bv+ykFQgjyiGGNVak+7tzuzKVsRt9vn2mr5jEGE/C9PddyZVoNBXIPcw+Zc?=
 =?us-ascii?Q?GE6CFr6XIUkwTIy9y9/z4911LoXkzCbr31+rN12jkL4h//MPFZGorZYdylcu?=
 =?us-ascii?Q?5+oh5nCioWLS+4rTa2FfMunhYKPf3O6hKm6NJnkC+E0ikT0oKVCsgjk3a5kA?=
 =?us-ascii?Q?er43WuwxoJv7nnLRPjlQgcI6/qdrtvC0iKOyfWPPNdX74dhT+tE+se6uDkHr?=
 =?us-ascii?Q?NKyJ/wDUct7y6BMG4L3+nPd3EDrxE1vXYKA9mcr5Q52Hob6b/bfsEQyhNIkm?=
 =?us-ascii?Q?HPRV47n2Pk3luVSRo3sVw/i8r0qU357TUZr1P2n6mtVYgBc1rL6tg6wixjMe?=
 =?us-ascii?Q?ggRy5cdtZ6OR7FHdsTW6CIr/Apbl+N5U0KJBGRV17RTt5V8+Hqw64ZhrwFHl?=
 =?us-ascii?Q?VJ2sJdh4jnhqj4m62w2rI3Y3i2mnLvxGfxkJQqZDENB3gusFwGepXx82+Ug9?=
 =?us-ascii?Q?cAFU4DNKpDrNikxOlGnmoqRWTi1jpV3y3zVZikCURElQhoGQvMiYr6yKZFyV?=
 =?us-ascii?Q?Xx/1p7Zakvh9y592SzyJoibUG2SZsisD5aqJy0YD/tbdZHI0WqZ1fhpSko9A?=
 =?us-ascii?Q?chsZaqxkQ0o3KSOMROrzqe5T601vIcSb34g4lyuPYWNW4q/wQAKVNdD0tCcb?=
 =?us-ascii?Q?fcQjPTogPnQzebxWjM13J2ey4N9cTiWHb6QloeP5qm/syLBe6d0v0e4wMG5M?=
 =?us-ascii?Q?wL+PHXRT+j262oxlwPbeY0xRtCSPbuK9WVRF+MX2dRo3sK/JE/N3XlrgN+Go?=
 =?us-ascii?Q?S5y7vzYb9faNsZUQZG+5eY9cUN3MGfmn0fIbp+/X3vjiCYjxYgrdRrXs8cW9?=
 =?us-ascii?Q?4HrpmdsVq5kvE2eD5XJ6GKuOnYQacCk1h5zgw2LRlN2bD6x+o8JDhsgX6VJU?=
 =?us-ascii?Q?3yUd0oAdveNKX65cZ8QNVQVKZgB47byq9Pw7jN6rqg6qfd9LzTRIoaa6O99T?=
 =?us-ascii?Q?89g5pF+O5loAG1NQ2LMOvShjPYCBF0NyTHyVs0bZOLkrsJgeAjARgXbJW3Pt?=
 =?us-ascii?Q?R1PCQnWSHzlp3eGxC78U9e5yIiH5sqruSQX74LBixXUAA6WKdNjpU7YFHQ+j?=
 =?us-ascii?Q?rqBKg+wSHLWczho1c3ZV2KK1FFKjA4BkKZukMAipKT1foAEJVufdWI9U5I67?=
 =?us-ascii?Q?6TkR30BrRqMknaPdeFSig19CUNO8ml9O4ESC81Cf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6556f1-93a8-48ed-b4ba-08db91798065
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 03:52:03.3764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkxHnpVcfcuo5geVC+TKVlZFVzBqjf7+S/vcYzM5c8jDTbg8ytc6a9DPE8foLCFMe/ivu3+1B7lQlI4ifiB+b3U4O8PiiUZMt7dp4piOEFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8193
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

Hi Prashant,

Could you please help review v4?=20


> -----Original Message-----
> From: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Sent: Monday, July 17, 2023 7:47 PM
> To: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> heikki.krogerus@linux.intel.com; pmalani@chromium.org;
> bleung@chromium.org
> Cc: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Subject: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
> cable type
>=20
> Connector class driver only configure cable type active or passive.
> Configure if the cable type is retimer or redriver with this change.
> This detail will be provided as a part of cable discover mode VDO.
>=20
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
> ---
> Changes in v4:
> - Removed local variables and used inline assignemtns.
> - Added details about return values in cros_typec_get_cable_vdo.

Sincerely,
Utkarsh Patel.
=20
