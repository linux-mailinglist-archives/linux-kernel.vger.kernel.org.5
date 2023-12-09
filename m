Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F278180B672
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjLIVFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 16:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjLIVFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 16:05:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367E6FD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 13:05:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E156AC433C7;
        Sat,  9 Dec 2023 21:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702155954;
        bh=BJt4m1bj3PQ1OsNq1UDFooL7gV/55KHr0BR1gtXR+gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtVvWRodKeN0gQJaq3t6lkrJmKokthC622qiFgmGF3k7L7Erz/HEiQiOWpIB/teLj
         O4TFUdPeq4WjpjOxi9dlO/K0f8pw9SYhHcuZY9rI+FGC9bZC+BBXbzZU6eQdIXG4oH
         sAqDXgtjCvOG5Qy66lCVxnlbYQsDTj0IKfHugYP2DKcTTUPH+4paF+ScrmoKmPL/hC
         yS/pE3A3oZINtp3hBBad1yJRDAJcpPVtdZnVhcPt0YXJnD83a34g103i/g2tDP9gwa
         M0UvsCNazoBYdTiEOv2l92weUSP9840VjJ39kktBPiACNfHOoo7UlYJEZNPM4BSNiH
         rkE1Rfv9p3Kdw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     aliceryhl@google.com, arve@android.com, christian@brauner.io,
        cmllamas@google.com, dualli@google.com, joel@joelfernandes.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        maco@android.com, rust-for-linux@vger.kernel.org,
        surenb@google.com, tkjos@android.com, jbaublitz@redhat.com,
        aaron@aaronballman.com, emilio@crisal.io,
        christian.poveda@ferrous-systems.com,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH] binder: use enum for binder ioctls
Date:   Sat,  9 Dec 2023 22:05:44 +0100
Message-ID: <20231209210544.139181-1-ojeda@kernel.org>
In-Reply-To: <2023120936-decency-engraved-5346@gregkh>
References: <2023120936-decency-engraved-5346@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this mean that we will have to wrap every ioctl definition in an
> enum just to get access to it in rust code?

Currently, yes (or one can build them on the Rust side using the `_IO*` const
functions that are in mainline at `rust/kernel/ioctl.rs`).

> What makes these defines so magical that bindgen can't decode them?  Is
> it just the complexity of the C preprocessor logic involved?  Any plans
> for bindgen to resolve this?

Yeah, currently bindgen only resolves "trivial" object-like macros. As soon as
a macro is more complex it does not work, even if it would still resolve into
a constant. The upstream issue for this particular case (a macro that uses
other function-like macros) uses `_IO*`s as the example, in fact, and is at:

    https://github.com/rust-lang/rust-bindgen/issues/753

which we track in our bindgen list at:

    https://github.com/Rust-for-Linux/linux/issues/353

There are several ways forward for bindgen here. Ideally, libclang would give
the resolved value to bindgen. This may require changes in upstream Clang.
I contacted Aaron Ballman (the Clang maintainer, Cc'd) a while ago and
he kindly offered to review the changes if they were eventually needed.

Otherwise (or meanwhile), it is also possible to implement a workaround that
stores the information in a way that can be retrieved by bindgen by using
the macro in some way (e.g. initializing a variable and asking for the value
of the variable). It is ugly, but it should work (at least for many cases --
there may be other compounding issues with e.g. 128-bit integers).

John Baublitz (Cc'd) has spent some time on this and, from what I can tell from
the issue, we may be waiting on an answer from bindgen (Cc'ing Emilio and
Christian, the bindgen maintainers) on whether the workaround is OK for them.
The workaround would be nice to have even if we change upstream Clang, because
it would help in many cases we care about, without having to wait until we get
a new LLVM released and so on.

Hope that helps!

Cheers,
Miguel
