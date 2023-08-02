Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190F576C51F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjHBGC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjHBGC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:02:27 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D742121;
        Tue,  1 Aug 2023 23:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690956146; x=1722492146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HZn4fkZGA6QrZn2br3L4Y0iHNzhmUrBl15Pg02hMGiw=;
  b=Ao9jJSynUsS633vTwtN91+4B05ok3pHYZ3Xki4mBKxMnT/pxheGI5fp7
   nqgA8V+74x2/VWohv3EPz73nd1CZcadG7s/RE8ssyPH/9u8pDKn5GHPlp
   X+fHkH7qSsra0I0ExQKb9ZzgVUBua0KdSXDjwBZuZFTVJ9LSL6Z8QNzo1
   YUuKSFDwYOwx1w7Uu+vRw5AoKzymhaKjpFRVUl10K6yiszEdi3V7bcXuI
   +P68cdRavaQoGekcZE4nan6zh7Ci4KQ0YAtZZpeCwazojQ71CWr1KKWuV
   sO9wg64UuHQlbDlBQpYydtD323+nXvI9AAEI/qCVEpDnvewNjnewwlDGy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="349793839"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="349793839"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 23:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872344368"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 01 Aug 2023 23:02:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 23:02:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 23:02:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 23:02:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 23:02:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SltGe4vKHYLvgB8k+t+p7pydg++kkJG2RCg9Oi9FQYjpUGpxNazLl8Nclr2wrOns3VF+G91hW3z4eyfJF9oIdwL1STonm3eUZXfxJeHXdNLchMrtUENvF2k/cRaNMH6E0+wxGY6Xhfz55JZ2Vk+w1skdU+VY7Ghd7qzdU8NcDNcHbPH27p3WS10jBqstuPw4idfRCkKTb86f97lz1z77TF4J0hbTykZZrSiePRwMIpE0pV2xECDJK/qKDXkI/v5ehqqhm7RHmxZnpk5rUPEfxd6cmQHfNQY/+j1nmvApQaC3mWCA7iOKhgx1DMi+44aHsksH9pvVn92L5jrFADTpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZn4fkZGA6QrZn2br3L4Y0iHNzhmUrBl15Pg02hMGiw=;
 b=i2ueIXF78sgeLHbrY5HxFpq9OeoDsuyHum6BJYG4WFAlW88e6hwil3hhwTajTbmLwOZKwXr7YJMaivAB7zWZWsslIIYYmIm/nN0bDrMD9qJYZnVVDE3twWd8E6dXlIS5Pw3fvfm5j3HbTK83D1cIc2NZoHIwPPDpg7iaksFdLUkM55e7r0BywiuL/s7GNM6oXU/njF1aR9sPXosSzw6bdG/yoI+D/nix5TOnxtxDyUGTQZciAznu2DDPanb2xz1K3pkR0Mh1cSVeUrj5AMJGypZShrO6s3G/gN7CWhE8K63/mI39a+9oQaqztKvV8qmWLbMsgpn8nONkczeVa3Q6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by PH0PR11MB5805.namprd11.prod.outlook.com (2603:10b6:510:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:02:12 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::cb1f:f744:409c:69b3]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::cb1f:f744:409c:69b3%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 06:02:12 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Huang, Ying" <ying.huang@intel.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Thread-Topic: [PATCH v2 2/3] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Thread-Index: AQHZutnYLMGgFuTJ3EWyF7wdkiGiPq/HdSKAgADQPDuADlKvgA==
Date:   Wed, 2 Aug 2023 06:02:12 +0000
Message-ID: <e3c253709ff5fd6a456d4b28b94b8a8a6b12be44.camel@intel.com>
References: <20230720-vv-kmem_memmap-v2-0-88bdaab34993@intel.com>
         <20230720-vv-kmem_memmap-v2-2-88bdaab34993@intel.com>
         <87a5vmadcw.fsf@linux.ibm.com>
         <87351e2e43.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87351e2e43.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|PH0PR11MB5805:EE_
