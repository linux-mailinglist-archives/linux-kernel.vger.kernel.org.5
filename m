Return-Path: <linux-kernel+bounces-144812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9B38A4B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13483B23057
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4813BBE1;
	Mon, 15 Apr 2024 09:03:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C383BBEF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171789; cv=none; b=pV4ph81ZS7z2bay7jZFgekTHLem8W3jpCPBsTUiNmSbpfJu1sLXWCBGd3ysKS2OEXl5YhmXgH2d+2oBNfInoUgRHqW0DHOzyqRiEb8bVvtHEUOkH/tgX5zhkZtx5wTBw31X1iUgDzdwQBQ/Cqfp7du5vI3iGWmZqgM3oLhQAQg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171789; c=relaxed/simple;
	bh=5/T5x66pc6y2H6Pxh4qf/wYay3CQIuW3A34KOdHpBJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvUQ1lQ1PkizCZ6/8Lsi0RwMDtINSwjfAl3MRBBLFsfjoHhNLggksqN0R7vgNaB3ECmhu67a/JiRo7cFHG7eq3W4nwdXF7a7rdnUP92m+lm+tsprQPLZ3JgUXDgfkb0z/3MRo0HRZ5jrS6EErKVZ8w9ljOvmFXs9fkNi/5kQJEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68E092F4;
	Mon, 15 Apr 2024 02:03:32 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.20.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1D283F64C;
	Mon, 15 Apr 2024 02:03:02 -0700 (PDT)
Date: Mon, 15 Apr 2024 10:02:59 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Kees Cook <keescook@chromium.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	syzbot <syzbot+cb76c2983557a07cdb14@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in fpa_set
Message-ID: <ZhztQ9CvDm3UPgE9@FVFF77S0Q05N>
References: <0000000000004cf5c205faf1c7f3@google.com>
 <dcf54740-7cc3-4017-ad1b-8626a22fc15e@I-love.SAKURA.ne.jp>
 <Zg1/1xbmrY4yDfhO@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg1/1xbmrY4yDfhO@shell.armlinux.org.uk>

On Wed, Apr 03, 2024 at 05:12:07PM +0100, Russell King (Oracle) wrote:
> On Tue, Mar 05, 2024 at 08:27:07PM +0900, Tetsuo Handa wrote:
> > Hello.
> > 
> > syzbot is reporting kernel memory overwrite attempt at fpa_set().
> > I guessed that the amount to copy from/to should be sizeof(union fp_state)
> > than sizeof(struct user_fp), for arch_ptrace(PTRACE_[SG]ETFPREGS) for arm
> > is using offset == 0 and size == sizeof(union fp_state). But my guess did not
> > solve the issue ( https://syzkaller.appspot.com/x/patch.diff?x=11e46dbc180000 ).
> 
> This is silly.
> 
> sizeof(struct user_fp) is:
> 
> 	8 * (
> 		1 bit for sign1, 15 bits unused => 2 bytes
> 		1 bit for sign2, 14 bits unused, 1 bit for j => 2 bytes
> 		31 bits for mantissa1 => 4 bytes
> 		32 bits for mantissa0 => 4 bytes
> 	) +
> 	4 bytes for fpsr
> 	4 bytes for fpcr
> 	8 bytes for ftype
> 	4 bytes for init_flag
> 
> This totals 8 * 12 + 4 + 4 + 8 + 4 = 116 bytes or 29 32-bit quantities,
> or 29 "unsigned int"s.
> 
> This is copied into union fp_state. This union is made up of one of
> several different formats depending on the FP being used. user_fp
> doesn't reflect this. However, one of these, struct fp_soft_struct,
> is specifically sized to ensure that user_fp is _smaller_.
> 
> struct fp_soft_struct is 35 unsigned int's. This is 140 bytes. This
> is larger than sizeof(user_fp).
> 
> Therefore, there is _no way_ for fpa_set() to overwrite anything
> outside of thread_info->fpstate, because sizeof(struct user_fp)
> is smaller than sizeof(thread->fpstate).
> 
> Syzbot appears to be wrong in this instance.

I believe the problem here is that HARDENED_USERCOPY tries to prevent any
usercopy to/from task_struct except for fields that are explicitly whitelisted
(which all need to be in one contiguous range). That was added in commit:

  5905429ad85657c2 ("fork: Provide usercopy whitelisting for task_struct")

However, architectures only have the option to provide
arch_thread_struct_whitelist() to whitelist some fields in thread_struct, not
thread_info where the fp_state lives. On arm arch_thread_struct_whitelist()
whitelists precisely nothing:

  static inline void arch_thread_struct_whitelist(unsigned long *offset,
                                                 unsigned long *size)
  {
         *offset = *size = 0;
  }

.. which was added in commit:

  08626a6056aad824 ("arm: Implement thread_struct whitelist for hardened usercopy")

That commit says that all accesses are bounce-buffered and bypass the check,
but AFAICT the fpa_set() code hasn't changed since then, so either that was
wrong or the user_regset_copyin() code has changed.

Kees, I believe you need to look at this.

See the dashboard page at:

  https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14

Mark.

