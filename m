Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722FF7D5BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344294AbjJXTrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbjJXTrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:47:00 -0400
Received: from out-206.mta1.migadu.com (out-206.mta1.migadu.com [IPv6:2001:41d0:203:375::ce])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F1122
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:46:58 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698176816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8N0UMrP9Bp+qXWXqFY94bMqSi2kh8plNyRimGu/oPZU=;
        b=qMx4kFsK8QwlZ3X2kfAhKkvhlFztlFpTUbRFZxzyjRZYUrwEmnAxRyc2/MxKo056L5h7U0
        icL+qjlNJarL4sNTH9ze20atGYTDHb4lzIiejCj3EzEavdNST30oFWijnF121tdqc7sizn
        WJ6I+Oqb2ZBBs1pQu293NTU5DmM5YW8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        keescook@chromium.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/39] lib/string_helpers: Add flags param to
 string_get_size()
Message-ID: <20231024194653.c24qbnk6bx3hep6y@moria.home.lan>
References: <20231024134637.3120277-1-surenb@google.com>
 <20231024134637.3120277-2-surenb@google.com>
 <ZTfUCiFP3hVJ+EXh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTfUCiFP3hVJ+EXh@smile.fi.intel.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 05:26:18PM +0300, Andy Shevchenko wrote:
> (Minimized the list of people for my review / comments)
> 
> On Tue, Oct 24, 2023 at 06:45:58AM -0700, Suren Baghdasaryan wrote:
> > From: Kent Overstreet <kent.overstreet@linux.dev>
> > 
> > The new flags parameter allows controlling
> >  - Whether or not the units suffix is separated by a space, for
> >    compatibility with sort -h
> >  - Whether or not to append a B suffix - we're not always printing
> >    bytes.
> 
> ...
> 
> >  	string_get_size(nblocks, queue_logical_block_size(q),
> > -			STRING_UNITS_10, cap_str_10, sizeof(cap_str_10));
> > +			0, cap_str_10, sizeof(cap_str_10));
> 
> This doesn't seem right (even if it works). We shouldn't rely on the
> implementation details.

It's now a flags parameter: passing an empty set of flags is not
"relying on an implementation detail".

> > -/* Descriptions of the types of units to
> > - * print in */
> > -enum string_size_units {
> > -	STRING_UNITS_10,	/* use powers of 10^3 (standard SI) */
> > -	STRING_UNITS_2,		/* use binary powers of 2^10 */
> > +enum string_size_flags {
> 
> So, please add UNITS_10 as it is now. It will help if anybody in the future
> wants to add, e.g., 8-base numbers.

Octal human readable numbers? No, no one's wanted that so far and I
very much doubt anyone will want that in the future.

> > +	STRING_SIZE_BASE2	= (1 << 0),
> > +	STRING_SIZE_NOSPACE	= (1 << 1),
> > +	STRING_SIZE_NOBYTES	= (1 << 2),
> >  };
> 
> Please, add necessary comments.

That I can do.

> > +enum string_size_units {
> > +	STRING_UNITS_10,	/* use powers of 10^3 (standard SI) */
> > +	STRING_UNITS_2,		/* use binary powers of 2^10 */
> > +};
> 
> And what a point now in having these?

Minimizing the size of the diff and making it more reviewable. It's fine
as an internal implementation thing.

> 
> I assume you need to split this to a few patches:
> 
> 1) rename parameter to be a flags without renaming the definitions (this will
>    touch only string_helpers part);
> 2) do the end job by renaming it all over the drivers;
> 3) add the other flags one-by-one (each in a separate change);
> 4) use new flags where it's needed;

No, those would not be atomic changes. In particular changing the
parameter to a flags without changing the callers - that's not how we do
things.

We're currently working towards _better_ type safety for enums, fyi.

The new flags _could_ be a separate patch, but since it would be
touching much the same code as the previous patch I don't see the point
in splitting it.

> >  	static const char *const units_10[] = {
> > -		"B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
> > +		"", "k", "M", "G", "T", "P", "E", "Z", "Y"
> >  	};
> >  	static const char *const units_2[] = {
> > -		"B", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"
> > +		"", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi", "Yi"
> >  	};
> 
> Ouch, instead of leaving this and actually "cutting the letter" with NO* flags,
> you did something different.

Not sure I understand your complaint? Were you attached to the redundant
Bs?

> Now the main part. Since in 50+% cases (I briefly estimated, it may be more)
> this is used in printf() why not introducing a new pointer extension for that?
> 
> Yes, it may be done separately, but it will look like a double effort to me.
> Instead it might give us a possibility to scale w/o touching users each time
> we want to do something and at the same time hide this complete API under
> printf() implementation.

No, I would not be in favor of another %p extension: in particular,
since this takes integer inputs the lack of type safety for %p
extensions coupled with C's very relaxed approach to integer type
conversion would be a really nasty footgun.
