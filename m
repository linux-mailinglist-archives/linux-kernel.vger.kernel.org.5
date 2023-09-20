Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392DA7A8C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjITSwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjITSwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:52:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17606AF;
        Wed, 20 Sep 2023 11:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695235922; x=1726771922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M54V96/a5JNvmtpGTO55S8B6KkQoazOnDcAbzhvWxAs=;
  b=lXkQnLPgYbiov/uheohU1+/fwSuuVVarDva+dUQsgBWtmG8XlznFwwzn
   XMGO6247NbPGMlrrJlJu2HDLUa5vgyGeFML2IMY2IeJ9UhywT5TfyhF9F
   zWK6R78CXGXg3AI5SO0FPtdNs/T8bjO8thXla0ZT6NKsDaMYbf0X9f2gM
   fWxePK+4L4N8l350JLthwCGW50RfXH/Ex2Oe+IfNUcXSK9QGfUsEkINo7
   0mhsQJSACzDZfM8i5Y2vmK5e2NJebcBsq5QDAZPnvvEwov0yEqPWZG196
   q2y9Z7ePzxLR0P+USCka240nIYtnMYqUktGVZm5R8K66h05R4HbFNbIxu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="377611672"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="377611672"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:52:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812280570"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="812280570"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmsmga008.fm.intel.com with ESMTP; 20 Sep 2023 11:52:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH linux-next] thermal: int340x: processor_thermal: Ack all PCI interrupts
Date:   Wed, 20 Sep 2023 11:51:53 -0700
Message-Id: <20230920185153.613706-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All interrupts from the processor thermal PCI device requires ACK. This
is done by writing 0x01 at offset 0xDC in the config space. This is
already done for the thereshold interrupt. Extend this for the workload
hint interrupt.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device_pci.c       | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index 44b179ce9bc9..3c5ced79ead0 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -154,10 +154,11 @@ static irqreturn_t proc_thermal_irq_handler(int irq, void *devid)
 	if (status) {
 		/* Disable enable interrupt flag */
 		proc_thermal_mmio_write(pci_info, PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
-		pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
 		pkg_thermal_schedule_work(&pci_info->work);
 	}
 
+	pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
+
 	return ret;
 }
 
-- 
2.40.1

