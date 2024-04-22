Return-Path: <linux-kernel+bounces-153922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F248AD4ED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A647FB21C60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9F0155345;
	Mon, 22 Apr 2024 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SlxMTVOE"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8215533F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814360; cv=none; b=cNRHweqo9vGjmkQzoCPpLTYcze7ITtZ2txeSGCB6+x0+rEvgkWM/WOvr1yv3nnDwhiY5Dbx7Xy8VK97sBzoLCLV4Jca3rRj7IvZytchpi1/0kUWjov1A2JcXZJzmYqtqr5jKZAgx9kvZMt2iI9euHHQsojZs2hSYmnbIq+byrbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814360; c=relaxed/simple;
	bh=8qj6kgnceGl/XWPqUbwu4wqOqoE/ev+jzoHS6K8BcYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5ipQ1gMhIXB5xfJJ/gYe5c+uJHluPP4nNZgik1mEijNDuXaT7JYFtaCz7tBu3TVfVaxY+DXGBOUr3qYPNdOSWxR43XQen5MnoOYYzVORJP+c5eR3gqdbMCs3NIw/l37RgSIA5CUV11XTcPnWmXz2QPJGTQwe+L7gOm/KTOYoZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SlxMTVOE; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Apr 2024 15:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713814355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPjjI9hwHAjLZP2f1PBusI6x5sJtErhiveXDwtFT25I=;
	b=SlxMTVOEsHL/2PHJfSWTgNtE/JRqJhkxOZKFiRxzsmy9xUojDjeLtS4oTJNk+uqjn37uAn
	4zSxwu61rPOr9yLzJGrQFfj3/6wblvKHMmGbUTNlfcpJ8bgrcUZh/Fbeq+glzPlAgGxKPs
	wkm6NkLKwQcrXrhVfemFA9ImPRtS+0E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nathan Chancellor <nathan@kernel.org>, bfoster@redhat.com, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] bcachefs: Fix format specifier in validate_bset_keys()
Message-ID: <omczcaeo74gwmsnysol6m7wwrh4rcdonmcn3fwp64pkavczqcp@enobbzrlpymb>
References: <20240416-bcachefs-fix-format-specifier-validate_bset_keys-v1-1-3ea2cdf28b12@kernel.org>
 <xznpzlnjcf3goexunm6azwercgwz7ikgum3i4gpdyxwykb4e4l@ascd3uztphq3>
 <CAMuHMdV9wMO2E=xNezs5FiDK_F3XKaVPaFbhh9+7djd26KkgMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdV9wMO2E=xNezs5FiDK_F3XKaVPaFbhh9+7djd26KkgMA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 22, 2024 at 02:47:32PM +0200, Geert Uytterhoeven wrote:
> Hi Kent,
> 
> On Wed, Apr 17, 2024 at 12:09 AM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> > On Tue, Apr 16, 2024 at 08:16:02AM -0700, Nathan Chancellor wrote:
> > > When building for 32-bit platforms, for which size_t is 'unsigned int',
> > > there is a warning from a format string in validate_bset_keys():
> > >
> > >   fs/bcachefs/btree_io.c: In function 'validate_bset_keys':
> > >   fs/bcachefs/btree_io.c:891:34: error: format '%lu' expects argument of type 'long unsigned int', but argument 12 has type 'unsigned int' [-Werror=format=]
> > >     891 |                                  "bad k->u64s %u (min %u max %lu)", k->u64s,
> > >         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >   fs/bcachefs/btree_io.c:603:32: note: in definition of macro 'btree_err'
> > >     603 |                                msg, ##__VA_ARGS__);                     \
> > >         |                                ^~~
> > >   fs/bcachefs/btree_io.c:887:21: note: in expansion of macro 'btree_err_on'
> > >     887 |                 if (btree_err_on(!bkeyp_u64s_valid(&b->format, k),
> > >         |                     ^~~~~~~~~~~~
> > >   fs/bcachefs/btree_io.c:891:64: note: format string is defined here
> > >     891 |                                  "bad k->u64s %u (min %u max %lu)", k->u64s,
> > >         |                                                              ~~^
> > >         |                                                                |
> > >         |                                                                long unsigned int
> > >         |                                                              %u
> > >   cc1: all warnings being treated as errors
> > >
> > > BKEY_U64s is size_t so the entire expression is promoted to size_t. Use
> > > the '%zu' specifier so that there is no warning regardless of the width
> > > of size_t.
> > >
> > > Fixes: 031ad9e7dbd1 ("bcachefs: Check for packed bkeys that are too big")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202404130747.wH6Dd23p-lkp@intel.com/
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202404131536.HdAMBOVc-lkp@intel.com/
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >
> > Thanks, applied
> 
> This is still not fixed in today's linux-next, while the issue is now
> causing breakage on several 32-bit defconfs in v6.9-rc5.

Apologies, I just neglected to update my for-next branch, it's in now.

