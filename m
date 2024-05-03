Return-Path: <linux-kernel+bounces-167972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC0C8BB1BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9898288185
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B0158D83;
	Fri,  3 May 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxG6giNO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018EC159919;
	Fri,  3 May 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756793; cv=none; b=jNqyHVooNUZbmrFOpTC8DiCrTul+Bn9nvDmmPo9AH27bNJN5yWPQNgZF6gS5ykstL4/lJ+VN6QcKbbMsgL8TZtbPiZHxFr1fjL4eGKAEufFY4KoeGdU/j8F4KK1V3CQvGyDcpsHsZWE+6HMJceAirK4p1iEdv/y1BiYLqZcdSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756793; c=relaxed/simple;
	bh=rYg2z0tMxWh1QUMfPTv8Rlu1//ZpmA9qzDQyAWqJF80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTEc+lkPw00lOz+T1CfxIIHb12RPRk7jbGSsfPD+TR8cU/2K7HeJLZxCkOeIoDoWMz6G0jLZ/sKkX/IDj+UTxZB2u1EnAOmM0S6fVn+vWlT8EhsMaRhCXXU1xORunjyiLE3fouVgagMIXbqx9LnriZLUO7QeWCG/ykSdftWW5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxG6giNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6B2C116B1;
	Fri,  3 May 2024 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714756792;
	bh=rYg2z0tMxWh1QUMfPTv8Rlu1//ZpmA9qzDQyAWqJF80=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jxG6giNOu7+tpTaOA2fawzw8AOIMOZR1t16nC64QwE2TW6alCVLcAU6ft/GAmsv6I
	 KXypYAKpaelL1bfc+v1gz/EIEnQkTyk4BNYddywqhGJupdpHzk5rEO4gnRP4z3jSra
	 J7Q31ZBIa36ABzPqxqASIqOOpbfEMDElAkEsqViox/eSCrsKIDSJKkKCrrJJiNQuoG
	 zLnba6wICm00Fei+RyGHh2VKVvJkfY3XpiB7Lj/nWFelxosyxy6CG9ixlMwtDK+/Xr
	 A01vHxNJcRc0IHdlPix2Ub0FmrABS9U84UJKndL8UPpocWtc2j6Otq0ao+0D3w7aMU
	 op48azWmczaYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 22E90CE10CB; Fri,  3 May 2024 10:19:52 -0700 (PDT)
Date: Fri, 3 May 2024 10:19:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
Message-ID: <a8de0474-bc19-489b-8df4-e4a352b7ddf2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240503081125.67990-1-arnd@kernel.org>
 <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>

On Fri, May 03, 2024 at 06:53:45PM +0200, John Paul Adrian Glaubitz wrote:
> Hello Arnd,
> 
> On Fri, 2024-05-03 at 10:11 +0200, Arnd Bergmann wrote:
> > I had investigated dropping support for alpha EV5 and earlier a while
> > ago after noticing that this is the only supported CPU family
> > in the kernel without native byte access and that Debian has already
> > dropped support for this generation last year [1] after it turned
> > out to be broken.
> 
> That's not quite correct. Support for older Alphas is not broken and
> always worked when I tested it. It's just that some people wanted to
> raise the baseline in order to improve code performance on newer machines
> with the hope to fix some minor issues we saw on Alpha here and there.
> 
> > This topic came up again when Paul E. McKenney noticed that
> > parts of the RCU code already rely on byte access and do not
> > work on alpha EV5 reliably, so I refreshed my series now for
> > inclusion into the next merge window.
> 
> Hrrrm? That sounds like like Paul ran tests on EV5, did he?

Arnd does say "noticed", not "tested".  No Alpha CPUs here, and I don't
run Alpha emulators.  There is only so much time in each day and only
so much budget for electricity.  ;-)

For the series: Acked-by: Paul E. McKenney <paulmck@kernel.org>

> > Al Viro did another series for alpha to address all the known build
> > issues. I rebased his patches without any further changes and included
> > it as a baseline for my work here to avoid conflicts.
> 
> It's somewhat strange that Al improves code on the older machines only
> to be axed by your series. I would prefer such removals to aimed at an
> LTS release, if possible.

Once they are in mainline, you are within your rights to send Al's
code-improvement patches to -stable, which should get them to the LTS
releases.  It might well be that Arnd was planning to do just that.

							Thanx, Paul

> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

