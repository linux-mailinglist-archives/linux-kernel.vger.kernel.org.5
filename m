Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E020771605
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 18:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjHFQJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 12:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjHFQJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 12:09:08 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2091.outbound.protection.outlook.com [40.107.11.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB3DE7;
        Sun,  6 Aug 2023 09:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXUzlva3MkAfCw+p7MGm9VQeWwTAKPDv/QhFNlDhZHBoogIr9sXHTiERE252IK1qXbGrqylY7POAFi+KWLICFGjGGfAdzNvvxUqj6e7BP8vBs7VOMEUtOh7HmMUksZGbJrA2j2jr4Jb4pViIwdz7icvyJVfJ0envb4E6wPZVmSkw6WBQ2vHrGOSbpUrbzsM8tSL7uPH0PzWP/xERf8rTyyWQfMWf/XSt19A5UAS065M+aJEpYFywUnlg2xw3oV5W78h99yfGpw4GB/2EKg13mTi54RIJedVdPc5etG6UyJsVKW/5X1MMeCrIOwCFyundh+Vbvi+FOIzIZRUxHmMicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=al40/dzxpgXamHRnZIziPdrQNMt2WdLqq33T8cOGQUM=;
 b=P3NF6LFEUfsXXgaMakxP8kqZN3HFOd7dEikwIKjvgRwRB3JNvluxEVqF7BFxmhiR88Pjcq7LdSzjfEvjh+k4IZAF2Op3kxVIlJnF9QC7C68urjX2IeSJE/2y1+WzeRHth/S7Qtr6GZ8PJnpE7nXXYs3OCLY0+gGC4BB/lStCMhwvedJKDmwJ+rHhXdY9eNHDlE3E2JQn1WYZN30+ikM+PlU0Zu+Rgs7xK0vS5dQS/wQRwBcgqOwXSjg9ZsFN34N8YCnBcnfjhyv/i0CDL5nw0AFDmg6YqYMOQf+RZODsBwnpZ13otSxDo2gNtSllw01a18nZqRBLjzBy8pmi48sU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al40/dzxpgXamHRnZIziPdrQNMt2WdLqq33T8cOGQUM=;
 b=U4YjGIEN6zvJi5mDDopMI03JBIdnX5fhuVJb7QKLo20iP2anfIRnXi9ACZg9mIFNCBWMCK3z0RzL9C/ab7XpSLXHP7mD4/tlZ0eIreKFG1tYCQolazwb0s4dQFUkavJwXahswsFgQqL+NsSrWq0tIAxWvWFcqDf0mgx7jI1vTL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB2368.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 16:09:05 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 16:09:05 +0000
Date:   Sun, 6 Aug 2023 17:09:03 +0100
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
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 11/13] rust: init: make `PinInit<T, E>` a supertrait
 of `Init<T, E>`
Message-ID: <20230806170903.36243f76.gary@garyguo.net>
In-Reply-To: <20230729090838.225225-12-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
        <20230729090838.225225-12-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0342.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::23) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB2368:EE_
