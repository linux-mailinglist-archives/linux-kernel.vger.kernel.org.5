Return-Path: <linux-kernel+bounces-162193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4DE8B577F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C1628639A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E874E548F7;
	Mon, 29 Apr 2024 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJvNYxPY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B880954743
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392564; cv=none; b=NIWgOOaqcnBQY/3HSXsujQO+0FXf9QImgGfYb/X+PiMKn7OHXDLlyo8dGdzuP2lQXeTCWM9mbIENlcdGnSyVZVxkq7h83A6TYW6QVm32YgHZIQOhBpOCL4Lk2W85+9RAGAcdDHwdyqnmgFJLlOlpTzwCI9NQUF/I2Nrq2Ohc5/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392564; c=relaxed/simple;
	bh=BmzzzNy0Qq0vMdNau1EvSHuLwokSd2AWKX8qj1/Jr6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7RKa5fJcQoKZBFJf9bilQ1HHR9VfT/IcvmOJpRDEz/CCiV8V0WYCvmZyB3NgRfycYIMs7M+McARit/AHsfvUztNy3O5V7lJt6tqkwO37DPTG3k/sFOmSIHHBmS6lskFitrzC7F8cqB2rNjcTw3L4pcGsE0jRJYD2IgoiRhOnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJvNYxPY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392563; x=1745928563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BmzzzNy0Qq0vMdNau1EvSHuLwokSd2AWKX8qj1/Jr6Q=;
  b=ZJvNYxPY77Z80SORpv8UsArrveRAm3ic4xG50lmMckc7SsJ7uws+xosr
   ph7QMvOasfLZhHVLFNvCXaJXxdf6wV3xWJgjJml9kaGcm9H3ZmE9npEiF
   KSaKE6/u67aEZWCddRZ0bbRIWNpzK4cVn9SXKTuLMrM0nUYf2HvSR3Y0q
   53InJqe9h+CmnNH0TMBAbnO+F5PFiNALLyaZ168aHnSmXEwO+zZS1gQve
   a17kuEfHpkDbe5mKbm93KQbaCe77NSsXJvyIW+DmsU7u+po+0PNmBGMXB
   rVPGOIZLlhjt2Y1uk7/l1ySp7SEpKczA2n5PaptomG+WL2S+YrPY4/TZt
   Q==;
X-CSE-ConnectionGUID: 6fFZH/PoQJOpF7cNFrjTOQ==
X-CSE-MsgGUID: tHJwHojjQlGkXgP50PtnRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908222"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908222"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:22 -0700
X-CSE-ConnectionGUID: DQykfGYrSxm1SPBtu9Tzzg==
X-CSE-MsgGUID: JysAfQlgSle4dJgF6PQYxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166613"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:20 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mikhail Lappo <miklelappo@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 03/14] stm class: Propagate source type to protocols
Date: Mon, 29 Apr 2024 15:08:57 +0300
Message-ID: <20240429120908.3723458-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
References: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Lappo <miklelappo@gmail.com>

Pass stm source type via stm_write() to allow different handling on
protocol level.

The measure above should allow protocol level encoder to differentiate
and accordingly pack the messages. As an example SyS-T might get use of
ftrace message ID's and instead of applying regular header, pack them
as SyS-T catalog or SyS-T Structured Binary Data message to allow proper
decoding on the other side.

Signed-off-by: Mikhail Lappo <miklelappo@gmail.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/stm/core.c    | 8 ++++----
 drivers/hwtracing/stm/p_basic.c | 3 ++-
 drivers/hwtracing/stm/p_sys-t.c | 3 ++-
 drivers/hwtracing/stm/stm.h     | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 20895d391562..ccf39a80dc4f 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -600,7 +600,7 @@ EXPORT_SYMBOL_GPL(stm_data_write);
 
 static ssize_t notrace
 stm_write(struct stm_device *stm, struct stm_output *output,
-	  unsigned int chan, const char *buf, size_t count)
+	  unsigned int chan, const char *buf, size_t count, struct stm_source_data *source)
 {
 	int err;
 
@@ -608,7 +608,7 @@ stm_write(struct stm_device *stm, struct stm_output *output,
 	if (!stm->pdrv)
 		return -ENODEV;
 
-	err = stm->pdrv->write(stm->data, output, chan, buf, count);
+	err = stm->pdrv->write(stm->data, output, chan, buf, count, source);
 	if (err < 0)
 		return err;
 
@@ -657,7 +657,7 @@ static ssize_t stm_char_write(struct file *file, const char __user *buf,
 
 	pm_runtime_get_sync(&stm->dev);
 
-	count = stm_write(stm, &stmf->output, 0, kbuf, count);
+	count = stm_write(stm, &stmf->output, 0, kbuf, count, NULL);
 
 	pm_runtime_mark_last_busy(&stm->dev);
 	pm_runtime_put_autosuspend(&stm->dev);
@@ -1299,7 +1299,7 @@ int notrace stm_source_write(struct stm_source_data *data,
 
 	stm = srcu_dereference(src->link, &stm_source_srcu);
 	if (stm)
-		count = stm_write(stm, &src->output, chan, buf, count);
+		count = stm_write(stm, &src->output, chan, buf, count, data);
 	else
 		count = -ENODEV;
 
diff --git a/drivers/hwtracing/stm/p_basic.c b/drivers/hwtracing/stm/p_basic.c
index 8980a6a5fd6c..5525c975cc6f 100644
--- a/drivers/hwtracing/stm/p_basic.c
+++ b/drivers/hwtracing/stm/p_basic.c
@@ -10,7 +10,8 @@
 #include "stm.h"
 
 static ssize_t basic_write(struct stm_data *data, struct stm_output *output,
-			   unsigned int chan, const char *buf, size_t count)
+			   unsigned int chan, const char *buf, size_t count,
+			   struct stm_source_data *source)
 {
 	unsigned int c = output->channel + chan;
 	unsigned int m = output->master;
diff --git a/drivers/hwtracing/stm/p_sys-t.c b/drivers/hwtracing/stm/p_sys-t.c
index 8254971c02e7..5b4b9f350ec1 100644
--- a/drivers/hwtracing/stm/p_sys-t.c
+++ b/drivers/hwtracing/stm/p_sys-t.c
@@ -285,7 +285,8 @@ sys_t_clock_sync(struct stm_data *data, unsigned int m, unsigned int c)
 }
 
 static ssize_t sys_t_write(struct stm_data *data, struct stm_output *output,
-			   unsigned int chan, const char *buf, size_t count)
+			   unsigned int chan, const char *buf, size_t count,
+			   struct stm_source_data *source)
 {
 	struct sys_t_output *op = output->pdrv_private;
 	unsigned int c = output->channel + chan;
diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
index a9be49fc7a6b..85dda6e0d10c 100644
--- a/drivers/hwtracing/stm/stm.h
+++ b/drivers/hwtracing/stm/stm.h
@@ -96,7 +96,7 @@ struct stm_protocol_driver {
 	const char	*name;
 	ssize_t		(*write)(struct stm_data *data,
 				 struct stm_output *output, unsigned int chan,
-				 const char *buf, size_t count);
+				 const char *buf, size_t count, struct stm_source_data *source);
 	void		(*policy_node_init)(void *arg);
 	int		(*output_open)(void *priv, struct stm_output *output);
 	void		(*output_close)(struct stm_output *output);
-- 
2.43.0


