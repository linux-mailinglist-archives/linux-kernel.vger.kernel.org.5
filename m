Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED42075B027
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjGTNfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjGTNfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:35:11 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3E02712
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:34:46 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-51866148986so516711a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689860077; x=1690464877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSQWIpe35h2vfmTYalpALxQAf+9bTQmlNidC6prPYv4=;
        b=ecYXq1Tb+6biFfM0X8wXZc7u6Ve8Qice5xiTqlI8UCyM8km12i39ggps/ecdrYw4Kj
         /0OcOBtD4WzfMlhshUn+mekiUcH1pcPPbvDEpnmZZjCMhUjjlzZPPlU0/vbmqeQfHwBC
         Sun+WFQgeMsW75Lv7cY1VSSwi51UYJUYUgeKuDpp+Xl+5xrnQJK45fBHx44jD0hmH3ou
         X1ascve+GeDF638HU3IXFFqv2DJYyzQYyhnXunOXN5yggqQm9uqcm+ko+CtIl3XVUvRQ
         7iwP3+yQ8zvo3n1xkBYhkjRX4471vQUJcF13I7PpTHEQ9FYap1gvDYP5uFQzKrMQTNP6
         3A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689860077; x=1690464877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSQWIpe35h2vfmTYalpALxQAf+9bTQmlNidC6prPYv4=;
        b=TB9l27xpqW+8ATro6C0M7bWbki6akWLd1fBYwtDH6b7r60qWS03MtnmXHHmI3Dl9+Z
         n4OoN2/ioHqLHe6IrUNRM6vUwvX1wsQ0o2qrVfBOImJs6ys5veGIObqXM4Lj11r8DGHZ
         U61W5ckteJxH9/ZhSwDPEanG26s3uyQMTgea6FRu1p2sJyqCidtbUnnaiN/a0psNZtUF
         IBqW+NWzFsM06c5RSmEXFyuopZD8/UTeK2fHQ+z4pVsDBRanCkQvDW7WSrdPBrDc8l3D
         LwRzkwuwJDzzw+f8jrMCU4pvRZXPOeF5zgD/nR/jnqYI2cz+gUR3ooE9UKUQXEcR8cnf
         BkWg==
X-Gm-Message-State: ABy/qLbb7o787hzKIhR0SF8RPEr5MY5Ja4uJJ7oc9P3sj9mbX0end1Uj
        OFGEtezX7PZV9oRBxAtz/zWA78/p8F6felg=
X-Google-Smtp-Source: APBJJlFUl48NrzAvipHQJcZMoPNYcfU7nf8Mihu3/BC21F7A2qKXQZzkclyQDECI6ySlPYgpbbk70/kAG9TUGYc=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:f684:0:b0:51b:de6b:b2cc with SMTP id
 d4-20020a50f684000000b0051bde6bb2ccmr26288edn.1.1689860077591; Thu, 20 Jul
 2023 06:34:37 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:34:34 +0000
In-Reply-To: <20230719141918.543938-10-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230719141918.543938-10-benno.lossin@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720133434.3546048-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 09/12] rust: init: implement Zeroable for Opaque<T>
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, nmi@metaspace.dk, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> Since `Opaque<T>` contains a `MaybeUninit<T>`, all bytes zero is a valid
> bit pattern for that type.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  ///
>  /// This is meant to be used with FFI objects that are never interpreted by Rust code.
>  #[repr(transparent)]
> +#[derive(Zeroable)]
>  pub struct Opaque<T> {
>      value: UnsafeCell<MaybeUninit<T>>,
>      _pin: PhantomPinned,
>  }

Does this actually work? I don't think we implement Zeroable for
UnsafeCell.

I suggest you instead add Opaque to the `impl_zeroable!` macro in
`rust/kernel/init.rs`.

Alice

