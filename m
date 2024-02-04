Return-Path: <linux-kernel+bounces-51731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D10848EAB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0768B21FC7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C2224E8;
	Sun,  4 Feb 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TXX8Cq8F"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B2122307
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058329; cv=none; b=L6kZW7fKgIi6WUFpFAZomBzatNcHD5Zq1y0YA7tRiNfdjWOYgNilp+FmXGre/RLzvSGBZY/FGP9X7fvVWgKIfi85gsBE2J44vuIvVi8ywTe1a627YS+ndlC/oT57WlX7SF1dRv4We1PPBHYWnfHHQ4j+ZLNru0MAiBpoaOVYliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058329; c=relaxed/simple;
	bh=0JcXOqJwgvaXB3q5MnlBmpdl74RAVdFizWUXVAVwj+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BJoccEoZ90fEhXO4qQS/tfeYOwhHB9nm6illtRBucOW7N1vP/aHzVw4oBBug5JDwzNaXjVbqXm5ARE6DLK+YWJBheN9xfe3oz24BmT2fovM+35fAubEabVt2HvnJ2gHqOxkWRp8FSwP+GbldATmWqC3RBfxIh2EZjrf1egJtTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TXX8Cq8F; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707058319; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=Qvz8jSNlW0u04VWtHyitrAixmhwD3hvNY7pKyKG/fR0=;
	b=TXX8Cq8F8NkvI5mKGUIA5HisvdVDFtzstalTSNCNFgMl2tEwhdLq8Iehuaatgjckrv3XA31Xuk6VGsvMI1x/RzQsvgqqhf0EXU82ovyD+E90MQjmhdjcaQtaIy2/pcu7c8DhuqfSD9Lz8YNQa/iCwKDMVUMvVcgyxm4cwRpyvr4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W00xOyM_1707058317;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W00xOyM_1707058317)
          by smtp.aliyun-inc.com;
          Sun, 04 Feb 2024 22:51:59 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv4 0/3] *** Detect interrupt storm in softlockup ***
Date: Sun,  4 Feb 2024 22:51:51 +0800
Message-Id: <20240204145154.11069-1-yaoma@linux.alibaba.com>
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

 kernel/watchdog.c | 247 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug |  13 +++
 2 files changed, 260 insertions(+)

-- 
2.37.1 (Apple Git-137.1)


