Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3AC7CCFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjJQWHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQWG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:06:58 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013001.outbound.protection.outlook.com [52.101.64.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBF495
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 15:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lp4pgn/TQr2annnefCXUCZnvGeXrpBVJKmEeaSrd+lhGpFzx+c6Q1OmFrCv5he1RHdo7dLV3j3V4wbpdeVJhEr1YsdG7N0Ghp/axRklVy/qgKhdM6PVamAq4hzuRFeJuxCwQZCiuXxrT8M9TWzNepY2Tgyb5BrFFRtkHEL/Mti1DrLYLfkoBa1OQhgG4UJWHsqyu7JK63c75mZ6BVOrEmlDm2I+7L1FZWkHRh3s7T9oCxroeJ7L0hxXyVLZ6B1bkeiGrJspF80ZVkdlL6z2Yg8hN7TSCYyLrcsflkKzN3HXIp6aPOsTz8pAd3GyyCZhstQhXFwOKzHjJWKysuSz/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f7KdOSQD5rQ9bjlMkRdypU6RgtWOUaYCAgMu2x8ZaM=;
 b=beUhCCH2+NyHaMMG98RVvGdnpMra1pfjOO1xzdXvuxRsyYyc973OsYMGawicwiMcsMMvqLvgeY2OY6yT6+GvbA2Bfug8RDJJsaUilhj9USeOS2Y0Iu8kwNR3Quv/NAFxbCpWSiECSW3J9afKX73Sl17bsFadFhOORE0NBWito7mrGfjnrqalzBeKpJgiGZ6gpsaCkiZTyNEddMgUIU+s9dk212IBZ4uKIX36OJrSY+uwOlktNxcZRYM1NHEOr5Wm8+AOyE518t2xbLQcVLb1MHZHOCR6P4YH16/f5NCY+1N/FbGqNZyMfLsqGYjlGT2IZptWveDpwVXh56PSog9z7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f7KdOSQD5rQ9bjlMkRdypU6RgtWOUaYCAgMu2x8ZaM=;
 b=LhxaMAeaRurXLdDugYquScALYqV+SqC2gVHF256hIdymuZmZ1LfpMq7KKEWgWXXUVmEXiOGPXJX4+TO6QISaSQGFWkFgIKFCncC6JFU5l82Q3JYOkc3L+pxcD5rlqgmN3V6zjE4vrMRs9Fl7FaVlcWZ6uG+tTUhfps8rc1DJ+WE=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SA3PR05MB9761.namprd05.prod.outlook.com (2603:10b6:806:31b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 22:06:51 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6886.037; Tue, 17 Oct 2023
 22:06:51 +0000
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
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/FrBDSECAgAAOE4CAAAQxgIABoxnfgAAgI4CAAAYlgIAHqOMRgAAI04CAADzyiIABTsvzgAADAQCAAB/hAIAADVOAgAADqIA=
Date:   Tue, 17 Oct 2023 22:06:51 +0000
Message-ID: <10930088-3B4E-4BED-896C-CA66AB196010@vmware.com>
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
In-Reply-To: <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SA3PR05MB9761:EE_
x-ms-office365-filtering-correlation-id: 91da9525-4d2a-473a-fedf-08dbcf5d5da9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUXNnoHHPSr10Z6JSvsSsRBimSMyTkr+f/aSoka6psFmbCvuK9/hx4KU7W1LUd+AmGlZ+wCD7I/3optnnRc1YUaOUc5d1oxJUpRx6JpSPUGUZxib3PRI+ClFAczTTsva0HP7POi7rzUFrMaacSXxWIqOsglrAdb+AqqpDSfKNwNTU3C61MYdRFz86h3fYZpTgS5Kr/9a+yFP8BLkg56k+s8sSqfBFl0q9z76laype93vaoUR9Xhs7QpDIcwtueYdtXsmBBaJzDQp8Z8Sp0X9CCbItWfe3qyuLDHhWtmpPQxfRqCd+95Lo33yl5vVINOH+GbJ+jg/xcpSIhbLIIDJFH7/AUMEztLbCosItoNdS45wod8CH6yej5uklFlQZfFecQ4Jgo3HFzvDDGagKyWvt0j/o6MmtlNZ1PYXGIQtQIa4PfMJlVNSUsVCv4E8UxKBXNR+UumdgP/Rnjy442Gd5sjTK+QIruPbQkrQIH3SEff1JSgNfzB69jpV6nsRukmHwoMf8W+8mEYABf+GKhxSOp4diVOZh0QonhE/rUJi2p53WDiFRlT5a8HIEs+4CRl23N6ciYGqAZTkwGLdUxri4HlIhhkpEVvbUbJ2244EmTR+P7D2aYqhDmEeUGp4XfYMikYXWJs0QJkQCxIYe/YsvEaxCML/EiM8wAzwDkHL8SP80YYsnelWzDb08RgGuHlkwpeayhMlaOzXgplgVSzIIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(53546011)(83380400001)(36756003)(26005)(5660300002)(41300700001)(8936002)(4326008)(8676002)(2616005)(86362001)(71200400001)(6486002)(38070700005)(122000001)(66476007)(2906002)(66946007)(478600001)(4744005)(54906003)(316002)(7416002)(91956017)(6916009)(66556008)(64756008)(66446008)(76116006)(6512007)(6506007)(33656002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jZzmZgN7XSFR1Z4X6q8WwViakkPCTUHMDaPoLm9jzQj+WCgQ7cgiI0uYH8ik?=
 =?us-ascii?Q?sY9MlGO45A3dejOrGTDVMzMmi/pKhYdGgVTjeVK77qEN0Ol5PaRwDn5tZyEd?=
 =?us-ascii?Q?oyLWRc8pLg9vZJjQgkZm6t+ndhrv/wBYLug9HZWw+jRbISWRJCoSG0YFL54/?=
 =?us-ascii?Q?8UU+xA25rOe+071/EAsL99JjFCO+RxGp+P3ta64XhgIieDXtONCF+3xpERe9?=
 =?us-ascii?Q?18/LZPqvoa05vnGY1fLTPOUVDMCpg3B/BOnRQ67KsnJvHJInQM6p1B9PoeEA?=
 =?us-ascii?Q?+XgonRtL3UBfwCbY9ku7EJHEhuV9KekTZh2i5NrmLvuD9eYONoKktiNwNMMS?=
 =?us-ascii?Q?8NeVzB4hxquialEzkdk8wa/S5HlLEmoVklAw+3SpouEwchKnmOlbyduUP3JI?=
 =?us-ascii?Q?hWKDpRy1MqP5lQMd010pOBXK7+Q40EnzzDfQOfz/xGQMX4KokbrmC8W3D/bA?=
 =?us-ascii?Q?CIndbuGhkzrUXEje1E2RnGhxgVUMDiNSwP/mrBGBQ/+P0d3hAhI8XHYYU0kN?=
 =?us-ascii?Q?f7La43mUdGOk+Ll3fLDFCbbiUZbKYnPdjIPDNiFQbEcqKDxAIowghVRrDqbM?=
 =?us-ascii?Q?2rwGGOEzm6YSxIcFJjJ0PvwcxRc9ARUZC2qS/yV0NdYVzZPlHZUo0yRrSJzr?=
 =?us-ascii?Q?+X9LSWS2hU7lsOeeyv+C344xVOqyW4XcWsBuBtex58UCwDYiLgFP58/a/kQL?=
 =?us-ascii?Q?20YUiywOgqIjTsbjG/MPP1PeiQoImEsx+dAqV16ornBQaXliJHrzpCLU5IGE?=
 =?us-ascii?Q?KJry2kKC1OdrP72COZMPSnzmO13Vy5pbxLLK4Rfc5eWGdrzgqLDRtnKi1H5x?=
 =?us-ascii?Q?gtmIvz5+ey7lZAhs4Zl+ygNb+JzXzrmqLEY9xZHhvcToOSf15/SdTxcA87b8?=
 =?us-ascii?Q?5WuDxI0BFiKMxY9CwDM+LhNGaZsNNTR7WWN7QIgSrN0qP6+UX5AkqpjGWZh9?=
 =?us-ascii?Q?G8Il4FCUl0Ci873JnsE3nqpvjHRMD+SWfiwHaq/RRGzyiTcaDITR1JAwGNGr?=
 =?us-ascii?Q?9q6gjeSPJAYDV5n+yTCiH3VNV3KukvpNRyElCj0QLKaCZwASIx+UBvE0KrhV?=
 =?us-ascii?Q?yGhZqGx/jIEwTEQt+7DtBEsZ2VN5DZxXqLPF/2q5iv4rTbNx5DVOlbnV3lCh?=
 =?us-ascii?Q?aoPfiE0sXIekiVXv2KaO1nI/VeGogeXKqsYVEVwVrdIFFdXJCFhl6lcLpbIV?=
 =?us-ascii?Q?oqo1HLHmpw4nmboj5IQY4Ra7lbhZ+2Z/qt/BOCI4RpwcgyILzgcFKHUwc3aO?=
 =?us-ascii?Q?BujkkGcbnrb6OmW8xVsnv31+UvcKkCAsBSZM2zTU1+sfBNfIhSgImebcIhey?=
 =?us-ascii?Q?V9+yskbqxMQwqGKmKj0DtV37Ftjq9x7wFApXnaOL0eXFVB2U4hbzLUnOcU4I?=
 =?us-ascii?Q?hWDhUepKomHb0ldyAediFBbNlWlhg3JNMmE+SJ11i4xe6KA03UxQfrbYFo1/?=
 =?us-ascii?Q?wlRqPitz0G7kfrOWnJJ2ZLG4MeqXIlNbR4Ee9VnHOo/4R//IIsddArJMmhwA?=
 =?us-ascii?Q?bDbyagiketYxafPFtCxxsxY+vr58KTDsrLZk4QUWTEoZTiaa89/NwzEBGxA+?=
 =?us-ascii?Q?B+8L7HPvlAFOfJCDhPrZV+ZUoXEmj87N5z/+albY?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1538DFED908F2E4699C3350A031E93D6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91da9525-4d2a-473a-fedf-08dbcf5d5da9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 22:06:51.2810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oWYg4UthisK5ysStkifSZ15nN13PvAXhtTPGxCfdpMNQDvVdUXHCK7evdA2QT7olUH6AxZF1PZc4njqsfFkODg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR05MB9761
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 18, 2023, at 12:53 AM, Linus Torvalds <torvalds@linux-foundation.o=
rg> wrote:
>=20
>=20
> but none of this should even matter, because by the time we actually
> *schedule* that thread, we'll set active_mm to the right thing.
>=20
> Can anybody see what's up?

Could it be related to exec_mmap() -> exec_mm_release() -> mm_release() -> =
deactivate_mm() ?

#define deactivate_mm(tsk, mm)                  \
do {                                            \
        if (!tsk->vfork_done)                   \
                shstk_free(tsk);                \
        load_gs_index(0);                       \
        loadsegment(fs, 0);                     \
} while (0)

We change gs_index(), so perhaps it affects later GS reads. There is also t=
his
X86_BUG_NULL_SEG. Need to dive deeper; just initial thoughts though (i.e., =
I might be
completely off).

