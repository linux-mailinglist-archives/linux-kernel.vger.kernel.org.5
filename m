Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6268790E84
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbjICVpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjICVpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:45:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF257E44;
        Sun,  3 Sep 2023 14:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693777476; x=1725313476;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=nCzs+hgygWK4dgUYOGcBdhfQTY/GGDWHj82sqz2AGz0=;
  b=gUTbaY+CTbOpciGE8wzga36QUwWdTCF6bBTMz1Sa67/WeFo8D/gNsks6
   lesnUeYO2DGa9rLq5xpSYhvsnrxKwOfr0D1r9ZyqR6TE8oEvVrTn0uOc2
   GXtzpG4WUK449OjHLUJvcDNQ15fqvNhlFPiUkOAXR3Ku3AqtXyFEnryhq
   vq0Ys0HSsnrlcbR44Uatk3fxOzu3cm1bZttO4QVNv+U4mZkd4YzrQKJ9o
   MaE3NTerQ8eHWl/kRE4fC1X5w4Abv4i6Fq7Iw+Tyz0kv1C7Rr/q1r0VQD
   AJpDf21Euuzp/5qzb1KUcyo4+jZ8K6opWP3Wgoo5YpLfPNfcuCZ3hzepJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="379198044"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="379198044"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 14:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="775622080"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="775622080"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.99.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 14:43:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Sun, 03 Sep 2023 14:42:58 -0700
Subject: [PATCH] cxl/mbox: Fix CEL logic for poison and security commands
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com>
X-B4-Tracking: v=1; b=H4sIAOH99GQC/x2NQQqEMAxFryJZT6BWEOpVZBZpTTWgnSEZBkG8u
 9Xl4/3HP8BYhQ2G5gDlv5h8SoX21UBaqMyMMlUG73zngusw7SsmXjHLjmEi34eYXfYt1CKSMUa
 lkpa72ch+rLf4Ktf9czO+z/MC9dHjDXYAAAA=
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693777405; l=1473;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=nCzs+hgygWK4dgUYOGcBdhfQTY/GGDWHj82sqz2AGz0=;
 b=qhrb563OWWjKn974tp+Xw/Vjnl4OLwol3QkFwJQdyNmxEZMTC8HqFUccKmDChyNXPHZBNXhHW
 v3a5948I6FEDC1VHT+c/wpUYXsRSE3e8KO3zsdWdz8H7ukfwYc/wKbq
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following debug output was observed while testing CXL

cxl_core:cxl_walk_cel:721: cxl_mock_mem cxl_mem.0: Opcode 0x4300 unsupported by driver

opcode 0x4300 (Get Poison) is supported by the driver and the mock
device supports it.  The logic should be checking that the opcode is
both not poison and not security.

Fix the logic to allow poison and security commands.

Fixes: ad64f5952ce3 ("cxl/memdev: Only show sanitize sysfs files when supported")
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/mbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ca60bb8114f2..b315bdab9197 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -716,8 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
 		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
 
-		if (!cmd && (!cxl_is_poison_command(opcode) ||
-			     !cxl_is_security_command(opcode))) {
+		if (!cmd && !cxl_is_poison_command(opcode) &&
+		    !cxl_is_security_command(opcode)) {
 			dev_dbg(dev,
 				"Opcode 0x%04x unsupported by driver\n", opcode);
 			continue;

---
base-commit: 1c59d383390f970b891b503b7f79b63a02db2ec5
change-id: 20230903-cxl-cel-fix-9da269bf0f21

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

