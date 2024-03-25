Return-Path: <linux-kernel+bounces-117739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D56E88AEF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1181C3E517
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9125F82D90;
	Mon, 25 Mar 2024 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jxx7Yn6f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE61180606;
	Mon, 25 Mar 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392127; cv=none; b=XPJL3kTHJ1QCTanV4Ib5CCQ/hRdAtzNwp3QtAYH4lonXk5DhmyuajumDksFzYkhGveGktJbIMVQqO9wkQfKLN4QFUu0EgYRja9ejmdqSwvSFGm5KJOdQ/vW9+quG5L9rmgiiB8BoZ6HsuQoqyk9b2TJ6Ubknre7zA0Q1YmQnbuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392127; c=relaxed/simple;
	bh=onaeBFADTWFzOVhM/6B/QEw4squGRUq4bVkj4JHF800=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5Dp0QPFcFr4yCn/e2vgjXT3tnapJQ5ia1z9GBli7FflHxKoTz3jv1Tuo6iDQQqTZ3ObUWZtXzX6bDBaOGhQbVAMJYJRdTpVd4M78XhBmErYs5Or0Gm9y6/fWemmPgkw270PQKxGsc8WaU3YWIM3LcgdQ4cfN+kou/lV4TZ+2FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jxx7Yn6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BC7C43390;
	Mon, 25 Mar 2024 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711392127;
	bh=onaeBFADTWFzOVhM/6B/QEw4squGRUq4bVkj4JHF800=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jxx7Yn6f/cCx9ADdM8gdrESUSJzfJ5yfUPe6uOY0+pU8x1g2EGhAqSwxaTs6AtE7n
	 qh1ytg94dDA4/hxm0hccmOF5lPivxZF3on2HRvVYDnHOhJE77hufAZXfPvqpJLQimw
	 CmOp23v6C6qCBHhCS48us7x1XAvK9rsdKyweNzhGTmHGHs4a9/ZhzKOSw7zcjX3voY
	 QlRg9RKIWcX3Bnw/c+A5HHWZVTsDvMbQD53MqRTRdJ8OImcBxZVaUBagi26SUKze8t
	 tDMp65TZaUcbzho1Nx8JgWdKv3VzFoY7PjK0lGncva2yzRExn1uTHxo7nrAN8pni3+
	 ewTySS50JcF0A==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 3/5] clk: Initialize struct clk_core kref earlier
Date: Mon, 25 Mar 2024 11:41:57 -0700
Message-ID: <20240325184204.745706-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240325184204.745706-1-sboyd@kernel.org>
References: <20240325184204.745706-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize this kref once we allocate memory for the struct clk_core so
that we can reuse the release function to free any memory associated
with the structure. This mostly consolidates code, but also clarifies
that the kref lifetime exists once the container structure (struct
clk_core) is allocated instead of leaving it in a half-baked state for
most of __clk_core_init().

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 9fc522c26de8..ee80b21f2824 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3959,8 +3959,6 @@ static int __clk_core_init(struct clk_core *core)
 	}
 
 	clk_core_reparent_orphans_nolock();
-
-	kref_init(&core->ref);
 out:
 	clk_pm_runtime_put(core);
 unlock:
@@ -4189,6 +4187,16 @@ static void clk_core_free_parent_map(struct clk_core *core)
 	kfree(core->parents);
 }
 
+/* Free memory allocated for a struct clk_core */
+static void __clk_release(struct kref *ref)
+{
+	struct clk_core *core = container_of(ref, struct clk_core, ref);
+
+	clk_core_free_parent_map(core);
+	kfree_const(core->name);
+	kfree(core);
+}
+
 static struct clk *
 __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 {
@@ -4209,6 +4217,8 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 		goto fail_out;
 	}
 
+	kref_init(&core->ref);
+
 	core->name = kstrdup_const(init->name, GFP_KERNEL);
 	if (!core->name) {
 		ret = -ENOMEM;
@@ -4263,12 +4273,10 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 	hw->clk = NULL;
 
 fail_create_clk:
-	clk_core_free_parent_map(core);
 fail_parents:
 fail_ops:
-	kfree_const(core->name);
 fail_name:
-	kfree(core);
+	kref_put(&core->ref, __clk_release);
 fail_out:
 	return ERR_PTR(ret);
 }
@@ -4348,16 +4356,6 @@ int of_clk_hw_register(struct device_node *node, struct clk_hw *hw)
 }
 EXPORT_SYMBOL_GPL(of_clk_hw_register);
 
-/* Free memory allocated for a clock. */
-static void __clk_release(struct kref *ref)
-{
-	struct clk_core *core = container_of(ref, struct clk_core, ref);
-
-	clk_core_free_parent_map(core);
-	kfree_const(core->name);
-	kfree(core);
-}
-
 /*
  * Empty clk_ops for unregistered clocks. These are used temporarily
  * after clk_unregister() was called on a clock and until last clock
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


