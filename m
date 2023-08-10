Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCACD777C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjHJPqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjHJPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:46:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90361BF7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74DA0642B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E856C433C8;
        Thu, 10 Aug 2023 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691682400;
        bh=/5zTFG72E+P4/DteEC6utdswFNMURiH163A5zO3iNl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzrD3D4afX32MxGIvx5B8zJiwNod0zFHSeAB4kPMETgWhSLCamNQkg7h26TVX8sUX
         qZfFjOxtsYnZCDeVFpvSPkvyYH0mf823wf6qDySRMjvJFTyabMiRjst7HAHfqIsy7F
         nLF89V8eoRunAIllh5aLIg4ckFkEbS7w7VNpmEZQ=
Date:   Thu, 10 Aug 2023 17:46:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: macros: add `paste!` proc macro
Message-ID: <2023081037-undertone-empathy-2ab6@gregkh>
References: <20230628171108.1150742-1-gary@garyguo.net>
 <CANiq72miVic=P+qSobuUqXoCuKW30_tT_buD8MyEsyVb_uoj6w@mail.gmail.com>
 <20230809230249.01ffc009.gary@garyguo.net>
 <CANiq72nWArGsvWVVknPdAVYUbWqJKfwOAVCRUmLnuAHAHP+rSQ@mail.gmail.com>
 <2023081043-cake-catwalk-1ba8@gregkh>
 <CANiq72=-NffQz9jMxoznoRGkeQz+1oTb6__r3c1z+BzOsWxfRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=-NffQz9jMxoznoRGkeQz+1oTb6__r3c1z+BzOsWxfRw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:56:18AM +0200, Miguel Ojeda wrote:
> On Thu, Aug 10, 2023 at 7:08 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > The kernel will migrate when we have converted all files in the tree to
> > SPDX and can worry about things like the SPDX version level.  We have a
> > ways to go still...
> 
> I see, thanks!
> 
> > Be VERY careful with dual licenses please, and especially non-GPL ones
> > in the kernel tree.  It gets tricky very very quickly and you need to
> > know what you are doing.  So much so that I really want to see a lawyer
> > sign off on such a thing so that everyone involved understands the
> > issues that this requires.
> 
> It is the common one used in Rust projects, which we are using for
> other bits too, e.g. vendoring the `alloc` standard library.
> 
> Since these couple functions are essentially a compiler plugin (a proc
> macro) that is useful in userspace and other contexts too, Gary wanted
> to use that license (he contributes the other kernel code under
> GPL-2.0). For instance, he may possibly want to put those functions in
> crates.io or similar, I imagine (like the linked crate this replaces
> as a simplification).

If he, as the copyright owner, wants to take the code and do anything
else with it, under any other license, they can.  There's nothing
preventing them from doing that, a dual license is not needed (as long
as you don't take any changes that anyone else made under a different
license.)

Which is one of the main reasons dual license isn't really needed, if
the author wants the code to go somewhere else also, they are free to do
so as they own the copyright.

So please think carefully about mixing licenses like this, it's almost
never needed, and keeping the files with multiple licenses is a major
pain to handle over time.

good luck!

greg k-h
