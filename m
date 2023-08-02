Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895ED76D628
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjHBRx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjHBRxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:53:38 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2116.outbound.protection.outlook.com [40.107.11.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3091730EB;
        Wed,  2 Aug 2023 10:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMolM7QT6xZAVmMMuaqEDNMTGUWkBrjIxAdNIkaZY8MFjXXRAmWjUouYnEeVqXz2+czYhP4o79lmIkvA81ZBhszHyC6V+Jzmpo1nhsVwnUFCXvQ1fF6f3tE/e9bk6ned1ZuqgOV35+3O5BPP794WQhBYoFdG/2n22tS3gnDpLXOTo9djUDA6zzLHaHQB/jxAs8CtfYOy9Gv5KiT600piT2H+NPRrkiHrCEvk821I4RCnS0Y0MMoUUgxjSqEryHWKA+0NRBaaM+iZo72za4d88iaL+lykwrlvanWizNIgzHhG6l72GTHwXQFqWc0wYy23C12ZHRYighoNBXwFDRrI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgH+WR+W6GYmQxluwFGHD1s9BBs1AFB1iy2J6gb98i4=;
 b=AQHZeCrO1g7kAVAtMF34f+qzm6NQPfhqoiROPb6ziXAyv74DFTJ7BWiUsWbvha46Z5SStfegfsyY0c+v6IkTrfYhLiFnEGT3Lpfu55KWIqc22xIZ3K5hl79eU7/WdvllQ/VZFyxEB7WAqm7KHGBTPQnP9Bi8ASfir/PY6rlW5NIxRtrLjJjQzzHFKjI5k4aBUXrhqHlNuVKpKwaKVhd+TfYJhn5YpwfBzYoCgOkaQglF2sbdKCGbWrP4S//Zn6SD6UeNH3fszrds+B/z/85xLqWp7iuPESleRNTXknal56DUWLRK6xmAuPdfcn1j2DEjZFtJOsmdSgp4nw0T38YAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgH+WR+W6GYmQxluwFGHD1s9BBs1AFB1iy2J6gb98i4=;
 b=BPpGydd1IoWjCMXS6K3IBHundeWUTDCGJf6MGH4DJTBK9M5kOm+XrgRgtfnmsMaTEmxjGTaZBuyZiDZWeST74e8Q1LSCazmIYk0xwPafWeSrUiN4lpS5uDMeW2lZkco9ZIsoIF4h6aOaNR2xILq0yFgAk7lUxHqRov3xIjw0qj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5396.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 17:52:36 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 17:52:36 +0000
Date:   Wed, 2 Aug 2023 18:52:33 +0100
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
Subject: Re: [PATCH v3 04/13] rust: init: make guards in the init macros
 hygienic
Message-ID: <20230802185233.138b81f1.gary@garyguo.net>
In-Reply-To: <20230729090838.225225-5-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
        <20230729090838.225225-5-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0333.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5396:EE_
X-MS-Office365-Filtering-Correlation-Id: 01744378-3a75-4ff3-0753-08db938141ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkZVqayUt52eIxSC4aAg5ykdScrIb05XgeSmm39b5HjfxHCqkBxTUPlB3IAhW/mG1ZXMpd5nC85xbYZrkpzdEBSOf+mgJCvQpG0+77sOXPoOxkSQMqWWPcnwUJV6JB8JxxzEgGbi+tQroi7Bit31XxEfPFvkzig0aWw4uXvZkbn3v5vy1OYclg5udBAjdIdpHmEVFSYwioG6OfqeGHwHFKVi9bbv2Z5Ud0nq4daSwEqP3j+1sbLqsDRgbO094A4fxaHo706lcQynhJB5Nn8MILeRe2QBAMcF55dZBPoEXKw1Xh3FE+8M1Kw22rAdFwzP1ZZBrIya/nL0IpNx7WQx4ryYNQPcevMAGc3OumMwXEyBp+X/z7tTaCKMPG7a2C4oRrGDmWb1U6BnQyxcg8xQI1kjhRACQqQcD/kz20cwfDKfQ1if7hVSPL+qClayYAZaVMlMe/C+phYCBUhWAX5xxgAlEoLQiPS5NateJJGUsore7CS8FsFr5MhhjVUC9kp9L0QsiaqBFKewpNymAlsJFE1Q7O1CjljjOVqjLfjcIMT26zCG1vZdio7hNh1yl9Us
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39830400003)(366004)(136003)(376002)(451199021)(2616005)(36756003)(6512007)(316002)(38100700002)(478600001)(86362001)(54906003)(66476007)(6666004)(66556008)(66946007)(6486002)(4326008)(6916009)(6506007)(1076003)(41300700001)(26005)(186003)(83380400001)(8676002)(8936002)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n9dktYyMX+fw1Fc+Gx+nLmHiQBoBLGFios0G7prchjce9zpFM/rQFEEtauKw?=
 =?us-ascii?Q?0UENrLlqt8cWhElvswajW/VsCPXKKN5V/JuVMjhQtYmQloUBuMgfzFExRpFj?=
 =?us-ascii?Q?JNImUoLedy1zDoYjOcwmxZ42c6TWYBDn6VguOsgAzbWpPDbjlAPyOMEK7U8t?=
 =?us-ascii?Q?3vnAw8dspJE3PMUp6izS9lTqhyGzKx1M0Qyvz2jZcnyjVOuzGZFhZnQFN2hn?=
 =?us-ascii?Q?jaFZifershj2fNc4Gkr0gUrR/87Lp4MndBvcSiVbW/WX3+YScM0ZcYP6Ff0a?=
 =?us-ascii?Q?pLghaTas0SN1IXaYKgFSS/i1nOEZjQpuxZKt3niTjfQgVrcgD4ylS5Ljc1GX?=
 =?us-ascii?Q?KWifXaLJd2MqZI1skeDGmvSKW5I3DfvIUr4ejVBWAd+/LPHAFWqLZQc31YJL?=
 =?us-ascii?Q?ZhbImBSng681Iz8urzt3ojdi1tB7gqyxfc3l4otPu1TXNifpqlU0/8jWYQu6?=
 =?us-ascii?Q?2DPEE/uoHEkZc3mYFDr1iOfpBuykEtZNwGANFOOTpN9TsSnPcpJWgHHDkZ/y?=
 =?us-ascii?Q?t+rAHP4FHlH+9JuCj3USTYIjzIYtY4MkHM4F8E7tD0HQ5t9MsDnJlh3A1oCr?=
 =?us-ascii?Q?0jBOJzCxFkg/tgFia2PDzW4eBSv90Zru+rFZaKOhQR94S0SUc+UY88p1RTJ1?=
 =?us-ascii?Q?Mztins6NUsGR0dWK/2+blsuC7ToYsZYH+phage3eJzWExHfFifJ6S5tCTlk5?=
 =?us-ascii?Q?SSPINf5sfYAbjwjaowv1L6OF5lHbvNkBE+ingFq3vPiDo0COm9SW6mQ31vwx?=
 =?us-ascii?Q?HTvcx6T70BXHoPj++6PLF3O7QrOzHVnhBHK9sFuy5hRZyCYE8kYm3QB4w8mq?=
 =?us-ascii?Q?HM6PmIWGx6VtXw7NSktUfKktVA5ozLWQFEEM6C5BzpFctL28xpeAip2BMv5d?=
 =?us-ascii?Q?20ywfaXLTlKo8mTtPNbxsTYfUt2tjTr9dB51LHsVyDp5lNH8wSlbbgb5r+CK?=
 =?us-ascii?Q?2FvK/Hap9D9HTrqnW1qP3IqF6rufup23hAprdqHZoN/admugyRjEfSBQ4VTp?=
 =?us-ascii?Q?Yku5PBIsvNsRIewatlisGNEsvCyZFdYKzN4l/LyQjapbAaanv4YCPekp5YgZ?=
 =?us-ascii?Q?rBE6G0mHvK1uGVnZCPt6YH0iI/zQ0HbcBpLzLsRdo998ilFWUlzuUejvFg/v?=
 =?us-ascii?Q?xtesO+PjLfbi4LP6CrPPJB2mvRqO1sH3TvK6weqlW5BVNai2LbeLE22mojI0?=
 =?us-ascii?Q?TLZP6DzORBA9Ck17YrtisgLtnGwrw1KTVKDP+uEHiMSHkGtQ9FzXCKob1BVi?=
 =?us-ascii?Q?D3NF12UBT6v3pBpYUZNWXQg8Y7levWpcH6TL2OyWW9UfQ7jCU5lxB33UiHek?=
 =?us-ascii?Q?Wv3WeaRrXBhJqrgGAgX/ULxsJhA1Ill3QmMr1qIgpzHoE5tB5hfyhpgkowVh?=
 =?us-ascii?Q?zQ5IzE7ZOvONk5opJTXdhluqXS/W+H2vQ6rNFjJ/ephXv04LlxE/clWMOu6+?=
 =?us-ascii?Q?9iTYu9DNiKVuq9Pg0YFJ48pJiRNVur/E6MCAMECz7/6GMcsFMFUd+M+F56Aq?=
 =?us-ascii?Q?Z+sM7ZVpDE+UgrKGEeoyP9updZqeajjDyXPyrWrxqnDvlm4Rucavou3FS73h?=
 =?us-ascii?Q?Z6OcmH6ReBYmz9PmItwzPqjzCntRwGUpAgn0w6M9?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 01744378-3a75-4ff3-0753-08db938141ce
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 17:52:36.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIoHDjpo2kpfYx8pRRLyLcc9GFGs3wCYtJ9q8YNN+SxRwlfSnhZx3T99HGfz+1Rf9F7dVd55vWfdErIvKPzJHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023 09:09:40 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Use hygienic identifiers for the guards instead of the field names. This
> makes the init macros feel more like normal struct initializers, since
> assigning identifiers with the name of a field does not create
> conflicts.
> Also change the internals of the guards, no need to make the `forget`
> function `unsafe`, since users cannot access the guards anyways. Now the
> guards are carried directly on the stack and have no extra `Cell<bool>`
> field that marks if they have been forgotten or not, instead they are
> just forgotten via `mem::forget`.
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
> - use Gary's `paste!` macro to create the guard hygiene.
> 
>  rust/kernel/init.rs            |   1 -
>  rust/kernel/init/__internal.rs |  25 ++-----
>  rust/kernel/init/macros.rs     | 116 +++++++++++++++------------------
>  3 files changed, 56 insertions(+), 86 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index d431d0b153a2..0120674b451e 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -216,7 +216,6 @@
>  use alloc::boxed::Box;
>  use core::{
>      alloc::AllocError,
> -    cell::Cell,
>      convert::Infallible,
>      marker::PhantomData,
>      mem::MaybeUninit,
> diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
> index 44751fb62b51..7abd1fb65e41 100644
> --- a/rust/kernel/init/__internal.rs
> +++ b/rust/kernel/init/__internal.rs
> @@ -174,7 +174,6 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit<T, E>) -> Result<Pin<&mu
>  /// Can be forgotten to prevent the drop.
>  pub struct DropGuard<T: ?Sized> {
>      ptr: *mut T,
> -    do_drop: Cell<bool>,
>  }
>  
>  impl<T: ?Sized> DropGuard<T> {
> @@ -190,32 +189,16 @@ impl<T: ?Sized> DropGuard<T> {
>      /// - will not be dropped by any other means.
>      #[inline]
>      pub unsafe fn new(ptr: *mut T) -> Self {
> -        Self {
> -            ptr,
> -            do_drop: Cell::new(true),
> -        }
> -    }
> -
> -    /// Prevents this guard from dropping the supplied pointer.
> -    ///
> -    /// # Safety
> -    ///
> -    /// This function is unsafe in order to prevent safe code from forgetting this guard. It should
> -    /// only be called by the macros in this module.
> -    #[inline]
> -    pub unsafe fn forget(&self) {
> -        self.do_drop.set(false);
> +        Self { ptr }
>      }
>  }
>  
>  impl<T: ?Sized> Drop for DropGuard<T> {
>      #[inline]
>      fn drop(&mut self) {
> -        if self.do_drop.get() {
> -            // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
> -            // ensuring that this operation is safe.
> -            unsafe { ptr::drop_in_place(self.ptr) }
> -        }
> +        // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
> +        // ensuring that this operation is safe.
> +        unsafe { ptr::drop_in_place(self.ptr) }
>      }
>  }
>  
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index 78091756dec0..454f31b8c614 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -994,7 +994,6 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
>  /// - `init_slot`: recursively creates the code that initializes all fields in `slot`.
>  /// - `make_initializer`: recursively create the struct initializer that guarantees that every
>  ///   field has been initialized exactly once.
> -/// - `forget_guards`: recursively forget the drop guards for every field.
>  #[doc(hidden)]
>  #[macro_export]
>  macro_rules! __init_internal {
> @@ -1034,6 +1033,7 @@ macro_rules! __init_internal {
>                      $crate::__init_internal!(init_slot($($use_data)?):
>                          @data(data),
>                          @slot(slot),
> +                        @guards(),
>                          @munch_fields($($fields)*,),
>                      );
>                      // We use unreachable code to ensure that all fields have been mentioned exactly
> @@ -1048,10 +1048,6 @@ macro_rules! __init_internal {
>                              @acc(),
>                          );
>                      }
> -                    // Forget all guards, since initialization was a success.
> -                    $crate::__init_internal!(forget_guards:
> -                        @munch_fields($($fields)*,),
> -                    );
>                  }
>                  Ok(__InitOk)
>              }
> @@ -1065,13 +1061,17 @@ macro_rules! __init_internal {
>      (init_slot($($use_data:ident)?):
>          @data($data:ident),
>          @slot($slot:ident),
> +        @guards($($guards:ident,)*),
>          @munch_fields($(,)?),
>      ) => {
> -        // Endpoint of munching, no fields are left.
> +        // Endpoint of munching, no fields are left. If execution reaches this point, all fields
> +        // have been initialized. Therefore we can now dismiss the guards by forgetting them.
> +        $(::core::mem::forget($guards);)*
>      };
>      (init_slot($use_data:ident): // use_data is present, so we use the `data` to init fields.
>          @data($data:ident),
>          @slot($slot:ident),
> +        @guards($($guards:ident,)*),
>          // In-place initialization syntax.
>          @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
>      ) => {
> @@ -1082,24 +1082,28 @@ macro_rules! __init_internal {
>          // return when an error/panic occurs.
>          // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
>          unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), $field)? };
> -        // Create the drop guard.
> -        //
> -        // We only give access to `&DropGuard`, so it cannot be forgotten via safe code.
> +        // Create the drop guard:
>          //
> -        // SAFETY: We forget the guard later when initialization has succeeded.
> -        let $field = &unsafe {
> -            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> -        };
> +        // We rely on macro hygiene to make it impossible for users to access this local variable.
> +        // We use `paste!` to create new hygiene for $field.
> +        ::kernel::macros::paste! {
> +            // SAFETY: We forget the guard later when initialization has succeeded.
> +            let [<$field>] = unsafe {
> +                $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> +            };
>  
> -        $crate::__init_internal!(init_slot($use_data):
> -            @data($data),
> -            @slot($slot),
> -            @munch_fields($($rest)*),
> -        );
> +            $crate::__init_internal!(init_slot($use_data):
> +                @data($data),
> +                @slot($slot),
> +                @guards([<$field>], $($guards,)*),
> +                @munch_fields($($rest)*),
> +            );
> +        }
>      };
>      (init_slot(): // no use_data, so we use `Init::__init` directly.
>          @data($data:ident),
>          @slot($slot:ident),
> +        @guards($($guards:ident,)*),
>          // In-place initialization syntax.
>          @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
>      ) => {
> @@ -1109,24 +1113,28 @@ macro_rules! __init_internal {
>          // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
>          // return when an error/panic occurs.
>          unsafe { $crate::init::Init::__init($field, ::core::ptr::addr_of_mut!((*$slot).$field))? };
> -        // Create the drop guard.
> -        //
> -        // We only give access to `&DropGuard`, so it cannot be forgotten via safe code.
> +        // Create the drop guard:
>          //
> -        // SAFETY: We forget the guard later when initialization has succeeded.
> -        let $field = &unsafe {
> -            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> -        };
> +        // We rely on macro hygiene to make it impossible for users to access this local variable.
> +        // We use `paste!` to create new hygiene for $field.
> +        ::kernel::macros::paste! {
> +            // SAFETY: We forget the guard later when initialization has succeeded.
> +            let [<$field>] = unsafe {
> +                $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> +            };
>  
> -        $crate::__init_internal!(init_slot():
> -            @data($data),
> -            @slot($slot),
> -            @munch_fields($($rest)*),
> -        );
> +            $crate::__init_internal!(init_slot():
> +                @data($data),
> +                @slot($slot),
> +                @guards([<$field>], $($guards,)*),
> +                @munch_fields($($rest)*),
> +            );
> +        }
>      };
>      (init_slot($($use_data:ident)?):
>          @data($data:ident),
>          @slot($slot:ident),
> +        @guards($($guards:ident,)*),
>          // Init by-value.
>          @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
>      ) => {
> @@ -1137,18 +1145,21 @@ macro_rules! __init_internal {
>          unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
>          // Create the drop guard:
>          //
> -        // We only give access to `&DropGuard`, so it cannot be accidentally forgotten.
> -        //
> -        // SAFETY: We forget the guard later when initialization has succeeded.
> -        let $field = &unsafe {
> -            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> -        };
> +        // We rely on macro hygiene to make it impossible for users to access this local variable.
> +        // We use `paste!` to create new hygiene for $field.
> +        ::kernel::macros::paste! {
> +            // SAFETY: We forget the guard later when initialization has succeeded.
> +            let [<$field>] = unsafe {
> +                $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> +            };
>  
> -        $crate::__init_internal!(init_slot($($use_data)?):
> -            @data($data),
> -            @slot($slot),
> -            @munch_fields($($rest)*),
> -        );
> +            $crate::__init_internal!(init_slot($($use_data)?):
> +                @data($data),
> +                @slot($slot),
> +                @guards([<$field>], $($guards,)*),
> +                @munch_fields($($rest)*),
> +            );
> +        }
>      };
>      (make_initializer:
>          @slot($slot:ident),
> @@ -1191,29 +1202,6 @@ macro_rules! __init_internal {
>              @acc($($acc)* $field: ::core::panic!(),),
>          );
>      };
> -    (forget_guards:
> -        @munch_fields($(,)?),
> -    ) => {
> -        // Munching finished.
> -    };
> -    (forget_guards:
> -        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> -    ) => {
> -        unsafe { $crate::init::__internal::DropGuard::forget($field) };
> -
> -        $crate::__init_internal!(forget_guards:
> -            @munch_fields($($rest)*),
> -        );
> -    };
> -    (forget_guards:
> -        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> -    ) => {
> -        unsafe { $crate::init::__internal::DropGuard::forget($field) };
> -
> -        $crate::__init_internal!(forget_guards:
> -            @munch_fields($($rest)*),
> -        );
> -    };
>  }
>  
>  #[doc(hidden)]

