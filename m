Return-Path: <linux-kernel+bounces-15001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A023E8225FA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FDB1F22DCB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110727EB;
	Wed,  3 Jan 2024 00:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toCVBpww"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161863C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 00:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52C2C433C8;
	Wed,  3 Jan 2024 00:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704241902;
	bh=c0hwMhIsCKXtfxkXFf6Gq2t1ll9WqyctEcwEz2UIEzo=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=toCVBpwwe1KnDV9/ZLIg406/wJF600ZU0JSCrpOfr4XneRIJiu2+tXkSsaQHZ4Hyi
	 Vgg0jBeumqWujmxRLxhqm4j9Sq+twZdIngDDEd03T9nWrPcmD1DITLPu2B9kJAdPS0
	 FGh1MU8SKjFKu8thStTnxhWmKEsJoTBZQanQ/bI4hWmjRhJ46A84JrvnQ6Kbq/BpCx
	 ctHlKoHbHf9nqfHOlJCYj0aXueWfijSBld5LMyM3fJn/oGB6Kqtl5/CK/8N+WC1gt7
	 YjcorpTd/Uk0K6ZHXts1iGdyahPbmB4GwswSz2+uah18QV68dr6ZF1b3aIR6Dcp9tQ
	 ro9DjrJf3kLpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5A15FCE16DA; Tue,  2 Jan 2024 16:31:42 -0800 (PST)
Date: Tue, 2 Jan 2024 16:31:42 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: zhxchen17@meta.com, dcostantino@meta.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, peterz@infradead.org, feng.tang@intel.com,
	longman@redhat.com, jstultz@google.com
Subject: [PATCH RFC tsc] Check for sockets instead of CPUs to make code match
 comment
Message-ID: <fcd476e1-f580-4954-9032-6c25686f0575@paulmck-laptop>
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
Cc: <x86@kernel.org>

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0abc9d..d45084c6a15e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1287,7 +1287,7 @@ int unsynchronized_tsc(void)
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 		/* assume multi socket systems are not synchronized: */
-		if (num_possible_cpus() > 1)
+		if (nr_online_nodes > 1)
 			return 1;
 	}
 

