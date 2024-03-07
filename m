Return-Path: <linux-kernel+bounces-95567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17828874F92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC1F9B216A9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7058812C52B;
	Thu,  7 Mar 2024 13:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ql8Xfspm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D56212BE96
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816678; cv=none; b=jE0U3wUb1uhNuyK63o0BfbcgQuFHa9EpVUv4/i4jfvRK2MqUQ/QttcAH9eKOCdPJyhYi6FyOFmGflFVpnSNv1eyoUs4BYtzz62momy8oudU4KMSlJFaK5CDbSEeVN1bOmih9zwNYCxeX2yMAp8pHSp1LG0RoJzQzwmiMXApa0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816678; c=relaxed/simple;
	bh=ydcV8KjuRh1M2V0fUWpxwuVFVEPey+xI15J/nZoDhU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e13NuUrtJGzVVhPqgiMTC+Or7Plma5EOgAleTzPhRMKKcKnphGYwcGk0SAJKoIa7+jnns0XfOwEhpDDw1J6tG9XdaruNWCF9mmHJBnQeZKUaFeMnUrRQMfjTVYnsKLAQYFG3sCudGvLgJ2uWRGyW6/bardnG6G9HdYexVitjBRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ql8Xfspm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709816677; x=1741352677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ydcV8KjuRh1M2V0fUWpxwuVFVEPey+xI15J/nZoDhU4=;
  b=Ql8XfspmRPHxBCYDITQZpQ5U9c+vclPgnmX7vLRyAig6tPyhfD8amuaU
   ZIH8TZPR88r6I1OlW0+sUOk0E+AnBrOCFEfO6fhp8KLM6VpqxiAp7X+pC
   uft3odEealzp4JOixSg8d7sqlnUpEG4hYPFsjGrBLcSEBhCqYWjM6aFWd
   M8Exz/nosJkSI74eky6Pd66akP4PdsMpJZXR+7AhadzxfVLzICEP8GJba
   K6JfHG36C7vQ7PwBh2aZpcrY8EzbgNgKSJnxMi1dd0OxImoPbTnompOea
   NZXtknmq6lGdCQP4KIAMZnGZ2AM74y3TgTLg8ENovB8ZZRGbe3/LZHVGT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="5068060"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="5068060"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:04:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="14592316"
Received: from unknown (HELO localhost) ([10.237.72.159])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:04:35 -0800
From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
To: Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Aapo Vienamo <aapo.vienamo@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] mtd: core: Report error if first mtd_otp_size() call fails in mtd_otp_nvmem_add()
Date: Thu,  7 Mar 2024 15:04:17 +0200
Message-ID: <20240307130418.3131898-2-aapo.vienamo@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240307130418.3131898-1-aapo.vienamo@linux.intel.com>
References: <20240307130418.3131898-1-aapo.vienamo@linux.intel.com>
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


