Return-Path: <linux-kernel+bounces-130487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79ED8978D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8274F28D9E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8FA154C08;
	Wed,  3 Apr 2024 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXdSCBef"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF08553A7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171442; cv=none; b=F8NqpVH68mW1r0YwFiiggX7Ua2/6nnFYgIgMGM8+XymCBZ0gq6BfQwuQCyQE9uhWD31/JAAlRE/5IDwPxeaT/BK6a/6uft1TMXwmA2pBFVqRtODPgDgFgQW387tnQfrHKR0MSaPjqpOkm0hpXHZruNQGptQooeEP5/doBHkjRJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171442; c=relaxed/simple;
	bh=MY0qMhK+Ip066j30e2Fo5r+ntZnfCU7bAxLRrjL4Czw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UtBOX2FiMHocPcx1qMuBK8+HHVELuuBKoAUYzfELy8Bs4gjphfVWe1suSK2e0asVIKopi8YkCYGd3qNqJepHf1mmr28r99dLNCUslx7RDhVIR/gZEFufjgUtZvVkFOKgKrzKVckZhXbZEO0wou8c3yFM9XIfIkBlh2Pr8HG6a/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXdSCBef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B90DC433C7;
	Wed,  3 Apr 2024 19:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712171442;
	bh=MY0qMhK+Ip066j30e2Fo5r+ntZnfCU7bAxLRrjL4Czw=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=UXdSCBefo6FnAJG45R4BUy0s90IK4srpa/j731QW3nACmIUJE2aGC/k1/eVvYbI3K
	 HtfDdiyv/Em78GOCqVSzFp7wPzBArHqrd1XPGogosAJNhUGvQLNF8m0M000DW2x99w
	 Sas2Bmm29rjoZ0vx7bfW72FLDVYYr5BpG5/kQZQCd+GfU8+9naplIqnJaJCNkA6T5m
	 Tfarpk8HTb50zyuCxPbR4u1VJuMNz6MQ7uBHR+WxdRHdSqiJDesYI8G7Is9DHhEk97
	 oNDDMo7O1UGyQrHRITcND/ezoZ2qCRGRZtXyWw9VwkPWXXe6rtvy/Z6MQHMCHkJSBH
	 L5OuSB5OeKyNQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 014CDCE0D85; Wed,  3 Apr 2024 12:10:41 -0700 (PDT)
Date: Wed, 3 Apr 2024 12:10:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Zhengxu Chen <zhxchen17@meta.com>,
	Danielle Costantino <dcostantino@meta.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Feng Tang <feng.tang@intel.com>, Waiman Long <longman@redhat.com>,
	John Stultz <jstultz@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH RFC v2 tsc] Check for sockets instead of CPUs to make code
 match comment
Message-ID: <62a0a0cd-3103-4e8f-b4c8-a91f12121e92@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The unsynchronized_tsc() eventually checks num_possible_cpus(), and
if the system is non-Intel and the number of possible CPUs is greater
than one, assumes that TSCs are unsynchronized.  This despite the
comment saying "assume multi socket systems are not synchronized",
that is, socket rather than CPU.  This behavior was preserved by
commit 8fbbc4b45ce3 ("x86: merge tsc_init and clocksource code") and
by the previous relevant commit 7e69f2b1ead2 ("clocksource: Remove the
update callback").

The clocksource drivers were added by commit 5d0cf410e94b ("Time: i386
Clocksource Drivers") back in 2006, and the comment still said "socket"
rather than "CPU".

Therefore, bravely (and perhaps foolishly) make the code match the
comment.

Note that it is possible to bypass both code and comment by booting
with tsc=reliable, but this also disables the clocksource watchdog,
which is undesirable when trust in the TSC is strictly limited.

Changes since v1:

o	Forward-port to v6.9-rc1.

Reported-by: Zhengxu Chen <zhxchen17@meta.com>
Reported-by: Danielle Costantino <dcostantino@meta.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Waiman Long <longman@redhat.com>
Cc: John Stultz <jstultz@google.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: <x86@kernel.org>

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5a69a49acc963..e938b990bea19 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1289,7 +1289,7 @@ int unsynchronized_tsc(void)
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 		/* assume multi socket systems are not synchronized: */
-		if (num_possible_cpus() > 1)
+		if (nr_online_nodes > 1)
 			return 1;
 	}
 

