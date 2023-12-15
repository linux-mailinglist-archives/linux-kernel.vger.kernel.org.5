Return-Path: <linux-kernel+bounces-783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD718145F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023AF1F24066
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3F11C292;
	Fri, 15 Dec 2023 10:46:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6831A704;
	Fri, 15 Dec 2023 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E9ACC15;
	Fri, 15 Dec 2023 02:46:56 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.45.203])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10DD63F5A1;
	Fri, 15 Dec 2023 02:46:09 -0800 (PST)
Date: Fri, 15 Dec 2023 10:46:04 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "perf: Fix perf_event_validate_size()"
Message-ID: <ZXwubNIxKH9s7DWt@FVFF77S0Q05N>
References: <20231214000620.3081018-1-lucas.demarchi@intel.com>
 <ZXsbHQOWkp4D6mXI@FVFF77S0Q05N.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsbHQOWkp4D6mXI@FVFF77S0Q05N.cambridge.arm.com>

On Thu, Dec 14, 2023 at 03:11:25PM +0000, Mark Rutland wrote:
> On Wed, Dec 13, 2023 at 04:06:20PM -0800, Lucas De Marchi wrote:
> > This reverts commit 382c27f4ed28f803b1f1473ac2d8db0afc795a1b.
> > 
> > When using for_each_sibling_event() lockdep complains on
> > 
> >         WARN_ON_ONCE(__lockdep_enabled &&                       \
> >                      (this_cpu_read(hardirqs_enabled) &&        \
> >                       lockdep_is_held(&(event)->ctx->mutex) != LOCK_STATE_HELD))
> > 
> > after a simple `perf stat -e instructions sleep 1`:
> > 
> > 	WARNING: CPU: 8 PID: 1471 at kernel/events/core.c:1950 __do_sys_perf_event_open+0xf37/0x1080
> > 	Modules linked in: x86_pkg_temp_thermal coretemp kvm_intel kvm e1000e igc irqbypass mei_pxp mei_hdcp crct10dif_pclmul wmi_bmof crc32_pclmul ghash_clmulni_intel i2c_i801 ptp mei_me i2c_smbus pps_core mei intel_lpss_pci video wmi fuse
> > 	CPU: 8 PID: 1471 Comm: perf Not tainted 6.7.0-rc5-linus-demarchi+ #8
> > 	Hardware name: Intel Corporation Rocket Lake Client Platform/RocketLake S UDIMM 4L ERB, BIOS RKLSFWI1.R00.2022.A00.2101052151 01/05/2021
> > 	RIP: 0010:__do_sys_perf_event_open+0xf37/0x1080
> > 	Code: ff e8 ed 30 ab 00 48 8b 81 28 02 00 00 83 ce ff 48 8d b8 a8 00 00 00 e8 67 38 ab 00 48 8b 4c 24 08 83 e8 01 0f 84 56 f9 ff ff <0f> 0b e9 4f f9 ff ff be 03 00 00 00 e8 d8 74 40 00 e9 54 fa ff ff
> > 	RSP: 0018:ffffc90001d6be40 EFLAGS: 00010297
> > 	RAX: 00000000ffffffff RBX: ffff888112bc8040 RCX: ffff888100c34568
> > 	RDX: 0000000080000000 RSI: ffffffff823e2806 RDI: ffffffff824023cb
> > 	RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> > 	R10: 0000000000000001 R11: 0000000000000000 R12: ffff888106560800
> > 	R13: 0000000000000000 R14: 0000000000080002 R15: ffff888100c34568
> > 	FS:  00007f723d196c00(0000) GS:ffff888450800000(0000) knlGS:0000000000000000
> > 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > 	CR2: 00005624c0efdaa0 CR3: 00000001199de002 CR4: 0000000000770ef0
> > 	PKRU: 55555554
> > 	Call Trace:
> > 	 <TASK>
> > 	 ? __do_sys_perf_event_open+0xf37/0x1080
> > 	 ? __warn+0x80/0x170
> > 	 ? __do_sys_perf_event_open+0xf37/0x1080
> > 	 ? report_bug+0x191/0x1c0
> > 	 ? handle_bug+0x3c/0x70
> > 	 ? exc_invalid_op+0x17/0x70
> > 	 ? asm_exc_invalid_op+0x1a/0x20
> > 	 ? __do_sys_perf_event_open+0xf37/0x1080
> > 	 do_syscall_64+0x42/0xf0
> > 	 entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > 	RIP: 0033:0x7f723bf1ea7d
> > 	Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 83 a3 0f 00 f7 d8 64 89 01 48
> > 	RSP: 002b:00007ffc7118ba68 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
> > 	RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f723bf1ea7d
> > 	RDX: 00000000ffffffff RSI: 00000000000005c0 RDI: 00005624c0efb0c0
> > 	RBP: 00007ffc7118bb20 R08: 0000000000000008 R09: 0000000000000000
> > 	R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000000
> > 	R13: 0000000000000008 R14: 00005624c0efb0b0 R15: 00005624c0efb0b0
> > 	 </TASK>
> > 	irq event stamp: 45697
> > 	hardirqs last  enabled at (45703): [<ffffffff81173dca>] console_unlock+0x10a/0x160
> > 	hardirqs last disabled at (45708): [<ffffffff81173daf>] console_unlock+0xef/0x160
> > 	softirqs last  enabled at (45276): [<ffffffff810dab0e>] irq_exit_rcu+0x8e/0xf0
> > 	softirqs last disabled at (45267): [<ffffffff810dab0e>] irq_exit_rcu+0x8e/0xf0
> > 
> > References: https://gitlab.freedesktop.org/drm/intel/-/issues/9847
> > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > ---
> > 
> > Not sure about a proper fix for this. At first I thought it was indeed
> > because previously it was not validating the the size correctly. However
> > then I noticed the warning is actually due to for_each_sibling_event().
> 
> I think what's happening here is that at the point we call
> perf_event_validate_size(), we've found and locked the relevant
> perf_event_context, but haven't set event->ctx yet via
> perf_install_in_context().
> 
> Thanks to earlier checks, we know that group_leader->ctx == ctx, so we have
> actually locked the relevant context, but for_each_sibling_event() doesn't have
> access to the context to discover that.
> 
> The diff below worked for me, though it's a bit ugly.

Thinking a bit more, it'd be cleaner to just special-case this within
perf_event_validate_size(), as below.

I'll go turn that into a proper patch and send it out shortly.

Mark.
---->8----
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c9d123e13b57..9efd0d7775e7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1947,6 +1947,16 @@ static bool perf_event_validate_size(struct perf_event *event)
                                   group_leader->nr_siblings + 1) > 16*1024)
                return false;
 
+       /*
+        * When creating a new group leader, group_leader->ctx is initialized
+        * after the size has been validated, but we cannot safely use
+        * for_each_sibling_event() until group_leader->ctx is set. A new group
+        * leader cannot have any siblings yet, so we can safely skip checking
+        * the non-existent siblings.
+        */
+       if (event == group_leader)
+               return true;
+
        for_each_sibling_event(sibling, group_leader) {
                if (__perf_event_read_size(sibling->attr.read_format,
                                           group_leader->nr_siblings + 1) > 16*1024)

