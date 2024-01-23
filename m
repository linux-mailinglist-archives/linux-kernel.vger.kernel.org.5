Return-Path: <linux-kernel+bounces-35233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB98C838E37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08CB1C22DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DB35DF00;
	Tue, 23 Jan 2024 12:12:36 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304205D8EB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706011956; cv=none; b=rWN1PzWf39gZ8vpQJ4GK/tsmv58yTUwEOvCy0ZjLfyOj6D77rNAX4Q3da8Z9YBr8Gb/S1DT4eYQ1XCZanWVqYu4/swteqE0/NrW8HAuwzJ59QSiwsU4u/oLRAV5Kj81VQHjMLVxO/A+aaurag8m86vwO94HJo3nir7qytfLz0i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706011956; c=relaxed/simple;
	bh=aoKMubrs7V0U9xeWv4qjkRfY0jZgwBiuAWXb6vO6uq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eWv3Flbu8tyx0fx142N52Bm01apymZRu4hX+V9YwlSh9TnQHay04onHRY6RT5gPZaCjfLVVsOg7HHlS3a75WeczGUw47eW8tbK+aoLSM44pGhhg8DiLsb14Bgo/FHuisagju833T8ZnolzT8i0/j+ep8M4ugVzplhfLqOYlptB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W.CnxE1_1706011947;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.CnxE1_1706011947)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 20:12:29 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	tglx@linutronix.de,
	maz@kernel.org,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	Bitao Hu <yaoma@linux.alibaba.com>
Subject: [PATCH 0/3] *** Detect interrupt storm in softlockup ***
Date: Tue, 23 Jan 2024 20:12:20 +0800
Message-Id: <20240123121223.22318-1-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi guys,
    I have previously encountered an issue where an NVMe interrupt
storm caused a softlockup, but the call tree did not provide useful
information. This is because the call tree is merely a snapshot and
does not fully reflect the CPU's state over the duration of the
softlockup_thresh period. Consequently, I think that reporting CPU
utilization (system, softirq, hardirq, idle) during a softlockup would
be beneficial for identifying issues related to interrupt storms, as
well as assisting in the analysis of other causes of softlockup.
    Furthermore, reporting the most time-consuming hardirqs during a
softlockup could directly pinpoint which interrupt is responsible
for the issue.

Bitao Hu (3):
  watchdog/softlockup: low-overhead detection of interrupt storm
  watchdog/softlockup: report the most time-consuming hardirq
  watchdog/softlockup: add parameter to control the reporting of
    time-consuming hardirq

 include/linux/irq.h     |   9 ++
 include/linux/irqdesc.h |   2 +
 kernel/irq/irqdesc.c    |   9 +-
 kernel/watchdog.c       | 289 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 308 insertions(+), 1 deletion(-)

-- 
2.37.1 (Apple Git-137.1)


