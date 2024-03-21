Return-Path: <linux-kernel+bounces-110195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3653C885B5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680D21C209B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547E86244;
	Thu, 21 Mar 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0iUR6HRc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659D8565C;
	Thu, 21 Mar 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033457; cv=none; b=FhFzz4EyoF+aTirL9luLBn2ycII3HAWHxYO8uMcQOLBoJ2m3dLs0WUrVA0YTLgThmPNI4CXQOgMjdOUJ+cuhAenDPq3um9RrV6GObdZnOW0CN6xyNLgACijMjNfrBFxViHe/DADepLuvKn852V0D6A60Ts3NgxNJJqzaGmbJaSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033457; c=relaxed/simple;
	bh=ZfR9GPQcw1be5kDF3GjeJkjm+W0b+OgIKcp3kCvASQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnVAGMU/5gmMYVUYkbKWAcstB9biWE3mBnEkjaBB6f6QSfW3Q7tQzQUebr1LmlKZ3vcfg2ZYqz7wMx1FfRRtfJYeus1LAv3eiffoasm8KPPDSIHypzH3H+OCYMTAAgaVZmK6fytZJlss4a7pcTAFbLzANwMA/4U7Tj7xyCgp2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0iUR6HRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FFCC433C7;
	Thu, 21 Mar 2024 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711033457;
	bh=ZfR9GPQcw1be5kDF3GjeJkjm+W0b+OgIKcp3kCvASQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0iUR6HRcYeR3/A62y/tvnwEVRrPw9rNoSHsNwe2aOFi0atBVYKX9i1nyLsO7+bd6R
	 FhCo6VE57tszNTdQtPNdH7R+cAAn4ckXZBLGMJe2dFDbwIm+S3k9w6JTvFP6DrOhEZ
	 +dH7tbQ0Ic4G61xFrj8B48Alp4NfhKuIL7Tl9jd4=
Date: Thu, 21 Mar 2024 16:04:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.9-rc1
Message-ID: <2024032107-upstart-dragonfly-e346@gregkh>
References: <Zfwv2y7P7BneKqMZ@kroah.com>
 <20240321134831.GA2762840@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321134831.GA2762840@dev-arch.thelio-3990X>

On Thu, Mar 21, 2024 at 06:48:31AM -0700, Nathan Chancellor wrote:
> On Thu, Mar 21, 2024 at 02:02:19PM +0100, Greg KH wrote:
> > All of these have been in linux-next for a long time with no reported
> > issue, other than a build warning with some older versions of gcc for a
> > speakup driver, fix for that will come in a few days when I catch up
> > with my pending patch queues.
> ...
> > Samuel Thibault (2):
> >       speakup: Fix 8bit characters from direct synth
> >       speakup: Add /dev/synthu device
> 
> That build warning actually happens with clang, not GCC as far as I am
> aware, and it is actually a hard build error with older versions of
> clang, as Arnd points out in his patch to fix this (although the warning
> is a hard error with CONFIG_WERROR too, which causes allmodconfig to
> break):
> 
> https://lore.kernel.org/20240313100413.875280-1-arnd@kernel.org/
> 
> Samuel's patch was even simpler:
> 
> https://lore.kernel.org/20240309203549.jj2l6epnznyjsrje@begin/
> 
> Why was one of these changes not applied before this was sent? I am
> aware you were on vacation recently but you are now adding a known issue
> to -rc1, which can proliferate to other maintainer's trees and makes
> testing for us more difficult :/

You answered it yourself here, I'm supposed to still be on vacation and
this came in while I was supposed to be ignoring emails, AND it works
fine for me here, which is why I didn't queue it up to my tree for
inclusion in this pull request.

And sorry for the confusion with gcc/clang, I got that mixed up.

> -next has been broken for the entire
> merge window over this, which is usually when there is a chance we can
> get maybe a week of green builds...

Stuff will always slip up at times, given the low-stakes of this, I
didn't think it was needed right now, again, because my local testing
was just fine.  I can go add it to the queue or if it affects Linus's
builds, he can take one of the above changes before I get a chance to
get through my todo mbox:

	$ mdfrm -c ~/mail/todo/
	1776 messages in /home/gregkh/mail/todo/

thanks,

greg "I need a vacation from my vacation..." k-h

