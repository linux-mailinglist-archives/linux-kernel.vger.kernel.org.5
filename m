Return-Path: <linux-kernel+bounces-63328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0597852DAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19DAAB270F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E2F23750;
	Tue, 13 Feb 2024 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9c36Lc/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5348225D2;
	Tue, 13 Feb 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819420; cv=none; b=KneNTzM/MMK8nliixpi5HKl2d+AOGHwGPgF5LN/bqAmEDkVkF5C0nIzeSZl98GGvhYZx/Z3al2B8tyy0RI553dvnO0SplcO2+TeHkI22e6fE5dIYqEb2k1glAQEeRZRVm5/xlma+PCX05DYD1dxwreF1BCLBQ34vr7BT49kg3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819420; c=relaxed/simple;
	bh=yq5HRU9Pb5q1jpmq7XT0U6aYcsw7enTeYRI+zhtoGRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R40dHwNtvEE8JdtCQjZ8yiZQYngdWnHIbyGlSjzbo8J3WjeR1s/Q0WeOSpopfsqmqz337untMQb1tW+OoOVxhy0PnGoTViiI5Egz4UJaKHtq1rNrM5hApxgbJWP/uwzBmKBxOooGQsJYyvlr16WqujnILis40Y9lEHwkjoQIUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9c36Lc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A845AC433C7;
	Tue, 13 Feb 2024 10:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707819420;
	bh=yq5HRU9Pb5q1jpmq7XT0U6aYcsw7enTeYRI+zhtoGRc=;
	h=From:To:Cc:Subject:Date:From;
	b=F9c36Lc/aQZfkBHmvKiejC1gWtzinZ/3+iAc9eR/J3h9zI7g/op8lFYtle0wExOkN
	 RJw8fXTS/mteuLyEN/8ak2sqqeDAhiIBPGPGvyI3TfycTQcxzNXpOWfGeD8FzLk6j6
	 TfFGLAaE1fqd1i0qCOF7/K8Gdm72ruNKcLlBZTjWPRWK+2TkyWoucZNe/362p7EGBm
	 TkrqAfkKafMv0T63/i57Moh3QtBZtul11a8tjxcv+AI2lr1mNsG+LIN6tRnofxC2rq
	 CweR/tfAOKkm3u1RpSETMEOjjeMsc/Xxmf3h/Ahd2Esi+i9OUgw9dANaSWoRkVaq5I
	 Y3m2lGbgJLcKQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] ethernet: cpts: fix function pointer cast warnings
Date: Tue, 13 Feb 2024 11:16:34 +0100
Message-Id: <20240213101654.461239-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

clang-16 warns about the mismatched prototypes for the devm_* callbacks:

drivers/net/ethernet/ti/cpts.c:691:12: error: cast from 'void (*)(struct clk_hw *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  691 |                                        (void(*)(void *))clk_hw_unregister_mux,
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/device.h:406:34: note: expanded from macro 'devm_add_action_or_reset'
  406 |         __devm_add_action_or_reset(dev, action, data, #action)
      |                                         ^~~~~~
drivers/net/ethernet/ti/cpts.c:703:12: error: cast from 'void (*)(struct device_node *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  703 |                                        (void(*)(void *))of_clk_del_provider,
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/device.h:406:34: note: expanded from macro 'devm_add_action_or_reset'
  406 |         __devm_add_action_or_reset(dev, action, data, #action)

Use separate helper functions for this instead, using the expected prototypes
with a void* argument.

Fixes: a3047a81ba13 ("net: ethernet: ti: cpts: add support for ext rftclk selection")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/cpts.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index bcccf43d368b..dbbea9146040 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -638,6 +638,16 @@ static void cpts_calc_mult_shift(struct cpts *cpts)
 		 freq, cpts->cc.mult, cpts->cc.shift, (ns - NSEC_PER_SEC));
 }
 
+static void cpts_clk_unregister(void *clk)
+{
+	clk_hw_unregister_mux(clk);
+}
+
+static void cpts_clk_del_provider(void *np)
+{
+	of_clk_del_provider(np);
+}
+
 static int cpts_of_mux_clk_setup(struct cpts *cpts, struct device_node *node)
 {
 	struct device_node *refclk_np;
@@ -687,9 +697,7 @@ static int cpts_of_mux_clk_setup(struct cpts *cpts, struct device_node *node)
 		goto mux_fail;
 	}
 
-	ret = devm_add_action_or_reset(cpts->dev,
-				       (void(*)(void *))clk_hw_unregister_mux,
-				       clk_hw);
+	ret = devm_add_action_or_reset(cpts->dev, cpts_clk_unregister, clk_hw);
 	if (ret) {
 		dev_err(cpts->dev, "add clkmux unreg action %d", ret);
 		goto mux_fail;
@@ -699,8 +707,7 @@ static int cpts_of_mux_clk_setup(struct cpts *cpts, struct device_node *node)
 	if (ret)
 		goto mux_fail;
 
-	ret = devm_add_action_or_reset(cpts->dev,
-				       (void(*)(void *))of_clk_del_provider,
+	ret = devm_add_action_or_reset(cpts->dev, cpts_clk_del_provider,
 				       refclk_np);
 	if (ret) {
 		dev_err(cpts->dev, "add clkmux provider unreg action %d", ret);
-- 
2.39.2


