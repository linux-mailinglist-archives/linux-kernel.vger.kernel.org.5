Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E615D8123A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjLNABn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjLNABl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:01:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4893693;
        Wed, 13 Dec 2023 16:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702512107; x=1734048107;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=og9g1hNe0r+tbZTnaz7ocNZVxFmbjwweFFyRLRn0BHU=;
  b=ikR+58se3aF7BACle3oxw9r9dIGKacSxRhZ6L0R06ryY5141gmdg5YIk
   KO3ahpJh4WcnQVu89xeHwkr0LKfbaNjMk7Akazy8wi8WQ7T9SmTQzdFnf
   41pBGuQIdszp+DwQ9LxSpf+ApUxqbxAu4SmxS73M5WV8EyH7M6tI9t9BI
   WHxaXKZ9JSvlVRo62iFZnrU+ffveYvN0q6J78qjrcf8KHj80EAjpKv4MA
   DuB9GHOeb7zzY3vQONgbb48/ADWER9WLos55wdfIyspdpEhq+3hYcKjUZ
   ncywdzurol34cWG81NdJu3E8ArieOJ77Cln5ghimNTW3GzjN8B0n0BjzD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="459366252"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="459366252"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 16:01:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1105485011"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="1105485011"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 16:01:45 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 16:01:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 16:01:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 16:01:43 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 16:01:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfyjzRee8MqBDASVN9HMO9Fy8IUSYe2ct/uDDyABh9LY1tUlPSiyu2AGNbmH4iaNaJMfGTQcCoMBKpaXDoKIQdhjj5/WvTyNvDh7K4P7WwihLrGk5PGAoIcd8Zr3L+/z38MH8sVw3blFzUNgsqqp7VqEV1qtRWD37CK+yKLLyeJ5/Dk42DU/ixoJ0xavsheFsXK8XLoUaBv+lEiZho1QGQh6MhKkk+UMjQAiJ1uVT5pyCKqsVjV8zPQFrwxVoUlmJ6GKIf0W/wBSU81IORmIabqocZ4xWAvxEgTQWKJII+NjtmzatOd3K4eb1BokPhTU/kZRZQYEISEYdmXuaUc1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=og9g1hNe0r+tbZTnaz7ocNZVxFmbjwweFFyRLRn0BHU=;
 b=QMaNNWkyaHHK1lNpPX82SkYUuxxXA9NHVfLqNK0nTaTbygJ6K5T/QWGSA3qh27MQv1YcPntYknuleqh3FQwUU6SaQk0AQ+vZC24wOs70M/pOoASzh2kytS/Lu6iZagLHKbqAL147fjfo/wAtS1ose1dat63q4iejgzSgHzB3To+kwqiZfjyWF+OWNcLEbqe9IEvy3vwKMDeao4zb+Zm384JvyiTAT41CesGNgi7rg9aXZmjneLk1oB4oj9Ywkny0C4vF0NeMYT1kOm0LCyFan1aSLNJJnhb57X6t3P0ivHBqeaJc0MSZRz9rnNUmm8szmFmRhEGBq8/g5BdGQFLPRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by IA1PR11MB7920.namprd11.prod.outlook.com (2603:10b6:208:3fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 00:01:38 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.7025.022; Thu, 14 Dec 2023
 00:01:38 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH] driver core: Add a guard() definition for the
 device_lock()
Thread-Topic: [PATCH] driver core: Add a guard() definition for the
 device_lock()
