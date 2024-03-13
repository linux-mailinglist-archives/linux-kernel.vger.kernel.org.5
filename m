Return-Path: <linux-kernel+bounces-102274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0185A87B019
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DA71F226FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14D512C816;
	Wed, 13 Mar 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UT9IR4bl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8412C7FC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351278; cv=none; b=FP3q9OO4jQobJB7R3yKkd/YGzBxF3QArvOjEuL/7CeMXU+RU6ERdjp5lFWw+ZAub8sQlNtkrehtjM/aKWJCx/wmyE3wv8E+fxuFXslxpOGKwA1N7Cm3pJS5g+Q74SxwJkGK5QwJEWyjVJAay4f3DtwreWDsFcQkRfWpftUVLjXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351278; c=relaxed/simple;
	bh=cMAF/BsQMrt/7XHws2t0rHI3xXRwHICqBykoan1yTSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gxl599FZCZnUHLOEwuIl1jy0rpzCdUiS1bJxvZtOLN3D1VQg5Vem8g1MGcw2Mu/R4cJIBBK3Jta0iaWBfqSMc4luQCp1vhgL2glqIwZHb61BMJmHY7E5y8NPyRQ1pFCXaIUxir1P+Bk+fEaDXannf+LnNulbqyKraCc7VrdWaJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UT9IR4bl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710351277; x=1741887277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cMAF/BsQMrt/7XHws2t0rHI3xXRwHICqBykoan1yTSI=;
  b=UT9IR4bl0dOPkgd8+zc1M8y65wbvrJ4p5vxYLzCGCYkCcfr9wTtFu4i3
   i5DocaiRbsUT2fYSj5+MOi8ksQhZSx//xqhBsyLnLEXVxnYgF/LZSVcjK
   q13hoxC73WwpbgkgZchBu72j3y3DshwADuP8RYwvyxbA/ElqMwhz8/u0Z
   XeNHP1Zw97NNzjJ089dLmPwBP9P0X3km8Hu/HLcI7HgNwvQ17eOJfLCcu
   0DO12uyhn2jqpeC+ouyjMxCIuwcDQc9BRmC1rRj2u2wHoFPreO4a55muR
   u/XUYrrwCnjK6c7Ot9I+NHE771F0wk1vu3xr7W1x5jIMHx4ezq+7p6a3y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="15772886"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="15772886"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 10:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="35132858"
Received: from unknown (HELO localhost) ([10.237.72.159])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 10:34:34 -0700
From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
To: mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: mika.westerberg@linux.intel.com,
	Aapo Vienamo <aapo.vienamo@linux.intel.com>
Subject: [PATCH v2 1/2] mtd: core: Report error if first mtd_otp_size() call fails in mtd_otp_nvmem_add()
Date: Wed, 13 Mar 2024 19:34:24 +0200
Message-ID: <20240313173425.1325790-2-aapo.vienamo@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313173425.1325790-1-aapo.vienamo@linux.intel.com>
References: <20240313173425.1325790-1-aapo.vienamo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jump to the error reporting code in mtd_otp_nvmem_add() if the
mtd_otp_size() call fails. Without this fix, the error is not logged.

Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
---
 drivers/mtd/mtdcore.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5887feb347a4..c365c97e7232 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -956,8 +956,10 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 
 	if (mtd->_get_user_prot_info && mtd->_read_user_prot_reg) {
 		size = mtd_otp_size(mtd, true);
-		if (size < 0)
-			return size;
+		if (size < 0) {
+			err = size;
+			goto err;
+		}
 
 		if (size > 0) {
 			nvmem = mtd_otp_nvmem_register(mtd, "user-otp", size,
-- 
2.41.0


