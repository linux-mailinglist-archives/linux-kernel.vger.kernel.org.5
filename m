Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E8B7AF564
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjIZUk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjIZUkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:40:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88DD11D;
        Tue, 26 Sep 2023 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695760817; x=1727296817;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UT9VFtjqYvBeuu/kT/fnhN6j0Bh7lbsCRRY399eHhmE=;
  b=hrVgMEqOhZW3OQf2l5WiYmW8LsiluDojpCcjXDHqrA0+Uu30KkWcYNf+
   +MOjknVpibaCUHhsdKMC0DLK7/R5Bze+OJVuKmIfwhZDS804syRzzEf5L
   xrDSqu7gwjKe7fri5Fp9ujX/bBHN5o5uD9oDw7oxcI7xeuoDXfeegdwfY
   PCtmndhJaR/nwZ2rRcEAnBC/4IEF04ffM44PuJz6JYzUeSx2+z684dNg2
   vAijAbCR0JI9HAdV/4VTrDWt7k6i3Ac1PzPAIO3k/AiRLMyyOVFUBcoci
   FrUYTEE19L/MS5j3J/FCcXj+ljnim4tvy6JS/9fMqKU+11PWRh0JPplIH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="371999048"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="371999048"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 13:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752314482"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="752314482"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 13:40:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 13:40:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 13:40:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 13:40:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 13:40:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMJe9JIZHbHQF7jW2O/KNQBB1ii0n2wv4/eWdzcOqOWijkL2EukYUJWW06OqTYS6iW+kRcXlnK+YEd0eBSydK8QlPP9hWhtGh9JN9/u3SPejuQPkKBi0VWiGlwgDtLGU7QXsQGs0+an/hfAF2N0J0YVm+Yaj7kIYjghTGZ0BesBwd4CeRMig/UvnUStliy6XL8IWAHjd+qq5lDb7MN+O5E9Mf72+4yQHHgDhtvUjLp3VB/4VuwUqfTJucsHCXRRokAs/RdXFCDOmN8xhF0Z9/3Wk4JEQxNUTnHFk6c4pAjmib9NlBejz6IQm4T0wDqO3AhLDnE+NVxz+FDdEylUt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UT9VFtjqYvBeuu/kT/fnhN6j0Bh7lbsCRRY399eHhmE=;
 b=GRf7DsM6HHFFbmaPHSnXCDByo3Tnc44CrHQGAdKEM3JgQDaJQvXcP4XrwfGUy4lv3A0iskswlRPYlj9nRlfqLfkmz/OO9N3vhrATYplMalUWgMNShNbzswE5TfJVQ8JJnHQoXimTdX05PIIyxUiv8CUdwoHaoACGlKB2wm376+6BSvJGBeP4y4QVhVaLYja6XEFHvIKCUzzLo4FZHH3ei3E8VJVS0eMbIqF4ia1j71xaAFPm0priWdM1GuTcWeh3sRpkI/auYkHvupVsomrKQ7MOTxRMtwkE9Tx8FZbj3+8X37BZRBecVZgCJUklawGdz+pfbiUEy8gQro8Joeqamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by DM4PR11MB5970.namprd11.prod.outlook.com (2603:10b6:8:5d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.23; Tue, 26 Sep 2023 20:40:13 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::a798:2371:34c5:4648]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::a798:2371:34c5:4648%7]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 20:40:13 +0000
From:   "Wang, Weilin" <weilin.wang@intel.com>
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Kan Liang" <kan.liang@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [RFC PATCH 00/25] Perf stat metric grouping with hardware
 information
Thread-Topic: [RFC PATCH 00/25] Perf stat metric grouping with hardware
 information
Thread-Index: AQHZ73g0BARn6iJkxEWaEIrGMatDWrAr3YYAgAG1dTA=
Date:   Tue, 26 Sep 2023 20:40:13 +0000
Message-ID: <CO6PR11MB563589E15DB12E3A98119990EEC3A@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
 <CAP-5=fU-jTKpo8j=7t_xbgnmQDT2+BcmmRY7SWb8e7tyRS7hQQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU-jTKpo8j=7t_xbgnmQDT2+BcmmRY7SWb8e7tyRS7hQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|DM4PR11MB5970:EE_
