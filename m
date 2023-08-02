Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBA676D318
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjHBP5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbjHBP5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:57:11 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBE9126;
        Wed,  2 Aug 2023 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690991827; x=1722527827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aNTB4lHKLJlFodapYVt2azqPj1uGlOHPC02CPDvnD+o=;
  b=iY00TUMpGYqX4hbdzhVMz4oMp6PwiZa+jJfdA92PuDZmMXhalP10V+LO
   FuwQMByGR2+6J7S/lEJVyUsyVOVZ0WBQzPv+c3XByJ2sXyj4I4L5pw8oG
   0sQfHVYthnt1QmoNumsrrtVINj7RqD2QI59PNQDsWjDvDbchbDtuGDE/D
   wSKqvUfGUaPsBxrCofqBrDCaRwhpJBEwYWJ0VKvSNC1CpG++MNSxR9ami
   rnHdzNxRXfmHrCm+ZBRYYUs1L52+h7M9TKM05uG7MnKNunEPpdY+yDgm4
   kuCw2gr2jx3saaVO0bWTrVws7/blralege9LkD04vAYuV2g3UOBuKzV89
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="367086767"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="367086767"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:57:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="794643477"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="794643477"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 02 Aug 2023 08:57:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 08:57:06 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 08:57:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 08:57:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 08:57:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie1qXNsAGWWce1mtiPRNNHJtrvwIkpjxfnv/bzOsQJv2UqmAqcifhvNOQyKTEbYE0S0rqM73Nxk+aiYfY2mbvsyriZazqNMFb3el9lkgQidh6VLKIkhQnFD7O6+gpumCrAlT+uC6zodbAbpmH83hDgLVVSZX9HVqYjqcTZb27f3B97QdfF2P3iv2vgbMNjM0hBqMNdwQDle4LKnbGiETrz2ipFJqjv8CRvuK5NgGQoIEZ8X3pW5//sIAVlDV049fdaf6x85IE62yjcBC0ay9PYuOV0CgHzknSPX0JMUvHdepco+FhFzlbJBjnGws8GBjNjZO46kd5ZpFLxxbUNodaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNTB4lHKLJlFodapYVt2azqPj1uGlOHPC02CPDvnD+o=;
 b=Jlol9NZoTfPLKCbAvE58V2XtPzzJVmtozDEM1XgSBtgbMlCO+xTLoy0LhJHJFw0NlFEpsY3jAcG677FG0VNeBNvpWrEa9d4ka1E/cgRTA9eWAgeONG6E9UiVX5j42bNYlgo2CLL9G7GCLkAkt/W0zQty6Nyo81jFmBGKSwvoJL7iQbsLk6TxrfhqZbylnaeIVjPC2maEQb99Mv0V10Sq7jnSVT7ifMnOD1UBa4Fk2Nqfs6MBXM21GylsKG1KnzYbQtzvCG0OVjrfRQVeP4xa/DIodB4gmxJIkVAPn8ShSSfynrBiQSredUDx2r5ncCCMd13qscrA+HC1YqGLvOW4Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Wed, 2 Aug
 2023 15:57:03 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::cb1f:f744:409c:69b3]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::cb1f:f744:409c:69b3%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 15:57:03 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "david@redhat.com" <david@redhat.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
Thread-Topic: [PATCH v3 1/2] mm/memory_hotplug: split memmap_on_memory
 requests across memblocks
Thread-Index: AQHZxQX9Jv9y/15P9EGT1xoIrXNt96/XDxAAgAAa1oA=
Date:   Wed, 2 Aug 2023 15:57:03 +0000
Message-ID: <77b598624dd18644ac080e18d4258358ea0888ac.camel@intel.com>
References: <20230801-vv-kmem_memmap-v3-0-406e9aaf5689@intel.com>
         <20230801-vv-kmem_memmap-v3-1-406e9aaf5689@intel.com>
         <20230802152058.000030ed@Huawei.com>
