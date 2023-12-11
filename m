Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0293A80DCB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 22:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbjLKVNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 16:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344826AbjLKVNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 16:13:24 -0500
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB7DD0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 13:13:29 -0800 (PST)
Date:   Mon, 11 Dec 2023 16:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702329207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ApXHTTHAG4MxZp4EC8hGfCJDFrAWlnz+x/MRiiLFanU=;
        b=dLpjYLre+kgLX1M2v/SpnGgs5E9NX60qPa7b4zl+atqP/Yzz+Cfko6NCYpbDRpPEqqJiJS
        3lh3aAkgfwfQLaUviEcmqgVJaL0CTOTxVyQkD9XRUpUU9pvau4iuImQfg+AfKW0o96BM8W
        RHL3n+zZ3XFfUP8H5ZoGBkjheJnjuLs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231211211322.bw2liijz63d3txya@moria.home.lan>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com>
 <20231206123402.GE30174@noisy.programming.kicks-ass.net>
 <CAH5fLgh+0G85Acf4-zqr_9COB5DUtt6ifVpZP-9V06hjJgd_jQ@mail.gmail.com>
 <20231206134041.GG30174@noisy.programming.kicks-ass.net>
 <CANiq72kK97fxTddrL+Uu2JSah4nND=q_VbJ76-Rdc-R-Kijszw@mail.gmail.com>
 <20231208165702.GI28727@noisy.programming.kicks-ass.net>
 <202312080947.674CD2DC7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202312080947.674CD2DC7@keescook>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:18:47AM -0800, Kees Cook wrote:
> On Fri, Dec 08, 2023 at 05:57:02PM +0100, Peter Zijlstra wrote:
> > On Fri, Dec 08, 2023 at 05:31:59PM +0100, Miguel Ojeda wrote:
> > > On Wed, Dec 6, 2023 at 2:41 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > Anywhoo, the longer a function is, the harder it becomes, since you need
> > > > to deal with everything a function does and consider the specuation
> > > > window length. So trivial functions like the above that do an immediate
> > > > dereference and are (and must be) a valid indirect target (because
> > > > EXPORT) are ideal.
> > > 
> > > We discussed this in our weekly meeting, and we would like to ask a
> > > few questions:
> > > 
> > >   - Could you please describe an example attack that you are thinking
> > > of? (i.e. a "full" attack, rather than just Spectre itself). For
> > > instance, would it rely on other vulnerabilities?
> > 
> > There's a fairly large amount of that on github, google spectre poc and
> > stuff like that.
> 
> tl;dr: I don't think the introduction of speculation gadgets is a
> sufficient reason to block Rust interfaces like this.
> 
> Long version:
> 
> I think the question here is "what is the threat model?" If I break down
> the objection, I understand it as:
> 
> 1) The trivial wrappers-of-inlines are speculation gadgets.
> 2) They're exported, so callable by anything.
> 
> If the threat model is "something can call these to trigger
> speculation", I think this is pretty strongly mitigated already;
> 
> 1) These aren't syscall definitions, so their "reachability" is pretty
> limited. In fact, they're already going to be used in places, logically,
> where the inline would be used, so the speculation window is going to be
> same (or longer, given the addition of the direct call and return).
> 
> 2) If an attacker is in a position to directly call these helpers,
> they're not going to use them: if an attacker already has arbitrary
> execution, they're not going to bother with speculation.
> 
> Fundamentally I don't see added risk here. From the security hardening
> perspective we have two goals: kill bug classes and block exploitation
> techniques, and the former is a much more powerful defensive strategy
> since without the bugs, there's no chance to perform an exploit.
> 
> In general, I think we should prioritize bug class elimination over
> exploit technique foiling. In this case, we're adding a potential weakness
> to the image of the kernel of fairly limited scope in support of stronger
> bug elimination goals.
> 
> Even if we look at the prerequisites for mounting an attack here, we've
> already got things in place to help mitigate arbitrary code execution
> (KCFI, BTI, etc). Nothing is perfect, but speculation gadgets are
> pretty far down on the list of concerns, IMO. We have no real x86 ROP
> defense right now in the kernel, so that's a much lower hanging fruit
> for attackers.
> 
> As another comparison, on x86 there are so many direct execution gadgets
> present in middle-of-instruction code patterns that worrying about a
> speculation gadget seems silly to me.
> 
> > [...]
> > The thing at hand was just me eyeballing it.
> 
> I can understand the point you and Greg have both expressed here: "this
> is known to be an anti-pattern, we need to do something else". I generally
> agree with this, but in this case, I don't think it's the right call. This
> is an area we'll naturally see improvement from on the Rust side since
> these calls are a _performance_ concern too, so it's not like this will be
> "forgotten" about. But blocking it until there is a complete and perfect
> solution feels like we're letting perfect be the enemy of good.
> 
> All of our development is evolutionary, so I think we'd be in a much
> better position to take these (currently ugly) work-arounds (visible
> only in Rust builds) so that we gain the ability to evolve towards more
> memory safe code.

Well said.

More than that, I think this is a situation where we really need to
consider what our priorities are.

Where are most of our real world vulnerabilities coming from? Are they
spectre issues, or are they memory safety issues, and the kinds of
logic/resource issues we know Rust's type system is going to help with?
I think we all know the answer to that question.

More than that, as kernel programmers, we need to be focusing primarily
on the issues that are our responsibility and under our control. At the
point when the inability of the CPU manufacturers to get their shit
together is causing us to have concerns over _generated code for little
helper functions_, the world has gone crazy.

I remember when the spectre stuff first hit, and everyone was saying
"this is just a temporary workaround; CPU manufacturers are going to
sort this out in a couple releases".

They haven't. That's batshit. And I doubt they ever will if we keep
pretending we can just work around everything in software.
