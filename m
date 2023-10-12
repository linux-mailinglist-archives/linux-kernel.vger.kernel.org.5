Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DFD7C7146
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379245AbjJLPTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379223AbjJLPTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:19:08 -0400
Received: from MW2PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620C2B8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yno7YsYMFmkex1q9bnVzLVYvQv0akvKxU8+wJDVpG+0bJNiRymcknbP3J34bddEsjqMYdP4tosSXwJRQYzzv6xM4lR6A0zZ45l3jJWWpDIxV8nxKkhTopnokf1yG0qEcz4RlPSxuueQTjNPxSDzDel5DxdRFultL2p3x2WE1WSfg8kyTnapyltvKJNY2eW+oXfK1VexDgdYmj8w5HLXmD/nZFRDbD/dSTrvoedb55OVjNmDt1LrKyD4TMiMFAAZqnUCL+FiejpLGjvAfpv+FQHTOwhS3CwPhHhH+GRGbAMFN0aHCM2uOQe2Lqs6kKDXgHJlZFTsjE/fkMnfMcEmN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVoMKQDI+TPndG9mRKyIJahv+9jNEwGr5h62fu6LNTo=;
 b=Z8SMRIo7NaUT5xxyowUck9Ca/thQ2ivlpu8piRsJ741eUVvJJuVlY1vQoEc+OQ7q5Yn8ge7bGlBB1RcDFxq5UH4Z9b3tZf8AhX6d4DFvt0PmORfRsPpPsqiozV0/3aj/XMbKghSHRkk98ukg6JiQkuVp9WBct6cSXmR6JfocFgD2Q96YE5ZTT/TA6HytMHZdsSYF5Qp6rLKI++aNC2q5L8abkRJs8L5dwWIKk2am+xqDozFj3z39W5urOj3PP6WwWIlDW041UTgC4ful3RnMQcEO75jXcOk1orJb1yFmUF4Q8cAKqa3efu7i+iDqnorctvCvM6bBYzn4reVF2n/Qhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVoMKQDI+TPndG9mRKyIJahv+9jNEwGr5h62fu6LNTo=;
 b=Dg7MLKJ/gglIwco3ERtr0bD9XlErhh+Pep2OG16iOq6HjFRUDNis6705bbwu86l6GGRMSslsv3uHK6eVERR8LbXuRbh23MAONBMhmTwbGfRdYhFLMUEb9gUltyqT7KtPXWGSR3cMjxuNCQCnDLD4PdunXTgFzOCfa24Kp91ftco=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BY3PR05MB8307.namprd05.prod.outlook.com (2603:10b6:a03:3b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:19:03 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:19:03 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Uros Bizjak <ubizjak@gmail.com>,
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
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/FrBDSECAgAAOE4CAAAQxgIABoxnfgAAgI4CAAAYlgIABI7cA
Date:   Thu, 12 Oct 2023 15:19:03 +0000
Message-ID: <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com>
References: <20231010164234.140750-1-ubizjak@gmail.com>
 <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com>
 <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
In-Reply-To: <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BY3PR05MB8307:EE_
x-ms-office365-filtering-correlation-id: 9841e9b4-8db6-46fd-1565-08dbcb36916b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2n9RzpWQohqebqZ9NKhmc+TMeH3Deu1VEZhEGTnd7jPMjDTA0yV303qNOzfBPdMs6CgqrD6bpIULfF7w7OAf6E6widqYcst58A01TdYTj+kq6U9ubunb0LxHcQlL2yTuUv3s0aiJMHngS4wh5VjBSRk1pUK9shmvekKJnwBt6YiNhk5NYd15ub5lBLJsbHG/pMAY6RlcxnhHOmpG2N/dA0+KyTkjkcusmcBFts+EDosdWuIN9xYqZsN04icRufl7gzNl4qIjWM3QL7lZgkCN6HvbW8p70tWUP2rPNv/MRByTp/FeE6LozAh/yr148YK4qUAU8hOEjDyeLQLAZvhRi4OONmw0dgFpYU90jyZn7khENk4fPqCI3LMAa6jfkMnmF8CezSpm0JI7tGGu3MmtS19U8xvdZP3j9xSLaUGWrvgkUmwlzImgFdl3ft1GEWJ+jrdcfP3M0XnxfsmPiZoM2Wk/pK5WIoHqBaertG7OjFOHvcmJ3ZAMmZsa9y9bqcbHOQzC8it5LpJm1xNQpm5d2PN74KZpAPWn0bK+WWRpEP7iZFPtTdn+hoTR3jzBukwathEP3VcEh4/LPGT8/a3hgsdXUsQDJ7l3UojH762eBcCe6jnZAfADnXTEcXow1l2AbdCQbAXwz0Al59nlFEDmjneb6XzgSdNnWvYOED5MysipT+2QAXwXqIMMbUXLhUA15PLCrs72t3+2mXnUpElw5IALJ0WQC2Tjt2LjUPoKlM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6916009)(83380400001)(316002)(38100700002)(91956017)(8676002)(76116006)(8936002)(38070700005)(122000001)(33656002)(86362001)(36756003)(54906003)(4326008)(66476007)(66556008)(66446008)(64756008)(66946007)(2616005)(6506007)(53546011)(2906002)(41300700001)(71200400001)(7416002)(6512007)(6486002)(966005)(5660300002)(26005)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHhvbCtib3VpNDdSNVJzUnkxd2dyRkNDVkMybC9vU1lpb1NsVEkyWnpzcnhE?=
 =?utf-8?B?ajhKQURsdm1uNk1ROTM5Q01oL0ZnZDhxK0o4WDcxL25wUzZ4Q3E1MUhpTWky?=
 =?utf-8?B?UlFOZ0FTOXJiVzFpQjJxaHVsZzdRRVVHTkRtRzFIRDNaYm91ZHVucmNvSjQy?=
 =?utf-8?B?bmpsLytaTTlwOEI1RHQwdEhvMUVKQXdudE5hTzQ0bU05RzhyeVhqcE1uTFlC?=
 =?utf-8?B?QVJjdnU3NmgwT0V0YUtQQ0FVMU5VV1A1YzVGMVFDNXZuL0hVOElidFRaTlJ3?=
 =?utf-8?B?cy80bUxjMXVSby9qeGViYjlNTENZcm9Ldy9kSFN4ZmJoTHZGSTQzWklITXMx?=
 =?utf-8?B?SytlZy9TeVVvQkk0UWF0NWFadkxVZFRDaUxMVzRJbTFqOWFxTEN1RnB1dEd6?=
 =?utf-8?B?U1pJYVdoMytlVDVzR1diYmtBVjdaSFppa3EyeDVjbFNnWDZwK0poODFEY2xQ?=
 =?utf-8?B?REp5ZTRZckhnb3RLeDRkSytaR2w1VXR2U3k2VWhOZTJzckowR21LZFVWQmYw?=
 =?utf-8?B?bDZMdHROc0ZEbFl5Vm5oL0w1Rit3S3VJNkp3d2xCR2V4b2VVM0gwNm0xWTZL?=
 =?utf-8?B?VTFhYzlJWkJxVmRRVVJOazVhdEVQNldndzZCNVhMTk1SWHgzbW1sdk1pcWl6?=
 =?utf-8?B?WC9KWlRVbnltWEZ6djRaSjJoQUpJWjNma0pldHVocHJxcGRNSjBpdVBZT3R6?=
 =?utf-8?B?WlQ2b0RRU3pvRytxbDEzeDlkYTBIeUNJd2lMN2ZNMlJuN0xORUs3NlJkSDFw?=
 =?utf-8?B?SFU2ekJydU1oOXhQSllwWkM0RUY4TDA2b2xHay93ZGd3ektPRDEyWWN2QjMw?=
 =?utf-8?B?WDJvek9aekdtaGdOb3ZSSUloMWZITVZLdXVCUVBYaTBpUTdKamNwbSs5b1lo?=
 =?utf-8?B?N3ROZml1ZDlmOEF5ckNaZjZvdDVobDMyV0lIN0JHRzlORndYR0toUUFNbml2?=
 =?utf-8?B?Q2ZnU0duYmoyVXpwSlFldWI2MDBDWHRwaXNKMER3YWdNb0R3MlFxaVFmUE1M?=
 =?utf-8?B?dmdiSzdSYjlPTExBYVk4WnFrdWRtTkRMYXBxRHcvWTBWcVZOb1c3dGRDUHla?=
 =?utf-8?B?aWg3dlV0U0ZxRTkxaHZNb2FlOXdNLy9PVk9CWFhJWHRhM0dXOGY3Q1lVbmVL?=
 =?utf-8?B?Z3F2UHZWS1BONHFPeDcycFRLSlp4NjhlN1MyZmFrOVViVjR2a2ljS0tpd2hK?=
 =?utf-8?B?dEVHN1lwL0NTczVQWUFRbU1hNzB0alFRMFpYa3V1WWo0ckRrcitFSWVraGVS?=
 =?utf-8?B?QnQwTHJjbjlQeWFjMkhWY2d0S0trMkdlb2NEelJtcGVPM21oUFJGcmFyb3hX?=
 =?utf-8?B?dm5HK21QZ2RvUDJkdXZ3ejdHejZ1M1Rjc3lOcWQ1dC8yTWxrZi9oc1ViRk5l?=
 =?utf-8?B?RmxzbEQ2Q0N2TTZ0UGV3dktzOGNERElJS1hRVzdMNWxFenZaSTVnQkNiK2VV?=
 =?utf-8?B?eEY0WmR0clcvdHJvRUtBQ1dCZXI5UjdmMDVFcjY1R0R3N1VtUUV4TDJqWHQ1?=
 =?utf-8?B?bTlnNUw4N3FVd2NqM3RDY3N4Z2RoMi9MNS9YZUhnYkVhYVFCOVpoeGk0ZnVj?=
 =?utf-8?B?WTNyU0UwTUdGZGtCMmkwUFAwanhKWWQ3RU95SGF1c0w0cnU0MS9ydWhveElB?=
 =?utf-8?B?RzNUeTZSenBNYzloR1haS01aaEdqTUQ3MlcvdmQxaXE4Q3hDOUdmVGlMcFFJ?=
 =?utf-8?B?aUlRVnNZWERTUXEyK3N2bXBIZ2NPenpja1UvY2ZmbTVycWJqdnZST0lYc2VY?=
 =?utf-8?B?MnVHVWw5emhib05kaFRQanpsbWxiS203SFJUT0Z4QzNJVWlzY3UyeitEVVR6?=
 =?utf-8?B?NTNML1JQamdvVVg3c3g5bmZ1dnByV1RlbWlTMkxpMGZ4VWYxdml0ZzdIY05M?=
 =?utf-8?B?UXl6SVlNQUtDZFBaZk5rNkF5MEVVamFXZk41U09RY3p3RmorMEtzRE1xSmUy?=
 =?utf-8?B?QThlaVZqWElxUFVhM3Ryay90YndpSk4xc21QTmVWQm01Y3BJcUVTMzVKL2RT?=
 =?utf-8?B?cjQrRnROUW15cVh1bno5L01xVGw2aDJaYkxTMGhXcTIxUm5YeEcwZFo2RDF2?=
 =?utf-8?B?UVhHR0FMUVZmb2k3VTdrNTNTZXZXQXFzaXFNZDFnaktLdlNOREJ6Sm52dHBM?=
 =?utf-8?Q?DsP/22WoRbqwQrh2c+sDrXNUR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BAB6CC90D8500745AFD2A3E84938A05B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9841e9b4-8db6-46fd-1565-08dbcb36916b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 15:19:03.1395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lW2vgoUbh7+RkTJx3pI9/N6/8clhy8iN4mVLxPVdGi9f0ulgmEBnaPIWtqNWzwrExHdYK4ACk2r7m7NuUA1i0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8307
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE9jdCAxMiwgMjAyMywgYXQgMTI6NTQgQU0sIExpbnVzIFRvcnZhbGRzIDx0b3J2YWxk
c0BsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPiAhISBFeHRlcm5hbCBFbWFpbA0K
PiANCj4gT24gV2VkLCAxMSBPY3QgMjAyMyBhdCAxNDozMywgVXJvcyBCaXpqYWsgPHViaXpqYWtA
Z21haWwuY29tPiB3cm90ZToNCj4+IA0KPj4gUmVhZGluZyB0aGUgYWJvdmUsIGl0IGxvb2tzIHRv
IG1lIHRoYXQgd2UgZG9uJ3Qgd2FudCB0byBwbGF5IGdhbWVzDQo+PiB3aXRoICJjb25zdCBhbGlh
c2VkIiB2ZXJzaW9ucyBvZiBjdXJyZW50X3Rhc2sgWzFdLCBhcyBwcm9wb3NlZCBieQ0KPj4gTmFk
YXYgaW4gaGlzIHBhdGNoIHNlcmllcy4NCj4gDQo+IFdlbGwsIG1heWJlIEknZCBsaWtlIGl0IGlm
IEkgc2F3IHdoYXQgdGhlIGVmZmVjdCBvZiBpdCB3YXMsIGJ1dCB0aGF0DQo+IHBhdGNoIG1lbnRp
b25zICJzeW5jX21tX3JzcygpIiB3aGljaCBkb2Vzbid0IGFjdHVhbGx5IGV4aXN0DQo+IChTUExJ
VF9SU1NfQ09VTlRJTkcgaXMgbmV2ZXIgZGVmaW5lZCwgdGhlIHNwbGl0IHZlcnNpb24gaXMgZ29u
ZSBhbmQNCj4gaGFzbid0IGV4aXN0ZWQgc2luY2UgY29tbWl0IGYxYTc5NDEyNDNjMSAibW06IGNv
bnZlcnQgbW0ncyByc3Mgc3RhdHMNCj4gaW50byBwZXJjcHVfY291bnRlciIpDQoNClNvIEkgYWRk
ZWQgYSBuZXcgdmVyc2lvbiBvZiB0aGUgY3VycmVudCBhbGlhc2luZyAod2VsbCwgYWN0dWFsbHkg
cGNwdV9ob3QNCmluIHRoZSBuZXcgdmVyc2lvbikgb24gdG9wIG9mIFVyb3PigJlzIHBhdGNoZXMs
IGFuZCB0aGUgZWZmZWN0IGNhbiBiZSBzZWVuDQppbiBtYW55IGZ1bmN0aW9ucy4gSSBkb27igJl0
IHdhbnQgdG8gYm90aGVyIHdpdGggbWFueSBleGFtcGxlcyBzbyBoZXJlIGlzDQphIGNvbW1vbiBh
bmQgc2ltcGxlIG9uZToNCg0KQ3VycmVudGx5IHN5c2NhbGxfZXhpdF93b3JrKCkgdGhhdCBzdGFy
dHMgd2l0aDoNCg0KICAgMHhmZmZmZmZmZjgxMTFlMTIwIDwrMD46IHB1c2ggICAlcmJwDQogICAw
eGZmZmZmZmZmODExMWUxMjEgPCsxPjogbW92ICAgICVyZGksJXJicA0KICAgMHhmZmZmZmZmZjgx
MTFlMTI0IDwrND46IHB1c2ggICAlcmJ4DQogICAweGZmZmZmZmZmODExMWUxMjUgPCs1PjogbW92
ICAgICVyc2ksJXJieA0KICAgMHhmZmZmZmZmZjgxMTFlMTI4IDwrOD46IGFuZCAgICAkMHgyMCwl
ZXNpDQogICAweGZmZmZmZmZmODExMWUxMmIgPCsxMT46IGplICAgICAweGZmZmZmZmZmODExMWUx
NDMgPHN5c2NhbGxfZXhpdF93b3JrKzM1Pg0KICAgMHhmZmZmZmZmZjgxMTFlMTJkIDwrMTM+OiBt
b3YgICAgJWdzOjB4MmFjODAsJXJheA0KICAgMHhmZmZmZmZmZjgxMTFlMTM2IDwrMjI+OiBjbXBi
ICAgJDB4MCwweDgwMCglcmF4KQ0KICAgMHhmZmZmZmZmZjgxMTFlMTNkIDwrMjk+OiBqbmUgICAg
MHhmZmZmZmZmZjgxMTFlMjJhIDxzeXNjYWxsX2V4aXRfd29yaysyNjY+DQogICAweGZmZmZmZmZm
ODExMWUxNDMgPCszNT46IG1vdiAgICAlZ3M6MHgyYWM4MCwlcmF4DQogICAweGZmZmZmZmZmODEx
MWUxNGMgPCs0ND46IGNtcHEgICAkMHgwLDB4N2M4KCVyYXgpDQoNClVzaW5nIHRoZSBjb25zdC1h
bGlhcyBjaGFuZ2VzIHRoZSBiZWdpbm5pbmcgb2Ygc3lzY2FsbF9leGl0X3dvcmsgdG86DQoNCiAg
IDB4ZmZmZmZmZmY4MTExY2I4MCA8KzA+OiBwdXNoICAgJXIxMg0KICAgMHhmZmZmZmZmZjgxMTFj
YjgyIDwrMj46IG1vdiAgICAlZ3M6MHg3ZWYwZTBmNiglcmlwKSwlcjEyICAgICAgICAjIDB4MmFj
ODAgPHBjcHVfaG90Pg0KICAgMHhmZmZmZmZmZjgxMTFjYjhhIDwrMTA+OiBwdXNoICAgJXJicA0K
ICAgMHhmZmZmZmZmZjgxMTFjYjhiIDwrMTE+OiBtb3YgICAgJXJkaSwlcmJwDQogICAweGZmZmZm
ZmZmODExMWNiOGUgPCsxND46IHB1c2ggICAlcmJ4DQogICAweGZmZmZmZmZmODExMWNiOGYgPCsx
NT46IG1vdiAgICAlcnNpLCVyYngNCiAgIDB4ZmZmZmZmZmY4MTExY2I5MiA8KzE4PjogYW5kICAg
ICQweDIwLCVlc2kNCiAgIDB4ZmZmZmZmZmY4MTExY2I5NSA8KzIxPjogamUgICAgIDB4ZmZmZmZm
ZmY4MTExY2JhNiA8c3lzY2FsbF9leGl0X3dvcmsrMzg+DQogICAweGZmZmZmZmZmODExMWNiOTcg
PCsyMz46IGNtcGIgICAkMHgwLDB4ODAwKCVyMTIpDQogICAweGZmZmZmZmZmODExMWNiYTAgPCsz
Mj46IGpuZSAgICAweGZmZmZmZmZmODExMWNjN2EgPHN5c2NhbGxfZXhpdF93b3JrKzI1MD4NCiAg
IDB4ZmZmZmZmZmY4MTExY2JhNiA8KzM4PjogY21wcSAgICQweDAsMHg3YzgoJXIxMikNCg0KU28g
d2UgYm90aCBzZWUgUklQLXJlbGF0aXZlIGFkZHJlc3NpbmcgaXMgYmVpbmcgdXNlZCAoaGVuY2Ug
dGhlIGluc3RydWN0aW9uIGlzDQpvbmUgYnl0ZSBzaG9ydGVyKSBhbmQgdGhlIHJlbG9hZCBnb2lu
ZyBhd2F5Lg0KDQpOb3csIEkgYW0gbm90IGEgY29tcGlsZXIgZXhwZXJ0IGFzIGZvciB0aGUgcmF0
aW9uYWxlLCBidXQgaXQgZ29vZ2xpbmcgYXJvdW5kDQpJIGNhbiBzZWUgTmljayBleHBsYWluaW5n
IHRoZSByYXRpb25hbGUgWzFdIC0gaWYgeW91IHVzZSDigJxw4oCdIHlvdXIgcmVhZCBtZW1vcnku
DQpCVFc6IEl0IGlzIHJlbGF0ZWQgdG8gZGlzY3Vzc2lvbiB5b3UgaGFkIFsyXSwgaW4gd2hpY2gg
eW91IGVuY291bnRlcmVkIGFuIGlzc3VlDQpJIGFsc28gZW5jb3VudGVyZWQgYmVmb3JlIFszXS4g
TXkgYmFkIGZvciBwdXNoaW5nIGl0IGluLg0KDQpBbnlob3csIEkgY3JlYXRlZCBhIHNpbWlsYXIg
Y29kZSBvbiBnb2Rib2x0ICggaHR0cHM6Ly9nb2Rib2x0Lm9yZy96L2RQcUtLelBzNCApDQp0byBz
aG93IHRoaXMgYmVoYXZpb3IgLSBob3cgY29tcGlsZXIgYmFycmllcnMgY2F1c2UgcmVsb2FkLiBJ
dCBzZWVtcyB0aGF0IHRoaXMNCmJlaGF2aW9yIGhhcHBlbnMgb24gR0NDIGFuZCBDTEFORyBvbiB2
YXJpb3VzIHZlcnNpb25zLg0KDQpUaGUgaWRlYSBiZWhpbmQgdGhlIHBhdGNoIGlzIHRoYXQgaXQg
Y29tbXVuaWNhdGVzIC0gaW4gdGhlIGNvbXBpbGF0aW9uIHVuaXQNCmdyYW51bGFyaXR5IC0gdGhh
dCBjdXJyZW50IGlzIGZpeGVkLiBUaGVyZSBpcyBhbiBpc3N1ZSBvZiB3aGV0aGVyIGl0IHdvcmtz
IHdpdGgNCkxUTywgd2hpY2ggSSBoYXZlIG5ldmVyIGNoZWNrZWQuDQoNCg0KWzFdIGh0dHBzOi8v
cmV2aWV3cy5sbHZtLm9yZy9EMTQ1NDE2DQpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDIzMDMwNjEyMDEwNi5HRTEyNjczNjRAaGlyZXoucHJvZ3JhbW1pbmcua2lja3MtYXNzLm5l
dC8NClszXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAxOTA4MjMyMjQ0MjQuMTUyOTYt
NS1uYW1pdEB2bXdhcmUuY29tLw0KDQotLQ0KDQpIZXJl4oCZcyB0aGUgdXBkYXRlZCBwYXRjaCAt
IGJ1dCBJIGRpZG7igJl0IHJlYWxseSBib290IGEgbWFjaGluZSB3aXRoIGl0IHNvIG5ldw0KaXNz
dWVzIG1pZ2h0IGhhdmUgY29tZSBzaW5jZSBteSBsYXN0IHBhdGNoLXNldDoNCg0KLS0gPjggLS0N
Cg0KRGF0ZTogVGh1LCAxMiBPY3QgMjAyMyAwNjowMjowMyAtMDcwMA0KU3ViamVjdDogW1BBVENI
XSBDb25zdCBjdXJyZW50DQoNCi0tLQ0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2N1cnJlbnQuaCB8
IDE3ICsrKysrKysrKysrKysrKystDQogYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYyAgIHwg
IDQgKysrKw0KIGluY2x1ZGUvbGludXgvY29tcGlsZXIuaCAgICAgICB8ICAyICstDQogMyBmaWxl
cyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3VycmVudC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
Y3VycmVudC5oDQppbmRleCBhMTE2OGU3YjY5ZTUuLmQwNWZiYjZhOGJkNyAxMDA2NDQNCi0tLSBh
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2N1cnJlbnQuaA0KKysrIGIvYXJjaC94ODYvaW5jbHVkZS9h
c20vY3VycmVudC5oDQpAQCAtMzYsOSArMzYsMjQgQEAgc3RhdGljX2Fzc2VydChzaXplb2Yoc3Ry
dWN0IHBjcHVfaG90KSA9PSA2NCk7DQogDQogREVDTEFSRV9QRVJfQ1BVX0FMSUdORUQoc3RydWN0
IHBjcHVfaG90LCBwY3B1X2hvdCk7DQogDQorLyoNCisgKiBIb2xkIGEgY29uc3RhbnQgYWxpYXMg
Zm9yIGN1cnJlbnRfdGFzaywgd2hpY2ggd291bGQgYWxsb3cgdG8gYXZvaWQgY2FjaGluZyBvZg0K
KyAqIGN1cnJlbnQgdGFzay4NCisgKg0KKyAqIFdlIG11c3QgbWFyayBjb25zdF9jdXJyZW50X3Rh
c2sgd2l0aCB0aGUgc2VnbWVudCBxdWFsaWZpZXJzLCBhcyBvdGhlcndpc2UgZ2NjDQorICogd291
bGQgZG8gcmVkdW5kYW50IHJlYWRzIG9mIGNvbnN0X2N1cnJlbnRfdGFzay4NCisgKi8NCitERUNM
QVJFX1BFUl9DUFUoc3RydWN0IHBjcHVfaG90IGNvbnN0IF9fcGVyY3B1X3NlZ19vdmVycmlkZSwg
Y29uc3RfcGNwdV9ob3QpOw0KKw0KIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgc3RydWN0IHRhc2tf
c3RydWN0ICpnZXRfY3VycmVudCh2b2lkKQ0KIHsNCi0JcmV0dXJuIHRoaXNfY3B1X3JlYWRfc3Rh
YmxlKHBjcHVfaG90LmN1cnJlbnRfdGFzayk7DQorDQorCS8qDQorCSAqIEdDQyBpcyBtaXNzaW5n
IGZ1bmN0aW9uYWxpdHkgb2YgcmVtb3Zpbmcgc2VnbWVudCBxdWFsaWZpZXJzLCB3aGljaA0KKwkg
KiBtZXNzZXMgd2l0aCBwZXItY3B1IGluZnJhc3RydWN0dXJlIHRoYXQgaG9sZHMgbG9jYWwgY29w
aWVzLiBVc2UNCisJICogX19yYXdfY3B1X3JlYWQgdG8gYXZvaWQgaG9sZGluZyBhbnkgY29weS4N
CisJICovDQorCXJldHVybiBfX3Jhd19jcHVfcmVhZCgsIGNvbnN0X3BjcHVfaG90LmN1cnJlbnRf
dGFzayk7DQogfQ0KIA0KICNkZWZpbmUgY3VycmVudCBnZXRfY3VycmVudCgpDQpkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29t
bW9uLmMNCmluZGV4IDM4MmQ0ZTZiODQ4ZC4uOTQ1OTBhZjExMzg4IDEwMDY0NA0KLS0tIGEvYXJj
aC94ODYva2VybmVsL2NwdS9jb21tb24uYw0KKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21t
b24uYw0KQEAgLTIwNTIsNiArMjA1MiwxMCBAQCBERUZJTkVfUEVSX0NQVV9BTElHTkVEKHN0cnVj
dCBwY3B1X2hvdCwgcGNwdV9ob3QpID0gew0KIH07DQogRVhQT1JUX1BFUl9DUFVfU1lNQk9MKHBj
cHVfaG90KTsNCiANCitERUNMQVJFX1BFUl9DUFVfQUxJR05FRChzdHJ1Y3QgcGNwdV9ob3QgY29u
c3QgX19wZXJjcHVfc2VnX292ZXJyaWRlLCBjb25zdF9wY3B1X2hvdCkNCisJX19hdHRyaWJ1dGVf
XygoYWxpYXMoInBjcHVfaG90IikpKTsNCitFWFBPUlRfUEVSX0NQVV9TWU1CT0woY29uc3RfcGNw
dV9ob3QpOw0KKw0KICNpZmRlZiBDT05GSUdfWDg2XzY0DQogREVGSU5FX1BFUl9DUFVfRklSU1Qo
c3RydWN0IGZpeGVkX3BlcmNwdV9kYXRhLA0KIAkJICAgICBmaXhlZF9wZXJjcHVfZGF0YSkgX19h
bGlnbmVkKFBBR0VfU0laRSkgX192aXNpYmxlOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
Y29tcGlsZXIuaCBiL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaA0KaW5kZXggZDc3NzlhMThiMjRm
Li5lNzA1OTI5MjA4NWUgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLmgNCisr
KyBiL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaA0KQEAgLTIxMiw3ICsyMTIsNyBAQCB2b2lkIGZ0
cmFjZV9saWtlbHlfdXBkYXRlKHN0cnVjdCBmdHJhY2VfbGlrZWx5X2RhdGEgKmYsIGludCB2YWws
DQogICovDQogI2RlZmluZSBfX19BRERSRVNTQUJMRShzeW0sIF9fYXR0cnMpIFwNCiAJc3RhdGlj
IHZvaWQgKiBfX3VzZWQgX19hdHRycyBcDQotCQlfX1VOSVFVRV9JRChfX1BBU1RFKF9fYWRkcmVz
c2FibGVfLHN5bSkpID0gKHZvaWQgKikmc3ltOw0KKwkJX19VTklRVUVfSUQoX19QQVNURShfX2Fk
ZHJlc3NhYmxlXyxzeW0pKSA9ICh2b2lkICopKHVpbnRwdHJfdCkmc3ltOw0KICNkZWZpbmUgX19B
RERSRVNTQUJMRShzeW0pIFwNCiAJX19fQUREUkVTU0FCTEUoc3ltLCBfX3NlY3Rpb24oIi5kaXNj
YXJkLmFkZHJlc3NhYmxlIikpDQogDQotLSANCjIuMjUuMQ==