In-Reply-To: <20230802152058.000030ed@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SJ0PR11MB5769:EE_
x-ms-office365-filtering-correlation-id: 2a6d57a2-611f-46b2-b934-08db93711d0c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZ3zPotJxFhD1F6mySyHUiQVvQS3FZGrwx/kCMcEsL6p4VSom2c9+jkDajc5/wOLS9mSziOFBc2jCDkBUzxk+SNanUQEIWOwRwbPiwlyqR5UO+VgU6Rj+tqA27DbKrfHtWXMU43/HZ9dXGHPPkJclQqYaEx9rNJIi/sHA8rwBktXilccaRZfmiLOoqre/yOB+D/YaH04MG1Y3O3BycBL18F1Xsemb6u6hOXnNThV6Zt0Y3y/CI8iqG0M7eXSxiGaz/vJiIa176E0C5vU0HcDtit+8fuutvvuupajIYAvo4UY3TFRQyW/XvW+D0UIwP2Pje3Ejt2OKviZ03HtHkwH6Ra+z+1ri8WVS4HK4ynFiY4GXxgLvV/LQVvunoVZ0j9zOMFUXiF0yMmpQHFSYy1SXR22bGNoIlHWZLlEqlbDoQlwdy8JW5ZmkcdRG71MEmzeIapbr5yvDNyLGrNQ9mWWJcniu+ucPZKSFKtIs1idwZWUTmyGEHd3BYjCxYWJPUsJ5AdsjqjNaNTRAEVD5mmKIuqU+eQuOxxm1/7OE/6Bza/EKg3BIDy/lG7PPBOgCO5W1wrg5ZdnGznKxDkr0CKIe0mlujh2eb/zWiClVKyX61g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(82960400001)(966005)(76116006)(54906003)(122000001)(6512007)(6506007)(26005)(6486002)(36756003)(8676002)(66946007)(8936002)(5660300002)(64756008)(66476007)(66446008)(66556008)(71200400001)(4326008)(6916009)(41300700001)(2906002)(2616005)(83380400001)(38070700005)(7416002)(38100700002)(86362001)(186003)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1hwbjR0K3AxTUdvQjd0M0JQWjJXVEZ6SHdVTVFDTHk5NElPM3VuTXJvQ28y?=
 =?utf-8?B?UFE2R3hJdFBwOVJEcjMrYXJkb0orbXJ4RVQ1c1JJcWtvekU2dlZLZXpXZjJm?=
 =?utf-8?B?dk54dFZDWDdhenQ5VGtyV0FnQXBwMU13MTlOWkhRRkVsKzBxNFl1dVFZV212?=
 =?utf-8?B?cS9IL2ErTGdPTGsrQnZQeHdwZEU3WXdWcXJMNDUwS1JqalI3aGZEd1RaR2Nn?=
 =?utf-8?B?TDBhWkZHYVQ3Y2NnaE5pT2djTHU3ZTB5SFF0ZlRaTW84S1l6TVUwenh3RGIw?=
 =?utf-8?B?NE1Ma3BxQnM5RENyUDFKQzZiWVFRK2JwNFVoRThSbGVLVmozK09sMG83aGR3?=
 =?utf-8?B?NzQ3MVRVdFJCckVqcys2QWYybVFkbjduNVR3cTZHVkV3aGptRDNnelJkNkta?=
 =?utf-8?B?bnIzbTYvYlBUZlhMWGNPTnM0MTZtMy9rMjRSb2FHNXpXc0M1V2g4UHZMYWEv?=
 =?utf-8?B?NEwzeDBXWDh6bFVkRDZibWNUcklsNFlqN0w4NitSMXVONVArOE4wMWp6OFBJ?=
 =?utf-8?B?QVJLWUVKTjZkb0Z4WDZDR1BENWhVY2lFQVZ2VzB5Ry9PcEhvenJzdVVqRVBx?=
 =?utf-8?B?Q1YwWXJLbzNFNStQSVQvZzJQM1BWdGtUTmI1Vkw0dU5jZVFTa1JZMXFlK1J5?=
 =?utf-8?B?MS9kcXR1UXRuQWd3ZFhJbXpCOVRaSTJ1WFE2ZndIeFdXNVBPZUZwd1pFaGNy?=
 =?utf-8?B?aTZJOG9HNjY3QnFMNmJndnA0aEFwMndFb3Nqc09YT3NkMHBEMDRZQkZvdUR5?=
 =?utf-8?B?Q0hwNEtYOVRYbWp5Yy85T293ZWY1ME5hN2JXazNseDVPV291emVKWjJVZHNr?=
 =?utf-8?B?ZWhXOWpjYThNSWpkNWFEOHBJOThLQ0JPRVFrZGhMZXNobzFQOWx4NDJqdUNw?=
 =?utf-8?B?SDVITFBJRlQvT1ZyOGpIMGNvSGdhT25EWHJVYXBwUGtWUmIvSTM0eHdxdkVu?=
 =?utf-8?B?TnRCYzFJVkpNbXdTT0MvV2NId2hPQXpGQ3QwVFlKNnJFZTJYcm5iSk9vNFZz?=
 =?utf-8?B?R2htS0FrNGo3eEtWRTFvL1gwcWo3OHpiS2VjYjVoNGk4bnhDVUVYRTFUcFFl?=
 =?utf-8?B?STNIYU9xY3FwczJtK0xLWnhqSHRkRXl5cjIrK3A4RVdtZkxXWGxldXpiL3FW?=
 =?utf-8?B?UU56WTUzTXFNZFNIdnhmZmFLOVN3Z3VFd3VUaFRTUVU4VWVDU1k1QnBUWnBK?=
 =?utf-8?B?Z2lIcDFCemtwMjRmZ1l1RkpvRWJESGJHQlJRNXR2UzJiNEtrcXJJRHlyYi9z?=
 =?utf-8?B?cStyUzcrd1NJczlwRTh1NXlROTFiaUNNZmNYM3IxanZjMXQ3VnVkQy9kMjBL?=
 =?utf-8?B?QmZlYW9wai9iYzcwS29kck8wN0VSbDJVSC82eEJDZEkyYjRoOW44VjhHbVZy?=
 =?utf-8?B?T2ZwSUdXVm0yY0V5SzVsaGdleUZlSXpReXBnR3dId2FTMGFHWVVPOStCaW1R?=
 =?utf-8?B?WE1ibEg1bXRNdTI4TE9oc3VDbS9NSWxEa0dsaWcxazR4WDRVL0FjQUQ4RDE1?=
 =?utf-8?B?ZHMxY0lMSWdZUzdFc0NhUlJ0eUpOZ0d2NlNqVTgrOXMwWDgzNE5Pd3p6TkRR?=
 =?utf-8?B?Mml2bjd6Z3o5QnBCaXVTWXlyMWhZeFpWMUcwZWtYTzE0eWRuTFVObnpuU3ht?=
 =?utf-8?B?SGJDc25raHFZTi92TEdOSXhLS1NGbFlqbWxLbDFmWnNubXFiQU1XMThTcGdm?=
 =?utf-8?B?RXBjR0JsL1BnZWxHbUs3a0kwbGNvZm5vbS9SaWFLWE1Jc21lSHllZzlCdmRj?=
 =?utf-8?B?VGdyZWRoQjBleGlHTWtKc0pma3h2VVVnZk9vTXovL0tEYTA4c0hxWFA4N2Fx?=
 =?utf-8?B?TVd2b2IxeGFkdTRna3ROM1A5UkFLOEltODdySVF6SkZKN1dxb1Vya084SHJK?=
 =?utf-8?B?cmVyUVBBdEVrMkczRzdCUVNBTGNoVHZSdVl5enVDeGVaeVQvRi9ZTnc5S0FK?=
 =?utf-8?B?SWk1V21IbUN1OHVsOGZQVXk0T2NjMUFUTjNLa2xkb1g3QXRWb1ZjNUxIL2ZS?=
 =?utf-8?B?RXM0ckpmU0psb3ZzYVJNelpxSFJzY2ZqUTE3aTcxaWRFVXBxRnN2eit4d1F5?=
 =?utf-8?B?eHhjbHR1UG9YNGFYd05yWHNmR1AxRWtHZS9oOW1uRWlKMGh6VktaZ05pU2Ev?=
 =?utf-8?B?Zk9OYzAvUmxGeHpxUlZzZURJSVZDam9TSzJSWFVNd2VvYlo1dWZ6QTEyWTI2?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6379E11014C9D9498E5BFF95336007DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6d57a2-611f-46b2-b934-08db93711d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 15:57:03.0613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVZZUwHkOq+6cdyJKQii01IJmGucWb5bTWfpA2gq26grxqITsftfAbwHsV79q+BhypYUz0I0gBXPZvOUWEOUMMu1jDB4ElIWUVwlu91Ax0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
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

