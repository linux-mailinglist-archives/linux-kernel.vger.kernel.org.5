Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5F76B203
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjHAKgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjHAKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:36:32 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE487A1;
        Tue,  1 Aug 2023 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1690886191; x=1722422191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gr7mUKw52rv98qS4sLygIA4eRzxDQj2rwvDemhyr358=;
  b=EuxsX51x6V90n4BQuCGMVAPlcUyVl+OhOfxPXI4EMyrZXNdRz7BRsBLo
   hOHkTX96QkGuRRltKnmGKBjHnLtAwTrnCprTrEoaLZUL2AHNyFTw/znvq
   wqThLetZmGo5EA7SD8Ouy0zIcYrDMwtfS1/ksTNeQI3NBgBHIlggIqJBm
   q/vktwjjDGpIgHXXK8BPsnkMLRYR7W4Zb9AnbKcUxfyJlENfYsegw1Hbx
   7lUC48eLB8pyLW5Gj7YDTBNHM2J4omNxROJ3OVWmJ+E/EAxPxo0HKHaC2
   2EN5JBWfI/ZxDK+vv6B4yGW26/FuKrI/56SUrQjfbhtNXzrOcPq4Sh/Ri
   g==;
X-IronPort-AV: E=Sophos;i="6.01,246,1684792800"; 
   d="scan'208";a="32226640"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Aug 2023 12:36:25 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 097CE280085;
        Tue,  1 Aug 2023 12:36:25 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jai Luthra <j-luthra@ti.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/3] clk: keystone: syscon-clk: specify whether a parent is required in match data
Date:   Tue,  1 Aug 2023 12:36:08 +0200
Message-Id: <9a3ad0aeff409a35cfb6e398a9235de31a8d70e5.1690885413.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690885413.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1690885413.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid checking the compatible string again in the probe function.

No functional change intended.

Fixes: 6acab96ee337 ("clk: keystone: syscon-clk: Add support for audio refclk")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/clk/keystone/syscon-clk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/syscon-clk.c
index 68ac536f564e..9626a877e072 100644
--- a/drivers/clk/keystone/syscon-clk.c
+++ b/drivers/clk/keystone/syscon-clk.c
@@ -27,6 +27,7 @@ struct ti_syscon_gate_clk_entry {
 struct ti_syscon_gate_clk_data {
 	const struct ti_syscon_gate_clk_entry *clks;
 	size_t num_clks;
+	bool needs_parent;
 };
 
 static struct
@@ -129,11 +130,9 @@ static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
 				     "failed to get regmap\n");
 
 	num_parents = of_clk_get_parent_count(dev->of_node);
-	if (of_device_is_compatible(dev->of_node, "ti,am62-audio-refclk") &&
-	    num_parents == 0) {
+	if (data->needs_parent && num_parents == 0)
 		return dev_err_probe(dev, -EINVAL,
 				     "must specify a parent clock\n");
-	}
 
 	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, data->num_clks),
 			       GFP_KERNEL);
@@ -208,6 +207,7 @@ static const struct ti_syscon_gate_clk_entry am62_audio_clks[] = {
 static const struct ti_syscon_gate_clk_data am62_audio_clk_data = {
 	.clks = am62_audio_clks,
 	.num_clks = ARRAY_SIZE(am62_audio_clks),
+	.needs_parent = true,
 };
 
 static const struct of_device_id ti_syscon_gate_clk_ids[] = {
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

