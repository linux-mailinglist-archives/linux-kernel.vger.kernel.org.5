Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C662E7D740E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjJYTO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYTO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:14:57 -0400
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2115.outbound.protection.outlook.com [40.107.121.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E3BB;
        Wed, 25 Oct 2023 12:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAWXF5YT7mfGVMF8heZKd+h+S8XuOjAs9qurUWn+lM1y5PWgeJWQ59FH7h2bGakLuR4BvLJylEEr/pfHU0ji/8TQYqekl6YX13EORP206HYPQKBZHqxj1kcaVS5cKcGGQrUEo8ND+jKtdpFL5m1v/Q2PRUjulSt3N4h1/50JNVHOW42v9TNc4YzzqD14LmwpVOoOWDt8RHttGNTxG2WEcQloBOWTFRBQQyMureql2iYDhHGpNIE/9iS0ncov6EDrT0xQgf4Pw7YQMpTvX6laDO0FcN1g/Lj4sfYaLrroRpBvUH3by0ji08byyYkdTH4YmGN9jeP5LoANQNdSJojDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXwU5DhO1jxWiorA6NUDVhGKvWjOznN+Lbnhm7FJViA=;
 b=PkRCp4X5ZWNguqlCfj6SL4T1DWpJWkrfjxjdxKgwgHFiJLVFpeO0qXmQ1ae6qh13cpDCbpy8HYfNbJKtWjVjKZTNpiQ+2EbkuvW7p5+weXm6JbCEZFT8259KiJKMGn1WmqIu/+m/AnqWewRqnRIeDTzy0tH37YMgNF2nY7nNOgSSD0E6HDvd2Nd0JLroF1UgcGpd97JwwsxVilekSIeRzyzeoWdTRxzqXUVE+iPiyIPyJJ1AsCWK7hxV1ds/qGNE2Dve1LDyCpt4vQ2JyJzbhTwz9OkdDA2s9lYeS4BZS06xaII/udqm7NoEM+wfDfxKfkrJlQPpjUrQJUJ+/2yPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXwU5DhO1jxWiorA6NUDVhGKvWjOznN+Lbnhm7FJViA=;
 b=OyDcK6MyFvtGYqr3J0BALMHR2hIi9tlQ7YmvWEJXsAPv+lAljtbqklEysf5JgtRnRbGJWuds3mbWUqqAb9CYMAivmDvYt3UkvmMooufiuMqZfxWe10mUVXCIWhJXjRYe8QhCY0dQ39E2fnXR7raUtxURyPffP4wPwy+1MmBGfZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB1990.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:7a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 19:14:52 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6331:81d5:43cc:a9a2]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6331:81d5:43cc:a9a2%6]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 19:14:52 +0000
