Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176137CB4AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjJPUfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjJPUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:35:29 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11013006.outbound.protection.outlook.com [52.101.49.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C947C9B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9mpUGpiKkZ5BRutT50kYsIPabNLZVddD323xgWziv3eyBxCWUWNap11T76AgYT8Jd0NBO/wvBvbzd7s+zUPIwDE0j0F8yw3nEY/N/hjMAv4ROZnInLGqjkSt7H/aFaQAPE6S2epAo1RXgkZpWaYk+mUkeWhtdIc2UVeavHBOlShgsMzZZA9OPUozIP+yOi9/gbWL9euzh9Hc4WbtvIC2SkE9ifxrr8eqjTxL1QagT2eWs0aILZNdeiF5VtdYJIiq4iJlU/09voPCl+n0mCIbZMompBdDjrGcIQr6iwKWhJH9MfjLX5HrEmSHGv86D0aU2OmkGwzKlp79Z6StbmUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2+tMxL85FskxQwQK//umSfJm4xVtQKcYGA5+Jl+qJc=;
 b=biftrHa3rL6WM8F8MdQItI2ZOGX06+rom9HVyNl5QISg2V2v5aqGHguee8FNBxskuCU4R+RfFqlcEoC+igRGRBNh0YIJkKpQWVmYjRracGWfh1IQUsAiwHS5jNC9QQyfI4qZgUfhEIpDm7/g7irN9NGMo1q9ziW06nUS81cQORWVRkHLLU9+WrVx0kbccSl95vkSE6u8faYfDIEk+a4r9fW3w1VabvEOeJOFP+4rpOXU0MJ44HyG1xE+fN6+NYtKbjll0JQvq8OPUEZ5pc6dW0SPzMjn8veC4QObV9j4pwgSw+OxHvh+2e18hNSy/KBr3GuZOe5XcjVH72+TFtZmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2+tMxL85FskxQwQK//umSfJm4xVtQKcYGA5+Jl+qJc=;
 b=U+AaLuR3fUAi4b0DQesJAI3w9W3Z3oCFx+wshg171AperrJtXac39m7ewQ6tMsDFpbGpFowfCnDlKhR72kf45KmUhSl6KJn0MJfit3Fg1m7MwMB9wtILOAWLp2LKxCsFj6df5YLMO2u1+/XvdMJ0szkQO2sKmWimE8oQsftAfd0=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CO6PR05MB7649.namprd05.prod.outlook.com (2603:10b6:5:347::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 20:35:24 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 20:35:24 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>
CC:     the arch/x86 maintainers <x86@kernel.org>,
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
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/FrBDSECAgAAOE4CAAAQxgIABoxnfgAAgI4CAAAYlgIAHqOMRgAAI04CAABO2AA==
Date:   Mon, 16 Oct 2023 20:35:24 +0000
Message-ID: <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com>
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
In-Reply-To: <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CO6PR05MB7649:EE_
x-ms-office365-filtering-correlation-id: b6e5fe26-9a75-42f1-9ca5-08dbce876ccc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGo8Yl6JfGooxFTwt31m6vSUIf1KrCkoRI5SqKCcq4R5ngA4rYglJsIAO9jRxjD4aLnkgtEBPSHcWciuBf5s/jfvqKDD6Fc3IoXXrH5KaMA7/5mvtz9Hn84RwmLGUQfgsX1+DXFSEIl2IHbOtobTW9MU3z/Yn7M+LD9Ck9irhtwPYrXLAGvGQ8wzFtXy8uxXwJfDTSJeE6UAAZ2GVUfZreJNJAdqX1S35Mb6Ehz6HYnTiSfM9dpqdgToM3BtIlxA7OVjHxQ0Q6byuhROkItUmtHgqLSrzda99mSBXmGzOJNJgFq5yVoJncsc+7sb0sS1NygwKaDJMnsCRtKISrE+ZpUdxIH8n0mYDWj2HO6mxLWaC11Oao5nDB+UO1q+GtQR60w2UwQXRM81XABmLRDXmy2Sfp9Gg2tOLwzKD73fN6/TmGKhah7NGWq8DUzZm/RcsX+zxt88kxebIlIUEz6lVbRz9NvYT7rdxbvoIXQ8MVXGqG/4PnRHJ8rSnBzBYjflU50deZh1udzZAhVohnFPM+yckxMP07K9kh5YPMbHCQdqkhlDpqzvZ1lkTkm8L2iOXSTWacs/9O6jWiS3DC+g1s2boiOiJSedHQBhJmKmtuMsxtf5iA5X4OHRT/RxXN6QgJHB4XgYidV4r97bFC3Z+XVoOn9UCkXSqlq5Rcpqb1LbD8ufbxDiNiRHcOSN5HUmOt5wMqthivQltJZrwugItK9wJg6tC/l7wnVzk6ToBfk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(53546011)(6486002)(966005)(122000001)(36756003)(38070700005)(83380400001)(38100700002)(71200400001)(6512007)(26005)(6506007)(2906002)(64756008)(54906003)(66476007)(66446008)(316002)(2616005)(478600001)(76116006)(66946007)(91956017)(110136005)(66556008)(7416002)(86362001)(33656002)(8676002)(41300700001)(5660300002)(8936002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTdLY2dMSklXVDhlS2xBK1NDNTlGS2hSTENVdjFLcGpLUU1ZbDJ0cEtxMTB5?=
 =?utf-8?B?QTZtQnhQZml5TGJKMGNGMHhxNlpRUDZsSEFxSG1sV1dzcEhqN1ZzakpNK3BM?=
 =?utf-8?B?MTllUzVzQUZDdTdwMHBmTWo2UnJ3Y1p5L0VUbjlzWTRBYXgvdm1sdStieXQ5?=
 =?utf-8?B?c21iSkZPV3JHS2kySzNxK0JJZ0N1SWxieFBrODNCMStER09BNGVKbTF6RG4x?=
 =?utf-8?B?Y0RkV0V1b3hLZzFrSi80bGFzdVlaM0gyTy9WOTdIV3dUU2RRUTBVRnJONXIr?=
 =?utf-8?B?Y3ZnU2ZpcEgzemxLNytBQVh3UDRXRURnNm8zYjJpMHAwY0NtUk1oSndCZm1x?=
 =?utf-8?B?OEpsZWdtRDNaVnByUEZiUUtDMEQ2MXJVdCtrV0RsU3dxNjdBYnh0T2IvRXhm?=
 =?utf-8?B?SjZNRTlyd0VzdEJUMnhuNUEyOG12NnpvSHE2VkhnZENNV3VPUk1uNGhvblkz?=
 =?utf-8?B?bnJaTTJ0SzdUeStKK245aEd1WkRvZnBKeExzT1I3RHJLSjFOWFQyVTdEb2pl?=
 =?utf-8?B?b3oxNUhLSklqeTBkdEhnMG5SL0paVzVnY1g1bndSZmc2TU1zemY1UllPeHlS?=
 =?utf-8?B?ZGtYcXd4d1liNmVtcG5FbDQxanJjeDN4aVpkRzJQekYrSmZYUWtJc3JVbS9H?=
 =?utf-8?B?eG5mMjBSRkNiZEVlanBXcEViYjFJVmljd3BmYVVQYkFETVorSlRFdzRJUlRB?=
 =?utf-8?B?bU9XbG9ValBRQUpWb1EwTXE3T0dENlljcjVmOXFtR1ZsdEg1RGttZnhJalBK?=
 =?utf-8?B?QnYyWUhJc2NWZ3dRekx0cW9VMmtaN3BVRVhBZ0VtdHAyTldUWC9JQW12ZVZ0?=
 =?utf-8?B?QkpYeVUwbzhCaHZHMXUwNnQwUmZBKzNDQ0FWV013Y2tQbVhWcFdtSUp6R3p1?=
 =?utf-8?B?dy9QK1hnNTZYeERDQktEVzBqTSttRHc4K3grTlhKVGJGU0d0ZkJDaC9RVkZR?=
 =?utf-8?B?bi9SRDhWSUtvYTV5NXFlUTJJbTZTcVZ4djZaWG0xbnY0YVczb2tiNVd0YXJp?=
 =?utf-8?B?WGIyaFB2TUNPakFrKzFVNFVpZUxZMy8rUkh4eDRncjlmbVNBdkptTi94anhJ?=
 =?utf-8?B?cUhsTmIxM2JaSFVwS1lzZUhWRFVXNTJsK21HMFg0dW9EQ1hnd0xPVzJKK1pq?=
 =?utf-8?B?aS9YSFkxTGRER3hFdEpsRWxZQUFDaU9NNktuVHg4K3AyZTR3SkFvZ1hHUjRv?=
 =?utf-8?B?bGF2U0FQYW9aZ0pvbDZWeVRGbnlUVC9BUVIrRXl5anF1cUEwRWRIN1V3UzI3?=
 =?utf-8?B?MVd5a3FMYmZGdWZ1K0RDV2g1WGtickRsSHVzems2NWFMYzV5ZVk0WHltaXdn?=
 =?utf-8?B?TVNaNjN5YVo4U29RQ2xLSjl0MS9rRVllQkNtbkVXNVBpM3crZjV5YytNOFVG?=
 =?utf-8?B?bDhkS3F3VWM0Ykozb3RrSnJDMm5vU2pjN3dBWmt0ZUNwdkpSbTQySHNKSjVK?=
 =?utf-8?B?OFQrT1YrMzN4SmlsYjNCTUhNNW40ZzcyVStlVWs0bTAzQTJVeEhpZThNM2lP?=
 =?utf-8?B?NVArUUU1VElrY0tRMzJhQUV2OGtzMVc5LzYwaGU3MWx4VkZLUzFsRmcxTUlz?=
 =?utf-8?B?c1hiQmNOUEYzeEcwOHR5Wm9HRFRVeGk2Wml4L25sYk9UUjFjOWw1LzNVVGJ5?=
 =?utf-8?B?ajJKNG5udEEweEg5b25MeW0rMnBRbnJTV0dqRUlEZW9qMzNqN3NlOHByaGta?=
 =?utf-8?B?OE03aUtTS0RLMzdaZGVscngvY1NKdmZ1VUpKTjhjYld2WE9LK0xibkVmNXVH?=
 =?utf-8?B?V2QzWWs3VGhwT05WdGprTWVQZkFZT1VBVGdWclRERTV1aWhaZWl0aDR0d3ZX?=
 =?utf-8?B?dkxRaUYrN3JVVm91dG9ieGVzaWMwSUcvVlNUYjhReTdZdUJFVHZXS3ROU3RN?=
 =?utf-8?B?dkpRV0MyUDFGK0lRQTN3cWl5S2NjSUpNR3VVNGpETFoyYjN1NDhLM0NFR3N2?=
 =?utf-8?B?VGZXOEc1eUk4NHlidlk5RGFia3M1b0FaTVlIMnZzaG5Ld0NhZ3IxR2lOQU40?=
 =?utf-8?B?YmExVVNJVkpEcE0vODl4WmlUdmxSVk9mZmJKSlhMUno3VTVjSUpaWXg1Z3l4?=
 =?utf-8?B?dDhxY1Z4TENxUFRXaEQ1Zm93Q3l2bDBabEFZL2NaNEtuSkNjVWwzOEdGeml4?=
 =?utf-8?Q?eahiivf9xN+3uHlu2eVMwmtn4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A338DC94C66DD4DBBF3EEE5EA0CBA90@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e5fe26-9a75-42f1-9ca5-08dbce876ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 20:35:24.3908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYLksZf+Ifp3Kp1zUNoP2rT17EDnrxEnZUvtRUVKbpZw/nlA7TSQ6FIHScbXijZl/frbYaIaDkYNsnR4Mxhs9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE9jdCAxNiwgMjAyMywgYXQgMTA6MjQgUE0sIExpbnVzIFRvcnZhbGRzIDx0b3J2YWxk
c0BsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiBTbyB0aGVyZSdzIHNvbWUgc2Vy
aW91cyBjb3JydXB0aW9uIHRoZXJlLCBidXQgZnJvbSB0aGUgb29wcyBpdHNlbGYgSQ0KPiBjYW4n
dCB0ZWxsIHRoZSBzb3VyY2UuIEkgZ3Vlc3MgaWYgd2UgZ2V0ICdjdXJyZW50JyB3cm9uZyBhbnl3
aGVyZSwgYWxsDQo+IGJldHMgYXJlIG9mZi4NCg0KSSBkb27igJl0IHRoaW5rIGl0IG1lYW5zIHRo
YXQgaXQgdGhlIGFsaWFzaW5nIGRvZXMgbm90IHdvcms7IEkgdGhpbmsgaXQgYWxsIG1lYW5zIHRo
YXQNCml0IGFjdHVhbGx5IHdvcmtzICp0b28gd2VsbCouDQoNCkkgaGF2ZSBlbmNvdW50ZXJlZCBz
ZXZlcmFsIHN1Y2ggaXNzdWVzIGJlZm9yZSBbMV0sIGFuZCB3aGlsZSBzb21lIGhhdmUgYmVlbiBm
aXhlZCwNCnNvbWUgaGF2ZSBub3QgKEkgbG9va2VkIGF0IHN3aXRjaF9mcHVfZmluaXNoKCkpLCBh
bmQgbWlnaHQgdW5kZXIgdGhlIHJpZ2h0L3dyb25nDQpjaXJjdW1zdGFuY2VzIHVzZSB0aGUgd3Jv
bmdseS3igJxjYWNoZWTigJ0gY3VycmVudC4gTW9yZW92ZXIsIHBlcmhhcHMgbmV3IHByb2JsZW1z
DQpoYXZlIGJlZW4gYWRkZWQgc2luY2UgbXkgb2xkIHBhdGNoLg0KDQpQZXJoYXBzIHRoZSB3aGFj
ay1hLW1vbGUgYXBwcm9hY2ggdGhhdCBJIHRvb2sgaW4gWzFdIGlzIHdyb25nLiBJbnN0ZWFkLCBw
ZXJoYXBzIGl0DQppcyBiZXR0ZXIgdG8gdXNlIGFuIHVuY2FjaGVkIHZlcnNpb24gb2YgY3VycmVu
dCB3aGVuIGNvbXBpbGluZw0KYXJjaC94ODYva2VybmVsL3Byb2Nlc3NfNjQuYyBhbmQgYXJjaC94
ODYva2VybmVsL3Byb2Nlc3NfMzIuYyAsIHNvIHRoZXkgd291bGQgbm90DQp1c2UgdGhlIGNvbnN0
IGFsaWFzLCBidXQgaW5zdGVhZCB1c2UgdGhlIG9yaWdpbmFsIChub24tY29uc3QpIG9uZS4gU29t
ZSBtYWNybw0KbWFnaWMgYW5kIGFuIGFkZGl0aW9uYWwgIi1E4oCdIGJ1aWxkIGZsYWcgY2FuIGRv
IHRoYXQuDQoNCkJ1dCBmaXJzdCwgdGhlcmUgaXMgYSBuZWVkIHRvIGNvbmZpcm0gdGhhdOKAmXMg
YWN0dWFsbHkgdGhlIHByb2JsZW0uIEnigJlsbCB0cnkgdG8gZG8NCml0IHRvbW9ycm93Lg0KDQpS
ZWdhcmRzLA0KTmFkYXYNCg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMTkw
ODIzMjI0NDI0LjE1Mjk2LTUtbmFtaXRAdm13YXJlLmNvbS8=