T24gV2VkLCAyMDIzLTA4LTAyIGF0IDE1OjIwICswMTAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUdWUsIDAxIEF1ZyAyMDIzIDIzOjU1OjM3IC0wNjAwDQo+IFZpc2hhbCBWZXJtYSA8
dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gVGhlIE1IUF9NRU1NQVBf
T05fTUVNT1JZIGZsYWcgZm9yIGhvdHBsdWdnZWQgbWVtb3J5IGlzIHJlc3RyaWN0ZWQgdG8NCj4g
PiAnbWVtYmxvY2tfc2l6ZScgY2h1bmtzIG9mIG1lbW9yeSBiZWluZyBhZGRlZC4gQWRkaW5nIGEg
bGFyZ2VyIHNwYW4gb2YNCj4gPiBtZW1vcnkgcHJlY2x1ZGVzIG1lbW1hcF9vbl9tZW1vcnkgc2Vt
YW50aWNzLg0KPiA+IA0KPiA+IEZvciB1c2VycyBvZiBob3RwbHVnIHN1Y2ggYXMga21lbSwgbGFy
Z2UgYW1vdW50cyBvZiBtZW1vcnkgbWlnaHQgZ2V0DQo+ID4gYWRkZWQgZnJvbSB0aGUgQ1hMIHN1
YnN5c3RlbS4gSW4gc29tZSBjYXNlcywgdGhpcyBhbW91bnQgbWF5IGV4Y2VlZCB0aGUNCj4gPiBh
dmFpbGFibGUgJ21haW4gbWVtb3J5JyB0byBzdG9yZSB0aGUgbWVtbWFwIGZvciB0aGUgbWVtb3J5
IGJlaW5nIGFkZGVkLg0KPiA+IEluIHRoaXMgY2FzZSwgaXQgaXMgdXNlZnVsIHRvIGhhdmUgYSB3
YXkgdG8gcGxhY2UgdGhlIG1lbW1hcCBvbiB0aGUNCj4gPiBtZW1vcnkgYmVpbmcgYWRkZWQsIGV2
ZW4gaWYgaXQgbWVhbnMgc3BsaXR0aW5nIHRoZSBhZGRpdGlvbiBpbnRvDQo+ID4gbWVtYmxvY2st
c2l6ZWQgY2h1bmtzLg0KPiA+IA0KPiA+IENoYW5nZSBhZGRfbWVtb3J5X3Jlc291cmNlKCkgdG8g
bG9vcCBvdmVyIG1lbWJsb2NrLXNpemVkIGNodW5rcyBvZg0KPiA+IG1lbW9yeSBpZiBjYWxsZXIg
cmVxdWVzdGVkIG1lbW1hcF9vbl9tZW1vcnksIGFuZCBpZiBvdGhlciBjb25kaXRpb25zIGZvcg0K
PiA+IGl0IGFyZSBtZXQuIFRlYWNoIHRyeV9yZW1vdmVfbWVtb3J5KCkgdG8gYWxzbyBleHBlY3Qg
dGhhdCBhIG1lbW9yeQ0KPiA+IHJhbmdlIGJlaW5nIHJlbW92ZWQgbWlnaHQgaGF2ZSBiZWVuIHNw
bGl0IHVwIGludG8gbWVtYmxvY2sgc2l6ZWQgY2h1bmtzLA0KPiA+IGFuZCB0byBsb29wIHRocm91
Z2ggdGhvc2UgYXMgbmVlZGVkLg0KPiA+IA0KPiA+IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnPg0KPiA+IENjOiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVk
aGF0LmNvbT4NCj4gPiBDYzogTWljaGFsIEhvY2tvIDxtaG9ja29Ac3VzZS5jb20+DQo+ID4gQ2M6
IE9zY2FyIFNhbHZhZG9yIDxvc2FsdmFkb3JAc3VzZS5kZT4NCj4gPiBDYzogRGFuIFdpbGxpYW1z
IDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+ID4gQ2M6IERhdmUgSmlhbmcgPGRhdmUuamlh
bmdAaW50ZWwuY29tPg0KPiA+IENjOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50
ZWwuY29tPg0KPiA+IENjOiBIdWFuZyBZaW5nIDx5aW5nLmh1YW5nQGludGVsLmNvbT4NCj4gPiBT
dWdnZXN0ZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiAN
Cj4gQSBjb3VwbGUgb2YgdHJpdmlhbCBjb21tZW50cyBpbmxpbmUuDQoNCkhpIEpvbmF0aGFuLA0K
DQpUaGFua3MgZm9yIHRha2luZyBhIGxvb2suDQoNCj4gDQo+ID4gLS0tDQo+ID4gwqBtbS9tZW1v
cnlfaG90cGx1Zy5jIHwgMTUwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA5MyBpbnNlcnRpb25zKCspLCA1
NyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5X2hvdHBsdWcu
YyBiL21tL21lbW9yeV9ob3RwbHVnLmMNCj4gPiBpbmRleCBkMjgyNjY0ZjU1OGUuLmNhZTAzYzhk
NGJiZiAxMDA2NDQNCj4gPiAtLS0gYS9tbS9tZW1vcnlfaG90cGx1Zy5jDQo+ID4gKysrIGIvbW0v
bWVtb3J5X2hvdHBsdWcuYw0KPiA+IEBAIC0xMzgzLDYgKzEzODMsNDQgQEAgc3RhdGljIGJvb2wg
bWhwX3N1cHBvcnRzX21lbW1hcF9vbl9tZW1vcnkodW5zaWduZWQgbG9uZyBzaXplKQ0KPiA+IMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gYXJjaF9zdXBwb3J0c19tZW1tYXBfb25fbWVtb3J5KHZtZW1t
YXBfc2l6ZSk7DQo+ID4gwqB9DQo+ID4gwqANCj4gPiArc3RhdGljIGludCBhZGRfbWVtb3J5X2Ny
ZWF0ZV9kZXZpY2VzKGludCBuaWQsIHN0cnVjdCBtZW1vcnlfZ3JvdXAgKmdyb3VwLA0KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHU2NCBzdGFydCwgdTY0IHNpemUsIG1ocF90IG1ocF9mbGFncykNCj4gPiAr
ew0KPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBtaHBfcGFyYW1zIHBhcmFtcyA9IHsgLnBncHJv
dCA9IHBncHJvdF9taHAoUEFHRV9LRVJORUwpIH07DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0
IHZtZW1fYWx0bWFwIG1ocF9hbHRtYXAgPSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoC5iYXNlX3BmbiA9wqAgUEhZU19QRk4oc3RhcnQpLA0KPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAuZW5kX3BmbsKgID3CoCBQSFlTX1BGTihzdGFydCArIHNpemUgLSAx
KSwNCj4gPiArwqDCoMKgwqDCoMKgwqB9Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoGludCByZXQ7DQo+
ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmICgobWhwX2ZsYWdzICYgTUhQX01FTU1BUF9PTl9N
RU1PUlkpKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1ocF9hbHRtYXAu
ZnJlZSA9IG1lbW9yeV9ibG9ja19tZW1tYXBfb25fbWVtb3J5X3BhZ2VzKCk7DQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBhcmFtcy5hbHRtYXAgPSBrbWFsbG9jKHNpemVvZihz
dHJ1Y3Qgdm1lbV9hbHRtYXApLCBHRlBfS0VSTkVMKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKCFwYXJhbXMuYWx0bWFwKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtZW1jcHkocGFyYW1zLmFsdG1hcCwgJm1ocF9h
bHRtYXAsIHNpemVvZihtaHBfYWx0bWFwKSk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgfQ0KPiA+ICsN
Cj4gPiArwqDCoMKgwqDCoMKgwqAvKiBjYWxsIGFyY2gncyBtZW1vcnkgaG90YWRkICovDQo+ID4g
K8KgwqDCoMKgwqDCoMKgcmV0ID0gYXJjaF9hZGRfbWVtb3J5KG5pZCwgc3RhcnQsIHNpemUsICZw
YXJhbXMpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXQgPCAwKQ0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycm9yOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKg
wqAvKiBjcmVhdGUgbWVtb3J5IGJsb2NrIGRldmljZXMgYWZ0ZXIgbWVtb3J5IHdhcyBhZGRlZCAq
Lw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldCA9IGNyZWF0ZV9tZW1vcnlfYmxvY2tfZGV2aWNlcyhz
dGFydCwgc2l6ZSwgcGFyYW1zLmFsdG1hcCwgZ3JvdXApOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlm
IChyZXQpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYXJjaF9yZW1vdmVf
bWVtb3J5KHN0YXJ0LCBzaXplLCBOVUxMKTsNCj4gDQo+IE1heWJlIHB1c2ggdGhpcyBkb3duIHRv
IGEgc2Vjb25kIGxhYmVsPw0KDQpZZXAgd2lsbCBkby4NCg0KPiANCjxzbmlwPg0KPiA+ICsNCj4g
PiArc3RhdGljIGludCBfX3JlZiB0cnlfcmVtb3ZlX21lbW9yeSh1NjQgc3RhcnQsIHU2NCBzaXpl
KQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqDCoMKgaW50IHJldCwgbmlkID0gTlVNQV9OT19OT0RF
Ow0KPiANCj4gSSdtIG5vdCBvdmVybHkga2VlbiB0byBzZWUgdGhlIHRyaXZpYWwgcmVuYW1lIG9m
IHJjIC0+IHJldCBpbiBoZXJlLg0KPiBKdXN0IG1ha2VzIGl0IGV2ZXIgc28gc2xpZ2h0bHkgaGFy
ZGVyIHRvIGNvbXBhcmUgb2xkIGNvZGUgYW5kIG5ldyBjb2RlLg0KDQpZZXAgLSB0aGlzIHdhcyB0
byB3b3JrIGFyb3VuZCB0aGUgcGF0Y2hlcyBJIHdhcyBiYXNlZCBvbiwgd2hpY2ggYWRkZWQNCmJv
dGggYSByZXQgYW5kIGxlZnQgdGhlIG9yaWdpbmFsIHJjIFsxXS4gQW5lZXNoIHdpbGwgc3RpY2sg
dG8gJ3JjJyBzbw0KbXkgbmV4dCByZXZpc2lvbiBzaG91bGQgc29ydCB0aGlzIG91dCBuYXR1cmFs
bHkuDQoNClsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzcxNTA0MjMxOWNlYjg2MDE2
YTQ5ODY4NjJhODI3NTZlNTYyOWQ3MjUuY2FtZWxAaW50ZWwuY29tLw0KDQo+IA0K
