Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649E77CE053
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjJROqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjJROq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:46:28 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11010000.outbound.protection.outlook.com [52.101.51.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF8794
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8W31yMLU1bjx0ysD9q4qzX9McgEMU9m+3DNNyRNrcEdMzNbJUTs61cL9L1smNmCXEm455ne0YuEXN2U8lvJl/NqNTt1L62UGZex7STz60LgzxzPYXHRItiwLZwy6FS2LounrwRXKEdkS03PEnk9pmsSWr7XGDaAEvk+KxrbP6h6/414AT4sWJ9v9qV9SeyKS7/FekmhbNdXwNTfSHl8kHdJWf2hIkXyuyKm+99A5PYazJgrQe2bXtHgg+6xKt6Tzg8BNv77FMf+z5uHDuGPIhfQKTHnqS8c62kPoJ+IDhp39vvg9rlfOQFYo9YFpYOLa+2Hm3vSzOolf8e4s8EFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEJCE0uhNsbtzZlir/qJppNrdHrgQiBuIZeo/O0lnh4=;
 b=i77uLKvtTySL1KxCdxs4dNiK08Z+kBnWic23gl+5dU5PjEMNF+lgZ8eCT0tZXAQvriF91nO2Lh11bgkObY1RGuHtDg6EmqDgIACsV1Y/KEslEE/Rqoz7pD4h4cTGLq7RjvoC4NMB7vuWm+tFnjMHgjt3kNYWxuaFW378ULEI2v1VwtM/CVCuM8UovNkguWJs7kkEc4xklY18QEk1+Cn5A9ooiEak+dxz1xClA2KNSa4+cuYm2YYWmNHC7jTjolj4dGQF7ZfGe9uVPz54TRfDOKQOoDSNaYDni/0WyFqyUV1GV7S+7qbtReZoX3C32bqrXMO5FpdvzcA3Db7jMKdlCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEJCE0uhNsbtzZlir/qJppNrdHrgQiBuIZeo/O0lnh4=;
 b=fkGqJ5sdVc3FeX2Hr6W8fDr/tLthBFu0AXbbl0G/bj1BLlidnQl9+Co8nxzTRVelIQjPWLzM2yd4679HxxwYStUniATkWGpgZA++PqGXukj1fDxSSanAqCwBmBFLvHUWvPHQzoGoZLmQeYOcdseUYLM1LYLdndBsmX15hmniAL4=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SN7PR05MB9879.namprd05.prod.outlook.com (2603:10b6:806:32e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 14:46:23 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e6fb:726:9aa2:fa13%6]) with mapi id 15.20.6886.039; Wed, 18 Oct 2023
 14:46:23 +0000
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
Thread-Index: AQHZ+5jZGZywpkB5zE2yxvhqDFo/FrBDSECAgAAOE4CAAAQxgIABoxnfgAAgI4CAAAYlgIAHqOMRgAAI04CAADzyiIABTsvzgAADAQCAAB/hAIAADVOAgAClpgCAABXQAIAANUA7gAAQyoCAABlpAA==
Date:   Wed, 18 Oct 2023 14:46:23 +0000
Message-ID: <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com>
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
In-Reply-To: <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SN7PR05MB9879:EE_
x-ms-office365-filtering-correlation-id: 4db653a8-db12-4e30-95be-08dbcfe8ffaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vy9CQAumvL6eQIa/PU1ewNTu1b5ZJPcqYU3DhKbE4WmZg82XzwePmqqQ2iazO5oW9r53XqvkYCCTYITsT14K+As/3WHe9IbfhjxDaAigl/vNwwQEsRRlXRnIeWnfE6G7BB/YtH9KBgn1vdN2PjOKrwD6RWE8muVWANJIaBCB+ZkJuEKpkeRrp2nBGOVOk38lfNptryAZ71cHc1rHMMgbS8w302488HRl6vdy7W+M7e6nCxV8qJPkwtVv+5rLTCNbp0mVzSBp76As7fN1gMb/WGY2GamRuw15Gb5GBLirw8dMX8u7ovj2fry3XUUt8A6iJ7eG6CIaH/6b66/S+KSTgmDwZWRZXva0O1H3f7JF/hZgG7WF1Wo8STfrO5VsaN+eJvVO994Erh+UkBj8TQgjJWqxLIL7G0Ks2PggIh7y/gbPczekxuppR4KBHBrCaG5iimUkKmiHU+0I7ql4QUpxIfnvPHCN7XiZryoNKPAQEj3JWFvZpuZ98/NTQQKMRblKzjXO31oyustdkI6G6gQ4AUQPOjMse0iZ5sIUd9/Q4rk91DpozvmT4Uy5cQAB++u8BYkfvozO1LNxBrtrr1AD6ZuTgmUvg93q3A2ug5tZ8CbFgtMDNeZxssIdmSovtDKieHOjNnfgSH04cY6fxJIfuwufU1quxQAkxEA5g+B0qTtNSCiCgwVNNqtDn9USdacizGjWk0KGT9Y9PdQTGqmiyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6512007)(66556008)(6916009)(66476007)(76116006)(91956017)(478600001)(71200400001)(66446008)(54906003)(6486002)(64756008)(66946007)(86362001)(38100700002)(2616005)(2906002)(6506007)(316002)(53546011)(26005)(41300700001)(36756003)(122000001)(5660300002)(8676002)(7416002)(33656002)(38070700005)(8936002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0dMdjF0VWhEOHdndE1GVXlkUFFxMHhSSFpSbXhrbzV0aVFDdWt6OEJDbjds?=
 =?utf-8?B?djZlc0VTSHhzSmFUZ2JleU5wWi9mVmM5S3djbW1jZnhaSHljQlhCRGpmeUh3?=
 =?utf-8?B?OUNNbC85UFFRcm9CZ3drNitVMWd1a0gxY1RwbWY1bTB4ZkMyaVJwcjRCNmZt?=
 =?utf-8?B?WUJpUi9JVUVPbTgxYzdObkhQMU9EZlFSRWlCOVd0dWFRT2x2bFBYWU9XN0Rr?=
 =?utf-8?B?OTA3aFNtOWR3QzJqdzJYMHJxakhVMzladytNbVJheFZrWkljcGx2SGVBSlRF?=
 =?utf-8?B?M2J1K0dYRWw0dVdxN3JDZUhhenNDcTk3NlhCR3dlelgrNjd0MnVqcVlXQXUz?=
 =?utf-8?B?K3VpVW5KSjRPOHNvRUJrZktZelNwNzJabHUyU0lMdjh2V3BHRmF4TVhXbzFJ?=
 =?utf-8?B?dHRhZEZUNWtzOE45TDZnaGRXUS9PRzBOQjBDZC9wcXhZRjhHS2JrR3ZKajR0?=
 =?utf-8?B?NnNSSzJEayszTldCQlRVMFNJZEEzTXNDZW4wNytTVHRVbi82endFQjluVk85?=
 =?utf-8?B?Rk9kcjlvZ0JKOVBLNTE1ZjRBSC9CbGVlRGxwV0pzU1BuWENqUWhDR1E0a0pL?=
 =?utf-8?B?ZXNFL296d3lNOUQ4VCsvZ2xQU0Qya21uMllmWXYxTW8yMEdOWmNLamZ5NTJp?=
 =?utf-8?B?MWwxZ2Y2YWkwVVlCb2lIWUtZcXFrMG1MWW0wczBRSS9tQWRRR2doelRLNHBx?=
 =?utf-8?B?d1dseWVsSzVPQllxWmkvSzRSVmpLZEFNRkdIVVFUN1dQS3FLSHFuYnVZQkx5?=
 =?utf-8?B?NlVMSXBEQXhaWnFtTWd2OVJSWWtYWkwrMXJPb1Q4MjBaRnliWEFaK1JNK05O?=
 =?utf-8?B?QkpMYzU3bGpra1d0MFVFYmMxdDJHSjlyQ1NqY0J0YTNtQWpYTm92a21vRkc5?=
 =?utf-8?B?ZXJJSWRNWG94ZTdDQzZVc09XQWZ6WEFlaGMzMHBuK3JGODk1c01QMy9MeVlm?=
 =?utf-8?B?NHFZcTcxY2RWR1J6VUlFYmFsOEc1eWJrVmE0YUQ0Z3dQNTd3cnA3ekNieTJD?=
 =?utf-8?B?VVlqWXhic2sxbUpGTHpjMEpZSFRDQ1huUmU2eVhVTW84YTNtQXp4RU82SW4w?=
 =?utf-8?B?czVQMEpUN0lId1lhNFJ6RFNWVU9OclFCSkl5S1cvd0YwOC9mcFdHaHhQR01M?=
 =?utf-8?B?MEx3dFFybUNSSlMvcm9yS3dOaGZwRnozWXNZMitwWjJMOVNyd2tvMXlIQ2lH?=
 =?utf-8?B?OWhPejVaTnJQSFNQbUJ2MEQ1VktsMVFRZVFIalUzN0F6bzROTVkxUW5Ha3Vt?=
 =?utf-8?B?bXNPM2xrdmJnLzRHU2dBUzhRNHlPUTBaV3VrNjFUNm0wQWlNU1VxNG4rWUho?=
 =?utf-8?B?bExMS1Z6S3V5R0c5M2xiWnRZSldRbkE0Ry9Fc3NPa2FqSE1jbnVYdDUyZlMx?=
 =?utf-8?B?ZXJIZ2xycUhLOWd1SDZRSFVac1BOT21uWnFWeW1CbzliYmRWeThvRm5RKy9m?=
 =?utf-8?B?TUlnZ3VtSHkvRGQvdXEyOEpHc1MwVk1LNUVHVTNkdytZNDh0VDJXQ1NDMDBP?=
 =?utf-8?B?R3dORG9rc0lMNkRZRVdRVXRZUTlRNXJXUjZRa0pMOGJxbkE5RTdnSmYwYUFM?=
 =?utf-8?B?MW9pSi9vUE84bWxqQjhud29SREVLYWhUMm5xbEptWkMxWkorSEo5UEN6dWlj?=
 =?utf-8?B?UXZkY2JBRURVSjhZWDBkeXZld2JKd0FubjlhZG9FMXlpUXNFZVovcHVCZytZ?=
 =?utf-8?B?Zjd1R0Z0aVdSOGdIeDBla2YyK2pUYTJyWGZ4TXV0ZGtja2U2ZTEva0duMFR2?=
 =?utf-8?B?ckwrbHY5QWVZV2ZuU3o2ZUlYYUtxTi9zZGZDQkRUVFpmT05ydFcvUWoxNzN1?=
 =?utf-8?B?VVM4K2tnMjVBOFlBQ2ZFVm83N0xJcm40c200d0VXRXVuU2RZNEQyaFc2WlJ4?=
 =?utf-8?B?NE95TmJ0cDdmSDN6bGxtVjNnU0VsUnk2OXlUVWpsZTM0a3ErVFlrRk9UWU1t?=
 =?utf-8?B?NHgxTFhxeDBRMjZMUHBqbUlDdTJPMHZXVUdpd3lhYkxENTZIRG9ZV3F0eXk1?=
 =?utf-8?B?MHB1eXBNT003VklEenI4NWZBRUlOME43U3pJY09STVBYcUp0Zzg2N2E4cGVy?=
 =?utf-8?B?ditXZnkyK21Zakl2SGw2OWZSMS9iRjFvdVZuWTdPQWZMS2hOaHFFRGxhVHAv?=
 =?utf-8?Q?BvIVp81ibSY0Z1zAGWLEkPkyf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9C5CD648EC73146A8B5C1C7CC0498DE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db653a8-db12-4e30-95be-08dbcfe8ffaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 14:46:23.1181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGSJKuRWbGzO2EVI1p1FMI5D7hNijf4OXWXYHHCTuDal0H2o9DnUQKxHA0QzxA3TRlWTJ4qBEjvPOTSqzbL08A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB9879
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE9jdCAxOCwgMjAyMywgYXQgNDoxNSBQTSwgVXJvcyBCaXpqYWsgPHViaXpqYWtAZ21h
aWwuY29tPiB3cm90ZToNCj4gDQo+PiANCj4+IExvb2tzIGxpa2UgYW5vdGhlciBjYXNlIG9mIHVu
ZGVyc3BlY2lmaWVkIGZ1bmN0aW9uYWxpdHkgd2hlcmUgYm90aA0KPj4gY29tcGlsZXJzIGRpZmZl
ci4gTHVja2lseSwgYm90aCBEVFJUIHdoZW4gYWxpYXNlcyBhcmUgaGlkZGVuIGluDQo+PiBhbm90
aGVyIFRVLg0KPiANCj4gQXR0YWNoZWQgaXMgdGhlIHByb3RvdHlwZSBwYXRjaCB0aGF0IHdvcmtz
IGZvciBtZSAodG9nZXRoZXIgd2l0aA0KPiBMaW51cycgRlBVIHN3aXRjaGluZyBwYXRjaCkuDQoN
CkluIGdlbmVyYWwgbG9va3MgZ29vZC4gU2VlIHNvbWUgbWlub3IgaXNzdWVzIGJlbG93Lg0KDQo+
IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2N1cnJlbnQuaA0KPiArKysgYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9jdXJyZW50LmgNCj4gQEAgLTM2LDEwICszNiwyMyBAQCBzdGF0aWNfYXNzZXJ0
KHNpemVvZihzdHJ1Y3QgcGNwdV9ob3QpID09IDY0KTsNCj4gIA0KPiAgREVDTEFSRV9QRVJfQ1BV
X0FMSUdORUQoc3RydWN0IHBjcHVfaG90LCBwY3B1X2hvdCk7DQo+ICANCj4gKy8qDQo+ICsgKg0K
PiArICovDQoNCk9idmlvdXNseSBzb21lIGZ1cnRoZXIgY29tbWVudHMgdG8gY2xhcmlmeSB3aHkg
c3RydWN0IHBjcHVfaG90IGlzDQpkZWZpbmVkIGluIHBlcmNwdS1ob3QuYyAodGhlIEdDQyBtYW51
YWwgc2F5czogICJJdCBpcyBhbiBlcnJvciBpZg0KdGhlIGFsaWFzIHRhcmdldCBpcyBub3QgZGVm
aW5lZCBpbiB0aGUgc2FtZSB0cmFuc2xhdGlvbiB1bml0IGFzIHRoZQ0KYWxpYXPigJ0gd2hpY2gg
Y2FuIGJlIHVzZWQgYXMgcGFydCBvZiB0aGUgZXhwbGFuYXRpb24uKQ0KDQo+ICtERUNMQVJFX1BF
Ul9DUFVfQUxJR05FRChjb25zdCBzdHJ1Y3QgcGNwdV9ob3QgX19wZXJjcHVfc2VnX292ZXJyaWRl
LA0KPiArCQkJY29uc3RfcGNwdV9ob3QpOw0KPiArDQo+ICsjaWZkZWYgQ09ORklHX1VTRV9YODZf
U0VHX1NVUFBPUlQNCj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgc3RydWN0IHRhc2tfc3RydWN0
ICpnZXRfY3VycmVudCh2b2lkKQ0KPiArew0KPiArCXJldHVybiBjb25zdF9wY3B1X2hvdC5jdXJy
ZW50X3Rhc2s7DQo+ICt9DQo+ICsjZWxzZQ0KPiAgc3RhdGljIF9fYWx3YXlzX2lubGluZSBzdHJ1
Y3QgdGFza19zdHJ1Y3QgKmdldF9jdXJyZW50KHZvaWQpDQo+ICB7DQo+ICAJcmV0dXJuIHRoaXNf
Y3B1X3JlYWRfc3RhYmxlKHBjcHVfaG90LmN1cnJlbnRfdGFzayk7DQo+ICB9DQo+ICsjZW5kaWYN
Cg0KDQpQbGVhc2UgY29uc2lkZXIgdXNpbmcgSVNfRU5BQkxFRCgpIHRvIGF2b2lkIHRoZSBpZmRl
ZuKAmXJ5Lg0KDQpTbyB0aGlzIHdvdWxkIHR1cm4gdG8gYmU6DQoNCnN0YXRpYyBfX2Fsd2F5c19p
bmxpbmUgc3RydWN0IHRhc2tfc3RydWN0ICpnZXRfY3VycmVudCh2b2lkKQ0Kew0KCWlmIChJU19F
TkFCTEVEKENPTkZJR19VU0VfWDg2X1NFR19TVVBQT1JUKSkNCgkJcmV0dXJuIGNvbnN0X3BjcHVf
aG90LmN1cnJlbnRfdGFzazsNCg0KCXJldHVybiB0aGlzX2NwdV9yZWFkX3N0YWJsZShwY3B1X2hv
dC5jdXJyZW50X3Rhc2spOw0KfQ0KDQoNCg==
