Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AB67CBC29
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjJQHX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjJQHXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:23:54 -0400
Received: from DM4PR02CU001.outbound.protection.outlook.com (mail-centralusazon11012011.outbound.protection.outlook.com [52.101.63.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5ED93
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA7p+YmAKvkiQjp7o3VK6lsbpRISY2PERrfCsosY2ktV7rqJKpdZa44mqckMnPCoiE3x0tkMygalqIzcyFTqzud7Ersl/x/T8AcKUzWgCWzLKFJtTmx6pWCMJqebdRPYvzER3QrfwFvcjagXnI6l/nX6V75C3pwaiqXeikDZgvzJVJis1SYRVbdJP36Wgy2rWtMGB05GjtUzYjyD0yceww/Sbxd+WTz0Lu7kd8EwXTMoiuwCArKxvjLGxILqOrD9tci+dwayJl4ec+WLsxmL5Od1igvE0kNO3K1yXl6wZYisj4uZFg1foRm8HnbC/kngvBJN41oVu7yOwGr6CQQzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQnnOOUhHiNSAk7hSnI0r9RsymSMOIskDTTRe36tcG4=;
 b=d4xWYAi/p4UQNEVZUiQ9hL8tqI8f5JzhKeiXeP0kRO/+EhH1KUeug40CfyVaxsGVg8HqbK+9yt8j8Xg4Yv51InkZjXnYXkNq9r/9rfBd5NRmhKbKRQl2G1yi7gB8S0C5QJUL5aaNottRno+hSx69YglaQBhEVFPoWgI3YJke0EfnJhnSUjN9Ncn3AS27dw7H7+nYjtkmDPJ8PtNfUe4kT4/MSHJm82S8rGbeJxQY+9hCXYULS9jmhZJFCcZihVl8VZb84ZGU0Dyp2oJ712t0EB+TItZYn7cOgeH98RAmLguXDKV20RlIFFq/safMsVo3n/E7dxG2XQW+mlVxS6qBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQnnOOUhHiNSAk7hSnI0r9RsymSMOIskDTTRe36tcG4=;
 b=yY1AC7JCxrNfEB66ilprtbxgI3a/Uj9vLgdA/DiLutVfg+x2+D65BhxcnrWSl8DGhspndrsJpbZZLSP8DXmZKpmVOdu1zyCmhuE18bE30I9tU/nbH29kclgGjPvlkuc+PsmcbgdglFeAguhM5Sfd3BUfCDdxDh88tcqgXPrALSw=
Received: from SA1PR05MB8534.namprd05.prod.outlook.com (2603:10b6:806:1dd::19)
 by CO1PR05MB7957.namprd05.prod.outlook.com (2603:10b6:303:f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 07:23:50 +0000
Received: from SA1PR05MB8534.namprd05.prod.outlook.com
 ([fe80::98f3:ea:b83b:9ed2]) by SA1PR05MB8534.namprd05.prod.outlook.com
 ([fe80::98f3:ea:b83b:9ed2%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 07:23:49 +0000
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
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/FrBDSECAgAAOE4CAAAQxgIABoxnfgAAgI4CAAAYlgIAHqOMRgAAI04CAADzyiIAAi/IA
Date:   Tue, 17 Oct 2023 07:23:49 +0000
Message-ID: <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com>
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
In-Reply-To: <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR05MB8534:EE_|CO1PR05MB7957:EE_
x-ms-office365-filtering-correlation-id: 43593603-25a5-4534-5dae-08dbcee20221
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UQ/DaX8UcL6l8uz2fgczyYzyRJL5XDV1u8D5PCq3wfiGoeQR/qvgtlx9pdcr/JW7K+dxRXxE2hfiWmU64zY1vom5WQJSBIXj/DMVkmNNv4G8mfC02gqMWUk2ROTmke/9X6uMwuGfvQiBcncAf7lr2Qn5nW7h5ADc+KeF6vRGBxXRKf47F0kJp8WtincVEruNZavEfZMs59RqeDSkXy90tidqsaCkmonbeCsddnZVrsTPEKeTbOfn3mAm9WS2xUIocRzdehfjr6rRQYybweZyqvNpt+mQfDFXDv03dFTh8DJy0YqDGG4P60gyD17gzhQCWLBCZySf66TdjyOYjsUa9qChPbgoBLaWL6mglYWOQFgjl7EacEOp8F0tC7UR0Chft750+eBaH4LA7JwMvLxkpJ8ywpNoENpbNeIPZJkUeCamwLdpTxNvUAAhHcZu+7b+fgTKJyCHLZ1PKRw67+51yX75SxH1V8n4DXLX44fZSneHDeFNsTEMA2QYScsdNzWdnvBOoPGIsJvUw/0ocwTEjHz+2Wra9zlfDRxt0Au2jRedrQoerDZhRMdrmo5v8037icgSgEn3bFmA7nmmBCCxyI1215tvy9RvsOSGd1HOph41tpoK9eFx8ILlDcLMw1OwhEGNudmyJGf0xneLq0MPILGaf9jrFidl37YSbKmRgtQ4u/ZL7LGeL2nJHZOIdeIvZHorpSFFrHO4rnycqgOF6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR05MB8534.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(53546011)(6486002)(122000001)(36756003)(38070700005)(38100700002)(6512007)(26005)(6506007)(2906002)(64756008)(54906003)(66476007)(66446008)(6916009)(316002)(2616005)(478600001)(76116006)(66946007)(66556008)(91956017)(7416002)(4744005)(86362001)(33656002)(41300700001)(71200400001)(8936002)(8676002)(4326008)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmhsVjNOOUtvckhXQjlDdG5CWERKdnVEdkkxQ0ptUFJvUVUxOCswUEVJcXJw?=
 =?utf-8?B?S004eUZpK0M4SkhnY1JGYWhId29hNnZub1J5ZUpIeXo3U09YQUt6Yi8ya0kr?=
 =?utf-8?B?Q2czZVpIYS96UXNLNnZVcktQbDNmQU10Rzh1bm5Ib2RtVHlKYnh3cmlYRmtT?=
 =?utf-8?B?cDBJcHVIcE5UL1NHck5LYXZnTHczNk1yb0RVcEdFMjQvUW5LSWpkSVFYMmk5?=
 =?utf-8?B?WlBuRk1PMkVPZE9NNUd5U3NjaDZSd0VLR2RNTG5XMEorTDdod3Axd1BFYUdl?=
 =?utf-8?B?SGt3dUpFZ2RtTGpFc2tOMzFHS1FJQUZOYnpKbE9JTmZHYXZXSjFaM2QvKzIv?=
 =?utf-8?B?UmMrcE9GUWMyNkpuN2djdDdaWlpGWmlsZzBKeFFaYVFHbUgwbnBiWkEzN1ls?=
 =?utf-8?B?dWdVSjFSMFlKT1FNOUNHMkM2Z1NwUFBURlZlMHVOVlJGaUtTTElOTlQzVlBn?=
 =?utf-8?B?djNHMXJXVzZVRGY3dWE3enQxaDVhZ054Nnl4MzRXWHExMjlqZmtmUnhkZ0pw?=
 =?utf-8?B?TGNXUXJjZkU1dHBLTndGbmhzNzZ6YUt0Sm1CTDRUS3I2WDJCRFJMbzNoZ3pU?=
 =?utf-8?B?R1ViRi81ZWEzcjNDUDE5a0hLYTdJWmY5YzdKTVV5TTc0RUtzUktuQlRZOTh0?=
 =?utf-8?B?bmNoQnUrSlkwbkR1MldHNjJlU2xIOTl1VThrUGN4RW9jQlFWSDF6cG1nTWR4?=
 =?utf-8?B?Z2VaSFcwU01TMXhxak5pTXhyN1RlSis5T1pqTUR2OXlQSCtHcURYL1lwaVc1?=
 =?utf-8?B?bkxxY2ZrOHErU1k2SldDNmp2MFRJdU50Skx0T0dYRGZvMUVqc3I0QjdxZDl4?=
 =?utf-8?B?OEllT1VpVU9VOGR1RFprUVJOQ3RMQUlMeEZNVUZ0WkhzZFRJQTI1U21LbEov?=
 =?utf-8?B?VWZDd21VUk50UDc1QkNDRVNtMXBxczFhOFpLRDJ6M1l6QW9Zc09EZkxoWDcv?=
 =?utf-8?B?eXQySWtjaVpvZ2dGdTQzWUtFZHN6WmtlTVZtRko3V1lWOEZZQXVmU1U3MXpJ?=
 =?utf-8?B?bE5FdjJuYXNGdTFJT2lPNVlMOXVwYTJDREV3a2UyeWRPaWVvaWxmUWE4UEdh?=
 =?utf-8?B?M0ZxUkFMM1JDT3hzSHdNOHZOaUJlblZhQS9QU25jRDlEWGlqZjYwRmhIaG81?=
 =?utf-8?B?OGJhU1N1cXdaZnVhVmdZWXoweVlLcWowZlpta1ZnRFAwTkFmbmFRUkRKdGI4?=
 =?utf-8?B?OFBPc0dOUDhNRjR6RjhHdVVtenBJNjRuYlJpcUhjU21uS0ZnRkpkQmw4dkZO?=
 =?utf-8?B?YnVURkcyMEQ0THIyVkJocmlBN0NrZm1GeTZ4dU4zbHlTN3JCbmhzY2JNeFZX?=
 =?utf-8?B?OUM2dHJQRWpnYWdpSjV4c08vWW9maEZIR3JKUHVxcENQeUFpM2hDZm9jY1cv?=
 =?utf-8?B?ZXRtTEpOd05UajRsdzJoSytobXBMTTJkT0pXZWVLY09TQWc5SjB4bS9UYll1?=
 =?utf-8?B?ZEhoRzR5dHFzNWF4bUwwUVlZcnk3cEhmV1pQbjJFaVB2T0doOGtkeFBKd0Yx?=
 =?utf-8?B?a01GVm5ROTZpOCtEWFl6eWVqNlZQT2tzUisvZmpVd1MxeTEwbngrRWJiQlM1?=
 =?utf-8?B?VlBOemFKcmJ0d212S3laVzBsZStmYm1heG9VZkt2OWY5YXlEeFhmT3pCUWp1?=
 =?utf-8?B?OVcvZVUzSk1qbHpSTU44SkF3am5XQmtIU2o5Y20xYmJ1aFhoYlFvbk8vY0JD?=
 =?utf-8?B?NnA4WnQwMmY0dzZpaHpGVzM2V3JGUmNCeDV1S1pWcU8zS1czME5MMnBiUjAx?=
 =?utf-8?B?OU1pYlFVMFNwM25zc2JIZWFWSW9aZThkeW0wQUw4MDJCZDRkYll1VlVGZWkz?=
 =?utf-8?B?MXBNQlVVcDdOWnN2c3lGZWY1bnhIeWRtcEU1UjJlbVp5WjJNQ1l1ZDk5MEJB?=
 =?utf-8?B?NzdpSnVVTEdWZTdGUFl0UVJoalRMTHRRZllNMlRiM1R1L05aeE9PMmVHTTll?=
 =?utf-8?B?Ny9jSUdObWJPR2U3VVlQbHF0enQwcGpHcEx2RGhXNEdTVjgrN1lqaUg0LzBw?=
 =?utf-8?B?YkV5dVJWdTlmT2NzTHArKzFITzBkYlYzUFBDNXhvRkYzODdNQlB2VU9IWTlQ?=
 =?utf-8?B?MHZGUDhtL2NUWk9kR2dwUUFvSkJMUEdvTHZQZ0owa0YzbHdxeXVGcGczbVF6?=
 =?utf-8?Q?htbrnchcfMp5hlnK/lwqBy0xo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B17E3DB7F4BD074A9F1BC8AAAFB4C367@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR05MB8534.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43593603-25a5-4534-5dae-08dbcee20221
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 07:23:49.6154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vucPq5u582uZT3cajS1thUEEsb78Kk4YHuGh5OlqiqhIaV2EeeZE2eiTEuWzWIqNUpx/BEdwxOWGGXaHl08N9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR05MB7957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE9jdCAxNywgMjAyMywgYXQgMjowMiBBTSwgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IC0gICAgICAgI0FQUA0KPiAtICAg
ICAgIG1vdnEgICAgJWdzOnBjcHVfaG90KCVyaXApLCAlcjEyDQo+IC0gICAgICAgI05PX0FQUA0K
PiAtICAgICAgIHRlc3RxICAgJDE2Mzg0LCAoJXIxMikNCj4gKyAgICAgICB0ZXN0cSAgICQxNjM4
NCwgKCVyZGkpDQo+IA0KPiBzbyBJIHRoaW5rIHRoaXMgaXMgdGhlIHJpZ2h0IHRoaW5nIHRvIGRv
LiBJIGNoZWNrZWQgdGhhdCB0aGUgMzItYml0DQo+IGNvZGUgYnVpbGRzIGFuZCBsb29rcyBzYW5l
IHRvby4NCj4gDQo+IEkgZG8gdGhpbmsgdGhlICdvbGQvbmV3JyBuYW1pbmcgaW4gdGhlIEZQVSBj
b2RlIHNob3VsZCBwcm9iYWJseSBiZQ0KPiAncHJldi9uZXh0JyB0byBtYXRjaCB0aGUgc3dpdGNo
X3RvKCkgbmFtaW5nLCBidXQgSSBkaWRuJ3QgZG8gdGhhdC4NCj4gDQo+IENvbW1lbnRzPw0KDQpZ
ZXMsIHRoZSBGUFUgaXNzdWUgaXMgdGhlIG9uZSB0aGF0IGNhdXNlZCBtZSB0byBjcmFzaCBiZWZv
cmUuIEkgaW5kZWVkIG1pc3NlZA0KdGhlIHN3aXRjaF9mcHVfcHJlcGFyZSgpLiBUaGUgb3RoZXIg
aXNzdWUgdGhhdCBJIGVuY291bnRlcmVkIGJlZm9yZSwgd2l0aA0KX19yZXNjdHJsX3NjaGVkX2lu
KCkgaGFzIGFscmVhZHkgYmVlbiB0YWtlbiBjYXJlIG9mLg0KDQpJdCB3b3VsZCBoYXZlIGJlZW4g
bmljZSB0byBzb21laG93IHByZXZlbnQgc3VjaCBhIHRoaW5nIGZyb20gcmVvY2N1cnJpbmcuDQpQ
cmVzdW1hYmx5IG9ianRvb2wgY291bGQgaGF2ZSBlbnN1cmVkIGl0IGlzIHNvLiBCdXQgYW55aG93
LCBJIGRvIG5vdCBrbm93IG9mDQphbnkgb3RoZXIgY3VycmVudGx5IG9wZW4gaXNzdWVzLg0KDQpU
aGlzIHdob2xlIHRoaW5nIChpbiBhZGRpdGlvbiB0byBVcm9z4oCZcyBhbmFseXNpcyBhbmQgb2Jq
ZHVtcCBudW1iZXJzKSBzaG93DQp0aGF0IHRoZSBjb25zdC1hbGlhcyBhbGxvd3MgbXVjaCBtb3Jl
IGFnZ3Jlc3NpdmUgb3B0aW1pemF0aW9ucyB0aGFuIHRoZQ0KY3VycmVudCB0aGlzX2NwdV9yZWFk
X3N0YWJsZSgpLg0KDQo=
