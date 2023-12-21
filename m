Return-Path: <linux-kernel+bounces-8782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1632A81BC27
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE9A1C24057
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222B61643D;
	Thu, 21 Dec 2023 16:38:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3EC1DA43;
	Thu, 21 Dec 2023 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3235101"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="3235101"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:38:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="847160659"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="847160659"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:38:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rGM3m-00000007tct-14wL;
	Thu, 21 Dec 2023 18:38:10 +0200
Date: Thu, 21 Dec 2023 18:38:09 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: tanzirh@google.com, Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	Greg KH <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 2/2] lib/string: shrink lib/string.i via IWYU
Message-ID: <ZYRp8cn_4pwyBe_m@smile.fi.intel.com>
References: <20231218-libstringheader-v3-0-500bd58f0f75@google.com>
 <20231218-libstringheader-v3-2-500bd58f0f75@google.com>
 <ZYG83l5AW_zVw2aR@smile.fi.intel.com>
 <CAKwvOd=OXOHAiwue98jfqZ=TJSe21ecfgtf6jEihy8F=0EvWnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=OXOHAiwue98jfqZ=TJSe21ecfgtf6jEihy8F=0EvWnA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 08:43:01AM -0800, Nick Desaulniers wrote:
> On Tue, Dec 19, 2023 at 7:55 AM Andy Shevchenko <andy@kernel.org> wrote:
> > On Mon, Dec 18, 2023 at 06:44:48PM +0000, tanzirh@google.com wrote:

...

> > >  #define __NO_FORTIFY
> > >  #include <linux/types.h>
> > > -#include <linux/string.h>
> > > -#include <linux/ctype.h>
> > > -#include <linux/kernel.h>
> > > -#include <linux/export.h>
> > > +#include <linux/bits.h>
> > >  #include <linux/bug.h>
> > >  #include <linux/errno.h>
> > > -#include <linux/slab.h>
> >
> > > -
> >
> > Why this blank is removed?
> 
> The automation isn't aware of any convention around having blank lines
> separate linux/* vs asm/*.  Is that a convention we have throughout
> the kernel, or just this file?

There is no documented conventions like this. Probably one has to add some,
let's say, recommendations.

This way (alphabetical ordering and grouping) it is easier to maintain and
in long term makes easier (less possible conflicts) when backporting.

> If we rerun the automation on this file after Tanzir's patch here, we
> get no further changes.  If we manually touch up the results, then
> rerun the automation, it will undo the manual touch ups.
> 
> I don't mind saying "you might have to manually touch up the results
> of the automation to comply with <link to documentation on stated
> kernel policy/style guide>" but on the other hand I also think it
> would be nice if other folks run the automation so that they don't get
> additional changes.  I'd like to avoid drive-by patches that just undo
> any manual touch ups.

I agree with this, but we have many maintainers and reviewers and some
ask one way, the others another way and so on... Without documentation
one can use a common sense and rationale behind it.

I don't really care about blank lines (however grouping is still done
as of today in this file), but I do care about ordering and grouping.

...

> > > +#include <linux/linkage.h>
> > > +#include <linux/stddef.h>
> > > +#include <linux/string.h>
> > > +#include <linux/ctype.h>
> > >  #include <asm/unaligned.h>
> > > -#include <asm/byteorder.h>
> > > +#include <asm/rwonce.h>
> > >  #include <asm/word-at-a-time.h>
> > >  #include <asm/page.h>
> >
> > Sort this group alphabetically as well.
> 
> By default the automation sorts the result.  I asked Tanzir to
> explicitly disable that; otherwise the resulting diffstat is hard to
> tell precisely what was removed/added vs simply moved.
> 
> If he kept the default behavior, I highly suspect the feedback would
> have been along the lines of "please don't sort the result; I can't
> tell what moved vs was added or removed."

Do you have such examples IRL?

In any case, how would you satisfy the maintainer's request which asks for
sorting?

> Perhaps we should add another commit on the series that manually sorts
> the results _after_ the automation?

I have no objections for this way (doing it in a two separate changes).
With the proposed you can satisfy any maintainer basically. Ones who
do not want sorting, may skip that patch, indeed.

> Do we have anything in Documentation/process/coding-style.rst about
> sorting headers? There's a blip about clang-format sorting them, but
> we don't have strong guidance along the lines of "you ought to sort
> your includes (when you don't have special cases like x-macros)."

Actually there is a rising trend to follow clang-format.
I have no idea what it does, but my rationale is explained above.

...

> > > +#include <vdso/limits.h>
> >
> > Just use linux/limits.h.
> >
> > VDSO is a very special UAPI case. So it's even stricter rule
> > than for asm/ for using anything from there.
> 
> We can add a special rule for this, Tanzir, please add. And remember
> to re-measure the results of that change for this patch's commit
> message.

Yes, please do.

...

> > Expected result:
> >
> > #include <linux/bits.h>
> > #include <linux/bug.h>
> > #include <linux/ctype.h>
> > #include <linux/errno.h>
> > #include <linux/limits.h>
> > #include <linux/linkage.h>
> > #include <linux/stddef.h>
> > #include <linux/string.h>
> > #include <linux/types.h>
> >
> > #include <asm/page.h>
> > #include <asm/rwonce.h>
> > #include <asm/unaligned.h>
> > #include <asm/word-at-a-time.h>

So, let's have above with one or two patches.

-- 
With Best Regards,
Andy Shevchenko



