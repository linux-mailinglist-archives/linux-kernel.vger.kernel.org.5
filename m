Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D73F7896CA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 14:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjHZMyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 08:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbjHZMxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 08:53:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C07E19AE;
        Sat, 26 Aug 2023 05:53:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E17ED75;
        Sat, 26 Aug 2023 05:54:25 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 192653F64C;
        Sat, 26 Aug 2023 05:53:42 -0700 (PDT)
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
Subject: [PATCH v2 1/6] firmware: arm_scmi: Simplify enable/disable Clock operations
Date:   Sat, 26 Aug 2023 13:53:03 +0100
Message-ID: <20230826125308.462328-2-cristian.marussi@arm.com>
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

SCMI Clock enable/disable operations come in 2 different flavours which
simply just differ in how the underlying SCMI transactions is carried on:
atomic or not.

Currently we expose such SCMI operations through 2 distinctly named
wrappers, that, in turn, are wrapped into another couple of similarly and
distinctly named callbacks inside SCMI Clock driver user.

Reduce the churn of duplicated wrappers by adding a param to SCMI Clock
enable/disable operations to ask for atomic operation while removing the
_atomic version of such operations.

No functional change.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- more descriptive commit message
- added a few defines to make clear what the boolean param means
---
 drivers/clk/clk-scmi.c            | 11 +++++++----
 drivers/firmware/arm_scmi/clock.c | 24 ++++++------------------
 include/linux/scmi_protocol.h     |  9 ++++-----
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 2c7a830ce308..b7a180b3443e 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -13,6 +13,9 @@
 #include <linux/scmi_protocol.h>
 #include <asm/div64.h>
 
+#define NOT_ATOMIC	false
+#define ATOMIC		true
+
 static const struct scmi_clk_proto_ops *scmi_proto_clk_ops;
 
 struct scmi_clk {
@@ -78,28 +81,28 @@ static int scmi_clk_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	return scmi_proto_clk_ops->enable(clk->ph, clk->id);
+	return scmi_proto_clk_ops->enable(clk->ph, clk->id, NOT_ATOMIC);
 }
 
 static void scmi_clk_disable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	scmi_proto_clk_ops->disable(clk->ph, clk->id);
+	scmi_proto_clk_ops->disable(clk->ph, clk->id, NOT_ATOMIC);
 }
 
 static int scmi_clk_atomic_enable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	return scmi_proto_clk_ops->enable_atomic(clk->ph, clk->id);
+	return scmi_proto_clk_ops->enable(clk->ph, clk->id, ATOMIC);
 }
 
 static void scmi_clk_atomic_disable(struct clk_hw *hw)
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	scmi_proto_clk_ops->disable_atomic(clk->ph, clk->id);
+	scmi_proto_clk_ops->disable(clk->ph, clk->id, ATOMIC);
 }
 
 /*
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index e6e087686e8c..1e8fae4b6570 100644
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
index 99c1405decd7..cb2afcc733a6 100644
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
2.42.0