x-ms-office365-filtering-correlation-id: 5aff75d0-7d1c-4933-56cb-08dbbed0c8a6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aI9Yib5+nPSoXVTvuZPumV6aJQqLpWZ0w/bfk0H3Jfcnezhjarlp3FwZ2wzkBYQDaSHu07jb+VrcidbGc9dIVRDYchtb8+DcDof1VgwvB59NjdmBHrQGDN++FrWwuoHWZl4NtoqOwXcv18kcOhaY/+CH/m+8oR3im97m8eJlQ46fHgK3psS+fE5Cxe3qTRISKxye2Ftpvw/4ReQOaaEkiDlmRTfNWHJ8Xy6hX4DmErXmxRMK3aIe9cQGAMjrKbrvXnlelFjVgqUkonHVFLIxXgw8zFDP27QS9GEr6mn/yvIIi4gN0OxQ7XVwfmA66J50eHZfg21K3c3BjjlQnAOXn4KIjLBxiUw4H5ymnI5fRLQoEpI78IE6ZOX+SG4BjpEquI9GnCQRcY/c4bZrSLnmVx5mIp+/Y/cHzV6ylOix/dRIdsXnJKLuhquYDT1gj6EG06jQutaUntYSySNqM8HlNKcDpP/ugtDMOQuaW7AG8dNNcfMkMJDmji1vfZ+ngnZJwP5Bn/9/sRGOjgj57ddieExUmnvjulOR5tsAha3Loqi6IhJwAHvh0VnHLeEYxaGLJFENx1ZowHY0uz3nul7e386ze55rKHOv7n+dtXGSuAc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(9686003)(33656002)(53546011)(6506007)(7696005)(2906002)(86362001)(55016003)(966005)(478600001)(71200400001)(8676002)(4326008)(8936002)(82960400001)(41300700001)(38100700002)(83380400001)(38070700005)(66946007)(122000001)(5660300002)(52536014)(316002)(26005)(64756008)(54906003)(76116006)(66476007)(66446008)(6916009)(66556008)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjUwM0NuNzNveFdZVmFqcDNaQk8ySkxGTDljM1krMUVyZDVTQnFGYTJZZnBh?=
 =?utf-8?B?NnVUNHljZXl0QmprSmZaK1JKaVpCNDd6a2lEY3lFd3FsTWJyU1hoL0tuZEJZ?=
 =?utf-8?B?VjlRUFBWTTc1cGRTeWJ0ZDlHT2sxN3huT1RGRFVGdC95bjA3OTdTY3NSNVhQ?=
 =?utf-8?B?dzN4V0twNXFDOHpRUDJERmgzM2ZBR0k4MDR6d0RPS0hMNTFsMVVISTdDOFUr?=
 =?utf-8?B?S0w4Q3Nrem02OGJ0cXl6cUlUNGYzeHlUS0JneC9aTXk1UDQ2em9vUFp0Y25N?=
 =?utf-8?B?T2E3UEdtN3hWMHRHZkhoS0R4TnhoSXlZN2haTzVBQmtHajl5NGkvYkZYQmpu?=
 =?utf-8?B?cFZFT0U3Z2FoQ3JkUUdsWm9VRVk0UG1ITDRjUXFEbVFIbndyK3M5S2JpM1My?=
 =?utf-8?B?OTZ4RUpqaG94Ylo2TklFdHNBN0J1YnMzMVZiVlI5TVhRbE9XdzhKSnVtL1Fm?=
 =?utf-8?B?K0M5bE5pV1JVRE5nckhKSnNEOTJoNjNTeFVXYzlueXVNd25GR1loZ3F4Qjc1?=
 =?utf-8?B?NGJ5Ty9KdWFncGtmSXZKdGpsZWpsMGFXVEZQVFJuK1NROEtpekJQMGpnNEJt?=
 =?utf-8?B?QlRId0dzOFpRTjZLRit0dU94bFV6ZXhyVTdlODgvc2I5T3NNL2ZZMFUvVUhk?=
 =?utf-8?B?QktrcXBDQ0ZxU3d5a2VKZjdaNnVWaHR2VEFHSFJoY2hSMVI3eVYraEFsN3J0?=
 =?utf-8?B?WndINnJlNzNOcDVrTUkwaGl1elFLZHM5OU4zS1dEY0JzdWpiSXJGQnppd1I3?=
 =?utf-8?B?Ym8zOVIxRzlzYk94V21HQVFKTXhXLy9xNGNSVVBZSWx0bWRkRld2d0xqaDdz?=
 =?utf-8?B?M3dsSGVaYXczNGxlSXFkTXIyMnBrMkk5YUtJSmd2MmtqT0l0NTh5TmMxYjhV?=
 =?utf-8?B?dXVEQ0pRVEhJT3U4UG1lN3RDYW1YY0ZCaXRhWURHRy8zRE9JWjVGb3VPRitn?=
 =?utf-8?B?NkVsSlJQY2JoNnFybzFMSEQzZ2I2N21LVTZwNi9jU2pPendrZEU3QXRmNStT?=
 =?utf-8?B?MDlVd3gybmpDMnh5bDI3UEtLalo2UGZ0ZW5ZdmFzZG5sN2V4TVRrbUw3K2la?=
 =?utf-8?B?RjVISnlYU2lDWUdERnVHb0JTQmFVZkdLTG9qRVp3M2QzLzNsMGxhakkwajNX?=
 =?utf-8?B?R054cDQ3dnJIVWtNKzBmVW8xQ0xWdlVDVmFQdFNTVE05UzZsWERIYVBjOVhw?=
 =?utf-8?B?Z2VCUkE5S0xUMUM3d0VOSTZBMXp3WFAxaTBPc0VvSHRtbmFOYUlTZ0p6U2JV?=
 =?utf-8?B?VlIyTHNIVU9LLzkvY3FqSTlRWW9PSTYwQWpBbnpQank5VjRMbjY2c2NSRDg0?=
 =?utf-8?B?Z3N0RFRDTTVWZklRUDJKZzZtQ2RISWdYbitQTko2dytpYzV3bm5yMklhZ0tZ?=
 =?utf-8?B?ejBKcUdKZzQ0YnJTODhQbUtIa3dGSmpDM2I4eTg2ZlltNDl2MnVmZUxhekts?=
 =?utf-8?B?a2poUTU5TDdycmNwaHlNVmsyZGZrYlQyalJsVzkzNkFPMEx1dXBWMGlLR2Z6?=
 =?utf-8?B?L2x0RXNPYllvYUM3emwyN2FMS0owOHhuOTdjVjl2My9YOE54bUl1RmxLdWVB?=
 =?utf-8?B?c1R2YUdzbCtkVEdNVHp0WnF1YlIzdWdiTFNtNU54c2cxbWRyOGg0MDVkakMw?=
 =?utf-8?B?Slh3amd2ZmJKK2dKL3UzMXNUMjBlbWwrV2lVclVZSTZjbUpxMmY2Q3lwcjdS?=
 =?utf-8?B?YnVtSkFhU3FHZVFIUkpXRjRxV1IwOGRyV1RlWTJjQm0wM2FYQmxKMDlveW42?=
 =?utf-8?B?a1VxTTZjVndyTjZLVGh0OVNCdktIeFBtbktoU05lY2F6MHo4OUFkZ2FmYkVP?=
 =?utf-8?B?WVFSUTdUNjNHenNua3VRZXhwbkhtYnZGTnZ0RzVLUVltR2tRRkhhOEEzZHZp?=
 =?utf-8?B?eSt4d0FlRUIxYUNLSmZIUlNhMXpEYlRjSGNvZXF5am53WkxaS29YcDRIRE1q?=
 =?utf-8?B?U01FUU0wK2lVb2RES3BaU0ZMaUtrSkI5azJGZDJBMVQ4RkdlcklGdzZRVGdz?=
 =?utf-8?B?VEd2eTV5emZPSjVVUDQ1bHk1NG5QR2hHVEhJMVllNTl2cE5zcWlTZEZlU2Vw?=
 =?utf-8?B?cDI0NE9MVnZuaXFvSTJBbGt2TVZOTndLWDViczE3Qk5nSUVQNHo3d1UzU2pr?=
 =?utf-8?Q?XF87kmrPX51jKoRBT5C4rPnTv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aff75d0-7d1c-4933-56cb-08dbbed0c8a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 20:40:13.1459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: omqACDBbLkpL890SxNqyPyIZ5KlbiJ8LfxUsphOyb1o2n5RpCG514TE5dJUd5LiNGl3A04m+aCHBShEk1t0Z0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5970
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWFuIFJvZ2VycyA8aXJv
Z2Vyc0Bnb29nbGUuY29tPg0KPiBTZW50OiBNb25kYXksIFNlcHRlbWJlciAyNSwgMjAyMyAxMToz
MCBBTQ0KPiBUbzogV2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+IENjOiBQ
ZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdvIE1vbG5hciA8bWluZ29A
cmVkaGF0LmNvbT47DQo+IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyA8YWNtZUBrZXJuZWwub3Jn
PjsgQWxleGFuZGVyIFNoaXNoa2luDQo+IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwu
Y29tPjsgSmlyaSBPbHNhIDxqb2xzYUBrZXJuZWwub3JnPjsgTmFtaHl1bmcNCj4gS2ltIDxuYW1o
eXVuZ0BrZXJuZWwub3JnPjsgSHVudGVyLCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29t
PjsNCj4gS2FuIExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsgbGludXgtcGVyZi11
c2Vyc0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRh
eWxvciwgUGVycnkgPHBlcnJ5LnRheWxvckBpbnRlbC5jb20+OyBBbHQsDQo+IFNhbWFudGhhIDxz
YW1hbnRoYS5hbHRAaW50ZWwuY29tPjsgQmlnZ2VycywgQ2FsZWINCj4gPGNhbGViLmJpZ2dlcnNA
aW50ZWwuY29tPjsgTWFyayBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtSRkMgUEFUQ0ggMDAvMjVdIFBlcmYgc3RhdCBtZXRyaWMgZ3JvdXBpbmcgd2l0aCBo
YXJkd2FyZQ0KPiBpbmZvcm1hdGlvbg0KPiANCj4gT24gU3VuLCBTZXAgMjQsIDIwMjMgYXQgMTE6
MTnigK9QTSA8d2VpbGluLndhbmdAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFdl
aWxpbiBXYW5nIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+ID4NCj4gPiBQZXJmIHN0YXQgbWV0
cmljIGdyb3VwaW5nIGdlbmVyYXRlcyBldmVudCBncm91cHMgdGhhdCBhcmUgcHJvdmlkZWQgdG8N
Cj4gPiBrZXJuZWwgZm9yIGRhdGEgY29sbGVjdGlvbiB1c2luZyB0aGUgaGFyZHdhcmUgY291bnRl
cnMuIFNvbWV0aW1lcywgdGhlDQo+ID4gZ3JvdXBpbmcgbWlnaHQgZmFpbCBhbmQga2VybmVsIGhh
cyB0byByZXRyeSB0aGUgZ3JvdXBzIGJlY2F1c2UNCj4gPiBnZW5lcmF0ZWQgZ3JvdXBzIGRvIG5v
dCBmaXQgaW4gdGhlIGhhcmR3YXJlIGNvdW50ZXJzIGNvcnJlY3RseS4gSW4NCj4gPiBzb21lIG90
aGVyIGNhc2VzLCB0aGUgZ3JvdXBpbmdzIGFyZSBjb2xsZWN0ZWQgY29ycmVjdGx5LCBob3dldmVy
LCB0aGV5IGxlZnQNCj4gc29tZSBoYXJkd2FyZSBjb3VudGVycyB1bnVzZWQuDQo+ID4NCj4gPiBU
byBpbXByb3ZlIHRoZXNlIGluZWZmaWNpZW5jaWVzLCB3ZSB3b3VsZCBsaWtlIHRvIHByb3Bvc2Ug
YSBoYXJkd2FyZQ0KPiA+IGF3YXJlIGdyb3VwaW5nIG1ldGhvZCB0aGF0IGRvZXMgbWV0cmljL2V2
ZW50IGdyb3VwaW5nIGJhc2VkIG9uIGV2ZW50DQo+ID4gY291bnRlciByZXN0cmljdGlvbiBydWxl
cyBhbmQgdGhlIGF2YWlsYWJpbGl0eSBvZiBoYXJkd2FyZSBjb3VudGVycyBpbg0KPiA+IHRoZSBz
eXN0ZW0uIFRoaXMgbWV0aG9kIGlzIGdlbmVyaWMgYXMgbG9uZyBhcyBhbGwgdGhlIHJlc3RyaWN0
aW9uDQo+ID4gcnVsZXMgY291bGQgYmUgcHJvdmlkZWQgZnJvbSB0aGUgcG11LWV2ZW50IEpTT04g
ZmlsZXMuDQo+ID4NCj4gPiBUaGlzIHBhdGNoIHNldCBpbmNsdWRlcyBjb2RlIHRoYXQgZG9lcyBo
YXJkd2FyZSBhd2FyZSBncm91cGluZyBhbmQNCj4gPiB1cGRhdGVkIHBtdS1ldmVudCBKU09OIGZp
bGVzIGZvciBmb3VyIHBsYXRmb3JtcyAoU2FwcGhpcmVSYXBpZHMsDQo+ID4gSWNlbGFrZXgsIENh
c2NhZGVsYWtleCwgYW5kIFRpZ2VybGFrZSkgZm9yIHlvdXIgdGVzdGluZyBhbmQNCj4gPiBleHBl
cmltZW50aW5nLiBXZSd2ZSBzdWNjZXNzZnVsbHkgdGVzdGVkIHRoZXNlIHBhdGNoZXMgb24gdGhy
ZWUNCj4gPiBwbGF0Zm9ybXMgKFNhcHBoaXJlUmFwaWRzLCBJY2VsYWtleCwgYW5kIENhc2NhZGVs
YWtleCkgd2l0aCB0b3Bkb3duDQo+IG1ldHJpY3MgZnJvbSBUb3Bkb3duTDEgdG8gVG9wZG93bkw2
Lg0KPiA+DQo+ID4gVGhlcmUgYXJlIHNvbWUgb3B0aW1pemF0aW9uIG9wcG9ydHVuaXRpZXMgdGhh
dCB3ZSBtaWdodCBpbXBsZW1lbnQgaW4gdGhlDQo+IGZ1dHVyZToNCj4gPiAxKSBCZXR0ZXIgTk1J
IGhhbmxkaW5nOiB3aGVuIE5NSSB3YXRjaGRvZyBpcyBlbmFibGVkLCB3ZSByZWR1Y2UgdGhlDQo+
ID4gZGVmYXVsdF9jb3JlIHRvdGFsIGNvdW50ZXIgc2l6ZSBieSBvbmUuIFRoaXMgY291bGQgYmUg
aW1wcm92ZWQgdG8gYmV0dGVyDQo+IHV0aWxpemUgdGhlIGNvdW50ZXIuDQo+IA0KPiBUaGFua3Mg
V2VpbGluISBJJ20gY2hlY2tpbmcgb3V0IHRoZSBzZXJpZXMuIEhvcGVmdWxseSB0aGUgTk1JIHdh
dGNoZG9nIHBlcmYNCj4gZXZlbnQgY2FuIGdvIGF3YXkgc29vbiB3aXRoIHRoZSBidWRkeSBzY2hl
bWU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzA1MjcwMTQxNTMuMjc5Mzkz
MS0xLQ0KPiBkaWFuZGVyc0BjaHJvbWl1bS5vcmcvDQo+IEJ1dCBiZXR0ZXIgTk1JIGhhbmRsaW5n
IHdvdWxkIGJlIHRydWUgZm9yIHBlb3BsZSB3aXRob3V0IHRoZSBsYXRlc3Qga2VybmVsLg0KPiAN
Cj4gVGhhbmtzLA0KPiBJYW4NCj4gDQpUaGFua3MgSWFuISBJIHdpbGwgdXBkYXRlIHRoZSBOTUkg
aGFuZGxpbmcgaW4gbmV4dCB2ZXJzaW9uLiANCg0KPiA+IDIpIEZpbGwgaW1wb3J0YW50IGV2ZW50
cyBpbnRvIHVudXNlZCBjb3VudGVyIGZvciBiZXR0ZXIgY291bnRlciB1dGxpemF0aW9uOg0KPiA+
IHRoZXJlIG1pZ2h0IGJlIHNvbWUgdW51c2VkIGNvdW50ZXJzIHNjYXR0ZXJlZCBpbiB0aGUgZ3Jv
dXBzLiBXZSBjb3VsZA0KPiA+IGNvbnNpZGVyIHRvIGFkZCBpbXBvcnRhbnQgZXZlbnRzIGluIHRo
aXMgc2xvdHMgaWYgbmVjZXNzYXJ5LiBUaGlzDQo+ID4gY291bGQgaGVscCBpbmNyZWFzZSB0aGUg
bXVsdGlwbGV4aW5nIHBlcmNlbnRhZ2UgYW5kIGhlbHAgaW1wcm92ZSBhY2N1cmFjeSBpZg0KPiB0
aGUgZXZlbnQgaXMgY3JpdGljYWwuDQo+ID4NCj4gPiBSZW1haW5pbmcgcXVlc3Rpb25zIGZvciBk
aWN1c3Npb246DQo+ID4gMykgV2hlcmUgdG8gc3RhcnQgZ3JvdXBpbmcgZnJvbT8gVGhlIGN1cnJl
bnQgaW1wbGVtZW50YXRpb24gc3RhcnQNCj4gPiBncm91cGluZyBieSBjb21iaW5pbmcgYWxsIHRo
ZSBldmVudHMgaW50byBhIHNpbmdsZSBsaXN0LiBUaGlzIHN0ZXANCj4gPiBkZWR1cGxpY2F0ZXMg
ZXZlbnRzLiBCdXQgaXQgZG9lcyBub3QgbWFpbnRhaW4gdGhlIHJlbGF0aW9uc2hpcCBvZiBldmVu
dHMNCj4gYWNjb3JkaW5nIHRvIHRoZSBtZXRyaWNzLCBpLmUuDQo+ID4gZXZlbnRzIHJlcXVpcmVk
IGJ5IG9uZSBtZXRyaWMgbWF5IG5vdCBiZSBjb2xsZWN0ZWQgYXQgdGhlIHNhbWUgdGltZS4NCj4g
PiBBbm90aGVyIHR5cGUgb2Ygc3RhcnRpbmcgcG9pbnQgd291bGQgYmUgZ3JvdXBpbmcgZWFjaCBp
bmRpdmlkdWFsDQo+ID4gbWV0cmljIGFuZCB0aGVuIHRyeSB0byBtZXJnZSB0aGUgZ3JvdXBzLg0K
PiA+IDQpIEFueSBjb21tZW50cywgc3VnZ2VzdGlvbnMsIG5ldyBpZGVhcz8NCj4gPiA1KSBJZiB5
b3UgYXJlIGludGVyZXN0ZWQgdG8gdGVzdCB0aGUgcGF0Y2ggb3V0IGFuZCB0aGUgcG11LWV2ZW50
IEpTT04NCj4gPiBmaWxlcyBvZiB5b3VyIHRlc3RpbmcgcGxhdGZvcm0gaXMgbm90IHByb3ZpZGVk
IGhlcmUsIHBsZWFzZSBsZXQgbWUNCj4gPiBrbm93IHNvIHRoYXQgSSBjb3VsZCBwcm92aWRlIHlv
dSB0aGUgZmlsZXMuDQo+ID4NCj4gPg0KPiA+IFdlaWxpbiBXYW5nICgyNSk6DQo+ID4gICBwZXJm
IHN0YXQ6IEFkZCBoYXJkd2FyZS1ncm91cGluZyBjbWQgb3B0aW9uIHRvIHBlcmYgc3RhdA0KPiA+
ICAgcGVyZiBzdGF0OiBBZGQgYmFzaWMgZnVuY3Rpb25zIGZvciB0aGUgaGFyZHdhcmUtZ3JvdXBp
bmcgc3RhdCBjbWQNCj4gPiAgICAgb3B0aW9uDQo+ID4gICBwZXJmIHBtdS1ldmVudHM6IEFkZCBm
dW5jdGlvbnMgaW4gamV2ZW50LnB5DQo+ID4gICBwZXJmIHBtdS1ldmVudHM6IEFkZCBjb3VudGVy
IGluZm8gaW50byBKU09OIGZpbGVzIGZvciBTYXBwaGlyZVJhcGlkcw0KPiA+ICAgcGVyZiBwbXUt
ZXZlbnRzOiBBZGQgZXZlbnQgY291bnRlciBkYXRhIGZvciBDYXNjYWRlbGFrZXgNCj4gPiAgIHBl
cmYgcG11LWV2ZW50czogQWRkIGV2ZW50IGNvdW50ZXIgZGF0YSBmb3IgSWNlbGFrZXgNCj4gPiAg
IHBlcmYgc3RhdDogQWRkIGhlbHBlciBmdW5jdGlvbnMgZm9yIGhhcmR3YXJlLWdyb3VwaW5nIG1l
dGhvZA0KPiA+ICAgcGVyZiBzdGF0OiBBZGQgZnVuY3Rpb25zIHRvIGdldCBjb3VudGVyIGluZm8N
Cj4gPiAgIHBlcmYgc3RhdDogQWRkIGhlbHBlciBmdW5jdGlvbnMgZm9yIGhhcmR3YXJlLWdyb3Vw
aW5nIG1ldGhvZA0KPiA+ICAgcGVyZiBzdGF0OiBBZGQgaGVscGVyIGZ1bmN0aW9ucyB0byBoYXJk
d2FyZS1ncm91cGluZyBtZXRob2QNCj4gPiAgIHBlcmYgc3RhdDogQWRkIHV0aWxpdHkgZnVuY3Rp
b25zIHRvIGhhcmR3YXJlLWdyb3VwaW5nIG1ldGhvZA0KPiA+ICAgcGVyZiBzdGF0OiBBZGQgbW9y
ZSBmdW5jdGlvbnMgZm9yIGhhcmR3YXJlLWdyb3VwaW5nIG1ldGhvZA0KPiA+ICAgcGVyZiBzdGF0
OiBBZGQgZnVuY3Rpb25zIHRvIGhhcmR3YXJlLWdyb3VwaW5nIG1ldGhvZA0KPiA+ICAgcGVyZiBz
dGF0OiBBZGQgYnVpbGQgc3RyaW5nIGZ1bmN0aW9uIGFuZCB0b3Bkb3duIGV2ZW50cyBoYW5kbGlu
ZyBpbg0KPiA+ICAgICBoYXJkd2FyZS1ncm91cGluZw0KPiA+ICAgcGVyZiBzdGF0OiBBZGQgZnVu
Y3Rpb24gdG8gY29tYmluZSBtZXRyaWNzIGZvciBoYXJkd2FyZS1ncm91cGluZw0KPiA+ICAgcGVy
ZiBzdGF0OiBVcGRhdGUga2V5d29yZCBjb3JlIHRvIGRlZmF1bHRfY29yZSB0byBhZGp1c3QgdG8g
dGhlDQo+ID4gICAgIGNoYW5nZXMgZm9yIGV2ZW50cyB3aXRoIG5vIHVuaXQNCj4gPiAgIHBlcmYg
c3RhdDogSGFuZGxlIHRha2VuIGFsb25lIGluIGhhcmR3YXJlLWdyb3VwaW5nDQo+ID4gICBwZXJm
IHN0YXQ6IEhhbmRsZSBOTUkgaW4gaGFyZHdhcmUtZ3JvdXBpbmcNCj4gPiAgIHBlcmYgc3RhdDog
SGFuZGxlIGdyb3VwaW5nIG1ldGhvZCBmYWxsIGJhY2sgaW4gaGFyZHdhcmUtZ3JvdXBpbmcNCj4g
PiAgIHBlcmYgc3RhdDogQ29kZSByZWZhY3RvcmluZyBpbiBoYXJkd2FyZS1ncm91cGluZw0KPiA+
ICAgcGVyZiBzdGF0OiBBZGQgdG9vbCBldmVudHMgc3VwcG9ydCBpbiBoYXJkd2FyZS1ncm91cGlu
Zw0KPiA+ICAgcGVyZiBzdGF0OiBBZGQgVFNDIHN1cHBvcnQgaW4gaGFyZHdhcmUtZ3JvdXBpbmcN
Cj4gPiAgIHBlcmYgc3RhdDogRml4IGEgcmV0dXJuIGVycm9yIGlzc3VlIGluIGhhcmR3YXJlLWdy
b3VwaW5nDQo+ID4gICBwZXJmIHN0YXQ6IEFkZCBjaGVjayB0byBlbnN1cmUgY29ycmVjdG5lc3Mg
aW4gcGxhdGZvcm0gdGhhdCBkb2VzIG5vdA0KPiA+ICAgICBzdXBwb3J0IGhhcmR3YXJlLWdyb3Vw
aW5nDQo+ID4gICBwZXJmIHBtdS1ldmVudHM6IEFkZCBldmVudCBjb3VudGVyIGRhdGEgZm9yIFRp
Z2VybGFrZQ0KPiA+DQo+ID4gIHRvb2xzL2xpYi9iaXRtYXAuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMjAgKw0KPiA+ICB0b29scy9wZXJmL2J1aWx0aW4tc3RhdC5jICAgICAgICAg
ICAgICAgICAgICAgfCAgICA3ICsNCj4gPiAgLi4uL2FyY2gveDg2L2Nhc2NhZGVsYWtleC9jYWNo
ZS5qc29uICAgICAgICAgIHwgMTIzNyArKysrKysrKysrKysNCj4gPiAgLi4uL2FyY2gveDg2L2Nh
c2NhZGVsYWtleC9jb3VudGVyLmpzb24gICAgICAgIHwgICAxNyArDQo+ID4gIC4uLi9hcmNoL3g4
Ni9jYXNjYWRlbGFrZXgvZmxvYXRpbmctcG9pbnQuanNvbiB8ICAgMTYgKw0KPiA+ICAuLi4vYXJj
aC94ODYvY2FzY2FkZWxha2V4L2Zyb250ZW5kLmpzb24gICAgICAgfCAgIDY4ICsNCj4gPiAgLi4u
L2FyY2gveDg2L2Nhc2NhZGVsYWtleC9tZW1vcnkuanNvbiAgICAgICAgIHwgIDc1MSArKysrKysr
Kw0KPiA+ICAuLi4vYXJjaC94ODYvY2FzY2FkZWxha2V4L290aGVyLmpzb24gICAgICAgICAgfCAg
MTY4ICsrDQo+ID4gIC4uLi9hcmNoL3g4Ni9jYXNjYWRlbGFrZXgvcGlwZWxpbmUuanNvbiAgICAg
ICB8ICAxMDIgKw0KPiA+ICAuLi4vYXJjaC94ODYvY2FzY2FkZWxha2V4L3VuY29yZS1jYWNoZS5q
c29uICAgfCAxMTM4ICsrKysrKysrKysrDQo+ID4gIC4uLi94ODYvY2FzY2FkZWxha2V4L3VuY29y
ZS1pbnRlcmNvbm5lY3QuanNvbiB8IDEyNzIgKysrKysrKysrKysrKw0KPiA+ICAuLi4vYXJjaC94
ODYvY2FzY2FkZWxha2V4L3VuY29yZS1pby5qc29uICAgICAgfCAgMzk0ICsrKysNCj4gPiAgLi4u
L2FyY2gveDg2L2Nhc2NhZGVsYWtleC91bmNvcmUtbWVtb3J5Lmpzb24gIHwgIDUwOSArKysrKw0K
PiA+ICAuLi4vYXJjaC94ODYvY2FzY2FkZWxha2V4L3VuY29yZS1wb3dlci5qc29uICAgfCAgIDI1
ICsNCj4gPiAgLi4uL2FyY2gveDg2L2Nhc2NhZGVsYWtleC92aXJ0dWFsLW1lbW9yeS5qc29uIHwg
ICAyOCArDQo+ID4gIC4uLi9wbXUtZXZlbnRzL2FyY2gveDg2L2ljZWxha2V4L2NhY2hlLmpzb24g
ICB8ICAgOTggKw0KPiA+ICAuLi4vcG11LWV2ZW50cy9hcmNoL3g4Ni9pY2VsYWtleC9jb3VudGVy
Lmpzb24gfCAgIDE3ICsNCj4gPiAgLi4uL2FyY2gveDg2L2ljZWxha2V4L2Zsb2F0aW5nLXBvaW50
Lmpzb24gICAgIHwgICAxMyArDQo+ID4gIC4uLi9hcmNoL3g4Ni9pY2VsYWtleC9mcm9udGVuZC5q
c29uICAgICAgICAgICB8ICAgNTUgKw0KPiA+ICAuLi4vcG11LWV2ZW50cy9hcmNoL3g4Ni9pY2Vs
YWtleC9tZW1vcnkuanNvbiAgfCAgIDUzICsNCj4gPiAgLi4uL3BtdS1ldmVudHMvYXJjaC94ODYv
aWNlbGFrZXgvb3RoZXIuanNvbiAgIHwgICA1MiArDQo+ID4gIC4uLi9hcmNoL3g4Ni9pY2VsYWtl
eC9waXBlbGluZS5qc29uICAgICAgICAgICB8ICAgOTIgKw0KPiA+ICAuLi4vYXJjaC94ODYvaWNl
bGFrZXgvdW5jb3JlLWNhY2hlLmpzb24gICAgICAgfCAgOTY1ICsrKysrKysrKysNCj4gPiAgLi4u
L3g4Ni9pY2VsYWtleC91bmNvcmUtaW50ZXJjb25uZWN0Lmpzb24gICAgIHwgMTY2NyArKysrKysr
KysrKysrKysrKw0KPiA+ICAuLi4vYXJjaC94ODYvaWNlbGFrZXgvdW5jb3JlLWlvLmpzb24gICAg
ICAgICAgfCAgOTY2ICsrKysrKysrKysNCj4gPiAgLi4uL2FyY2gveDg2L2ljZWxha2V4L3VuY29y
ZS1tZW1vcnkuanNvbiAgICAgIHwgIDE4NiArKw0KPiA+ICAuLi4vYXJjaC94ODYvaWNlbGFrZXgv
dW5jb3JlLXBvd2VyLmpzb24gICAgICAgfCAgIDI2ICsNCj4gPiAgLi4uL2FyY2gveDg2L2ljZWxh
a2V4L3ZpcnR1YWwtbWVtb3J5Lmpzb24gICAgIHwgICAyMiArDQo+ID4gIC4uLi9hcmNoL3g4Ni9z
YXBwaGlyZXJhcGlkcy9jYWNoZS5qc29uICAgICAgICB8ICAxMDQgKw0KPiA+ICAuLi4vYXJjaC94
ODYvc2FwcGhpcmVyYXBpZHMvY291bnRlci5qc29uICAgICAgfCAgIDE3ICsNCj4gPiAgLi4uL3g4
Ni9zYXBwaGlyZXJhcGlkcy9mbG9hdGluZy1wb2ludC5qc29uICAgIHwgICAyNSArDQo+ID4gIC4u
Li9hcmNoL3g4Ni9zYXBwaGlyZXJhcGlkcy9mcm9udGVuZC5qc29uICAgICB8ICAgOTggKy0NCj4g
PiAgLi4uL2FyY2gveDg2L3NhcHBoaXJlcmFwaWRzL21lbW9yeS5qc29uICAgICAgIHwgICA0NCAr
DQo+ID4gIC4uLi9hcmNoL3g4Ni9zYXBwaGlyZXJhcGlkcy9vdGhlci5qc29uICAgICAgICB8ICAg
NDAgKw0KPiA+ICAuLi4vYXJjaC94ODYvc2FwcGhpcmVyYXBpZHMvcGlwZWxpbmUuanNvbiAgICAg
fCAgMTE4ICsrDQo+ID4gIC4uLi9hcmNoL3g4Ni9zYXBwaGlyZXJhcGlkcy91bmNvcmUtY2FjaGUu
anNvbiB8ICA1MzQgKysrKystDQo+ID4gIC4uLi9hcmNoL3g4Ni9zYXBwaGlyZXJhcGlkcy91bmNv
cmUtY3hsLmpzb24gICB8ICAgNTYgKw0KPiA+ICAuLi4vc2FwcGhpcmVyYXBpZHMvdW5jb3JlLWlu
dGVyY29ubmVjdC5qc29uICAgfCAgNDc2ICsrKysrDQo+ID4gIC4uLi9hcmNoL3g4Ni9zYXBwaGly
ZXJhcGlkcy91bmNvcmUtaW8uanNvbiAgICB8ICAzNzMgKysrKw0KPiA+ICAuLi4veDg2L3NhcHBo
aXJlcmFwaWRzL3VuY29yZS1tZW1vcnkuanNvbiAgICAgfCAgMzkxICsrKysNCj4gPiAgLi4uL2Fy
Y2gveDg2L3NhcHBoaXJlcmFwaWRzL3VuY29yZS1wb3dlci5qc29uIHwgICAyNCArDQo+ID4gIC4u
Li94ODYvc2FwcGhpcmVyYXBpZHMvdmlydHVhbC1tZW1vcnkuanNvbiAgICB8ICAgMjAgKw0KPiA+
ICAuLi4vcG11LWV2ZW50cy9hcmNoL3g4Ni90aWdlcmxha2UvY2FjaGUuanNvbiAgfCAgIDY1ICsN
Cj4gPiAgLi4uL2FyY2gveDg2L3RpZ2VybGFrZS9jb3VudGVyLmpzb24gICAgICAgICAgIHwgICAg
NyArDQo+ID4gIC4uLi9hcmNoL3g4Ni90aWdlcmxha2UvZmxvYXRpbmctcG9pbnQuanNvbiAgICB8
ICAgMTMgKw0KPiA+ICAuLi4vYXJjaC94ODYvdGlnZXJsYWtlL2Zyb250ZW5kLmpzb24gICAgICAg
ICAgfCAgIDU2ICsNCj4gPiAgLi4uL3BtdS1ldmVudHMvYXJjaC94ODYvdGlnZXJsYWtlL21lbW9y
eS5qc29uIHwgICAzMSArDQo+ID4gIC4uLi9wbXUtZXZlbnRzL2FyY2gveDg2L3RpZ2VybGFrZS9v
dGhlci5qc29uICB8ICAgIDQgKw0KPiA+ICAuLi4vYXJjaC94ODYvdGlnZXJsYWtlL3BpcGVsaW5l
Lmpzb24gICAgICAgICAgfCAgIDk2ICsNCj4gPiAgLi4uL3g4Ni90aWdlcmxha2UvdW5jb3JlLWlu
dGVyY29ubmVjdC5qc29uICAgIHwgICAxMSArDQo+ID4gIC4uLi9hcmNoL3g4Ni90aWdlcmxha2Uv
dW5jb3JlLW1lbW9yeS5qc29uICAgICB8ICAgIDYgKw0KPiA+ICAuLi4vYXJjaC94ODYvdGlnZXJs
YWtlL3VuY29yZS1vdGhlci5qc29uICAgICAgfCAgICAxICsNCj4gPiAgLi4uL2FyY2gveDg2L3Rp
Z2VybGFrZS92aXJ0dWFsLW1lbW9yeS5qc29uICAgIHwgICAyMCArDQo+ID4gIHRvb2xzL3BlcmYv
cG11LWV2ZW50cy9qZXZlbnRzLnB5ICAgICAgICAgICAgICB8ICAxNzkgKy0NCj4gPiAgdG9vbHMv
cGVyZi9wbXUtZXZlbnRzL3BtdS1ldmVudHMuaCAgICAgICAgICAgIHwgICAyNiArLQ0KPiA+ICB0
b29scy9wZXJmL3V0aWwvbWV0cmljZ3JvdXAuYyAgICAgICAgICAgICAgICAgfCAgOTI3ICsrKysr
KysrKw0KPiA+ICB0b29scy9wZXJmL3V0aWwvbWV0cmljZ3JvdXAuaCAgICAgICAgICAgICAgICAg
fCAgIDgyICsNCj4gPiAgdG9vbHMvcGVyZi91dGlsL3BtdS5jICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgNSArDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9wbXUuaCAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgIDEgKw0KPiA+ICB0b29scy9wZXJmL3V0aWwvc3RhdC5oICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgICAxICsNCj4gPiAgNjAgZmlsZXMgY2hhbmdlZCwgMTM3OTAgaW5zZXJ0
aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCB0b29scy9w
ZXJmL3BtdS1ldmVudHMvYXJjaC94ODYvY2FzY2FkZWxha2V4L2NvdW50ZXIuanNvbg0KPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQNCj4gPiB0b29scy9wZXJmL3BtdS1ldmVudHMvYXJjaC94ODYvaWNl
bGFrZXgvY291bnRlci5qc29uDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IHRvb2xzL3Bl
cmYvcG11LWV2ZW50cy9hcmNoL3g4Ni9zYXBwaGlyZXJhcGlkcy9jb3VudGVyLmpzb24NCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gdG9vbHMvcGVyZi9wbXUtZXZlbnRzL2FyY2gveDg2L3Rp
Z2VybGFrZS9jb3VudGVyLmpzb24NCj4gPg0KPiA+IC0tDQo+ID4gMi4zOS4zDQo+ID4NCg==
