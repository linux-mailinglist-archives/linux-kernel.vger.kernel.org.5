Return-Path: <linux-kernel+bounces-64679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3586854167
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79FACB21689
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAB18C06;
	Wed, 14 Feb 2024 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PM9ACNwJ"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D929C53BE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707876886; cv=none; b=L+mCM78y5s3QukgsPs8rqMQgj5gGgJ6ry6w/976B2W01gQMUJWha2SzQzq6YqENgZJFKfOSeZJuuIxkHhWVw/C8BJqhw0s8br3oR23QYd4SZIro1W40wiaoBDFVbusixoVzR0BjnLYHie56R+nPePOCo8Bu/amL3J9+dQ7CY3qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707876886; c=relaxed/simple;
	bh=chFq2zfHZxkcVkF89cp+H6QVvjioRtjCceqKlPUXl24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DktbX409eWqEjSk/rFcKQw8d8j0EVvnWVBnRN+WvqEjluWVlctuiGR4njKR48vDKUhUTeUFDgNZbagC8rAReobhRza/ZiyO23+WvooZGrsmiLu+K7YNCj+rPpC3tiP23imwdkmLkTxMaORWc5b+XftYt5ZkGYsSIPRBJNX9azxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PM9ACNwJ; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707876875; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=V5+UU8V8D3wFkpnB5joXR8dquv+5JIebwxrhTOq2T3A=;
	b=PM9ACNwJeCDSBxR9Nf57N9zMVXm8rW5pDk2fWD1hBCJn9B7bOHSnO3gQToIK2QFF8V7jBv9Afg73yTbLlAbN4s0E3eUvOdRsYY+I3k6kWFNzstMrAus+lB8KAS+dk01acZILdlaEud3qwQLDFCPhX2X0IXTnB2kaLyhF3AsY9Bo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0b-9F0_1707876873;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W0b-9F0_1707876873)
          by smtp.aliyun-inc.com;
          Wed, 14 Feb 2024 10:14:34 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	liusong@linux.alibaba.com
Cc: yaoma@linux.alibaba.com,
	linux-kernel@vger.kernel.org
Subject: [PATCHv7 0/2] *** Detect interrupt storm in softlockup ***
Date: Wed, 14 Feb 2024 10:14:28 +0800
Message-Id: <20240214021430.87471-1-yaoma@linux.alibaba.com>
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

Bitao Hu (2):
  watchdog/softlockup: low-overhead detection of interrupt
  watchdog/softlockup: report the most frequent interrupts

 kernel/watchdog.c | 255 +++++++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug |  13 +++
 2 files changed, 263 insertions(+), 5 deletions(-)

-- 
2.37.1 (Apple Git-137.1)


