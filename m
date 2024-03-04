Return-Path: <linux-kernel+bounces-91031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA078708AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE4A1C21A85
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55EA61671;
	Mon,  4 Mar 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLwQyqWu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846A612FF;
	Mon,  4 Mar 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574721; cv=none; b=pN6Ju+Zja9kIZd9qpgQSFplA3fIbIgMKBtqHw82wyZGW+OEoaug+T+5F1AQPzqlDqYtQu6MYML962SYADs1aDUVL1+D9oychgHd3QVaHhMOfN/d4a9fJPl2gHtqrgo9XHyrmnEOKGFyXgN5ufwDgxXPv5LCzfoZLHWb3ctpZQPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574721; c=relaxed/simple;
	bh=4DfBSXNJM2nONjEhv8h2o0Di7f5jtcMwhU0s7F1/xz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdfUP9lI+MueZrfO5spYTW/Y+Qaovl1dBzzgGOsZygzF8+0DoeaKxkUK66POjdw0wbIDbjnsAzgakf8ctz9K3iaY/vPa2X9H17TQ+lDmCRUN1SJbjHJWoKQDFuGgzPr8TSzKpbB8ek8fELT5FRcSR+K8wlaknudI2DW8BAhehGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLwQyqWu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709574719; x=1741110719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4DfBSXNJM2nONjEhv8h2o0Di7f5jtcMwhU0s7F1/xz0=;
  b=HLwQyqWuq6bfxlg3QlgRmt/mir+4hIMZ/hMZquoDVrew4b1nvn6Qvfbs
   v297J8itc9Z2z6rFsJCkAH3CHfMqkjQGOz20hCZVlO4DcsS5pon2lpug3
   GZ1yUmO7n3SQOp1ZmRSkisBPfiUfLWYF7qsjC8BzH8vFtO0MVR4wVi2em
   /UDXXLDROo0Cw+BZbMaQO3TkgcfTorYVuca41oLHgkrEYpa4Ifs0F0aHm
   +NxLvyvmmvlBn0QJuTJO1Hlc5pOnIxV012mLc2zJtlFfLEw1dqZnzRUhq
   NY/ZbEX5HK4MihrH08mNtdv+6mKL8aGuecd9yfCwPES5X9ARX5S/XjSYS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4209802"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="4209802"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 09:51:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040905"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040905"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 09:51:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 42E2915C; Mon,  4 Mar 2024 19:51:53 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] drm/msm/hdmi: Replace of_gpio.h by proper one
Date: Mon,  4 Mar 2024 19:51:52 +0200
Message-ID: <20240304175152.1199270-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it directly, replace it
with what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index c8ebd75176bb..24abcb7254cc 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -5,8 +5,8 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <linux/gpio/consumer.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
-- 
2.43.0.rc1.1.gbec44491f096


