Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D09759F45
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGSUFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjGSUFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:05:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98FE2122;
        Wed, 19 Jul 2023 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689797109; x=1721333109;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V1JyymLaBhl7BBn/spNK8B0vRTkbzIcjg/ukMVVaYNo=;
  b=KXIB5djm6aKvCorsgRzPWOBHOFKvdoPHrI7dNd/yfHqNcJ8Cr/g/YRjd
   0xsufEOorjgU5UqRWI4BOmnfXjiZ8XbGPgYUSkdk1QDqNp0n6qlsXmKbC
   Y3rg0Bko2iiZesQsr6Sw6fAtftwAkPd9sq2ZXp0wn1lQdOWm0E7pI/gBm
   +5ogKPTC/hrtTDxQh+SBKreoFLhgGtshygT1Lu2DX1bpM7lqgpS+7T/8Y
   tIesU/sJtgJLL8b6E7IaBES5Hc+GlcWnkPc1MZvlmQ2T9NMmuHCCWe60I
   hp0PKsUAwWw1PJUCqmBbjC7ArpDBI8OPGGYO94SCosptBNdI8EsbWLblQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="432750246"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="432750246"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 13:05:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="970746324"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="970746324"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jul 2023 13:05:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 13:05:08 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 13:05:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 13:05:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 13:05:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8bTn59ejm0BEq91tv/CNxtGe80ys1++ph6ueUSjYAw0LCXSrteeAQ1UvrX7hiKfnLYsft/8DXbUqIX0xoNkg/I+u5VNAHqof9KYvQdTJ5MpFJCHB0KzGPArjhXRmNQtKeL+nmtLhuK4rME+NvlJUI8Q8vg5BaH5cRUNnMtY6XsSnzbvfYvTM7dgogUHdIUE9a1BVlXQveD++pK55q0qgvqkDEzlL1mxk4e9A3XSXrKn12TxaLk+iOb8iO6apVgmc/rhdMyvE1vLtu6uBWFHIPESnvZOudXdt+JJ4ssGH4oEnaRHQbQzRbW7TFC1XK6vu13gzd1hkAxX2LG7x2f4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1JyymLaBhl7BBn/spNK8B0vRTkbzIcjg/ukMVVaYNo=;
 b=OlUyOFCC4rrLAhAJlXBak7umlOrfm/5wH/CZ6yPjDNTGQIliI2/88uPieuF6x1wbQxGV9MO6f8sjWs1vAJLLrCwHEtMJ96qRNmZ+J0SACURVB3sGcO751Qj2FbbkcW1HGXqTaJfoRU97xb9QXqbc7Y6rjf6vaijv5jkBO+Fksrkl1RhtPUcaPe8P7JGAP52xkfDHQCNODZ1DRTFK2byWKRUpJUJ4cIbe+en6YWU951ma9rW0DOrIOIKjI1wFeInzMUun9781Ifx7rEYIyC3Hx0LmAgYO0CGt5ykDwU7CVijthRiZ9bLPN3j4Td/NTxUkKsv37WpJ1RxpIFnCw9HUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by MW4PR11MB6691.namprd11.prod.outlook.com (2603:10b6:303:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 20:05:05 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::2f24:2dc9:60b:a244]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::2f24:2dc9:60b:a244%7]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 20:05:05 +0000
From:   "Winiarska, Iwona" <iwona.winiarska@intel.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Solanki, Naresh" <naresh.solanki@9elements.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "Rudolph, Patrick" <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v3 3/3] hwmon: (peci/dimmtemp) Add Sapphire Rapids support
Thread-Topic: [PATCH v3 3/3] hwmon: (peci/dimmtemp) Add Sapphire Rapids
 support
Thread-Index: AQHZunC+Or2l93LzxU2F3y/oH0/Rj6/Bg7sA
Date:   Wed, 19 Jul 2023 20:05:05 +0000
Message-ID: <3a11291ea550744fb50f0e6359d4d8780e1c583a.camel@intel.com>
References: <20230719184155.59375-1-Naresh.Solanki@9elements.com>
         <20230719184155.59375-3-Naresh.Solanki@9elements.com>
