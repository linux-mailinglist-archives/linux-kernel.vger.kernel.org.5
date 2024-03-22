Return-Path: <linux-kernel+bounces-111063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84967886780
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413672842A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57713168A4;
	Fri, 22 Mar 2024 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QD+TgHUY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EE516429
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092679; cv=none; b=U6DdfTR3F7Yh2iUa8trlllfrC+L9il9/YAngFU+L2ib5ELV+3DXTX4Td6H+1wAPcLZ8QMspXctSPdqAVFFaqyl3DJLjUSFZd8IepaG0kLyGe0UCmdLkr3rD9OjWYSZmTnOSZ949RZMJJbe2pfI+WsxzWhunF8IBPiqkzvywqfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092679; c=relaxed/simple;
	bh=o020fbPcniAIPoqCsanb1gTGdjBV6t3aRuVr6aQOMH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejgasyuRu/2THH/30dJC6sB+3eK0flItrO7OQfhL2mtdAEblWIwLxkOL2Tv0NqTuWEwZtkj/40terZ0AAHDbCWn1NfEGHG4IUXGbEoVy6xDTo69v5p9HYP63WKDTEUJzB4aZD4a6qHiIJ3j5VO2UA5EcxvM7nmGZBi1n1sWtl4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QD+TgHUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E63FC433C7;
	Fri, 22 Mar 2024 07:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711092679;
	bh=o020fbPcniAIPoqCsanb1gTGdjBV6t3aRuVr6aQOMH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QD+TgHUY1/hYOYJOT651wO62I4s+PaIOxBmLWUvgqAZ41al+39DThfQ7wJfLB/YLF
	 DzHEeJwCSHdlUi6B329WGVmPcYP7y45MSipkvpyGHKY2MAFsOZVX8hp06D607LjQR2
	 WqMX9IWtWKPxX4MgvS7yHS6+dl06D4WPIWhoSeMQ=
Date: Fri, 22 Mar 2024 08:31:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thorsten Scherer <t.scherer@eckelmann.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PULL] siox changes for 6.9
Message-ID: <2024032240-yield-tycoon-f5a4@gregkh>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ad141dd22c7d95ad0bd347f257ce586e1afb22a4.1708328466.git.u.kleine-koenig@pengutronix.de>
 <ftvih5huvc72a76s7fe4zisrqtaax5tcgoukqoi2bkz47zcrq2@4fixszonixgl>
 <2024030732-ocean-handbook-161f@gregkh>
 <nuchb5aaywc5vr6cof4gqbavq4rkte3hvzgs6au3lbg6s6wlq4@bvbjevbum7kc>
 <o52ptgjxknpxhtyemb5xdjyobidejvzluicsoc5ceajy4pz4xy@6e3aecoiz7eh>
 <k7pd3oar3e3mogaokjl7mykqy3w3cifl4dgbukmnsynyqgk5ze@ch5mn5xln2j7>
 <mryuydqd7pqxwkvylp24fped57tsys4me4pazdg4ujwkwtthhp@26rnjgzjesrx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mryuydqd7pqxwkvylp24fped57tsys4me4pazdg4ujwkwtthhp@26rnjgzjesrx>

On Fri, Mar 22, 2024 at 08:22:16AM +0100, Uwe Kleine-König wrote:
> Hello Greg,
> 
> On Sat, Mar 16, 2024 at 08:37:04AM +0100, Uwe Kleine-König wrote:
> > On Fri, Mar 08, 2024 at 10:20:05PM +0100, Uwe Kleine-König wrote:
> > > On Thu, Mar 07, 2024 at 09:38:07AM +0100, Uwe Kleine-König wrote:
> > > > On Thu, Mar 07, 2024 at 07:29:59AM +0000, Greg Kroah-Hartman wrote:
> > > > > Can you send me a "real" git pull request so that I can verify it is
> > > > > what you say it is (ideally with a signed tag)?
> > > > 
> > > > Sure, can do. I will do that tomorrow when (and if) my branch is in next
> > > > and so got a bit more exposure.
> > > 
> > > That has worked so far. So here comes the requested pull request. I
> > > dropped the two patches you collected in the meantime in your
> > > char-misc-next branch. The two branches (i.e. your char-misc-next and
> > > this PR's tag) merge without conflict.
> > > 
> > > The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:
> > > 
> > >   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/siox/for-greg-6.9-rc1
> > > 
> > > for you to fetch changes up to db418d5f1ca5b7bafc8eaa9393ea18a7901bb0ed:
> > > 
> > >   siox: bus-gpio: Simplify using devm_siox_* functions (2024-03-08 22:01:10 +0100)
> > > 
> > > Please pull this for the 6.9-rc1 merge window.
> > 
> > I didn't hear anything back from you and wonder if there is still a
> > chance to get this in. I guess that's just you being busy with other
> > (and more important) stuff. Would it help you if I sent a pull request
> > to Linus directly?
> > 
> > The changes are in next leading to db418d5f1ca5 since next-20240308. (As
> > db418d5f1ca since next-20240312, I rebased as two of the six siox
> > patches got into char-misc-next that were picked up directly from the
> > mailing list. Before the rebase it was 4ab973203404.)
> 
> You probably saw me being impatient and sending the PR to Linus
> directly. If not: These changes are already in the mainline now
> (00453419575d6b4f5ce0f370da9421cf5253f103) and this is the thread you
> can drop from your todo list. I removed the above tag from my repository
> to (hopefully) prevent future confusion.

No worries, I see this is all in Linus's tree.  Sorry for the delay, I
was actually on vacation for once and didn't have the chance to do all
of this (and to be fair, you asked for the pull request way too late...)

thanks,

greg k-h

