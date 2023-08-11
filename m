Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A457377941E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjHKQQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjHKQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:15:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAE39271E;
        Fri, 11 Aug 2023 09:15:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 083BE139F;
        Fri, 11 Aug 2023 09:16:37 -0700 (PDT)
Received: from pluto.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6023F64C;
        Fri, 11 Aug 2023 09:15:51 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 1/6] firmware: arm_scmi: Simplify enable/disable Clock operations
Date:   Fri, 11 Aug 2023 17:14:41 +0100
Message-ID: <20230811161446.636253-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811161446.636253-1-cristian.marussi@arm.com>
References: <20230811161446.636253-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a param to Clock enable/disable operation to ask for atomic operation
and remove _atomic version of such operations.

No functional change.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/clk/clk-scmi.c            |  8 ++++----
 drivers/firmware/arm_scmi/clock.c | 24 ++++++------------------
 include/linux/scmi_protocol.h     |  9 ++++-----
 3 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 2c7a830ce308..ff003083e592 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -78,28 +78,28 @@ static int scmi_clk_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	return scmi_proto_clk_ops->enable(clk->ph, clk->id);
+	return scmi_proto_clk_ops->enable(clk->ph, clk->id, false);
 }
 
 static void scmi_clk_disable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	scmi_proto_clk_ops->disable(clk->ph, clk->id);
+	scmi_proto_clk_ops->disable(clk->ph, clk->id, false);
 }
 
 static int scmi_clk_atomic_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	return scmi_proto_clk_ops->enable_atomic(clk->ph, clk->id);
+	return scmi_proto_clk_ops->enable(clk->ph, clk->id, true);
 }
 
 static void scmi_clk_atomic_disable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	scmi_proto_clk_ops->disable_atomic(clk->ph, clk->id);
+	scmi_proto_clk_ops->disable(clk->ph, clk->id, true);
 }
 
 /*
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 96060bf90a24..447d29b5fc72 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -418,26 +418,16 @@ scmi_clock_config_set(const struct scmi_protocol_handle *ph, u32 clk_id,
 	return ret;
 }
 
-static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id)
+static int scmi_clock_enable(const struct scmi_protocol_handle *ph, u32 clk_id,
+			     bool atomic)
 {
-	return scmi_clock_config_set(ph, clk_id, CLOCK_ENABLE, false);
+	return scmi_clock_config_set(ph, clk_id, CLOCK_ENABLE, atomic);
 }
 
-static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id)
+static int scmi_clock_disable(const struct scmi_protocol_handle *ph, u32 clk_id,
+			      bool atomic)
 {
-	return scmi_clock_config_set(ph, clk_id, 0, false);
-}
-
-static int scmi_clock_enable_atomic(const struct scmi_protocol_handle *ph,
-				    u32 clk_id)
-{
-	return scmi_clock_config_set(ph, clk_id, CLOCK_ENABLE, true);
-}
-
-static int scmi_clock_disable_atomic(const struct scmi_protocol_handle *ph,
-				     u32 clk_id)
-{
-	return scmi_clock_config_set(ph, clk_id, 0, true);
+	return scmi_clock_config_set(ph, clk_id, 0, atomic);
 }
 
 static int scmi_clock_count_get(const struct scmi_protocol_handle *ph)
@@ -470,8 +460,6 @@ static const struct scmi_clk_proto_ops clk_proto_ops = {
 	.rate_set = scmi_clock_rate_set,
 	.enable = scmi_clock_enable,
 	.disable = scmi_clock_disable,
-	.enable_atomic = scmi_clock_enable_atomic,
-	.disable_atomic = scmi_clock_disable_atomic,
 };
 
 static int scmi_clk_rate_notify(const struct scmi_protocol_handle *ph,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index e6fe4f73ffe6..b4c631a8d0ac 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -90,11 +90,10 @@ struct scmi_clk_proto_ops {
 			u64 *rate);
 	int (*rate_set)(const struct scmi_protocol_handle *ph, u32 clk_id,
 			u64 rate);
-	int (*enable)(const struct scmi_protocol_handle *ph, u32 clk_id);
-	int (*disable)(const struct scmi_protocol_handle *ph, u32 clk_id);
-	int (*enable_atomic)(const struct scmi_protocol_handle *ph, u32 clk_id);
-	int (*disable_atomic)(const struct scmi_protocol_handle *ph,
-			      u32 clk_id);
+	int (*enable)(const struct scmi_protocol_handle *ph, u32 clk_id,
+		      bool atomic);
+	int (*disable)(const struct scmi_protocol_handle *ph, u32 clk_id,
+		       bool atomic);
 };
 
 /**
-- 
2.41.0

