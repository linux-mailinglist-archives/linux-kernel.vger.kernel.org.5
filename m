Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C340C7896D1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjHZMyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 08:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjHZMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 08:53:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83C0919AE;
        Sat, 26 Aug 2023 05:53:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99A5F1FB;
        Sat, 26 Aug 2023 05:54:33 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 431503F64C;
        Sat, 26 Aug 2023 05:53:51 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@foss.st.com, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH v2 5/6] clk: scmi: Add support for .is_enabled clk_ops
Date:   Sat, 26 Aug 2023 13:53:07 +0100
Message-ID: <20230826125308.462328-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230826125308.462328-1-cristian.marussi@arm.com>
References: <20230826125308.462328-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for .is_enabled atomic clk_ops using the related SCMI Clock
operation in atomic mode, if available.

Note that the .is_enabled callback will be supported by this SCMI Clock
driver only if the configured underlying SCMI transport does support atomic
operations.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- use more descriptive defines
---
 drivers/clk/clk-scmi.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index b7a180b3443e..2e1337b511eb 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -20,6 +20,7 @@ static const struct scmi_clk_proto_ops *scmi_proto_clk_ops;
 
 struct scmi_clk {
 	u32 id;
+	struct device *dev;
 	struct clk_hw hw;
 	const struct scmi_clock_info *info;
 	const struct scmi_protocol_handle *ph;
@@ -105,10 +106,24 @@ static void scmi_clk_atomic_disable(struct clk_hw *hw)
 	scmi_proto_clk_ops->disable(clk->ph, clk->id, ATOMIC);
 }
 
+static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
+{
+	int ret;
+	bool enabled = false;
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	ret = scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled, ATOMIC);
+	if (ret)
+		dev_warn(clk->dev,
+			 "Failed to get state for clock ID %d\n", clk->id);
+
+	return !!enabled;
+}
+
 /*
- * We can provide enable/disable atomic callbacks only if the underlying SCMI
- * transport for an SCMI instance is configured to handle SCMI commands in an
- * atomic manner.
+ * We can provide enable/disable/is_enabled atomic callbacks only if the
+ * underlying SCMI transport for an SCMI instance is configured to handle
+ * SCMI commands in an atomic manner.
  *
  * When no SCMI atomic transport support is available we instead provide only
  * the prepare/unprepare API, as allowed by the clock framework when atomic
@@ -132,6 +147,7 @@ static const struct clk_ops scmi_atomic_clk_ops = {
 	.set_rate = scmi_clk_set_rate,
 	.enable = scmi_clk_atomic_enable,
 	.disable = scmi_clk_atomic_disable,
+	.is_enabled = scmi_clk_atomic_is_enabled,
 };
 
 static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
@@ -221,6 +237,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 
 		sclk->id = idx;
 		sclk->ph = ph;
+		sclk->dev = dev;
 
 		/*
 		 * Note that when transport is atomic but SCMI protocol did not
-- 
2.42.0

