Return-Path: <linux-kernel+bounces-140006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C9B8A0A46
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9A0B2A924
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2479F13E882;
	Thu, 11 Apr 2024 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D+Jler6Z"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872513E3E5;
	Thu, 11 Apr 2024 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821306; cv=none; b=PRgsXOd9dmTeneAF6Yo2Mv437P4eVFc9gs1jS/9X61tPjjIPQPfzkkOFYG3Hp/9dYfu/niyuxcOuJrgxfHzkK6K42GPJsdPoSJzdXc1XTJxATq/ARrrwFWcS1srUie91FBDkM/AoK7KGcrtod5vYhqxHIZu/ra2g7KrYcMdOQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821306; c=relaxed/simple;
	bh=1zRWSXfH24xM+juILZQVIUm8hs+OQD/BWNknxMwOY5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pubOszxV/PhjLLoLAGNjFREoxg+BeMPJMk0XUhoDhNj0HvvPWwHuzZigvtxkuTDIMlxpmhrYUBfTQlTWy9fBBhwmPK2cy6DPyjmIHvOW5ruhRngfSf+e8fA4mb5OMZBWZSYU4+Pb5u+OD7n2OTAgD7mc6Y1Oc2ZhdIFTf7inOpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D+Jler6Z; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712821300; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Wy8/fiKaZNwlfMDJNjam2Eo/3fPP4NAAJyni7X89V1A=;
	b=D+Jler6Ztp91+3u4/OfTg6DMuKQUZr2CTqFk459KGC2GBFS0ro0vNqgkh2HxtwuXHNCv2Skl4/kRkFKs6NuPu6OeaEtq5p3a0UcxEvSzEKZthjzfhc2Q7x6JeLTPYFkvSAhbylL5aCDANLBH9d3xv5bDN5IJof6SP0WEDSMYSoM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W4KbQ8G_1712821297;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W4KbQ8G_1712821297)
          by smtp.aliyun-inc.com;
          Thu, 11 Apr 2024 15:41:39 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	tglx@linutronix.de,
	liusong@linux.alibaba.com,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	deller@gmx.de,
	npiggin@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv13 0/5] *** Detect interrupt storm in softlockup ***
Date: Thu, 11 Apr 2024 15:41:29 +0800
Message-Id: <20240411074134.30922-1-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, guys.
I have implemented a low-overhead method for detecting interrupt
storm in softlockup. Please review it, all comments are welcome.

Changes from v12 to v13:

- Update patch #1 based on the latest kernel code.

- From Thomas, split patch #1 into two. The new patch #1 converts
kstat_irqs into a struct with just the count in it; the new
patch #2 introduces a snapshot mechanism for interrupt statistics.
Due to the code being split, I removed the Reviewed-by tags from
LiuSong and Douglas in patch #1 and patch #2.
Please review it again, and all comments are welcome.

- Revised the comment for using printk() instead of pr_crit() to make
the reasoning clearer.

Changes from v11 to v12:

- From Douglas and Thomas, add a new kconfig knob save memory when
the softlock detector code is not enabled.

- Adjust the order of the patches; patch #1 and patch #2 are related
to genirq, while patch #3 and patch #4 are related to watchdog/softlockup,
making the dependency relationships clearer.

- Add the 'Reviewed-by' tag of Douglas.

Changes from v10 to v11:

- Only patch #2 and patch #3 have been changed.

- Add comments to explain each field of 'struct irqstat' in patch #2.

- Split the inner summation logic out of kstat_irqs() and encapsulate
it into kstat_irqs_desc() in patch #3.

- Adopt Thomas's change log for patch #3.

- Add the 'Reviewed-by' tag of Liu Song.

Changes from v9 to v10:

- The two patches related to 'watchdog/softlockup' remain unchanged.

- The majority of the work related to 'genirq' is contributed by
Thomas, indicated by adding 'Originally-by' tag. And I'd like to
express my gratitude for Thomas's contributions and guidance here.

