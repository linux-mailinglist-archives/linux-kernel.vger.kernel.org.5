Return-Path: <linux-kernel+bounces-54630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D70E84B1BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C09287759
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3A912DDA9;
	Tue,  6 Feb 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fs8htcWW"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADC12D776
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213558; cv=none; b=srJKyeWs8x5wjyISQ7gzn+Y21kOKH1EE+j+LjbAtmT1Mk7YV9IeGl21unU1fO/QSQRH+zr5OuF6g+aH7aQ7T5k0hzSgYLe0EKH9C53jT6KxsKfZ6/6jZQqWLXkOPXeHx2+g/KvNHsAnEyp59p544mwyYdK4lDl68kSLj1Be8D/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213558; c=relaxed/simple;
	bh=rgBw88hJolSgSZ/34zK+NzRZplSTArpsDUnxWP5SxIo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FxpW8Eq+khMJUFPhy/lqiS6jY4lXudgOpK1YBizfhdcE9fxDR7gmca59XtswbUceJpD+a8hQIRykbadQiAfPt9SVPvrBINJaWEwWtT0/umcM3XRTSS5urPKIYiVkgoSaB3r1MvjocM0qIc2Y8+DsPs29+u8zg9/1BZNkHnx++Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fs8htcWW; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707213547; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=O+E9jRj6xzPvVoIr+app9sg3ad2aS4jITRcsHfNdvI8=;
	b=Fs8htcWWAiDFLrDrj1wig1ONFpB+15sRqi3p1lqQ1cI5hT2SIpaNTggEGhCieE3Oc72xH5V1WmERTApPQlRNs2iZZlV7Dc9mA8AOpzrCfgCxR1kcTF9Ie9eVN031ZCQXTSyFRWqb3Skk+//mzLhz47fuZZ8RiABpnTJcO5UVy2Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0DCVLK_1707213545;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W0DCVLK_1707213545)
          by smtp.aliyun-inc.com;
          Tue, 06 Feb 2024 17:59:06 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv5 0/3] *** Detect interrupt storm in softlockup ***
Date: Tue,  6 Feb 2024 17:58:59 +0800
Message-Id: <20240206095902.56406-1-yaoma@linux.alibaba.com>
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
I have implemented a low-overhead method for detecting interrupt storm
in softlockup. Please review it, all comments are welcome.

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

Bitao Hu (3):
  watchdog/softlockup: low-overhead detection of interrupt
  watchdog/softlockup: report the most frequent interrupts
  watchdog/softlockup: add SOFTLOCKUP_DETECTOR_INTR_STORM Kconfig knob

 kernel/watchdog.c | 245 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug |  13 +++
 2 files changed, 258 insertions(+)

-- 
2.37.1 (Apple Git-137.1)


