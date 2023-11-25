Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4DD7F8C40
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjKYQD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjKYQDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:03:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD81F1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 08:04:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4540CC433C8;
        Sat, 25 Nov 2023 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700928241;
        bh=LW1ts9SJDj+sVWFA4PwEH3tAXMVY/D5+pM3wT6T/eaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0l3+hffifmm8niZ1+DSbrsjBMUVYHW7mpclNeedO8kcU4ZdJWsuBd2zV85Ya7H2bx
         L+uS2bFqeD4EaDqvEqI3PbQu5Xvl2ENrn9iY9O2dnP+hDS/GcOFvt6LHh+GA4rVhzm
         UzoFDfbbX/3QxpoBS8nJVirEVeZUqs2gtp+s8epg=
Date:   Sat, 25 Nov 2023 16:03:59 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: macros: allow generic parameter default values
 in `#[pin_data]`
Message-ID: <2023112500-pandemic-numbness-db06@gregkh>
References: <20231125125024.1235933-1-benno.lossin@proton.me>
 <20231125125024.1235933-2-benno.lossin@proton.me>
 <2023112525-impatient-untwist-ee3d@gregkh>
 <t4HJjY0Oft2K2H1ssXTxZchdPTx25J6WqSJqAx75NiRUYg40BBLt1AHxm9ZF0UA70FkqIXb6Pp2sz3BErD-AyXmQCkU4xDvqyXHSinaWGb4=@proton.me>
 <2023112514-laziness-valium-7a25@gregkh>
 <5hsq7OfTOZ9Wi70n6p9nfFPr4IDJ9YECqWHEgsnMnzN3lcLeojK5ZlwR7nzDGdK5Wjrb95Jk60CGKszSiUhMsZQA2vlwSltMMypfk4HzgJM=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5hsq7OfTOZ9Wi70n6p9nfFPr4IDJ9YECqWHEgsnMnzN3lcLeojK5ZlwR7nzDGdK5Wjrb95Jk60CGKszSiUhMsZQA2vlwSltMMypfk4HzgJM=@proton.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 03:26:02PM +0000, Benno Lossin wrote:
> On 25.11.23 16:10, Greg KH wrote:
> > On Sat, Nov 25, 2023 at 03:02:00PM +0000, Benno Lossin wrote:
> >> On 25.11.23 15:26, Greg KH wrote:
> >>> On Sat, Nov 25, 2023 at 12:51:09PM +0000, Benno Lossin wrote:
> >>>> This patch adds compatibilty for generic parameters defaults by using
> >>>> the newly introduced `decl_generics` instead of the `impl_generics`.
> >>>
> >>> This says _what_ is happening here, but not _why_ this is needed at all.
> >>>
> >>> Try taking a look a the kernel documentation for how to write a good
> >>> changelog text to make this much better.  It's often times the most
> >>> difficult portion of making a kernel patch, the code is easy, writing a
> >>> summary of why everyone else should agree that this code is acceptable
> >>> is hard.
> >>
> >> The reason is hidden in the third patch.
> > 
> > Please do not hide things, patches need to be stand-alone and
> > understandable that way, otherwise they will be rejected as no one can
> > understand why they would be needed.
> 
> This was not my intention, I just realized this due to your question. I
> wanted to point you to the third patch (which for some reason sadly does
> not have the correct In-Reply-To header). Since that might help you
> understand some of the context.

Again, changes need to be understood on their own, so provide some hints
as to _why_ this is needed.

> >> Without this, the `#[pin_data]
> >> macro would not allow specifying const generic parameter default values
> >> and instead emit a compile error.
> > 
> > That's nice, but it still doesn't tell me _why_ this is needed.  Why
> > would I want any generic paramter default values at all?  Who needs any
> > of this?  What will it be used for?  What does it actually do?
> 
> `#[pin_data]` is a proc-macro that one can put on any struct to make the
> pin-init API available for use with that struct. Since e.g. mutexes are
> initialized using the pin-init API, you have to do this for anything
> that contains a mutex.
> This macro should be compatible with any struct definition even with
> ones that have const generic parameter defaults. This was an oversight
> in the original design, as it does not support that, since the proc
> macro parsing cannot handle the `=` character.
> 
> The short answer for why one would want to have const generic parameter
> defaults is that the language supports it.

Wait, no, that's not what we do in the kernel.  We only add support for
things that we actually need and use.

If you have no use for this, but it's here just "because we might want
it someday", then we can't take it for obvious reasons.

So provide a user of the feature, and then we can actually understand if
it is worth adding, or perhaps, it's not needed at all as other things
can be done.

> And since there is nothing
> that prevents `#[pin_data]` to be implemented for such structs, we
> should it do it.
> Rust generally aims to make all features compatible
> with each other and we would like to do the same for our
> libraries/customized features.

The kernel doesn't have a "library", that's not how we work, it's
self-contained and does not export anything nor work with external
libraries outside of its source tree.

> The longer answer is a concrete example of a usecase for const generic
> parameter defaults: the `Work<T, ID>` struct of the workqueue bindings.
> The `ID` parameter is used to identify multiple instances of `Work`
> within the same struct.

Why not just declare them as different names?

And multiple workqueues in a single structure are ripe for problems, are
you sure you need that?

> But if you only intend to have a single `Work`
> struct embedded in your struct, then there is no need to distinguish it
> from something else (after all there is only one) and therefore we want
> people to just write `Work<T>`. This is where the author of
> `Work<T, ID>` can write:
> 
>     struct Work<T, const ID: usize = 0> {
>         // ...
>     }
> 
> But the `= 0` syntax is currently not supported by `#[pin_data]`.

Why not just force a name for either way it is declared?  Wait, "id"?
What is that for and what will require and define that?

thanks,

greg k-h
