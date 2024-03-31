Return-Path: <linux-kernel+bounces-126329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA3389353E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B396B27B3A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F941474BB;
	Sun, 31 Mar 2024 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KyJ3wqC1"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F168145339
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711906017; cv=none; b=EjTAp9keBr7+s/Ytp3poSRMv6q3Swh4cbnpNDMFF74UHNO1KbWojE6bYausWDw2/dIlB5GP5TCik5AQQZq/40TNRCoBQjhHWx8VTXZq5tPBo90Lx7UKbBDFYswPIx07ssMe3VHILB6z6QVFSa/mPhYmoIPmHQa1Uh24KEJOMpx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711906017; c=relaxed/simple;
	bh=/XjE84p54DE3kiyQkHIoHpkUGWHZZKwlG7z8EyTriWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBU4QHTYFuTPXhKFCYiOg5APHkvCTuN39OaKFpoZ4pC+NWVBjqprMTA87WuJI773yaJLQexwmhduXMhicDMLVaG87GfQYPK6uo3YER7kbRXaGl/3Qtv3KdgysNu3Q2Z1Yr7HASX1t9eJcOs4gO8Kw5L0nTg+ZB7LaaIVDufcBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KyJ3wqC1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kKRpfMExxpUd+iTI+rbhd7CZmVDhOXT/ORPRCwb06vA=; b=KyJ3wqC1wwrENh5dQpj+qixD3E
	JLynBZv0H5we/hNY6JrqwZrcgwlthbSCR4Ghx6x4CWr7aF1lenS9mzQanBCSOMLpxXS1A4WiXZ9Cd
	1tjSzvAD5CpIg5Ialkp7AwgMUSef08DP8P4e4KPazmfBpH7NOsTHeI7l0y6fC38RyLw+KsG31dXsm
	9B7BTHZNF5kYgYSldSt1nTif4l+Wb6PIwO68BU3xMPsPhSFJYUCwZljJ5SG+oAg5Kd25PtzgQNBQX
	Uz+DjfuKgqVOPFQ3z9Ndk4KVzCWAB/sTLeM6/P+C4x1siYefcwj9Rdg6t2JYOQE4gFU+gYsMpMhP/
	Rt7MCfBA==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqyxL-00000005z30-2uei;
	Sun, 31 Mar 2024 17:26:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5/6] tick/sched: fix struct tick_sched doc warnings
Date: Sun, 31 Mar 2024 10:26:51 -0700
Message-ID: <20240331172652.14086-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240331172652.14086-1-rdunlap@infradead.org>
References: <20240331172652.14086-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings in struct tick_sched:

tick-sched.h:103: warning: Function parameter or struct member 'idle_sleeptime_seq' not described in 'tick_sched'
tick-sched.h:104: warning: Excess struct member 'nohz_mode' description in 'tick_sched'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>

 kernel/time/tick-sched.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -46,8 +46,8 @@ struct tick_device {
  * @next_tick:		Next tick to be fired when in dynticks mode.
  * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
  * @idle_waketime:	Time when the idle was interrupted
+ * @idle_sleeptime_seq:	sequence counter for data consistency
  * @idle_entrytime:	Time when the idle call was entered
- * @nohz_mode:		Mode - one state of tick_nohz_mode
  * @last_jiffies:	Base jiffies snapshot when next event was last computed
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
  * @timer_expires:	Anticipated timer expiration time (in case sched tick is stopped)

