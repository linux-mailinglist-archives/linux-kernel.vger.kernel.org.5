Return-Path: <linux-kernel+bounces-65368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D869854BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501F61C214D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06245B21C;
	Wed, 14 Feb 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBoKTQ0F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835E554FAD;
	Wed, 14 Feb 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707922502; cv=none; b=M2sfTzY08UcfliR1vVvA0XFF/pbmXplMyETko+l40V49Z0+WRkVk2qhpOcuQi21qSEDZVvibjeLMnPdXqTlpgjjsduT3uRIysR78myAxrPumzcbATaZPxKH4Pi5tqfaefOeyXvySca2o+nd3fWSOGx5IM2BLPIDEFLhk20bqLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707922502; c=relaxed/simple;
	bh=lzj2XSAw769/WZ86KuTWetUX/lYELdru1gi0Xpeqrsg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mpmLamnwcysLzL3XsxeRDf7p+BoMf4BYGapaZuSd+JgCtvaayS1hv1hoB3LaZkfh8ITswRnwggpZyNeHDhEv+b0lGRp6G65T6heKBX44rnF4ka4CZKPPENpjT1Kxd8lq1aQAVcOv33HaySDC/zzbCwn2vQbwDoMK14mYtTszsBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBoKTQ0F; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707922501; x=1739458501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lzj2XSAw769/WZ86KuTWetUX/lYELdru1gi0Xpeqrsg=;
  b=FBoKTQ0FpF0LBz8DzUz/IUN5H1CRBxTMDbXOCLpCXjFc/0CBRX7lLVJm
   JZJHVCs7TxCPR2vs8Yox7+h0X6S0QAyyc3xSpQXghUjDniIKU2KFu9oGs
   TOLmN8NtVSaO5oL9caakkGBWfBI7fVMZYA1bQudSqj6dWCg5sSdnyHMEZ
   IOmJE7QzOkorzIqA7XVdwCIx+3Yl2Yx1XMhCq5eTi5pZQ7+KC67bSGME+
   2VxJAsE3FVnfJRRQ2MHMp3B1ZAEY8OWQcHU8m+l0BMR3d5wNodmp1DmrE
   4RqGuyy1WMddNmq+X8KBnMK/OzEda30j9gGrGr8C+Btti63C+If9/ZvmU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19480235"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="19480235"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 06:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3108826"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.33.229])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 06:54:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] tty: Don't include tty_buffer.h tty.h
Date: Wed, 14 Feb 2024 16:54:39 +0200
Message-Id: <20240214145439.62624-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There's no need to include linux/tty_buffer.h in linux/tty.h.
Move the include into tty_buffer.c that is actually using it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/tty_buffer.c | 1 +
 include/linux/tty.h      | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index f8883afbeeba..79f0ff94ce00 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -7,6 +7,7 @@
 #include <linux/errno.h>
 #include <linux/minmax.h>
 #include <linux/tty.h>
+#include <linux/tty_buffer.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_flip.h>
 #include <linux/timer.h>
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 8c76fd97d4ad..2b2e6f0a54d6 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -6,7 +6,6 @@
 #include <linux/major.h>
 #include <linux/termios.h>
 #include <linux/workqueue.h>
-#include <linux/tty_buffer.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_ldisc.h>
 #include <linux/tty_port.h>
-- 
2.39.2


