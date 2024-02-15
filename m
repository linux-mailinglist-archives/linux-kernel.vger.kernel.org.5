Return-Path: <linux-kernel+bounces-66495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51CE855DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F95B2CBB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF613FE2;
	Thu, 15 Feb 2024 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lrawo/vv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5113ADD;
	Thu, 15 Feb 2024 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988270; cv=none; b=dLSjzDcW83oU7GCwkKWf6js43LFAXdGLwyJ1dJhXfPLi4+D5Roi+318pGHNFkJrHqjnGv4iGlToD6okCpKzd6S+n4w7LbeHlR62t1snzko5wbcVf8UHgN4k1kmfUv7aSp7uMkhR8apYRpO3070r0Nvyb0fbPHxFXHEVK1mAAgi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988270; c=relaxed/simple;
	bh=7eGIJxOK0G/jSamaJ4jiJZq4d17+9v1xzV/cbhLB+Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBvnJeClk4gKhUa3itFERHAHopLmrtTplU/g+PHGw/i5LwP6JRlWROJyjNfjo2zidqcJPIvZMRqFAnRh4/seDI8ljqwYN03sde0g6KeRbUnROgyX4OAiDHGxJCgn9lB2r46pSGRelw1THEBz5GCY8JB4m3d4nVmLkE4EnYtXrWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lrawo/vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC24C433F1;
	Thu, 15 Feb 2024 09:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707988269;
	bh=7eGIJxOK0G/jSamaJ4jiJZq4d17+9v1xzV/cbhLB+Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrawo/vvf9RjklBWJmIYkaGooX/f9MU2fxom5gF0oAiukSehNeOQONWHr+1A0MBAX
	 Afb9rzUx+RjdPjUnMeau51NkD1RwJ5amxxkxBB5LcLBaEl/GqQxgUG235aa2cDxZi6
	 PtfNHsZi45/jmfn25HPUihNL7MgiVfmMU+Lz6BfY=
Date: Thu, 15 Feb 2024 10:11:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Tesarik <petrtesarik@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>,
	David Kaplan <david.kaplan@amd.com>,
	Larry Dewey <larry.dewey@amd.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Mike Christie <michael.christie@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Maninder Singh <maninder1.s@samsung.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
Message-ID: <2024021514-manmade-ambitious-414a@gregkh>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
 <20240214113035.2117-6-petrtesarik@huaweicloud.com>
 <20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
 <2024021425-audition-expand-2901@gregkh>
 <20240214155524.719ffb15@meshulam.tesarici.cz>
 <2024021415-jokester-cackle-2923@gregkh>
 <20240214173112.138e0e29@meshulam.tesarici.cz>
 <2024021417-magma-drudge-ad70@gregkh>
 <20240214204254.6208ca2f@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214204254.6208ca2f@meshulam.tesarici.cz>

On Wed, Feb 14, 2024 at 08:42:54PM +0100, Petr Tesařík wrote:
> On Wed, 14 Feb 2024 19:48:52 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Feb 14, 2024 at 05:31:12PM +0100, Petr Tesařík wrote:
> > > On Wed, 14 Feb 2024 16:11:05 +0100
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >   
> > > > On Wed, Feb 14, 2024 at 03:55:24PM +0100, Petr Tesařík wrote:  
> > > > > OK, so why didn't I send the whole thing?
> > > > > 
> > > > > Decomposition of the kernel requires many more changes, e.g. in linker
> > > > > scripts. Some of them depend on this patch series. Before I go and
> > > > > clean up my code into something that can be submitted, I want to get
> > > > > feedback from guys like you, to know if the whole idea would be even
> > > > > considered, aka "Fail Fast".    
> > > > 
> > > > We can't honestly consider this portion without seeing how it would
> > > > work, as we don't even see a working implementation that uses it to
> > > > verify it at all.
> > > > 
> > > > The joy of adding new frameworks is that you need a user before anyone
> > > > can spend the time to review it, sorry.  
> > > 
> > > Thank your for a quick assessment. Will it be sufficient if I send some
> > > code for illustration (with some quick&dirty hacks to bridge the gaps),
> > > or do you need clean and nice kernel code?  
> > 
> > We need a real user in the kernel, otherwise why would we even consider
> > it?  Would you want to review a new subsystem that does nothing and has
> > no real users?  If not, why would you want us to?  :)
> 
> Greg, please enlighten me on the process. How is something like this
> supposed to get in?

If you were in our shoes, what would you want to see in order to be able
to properly review and judge if a new subsystem was ok to accept?

> Subsystem maintainers will not review code that depends on core features
> not yet reviewed by the respective maintainers. If I add only the API
> and a stub implementation, then it brings no benefit and attempts to
> introduce the API will be dismissed. I would certainly do just that if
> I was a maintainer...

Exactly, you need a real user.

> I could try to pack everything (base infrastructure, arch
> implementations, API users) into one big patch with pretty much
> everybody on the Cc list, but how is that ever going to get reviewed?

How are we supposed to know if any of this even works at all if you
don't show that it actually works and is useful?  Has any of that work
even been done yet?  I'm guessing it has (otherwise you wouldn't have
posted this), but you are expecting us to just "trust us, stuff in the
future is going to use this and need it" here.

Again, we can not add new infrastructure for things that have no users,
nor do you want us to.  Ideally you will have at least 3 different
users, as that seems to be the "magic number" that shows that the
api/interface will actually work well, and is flexible enough.  Just
one user is great for proof-of-concept, but that usually isn't good
enough to determine if it will work for others (and so it wouldn't need
to be infrastructure at all, but rather just part of that one feature on
its own.)

> Should I just go and maintain an out-of-tree repo for a few years,
> hoping that it gets merged one day, like bcachefs? Is this the way?

No, show us how this is going to be used.

Again, think about what you would want if you had to review this.

thanks,

greg k-h

