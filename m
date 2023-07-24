Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B1775FB83
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGXQKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXQKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:10:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3000131;
        Mon, 24 Jul 2023 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690214999; x=1721750999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gpQAA3ReL8cYqiTAFeVGiUuErNJ+UsxdozhEdWA3gMo=;
  b=i3nJWNSG3x/PDcIK+xDOkLVs82Fc1Un1q8GA85AoOD1oQEV3eNoeD/yb
   yoT3Gx71BiH/FMDSFeHxcq4Rrd3vtKlrdH0WzN/RuHD4AH2o5JrBBx+0Z
   1yNFH767IKl4Gu7C2artlyPj7cyufQNZLwhLrunOylCRP7ZcEivFiRzKb
   LF1VZoIguSlKmIXKiVr1CFOcf9Zsba4x3B8KKYOOHib5FQa4AxEAOeeSH
   zYW4Ap7MtCYGDPC0kAN59fJ2wWQM7PQpKtbJWgLeED4dfV9Xm+CV5Omvo
   nAC6H0ZAmWX4/LdNxQXxojxbb7o7n04Fp9tbIyEzHpcsZ85HnvPhagba6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="453861268"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="453861268"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="839511887"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="839511887"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 09:09:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 09:09:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 09:09:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 09:09:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 09:09:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8PVpHP91ne9qnCQ84bJK8XKhZntHY07t6jwtCriCZfWBJooMKcO2QC/4NmRoskQQNlx7FmhkiVrTy4oC8gYlE748KxKEhVL5u6GZ5h4InoJrk6mCcyUyxAwADRMfCe9+v/utAGV7PDbWUbTJNn1sjXv9KqGncnf+uFM9K6ishQoH9j/oO4439xtoILhSOCqR/BXe4zTyOmpOZHPB9/YAJKic7/eSG8KGtRPpstB3AiLwFLQ+ws0eio5DVzlqgwcKudZ+JKiHNBMpwTMRQou/MHlzYxYUrUwAfZLftt2EOAkDvsmoYcAwgS3E6/nGNxuabXj95sF8xX9glQrMFbqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpQAA3ReL8cYqiTAFeVGiUuErNJ+UsxdozhEdWA3gMo=;
 b=VNUIcbxSvq0znacJljt3tjum83e8wKa12oF4T2XRN/X3ZE3usUXrTSUAzQGulJnb5xdT8clFMkgb1pyBEXQeMcZbzvrfi5tAdp01r8ZpyzOT3PnLmT+Fsynu71mPRWOAC+QXCW3FEdePoct+YlvH5gnZ7xPSttTVxUiGoYh9ay2Hkizl4XOklvvSd9QtLgxYCRkqU9YTww9uWkbBOIG8s1MbRfgy0QmT7RPTv/Z7BxU+GGIBCy0huOA1RdxqhLH79uwoMnTUNAAq6/U7YWDMipipMjUEli+yQ629w2EYpdOoFM858wRDeOgcoiMhM3o/2jVbCOiDyDmyVRUmm9O7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH0PR11MB4903.namprd11.prod.outlook.com (2603:10b6:510:36::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 16:09:56 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6c4d:b433:cf0b:8a5]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::6c4d:b433:cf0b:8a5%7]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 16:09:55 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Koba Ko <koba.ko@canonical.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] EDAC/i10nm: Skip the absent memory controllers
Thread-Topic: [PATCH v2 1/1] EDAC/i10nm: Skip the absent memory controllers
Thread-Index: AQHZss8iubWsf70ZJUS2YrBy3XFYsq/JLKuw
Date:   Mon, 24 Jul 2023 16:09:55 +0000
Message-ID: <SJ1PR11MB6083C2E1587E3D7046D0A652FC02A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <CAAd53p6J8usSi+rHnd9+714mUqZ2zTdhFSEWUtiK7aNzcAZ8CA@mail.gmail.com>
 <20230710013232.59712-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20230710013232.59712-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH0PR11MB4903:EE_
