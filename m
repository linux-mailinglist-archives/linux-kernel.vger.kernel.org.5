Return-Path: <linux-kernel+bounces-155865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC0F8AF82F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B6E1F24185
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C85B143898;
	Tue, 23 Apr 2024 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+vnv3HV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91359142E8B;
	Tue, 23 Apr 2024 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905186; cv=none; b=u60QJ5SN1//rIZ5o5vp8Ur5CESjdaj6hOzCZpyzUEK/R+y35MMh2a/GKjUU35j3NjSnLotwgK2Hr1xVtD4YxMUEDW53pmPSje57eiOLjbQWmcC6qEteSU0REFVCLDteFSpSTIw9aqiEAdk5g/XhzwD+fdibW8Des78NyhLnZO7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905186; c=relaxed/simple;
	bh=aPi/KDxGcseIweuTcstcV1YqbcBID4ifcFKvvx7NzAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCB/yiFQfuniIEY8vzZJdVbATG2E2U27vgnYmdabD3xInLyj8pjk5XpomuRXPnrBAx3hD/7DFSpX+WXiBdLbAceQ3/UC/1soxR3RHFTFRRA9HVusHUv9na98MC1mIWMuZFgNb4n4UfcVrJEiLOUP6EcEFd1GISf6eNBU7sXeLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+vnv3HV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713905186; x=1745441186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aPi/KDxGcseIweuTcstcV1YqbcBID4ifcFKvvx7NzAA=;
  b=H+vnv3HVDwzWARvM5GMzkYFbgVCq2NWFk4jBsohrefNkXTvtwHllqHqr
   viWFFZ+2C9pxa7Bd9JGRx8uwh7PDFefhduEpiGia3O5g5WTpenigqGvDz
   kPPBVXe64vRbeGRWZDs+GDHaGzgTuiRPBdm3/rSW4k7MXnqHmYweclVXw
   QUcC9OmmNwFmRDqkeJTFwnoM0Noi8nVEhFmW0TQPLQFgaaOavRthOmVqG
   x3xHL48TSnLnLVI5Po3RodhKP3pPSg2jlMjAts217Xcw9Sqd1jmzdRgkQ
   hpXz9oFa5uy2rS5SYF1G+n803Tdarw6eUOopeLf2jLfm3SvOKoz9Y3gl4
   A==;
X-CSE-ConnectionGUID: ecyUjgbVRbqQwdZGIjHLoA==
X-CSE-MsgGUID: gtzgQmhNTseCFCbFARA4mA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34912320"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="34912320"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:46:23 -0700
X-CSE-ConnectionGUID: CpxSsS01SECWcMkAkJd36g==
X-CSE-MsgGUID: +wc3V5y3S9m6IsWwSrCc1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24533081"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa010.fm.intel.com with ESMTP; 23 Apr 2024 13:46:23 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 03/10] platform/x86/intel/tpmi: Align comments in kernel-doc
Date: Tue, 23 Apr 2024 13:46:12 -0700
Message-Id: <20240423204619.3946901-4-srinivas.pandruvada@linux.intel.com>
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

Align comments in kernel-doc for the struct intel_tpmi_plat_info.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/intel_tpmi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index a3529b962be6..685a41dddf82 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -27,9 +27,9 @@ enum intel_tpmi_id {
 
 /**
  * struct intel_tpmi_plat_info - Platform information for a TPMI device instance
- * @package_id:	CPU Package id
- * @bus_number:	PCI bus number
- * @device_number: PCI device number
+ * @package_id:      CPU Package id
+ * @bus_number:      PCI bus number
+ * @device_number:   PCI device number
  * @function_number: PCI function number
  *
  * Structure to store platform data for a TPMI device instance. This
-- 
2.40.1


