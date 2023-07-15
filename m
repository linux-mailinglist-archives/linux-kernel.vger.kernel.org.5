Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAE37549F8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGOQA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGOQAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:00:24 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2107.outbound.protection.outlook.com [40.107.11.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6206B2729;
        Sat, 15 Jul 2023 09:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aegxS62Lg7pxfwCmx8xWGJF9mRFciQWf2gGBd9mTEwWMtfmS80uksn171cc8Tqxf5FlNpIZFBLBMee7VB8eyv/2+rG1dz3TrkmG/wTSNLpl55HJrmSna/FTWU4eKFi8cm5szV1sgPFMt+yLQx38UVFcdhQPowv5MMyUM5Diyl5K0fHKh+cWpKHFrakzrX6x9Xfr03QU1REmKLKmYj4cUSLz66TW8CemPhTlTuhY/4GvM3xLDctmOnbiUSoNj2j4U0/U2lQMgNa9v864eu5yaktujDeaD21sy6zbSaibMzU2hLvVW5fow8e8O5iqggwhmBOF8wcy27F7po4Mfp0TkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXYCgRWFE+ouQ9u5azI7i4FWpw16uegd4+p2bQXtBkg=;
 b=ffAt9M+NbAmoGawMwTHgVIhvziZca6o8qS96i3ZqO22IODTxuCphbPyjh+LweaVkXOvf7IMFaL0FQ2pdmWthC6stuiKBpAkM87wtW6xKyr4lQJlJ6M87RP+bgzCswUEAfevDvADLxPXj16xgQ9hoiMRBWAkL9SqfyZMUInTk9/xDzx7w1qKnaVQJJYQcKzuHIAFa5wUKzM2iWnmVsQ3ga3T5YuHpZc3F/2q44oeIG0ULokRky6C8Q5/E97if3hNCtl+uvyDruBJB95vpMKccB6mJzcTMjlDS3v34xvjuFYnzfeAlLzP7hwdgEtOj5xb862noep1d32HD763z5tRJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXYCgRWFE+ouQ9u5azI7i4FWpw16uegd4+p2bQXtBkg=;
 b=iwQOvRbLPxMsgWPGPCgg/jIGm32fDeg8F6APskHYFR8td0zjN6KlK1FmvP3FZefeVZZkz2ty9iNk8RrqqDt5cEwVrXYVoeMmFgvJDMK0ooGgGs1o643V1OlWsCdmfZp9d6cR6+IeHq7pwqe21OL6rYzrKxa6fEXZq/mbgfcqDuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6635.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 16:00:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 16:00:19 +0000
Date:   Sat, 15 Jul 2023 17:00:18 +0100
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
Subject: Re: [PATCH RFC 11/11] rust: sync: arc: Add lockdep integration
Message-ID: <20230715170018.4c58d854.gary@garyguo.net>
In-Reply-To: <20230714-classless_lockdep-v1-11-229b9671ce31@asahilina.net>
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
        <20230714-classless_lockdep-v1-11-229b9671ce31@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0316.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9c38a2-d6ee-46ed-5103-08db854c96cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxuT7ZiILzBsn80hY7go4j0mmdgqKV2jAEAo5uiygPDH3kA9cFbEJptf2nrvEeHjFZZB1PdtXFoCnlVqUT+eUsRdQphmyRBOC8jyXHxWQjrMu/nToxHOundalnsu0JHmsLD82fnCSgW0/6Dv6oXWiiDu9bniaAJP+wFgFYOGDV8MSp7iX+avZJ3yQR11lBQu7NKM4gRT7zPrRzjqWM0dTmRe660N6jfqFZqCBtrOksPhTYhu7pgTi9q9pemeIrKQ+gCQyESOP6wXhH10egWdw0HYPSNH2cF5s6wULjJDV6yggkRTHYQPcj7kbGbXZjI3HlK8lc3oU1HWYzpsjQDBz9oAizg9zFZv/Cq5IQK9v6zbDMHreQVBkJSX/KNgVGyxvGMUTlPDJueTmWQ/dGTfXdkECbdvXdUvu2wjWie1nk/jyWs1YaS892szg7v+EusQ6MGX6rVsXm/O60gGEylLEMCWYz2v4CTkOD42CHw8RPt4NZm83EeeTA6IggVa7AaHpehR4XrurEzV2SC5pJxDalPOMtXVDIN0elbUY/NO3AyeMHifruS9ks4shVcM/H22
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(136003)(366004)(39840400004)(451199021)(1076003)(38100700002)(26005)(6506007)(186003)(2616005)(83380400001)(2906002)(36756003)(5660300002)(7416002)(478600001)(54906003)(86362001)(316002)(41300700001)(6486002)(8676002)(6512007)(4326008)(66946007)(66556008)(66476007)(6916009)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CnlsEnfyAitMFRh1RIaKbsIWJ33786nRdXTdJfc9zKBFLs2GTKbzPIsATXET?=
 =?us-ascii?Q?a0efEpcvxh97qxJBtVTwRAgbgXxA3KcUT1iCQs7A3Hk7BJXpoBjT0VBqqalk?=
 =?us-ascii?Q?f6yEl/2E9TFikRshML5LMAyq4IxXDrGigcz6LvEKIIHF/8gBDyrcmR1PgIp0?=
 =?us-ascii?Q?CVmNqy2oVh/D6GvCgp+1KgHE3jcqA9B5iCfgB+GDS4ynMXkfasGeObsbrTbL?=
 =?us-ascii?Q?pq1WEX7dZDflzJP8KlvQiTBH+taYaMAcnmgkSDm5hBfBNe1koWujpJ0rkF1N?=
 =?us-ascii?Q?lx8K5H5sliSGk+rFpjf6IXmtlYB5odkmbqNW3Blzs4UVKMF7wMLr3XxqEOor?=
 =?us-ascii?Q?prvVnOvswz/ANPR5Rx7S7cUtaTE9nHTH1FevhH3Rp3kkD8eCTqs0aKNOwo36?=
 =?us-ascii?Q?37ZYZBJItbf3+miENapW1GP1F8wjZ9q6qvfR29e0izG0fk0OvcFJZDq7ukya?=
 =?us-ascii?Q?wXv+OWcBlRUuKrF6C46rj7QwVThRs8gKFEZs9To4KSxvoP3nn+hq+pdZIkAY?=
 =?us-ascii?Q?pUiZi/u5ApXeWUDJto9WAoUpVVAIC4GeRAfBF2Cc4bYPlwKE3CwwhDINZeb4?=
 =?us-ascii?Q?1vCT1BIryFu/CLuq4n6IO+dLvtgVGsvcclA044R3DlqM5Vq8o1K4MCEzYwFu?=
 =?us-ascii?Q?WwecgB7+tuBx4BdxAtoAH3lHrmBPrD5zLKCiARtcDh6FuV3anwNLHERgtdDo?=
 =?us-ascii?Q?yP6n+308ELSEZBbHHR30+W919X4jd5LvFpk+s8DunC1bXic3A3Ulv4u6q1la?=
 =?us-ascii?Q?gBNIrUuGYsODnHZhKLhFPVzFtAqGtoqp9DcN8QCeM6QxD2iq9WQ4kqs+PH5Z?=
 =?us-ascii?Q?qwI4LAw6dbnT+KTtUiQIVnC2Wwd8hN/CIulCj2zWg1IhgBL4qTSuI9LYTiSZ?=
 =?us-ascii?Q?4hqePlAerxiM+DPf/STWRWuZSJ58vj3PH/aB6KJnBeox7wzGyHdZjhxgOIEF?=
 =?us-ascii?Q?raHTxi4cO/BBhai0SZWrZZHNhn/LQf6qnGBJFT3znVoXQt+X3wWko+X/6SWq?=
 =?us-ascii?Q?CxQ7rTy6i6kkUxp4bWzZAJ1s9VaNGBbPY1xo0OInTpzcLJPRaV4qtU7Tvsq7?=
 =?us-ascii?Q?7i/yw/BD/fWuba74sk2vcJUYjeIMDjCyDcGo65rXUZrVamZuvKJo3y5Z47G2?=
 =?us-ascii?Q?az/GfqIhgZaUXESeTOvgKB2gB20P8EZy83XnfIWma1QD5aWGjwwFtHJkMZVk?=
 =?us-ascii?Q?kDzYvPHiQqIt5T5mwNJ6FDcDtV3TtyT0Xlv5fbeoOnGeJdfb5WtcaIOI54Xh?=
 =?us-ascii?Q?0tQj9xBjpoGASol8tnfYN/tZMaag2NlrLf6QOGMiwCmxLBYW7zaOlDQQ4CFt?=
 =?us-ascii?Q?rG8FtyoW3Idw75M3G02hs5FgTZHE0AdmOgy4DalTd8EyWI2DJjEw4560+Gqr?=
 =?us-ascii?Q?yqCrfpPz1/tQ+awQ0mtHHx6l8YteDiwsnSl5jk/EsB8rea+50TiOoaXUv4Ek?=
 =?us-ascii?Q?KclB1mSOYj1ickReyJE0T9LzLY72H8v4PsmCdlfpe5ATQaHBqcnSSHAG/xJi?=
 =?us-ascii?Q?GK3BX81jeNmz55VdzJWAiSQhsvOJKAp8hVmpZdLkH74VsY0RS6VkvAFBP8Gr?=
 =?us-ascii?Q?DWc4TPEtuWixhquGIeVNQ0Tw4AfX83DYolwAraBV?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9c38a2-d6ee-46ed-5103-08db854c96cd
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 16:00:19.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCqUeH/VuldLzWkkZCjctlDieN6tPlORrvXKUiTuFzysHjyJXT2nTc1k8MWgYGjjy5uIJD8NILMdkLJHfjJ2nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6635
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 18:14:03 +0900
Asahi Lina <lina@asahilina.net> wrote:

> Now that we have magic lock class support and a LockdepMap that can be
> hooked up into arbitrary Rust types, we can integrate lockdep support
> directly into the Rust Arc<T> type. This means we can catch potential
> Drop codepaths that could result in a locking error, even if those
> codepaths never actually execute due to the reference count being
> nonzero at that point.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  lib/Kconfig.debug       |  8 ++++++
>  rust/kernel/init.rs     |  6 +++++
>  rust/kernel/sync/arc.rs | 71 ++++++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index fbc89baf7de6..ff4f06df88ee 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -3010,6 +3010,14 @@ config RUST_BUILD_ASSERT_ALLOW
>  
>  	  If unsure, say N.
>  
> +config RUST_EXTRA_LOCKDEP
> +	bool "Extra lockdep checking"
> +	depends on RUST && PROVE_LOCKING
> +	help
> +	  Enabled additional lockdep integration with certain Rust types.
> +
> +	  If unsure, say N.
> +
>  endmenu # "Rust"
>  
>  endmenu # Kernel hacking
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index f190bbd0bab1..b64a507f0a34 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -1208,6 +1208,7 @@ pub trait InPlaceInit<T>: Sized {
>      /// type.
>      ///
>      /// If `T: !Unpin` it will not be able to move afterwards.
> +    #[track_caller]
>      fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
>      where
>          E: From<AllocError>;
> @@ -1216,6 +1217,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
>      /// type.
>      ///
>      /// If `T: !Unpin` it will not be able to move afterwards.
> +    #[track_caller]
>      fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
>      where
>          Error: From<E>,
> @@ -1228,11 +1230,13 @@ fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
>      }
>  
>      /// Use the given initializer to in-place initialize a `T`.
> +    #[track_caller]
>      fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
>      where
>          E: From<AllocError>;
>  
>      /// Use the given initializer to in-place initialize a `T`.
> +    #[track_caller]
>      fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
>      where
>          Error: From<E>,
> @@ -1277,6 +1281,7 @@ fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
>  
>  impl<T> InPlaceInit<T> for UniqueArc<T> {
>      #[inline]
> +    #[track_caller]
>      fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
>      where
>          E: From<AllocError>,
> @@ -1291,6 +1296,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
>      }
>  
>      #[inline]
> +    #[track_caller]
>      fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
>      where
>          E: From<AllocError>,
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index a89843cacaad..3bb73b614fd1 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -34,6 +34,9 @@
>  };
>  use macros::pin_data;
>  
> +#[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
> +use crate::sync::lockdep::LockdepMap;
> +
>  mod std_vendor;
>  
>  /// A reference-counted pointer to an instance of `T`.
> @@ -127,6 +130,17 @@ pub struct Arc<T: ?Sized> {
>      _p: PhantomData<ArcInner<T>>,
>  }
>  
> +#[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
> +#[pin_data]
> +#[repr(C)]
> +struct ArcInner<T: ?Sized> {
> +    refcount: Opaque<bindings::refcount_t>,
> +    lockdep_map: LockdepMap,
> +    data: T,
> +}
> +
> +// FIXME: pin_data does not work well with cfg attributes within the struct definition.
> +#[cfg(not(CONFIG_RUST_EXTRA_LOCKDEP))]
>  #[pin_data]
>  #[repr(C)]
>  struct ArcInner<T: ?Sized> {
> @@ -159,11 +173,14 @@ unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
>  
>  impl<T> Arc<T> {
>      /// Constructs a new reference counted instance of `T`.
> +    #[track_caller]
>      pub fn try_new(contents: T) -> Result<Self, AllocError> {
>          // INVARIANT: The refcount is initialised to a non-zero value.
>          let value = ArcInner {
>              // SAFETY: There are no safety requirements for this FFI call.
>              refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
> +            #[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
> +            lockdep_map: LockdepMap::new(),
>              data: contents,
>          };
>  
> @@ -178,6 +195,7 @@ pub fn try_new(contents: T) -> Result<Self, AllocError> {
>      ///
>      /// If `T: !Unpin` it will not be able to move afterwards.
>      #[inline]
> +    #[track_caller]
>      pub fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Self>
>      where
>          Error: From<E>,
> @@ -189,6 +207,7 @@ pub fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Self>
>      ///
>      /// This is equivalent to [`Arc<T>::pin_init`], since an [`Arc`] is always pinned.
>      #[inline]
> +    #[track_caller]
>      pub fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
>      where
>          Error: From<E>,
> @@ -292,15 +311,46 @@ fn drop(&mut self) {
>          // freed/invalid memory as long as it is never dereferenced.
>          let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
>  
> +        // SAFETY: By the type invariant, there is necessarily a reference to the object.
> +        // We cannot hold the map lock across the reference decrement, as we might race
> +        // another thread. Therefore, we lock and immediately drop the guard here. This
> +        // only serves to inform lockdep of the dependency up the call stack.
> +        #[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
> +        unsafe { self.ptr.as_ref() }.lockdep_map.lock();

Make the intention explicit by

	drop(unsafe { self.ptr.as_ref() }.lockdep_map.lock());

and make `lock` function `must_use`.

> +
>          // INVARIANT: If the refcount reaches zero, there are no other instances of `Arc`, and
>          // this instance is being dropped, so the broken invariant is not observable.
>          // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
>          let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
> +
>          if is_zero {
>              // The count reached zero, we must free the memory.
> -            //
> -            // SAFETY: The pointer was initialised from the result of `Box::leak`.
> -            unsafe { Box::from_raw(self.ptr.as_ptr()) };
> +
> +            // SAFETY: If we get this far, we had the last reference to the object.
> +            // That means we are responsible for freeing it, so we can safely lock
> +            // the fake lock again. This wraps dropping the inner object, which
> +            // informs lockdep of the dependencies down the call stack.
> +            #[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
> +            let guard = unsafe { self.ptr.as_ref() }.lockdep_map.lock();
> +
> +            // SAFETY: The pointer was initialised from the result of `Box::leak`,
> +            // and the value is valid.
> +            unsafe { core::ptr::drop_in_place(&mut self.ptr.as_mut().data) };
> +
> +            // We need to drop the lock guard before freeing the LockdepMap itself
> +            #[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
> +            core::mem::drop(guard);
> +
> +            // SAFETY: The pointer was initialised from the result of `Box::leak`,
> +            // and the lockdep map is valid.
> +            #[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
> +            unsafe {
> +                core::ptr::drop_in_place(&mut self.ptr.as_mut().lockdep_map)
> +            };
> +
> +            // SAFETY: The pointer was initialised from the result of `Box::leak`, and
> +            // a ManuallyDrop<T> is compatible. We already dropped the contents above.
> +            unsafe { Box::from_raw(self.ptr.as_ptr() as *mut ManuallyDrop<ArcInner<T>>) };

I feel there are a lot more `as_ref/as_mut` calls than it could be.
Could you refactor the code to make a single `as_ref()` call for the
non-zero path and a single `as_mut()` call for the zero path?

>          }
>      }
>  }
> @@ -512,6 +562,7 @@ pub struct UniqueArc<T: ?Sized> {
>  
>  impl<T> UniqueArc<T> {
>      /// Tries to allocate a new [`UniqueArc`] instance.
> +    #[track_caller]
>      pub fn try_new(value: T) -> Result<Self, AllocError> {
>          Ok(Self {
>              // INVARIANT: The newly-created object has a ref-count of 1.
> @@ -520,13 +571,27 @@ pub fn try_new(value: T) -> Result<Self, AllocError> {
>      }
>  
>      /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
> +    #[track_caller]
>      pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
>          // INVARIANT: The refcount is initialised to a non-zero value.
> +        #[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
> +        let inner = {
> +            let map = LockdepMap::new();
> +            Box::try_init::<AllocError>(try_init!(ArcInner {
> +                // SAFETY: There are no safety requirements for this FFI call.
> +                refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
> +                lockdep_map: map,
> +                data <- init::uninit::<T, AllocError>(),
> +            }? AllocError))?
> +        };
> +        // FIXME: try_init!() does not work with cfg attributes.
> +        #[cfg(not(CONFIG_RUST_EXTRA_LOCKDEP))]
>          let inner = Box::try_init::<AllocError>(try_init!(ArcInner {
>              // SAFETY: There are no safety requirements for this FFI call.
>              refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
>              data <- init::uninit::<T, AllocError>(),
>          }? AllocError))?;
> +
>          Ok(UniqueArc {
>              // INVARIANT: The newly-created object has a ref-count of 1.
>              // SAFETY: The pointer from the `Box` is valid.
> 

