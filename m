Return-Path: <linux-kernel+bounces-65926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3A8553DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D89293E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDD113DBBE;
	Wed, 14 Feb 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KSHVifil"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF913DBAE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941954; cv=none; b=aFc5mG8Q6FU3mTkZLc47kXwFe0ZcA9geuXZK+CrrZ6HIH2JHQXZL4VeZIajG47QLAK+RiNDHl1TPDtz9x/VclXzwVmOpG5CPKMJ/jI9khcrvSnHONzBy52MLDmmQunH8Tm5FTM6J+7AIkg7w3m+/pewBQsgSV+W/Xj7+qKke8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941954; c=relaxed/simple;
	bh=RZ54gsjHSdffD9b8pq8FeMFaCz2Uxzo30+wsQyyXz3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUSHjsNAR2Md95ATZbTmXorSKBzlBZqFnwjtAQMcJPmLhviFqXfdSHC25ruqOKeuCYJAtRLGnvbT0UudJqS0Zyd+5bD1LL4JCPXgYQb2T86I0t89odFvlns/FXNwZBGAhh31vuNRsGKTBz9qy1kKxhOAjZ8gvlKwCnt3Gvo4Dg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KSHVifil; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Feb 2024 15:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707941950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L42b5N/GQ68Kpxg4Oo8Su8vLQtANWLk3evJdNxwO3Tg=;
	b=KSHVifilt6B2simPlaHg7DLZfJs3z50rDX6Lz5RUbR0upOZOOJUjl0KIZdMs3v6ywaJB5P
	W1Kgn8BySc9N2zpkP95Jk1oL+/0n0ZArmvvpDlxeOVMpmjfEEw38ahWCoFMsEdFpCYhinw
	ONHkPQmckYCV8MXTHM9NxnTmQdPaKyM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Tesarik <petrtesarik@huaweicloud.com>, 
	Jonathan Corbet <corbet@lwn.net>, David Kaplan <david.kaplan@amd.com>, 
	Larry Dewey <larry.dewey@amd.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Carlos Bilbao <carlos.bilbao@amd.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Petr Mladek <pmladek@suse.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Eric DeVolder <eric.devolder@oracle.com>, 
	Marc =?utf-8?Q?Aur=C3=A8le?= La France <tsi@tuyoix.net>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, "Christian Brauner (Microsoft)" <brauner@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Guenter Roeck <groeck@chromium.org>, Mike Christie <michael.christie@oracle.com>, 
	Maninder Singh <maninder1.s@samsung.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
Message-ID: <xg7iz7syomv3oobjktgn76fyxms4vfs66jul56ub36prwnncxm@hsjhc5m72ipq>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
 <20240214113035.2117-6-petrtesarik@huaweicloud.com>
 <20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
 <2024021425-audition-expand-2901@gregkh>
 <20240214155524.719ffb15@meshulam.tesarici.cz>
 <2024021415-jokester-cackle-2923@gregkh>
 <20240214173112.138e0e29@meshulam.tesarici.cz>
 <g3llwlzlhatvz2a23cntx7lscqarepq4uyaq6wne6my7ddo3mk@6b64pjcnykah>
 <20240214210937.3a19945f@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214210937.3a19945f@meshulam.tesarici.cz>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 14, 2024 at 09:09:37PM +0100, Petr Tesařík wrote:
> On Wed, 14 Feb 2024 13:54:54 -0500
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
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
> > Given that code is going to need a rewrite to make use of this anyways -
> > why not just do the rewrite in Rust?
> 
> Thank you for this question! I concur that rewriting the whole kernel
> in Rust would be a better option. I see two differences:
> 
> 1. amount of work
> 2. regressions
> 
> Rewriting something in Rust means pretty much writing it from scratch.
> Doing that necessarily introduces regressions. Old code has been used.
> It has been tested. In many corner cases. Lots of bugs have been found,
> and they’ve been fixed. If you write code from scratch, you lose much
> of the accumulated knowledge.

But it's work that already has some growing momentum behind it,
especially in the area you cited - decompression algorithms.

> More importantly, sandbox mode can be viewed as a tool that enforces
> decomposition of kernel code. This decomposition is the main benefit.
> It requires understanding the dependencies among different parts of the
> kernel (both code flow and data flow), and that will in turn promote
> better design.

You see this as a tool for general purpose code...?

Typical kernel code tends to be quite pointer heavy.

> > Then you get memory safety, which seems to be what you're trying to
> > achieve here.
> > 
> > Or, you say this is for when performance isn't critical - why not a user
> > mode helper?
> 
> Processes in user mode are susceptible to all kinds of attacks you may
> want to avoid. Sandbox mode can be used in situations where user mode
> does not exist, e.g. to display a boot logo or to unpack initramfs.

[citation needed]

Running code in the kernel does not make it more secure from attack, and
that's a pretty strange idea. One of the central jobs of the kernel is
to provide isolation between different users.

> Sandbox mode is part of the kernel, hence signed, which may be relevant
> if the kernel is locked down, so you can use it e.g. to parse a key
> from the bootloader and put it on the trusted keyring.
> 
> Regarding performance, sandbox overhead is somewhere between kernel
> mode and UMH. It is not suitable for time-critical code (like handling
> NIC interrupts), but it's still much faster than UMH.

yeah, this doesn't seem like a worthwhile direction to go in.

