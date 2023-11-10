Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028B37E823B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345014AbjKJTHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjKJTH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:07:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0352C27B30;
        Fri, 10 Nov 2023 10:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699641003; x=1731177003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FtWCs8mUEVjet65jeUzSbd7yYe6/fT5WULvkbUviyec=;
  b=ns9P5a2oesVL6BGaCMLAf0bisKbihQ+Y2MChHyTOb+0Hk8Qq38V4thu6
   NksBtUPr77bU6gzUWmlNKSz39KXBPtDl9iJZnhkebwyKbqjwp4Ywh9E5l
   rLKhsWMzfNSzoL8Qsv1QbdNtwWAFixfSUx6/ff4PnyfkbUb8CPOfHrzzs
   1EWfh/uI39NAcT6WxfFIXPvFqiEaOhpclbhMlrYfUh1fAVNjwBn/+FzuK
   x1i0lJXoAqqyn/aL/8BpacQbl10VNLu9Gd8tNmniIRNs5pcUrnQkKI7Jj
   eSrdpS6KsV/Cf+n7iO1jYt8h1wtY7yOe98qNCuyYlI6HCwDkKehiu6YXp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="380606836"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="380606836"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 10:29:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="792912159"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="792912159"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2023 10:29:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9F9A97F1; Fri, 10 Nov 2023 20:23:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 06/25] i2c: designware: Replace a while-loop by for-loop
Date:   Fri, 10 Nov 2023 20:11:26 +0200
Message-ID: <20231110182304.3894319-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
References: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
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

Replace a while-loop by for-loop in i2c_dw_probe_lock_support() to
save a few lines of code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 63cc3cdca2c7..cb954f11540e 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -260,11 +260,9 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 	int i = 0;
 	int ret;
 
-	ptr = i2c_dw_semaphore_cb_table;
-
 	dev->semaphore_idx = -1;
 
-	while (ptr->probe) {
+	for (ptr = i2c_dw_semaphore_cb_table; ptr->probe; ptr++) {
 		ret = ptr->probe(dev);
 		if (ret) {
 			/*
@@ -276,7 +274,6 @@ static int i2c_dw_probe_lock_support(struct dw_i2c_dev *dev)
 				return ret;
 
 			i++;
-			ptr++;
 			continue;
 		}
 
-- 
2.43.0.rc1.1.gbec44491f096