x-ms-office365-filtering-correlation-id: 571cb8e2-6e38-4bfd-38e6-08db931e03e9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yk6k14ai73Ol4ADQa89ZunDoprbt2d/soI/ZqwwbSxc1k0/++jXXolCpo0xHjspU0RsX0wBM8GydtAMmxqK97J63ZA/uUhVK3X5AKfpKJcLA3CpZIwczcSaGRJOfmwdFhWGlL/csCh/2UV0qCuqv5801nM09OlPc/B0vaeshNnrKF4PwZdvIjhlN+qBjkXnuZpkXoOcUBHjBM8kqobPDHdeYfv6PgQ/vMFkkhkQ47hozfptyLZoXzRPLxzApNMdZvu5JIJlHgcUJUOVqyOQ6UcYpPNzaLwQ5pQCwvnIGLRWN/OlK8qqk7g2EZnVJQnSqjk8nQM0+m37gsAA6GIwN+QjnEJLymDrxy5ylXWbKm0X2qJJlW1yhv8xrTwffQM0/AtOi4kv8Is9xvKwu3kPG92TTOhdSeu+FnoYXwqHP9BA69/a6FiBQ7gm98JxVCiF7+B/5Rwb3LSWMMcBmvZ0SFDDscrVj8WKBiwmpxANb9Besi0UMug+X44VOM/KpYoqSTG0ttJCkVodVWsGL33bgcGTmcbJUcXXRExdT9skLNlN6SpWdZ1fnIn5CLm/A3xyuXjJg54picPMpSwYdexVsf25nLB+Ylw2TNH50Vrjg6YufueD8Af9+JDdJXsqLzdE5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(186003)(2616005)(36756003)(6512007)(316002)(86362001)(122000001)(478600001)(54906003)(110136005)(38100700002)(66946007)(76116006)(66446008)(66556008)(66476007)(71200400001)(64756008)(6486002)(4326008)(26005)(82960400001)(6506007)(41300700001)(8936002)(8676002)(38070700005)(7416002)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDJBbzlZUHNrb0lrZzFXdFpPRWtzUm8wU2xTanRMKzcyaU1USlp2b1Fwb3cx?=
 =?utf-8?B?K1dvdkVETGFRTUVPejcrVU1BZG9VcytlRThMVk1QRHdISDJSeHNwV2hFU0dp?=
 =?utf-8?B?Uy9ldzRyaU9KRXRoU2srakZpV09uaHh2TlQwbVZySHB1MWNoS01jWTh3MTdB?=
 =?utf-8?B?SDFjMHY1U1pTdGs3ZzB4Z0o3eVZyRk9hU0IxSXRZZFZSZll0R1UzK096UGZP?=
 =?utf-8?B?ZjhWeTZJa3p2UGZZSEpTQjJDNWpudGE1OEt6WkpvMzNQaWxjOGo5Smk4OFV2?=
 =?utf-8?B?angxR0tuKzFEZlBVZ0p2a1Y5b2N3UHBUV1o3SFJpY2xiWjJqRmM5cnkxRnNx?=
 =?utf-8?B?cnl2S0E0czhhS0ZFcFhMRUdYY3lORTI2d3J2OVNZcjMxMGQ3K3JIZWtGeStw?=
 =?utf-8?B?WDlJKzNHLzdobjlUWVpiN09VdGVkcGxFMkVLYWtnOTg0TE9IVExZY1E4cmEz?=
 =?utf-8?B?SHp6cVBEVFFVRTVRdkdTWG5jdEViTTFDb3hlVjdHaXZFaTRzaUpCRi96ZW1k?=
 =?utf-8?B?SHBlUk40YUhvdTlmQ1orZitBaG9YYU4vRGZkRHZHaGlYYnRkczJRQStLWXFH?=
 =?utf-8?B?N1BMakQybG1ZVnZGYllrQ0FJcEVyS2tmZW1HMU5PU1hLalMvSmJENC8xT2hE?=
 =?utf-8?B?VHVKN3RKZjlkT1VPZloyOXhYVUdaSDJXL0YrNVoyQnZMY2srY0hOK1R6SUU1?=
 =?utf-8?B?UDNrOWlxYmRCRS9OdGR0V3lxUXZNVXRpTDBXSXdlYys0OGViK3dKbi9IaHZQ?=
 =?utf-8?B?ODZoYlNBblhLc3dHb3NpdFZpZjlDNUFHdHJla0xzVktya2Ezb2F1a1cySW1p?=
 =?utf-8?B?S05oU0RTVW9RdzR4WXY1MFcrS01wZzZ4UHUrTkxrZTR1ZDdHeHZXQXBXdzV0?=
 =?utf-8?B?T3BTa2RiMnFYeUhKV0plOEpmbW5vbFE3OEJTQmsxVTJGbENUbEpqTk5PVmdq?=
 =?utf-8?B?VGpIUEpLT05JbENZeG4rbDdOVURKemI1OU9OdERTSHMvUFB0Tkp5Wk1PNmYr?=
 =?utf-8?B?MHliRkNIWkU5MzFjTnN6RWVFT1QxeUpoMkZ1WEhsQkRHdXdYVzFPQVhFVXZJ?=
 =?utf-8?B?SUpLNTNtYzM1OW5MWUxTYklackFaVFdGR1FEeHNUT0U0a3duR3k1S1YvZEJj?=
 =?utf-8?B?MjExck55cVU1a0pxeE55YncvcXp1bHJ2djhXbDFLUEVWK3dOZmFsSWwyd2hx?=
 =?utf-8?B?SzlTRkZrK25Ga293ZVpBMkNCNUszUU8zRDNPNk1nZFhoSDM3Q3V4Z1B4ZUQ0?=
 =?utf-8?B?Q3RCbGY0SW52ejVXNFpJUG9nUTJoTklGZ0JBeVU4K0J6dUxkOXRmd20xMzJj?=
 =?utf-8?B?ejdvcXU3M1N2V05jdStpanRrVC8wMllpMHRsaTg4S0xDUFhhaTBKTzV5KzJN?=
 =?utf-8?B?NFF2NktHRlY1cjNZaCtVYlQyNE52S1Q2SG1nL2Y4ZkxHeWJtQ1Ntdnpsck9R?=
 =?utf-8?B?ZEVMa0Y0eER2S1JTcGUrTGVvVm4vNkNUNEl6NDN4YW8yZ0pzNDhIajR4cHk1?=
 =?utf-8?B?aEwwbkJUMmFHczdhR3ltbnhGcDcxQkJ2K0FLdlpqN1dLV0tIRE85RVdTaHRi?=
 =?utf-8?B?bzF4cmN3QWkyOENhUDkyUUQrcnhzYTFLbVE0NHB5NnJTMi9XZTE1azNmSVNC?=
 =?utf-8?B?N1BNakREVyt6d1dPMU82TUpxcFZMaWR1OUYybTRxTy90SE04U2hhRnJuMTlp?=
 =?utf-8?B?YnlCdHF3RlhSbDZ0YnlDbkdrR1dxVFBabUN3a1Nqb1cwS1VaWVF2UkVMTDcv?=
 =?utf-8?B?OXJIaE5oUmhwS3ZvNmp4UlRDN3hVdWVDNkRnOHhtVFJPVVphKzVuaFVXSFR3?=
 =?utf-8?B?dDFDdk81ZGZYYytINTZYZTBZTmtraEJ6TWlTanBxcFB2d01RdjFpd1FwZGdw?=
 =?utf-8?B?MUpSU1FQK3ovR3FXRUVacllxNnhNQ0Zoc0VSaFMvSy9iU0ZqU0pYR21XNHcw?=
 =?utf-8?B?UHJjeDV2Ymc2dmxFR3kwTmRPcFpxcjBiV204L2M5UW5wblE2QlR2aVBKWUVh?=
 =?utf-8?B?eHZKdXp0Rnp0OXdsTGFQWlYybjVqM0NlMzJrZUIyZ00xQlF4R25GRzVmdUVH?=
 =?utf-8?B?aUkxWHl1UWEyZlJJN2svYk9XUkdRUnprRk54bDl3dXkvYXJKL0wwdE5KNTE4?=
 =?utf-8?B?eXltTEVtMXFlWFFMbFMrcloxN3J2aHczU0VYMGRqS2owZDc1bkh0elhteW9M?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BE1D7F12D2B344680F74468D4E41E25@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 571cb8e2-6e38-4bfd-38e6-08db931e03e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 06:02:12.6372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ck2dv/DclUe+/RTl9OdLtV3Th/KtutZv2kzQ9lHoiPp/gbQ82zHNVhklNfRL5BUmbKTHBVb/SgbVQJaZ54q99FppIXuEHcMO986OUHMD1IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5805
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

