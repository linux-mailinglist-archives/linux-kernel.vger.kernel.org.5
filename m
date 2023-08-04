Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDED770647
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjHDQt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHDQtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:49:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C98749E1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691167761; x=1722703761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aahh5Swgdsj9tjDJPMypieJ+4SsMPQB76IH8IvwJU4w=;
  b=ceU8loo2zlPBQYTloD0nKwXLEsXjR0+Vrviw9/hZ0XDULg2qptG7JdEY
   iwMQSSybxB3UEllcbqgZEW+WRD9+QlGP7/K/kw7wH61u+480rIhmYA9O6
   cJFsKFtiPcB/8xsPOx58IelQk/lnuBht82SM6mVk/aH+vk0N3QENe0xYe
   zrz74ybIqsNQ3S7lAdb/yehyWzAafT12iH2AEHCGVYSN8JmUMDkUHjUMv
   f7JY/BFU4cw6TtpgxTxnlcQAPVHn5jcxocHTQfHvrhZartD5JybPRbrnX
   S5HfrnS5ZXBfrd/i0hUw++rY0tV2zSKDYdjaE/v0uMyT63WYDHQNliiiJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="350505882"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="350505882"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 09:49:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="903943911"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="903943911"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 04 Aug 2023 09:49:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 104BE45B; Fri,  4 Aug 2023 19:49:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] irqdomain: Refactor error path in __irq_domain_alloc_fwnode()
Date:   Fri,  4 Aug 2023 19:49:32 +0300
Message-Id: <20230804164932.40582-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, there is no need to call kasprintf() if the previous
allocation failed. Second, there is no need to call for kfree()
when we know that its parameter is NULL. Refactor the code accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irqdomain.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 0bdef4fe925b..d2bbba46c808 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -81,6 +81,8 @@ struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 	char *n;
 
 	fwid = kzalloc(sizeof(*fwid), GFP_KERNEL);
+	if (!fwid)
+		return NULL;
 
 	switch (type) {
 	case IRQCHIP_FWNODE_NAMED:
@@ -93,10 +95,8 @@ struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 		n = kasprintf(GFP_KERNEL, "irqchip@%pa", pa);
 		break;
 	}
-
-	if (!fwid || !n) {
+	if (!n) {
 		kfree(fwid);
-		kfree(n);
 		return NULL;
 	}
 
-- 
2.40.0.1.gaa8946217a0b

