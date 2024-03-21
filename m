Return-Path: <linux-kernel+bounces-109606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3EC881B55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7BCB2235E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6356D39;
	Thu, 21 Mar 2024 02:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="snxm+kmC"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE251877;
	Thu, 21 Mar 2024 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710989608; cv=none; b=nVBMX3r5FQIiDBIwTExwZP045oslmS97ae3TwQv2JeXwccSc7lz32pZHp44Hb+Go3oGsofwk2lsVzHskFyqseRG3Jvw04zQhoOTgI6zGoYdk26BeKc//Sh52gMAZtJ8wVcUazN18T3Ven1II6cOODJWOn4OxFfmjQJ/6XViZJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710989608; c=relaxed/simple;
	bh=OZiUkq/wmr+qnd1FdBGm2naXPOomtQWmzQ1UrEmHvLg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fd3k4q6a6P7aDWgxMc26DHN1rbnosELx975WtLQBV8vwVaYjnLQC2qXHBpclihhoxtB1c1s0J58fpv70lsqOWEDeZ3i/aTPWHdFYJlU4ykruvVFsCjiTo1OWuvpsa8Z6yDKb4uIwtfIHnG8ZTf7oJzR6w44e5iQIxlU/aJY69TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=snxm+kmC; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710989602; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=QqSJg4FMwGwgy/XBJ2XliwqjmCjrqPhPQDS9UJTxrzU=;
	b=snxm+kmCQUkQ99SyAqpYkZGWGuv/gU5enlItHlFU7VF6R1v4MtZch6ZTOcZFbDscIjJO3eojPmV+8xOM7KYP5jtVU1rYzrwqcRyjV/BtIROem1EmaZYEyPSAqM2l9I8dZvUBdBFlallVAo1RnL+FIo5N5rwK1YZ3UFCvHVIOIh8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W2zFICf_1710989599;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W2zFICf_1710989599)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 10:53:21 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	linux-edac@vger.kernel.org
Cc: tianruidond@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v2 0/2] ARM Error Source Table V1 Support
Date: Thu, 21 Mar 2024 10:53:15 +0800
Message-Id: <20240321025317.114621-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the ARM Error Source Table (AEST) based on
the 1.1 version of ACPI for the Armv8 RAS Extensions [0].

The Arm Error Source Table (AEST) enable kernel-first handling of errors
in a system that supports the Armv8 RAS extensions. In kernel-first mode,
kernel controls almost all RAS configuration, include CE threshold and
interrupt enable/disable. Hardware errors will trigger a RAS interrupt
to kernel, kernel scan all AEST node to find error node which occur
error in irq context and process the RAS error. Kernel will act as
follow for different types error:
  - CE, DE: use a workqueue to log this hardware errors.
  - UER, UEO: call memory_failure.
  - UC, UEU: panic.

I have tested this series on PTG Yitian710 SOC. Both corrected and
uncorrected errors were tested to verify the non-fatal vs fatal
scenarios.

Future work:
1. Add CE storm mitigation.
2. Support AEST V2.

This series is based on Tyler Baicar's patches [1], which do not have v2
sended to mail list yet. Change from origin patch:
1. Add a genpool to collect all AEST error, and log them in a workqueue
other than in irq context.
2. Just use the same one aest_proc function for system register interface
and MMIO interface.
3. Reconstruct some structures and functions to make it more clear.
4. Accept all comments in Tyler Baicar's mail list.

Change from V1:
https://lore.kernel.org/all/20240304111517.33001-1-tianruidong@linux.alibaba.com/
1. Marc Zyngier
  - Use readq/writeq_relaxed instead of readq/writeq for MMIO address.
  - Add sync for system register operation.
  - Use irq_is_percpu_devid() helper to identify a per-CPU interrupt.
  - Other fix.
2. Set RAS CE threshold in AEST driver.
3. Enable RAS interrupt explicitly in driver.
4. UER and UEO trigger memory_failure other than panic.

[0]: https://developer.arm.com/documentation/den0085/0101/
[1]: https://lore.kernel.org/all/20211124170708.3874-1-baicar@os.amperecomputing.com/

Tyler Baicar (2):
  ACPI/AEST: Initial AEST driver
  trace, ras: add ARM RAS extension trace event

 MAINTAINERS                  |  11 +
 arch/arm64/include/asm/ras.h |  71 +++
 drivers/acpi/arm64/Kconfig   |  10 +
 drivers/acpi/arm64/Makefile  |   1 +
 drivers/acpi/arm64/aest.c    | 839 +++++++++++++++++++++++++++++++++++
 include/linux/acpi_aest.h    |  92 ++++
 include/linux/cpuhotplug.h   |   1 +
 include/ras/ras_event.h      |  55 +++
 8 files changed, 1080 insertions(+)
 create mode 100644 arch/arm64/include/asm/ras.h
 create mode 100644 drivers/acpi/arm64/aest.c
 create mode 100644 include/linux/acpi_aest.h

-- 
2.33.1


