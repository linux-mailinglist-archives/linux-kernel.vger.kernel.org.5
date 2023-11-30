Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536A57FED54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbjK3KxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjK3KxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:53:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74D0D40
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:53:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7729C433C7;
        Thu, 30 Nov 2023 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701341588;
        bh=8XkaVRCmO2JrQF4/dXotopuTsQp9i+OgT5+rIs7i4Gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nxgq+smu5i9vrVSHRNyc4tSnnk1V+SQBcysfec0SgCiyBnnZiKxpVG/yENQAGdJHS
         P0q9pkQAc1X8rRKYv/JLNR5EDc/mQXLUp+U6IaF1oI32BXTNRgo048TE8o7dY+8Oe7
         OOYs9gagAX88y/maW+iiG9baEcJWSbGf5ouOq7Thf0Epn8Rr8lOMoPQv2dyMjrVDY6
         rDBmjYCyUVtM9jnAB7t8BG63/q6HrfRVikfqjUVEZHmXbEEOazWx6yali03PuUE4Mo
         cluCgiEauUfrj6iM/fyEGAth/qfmFIpsXFA0k5JPUw/HWtjPPMmGnIr4kp/odUrS3n
         NNNzR8mFh3wHw==
Date:   Thu, 30 Nov 2023 11:52:59 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, cmllamas@google.com,
        dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org,
        peterz@infradead.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, tkjos@android.com,
        viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231130-neuordnung-matetee-7aefa024f80b@brauner>
References: <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231130093603.113036-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130093603.113036-1-aliceryhl@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:36:03AM +0000, Alice Ryhl wrote:
> Christian Brauner <brauner@kernel.org> writes:
> > I'm a bit puzzled by all these rust_helper_*() calls. Can you explain
> > why they are needed? Because they are/can be static inlines and that
> > somehow doesn't work?
> 
> Yes, it's because the methods are inline. Rust can only call C methods
> that are actually exported by the C code.
> 
> >> +    /// Converts this kernel UID into a UID that userspace understands. Uses the namespace of the
> >> +    /// current task.
> >> +    pub fn into_uid_in_current_ns(self) -> bindings::uid_t {
> > 
> > Hm, I wouldn't special-case this. Just expose from_kuid() and let it
> > take a namespace argument, no? You don't need to provide bindings for
> > namespaces ofc.
> 
> To make `from_kuid` safe, I would need to wrap the namespace type too. I
> could do that, but it would be more code than this method because I need
> another wrapper struct and so on.
> 
> Personally I would prefer to special-case it until someone needs the
> non-special-case. Then, they can delete this method when they introduce
> the non-special-case.
> 
> But I'll do it if you think I should.

No, don't start wrapping namespaces as well. You already do parts of LSM
as well.

> 
> >> +impl PartialEq for Kuid {
> >> +    fn eq(&self, other: &Kuid) -> bool {
> >> +        // SAFETY: Just an FFI call.
> >> +        unsafe { bindings::uid_eq(self.kuid, other.kuid) }
> >> +    }
> >> +}
> >> +
> >> +impl Eq for Kuid {}
> > 
> > Do you need that?
> 
> Yes. This is the code that tells the compiler what `==` means for the
> `Kuid` type. Binder uses it here:

Ok, thanks.
