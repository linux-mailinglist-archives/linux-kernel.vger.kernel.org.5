Return-Path: <linux-kernel+bounces-162305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2B8B5943
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29EAA1F2165D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A43070CCB;
	Mon, 29 Apr 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkaCtLaA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EE654907
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395712; cv=none; b=fmzLaHOygOgaInWGAH6ADljshlPyrEjEzXZPNv50V3prspRlTLHWM5R9BMFfs0e1W/uO0oF1s9VWDZfdjCL0BNJNiUvbeI2bPw4YQGN5v7yJ1gnD9uT2ahZQxVhzll0a4qDCYYV9AFDwbP0lDpy3xG6UjEV5BE9UK5W7QqmDIMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395712; c=relaxed/simple;
	bh=BmzzzNy0Qq0vMdNau1EvSHuLwokSd2AWKX8qj1/Jr6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAvFNxug9Gw8igzRcpo5ioaogC34ZhmRS2ZdaiSX401yGTTEAfxs07ZRH0Qn5xb8zXRTrYd46Pyf8ztBaNUakG22ggb3vNJyOFy7rs4DbzQAEQ4lg/l87VV3kpsXdoQUx9afhHy5w3t2efYmt8S0wv34pp0X1hk6rVkTLfnV9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkaCtLaA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395711; x=1745931711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BmzzzNy0Qq0vMdNau1EvSHuLwokSd2AWKX8qj1/Jr6Q=;
  b=VkaCtLaAeXk4lXRiHGm1icYAfolpwoKBYlXc1EVIWE1OXYEa8ypSpqAm
   tDoAk3M+6fGlzPsOmZKZza6br8YDZlvIJVCnbMOIs+iNWAwjApb1Sv5x9
   THxA+IG+/MchH8FdgvzN5gzoV4Y595rQAc44QewK/wijCAXEITwYQ83uL
   dCjiPEMF7KCd+bBCuWRLTvXDWtrZp51KapT2ArHlRSdFGI8gVivoiR5jY
   J5WQ5NmW3pPBOQT/GyxLVJn5z45DfL/ieo1w7W7V4xN3oakWnDPielSeY
   ewDqV68ZzyFuEmn7LGti1ti4X6eCA0aUT9wZ/b2nHHHuPR67Q7HeWK7EB
   Q==;
X-CSE-ConnectionGUID: UQ70tuntT3KopJtYJ+pHTw==
X-CSE-MsgGUID: H/FBSiL5S2yE5aybOd9cSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986828"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986828"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:01:49 -0700
X-CSE-ConnectionGUID: 0ROJO89lSCi4s4Jjrgni5Q==
X-CSE-MsgGUID: +sPx+m99S/OpvOyrYf4u+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507060"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:01:46 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mikhail Lappo <miklelappo@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 03/15] stm class: Propagate source type to protocols
Date: Mon, 29 Apr 2024 16:01:07 +0300
Message-ID: <20240429130119.1518073-4-alexander.shishkin@linux.intel.com>
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


