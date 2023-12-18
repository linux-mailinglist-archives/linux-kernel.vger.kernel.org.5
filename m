Return-Path: <linux-kernel+bounces-4158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D0B81789B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 152A6B226EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B479571446;
	Mon, 18 Dec 2023 17:23:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1C31E4A4;
	Mon, 18 Dec 2023 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="398319087"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="398319087"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 09:23:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="919334061"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="919334061"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 09:23:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rFHKt-0000000725r-1PQS;
	Mon, 18 Dec 2023 19:23:23 +0200
Date: Mon, 18 Dec 2023 19:23:23 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tanzir Hasan <tanzirh@google.com>, Kees Cook <keescook@chromium.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nick DeSaulniers <nnn@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/2] sh: Added kernel.h to word-at-a-time
Message-ID: <ZYCACxTTc4j9VrIs@smile.fi.intel.com>
References: <20231214-libstringheader-v2-0-0f195dcff204@google.com>
 <20231214-libstringheader-v2-1-0f195dcff204@google.com>
 <ZXx5DyidpHFhRevy@smile.fi.intel.com>
 <CAE-cH4p5VJ_A91BAkURBN67ACA0_u7T8UhApUYLQDWeeRY6FWA@mail.gmail.com>
 <CAHp75Vdo=g7ZBAuk79PtLOYs-YHo5sCTp1WVFESHA0xN0zGEmQ@mail.gmail.com>
 <CAKwvOdmMqJacYRfwohY-DXBbmNmz_M4EKUL1KuTv=tT2dO_p1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmMqJacYRfwohY-DXBbmNmz_M4EKUL1KuTv=tT2dO_p1g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 18, 2023 at 08:57:59AM -0800, Nick Desaulniers wrote:
> On Fri, Dec 15, 2023 at 11:09 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Dec 15, 2023 at 8:31 PM Tanzir Hasan <tanzirh@google.com> wrote:
> > > On Fri, Dec 15, 2023 at 8:04 AM Andy Shevchenko <andy@kernel.org> wrote:
> > >> On Thu, Dec 14, 2023 at 09:06:12PM +0000, tanzirh@google.com wrote:

...

> > >> > +#include <linux/kernel.h>
> > >>
> > >> I highly discourage from doing that. Instead, split what is needed to
> > >> the separate (new) header and include that one.
> > >
> > >
> > > I think it would make the most sense to do this in a separate patch.
> > > What word-at-a-time.h needs from kernel.h is REPEAT_BYTE and to my knowledge,
> > > almost every other version of word-at-a-time.h includes kernel.h gets this by
> > > including kernel.h. A future change could be removing REPEAT_BYTE
> > > out of kernel.h
> >
> > Just create a patch that either moves that macro (along with upper_*()
> > and lower_*() APIs) to a more distinguishable header
> > (maybe bytes.h or words.h or wordpart.h, etc) and use it in your case
> > and fix others.
> 
> Andy,
> These are good suggestions and we should do them...
> 
> ...and Tanzir only has 3 weeks left of his internship.  I don't want
> him to get bogged down chasing build regressions from modifying the
> headers themselves.  I think what's best for him from here through the
> remainder of his internship is to stay focused on applying suggestions
> from IWYU to just modify the #include list of .c files, and not start
> splitting .h files.  Splitting the .h files will be the next step, and
> is made easier by having the codebase not have so many indirect
> includes (via IWYU), but we need time to soak header changes, and time
> Tanzir does not have.  Please can we keep the suggestions focused on
> whether the modifications to the header includes (and the tangential
> cleanups) are correct?

Understood. Can we add a comment like

/* FIXME: replace with a proper header to avoid dependency hell */
#include <linux/kernel.h>

?

> While REPEAT_BYTE has a manageable number of users, upper_* and
> lower_* have significantly more; I worry about moving those causing
> regressions.

If you look at how I did similar in the past, I back included new header
into kernel.h. Not the pretty solution, but allows to split in the new code.

> We can move them, but such changes would need significantly more soak time

s/significantly//

But I got your point, see above.

> than this series IMO. Tanzir is also working on statistical analysis; I
> suspect if he analyzes include/linux/kernel.h, he can comment on whether the
> usage of REPEAT_BYTE is correlated with the usage of upper_* and lower_* in
> order to inform whether they should be grouped together or not.

-- 
With Best Regards,
Andy Shevchenko



