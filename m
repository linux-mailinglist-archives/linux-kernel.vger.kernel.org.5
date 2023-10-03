Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E7D7B6D73
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjJCPxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjJCPxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:53:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B22BA6;
        Tue,  3 Oct 2023 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696348422; x=1727884422;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cSNZnvTcszynHkc7EOnPJtMLPyMJLtAPb33rc17IhQU=;
  b=gpsbtYqIlth1T2AggptEJW4GTA+aYSxWT8OfmV5C+wqG6FLFE7Pqu+SQ
   F+DbZWVYho8bKafr7BPK6hDwFjUlSlgIr+Z+TpNUuDmfy6d+G9x/o/H2M
   8A6cQa463rig9iOB0He4avuG0ozmymVsmZGshfTwJia0HpHdutKbBfE/v
   /P7lisGKk5EHumb1mMn9vYgMY+7LtvDExSXJ5Imkl+4cxI6tzP6UhwlsD
   qXZTTpfowL4yuBfCBwCB/jjG8bZgd3ibvDe/3+mwdawS95OLxyPWr9cWs
   nXW9AzIWaVdMmdlH08jWjn+AjTy6zMBUFcw0S6bYYeUiYg/l/TmOJ/W5p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="380186347"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="380186347"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 08:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="744564490"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="744564490"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orsmga007.jf.intel.com with ESMTP; 03 Oct 2023 08:53:41 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE bit
Date:   Tue,  3 Oct 2023 08:53:32 -0700
Message-Id: <20231003155332.1855569-1-srinivas.pandruvada@linux.intel.com>
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

The EHL (Elkhart Lake) based platforms provide a OOB (Out of band)
service, which allows to wakup device when the system is in S5 (Soft-Off
state). This OOB service can be enabled/disabled from BIOS settings. When
enabled, the ISH device gets PME wake capability. To enable PME wakeup,
driver also needs to enable ACPI GPE bit.

On resume, BIOS will clear the wakeup bit. So driver need to re-enable it
in resume function to keep the next wakeup capability. But this BIOS
clearing of wakeup bit doesn't decrement internal OS GPE reference count,
so this reenabling on every resume will cause reference count to overflow.

So first disable and reenable ACPI GPE bit using acpi_disable_gpe().

Fixes: 2e23a70edabe ("HID: intel-ish-hid: ipc: finish power flow for EHL OOB")
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Closes: https://lore.kernel.org/lkml/CAAd53p4=oLYiH2YbVSmrPNj1zpMcfp=Wxbasb5vhMXOWCArLCg@mail.gmail.com/T/
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 55cb25038e63..710fda5f19e1 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -133,6 +133,14 @@ static int enable_gpe(struct device *dev)
 	}
 	wakeup = &adev->wakeup;
 
+	/*
+	 * Call acpi_disable_gpe(), so that reference count
+	 * gpe_event_info->runtime_count doesn't overflow.
+	 * When gpe_event_info->runtime_count = 0, the call
+	 * to acpi_disable_gpe() simply return.
+	 */
+	acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
+
 	acpi_sts = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
 	if (ACPI_FAILURE(acpi_sts)) {
 		dev_err(dev, "enable ose_gpe failed\n");
-- 
2.41.0

