Return-Path: <linux-kernel+bounces-133697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5919089A77D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1BA1F21FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A3233080;
	Fri,  5 Apr 2024 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="EC4J5vK/"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9E2E84E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712358047; cv=none; b=GssNeV/atoeTvgq3i9VNpO5ixgXrJvrA1JCr4J/vt2JNKOAep/Ou8vAn8TuX6U48GiL978JCh1iA3qhNkQJAr6r3uqVw3UtfuzYJBoXddzZ2d2076hXUkQCSL9Ws27+mnl8ubvfy/GilV3z9/qOklmFiqOz4/x8uHBRZauavwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712358047; c=relaxed/simple;
	bh=CiSiD5qhIQWwosDNaLJfp1lrKTM/qSUDfU9Mwb1M0GM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dJzKht/3WHnadQnB8qAMhLNz4kc8H6oAt3Gwe93E8aUxYp69sPf2XBL4qk4wAE3JMqWKVpn1CNn8A7iWpe9201x7xTaXn6KA/Jjzwx12iY0ireit/VIGz4tvUMAzTYmDmyl3xnmAg5l7ARYru91thqtpwfC9t/qz3xuBIp9HZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=EC4J5vK/; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=I2GgNCfpdaZ52tLl2SvBDH3lJIvmmyVEPO4phk6KvCU=;
  b=EC4J5vK/wJCQJTSpd36WFRhmiDLunMCZuZ1TwDGy5iGJBB87qqqKvj30
   LxzJhcMoaj8fOEVx620QnT/9k5eT6saNijm0SkmPDnU8D8i4+pDSOSgjc
   6cqktXSO+gR+sztYAR7m5/pwv4TK53Qe04ExyWsFDkOuVO+TZEVhPfqA3
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,182,1708383600"; 
   d="scan'208";a="160229611"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 01:00:36 +0200
Date: Sat, 6 Apr 2024 01:00:35 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: "Paul E. McKenney" <paulmck@kernel.org>
cc: Julia Lawall <julia.lawall@inria.fr>, Arnd Bergmann <arnd@arndb.de>, 
    linux-kernel@vger.kernel.org
Subject: Re: Finding open-coded workarounds for 1/2-byte cmpxchg()?
In-Reply-To: <f57bcb57-45a4-4dfb-8758-8f7302223ea9@paulmck-laptop>
Message-ID: <alpine.DEB.2.22.394.2404060057110.3446@hadrien>
References: <f57bcb57-45a4-4dfb-8758-8f7302223ea9@paulmck-laptop>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 4 Apr 2024, Paul E. McKenney wrote:

> Hello, Julia!
>
> I hope that things are going well for you and yours.
>
> TL;DR: Would you or one of your students be interested in looking for
> some interesting code patterns involving cmpxchg?  If such patterns exist,
> we would either need to provide fixes or to drop support for old systems.
>
> If this would be of interest, please read on!
>
> Arnd (CCed) and I are looking for open-coded emulations for one-byte
> and two-byte cmpxchg().  Such emulations might be attempting to work
> around the fact that not all architectures support those sizes, being
> as they are only required to support four-byte cmpxchg() and, if they
> are 64-bit architectures, eight-byte cmpxchg().
>
> There is a one-byte emulation in RCU (kernel/rcu/tasks.h), which looks
> like this:
>
> ------------------------------------------------------------------------
>
> u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
> {
> 	union rcu_special ret;
> 	union rcu_special trs_old = READ_ONCE(t->trc_reader_special);
> 	union rcu_special trs_new = trs_old;
>
> 	if (trs_old.b.need_qs != old)
> 		return trs_old.b.need_qs;
> 	trs_new.b.need_qs = new;
> 	ret.s = cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s);
> 	return ret.b.need_qs;
> }
>
> ------------------------------------------------------------------------
>
> An additional issue is posed by these, also in kernel/rcu/tasks.h:
>
> ------------------------------------------------------------------------
>
> 	if (trs.b.need_qs == (TRC_NEED_QS_CHECKED | TRC_NEED_QS)) {
>
> 	return smp_load_acquire(&t->trc_reader_special.b.need_qs);
>
> 	smp_store_release(&t->trc_reader_special.b.need_qs, v);
>
> ------------------------------------------------------------------------
>
> The additional issue is that these statements assume that each CPU
> architecture has single-byte load and store instructions, which some of
> the older Alpha systems do not.  Fortunately for me, Arnd was already
> thinking in terms of removing support for these systems.
>
> But there are additional systems that do not support 16-bit loads and
> stores.  So if there is a 16-bit counterpart to rcu_trc_cmpxchg_need_qs()
> on a quantity that is also subject to 16-bit loads or stores, either
> that function needs adjustment or a few more ancient systems need to
> lose their Linux-kernel support.
>
> Again, is looking for this sort of thing something that you or one of
> your students would be interested in?

Hello,

I tried, but without much success.  The following looks a little bit
promising, eg the use of the variable name "want", but it's not clear that
the rest of the context fits the pattern.

diff -u -p /home/julia/linux/net/sunrpc/xprtsock.c
/tmp/nothing/net/sunrpc/xprtsock.c
--- /home/julia/linux/net/sunrpc/xprtsock.c
+++ /tmp/nothing/net/sunrpc/xprtsock.c
@@ -690,12 +690,9 @@ xs_read_stream(struct sock_xprt *transpo
 		if (ret <= 0)
 			goto out_err;
 		transport->recv.offset = ret;
-		if (transport->recv.offset != want)
-			return transport->recv.offset;

The semantic patch in question was:

@r@
expression olde;
idexpression old;
@@

if (olde != old) { ... return olde; }

@@
expression newe != r.olde;
idexpression nw;
expression r.olde;
idexpression r.old;
@@

*if (olde != old) { ... return olde; }
..
*newe = nw;
..
*return newe;

The semantic patch doesn't include the cmpxchg.  I wasn't sure if that
would always be present, or in what form.

julia

