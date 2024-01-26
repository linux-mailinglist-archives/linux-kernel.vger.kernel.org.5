Return-Path: <linux-kernel+bounces-39908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C3383D81B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D8FBB35D55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6001BC5F;
	Fri, 26 Jan 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xuut1Wzs"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C91BC34
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260885; cv=none; b=cxjv02lbD5cqgPULHx/nLqEStXWstyxaAnhBGcHCAg7IsFYXYJA1Ot/zAS+6edhxgTV+rrsRulSuZIee5khLAl6rimHBfMvCRoXjtRKCIV9rBwRDz9SRndZxLPMhTCmj4EfQTFT0cQ/Ya4n5qvxyq7OMXsJq4GeY34aWbMvyYXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260885; c=relaxed/simple;
	bh=6mV7VNYt7HwWXFfXqjQflzG59MR/XQAJ7cn2D6yJLfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hhp3s3sGjHDLDXObWIf9V6q88cQW1WiY2DRjYdcfe00/AyxKVEuBtkCzlUK/+9dBh8cDBNvVIEHDDYhLAx1hbj4V1XwHQJX20NYhTVo0CmBS+oLWgDDERzi5ygzwqFGuRHRn/rgYH2zoESmBoX+YC4wnVZlGL05OyJ8JFAHVeuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xuut1Wzs; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706260883; x=1737796883;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6mV7VNYt7HwWXFfXqjQflzG59MR/XQAJ7cn2D6yJLfs=;
  b=Xuut1Wzs8V+OSZhANLhR1xRFeXyPNv069YvHd3sFyeoXS8GCv1xZxjfl
   A/1UeKxroVoZpf4EX7p+wS5ICZz9EdnjKBGpX/Ubfk7xqdCd45jzxUhRL
   hSLf+WWhZJg66j8emnE5eAysym4V7vvJlzhzzsPyzLBDJ1b5EPIw7qHRo
   tijhnwfilCA1PhPhFzp6spKJaUXF1h2w46FYtid7C6odMRlRc/NJMm8dW
   qgOc3noozfUMY5NQeCVQ0/9agkCpJwjnFHxAt221J9xD6VSv6s+8rYR4g
   Wq0q+tCdVVDnPmIhuZ6rIMYD4qQBDNSF9TOaJ/GH4oAXstA/FUw1SqMBj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="401279180"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401279180"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 01:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="906261352"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="906261352"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jan 2024 01:21:20 -0800
From: Feng Tang <feng.tang@intel.com>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>
Cc: Feng Tang <feng.tang@intel.com>,
	Jin Wang <jin1.wang@intel.com>
Subject: [PATCH] clocksource: Scale the max retry number of watchdog read according to CPU numbers
Date: Fri, 26 Jan 2024 17:12:50 +0800
Message-Id: <20240126091250.79985-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a bug on one 8-socket server that the TSC is wrongly marked as
'unstable' and disabled during boot time. (reproduce rate is every 120
rounds of reboot tests), with log:

    clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
    wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
    tsc: Marking TSC unstable due to clocksource watchdog
    TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
    sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
    clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
    clocksource: Switched to clocksource hpet

The reason is for platform with lots of CPU, there are sporadic big or huge
read latency of read watchog/clocksource during boot or when system is under
stress work load, and the frequency and maximum value of the latency goes up
with the increasing of CPU numbers. Current code already has logic to detect
and filter such high latency case by reading 3 times of watchdog, and check
the 2 deltas. Due to the randomness of the latency, there is a low possibility
situation that the first delta (latency) is big, but the second delta is small
and looks valid, which can escape from the check, and there is a
'max_cswd_read_retries' for retrying that check covering this case, whose
default value is only 2 and may be not enough for machines with huge number
of CPUs.

So scale and enlarge the max retry number according to CPU number to better
filter those latency noise on large system, which has been verified fine in
4 days and 670 rounds of reboot test on the 8-socket machine.

Tested-by: Jin Wang <jin1.wang@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 kernel/time/clocksource.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c108ed8a9804..f15283101906 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -226,6 +226,15 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
 
+	/*
+	 * If no user changes the default value, scale the retry threshold
+	 * according to CPU numbers. As per test, the more CPU a platform has,
+	 * the bigger read latency is found during boot time or under stress
+	 * work load. Increase the try nubmer to reduce false alarms.
+ 	 */
+	if (max_cswd_read_retries == 2)
+		max_cswd_read_retries = max(2, ilog2(num_online_cpus()));
+
 	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
-- 
2.34.1


