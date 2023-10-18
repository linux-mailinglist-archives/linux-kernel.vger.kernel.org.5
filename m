Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523197CD9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjJRKy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjJRKyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:54:20 -0400
Received: from CO1PR02CU001.outbound.protection.outlook.com (mail-westus2azon11011008.outbound.protection.outlook.com [52.101.47.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACC4123
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN3q25++WvagiFNHkfLDAO4zwonh1c7acsrON6QeLM1yLg29Zi7VirTn+zwki0HDDJBGRIU543K9NUC6/bQJu92/E3VtGy09XKsJsrWIw+4WYSS92e+Ss2Lp4QNG8L6j2vlzgjleueWr0cs/RfTDiZ7H74aYT/XuDEdsML4bqcmkGed0C3aTa7oQ10g8ncXiXlLkzp9SOTExocwH/rezMpWqkOOFMzTWvOnAFQo/kk6kNgCp0NaZ+V9NtaDc4i2uKq9fZLABoDMJmPUdKPGZtdD2YiukpBahn0Xee3Hi5eZiRFQga70MfEoHTIKEM2XGZdm5CSOfGN6h4bn0yffFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWnA86LZqeM5xfVZYQowLXjFVl4akFqcihH1jytxJac=;
 b=Z7AOXV+l6ay1bS4xxtyIgucmvUTke/Nzr4jjZe0ISnjzk+g6Z6Vm99qtXeRM1t4NcmKAEYeLoiDZyyz7xZscP6TpcufmI8gPmTyMJBzHKJ6cQ2qo5zCgQh/yISK+klfdc260IwLvTABH0sytb5gFuYZ5yokY6l1cDEwdl/0OpRaboivYNXf0nw5IRlGtPHGIioX04fRhutiC8UCkAtAvbGd3aDFADe2VRy9EpsECtrnHAX/8KqdwKD2o1CLaqYUAQZXHWSTZhuqrE4rr2ylV4leQtu/9HeBw/8CBJQgWcXV2WjXv5NO0gts/GVhdqJ7P9YlKb4Zdl/rXgwxx+8d6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWnA86LZqeM5xfVZYQowLXjFVl4akFqcihH1jytxJac=;
 b=roQwEugMxNwfgf9fgpkul1bCR64hkVXg0RnOPp6sOMKyWyHgGw+EyJLWOw0fiHeCMZrhnsqDcvLOKUoakoYklbvfR61x95wwdHX9DnubK2rntNN7oJG8i6GLNhkpTmgtqVYatjgUCO1gFIHtnyQr/7Xjazp1LGI+/F/pcNs4d3c=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM4PR05MB9183.namprd05.prod.outlook.com (2603:10b6:8:ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 10:54:14 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6886.039; Wed, 18 Oct 2023
 10:54:14 +0000
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
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/FrBDSECAgAAOE4CAAAQxgIABoxnfgAAgI4CAAAYlgIAHqOMRgAAI04CAADzyiIABTsvzgAADAQCAAB/hAIAADVOAgAClpgCAABXQAIAAHpgA
Date:   Wed, 18 Oct 2023 10:54:13 +0000
Message-ID: <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com>
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
In-Reply-To: <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|DM4PR05MB9183:EE_
x-ms-office365-filtering-correlation-id: 220b237f-0e99-4331-3cee-08dbcfc8912f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E9lUkwEmI+vgjiZbqV3tQ8Hg1fYYvCYknNEd4xneIpreUV4sYvZA+yVBuoaRBsRyHkOHqCj6qHPquHrWpE4s1PATzTlNEm0zzvhRMU9UnqC623VTfLtvZsruDAKDKQMAxZ0dVxtS2Tkp0gOYBWdL5yjr9/hg+A/IWXRIDxGjd0AfsNRrGOTs0ifAgF9KCmQLQnPuutsF53Ysdud1VB8FIyLLpGrtn1h9HbH8WEr6ctHuYi7dBp5YLsw9yy6gYjxYAh2BZtILsQ6wWWQEzewojRHMKkdOwWmt4xLZdAEkXbUU0sENMX5U7ggSmKDV94L1cxFd42uTW/hCBC46Pf/v6gSLcgFPvAk1GAxnoVlj+ACFjXMx2ZkOvXC5bAOP+ksJsteTrNn9Wlb/cBQZgosv33RgWVV/Qz7iGZ7vSlg5nm/yio2b0ELSEacBvaqXy3wavcMKl2wM6A5TEkPvcx+Ivn5aWlZ7lsOnj1YiwLqz4/3vFInr1NxmuDokA/FrdXgwLy6ko42mmR+YL8SqH5+/W/MKrVZQPaIdh2TRmr6gATo+5X6MHxtk9ifWF0T608ybqacrm2PDDCi335d6KeBwNFSCGWMzvr+E/BBEmy/RKze65x8sWLPKve/HG/4ojt2Vta/I0vz+YO3L07/ynZW04fiY0nSkfARb5gW2jHobZpbq9zzWl3JX+W7DXcUzm1pBe8xgMXzl7wgOsoV9CimzHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6486002)(478600001)(6916009)(66446008)(66556008)(316002)(91956017)(41300700001)(7416002)(64756008)(8676002)(8936002)(4326008)(54906003)(76116006)(66476007)(66946007)(71200400001)(6512007)(5660300002)(6506007)(53546011)(86362001)(38070700005)(122000001)(38100700002)(36756003)(26005)(2906002)(33656002)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkJPcEtDQXozSVdQTnV3c2tyVU9UNFZnQ1BzZ2p5NXZNMXpmTDU3Tm9KTWJj?=
 =?utf-8?B?UDNZRVZBdlozSHJWYldqcTVTaW56ZVI1WDEvYlkrT3JFcXlqR1ZDSDYzYXJz?=
 =?utf-8?B?eTg4V0ZXczVVYU9GVU5LVG03VDBXQW9CTVhNT1E2YVhSczhWVjM2aWtxek8y?=
 =?utf-8?B?TVYxL2JwNElyVE53cXRDb3NrOTJyTFZmWjVWc0hvbEx4LytxbE9Od0FpMnBL?=
 =?utf-8?B?S0Fza0FUU1lXcWdOM2dsenJMMTFMNTc2ak1RYXpoSkZBbjB1ZjVSZ1poa3BJ?=
 =?utf-8?B?N1BZWmI4cHNyU1dPWTlPVzB3ckoySE52TE1jWVdYdHI5eDllWTJkN0VTWllB?=
 =?utf-8?B?dHN5RUZSeEZRZXBQNlpvN3dyVTZoK3V3NkR3UDFGdWtPeWpHUnNtSnJ2YTM4?=
 =?utf-8?B?K2xTVkNBank3MVp5akxZTm9NdEpEaitldkROTmkvNVBhdllhWi84OFNNUDhR?=
 =?utf-8?B?ckMwV1VkWEErOW05aEZoUGVoTncyL0JaazRtV2l3M0M3a1NuQTBoVzNQQ2do?=
 =?utf-8?B?NFJMRktzWlB2b25CcFNnQk5hQXJoeFdzblRNMWphdWE3Sk5GNHdHQWY4eXpp?=
 =?utf-8?B?R3Bna1VOT0w1Y3FyQ3FFek5Yc1QzWW9XcElEZVIzR0xyT01mcTFLdkFjWVlN?=
 =?utf-8?B?SS9saG1zTEhjL2hzTDI3b1FMeVJrdGlUWEhweERxV3N3M1BhTHZCUk1JWlRa?=
 =?utf-8?B?TnBvNmNWYTNRWE9JNW84bWptZVRNTklOWkZRcE5VQ2RKQWFtSGJQbVViTjVD?=
 =?utf-8?B?WXY1bCs0QjRDckE0NFJLc0lqaUdKOXczYndveHB5WG5tRFBFVlJ2RVB0a3d2?=
 =?utf-8?B?UldXcS9HU0doNnhvRFo4MDVMUW9sTGZKK1RpdUNGL3UxYlNJMElzdzM3MlpR?=
 =?utf-8?B?ZG84ZWw2RkJnRVRsUE1tNnlseXN2NFhEN200UCtNVW1xSHNlWkFsTGhXVm4x?=
 =?utf-8?B?dXBaU0JJYzIvemw3WVloMnFuUUhMemhnN2FGOWEycElqR0c3Y2x0QlFVdDNN?=
 =?utf-8?B?YXA1ZDlPWGtFRXY1UlEydE95WFNEZXIwR3U1ajhEVTZ6OTRVL1FZVWE0Tjhr?=
 =?utf-8?B?RE9wQkgxUndoR2VYZ1poRmF0YjhLTTNxeks1UmtURUpjQUlWcjFYYk8xSmRZ?=
 =?utf-8?B?MHpXYWxTSnBua2kvenhHTGlVZHpwUytXZUhQV1ZhYUhzb2lnQ2lzdy9BdVRI?=
 =?utf-8?B?YnBUUm9YN1UzUjVGK2s1VXdFeXdGQ1c3K1lrSHIrck8vQW1jd0xqRUZaNVdL?=
 =?utf-8?B?cVpoNk1rcU42L0U0SUl1QWlMdS80dUxyWVhUVnNSSzNkNzFBYTVwSHBCUk5y?=
 =?utf-8?B?SjVJZyt6Yml3MytRcmZpRm1lY3NpSnRQeUJrNlpuK3RUT0pJeStnMElWYW1x?=
 =?utf-8?B?L3c4WXU5R3huNDMzL2thL0tBY2p6VFIwNjRkNXNYR0NCaVZzNTBoY0dxWTF4?=
 =?utf-8?B?Qnk4TnVMS3Znbm5VRU1acDFLR3FQelJMakpTazF5U3NkdG54Qzl2UWJEQTVN?=
 =?utf-8?B?OFl2SjJ1SmlQNlFlRTFlMTRVWGVUYmtyaittWHRUMVBrTHNLREo4MDZoRFV1?=
 =?utf-8?B?Q2U1TkRld0hBUE5IVWxuT3UvdlUxcVVBTzd2TkZvaHBRV3lYRER1ZUFBZ1Zo?=
 =?utf-8?B?NTRwdFgwdXJReGJKb2Z0TnRVeVp2czlhZGp3SHppUGhBVDhlaitZencwdFJm?=
 =?utf-8?B?bzJiNmFTei9jNG1kTDhBVHY0d01OMzRaZ3Jyb09iVE9QcDhNVllhSFo4T1pN?=
 =?utf-8?B?ZVk0aFY2STY5eGdCd0hMeXZNL3VtRDdvQ0l2LzRWNjZKWVhrL0FOWmVmQnd1?=
 =?utf-8?B?L1VRM293SFltQ2ZURkhucTlIZUlDeEhaYVBYR1dQN3JKTm01Z3hHVXVGb0NI?=
 =?utf-8?B?SzZFeHZZYVlBZXFheGYzV2R2ZUNrVUZlRHlmZHpJd2RtVVNzaXRlRDJ6cGJv?=
 =?utf-8?B?TWk0M01uSUFHd2xvbzBFMjhpY1FJdG1jYWxaUUkwS09pTlVDdnp0UVVXeWVN?=
 =?utf-8?B?YkNlaEFFZVgrMkdUVS9rQ1ZTdUtBWE1COVpkdVZUTTVkV05QS1RRNTRRbE9o?=
 =?utf-8?B?c05DZVljMXVjL01hQXJCSXFjRG9HbmZQdDZKR0tmUTY5YWlBQzJSejVIcm1u?=
 =?utf-8?Q?drZS+7zURUUWR992vnQa6HKc7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F711E84036CEAF48907E5A7ADE68F4D2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220b237f-0e99-4331-3cee-08dbcfc8912f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 10:54:13.9055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dzpm6LjkvgFl+1SHPzZovFVf24LxxiQQZD67NzYdjF7KI3/8kDxrbth6PeuX+zvfamqk4s3lZAKBNH06y80hug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR05MB9183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDE4LCAyMDIzLCBhdCAxMjowNCBQTSwgVXJvcyBCaXpqYWsgPHViaXpqYWtA
Z21haWwuY29tPiB3cm90ZToNCj4gDQo+IFNvbHZlZC4NCj4gDQo+IEFsbCB0aGF0IGlzIG5lZWRl
ZCBpcyB0byBwYXRjaCBjcHVfaW5pdCgpIGZyb20NCj4gYXJjaC94ODYva2VybmVsL2NwdS9jb21t
b24uYyB3aXRoOg0KPiANCj4gLS1jdXQgaGVyZS0tDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L2NvbW1vbi5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYw0KPiBpbmRl
eCBiMTRmYzhjMWM5NTMuLjYxYjZmY2RmNjkzNyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2Vy
bmVsL2NwdS9jb21tb24uYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jDQo+
IEBAIC0yMjI4LDcgKzIyMzIsNyBAQCB2b2lkIGNwdV9pbml0X2V4Y2VwdGlvbl9oYW5kbGluZyh2
b2lkKQ0KPiAqLw0KPiB2b2lkIGNwdV9pbml0KHZvaWQpDQo+IHsNCj4gLSAgICAgICBzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKmN1ciA9IGN1cnJlbnQ7DQo+ICsgICAgICAgc3RydWN0IHRhc2tfc3RydWN0
ICpjdXIgPSB0aGlzX2NwdV9yZWFkX3N0YWJsZShwY3B1X2hvdC5jdXJyZW50X3Rhc2spOw0KPiAg
ICAgICBpbnQgY3B1ID0gcmF3X3NtcF9wcm9jZXNzb3JfaWQoKTsNCg0KVGhhbmtzIGZvciBzb2x2
aW5nIHRoYXQsIGFuZCBzb3JyeSB0aGF0IEkgbWlzc2VkIGl0Lg0KDQpUaGUgcmVhc29uIEkgZGlk
buKAmXQgZW5jb3VudGVyIGl0IGJlZm9yZSBpcyB0aGF0IGluIG15IG9yaWdpbmFsIHBhdGNoIEkg
Y3JlYXRlZA0KYSBuZXcgY29tcGlsYXRpb24gdW5pdCB3aGljaCBvbmx5IGRlZmluZWQgdGhlIGFs
aWFzLg0KDQpTaW5jZSB0aGVyZSBtaWdodCBiZSBhZGRpdGlvbmFsIHByb2JsZW1zIChhbnkg4oCc
Y3VycmVudOKAnSB1c2UgaW4gY29tbW9uLmMgaXMNCmRhbmdlcm91cywgZXZlbiBpbiBpbmNsdWRl
ZCBmaWxlcyksIEkgdGhpbmsgdGhhdCB3aGlsZSB0aGVyZSBtYXkgYmUgYWRkaXRpb25hbA0Kc29s
dXRpb25zLCBkZWZpbmluZyB0aGUgYWxpYXMgaW4gYSBzZXBhcmF0ZSBjb21waWxhdGlvbiB1bml0
IC0gYXMgSSBkaWQgYmVmb3JlIC0NCmlzIHRoZSBzYWZlc3QuDQoNCg==