Date:   Wed, 25 Oct 2023 20:14:45 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: macros: improve `#[vtable]` documentation
Message-ID: <20231025201445.497f6ef4.gary@garyguo.net>
In-Reply-To: <5c8b516d-323e-4a0b-8b8a-c0f0aec38b06@proton.me>
References: <20231019171540.259173-1-benno.lossin@proton.me>
        <20231024122423.383ea1bb@eugeo>
        <5c8b516d-323e-4a0b-8b8a-c0f0aec38b06@proton.me>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB1990:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa8031d-8fee-4dfe-c47a-08dbd58eaa28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hd3XZ5btX7dGoEbiaTLmxYf/3w2M/QvG4aUPbw5cxhHCpXx2XMQu6avazGw9JxIK9BhazejVJO5r1NJwE2Kh5vD/ClFKfdYOn9skt+iMY4hYeIAdNTDVCkQbXLE0Jg1LHAxpkD0BWuVQaXkkh0Hk2Yw21mpSp+tBTa8zlir055e32tfbbIt/65JX9ShLVYb8yYB9jkw/YQyswEo44cl97UdECPk6DuEZs220oi4TP5y797L/RgiMKyMtvaRDKv2k0fgtZVEj9MKuECpHsIf25bQHZcRhuSCmaVfc38P7BaWS6Vr0z0PnjRwWZMLwEXHdY1oNc+QNrIbMhBNxEtuQ+MBRPYb1SH1l7XWq+At821OpAeiUS13ZEfm31idzhjE669eFdTHBgPODp5z6Vq//qLz2wInibNeJPJZBjf5hNo15RWJ1x8940QvyVKSSWW7LueQposcgXzFf+hstpTQwxYb6c/GXgbv2nAsinlYcpjCmWsW+YP5TvZV+pJ1iAkDxdRYsam5QKke8kLFvk79W0FaEOqvzMEMypj5xVx2EypFo9Q88dVJNjGwNVz6yMQTV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(396003)(366004)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6666004)(66556008)(66946007)(66476007)(316002)(54906003)(6916009)(38100700002)(478600001)(6486002)(86362001)(41300700001)(8936002)(8676002)(4326008)(6512007)(53546011)(6506007)(5660300002)(36756003)(7416002)(2616005)(1076003)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ds5sek4FYxUC+MqBF/MA1Mzz7Lp6v8PWp9jSVlibBOPPEEDMIx1mgTvKTUPo?=
 =?us-ascii?Q?RWVTQmnsnJ4LRa7foU5drHffPZt54l32RjPUiqw51B4EwyInzuOuLY0S+GSJ?=
 =?us-ascii?Q?qYDZETzcW6rPHFDwxypkg1Fg3MtG+Z2yiBdC9c8l8g0szZgKi3tXwwYdHTG8?=
 =?us-ascii?Q?B6IvIHM+60M0EpXBWO3OsAvX6ZtMu76H0qN3ZXfps039cYRXjTcc3xwuiz45?=
 =?us-ascii?Q?nZAaPgoZucuH/I9Hha64oeJFVAETOe/L5cd835r6YuXdTGWjvkrH09BRhHDn?=
 =?us-ascii?Q?dr5DSrcuV1B+XNAy3CXATIPqvSypPSLGoHKCeBg4ASToXh5bUSrvkH4kNvqb?=
 =?us-ascii?Q?lTeePndYhtIVCKTQcxzgwLZ3KVj2BH7X86jfw1S6NxyNOr5+Q8eq2kSqX9eJ?=
 =?us-ascii?Q?LWpbLPsNrYpbUl9/5UZSO+lf/vk8N5q4SjTU+A+Si+JaA8Yzs/pJ0PCe+paN?=
 =?us-ascii?Q?KmTkWClsrqQHw7vZ72qQ7DLceogu1fX99hQZUxhzc/gWO9JqLy0EHXvkDOYt?=
 =?us-ascii?Q?7WjjNNOw4hLuXsjaOAMIgLmrxZty33dkk/mXk6HLHL3OjJ0P+FUoHZ8vgGRu?=
 =?us-ascii?Q?rvFDqeBCDKsogJ3axeUlxiknJ/Nx3I5j37IkuSR+sx9vxFUHdsG72M/2aXox?=
 =?us-ascii?Q?r7Yh6RLUIk8HWT+/cKHtwm2aweYJ7CFwmyxWEBbJEVFzc7B7FWl1Ku33rpIw?=
 =?us-ascii?Q?SbRXFlcJU+rEp4C74TJP5Q+ai/71LfFFY3us/NkU9T9yHrEipVPql4V+efzo?=
 =?us-ascii?Q?LYXmmaxQT363j/jndftKCngqgNz/gBB3ch3UZK9qzhsbm5fokZsGdBHHz1Gr?=
 =?us-ascii?Q?B9q3y2stm6eix0OieJ/AkA0sa57XG5MzR0x/U12MuovlSub/tzQfn/b0CU6O?=
 =?us-ascii?Q?UxFiahXwnUXgLeqWMXBLTLnhvNHVsaSOPTg04mSAaH/zMPRloiR0thHAKuHZ?=
 =?us-ascii?Q?yfGZHfYfRX0T+3Mdn7COxwoyWTrer4PXEmowBWGFgc0sNLfiLjGzr0hjZS9a?=
 =?us-ascii?Q?SLwEPjgSZrU0YnwpVVkBaVaeDeOYQ1EnHex7n2U4gI+NRQle98Fc7Mh5Uocr?=
 =?us-ascii?Q?kzLLkcs/egZs9KvAZTCyG7U+Xw6xi5bmbUNrqpIT4nazVZPkIizmqKgIeF1/?=
 =?us-ascii?Q?gjkhKNgz+4MLgGKPJvLLvg2tl1TZa+QX6VFx+hj6h4ZNH5G/B9BerI2un4J4?=
 =?us-ascii?Q?KzojPI98Io5wHFXPP4oabACVas7xbqHptU+vpWBtIhYo9QBwF70RM6oynqqb?=
 =?us-ascii?Q?8GBXl7fribNPe4IzIUYQqtNjrzSn2MXz8u4lFJRDhyU5+Y+3A8iq03i/uSkZ?=
 =?us-ascii?Q?rvisn4Z2/YQ4h7XspGIyg2scOCNMbgDk0cruSX56ckFUUAsYunKVr2m0iHUR?=
 =?us-ascii?Q?gS8UnDvT1yZ3EjIe9X1hRGtI2HieJcZbV7bfmB25Yb3SybPdZPzcfAqEQs2o?=
 =?us-ascii?Q?VmhxoDdXdkUyqNqWut+h/omO9bUBiwGiu9O8VZtHJIbhTUmW+Wzu0ZtJKIyu?=
 =?us-ascii?Q?9UGtaosbBPIZNFUmcTYZ5UW3QO4aKwncXM/epi3EQHT3h20KbWpwqF15Pksx?=
 =?us-ascii?Q?AFX1mvgNafxrkfsNHg5arj6Sg1UCvrFrhYqAAHplM2hNiEhAaARWrH4iRKIQ?=
 =?us-ascii?Q?FGK4OrmLGFvaCeG4XRORRahq3G0HEtT2uSflonM6PEEC?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa8031d-8fee-4dfe-c47a-08dbd58eaa28
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 19:14:52.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7Thb8D/BjJ4RstgRL+wceKGiIpcWJUqTVpW9z0nvmF71+MZH0CUB9eI/k+99MPEMqzNJS5d/g/J3JYwi9IErQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1990
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 14:43:30 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> On 24.10.23 13:24, Gary Guo wrote:
> > On Thu, 19 Oct 2023 17:15:53 +0000
> > Benno Lossin <benno.lossin@proton.me> wrote:  
> 
> [...]
> 
> >> -/// This attribute is intended to close the gap. Traits can be declared and
> >> -/// implemented with the `#[vtable]` attribute, and a `HAS_*` associated constant
> >> -/// will be generated for each method in the trait, indicating if the implementor
> >> -/// has overridden a method.
> >> +/// This attribute closes that gap. A trait can be annotated with the `#[vtable]` attribute.
> >> +/// Implementers of the trait will then also have to annotate the trait with `#[vtable]`. This
> >> +/// attribute generates a `HAS_*` associated constant bool for each method in the trait that is set
> >> +/// to true if the implementer has overridden the associated method.
> >> +///
> >> +/// For a function to be optional, it must have a default implementation. But this default
> >> +/// implementation will never be executed, since these functions are exclusively called from
> >> +/// callbacks from the C side. This is because the vtable will have a `NULL` entry and the C side
> >> +/// will execute the default behavior. Since it is not maintainable to replicate the default
> >> +/// behavior in Rust, the default implementation should be:
> >> +///
> >> +/// ```compile_fail
> >> +/// # use kernel::error::VTABLE_DEFAULT_ERROR;
> >> +/// kernel::build_error(VTABLE_DEFAULT_ERROR)  
> > 
> > Note that `build_error` function is considered impl detail and is
> > hidden.  
> 
> I see, we should mention that in the docs on `build_error`.

Well, it's marked as `#[doc(hidden)]`...

> 
> > This should use the macro version instead:
> > 
> > kernel::build_error!(VTABLE_DEFAULT_ERROR)  
> 
> Is there a reason that it is a macro? Why is it re-exported in the
> kernel crate? The macro could just use `::bulid_error::build_error()`.

The original intention is to allow format strings, but Rust const
panic is not powerful enough to support it at the moment. Macro
allows higher flexibility.

It's re-exported so the macro can reference them (note that downstream
crates can't reference build_error directly). Perhaps I should put it
inside __private_reexport or something instead.
