Return-Path: <linux-kernel+bounces-92677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01E1872417
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD511C21725
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCF612C55A;
	Tue,  5 Mar 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XISr8894"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8812BE8C;
	Tue,  5 Mar 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655745; cv=none; b=CnqArFTSls6xK9s7HiGrpq8jyo5kg7exCEG+iq3kxBgpHc+5mcNSkydvXg9BQIcrBDX+Du8ev93Iss6FIOlHbW9ttX/sfZBiY3VaclWBpKHYMvchgUVc+5rx3oFmxZLitCxpmhMcuIfMseg7c7aks+KJkNwBHBjuFD4Pf1kVFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655745; c=relaxed/simple;
	bh=oyQY85HAcz7F724S9pGlCinNferaZQxQAA0I1jPEHqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUfZ/fCyefTTLmEAgX1SNhWzrW/0d2U3sCffhAckVWhrnS+id5haWFmT35T8zzKa/3eZuVYeVF/zXWGvgaiI9vBSpzT3tMSjc6TxjHLGCa5QiJxSj3nB9eioV27t2MwYj4xRUJZCmFFnTqrjKI0biOq0IG76dmFSo+SXGL67Bf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XISr8894; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9F72C433C7;
	Tue,  5 Mar 2024 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709655744;
	bh=oyQY85HAcz7F724S9pGlCinNferaZQxQAA0I1jPEHqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XISr8894VLinyDkekfkKRmG1NfzBJSnSCcpXxTfIn77W3UZ6JK8igpCiwGDgLyiJj
	 F3P9qpZRKD7dozpTDWPwdQgzydH2xEu9+CmLGXjSwbh7J3d1MH+KCJAamhdSmQ4kzr
	 RtN7iYQedQSffcezgTEFTPEPb9Bke1RdSuSgOV/Ph23ZJp1f5d3OWi6Dv2BT7CNlHo
	 ucg7XdXJkYfObgkHDIZ5gfQhK6eoFvpm5TwFTme6qkSpoHf76tBMVl4WUM3wIKdVXp
	 XpE26jVJ0jU/buT6ezjkDjFAgawo6/pjUAG0InU2juFuHH2T9xt+6l2HCPouM4FsWN
	 xHc2J4fwhz3hw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A243C54E55;
	Tue,  5 Mar 2024 16:22:24 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 06 Mar 2024 00:22:23 +0800
Subject: [PATCH v2 1/2] clk: set initial best mux parent to current parent
 when determining rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-mux-v2-1-92a5fa461fd2@outlook.com>
References: <20240306-mux-v2-0-92a5fa461fd2@outlook.com>
In-Reply-To: <20240306-mux-v2-0-92a5fa461fd2@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709655743; l=1261;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=qRdSqORY6NMYE6mBkGdQAfI34M7sak4eBKjAJcYC8Bc=;
 b=2/KcJ3havJchmRp7Q0ZuGjPGMzYhLc2hdls8eymEBdHAOmEhBuKe1/LHXVOTT93oVuY6vlvlw
 TNsRHeihtsgAYYDoUzNaYnSz04AOlbU4XGb4vCwAGRXc8BH34n21Ihv
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
 drivers/clk/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2253c154a824..5fa92227b355 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -639,9 +639,9 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 				 struct clk_rate_request *req,
 				 unsigned long flags)
 {
-	struct clk_core *core = hw->core, *parent, *best_parent = NULL;
+	struct clk_core *core = hw->core, *parent, *best_parent = core->parent;
 	int i, num_parents, ret;
-	unsigned long best = 0;
+	unsigned long best = clk_core_get_rate_nolock(core);
 
 	/* if NO_REPARENT flag set, pass through to current parent */
 	if (core->flags & CLK_SET_RATE_NO_REPARENT)

-- 
2.43.0


