Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD72E78B16E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjH1NPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjH1NP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:15:27 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BE59D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:15:20 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d7ab8e1f27cso2088658276.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693228520; x=1693833320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEMWlLjO4ma0k7EwHVIyg1u7C9yprMEwyDZO+iulDM8=;
        b=V6+h4vwrMOMu03ltsnbkQ0zC/AkN7nV9NZ0AqhY1LFP5v6jGwCllqln6omhYPVWEue
         o6xUFtSRW6KX+7UfEgOJfZERl/kZHyTgyfTZJ9TXwY8EJmJbDJB61ejNTCvuPTuX/UUk
         y2cRJqAtmUpCuuy2s/I3QeLmyRNlZXuvroD1a8pu0nm87iUKbb+oQ5t5aEIMkQrTnXAt
         GUhwHD7H9NiU+Q/dXzuRZOgGY1ZprBJtD1ent0Sz12en2jY+j3479biI1NAUjk6eOZVq
         kOgd03dmIqJLwGXSxEpoB18TIngrd5D29G9XCqaukXHN9b4G9yW+PlKopx18SzdEAC4t
         OINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693228520; x=1693833320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEMWlLjO4ma0k7EwHVIyg1u7C9yprMEwyDZO+iulDM8=;
        b=fGYcePAMF2ZtMrnX+si5Nq8ecEzz4ViRhK+Z+Sq8LdrTrouUI9Z3es0nahHT7E3CtT
         sJ4H5I8tY8iXKbdYbTPlS0VM4mmNbNIu4hk2GDsmQ41F0M/iHSr8pKXryh5MAb1frJ/A
         GXg1819KCi4UJpeLoK+SVulR4Ax5mzU4YkmuGmnIo7c6pf0gFqXRnG1/hoGZhF7+OgGq
         6ZHU1k9085HcsAEsFBta6Jk54SrdYhY50ed2vQLGFMrZ6lm4HgTebnRqHWMeiRcqYb0C
         j5JtHd7cDtrW9KZbiNoIfLd/QvdO1KQdIqXbQl2xL7UASgiHNPbcMNtcWSHkTe+PY3nv
         f4Qg==
X-Gm-Message-State: AOJu0YyJCk1oWmJx4jC/DwUmGgcBSejmM7+pZl3Lwvu/1LhyGmgF8Yo1
        yNZ/5W+9nmdB4bAAohQGtw1LpxttNyK5Ujhj0EL/Vg==
X-Google-Smtp-Source: AGHT+IGWFL9C23hjo7ugSaRQgcoYQlrrlRRD2Om8y9giiAsrv1ninAUIrU/JT1hEg6Os1gAbNBmQm8Ubw8m1A/3B17Y=
X-Received: by 2002:a25:e7c9:0:b0:d1c:bb1d:238a with SMTP id
 e192-20020a25e7c9000000b00d1cbb1d238amr24088739ybh.52.1693228519427; Mon, 28
 Aug 2023 06:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230823160244.188033-1-ojeda@kernel.org> <20230823160244.188033-2-ojeda@kernel.org>
In-Reply-To: <20230823160244.188033-2-ojeda@kernel.org>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 28 Aug 2023 15:15:08 +0200
Message-ID: <CAH5fLggn1fPjZXMg4mmizvO-B-GgRSG6vwjF+eg-sohs=yYYhw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: arc: add explicit `drop()` around `Box::from_raw()`
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 6:03=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
> `Box::from_raw()` is `#[must_use]`, which means the result cannot
> go unused.
>
> In Rust 1.71.0, this was not detected because the block expression
> swallows the diagnostic [1]:
>
>     unsafe { Box::from_raw(self.ptr.as_ptr()) };
>
> It would have been detected, however, if the line had been instead:
>
>     unsafe { Box::from_raw(self.ptr.as_ptr()); }
>
> i.e. the semicolon being inside the `unsafe` block, rather than
> outside.
>
> In Rust 1.72.0, the compiler started warning about this [2], so
> without this patch we will get:
>
>         error: unused return value of `alloc::boxed::Box::<T>::from_raw` =
that must be used
>         --> rust/kernel/sync/arc.rs:302:22
>         |
>     302 |             unsafe { Box::from_raw(self.ptr.as_ptr()) };
>         |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         |
>         =3D note: call `drop(Box::from_raw(ptr))` if you intend to drop t=
he `Box`
>         =3D note: `-D unused-must-use` implied by `-D warnings`
>     help: use `let _ =3D ...` to ignore the resulting value
>         |
>     302 |             unsafe { let _ =3D Box::from_raw(self.ptr.as_ptr())=
; };
>         |                      +++++++                                 +
>
> Thus add an add an explicit `drop()` as the `#[must_use]`'s
> annotation suggests (instead of the more general help line).
>
> Link: https://github.com/rust-lang/rust/issues/104253 [1]
> Link: https://github.com/rust-lang/rust/pull/112529 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