T24gTW9uLCAyMDIzLTA3LTI0IGF0IDExOjE2ICswODAwLCBIdWFuZywgWWluZyB3cm90ZToKPiAi
QW5lZXNoIEt1bWFyIEsuViIgPGFuZWVzaC5rdW1hckBsaW51eC5pYm0uY29tPiB3cml0ZXM6Cj4g
PiAKPiA+ID4gQEAgLTEzMzksMjcgKzEzNjcsMjAgQEAgaW50IF9fcmVmIGFkZF9tZW1vcnlfcmVz
b3VyY2UoaW50IG5pZCwKPiA+ID4gc3RydWN0IHJlc291cmNlICpyZXMsIG1ocF90IG1ocF9mbGFn
cykKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoC8qCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgKiBTZWxm
IGhvc3RlZCBtZW1tYXAgYXJyYXkKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gPiAtwqDC
oMKgwqDCoMKgwqBpZiAobWhwX2ZsYWdzICYgTUhQX01FTU1BUF9PTl9NRU1PUlkpIHsKPiA+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghbWhwX3N1cHBvcnRzX21lbW1hcF9v
bl9tZW1vcnkoc2l6ZSkpIHsKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXQgPSAtRUlOVkFMOwo+ID4gPiArwqDCoMKgwqDCoMKgwqBpZiAoKG1o
cF9mbGFncyAmIE1IUF9NRU1NQVBfT05fTUVNT1JZKSAmJgo+ID4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqAgbWhwX3N1cHBvcnRzX21lbW1hcF9vbl9tZW1vcnkobWVtYmxvY2tfc2l6ZSkpIHsKPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZvciAoY3VyX3N0YXJ0ID0gc3RhcnQ7
IGN1cl9zdGFydCA8IHN0YXJ0ICsgc2l6ZTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGN1cl9zdGFydCArPSBtZW1ibG9ja19zaXplKSB7Cj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0ID0gYWRkX21lbW9y
eV9jcmVhdGVfZGV2aWNlcyhuaWQsCj4gPiA+IGdyb3VwLCBjdXJfc3RhcnQsCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1lbWJsb2Nr
Xwo+ID4gPiBzaXplLAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBtaHBfZmxhZ3MKPiA+ID4gKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3Rv
IGVycm9yOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gCj4gPiBX
ZSBzaG91bGQgaGFuZGxlIHRoZSBiZWxvdyBlcnJvciBkZXRhaWxzIGhlcmUuIAo+ID4gCj4gPiAx
KSBJZiB3ZSBoaXQgYW4gZXJyb3IgYWZ0ZXIgc29tZSBibG9ja3MgZ290IGFkZGVkLCBzaG91bGQg
d2UKPiA+IGl0ZXJhdGUgb3ZlciByZXN0IG9mIHRoZSBkZXZfZGF4LT5ucl9yYW5nZS4KPiA+IDIp
IFdpdGggc29tZSBibG9ja3MgYWRkZWQgaWYgd2UgcmV0dXJuIGEgZmFpbHVyZSBoZXJlLCB3ZSBy
ZW1vdmUKPiA+IHRoZQo+ID4gcmVzb3VyY2UgaW4gZGF4X2ttZW0uIElzIHRoYXQgb2s/IAo+ID4g
Cj4gPiBJTUhPIGVycm9yIGhhbmRsaW5nIHdpdGggcGFydGlhbCBjcmVhdGlvbiBvZiBtZW1vcnkg
YmxvY2tzIGluIGEKPiA+IHJlc291cmNlIHJhbmdlIHNob3VsZCBiZQo+ID4gZG9jdW1lbnRlZCB3
aXRoIHRoaXMgY2hhbmdlLgo+IAo+IE9yLCBzaG91bGQgd2UgcmVtb3ZlIGFsbCBhZGRlZCBtZW1v
cnkgYmxvY2tzIHVwb24gZXJyb3I/Cj4gCkkgZGlkbid0IGFkZHJlc3MgdGhlc2UgaW4gdjMgLSBJ
IHdhc24ndCBzdXJlIGhvdyB3ZSdkIHByb2NlZWQgaGVyZS4KU29tZXRoaW5nIG9idmlvdXNseSB3
ZW50IHZlcnkgd3JvbmcgYW5kIEknZCBpbWFnaW5lIGl0IGlzIG9rYXkgaWYgdGhpcwptZW1vcnkg
aXMgdW51c2FibGUgYXMgYSByZXN1bHQuCgpXaGF0IHdveXVsZCByZW1vdmluZyB0aGUgYmxvY2tz
IHdlIGFkZGVkIGxvb2sgbGlrZT8gSnVzdCBjYWxsCnRyeV9yZW1vdmVfbWVtb3J5KCkgZnJvbSB0
aGUgZXJyb3IgcGF0aCBpbiBhZGRfbWVtb3J5X3Jlc291cmNlKCk/IChmb3IKYSByYW5nZSBvZiBb
c3RhcnQsIGN1cl9zdGFydCkgPwo=
