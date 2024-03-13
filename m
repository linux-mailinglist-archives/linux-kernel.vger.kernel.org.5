Return-Path: <linux-kernel+bounces-101193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2813B87A3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 555A6B20CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4D0171C7;
	Wed, 13 Mar 2024 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeXdoz4C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328FC171A6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316897; cv=none; b=SJURJchJ/9Gg86uv103y1j03NSguAE4t+l4BafUl8UFcLY0syxQzrzpskf6v5ZgjttvFDtupD8DqSQXrHrCv91F1+HskDV2O/02NzIN9Uw5g5m4DTKlPnodzQ0LTesq8e0AafWecc2zOR4DbH/5PBNlNEnXOweWNlDDBSqC9ZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316897; c=relaxed/simple;
	bh=nwz0DZfJ4BsAJ2MJ8PJrm4sS1dTMoBxVoe6SWTWTW/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJIfQKriIxZSBNp3zgyPAXHLGOHONqwHGq0xZKiZHYr4U9SxT94tFmSlKWlGJWA132Kjt/j57/hEWgLB2cJYQFwdr7GtH8i3MOwJnIZuCeNZx5Yp/k5vNfS2fqTsjWNGQnVUcr0+vfTlJ0Y1G8c5YVJ4Pj84RyNz03Ajm6Ht8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeXdoz4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB3CC433C7;
	Wed, 13 Mar 2024 08:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710316896;
	bh=nwz0DZfJ4BsAJ2MJ8PJrm4sS1dTMoBxVoe6SWTWTW/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FeXdoz4CnzMEtLqigFvfduBD5MKlTTUyLGcUKYG/Tx0vDUOqYsxe0tWfx1uIBSPTG
	 rg9+Ek6hMtE+n9WTOU388XmUPSW8fvNN0GqNNfBbs7zYiqvJwzTXfm5yVjrfBFCtXb
	 Dd4hqM59MmVQWkLjzz2E5psBZHtpyGAzZ9OHHUTaW27JddKn9a7nj8N52sG+B0d6Xw
	 UDTUf2+YPeki+4XEPiWIqXYv0wD1Ia6yP+DVzVGtEEjp75UCUoXkzpEnO4jeOfDRe1
	 2VXFHWkkt8695CyxPfVMlIMxdS48p0nM5hfiI1ZEMeIyUbtN7AcgVDz/8qImvYSspu
	 n9McUmprB5gfQ==
Date: Wed, 13 Mar 2024 08:01:32 +0000
From: Lee Jones <lee@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Michal Hocko <mhocko@suse.com>,
	cve@kernel.org, linux-kernel@vger.kernel.org,
	Joel Granados <j.granados@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2023-52596: sysctl: Fix out of bounds access for empty
 sysctl registers
Message-ID: <20240313080132.GD1522089@google.com>
References: <2024030645-CVE-2023-52596-b98e@gregkh>
 <Ze68r7_aTn6Vjbpj@tiehlicka>
 <Ze9-Xmn8v4P_wppv@bombadil.infradead.org>
 <20240312091730.GU86322@google.com>
 <ZfAkOFAV15BDMU7F@tiehlicka>
 <ZfBwuDyzLl5M0mhC@bombadil.infradead.org>
 <20240312154910.GC1522089@google.com>
 <ZfCZGevmDe149QeX@bombadil.infradead.org>
 <202403121431.55E67E201@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202403121431.55E67E201@keescook>

On Tue, 12 Mar 2024, Kees Cook wrote:

