Return-Path: <linux-kernel+bounces-154998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD828AE424
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA051F23BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF184A44;
	Tue, 23 Apr 2024 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo692RAm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8C7FBBF;
	Tue, 23 Apr 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872028; cv=none; b=Pw8uA9cm0W0pWbSL9WnvmGJqNOiA473/FYCA3+wyXW88IvS1Ktcey8RXOUAst3an93mj+F3GvAUQletz8hzDS0Vbr9gT37PUetjuXGmvIffoW5sGXC4HKVshEf3ydbu0JfrS0//k6MY/KRnBc8hklnJKYmGbWXBVNOZSjS9LDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872028; c=relaxed/simple;
	bh=cC5/q/rDAJvbVMbrF1YBegWAnIa9bk1DnKTjp39vagY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSsYJco78MWDmC2pIJhUP9lMgh1CbeOjZdH6qD+LR52WtFqnl+bGvdBFThti8VMdQRJkWGTHIZLCl8KKkuoUVk0syEx6Wt1Uk4KL1sz0Isesv1yxEzS/TS6NxTDfdoi3ptkepmUDwdl0XBgaS7sbvV9uSaBxSqG7HIcvkRXuzqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo692RAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609C9C116B1;
	Tue, 23 Apr 2024 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872027;
	bh=cC5/q/rDAJvbVMbrF1YBegWAnIa9bk1DnKTjp39vagY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zo692RAmsm1vLjhATemvFORhpgACbgV41af4TnLMOJADX9uv7UclWmvlJ+vvu2/wl
	 o4tPRRJwNcLM0RAwdvldUp070gZPcWK5b+pOfcY1Ulj7yx6loKa1w3dJUzAQyoX2bc
	 Zl259Nko9SuGT++XfEWLwD4XSIkVPsR9CHrPZZZQzUyZQULDmBM0JCKSvU8sOC/bjD
	 AxFNkXugtAGl5qUbrAPUlVZC9NgzTtEVRw8Xe4frygrr4EWj/61NP5IfOtj4utOS27
	 IsxGQOv/9XWMGr36zBeg8WQPijI3c1zsvwTKARs1lW/2UveoNvffDSqMdFF24PnLs7
	 T94gAUNSvHpQA==
Date: Tue, 23 Apr 2024 13:33:44 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Nadav Amit <namit@vmware.com>,
	Breno Leitao <leitao@debian.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 09/10] x86/rcu: Add rcu_preempt_count
Message-ID: <ZiecmBdOwHaaMufg@localhost.localdomain>
References: <20240328075318.83039-1-jiangshanlai@gmail.com>
 <20240328075318.83039-10-jiangshanlai@gmail.com>
 <ZiZEcBEvK8NOQvwU@localhost.localdomain>
 <CAJhGHyBMYDWbRYp86wBu3x6Ry8HM2yiZxNv_WATwhzV+OO+ZFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyBMYDWbRYp86wBu3x6Ry8HM2yiZxNv_WATwhzV+OO+ZFA@mail.gmail.com>

Le Tue, Apr 23, 2024 at 05:02:35PM +0800, Lai Jiangshan a écrit :
> Hello, Frederic
> 
> Thanks for reviewing.
> 
> On Mon, Apr 22, 2024 at 7:05 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> 
> > > +
> > > +/* We use the MSB mostly because its available */
> >
> > I think you can safely remove the "We " from all the comments :-)
> 
> The file is mainly copied from arch/x86/include/asm/preempt.h.
> I will rephrase sentences in later iterations.
> 
> >
> > > +#define RCU_PREEMPT_UNLOCK_SPECIAL_INVERTED  0x80000000
> >
> > How about RCU_PREEMPT_UNLOCK_FASTPATH ?
> 
> 
> I'm not good at naming. But the MSB really means exactly the opposite
> of current->rcu_read_unlock_special and I think "UNLOCK_SPECIAL_INVERTED"
> fits the meaning.

Right but I tend to think a constant should tell what something is, not what
something is not.

FWIW, p->rcu_read_unlock_special could even be renamed to p->rcu_read_unlock_slowpath

Thanks.

