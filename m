Return-Path: <linux-kernel+bounces-132221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EC3899198
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7602854AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED75070CD7;
	Thu,  4 Apr 2024 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huuEDqmt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CACE6F510
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271083; cv=none; b=PuI/oHrqkA6+rQIJgUj4dKremYID1MSXBcXecInOJ8s/zJVxv2a1SG6w1NAM7Nf8nnLCrQ6Lq2bstWjZZVWn162ENMMYWWNRMhr6f7CmuTUhzL+RsNlJI6k75UMn7h/clN8KHaL+LM/RA9djwIppRvjnvci2iic4jxv5yUPXjtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271083; c=relaxed/simple;
	bh=2UN5GNAtSEXlpTizfwZqp5koDj5Ow1gXjAgNuS85JkE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o+M8D635M/Ya1I5XUJTRvwu0HY4I+79tGC1f0ZuvNg+X616vpgf8YtQ2laETAAujQUCCf8ns0dk8uqBq1uw0/Gog/8QL11/ac6IKJR8TuX3L0hHH6WbU7C1yPgnb+rTrlAh3E/QUtQ1in/AVWj4pTRwvADqVe6njIPJSl26Tz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huuEDqmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5612C433C7;
	Thu,  4 Apr 2024 22:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712271082;
	bh=2UN5GNAtSEXlpTizfwZqp5koDj5Ow1gXjAgNuS85JkE=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=huuEDqmtN8iA/Xlr6Lm8EbdM/UjkEeuCdKvRGDv8LaRhDpN5wpoc4NAX495xlbFKo
	 DGjPxlB6nrvQzLNuDJ7gDFsepu7wbF1wjS29cY1yb1pH8lRc2n7aN7h7EJVZUljN4d
	 VSkIaTi6lpgdB4xytWaaWy1rKGzOGl9kqt4MJNW82ArQxOG4fA9WMmSgYYn8g2QrpL
	 pR8FZnh+8QP7MgLwBZ6tNkha21QRTQkYuuXtamyVsqQ2HeOhZhGx6/GWtCE0ep3fLM
	 WXCdPQkSu078Sc8f8XQ341bVucchEaVou+4dPCjXmXrjpGHsrYOkPbzQ9rh5geCI0j
	 ssLlntjqdP8tw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 68762CE0D0C; Thu,  4 Apr 2024 15:51:22 -0700 (PDT)
Date: Thu, 4 Apr 2024 15:51:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Finding open-coded workarounds for 1/2-byte cmpxchg()?
Message-ID: <f57bcb57-45a4-4dfb-8758-8f7302223ea9@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Julia!

I hope that things are going well for you and yours.

TL;DR: Would you or one of your students be interested in looking for
some interesting code patterns involving cmpxchg?  If such patterns exist,
we would either need to provide fixes or to drop support for old systems.

If this would be of interest, please read on!

Arnd (CCed) and I are looking for open-coded emulations for one-byte
and two-byte cmpxchg().  Such emulations might be attempting to work
around the fact that not all architectures support those sizes, being
as they are only required to support four-byte cmpxchg() and, if they
are 64-bit architectures, eight-byte cmpxchg().

There is a one-byte emulation in RCU (kernel/rcu/tasks.h), which looks
like this:

------------------------------------------------------------------------

u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
{
	union rcu_special ret;
	union rcu_special trs_old = READ_ONCE(t->trc_reader_special);
	union rcu_special trs_new = trs_old;

	if (trs_old.b.need_qs != old)
		return trs_old.b.need_qs;
	trs_new.b.need_qs = new;
	ret.s = cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s);
	return ret.b.need_qs;
}

------------------------------------------------------------------------

An additional issue is posed by these, also in kernel/rcu/tasks.h:

------------------------------------------------------------------------

	if (trs.b.need_qs == (TRC_NEED_QS_CHECKED | TRC_NEED_QS)) {

	return smp_load_acquire(&t->trc_reader_special.b.need_qs);

	smp_store_release(&t->trc_reader_special.b.need_qs, v);

------------------------------------------------------------------------

The additional issue is that these statements assume that each CPU
architecture has single-byte load and store instructions, which some of
the older Alpha systems do not.  Fortunately for me, Arnd was already
thinking in terms of removing support for these systems.

But there are additional systems that do not support 16-bit loads and
stores.  So if there is a 16-bit counterpart to rcu_trc_cmpxchg_need_qs()
on a quantity that is also subject to 16-bit loads or stores, either
that function needs adjustment or a few more ancient systems need to
lose their Linux-kernel support.

Again, is looking for this sort of thing something that you or one of
your students would be interested in?

							Thanx, Paul

