Return-Path: <linux-kernel+bounces-63714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BE385338C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5521B233DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DC558122;
	Tue, 13 Feb 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w8bAWb1u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817D58105;
	Tue, 13 Feb 2024 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835803; cv=none; b=Bnc0QRdNNNsLrxE/Dq+1P7MnQfkDHYaYIqZt6PPiuWAdyrf5hki7vY2qld4wlSp3hAW27Im9k6NlCWNgjdMdia5m+cbotQXCmA12kRHQ/hVNzHv3CIttcjXLtr7K/XBHp0QhjRurvTVaoNwMYr2AjRR4deIEdiG8NMx+YHxE65Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835803; c=relaxed/simple;
	bh=AfXNvoDPfGxO4Tl8E8xiaQRy/lU+RIhza61C8gLWqgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU8I8nUbyIyf14Zc9RU6xhyiIiIlVRxlI6ykoGpZvBkYKktfvwnyPZd7tECjX+gFhta4hT+J32mV68mSSVKR2aMKxDL1x78dgaMbpFFLy4TnKJZT0zs8XkGij35uS8nmLJHMEsQ79BZyLMljftUdnjeLGLSv53Cx3HO052YBWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w8bAWb1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B44C43390;
	Tue, 13 Feb 2024 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707835803;
	bh=AfXNvoDPfGxO4Tl8E8xiaQRy/lU+RIhza61C8gLWqgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w8bAWb1ukEFNJfV6I2vn9aEwQWg/6XlUcLZXRxIfEHyaq/vDunwdWzBzqwvRy2JZC
	 5YZNHPpJJMmkwg/F54tsVm13wCIJAwJPBcZYFLnyle0g6oRhilqmDU6qfC5DAda5Tz
	 GmSKMn1lNhq5em/cXN5EWFt7A+5ctRgLZtbzHI7g=
Date: Tue, 13 Feb 2024 15:50:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, David Laight <David.Laight@aculab.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [regression] linux-6.6.y, minmax: virtual memory exhausted in
 i586 chroot during kernel compilation
Message-ID: <2024021318-shifty-daybed-fca8@gregkh>
References: <f9f89284-0f48-4971-ad8d-86938a82fafc@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f89284-0f48-4971-ad8d-86938a82fafc@leemhuis.info>

On Mon, Feb 12, 2024 at 05:16:58PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi Greg, Sasha, and David,
> 
> I noticed a regression report in bugzilla.kernel.org that seems to be
> specific to the linux-6.6.y series:
> 
> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218484 :
> 
> > After upgrading to version 6.6.16, the kernel compilation on a i586
> > arch (on a 32bit chroot in a 64bit host) fails with a message:
> > 
> > virtual memory exhausted: Cannot allocate memory
> > 
> > this happens even lowering the number of parallel compilation
> > threads. On a x86_64 arch the same problem doesn't occur. It's not
> > clear whether some weird recursion is triggered that exhausts the
> > memory, but it seems that the problem is caused by the patchset
> > 'minmax' added to the 6.6.16 version, in particular it seems caused
> > by these patches:
> > 
> > - minmax-allow-min-max-clamp-if-the-arguments-have-the-same-signedness.patch
> > - minmax-fix-indentation-of-__cmp_once-and-__clamp_once.patch
> > - minmax-allow-comparisons-of-int-against-unsigned-char-short.patch
> > - minmax-relax-check-to-allow-comparison-between-unsigned-arguments-and-signed-constants.patch
> > 
> > Reverting those patches fixes the memory exhaustion problem during compilation.
> 
> The reporter later added:
> 
> > From a quick test the same problem doesn't occur in 6.8-rc4.
> See the ticket for more details.
> 
> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> not CCed them in mails like this.
> 
> [TLDR for the rest of this mail: I'm adding this report to the list of
> tracked Linux kernel regressions; the text you find below is based on a
> few templates paragraphs you might have encountered already in similar
> form.]
> 
> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
> 
> #regzbot introduced: 204c653d5d0c79940..9487d93f172acef
> https://bugzilla.kernel.org/show_bug.cgi?id=218484
> #regzbot title: minmax: virtual memory exhausted in 6.6.16 with i586 chroot
> #regzbot ignore-activity
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> [1] because bugzilla.kernel.org tells users upon registration their
> "email address will never be displayed to logged out users"

I think this was already fixed in 6.7 or Linus's tree, but I can't seem
to find the commit at the moment.

What file is causing the compiler to crash?  Is it some video or media
driver?

thanks,

greg k-h

