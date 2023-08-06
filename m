Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C707D771603
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjHFQIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 12:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjHFQH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 12:07:58 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2120.outbound.protection.outlook.com [40.107.10.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B04E3;
        Sun,  6 Aug 2023 09:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1bc7bLfsZqglj5Eddkkspyc0n7jMPSCGggtJ5iwpgVKZzYxDOxAUW13WrsSdu6d0xPT+F/4rKr0sk1glLd6ilntmSR4lRq31A1ZodvQ0E1Q7VC993WO4CZAEENz3s1vMsr0HnSM0TigvZTg3WE0aN/X/3YBukXtxgszmJNN+B/H3Z8cdHbGkudzDe3s8r8FUaZExbTLv23+IYFxGQezKsmVTmdCdpY3TKBuSex+49s2TzJtxpK/AKpmqb7nwSaJqPQPWQtq4SG3slNA9AdGYv4Q9VKB2f79B+p+2fOoMIdAdFh4lMWd7v0E8o8AVaxiXL4BWXmwQkKZWAKWsZSg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CfCdxKjKNueWAI3q3J0k9NEgS9U53vLu9DsU+tkfew=;
 b=BpS6vusbvwjHgiszi5j0xNQ5e4La/hg+UrgcHg0viRGeArm2AlghwRbvSsrszIIlQ3AqQiL/9mRG+2gaPfrGoz6t84dnEMZAKADzvmPpeneY6hw+EcOcNO4IqM0KZ9CRyswCBDx+CpUcWwqUFK6fnN3NOYR4fNBrlD33fxfptncrm95HfQsaFrBpzYLoaeNruyES0GN4Rk14DjYKNXah0XvmHnLpZxpTn3VpWmkM/LlQ6xFkn+nTPGZoAXhOaYNX4eifDaA3qa66CM4f/lpZzASUDruna2p8rf4ilTmYXYPZQtbLMZKAEojcregK8/QHafNkJccxGLvy3ReNP8LSKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CfCdxKjKNueWAI3q3J0k9NEgS9U53vLu9DsU+tkfew=;
 b=qxJiOnPRGRZhEG6vKSwkkQyKTyT5vFsiUSDN4kGzh/wDdf02T2sV00xCfD1Btt4Py2498Eukz0Lc3EKTkfUIa97C50CP5WXKglbkaLlTbx3d51xnuzIm6nAQi99wqJGg0JBf6lGzH7P5sWHORtuh1azchUVBfcrUgV4X3a3HWuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB2368.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 16:07:53 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 16:07:53 +0000
Date:   Sun, 6 Aug 2023 17:07:51 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 09/13] rust: init: add support for arbitrary paths in
 init macros
