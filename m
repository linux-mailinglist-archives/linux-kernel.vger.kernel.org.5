Return-Path: <linux-kernel+bounces-165829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C5A8B921C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418B228593E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62598168AE2;
	Wed,  1 May 2024 23:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgWbrj+/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2371649A8
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605379; cv=none; b=UV58mRMV/GLBgd8B96b0H86aWAflOCK+4lgOm5I0c3XBw7GKhjy/7AzPf8XQZLEZJ/lMOwwZ2vdTjypp9xa1K8xkawWGTsMD28GiBhfBI7pUPdM/yDwK7n32gfPKQzxZhPHq0n0qqvUoQQYJGEyf2b0pAMmWBmjrVi4oRUNmuns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605379; c=relaxed/simple;
	bh=eA6Bqgpezupf42/4NRslV+u8V0YsI2GtSGd5jtItFeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SATBF9PNtuZZKnM94G5k+rupZs9v3GsHaWlJmowJ4KozEjLgv5y+Q2FBfnUNNG8n3Z4SWk8CpjDm2HzjhY/a8FtVXbPHuydmMLDIxDLAkH99agbZvc4ZqNmHh1zfjC/wR3XVM7ki2QF7fYQUwCScN1bp7uP9HknekEsYAX1wXxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgWbrj+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3141AC072AA;
	Wed,  1 May 2024 23:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714605379;
	bh=eA6Bqgpezupf42/4NRslV+u8V0YsI2GtSGd5jtItFeU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FgWbrj+/kOawgLC90GqWNy8Kk5jt+0MFAIZTysPeA2G69ytKHorfEZpaI2uxbgs35
	 mpA57QN4Xh9Fs+28Tprtf1lLnY2SnPQihr5+43s7E+NefhhgEbju81aNxdCYUiBSPm
	 sSbMyXRPf6lf+SmF+0Wo5tIb9Z3wY4X4f+8NOS0sF4DFhkgCoHojoq3N5NOPu3WA7B
	 7qXd3KutxhPdmcLzUJ1aYtAF6W6nJlJpLIMvDN/cNT30lu8/g/mFbSAroFFfEdY3Yx
	 sHq/zB6oqbEAiRxrV3pzLfbldswirdE/ow1gnQblqe/mLobZtnwNliEPGeT2D/fDf6
	 Z1l+jrITVe8Jw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CAA9CCE1073; Wed,  1 May 2024 16:16:18 -0700 (PDT)
Date: Wed, 1 May 2024 16:16:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Feng Tang <feng.tang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Zhengxu Chen <zhxchen17@meta.com>,
	Danielle Costantino <dcostantino@meta.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, John Stultz <jstultz@google.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH RFC v3 tsc] Check for sockets instead of CPUs to make code
 match comment
Message-ID: <b09884cc-4729-42bc-a3a1-10f38993627e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <62a0a0cd-3103-4e8f-b4c8-a91f12121e92@paulmck-laptop>
 <Zg416EXHJa9CdI9L@feng-clx.sh.intel.com>
 <4b6724fb-2fb7-4081-ba1d-0797d746d9b8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b6724fb-2fb7-4081-ba1d-0797d746d9b8@paulmck-laptop>

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

[ paulmck: Switch from nr_online_nodes to topology_max_packages() per Feng Tang feedback. ]

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
index 5a69a49acc963..0e7f44cc168e2 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1289,7 +1289,7 @@ int unsynchronized_tsc(void)
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
 		/* assume multi socket systems are not synchronized: */
-		if (num_possible_cpus() > 1)
+		if (topology_max_packages() > 1)
 			return 1;
 	}
 

