Return-Path: <linux-kernel+bounces-145774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1128A5AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289131C22F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE31015666F;
	Mon, 15 Apr 2024 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsyBAG5q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA57D156257;
	Mon, 15 Apr 2024 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209628; cv=none; b=OJiB5EYVzc1dT0etwT7tWxTo371HORlmMiFKVNu+aWULiYs7YMX1tb5gFgcmtktlkMUeJZmckLPjbR+cXL+VHlBq+7Mm3cv+QiDnz07EtV2VKiArF3sZDTbd4QEv+oAaWwxaTFhypgaKJJPY5hOV7C091rxTo1k4q99JyJZPEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209628; c=relaxed/simple;
	bh=CaVFwObFpXnqJOyd4URZ0hHz8CcFDZmnBJjVuE2smiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gK/8RpSB0jpqfp1b7w/aig0rcGhroK68f8eIqevniyoxCcF5SpyEcrWwpKyVQMJ1Wtz1h1eldrk5skVplYlqw993KpsmCWZN5EuH6U5hp53XEbDyj/Usw+lFjF6cZLgcLvsFia1xogTOz/KWvmGs+uUANdzoT+IQCxOuOauZ8zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsyBAG5q; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713209627; x=1744745627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CaVFwObFpXnqJOyd4URZ0hHz8CcFDZmnBJjVuE2smiU=;
  b=CsyBAG5qqMNYAiT6SJHRmrOvcgNcefzb2NTe3amZOoYKdm6qfArC8Pyr
   r+tmQgW+GQzAqiNpYo681EQmnLVndXdNp69PKMdvlHcq+ThATF48LPGlC
   +matsK7ZtelAcI99fkR6KcrPUiJ5nbzxp5FivqLbyXdFjjvU58O81TqBM
   cUGV3vzEhCX2eAe5lM41h/pRt4tZ03dAefOs+A48XZNfCkn/k7OHvxkE7
   mP1vFx6qVMQ0GJHueyolN6kckdA8fvlbP6KkOu4nn07bKXbUW7/n0bOzK
   it9HXE7WsS/TfALSTiB1jK1pVew7wWCShttiwjNEJn+YWQbGUx2Narnrj
   g==;
X-CSE-ConnectionGUID: RFkLSQ7IT+mfSBxwTiv3bg==
X-CSE-MsgGUID: xaLqjTxfTzaFp8hiQcEaaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8741051"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8741051"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 12:33:45 -0700
X-CSE-ConnectionGUID: JWINRoLoT9WALIkcLSYEnA==
X-CSE-MsgGUID: cMP8kkSbR9+9OeuSypvNrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="53214029"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 15 Apr 2024 12:33:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 207E85F7; Mon, 15 Apr 2024 22:33:42 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] spi: Introduce spi_for_each_valid_cs() in order of deduplication
Date: Mon, 15 Apr 2024 22:31:20 +0300
Message-ID: <20240415193340.1279360-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240415193340.1279360-1-andriy.shevchenko@linux.intel.com>
References: <20240415193340.1279360-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order of deduplication and better maintenance introduce a new
spi_for_each_valid_cs() helper macro.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4e40efd25aec..ffaa9dce8304 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1022,16 +1022,18 @@ static void spi_res_release(struct spi_controller *ctlr, struct spi_message *mes
 }
 
 /*-------------------------------------------------------------------------*/
+#define spi_for_each_valid_cs(spi, idx)				\
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)		\
+		if (!(spi->cs_index_mask & BIT(idx))) {} else
+
 static inline bool spi_is_last_cs(struct spi_device *spi)
 {
 	u8 idx;
 	bool last = false;
 
-	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
-		if (spi->cs_index_mask & BIT(idx)) {
-			if (spi->controller->last_cs[idx] == spi_get_chipselect(spi, idx))
-				last = true;
-		}
+	spi_for_each_valid_cs(spi, idx) {
+		if (spi->controller->last_cs[idx] == spi_get_chipselect(spi, idx))
+			last = true;
 	}
 	return last;
 }
@@ -1095,8 +1097,8 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 
 	if (spi_is_csgpiod(spi)) {
 		if (!(spi->mode & SPI_NO_CS)) {
-			for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
-				if ((spi->cs_index_mask & BIT(idx)) && spi_get_csgpiod(spi, idx))
+			spi_for_each_valid_cs(spi, idx) {
+				if (spi_get_csgpiod(spi, idx))
 					spi_toggle_csgpiod(spi, idx, enable, activate);
 			}
 		}
-- 
2.43.0.rc1.1336.g36b5255a03ac


