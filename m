Return-Path: <linux-kernel+bounces-43012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA75840A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8666F1C20C48
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CFB154445;
	Mon, 29 Jan 2024 15:41:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA7E154426
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542870; cv=none; b=HhHYlgvFmGkTQoaBlH+kSNfyPQgRWsegM8j9eNZG6NmDb9d8Bwa5EPoslN2ojJdJvVpS1Qh59mRePjGxBpu9+SodNoniENBhglaffKwPYuqnqVXGMfvfZsCzQpHJ0zbdZPhPWyM/tzyuhssqUyQ0fprJ0K8hR+LfbJYt00sVPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542870; c=relaxed/simple;
	bh=VxMCAZG5PA+92iidZrv0IOb7p+NHuMVSN9QfCkcFCrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kllERQzeqU0A6jjvpZcLYbv3vFMHNDfJUrvmV67w8WN2nU5nLbRJnNXFrE61DtJ2XRzZwStv+mu00vkkDCpY0WspSV89XWsgrda4NQXcgvenouZq3hrieibIduK1iUsJmc8J6TBwlAyI63sPNOsusc8FbzXS5Y3SyezxQGRyfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1EBEDA7;
	Mon, 29 Jan 2024 07:41:50 -0800 (PST)
Received: from e127643.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D8363F738;
	Mon, 29 Jan 2024 07:41:04 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com
Cc: James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 00/12] coresight: Separate sysfs and Perf usage and some other cleanups
Date: Mon, 29 Jan 2024 15:40:31 +0000
Message-Id: <20240129154050.569566-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since V1:

  * Clarify further "the selected sink" in _coresight_build_path()
  * Move etm4x's mode to coresight device which was missing from V1
  * Use explicit initialisers in coresight_dev_type
  * Create functions for handling mode changes

I've been finding it quite difficult to reason about some of the state
and functions in coresight-core.c because they have generic names when
they are actually only relevant to the sysfs usage of Coresight rather
than usage through Perf. This is probably because sysfs came first and
Perf was added later. This has caused a couple of issues where these
things have been used in the wrong context, for example the first
commit is a fixup.

To fix this I've mainly just moved all of the sysfs stuff to the sysfs
file and removed the 'enable' state, which was just for sysfs. While
doing the refactor it became obvious that refcnt didn't need to be
atomic either, so that can be simplified along with some other comment
clarifications and simplifications.

Hopefully it's also a step towards to removing all of the duplicate
refcnt and mode tracking code from the individual devices. That tracking
pretty much always results in a one-shot enable/disable and fixes the
mode to either sysfs or Perf, and there is no reason that can't exist in
the core layer outside of the devices. I tried to finish that in this
set, but there turned out to be some complexities, so I cut it short at
a point where I can be sure that there are no behavioral changes.

James Clark (12):
  coresight: Fix issue where a source device's helpers aren't disabled
  coresight: Make language around "activated" sinks consistent
  coresight: Remove ops callback checks
  coresight: Move mode to struct coresight_device
  coresight: Remove the 'enable' field.
  coresight: Move all sysfs code to sysfs file
  coresight: Remove atomic type from refcnt
  coresight: Remove unused stubs
  coresight: Add explicit member initializers to coresight_dev_type
  coresight: Add helper for atomically taking the device
  coresight: Add a helper for getting csdev->mode
  coresight: Add helper for setting csdev->mode

 drivers/hwtracing/coresight/coresight-core.c  | 494 +-----------------
 drivers/hwtracing/coresight/coresight-etb10.c |  29 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |   2 +-
 drivers/hwtracing/coresight/coresight-etm.h   |   2 -
 .../coresight/coresight-etm3x-core.c          |  23 +-
 .../coresight/coresight-etm3x-sysfs.c         |   4 +-
 .../coresight/coresight-etm4x-core.c          |  26 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |   1 -
 drivers/hwtracing/coresight/coresight-priv.h  |   9 +-
 drivers/hwtracing/coresight/coresight-stm.c   |  30 +-
 drivers/hwtracing/coresight/coresight-sysfs.c | 391 ++++++++++++++
 .../hwtracing/coresight/coresight-tmc-core.c  |   2 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  46 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  33 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 -
 drivers/hwtracing/coresight/coresight-tpda.c  |  13 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |  14 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c    |  22 +-
 drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 -
 include/linux/coresight.h                     | 146 ++----
 20 files changed, 606 insertions(+), 685 deletions(-)

-- 
2.34.1


