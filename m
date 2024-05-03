Return-Path: <linux-kernel+bounces-168435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 290CF8BB890
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A641F2358A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111A84E05;
	Fri,  3 May 2024 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ahp/jcO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411275CDE6
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 23:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714780753; cv=none; b=d3RsFXf+zKmdEZlRyY/bq9CqS6Hen+XmxSWKBuSYdS9Xxcq7gHED6ebJT0ipBtLuHVqk2+ymf1hyXKyM9kMRSHDOf8gtmCvi6XnD50c9gwhbjUG72DTaXJMNMisoPNutZpL1IN4LKvUrFkSbUF6B+i+6ouh1rP9xELzy9KNJM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714780753; c=relaxed/simple;
	bh=NL0WiPs/jhkLItIYOWa0RRUZ6Qr80md6Wk/uzeebyAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIeE/lxJ1dl39xBGbNVBXi9FHpgVtBWfuDyDq38Hh6WnY/cXR2lj1RQZBgKD6gwUvG7AWF74zqWMnro56id9T8dDoj+1n389viQgSE+/XitesnjzLhmATZyQeCJvlatjTm1+QOnUObqXvHtG9208/cABnWxvcRxfUVoUiO6Ymfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ahp/jcO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A845AC116B1;
	Fri,  3 May 2024 23:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714780752;
	bh=NL0WiPs/jhkLItIYOWa0RRUZ6Qr80md6Wk/uzeebyAw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ahp/jcO73gw1ELQN0e+CLvHEDzQSMCIFEh5UocYY763udZwbUA7gxpE2WJZBWjJiK
	 U2/+knE9m7VyP0KDxaMgjb4j+D3z2qFtU92srNhrSDPPFucrrmlkCNbWnyDy2V/r86
	 FC6eUnHf1STvqN5bFtZs6l1/E5uAaZVHYpPDtuusPFH82pSG+BsM2osezwyyv75hSD
	 Xtf5z3kbA+DLbNFHmAYnWW9xUCGNI5SB8EXDeVUEEmmnbXb2yugtUlDHK2NonmTS96
	 wJ0oA6CAbPowYxmY/KR2rCaC279d49433XUPQ+lFq67DU31PLHQs5AAS04XxvjCtkH
	 EpLcfHgB6DsoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 46210CE09B5; Fri,  3 May 2024 16:59:12 -0700 (PDT)
Date: Fri, 3 May 2024 16:59:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Elver <elver@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
Message-ID: <2beaba9f-6f83-4a7c-8835-fe5fe88a006c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=whnQXNVwuf42Sh2ngBGhBqbJjUfq5ux6e7Si_XSPAt05A@mail.gmail.com>
 <d4de136e-c4e0-45c2-b33e-9a819cb3a791@paulmck-laptop>
 <CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com>
 <892324fc-9b75-4e8a-b3b6-cf3c5b4c3506@paulmck-laptop>
 <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
 <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop>
 <b3b81374-a19d-4bf5-abb3-15e48c72f01a@paulmck-laptop>
 <ZjPBPWSSdE_VcH_V@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjPBPWSSdE_VcH_V@boqun-archlinux>

On Thu, May 02, 2024 at 09:37:17AM -0700, Boqun Feng wrote:
> On Wed, May 01, 2024 at 03:32:34PM -0700, Paul E. McKenney wrote:
> > On Wed, May 01, 2024 at 02:49:17PM -0700, Paul E. McKenney wrote:
> > > On Wed, May 01, 2024 at 02:20:35PM -0700, Linus Torvalds wrote:
> > > > On Wed, 1 May 2024 at 14:06, Linus Torvalds
> > > > <torvalds@linux-foundation.org> wrote:
> > 
> > [ . . . ]
> > 
> > > > I'd love to see an extension where "const volatile" basically means
> > > > exactly that: the volatile tells the compiler that it can't
> > > > rematerialize by doing the load multiple times, but the "const" would
> > > > say that if the compiler sees two or more accesses, it can still CSE
> > > > them.
> > 
> > Except that "const volatile" already means "you cannot write to it,
> > and reads will not be fused".  :-/
> > 
> > > No promises, other than that if we don't ask, they won't say "yes".
> > > 
> > > Let me see what can be done.
> > 
> > >From a semantics viewpoint __atomic_load_n(&x, __ATOMIC_RELAXED) would
> > work for loading from x.  The compilers that I tried currently do not
> > fuse loads, but they are allowed to do so.
> 
> Yeah, I wonder the same, from what I read, "const volatile" seems to
> be just a (non-volatile) relaxed atomic load.

Hmmm...  Maybe something like this very lightly tested patch?

(I did not immediately see a use case for WRITE_ONCE_MERGEABLE(),
but that is likely a failure of imagination on my part.)

------------------------------------------------------------------------

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 8d0a6280e9824..55e87a8aec56f 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -79,6 +79,15 @@ unsigned long __read_once_word_nocheck(const void *addr)
 	(typeof(x))__read_once_word_nocheck(&(x));			\
 })
 
+/*
+ * Use READ_ONCE_MERGEABLE() and WRITE_ONCE_MERGEABLE() when you need to
+ * avoid duplicating or tearing a load or store, respectively, but when
+ * it is OK to merge nearby loads and stores.  It must also be OK for a
+ * later nearby load to take its value directly from a prior store.
+ */
+#define READ_ONCE_MERGEABLE(x) __atomic_load_n(&x, __ATOMIC_RELAXED)
+#define WRITE_ONCE_MERGEABLE(x, val) __atomic_store_n(&x, val, __ATOMIC_RELAXED)
+
 static __no_kasan_or_inline
 unsigned long read_word_at_a_time(const void *addr)
 {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d5507ac1bbf19..b37c0dbde8cde 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -459,7 +459,7 @@ static void adjust_jiffies_till_sched_qs(void)
 		return;
 	}
 	/* Otherwise, set to third fqs scan, but bound below on large system. */
-	j = READ_ONCE(jiffies_till_first_fqs) +
+	j = READ_ONCE_MERGEABLE(jiffies_till_first_fqs) +
 		      2 * READ_ONCE(jiffies_till_next_fqs);
 	if (j < HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV)
 		j = HZ / 10 + nr_cpu_ids / RCU_JIFFIES_FQS_DIV;

