Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FDF80AE27
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjLHUpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHUpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:45:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A44A1706;
        Fri,  8 Dec 2023 12:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uuulqJ0udjp/ONQs9URiRO2kRC7WLgYyKoN4bKlDxU8=; b=DHsdeOTEek3iQwO3tU1lWqjYnS
        9WZO8OJd9l0ESCow217XyrKQiBE9yJ0zqWFYzWFH6tZ5f/h1C9LssraIN5kD9BA4dyQq7v4x37Xdw
        4ATU9AmTFnjE4CjDlsFrzIdD89OMEh9th3HFZkJ99AlxbYJ36wbZEGFlr9rOWWU5LvRttecpWRhgm
        gHKRKjJhs98U7yUBoCTZL0Hd5MdQ7z4hTOmisqmM11jTmT1dh9Tcf3ueDE7NV4WmIpVLhUEjA6gZc
        3lC2lmyClXm6ovkVeLx7RMlUAuZzX0afZAKs+yy1bBdeFK43C67PvE8GINv0rnlHAwzn8dQhRhopr
        YE6cD9zQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rBhiX-006YEc-S1; Fri, 08 Dec 2023 20:45:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EC053003F0; Fri,  8 Dec 2023 21:45:01 +0100 (CET)
Date:   Fri, 8 Dec 2023 21:45:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
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
Message-ID: <20231208204501.GJ28727@noisy.programming.kicks-ass.net>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com>
 <20231206123402.GE30174@noisy.programming.kicks-ass.net>
 <CAH5fLgh+0G85Acf4-zqr_9COB5DUtt6ifVpZP-9V06hjJgd_jQ@mail.gmail.com>
 <20231206134041.GG30174@noisy.programming.kicks-ass.net>
 <CANiq72kK97fxTddrL+Uu2JSah4nND=q_VbJ76-Rdc-R-Kijszw@mail.gmail.com>
 <20231208165702.GI28727@noisy.programming.kicks-ass.net>
 <202312080947.674CD2DC7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312080947.674CD2DC7@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:18:47AM -0800, Kees Cook wrote:

> Even if we look at the prerequisites for mounting an attack here, we've
> already got things in place to help mitigate arbitrary code execution
> (KCFI, BTI, etc). Nothing is perfect, but speculation gadgets are
> pretty far down on the list of concerns, IMO. We have no real x86 ROP
> defense right now in the kernel, so that's a much lower hanging fruit
> for attackers.

Supervisor shadow stacks, as they exist today, just can't work on Linux.
Should get fixed with FRED, but yeah, this is all somewhat unfortunate.

> As another comparison, on x86 there are so many direct execution gadgets
> present in middle-of-instruction code patterns that worrying about a
> speculation gadget seems silly to me.

FineIBT (or even IBT) limits the middle of function gadgets
significantly.

