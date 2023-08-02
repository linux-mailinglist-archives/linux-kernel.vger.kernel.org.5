Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBFD76D672
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjHBSGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjHBSFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:05:52 -0400
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2094.outbound.protection.outlook.com [40.107.122.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D537A1FEF;
        Wed,  2 Aug 2023 11:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL2SsUAVfUtSlYmXN7Tlp/3DGOpdvH+SX86E/Tol3xfVy2Lyll/rYNTs28QYw6V57L05QdOR5tW4GzRB+tsAEV7Q2skhooJV2uBiqQIbDn6OyuxNvbeX8obiB8wmP6EkR5CoqDU7t6FWKgjlv7uPAk0HrWohcHtOyE89Z7why/f34yrRC224sE++UqRmPb99zn5MaxMUYXJtfNpEvOwe/5a0CX0wA5+ISaPfN4VpY7ritg0wgfzas/eOJ7DwL2E9JH1CV5Odgl+08mRhj1DEU+btj34iDadvkKJobEaK3su7HQ96LZ+dNbkoHm5zPDKuLgPg0mdDkGe69z33u/xAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvFcgb3BLvVr78R08i4ax83zOtcs++NzCS7E2ch/fkU=;
 b=BUWXB/23gCMM0IiDrm4rKHODh/4Iiw1mI3W1yJKMvZlqs3+w6Ii21XsJgIVDrv8dYgrZnekTf0FGPCfVSXGHFTAUvFxPvxlfNhsTblzg7x1UqnFGwucxlJ2C1WJAsy5mR5zlUDC+pzY+9+s5Ew1aJE+PfAXsE8jJ4UQaC0HORZ42UaDSLkoFPnqtM3qPEDc0+8Rtq0yZ8f5i1yinWLsaRcTLZF4U3WMbsp1npWdyAH/uBd1Hz5cFMRrgmL+ylhxGIhurPNwOfojHTRhIrECL28jfJdwzUh/WsQKm5K2pvDt4Z0Gt5MuLsSyoxYwV25VQ+TNcDmsJNxLMqH7Dt1g6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvFcgb3BLvVr78R08i4ax83zOtcs++NzCS7E2ch/fkU=;
 b=vlP70YLelmIQbefEoZRuVpZVv0t39FpvNlHiIIqPP6pUgrppNJEOFLD2wY1uGMeoUx2VjEcp11jpiUGOgskGE1Zt9iNQ2MIdytHq0XS4nkrj62SWIlFs9D+P923Sn0UI3I+qgDSxc1gCsvqstKC8vSS/WVg/rcS2g1atSImx9jU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB2080.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:122::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 18:05:17 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 18:05:17 +0000
Date:   Wed, 2 Aug 2023 19:05:14 +0100
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
Subject: Re: [PATCH v3 07/13] rust: init: add `..Zeroable::zeroed()` syntax
 for zeroing all missing fields
Message-ID: <20230802190514.24a5bdcf.gary@garyguo.net>
In-Reply-To: <20230729090838.225225-8-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
        <20230729090838.225225-8-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::18) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB2080:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f2da4b-858f-4bbb-9606-08db9383074d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtffPzDzaqWq2CFTxB2lCIg3Of5V/++savTg+Qt8yZ0oOEcumn76moUVRo4bpXoW9U8K9lCjL7Nb2vQBoPXCCgmJmKcDEihqk77FYbBlv0qzm06w7AjrMH+d5fl5HrYPGI8PrWUn95Vl+8jxbBtA7PXnNfrQQhIqA1v9BpvWpb+RGlQW+CQgSDw+lZPQuEoIWBkUgV+vWWOb2LRwvD/F25GAlolpe5Bb825vt72yspf3w0wxYR13ro9/5qSM2vZWIxSvGxFRnzNjDNORmnfsoGVatz8d056z0tA/Gs9w+p3jb1tbhZMa8IFzNErfelRW6Ua/jelo6t2u4ugCfKcsC5XxC+hl3MSOt0x+bSNqu8CtpEixma5aVQWS0vsU9QSrcuPQgTtGQQX6FnZ+yLpQf8YLstNmMewYw5HQJS2s4ah3Kxqlhs+zy8S55IBHtKCB/RwV7qNy/0byiDp9BPLqX6iAGwBS6eMhuB/kaKPPyT7BXL2M7IxtjFIzkheWgjPtQV8mdz357yyST1+K2kyG02rqcHSdxR/5m/GGgBgPW0PbaQbf/n+CoXevPfWhbt9u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39830400003)(366004)(136003)(376002)(451199021)(2616005)(186003)(6512007)(316002)(86362001)(478600001)(54906003)(38100700002)(66476007)(66556008)(6666004)(6486002)(66946007)(4326008)(6916009)(6506007)(36756003)(41300700001)(26005)(8676002)(5660300002)(8936002)(1076003)(30864003)(2906002)(7416002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6f1Lrw9AnGen2TpoSD7+vBdCTYXfJuRMNgurPIukCnnJ9yv62paXJUkdYrJd?=
 =?us-ascii?Q?kbkh986xJJWe82Xf5bsUh6hirGXloUNmHCiqA4TldPVmwaxVNGMXoldl39jz?=
 =?us-ascii?Q?c1QmPCC4WCkxGtckjtYWiHFGTFlQ8NWqIqHZu7MysICZqJev56Ek79QIKc5F?=
 =?us-ascii?Q?O2XlvHTSPSAsD87l+g0HPeIeWveveu868OCw/DvAjf87xEUkzuobo0HsAJ0u?=
 =?us-ascii?Q?E6FbJTG6aVA+c4I373eudWiEBGQIzysWO9MSEQiAwbNxaSOLAKldgaxkuu/2?=
 =?us-ascii?Q?vNx9LXYWYiZmpm5OuLFA7mxzil57lhSbdabrHN6AXdXVNIdIy/QI/oU5C/ZA?=
 =?us-ascii?Q?xzrn6n7CjL2BvfuRctHf8EiQe6+sMEW1KUdo4zEk4vzRPAyOKnqnZflzdKHY?=
 =?us-ascii?Q?VSzg6kAliiPpSuibQZHz9pDmcchAwWBTTqvT490xsn4MjKLndAv7m8Rvb4Nw?=
 =?us-ascii?Q?+idZGEAomXhcel7lIzy7bg2gNp/6+mIlgwqI+CeF9zD9UU1dqAOUjDGEEiX9?=
 =?us-ascii?Q?MlJLlXRsQ2ScnhKh6/a0HrE8+s5BUJRY9baiUH/CCzh2K+N/I9TlqYQ37+qc?=
 =?us-ascii?Q?acfy54ga8a7Mj7PIFFKdwRHVuHLSJQJytCnE8jxUfh9hOHCkx4RARY5+OUvn?=
 =?us-ascii?Q?623yHfJwk82ma1e+WDkjbM6ctRVuk75QKcXlv6Q+Q6enSwlPoHsKMzV73h6x?=
 =?us-ascii?Q?pQZXsugvyr0rjPyNcsfXQNtlMsJrtBZR8GCDUE2ExNslcaqEEAmJX1Am33fY?=
 =?us-ascii?Q?q/O+qgZsLVihku8rgIHLosc/QwLeYmT91kKV7i/NEU/QLiRyq+c4+6C2Oqez?=
 =?us-ascii?Q?fWGXHB0+HHRWCxbxrOR6F2nYHgtfQn1nj8Nsmwd0Hba5teHU2er4qhe/iPM6?=
 =?us-ascii?Q?d1o22Hd8hQ8EWCMFOjogeffvIxz7LUUd4qzBKLpSdDx/3pplKI1GThUJzIM0?=
 =?us-ascii?Q?88qSNEZmwh1wM7BA6MuYQ7cKG4cRQTjrvGSfh5vUs4WxLFs0DtN2lk0MXntT?=
 =?us-ascii?Q?u3IEJUlHMl3Tbu353l46ytGyQHWRDqPgsWca16C1Lg1kb8vmJgk9f4ETpQ/j?=
 =?us-ascii?Q?NBzeHFAnw9gyBfZAo0U8pRU9CX/iMWN9mAU2WOhLi+y2HgAyaN7kwiL73W08?=
 =?us-ascii?Q?bUyIvn9eiO4I+RbWhjxzXpZkewj7QpVia3eANCMmHm2bnbHrhJ2fDqxV27hN?=
 =?us-ascii?Q?lG0NeUmMzY/lSNHnJveG5bhakPdVDwMk+Z2a23yDPkI/eUx2gJJeSLYdqM1m?=
 =?us-ascii?Q?GGS0pFQ/zfDXLN/I2BS7cVBLAJcRt4tJM7GER7FsaM3Ogs4kAHExLC/MKiXA?=
 =?us-ascii?Q?P8leQAGFCJjkzp28RZiVcFRRY1xjiEObxrBQsr3es+3rRzL0jkYrea8NdWUn?=
 =?us-ascii?Q?GKR0ZK9UWtcWV6/teHVmKgS/zdS3L1v7o6ZNrjEyPsFNrFi5XVh+M+qQV6eJ?=
 =?us-ascii?Q?h3T3zuKXg1DtGwM+roFsXUGv8Wgb6Qx2vygUbUHn2DaiByT3wbGl/0aoLecv?=
 =?us-ascii?Q?38sYk9WARb1doDBNCGmUQ2vuR8Lgz6GFOmZJFuSkPbeH5YN18tIC7nsvoZgP?=
 =?us-ascii?Q?V/WgMp35su3qfYLx1bPzOveXnIIvxD8yzQxXc0Iq?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f2da4b-858f-4bbb-9606-08db9383074d
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 18:05:17.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ch3ois9WIoNs1oHJGCHPDvlS1KAsT67TiEusKoNQJTVlEasSTSgz601GZlf9K3PaoQyB7sOliS9X7N6O5iGOUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023 09:09:59 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Add the struct update syntax to the init macros, but only for
> `..Zeroable::zeroed()`. Adding this at the end of the struct initializer
> allows one to omit fields from the initializer, these fields will be
> initialized with 0x00 set to every byte. Only types that implement the
> `Zeroable` trait can utilize this.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v2 -> v3:
> - changed `if false` argument to use `never executed closure`,
> - added Reviewed-by's from Martin and Alice.
> 
> v1 -> v2:
> - fix doctest imports,
> - fix doctest examples,
> - fix `Zeroable` path in the `__init_internal` macro,
> - rename `is_zeroable` -> `assert_zeroable`,
> - add missing `{}` to the case when `..Zeroable::zeroed()` is present,
> - add `allow(unused_assignments)` in the type-checked struct
>   initializer.
> 
>  rust/kernel/init.rs        |  16 +++++-
>  rust/kernel/init/macros.rs | 115 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 129 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 0120674b451e..460f808ebf84 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -517,13 +517,17 @@ macro_rules! stack_try_pin_init {
>  /// - Fields that you want to initialize in-place have to use `<-` instead of `:`.
>  /// - In front of the initializer you can write `&this in` to have access to a [`NonNull<Self>`]
>  ///   pointer named `this` inside of the initializer.
> +/// - Using struct update syntax one can place `..Zeroable::zeroed()` at the very end of the
> +///   struct, this initializes every field with 0 and then runs all initializers specified in the
> +///   body. This can only be done if [`Zeroable`] is implemented for the struct.
>  ///
>  /// For instance:
>  ///
>  /// ```rust
> -/// # use kernel::{macros::pin_data, pin_init};
> +/// # use kernel::{macros::{Zeroable, pin_data}, pin_init};
>  /// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
>  /// #[pin_data]
> +/// #[derive(Zeroable)]
>  /// struct Buf {
>  ///     // `ptr` points into `buf`.
>  ///     ptr: *mut u8,
> @@ -536,6 +540,10 @@ macro_rules! stack_try_pin_init {
>  ///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
>  ///     pin: PhantomPinned,
>  /// });
> +/// pin_init!(Buf {
> +///     buf: [1; 64],
> +///     ..Zeroable::zeroed()
> +/// });
>  /// ```
>  ///
>  /// [`try_pin_init!`]: kernel::try_pin_init
> @@ -555,6 +563,7 @@ macro_rules! pin_init {
>              @data(PinData, use_data),
>              @has_data(HasPinData, __pin_data),
>              @construct_closure(pin_init_from_closure),
> +            @munch_fields($($fields)*),
>          )
>      };
>  }
> @@ -611,6 +620,7 @@ macro_rules! try_pin_init {
>              @data(PinData, use_data),
>              @has_data(HasPinData, __pin_data),
>              @construct_closure(pin_init_from_closure),
> +            @munch_fields($($fields)*),
>          )
>      };
>      ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
> @@ -624,6 +634,7 @@ macro_rules! try_pin_init {
>              @data(PinData, use_data),
>              @has_data(HasPinData, __pin_data),
>              @construct_closure(pin_init_from_closure),
> +            @munch_fields($($fields)*),
>          )
>      };
>  }
> @@ -658,6 +669,7 @@ macro_rules! init {
>              @data(InitData, /*no use_data*/),
>              @has_data(HasInitData, __init_data),
>              @construct_closure(init_from_closure),
> +            @munch_fields($($fields)*),
>          )
>      }
>  }
> @@ -708,6 +720,7 @@ macro_rules! try_init {
>              @data(InitData, /*no use_data*/),
>              @has_data(HasInitData, __init_data),
>              @construct_closure(init_from_closure),
> +            @munch_fields($($fields)*),
>          )
>      };
>      ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
> @@ -721,6 +734,7 @@ macro_rules! try_init {
>              @data(InitData, /*no use_data*/),
>              @has_data(HasInitData, __init_data),
>              @construct_closure(init_from_closure),
> +            @munch_fields($($fields)*),
>          )
>      };
>  }
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index cfeacc4b3f7d..4c86281301d8 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -991,6 +991,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
>  ///
>  /// This macro has multiple internal call configurations, these are always the very first ident:
>  /// - nothing: this is the base case and called by the `{try_}{pin_}init!` macros.
> +/// - `with_update_parsed`: when the `..Zeroable::zeroed()` syntax has been handled.
>  /// - `init_slot`: recursively creates the code that initializes all fields in `slot`.
>  /// - `make_initializer`: recursively create the struct initializer that guarantees that every
>  ///   field has been initialized exactly once.
> @@ -1009,6 +1010,82 @@ macro_rules! __init_internal {
>          @has_data($has_data:ident, $get_data:ident),
>          // `pin_init_from_closure` or `init_from_closure`.
>          @construct_closure($construct_closure:ident),
> +        @munch_fields(),
> +    ) => {
> +        $crate::__init_internal!(with_update_parsed:
> +            @this($($this)?),
> +            @typ($t $(::<$($generics),*>)? ),
> +            @fields($($fields)*),
> +            @error($err),
> +            @data($data, $($use_data)?),
> +            @has_data($has_data, $get_data),
> +            @construct_closure($construct_closure),
> +            @zeroed(), // nothing means default behavior.
> +        )
> +    };
> +    (
> +        @this($($this:ident)?),
> +        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @fields($($fields:tt)*),
> +        @error($err:ty),
> +        // Either `PinData` or `InitData`, `$use_data` should only be present in the `PinData`
> +        // case.
> +        @data($data:ident, $($use_data:ident)?),
> +        // `HasPinData` or `HasInitData`.
> +        @has_data($has_data:ident, $get_data:ident),
> +        // `pin_init_from_closure` or `init_from_closure`.
> +        @construct_closure($construct_closure:ident),
> +        @munch_fields(..Zeroable::zeroed()),
> +    ) => {
> +        $crate::__init_internal!(with_update_parsed:
> +            @this($($this)?),
> +            @typ($t $(::<$($generics),*>)? ),
> +            @fields($($fields)*),
> +            @error($err),
> +            @data($data, $($use_data)?),
> +            @has_data($has_data, $get_data),
> +            @construct_closure($construct_closure),
> +            @zeroed(()), // `()` means zero all fields not mentioned.
> +        )
> +    };
> +    (
> +        @this($($this:ident)?),
> +        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @fields($($fields:tt)*),
> +        @error($err:ty),
> +        // Either `PinData` or `InitData`, `$use_data` should only be present in the `PinData`
> +        // case.
> +        @data($data:ident, $($use_data:ident)?),
> +        // `HasPinData` or `HasInitData`.
> +        @has_data($has_data:ident, $get_data:ident),
> +        // `pin_init_from_closure` or `init_from_closure`.
> +        @construct_closure($construct_closure:ident),
> +        @munch_fields($ignore:tt $($rest:tt)*),
> +    ) => {
> +        $crate::__init_internal!(
> +            @this($($this)?),
> +            @typ($t $(::<$($generics),*>)? ),
> +            @fields($($fields)*),
> +            @error($err),
> +            @data($data, $($use_data)?),
> +            @has_data($has_data, $get_data),
> +            @construct_closure($construct_closure),
> +            @munch_fields($($rest)*),
> +        )
> +    };
> +    (with_update_parsed:
> +        @this($($this:ident)?),
> +        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @fields($($fields:tt)*),
> +        @error($err:ty),
> +        // Either `PinData` or `InitData`, `$use_data` should only be present in the `PinData`
> +        // case.
> +        @data($data:ident, $($use_data:ident)?),
> +        // `HasPinData` or `HasInitData`.
> +        @has_data($has_data:ident, $get_data:ident),
> +        // `pin_init_from_closure` or `init_from_closure`.
> +        @construct_closure($construct_closure:ident),
> +        @zeroed($($init_zeroed:expr)?),
>      ) => {{
>          // We do not want to allow arbitrary returns, so we declare this type as the `Ok` return
>          // type and shadow it later when we insert the arbitrary user code. That way there will be
> @@ -1026,6 +1103,17 @@ macro_rules! __init_internal {
>                  {
>                      // Shadow the structure so it cannot be used to return early.
>                      struct __InitOk;
> +                    // If `$init_zeroed` is present we should zero the slot now and not emit an
> +                    // error when fields are missing (since they will be zeroed). We also have to
> +                    // check that the type actually implements `Zeroable`.
> +                    $({
> +                        fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
> +                        // Ensure that the struct is indeed `Zeroable`.
> +                        assert_zeroable(slot);
> +                        // SAFETY:  The type implements `Zeroable` by the check above.
> +                        unsafe { ::core::ptr::write_bytes(slot, 0, 1) };
> +                        $init_zeroed // this will be `()` if set.
> +                    })?
>                      // Create the `this` so it can be referenced by the user inside of the
>                      // expressions creating the individual fields.
>                      $(let $this = unsafe { ::core::ptr::NonNull::new_unchecked(slot) };)?
> @@ -1062,7 +1150,7 @@ macro_rules! __init_internal {
>          @data($data:ident),
>          @slot($slot:ident),
>          @guards($($guards:ident,)*),
> -        @munch_fields($(,)?),
> +        @munch_fields($(..Zeroable::zeroed())? $(,)?),
>      ) => {
>          // Endpoint of munching, no fields are left. If execution reaches this point, all fields
>          // have been initialized. Therefore we can now dismiss the guards by forgetting them.
> @@ -1163,6 +1251,31 @@ macro_rules! __init_internal {
>              );
>          }
>      };
> +    (make_initializer:
> +        @slot($slot:ident),
> +        @type_name($t:ident),
> +        @munch_fields(..Zeroable::zeroed() $(,)?),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        // Endpoint, nothing more to munch, create the initializer. Since the users specified
> +        // `..Zeroable::zeroed()`, the slot will already have been zeroed and all field that have
> +        // not been overwritten are thus zero and initialized. We still check that all fields are
> +        // actually accessible by using the struct update syntax ourselves.
> +        // We are inside of a closure that is never executed and thus we can abuse `slot` to
> +        // get the correct type inference here:
> +        #[allow(unused_assignments)]
> +        unsafe {
> +            let mut zeroed = ::core::mem::zeroed();
> +            // We have to use type inference here to make zeroed have the correct type. This does
> +            // not get executed, so it has no effect.
> +            ::core::ptr::write($slot, zeroed);
> +            zeroed = ::core::mem::zeroed();
> +            ::core::ptr::write($slot, $t {
> +                $($acc)*
> +                ..zeroed
> +            });
> +        }
> +    };
>      (make_initializer:
>          @slot($slot:ident),
>          @type_name($t:ident),

