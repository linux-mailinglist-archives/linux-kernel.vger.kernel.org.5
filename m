Return-Path: <linux-kernel+bounces-78818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C789686193E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C191F2519D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AD612CD9A;
	Fri, 23 Feb 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF5+3niz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1961272D8;
	Fri, 23 Feb 2024 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708734; cv=none; b=dPO1rSBLIbRQOyvu5zwTIQkiOtW57uJ0oBWaBX3hNXiBFVvgTJwJ8s2Xg8xL1LtPQFwGX+RzMzqXjG5nczkdk4BBjP3BhT+ldIZrDAGn+bQaNHd9ciiVXoUGPnsZj/beaWE2/FyqobWiNtPNnQtCVMm3OkUhn4GvrOZ79ona3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708734; c=relaxed/simple;
	bh=jPhUX7fseszIBa5Cz4g6HtJ32wY5HpFdNrxQegeyAcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dFmsDUeyNEoVTc19/r/SidKfDQTtreNccp0L2lZoQbS37N/TsstN2lIHmVnSSOTmctnLWcO2z47ZllSorUb5vG8MmFowugSdswERQJeL+IOcpfDN1i4Qqo9C6B90WDC538xY4RLjkqHMxo83QC6uifw9qdwWt76WdOHgJT3YWxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF5+3niz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8925FC433C7;
	Fri, 23 Feb 2024 17:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708708733;
	bh=jPhUX7fseszIBa5Cz4g6HtJ32wY5HpFdNrxQegeyAcU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=XF5+3niz1AvIp05ztwt2NQuB8gytrjZBE9VbVU8Ge59jvkl6U8I3PaXf0sVbfcngD
	 xJ4HlxqQYpl8bI4RG/SlwpYKhMmwreT7RUEkLphSee8uogcE0N80IBCGPRalXX38+E
	 cU9kANXDxFRDDMGmUmk5BMcu/dKC4FpINudh3wpOcsPKq30XS3TE30gaOSyFZ/rqdh
	 oY4807xtUmjPO6MKY7q4AEVze03XjL0sDRE49QHiHyNxXNW7qqDwnvzNslgF++1CsF
	 jtZqeMPuVrLO8L3m3SlGOt39gPrvZ80/59fajymbUOVLITGYsS/Q5KZrDF3gsDtje3
	 WWOE0egbf/Jsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F77C5478C;
	Fri, 23 Feb 2024 17:18:53 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 24 Feb 2024 01:18:52 +0800
Subject: [PATCH RESEND] clk: set initial best mux parent to current parent
 when determining rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-mux-v1-1-608cc704ef43@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708708732; l=1451;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=fggch9mxMQ8SzPlFXnQcVvzDJCD3ro+vLZXoDYu1RGE=;
 b=WdFzW2xYhaZML01H7Wn3y7hOtv/t49Ffr8hwuamJTDM1SyPptIImRnP9E/eEQE/s1XsHe1wfJ
 I2CNZM08YmmCIAk+hVTmfKzxwd98Rl8RXD3aRxo0wP4bLDZ+v0hboHu
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

Originally, the initial clock rate is hardcoded to 0, this can lead to
some problem when setting a very small rate with CLK_MUX_ROUND_NEAREST.

For example, if the lowest possible rate privided by the mux is 1000Hz,
setting a rate below 500Hz will fail, because no clock can provide a
better rate than the non-existant 0. But it should succeed with 1000Hz
being set.

Setting the initial best parent to current parent could solve this bug
very well.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
This is actually a v2 of [1], but seems too simple to have a unittest.
It's tested in a mmc host driver.

[1]: https://lore.kernel.org/linux-clk/20230421-clk-v3-1-9ff79e7e7fed@outlook.com/
---
 drivers/clk/clk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2253c154a824..d98cebd7ff03 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -649,6 +649,10 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 
 	/* find the parent that can provide the fastest rate <= rate */
 	num_parents = core->num_parents;
+	if (core->parent) {
+		best_parent = core->parent;
+		best = clk_core_get_rate_nolock(best_parent);
+	}
 	for (i = 0; i < num_parents; i++) {
 		unsigned long parent_rate;
 

---
base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d
change-id: 20240215-mux-6db8b3714590

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>


