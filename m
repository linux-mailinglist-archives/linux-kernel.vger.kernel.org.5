Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA3078E039
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbjH3TMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245191AbjH3Oov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:44:51 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDED5D1;
        Wed, 30 Aug 2023 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693406689; x=1724942689;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7TaFVlp//OMcszsYkRir2eIPng21uz3mDFpNWMvw9F0=;
  b=IJXmYw1DH6HTbEY/3niKNOqoBkB+zoczHa1clQBMK6FfodF3wg3z/fIJ
   i1OdY+ZlzLYboZ10coA+a56RMiKitZuiKjh8geow+wPScztESA+WYKVpL
   A5n8j28i+Pu9KOkyC5C/mzpCXL5z7B6PlqDvlOvVzBGEwpHZpkrm8fz0q
   w=;
X-IronPort-AV: E=Sophos;i="6.02,214,1688428800"; 
   d="scan'208";a="236174924"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 14:44:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-1cca8d67.us-west-2.amazon.com (Postfix) with ESMTPS id EF5AD80CC6;
        Wed, 30 Aug 2023 14:44:45 +0000 (UTC)
Received: from EX19D002ANA003.ant.amazon.com (10.37.240.141) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 30 Aug 2023 14:44:41 +0000
Received: from b0f1d8753182.ant.amazon.com (10.106.83.32) by
 EX19D002ANA003.ant.amazon.com (10.37.240.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.37;
 Wed, 30 Aug 2023 14:44:37 +0000
From:   Takahiro Itazuri <itazur@amazon.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Takahiro Itazuri <zulinx86@gmail.com>,
        Takahiro Itazuri <itazur@amazon.com>
Subject: [PATCH] docs: Add desc for best effort mode of mmio_stale_data
Date:   Wed, 30 Aug 2023 15:44:26 +0100
Message-ID: <20230830144426.80258-1-itazur@amazon.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.83.32]
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D002ANA003.ant.amazon.com (10.37.240.141)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the sysfs files for mds and tsx_async_abort, that for
mmio_stale_data also provides the best effort mitigation mode which
invokes the mitigation instructions without a guarantee they clear the
CPU buffers to address virtualized scenarios. Adds description for the
mode in the mmio_stale_data's page to make it self-contained.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 .../hw-vuln/processor_mmio_stale_data.rst     | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
index c98fd1190..c1c96eeb8 100644
--- a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
+++ b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
@@ -226,7 +226,7 @@ The possible values in this file are:
        - The processor is vulnerable, but no mitigation enabled
      * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
        - The processor is vulnerable, but microcode is not updated. The
-         mitigation is enabled on a best effort basis.
+         mitigation is enabled on a best effort basis. See :ref:`best_effort`.
      * - 'Mitigation: Clear CPU buffers'
        - The processor is vulnerable and the CPU buffer clearing mitigation is
          enabled.
@@ -254,6 +254,23 @@ the above information:
   'SMT Host state unknown'  Kernel runs in a VM, Host SMT state unknown
   ========================  ===========================================
 
+.. _best_effort:
+
+Best effort mitigation mode
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+If the processor is vulnerable, but the availability of the microcode-based
+mitigation mechanism is not advertised via CPUID the kernel selects a best
+effort mitigation mode.  This mode invokes the mitigation instructions
+without a guarantee that they clear the CPU buffers.
+
+This is done to address virtualization scenarios where the host has the
+microcode update applied, but the hypervisor is not yet updated to expose the
+CPUID to the guest. If the host has updated microcode the protection takes
+effect; otherwise a few CPU cycles are wasted pointlessly.
+
+The state in the mmio_stale_data sysfs file reflects this situation accordingly.
+
 References
 ----------
 .. [#f1] Affected Processors
-- 
2.40.1

