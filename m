Return-Path: <linux-kernel+bounces-94847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A668745DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1921C23889
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF04A5672;
	Thu,  7 Mar 2024 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJVDjvMo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684529B0;
	Thu,  7 Mar 2024 02:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709777032; cv=none; b=tMLg48ZPKZ3aoULYX6wASoHqrxAP/+e2ZSWXgLkQilhtOD/wD7gdp8KQGPoRD+wSWFq8xBpiMQJSGSwE9l4yBUZXeGdSDb0QJ5eU6N1CZ3Tk13XHXbfescyNv9XxkQQlLW49QYV8TRmsXeIWL/FdRSJjxCaVcxguKUAUVbMkn1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709777032; c=relaxed/simple;
	bh=Cl8dTmlc9duSd7n28lik+iwh3pfH6s7fs5pow85J+Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o4lPNWsTSupQomIR+AiyX/MFOf+Wx2JwiIJhYLPSlQpUl3KMUAgqr+W0AgQ37dbz94O6Zb6Ql7ITKNQ785YgF4429ivOtvC7cDl/FHnJlOF8tZ5hNH18YRykvRv20jgezwWrnTGoqC4kDroY2pnM+vtWi7neXG9SwY38sgNdvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJVDjvMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 561E0C433C7;
	Thu,  7 Mar 2024 02:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709777031;
	bh=Cl8dTmlc9duSd7n28lik+iwh3pfH6s7fs5pow85J+Dw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=IJVDjvMo9/wrge++fpaDouU/gfUKJz1mPmlQCgxRJWC0Ewm0uST1x8OZCLwSlYqex
	 C5jj3gRifVQYWQADzKCviEgPT8I0j0q1Ivk46kvt/o0EIH6GFt7vRahZo6BZI0mPBo
	 3yI0B4rG1PBdqCbZwNDZaOQI1T4T4xYVsc3IHumI60y3Gv3AtxI5i9v2pqhn+tvMjD
	 I5zAi78ZBgucsFenSj/tgtcU8NgDpYy5L6m+SqnANiVIAjeP0dEiYl4RrsZKK1DcBD
	 KHVBItkhH5DLHdQkjjq9Se0o1QK7xxW9US0SffLLSg1wl7V8VWOGfOlfiqW54Tx4sI
	 mgJFtCn4ulEsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3972BC54E41;
	Thu,  7 Mar 2024 02:03:51 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 07 Mar 2024 10:03:50 +0800
Subject: [PATCH v3] clk: set initial best mux parent to current parent with
 CLK_MUX_ROUND_CLOSEST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-mux-v3-1-0885fc1ab2c9@outlook.com>
X-B4-Tracking: v=1; b=H4sIAIUg6WUC/1WM0Q6CIBhGX8Vx3d/gBy276j1aFyCQrJQGymzOd
 w/tonl5vn3nzCSa4Ewkl2ImwSQXne8z8ENBmlb2DwNOZyZIUVBkJXTjBJVWZ8VPTJQ1Jfn5Dsa
 6aavc7plbFwcfPls0sXXd+4kBA6MUWiU506K++nF4ef88Nr4jayHh3+K0+lkIFGqUpZWiYlbj3
 lqW5QsHS1sRzgAAAA==
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709777030; l=1992;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=+mzOqRRpetTLywKtq+naXweDz2ih9wEm/mCbtZc7rOw=;
 b=q+iZF6EtDER3d5gAVZq04xD7GVCQQOVDTZPRm4F+aCBXhuLGOt+Y78TQ2fuynzckogHnLL6vD
 XzZ5kgSoK0xCpTlzgt55ANodTR7HaH4eNJg3XL7hLANVkNYw5P2M0Cp
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Originally, the initial clock rate is hardcoded to 0, this can lead to
some problem when setting a very small rate with CLK_MUX_ROUND_CLOSEST.

For example, if the lowest possible rate provided by the mux is 1000Hz,
setting a rate below 500Hz will fail, because no clock can provide a
better rate than the non-existant 0Hz. But it should succeed with 1000Hz
being set.

Setting the initial best parent to current parent could solve this bug.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
This is actually a v2 of [1]. It's tested in a mmc host driver.

[1]: https://lore.kernel.org/linux-clk/20230421-clk-v3-1-9ff79e7e7fed@outlook.com/
---
Changes in v3:
- remove the fix for clk_test.c
- limit the fix to CLK_MUX_ROUND_CLOSEST
- Link to v2: https://lore.kernel.org/r/20240306-mux-v2-0-92a5fa461fd2@outlook.com

Changes in v2:
- cover letter: remove statements about unittest
- add fix for clk_test.c
- s/privide/provide
- Cc Maxime
All suggested by Stephan Boyd
- Link to v1: https://lore.kernel.org/r/20240215-mux-v1-1-ebb2fba31d49@outlook.com
---
 drivers/clk/clk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2253c154a824..74dd61f7269f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -647,6 +647,12 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 	if (core->flags & CLK_SET_RATE_NO_REPARENT)
 		return clk_core_determine_rate_no_reparent(hw, req);
 
+	/* if MUX_ROUND_CLOSEST is set, set the initial best parent to current parent */
+	if (flags & CLK_MUX_ROUND_CLOSEST) {
+		best_parent = core->parent;
+		best = clk_core_get_rate_nolock(core);
+	}
+
 	/* find the parent that can provide the fastest rate <= rate */
 	num_parents = core->num_parents;
 	for (i = 0; i < num_parents; i++) {

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240215-mux-6db8b3714590

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


