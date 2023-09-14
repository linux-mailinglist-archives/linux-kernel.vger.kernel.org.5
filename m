Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C3F7A10E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjINWZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjINWZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:25:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960B2100;
        Thu, 14 Sep 2023 15:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694730345; x=1726266345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mh8fE6vgowiAhHm4fpC4Alsp4aaY+wRem+ZyVjBKytg=;
  b=MaxLcaH/ANp911yYyp8wPYrf/sGiAibh7IDXd/m8xgXlfE/IBLNnbDhR
   pVGaY9pN4w0oug+mcgRS9MDDeqhqEfpycwPO0Irp3UPa+MZg/b4XEZ/0+
   2Yebe3Vzu7C+32qws6MJzm8BDb5usmbOjTTyExnXJ2684/wf6YMKGrwKi
   JPx+UjS1YBSFekdFWFBfQ43vRTXXOL7wmJKM6CnDf/CzONdQ2jE9Js6r2
   sZ+W7I6cqBDFRJC0C/aeWEv/qwP3ZT18JMfJrcVzgjhlmblbEPKr5Wzjq
   3B3u/3WnhEjmtdUW8QxW/AGvfO22fNaMDj4kDHcabX58eCw/iCrzXz2GZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="410033378"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="410033378"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 15:25:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="1075553706"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="1075553706"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 15:25:43 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1] ACPI: processor_pdc: Fix uninitialized access of buf
Date:   Fri, 15 Sep 2023 01:25:27 +0300
Message-ID: <20230914222527.3472379-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bug was introduced during unification of setting CAP_SMP_T_SWCOORD for
_PDC and _OSC methods. Third u32 in buffer is never being zero-ed before
setting bits on it. The memory is not guaranteed to be zero as it was
allocated by kmalloc() instead of kzalloc(). Fix this by initializing
third u32 in buffer to 0.

Fixes: b9e8d0168a7a ("ACPI: processor: Set CAP_SMP_T_SWCOORD in arch_acpi_set_proc_cap_bits()")
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/processor_pdc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 1a8591e9a9bf..994091bd52de 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -19,6 +19,7 @@ static void acpi_set_pdc_bits(u32 *buf)
 {
 	buf[0] = ACPI_PDC_REVISION_ID;
 	buf[1] = 1;
+	buf[2] = 0;
 
 	/* Twiddle arch-specific bits needed for _PDC */
 	arch_acpi_set_proc_cap_bits(&buf[2]);
-- 
2.41.0

