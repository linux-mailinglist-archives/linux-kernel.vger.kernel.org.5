Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BE87DB49E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjJ3HwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjJ3HwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:52:11 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azon11011006.outbound.protection.outlook.com [52.101.47.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E831DB7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXmiLJGZfo9lmlSYydvYWFOkZDFykrePi/NQhq781ow9EsGqjUzCFa3DWpbiUT22UEGKbYSA+CBgHExUqTQzmrRF2TSZidyGYKuFJipv5jgaqFvA6xdQoFcL9yNHkD4oNS4JInMDkC67b7w81IeJHcq8u2AQsheHsBkpVVFQxTCejfm3axGJV+V4S1/IElfAxawkRu2XU16awbrmVBmK39vAlOTMIUbkp2pTZ0Pxoirz7J2dwlKCTHW3Hsj28FHX/kGjeytXg+Mn2eLNCMa8hy/PmYjHYhbWVqRs7+E/O+a0J+BvVeNj7zW24Mo/YVf7hEGJQKzuBNmGl/Qq0lJ44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuDQYkU5zE9SzIr5BIxvoDx88zXcZqqhFBG5LE042N8=;
 b=DZ4zgGHGHbV75/gIkjsC+ssv8cASIQDT4zkCAYsJkR0isRRsSmTId4JWDq811iXEORlTuby+DP4Ypqe6gr1ZOf68RtBlo0IhQzmGnc0OHNt7SChpk9u42y3GubWOzF/Cer8v5IbBU90CQK22PyzKHk1QT8Gm6jx40szKnB7Hn910bg5PGS9aqPjd9aAw+fiocl34wxEtXnbN105ngtbrhsOMyCoRFcffRkTA/RHUciqFsCrgLFl6PC1+hz18VRFoB/O4zTfqgY4XDHx9NGYXF0QvRRZkcTipgqSYm+KOqnqqsnQSbKhcYfWXG4g8B+jfD95x3EK2W6V/JOVFwIPbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuDQYkU5zE9SzIr5BIxvoDx88zXcZqqhFBG5LE042N8=;
 b=kLTARrf1tdOb8e1HoEFJiEXgpy0jn60E6EilVFrC19+lN2esEMcjl6n4RKF3IoDru9qUNJOZ6loGbzV/oCg5plekNi7oIEY3qwZV2m3A6Of1XK4DUqtW4KD3m7BRN21sFdaWekmx9nphlzJvMEg9i7NLODqJ5oaAOzwadZWr7Dw=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CY8PR05MB10153.namprd05.prod.outlook.com (2603:10b6:930:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 07:52:05 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::b668:aef3:606e:923f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::b668:aef3:606e:923f%4]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 07:52:05 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Byungchul Park <byungchul@sk.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [v3 1/3] mm/rmap: Recognize non-writable TLB entries during TLB
 batch flush
Thread-Topic: [v3 1/3] mm/rmap: Recognize non-writable TLB entries during TLB
 batch flush
Thread-Index: AQHaCwJUaV3x06E/C0qKHOdsSMyqCLBh9eEA
Date:   Mon, 30 Oct 2023 07:52:05 +0000
Message-ID: <1DB097E6-6585-4D10-95C9-7BAA5A622B7E@vmware.com>
References: <20231030072540.38631-1-byungchul@sk.com>
 <20231030072540.38631-2-byungchul@sk.com>
In-Reply-To: <20231030072540.38631-2-byungchul@sk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CY8PR05MB10153:EE_
x-ms-office365-filtering-correlation-id: 3de838c8-f13c-4680-31e4-08dbd91d1c85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 264c6b4il+U/fNGxrG2XAyH5L4MEivsy+nDbgiM6adSaYCM9nu2VGV4uvnnhlNAi1diu+xlYvY1Xle6tqxOtDhQ55HjT828tGi6g+FH9FKlZRhJN+M/63YbDSBSGayG8PmOETn71ylIQdP9wPtSU9hM9U57k1/os0VW75+rE741hNcJH1+7MNpHoM44uUYkCVCzx0OHpbY4X9yksxfgJbHhIFe2cAX6SvWQnso/NbKBZjKCfqaCWUmFFsGpiR7zOl8IzWyJ+Qorg4H5FU9USYK65EH1LzYITqluR9KYPhdKODmiBs5a0iWxg4YooD1njaBbBCtOSGvFeIOkcW70p5qUkYSFtPfuY3WqUU5M6lwCmygA5u0kQfah/ybVZ4SzfuXe22ei8Wj7i4JvFnDNeiVXCpdAN5qq2T3ErD01lGvDD1pZCdoTC5Ryh+OAoqRJ3LiJxXm6h0t0inO1XCSDHKSRRwhIl0VVIre+f9Mon8t7jreN4B6g5mllwlWvSWFKK+oC7F11ABMOmLfsLTIZ84PWq1MusAaKGwHRWr1opclrPhDYfAQNng13auS/RcR19W+DhfpQBYsD7/iSpSteebaJg+qXyWc7Z2BpRaQNb7UGJrtBPEhJ106XJsJ5rMVkjqWBS6em8K2Vqzd4PotOjyyzFlIuAE0jx+sgQ96RYex8g16xsTQnNLzUlCC+IU3BcimZyj+fjxRq83OKfIBRjpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(71200400001)(83380400001)(91956017)(41300700001)(33656002)(86362001)(2906002)(26005)(7416002)(36756003)(5660300002)(2616005)(38100700002)(122000001)(38070700009)(66446008)(6486002)(66946007)(6512007)(54906003)(76116006)(4326008)(64756008)(66556008)(6916009)(8936002)(66476007)(316002)(478600001)(8676002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU9CaEtHaTkzVmVWVTIvWTJWQ1F5Y0JDV0VuQjNEMDB2a1FFa2k5bzdmYlhl?=
 =?utf-8?B?SFk0V2RPZzlDSkZXRHhFT0ZXRWFVempGM1NBSy92eGNoUnFZdzFlaStKdHNx?=
 =?utf-8?B?OXlkVi83dGJQMFFPc2hRWmpiYkpjMTc3a0lRazBic2hUelk5UWdjQlFQeURt?=
 =?utf-8?B?UXJub1NmaXBESUpmYndsUmZKRHUzZkhRaGd3TDMzWlJHRk9wNzV5VGFiR01j?=
 =?utf-8?B?RkVlRnF2aGtxNGUxcG5SaWFkWkN1WUlGSUpXdzdQN3pRYk4yQy9PR2ZYcHlj?=
 =?utf-8?B?MXFrUDU4TUZDSjRxdG56RlRWVTRhMGZjSVRoQUhNRHd0TG00ZFJ2QUJZbnFi?=
 =?utf-8?B?VnczTGZZckRTM3BUY3FyRWtiZ0RJVzlqeWs2eVp2YVJjZHd6cUZYV2U3RnRy?=
 =?utf-8?B?c3VQcXNCZDNWdmI1WTJtbyt3L05JSWNQbmpBYkhoOXphSGVpa0E0SitBWnZ2?=
 =?utf-8?B?R0dOanlqOVJPQzJyT3JYenBrejJVRGNNcHovM0pONFl1dmtuckhNeVF2RzVo?=
 =?utf-8?B?d3F3YWl1blJKUHRaVlZjSjVKbWZwcVdIamprSVZMTjBnUU1sSm5WZE5oUTlM?=
 =?utf-8?B?NGhHL0laakgrL2FjMnNLY0RHU0xLYTVGcDlzL2x2UW9Kb3NWSkFEWUJRczdI?=
 =?utf-8?B?TDdieTU2U000emFLWmhMazFxaUpOMXlCSE9vU0Z0Z1JSOVQ4Zk5LNFJoWHZj?=
 =?utf-8?B?eGdyclpVSlRSYWJjZHFPSEVJNzZpMExFZjgxcUQzVnlsaVlQU0U2aTVIQ0ZF?=
 =?utf-8?B?M2ttQzJZUERxeDgzZmtHZGQyVzdHS2o5UW5nQzk5cWlRT05FVnhmbDA5RE0w?=
 =?utf-8?B?aFc2T2ZuNUJuUXNEbmR1ZFZILzVPbTBmZG5Xd0NoWVRDTEFTcGp4cW5XYXhE?=
 =?utf-8?B?Q3ZieXFJT09kbzBsQTZrUU1ka1JINjN6MjFiSWIwVk11RENnWDZyQ3B0QTFW?=
 =?utf-8?B?R283YnlpVkl2OUxjY2Nxa1U4TkZLbFgyZU54bk9wSnFYMHZQeHJqclVwWjBx?=
 =?utf-8?B?ZE9SWUdzdTVSRnNjMy9scHIwOGZuRVVsaCtmVDRaN2VvWnlYdXhIbEtncSt3?=
 =?utf-8?B?YUJJdTMvcWhNT0VXM1ZKcFhGZGxtL3dHK2NHYjdOTHFWdEpGZTZpSllucmY0?=
 =?utf-8?B?dkZIQ3pzaEl0RFI0ZTRUWThXejRJWk5mS1k4bVZYRGc1aW5HVTM1WE9aajVi?=
 =?utf-8?B?bnNsZTdLMHR1RExNL1EvWE5PNEwxUjE1Ui9vQzAzTk9MZW5OWGpTS1k0K2pG?=
 =?utf-8?B?OUdZanVzaStRc2ZPUmNvMjZ2K1hkMkhSd1E2a1RPVWR6N3BjN2FIYlpZeXJk?=
 =?utf-8?B?SVVQQlJpYktodkxqNStoYWJvVWhCcFFDNkZqVTV0eWgrdFpnZ01OV1UwM0lY?=
 =?utf-8?B?Qnoyc3V4c1ZZWDZUcGNwaDBBZlNxZENpMXB0ZnFyL3IvTEtjSy8rdGp0MzFC?=
 =?utf-8?B?cEhiK3JaV1U1NGt0N0FjcVVQT3ZBWkpnMjlJcDlXd3FxMFdndzBXMjd0RVM4?=
 =?utf-8?B?UHFVdjVaelI3R3AzVjNzRE1WSnh5RGRLZ1lEcWF4WitGQlk0SDNJcmdlK1JV?=
 =?utf-8?B?R0lNaG1JaUxVWFliWC9yakpUbnBCQkU2MG9kU3F5ZjF4TW5sZ29QTUFnMEZx?=
 =?utf-8?B?blA3SUFHT2FoRmxsQmc4VEpnRkRQaVpaTmY5dzNzeGZpdEhEeEEybjVWVVhj?=
 =?utf-8?B?dEttNmtwR0ErVjREeDBMRVFKcDZwRExtNEM5UmJlaGFCMUpYSEFyakYxa0hq?=
 =?utf-8?B?T250ek1UK2tTcDhMeUQ0R2dYQjhUejJHcGdJUkh0U0VROEEzVWJmdkRDVmRV?=
 =?utf-8?B?anEySXhlU3FDVnZCWVNUOXZGMWpRMFpSV1A5bTNTVW1MeExZMnBEUzNwblJz?=
 =?utf-8?B?VkE1UkEvZ01xS2ZjeG1pWW1FRlltdDl4TmkzR3NHWi9KcUh5bDRSR2xwdnht?=
 =?utf-8?B?SnJEbThYNnNndks4VzErMmZwTnZXUGo5QUxSemlMVk1ud1A2VG9Pb2xHd0Vm?=
 =?utf-8?B?Tm9FWmhNVS9JSVRGcEhiYjYycGlpQnhoSlF4WE9tRitOZzNKVmw3OXB2KzFk?=
 =?utf-8?B?QmxWVUNJaDgyNGZLRk1vSzhYay9zUC96V2xuRTIvZjV6RjIwUnZPZUxSM2hj?=
 =?utf-8?Q?srABTj+OJUwlm/0Magc6b2jhR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFBE396C1F7C8A41B007D2E009C790E2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de838c8-f13c-4680-31e4-08dbd91d1c85
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 07:52:05.8822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzU+LyInpWIRdz0v73z5XB3IMNQP1sFsOteMLezO93DDthAPr1NsJvIPU+0JtiF9O1ruPcISWIi6+EtcQxXwBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR05MB10153
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpCZWxvdyBhcmUgc29tZSBwb2ludHMgeW91IG1pZ2h0IGZpbmQgdXNlZnVsOg0KDQo+ICsNCj4g
LyoNCj4gICogQmxpbmRseSBhY2Nlc3NpbmcgdXNlciBtZW1vcnkgZnJvbSBOTUkgY29udGV4dCBj
YW4gYmUgZGFuZ2Vyb3VzDQo+ICAqIGlmIHdlJ3JlIGluIHRoZSBtaWRkbGUgb2Ygc3dpdGNoaW5n
IHRoZSBjdXJyZW50IHVzZXIgdGFzayBvcg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9t
bV90eXBlc190YXNrLmggYi9pbmNsdWRlL2xpbnV4L21tX3R5cGVzX3Rhc2suaA0KPiBpbmRleCBh
YTQ0ZmZmOGJiOWQuLjM1YmE5NDI1ZDQ4ZCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9t
bV90eXBlc190YXNrLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9tbV90eXBlc190YXNrLmgNCj4g
QEAgLTU5LDggKzU5LDggQEAgc3RydWN0IHRsYmZsdXNoX3VubWFwX2JhdGNoIHsNCj4gCSAqLw0K
PiAJc3RydWN0IGFyY2hfdGxiZmx1c2hfdW5tYXBfYmF0Y2ggYXJjaDsNCj4gDQo+IC0JLyogVHJ1
ZSBpZiBhIGZsdXNoIGlzIG5lZWRlZC4gKi8NCj4gLQlib29sIGZsdXNoX3JlcXVpcmVkOw0KPiAr
CS8qIFRoZSBudW1iZXIgb2YgZmx1c2ggcmVxdWVzdGVkLiAqLw0KDQpOdW1iZXIgb2Ygd2hhdD8g
QmFzZSBwYWdlcyBJIHByZXN1bWUuDQoNCj4gKwlpbnQgbnJfZmx1c2hfcmVxdWlyZWQ7DQoNClBl
cmhhcHMgdW5zaWduZWQgd291bGQgYmUgYmV0dGVyIHN1aXRlZD8NCg0KPiANCj4gCS8qDQo+IAkg
KiBJZiB0cnVlIHRoZW4gdGhlIFBURSB3YXMgZGlydHkgd2hlbiB1bm1hcHBlZC4gVGhlIGVudHJ5
IG11c3QgYmUNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2NoZWQuaCBiL2luY2x1ZGUv
bGludXgvc2NoZWQuaA0KPiBpbmRleCA3N2YwMWFjMzg1ZjcuLjYzMTg5YzAyMzM1NyAxMDA2NDQN
Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9zY2hlZC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc2No
ZWQuaA0KPiBAQCAtMTMyNCw2ICsxMzI0LDcgQEAgc3RydWN0IHRhc2tfc3RydWN0IHsNCj4gI2Vu
ZGlmDQo+IA0KPiAJc3RydWN0IHRsYmZsdXNoX3VubWFwX2JhdGNoCXRsYl91YmM7DQo+ICsJc3Ry
dWN0IHRsYmZsdXNoX3VubWFwX2JhdGNoCXRsYl91YmNfbm93cjsNCg0KdGxiX3ViY19ub3dyIGlz
IC0gSSB0aGluayAtIGxlc3MgaW5mb3JtYXRpdmUgdGhlIHRsYl91YmNfcm8gKGFuZCBhIGNvbW1l
bnQNCndvdWxkIGJlIHVzZWZ1bCkuDQoNCltzbmlwXQ0KDQo+IA0KPiArDQo+ICtpbnQgbnJfZmx1
c2hfcmVxdWlyZWQodm9pZCkNCj4gK3sNCj4gKwlyZXR1cm4gY3VycmVudC0+dGxiX3ViYy5ucl9m
bHVzaF9yZXF1aXJlZDsNCj4gK30NCj4gKw0KPiAraW50IG5yX2ZsdXNoX3JlcXVpcmVkX25vd3Io
dm9pZCkNCj4gK3sNCj4gKwlyZXR1cm4gY3VycmVudC0+dGxiX3ViY19ub3dyLm5yX2ZsdXNoX3Jl
cXVpcmVkOw0KPiArfQ0KDQpJIGhhdmVu4oCZdCBnb25lIHRocm91Z2ggdGhlIHVzZXJzIG9mIHRo
ZXNlIGZ1bmN0aW9ucyB5ZXQsIGFzIHRoZXkgYXJlIG5vdCBpbmNsdWRlZA0KaW4gdGhpcyBwYXRj
aCAod2hpY2ggaXMgdXN1YWxseSBub3QgZ3JlYXQpLg0KDQpBbnlob3csIGl0IG1pZ2h0IGJlIGEg
Yml0IHdhc3RlZnVsIHRvIGhhdmUgYSBmdW5jdGlvbiBjYWxsIGZvciBzdWNoIGEgZnVuY3Rpb24u
IFNlZQ0KaWYgaXQgaXMgcG9zc2libGUgdG8gYXZvaWQgdGhhdCBjYWxsLg0KDQo+ICsNCj4gLyoN
Cj4gICogRmx1c2ggVExCIGVudHJpZXMgZm9yIHJlY2VudGx5IHVubWFwcGVkIHBhZ2VzIGZyb20g
cmVtb3RlIENQVXMuIEl0IGlzDQo+ICAqIGltcG9ydGFudCBpZiBhIFBURSB3YXMgZGlydHkgd2hl
biBpdCB3YXMgdW5tYXBwZWQgdGhhdCBpdCdzIGZsdXNoZWQNCj4gQEAgLTYxNSwxMSArNjQxLDEy
IEBAIHZvaWQgdHJ5X3RvX3VubWFwX2ZsdXNoKHZvaWQpDQo+IHsNCj4gCXN0cnVjdCB0bGJmbHVz
aF91bm1hcF9iYXRjaCAqdGxiX3ViYyA9ICZjdXJyZW50LT50bGJfdWJjOw0KPiANCj4gLQlpZiAo
IXRsYl91YmMtPmZsdXNoX3JlcXVpcmVkKQ0KPiArCWZvbGRfdWJjX25vd3IoKTsNCj4gKwlpZiAo
IXRsYl91YmMtPm5yX2ZsdXNoX3JlcXVpcmVkKQ0KPiAJCXJldHVybjsNCj4gDQo+IAlhcmNoX3Rs
YmJhdGNoX2ZsdXNoKCZ0bGJfdWJjLT5hcmNoKTsNCj4gLQl0bGJfdWJjLT5mbHVzaF9yZXF1aXJl
ZCA9IGZhbHNlOw0KPiArCXRsYl91YmMtPm5yX2ZsdXNoX3JlcXVpcmVkID0gMDsNCj4gCXRsYl91
YmMtPndyaXRhYmxlID0gZmFsc2U7DQo+IH0NCj4gDQo+IEBAIC02MjcsOCArNjU0LDkgQEAgdm9p
ZCB0cnlfdG9fdW5tYXBfZmx1c2godm9pZCkNCj4gdm9pZCB0cnlfdG9fdW5tYXBfZmx1c2hfZGly
dHkodm9pZCkNCj4gew0KPiAJc3RydWN0IHRsYmZsdXNoX3VubWFwX2JhdGNoICp0bGJfdWJjID0g
JmN1cnJlbnQtPnRsYl91YmM7DQo+ICsJc3RydWN0IHRsYmZsdXNoX3VubWFwX2JhdGNoICp0bGJf
dWJjX25vd3IgPSAmY3VycmVudC0+dGxiX3ViY19ub3dyOw0KPiANCj4gLQlpZiAodGxiX3ViYy0+
d3JpdGFibGUpDQo+ICsJaWYgKHRsYl91YmMtPndyaXRhYmxlIHx8IHRsYl91YmNfbm93ci0+d3Jp
dGFibGUpDQo+IAkJdHJ5X3RvX3VubWFwX2ZsdXNoKCk7DQo+IH0NCj4gDQo+IEBAIC02NDUsMTUg
KzY3MywxNiBAQCB2b2lkIHRyeV90b191bm1hcF9mbHVzaF9kaXJ0eSh2b2lkKQ0KPiBzdGF0aWMg
dm9pZCBzZXRfdGxiX3ViY19mbHVzaF9wZW5kaW5nKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBwdGVf
dCBwdGV2YWwsDQo+IAkJCQkgICAgICB1bnNpZ25lZCBsb25nIHVhZGRyKQ0KPiB7DQo+IC0Jc3Ry
dWN0IHRsYmZsdXNoX3VubWFwX2JhdGNoICp0bGJfdWJjID0gJmN1cnJlbnQtPnRsYl91YmM7DQo+
ICsJc3RydWN0IHRsYmZsdXNoX3VubWFwX2JhdGNoICp0bGJfdWJjOw0KPiAJaW50IGJhdGNoOw0K
PiAJYm9vbCB3cml0YWJsZSA9IHB0ZV9kaXJ0eShwdGV2YWwpOw0KPiANCj4gCWlmICghcHRlX2Fj
Y2Vzc2libGUobW0sIHB0ZXZhbCkpDQo+IAkJcmV0dXJuOw0KPiANCj4gKwl0bGJfdWJjID0gcHRl
X3dyaXRlKHB0ZXZhbCkgfHwgd3JpdGFibGUgPyAmY3VycmVudC0+dGxiX3ViYyA6ICZjdXJyZW50
LT50bGJfdWJjX25vd3I7DQoNClVzaW5nIHRoZSB0ZXJuYXJ5IG9wZXJhdG9yIGhlcmUgaXMgYSBi
aXQgY29uZnVzaW5nLiBZb3UgY2FuIHVzZSBhbiDigJxpZuKAnQ0KaW5zdGVhZCBvciBpZiB5b3Ug
bWluZCBpcyBzZXQgZG9pbmcgaXQgdGhpcyB3YXkgYXQgbGVhc3QgbWFrZSBpdCBlYXNpZXIgdG8N
CnJlYWQ6DQoNCgl0bGJfdWJjID0gKHB0ZV93cml0ZShwdGV2YWwpIHx8IHdyaXRhYmxlKSA/ICZj
dXJyZW50LT50bGJfdWJjIDoNCgkJCQkJCSAgICAmY3VycmVudC0+dGxiX3ViY19ub3dyOw0KDQpB
bmQgb2YgY291cnNlLCBhZGQgYSBjb21tZW50Lg0KDQo+IAlhcmNoX3RsYmJhdGNoX2FkZF9wZW5k
aW5nKCZ0bGJfdWJjLT5hcmNoLCBtbSwgdWFkZHIpOw0KPiAtCXRsYl91YmMtPmZsdXNoX3JlcXVp
cmVkID0gdHJ1ZTsNCj4gKwl0bGJfdWJjLT5ucl9mbHVzaF9yZXF1aXJlZCArPSAxOw0KDQpQcmVz
dW1hYmx5IG92ZXJmbG93IGlzIGltcG9zc2libGUgZm9yIG90aGVyIHJlYXNvbnMsIGJ1dCBzb21l
dGhpbmcgbGlrZSB0aGF0DQp3b3JyaWVzIG1lLg0KDQo=
