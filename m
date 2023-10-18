Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52647CE218
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjJRQDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJRQDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:03:07 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013001.outbound.protection.outlook.com [52.101.64.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7C0120
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPKSj0KvIQEvNYCB+KeXlVp2pVMTit/9dUl3SpK+6lPIblMO4U8Ilg2KZtksCcj4yeXgAumAsWECMe9iPHwpvSFnZUcY3qMedRn/ky/mwzy9x7BTBQt2xbDR6xwtpACoD1WkxYy1mYSNLhp2JtnY0PKqgh6oyuqSjH7Ird7PYulIEzf6DsAHQKnW/focf5WN513u4G4S3OpzqRzL3+vPdwTcd+KmTqRSVgxrICtgOUVBih0afUkWsUm/0yFjaajndWM1BTovjc0Z8mKrwlB6i7wokoJ9HaN5ngZE1nmduZMAdkmCZA44Ti59d+ifC1+yDVGMA9IPLMosEdECI2jwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVQKyaiyBNQazgzE+MAsDa4E/3zNCelsm8/JeAlIdYc=;
 b=BLIXSsH6gTo46MBlyXFkGwysctKL40JNImvkFxbquu2sDDqJdY+WRzEl2ycTkA9DogB3WJ1m2tfNJXJLx4DYBJwY/MO2IAnkZs+wp4baZCyaxPIAWH4CWMw/SiHE9067br1+wI7fMT+OLoT+etdCuzzZeSGA4ksJZ9hEYrvDq6iQJuQtNSJTx6oPqd9EzHgUuhyq2nq+2L9K1ELQoqnWt4DiYGOTLnmWfUrZ2jkw4mLrCRhCXsZ1oqLbqV67six5RKcAzJe6Ya1fhBZf+GvOZLz/uE5HcXa6nfOvoc+dhUdfu+Ist0YzdPDzFNegX73wlAhflnyBUrqncy9Ulx/KyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVQKyaiyBNQazgzE+MAsDa4E/3zNCelsm8/JeAlIdYc=;
 b=U3u5hh3GhgiQ9hWZ7VGBJ8w3XhBBjGUXEF52Pmyu4B50+74xp7aaEwPNIqfRQJdvxga/GZl9nsVT7oEWZ9XvD8oWNx5vRKRqdo+6wikLczMIYrDdN0Ywq5wj+gsiUI+mmlXo+QTkIUYcaflcbuLdoncF2ET9Y4cWzOO+MfcG2Ws=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by PH0PR05MB7961.namprd05.prod.outlook.com (2603:10b6:510:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 16:03:01 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6886.039; Wed, 18 Oct 2023
 16:03:01 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Uros Bizjak <ubizjak@gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Thread-Topic: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/FrBDSECAgAAOE4CAAAQxgIABoxnfgAAgI4CAAAYlgIAHqOMRgAAI04CAADzyiIABTsvzgAADAQCAAB/hAIAADVOAgAClpgCAABXQAIAANUA7gAAQyoCAACJcPoAADHsA
Date:   Wed, 18 Oct 2023 16:03:01 +0000
Message-ID: <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com>
References: <20231010164234.140750-1-ubizjak@gmail.com>
 <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com>
 <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com>
 <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com>
 <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com>
 <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com>
 <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com>
 <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
In-Reply-To: <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|PH0PR05MB7961:EE_
x-ms-office365-filtering-correlation-id: fc9a415b-1116-48e1-1d95-08dbcff3b44b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F3Oj9hvNgoxgICXPC51eWc5HlRxv0xGm7oZDkUqTFw6RW3Z+VamQ/Nl7iPzzt5S2ytcYKKprH/xV8AHaIG+3mVOBr+cThK8khaJiD9IinO2ibQPNYZzu311O0xki6XAAKpx5Y98xMWz0xuZQGYef2zQfTi92KzPB6eqHjtNNWExdKzSKTwnRpttyb491rAnruU6cyuEd5ttOJmi73oSGbAc7v1UKKnWmtJbxetewxBX79UXwvO0AaK8tXvIK8DPjlSP+Uj3KxKsW+AUww4yrD4TXdJ0mGRgUuyqUENyoroxJIixO5sUnUQ6ADpteDB8stdX7DISTWu3vslUmPwm5+GbF53OhmoiEsMCJQKB1ilhQ9Kspqi1lL8w5KdszbKvkY7B5AnCqiDD+pcPe92PL+ej05Xg4hAPiKLjKFzg1H43ZL5ArFEeoeDrpAN6v1Rr8svlh6R8jcEGBvxPbsJ8/wQ8pp52JPJ7JV+pPHqKxaqb9ac7bN/bKCaPpJENfjtjphEMoFdUG6f4gfuFYCMleafryR1qiUYIuqnQqsl/XhBFnrF8GRktOkm3XAU87trBkq+hbGLjxzrr4ZpYhBOpYkczXTN1qkBKz45cgg/adMJg1dhR9ZbzlhYh0eQ4TyXe3FpSD7sEMIxwqP0RRLSdI+G/CLTeanCQVZlByj5MDmKmAyFOYAGkiK+EsBNWZOtBQr8jrSoFX8CU0OaZCGkeYGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(38100700002)(478600001)(5660300002)(6486002)(66946007)(76116006)(91956017)(83380400001)(4326008)(71200400001)(86362001)(7416002)(4744005)(41300700001)(66446008)(8936002)(8676002)(2906002)(53546011)(66476007)(66556008)(6506007)(54906003)(64756008)(316002)(6916009)(6512007)(38070700005)(2616005)(26005)(122000001)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmFIbjhYMEJ4YzFkbU11N2dSMUs1ays1dG1PcGNuRHpBT0F3MjZFYU9COUYx?=
 =?utf-8?B?ekYzcHAwOWUxaDZOTGpnUEZhVzRrQXVPbDBDbi91RTF4RnpQU1BpaDYydDNS?=
 =?utf-8?B?aWtCY0hLOXc3SFhWMHJMT0JHa1JHOFg5VkZaY21nWlNBOEZYdDhzUjRZZExv?=
 =?utf-8?B?TUZXSU13Z3ZFUS9aMkdqaFpQNnExcjBBVkx5S1pPeHhNNFYzblZ0SGZkbUJ6?=
 =?utf-8?B?UGJ4RjBqMmtNUEhnTURZSXVYOStEYXF2TWI4ZSsyTGplVU1NTEJDT3ZELzJC?=
 =?utf-8?B?ZWpZdldubytSOExlMnBXaXU2NUZFazhkaitMTFg5ck5JcUdVUXJvNWVCMkF2?=
 =?utf-8?B?QUdTYkQrZnpUQWNWMStDTDc0WHhYMW1uMFRrLytrWDYyY1RJbWNhUmoycWZU?=
 =?utf-8?B?K0JMM2pFdytEUEtYaVZaeEZ2VXdUVmI5cTZTenNoNno2cWpVU0N0ZHlLU2oy?=
 =?utf-8?B?ZDhONUJjam5Zbys5M0NWWlVlUGdmK0NQd2s3bFNrMmFyMGFjbVlUMWN3MVNY?=
 =?utf-8?B?cGhFM0cyMzg3OWhDUjNweC80Q2IzcFoya0laTGFtVnZ1NHgxMWR1dGhlYWgx?=
 =?utf-8?B?S3pxMUtBaWs0YitXcXdEanB1c1h0aFBiRFpWZG5mQzhkc25GL2JvVlNyZ2ln?=
 =?utf-8?B?dXlXeHZMcGVFbjJJSll3b1J6MlZHWkhqNmFBNHQ0M1pKZmZ4SUs2cjBLbmoy?=
 =?utf-8?B?bE5QakRaSXIzYWtqNi8rdWs0UnpJNlc0b2ZzL1R3d0o0TWZtc2N5UDJOTTcw?=
 =?utf-8?B?RTdxMFlHdVByamdFaytYWjFEZ1RIRUJBWmdtSEs2a0NWL2xMRDZneVprdW8z?=
 =?utf-8?B?ZGtyNzVUZVhBMGZYTldZSW5GRHh5YU9ld2hrWTJKR1ZrY1Rac2pyVnczRmpu?=
 =?utf-8?B?NCtUVzJWK2Zmc0hwUmlVazNQK05HTW5LcCs5RUJpRmI1TkYvUXFRMkVrNnlF?=
 =?utf-8?B?cTFqQlg5ZEtndnFkLzBVK3R5QU5rbU1jM0JqcGxUT3pVTFEreEZ1TXNJOXF0?=
 =?utf-8?B?aUdJZ1RSejN3TitVbWlyck51ditWK3hiMlpQUVo3S3ZTeUhnSjkwSkp5aXVV?=
 =?utf-8?B?cXZPcGhkWnBLUmRlcEYzeFluZ0JGQ0FPZjFVSDBleTYrV2JEaVhXT0UvOWwx?=
 =?utf-8?B?T3o4TWNMdkdRZWFyREQydXk3TW9EeXJOdzhjd3QzKy9nZGxWdnlHejM2bCta?=
 =?utf-8?B?QjMzMWVzbHp1OXFtTVFHVW1STHdkazJuUlYrcUxiVkhsWnQzMGt4QUJXZHRl?=
 =?utf-8?B?ZndMTHMveDNoOWpYZkFTZDl5ODRqUklqbUxEcTlXNWxGbG9tOTFYM0lZSTdR?=
 =?utf-8?B?ZlNEdEtGMWorZGx1dTI1d3FxSWJYU2tkdzJvQlN4NkpiSEwyeCtRU0JjclZT?=
 =?utf-8?B?c3BEOU1kNnZYc3RWcnFUNC84QnZDYzJBeXFRclZwU25kOFUyeXhoeDVpOVRt?=
 =?utf-8?B?ckFraGRrdUFab0lEU014ZjNFekF4TU5aWUs5UDJuZ3hzK3lrelJESVJzU083?=
 =?utf-8?B?eHA0dm1qdkJWVURPd1RKd3NQQ1FzczB6ZlNPR25kU2Z5VFVZWExSNy9GdGU3?=
 =?utf-8?B?SXQxdTg0d0NjbkhobTRSQ3RUWG9zYml3ZzFIYTZpNzhVTnNJMlNBMFV6cDIw?=
 =?utf-8?B?V0FaNkppcEp2Z0hNTFJ2Vkp0NGdyeFl6ZXpMOUQ3d1ZYajd4UkFHNVpKSWo4?=
 =?utf-8?B?ZDIwV2gyVDlQMlRRK1pBYVZxWUUyVXNMMk9PU1BqVzg2eS9NQk0yTHBwTGZO?=
 =?utf-8?B?UXljZWxXMFQ0djNNMk1QQWFydEhRSWkyaFVoNHh2ZjF1M3hiYXlUQThNdkk1?=
 =?utf-8?B?dDRHY3RnS3p2RGZId1ZqaGtiUytST3pMa2FFT0hJaStyRVJXNjl1VllSa01X?=
 =?utf-8?B?TmduNDIyS2dwNFE1THNlRjFCT2dtNlMrbHY2MjRXaUN1UENkT1RiUWZnSjg0?=
 =?utf-8?B?cXoxN1h6SEZPM2lvM250YzBueG5GNm5FR3d3OGhhdHBtMVlwV0pSSlRhd0cy?=
 =?utf-8?B?QklwMCtMVVFoOCszKzhkV292dGhHdGZLM0ZyUHRneGx5b0hqMEFoYWltMHc0?=
 =?utf-8?B?VzUxVVcvQ1pPdyt6UHUrNWZZWDlyem52engxWlFQVHJXRkxhU0Q3VnVJOHZP?=
 =?utf-8?Q?6KiVDxuIRVlF1HPjCbkFiejYw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A6ED13AFA7F0640981ED74A7F1119F8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9a415b-1116-48e1-1d95-08dbcff3b44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 16:03:01.1815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOIymuxWtzfgqbRLhgJbqqaDioL70z0Zi5O57tNNUfIQiiv6IX/ICtBMWbzY1svIsX1AEveuNgRmgJR6fgsEjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7961
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE9jdCAxOCwgMjAyMywgYXQgNjoxNyBQTSwgVXJvcyBCaXpqYWsgPHViaXpqYWtAZ21h
aWwuY29tPiB3cm90ZToNCj4gDQo+IEkgYW0gbW9yZSB0aGlua2luZyBvZiBtb3ZpbmcgdGhlIGlm
ZGVmZmVyeSB0byBwZXJjcHUuaCwgc29tZXRoaW5nIGxpa2UNCj4gdGhlIGF0dGFjaGVkIHBhcnQg
b2YgdGhlIHBhdGNoLiBUaGlzIHdvdWxkIGhhbmRsZSBhbGwgY3VycmVudCBhbmQNCj4gZnV0dXJl
IHN0YWJsZSBwZXJjcHUgdmFyaWFibGVzLg0KDQpJIHRoaW5rIHRoYXQgZm9yIGNvbnNpc3RlbmN5
IHRoaXNfY3B1X3JlYWRfc3RhYmxlKCkgc2hvdWxkIGFsd2F5cyBiZSBhbg0KcnZhbHVlLCBzbyBp
bnN0ZWFkIG9mOg0KDQo+ICNkZWZpbmUgdGhpc19jcHVfcmVhZF9zdGFibGUocGNwKQljb25zdF8j
I3BjcA0KDQpZb3Ugd291bGQgdXNlIGEgc3RhdGVtZW50IGV4cHJlc3Npb246DQoNCiNkZWZpbmUg
dGhpc19jcHVfcmVhZF9zdGFibGUocGNwKQkoeyBjb25zdF8jI3BjcDsgfSkNCg0KVGhpcyB3b3Vs
ZCBtYXRjaCB0aGUgb3RoZXIgKGV4aXN0aW5nL2ZhbGxiYWNrKSBkZWZpbml0aW9uIG9mDQp0aGlz
X2NwdV9yZWFkX3N0YWJsZS4NCg0KSGF2aW5nIHNhaWQgdGhhdCwgSSBhbSBub3Qgc3VyZSB3aGF0
IG90aGVyIHVzYWdlcyB5b3UgaGF2ZSBpbiBtaW5kLg0K4oCcY3VycmVudOKAnSBpcyBhIHByZXR0
eSBvYnZpb3VzIHN0cmFpZ2h0IGZvcndhcmQgY2FzZSB3aXRoIGNvbnNpZGVyYWJsZQ0KaW1wYWN0
IG9uIGNvZGUgZ2VuZXJhdGlvbi4gVGhlcmUgbWF5IGJlIGFkZGl0aW9uYWwgdmFyaWFibGVzLCBi
dXQgaXQgaXMNCmxpa2VseSB0aGF0IHRoZXJlIHdvdWxkIGJlIG1vcmUgZnVuY3Rpb25zL1RVIGlu
IHdoaWNoIHRoZXkgd291bGQgbm90IGJlDQpjb25zdGFudCBhbmQgd291bGQgcmVxdWlyZSBtb3Jl
IHJlZmluZWQgdGVjaG5pcXVlcyB0byBhdm9pZCBtaXN0YWtlcw0Kc3VjaCBhcyB0aGUgdXNlIG9m
IHN0YWxlIGNhY2hlZCB2YWx1ZXMuDQoNCg==