x-ms-office365-filtering-correlation-id: de055fa0-fd70-4629-a2a6-08db8c606be4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g1FwZA8FxP1VePgdX3suzetFGgNTrJu1blcTLDwgFK6sbRt/aFY0oSwt6ZjsbxczZ6jEHtAbnASDqw4upn48eTkG0YfLG1Rm7rByyUjR3tHAjDkhMRHQ48o+rt4FJs2shDyIapULsT6iNEelpT2F+5iY7yeI2F3f9N2BnND+4WAyDDnN1Hwxfs2k9JInnXRVLfN9REU7Hs/IM6vsuvo4xJRMRYghjThadFLJmA6k4sY9KSkdas15GNuGYmuzsvigN4muG1XaZgfutfJx3AcDwAZk//S2V4qbkQT410qw7vRee5o2q4+6zAiqEVlvQFEMUCDAskcp7tQki4cZmkFQ9M2VwffEXv2yihQtDuopzCgQt0h3+WxD9H9W521MSyWIsocWfyM8ELKhNEz4em07GSZ4afGy2CkwiFxJc4JfZKJPLRkT1N8/nlFI3veNPYbD3P+7hhSEzdtZ7VHkvW2O4kSJiNlwt7LsQm0EOSsB+QB+NdIr39evWAuXqb7+VMv2Orl+UKV8SfF4exbthXKFmwrfAd6DP6MCPsuHqlcKz3yn5Fn6HtyJ/lHtwc5wFcLxwrW0GYfCaGUFzWiCuIWvZg6WeW3frBVbhUSpqLzCUKn+zSqn/wQmoVqrXWUqkExU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(4744005)(2906002)(55016003)(6636002)(4326008)(9686003)(316002)(7696005)(76116006)(64756008)(66446008)(66476007)(66946007)(66556008)(41300700001)(38070700005)(478600001)(33656002)(71200400001)(86362001)(54906003)(52536014)(38100700002)(186003)(122000001)(82960400001)(6862004)(8676002)(8936002)(6506007)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KnHC5WTdiRDWA9uFA7ExyPU80ZLpSlAHQ9nUCqtHgWF8JhbFco7flxVwrZ0s?=
 =?us-ascii?Q?Tb3McrhtFKu+z4vA8FM7i2gCV+KZjH5IcbFgTxl5Ur5nQEUfQVXD34HyPJzn?=
 =?us-ascii?Q?jNavOlS+1U0s5O7VcHNiTBAlnQtt0zwlzOZKJToMFENgftnyIiNAVcQHiAKg?=
 =?us-ascii?Q?TEOpCGgG6ua7nuFEC//76FOqMcVqElcT3bv5xbJ2WD4A/V7DD/4iIwrjux2g?=
 =?us-ascii?Q?znfmADXttpr1tXaierXCI2i91DG3GfW40O5NkHvsvfUWSONJsulZIGWuAvBW?=
 =?us-ascii?Q?Jy02D5WWUP5+nHpADwW/S6DZp9grFCmm9nU4LLRVfX+473GNkCCNNyv3jYca?=
 =?us-ascii?Q?KrjWLxvDPZh0egPO4Vi/+feoXTq2y81KmAWcPzg0w3uq/1FTJCrv1+5QE2QQ?=
 =?us-ascii?Q?TNIFUEdZZ5Vz4Ez5h6EwfguTOl7HrZZmneaEI7afrGFyfcL3KnhQNEV8WR+N?=
 =?us-ascii?Q?RzBj6Xq0M8IcyHBua/XeltuseqSbWPXEWTuwO8C/qszOVzV6F2GUq27Q3oyP?=
 =?us-ascii?Q?+HatdHGdAqfzaUbBSXes+EZf+GPbnpKsGBxPVRLoJ8JV4n92Gts2Dr4T1GLn?=
 =?us-ascii?Q?lpW226LEt2yPqed5OOpvmb9l8T5NnouUxbVUG7YOeMtEMqWODDh09TU3JYhM?=
 =?us-ascii?Q?d39w+zGWO0hq2cTTuHlKv2x/DRU0H2+0D39boNw7VL4cJWIKNnnTKmgderaU?=
 =?us-ascii?Q?4yZDLGYvTh1xgXMEFayAXLSCZBN2jOtwRtlSMb3hZjUhiY9EmSiccSG6blHp?=
 =?us-ascii?Q?Jrm56SSjwblAt1DkbJpjXYS/5vQoAbn7cl4uUUxEWUKG2w0tKN2xbIKFeRY/?=
 =?us-ascii?Q?OWmmS2ccv1AGDuR+Dum14n5CJ7thptZ41WxcxXykvdwqg3JYAmTQg1cRuQLJ?=
 =?us-ascii?Q?7jQYCxXDdl2Pm9gXYJONDxFkvgTSMxbZoHILVepQ09PxMsLseD1MAZgjGQjF?=
 =?us-ascii?Q?9SL/qxM5Xpnukw0T4WE0xqP+URtcveSgihCYXOL60+2b3WywbxG13nagZXD2?=
 =?us-ascii?Q?fWC1u+tIdzf8IE5hzf3mjtWAPky4woOT/ZLnzlOcQ0Fsmc0RNUFeHNGfW4yI?=
 =?us-ascii?Q?Om02Ulg7YPasHtgvGSxp0yzlyeWGwTHcTyS1LbeNpKxO+zCf6gMQfk0nx9OW?=
 =?us-ascii?Q?RYxT6bmcv0Vn2tp2S3h1d3jyrLq26PzqbOfA8NwIVxLDQWeSAMPJ49CkLGyg?=
 =?us-ascii?Q?a1QN+keMVIkLDvKcuJc2ivQP53WzZznWN/Fts1YT6aXwdq/QjEbD4tB1on3p?=
 =?us-ascii?Q?j4FbPQx7CbiEQfO1FnudbZHJyCqBIIEmMcjlif1Hd7y1aoL7pnspD0KNJC0z?=
 =?us-ascii?Q?6XimbQHWVkvTCPnB3ansI8cBeaEM6NNjV82U4ynqLk/MDvhJIWYLkK8dgF7p?=
 =?us-ascii?Q?p90EZ4jOXjDpRxGdcVcmyH639lr1xV1dfLloSldUKUbDMeJIxBcaJPLNnweE?=
 =?us-ascii?Q?0jH93nTGoYA2rfiWTh/qYkC7cPynA4qlXfzZt5xlZF+b9uIBAcIdnSUsesV+?=
 =?us-ascii?Q?GGmu9t3EwOEFTT8GP7e/tEF1Joo6dbqosvxYEr4DJmmPxU9vp+xVuQn/WXnF?=
 =?us-ascii?Q?lqawCCZPwJqHJF4vsCU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de055fa0-fd70-4629-a2a6-08db8c606be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 16:09:55.7379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDzjYAQ5chAVATMr6ZEtYIXg/qmARy/d8mToLfAyuEJubbTbvuul1x/JxVWZIbAxuIDnuYG7ZPm2UBKynbugdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4903
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Some Sapphire Rapids workstations' absent memory controllers
> still appear as PCIe devices that fool the i10nm_edac driver
> and result in "shift exponent -66 is negative" call traces
> from skx_get_dimm_info().
>
> Skip the absent memory controllers to avoid the call traces.

Applied to RAS tree for next merge window.

Thanks

-Tony
