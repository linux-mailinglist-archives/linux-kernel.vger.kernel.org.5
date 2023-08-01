Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5924676B207
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjHAKgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjHAKge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:36:34 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07DFE9;
        Tue,  1 Aug 2023 03:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1690886193; x=1722422193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=71D94zn0r09sDIOSC/l60WT+v/gYihO1La2/Jx5ioYc=;
  b=Mn5wPl4rHmyp0bg1Bs4XdsH/wMabJc6vLpYPexrw9Nxd7clQm09W426I
   EZCubDzYDCKkOQlSeWdZU1fS5BFwsP9cFArGjtofKVFEvYzmuvHBNKSoG
   Bub6LZdij8osCjxWozupqYr2JSX2m+LASemaX2JAdh3q0ce9sXRaJ3JE6
   F38mhld9rKlRhch/WrdsCPj+DzESDNBqVSLEC8HDBbMXP4SxiJPZUjiuP
   lApCQXm6QJIccm4rFuhcCEe7D/tNMFYuQ7+CHVIA/MTSgOzEgCNkbyRKk
   TkrSjGX6TcYVq+9nVWzTofcDK4P5zNy1geTFUMujMBnEE8w9Yyjzb8rft
   w==;
X-IronPort-AV: E=Sophos;i="6.01,246,1684792800"; 
   d="scan'208";a="32226641"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Aug 2023 12:36:25 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 30605280086;
        Tue,  1 Aug 2023 12:36:25 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jai Luthra <j-luthra@ti.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 3/3] clk: keystone: syscon-clk: use of_clk_hw_simple_get() for audio refclk
Date:   Tue,  1 Aug 2023 12:36:09 +0200
Message-Id: <fe46b97cb6b53ad20397c1569dbbfc2b15239b29.1690885413.git.matthias.schiffer@ew.tq-group.com>
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

The binding documentation for ti,am62-audio-refclk specifies that it has 0
clock cells (and Device Trees using the binding as documented have already
existed in vendor kernels for some time). Fix the driver to use
of_clk_hw_simple_get() instead of of_clk_hw_onecell_get(), as attempting
to reference the clock in the Device Tree will fail otherwise.

Fixes: 6acab96ee337 ("clk: keystone: syscon-clk: Add support for audio refclk")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/clk/keystone/syscon-clk.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/syscon-clk.c
index 9626a877e072..a539dbf2f48e 100644
--- a/drivers/clk/keystone/syscon-clk.c
+++ b/drivers/clk/keystone/syscon-clk.c
@@ -28,6 +28,7 @@ struct ti_syscon_gate_clk_data {
 	const struct ti_syscon_gate_clk_entry *clks;
 	size_t num_clks;
 	bool needs_parent;
+	bool simple; /* Use of_clk_hw_simple_get() rather than onecell */
 };
 
 static struct
@@ -129,6 +130,10 @@ static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "failed to get regmap\n");
 
+	if (data->simple && data->num_clks != 1)
+		return dev_err_probe(dev, -EINVAL,
+				     "simple clocks must have exactly 1 entry\n");
+
 	num_parents = of_clk_get_parent_count(dev->of_node);
 	if (data->needs_parent && num_parents == 0)
 		return dev_err_probe(dev, -EINVAL,
@@ -151,8 +156,12 @@ static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
 				 data->clks[i].name);
 	}
 
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-					   hw_data);
+	if (data->simple)
+		return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+						   hw_data->hws[0]);
+	else
+		return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+						   hw_data);
 }
 
 #define TI_SYSCON_CLK_GATE(_name, _offset, _bit_idx)	\
@@ -208,6 +217,7 @@ static const struct ti_syscon_gate_clk_data am62_audio_clk_data = {
 	.clks = am62_audio_clks,
 	.num_clks = ARRAY_SIZE(am62_audio_clks),
 	.needs_parent = true,
+	.simple = true,
 };
 
 static const struct of_device_id ti_syscon_gate_clk_ids[] = {
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

