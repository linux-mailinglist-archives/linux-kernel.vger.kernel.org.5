Return-Path: <linux-kernel+bounces-155863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CBC8AF82C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89D728ADF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7168143872;
	Tue, 23 Apr 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhkfoVzk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B91142E60;
	Tue, 23 Apr 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905186; cv=none; b=lGjrf2y0pnk3YZIwffhpVnQZ32xTcQW8ZQVUGd7QpQkC0Dv3Ccruxo9g+60pkINBTq1pfqIdKEnjvroksD2uwcj/exqQMUbDOEemSDufKaSACKA5mROnbxqr1BLBqgT0pDGLH3S90eTzYiD61ijJ9FvMOklqS5b2EwGktVx8mxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905186; c=relaxed/simple;
	bh=fUXIJCIDo5X2sfJQxHfOh7XygvEXgVQ3BqmbUPgt9LA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7x50U5L0r5BcaZk0zsjIKLexkJiDUjzkaGYiJLWsKn1QK/UBlg3PX7/6NtWn5swUH3Wb6+TQ75kM59RMcMRm5WSZpa5JHKQ54aoPPRCUgWpCKq+BVhl/Kp449UmFE1Dtj1Yjz+dKIpY7DvxtKD60d3wSKCJDypn+VHWGTZeHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhkfoVzk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905185; x=1745441185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fUXIJCIDo5X2sfJQxHfOh7XygvEXgVQ3BqmbUPgt9LA=;
  b=lhkfoVzkRlCB0U9t0vragWNx0/aX5NuI3R7hfwMTJUOoqJ4KRzUG9lkJ
   Sbw4pDqrQkQIruRPANS9Da0P4SG175QOgz+qGFuQRJ0VTdqgAs7DYMGfG
   4Yi8QcPaN68IRtib7V0CN0khWx5KOOq60V6iVOthrr4NmtJPph1V6g1Yh
   wsBQ48xIxh3sAbgxju81KsNMHyJoEs7JpDjFfL+2jisQn2XhWozfj1SjS
   Y1L7wDUEHVY4Dm/14OcQcRin9KZ5aGWhjqYeUaSMFSe+kmFSbOesueJdG
   8bLVDMSgXa6gIxFZw54cTiNpQZkD9W5E43cp2MxLeIp4ebSAjlO3K4DVb
   w==;
X-CSE-ConnectionGUID: aphKj4PpSbG4cdJciU9GDw==
X-CSE-MsgGUID: QTVEfOtVRhmbscWH7KVk2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34912316"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34912316"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:46:23 -0700
X-CSE-ConnectionGUID: 5zxWEia2TdybBuIjl+p30A==
X-CSE-MsgGUID: p2i9LJ5kSRalXoVDru3KbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24533079"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 13:46:23 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/10] platform/x86/intel/tpmi: Handle error from tpmi_process_info()
Date: Tue, 23 Apr 2024 13:46:10 -0700
Message-Id: <20240423204619.3946901-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
References: <20240423204619.3946901-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When tpmi_process_info() returns error, fail to load the driver.
This can happen if call to ioremap() returns error.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org # v6.3+
---
 drivers/platform/x86/intel/tpmi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 910df7c654f4..003e765dedea 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -763,8 +763,11 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 		 * when actual device nodes created outside this
 		 * loop via tpmi_create_devices().
 		 */
-		if (pfs->pfs_header.tpmi_id == TPMI_INFO_ID)
-			tpmi_process_info(tpmi_info, pfs);
+		if (pfs->pfs_header.tpmi_id == TPMI_INFO_ID) {
+			ret = tpmi_process_info(tpmi_info, pfs);
+			if (ret)
+				return ret;
+		}
 
 		if (pfs->pfs_header.tpmi_id == TPMI_CONTROL_ID)
 			tpmi_set_control_base(auxdev, tpmi_info, pfs);
-- 
2.40.1


