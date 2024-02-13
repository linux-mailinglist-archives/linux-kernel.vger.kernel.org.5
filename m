Return-Path: <linux-kernel+bounces-63864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787F08535A5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948E91C2145B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E596027A;
	Tue, 13 Feb 2024 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HpC+xxk7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965276025B;
	Tue, 13 Feb 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840361; cv=none; b=ckBCBAiRxImlno3/T5qO6jOrYUulbemxlWj9EFg9vkarrkn8Ru6mVnw2PPnaOhMZJCE1LRgEokghcPuUYYuGumM9BUoUtdrbZ4VP9oSo5WnUUyfKwObxICFNcv6rPkl6Y40O4LO8Xsk9tNx1GQlpf1NFe7H21CBgoDp+FGYsYsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840361; c=relaxed/simple;
	bh=8IrZp1R6Id5dnAPQaTPV1kv7PcWpRQgZiextr7aFPgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOlrpyAowLi9nLbdfXe/BHSQ0fHxRn83ZAiBX9J3z4lJYsawI+Jx7hpcGWJ/nUtDYgcCEHv0vWe6WXz6ANfPUX83yPyXG6WWkWyZ42W4evQGx7Sv4eEcYZTLjjOA3g0NQOJtNMsETFxTZWU0rll7EZ1w4M1UWfQZGjoWbYme3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HpC+xxk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54887C433C7;
	Tue, 13 Feb 2024 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707840361;
	bh=8IrZp1R6Id5dnAPQaTPV1kv7PcWpRQgZiextr7aFPgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpC+xxk7dsmGsS1klQiOYCtvx6SRk+i18WHGYIJ9m76XsA7lICyPtbdD/Zmq9NgJg
	 UdVSkS6nCzOyFanbdyUtMRKA6v/znfAccvaYRlsUpJSIQ/dy40h3j11X877fP+bVnS
	 huOtfjQXil86hwRFyNJTynz/n6SmVB6+MzbrgWHU=
Date: Tue, 13 Feb 2024 17:05:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David Laight <David.Laight@aculab.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [regression] linux-6.6.y, minmax: virtual memory exhausted in
 i586 chroot during kernel compilation
Message-ID: <2024021331-famished-underpass-1080@gregkh>
References: <f9f89284-0f48-4971-ad8d-86938a82fafc@leemhuis.info>
 <2024021318-shifty-daybed-fca8@gregkh>
 <699726f6-8f5d-4482-8c27-8ea47a483f8a@leemhuis.info>
 <19d0ed563ba0449dac089b95456026dd@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d0ed563ba0449dac089b95456026dd@AcuMS.aculab.com>

On Tue, Feb 13, 2024 at 03:13:10PM +0000, David Laight wrote:
> From: Linux regression tracking (Thorsten Leemhuis)
> > Sent: 13 February 2024 15:01
> > 
> > On 13.02.24 15:50, Greg KH wrote:
> > > On Mon, Feb 12, 2024 at 05:16:58PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> > >>
> > >> I noticed a regression report in bugzilla.kernel.org that seems to be
> > >> specific to the linux-6.6.y series:
> > >>
> > >> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218484 :
> > >>
> > >>> After upgrading to version 6.6.16, the kernel compilation on a i586
> > >>> arch (on a 32bit chroot in a 64bit host) fails with a message:
> > >>>
> > >>> virtual memory exhausted: Cannot allocate memory
> > >>>
> > >>> this happens even lowering the number of parallel compilation
> > >>> threads. On a x86_64 arch the same problem doesn't occur. It's not
> > >>> clear whether some weird recursion is triggered that exhausts the
> > >>> memory, but it seems that the problem is caused by the patchset
> > >>> 'minmax' added to the 6.6.16 version, in particular it seems caused
> > >>> by these patches:
> > >>>
> > >>> - minmax-allow-min-max-clamp-if-the-arguments-have-the-same-signedness.patch
> > >>> - minmax-fix-indentation-of-__cmp_once-and-__clamp_once.patch
> > >>> - minmax-allow-comparisons-of-int-against-unsigned-char-short.patch
> > >>> - minmax-relax-check-to-allow-comparison-between-unsigned-arguments-and-signed-constants.patch
> > >>>
> > >>> Reverting those patches fixes the memory exhaustion problem during compilation.
> > >>
> > >> The reporter later added:
> > >>
> > >>> From a quick test the same problem doesn't occur in 6.8-rc4.
> > >> See the ticket for more details.
> > >
> > > I think this was already fixed in 6.7 or Linus's tree, but I can't seem
> > > to find the commit at the moment.
> > 
> > I thought so as well, but was in the same situation. But your comment
> > made me look again and now I found it: that was 31e97d7c9ae3de ("media:
> > solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)"), which indeed is
> > not yet in 6.6.y.
> 
> The code is actually (now) doing:
> 	clamp(b, clamp(c, a, d), d)
> but previously was four nested min()/max().
> Even the a/b/c/d aren't trivial.
> It always was a pretty long line, but the longer expansions made it explode.
> 
> I was mildly surprised to see the minmax changes backported.
> Not complaining though.

They were needed to fix build errors in a different driver that was
depending on the type checking changes in them.  That's why I added
them.

> But 31e97d7c9ae3de needs backporting as well.

Now queued up, thanks.

greg k-h

