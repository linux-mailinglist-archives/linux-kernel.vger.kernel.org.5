Return-Path: <linux-kernel+bounces-53144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 757E584A136
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147911F22424
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665B047F71;
	Mon,  5 Feb 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esyUeP8R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498647F5B;
	Mon,  5 Feb 2024 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155155; cv=none; b=ZpnNvAv5yCwd6kyCZWsWBYOkISKrAX/XlS5n0Ail9fT7pJPkRYSxenH0nyCT5r7lg9wtkoLYVqdVguoA4ncPYFtqd6Lkxk+x+kvUpf2FjwrfZxIRZOvFQS9ryItwDhGF0bgEVZP+QbRLmOEzrUTDCfIUYX15yVhMTB/A8xlaf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155155; c=relaxed/simple;
	bh=KcGTEv/HJsgkRxOGRgiheWBXXvA+5x5HPQ7c/2TaC4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrDZldLJpNSNHxUhwWGxw1s11vjis8MDq7J1MBVZw0GBLluzoq9Qb4RwyVucLq7/GQB0bePnDdxH2bFkmwjgIH+AalXOvidhtWixcPHaDUULegT/opOIh5x5/NyZwi/RdyWVMgBF70iKkytUW/r4h3WC7vPYBqgCBLYpc2r5p7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esyUeP8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB57C433F1;
	Mon,  5 Feb 2024 17:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707155155;
	bh=KcGTEv/HJsgkRxOGRgiheWBXXvA+5x5HPQ7c/2TaC4o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=esyUeP8RXiXkP/m0BWRCxX+rSK2QgWHx7kp5MVXepqQ4IzuzrOvWLVm+h31SuOr39
	 AnaK4/i03ppBkS4QvzabFUUr/uyipetvgVeqexoGrI/eAG4med7Dg7Tw3Lu4YSDeNe
	 fhS+Qn1vZgJHY99ZvwVF5swtqekp9kLOUCxGSvq4KAMtngJAJ8yxUzeU4/shf6e9hc
	 MNLwLBIqmScjUZQMaKvu+9vVQsLRD6az+vOx8j1HCQF+iE7eMkMue/jWxWsuMJ7COf
	 +jGOitklx12Sq5ihuGRzA0htBS8gGRbKgVKxY4qwqv4UA6NZqELPsG8y5vIBFmaQu3
	 eRGUOfIWzanFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0BD1BCE1BB6; Mon,  5 Feb 2024 09:45:53 -0800 (PST)
Date: Mon, 5 Feb 2024 09:45:53 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <a6762ad5-62f2-41d4-bba7-c2d9dcb12498@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <c6ce8816-c4ff-4668-8cbb-88285330057d@huaweicloud.com>
 <25fd8537-5a27-4b62-9bf9-1ee7ca59b5b8@paulmck-laptop>
 <Zb0evDquygkDI_8P@slm.duckdns.org>
 <c5d5ad66-da86-447b-8014-820d2c67382d@paulmck-laptop>
 <ZcDdlRzpofn2cAuO@alley>
 <20240205132515.GF69174@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205132515.GF69174@google.com>

On Mon, Feb 05, 2024 at 10:25:15PM +0900, Sergey Senozhatsky wrote:
> On (24/02/05 14:07), Petr Mladek wrote:
> > > Good point, if it does recur, I could try it on bare metal.
> > 
> > Please, me, John, and Sergey know if anyone see this again. I do not
> > feel comfortable when there is problem which might make consoles calm.
> 
> Agreed.
> 
> > Bisection identified this commit:
> > 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
> 
> That commit triggered early boot use-after-free (per kasan) on
> my system, which probably could derail some things.

And enabling KASAN on next-20240130 got me that same KASAN report and
also suppressed the misbehavior, which is not surprising given that
KASAN quarantines free memory for some time.  Plus enabling KASAN
on recent -next does not trigger that KASAN report.

So my guess is that we can attribute my oddball test failures to
that use after free.  But I will of course continue testing.

							Thanx, Paul

