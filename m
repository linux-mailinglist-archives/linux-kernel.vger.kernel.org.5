Return-Path: <linux-kernel+bounces-47475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A00844E6D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3AF81C28BA3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3952A3CF4E;
	Thu,  1 Feb 2024 01:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPYbQd+J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4B71EF15;
	Thu,  1 Feb 2024 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749675; cv=none; b=YiX9QLUrMOHKI0F65qVTEl+5n4iovawM92tD1ioKQdnZOa+TFhSJX1Il8/rXZ1dQHeZ0cpGkRIsW4nPZ8CwOHp6XCrTUlo1cO2Y770W4t1uhPUVOn6RyF3BS1mqVmpBRR9j6s/kmtV9D336h55MxvKW1+Yca4H25Od6V0yKNLX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749675; c=relaxed/simple;
	bh=yHNdMgW9yFyo2zPLd2fT4A8rb7bD8WunIVFdY+rWAMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WrnF1VULZGV3UwDkvTH7iL9ZbLW2Ymcpsh8MUDGKqPSPFdB+WW1c3DKxIb60lQ8RN/LXE7h3Yj7kYEejvcTpCcUb1go+rUAJfL763ydT2T1yTwgDTArYfPlHA1dwfGogu7HMRf0lNevCrv4SCJ7K/TKpesp0/wa8fGWu2wkRMMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPYbQd+J; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749674; x=1738285674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHNdMgW9yFyo2zPLd2fT4A8rb7bD8WunIVFdY+rWAMY=;
  b=KPYbQd+J66Hu5+wQD/qzz0Nyhe69dwqqfdbKoroU4j746tDo8p5F2Tv7
   Qf817LcZugU7Il9c/tCDKN4PBaaCUxrzADNLY5VXwyaGvhk62B79/DQ1L
   LbRjEc/OGdsWFAKreT6xfdA20u7ulsJBMyEbDXYvl2jBizvBcU2CNfZOw
   57KGnbFdE4amIJKFw5MaO5bivABe+9pHv+C48RJtWWs6Gvj8hIMw4LgDR
   ek1ytvRxd1SEO1SW2/9uENHB0ivq0KB1FnY+LkyT7/NKT8stRefgixCMg
   nNjH0o59rI309r7HHfNePtwMq5u1NCPuzvIUwmopQvh/dNMnc6Dj7PXPi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11145823"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="11145823"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="37057415"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:49 -0800
Received: from debox1-desk4.lan (unknown [10.212.205.115])
	by linux.intel.com (Postfix) with ESMTP id 26C98580DF0;
	Wed, 31 Jan 2024 17:07:49 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: netdev@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 5/8] platform/x86/intel/sdsi: Add in-band BIOS lock support
Date: Wed, 31 Jan 2024 17:07:44 -0800
Message-Id: <20240201010747.471141-6-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201010747.471141-1-david.e.box@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per SDSi in-band interface specification, sec titled "BIOS lock for
in-band provisioning", when IB_LOCK bit is set in control qword, the
SDSI agent is only allowed to perform the read flow, but not allowed to
provision license blob or license key. So add check for it in
sdsi_provision().

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/sdsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 14821fee249c..287780fe65bb 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -61,6 +61,7 @@
 #define CTRL_OWNER			GENMASK(5, 4)
 #define CTRL_COMPLETE			BIT(6)
 #define CTRL_READY			BIT(7)
+#define CTRL_INBAND_LOCK		BIT(32)
 #define CTRL_STATUS			GENMASK(15, 8)
 #define CTRL_PACKET_SIZE		GENMASK(31, 16)
 #define CTRL_MSG_SIZE			GENMASK(63, 48)
@@ -331,12 +332,21 @@ static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, s
 	return sdsi_mbox_cmd_read(priv, info, data_size);
 }
 
+static bool sdsi_ib_locked(struct sdsi_priv *priv)
+{
+	return !!FIELD_GET(CTRL_INBAND_LOCK, readq(priv->control_addr));
+}
+
 static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 			      enum sdsi_command command)
 {
 	struct sdsi_mbox_info info = {};
 	int ret;
 
+	/* Make sure In-band lock is not set */
+	if (sdsi_ib_locked(priv))
+		return -EPERM;
+
 	if (count > (SDSI_SIZE_WRITE_MSG - SDSI_SIZE_CMD))
 		return -EOVERFLOW;
 
-- 
2.34.1