X-MS-Office365-Filtering-Correlation-Id: efcf6aca-8155-4606-1cbb-08db96977548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcXWxJD+0Ck8nW+kXNXXL+niwvurXfju74rbI4gQU4PPGmB60aTHiDgBXoOSQD6Ow0Ilc73gMh7+8X26p29c9EY4zzrnBMbgRAbJ5Q3XQIzpb6EdU7nVv6hh1m8JLN0Uy/taVWquat1szO472QnOZamdE+3Kp85BNJoXN9Tl3pjvhtinjiWukXwnvne9B4AC0MHaCZiXGYCcWI38z728tY8EJmeRHhwcE0Ordc/CEBruux6Ka+Zy9vnsgBS78t/ozh/hED4/CLlAURwiPj5xJzGnWbjxFIU8n/iqbrimQe/OWjXUClXtIgaLkja8qZNIdZKa515s8Np1kPPR0c+dhPcVMN8KCrezx05BAirwvCyuKFrMJJXhB6SJLpLGa0OAGCR71EPDwUFfbS0944VYCTyV5Z9BbkuN07ObC4INC137Y9bVJkZ1BdpTfD1DQ+9RnEknYL7Dq3rCG7Uc1DZesKyZ8x/6gW9+0TsZ/40CkrD3ual9LofDpE9B+WEtCOCYvKrFSQuvHovtUy4IBY81aCMyfzmUYSFn9X1B2fT2RfPEdBiER43NoSoko3co9kqPcmtjRgoZVEz8TUAi4U74m230f11hC79clNEem+MlTJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39830400003)(396003)(136003)(1800799003)(186006)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(83380400001)(7416002)(8936002)(8676002)(2616005)(478600001)(6916009)(86362001)(316002)(6506007)(54906003)(38100700002)(6486002)(66476007)(66556008)(66946007)(6512007)(4326008)(36756003)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ToOXy5iutVVizQR+8MrM/MBgb4hWU+ukMKwchZXVUBrqqBBKtLdwEu41XPUC?=
 =?us-ascii?Q?VTz9RsKe/8wygS9z54RPqdpc2eH04I2ORbacXqDivuEc8IWImMR9i2XnbmvO?=
 =?us-ascii?Q?C4aLWLSgd3sAv1Z9GSPY4Y3+IfOG6iI1X72/+OrHcvU+N1+TynnLDY1Z4c1d?=
 =?us-ascii?Q?ESDHIsx4l4n3cAl8of4KERv6FNUN9sQ65a2h0pHRTC52CG/P+tOWghUX0ac5?=
 =?us-ascii?Q?pI3OkFIYgL4LVG63eqw+xGmp2b7IM+OnoycygooHZCzR/WABMeZ5RR7ZSPMl?=
 =?us-ascii?Q?ZoEVrYxSb3deNKgwX34cPUG5RPtL8Fjdtazn0YwiiKSyON43rUmwrxD71yi3?=
 =?us-ascii?Q?c57XvYUl2W3GuVUPmTGc4lLUg/Cm3vdTpvRBETQV3tJv1D51M2zR0iORGTHz?=
 =?us-ascii?Q?JIovdcsNkCVGOuRaM9ZFfJy8SKBmOLQtJzvY1SCiiq6HTik+jwef8J1ROKOS?=
 =?us-ascii?Q?JYJUb4yKwEcUZpSXiL3xN/REM3XcAUyoxm5hmXxLbZsePChzB3JVPllhMANT?=
 =?us-ascii?Q?rW7JyZjn8flfX8YoE8QSmc/OTlEZi58GJ53AfOv97Um5LQyZcb4kv9hqY6DW?=
 =?us-ascii?Q?2XY20PPeIejxmNxU1H/nO711SSuAhOSTEBYaivzLlqObWVeR9EGIUFHGrlpu?=
 =?us-ascii?Q?67S1YlA/+t1HUKwzLnpS2ct3SVj9ZoFzt8PAjzI1P8tMreG5DbwGuT4dTEkH?=
 =?us-ascii?Q?KeL8/gWrC5p4O/ACGKNf/QTspivijfoqexVEWW8QvVxm0oqg4qpnWjzDjMu1?=
 =?us-ascii?Q?rZNLCrbp45vi1YJM4o0koy1JhsGpfqLKPDBRNrDRjU4N3Rx5yAEHAzn3HHRd?=
 =?us-ascii?Q?eQ0oU6HCx9lBBsq4blg5HwCb+Qjm8sUmBgp0HJF7FfHOhXzerGWpNtSmVbAp?=
 =?us-ascii?Q?NhBoywcAsCayvEkrmmpH8NzqlPJuSQ/0NTunCcqHU3IDAwL0DyL3nQBuSM1g?=
 =?us-ascii?Q?V8c4OKqbZYJqJi7pIdTr5c87VNQkWkgTLHj0cSDOpbi85ju06LW5TQ2eWfDw?=
 =?us-ascii?Q?L2+Oc43Bx6wOQXM3xF5BqjwmqZZRPlAIrBfjQFfsZUr+P7Q57Lxtn5J189od?=
 =?us-ascii?Q?cJ2r5/IX1/fXIJoAn+5+Ul4Z8rwrvKwhJ09nLwPZ2gmY6kM6XK5f+z5XR362?=
 =?us-ascii?Q?0UVUZvRfAAyksn1MvZYWrSJuohMXgjjaOWLbmGaTGUeRFOy7N8fxkJCA+l4N?=
 =?us-ascii?Q?XaWIhe2QXLuGMXfB/Mr+u1Ih+yuuit2QobEv/KS37cp+lh7LfSG9jlHKsjoe?=
 =?us-ascii?Q?fhHpCXWu7vfpiNK33OFlpZv/OCLnKlt+RNS7fCklSLKIdhnNbjQxiG96hYs6?=
 =?us-ascii?Q?NuzxsvRG2xGvOuoFFZUgn0Q2+L/ielSfN5wwZU60xVg+ErOeOoIxXamLpfJy?=
 =?us-ascii?Q?IKSlNogxon6knVOMn/VS66Su2KEXCZPNvN2jme5sgeGYkHBbSiY6VCBpdT4x?=
 =?us-ascii?Q?strVAHea1/cKYGcWyz3+L2gUvDmubqqnyNMn7yEdOKIuDKU0YQyPgkmnhaJy?=
 =?us-ascii?Q?ijTnrkISEdu+cIGCJHKb8jfVeDmLtKMFOCbhqvSq6JtwQVR53FOQvljTfrwm?=
 =?us-ascii?Q?GfYTqP+KxCWY1RdglxlAs1hdhCH/frmv8+Fi2CmG?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: efcf6aca-8155-4606-1cbb-08db96977548
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 16:09:05.6244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vG5RRPlpNce04xqo0RoVVHlNGi9OCxWaaxVQaMbVpJc30PBmRmOTvxadxDw6eBSK7umE7ovnyu96s6mPqk7/Rg==
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

