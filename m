Return-Path: <linux-kernel+bounces-150884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAE08AA634
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C688B1C20FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA93383;
	Fri, 19 Apr 2024 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj2pshnT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB3D7F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713486150; cv=none; b=ripxU6C3dzXO1os76UaYJMJpyhCRPRy9yv9bD+YOWdNH+BeXkcITZJiiISH/fXGtMgTIOBT+HBTYcF4FMtoqwSR/Nqaq7XBTx9aBTah+7IW0wwP5IrO8ybFwT4k2HCBUwVzISwLKeuN+YqAtBrEGajf2LFWF8Sv0AIuqVEEBHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713486150; c=relaxed/simple;
	bh=d3bTP7KKC9aZn1EnXjEovuY7nPSOZbnGxThq3FCimdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pyFJ3/ZPPQbWCqm9LgYgbsu1RqoW2bvYF6r6YTG0wMco+Rf1fnLDFPZ3vK83tNoFnySuKmHWQ0bmbzzZKxKhKGU7rYw7DZuOu/HOSDiDCYnCl9rjKt3XxSpM0wIbTkMokOQdtoHkUJWGmGArGlIPuIhp0FZv5RensCjuUZXhBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj2pshnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F73C113CC;
	Fri, 19 Apr 2024 00:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713486150;
	bh=d3bTP7KKC9aZn1EnXjEovuY7nPSOZbnGxThq3FCimdk=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=gj2pshnT+qP2eCmnwAdg4gUaP2cuYyRadXdsNjVJmXdzPvkSS1WZzBe8U1ZEkP8eb
	 23YUmpEgyCjE5VwFYNPDTpfI4S+s/iAW1liHs5wKdGg67IP2TfFo2hbqCIyXC5vw7Z
	 Y3A4Ums9Bnitb8xBIWYtv84qRpkB+NWSzO2Cyat8YASWbFM0Ond22nEKiGawiJ3eLL
	 QAYVXpnXBiKvbKDtNEbBog1cctm6eYTMSLFQHY2FCOvYA0EY762PYxsNgp3RCWicgW
	 iXqNE80JCNJu/SB+WdPtLP5AhhNHQPpclMgxyvnOzFHeP9skOjGtqDjj4JGErjn3PZ
	 85GZarQsMbkyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F39F6CE0444; Thu, 18 Apr 2024 17:22:26 -0700 (PDT)
Date: Thu, 18 Apr 2024 17:22:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [BUG] objtool complains about missing __noreturn__ on x64_sys_call()
 and ia32_sys_call()
Message-ID: <6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

Recent -next kernels, including next-20240418, get the following objtool
build errors:

vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation

These functions appear to have been added to -next and mainline by
commit 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls
for system calls").  But the diagnostic does not make much sense because
both functions always return unless the system call itself doesn't return.

Adding annotate_unreachable() to the end of each function did not help,
header comment notwithstanding.  On the other hand, these objtool errors
were from Ubuntu clang version 14.0.0-1ubuntu1.1 rather than GCC.
I also freely confess that I don't understand the "};" at the end of
both functions.

Thoughts?

							Thanx, Paul