Thread-Index: AQHaLhh8Soa82xlCd0+oPEo4TpJ2DLCn5TcA
Date:   Thu, 14 Dec 2023 00:01:38 +0000
Message-ID: <77bf5505cf28da23077ade3e5318bafd4e47cf93.camel@intel.com>
References: <170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|IA1PR11MB7920:EE_
x-ms-office365-filtering-correlation-id: 1573f475-c706-47ff-39c7-08dbfc37d86d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4FVRxBfZM1Yt/U6qx9uahAytlMYtwQdNBKrUfghNMzFTG+oU6KA4mNw3WWfsgEr8cZgGCx/SJkkpu1a14SCRGhIvHTuITx8MPU1cbCs/H2W0YEql38GpsdcdfbLnHVHk0npPiFfzBkcdFKzhrXHQf+t3Z5zQswhAoomDns6WLNJ0nDooLCtlQFA3E1o/Ui7Jno0t2MGqcehABHUiYE0Nanc8kyge+KAcZKy2gw3cg/xIT6Hkmi6SbC/8CKVWc2EosAKAvnWnwhZcdq1tPC6MfqCLodcFXLknpci5ubew9lhuf5KefKPyQg6wZ1ox1hg3ybmZSnx7Qp+p7Bk0Q0kpEdqQeUROF8ZX3id/hywcQbdVIBf5Khi+kEe7/sr9jun0X0MEJhW5O1QtKYyMJ0jSwXlBbKZ1/tKUEfZN+sQ5Z/BAttyHJSYByTyDsBwfc8RQC+yaWZAkRAC1CMKSkMrHtGX/gfT8EO1pCNKk26L9B57aDyCLMghwz2RSWGBHheQr+5Bg5XBv5G2mmab1/flzP6Ap8hflKsLlN7UHmb++vv/s6lDM9FMSSnJ6TeSouFfSsAU5j99ik3ypioTbFRL7XODsOsGfyovPdopY7R8flhjWOn/aHB1UxBxavvIiLLnKPLX7wWrO08sw//1rngsxcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(71200400001)(2616005)(86362001)(82960400001)(36756003)(122000001)(38100700002)(38070700009)(5660300002)(2906002)(83380400001)(6512007)(6506007)(66446008)(64756008)(4326008)(66556008)(316002)(66946007)(110136005)(54906003)(76116006)(8936002)(8676002)(66476007)(4001150100001)(478600001)(6486002)(966005)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXY1cWxuWGEvWk9uT3dnVUMxUTduRitndHUycTc4Rlk0ajA3TUFOdllmOHJH?=
 =?utf-8?B?amVRRlBoMVdTTG93TGFmbFd6Q2ZoM3NtalZOS1pEQTY0c05UY1ArNk9QUzAx?=
 =?utf-8?B?UVl6NHdScE9nRjJpMldZeldVNENpc2x3SENZYmRDQjMwVDRIRUdNaVlZdjEx?=
 =?utf-8?B?RzV3SThVNTNpbEgwTHJlMCs1K0JtQnpic0RLeE1EL0ZHYnp6T2lXemVtSDl4?=
 =?utf-8?B?QnRPcE1NK0pzSmpPNExJSjJVUi8zQ3pjNHE0QkZiRVNJOWQ5Ujh6WDNweUZy?=
 =?utf-8?B?Tm56dlh6enB1aDlqUzhTKzlRbHYweXljRXpvZGFqWUJyc0JORDVsemxLY29m?=
 =?utf-8?B?VWtvWjRkZ2FXY2tialdPaTVJTWtaUU44MGlQVC9NbmdWeDJRdUg1RDNCV0FG?=
 =?utf-8?B?MkVLWDhLREFqUkp0RkFqNkl2cEM4dU1OUytFZGVHRHpTVGJwOWFZaVJwWElK?=
 =?utf-8?B?ZFJ1T1E5ZGN0QmdzWHBQWURuQU1SQkZDdDVWazBmTHdRYUtReGltZWtqUEVq?=
 =?utf-8?B?dUY4UzBBTCtYdVBlVlBQZG96bFdsVFN0QW9JTnlLT3pnMkM2dmRsWHJBSXRv?=
 =?utf-8?B?THBqcmNGUm8xd0VUR0E2NFhHa1FvLzJOdmtSb09QRkMxS2hzNjdKUzV1eTNj?=
 =?utf-8?B?TmxkMndCbTZ0N2Q1UTdMMEU2Q3VlemdpYVQ2eDhwWG9WZXo4NThTbTh1MHg1?=
 =?utf-8?B?ZzhYQjdib0JxTDNCZnp4TFA2T1llOVp6bFRmNnNYOVJLWlJsQ2oxcEU3MUtN?=
 =?utf-8?B?Y1dEckI4MkY2T2lGeEZvT1FSYzZ5Uy83R09RaUc5NVY3ZTZzdDBpVXB5ZGZj?=
 =?utf-8?B?NWtCQUdYQ2RseDBwY1EzbnZZOS9ac3B6akhmeTdxSlpqQ0thc2prTGk1NmFk?=
 =?utf-8?B?Y0FYVGpDcjhKMVBKYzdWZWEzZ25BbGdjc0diMWFkSWhpckU5YzFGcjFKMmd5?=
 =?utf-8?B?cENLQk05dUpQL3N2NWt4M0RaTkRHYWlEMW1qKzNkVkQvcjgwQjErc1lrZHM3?=
 =?utf-8?B?TUVWa1QvV2I4cURtbkc5M0hjYUgyaUZBdlYzcXRiU0FhVDRKV3JOOFg3cG5n?=
 =?utf-8?B?STJ3UzdIZVNDWVdreVN3Y202Y3NkcWIzbEZXUmJhdXhEeW04YVdkQ1Rqb3h3?=
 =?utf-8?B?RnBtUkJkaXBLWE1SOGZTcUlhQjIzeUkwbkJJRmlNalAwRkxOUTZIcmV6R29G?=
 =?utf-8?B?cllsYU5BbWg4ajBoNmR4L0Q4QUcvZ25USmR1M1lPUXhFa3pCblgrNE9Gb0NB?=
 =?utf-8?B?eldKWkZlRzN5Ti9idWRXQWpzc05MRlJCa29Cc1dydTJadzJxY2dFNHRac2Fz?=
 =?utf-8?B?MmlhS1FmS3RmOUdDaEtxUURTR0hUM053ZU9qbWo4bCs0TWNzRGFKSm9FeFJk?=
 =?utf-8?B?c2JXVmFLK21mWlpkZXNIaGNiSHB4SnNIdkNaWU1RdzVyQlhpVUE5Rm1lUkl4?=
 =?utf-8?B?WSt5OHBsVm9qT0R5Rk54S0l6Vk81blRXY1M5TXNtM3RwYjNEWmRkL3ZYZW9m?=
 =?utf-8?B?K09RU3J3ZlhLUlU4dlVDbnJCOWJrWlFGV0VSSm5EMG8rQ0MraUVSWUZtTmdK?=
 =?utf-8?B?N0xiWGQ0VHJHMzl4enhseE5IUXJhMFptUFgyRitiVnVTMHI1SUY2ZjIyUlAz?=
 =?utf-8?B?Y1FZY053K1JRR3UzMXgySEFSVkgyZWRHcWI1MlhtaVlYM00ycWwxbVpySFFo?=
 =?utf-8?B?NHZmUU1pWjQzK0ZORUhZV0lia2tsZTRsUWEyRmR5Uk1TU2dsbTVYSzMxdlpJ?=
 =?utf-8?B?VlhOTklwWWVqZTBNY0JXei9RS3pzcTlZRUw2bXV4WmhWSmtsRitNQXpBcTNv?=
 =?utf-8?B?TkwxYWFuTDlWVmRsQUdjWk03NURTelpHSHJ4d21BMy9jZmJOSU9uUmczOXJq?=
 =?utf-8?B?WHk3WFpGVXYwQXJ5REpZNjdLNnVLT0haQkVpSmZRQXN2RUNwZGpYS0pTdC9X?=
 =?utf-8?B?OGEwWCtFOWZpalc4OWlmb3p6MHBkNkFSQ2xCMTFwcXh6V2ttZk12b05Mb2cz?=
 =?utf-8?B?L0FBRDdpUjh2L2VGeDNHTndZbkpHdUdRSk42eFozYkhqM2JOSVlPWlU5VFk1?=
 =?utf-8?B?MlNmc2laNTNyalAyNzlIVUU2QnJ0emJDeGRDbEFoTU13NzNkMXEzTGpwRjJP?=
 =?utf-8?B?dlhIQzdsN2grbVdIV3IwR2xwcHlHT1VGTDFUVEM0ZWxycS8za1lBWDRQdzZC?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A729DC58E6DF443BAF6D34300311525@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1573f475-c706-47ff-39c7-08dbfc37d86d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 00:01:38.6956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3FbFDffZIt3J7F64OWiuZJ89HQSXGV067ibj8IdNksWeei1lfQjqHFk6TB8V1Wz4XEpStHLj7t6q7Xm9NvL+KsirVxAcm8lCBq7fmDbxsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7920
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

