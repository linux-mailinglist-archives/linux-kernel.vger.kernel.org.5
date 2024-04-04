Return-Path: <linux-kernel+bounces-131642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8040898A57
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF7628C02E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C591D54F;
	Thu,  4 Apr 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG07vG/+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE071D547
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241888; cv=none; b=mZ4Y9gdGIMMTKdRDeiZOsryNNwYr1vUVoPw5A9ljELg9EukunelsRu49mAS01Kx5x6S7rk3w/ZjFqbor8sFTjZHX6xlB68sifzAnddJnUX5FmkZvOCONlEbAg3P1rJkD3CfZimTVgDvsh9cpp8vWx8nCf9HUxi7+DQZOCX/bY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241888; c=relaxed/simple;
	bh=MGdhEH80uy/Lx1+sgaVmu4+ggQSHOkOPqbRZA4BrdOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coeZ2yoVFhqtxCK9rBFTKvg3LLSni/IF+7m9E9AkgBXMN+mA2c42NyUZ02M3CSf444ELuXkJfAnmOG5JQgj0aZgRUaMjlTRCD5/MS5R7tqiHyNvOxEGkxn8U/eXivP9SO1OXieSP72wLTjl9qs6Qxq3C+6q7sJmL+UNL8UOValA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pG07vG/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5E9C433C7;
	Thu,  4 Apr 2024 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712241887;
	bh=MGdhEH80uy/Lx1+sgaVmu4+ggQSHOkOPqbRZA4BrdOk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pG07vG/+3x5FvrF+5EJ0ingecvsya6PlN2fl1BNnQ96FjlU/EPrRyf9PJaTwHVtXz
	 VI3EoILgsi/Ju1BDvWkO706mGVIF40Df7NdEVMdjWdSsA09USr9rBTcwFzvviYFsHq
	 XTwTctDfm7CHa6lnnrVrePou7mPHqOk3M0gfPK8jQ/99zdUBPFc6k4sgARMmVC7UlS
	 k8Fl/TI6t7W1qtGMJVIpvpCS1+j5qfGYRrPMfdMQt/jsC/hYzuqYh41kYRU+0TEMQo
	 UCfmiIyZsfs+N4z0IP+oMKbSLF6zTLeJfgfJ/iNS0wVSQHLOhT99CblXPQXai7mVoH
	 2IG9k10wiZiPw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 73620CE0D0C; Thu,  4 Apr 2024 07:44:47 -0700 (PDT)
Date: Thu, 4 Apr 2024 07:44:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Vineet Gupta <vgupta@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH RFC cmpxchg 3/8] ARC: Emulate one-byte and two-byte
 cmpxchg
Message-ID: <b84884eb-e23b-480d-827e-06f1188ece9e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <31c82dcc-e203-48a9-aadd-f2fcd57d94c1@paulmck-laptop>
 <20240401213950.3910531-3-paulmck@kernel.org>
 <836df0c7-51a7-4786-8a65-a70efe9b6eec@app.fastmail.com>
 <32936b57-f451-460b-a2df-e74293e44f5c@paulmck-laptop>
 <f9b3c536-887a-4a33-bd03-70e60c5aa517@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9b3c536-887a-4a33-bd03-70e60c5aa517@app.fastmail.com>

On Thu, Apr 04, 2024 at 01:57:32PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 2, 2024, at 19:06, Paul E. McKenney wrote:
> > On Tue, Apr 02, 2024 at 10:14:08AM +0200, Arnd Bergmann wrote:
> >> On Mon, Apr 1, 2024, at 23:39, Paul E. McKenney wrote:
> >> > Use the new cmpxchg_emu_u8() and cmpxchg_emu_u16() to emulate one-byte
> >> > and two-byte cmpxchg() on arc.
> >> >
> >> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >> 
> >> I'm missing the context here, is it now mandatory to have 16-bit
> >> cmpxchg() everywhere? I think we've historically tried hard to
> >> keep this out of common code since it's expensive on architectures
> >> that don't have native 16-bit load/store instructions (alpha, armv3)
> >> and or sub-word atomics (armv5, riscv, mips).
> >
> > I need 8-bit, and just added 16-bit because it was easy to do so.
> > I would be OK dropping the 16-bit portions of this series, assuming
> > that no-one needs it.  And assuming that it is easier to drop it than
> > to explain why it is not available.  ;-)
> 
> It certainly makes sense to handle both the same, whichever
> way we do this.

Agreed, at least as long as the properties of the relevant hardware are
consistent with doing so.

> >> Does the code that uses this rely on working concurrently with
> >> non-atomic stores to part of the 32-bit word? If we want to
> >> allow that, we need to merge my alpha ev4/45/5 removal series
> >> first.
> >
> > For 8-but cmpxchg(), yes.  There are potentially concurrent
> > smp_load_acquire() and smp_store_release() operations to this same byte.
> >
> > Or is your question specific to the 16-bit primitives?  (Full disclosure:
> > I have no objection to removing Alpha ev4/45/5, having several times
> > suggested removing Alpha entirely.  And having the scars to prove it.)
> 
> For the native sub-word access, alpha ev5 cannot do either of
> them, while armv3 could do byte access but not 16-bit words.
> 
> It sounds like the old alphas are already broken then, which
> is a good reason to finally drop support. It would appear that
> the arm riscpc is not affected by this though.

Good point, given that single-byte load/store and emulated single-byte
cmpxchg() has been in common code for some time.

So armv3 is OK with one-byte emulated cmpxchg(), but not with two-byte,
which is consistent with the current state of this series in the -rcu
tree.  (My plan is to wait until Monday to re-send the series in order
to allow the test robots to find yet more bugs.)

Or is the plan to also drop support for armv3 in the near term?

> >> For the cmpxchg() interface, I would prefer to handle the
> >> 8-bit and 16-bit versions the same way as cmpxchg64() and
> >> provide separate cmpxchg8()/cmpxchg16()/cmpxchg32() functions
> >> by architectures that operate on fixed-size integer values
> >> but not compounds or pointers, and a generic cmpxchg() wrapper
> >> in common code that can handle the abtraction for pointers,
> >> long and (if absolutely necessary) compounds by multiplexing
> >> between cmpxchg32() and cmpxchg64() where needed.
> >
> > So as to support _acquire(), _relaxed(), and _release()?
> >
> > If so, I don't have any use cases for other than full ordering.
> 
> My main goal here would be to simplify the definition of
> the very commonly used cmpxchg() macro so it doesn't have
> to deal with so many corner cases, and make it work the
> same way across all architectures. Without the type
> agnostic wrapper, there would also be the benefit of
> additional type checking that we get by replacing the
> macros with inline functions.
> 
> We'd still need all the combinations of cmpxchg() and xchg()
> with the four sizes and ordering variants, but at least the
> latter should easily collapse on most architectures. At the
> moment, most architectures only provide the full-ordering
> version.

That does make a lot of sense to me.  Though C-language inline functions
have some trouble with type-generic parameters.

However, my patch is down at architecture-specific level, so should not
affect the cmpxchg() macro, right?  Or am I missing some aspect of your
proposed refactoring?

							Thanx, Paul