Message-ID: <20230806170751.0387f06e.gary@garyguo.net>
In-Reply-To: <20230729090838.225225-10-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
        <20230729090838.225225-10-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0073.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::6) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB2368:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb5f800-da09-4418-3e10-08db96974a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Rgew4rJr5ecNzIy+MycksNs46SqBDfAhDgnLgeuIWynoX/J5nx7D3o1cK0X+ZHsuniL72fQIdbqffxDraKetgRmWox0dxrTu0YpWI6KwifPqWQUaCpZLkaUxLE5nRO3vQp7dExZaWU/c3GB2AR1NcilOSgve3nftFhmFY/Ppgejj926bwuRh+NgwS1KMnvGIebT85qSDQnEHOOAB7Ah2KXnxBEd3XTpL0wMUlRSuDIUoiNMu2XZy359wdOOhj4sDiMCyfEJnTMuYrF3Oat9i6/mXgstDk8Rjpz40JXfeDLv8i3SxzkZv01V4xop1jCOBkfLj0oB9aAG4mZYhqbbYeFwvTTNXPkUf/HhzTskdHqykjrWczUUjYtiju+xbozGvZclryHw6POZVkt5EZ9lD4lNaSqJlqH/FpnyWWSNMibOHWjOMWE4grnoaXoiuB017gEtM23G5Ylzjm9MnVqAQELfsdcguCJdtHY7n1MNzawZOIYvN66vOoXGBRWdgd/tlgG4dYD4GXkSZy2WMGufcqkov+UoEq7Ev79d8HynMzKnIkFTZ39UKmeUswrD33lJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39830400003)(396003)(136003)(1800799003)(186006)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(83380400001)(7416002)(8936002)(8676002)(2616005)(478600001)(6916009)(86362001)(316002)(6506007)(54906003)(38100700002)(6486002)(66476007)(66556008)(66946007)(6512007)(4326008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DM/uz0oCUgR2MkxIC1MKVOia9EksohV07/MhHOogySPLUkcjM3cI6JP4WnhI?=
 =?us-ascii?Q?bF1BDYcD55wTRlLYEjUtb8i9IO07SAIHhD7eqxRXae3+WbNOEvJb5PHOOF2P?=
 =?us-ascii?Q?4wR5p0WKrSLH+0g/YqEIA9kjtUwPdKbFiER6c+kKMm90czcvMNg8YBsrWIm4?=
 =?us-ascii?Q?QrPmKnO8RR7Z5375FVVQdBYt1YzJPnxHeaES6Y8Blw3Ja5Db49jir7nNZM7k?=
 =?us-ascii?Q?1UGnHx6v/SWvWBJ3hgn0O1M2tA76vLB4Cif2r9d0eeHBxkwxf3O5YOjCyfhy?=
 =?us-ascii?Q?xoJ6rZmKUrdWp2ikhrdlURKMGRj7tvNieB08mJrJQ8VN0b1IWtUzsT0v005o?=
 =?us-ascii?Q?Q3kh2d/PPo6aLmXE2V6caBntczv/97iCMhd+7/F0tekCqwHx+uNxyDoh7ZfV?=
 =?us-ascii?Q?wdsDFgI6smooxnEfRu9dt6YnzS3F0kSDsLrZNPn8nVXNIQ+YnjBT4KIhuGL+?=
 =?us-ascii?Q?2Db+AMb3zMzFJj8fJvQC93QU3ON+35mAO2tU7X/k5BbEMpQobWGighwTyzXM?=
 =?us-ascii?Q?QP6dWk2S6iWVO4jQiQ3Vi74tQl5X6u7I73+Q0PiURy3DTtq6CgIiNfBhngIx?=
 =?us-ascii?Q?XZtQEwB921ezJCUf7YTq6KJZ2lIYsCBiD2LnbqXjBZMx3h/saxF/+52d3Wyh?=
 =?us-ascii?Q?uKtTU7jYTFOqgTsxxYvbmUZhBksL10jidmasJCywwudMJSVlwqr0YVTFgcet?=
 =?us-ascii?Q?4twVBUQulLSdHeiy2YwY7wCFFGgb4ja1PbQ+cEm2zQhDdqA3uvxAQyaXt6AU?=
 =?us-ascii?Q?3BKbGVT0wD09nnd1DoAmaEnMgER9Ej8VayriH9HT6Syv+9HrDI5JPTx2Kbsx?=
 =?us-ascii?Q?SP43Xr4HSYbfaw66rkpMMMVhqAvsJiq6fcYPG0E1CoZWMLWIrDAYUhRNT9If?=
 =?us-ascii?Q?I7ptBPUvZy8Pk1gx3xHz/coDyEGNNKdQ3XzWN3tEpdxA4XetTKGrOe4My23A?=
 =?us-ascii?Q?BGlUGOnbvXMNAN1tkfPD6z1y0sSWp9XzD+nu/+09ixY/gX1KyJYBdYmxYcxz?=
 =?us-ascii?Q?pIxYagp220Jr8Np7AcsCht5oIwQDMvE80HrlWCDDwi3UU5+8YA/VTGrDWZtr?=
 =?us-ascii?Q?887H0rRcLUddm585koYX6tjLJcg5EjKlPQdwfnbhPgkHo/ZiM31hiFfsAudx?=
 =?us-ascii?Q?MbmuhSYmZT8wqb2f3Y0VPCVmtP5Fl4wfw8OrpR8phgkMAEfNyE4/xQjcRLfG?=
 =?us-ascii?Q?ZhIpZRpl+6oErAJfBwc+2cOy7jRDTmbisOhQyTJ/nbua4t8RgEoyobpTeWFy?=
 =?us-ascii?Q?K5w88jC+mxqCTtuP/W+f+XgXFVFf5FaXjtn9qUDRhYVV+ZuewSvh0raPDSnl?=
 =?us-ascii?Q?9+v0SksWJuQ4Sx1EzqtT5tjS+wZmvgqedcf87WnpsZsGA/wbcoZ1oiWjai/J?=
 =?us-ascii?Q?y1sG7hfDzywjDagHNL2yJzaQlgy8wh7PfJMyJ0zkvxIGYA6P4TABngh5+yDR?=
 =?us-ascii?Q?0+68x7yMqGLN86Ov/0jmd27+xjb+1KF849NBu+pHNePH56e1ODTbJ4gTj3cK?=
 =?us-ascii?Q?cLAyKgLWtuKP2+Y7ZcuFzWZH9Lvj3s4LXLH+sKGEwFKrIagHR5UZCVjmaKNm?=
 =?us-ascii?Q?Oaxl3QmUOld6WcHT/IwcW3DGmqet6fDck7gmAPjx?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb5f800-da09-4418-3e10-08db96974a62
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 16:07:53.6436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+tEw9g7NmfnuoNv3wXYhtGD0QJhXBQShnspEeOEfRGHgCf71MUmOXXxbRJd4GMXAm6GboMSbJoPH7FAdKq37w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2368
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023 09:10:16 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Previously only `ident` and generic types were supported in the
> `{try_}{pin_}init!` macros. This patch allows arbitrary path fragments,
> so for example `Foo::Bar` but also very complex paths such as
> `<Foo as Baz>::Bar::<0, i32>`.
> 
> Internally this is accomplished by using `path` fragments. Due to some
> peculiar declarative macro limitations, we have to "forget" certain
> additional parsing information in the token trees. This is achieved by
> using the `paste!` proc macro. It does not actually modify the input,
> since no `[< >]` will be present in the input, so it just strips the
> information held by declarative macros. For example, if a declarative
> macro takes `$t:path` as its input, it cannot sensibly propagate this to
> a macro that takes `$($p:tt)*` as its input, since the `$t` token will
> only be considered one `tt` token for the second macro. If we first pipe
> the tokens through `paste!`, then it parses as expected.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v2 -> v3:
> - added Reviewed-by's from Martin and Alice.
> 
> v1 -> v2:
> - use Gary's `paste!` macro instead of `retokenize`,
> - remove the retokenize macro.
> 
>  rust/kernel/init/macros.rs | 54 ++++++++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index 4c86281301d8..d54243cd3c82 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -1000,7 +1000,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
>  macro_rules! __init_internal {
>      (
>          @this($($this:ident)?),
> -        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @typ($t:path),
>          @fields($($fields:tt)*),
>          @error($err:ty),
>          // Either `PinData` or `InitData`, `$use_data` should only be present in the `PinData`
> @@ -1014,7 +1014,7 @@ macro_rules! __init_internal {
>      ) => {
>          $crate::__init_internal!(with_update_parsed:
>              @this($($this)?),
> -            @typ($t $(::<$($generics),*>)? ),
> +            @typ($t),
>              @fields($($fields)*),
>              @error($err),
>              @data($data, $($use_data)?),
> @@ -1025,7 +1025,7 @@ macro_rules! __init_internal {
>      };
>      (
>          @this($($this:ident)?),
> -        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @typ($t:path),
>          @fields($($fields:tt)*),
>          @error($err:ty),
>          // Either `PinData` or `InitData`, `$use_data` should only be present in the `PinData`
> @@ -1039,7 +1039,7 @@ macro_rules! __init_internal {
>      ) => {
>          $crate::__init_internal!(with_update_parsed:
>              @this($($this)?),
> -            @typ($t $(::<$($generics),*>)? ),
> +            @typ($t),
>              @fields($($fields)*),
>              @error($err),
>              @data($data, $($use_data)?),
> @@ -1050,7 +1050,7 @@ macro_rules! __init_internal {
>      };
>      (
>          @this($($this:ident)?),
> -        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @typ($t:path),
>          @fields($($fields:tt)*),
>          @error($err:ty),
>          // Either `PinData` or `InitData`, `$use_data` should only be present in the `PinData`
> @@ -1064,7 +1064,7 @@ macro_rules! __init_internal {
>      ) => {
>          $crate::__init_internal!(
>              @this($($this)?),
> -            @typ($t $(::<$($generics),*>)? ),
> +            @typ($t),
>              @fields($($fields)*),
>              @error($err),
>              @data($data, $($use_data)?),
> @@ -1075,7 +1075,7 @@ macro_rules! __init_internal {
>      };
>      (with_update_parsed:
>          @this($($this:ident)?),
> -        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @typ($t:path),
>          @fields($($fields:tt)*),
>          @error($err:ty),
>          // Either `PinData` or `InitData`, `$use_data` should only be present in the `PinData`
> @@ -1094,7 +1094,11 @@ macro_rules! __init_internal {
>          // Get the data about fields from the supplied type.
>          let data = unsafe {
>              use $crate::init::__internal::$has_data;
> -            $t$(::<$($generics),*>)?::$get_data()
> +            // Here we abuse `paste!` to retokenize `$t`. Declarative macros have some internal
> +            // information that is associated to already parsed fragments, so a path fragment
> +            // cannot be used in this position. Doing the retokenization results in valid rust
> +            // code.
> +            ::kernel::macros::paste!($t::$get_data())
>          };
>          // Ensure that `data` really is of type `$data` and help with type inference:
>          let init = $crate::init::__internal::$data::make_closure::<_, __InitOk, $err>(
> @@ -1253,7 +1257,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
>      };
>      (make_initializer:
>          @slot($slot:ident),
> -        @type_name($t:ident),
> +        @type_name($t:path),
>          @munch_fields(..Zeroable::zeroed() $(,)?),
>          @acc($($acc:tt)*),
>      ) => {
> @@ -1270,15 +1274,21 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
>              // not get executed, so it has no effect.
>              ::core::ptr::write($slot, zeroed);
>              zeroed = ::core::mem::zeroed();
> -            ::core::ptr::write($slot, $t {
> -                $($acc)*
> -                ..zeroed
> -            });
> +            // Here we abuse `paste!` to retokenize `$t`. Declarative macros have some internal
> +            // information that is associated to already parsed fragments, so a path fragment
> +            // cannot be used in this position. Doing the retokenization results in valid rust
> +            // code.
> +            ::kernel::macros::paste!(
> +                ::core::ptr::write($slot, $t {
> +                    $($acc)*
> +                    ..zeroed
> +                });
> +            );
>          }
>      };
>      (make_initializer:
>          @slot($slot:ident),
> -        @type_name($t:ident),
> +        @type_name($t:path),
>          @munch_fields($(,)?),
>          @acc($($acc:tt)*),
>      ) => {
> @@ -1286,14 +1296,20 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
>          // Since we are in the closure that is never called, this will never get executed.
>          // We abuse `slot` to get the correct type inference here:
>          unsafe {
> -            ::core::ptr::write($slot, $t {
> -                $($acc)*
> -            });
> +            // Here we abuse `paste!` to retokenize `$t`. Declarative macros have some internal
> +            // information that is associated to already parsed fragments, so a path fragment
> +            // cannot be used in this position. Doing the retokenization results in valid rust
> +            // code.
> +            ::kernel::macros::paste!(
> +                ::core::ptr::write($slot, $t {
> +                    $($acc)*
> +                });
> +            );
>          }
>      };
>      (make_initializer:
>          @slot($slot:ident),
> -        @type_name($t:ident),
> +        @type_name($t:path),
>          @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
>          @acc($($acc:tt)*),
>      ) => {
> @@ -1306,7 +1322,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
>      };
>      (make_initializer:
>          @slot($slot:ident),
> -        @type_name($t:ident),
> +        @type_name($t:path),
>          @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
>          @acc($($acc:tt)*),
>      ) => {