T24gV2VkLCAyMDIzLTEyLTEzIGF0IDE1OjAyIC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEF0IHByZXNlbnQgdGhlcmUgYXJlIH4yMDAgdXNhZ2VzIG9mIGRldmljZV9sb2NrKCkgaW4gdGhl
IGtlcm5lbC4gU29tZSBvZg0KPiB0aG9zZSB1c2FnZXMgbGVhZCB0byAiZ290byB1bmxvY2s7IiBw
YXR0ZXJucyB3aGljaCBoYXZlIHByb3ZlbiB0byBiZQ0KPiBlcnJvciBwcm9uZS4gRGVmaW5lIGEg
ImRldmljZSIgZ3VhcmQoKSBkZWZpbml0aW9uIHRvIGFsbG93IGZvciB0aG9zZSB0bw0KDQoiRGVm
aW5lIGEgZGVmaW5pdGlvbiIgc291bmRzIGEgYml0IGF3a3dhcmQsIHBlcmhhcHMgICJBZGQgYSAu
LiI/DQoNCj4gYmUgY2xlYW5lZCB1cCBhbmQgcHJldmVudCBuZXcgb25lcyBmcm9tIGFwcGVhcmlu
Zy4NCj4gDQo+IExpbms6IGh0dHA6Ly9sb3JlLmtlcm5lbC5vcmcvci82NTc4OTc0NTNkZGE4XzI2
OWJkMjk0OTJAZHdpbGxpYTItbW9ibDMuYW1yLmNvcnAuaW50ZWwuY29tLm5vdG11Y2gNCj4gTGlu
azogaHR0cDovL2xvcmUua2VybmVsLm9yZy9yLzY1NzdiMGMyYTAyZGZfYTA0YzUyOTRiYkBkd2ls
bGlhMi14ZmguamYuaW50ZWwuY29tLm5vdG11Y2gNCj4gQ2M6IFZpc2hhbCBWZXJtYSA8dmlzaGFs
LmwudmVybWFAaW50ZWwuY29tPg0KPiBDYzogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29t
Pg0KPiBDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPiBDYzogR3Jl
ZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gQ2M6IEFuZHJl
dyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IERh
biBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KDQpPdGhlciB0aGFuIHRoYXQs
IGxvb2tzIGdvb2QsDQoNClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1h
QGludGVsLmNvbT4NCg0KPiAtLS0NCj4gSGkgR3JlZywNCj4gDQo+IEkgd29uZGVyIGlmIHlvdSBt
aWdodCBpbmNsdWRlIHRoaXMgY2hhbmdlIGluIHY2LjctcmMgdG8gZWFzZSBzb21lIHBhdGNoDQo+
IHNldHMgYWx0ZXJuYXRlbHkgZ29pbmcgdGhyb3VnaCBteSB0cmVlIGFuZCBBbmRyZXcncyB0cmVl
LiBUaG9zZQ0KPiBkaXNjdXNzaW9ucyBhcmUgbGlua2VkIGFib3ZlLiBBbHRlcm5hdGVseSBJIGNh
biBjYW4ganVzdCB0YWtlIGl0IHRocm91Z2gNCj4gbXkgdHJlZSB3aXRoIHlvdXIgYWNrIGFuZCB0
aGUgb3RoZXIgdXNlIGNhc2UgY2FuIGNpcmNsZSBiYWNrIHRvIGl0IGluDQo+IHRoZSB2Ni45IGN5
Y2xlLg0KPiANCj4gSSBjb25zaWRlcmVkIGFsc28gZGVmaW5pbmcgYSBfX2ZyZWUoKSBoZWxwZXIg
c2ltaWxhciB0byBfX2ZyZWUobXV0ZXgpLA0KPiBidXQgSSB0aGluayAiX19mcmVlKGRldmljZSki
IHdvdWxkIGJlIGEgc3VycHJpc2luZyBuYW1lIGZvciBzb21ldGhpbmcNCj4gdGhhdCBkcm9wcyBh
IGxvY2suIEFsc28sIEkgbGlrZSB0aGUgc3ludGF4IG9mIGd1YXJkKGRldmljZSkgb3Zlcg0KPiBz
b21ldGhpbmcgbGlrZSBndWFyZChkZXZpY2VfbG9jaykgc2luY2UgYSAnc3RydWN0IGRldmljZSAq
JyBpcyB0aGUNCj4gYXJndW1lbnQsIG5vdCBhIGxvY2sgdHlwZSwgYnV0IEknbSBvcGVuIHRvIHlv
dXIgb3IgUGV0ZXIncyB0aG91Z2h0cyBvbg0KPiB0aGUgbmFtaW5nLg0KPiANCj4gwqBpbmNsdWRl
L2xpbnV4L2RldmljZS5oIHzCoMKgwqAgMiArKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RldmljZS5oIGIvaW5j
bHVkZS9saW51eC9kZXZpY2UuaA0KPiBpbmRleCBkN2E3MmE4NzQ5ZWEuLjZjODMyOTQzOTVhYyAx
MDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9kZXZpY2UuaA0KPiArKysgYi9pbmNsdWRlL2xp
bnV4L2RldmljZS5oDQo+IEBAIC0xMDA3LDYgKzEwMDcsOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
ZGV2aWNlX3VubG9jayhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+IMKgwqDCoMKgwqDCoMKgwqBtdXRl
eF91bmxvY2soJmRldi0+bXV0ZXgpOw0KPiDCoH0NCj4gwqANCj4gK0RFRklORV9HVUFSRChkZXZp
Y2UsIHN0cnVjdCBkZXZpY2UgKiwgZGV2aWNlX2xvY2soX1QpLCBkZXZpY2VfdW5sb2NrKF9UKSkN
Cj4gKw0KPiDCoHN0YXRpYyBpbmxpbmUgdm9pZCBkZXZpY2VfbG9ja19hc3NlcnQoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiDCoHsNCj4gwqDCoMKgwqDCoMKgwqDCoGxvY2tkZXBfYXNzZXJ0X2hlbGQo
JmRldi0+bXV0ZXgpOw0KPiANCg==