In-Reply-To: <20230719184155.59375-3-Naresh.Solanki@9elements.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5823:EE_|MW4PR11MB6691:EE_
x-ms-office365-filtering-correlation-id: f4a25ed1-4535-487b-0e51-08db8893720d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HFTXJkeFrKWGXrjcQ8ttLg1KV030qZ88/n75U7ZZkLf9OaRAkulFEmLinvCI80VJKYdG2R8Pm/RhOJfp3p8UObv07yjx+cP8YyVqQPw5lnZKhS905hkd0ITVK3uhw0v22d04P6RhkxuCgjh0wuKGxqvnGoLZMpEzx6KtixB917vLam2F/bnn1sS7KXs0t8faUP73pbVLmhm6rolecc0BupJW86CkUQcoIH30tQ2cui9Cwvi3/KzAHHXFSrajq/YXDCHDjLXHJGiGGG4FUcfC3OSJaVicaKD+4ML1AaivP1NDLNsyjqelG9jRiMe8wzSzj1dgy0kXHEA7w4XMqOq57wNCgD9bAIRZC31ZJOsH/2sYbR8iZ4x+SkOBBD78z0nGW/DjcECDZQ9jti1eUyX8PdLznRKI14/n9f+3rwqPQqRPWS7AaalCkxOw6oZ0gwKxXOC5YgFqO3GQeFPykS4zz9VMf6DsKE7W4OTj6ubZI7ZiahKpcPR+fycDu1K9JmDy4cfzyzk6SHTKMuqoMDBN72XUw81Oi8d9mjFr/uVdo7jfhWSeaodhoubjAIw++IJRdFx/kG+lR8JV7mQDp+uar9xEnmNxy5/qWAWFC3iCiBS3Qpp0RWST1hfx9tVLPyjX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(41300700001)(6512007)(66446008)(8676002)(66476007)(66946007)(8936002)(66556008)(2906002)(6486002)(91956017)(76116006)(122000001)(86362001)(4326008)(316002)(64756008)(36756003)(5660300002)(2616005)(38100700002)(186003)(26005)(83380400001)(71200400001)(82960400001)(6506007)(38070700005)(110136005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUlmUlNDUCtFc1lXKzF6Y1ZXbG1MT2lpNGNZREJYdWxYOTRvY2FiOVJoVk94?=
 =?utf-8?B?M1VERG5WOUxuT3B3V3N0b21nV3pISmIwdUFwRnVJM2x5dUxMa2pUeXlvR3U1?=
 =?utf-8?B?Z0l2RFRZWFNrTWdaNW5mYmlrV1JJMFNpV0RGaWhzWXptc1J3SmsxSjVhK2wy?=
 =?utf-8?B?akhJSFMvR1hxTFcrK012bkJ0cEtjTW16TVlFaktNSzdpanNWTEhkSWF3NTNp?=
 =?utf-8?B?dFdTVlp4YXIwQmQvemM2WWdTMjBDOVFHN0lVYVBmOTVIOW8wYnJSNkM3azVZ?=
 =?utf-8?B?eG5EVXc0cHlUbUFNOHZBSlozNElqUGNUdUFvVWtWTmNBRXRnL3Yvdll4eEcw?=
 =?utf-8?B?TGIzcDZtdG9BVUl3NWZPS2gvMnJpMWlVZUFDU2NBY0NPS3lVQmh4QVJLZnUw?=
 =?utf-8?B?RlB4NDVtUWM3RXFaQjNmTEpqZ2prOHFST2ViYWhhRDQxSHE3bUlISnFIQnNW?=
 =?utf-8?B?MTI0TzV6M1RwYTJOK3BKVEFvc3lGSk11YW9pR1ZheGFxSCtxWkZMblo2U2JR?=
 =?utf-8?B?bytDaDErN1g5Z1BOazNzYjZsdGVVSnZCcmNZalM5VTVHblBLUldUSDAvSzBX?=
 =?utf-8?B?d3hPRFhlQWpiZ2RVcy82ZkFXZ3dKSEZYNGd0bFhrQ1R2S0JIM0ZSK3ZwbkJP?=
 =?utf-8?B?MFJsNSs5d05BNWU4MUdHWmRBSnZIdXN5bUsvYVhPZkdWbFcvc3lYQVJ5eTh6?=
 =?utf-8?B?RCtEZWJZaUNpMnoycm5JZ3BRTDRkWGlYaUhLM04zMWM3MEZTakZJUUtEZ2lh?=
 =?utf-8?B?UzNwMmY2VDJZOGNNS016WGhnNzFSM0dwNzVVSnNzQVpMMVIxK1k5cTI3RTRl?=
 =?utf-8?B?bzhpOWozVTZhcHJ3dWZheS9Qb1RZWmpSdE1aS2NTUGdHVm14TW5lTHQ3ZjBz?=
 =?utf-8?B?R2txd1dBSHhVUjk3YlNUV1VObmZ3OGNvaGdvcDRBazlHK2RZUDl2MHo0amJN?=
 =?utf-8?B?ekZFMXhVZjJoSlZWUVNjQnVhOEFTek9FZit4QzRINk5qRXFIcWJ6ekd2SW8r?=
 =?utf-8?B?MVpPUi9qemVPclRSUFU1RHhOUU1Yd1FDdTJUZjhDK1ZZSm9ueWpkRUxvNUxn?=
 =?utf-8?B?Z3lUN3RKcWxLQkJsdXJ0QklIditpSUR1YXFRQXlWLzUxTkIrUXRTTEFUbnZq?=
 =?utf-8?B?akQzcUdrc0duRHBzcTQ4am9zdjZySFU5cE1LSzNlcUE1NkhzZzVrc2IvY0JO?=
 =?utf-8?B?VW5pSmFGMUlwRVc5ellRYmlTUWlQenFuQ2ZFTGJVKzdRczZNY0F4bkpwNEl0?=
 =?utf-8?B?L21JVGh0ZGpOQWFGUjM0b1FmR3ViRElRV0poUVp3d3VVM1dlRW1iNVNwRjFO?=
 =?utf-8?B?SDIyZzRVajJPNGVEZEljaW9DUHpXbEY4aFFnNzVPcTM0VTJaYU81OVdleWt6?=
 =?utf-8?B?NjB4ZHNva2JYT3FWczlZeGIzZ3hkeHFHVWJNSVY5UlEvYURhc0hsNmpWWmc5?=
 =?utf-8?B?U29ReHFFQ05nSW9JUWdDd043R0xwWnJZY0NQdERLWXlldUFZeVM0YkhoU3VG?=
 =?utf-8?B?dnRZdjJQSUgzWnBCRWNOWG1yWVQ0RzhrT2RYWlUwTWNjMUN2d3c0dWh1L2M0?=
 =?utf-8?B?YXhtRzFPOUJDdkV4cVYwMXNFREQzR3BYTG9rMG1lN3lXTXFjd2E5OVMwTGFt?=
 =?utf-8?B?eUpYcCtjdU9PVU4vNXhLRDcyNXBOWnNHSTNsVGlkekRmUVhQOFIvSXF5TDFY?=
 =?utf-8?B?em5YZEVWRCtYUE5hZm9KNFdqSm03eVVLaW9BRVBDdDJlVFNUcnBpTno2VGVn?=
 =?utf-8?B?OGxBRy8vb3diQnNkRlRWUlNoVkduanBYWjlXd3d5MU51SHlHM0NDKzMxREdE?=
 =?utf-8?B?RHk2aWFtNUNjcHBwNlpacmUvTDJsWlIrN1E5TzRsTHR2RUs4VUZYby9qZ0o3?=
 =?utf-8?B?SURYV2VKUiszd1VxMXI5TGlGNCtWU0JuRVoxbG13YWtnbW05cWxZak1CNW1i?=
 =?utf-8?B?K215Ym1RemlKQ203aUhnRmFweGhUWCt1OW5nY3dmeisrcmRPaGpoL3NwMEhj?=
 =?utf-8?B?UFpuNjBjU1NFM0dSckRvQlY3N29hOFVXWGhqV0ZjSktIRFI2VmdyclhqblNN?=
 =?utf-8?B?ODY5UHJXYS80UStqM3BySUR2Y2tnc0NqZ0J3Rjdlbmc1ZXF2eHpmb3d6SE9w?=
 =?utf-8?B?TzIzckFDd2ZBeWpwbXVMNWpsbkZtdktZQ1ViSjN0TnVIUE5MOFVzSTRwMmQ0?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0C3E2821B60494E968A91CA738ADE65@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a25ed1-4535-487b-0e51-08db8893720d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 20:05:05.8042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brAyRkTAC6ddNFsqphM6YwVbTl1bdTZ+qWNKfAs5tcHMYOaFYsPYTTQrtyqqxw6GD38bubiL5rECTspEa5pmOgqaiVm8jX+lBVsBb1AJ2d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6691
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA3LTE5IGF0IDIwOjQxICswMjAwLCBOYXJlc2ggU29sYW5raSB3cm90ZToN
Cj4gRnJvbTogUGF0cmljayBSdWRvbHBoIDxwYXRyaWNrLnJ1ZG9scGhAOWVsZW1lbnRzLmNvbT4N
Cj4gDQo+IFRoaXMgcGF0Y2ggZXh0ZW5kcyB0aGUgZnVuY3Rpb25hbGl0eSBvZiB0aGUgaHdtb24g
KHBlY2kvZGltbXRlbXApIHRvDQo+IGluY2x1ZGUgc3VwcG9ydCBmb3IgU2FwcGhpcmUgUmFwaWRz
IHBsYXRmb3JtLg0KPiANCj4gU2FwcGhpcmUgUmFwaWRzIGNhbiBhY2NvbW1vZGF0ZSB1cCB0byA4
IENQVXMsIGVhY2ggd2l0aCAxNiBESU1Ncy4gVG8NCj4gYWNjb21tb2RhdGUgdGhpcyBjb25maWd1
cmF0aW9uLCB0aGUgbWF4aW11bSBzdXBwb3J0ZWQgRElNTSBjb3VudCBpcw0KPiBpbmNyZWFzZWQs
IGFuZCB0aGUgY29ycmVzcG9uZGluZyBTYXBwaGlyZSBSYXBpZHMgSUQgYW5kIHRocmVzaG9sZCBj
b2RlDQo+IGFyZSBhZGRlZC4NCj4gDQo+IFRoZSBwYXRjaCBoYXMgYmVlbiB0ZXN0ZWQgb24gYSA0
UyBzeXN0ZW0gd2l0aCA2NCBESU1NcyBpbnN0YWxsZWQuDQo+IERlZmF1bHQgdGhyZXNob2xkcyBh
cmUgdXRpbGl6ZWQgZm9yIFNhcHBoaXJlIFJhcGlkcywgYXMgYWNjZXNzaW5nIHRoZQ0KPiB0aHJl
c2hvbGQgcmVxdWlyZXMgYWNjZXNzaW5nIHRoZSBVQk9YIGRldmljZSBvbiBVbmNvcmUgYnVzIDAs
IHdoaWNoIGNhbg0KPiBvbmx5IGJlIGFjaGlldmVkIHVzaW5nIE1TUiBhY2Nlc3MuIFRoZSBub24t
UENJLWNvbXBsaWFudCBNTUlPIEJBUnMgYXJlDQo+IG5vdCBhdmFpbGFibGUgZm9yIHRoaXMgcHVy
cG9zZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBhdHJpY2sgUnVkb2xwaCA8cGF0cmljay5ydWRv
bHBoQDllbGVtZW50cy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IE5hcmVzaCBTb2xhbmtpIDxOYXJl
c2guU29sYW5raUA5ZWxlbWVudHMuY29tPg0KPiBBY2tlZC1ieTogR3VlbnRlciBSb2VjayA8bGlu
dXhAcm9lY2stdXMubmV0Pg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiBWMzoNCj4gLSBVcGRhdGUgQWNr
ZWQtYnkgaW4gY29tbWl0IG1lc3NhZ2UuDQo+IENoYW5nZXMgaW4gVjI6DQo+IC0gVXBkYXRlIHN1
YmplY3QuDQo+IC0tLQ0KPiDCoGRyaXZlcnMvaHdtb24vcGVjaS9kaW1tdGVtcC5jIHwgMjQgKysr
KysrKysrKysrKysrKysrKysrKystDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL3BlY2kv
ZGltbXRlbXAuYyBiL2RyaXZlcnMvaHdtb24vcGVjaS9kaW1tdGVtcC5jDQo+IGluZGV4IGVkOTY4
NDAxZjkzYy4uZWRhZmJmZDY2ZmVmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2h3bW9uL3BlY2kv
ZGltbXRlbXAuYw0KPiArKysgYi9kcml2ZXJzL2h3bW9uL3BlY2kvZGltbXRlbXAuYw0KPiBAQCAt
MzAsOCArMzAsMTAgQEANCj4gwqAjZGVmaW5lIERJTU1fSURYX01BWF9PTl9JQ1jCoMKgwqDCoDIN
Cj4gwqAjZGVmaW5lIENIQU5fUkFOS19NQVhfT05fSUNYRMKgwqA0DQo+IMKgI2RlZmluZSBESU1N
X0lEWF9NQVhfT05fSUNYRMKgwqDCoDINCj4gKyNkZWZpbmUgQ0hBTl9SQU5LX01BWF9PTl9TUFLC
oMKgwqAxMjgNCg0KV2hlcmUgd2FzIHRoaXMgbnVtYmVyIHRha2VuIGZyb20/DQpTaW5nbGUgQ1BV
IGhhcyA4IGNoYW5uZWxzIChub3QgMTI4KSwgYW5kIGRpbW10ZW1wIGh3bW9uIGJpbmRzIHRvIGEg
c2luZ2xlIENQVS4NCg0KPiArI2RlZmluZSBESU1NX0lEWF9NQVhfT05fU1BSwqDCoMKgwqAyDQo+
IMKgDQo+IC0jZGVmaW5lIENIQU5fUkFOS19NQVjCoMKgwqDCoMKgwqDCoMKgwqDCoENIQU5fUkFO
S19NQVhfT05fSFNYDQo+ICsjZGVmaW5lIENIQU5fUkFOS19NQVjCoMKgwqDCoMKgwqDCoMKgwqDC
oENIQU5fUkFOS19NQVhfT05fU1BSDQoNClRoZW4gLSB0aGVyZSdzIG5vIG5lZWQgZm9yIGNoYW5n
aW5nIHRoZSBNQVggdmFsdWUuDQoNCj4gwqAjZGVmaW5lIERJTU1fSURYX01BWMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBESU1NX0lEWF9NQVhfT05fSFNYDQo+IMKgI2RlZmluZSBESU1NX05VTVNfTUFY
wqDCoMKgwqDCoMKgwqDCoMKgwqAoQ0hBTl9SQU5LX01BWCAqIERJTU1fSURYX01BWCkNCj4gwqAN
Cj4gQEAgLTUzMCw2ICs1MzIsMTUgQEAgcmVhZF90aHJlc2hvbGRzX2ljeChzdHJ1Y3QgcGVjaV9k
aW1tdGVtcCAqcHJpdiwgaW50DQo+IGRpbW1fb3JkZXIsIGludCBjaGFuX3JhbmssIHUNCj4gwqDC
oMKgwqDCoMKgwqDCoHJldHVybiAwOw0KPiDCoH0NCj4gwqANCj4gK3N0YXRpYyBpbnQNCj4gK3Jl
YWRfdGhyZXNob2xkc19zcHIoc3RydWN0IHBlY2lfZGltbXRlbXAgKnByaXYsIGludCBkaW1tX29y
ZGVyLCBpbnQNCj4gY2hhbl9yYW5rLCB1MzIgKmRhdGEpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDC
oC8qIFVzZSBkZWZhdWx0cyAqLw0KPiArwqDCoMKgwqDCoMKgwqAqZGF0YSA9ICg5NSA8PCAxNikg
fCAoOTAgPDwgOCk7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIDA7DQo+ICt9DQo+ICsN
Cg0KUmF0aGVyIHRoYW4gaGFyZGNvZGluZyB0aGUgZGVmYXVsdHMsIGl0IHNob3VsZCBiZSBwb3Nz
aWJsZSB0byBjb21wdXRlIGl0IGluIGENCnNpbWlsYXIgd2F5IHRvIElDWCAoYW5kIHdpdGggdGhh
dCAtIGNvbW1pdCBtZXNzYWdlIHNob3VsZCBiZSB1cGRhdGVkKS4NCldlJ3JlIHN0YXJ0aW5nIGZy
b20gMWU6MDAuMiBpbnN0ZWFkIG9mIDEzOjAwLjIsIGFuZCBvZmZzZXRzIHdpdGhpbiBJTUMgc3Rh
cnQNCmZyb20gMHgyMTlhOCB3aXRoIDB4ODAwMCBzaGlmdC4NCkl0IHdvdWxkIGxvb2sgbGlrZSB0
aGlzIChub3RlIC0gbm90IHRlc3RlZCBvbiBhY3R1YWwgU1BSKToNCg0Kc3RhdGljIGludA0KcmVh
ZF90aHJlc2hvbGRzX3NwcihzdHJ1Y3QgcGVjaV9kaW1tdGVtcCAqcHJpdiwgaW50IGRpbW1fb3Jk
ZXIsIGludCBjaGFuX3JhbmssIHUzMiAqZGF0YSkNCnsNCgl1MzIgcmVnX3ZhbDsNCgl1NjQgb2Zm
c2V0Ow0KCWludCByZXQ7DQoJdTggZGV2Ow0KDQoJcmV0ID0gcGVjaV9lcF9wY2lfbG9jYWxfcmVh
ZChwcml2LT5wZWNpX2RldiwgMCwgMzAsIDAsIDIsIDB4ZDQsICZyZWdfdmFsKTsNCglpZiAocmV0
IHx8ICEocmVnX3ZhbCAmIEJJVCgzMSkpKQ0KCQlyZXR1cm4gLUVOT0RBVEE7IC8qIFVzZSBkZWZh
dWx0IG9yIHByZXZpb3VzIHZhbHVlICovDQoNCglyZXQgPSBwZWNpX2VwX3BjaV9sb2NhbF9yZWFk
KHByaXYtPnBlY2lfZGV2LCAwLCAzMCwgMCwgMiwgMHhkMCwgJnJlZ192YWwpOw0KCWlmIChyZXQp
DQoJCXJldHVybiAtRU5PREFUQTsgLyogVXNlIGRlZmF1bHQgb3IgcHJldmlvdXMgdmFsdWUgKi8N
Cg0KCS8qDQoJICogRGV2aWNlIDI2LCBPZmZzZXQgMjE5YTg6IElNQyAwIGNoYW5uZWwgMCAtPiBy
YW5rIDANCgkgKiBEZXZpY2UgMjYsIE9mZnNldCAyOTlhODogSU1DIDAgY2hhbm5lbCAxIC0+IHJh
bmsgMQ0KCSAqIERldmljZSAyNywgT2Zmc2V0IDIxOWE4OiBJTUMgMSBjaGFubmVsIDAgLT4gcmFu
ayAyDQoJICogRGV2aWNlIDI3LCBPZmZzZXQgMjk5YTg6IElNQyAxIGNoYW5uZWwgMSAtPiByYW5r
IDMNCgkgKiBEZXZpY2UgMjgsIE9mZnNldCAyMTlhODogSU1DIDIgY2hhbm5lbCAwIC0+IHJhbmsg
NA0KCSAqIERldmljZSAyOCwgT2Zmc2V0IDI5OWE4OiBJTUMgMiBjaGFubmVsIDEgLT4gcmFuayA1
DQoJICogRGV2aWNlIDI5LCBPZmZzZXQgMjE5YTg6IElNQyAzIGNoYW5uZWwgMCAtPiByYW5rIDYN
CgkgKiBEZXZpY2UgMjksIE9mZnNldCAyOTlhODogSU1DIDMgY2hhbm5lbCAxIC0+IHJhbmsgNw0K
CSAqLw0KCWRldiA9IDI2ICsgY2hhbl9yYW5rIC8gMjsNCglvZmZzZXQgPSAweDIxOWE4ICsgZGlt
bV9vcmRlciAqIDQgKyAoY2hhbl9yYW5rICUgMikgKiAweDgwMDA7DQoNCglyZXQgPSBwZWNpX21t
aW9fcmVhZChwcml2LT5wZWNpX2RldiwgMCwgR0VUX0NQVV9TRUcocmVnX3ZhbCksIEdFVF9DUFVf
QlVTKHJlZ192YWwpLA0KCQkJICAgICBkZXYsIDAsIG9mZnNldCwgZGF0YSk7DQoJaWYgKHJldCkN
CgkJcmV0dXJuIHJldDsNCg0KCXJldHVybiAwOw0KfQ0KDQpUaGFua3MNCi1Jd29uYQ0KDQo+IMKg
c3RhdGljIGNvbnN0IHN0cnVjdCBkaW1tX2luZm8gZGltbV9oc3ggPSB7DQo+IMKgwqDCoMKgwqDC
oMKgwqAuY2hhbl9yYW5rX21heMKgwqA9IENIQU5fUkFOS19NQVhfT05fSFNYLA0KPiDCoMKgwqDC
oMKgwqDCoMKgLmRpbW1faWR4X21heMKgwqDCoD0gRElNTV9JRFhfTUFYX09OX0hTWCwNCj4gQEAg
LTU3Miw2ICs1ODMsMTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkaW1tX2luZm8gZGltbV9pY3hk
ID0gew0KPiDCoMKgwqDCoMKgwqDCoMKgLnJlYWRfdGhyZXNob2xkcyA9ICZyZWFkX3RocmVzaG9s
ZHNfaWN4LA0KPiDCoH07DQo+IMKgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRpbW1faW5mbyBk
aW1tX3NwciA9IHsNCj4gK8KgwqDCoMKgwqDCoMKgLmNoYW5fcmFua19tYXjCoMKgPSBDSEFOX1JB
TktfTUFYX09OX1NQUiwNCj4gK8KgwqDCoMKgwqDCoMKgLmRpbW1faWR4X21heMKgwqDCoD0gRElN
TV9JRFhfTUFYX09OX1NQUiwNCj4gK8KgwqDCoMKgwqDCoMKgLm1pbl9wZWNpX3JldmlzaW9uID0g
MHg0MCwNCj4gK8KgwqDCoMKgwqDCoMKgLnJlYWRfdGhyZXNob2xkcyA9ICZyZWFkX3RocmVzaG9s
ZHNfc3ByLA0KPiArfTsNCj4gKw0KPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXV4aWxpYXJ5X2Rl
dmljZV9pZCBwZWNpX2RpbW10ZW1wX2lkc1tdID0gew0KPiDCoMKgwqDCoMKgwqDCoMKgew0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5uYW1lID0gInBlY2lfY3B1LmRpbW10ZW1w
LmhzeCIsDQo+IEBAIC01OTcsNiArNjE1LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXV4aWxp
YXJ5X2RldmljZV9pZA0KPiBwZWNpX2RpbW10ZW1wX2lkc1tdID0gew0KPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoC5uYW1lID0gInBlY2lfY3B1LmRpbW10ZW1wLmljeGQiLA0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxv
bmdfdCkmZGltbV9pY3hkLA0KPiDCoMKgwqDCoMKgwqDCoMKgfSwNCj4gK8KgwqDCoMKgwqDCoMKg
ew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm5hbWUgPSAicGVjaV9jcHUuZGlt
bXRlbXAuc3ByIiwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kcml2ZXJfZGF0
YSA9IChrZXJuZWxfdWxvbmdfdCkmZGltbV9zcHIsDQo+ICvCoMKgwqDCoMKgwqDCoH0sDQo+IMKg
wqDCoMKgwqDCoMKgwqB7IH0NCj4gwqB9Ow0KPiDCoE1PRFVMRV9ERVZJQ0VfVEFCTEUoYXV4aWxp
YXJ5LCBwZWNpX2RpbW10ZW1wX2lkcyk7DQoNCg==
