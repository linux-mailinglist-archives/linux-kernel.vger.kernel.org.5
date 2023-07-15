Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C20875495A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGOOaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGOOaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:30:05 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2138.outbound.protection.outlook.com [40.107.10.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27384E4E;
        Sat, 15 Jul 2023 07:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BftPUfT4Chz0cGK1R9CGXByrUpSlywApAHxitvOsPLmNINkFfogRyfwXRw8doCwWRythmCVk9gDRxw2Q5Uz4m3ecBgT2L6xv0M4pswsqJux5Dm4bZ4k+cm5CpDsDkOVWTYhhvORb0KYyn5feo39m9ojpbYVA5Fgh2RWuJ3mdPU/YAxTCqdKn7sv26AMpT0YlURtkU7Eg7pJGijxlgs7XEQPDJpP5/9LjA0InyfSNPq3lY/Ljf9HnsO6jgzQxkQSFcZYM9wCze/JYwbmn9KHLlDLbR1XQ+EntJjhK//gsmt01F+xYWFonnepfnZI9q5CyuyCIPD5kMmpM/5d3GXb/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSni92YchIqmk0kjLLtMpnJkPgkBEOUB/GKKTpy8Etk=;
 b=f0UKZqJGeBjvxmJkGh/q5hGRYyfONiLZ9u0B8j5XsuSkpVopIsLLJuifWrUBoEu9jtw5ujmXnqWymk4Jalj+8TqmiQDccUnQdwk30tj+4FpuDPuEtkqhz9TgMHdzVHRhPBOUAOAW3P4MEaysWCFoYFGcELCaJhdRmSYjHRfg0ZFpzXmF9J46t2XE752klLXhzJxR+xbpJYpQfPS5KSehooJeNbKjJBjn8fpL7QMWPFsN6e7YZlzVgmSlLaljnfFA3H5RbK1jufJhcxLIsez6I4MhDT7txTjBT7PWN5LmzW03KExAuKxSets7UTutNZisKkLHaPyunOADBLEz1YJI6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSni92YchIqmk0kjLLtMpnJkPgkBEOUB/GKKTpy8Etk=;
 b=fq/LslKBIBPeiOW50wCmJxJEyUuKqWcGv553ezEK8F1duT1zx2JYgQNxS9rIKj+uj9KNDWZbzGDp+jwAt15O/WjqIhSxE9TKAXp1LtDRpoD9S9BcdpEkosB99QY02ki+Yw9HcQ63+RSKBLnPupwcN5pRiOK06y4wehBYmceY8Us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5842.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 14:30:00 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 14:30:00 +0000
Date:   Sat, 15 Jul 2023 15:29:58 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH RFC 02/11] rust: lock: Add Lock::pin_init()
Message-ID: <20230715152958.527fba87.gary@garyguo.net>
In-Reply-To: <20230714-classless_lockdep-v1-2-229b9671ce31@asahilina.net>
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
        <20230714-classless_lockdep-v1-2-229b9671ce31@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0242.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::16) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 450a2488-4dad-430d-783f-08db853ff857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hFTylMusHX2ET9butq3JH+mO0WUjL1K9gSEPCinphvOQxqwsXnrispWcJLr3ptIZ3dPUrh2K1+DGAV3P0DxJbn7Jt6Ck9q0/fIwBb2XjwVJpAmpxQqYpuCOtUY5LfTEdFDO83EQ+lNOuaz9veOyi9ugzxykHjGyhpUg4CndQ8W3N05J50OjXXFKlQdPBkmOJbKrxF9fCo64KJJ2T+SUaKh5azD4H9gudi/f0/jn8uJPGLMSWPV07pmY949t1wsjj/tf4I4tOxLefwfdlP/DDUlep3/lVXC1d1WMg5TGcS3uM7N8U9sqS/G+oEC/+YtnBTa5Kx5xKaD4H+yhN0JcT23EV5hx18C2cAanlCBPMdxDppWDoUW7YWPhvLeD/PfDqVWX3TmGIl1P+dsLQahICXz/5LuiLMyi96QH9hUBG36tXHaTxJXpSdq3SWrUXtv1z/p+BFnDMp9nYysCHWASSLFl6wgF8AZMh4nPfs40LE169mTMBWvairRG+qw/lwdjhDOzebFx0AMZNj7j9q00/K9p3aEm0X+iYI4gcjic3N104NKS5LIJHNz8NtTD7pqwQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(396003)(39830400003)(346002)(451199021)(26005)(6506007)(38100700002)(1076003)(54906003)(478600001)(7416002)(5660300002)(8676002)(8936002)(4326008)(66946007)(66476007)(6916009)(66556008)(6486002)(6512007)(86362001)(41300700001)(316002)(2616005)(186003)(36756003)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OeF0YcZnZ0v7Q5d3KX49OOEWPlWv96luqwJkOO/41NY1vsRQbY09GlBG3guy?=
 =?us-ascii?Q?+6Sq4JuUeZXmAEyMEzB6NhB3Z3Uxp8plka47sLVq+eqpVIwQKf6laUl2/P0a?=
 =?us-ascii?Q?chNZnwuaR4T5rAQ2Y6uJqi/u6Qv5njbk8/jv+9go80VhK0+VVIVybFRJfZ4I?=
 =?us-ascii?Q?epWB/n7UB3pdy6Q/K6pi5uKMUNR9N9SIKoLy4G0rAc1xc2BLFC9B38WA7CR6?=
 =?us-ascii?Q?HuLozasJowJAE5OR6vQTmFdZF/8hzaz3ySw/F1e5Orkwzt+3F/fZOYTN/37y?=
 =?us-ascii?Q?FPIToSBQ92XnsAPP8MMFy3veXucAwv1zJzArX3JY0DdXEClEbjHPyF3gEdNC?=
 =?us-ascii?Q?I3yqzny0RRVuutiGFn8cOx7gIfatqL2wn9BpuCMs1HI0yXdAF3miDVq3gxpS?=
 =?us-ascii?Q?EdINaUWxSoGUYl9y3v27NdWPRUb5XUSh+LaBb9tMEkL0V8JyWsOwb3NHyg8f?=
 =?us-ascii?Q?qlQo1WkruZU8htNvNe1tkoqFYIQC5h5RjVi7z1JEKrBhu+yCC+RwC/DFwic4?=
 =?us-ascii?Q?NjgDzeI6ML5ecTOuKIOiSM8v6RcVlNjZChRVF7bce7bx0BCtIJujFrvpcRCW?=
 =?us-ascii?Q?daMqBFIAqwV8V+MrtXFapgRJLFgWBXADgPuHczpMBhqdQiKQ4YfYR2vlXe+V?=
 =?us-ascii?Q?8eX3uEjF15+lnxlTzojUf501w2bZLPgxo/2ZGZS2R205FRbentDpH74u3fa7?=
 =?us-ascii?Q?xUzbJtk2vH82jWdZGEVFOyWwd0jbj9QHcbDBDb40ipEI0q8QJjk5samkBvGj?=
 =?us-ascii?Q?dqtEwZZo1q+2/KUoiDTSX51bTR5GS7W4WF0LVsuylW+oGZnNBvLJrZ4F0SMd?=
 =?us-ascii?Q?uthwjSR+rsxCnE9Ngp6xHHDr0yIeWI9wPvmSCWw8h0jZaGEHztXG6hsqV7ze?=
 =?us-ascii?Q?W8XRW1R0H55FkM4QFZ81gVUP6fA3aN0uqCRZ+JjWixxv0tRWrQF3gSmiax++?=
 =?us-ascii?Q?vZ7PE4j1QHIn6B9TQtxazbMut+YgnRqBjyM78LeFevBgjyaMBG/ToQA4IrfL?=
 =?us-ascii?Q?8Y24TmYetxctxUHYg25JuBtYsmdcm2RLFeIW0Kw55EbHVANIpzwa2ZTGJDg4?=
 =?us-ascii?Q?ZRUtYDugqGhyP/qizXs9YmwxElf8/uH9HkK5HzeLqi42w6AJl41pyD5qNDj0?=
 =?us-ascii?Q?OV601s5NnmoyYwH4aVCv7oWqCaYkXTb18LZ64s8kQXgMKuWneVCUnEl+B5sS?=
 =?us-ascii?Q?NGy+IdcEec9GavQEuLnK5sgMDUoDlys6KFR9O4lgTchloMPsJu9ndB/f563J?=
 =?us-ascii?Q?1jpZ3gNWamI3+k4CIcTcK+NKYHknIIOL2z54WAjzXL3804MNqnR8HJ4+BWjR?=
 =?us-ascii?Q?jBdYQqTCMs9ovFnFLLg189xo0A1p7qWkLQHUL6Rsmiy0OCOEndogVyOsfE4i?=
 =?us-ascii?Q?dhflJtT2Mi7YnaAo61h/PKbUTEXl+uue/0oSG14LRKGDWQxnuZFGHccP/RJb?=
 =?us-ascii?Q?M2ptifn/Tj64XmPaiwtlTD0PHXzPzE74FCdEm8AftK7n1fdaSoH2u+NclxZu?=
 =?us-ascii?Q?gglsoe1vgUvbm9EM5mjqBR4qoa+rgXjE8N2TnA0KM6+zYjoHrdH9BVgYfkGm?=
 =?us-ascii?Q?qGkMDkbvJqA77oxmopFuEDuAXj+SjplCLZExTUp2?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 450a2488-4dad-430d-783f-08db853ff857
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 14:30:00.0284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFtxAxNNqyAsBxxg+qKhs9mm5L11LNadjHJFom6e3k8KhdZTAI+JRzxtlLD8Iv6fcgiILI3B63AGbxNEjH9GWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5842
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 18:13:54 +0900
Asahi Lina <lina@asahilina.net> wrote:

