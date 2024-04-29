Return-Path: <linux-kernel+bounces-163149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A3F8B6660
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D0C7B225C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA0E194C81;
	Mon, 29 Apr 2024 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoRklByC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F283194C7D;
	Mon, 29 Apr 2024 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433713; cv=none; b=p53/ll7TPFM6PLFukebTTr+i/ugdez0nEDGiGBBHRqv43AtdJB90LiAysobzUQJ0mKWxZy2j366PqQuY92y9OKW+5lb5CtqOTmB/tDH9dS3HY2jXLJS+SQTIumucQYgDMOsWGgL2CdiNmLl+33xlYzMPKOyH74ZYv0jYzjw0i2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433713; c=relaxed/simple;
	bh=TFPGY+ddCwHX9312u/U1NxmZ4OYD0jX/msGOy3fTFSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=POf/5nFv7hmmJDOZEPBWCrFIdF4D/XPMJKmHe9nAFPeeqvLi1QRmAXkjueEfVZtBinAFaeQ3O65BEO3PXkd+PAJH5JATpdCYHW4+5Mg/B5XoLeG02RND9jNGgqHI6rKuw/3cO+EW2nkaDTcQwklfnKCIH5FulNWcUVdQpLX9A3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoRklByC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714433712; x=1745969712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TFPGY+ddCwHX9312u/U1NxmZ4OYD0jX/msGOy3fTFSg=;
  b=eoRklByCbkvEiQtVJZ+oM69QGLxAuGue8yX6c9/gr1zD/MVtCdjBy2ZQ
   Clt1p50ozBxw3YWtYKTVTzrUITp2bmpA9WJhLreBqd30rY1kQxL5ihCd3
   xKrmM2+vzFYNfBkd5kwAuL8lVhY0fqjy83l0wr3HrwxSdmw23gK7Pq4fO
   aJjRxUcTCx2/5UaFk50MbIUHHny+luREJ0dy5o8H8YIhYRnhk87TAi7Tx
   1ufIU5E/WkCcO0Atpr4/Q4Cv6OitYMqVrWer743VQCScdljOFWq1LCa36
   M3GFEhn2ZeYvg8yIpqFR84T95CKJNeWati8VQ0gfzQXo3Qrz92Laa+gCn
   Q==;
X-CSE-ConnectionGUID: 2rFRirq0RrGCDx+Kh74OkA==
X-CSE-MsgGUID: RQRFEapTSTC2VybheHH/vQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10274508"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10274508"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:35:09 -0700
X-CSE-ConnectionGUID: WTn4LFf8QsGgfhCNtU+5xg==
X-CSE-MsgGUID: BhAfoo7wQNiKotgFHFswdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26200133"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 16:35:08 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 1/4] thermal: intel: hfi: Rename HFI_UPDATE_INTERVAL
Date: Mon, 29 Apr 2024 16:41:49 -0700
Message-Id: <20240429234152.16230-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
References: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The name of the constant HFI_UPDATE_INTERVAL is misleading. It is not a
periodic interval at which HFI updates are processed. It is the delay in
the processing of an HFI update after the arrival of an HFI interrupt.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/intel/intel_hfi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index fbc7f0cd83d7..e2b82d71ab6b 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -166,7 +166,7 @@ static struct hfi_features hfi_features;
 static DEFINE_MUTEX(hfi_instance_lock);
 
 static struct workqueue_struct *hfi_updates_wq;
-#define HFI_UPDATE_INTERVAL		HZ
+#define HFI_UPDATE_DELAY		HZ
 #define HFI_MAX_THERM_NOTIFY_COUNT	16
 
 static void get_hfi_caps(struct hfi_instance *hfi_instance,
@@ -322,7 +322,7 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	raw_spin_unlock(&hfi_instance->event_lock);
 
 	queue_delayed_work(hfi_updates_wq, &hfi_instance->update_work,
-			   HFI_UPDATE_INTERVAL);
+			   HFI_UPDATE_DELAY);
 }
 
 static void init_hfi_cpu_index(struct hfi_cpu_info *info)
-- 
2.34.1


