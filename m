Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D821755F49
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjGQJc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjGQJcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:32:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F512D;
        Mon, 17 Jul 2023 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689586340; x=1721122340;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k1VttNSjGVJlFU/THPyMisX2NJIoBk9nmTtj2yhOEFA=;
  b=go3ljCfCyaMJpN+8PgyX88Jf+88RTn7eZCDTk3hZO0LEhb0+c7N+eQYc
   7s7FIF1RmM+bnHF7H6INSKclTVcg3LUG2x6crG1vZNPQG8nOwb7KVygsm
   lkxOkvarqQJi8R82kpVym0E5hQYnpbrdWOz0Mpx5F3tlv2ymhP0p8tAGb
   E5PsTM2Nctq5f2MGpCvzZ8BTU8boq4JL+IUiPxpFLeDYETjMUNrRzjn5+
   7cC5pOfT6miGcFHlDY/wD/SQReDZMwnt3aE06g2eElA0HEHXMjd6MA2tH
   ElRMeBhvwtwTVBd0lEpKp/BnX3VX0RIDwE8tjL5G/hnMu2LqThcNP6ebY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="355823768"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="355823768"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 02:32:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="723139813"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="723139813"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2023 02:32:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 64F80256; Mon, 17 Jul 2023 12:32:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] Bluetooth: MGMT: Use correct address for memcpy()
Date:   Mon, 17 Jul 2023 12:32:14 +0300
Message-Id: <20230717093214.82102-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function ‘fortify_memcpy_chk’,
    inlined from ‘get_conn_info_complete’ at net/bluetooth/mgmt.c:7281:2:
include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
  592 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

This is due to the wrong member is used for memcpy(). Use correct one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 33c06f7c7641..d6c9b7bc8592 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7278,7 +7278,7 @@ static void get_conn_info_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	memcpy(&rp.addr, &cp->addr.bdaddr, sizeof(rp.addr));
+	memcpy(&rp.addr, &cp->addr, sizeof(rp.addr));
 
 	status = mgmt_status(err);
 	if (status == MGMT_STATUS_SUCCESS) {
-- 
2.40.0.1.gaa8946217a0b

