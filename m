Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84A97778B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjHJMmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjHJMmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:42:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ECC1B4;
        Thu, 10 Aug 2023 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691671361; x=1723207361;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=7VcllAyFrBmVfaEwTkFYcgwmqODE/RN1Lw6stfInOok=;
  b=kryWfBJ4d6wOmCkj+od+NSEIsrFqD24vsuNVRprYkW4eE086roFHycBM
   Hs5X9E3MO+AsUpvpNkNHap9M0S+fVgl1ZNxJygLFesVZMRl9VPvpWHZiI
   7FgMD3+2YAyCc3XNEnwEIs8aTnmXh82L2AWoAzYP437KdlxwEsCsv4ew6
   NO4+qXMVW3PKUBjXW0NypxBUFsW4NkwR3TwzuQqOQUtqVwBRRdeNEAXSx
   oJuhOl1hrP7iSyDphFPVrPUb2455qKC8RrkhP9ciprKBJCT0FaqJtMkE3
   RV+TiD29RtVXDL/MVyNbOTANcC/2KJc2+Gc++qEiaNfBxOqnvfmmRdQjJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="435282550"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="435282550"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 05:42:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="797598196"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="797598196"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2023 05:42:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 05:42:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 05:42:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 05:42:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 05:42:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQP8TfENpRUmYO2Jnr3mjrpp69F7/6IULfE8ykl0M4aGF1VAx7Ymq4SC0zZOp6pwWBIdynQ3COiGOPD7+xDnxy2D9ud0mOs3BmBloMlwvL1enmDe1Pj6jJYBee/LmsKxXzW2sR508/Y+YE5WbOA1hZGLu5KpvtCPgb+ibXvq1Vg0MVo6E9QlDyrwjqWCXJ/A4oOvOnXPazBBm27Ai3SWhuqob5FDUnpW4YY0tKgS0C2xg47EfcYRqvObR4HFsBuJJz/mfApuUFwrkucu06JEBwjCz9j7oYdyAAVLYUx2BpJaUm40pDM6g3zFsrXH+OkMFMPp93j7k3hnsQrQcWGK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IvHLiV8c3ycE20SySRMQd5nXzL3z3HzY0O6mnX7IWw=;
 b=HxC8Aw99LhtPV/KjxFUcUfAe2KnXMKgX0XSYewkEZxAvl9JLY7U/9zbdX1gMNDq2xzX+aqQKSmqv61knlSdtkCYVe1uNaBgrflS8m4hNkAo2wHRkK3meqTeMyjgAbJN/Gz27LscoXRrOkZwNBqgHSyv8bYM209kDbz0hpmgKq7HmsOuRO1+CLpwgYwPms8VRYSYxv7JqLi1IYO0GxYz/aGfgMRwJAcX/2CAmwNRfnPWEpSRlufEV0lzU6qzeSEfMCMxvxM/6bP7MFjovyUcT63KWbptLwqSJ5ZGKHi2p/FNjQOIR9wGNW34/Uuepl5X31Ztze46EneaPN/IjqXWxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB2005.namprd11.prod.outlook.com (2603:10b6:903:2e::18)
 by MW4PR11MB6667.namprd11.prod.outlook.com (2603:10b6:303:1ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:42:36 +0000
Received: from CY4PR11MB2005.namprd11.prod.outlook.com
 ([fe80::343b:99ae:e5a2:548f]) by CY4PR11MB2005.namprd11.prod.outlook.com
 ([fe80::343b:99ae:e5a2:548f%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 12:42:36 +0000
From:   "Schimpe, Christina" <christina.schimpe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kostya Serebryany <kcc@google.com>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] mm: Fix access_remote_vm() regression on tagged addresses
Thread-Topic: [PATCH] mm: Fix access_remote_vm() regression on tagged
 addresses
Thread-Index: AQHZytBE++hcdrebDUWIo5xEYf6fka/iEEYAgAFkKCA=
Date:   Thu, 10 Aug 2023 12:42:36 +0000
Message-ID: <CY4PR11MB2005976F49613E20BC072ECCF913A@CY4PR11MB2005.namprd11.prod.outlook.com>
References: <20230809144600.13721-1-kirill.shutemov@linux.intel.com>
 <CAHk-=whaGTq11x_F1Y+J85j+Eh7JxVqH1sWpqgH+-7wQZ1ZE2A@mail.gmail.com>
In-Reply-To: <CAHk-=whaGTq11x_F1Y+J85j+Eh7JxVqH1sWpqgH+-7wQZ1ZE2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB2005:EE_|MW4PR11MB6667:EE_
x-ms-office365-filtering-correlation-id: 1d2507a7-3f00-422e-512b-08db999f4659
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IyzjdHk8aUiElCGHAkjp+EMMoyDqneHBCGzX5Il6N6CJnl2Ebxj6pbgY20+3zwXKiYPRR2rWsK2d2cGZKIyGfmPcLq91KspZgBr77tEg40j/4c9UY3qlONkhP9LRnwtLCY2w8HJ2FU3aQmu8NW9tNSG/LKA7gbDNBKcBZMNoYGzDgzE38q23cCeadUJagHGOrXAmwILFxY0Gr1eZX7+nBFEjYhw9kXnLXCg67ubDm6rHZk+LqW2NwHBxodi44i74wT2sGHLtXXC6ZtA+PKHt/KABWQrJG3QttRxjqs4E+CcJhWafsnahzOzLQLSzgjgTZdh/gQL0F9xt1+3jwPO16BQe1Ha05QC7aPKccMfDYAOEigky+7gV38aGyK+8tg2bvn0WR1uvOAQ+iGGNSjLn4n8FtDLrEoW03gSkHVGxUwdZJIwhTV97iKmInLLABaHE9zLaugBY5//FI5Oq+L9zydwKzzSH/JUHurMKmm7DhvEeCNzS12PVDLESjorJJqXI7mrxrE7VEiycD12sZ2fBX3vnQlWFSo9/Vj59YD8ws2rZuunJYeWIw7YLggG+ARqeHZ0Zf3Y56LVHnKSXf11XkkRFWsIJ42tHpZeebEQLvUo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2005.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(136003)(346002)(376002)(186006)(451199021)(1800799006)(4744005)(71200400001)(83380400001)(82960400001)(55016003)(2906002)(122000001)(478600001)(41300700001)(9686003)(966005)(26005)(316002)(6506007)(66946007)(66556008)(76116006)(66446008)(66476007)(64756008)(33656002)(4326008)(38070700005)(110136005)(38100700002)(54906003)(7416002)(7696005)(86362001)(8676002)(8936002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzhqM25mZi9WelNVYnA0SkgyU05FK2o5TnBiOXF1UXM1cm43ZlR1dThLRWxG?=
 =?utf-8?B?M1JMcElGd1Z3amVvUlJDajlvR2loeHUxd3pXRmt6UkVwWktqazRvZzExRm9P?=
 =?utf-8?B?TWZNVmhhdFNzUkJzSkF4ZmNKRjhPY0hOTWlXSlRUcEkrZnpCdDdzOEFzaWFm?=
 =?utf-8?B?YUpGWjhlM24wdWZLczU1WW5KbHRVVGRUcHlyNE9wQzFYUU1RdFBpaG9sVDJ5?=
 =?utf-8?B?VHcrcmtQN01SaDVpVFZOOWxBRC9mQVpwNExBTXpzdFZFK1J5cUk0UjhjVXlH?=
 =?utf-8?B?ZXNnZEhRWkl1LzB4cWtBMWd5dGJtQjM4cEZia1phbm5vTnZIMFRldlBHOXpv?=
 =?utf-8?B?K093ZTFSSlQvSmRGWUdYNklEWGdMUkQ1aG1WQ0w0UjNUQWNPcUZJUS8vVDRK?=
 =?utf-8?B?RlQ5Wk9aK0pGeFpSNy9iTUVKR0x5U0Z6b0lIRHdqRE1xZko3ZmtpZHJ0aTNj?=
 =?utf-8?B?aGJ2TTFDMk41MTlhY2JXbCt2L2lvcDU5UWQwNkJaMjJDWTFGTW00dFBtWmdp?=
 =?utf-8?B?aDUyVlI4NHlocGhzc1AxVzRVNW9EeVArWlRlc3d6ZlZ3TE9MbHNrS3U0dGFL?=
 =?utf-8?B?UWdjQUc4R0k0aTFGc0pxNHNoSnU4NGhtTUNJYmhLWUdwN0NHalBYQWFpdE51?=
 =?utf-8?B?aGtVLzZvOWFIektHcGY4aTlVa1p1RWFoVkFpWVhXMHF0bWMyaEpkbmVzK1FJ?=
 =?utf-8?B?NlJiTmJOTC9hd1ZuTUlPR3NGNzE4ajBpMW9rYkhBaGxDUjJydjZQa01uTWph?=
 =?utf-8?B?Z08rb0p0ZGp3TCtyRlR6ei9RSE5GWWFkR0lYV3lObitIVjBpeEJLY2VwUG1q?=
 =?utf-8?B?dmk3MjVuY25DazMyQUc0T2ZiM0k3aytUZnVXTmZUdmtub09FZks3TlF5NUQw?=
 =?utf-8?B?cE9YK01xS0xyMkpMUis4Q1hnS2s1MTg2bDdhTklSKzZwT0liUGw3Ky9oWXEy?=
 =?utf-8?B?OWtVSVdNTXpSL2Njd2hvTDZFemFWNGIzbkU5d3VZS1h6cjZUeWNuNTdya1hG?=
 =?utf-8?B?NTlxeTlYTXQwU2pkYnBmL2FGa1dOcklZWktxNm16ZGJ2TXd3aWtCd3hpSTNN?=
 =?utf-8?B?ZUg4L0FrQ2xoODdsa245OU9IZ2s3Z0xOQ2ZSbHpTVHpNaTdEZUpkT3ZNYXc5?=
 =?utf-8?B?WE9WZC9yNHJlRzRQaktKTHM3eEFNRm5ueU8wbktCT1JuQkFaaFU0ajdJTWEz?=
 =?utf-8?B?OTh6UzhCL3o1Z0NQT2xpbUhCNXUvR1kvdEl1akRuaHBFLy9sL3IvdVpVK043?=
 =?utf-8?B?M0tpbzlOMWNldXNqcUtTOE9iMzI3S2xlVzNXa1ZhbU4wZElGdjhUZ04vZ1pR?=
 =?utf-8?B?VnZQOWNpdGR5N1ZCWHgxdWk4YXhhamdKRDNVSkl3OFJ4d09qdndCNVV6d0I2?=
 =?utf-8?B?dXk5K1pRclhzZlNEVXFMRzVJSU5IVTlaakJNaDVrb0xtdURveGxwRU5JY1Y3?=
 =?utf-8?B?VHV1dnJiNXg1aWYwWGlyQ1VublJ1UHI3N0tMSFEvVTZ3QmZuVGIxNzRqM0N6?=
 =?utf-8?B?em1OZ0RxNnJqYmw4dXdoT2FZR1ZETDEvNzJUZ2Z5Z3RKclpmWktySWVlc0lx?=
 =?utf-8?B?dDgwcU1ydEp1Q3F3OU5BbUZMVkw0ZFlsU1EyWFJhV2lXaGdhKzI0OTZ0Rmx1?=
 =?utf-8?B?ck1ZdDF5UzVoVUR0bXMwWE5tZ3Nva2RySjZtUVhzNTVVeGl6U21xaEpVSFpy?=
 =?utf-8?B?amUwdnc5VU4zcjZZUUQ1b0psQk85ZlU1YkZoelJnUmZHOGV4UUQ0SFpTMkJF?=
 =?utf-8?B?c1RXVDBQTHY4MnQxNU5wOUdpdFZUTFVRSlBsWHBSWkZib2xmR282cVBJN0cw?=
 =?utf-8?B?R3NCSzNIeVdmWklGU3ZKYVZESGVhMnBMQWlMNHYrdE5xekJIS0ZPNFBFWE9i?=
 =?utf-8?B?Zk1FU1JnMklUNERKZVBxdHNTYjUyTm4xUisvdnFjVDFYcENLOVpDeXlJTTln?=
 =?utf-8?B?U0o4dmpwQktzZzlKaWZhQzZNT0MydUMvT2ZqQ1ZMNHg1bndINDVPM1Z3MFp4?=
 =?utf-8?B?UW1XRUFWKzU2WmtHVHV3dGkreXRLWms4Y2xkRElheGlYa21MalRiaEh4OUpQ?=
 =?utf-8?B?eU5TTWVDb0Z0a01FSlF3dkhrMHpidGErWUM1RXJNY1ZUOE13T0pxZWl0aG00?=
 =?utf-8?B?bnRGQjZmSnlVa2xLNDU3YktOd29NWUdmTDVidnhJVUxBNENjbkJTZlAwOVh1?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2005.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2507a7-3f00-422e-512b-08db999f4659
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 12:42:36.1623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTL/uDKVwExKT8nO98ivzQo0v//B0Q/sh4DXp6OyyvhAOJY96wjN3bZQjzKiyzmX79SgjOwsWApW9E0fE4L95/1HDjjbWgDSDu5u5T3elOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6667
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJbnRlcmVzdGluZyB0aGF0IGl0IHRvb2sgdGhpcyBsb25nIHRvIG5vdGljZS4NCj4gDQo+IE5v
dCBzdXJwcmlzaW5nIGNvbnNpZGVyaW5nIHRoYXQgTEFNIGlzbid0IGFjdHVhbGx5IGF2YWlsYWJs
ZSwgYnV0IEknZCBoYXZlDQo+IGV4cGVjdGVkIHRoZSBhcm0gcGVvcGxlIHRvIG5vdGljZSBtb3Jl
LiBZZXMsIEkgaGF2ZSAoYW5kIHRlc3QpIG15DQo+IGFybTY0IGxhcHRvcCwgYnV0IEkgb2J2aW91
c2x5IGRvbid0IGRvIHVzZXIgc3BhY2UgZGVidWdnaW5nIG9uIGl0Lg0KPiBBcHBhcmVudGx5IG90
aGVycyBkb24ndCBlaXRoZXIuDQo+IA0KPiBPciBtYXliZSBUQkkgaXMgdXNlZCBhIGxvdCBsZXNz
IHRoYW4gSSB0aG91Z2h0Lg0KDQpKdXN0IGZvciB0aGUgcmVjb3JkOg0KDQpXZSBkb24ndCBoYXZl
IGFueSBMQU0gc3VwcG9ydCBpbiBHREIgeWV0LCB3ZSBhcmUganVzdCB3b3JraW5nIG9uIGl0Lg0K
V2UgY3VycmVudGx5IHJlbHkgb24gdGhhdCBmZWF0dXJlLCBidXQgY291bGQgc3RpbGwgY2hhbmdl
IGl0LiBXZSBkb24ndCANCm5lY2Vzc2FyaWx5IHJlcXVpcmUgL3Byb2MvUElEL21lbSB0byBzdXBw
b3J0IHRhZ2dlZCBhZGRyZXNzZXMuDQoNCkFSTSdzIFRCSSBzdXBwb3J0IGluIEdEQiBkb2VzIG5v
dCByZWx5IG9uIC9wcm9jL1BJRC9tZW0gdG8gc3VwcG9ydCB0YWdnZWQNCmFkZHJlc3NlcyBBRkFJ
Sy4NCkkgYWxzbyB0aG91Z2h0IHRoYXQgdGhlIGtlcm5lbCBkb2VzIG5vdCBzdXBwb3J0IHRhZ2dl
ZCBhZGRyZXNzZXMgZm9yDQovcHJvYy9QSUQvbWVtIGluIGNhc2Ugb2YgQVJNLiBUaGlzIGlzIGF0
IGxlYXN0IHJlZmxlY3RlZCBieSB0aGVpciBwYXRjaGVzDQpmb3IgVEJJIGFuZCB0aGUga2VybmVs
IGRvY3MNCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24vYXJtNjQvdGFn
Z2VkLXBvaW50ZXJzLnR4dC4NCg0KQ2hyaXN0aW5hDQpJbnRlbCBEZXV0c2NobGFuZCBHbWJIClJl
Z2lzdGVyZWQgQWRkcmVzczogQW0gQ2FtcGVvbiAxMCwgODU1NzkgTmV1YmliZXJnLCBHZXJtYW55
ClRlbDogKzQ5IDg5IDk5IDg4NTMtMCwgd3d3LmludGVsLmRlIDxodHRwOi8vd3d3LmludGVsLmRl
PgpNYW5hZ2luZyBEaXJlY3RvcnM6IENocmlzdGluIEVpc2Vuc2NobWlkLCBTaGFyb24gSGVjaywg
VGlmZmFueSBEb29uIFNpbHZhICAKQ2hhaXJwZXJzb24gb2YgdGhlIFN1cGVydmlzb3J5IEJvYXJk
OiBOaWNvbGUgTGF1ClJlZ2lzdGVyZWQgT2ZmaWNlOiBNdW5pY2gKQ29tbWVyY2lhbCBSZWdpc3Rl
cjogQW10c2dlcmljaHQgTXVlbmNoZW4gSFJCIDE4NjkyOAo=

