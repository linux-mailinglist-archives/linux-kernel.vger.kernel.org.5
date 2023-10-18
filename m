Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFC87CE89C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjJRURX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjJRURT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:17:19 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11010000.outbound.protection.outlook.com [52.101.51.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1002FB8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:17:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJWQqCSzeSV9FvltvUp6tD9xPoAHFFLJZ0frT62/f1yurFsnYtdbni2Il1Y7v4r1DjLsDkOO4U/Hq+doH0LLJTVSIECSsY38aAntmOqrPkpJI5fNm6BXIV8pwe/C7MBIq882gBaD417RKarNxe0yiLlG1yPI9keyKtTi9ZjDLo3mB73CK0EEOfbcaNNG6mPpVDHEHMCD8ibK7yhwgWP38t/6HBOS5bdxumjzte31sK4Qhb0peTwhT3pBIBej47ljCwEfUq5vnDodRdlAcdR/1a1Ipmh3xePkqYP6t0ewx2hqIhaZvMFAWZQ8veWLOapTLjhcsBPmq5T6lnRHqM6z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nea5EXtdQgT8Pk1NAgvdIoG8rj9HTGXFStC2ChlELBE=;
 b=mlhnWzxfL2fbW3+XjPyuPQilURjUxrbFxVXnN0Q8y2RWItHU0J4RwladPYNd8o+xrt3VELDH62BdBlwSIvyx40znFU3CpCjsTtTa9vvAfs3RjjWLNNMKuoZpY4GMOnN3hM+Vj30R1TMhzQop5BQAsr1O4r/P4MgvQaO34vUY7vS4btHSfvVjaoJN6BAK1mRYYEKBIox0hyLgiyvw4veS+a4dojgcMM6VOhG+QNvO+hNDmmbnYMYAqvZP8rYw+QMEchCe9wLZRgiHbFo+jLdmmkF+denfaElk1bcZa0/k1Zzj5eUDpaD82u632IXzKsLCvLCXNkOThIDbAYIootx/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nea5EXtdQgT8Pk1NAgvdIoG8rj9HTGXFStC2ChlELBE=;
 b=GplpO4umxnBJvGC084YM6o8+Zz5fDOFjgCcsaxRZDrsaj2CRkm2Q3jhZNo8lkTXHOc9qiEwcXqNGl7pU4TBkJD4i2VBenlucLvOxh4xpHvMQjOEXNjx6yJZzE1oQhKCCSq/oO5X8cjkgVr9vVAfwx8xlnsU+H2TwnVehARlmKZc=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by IA1PR05MB9382.namprd05.prod.outlook.com (2603:10b6:208:41a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 20:17:15 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6886.039; Wed, 18 Oct 2023
 20:17:15 +0000
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
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/FrBDSECAgAAOE4CAAAQxgIABoxnfgAAgI4CAAAYlgIAHqOMRgAAI04CAADzyiIABTsvzgAADAQCAAB/hAIAADVOAgAClpgCAABXQAIAANUA7gAAQyoCAACJcPoAAE0DxgAAcTYCAAAIigIAAAw6AgAASjACAAAw4AA==
Date:   Wed, 18 Oct 2023 20:17:14 +0000
Message-ID: <90084B6D-AF09-467D-A550-CC557F709847@vmware.com>
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
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com>
 <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
In-Reply-To: <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|IA1PR05MB9382:EE_
x-ms-office365-filtering-correlation-id: 0ae29152-7808-4ffc-0fd4-08dbd017384f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ac6row0XU0uppgzdN+mN0bxcewRbU3wnsxgrCxKIH3fXhTFQ6I1FjsZOsgX85LwDHlm6rVrVyKGaw/eOfwY2YSo2QTwxneIpM1+tcEQ8kk3CzYRMUuJE4AlFOTFk55I0ZovT/cEwgWFTE/hG267tWWd6/TSyLriLVW1jJimndnIYV2sZ+8FoTtHmNvxcH4YrXxgmxf5UCnKr9+vDNlizBIHTPwGyZULztgYs/2KcTqI7iPrOxiZEqxHTNfiN5Ar9c2F1C4CIJ2et9ukmP8m1VRNKDFQGTmzQVFoFt4aEo1CMUjbWBAsLG8kTegR0D6lunG5X61wrcyLsTa9qOBBmWi0IF+nn4XTIGn8a+YLXmx5UVYeC76HdLqU2H6Nqylk1A/zxYDTVqvCLea1j9Qj+TzCXGjVUolxj9NfdNR4VK5dSdhMxmbLyXcRhjGMtseMnlp8wEV6gNHbS4NDZ/qZtKUsWsoFZKRFIhPu83VCjTce+iRAkiYk81HdWSDr0RgtvrEoxDuhjbUq8W0m0bzdDTnpByDluGFwLAdKy1eUfB8O4nytHIcKgP+Ch2szgm7NprqVq8C1eHHNedxKhj6u2qIPtj8A09Vv30jFRKsmn24FuFAl92qUMDHiHGAtk0wIdKB9+AWugXjVlwW/Gg7KMP3204w2J24eQ+a9rpNzIA8g0YbG+8l7x4dZuhhqP/vTP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(2616005)(38070700005)(8936002)(8676002)(4326008)(71200400001)(33656002)(38100700002)(5660300002)(83380400001)(122000001)(6486002)(2906002)(478600001)(41300700001)(86362001)(7416002)(6512007)(316002)(6506007)(91956017)(66946007)(53546011)(66446008)(54906003)(76116006)(36756003)(64756008)(66476007)(66556008)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkJGYWMyd3JaN05Tb25FNTZxbDMwdVh4c3VBL3lCREVFZEZHUkxsbnZSQnoy?=
 =?utf-8?B?eGV2V1dVTktscDRTMExRUjlVMmtyUXQvT210aHVYdFBzSHphZGliT0JpUlVF?=
 =?utf-8?B?UWJ5cWVZNWRIeGh3NitpamZFUmFFVURtbHNsZzNjSXY1WmN6YXlubnB6a2hG?=
 =?utf-8?B?NVNiYVplVVFXUzk1OWlqc1ViL0I3VGxjM0l0cDZnR2w0amFBdEUwMk9FeW1u?=
 =?utf-8?B?L2g2clFrR3hKa1lvOHE2NW9JTlRqU21maGp6OHNyNXIyU0Mxb0VrV0lJOU9y?=
 =?utf-8?B?THl5ai9TTVd1b3pwZXArN2Zqdm42NWFLU21IWjZCTkMzK3Z6LytDKytzd1k5?=
 =?utf-8?B?NklOZERYSEs0SUJ0UkNrY3BrcDBXNURCYld3bko3Slk1NHVlOTZKTWlnTlJo?=
 =?utf-8?B?ais0OTF6RmJYUFpod0Zmd01FWVRtejdnTXp1b0I1MVB4cld1UmhvbFNlQnBK?=
 =?utf-8?B?K0JCQjdSTzVWL0hjREV2TXVEVEMrWmVmWVcvNHhXUVRGL0NnRVBWT0VmazJk?=
 =?utf-8?B?bDVvT3VQRUVpYXVSeE9IWUxOY0pFak90NmZKZzJ4T2lmR3d4dlJuczdGbGgy?=
 =?utf-8?B?QlczRmRJUGdmQ1JWaW9SNU1NYnRZNjNqb1A4T1lPS2Z5aGlWUlhtME9uWHVD?=
 =?utf-8?B?VFR0YmxtcUp1c0o3MlJ0amhpM2xPQ1YxdnJvTm9zekJmbU4wdUl3NmFPYTlS?=
 =?utf-8?B?RUxROVByWHZkUjBzbEo2UjRDbFljR3dtNSs5bGc1cXJxeVZ0d0llNVZPbHdh?=
 =?utf-8?B?RlZObE9GWVV3QmRGbE5KM08wU0QxbG4yWXh4aVRlZjdIUGxEM3hKVDBhUG1a?=
 =?utf-8?B?SlJwdFNRbEpnVEQ2WXJaNFZWMFlkQ3ZRVTE0aWpwZHJ6T2F5TFlZRkpjS2Qv?=
 =?utf-8?B?bVhYSUFZbzNLQlRsNjZqRGxHdmVWcWdTWEMyd2tmVTFVMWpaUVE0ZnpNOTJp?=
 =?utf-8?B?U3cxT2h6YmxhZzd4UWpZTGlvNlp2eVJWbTlsNFlFSmVpWHBkcVlyUTNjK3pW?=
 =?utf-8?B?L3FUdS9kVGdMZUwrK1NuUlY2blpjYXVRUEZhNWd6VGw4bkhIWnRiN0dIQnU5?=
 =?utf-8?B?c2lrTWV5RGpCU3lJVEdIV0s1UmJraXFPSlJHNU9GL2FVZEFaeU5XKzB5amxT?=
 =?utf-8?B?aWF1NURCMDlLKzVWSk1zSmdoWTFKazBjTE5wd1pQUnZKNk0xZjYxaHR2M1kw?=
 =?utf-8?B?YU1CbmVSNUFjM2JsMDNYWVNpdTdpbjF6T0NRMWsya3Njdklyd3BFZmdMczl6?=
 =?utf-8?B?Yldqb1ZzdUI2cDM1L2xPakJQWnZnWFdiMVZoek5jVG4wa01xMlFYYUxWaS9k?=
 =?utf-8?B?dlFNaTJUNm9Xd09yaWFJbFNOTG1NNkk3b3JUcWxmZDVtRy9UQkIvZTZHQ0FH?=
 =?utf-8?B?ZjBCNnhLYW93K3pJanRLRzZ2RGVGNk5YTHVOU3I1a2krU21sblZzcW5aSmMx?=
 =?utf-8?B?eEdMTGtxLzczVWFzbDhTSC96VEtNR2xlVGo0VGNHc1VzeENwQVFDUU1BK3BO?=
 =?utf-8?B?ZThVdUVhaVdkd0prcTllRzUwWG55a1EyZUhhVVNnQXZVVmRkdXpFa0dpZGtT?=
 =?utf-8?B?VGIya3NLOER0OWtaeC9mV29NT3BvamVhR3R4SXVFWmN2OWV3cWJ4M1lKeXdM?=
 =?utf-8?B?WmRVZFBIV1dXZWhKdFhIeDVUdW5vQXdYaC9xVkh2d2tJKzRtVGFLSU9uNEZK?=
 =?utf-8?B?OEZNcHpScFFvbEwzME5VNlh0dGNKaTJBSGZFRWkwMVNOeVBsWjNUY1A0cUln?=
 =?utf-8?B?aFJHYWJTSVFYQXNnYmlCMmNEUmVnVU4zM0NETUFRNTdqci9lQ29OYjZYZXZW?=
 =?utf-8?B?ZGVaUDhsRW5STXdZUE45ejFXYzcvcDBxS1JsVlNXVjZybm1pREFqN2E3d212?=
 =?utf-8?B?WVpMSHZMbEt2bEErVlJjVnA4MCtMZ0xIeXljMFU5amtqOVUyZU1rbi9RSXY0?=
 =?utf-8?B?b1lPd3ovdUZZaEVCZ3ZUMzhyTTZyVWFtUHRUUisrcXBSejdlTEJKVDZudlFh?=
 =?utf-8?B?UTIrR0xYN2lXcFd0SlBLOXlTcWo4K0dKaFV1WDZCQjF3WW42eVc5TzN6cDMv?=
 =?utf-8?B?SXJJSytTRmpZbVZXbHMzeWxkU1VhRHdwOFlGZmtsaWhyajN3MkRldVJBMk9G?=
 =?utf-8?Q?Gxv8pH7pWQ5EnqhZThmYaeOeI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E07D9F54AA14D4289775F7EC2DD99F8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae29152-7808-4ffc-0fd4-08dbd017384f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 20:17:15.0102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+Ryo8OgXNp1NY92NFJXOl0VGlsLeeI0nevaVjqxVUimOoOV8wNWdhQefCE28YBg5yupDPY9wLBf2xFkwZJhOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB9382
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gT2N0IDE4LCAyMDIzLCBhdCAxMDozMyBQTSwgVXJvcyBCaXpqYWsgPHViaXpqYWtA
Z21haWwuY29tPiB3cm90ZToNCj4gDQo+IFRoaXMgcGFjaCB3b3JrcyBmb3IgbWU6DQo+IA0KPiAt
LWN1dCBoZXJlLS0NCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NtcC5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vc21wLmgNCj4gaW5kZXggNGZhYjJlZDQ1NGYzLi42ZWRhNDc0
OGJmNjQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NtcC5oDQo+ICsrKyBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3NtcC5oDQo+IEBAIC0xNDEsOCArMTQxLDcgQEAgX192aXNp
YmxlIHZvaWQNCj4gc21wX2NhbGxfZnVuY3Rpb25fc2luZ2xlX2ludGVycnVwdChzdHJ1Y3QgcHRf
cmVncyAqcik7DQo+ICogVGhpcyBmdW5jdGlvbiBpcyBuZWVkZWQgYnkgYWxsIFNNUCBzeXN0ZW1z
LiBJdCBtdXN0IF9hbHdheXNfIGJlIHZhbGlkDQo+ICogZnJvbSB0aGUgaW5pdGlhbCBzdGFydHVw
Lg0KPiAqLw0KPiAtI2RlZmluZSByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpICB0aGlzX2NwdV9yZWFk
KHBjcHVfaG90LmNwdV9udW1iZXIpDQo+IC0jZGVmaW5lIF9fc21wX3Byb2Nlc3Nvcl9pZCgpIF9f
dGhpc19jcHVfcmVhZChwY3B1X2hvdC5jcHVfbnVtYmVyKQ0KPiArI2RlZmluZSByYXdfc21wX3By
b2Nlc3Nvcl9pZCgpICByYXdfY3B1X3JlYWQocGNwdV9ob3QuY3B1X251bWJlcikNCg0KSSBkb27i
gJl0IHRoaW5rIHRoYXTigJlzIGNvcnJlY3QuIElJVUMsIGFsdGhvdWdoIGNoYW5naW5nIF9fc21w
X3Byb2Nlc3Nvcl9pZCgpDQp0byByZWFkIHBjcHVfaG90LmNwdV9udW1iZXIgdGhyb3VnaCByYXdf
Y3B1X3JlYWQsIHJhd19zbXBfcHJvY2Vzc29yX2lkKCkNCnNob3VsZCBub3QgYmUgY2hhbmdlZCBp
biB0aGlzIG1hbm5lci4NCg0KcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSBkb2VzIG5vdCBhc3N1bWUg
dGhhdCBwcmVlbXB0aW9uIG9yIGF0IGxlYXN0DQptaWdyYXRpb24gb2YgdGhlIHRhc2sgdG8gYW5v
dGhlciBjb3JlIGlzIHBvc3NpYmxlLiBTbyDigJx2b2xhdGlsZeKAnSBrZXl3b3JkDQphbmQgaW5s
aW5lIGFzc2VtYmx5IGFyZSB1c2VkIHRvIGVuc3VyZSB0aGUgb3JkZXJpbmcgYW5kIHRoYXQgdGhl
IHJlYWQNCmlzIHJlYWQgd2l0aG91dCBzb21lIGNvbXBpbGVyIG9wdGltaXphdGlvbiB0aGF0IHJl
YWRzIHRoZSB2YWx1ZSBtdWx0aXBsZQ0KdGltZXMgb3IgdGVhcnMgdGhlIHJlYWRzLg0KDQpJbiBj
b250cmFzdCByYXdfY3B1X3JlYWQoKSBkb2VzIG5vdCB1c2UgdGhlIHZvbGF0aWxlIGtleXdvcmQs
IHNvIGl0DQpkb2VzIG5vdCBwcm92aWRlIHRoZSBzYW1lIGd1YXJhbnRlZXMuDQoNCg==
