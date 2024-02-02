Return-Path: <linux-kernel+bounces-50057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246368473CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5719F1C2360F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEBD1474A1;
	Fri,  2 Feb 2024 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa/+sWZx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AF179A5;
	Fri,  2 Feb 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889487; cv=none; b=TgnShTA+WMngeOtPWrw4B8yziL0TaMxnaETkXM1UHBAoktinyaxm6k5XGlNiW+6tp7REY8RhZ+86qKuW3rP65DYZaOrFdT6K/ddlidSxsgsFhNaibDr1z3/h8IwywT57+hE/tkvE0oCKc1uxB5BFMbzWB2Lyg5nFGgpbUDDOXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889487; c=relaxed/simple;
	bh=wJKT5sIxNf/D+z4BQh9AyVtHvq/XuXC9v+TH4SmaVhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BONO3evOL9HHSXHoW5KyCvD0dAQ4fXrvx8iM2qIntBd2PkI7CHNwm8kds16tg4O3fHYg4/b9pWtb9HACOYuQ/SzRZlQIJDgCaJfuefHVZ//rYZBAG+jIGEM2RCYfyi2pCRH9+ponaDvw1BPC8gHZKz9fjHWFPVqVbV9ng7HP5mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sa/+sWZx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335ABC433F1;
	Fri,  2 Feb 2024 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889487;
	bh=wJKT5sIxNf/D+z4BQh9AyVtHvq/XuXC9v+TH4SmaVhU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sa/+sWZx+x6EWbUZhTKUbEeWga1LllPF+PKpXaA6jjhJYhsyRmGgqOt0nil0iseSt
	 uAjvqTlMbaz/vgUazGmnTdGkZs3wkbAUal3EU9RpC+ZQ91jTvjydsnTmNXqU4dJBs+
	 9OyHu2vCoZYwZNIxYXZdtFXq6becbC7ILFgILCfswe4Zi0XX7XVcMq7OUh95TnLYvr
	 omeS4n0GlPzljshXa5PL9lCGuVG8z6YzethzKmN0qqAEvTsKnEqaceTegRkbd1PPxg
	 LOlCpZqI1hOKbMOC7892Z4Vw9JUKYi9E41b6fvQLQXcmjoizLRep4LG14YOIcg7fV5
	 Py/sPFu+6fuEw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C214ACE2250; Fri,  2 Feb 2024 07:58:06 -0800 (PST)
Date: Fri, 2 Feb 2024 07:58:06 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [BUG] workqueues and printk not playing nice since next-20240130
Message-ID: <7b5a386e-2dcf-49f1-a8e9-c46d2a9f8800@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <410d6a87-bf34-457e-b714-1e6149d48532@paulmck-laptop>
 <87le83ara7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le83ara7.fsf@jogness.linutronix.de>

On Fri, Feb 02, 2024 at 03:18:48PM +0106, John Ogness wrote:
> On 2024-02-02, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > So the system really did boot and is running just fine.  It is just that
> > there is no console output.  Details, details!
> >
> > Is there anything I can do to some combination of workqueues and printk
> > to help debug this?
> 
> The printk ringbuffer contents would certainly be interesting.
> 
> If you build the GDB scripts (CONFIG_GDB_SCRIPTS) then you will have:
> 
> (gdb) lx-dmesg

This says no such command even though I do have CONFIG_GDB_SCRIPTS=y
in my .config.

> As an alternative, you could copy the contents of
> Documentation/admin-guide/kdump/gdbmacros.txt into your .gdbinit and
> then will have:
> 
> (gdb) dmesg

This one hangs.

> There may be some hints in the kernel log as to why there is no console
> output.

On the other hand, next-20240202 doesn't show the problem.  No idea
what might have changed.  :-/

							Thanx, Paul

