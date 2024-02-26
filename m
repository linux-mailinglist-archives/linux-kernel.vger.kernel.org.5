Return-Path: <linux-kernel+bounces-80397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA078667C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2571F21D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EE91B7E5;
	Mon, 26 Feb 2024 02:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eMTKd+N7"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5381014008;
	Mon, 26 Feb 2024 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708913397; cv=none; b=YZeMFWzWOvRTwNjSkVsv0p+p0eeg4QwqhWHZGVLME6zWS3k9XOIL/Jrqa20A1+nLfdo0tMGqXK/OtP9FxHUO2YiM3cB9GXTIkKYHD2yOCpPNfl+wJEiOoI0tygoBg9/7lqpmEqhcS73iKN0zhREoVMJHqShPCEzpSk/9n7Jwy2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708913397; c=relaxed/simple;
	bh=xqSdcvfF52m0d+uCT6y8AaQUuKTyUCqz1phPw/C3g74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BRx7pMjAUlbAxUFuSzmr6JOvPVo5KopeGigopzFducsSlWPBNgaq0nOo+zV0E2hXeku5hJmc9iDOwgsJ2nUIPo9VE0gO37jvuCY2p7wiTISMs2y770x8AselF3VpavKQu+EJtmduL78XouXcf6Auq0dH80j59hwpbSFWcuttAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eMTKd+N7; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708913386; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=jv+aK5XwpBtYKEi0Xkxc21RyxobUytKZ1H8vPKocwNs=;
	b=eMTKd+N7YnjF2WTjA/irnQq/2pbtiQUNdLBbyHKdguTbINlG+LaxKUlsaa8lL4rrzxbLhCiiLbIy7EG0dZJ0FBnHTuStkwxXBghDjK85ATdPrG48iovB1/1U0pdR74M6l2+tlkuB2AYxY2sfi0MJkCu9EHd8dekFfHJCWm8Srfw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W1A1HYP_1708913382;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W1A1HYP_1708913382)
          by smtp.aliyun-inc.com;
          Mon, 26 Feb 2024 10:09:44 +0800
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
Subject: [PATCHv10 0/4] *** Detect interrupt storm in softlockup ***
Date: Mon, 26 Feb 2024 10:09:35 +0800
Message-Id: <20240226020939.45264-1-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, guys.
I have implemented a low-overhead method for detecting interrupt
storm in softlockup. Please review it, all comments are welcome.

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

Bitao Hu (4):
  watchdog/softlockup: low-overhead detection of interrupt storm
  genirq: Provide a snapshot mechanism for interrupt statistics
  genirq: Avoid summation loops for /proc/interrupts
  watchdog/softlockup: report the most frequent interrupts

 arch/mips/dec/setup.c                |   2 +-
 arch/parisc/kernel/smp.c             |   2 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c |   2 +-
 include/linux/irqdesc.h              |  11 +-
 include/linux/kernel_stat.h          |   3 +
 kernel/irq/internals.h               |   2 +-
 kernel/irq/irqdesc.c                 |  36 ++++-
 kernel/irq/proc.c                    |  12 +-
 kernel/watchdog.c                    | 213 ++++++++++++++++++++++++++-
 lib/Kconfig.debug                    |  13 ++
 scripts/gdb/linux/interrupts.py      |   6 +-
 11 files changed, 276 insertions(+), 26 deletions(-)

-- 
2.37.1 (Apple Git-137.1)


