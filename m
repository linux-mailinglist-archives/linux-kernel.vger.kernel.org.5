Return-Path: <linux-kernel+bounces-162201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B618B5787
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A0C1F221C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E28757E7;
	Mon, 29 Apr 2024 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgLsbs3E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F3745E5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392577; cv=none; b=KOwlcjeN33aAGFP4izzK59/wKMZ9U9llIsySBK5Gnl9Szr908fJzRsmBhk7Caeq2BfhJA8PAyDK5BQTMHY+/AuD7MTwFn1YoO6eeKPyGtri2IYHpdKIGmS0mEgpYua8MBXCAR/puSc8r9qfOGeyTrKeNgwtdVuO4ikljeiTyZOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392577; c=relaxed/simple;
	bh=wLYBlxedLAthkJZqqlPpyzb7ig9rN7jLeqrZ6Jbe1HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8bwQ+F2BSCnB0WvRgRA8jt1s19MqCg2XuQdJmkUqzxNB4lukZLZctET+UqYCQuRJ5miEEr6YssL3gEKt7QBZ27I3yX/gO3tB37yrOZhXFyyeCohos1xYtHUZ/bAOLTq8tvaXzjUg0MmNN9w1fFLMMAiah0rwitNn3ok3QqxgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgLsbs3E; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392577; x=1745928577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLYBlxedLAthkJZqqlPpyzb7ig9rN7jLeqrZ6Jbe1HE=;
  b=LgLsbs3ENPu9nCm2pMP175SmwtRZ0TN3Ui2kLybsL3dWNxexmc7X4cwk
   Wnoza/rqGbgwnjt55eFgqMChLgRu/KOh1jBMChFuZtOpD3YSgzzSqL41u
   IYqDiuz65eo8QmQmw0bdu7HbtR5aGCz8zLzTRtFKCi9qihdpxp5LvxpDm
   conP5oI++fexV5Z5+is5cR7KLvntyyu7LlgcyNgzGi0T90d9MPPYsj66o
   g5DzvjLpWXmc7fvT1jCI8Sg+c36q/1QcuqqiwK659fKh3RIOVS+fAy9Rt
   zVQyZZxtDvkKDMqty3Fx/F5m2W2fCCczQOa/nZ1afFaD/bOk1PxBF1yib
   w==;
X-CSE-ConnectionGUID: uFZ/3b7jROaYPTfN5pYcdQ==
X-CSE-MsgGUID: JxzlNQv6S0m0Rmmomxczsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908280"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908280"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:36 -0700
X-CSE-ConnectionGUID: DJReRyvzTOOiCTbAQMlVCA==
X-CSE-MsgGUID: 4h4ZkCnqRBOPfZDmPc4H+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166654"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:34 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 11/14] intel_th: pci: Add Sapphire Rapids SOC support
Date: Mon, 29 Apr 2024 15:09:05 +0300
Message-ID: <20240429120908.3723458-12-alexander.shishkin@linux.intel.com>
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

Add support for the Trace Hub in Sapphire Rapids SOC.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 44c08db253d8..08c956fb4995 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -309,6 +309,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3256),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Sapphire Rapids SOC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3456),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
-- 
2.43.0


