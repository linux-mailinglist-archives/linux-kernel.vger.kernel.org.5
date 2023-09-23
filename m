Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6EC7ABC9B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 02:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjIWAQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 20:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjIWAQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 20:16:30 -0400
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2109.outbound.protection.outlook.com [40.107.121.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24976136;
        Fri, 22 Sep 2023 17:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYCuaa334oUPY3X20/novqLzWcRdog9k8WIFBZKG3IjR/mCjFV6zX3RVMl5keqoMgHRatU/wxMQiZgx3cJDrI3gOAEl5e6ji7k9orxrdtme748sa6rpuEHaz6TFcdTjblKCIo/BoU2Wvt+IXZaEukVeZK8kWsQHzw4IKAJtLuBGuhxed2kVnoqnwWKbLk2XwuWywt4jiwQm4RvucrU24Dbk+fk74Yf9sZRu+A0tsGcUsnfC5+HbpA1tPTI3J9rL8lF/kGiP0JH27oi/D++g0cZTTddyVQsfg7UKvI8DMr3SSORfLPAj2B6mH8Ku1pgMu0CAUwuN9gIvV8kkE/IjlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZKgbhtk3IzghVwYsYUz+eucFoFGCdKh5iFTrbrhbU0=;
 b=U/uenD0Mssz7c5MFuVYmYUBtRwwpubzXFrOdAeMQPUGeWynEiUfb4jy+8+fIc8lVqynfPq0Cy/xGqXvX7YiIZLsA9tC/otT7u21vmmSqQXArDlnOAr4m5RO47T85TlV66Ox6Nhmoq6llK6rG1lEPLEVcz1rh6t/TxfCL0Yo9dlsc0ncP7SWJlu8sKZHT9VVOo8Vvq6Z/csSdthIW7iZY20IwN3U7i7LWc0XK5JPgLxojKTxERl8bvkD2biha+anNHoh5OggQwkJJ6oahdE2Z4vql7d73K6D6KR02xtnxFqJTJb/kkf9p96628DCTaFdM3ORh8cMPPrVnHCTzo//ovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZKgbhtk3IzghVwYsYUz+eucFoFGCdKh5iFTrbrhbU0=;
 b=sLbRHmFyHbr+iLUh5fdYFV4NQdAl7GOFW+n2qLyCd6lbxinbf952JdJV/UpeBvm8oDWzUBC+A3UyH3Ty5NVunzDK0XlsOnEX0qUG/MsDqK5weyS2f2XnzMuEGSlPwe3KFEJprDkFMkSrpFPMPs2X+UzSsHUe/M28GAX2lcsMU+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6861.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 00:16:21 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::7965:8756:9ad5:df1d%6]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 00:16:21 +0000
