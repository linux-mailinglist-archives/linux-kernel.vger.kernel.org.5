Return-Path: <linux-kernel+bounces-67139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B23A8566EC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9D0B22D60
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A91B13249F;
	Thu, 15 Feb 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xude8sqO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654D13248B;
	Thu, 15 Feb 2024 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009750; cv=none; b=ZS0TNRfEONbuuj3Uu+SOkBufrxyet6KfJP0gCZoIRSjcI71Ld1skzE/u74u6miQfF5On6HI7ejADJ66n6YOjKOKGXTxvJ1gks5kxk+KvWuRJuge3tPPTVNsPyF5I+CU+rtdB1R9HjfJO6NU1wQ7yYIJsnd5tm7ZofPf8uTIq8wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009750; c=relaxed/simple;
	bh=jPhUX7fseszIBa5Cz4g6HtJ32wY5HpFdNrxQegeyAcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NvTFK7ob65JjjQRxYT0b8MsQ527COx/nNBg/Z1/linjnvrd0T3DYpdDlUnjwldsJrMi6waJS1tKAcltQuQxAByOw7mU9qYMHM1Ku1Up+Q6h60JDIxokK2uO2KdhEFm9R1hezOzfR8AIlNSYOuvCxsm5Jz3WlFGwKQmJdmAskE70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xude8sqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 833DAC433C7;
	Thu, 15 Feb 2024 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708009750;
	bh=jPhUX7fseszIBa5Cz4g6HtJ32wY5HpFdNrxQegeyAcU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Xude8sqOiVdg231+aBTlQVEWxWUncmugjUAZEc0e7eyRqBCGubPrQQnuxVjpYahyl
	 SyWkj+WsA758DXkerF6rhcrP2IdoOgzYq/ErVepbUZYetP+fEWqEXLMjzG3DCu7Xco
	 LddQ4tsH/psTEwtMApnURTE+kBVQigwCzXEd+H0pLrmz1Z2941NFh61JX5YGiK9OIP
	 xMB2KIBKcpPDhtP1wl96WpdxWpuhYK9/eTo4W3tkpCigpMaUYqbW29dQhd9oNSbfmQ
	 QxEplSeiaQhTaqzKh5JbuuWkpj9x40iyKry3A5PqbV/wOQcD9zSjTCbEp6TseGHvu1
	 CjyVjlgcGbxXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5E7C4829E;
	Thu, 15 Feb 2024 15:09:10 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 15 Feb 2024 23:09:11 +0800
Subject: [PATCH] clk: set initial best mux parent to current parent when
 determining rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-mux-v1-1-ebb2fba31d49@outlook.com>
X-B4-Tracking: v=1; b=H4sIABYpzmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0NT3dzSCl2zlCSLJGNzQxNTSwMloMqCotS0zAqwKdGxtbUALxNcR1U
 AAAA=
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708009751; l=1451;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=fggch9mxMQ8SzPlFXnQcVvzDJCD3ro+vLZXoDYu1RGE=;
 b=wxjkbfTu/rBP44OMka17mBI8BMrBoao1MdhKtAdERg9Fwk4DSHxtLiTFHjXE1Uzk37ksKfWK6
 Vqg0qaYsmCACkojwPFrwYG6rvVm8oPv0ZySlUoc58fjg8jpb2yMSbLX
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


