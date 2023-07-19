Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA81759657
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjGSNQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjGSNP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:15:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F01A6;
        Wed, 19 Jul 2023 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689772557; x=1721308557;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a3IRTT3fhajV+k4HkhAycEnaQ43BbvTn+F4JZ8wbqRo=;
  b=bf/RIFNygnxbZKXsbFOvqkOPHOxAeREDtYvhueQR3LEne3X70Leer+mb
   sDQDycjfTFOgKVY7nMpCeWwK0/nxoD9B60q8QOxFUNgOH9nbpkPZC46B/
   q8I5oEq8QtbjBFzaAGOevymO1Ew5QnQwWc4/wRIONYerI1h2iTfIQYG3Q
   js5KEu8YTKzgiam2X7htoPDsWyr90OjLmlwS15EaythKjNezWRGb1eKIJ
   Xa9pSvyeTDnSgcPtxQkAZTmCU2rt7y3YfXNfbmtQ6gn2k+JhBhu+2GyzT
   HZYu00sj242XcqEELr0k/nIldXxMbteGEBaZPm3mw3gggNLR7f6KW0SHV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="369105322"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="369105322"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:14:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="723982587"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="723982587"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2023 06:14:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A7722370; Wed, 19 Jul 2023 16:14:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 1/1] media: drxk: Use %*ph for printing hexdump of a small buffer
Date:   Wed, 19 Jul 2023 16:14:45 +0300
Message-Id: <20230719131445.47060-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel already has a helper to print a hexdump of a small
buffer via pointer extension. Use that instead of open coded
variant.

In long term it helps to kill pr_cont() or at least narrow down
its use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: bumped debug level and dropped unneeded conditional (Hans)
 drivers/media/dvb-frontends/drxk_hard.c | 29 +++++--------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 6ad4f202f1bf..2770baebbbbc 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -229,13 +229,8 @@ static int i2c_write(struct drxk_state *state, u8 adr, u8 *data, int len)
 	struct i2c_msg msg = {
 	    .addr = adr, .flags = 0, .buf = data, .len = len };
 
-	dprintk(3, ":");
-	if (debug > 2) {
-		int i;
-		for (i = 0; i < len; i++)
-			pr_cont(" %02x", data[i]);
-		pr_cont("\n");
-	}
+	dprintk(3, ": %*ph\n", len, data);
+
 	status = drxk_i2c_transfer(state, &msg, 1);
 	if (status >= 0 && status != 1)
 		status = -EIO;
@@ -267,16 +262,7 @@ static int i2c_read(struct drxk_state *state,
 		pr_err("i2c read error at addr 0x%02x\n", adr);
 		return status;
 	}
-	if (debug > 2) {
-		int i;
-		dprintk(2, ": read from");
-		for (i = 0; i < len; i++)
-			pr_cont(" %02x", msg[i]);
-		pr_cont(", value = ");
-		for (i = 0; i < alen; i++)
-			pr_cont(" %02x", answ[i]);
-		pr_cont("\n");
-	}
+	dprintk(3, ": read from %*ph, value = %*ph\n", len, msg, alen, answ);
 	return 0;
 }
 
@@ -441,13 +427,8 @@ static int write_block(struct drxk_state *state, u32 address,
 		}
 		memcpy(&state->chunk[adr_length], p_block, chunk);
 		dprintk(2, "(0x%08x, 0x%02x)\n", address, flags);
-		if (debug > 1) {
-			int i;
-			if (p_block)
-				for (i = 0; i < chunk; i++)
-					pr_cont(" %02x", p_block[i]);
-			pr_cont("\n");
-		}
+		if (p_block)
+			dprintk(2, "%*ph\n", chunk, p_block);
 		status = i2c_write(state, state->demod_address,
 				   &state->chunk[0], chunk + adr_length);
 		if (status < 0) {
-- 
2.40.0.1.gaa8946217a0b

