Return-Path: <linux-kernel+bounces-100472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67789879842
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B282837B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54737D070;
	Tue, 12 Mar 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCzd5Jr7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C579B65
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258555; cv=none; b=D23nfhe9mwQXCqKikL5uN7A3uKkFKKY9ZLQ+xA2SFEAElrllgLi0sT9Js58raE28fIK4dZit4jJQyHinHTWoCuR7cfpCoBmcHbmuyAQNBrYrL50yKQpHoD5gEuroyKt82fy5oxRVxdmnP5rfegrsMwEK2/Q1T+nRGWYpmUJOfJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258555; c=relaxed/simple;
	bh=hHMugEILW0UqdSdjlldWDhuqZFh0+D6PueKHA0uedwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oapu5TGVbNaD/G3pPsGXitb1FYXHKhJdvr7HCdjyYp9L5Ae6De+GU0gynCfW5bM99A9Ip5QybJ3OStBLiQvVhHmmPhIvL7duSRF+xXDOYuokS+oyYnK+9ig3idH4kMor+I2xWal+D03SYFcWiquNcYA7uDalG1pQUNE8sXcG6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCzd5Jr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4789DC43390;
	Tue, 12 Mar 2024 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710258554;
	bh=hHMugEILW0UqdSdjlldWDhuqZFh0+D6PueKHA0uedwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCzd5Jr7Jox23Fm16Gt1e+3vBB4621+FCaf8YVozi3JuXz1w5r270EfArEkUdUNwT
	 9mBa+Cl4xHq7EEX0T7h/cdRsJyJNLjwa1Px8txUt+ODGtyoZjyPJBhgW6VnQNChNvn
	 J6rF914Vyg23y3q+g+yp7ryzLSF/NRtu1h8ou+fPs647cgsgrFg/B9gMCP8sNvLRzh
	 YQktbhRb4n71LLeEqqPDEgt2/NSDfPIBUhVPP2I+NzbEoMSjV34JH3rjL1hfhPYq+m
	 5bm+I3/pFna+XfAlB5YR6awfUXK9CEkv9SRh2pI0w14FBOOSIyBtZSnU5szVxsgLcK
	 ecXX1rnX9CVtg==
Date: Tue, 12 Mar 2024 15:49:10 +0000
From: Lee Jones <lee@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52596: sysctl: Fix out of bounds access for empty
 sysctl registers
Message-ID: <20240312154910.GC1522089@google.com>
References: <2024030645-CVE-2023-52596-b98e@gregkh>
 <Ze68r7_aTn6Vjbpj@tiehlicka>
 <Ze9-Xmn8v4P_wppv@bombadil.infradead.org>
 <20240312091730.GU86322@google.com>
 <ZfAkOFAV15BDMU7F@tiehlicka>
 <ZfBwuDyzLl5M0mhC@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfBwuDyzLl5M0mhC@bombadil.infradead.org>

On Tue, 12 Mar 2024, Luis Chamberlain wrote:

> On Tue, Mar 12, 2024 at 10:45:28AM +0100, Michal Hocko wrote:
> > On Tue 12-03-24 09:17:30, Lee Jones wrote:
> > [...]
> > > > Backporting this is fine, but wouldn't fix an issue unless an external
> > > > module had empty sysctls. And exploiting this is not possible unless
> > > > you purposely build an external module which could end up with empty
> > > > sysctls.
> > 
> > Thanks for the clarification Luis!
> > 
> > > Thanks for the amazing explanation Luis.
> > > 
> > > If I'm reading this correctly, an issue does exist, but an attacker
> > > would have to lay some foundations before it could be triggered.  Sounds
> > > like loading of a malicious or naive module would be enough.
> > 
> > If the bar is set as high as a kernel module to create and empty sysctl
> > directory then I think it is safe to say that the security aspect is
> > mostly moot. There are much simpler ways to attack the system if you are
> > able to load a kernel module.
> 
> Indeed, a simple BUG_ON(1) on external modules cannot possible be a
> source of a CVE. And so this becomes BUG_ON(when_sysctl_empty()) where

Issues that are capable of crashing the kernel in any way, including
with WARN() or BUG() are being considered weaknesses and presently get
CVEs.

> when_sysctl_empty() is hypotethical and I think the source of this
> question for CVE. Today's that not at boot time or dynamically with
> any linux kernel sources released, and so its only possible if:
> 
>   a) As Joel indicated if you backported an empty sysctl array (which
>   would be unless you carried all the infrastructure to support it).
> 
>   b) an external module has an empty sysctl

So what we're discussing here is weather this situation is
_possible_, however unlikely.

You are the maintainer here, so the final decision is yours.  If you say
this situation is impossible and the CVE should be revoked, I'll go
ahead and do just that.

-- 
Lee Jones [李琼斯]

