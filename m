Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41E770729
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjHDRco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjHDRcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:32:41 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11013006.outbound.protection.outlook.com [52.101.49.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED424C0B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5ALTXAt54v9RiM4xOFdYvPiBwGOS8hEWK6kEFg00EYbHnzVN+7mhxAqtn8fDdiq3aQgypz5PuJ22s5g67fKcH5s2ZqcxryQUtAepaVAL0fqVKS50FRLx5R89755qKzIw0H+3rSIBEmBwLpJjEh4exWoLxIVOqVBA7DOLkW3OlduQtWkHGC9xO/BIM2+tJExXUP3Fq2HO4JfYg5tR0CQ3umTesh1HcmgYjoJeKGuzrZ9K8JP757nlT/bcAFf49pP1aq/ObS7uaQryvrSSAMikgQWRyMKfdVb3tMaTDIfm8z1BeQx4swLLC/Lj/0b6Heg9S3+yBYaDL6A7rDpATh47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P1C2j12cDJMYBayOJMr/qVhna6Ozyxcco7hIQj1UmE=;
 b=egkJVXvxnoiNVum63ldMJBOasYCTqrS3AEJbu6UIlhD/lZvGWdedjxU6Sr9Yv/7Sg08qH5819A+GkacRSzD5ESdNJKbLJADevi50dR/IEAqrJVNDo9CImRz6Jzg8pOCZHPjhMWhuNUVzj90wInO6rQcaxt4CU0KekBbGBBGGNsOCh0/EUfnBlWhlGVDKqpMNwFRIYsXd44s/uPWQfS1DTdYFNCz3gZlgugfGFKS436phdQl3unmMzBaHkTeOal91XJIRIH4HB9euwfuHF8jszBXExDUNmk5itAySYYqq0LYAdGnpBhdXtxbpM0RrcV2aGqt51BOupJE0/1Xhv51B1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P1C2j12cDJMYBayOJMr/qVhna6Ozyxcco7hIQj1UmE=;
 b=IRXuEFAZMx3jCau+cDJJ0APcDi84hEz1Xs/7uEx4jAD9EyX29dzaTOshGUDmsJvTqthUyqJm6bQ/qs2fJHEgMo4QiqxQYv/JD2dYq/amRgrWkTsX0m5qseQ06/nU/WYpcNPYKJPIAfql/naJoaYTnavOTG2glrMArIVf/GyEeIg=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by PH0PR05MB7701.namprd05.prod.outlook.com (2603:10b6:510:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 17:32:30 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::cb5f:3cca:be0e:46f6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::cb5f:3cca:be0e:46f6%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 17:32:30 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Byungchul Park <byungchul@sk.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "kernel_team@skhynix.com" <kernel_team@skhynix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RFC 2/2] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Thread-Topic: [RFC 2/2] mm: Defer TLB flush by keeping both src and dst folios
 at migration
Thread-Index: AQHZxpvt9z94G2ovGUa0gZ/8II1oaq/aZgSA
Date:   Fri, 4 Aug 2023 17:32:30 +0000
Message-ID: <7023C1AF-6C9B-4544-8EC4-0BB790C1E338@vmware.com>
References: <20230804061850.21498-1-byungchul@sk.com>
 <20230804061850.21498-3-byungchul@sk.com>
In-Reply-To: <20230804061850.21498-3-byungchul@sk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|PH0PR05MB7701:EE_
x-ms-office365-filtering-correlation-id: 83f595c5-53de-42bc-43fb-08db9510c78e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pap+zXIg3FNekI+3IjvUscZcuJgojcYgAaODswETAjInbgQND9ONR1rjdCqDsjtgWspD6X1lrCbJgG2UTgXBJQ36VFcjkfaBmDxaKflU7ZE4Dww4vpTx+LEyeUFHyeT1vk60CAq9//Ie0hZNKI+PEib77nfjM7gjby9uleqaUb/syo9rR8S3P9i/84DHFoAIT2KARWYkwx95M+DeUELlhrytLaPDq5Bzf09qGEwKiQ1ubWg7UFrpaH9x0Y1emWSvFyjYrireudJz7iz2/666t56F91yWyVUui2eN/zGe3kYGru4HLoxYZ0h0TcvBHUGA9Vy9bx4PPzZcVOfR0J2+XlmeKvGbNgfyJ3Ge0wYhOgw939LH2ZFHkfFBzcoxH3ZCCoTi7ZeEGDmFmIRYTAV/1xC+53EEj0jUWf74FkQESRUWlHpwckWOH3EkSC08Aj2fnpMkBM+MRZZCbk8BOPJDDNuUUHl+BhOcfOV9cmzM4SfUaQGlvdzsQZoQn7vzcMon1r6c/TE1Pch6yC2lOrPQB4dqp1DW+qU9UhX/1RKE8K1pJuxNcETq3CBkjB+vrJsbj7aeuY3qoNAte8C0RjYCTwwp8+rk7IcljgeZYsCXA7Izw7K7oYnSiZBqY1sxXdo/ijfUl05cnVPGMq8etmnxEIu78fE7V/rPe14ChpJe6135mgJKwmwYPo5g8A1JolulQqy2hfgp86ERcAmlA4RQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(186006)(1800799003)(71200400001)(478600001)(6486002)(54906003)(2616005)(26005)(6512007)(53546011)(6506007)(2906002)(316002)(4326008)(64756008)(76116006)(66476007)(66946007)(6916009)(66446008)(66556008)(5660300002)(7416002)(41300700001)(8676002)(8936002)(122000001)(38100700002)(36756003)(38070700005)(33656002)(86362001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVNGT1o1QVFnVktpQVBnekRZdVJYanFQZ0VBUHRtaUxES2JIMTRvRUtnMUFO?=
 =?utf-8?B?a0QyL3ZXVTlOdFFvaHJVWlA0TmxCenlKY0JHQjRpM1lxeTQ5NjdJUWNxSkVW?=
 =?utf-8?B?dmhkMytWbE1TS003UmZhUVFrU1k3bU9ESE1yb2J1NzR0NXZXV2h1bGwrNnlG?=
 =?utf-8?B?Vm5RSXZDc0x0SjNQM3lKQU5Ra1RGR1dyd0dZV1lqL2x2Yk8vQzMycmVVVHlk?=
 =?utf-8?B?ekh3OVJ0YjNjMnUwanZsTTBtSDVlU0dITU82WUlyRGtxTXVqNzJ2ckZUcm5J?=
 =?utf-8?B?RkhmcVlyV2oyUlJkalhEYTJCMWhMNHZZYzcyNExrYk5idEdHeUR0UmJndHUw?=
 =?utf-8?B?TUdIOWhnWVpHSEVya29tUjNHQ09qVGswQVlaejVTOFhyRUdzWlJrZ3dBQjRY?=
 =?utf-8?B?aitablRKQTRyRnFOcGhuTWE2dy8rc0IvNUNMVE15WWZwMXVLS2JFWldnTXBQ?=
 =?utf-8?B?bDJGT2NORmJITXdtRXZSNkRzQ2VsdG1lMS9qNVpoM1FTM2Z1MFN4R1FBNCtP?=
 =?utf-8?B?ZkdKKzNqd09RUC9kOUUvc25pakg1MitWb25Denl6eklqNE9lWlBXb0pqYmM0?=
 =?utf-8?B?eWV0Y3lUd0VCWWV0Mys0OE5PRGJnWkJkR25vNFJDOGVFNVY2bkdDcHlUZWkw?=
 =?utf-8?B?RlF5NjlNZnh2akVNS2VQdG1oVWM5SDNtSm83ejc3L0U3TGc0Yi9VQi9VMUwy?=
 =?utf-8?B?Y3VObzllTzFzRUNSVE56bjM4VC83MEMyb2tleW5DaHpPYS9iVTBINlp5S2Nh?=
 =?utf-8?B?TjRlclJwSlFHNE4yK2t6b20vSndlVWtqS2luZEZuMy9CY05ram5RYVk3OWx2?=
 =?utf-8?B?THB1dmJpUGJTamdtcWs3eEd6M21kSUViWkptYndDR2YyY3VkWDM0YlBEV2pk?=
 =?utf-8?B?ditmNXpzKzhtd1BhRzlHYVRtcVN5Nm9vQVF3S1UzNHNlUTFDQkFsQUw5N2ho?=
 =?utf-8?B?WVR2N1cvYm9oenk3cFJlalB4OWEwQWR5Nk51aWxqMHBUM3g5dWo0UFNod0Uv?=
 =?utf-8?B?R1I0aWh1Z1lNdGlkMU9wcTY0bk1scEJ6NCtuNGovaGFHSHBERnhZdHdDY21l?=
 =?utf-8?B?cnBNaUhham1DbHdMNmJLUlJBbHlmSXg2a1ZyNVVpOSt3VVc1d0xCckxFaksv?=
 =?utf-8?B?WTJCWEJlQ0dmbTVGK2k4ZmJNc25SeTZldDRWSmJGbzdTZ0ozdC9pNytVd3Rn?=
 =?utf-8?B?cDdUM0s0QnNoV3pPVTFESXRFTjFTTjlBM2JkTC9Hd0JpWGZrcmhTMW5jZEk5?=
 =?utf-8?B?MFhEQkNCSnFCTzl0azdPeDBLZ2w3S21SWG11eWl2cXpTZmt0TkhGZ0Uxek5U?=
 =?utf-8?B?MVJVMHhSR0tqVjNjTWYzeURlTTg2VjZhdDlBWlZYbG8waHl6dk93ZGVCd0lM?=
 =?utf-8?B?WElSWmVRZ0Z5VUorSlptT3p6SmdzUHFjZHNUR0JjdmxXS2FJRWNodC9uMnZW?=
 =?utf-8?B?RWNMc09JdzBjTWpNMDJ4SDlGRkY2N3oyNmVad0pSdXJIM1p4cEhUVzY4U0Ns?=
 =?utf-8?B?L0c5Q2xaMzB0bnpOMnhuOThrNzI1eGNpSEY1U0gwaUVxdHBJVU0xb3NIbE5o?=
 =?utf-8?B?MkdIMVBnMzZCZHM5WXlkN1ZsZ1VJV0FHQTUxY1RIb29jNm5zT3hzeFdEUWFl?=
 =?utf-8?B?bWk0aU9BSUU3ME9HZFpEdDAzQlBlaVF2Q3lIUEZNNjhXRVdpeU15d1plYTZz?=
 =?utf-8?B?T1FGRHQ5Z051eWtoZzNCS2R3WHZ5ZDN2dTJWekNORjdLZmE5YWN4T0xrQ2tr?=
 =?utf-8?B?aGY4SGhDUkZqNXFkb2xRTXRKR0l3RWRiTE5ySzNZTS9TV29sdzkwbDcwSE1M?=
 =?utf-8?B?MGtObFdtSStFUUxsTWxkNXZQeVVSandIRVVlL2xSb2xnTFFreC8rZnN0MUV6?=
 =?utf-8?B?UjBLYy9ScGlmNGppb2tYYzFoZU42dEJ4V1d4UHhmWWRBL2YzMEc0MG1XSExD?=
 =?utf-8?B?UGUrazEydlJ6YzhmYWZYamFsMkdCazF4b2JtYjlMbUgvdCttZWQxNGV0Slhj?=
 =?utf-8?B?R1ZTTTY2YlBmVzVqbHVuRjdaUlZyWkM2M2NvTnNsQjljK09Ndmh4bW96VHlq?=
 =?utf-8?B?TTA5YVREemNza2Z1WElhWXBZRU9UKytEdDdGNVVSZVR2SVNNbS9tdGtCOStF?=
 =?utf-8?Q?X2Hr/HIGeCTJWskOiwCQNgTEg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0E057774BE53E4F8DBBDB3C001FE8A7@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f595c5-53de-42bc-43fb-08db9510c78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 17:32:30.3046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F20PFxvmtBGc6anXmx8kUZtocOnSox6gTnipYVWmkLDKzRcTQ8cbhVKWWjb/rB5NfmISepw7RAbtBO/i0yT6Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7701
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDMsIDIwMjMsIGF0IDExOjE4IFBNLCBCeXVuZ2NodWwgUGFyayA8Ynl1bmdj
aHVsQHNrLmNvbT4gd3JvdGU6DQo+IA0KPiBJbXBsZW1lbnRhdGlvbiBvZiBDT05GSUdfTUlHUkMg
dGhhdCBzdGFuZHMgZm9yICdNaWdyYXRpb24gUmVhZCBDb3B5Jy4NCj4gDQo+IFdlIGFsd2F5cyBm
YWNlIHRoZSBtaWdyYXRpb24gb3ZlcmhlYWQgYXQgZWl0aGVyIHByb21vdGlvbiBvciBkZW1vdGlv
biwNCj4gd2hpbGUgd29ya2luZyB3aXRoIHRpZXJlZCBtZW1vcnkgZS5nLiBDWEwgbWVtb3J5IGFu
ZCBmb3VuZCBvdXQgVExCDQo+IHNob290ZG93biBpcyBhIHF1aXRlIGJpZyBvbmUgdGhhdCBpcyBu
ZWVkZWQgdG8gZ2V0IHJpZCBvZiBpZiBwb3NzaWJsZS4NCj4gDQo+IEZvcnR1bmF0ZWx5LCBUTEIg
Zmx1c2ggY2FuIGJlIGRlZmVyZWQgb3IgZXZlbiBza2lwcGVkIGlmIGJvdGggc291cmNlIGFuZA0K
PiBkZXN0aW5hdGlvbiBvZiBmb2xpb3MgZHVyaW5nIG1pZ3JhdGlvbiBhcmUga2VwdCB1bnRpbCBh
bGwgVExCIGZsdXNoZXMNCj4gcmVxdWlyZWQgd2lsbCBoYXZlIGJlZW4gZG9uZSwgb2YgY291cnNl
LCBvbmx5IGlmIHRoZSB0YXJnZXQgUFRFIGVudHJpZXMNCj4gaGF2ZSByZWFkIG9ubHkgcGVybWlz
c2lvbiwgbW9yZSBwcmVjaXNlbHkgc3BlYWtpbmcsIGRvbid0IGhhdmUgd3JpdGUNCj4gcGVybWlz
c2lvbi4gT3RoZXJ3aXNlLCBubyBkb3VidCB0aGUgZm9saW8gbWlnaHQgZ2V0IG1lc3NlZCB1cC4N
Cj4gDQo+IFRvIGFjaGlldmUgdGhhdDoNCj4gDQo+ICAgMS4gRm9yIHRoZSBmb2xpb3MgdGhhdCBo
YXZlIG9ubHkgbm9uLXdyaXRhYmxlIFRMQiBlbnRyaWVzLCBwcmV2ZW50DQo+ICAgICAgVExCIGZs
dXNoIGJ5IGtlZXBpbmcgYm90aCBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIG9mIGZvbGlvcyBkdXJp
bmcNCj4gICAgICBtaWdyYXRpb24sIHdoaWNoIHdpbGwgYmUgaGFuZGxlZCBsYXRlciBhdCBhIGJl
dHRlciB0aW1lLg0KPiANCj4gICAyLiBXaGVuIGFueSBub24td3JpdGFibGUgVExCIGVudHJ5IGNo
YW5nZXMgdG8gd3JpdGFibGUgZS5nLiB0aHJvdWdoDQo+ICAgICAgZmF1bHQgaGFuZGxlciwgZ2l2
ZSB1cCBDT05GSUdfTUlHUkMgbWVjaGFuaXNtIHNvIGFzIHRvIHBlcmZvcm0NCj4gICAgICBUTEIg
Zmx1c2ggcmVxdWlyZWQgcmlnaHQgYXdheS4NCj4gDQo+ICAgMy4gVExCIGZsdXNoZXMgY2FuIGJl
IHNraXBwZWQgaWYgYWxsIFRMQiBmbHVzaGVzIHJlcXVpcmVkIHRvIGZyZWUgdGhlDQo+ICAgICAg
ZHVwbGljYXRlZCBmb2xpb3MgaGF2ZSBiZWVuIGRvbmUgYnkgYW55IHJlYXNvbiwgd2hpY2ggZG9l
c24ndCBoYXZlDQo+ICAgICAgdG8gYmUgZG9uZSBmcm9tIG1pZ3JhdGlvbnMuDQo+IA0KPiAgIDQu
IEFkanVzdCB3YXRlcm1hcmsgY2hlY2sgcm91dGluZSwgX196b25lX3dhdGVybWFya19vaygpLCB3
aXRoIHRoZQ0KPiAgICAgIG51bWJlciBvZiBkdXBsaWNhdGVkIGZvbGlvcyBiZWNhdXNlIHRob3Nl
IGZvbGlvcyBjYW4gYmUgZnJlZWQNCj4gICAgICBhbmQgb2J0YWluZWQgcmlnaHQgYXdheSB0aHJv
dWdoIGFwcHJvcHJlYXRlIFRMQiBmbHVzaGVzLg0KPiANCj4gICA1LiBQZXJmb3JtIFRMQiBmbHVz
aGVzIGFuZCBmcmVlIHRoZSBkdXBsaWNhdGVkIGZvbGlvcyBwZW5kaW5nIHRoZQ0KPiAgICAgIGZs
dXNoZXMgaWYgcGFnZSBhbGxvY2F0aW9uIHJvdXRpbmUgaXMgaW4gdHJvdWJsZSBkdWUgdG8gbWVt
b3J5DQo+ICAgICAgcHJlc3N1cmUsIGV2ZW4gbW9yZSBhZ2dyZXNpdmVseSBmb3IgaGlnaCBvcmRl
ciBhbGxvY2F0aW9uLg0KDQpTbyBJIHRoaW5rIHRoYXQgd2hhdCB5b3Ugd2FudCB0byBkbyBtYXkg
YmUgcG9zc2libGUsIGJ1dCBJIHRoaW5rIGl0IHdvcnRoDQpjaGVja2luZyBvbmNlIGFuIFJGQyB0
aGF0IGNhbiBiZSByZXZpZXdlZCBpcyBwb3N0ZWQuIFRoZSBjb21wbGV4aXR5IGFuZA0Kb3Zlcmhl
YWRzIHdvdWxkIHRoZW4gbmVlZCB0byBiZSBldmFsdWF0ZWQuDQoNClRoZSBwYXRjaCBpbiBpdHMg
Y3VycmVudCBmb3JtLCBJIGFtIGFmcmFpZCwgaXMgdmVyeSB2ZXJ5IGhhcmQgdG8gcmV2aWV3Lg0K
SXQgaXMgd2F5IHRvbyBiaWcgYW5kIGlzIG1pc3NpbmcgY29tbWVudHMuIEhhdmluZyBDT05GSUdf
TUlHUkMgbWFrZXMgbm8NCnNlbnNlIChJIGd1ZXNzIGl0IGlzIGludGVuZGVkIHRvIGJlIGEg4oCc
Y2hpY2tlbi1iaXTigJ0pLiBWYXJpYWJsZSBhbmQNCmZ1bmN0aW9uIG5hbWVzIGFyZSBub3QgaW5m
b3JtYXRpdmUuIFRoZSBtZW1vcnkgYmFycmllcnMgYXJlIGhhbmRsZQ0KaW1wcm9wZXJseSAocGxl
YXNlIGNoZWNrIGFnYWluIHRoZSBzbXBfbWJfX2FmdGVyX2F0b21pYygpIHJ1bGVzKS4NCg0KQWN0
dWFsbHksIHdoZW4gaXQgY29tZXMgdG8gY29uY3VycmVuY3ksIHRoZXJlIGFyZSBtYW55IHRoaW5n
cyBJIGRpZCBub3QNCnVuZGVyc3RhbmQgZnJvbSBhIGdsYW5jZSBhdCB0aGUgY29kZSB3aGVuIGl0
IGNvbWVzIHRvIGNvbmN1cnJlbmN5OiB0aGUNCnVzZSBvZiBsbGlzdF9hZGQgd2hlbiAoSSB0aGlu
az8pIHRoZSBsbGlzdCBpcyBub3Qgc2hhcmVkIChJIHRoaW5rPyk7IHRoZQ0KdXNlIG9mIFdSSVRF
X09OQ0UoKSBmb3Igc3luY2hyb25pemF0aW9uOyBtaWdyY19nZW4gc2NoZW1lIChhbmQgQlRXLCBz
aW5jZQ0Kc3VjaCBhIGNvdW50ZXIgbWlnaHQgb3ZlcmZsb3cgaXQgc2hvdWxkIGJlIGF0b21pYzY0
KS4NCg0KQnV0IG11Y2ggbW9yZSBpbXBvcnRhbnRseSwgZ29pbmcgdXAgb25lIGxldmVsLCB0aGVy
ZSBhcmUgc2V2ZXJhbCBpc3N1ZXMNCnRoYXQgc2hvdWxkIGJlIGFkZHJlc3NlZC9jb25zaWRlcmVk
L2Rpc2N1c3NlZDoNCg0KYS4gSXQgc2VlbXMgdG8gbWUgdGhhdCB3aGVuIGEgbmV3IFBURSBpcyBl
c3RhYmxpc2hlZCAoZS5nLiwgZm9sbG93aW5nDQogICBhbiBtbWFwKCkpLCBhbmQgdGhlcmUgYXJl
IHBlbmRpbmcgZGVmZXJyZWQgZmx1c2hlcywgYSBmdWxsIFRMQiBmbHVzaA0KICAgd291bGQgYWxz
byBiZSByZXF1aXJlZC4gU28geW91ciBwb2ludCAoMikgd291bGQgbmVlZCB0byBiZSBleHRlbmRl
ZC4NCg0KYi4gV2hlbiBhIHJlZmVyZW5jZSB0byB0aGUgcGFnZSBpcyB0YWtlbiBpbiBvdGhlciBt
ZWFucyAoZ2V0X3VzZXJfcGFnZXMoKSksDQogICBhIFRMQiBmbHVzaCBtaWdodCBhbHNvIGJlIG5l
ZWRlZC4NCg0KYy4gSWYgd2Ugc3RhcnQgZGVmZXJyaW5nIFRMQiBmbHVzaGVzIGZvciBhIGxvbmcg
dGltZSwgYW5kIHRocm91Z2hvdXQgdGhhdA0KICAgdGltZSBtYW55IGV2ZW50cyAoVExCIGZsdXNo
LCBwYWdlLWZhdWx0cywgZXRjLikgbWlnaHQgcmVxdWlyZSBhICpmdWxsKg0KICAgVExCIGZsdXNo
LCB0aGF0IG1pZ2h0IGhhdmUgbmVnYXRpdmUgaW1wYWN0Lg0KDQpkLiBUaGUgaW50ZXJhY3Rpb25z
IHdpdGggb3RoZXIgbWVjaGFuaXNtcyB0aGF0IGluc3BlY3QgdGhlIFBURSB0byBtYWtlDQogICBk
ZWNpc2lvbnMgYW5kIG1pZ2h0IG5vdCB0YWtlIGludG8gYWNjb3VudCB0aGUgZmFjdCBhIFRMQiBm
bHVzaCB3YXMgbm90DQogICBkb25lIG5lZWQgdG8gYmUgY29uc2lkZXJlZC4gVGhlIGludGVyYWN0
aW9uIHdpdGggbW11X2dhdGhlciBoYXMgYmVlbg0KICAgdGFrZW4gZm9yLCBidXQgdGhlcmUgaXMg
YSBxdWVzdGlvbiBvZiB3aGV0aGVyIHNvbWV0aGluZyBoZXJlIG1pZ2h0DQogICBicmVhayBpdC4g
IA0KDQpOb3cgdGhlcmUgYXJlIG1hbnkgdGhpbmdzIGluIHRoZSBwYXRjaCB0aGF0IG5lZWQgdG8g
YmUgYWRkcmVzc2VkIGFuZCBhcmUNCnVuYWNjZXB0YWJsZSBpbiB0aGVpciBjdXJyZW50IGZvcm0g
KGUuZy4sIG1pZ3JjX3RyeV9mbHVzaCgpIGZsdXNoaW5nDQpwb3RlbnRpYWxseSB0d2ljZSB0aGUg
c2FtZSBjb3JlcyksIGJ1dCByZXZpZXdpbmcgdGhpcyBwYXRjaCBpbiBpdHMNCmN1cnJlbnQgZm9y
bSBpcyB0b28gdGVkaW91cyBmb3IgbWUuDQoNClsgQlRXOiBmb3IgZnV0dXJlIHZlcnNpb25zLCBj
b25zaWRlciBjYydpbmcgUGV0ZXIgWmlqbHN0cmEsIEFuZHkNCiAgTHV0b21pcnNraSBhbmQgRGF2
ZSBIYW5zZW4uIF0NCg0K
