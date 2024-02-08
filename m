Return-Path: <linux-kernel+bounces-58094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D9684E139
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D2FCB21631
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63904762D8;
	Thu,  8 Feb 2024 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fK2O4Syu"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565176036
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707396875; cv=none; b=TIjPitjcWXxEldb5Gl4j3pX0mKmfv+FBjDgDsg7A0rL7M97jqukrRC+EvyDPfMHAzhHx45uGthJfT7BkPbS9xPYySZ67Sjttjchkb6jbxbhkaA077Y4T9W1x+3Z1FtGFpX2DO7I9a79BfL/vkUkO5C6ra8KC6+SeHn/1zmlkXk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707396875; c=relaxed/simple;
	bh=jFdrAmmiEqaYk7GTCUNGd+77e40anha5SBREow0cYg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OfoUMW9/IfJn1r26Zr5eDDYL2y8tQ3X9UuKOg6ydisTMhqAcC9XmKdOj4KaoJuvVsCP9nXfsUoskazyhq245EsAxNEHGF0abcHC1lvhpNRGXLrYgp0XMatv7zDYLb38ThDhXAKLSix9t6epSjZkWQ1DD15Fuxx+QDlCcboO6Jh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fK2O4Syu; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707396870; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=XHK6kOnSeSKQ2zuKL97UJxePL2wg5A3NCvg/jmIvXcQ=;
	b=fK2O4SyuYPKeNFL7eUHi5XIYPQFyax8El1UgAZr8IjCffazOZ/IDW44v8R9g/TcBIRiTyBGEHtsRIR3T5ylzjrW76PxINAHhUThTN7dYZ00DdDk/Hv/sexQ0C+fBEr+LgUKJdMIaENpEOWkeBvsK8OzOL2+MvZM+74h3LurNb/U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0JHSWK_1707396868;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W0JHSWK_1707396868)
          by smtp.aliyun-inc.com;
          Thu, 08 Feb 2024 20:54:29 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv6 0/2] *** Detect interrupt storm in softlockup ***
Date: Thu,  8 Feb 2024 20:54:24 +0800
Message-Id: <20240208125426.70511-1-yaoma@linux.alibaba.com>
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

Bitao Hu (2):
  watchdog/softlockup: low-overhead detection of interrupt
  watchdog/softlockup: report the most frequent interrupts

 kernel/watchdog.c | 244 +++++++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug |  13 +++
 2 files changed, 253 insertions(+), 4 deletions(-)

-- 
2.37.1 (Apple Git-137.1)


