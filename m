Return-Path: <linux-kernel+bounces-162304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9F38B5941
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E81D1F21E42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26086E61D;
	Mon, 29 Apr 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UhwHTv+9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E91548EC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395712; cv=none; b=tpcBRsrZrHUiaw8F4gG5cnZZG4TWyKQNojkj60Qg8g5GRS+KSURUcNzlVBHqgLgBOTgr/q3OlxT2IPauTnIMqhFNDry0f+XsobaiVn5o2Uiah+CpzwGLHqeP3VmflFoGr4bRfk3RqO1zLeN22wcG+KSu/hb8TZ12JwxAFNpuxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395712; c=relaxed/simple;
	bh=ni7xzfycKKP1MKVU8EmsUqb3361Wz7LPiZp+v1kH+eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbMCserUmiOkFQH1BPO1gNsipYgnnf+auZ8oeqIf0drUyCN3cK+rYwbDfK242SSmMDmv6tJSKsgJSiUUl2AT8IjqwrvRe/BkWIfKwQ2kz3Nn7dtfM2xiuxIgl/9FUmuHzbZdLzGYhY6I3TdGqDX6P1je7Lj+hppGZ6VB13rcwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UhwHTv+9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395710; x=1745931710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ni7xzfycKKP1MKVU8EmsUqb3361Wz7LPiZp+v1kH+eQ=;
  b=UhwHTv+9n1lwLNWv8Hi/hPP/DOoYOGnrE1d5jOHDJkhetgA72ukdvFAK
   lJJoUbsucfa4Dgg72DCXw3dxs8/15KKrvSPPOuXZV+jvuSo3b916A8MI+
   kW3oHd8l1DLPyjiGZf+6jHR0Ieemad7mU2eGFadPx87VaXfLtntfmCjW9
   h+LCW+1sCoobLIa5SrkVuf1P4Xnw7iBsFN1EDf3S1/zEnwaEDOOidWL4B
   ifgvZlfyTkRWBr4dw0Q/qAI4dPfmkcYklaVpkC/1zijVsgvZrzmTmcZsW
   po/tTp9ifS7U2VQqeCANvledLz5N809yPXxMTG8UNiPi0GvSerIMopNE2
   Q==;
X-CSE-ConnectionGUID: 5LXlqQFCSvOUYEJmIygpMQ==
X-CSE-MsgGUID: F4+BIsicSUqweMq/YjWdhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986822"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986822"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:01:47 -0700
X-CSE-ConnectionGUID: SfmXNeZdR3qCnAqorRUrSg==
X-CSE-MsgGUID: LT5mhXZUT2ejWhJyjUkkbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507056"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:01:44 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mikhail Lappo <miklelappo@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 02/15] stm class: Add source type
Date: Mon, 29 Apr 2024 16:01:06 +0300
Message-ID: <20240429130119.1518073-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
References: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Lappo <miklelappo@gmail.com>

Currently kernel HW tracing infrastrtucture and specifically its SyS-T
part treats all source data in the same way. Treating and encoding
different trace data sources differently might allow decoding software
to make use of e.g. ftrace event ids by converting them to a SyS-T
message catalog.

The solution is to keep source type stored within stm_source_data
structure to allow different handling by stm output/protocol.
Currently we only differentiate between STM_USER and STM_FTRACE sources.

Signed-off-by: Mikhail Lappo <miklelappo@gmail.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/stm/console.c   |  1 +
 drivers/hwtracing/stm/ftrace.c    |  1 +
 drivers/hwtracing/stm/heartbeat.c |  1 +
 include/linux/stm.h               | 12 ++++++++++++
 4 files changed, 15 insertions(+)

diff --git a/drivers/hwtracing/stm/console.c b/drivers/hwtracing/stm/console.c
index a00f65e21747..097a00ac43a7 100644
--- a/drivers/hwtracing/stm/console.c
+++ b/drivers/hwtracing/stm/console.c
@@ -22,6 +22,7 @@ static struct stm_console {
 	.data	= {
 		.name		= "console",
 		.nr_chans	= 1,
+		.type		= STM_USER,
 		.link		= stm_console_link,
 		.unlink		= stm_console_unlink,
 	},
diff --git a/drivers/hwtracing/stm/ftrace.c b/drivers/hwtracing/stm/ftrace.c
index 3bb606dfa634..a7cea7ea0163 100644
--- a/drivers/hwtracing/stm/ftrace.c
+++ b/drivers/hwtracing/stm/ftrace.c
@@ -23,6 +23,7 @@ static struct stm_ftrace {
 	.data	= {
 		.name		= "ftrace",
 		.nr_chans	= STM_FTRACE_NR_CHANNELS,
+		.type		= STM_FTRACE,
 		.link		= stm_ftrace_link,
 		.unlink		= stm_ftrace_unlink,
 	},
diff --git a/drivers/hwtracing/stm/heartbeat.c b/drivers/hwtracing/stm/heartbeat.c
index 81d7b21d31ec..e9496fe97baa 100644
--- a/drivers/hwtracing/stm/heartbeat.c
+++ b/drivers/hwtracing/stm/heartbeat.c
@@ -78,6 +78,7 @@ static int stm_heartbeat_init(void)
 		}
 
 		stm_heartbeat[i].data.nr_chans	= 1;
+		stm_heartbeat[i].data.type	= STM_USER;
 		stm_heartbeat[i].data.link	= stm_heartbeat_link;
 		stm_heartbeat[i].data.unlink	= stm_heartbeat_unlink;
 		hrtimer_init(&stm_heartbeat[i].hrtimer, CLOCK_MONOTONIC,
diff --git a/include/linux/stm.h b/include/linux/stm.h
index 3b22689512be..2fcbef9608f6 100644
--- a/include/linux/stm.h
+++ b/include/linux/stm.h
@@ -30,6 +30,16 @@ enum stp_packet_flags {
 	STP_PACKET_TIMESTAMPED	= 0x2,
 };
 
+/**
+ * enum stm_source_type - STM source driver
+ * @STM_USER: any STM trace source
+ * @STM_FTRACE: ftrace STM source
+ */
+enum stm_source_type {
+	STM_USER,
+	STM_FTRACE,
+};
+
 struct stp_policy;
 
 struct stm_device;
@@ -106,6 +116,7 @@ struct stm_source_device;
  * @name:	device name, will be used for policy lookup
  * @src:	internal structure, only used by stm class code
  * @nr_chans:	number of channels to allocate
+ * @type:	type of STM source driver represented by stm_source_type
  * @link:	called when this source gets linked to an STM device
  * @unlink:	called when this source is about to get unlinked from its STM
  *
@@ -117,6 +128,7 @@ struct stm_source_data {
 	struct stm_source_device *src;
 	unsigned int		percpu;
 	unsigned int		nr_chans;
+	unsigned int		type;
 	int			(*link)(struct stm_source_data *data);
 	void			(*unlink)(struct stm_source_data *data);
 };
-- 
2.43.0


