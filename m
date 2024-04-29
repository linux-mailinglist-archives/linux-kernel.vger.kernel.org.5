Return-Path: <linux-kernel+bounces-162200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAD18B5786
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC75F28731B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B9E745D6;
	Mon, 29 Apr 2024 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMCC97gD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822673534
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392575; cv=none; b=G12bOmINiDFK90XxhK7juR4sTizKL/K7NxXLyka/ttHIb6hK1YQNnW1Jy03CIXeoW8wDio5VuTpQ0+wqCzCwinQmjTTFPYl3gz0H6BHy6O3kovNKJimpToBGE1rsVWzElfZ8mGcFpQ4G6G0T3dgqBJwB4gel2sl87y+bNXIQdr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392575; c=relaxed/simple;
	bh=bxIRmwYGyryCI32YPKm+QfLssD8VLAYd6uQrJuFO2ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYP7tiy1/FqAL9Hwk58F+zbjj7xSLAyazkjGVYVwFVEdVX11lpchyKdvJesefrGSFtQESlgFJugPKVb7UMTjpZUTppt7R+/epvDEOYZxqIOf9BYdb70JwpffOtONboKQzWO37I+W/wuvJX4rhw4tUDFt5IcIplsn6gfl+yAKTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMCC97gD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392575; x=1745928575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bxIRmwYGyryCI32YPKm+QfLssD8VLAYd6uQrJuFO2ko=;
  b=BMCC97gDu6JA5CYff6r/tcMbJyUDvorQOpSIgx8ehqfK01ipZKTjqMV5
   yGEL5Zh7Mm+FL/+UwnrP7obYIzIXgOEcIFVO0TJ28/aUGretHYnuUT7fS
   /LiqjrdBfSnhknaRKC6Gr+BXq8eI6j/cjYj1s2e7naG/RSc/w5bVgRPvS
   DS0mK7HQTguKoPaAa/gHD7eSmgKjdmGN2ebQpFlUtR6pX0SUTbYUqtsoE
   8zB+InYTmwm7BT/aPvRcqe8dbZzJ59C1KwVL9OilPTOQNCYWTY9tVhMRC
   YNX99WkkAiGtVhDgsonaJqHGqw+ErfZxSwpMtrZHovqrgbeALIHWi8m95
   Q==;
X-CSE-ConnectionGUID: d+Ac1TDTSXaclN2nVGbtAQ==
X-CSE-MsgGUID: FaN42iaET+W/xbTdcGdl2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908277"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908277"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:35 -0700
X-CSE-ConnectionGUID: cKegIMa7TGyKiQJM0zOFYw==
X-CSE-MsgGUID: 8+ROLR8KRjm1V9rtqHEcNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166649"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:32 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 10/14] intel_th: pci: Add Granite Rapids SOC support
Date: Mon, 29 Apr 2024 15:09:04 +0300
Message-ID: <20240429120908.3723458-11-alexander.shishkin@linux.intel.com>
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

Add support for the Trace Hub in Granite Rapids SOC.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index beb4b2766aae..44c08db253d8 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -304,6 +304,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0963),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Granite Rapids SOC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3256),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
-- 
2.43.0