> Allow initializing a lock using pin_init!(), instead of requiring
> the inner data to be passed through the stack.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/sync/lock.rs       | 30 +++++++++++++++++++++++++++++-
>  rust/kernel/sync/lock/mutex.rs | 13 +++++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index a2216325632d..d493c5d19104 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -6,7 +6,9 @@
>  //! spinlocks, raw spinlocks) to be provided with minimal effort.
>  
>  use super::LockClassKey;
> -use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
> +use crate::{
> +    bindings, init::PinInit, pin_init, str::CStr, try_pin_init, types::Opaque, types::ScopeGuard,
> +};
>  use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
>  use macros::pin_data;
>  
> @@ -87,6 +89,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
>      _pin: PhantomPinned,
>  
>      /// The data protected by the lock.
> +    #[pin]
>      pub(crate) data: UnsafeCell<T>,
>  }
>  
> @@ -111,6 +114,31 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
>              }),
>          })
>      }
> +
> +    /// Constructs a new lock initialiser taking an initialiser.
> +    pub fn pin_init<E>(
> +        t: impl PinInit<T, E>,
> +        name: &'static CStr,
> +        key: &'static LockClassKey,
> +    ) -> impl PinInit<Self, E>
> +    where
> +        E: core::convert::From<core::convert::Infallible>,
> +    {
> +        try_pin_init!(Self {
> +            // SAFETY: We are just forwarding the initialization across a
> +            // cast away from UnsafeCell, so the pin_init_from_closure and
> +            // __pinned_init() requirements are in sync.
> +            data <- unsafe { crate::init::pin_init_from_closure(move |slot: *mut UnsafeCell<T>| {
> +                t.__pinned_init(slot as *mut T)
> +            })},
> +            _pin: PhantomPinned,
> +            // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
> +            // static lifetimes so they live indefinitely.
> +            state <- Opaque::ffi_init(|slot| unsafe {
> +                B::init(slot, name.as_char_ptr(), key.as_ptr())
> +            }),
> +        }? E)
> +    }

I think you might be able to just modify the `new` function? We have a
blanket implementation

	impl<T> Init<T, Infallible> for T

which makes any `T` also `impl PinInit`.

>  }
>  
>  impl<T: ?Sized, B: Backend> Lock<T, B> {
> diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
> index 923472f04af4..06fe685501b4 100644
> --- a/rust/kernel/sync/lock/mutex.rs
> +++ b/rust/kernel/sync/lock/mutex.rs
> @@ -18,6 +18,19 @@ macro_rules! new_mutex {
>      };
>  }
>  
> +/// Creates a [`Mutex`] initialiser with the given name and a newly-created lock class,
> +/// given an initialiser for the inner type.
> +///
> +/// It uses the name if one is given, otherwise it generates one based on the file name and line
> +/// number.
> +#[macro_export]
> +macro_rules! new_mutex_pinned {
> +    ($inner:expr $(, $name:literal)? $(,)?) => {
> +        $crate::sync::Mutex::pin_init(
> +            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
> +    };
> +}
> +
>  /// A mutual exclusion primitive.
>  ///
>  /// Exposes the kernel's [`struct mutex`]. When multiple threads attempt to lock the same mutex,
> 

