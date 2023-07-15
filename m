Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8A47549E4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGOPrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGOPrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:47:53 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2109.outbound.protection.outlook.com [40.107.11.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14902691;
        Sat, 15 Jul 2023 08:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHPswnRb9tuAUBLULj5rrTID2UbevJ6v8pAEk0creS8jIYvKheRMXY+wv/mEvCm4Rzcb/wqQcvxJJh8YFxJrqshAs1aHGdQyi+K38xdKY4D/rowtbnV9JDTWIv3M1VGWv/4X40VICQwhblQa0eH69cUQtFtaOu+vcz2JONhqYk42I+GOxrnkn4SbUneXCJhLNG3AEOAnB2yIeRqHXHl7lpnTVrxLulF/dFutU0mP8oxGSOvjchLxzf8D3W0zqwgUA+hF8Fk8kswSSMI/3gN1GtWszHj2JVNEDXIaeYCGnyyB+dR++Fe0y/kew1SmH3V+7pDDTkwo4imj24tjvyxVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vd092fvSDWydGFLfQuY9jxv3QRB3jCUMnL7OD944cnI=;
 b=ndFBkiIpjUHiDHrNjNAgHpnGbZzgyak161SwSca6KrYOm6nH3iKRLlaAwunvW+s7rmSTGhUjIKLXKo/NT3sYXXhmW2tv3AK55SgGeRjhXg7ere4ig06ekimzM4Q8fQyD4yu+4SMdF6guamLnNQ7q5qrkjSGw4xSsx0blUydhAh+I2iSfXTXthxrDVpkHD3UUJGSnz4e5VjijufduS9cEv9FgO9OuUAq4extMhOHjVO7D/oMXoccmy5gd7atE9Tc7Yab+E2CBLUD01XJD5valJ5EUSUli6USmOF4ZLoOhtjtjA1QNOKEMqIMuImMSJRC4NCpvxmBI8WFxL2nxIz8MGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vd092fvSDWydGFLfQuY9jxv3QRB3jCUMnL7OD944cnI=;
 b=jMrA9dCNdCkNHfQAdrC7XYwVJ26Eywx8ATi0ToWlL73njN/EZOpcZljcaElj/Pcswj5GKCzG3eMxBWNgheE5PMs7rN0RpOIYQn8Vy/uYwIEnDysJ5CBcj1QKIYXKt1ziYRHJD7vmJW3AtH6KKL4lMJ9R+VYTAFsGtXKssdnXTR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB7284.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 15:47:49 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 15:47:49 +0000
Date:   Sat, 15 Jul 2023 16:47:47 +0100
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
Subject: Re: [PATCH RFC 07/11] rust: sync: Implement dynamic lockdep class
 creation
Message-ID: <20230715164747.7ba23b36.gary@garyguo.net>
In-Reply-To: <20230714-classless_lockdep-v1-7-229b9671ce31@asahilina.net>
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
        <20230714-classless_lockdep-v1-7-229b9671ce31@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ed79ed-77ba-4d4c-1b22-08db854ad77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSjYL7ByM2X4MniQJujwm+ArcgKZl/zuuN7BXtKr5yFds4t6jcSw6KRHzZ9CmzaJ/8QGdRU+YTopSiOMyXeRH8rwUhhOwK9QBEnVTp33TaJVs0R3yuygV7VjZdimwyFFwU8zXAZD30yTy8MncAk/+QIMpUjJm0T5CRIK+8ILiPl9lUxr/jCdLKAJe/LK07ZGRSZp9y+kr5xz4t023SFdOhCqYcyRM6qx1IMa2KUZx7ESlh+uSy1Y0xAtg9ucvOMm6sjPxHrns5iZefGxdTPcy3v3HeZPWzyNdGxc46WlDz10HWHZZBqP9L+STaFpWA5lihBwtz6IqfjQhpEzRXgw+YzX7YorulBwL4Ioe1NPs20FEOMMrT5AyFDXh7Y7MB/X3+1KjDEO14UXqBNir8uP97HPiwa7Y50HoDiFXZsXNCiHuRboQCoIHUhQ82Ay+eSQcMlA8oOGLP/2J7yNZSkCG8uzCLKjB5gwdfsoq4f7Sfe9CR7zw8rui98R8ESzzKA+DLV+381pYner2HF0Z+Ae78oh0m79eEoB+rhRBxCvScjuUIAYHaqm/oQCmwsxMV1L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(136003)(366004)(39840400004)(451199021)(1076003)(38100700002)(26005)(6506007)(186003)(2616005)(83380400001)(2906002)(36756003)(5660300002)(7416002)(478600001)(54906003)(86362001)(316002)(41300700001)(6486002)(8676002)(6512007)(4326008)(66946007)(66556008)(66476007)(6916009)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?atS8ngO67Ev7qhqaCRkzo6/ZnsMn70wmkWZ0Wc5SOVGeANAxeUJ+XCPCzHhL?=
 =?us-ascii?Q?bEHFX2XN4MyjiZcY3UY8q+B+eQzXDT/kYx8JMLpoiKXhqPi4AXJopgtLtk6x?=
 =?us-ascii?Q?ug7oIV3MIySGbvHzOePMztXI025KfizOyMUaeAHRZL1u9SbyHwt9wyEaC9tU?=
 =?us-ascii?Q?Q/I56O7cU1/q40JXqkyfH5L48/0D6LcZMvEsEPYuWDtdIWJ66WvhWjjB38gT?=
 =?us-ascii?Q?nKmxv35wPr5v7srUwQ2hCcTg3I0XrXBkpEcNzTXZrWEd9XqHimbu59aKgU+C?=
 =?us-ascii?Q?vYuxGaVpXmw9fgiSL1fLg6VPTKle+jREl+RZ/Pt91unPY7Vbp780q5lW2E3S?=
 =?us-ascii?Q?BnXh9mExElLnsI+CAg8x+zqcsC6YscwVkGCnoo5lvEZCA5j6+O+4RMparHLb?=
 =?us-ascii?Q?kli3nVSqMAkFY2eqCtNM9g7esWIDJWnVRAzkKwwgGppbtI2qq2YKzis1UyAv?=
 =?us-ascii?Q?hkpcHxki6DoYOy+LjjEDq5vHcRau+4THxDSeGVLW1yX9MQh70hgTGd0dnpeY?=
 =?us-ascii?Q?ItDgBqw93PQPn4vu7VVM9cwHF3sW3b+edlQoFFwa1pxToinRfTcX3F1wbgmJ?=
 =?us-ascii?Q?0NNILgxNt/tu9Xne27baHxJFIx9pbMFHJ/ORqRTt+8besOFrMWK7rfnvDFXe?=
 =?us-ascii?Q?czRWl/xI9Qugb18LKtvGYVJzXbkZrhg4VWtHfD+II6Nxom9EQPgYPCqSZy3p?=
 =?us-ascii?Q?crYbRAnieQIKVlDOScx2Q7420QD/jD2p0HTkiQ6qWgx0NckuuF3Cuq7JS5TH?=
 =?us-ascii?Q?Lnd+aljP1KEouikfW/8Wu/Qx/iSjW2XxxAWl44e+ac7g294BBprslwwVkMiL?=
 =?us-ascii?Q?nhhsp91bO0ygePJYP2dtNz4i3t5W6A5B8PPSF6ZOs0xqXt5FvO5UIPJm+X7x?=
 =?us-ascii?Q?Xh2Z0PrWYg0YZMlUVF5w1wFwBKsgXDj4XzeT27MJI5YROrCsQBuTlQK177R5?=
 =?us-ascii?Q?yuADlNBqhUY2lNq+RZ/zB+o5wfXSKG0WJnAczhGUYxwd7uIJcia/ZFTxxISm?=
 =?us-ascii?Q?wi4MXZz8P+JH146SG4+3jtDSbOoJKz77G8MkxVvr7XSuvBl5BHe98wikjd2Q?=
 =?us-ascii?Q?KhMAgYZVhXavujEXM2OtnU5icln5wn0Nb1mDgMjNb/PZQnwIip/ckp7kyoq3?=
 =?us-ascii?Q?XOb95BayxolL7ePw90tmespcbK58Io1vgygUxeTEgFiBP0M7v9Khtl1o0PUa?=
 =?us-ascii?Q?qrfUB4hsRgwEYeffOrbG5jfmFG50nfjzbHRRDUEIeN/yvfk2C1RDkXkBm0To?=
 =?us-ascii?Q?XwwucqIITKEyie5h/Lj+nqT8Dy+lH9Ievqi4B8CZ4Pm1/J5SYyEpUIctNtnL?=
 =?us-ascii?Q?JbkMOADIzx7Bp+OKlB8rdvbJXdB5jfkXj86hoAXbJVX+2T2NPpXidye5AGYr?=
 =?us-ascii?Q?MA2ZMfdpgqAcHjigBy+EGQz3XSeXw94NytjP4qTEJGGdYQIn4gB7vOTOFBJi?=
 =?us-ascii?Q?83C/tW+eB/6IISQf6SUu1p7WOzsWuoET/UNVVojOP9uSLqWqLR0i+4ly86OM?=
 =?us-ascii?Q?Pm9TpdfmK9zvNTSggljJuQPm6nht4E4CsvM+/mrMKEjarnQCS7Jk6d3/PhM2?=
 =?us-ascii?Q?LVQ6huG4a/7OCFOn8h38x6z2ljuE0Xzl7mAbKpsQ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ed79ed-77ba-4d4c-1b22-08db854ad77a
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 15:47:49.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6AWZCfaN0Ea7Hez9RNuVmwM26UuitHpwyonwJLpZ3/aaCTMmgBHsfQnQ4yq7ZF1gATbfeUyVceVe5+SBDjzgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7284
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 18:13:59 +0900
Asahi Lina <lina@asahilina.net> wrote:

> Using macros to create lock classes all over the place is unergonomic,
> and makes it impossible to add new features that require lock classes to
> code such as Arc<> without changing all callers.
> 
> Rust has the ability to track the caller's identity by file/line/column
> number, and we can use that to dynamically generate lock classes
> instead.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/sync/lockdep.rs    | 147 ++++++++++++++++++++++++++++++++++++++++-
>  rust/kernel/sync/no_lockdep.rs |   8 +++
>  2 files changed, 154 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync/lockdep.rs b/rust/kernel/sync/lockdep.rs
> index d8328f4275fb..fbf9f6ed403d 100644
> --- a/rust/kernel/sync/lockdep.rs
> +++ b/rust/kernel/sync/lockdep.rs
> @@ -5,7 +5,19 @@
>  //! This module abstracts the parts of the kernel lockdep API relevant to Rust
>  //! modules, including lock classes.
>  
> -use crate::types::Opaque;
> +use crate::{
> +    c_str, fmt,
> +    init::InPlaceInit,
> +    new_mutex,
> +    prelude::{Box, Result, Vec},
> +    str::{CStr, CString},
> +    sync::Mutex,
> +    types::Opaque,
> +};
> +
> +use core::hash::{Hash, Hasher};
> +use core::pin::Pin;
> +use core::sync::atomic::{AtomicPtr, Ordering};
>  
>  /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
>  #[repr(transparent)]
> @@ -42,3 +54,136 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
>  // actually dereferenced.
>  unsafe impl Send for LockClassKey {}
>  unsafe impl Sync for LockClassKey {}
> +
> +// Location is 'static but not really, since module unloads will
> +// invalidate existing static Locations within that module.
> +// To avoid breakage, we maintain our own location struct which is
> +// dynamically allocated on first reference. We store a hash of the
> +// whole location (including the filename string), as well as the
> +// line and column separately. The assumption is that this whole
> +// struct is highly unlikely to ever collide with a reasonable
> +// hash (this saves us from having to check the filename string
> +// itself).
> +#[derive(PartialEq, Debug)]
> +struct LocationKey {
> +    hash: u64,
> +    line: u32,
> +    column: u32,
> +}
> +
> +struct DynLockClassKey {
> +    key: Opaque<bindings::lock_class_key>,
> +    loc: LocationKey,
> +    name: CString,
> +}
> +
> +impl LocationKey {
> +    fn new(loc: &'static core::panic::Location<'static>) -> Self {
> +        let mut hasher = crate::siphash::SipHasher::new();
> +        loc.hash(&mut hasher);
> +
> +        LocationKey {
> +            hash: hasher.finish(),
> +            line: loc.line(),
> +            column: loc.column(),
> +        }
> +    }
> +}
> +
> +impl DynLockClassKey {
> +    fn key(&'static self) -> LockClassKey {
> +        LockClassKey(self.key.get())
> +    }

I don't understand why PATCH 06 is needed. If we keep the current
`LockClassKey` definition this could just be returning `'static
LockClassKey`, which is a simple `&self.key`.

> +
> +    fn name(&'static self) -> &CStr {
> +        &self.name
> +    }
> +}
> +
> +const LOCK_CLASS_BUCKETS: usize = 1024;
> +
> +#[track_caller]
> +fn caller_lock_class_inner() -> Result<&'static DynLockClassKey> {
> +    // This is just a hack to make the below static array initialization work.
> +    #[allow(clippy::declare_interior_mutable_const)]
> +    const ATOMIC_PTR: AtomicPtr<Mutex<Vec<&'static DynLockClassKey>>> =
> +        AtomicPtr::new(core::ptr::null_mut());
> +
> +    #[allow(clippy::complexity)]
> +    static LOCK_CLASSES: [AtomicPtr<Mutex<Vec<&'static DynLockClassKey>>>; LOCK_CLASS_BUCKETS] =
> +        [ATOMIC_PTR; LOCK_CLASS_BUCKETS];
> +
> +    let loc = core::panic::Location::caller();
> +    let loc_key = LocationKey::new(loc);
> +
> +    let index = (loc_key.hash % (LOCK_CLASS_BUCKETS as u64)) as usize;
> +    let slot = &LOCK_CLASSES[index];
> +
> +    let mut ptr = slot.load(Ordering::Relaxed);
> +    if ptr.is_null() {
> +        let new_element = Box::pin_init(new_mutex!(Vec::new()))?;
> +
> +        if let Err(e) = slot.compare_exchange(
> +            core::ptr::null_mut(),
> +            // SAFETY: We never move out of this Box
> +            Box::into_raw(unsafe { Pin::into_inner_unchecked(new_element) }),
> +            Ordering::Relaxed,
> +            Ordering::Relaxed,
> +        ) {
> +            // SAFETY: We just got this pointer from `into_raw()`
> +            unsafe { Box::from_raw(e) };
> +        }
> +
> +        ptr = slot.load(Ordering::Relaxed);
> +        assert!(!ptr.is_null());
> +    }
> +
> +    // SAFETY: This mutex was either just created above or previously allocated,
> +    // and we never free these objects so the pointer is guaranteed to be valid.
> +    let mut guard = unsafe { (*ptr).lock() };
> +
> +    for i in guard.iter() {
> +        if i.loc == loc_key {
> +            return Ok(i);
> +        }
> +    }
> +
> +    // We immediately leak the class, so it becomes 'static
> +    let new_class = Box::leak(Box::try_new(DynLockClassKey {
> +        key: Opaque::zeroed(),
> +        loc: loc_key,
> +        name: CString::try_from_fmt(fmt!("{}:{}:{}", loc.file(), loc.line(), loc.column()))?,
> +    })?);
> +
> +    // SAFETY: This is safe to call with a pointer to a dynamically allocated lockdep key,
> +    // and we never free the objects so it is safe to never unregister the key.
> +    unsafe { bindings::lockdep_register_key(new_class.key.get()) };
> +
> +    guard.try_push(new_class)?;
> +
> +    Ok(new_class)
> +}
> +
> +#[track_caller]
> +pub(crate) fn caller_lock_class() -> (LockClassKey, &'static CStr) {
> +    match caller_lock_class_inner() {
> +        Ok(a) => (a.key(), a.name()),
> +        Err(_) => {
> +            crate::pr_err!(
> +                "Failed to dynamically allocate lock class, lockdep may be unreliable.\n"
> +            );
> +
> +            let loc = core::panic::Location::caller();
> +            // SAFETY: LockClassKey is opaque and the lockdep implementation only needs
> +            // unique addresses for statically allocated keys, so it is safe to just cast
> +            // the Location reference directly into a LockClassKey. However, this will
> +            // result in multiple keys for the same callsite due to monomorphization,
> +            // as well as spuriously destroyed keys when the static key is allocated in
> +            // the wrong module, which is what makes this unreliable.

If the only purpose of introducing `StaticLockClassKey` and change
`LockClassKey` is to make this fallback path work, then I don't think
that change is worth it. I don't really see an issue with forging a
`'static LockClassKey' from a `'static Location`, especially since you
can't really do any memory access with `LockClassKey`.

> +            (
> +                LockClassKey(loc as *const _ as *mut _),
> +                c_str!("fallback_lock_class"),
> +            )
> +        }
> +    }
> +}
> diff --git a/rust/kernel/sync/no_lockdep.rs b/rust/kernel/sync/no_lockdep.rs
> index 518ec0bf9a7d..de53c4de7fbe 100644
> --- a/rust/kernel/sync/no_lockdep.rs
> +++ b/rust/kernel/sync/no_lockdep.rs
> @@ -4,6 +4,8 @@
>  //!
>  //! Takes the place of the `lockdep` module when lockdep is disabled.
>  
> +use crate::{c_str, str::CStr};
> +
>  /// A dummy, zero-sized lock class.
>  pub struct StaticLockClassKey();
>  
> @@ -28,3 +30,9 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
>          core::ptr::null_mut()
>      }
>  }
> +
> +pub(crate) fn caller_lock_class() -> (LockClassKey, &'static CStr) {
> +    static DUMMY_LOCK_CLASS: StaticLockClassKey = StaticLockClassKey::new();
> +
> +    (DUMMY_LOCK_CLASS.key(), c_str!("dummy"))
> +}
> 