Date:   Sat, 23 Sep 2023 08:16:04 +0800
From:   Gary Guo <gary@garyguo.net>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Message-ID: <20230923081604.6e2de521@gary-lowrisc-laptop>
In-Reply-To: <CAH5fLgj_wQtmW4A6-4wPeP-Qmk2ga2NoVRwZDujjYvHWY7Bk3A@mail.gmail.com>
References: <20230921213440.202017-1-wedsonaf@gmail.com>
        <20230921213440.202017-3-wedsonaf@gmail.com>
        <CAH5fLgj_wQtmW4A6-4wPeP-Qmk2ga2NoVRwZDujjYvHWY7Bk3A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TYCPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bdbca71-8fb1-4612-98aa-08dbbbca506d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSZ3miYc9yRhAsVNa/mpSMtvQp3E+dLZ8bovZqoPeTyoP1ba+MWMo2wDfdf2RGrdgQ8I8FXiRtA5hPQygWzPAoFpKTKMzQCuHq+N++BachHhs5ePgXtgNCd7Cl9NDirAT47VefmmAxVa0tclcwOV0v1ncNLDN5YHHRDC3kewCVGSe8BKdiUcZsSBIWAg5xJcTYg9vMPD/7OGDJdGzzQ4Gc8V5H8IYYMIPtM9ZgaiIMTqEYfS7JnXLPSqKMmpZqRPbp2fz4zGZZHHL/ZMnR+eBN9ZGKRlfV8sHZ7vVO7uFydE0MGA4JdxXVFahHBjANSMVLZj9QAUmOyX5MePrkUhwUXquwLRuXkfVvVkqU/5g82iGCaWw8c5Fh0+a8ZeIDHaQPpjIjXYtc5M4XVDCXcvzn95FiNuSLtuMyp2jfEjmks4T1a0vXovcE6VD/srUyNxk+ET5gBfGFZO+GfiDWRdKHcEj6ujduroeDFDgfRjMhtXIbVMKT19UIcxfL2ico7lw9PSfeH2z4Zzdo5Z+guf3eadY6asapN+ZQ1iBTi/e6Lu8XHgrJpiu47IZ5ZGYGBfzs/lXK2VVTB1A9HUU/346LCPfkEQ5QJcjz56+peqkP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(396003)(376002)(346002)(136003)(366004)(186009)(1800799009)(451199024)(1076003)(6486002)(53546011)(45080400002)(6506007)(6666004)(478600001)(9686003)(26005)(41300700001)(6512007)(2906002)(7416002)(33716001)(5660300002)(316002)(6916009)(54906003)(66476007)(66556008)(4326008)(66946007)(8676002)(8936002)(86362001)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3BiQXhVMm8wcEIzWGFrT255bDJpaW9XNGt1OUxKQk9vVTlxa1NkK0phWXJx?=
 =?utf-8?B?UTJXK1QvTkN5WEExQmpDek5rOHlVSzhKVnFnbjFHZWlNRFdaMW1BN05sb1Jy?=
 =?utf-8?B?ak9hSnNQQ1N4ajZxdTV3cDVsa2pyL1hBRURlSm51T3g0M1pBNlQxdjlEYit3?=
 =?utf-8?B?QkZ4Y1NqNnpBSUdKU2lGWGladERSZml2WlRxdFVQcGtmZityQ29rZjNNWTFG?=
 =?utf-8?B?RGhPQzYvejV4RURZM0M5cDJLY0hNaEJZaUFRSGNnRzVGSk50dE5QanBJOUdw?=
 =?utf-8?B?ditqdkord1BPcEZFYlRGdEcyRHZ2ZURCMURaQmZwLzZLcVhmWEVWTUtsSis0?=
 =?utf-8?B?QTRWcTBFQS9QQ3BJdlFIWDRaRHdZaXdOb0RxNXpmL0RKRjdxcFBwR0R5M2Yx?=
 =?utf-8?B?T29yMTdvMi9HcUtWVGhueWZtQzlib0dGdVdVaWZic2lSV1F6V0Y2S2Z0SkVC?=
 =?utf-8?B?WWdTeGZQOXcrbkM3WnhXK1R4S0hDZjJkc3Bsc0NCcGRDL1BCU2pTb2YzUFl1?=
 =?utf-8?B?Q2NlMU9ncFJSQjZxSnBYaVE5N2dsaFRuRDdNRGtXWGtOdU94ZGpna09ZRzRq?=
 =?utf-8?B?dHFYUXFLalhNbHVpQ2Z2RkxBazFrbGNsRXp6aFZiWFlWS2xnaXJCNGZhOEt3?=
 =?utf-8?B?MWxOQXhoUEFHTnFSUlRMUVE4WWU1SGtja0FMbTllMUJtem1vdmJiclRnalhE?=
 =?utf-8?B?Vmh0VG1ndUFGUE8rcHBMUFRjSUYxM016MnJGZ1c0a0xFL2pwVWpMNVBCZ0xv?=
 =?utf-8?B?TVVBU0dLaXc3a3lZakNCRndJR2x6QlRzdXhEdWkvRUt6WjMzWlU2TXprWFZv?=
 =?utf-8?B?YldybDVIRjR1M2JyMWtrYzFIZEpFdDNTcWVYeWR0UTQwb1BHeEJTSEJNNmFP?=
 =?utf-8?B?RDdsczRZYm9GZENLbGphNXhpLzZIeUMxMDF0ZnZ1eW53MjVwak9nTjBmODFP?=
 =?utf-8?B?bFVQMGJCRGxFNW9YbUpiVXhlTzh5UHdMbzdYK09oUFRnSjVqRHFwSy9sK2Yx?=
 =?utf-8?B?U0Y2OGRFcVFHMGlPNlA2UXpLcVNPeVluOVhJMTFvTTdJQUhjVGZaVXk4YkxH?=
 =?utf-8?B?RXE4WXNhZXBwc1FkTmNMclBWSTZlRjczMEdEWTEvVTVYNTlzU1ZSTExocU16?=
 =?utf-8?B?cTU2RU1xVEVJaGo1Y3BhbjljUGsySStCTjdFVURDbVNzQ0dVajZzeC9FTllr?=
 =?utf-8?B?ZzROSWRBZzE0NVUvTlh3QVRQbEdSbVltS0lvQmMzZlMvd2dKQ1BTZ1lFa2RD?=
 =?utf-8?B?UHBFTW1VamI4bHZpMlZtNHNiUkxnbFBzSG1nZ1Q0RTMwN3lyRU9LWHo0blNy?=
 =?utf-8?B?ZThIckZOVFkrQ0plWHFmWWlNNWg4MmNJV1BBcWp1OVhZL1hUVzN0NEU0UkxZ?=
 =?utf-8?B?cm1LRlIxZ3JVMWdoR0hxUWlGb3BldXZIVm1jdlE2WU9FcVR5NVJYQTNyMUE4?=
 =?utf-8?B?TTBYVUc0bFFUbzF5cmErM1JPRnNyNHpTTVl1VFR0bzFhZlV3VzlaUCt6NVdH?=
 =?utf-8?B?RDEzdndabHFEUTVMMmN0ZFJ6ajdvQlc0TzR2K0lIM2Z0TlpldXQwR3JPWHZJ?=
 =?utf-8?B?WENhcUJtdEdvZ1M1UzJPNzRFTnZLNnBzR1NhV3BuUm1mN2V2TmtqczhuQnNT?=
 =?utf-8?B?VUphL2NrNEFJa2NQOTJPK2NyQWZxZk9tSUZsVFQxWlFEQUFPa3QrY0ppbHRa?=
 =?utf-8?B?dkxKaURqaWFmQlVrTGRCVnFpOUFhemdwd1VmWVdDWXM1RGcyNUV3NFQzQVFa?=
 =?utf-8?B?TDZiZkFNb21WWFJCRW9TdC9za21CelFWbW4zT1RjWndCVmVLcU1sQnhaNUNW?=
 =?utf-8?B?cC9HWjY2SkRZek9CTkxJUUtBU2o0RHExN1hmMVRtZEc1UkVrbEZVdUR5bUZi?=
 =?utf-8?B?RVdiVVgvWjZmbHhwQ0hsVFk5ZTUxWjNIKy90NFdnNU5LaTR4V0lkbmFqbEZN?=
 =?utf-8?B?eDlJamlBWS9Hc3FpUjlCTVJVSkR5TEt0RW83dnJoWENyYVpqd1I3RTJuendx?=
 =?utf-8?B?Z0F3ZTBQOGEzUFRWT2g1UFBYczBqcHUxU21XdDJ0bUU2a1BiTnZqTEdEOHpO?=
 =?utf-8?B?TUxIQ2VjK21JV2NLZTdobHVFMmw5VjVnUmc2bDd0bU9SUThZOE1GRngxVGZs?=
 =?utf-8?Q?JbTJXts3PQ+EM1UC5IFCF5GM6?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdbca71-8fb1-4612-98aa-08dbbbca506d
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 00:16:21.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mONA7g61Y2eYYj2MYCo8IwWXH1xmcPugvBUkXBzTn0rshYk0ZyjZoSMLDKEmhPZsJ81Zhken2Qy6zrhtG5eRxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6861
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 17:29:58 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Thu, Sep 21, 2023 at 11:35=E2=80=AFPM Wedson Almeida Filho
> <wedsonaf@gmail.com> wrote:
> >
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > With GATs, we don't need a separate type to represent a borrowed object
> > with a refcount, we can just use Rust's regular shared borrowing. In
> > this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
> >
> > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com> =20
>=20
> I wonder whether "WithArc" is a better name? After all, arc is short
> for "atomic refcount".
> I also think it's nice to include Arc in the name of the type.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Or just call it with `WithRc` -- we don't use `aloc::rc::Rc` in the
kernel so there's no need to emphasis that this one is atomic :)

I personally think the `WithRef` name is fine, we have a smart pointer
called `ARef` after all :)

Best,
Gary