> On Tue, Mar 12, 2024 at 11:04:09AM -0700, Luis Chamberlain wrote:
> > + Kees,
> > 
> > On Tue, Mar 12, 2024 at 03:49:10PM +0000, Lee Jones wrote:
> > > On Tue, 12 Mar 2024, Luis Chamberlain wrote:
> > > 
> > > > On Tue, Mar 12, 2024 at 10:45:28AM +0100, Michal Hocko wrote:
> > > > > On Tue 12-03-24 09:17:30, Lee Jones wrote:
> > > > > [...]
> > > > > > > Backporting this is fine, but wouldn't fix an issue unless an external
> > > > > > > module had empty sysctls. And exploiting this is not possible unless
> > > > > > > you purposely build an external module which could end up with empty
> > > > > > > sysctls.
> > > > > 
> > > > > Thanks for the clarification Luis!
> > > > > 
> > > > > > Thanks for the amazing explanation Luis.
> > > > > > 
> > > > > > If I'm reading this correctly, an issue does exist, but an attacker
> > > > > > would have to lay some foundations before it could be triggered.  Sounds
> > > > > > like loading of a malicious or naive module would be enough.
> > > > > 
> > > > > If the bar is set as high as a kernel module to create and empty sysctl
> > > > > directory then I think it is safe to say that the security aspect is
> > > > > mostly moot. There are much simpler ways to attack the system if you are
> > > > > able to load a kernel module.
> > > > 
> > > > Indeed, a simple BUG_ON(1) on external modules cannot possible be a
> > > > source of a CVE. And so this becomes BUG_ON(when_sysctl_empty()) where
> > > 
> > > Issues that are capable of crashing the kernel in any way, including
> > > with WARN() or BUG() are being considered weaknesses and presently get
> > > CVEs.
> > 
> > Its not possible to crash any released kernel with the out of bounds issue
> > today, the commit is just a fix for a future world with empty sysctls
> > which just don't exist today.
> > 
> > Yes you can crash an external module with an empty sysctl on kernels
> > without that commit, but an empty sysctl is not common practice for
> > external modules, they'd have to have custom #ifdefs embedded as noted
> > earlier with the example crash. So your average external module should
> > not be able to crash existing kernels. The scope of a crash then would
> > be external modules that used older kernels without the fix starting after
> > v6.6. Since the fix is already meged on v6.6+ the scope of possible
> > kernels is small, and you'd need a specially crafted sysctl empty array
> > to do so.
> > 
> > > > when_sysctl_empty() is hypotethical and I think the source of this
> > > > question for CVE. Today's that not at boot time or dynamically with
> > > > any linux kernel sources released, and so its only possible if:
> > > > 
> > > >   a) As Joel indicated if you backported an empty sysctl array (which
> > > >   would be unless you carried all the infrastructure to support it).
> > > > 
> > > >   b) an external module has an empty sysctl
> > > 
> > > So what we're discussing here is weather this situation is
> > > _possible_, however unlikely.
> > 
> > I tried my best to summarize that world as we see it above.
> > 
> > > You are the maintainer here, so the final decision is yours.  If you say
> > > this situation is impossible and the CVE should be revoked, I'll go
> > > ahead and do just that.
> > 
> > To the best of our ability, from our perspective, upon our review, the
> > only way to trigger a crash would be with sysctls on external modules
> > loaded on these kernels:
> > 
> >  * v6.6 up to v6.6.15 (v6.6.16 has the fix backported) so 16 releases
> >  * v6.7 up to v6.7.3  (v6.7.4 has the fix backported) so 4 releases
> > 
> > External modules having empty sysctls should be rare, however possible.
> > So these 20 release would be affected by a crash with specially crafted
> > external modules. I suppose one way to exploit this, might be for a
> > vendor providing an external safe-looking module with #ifdefs which make
> > a sysctl seem non-empty but in reality it would be. That issue would
> > exist for 20 kernel releases. Could someone craft something with the out
> > of bounds access given the context to do something evil? Your domain of
> > expertise, your call, not ours.
> 
> I'm not a member of the CNA, but I would lean "yes, the absolute weakest
> of CVE" after spending some time reading the code, reading this thread,
> to dig in and look at this. If it's a malicious module, it doesn't matter:
> the module can do anything. If it's a published module that an attacker
> could use due to the resulting logic of processing the 0th sysctl table
> entry, okay, yes, CVE. Likely insanely rare, but not impossible. But,
> if, as Luis says, there are no upstream modules like this, then it's
> not a CVE.
> 
> So for real-world impact, we'd have to either say "there might be an
> out-of-tree module that could be used as a stepping stone here, and we
> want to protect our users, so let's assign a CVE" or we take a hard line
> and say that's up to downstreams to assign CVEs for their modules.
> 
> I have tried to argue before that it's up to the core kernel code to Do
> The Right Thing, even in the face of crappy out-of-tree code, so to me,
> since this is a (very very very limited) weakness in the core kernel
> code, give it a CVE.
> 
> My attempt at a CVSS for it yields a 3.4 overall:
> AV:L/AC:H/PR:H/UI:N/S:U/C:L/I:L/A:L/E:U/RL:O/RC:X
> https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator?vector=AV:L/AC:H/PR:H/UI:N/S:U/C:L/I:L/A:L/E:U/RL:O/RC:X&version=3.1

Thank you Luis and Kees for your input.  Your efforts are very much
appreciated.  I have read and digested everyone's points.

Since no one (including myself) is willing to conclude that this
represents _zero_ risk, the allocation will not be rescinded.  In our
view a CVE, however weak, is still a CVE.  Thus, inline with our
documented cautious posture I'm going to err on the side of it.

Thanks again everyone.

-- 
Lee Jones [李琼斯]

