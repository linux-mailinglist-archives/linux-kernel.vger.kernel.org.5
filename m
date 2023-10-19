Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191547CF09E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjJSHDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjJSHDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:03:02 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52C6A12D;
        Thu, 19 Oct 2023 00:02:58 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 39J71rZ9000896;
        Thu, 19 Oct 2023 09:01:53 +0200
Date:   Thu, 19 Oct 2023 09:01:53 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <ZTDUYSBS7AO9pAgm@1wt.eu>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
 <202310182248.9E197FFD5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310182248.9E197FFD5@keescook>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:01:54PM -0700, Kees Cook wrote:
> On Thu, Oct 19, 2023 at 07:46:42AM +0200, Christoph Hellwig wrote:
> > On Wed, Oct 18, 2023 at 10:48:49PM +0000, Justin Stitt wrote:
> > > strncpy() is deprecated for use on NUL-terminated destination strings
> > > [1] and as such we should prefer more robust and less ambiguous string
> > > interfaces.
> > 
> > If we want that we need to stop pretendening direct manipulation of
> > nul-terminate strings is a good idea.  I suspect the churn of replacing
> > one helper with another, maybe slightly better, one probably
> > introduces more bugs than it fixes.
> > 
> > If we want to attack the issue for real we need to use something
> > better.
> > 
> > lib/seq_buf.c is a good start for a lot of simple cases that just
> > append to strings including creating complex ones.  Kent had a bunch
> > of good ideas on how to improve it, but couldn't be convinced to
> > contribute to it instead of duplicating the functionality which
> > is a bit sad, but I think we need to switch to something like
> > seq_buf that actually has a counted string instead of all this messing
> > around with the null-terminated strings.
> 
> When doing more complex string creation, I agree. I spent some time
> doing this while I was looking at removing strcat() and strlcat(); this
> is where seq_buf shines. (And seq_buf is actually both: it maintains its
> %NUL termination _and_ does the length counting.) The only thing clunky
> about it was initialization, but all the conversions I experimented with
> were way cleaner using seq_buf.
(...)

I also agree. I'm using several other schemes based on pointer+length in
other projects and despite not being complete in terms of API (due to the
slow migration of old working code), over time it proves much easier to
use and requires far less controls.

With NUL-teminated strings you need to perform checks for each and every
operation. When the length is known and controlled, most often you can
get rid of many tests on intermediate operations and perform a check at
the end, thus you end up with less "if" and "goto fail" in the code,
because the checks are no longer for "not crashing nor introducing
vulnerabilities", but just "returning a correct result", which can often
be detected more easily.

Another benefit I found by accident is that when you need to compare some
tokens against multiple ones (say some keywords for example), it becomes
much faster than strcmp()-based if/else series because in this case you
start by comparing lengths instead of comparing contents. And when your
macros allow you to constify string constants, the compiler will replace
long "if" series with checks against constant values, and may even arrange
them as a tree since all are constants, sometimes mixing with the first
char as the discriminator. Typically on the test below I observe a 10x
speedup at -O3 and ~5x at -O2 when I convert this:

	if (!strcmp(name, "host") ||
	    !strcmp(name, "content-length") ||
	    !strcmp(name, "connection") ||
	    !strcmp(name, "proxy-connection") ||
	    !strcmp(name, "keep-alive") ||
	    !strcmp(name, "upgrade") ||
	    !strcmp(name, "te") ||
	    !strcmp(name, "transfer-encoding"))
		return 1;

to this:

	if (isteq(name, ist("host")) ||
	    isteq(name, ist("content-length")) ||
	    isteq(name, ist("connection")) ||
	    isteq(name, ist("proxy-connection")) ||
	    isteq(name, ist("keep-alive")) ||
	    isteq(name, ist("upgrade")) ||
	    isteq(name, ist("te")) ||
	    isteq(name, ist("transfer-encoding")))
		return 1;

The code is larger but when compiled at -Os, it instead becomes smaller.

Another interesting property I'm using in the API above, that might or
might not apply there is that for most archs we care about, functions
can take a struct of two words passed as registers, and can return
such a struct as a pair of registers as well. This allows to chain
functions by passing one function's return as the argument to another
one, which is what users often want to do to avoid intermediate
variables.

All this to say that length-based strings do offer quite a lot of
benefits over the long term.

Willy