- Adopt Thomas's change log for the snapshot mechanism for interrupt
statistics.

- Split unrelated change in patch #2 into a separate patch #3.

Changes from v8 to v9:

- Patch #1 remains unchanged.

- From Thomas Gleixner, split patch #2 into two patches. Interrupt
infrastructure first and then the actual usage site in the
watchdog code.

Changes from v7 to v8:

- From Thomas Gleixner, implement statistics within the interrupt
core code and provide sensible interfaces for the watchdog code.

- Patch #1 remains unchanged. Patch #2 has significant changes
based on Thomas's suggestions, which is why I have removed
Liu Song and Douglas's Reviewed-by from patch #2. Please review
it again, and all comments are welcome.

Changes from v6 to v7:

- Remove "READ_ONCE" in "start_counting_irqs"

- Replace the hard-coded 5 with "NUM_SAMPLE_PERIODS" macro in
"set_sample_period".

- Add empty lines to help with reading the code.

- Remove the branch that processes IRQs where "counts_diff = 0".

- Add the Reviewed-by of Liu Song and Douglas.

Changes from v5 to v6:

- Use "./scripts/checkpatch.pl --strict" to get a few extra
style nits and fix them.

- Squash patch #3 into patch #1, and wrapp the help text to
80 columns.

- Sort existing headers alphabetically in watchdog.c

- Drop "softlockup_hardirq_cpus", just read "hardirq_counts"
and see if it's non-NULL.

- Store "nr_irqs" in a local variable.

- Simplify the calculation of "cpu_diff".

Changes from v4 to v5:

- Rearranging variable placement to make code look neater.

Changes from v3 to v4:

- Renaming some variable and function names to make the code logic
more readable.

- Change the code location to avoid predeclaring.

- Just swap rather than a double loop in tabulate_irq_count.

- Since nr_irqs has the potential to grow at runtime, bounds-check
logic has been implemented.

- Add SOFTLOCKUP_DETECTOR_INTR_STORM Kconfig knob.

Changes from v2 to v3:

- From Liu Song, using enum instead of macro for cpu_stats, shortening
the name 'idx_to_stat' to 'stats', adding 'get_16bit_precesion' instead
of using right shift operations, and using 'struct irq_counts'.

- From kernel robot test, using '__this_cpu_read' and '__this_cpu_write'
instead of accessing to an per-cpu array directly, in order to avoid
this warning.
'sparse: incorrect type in initializer (different modifiers)'

Changes from v1 to v2:

- From Douglas, optimize the memory of cpustats. With the maximum number
of CPUs, that's now this.
2 * 8192 * 4 + 1 * 8192 * 5 * 4 + 1 * 8192 = 237,568 bytes.

- From Liu Song, refactor the code format and add necessary comments.

- From Douglas, use interrupt counts instead of interrupt time to
determine the cause of softlockup.

- Remove the cmdline parameter added in PATCHv1.

Bitao Hu (5):
  genirq: Convert kstat_irqs to a struct
  genirq: Provide a snapshot mechanism for interrupt statistics
  genirq: Avoid summation loops for /proc/interrupts
  watchdog/softlockup: low-overhead detection of interrupt storm
  watchdog/softlockup: report the most frequent interrupts

 arch/mips/dec/setup.c                |   2 +-
 arch/parisc/kernel/smp.c             |   2 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c |   2 +-
 include/linux/irqdesc.h              |  16 +-
 include/linux/kernel_stat.h          |   8 +
 kernel/irq/Kconfig                   |   4 +
 kernel/irq/internals.h               |   4 +-
 kernel/irq/irqdesc.c                 |  50 +++++--
 kernel/irq/proc.c                    |   9 +-
 kernel/watchdog.c                    | 215 ++++++++++++++++++++++++++-
 lib/Kconfig.debug                    |  14 ++
 scripts/gdb/linux/interrupts.py      |   6 +-
 12 files changed, 302 insertions(+), 30 deletions(-)

-- 
2.37.1 (Apple Git-137.1)


