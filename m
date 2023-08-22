Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3653578426E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbjHVNvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjHVNvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:51:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB6C18B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692712302; x=1724248302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IF1fdtOJgoJHOlU5g1ASqshyhrK75YRzFrvQMf4aelo=;
  b=Pq2wes8wJAYyhRBejtIk2MsSe3CgXGFx74K0uIDHPPtYhkFerM7viFoV
   WnrNma7LqybL0Hc0A9vSj4kQNL1Ae3VBMgmsmUfv95mZrMS1IVReAKwzt
   y8+gwjXcF+AzSM/nslLqm5zZG/kXxIqS0S9OvmFVnZMapohNFlmqKjxXs
   NhE/f1FLu/Dj+qRB+3XsJiAyGhlvoNRJGJeTOoigsuKemN2X6tiKZiUdi
   dfrJcYuqJLwQqiAi9nda67Tu+1ehJi6fgcYSX3MrR9lU1mDs5B+8tJrvd
   Y1qnfBnNwUobCjuteRpvRh+6TWiXFBMu5j2D9n7NZZ3E2i0LKtQkYzRZ5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="404885538"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="404885538"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 06:51:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="771363041"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="771363041"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 22 Aug 2023 06:51:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2486E379; Tue, 22 Aug 2023 16:51:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] irqdomain: Check virq for 0 before use in irq_dispose_mapping()
Date:   Tue, 22 Aug 2023 16:51:36 +0300
Message-Id: <20230822135136.2138380-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a bit hard to read the logic since we use virq before checking
it for 0. Rearrange the code to make it better to understand.

This, in particular, should clearly answer the question whether caller
need to perform this check or not, and we have plenty places for both
variants, confirming a confusion.

Fun fact that the new code is shorter:

  Function                                     old     new   delta
  irq_dispose_mapping                          278     271      -7
  Total: Before=11625, After=11618, chg -0.06%

when compiled by GCC on Debian for x86_64.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/irqdomain.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 0bdef4fe925b..26f1be63d622 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -903,10 +903,11 @@ EXPORT_SYMBOL_GPL(irq_create_of_mapping);
  */
 void irq_dispose_mapping(unsigned int virq)
 {
-	struct irq_data *irq_data = irq_get_irq_data(virq);
+	struct irq_data *irq_data;
 	struct irq_domain *domain;
 
-	if (!virq || !irq_data)
+	irq_data = virq ? irq_get_irq_data(virq) : NULL;
+	if (!irq_data)
 		return;
 
 	domain = irq_data->domain;
-- 
2.40.0.1.gaa8946217a0b

