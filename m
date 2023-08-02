Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED076C69B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjHBHVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbjHBHVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:21:01 -0400
Received: from mail-m12739.qiye.163.com (mail-m12739.qiye.163.com [115.236.127.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01152D5F;
        Wed,  2 Aug 2023 00:20:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m12739.qiye.163.com (Hmail) with ESMTPA id B0BE04A01E3;
        Wed,  2 Aug 2023 15:20:41 +0800 (CST)
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        kever.yang@rock-chips.com, zhangqing@rock-chips.com,
        heiko@sntech.de
Cc:     linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, huangtao@rock-chips.com
Subject: [PATCH v3 1/4] clk: gate: export clk_gate_endisable
Date:   Wed,  2 Aug 2023 15:20:35 +0800
Message-Id: <20230802072038.29996-2-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230802072038.29996-1-zhangqing@rock-chips.com>
References: <20230802072038.29996-1-zhangqing@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkgdTVZNGkJDTUMYGR1DTh1VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
        kG
X-HM-Tid: 0a89b51eccb3b212kuuub0be04a01e3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6K0k6SSo6Vj1CMCs2OT9RAzw*
        TB0aCyxVSlVKTUJLQk1LQ09JT0hIVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlNQ0w3Bg++
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make clk_gate_endisable not static, export API for other use.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/clk-gate.c       | 3 ++-
 include/linux/clk-provider.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 64283807600b..5a9d10370237 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -53,7 +53,7 @@ static inline void clk_gate_writel(struct clk_gate *gate, u32 val)
  *
  * So, result is always: enable xor set2dis.
  */
-static void clk_gate_endisable(struct clk_hw *hw, int enable)
+void clk_gate_endisable(struct clk_hw *hw, int enable)
 {
 	struct clk_gate *gate = to_clk_gate(hw);
 	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
@@ -87,6 +87,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 	else
 		__release(gate->lock);
 }
+EXPORT_SYMBOL_GPL(clk_gate_endisable);
 
 static int clk_gate_enable(struct clk_hw *hw)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 0f0cd01906b4..2d36404c14b3 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -630,6 +630,7 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 void clk_unregister_gate(struct clk *clk);
 void clk_hw_unregister_gate(struct clk_hw *hw);
 int clk_gate_is_enabled(struct clk_hw *hw);
+void clk_gate_endisable(struct clk_hw *hw, int enable);
 
 struct clk_div_table {
 	unsigned int	val;
-- 
2.17.1