On Sat, 29 Jul 2023 09:10:22 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Remove the blanket implementation of `PinInit<T, E> for I where I:
> Init<T, E>`. This blanket implementation prevented custom types that
> implement `PinInit`.
> 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v2 -> v3:
> - add blank missing line,
> - added Reviewed-by's from Martin and Alice.
> 
>  rust/kernel/init.rs            | 21 ++++++++-------------
>  rust/kernel/init/__internal.rs | 12 ++++++++++++
>  2 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 06ecab4901f2..040dc9a5f9fd 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -807,7 +807,7 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>  ///
>  /// [`Arc<T>`]: crate::sync::Arc
>  #[must_use = "An initializer must be used in order to create its value."]
> -pub unsafe trait Init<T: ?Sized, E = Infallible>: Sized {
> +pub unsafe trait Init<T: ?Sized, E = Infallible>: PinInit<T, E> {
>      /// Initializes `slot`.
>      ///
>      /// # Safety
> @@ -818,18 +818,6 @@ pub unsafe trait Init<T: ?Sized, E = Infallible>: Sized {
>      unsafe fn __init(self, slot: *mut T) -> Result<(), E>;
>  }
>  
> -// SAFETY: Every in-place initializer can also be used as a pin-initializer.
> -unsafe impl<T: ?Sized, E, I> PinInit<T, E> for I
> -where
> -    I: Init<T, E>,
> -{
> -    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
> -        // SAFETY: `__init` meets the same requirements as `__pinned_init`, except that it does not
> -        // require `slot` to not move after init.
> -        unsafe { self.__init(slot) }
> -    }
> -}
> -
>  /// Creates a new [`PinInit<T, E>`] from the given closure.
>  ///
>  /// # Safety
> @@ -971,6 +959,13 @@ unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
>      }
>  }
>  
> +// SAFETY: Every type can be initialized by-value. `__pinned_init` calls `__init`.
> +unsafe impl<T, E> PinInit<T, E> for T {
> +    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
> +        unsafe { self.__init(slot) }
> +    }
> +}
> +
>  /// Smart pointer that can initialize memory in-place.
>  pub trait InPlaceInit<T>: Sized {
>      /// Use the given pin-initializer to pin-initialize a `T` inside of a new smart pointer of this
> diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
> index 7abd1fb65e41..12e195061525 100644
> --- a/rust/kernel/init/__internal.rs
> +++ b/rust/kernel/init/__internal.rs
> @@ -32,6 +32,18 @@ unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
>      }
>  }
>  
> +// SAFETY: While constructing the `InitClosure`, the user promised that it upholds the
> +// `__pinned_init` invariants.
> +unsafe impl<T: ?Sized, F, E> PinInit<T, E> for InitClosure<F, T, E>
> +where
> +    F: FnOnce(*mut T) -> Result<(), E>,
> +{
> +    #[inline]
> +    unsafe fn __pinned_init(self, slot: *mut T) -> Result<(), E> {
> +        (self.0)(slot)
> +    }
> +}
> +
>  /// This trait is only implemented via the `#[pin_data]` proc-macro. It is used to facilitate
>  /// the pin projections within the initializers.
>  ///

