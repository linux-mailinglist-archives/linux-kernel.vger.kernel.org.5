Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5177E7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345268AbjHPRlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345261AbjHPRlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:41:04 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2094.outbound.protection.outlook.com [40.107.11.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9217F270D;
        Wed, 16 Aug 2023 10:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVsRBpXbpth8gqkg0dWTqP8PhvUvPYEMXSpJeehfQ6iT1szNtTOH1Gi1ugmV4VwiMZ7mSUkOSLPDQv0MnUDayPQTxiOofyvimx7JwEs09+Zl8aSXEPdcLoNrNCcdkDVrQXLXH7zsRCwRaP7oaAl9/CWooLJNvytOeB6dewN5J6+uSGBhmX0ohULQh3c4bH6EXT5FQwKWoMgsNwzQx7yxcCmSwkdyMK6TpUyAH8Z8EKdKkFduCtEQ0BxYESp76EK1RGb1ZwuWvryn6PimNQ0A7jVQhCvDZ8Zi/O28SIzBltTAmjwoBd58TmSbqsvtZrOuOgMqMyw6lPXeSKIPy6j1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZ9G26NqQoceFpaXIYrc74TwM4e/bj4fgeUFVHtnuXg=;
 b=BndcF9ruVGmkyOo0FjiL9liFQvCPIJLwnLopewu5IuFdrPMvGAy6J2bwl+1sIrYQBKzeQxjzxqpvQAz8nlQxGHnC0eLr5yY+/4X8ztptQFEM0x0Kb0LPqZql24IWKbkGfSxxiHdOWbiEP0tsR6JM+q8ITmVGtWOfkttWaoqm56J/g5TCrWTXq80pbRCNPrPi4zt96OEsELMqQiQaiAbMwcO5t982Mw0+6mX7YT3veScsuVcamj9OsfcJs5FjotpD+DRNPwwq/8ifxt5vU5YBYRS77g8ZbGQ7t7zgaIdoFQYhrtIFnk+Ij+o4n+0q4JoG6f9NfxVOmzUnR8AdgeMJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZ9G26NqQoceFpaXIYrc74TwM4e/bj4fgeUFVHtnuXg=;
 b=eJPSb+osb6o4rUlVsI1JfDG/XYDopWQkvLUNXUSuzKyWC0iAF3HLNhMYy9/ZviERiJ0YpWGqBXSA0T58tWXXfKWwqALL8Fw99DTHgJcjO6fnegjfzfI5FlTAriWkLHvxGibXNFuTOXjrwL3ERh24g7znyn0PYYWFQpfzqjIHlD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5275.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:190::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 17:40:59 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 17:40:59 +0000
Date:   Wed, 16 Aug 2023 18:40:55 +0100
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
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH v4 03/13] rust: add derive macro for `Zeroable`
Message-ID: <20230816184055.400b067d.gary@garyguo.net>
In-Reply-To: <20230814084602.25699-4-benno.lossin@proton.me>
References: <20230814084602.25699-1-benno.lossin@proton.me>
        <20230814084602.25699-4-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0618.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: 08298017-b80a-4fc0-bd93-08db9e7ff39e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: braGjTwJATA6Zte5Ib3+8d9grmgrUdehrF8CRGXCaTnwbGoXeiY30+ay8wPqCh9kHAspoO0ZOPWUtdDMwDFs90NhyMDPXYfjtT7SfDNd8QEJc4D+gYz+KoY+mV+E09aUOR7+H81t/bdSU1x4Z4yLTgn3DxALEChgB4YUpvd40xaccSyI+I90SJ9v/DV5xtMzFiDy1G9Fztd9d4M/akM+NUrAU1zQknuwUr7RyRZpXfzjBR7JkYorp7EDNGf116T908w5FczZDgdikvemADFawLLYcs+v9b8tQsWugheMz4tkohz/4YR677POPPUzJrAxg19FeaydZbxYEIWIrLprmISp21k2f04sX04I79Sn36oaeyY6OeQW6OZPFE1GniXKWC3P503XATrJhnb9XHxTSoNY7RwuVJnHNSAmUycuTdj8z7C8d2Ax+K5JTg3RJ0jqWK6G0Sf6jxVaBJqeLuuPlwUI1UssscgeutSUTPcS2awDfFBhQN96IuNLZGrArKucNL7NceewMhX0D7lJLDkSVVw8voZFYar3kaUbCnr6T9QxPncBzpwnbzDjf3ydp+ekrQSrChAaf59vYtsAdsaKr1Me/xMY2dveCsp26tmHifs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39830400003)(396003)(346002)(451199024)(1800799009)(186009)(2906002)(83380400001)(7416002)(86362001)(478600001)(6506007)(36756003)(6486002)(2616005)(6666004)(1076003)(6512007)(26005)(5660300002)(41300700001)(54906003)(316002)(66946007)(66556008)(66476007)(6916009)(8676002)(8936002)(4326008)(66574015)(38100700002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azJaTk9pcHF2V3lDb3VYZkJHVzZqZXdHcmlhSDJDUGVxalF3WW1tQklGS0Fi?=
 =?utf-8?B?YkQ2dk4zdzMzakh1V0xZdXRxYnBxYmJvVEFURytNNWNKTFFWSXV6L3k5WUpv?=
 =?utf-8?B?Um96OUdKK0pRbXVYaW1WWjdEWEhRZDVVazB1MEM0MjFpMVVXaFRGbGcvSThy?=
 =?utf-8?B?R3J5NE5vSzlHc1R4YTAzb1BOWEd2bVFnZG5lNUpPY055N01PMUdOWHNvNk5C?=
 =?utf-8?B?VFhWSm1iVk8rRzRXSUZTMG9vb2xkWWhUSndQUU5saUhnblduZEFON2p1UDZG?=
 =?utf-8?B?ZUNtVktTcVdvV2NNQzl3VlFyYzFGejdoYTJLSnllRnBpNU1qK0FTcHJtY3FN?=
 =?utf-8?B?cTErT0YrL0RNeXNDVzdDMm9jNXRNbXc3bW1MZmUzSUw3ekpnZEdnL3VIUk1E?=
 =?utf-8?B?VFBUb1pCd3FtelFTeHBmODV6VWpjWTNyeEpabTZ4OStkOCtrc2JWeG1ncmwx?=
 =?utf-8?B?M2ZuQ3RtR1M1cmJ4YkFvYUc3U09nUUN5NXBrWU1QNWFDT09YbjJFU3ptK3Ji?=
 =?utf-8?B?SDBlTHJRNjY5aW1rejFpOC9EZWJRdExQeWdrbmxSZWdId3pVdkFYK2NPb0Ev?=
 =?utf-8?B?WkF0L24zWTY2RCtWRVFsWDNveVJscjdVdWd6TDBlcVU3dmNMY1BJeGw0QjVp?=
 =?utf-8?B?ZmMwZE9Vc1AvaVNvdnhLRHlMRnV6dUR4eDFpL0pMQjVoOXdGbW40bkc5UFh6?=
 =?utf-8?B?OGdZRTdEY284OXpqbWt6U3FSZU02a0hGR0Q1amoySzhEZGtONWNINUF5VmxZ?=
 =?utf-8?B?bFRtbCtQZW5LbzRNSnQ4SlJFbk1RVllyYWNHV3QvZG9BMjNqUGxGL1ZjdWJ5?=
 =?utf-8?B?Tlc0VTdvd3F1ZGNCcjA2OWpVRXJLM1YwMkJ3U1h6cWFXUHlmeXJsSndKWHVr?=
 =?utf-8?B?akVzUmROSk5Ic2RCSk53NHFmWHRPRFFzWFI4REhhUDZ3WkFyMm5xVjVxditR?=
 =?utf-8?B?c0d2NUdhQlEvazN6MHRHbDRpeEo5OXhlVGlzNVFhalFsYWJIUHRzMzNVRWRX?=
 =?utf-8?B?cDhrYnVmcnF2L01Vd1daQkxKWnFDbEJFWXhnZUw2VTVFbVRoaTJmQzM4U3NX?=
 =?utf-8?B?ZW1LOHJjVDl0cHdUeU93WUMxY1JWSm1Oc1lZcUlSUVpWSkw0L3BZK1Q2NWFK?=
 =?utf-8?B?Mkp6ZE9TR3lZZElKY1hNTGJKdVpXWm10NTZoeXhSVThNeW93N0JpUmRtWnBh?=
 =?utf-8?B?L2tuVXdYZFNRZUc4NjQyUE5UajRGc0d5VmZ2ZlhONk5CZ2ZweVExSnpINW5o?=
 =?utf-8?B?ekxJdnkrT2R1cm1hNlpPNTdJd1EveUVQTWMvUkUrbDI5SlhOUExoL3BHbnRz?=
 =?utf-8?B?U2tGWHZVOElTY3BDT1QvWmx1bXcwNmhQbEhFT2NzR3dQamVRa3NMUGQ0WnR6?=
 =?utf-8?B?TktRU0svelRJYXhWKzJVMk5mNWRXUDc5Z3JXOG90eWRUZEdwdHhvRVVURFR1?=
 =?utf-8?B?Z01YVnJKUkFROWlSYUU4S01kZURkV1ArZ1BEOGZSL2VLb0txb0xVNVVGdkdL?=
 =?utf-8?B?WWRjODNXaFFwTkpINzFXanEwcWM3d2VmLzdnY0Y5d0R4ckNBUzh3QSt1ZjhT?=
 =?utf-8?B?S2VhaFUvSEg0OFJSc0NDMW9aaEdQMm9Oak1iYUx4WlZqUmcxMjl6RzJvN3Fs?=
 =?utf-8?B?VUpIMnN5eUZMaFY3U3QzV0sxaGtxQm1YTUh4N092aTF6MHFpMi9nTW14SlBK?=
 =?utf-8?B?TFpMcjM5cDZSQkNzVGZ0ZDFnSXVxOHdNNWZMT3FQN21hUHpoaDY2Y3piMitl?=
 =?utf-8?B?VkJIMFNXL21vc0RxbTBUUktvNTBBdTYrUi9raFJRckp6TU9pem8yeXdKNmgw?=
 =?utf-8?B?cHU2eWZ0cnFtQVB3NjNvUXd2RnNpNnNDNUQwekxVcTltM0VhNHBOa1o3YjhE?=
 =?utf-8?B?OTNKZHZuVXBVSzcxdUpUaHFBT1hIZlV0M0Z0NE5RbTNZK0xIUnhuUmxFd2RX?=
 =?utf-8?B?TlFQd2VFOVU4ZERIZm1DTTIxWHZKaXB4NkFsZjhCRy9oQVFZdkVGZlhlbms3?=
 =?utf-8?B?R094aGNWdU43T3o3MlBVaE1PNjlRUHFEeUhJQUVlcU82WEorK2hyUm1ySjg3?=
 =?utf-8?B?Q2NLcDgwRW1yYUdCOTNMR2g4cVRiVUNxMjd6aDN3MVcvYkFFckJMTEY0czFT?=
 =?utf-8?Q?Ypd4TvWqkaRpB9jwL2y3Z/YKb?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 08298017-b80a-4fc0-bd93-08db9e7ff39e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:40:58.9929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQEHtsiyIogqQpUnnjQ8m6u5Bp47j1YxQES31E3LgtqCmvkCuLUClSMOzlX9l0kRf/Fct0y1paJ/zw18lBDpaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5275
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 08:46:41 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Add a derive proc-macro for the `Zeroable` trait. The macro supports
> structs where every field implements the `Zeroable` trait. This way
> `unsafe` implementations can be avoided.
>=20
> The macro is split into two parts:
> - a proc-macro to parse generics into impl and ty generics,
> - a declarative macro that expands to the impl block.
>=20
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v3 -> v4:
> - add support for `+` in `quote!`.
>=20
> v2 -> v3:
> - change derive behavior, instead of adding `Zeroable` bounds for every
>   field, add them only for generic type parameters,
> - still check that every field implements `Zeroable`,
> - removed Reviewed-by's due to changes.
>=20
> v1 -> v2:
> - fix Zeroable path,
> - add Reviewed-by from Gary and Bj=C3=B6rn.
>=20
>  rust/kernel/init/macros.rs | 35 ++++++++++++++++++
>  rust/kernel/prelude.rs     |  2 +-
>  rust/macros/lib.rs         | 20 +++++++++++
>  rust/macros/quote.rs       | 12 +++++++
>  rust/macros/zeroable.rs    | 72 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 rust/macros/zeroable.rs
>=20
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index 9182fdf99e7e..78091756dec0 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -1215,3 +1215,38 @@ macro_rules! __init_internal {
>          );
>      };
>  }
> +
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! __derive_zeroable {
> +    (parse_input:
> +        @sig(
> +            $(#[$($struct_attr:tt)*])*
> +            $vis:vis struct $name:ident
> +            $(where $($whr:tt)*)?
> +        ),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @body({
> +            $(
> +                $(#[$($field_attr:tt)*])*
> +                $field:ident : $field_ty:ty
> +            ),* $(,)?
> +        }),
> +    ) =3D> {
> +        // SAFETY: every field type implements `Zeroable` and padding by=
tes may be zero.
> +        #[automatically_derived]
> +        unsafe impl<$($impl_generics)*> $crate::init::Zeroable for $name=
<$($ty_generics)*>
> +        where
> +            $($($whr)*)?
> +        {}
> +        const _: () =3D {
> +            fn assert_zeroable<T: ?::core::marker::Sized + $crate::init:=
:Zeroable>() {}
> +            fn ensure_zeroable<$($impl_generics)*>()
> +                where $($($whr)*)?
> +            {
> +                $(assert_zeroable::<$field_ty>();)*
> +            }
> +        };
> +    };
> +}
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index c28587d68ebc..ae21600970b3 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -18,7 +18,7 @@
>  pub use alloc::{boxed::Box, vec::Vec};
> =20
>  #[doc(no_inline)]
> -pub use macros::{module, pin_data, pinned_drop, vtable};
> +pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
> =20
>  pub use super::build_assert;
> =20
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index b4bc44c27bd4..fd7a815e68a8 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -11,6 +11,7 @@
>  mod pin_data;
>  mod pinned_drop;
>  mod vtable;
> +mod zeroable;
> =20
>  use proc_macro::TokenStream;
> =20
> @@ -343,3 +344,22 @@ pub fn paste(input: TokenStream) -> TokenStream {
>      paste::expand(&mut tokens);
>      tokens.into_iter().collect()
>  }
> +
> +/// Derives the [`Zeroable`] trait for the given struct.
> +///
> +/// This can only be used for structs where every field implements the [=
`Zeroable`] trait.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// #[derive(Zeroable)]
> +/// pub struct DriverData {
> +///     id: i64,
> +///     buf_ptr: *mut u8,
> +///     len: usize,
> +/// }
> +/// ```
> +#[proc_macro_derive(Zeroable)]
> +pub fn derive_zeroable(input: TokenStream) -> TokenStream {
> +    zeroable::derive(input)
> +}
> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> index dddbb4e6f4cb..33a199e4f176 100644
> --- a/rust/macros/quote.rs
> +++ b/rust/macros/quote.rs
> @@ -124,6 +124,18 @@ macro_rules! quote_spanned {
>          ));
>          quote_spanned!(@proc $v $span $($tt)*);
>      };
> +    (@proc $v:ident $span:ident ; $($tt:tt)*) =3D> {
> +        $v.push(::proc_macro::TokenTree::Punct(
> +                ::proc_macro::Punct::new(';', ::proc_macro::Spacing::Alo=
ne)
> +        ));
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident + $($tt:tt)*) =3D> {
> +        $v.push(::proc_macro::TokenTree::Punct(
> +                ::proc_macro::Punct::new('+', ::proc_macro::Spacing::Alo=
ne)
> +        ));
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
>      (@proc $v:ident $span:ident $id:ident $($tt:tt)*) =3D> {
>          $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new(=
stringify!($id), $span)));
>          quote_spanned!(@proc $v $span $($tt)*);
> diff --git a/rust/macros/zeroable.rs b/rust/macros/zeroable.rs
> new file mode 100644
> index 000000000000..0d605c46ab3b
> --- /dev/null
> +++ b/rust/macros/zeroable.rs
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use crate::helpers::{parse_generics, Generics};
> +use proc_macro::{TokenStream, TokenTree};
> +
> +pub(crate) fn derive(input: TokenStream) -> TokenStream {
> +    let (
> +        Generics {
> +            impl_generics,
> +            ty_generics,
> +        },
> +        mut rest,
> +    ) =3D parse_generics(input);
> +    // This should be the body of the struct `{...}`.
> +    let last =3D rest.pop();
> +    // Now we insert `Zeroable` as a bound for every generic parameter i=
n `impl_generics`.
> +    let mut new_impl_generics =3D Vec::with_capacity(impl_generics.len()=
);
> +    // Are we inside of a generic where we want to add `Zeroable`?
> +    let mut in_generic =3D !impl_generics.is_empty();
> +    // Have we already inserted `Zeroable`?
> +    let mut inserted =3D false;
> +    // Level of `<>` nestings.
> +    let mut nested =3D 0;
> +    for tt in impl_generics {
> +        match &tt {
> +            // If we find a `,`, then we have finished a generic/constan=
t/lifetime parameter.
> +            TokenTree::Punct(p) if nested =3D=3D 0 && p.as_char() =3D=3D=
 ',' =3D> {
> +                if in_generic && !inserted {
> +                    new_impl_generics.extend(quote! { : ::kernel::init::=
Zeroable });
> +                }
> +                in_generic =3D true;
> +                inserted =3D false;
> +                new_impl_generics.push(tt);
> +            }
> +            // If we find `'`, then we are entering a lifetime.
> +            TokenTree::Punct(p) if nested =3D=3D 0 && p.as_char() =3D=3D=
 '\'' =3D> {
> +                in_generic =3D false;
> +                new_impl_generics.push(tt);
> +            }
> +            TokenTree::Punct(p) if nested =3D=3D 0 && p.as_char() =3D=3D=
 ':' =3D> {
> +                new_impl_generics.push(tt);
> +                if in_generic {
> +                    new_impl_generics.extend(quote! { ::kernel::init::Ze=
roable + });
> +                    inserted =3D true;
> +                }
> +            }
> +            TokenTree::Punct(p) if p.as_char() =3D=3D '<' =3D> {
> +                nested +=3D 1;
> +                new_impl_generics.push(tt);
> +            }
> +            TokenTree::Punct(p) if p.as_char() =3D=3D '>' =3D> {
> +                assert!(nested > 0);
> +                nested -=3D 1;
> +                new_impl_generics.push(tt);
> +            }
> +            _ =3D> new_impl_generics.push(tt),
> +        }
> +    }
> +    assert_eq!(nested, 0);
> +    if in_generic && !inserted {
> +        new_impl_generics.extend(quote! { : ::kernel::init::Zeroable });
> +    }
> +    quote! {
> +        ::kernel::__derive_zeroable!(
> +            parse_input:
> +                @sig(#(#rest)*),
> +                @impl_generics(#(#new_impl_generics)*),
> +                @ty_generics(#(#ty_generics)*),
> +                @body(#last),
> +        );
> +    }
> +}

