Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0AA7CF7E2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345510AbjJSMCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345471AbjJSMB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:01:58 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DE85138;
        Thu, 19 Oct 2023 05:01:54 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 39JC0qTV004618;
        Thu, 19 Oct 2023 14:00:52 +0200
Date:   Thu, 19 Oct 2023 14:00:52 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <ZTEadLq8UFrxsHr/@1wt.eu>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
 <202310182248.9E197FFD5@keescook>
 <ZTDUYSBS7AO9pAgm@1wt.eu>
 <50ad206e-8a6a-4223-8050-0880e2b1581c@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50ad206e-8a6a-4223-8050-0880e2b1581c@p183>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 02:40:52PM +0300, Alexey Dobriyan wrote:
> On Thu, Oct 19, 2023 at 09:01:53AM +0200, Willy Tarreau wrote:
> > On Wed, Oct 18, 2023 at 11:01:54PM -0700, Kees Cook wrote:
> > > On Thu, Oct 19, 2023 at 07:46:42AM +0200, Christoph Hellwig wrote:
> > > > On Wed, Oct 18, 2023 at 10:48:49PM +0000, Justin Stitt wrote:
> > > > > strncpy() is deprecated for use on NUL-terminated destination strings
> > > > > [1] and as such we should prefer more robust and less ambiguous string
> > > > > interfaces.
> > > > 
> > > > If we want that we need to stop pretendening direct manipulation of
> > > > nul-terminate strings is a good idea.  I suspect the churn of replacing
> > > > one helper with another, maybe slightly better, one probably
> > > > introduces more bugs than it fixes.
> > > > 
> > > > If we want to attack the issue for real we need to use something
> > > > better.
> > > > 
> > > > lib/seq_buf.c is a good start for a lot of simple cases that just
> > > > append to strings including creating complex ones.  Kent had a bunch
> > > > of good ideas on how to improve it, but couldn't be convinced to
> > > > contribute to it instead of duplicating the functionality which
> > > > is a bit sad, but I think we need to switch to something like
> > > > seq_buf that actually has a counted string instead of all this messing
> > > > around with the null-terminated strings.
> > > 
> > > When doing more complex string creation, I agree. I spent some time
> > > doing this while I was looking at removing strcat() and strlcat(); this
> > > is where seq_buf shines. (And seq_buf is actually both: it maintains its
> > > %NUL termination _and_ does the length counting.) The only thing clunky
> > > about it was initialization, but all the conversions I experimented with
> > > were way cleaner using seq_buf.
> > (...)
> > 
> > I also agree. I'm using several other schemes based on pointer+length in
> > other projects and despite not being complete in terms of API (due to the
> > slow migration of old working code), over time it proves much easier to
> > use and requires far less controls.
> > 
> > With NUL-teminated strings you need to perform checks for each and every
> > operation. When the length is known and controlled, most often you can
> > get rid of many tests on intermediate operations and perform a check at
> > the end, thus you end up with less "if" and "goto fail" in the code,
> > because the checks are no longer for "not crashing nor introducing
> > vulnerabilities", but just "returning a correct result", which can often
> > be detected more easily.
> > 
> > Another benefit I found by accident is that when you need to compare some
> > tokens against multiple ones (say some keywords for example), it becomes
> > much faster than strcmp()-based if/else series because in this case you
> > start by comparing lengths instead of comparing contents. And when your
> > macros allow you to constify string constants, the compiler will replace
> > long "if" series with checks against constant values, and may even arrange
> > them as a tree since all are constants, sometimes mixing with the first
> > char as the discriminator. Typically on the test below I observe a 10x
> > speedup at -O3 and ~5x at -O2 when I convert this:
> > 
> > 	if (!strcmp(name, "host") ||
> > 	    !strcmp(name, "content-length") ||
> > 	    !strcmp(name, "connection") ||
> > 	    !strcmp(name, "proxy-connection") ||
> > 	    !strcmp(name, "keep-alive") ||
> > 	    !strcmp(name, "upgrade") ||
> > 	    !strcmp(name, "te") ||
> > 	    !strcmp(name, "transfer-encoding"))
> > 		return 1;
> > 
> > to this:
> > 
> > 	if (isteq(name, ist("host")) ||
> > 	    isteq(name, ist("content-length")) ||
> > 	    isteq(name, ist("connection")) ||
> > 	    isteq(name, ist("proxy-connection")) ||
> > 	    isteq(name, ist("keep-alive")) ||
> > 	    isteq(name, ist("upgrade")) ||
> > 	    isteq(name, ist("te")) ||
> > 	    isteq(name, ist("transfer-encoding")))
> > 		return 1;
> > 
> > The code is larger but when compiled at -Os, it instead becomes smaller.
> > 
> > Another interesting property I'm using in the API above, that might or
> > might not apply there is that for most archs we care about, functions
> > can take a struct of two words passed as registers, and can return
> > such a struct as a pair of registers as well. This allows to chain
> > functions by passing one function's return as the argument to another
> > one, which is what users often want to do to avoid intermediate
> > variables.
> 
> Chaining should be nice cherry on top for very specific cases but certainly
> not promoted or advertised. Deleting intermediate variables promotes
> implementation-defined behaviour because of unspecified order of evaluation
> of function arguments. Second, debuggers still operate with lines in mind,
> so jumping to the next statement written like this
> 
> 	f(g(), h())
> 
> can be problematic.

It obviously depends what these functions do, but that remains true for
lots of other use cases applying to a shared memory location, if that's
the case. Also it happens that a lot of string functions that are used
as arguments to other ones are in fact lookups, skip, trim etc which
only manipulate the pointer and the length and not the contents.

> Intermediate variables are much less of a problem now
> that -Wdeclaration-after-statement has been finally abolished! They don't
> consume LOC anymore.

Intermediate variables declared after statements remain an abomination
which turn a visual lookup from O(indent_levels) to O(lines) because
normally you only have to quickly glance a the previous opening brace
and if you don't find, you repeat, but with them you have to visually
scan every single line. They're now allowed for macros and iterators
which can make a good use of them but it's not a reason for abusing
them in code supposed to be reviewable by humans.

> > All this to say that length-based strings do offer quite a lot of
> > benefits over the long term.
> 
> As long as they are named kstring :-) Or std_string, he-he.

That point is the last of my concerns ;-)

Willy
