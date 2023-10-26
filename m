Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365587D8882
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjJZSpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjJZSpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:45:03 -0400
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D9410A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:45:01 -0700 (PDT)
Date:   Thu, 26 Oct 2023 14:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698345899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IWLfJjcvE4DmKjAw88y0uY3EAFQFSydpBXEYTrkjUzk=;
        b=m3r/nVChVfwP7Phhrca6bc0213f9kFa8Bpbr68o2xfyMOrHDmRuw+nQfvxeXawFIO9dX61
        RkAFsWAD1KkJsso9wq2c+iTZPog4GNSF8a8ZSqSFdaSSTiP6ZbRztd7dJrlfZsMrzs1lfF
        xF4VY9GPLZhguqYyf03422F3dyeNNUs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        keescook@chromium.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/39] lib/string_helpers: Add flags param to
 string_get_size()
Message-ID: <20231026184456.q6ocnmpq6jhqi7zi@moria.home.lan>
References: <20231024134637.3120277-1-surenb@google.com>
 <20231024134637.3120277-2-surenb@google.com>
 <ZTfUCiFP3hVJ+EXh@smile.fi.intel.com>
 <20231024194653.c24qbnk6bx3hep6y@moria.home.lan>
 <ZTpl1ELUMEmne21U@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTpl1ELUMEmne21U@smile.fi.intel.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 04:12:52PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 24, 2023 at 03:46:53PM -0400, Kent Overstreet wrote:
> > On Tue, Oct 24, 2023 at 05:26:18PM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 24, 2023 at 06:45:58AM -0700, Suren Baghdasaryan wrote:
> 
> ...
> 
> > > >  	string_get_size(nblocks, queue_logical_block_size(q),
> > > > -			STRING_UNITS_10, cap_str_10, sizeof(cap_str_10));
> > > > +			0, cap_str_10, sizeof(cap_str_10));
> > > 
> > > This doesn't seem right (even if it works). We shouldn't rely on the
> > > implementation details.
> > 
> > It's now a flags parameter: passing an empty set of flags is not
> > "relying on an implementation detail".
> 
> 0 is the "default" flag which is definitely relies on the "implementation
> detail". And I think that it's better that caller will explicitly tell what
> they want.
> 
> ...
> 
> > > > -/* Descriptions of the types of units to
> > > > - * print in */
> > > > -enum string_size_units {
> > > > -	STRING_UNITS_10,	/* use powers of 10^3 (standard SI) */
> > > > -	STRING_UNITS_2,		/* use binary powers of 2^10 */
> > > > +enum string_size_flags {
> > > 
> > > So, please add UNITS_10 as it is now. It will help if anybody in the future
> > > wants to add, e.g., 8-base numbers.
> > 
> > Octal human readable numbers? No, no one's wanted that so far and I
> > very much doubt anyone will want that in the future.
> 
> I also in doubt, but still, the explicit is better than implicit in this case
> in my opinion.
> 
> > > > +	STRING_SIZE_BASE2	= (1 << 0),
> > > > +	STRING_SIZE_NOSPACE	= (1 << 1),
> > > > +	STRING_SIZE_NOBYTES	= (1 << 2),
> > > >  };
> 
> ...
> 
> > > > +enum string_size_units {
> > > > +	STRING_UNITS_10,	/* use powers of 10^3 (standard SI) */
> > > > +	STRING_UNITS_2,		/* use binary powers of 2^10 */
> > > > +};
> > > 
> > > And what a point now in having these?
> > 
> > Minimizing the size of the diff and making it more reviewable. It's fine
> > as an internal implementation thing.
> 
> It's not an issue to rename these all over the places as you already did that
> for most of the users. And minimizing diff could be done better with
> --histogram algorithm or so. Otherwise it is not an objective here, right?
> 
> ...
> 
> > > I assume you need to split this to a few patches:
> > > 
> > > 1) rename parameter to be a flags without renaming the definitions (this will
> > >    touch only string_helpers part);
> > > 2) do the end job by renaming it all over the drivers;
> > > 3) add the other flags one-by-one (each in a separate change);
> > > 4) use new flags where it's needed;
> > 
> > No, those would not be atomic changes. In particular changing the
> > parameter to a flags without changing the callers - that's not how we do
> > things.
> 
> > We're currently working towards _better_ type safety for enums, fyi.
> > 
> > The new flags _could_ be a separate patch, but since it would be
> > touching much the same code as the previous patch I don't see the point
> > in splitting it.
> 
> Individual flags can be discussed, objected or approved and won't affect the
> rest of the changes. That's why I highly recommend to reconsider splitting of
> this change.
> 
> It would be possible to squash back if maintainer wants this, but from review
> perspective you are adding more burden to the reviewer's shoulders is not good.
> 
> ...
> 
> > > >  	static const char *const units_10[] = {
> > > > -		"B", "kB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"
> > > > +		"", "k", "M", "G", "T", "P", "E", "Z", "Y"
> > > >  	};
> > > >  	static const char *const units_2[] = {
> > > > -		"B", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"
> > > > +		"", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi", "Yi"
> > > >  	};
> > > 
> > > Ouch, instead of leaving this and actually "cutting the letter" with NO* flags,
> > > you did something different.
> > 
> > Not sure I understand your complaint? Were you attached to the redundant
> > Bs?
> 
> Flag means "cutting" while in the code you "adding" (doing the opposite). Why
> not do exactly "cutting" without touching there. Or since you mentioned changes
> across the all callers, make them explicitly tell that they want Bytes suffix.

Andy: to be blunt, you've been pretty hostile and hysterical ("breaking
the kernel!" over debug statements? really?) and the bikeshedding is
getting to be too much - I'm just going to drop this patch from the
series and we'll post process the output as needed.
