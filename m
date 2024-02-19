Return-Path: <linux-kernel+bounces-71935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3201685ACB3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEB9EB24669
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C23524CF;
	Mon, 19 Feb 2024 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rennXjGT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41CA51C5F;
	Mon, 19 Feb 2024 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372793; cv=none; b=KNkksXIHq/MhqtwzfCmsU8CXZfK9h3esD5inWuTYmCqwjfMvCelKPxJIgrgvubu49uGb/fUXYuidOUdXLgWLeahB4701QvY+1Ibh3RZpg+2vqundziDkR95hD+cOGCzXUuDeEKx8mrxq/blzCsk5PYr/e/xvLMBTJnhWUJfcccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372793; c=relaxed/simple;
	bh=jPhUX7fseszIBa5Cz4g6HtJ32wY5HpFdNrxQegeyAcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ArHSECXTkq2JES8kPX3VAlMjUlMNHzk5uhi7yzGimFcbzz1AchmAbiomr2fk9gc1vXlRylCvT8qUqZ221EGkz+dvgkAzhdvVmRFsR7/ce0lJ3uvIt0K1kZzzXfjPoBuNDfeL1NW0LsqNapA3nVLjV0kKgmeQJKYo6hVv2HVxD/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rennXjGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 569EBC43390;
	Mon, 19 Feb 2024 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708372793;
	bh=jPhUX7fseszIBa5Cz4g6HtJ32wY5HpFdNrxQegeyAcU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=rennXjGTcaDY/TDQzC7c3u7zSQ44dXdcvGGfTfQB2u6ZEEW+5Z6gMZysAAAp0iBcB
	 kD9V0lmIUQIdYUZBZpof+tjWHQpcdZpTm84UPP4mwsby14/Xh+FXDpuIZ5I8RHiAQ8
	 AEN3pbFBU0p634Q9TucB9q2jIT/90ByGB/8A88uSKaWe0ScsueACbFngOV0EAmI3Wk
	 kqjtGNEqLKj3PadrpV/b+6tZEl1dQ5g9+RJ9DtuzSAp/a922HEQTeWBZPwmLHJuGHe
	 xBoKDeBpTOfT6G96xaCVMFnhQxkWa86HX+aBydZm6bKemxiorQ37KPWKXIc8OuO/Le
	 r6Fjmpv/1vdGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469C7C48BC3;
	Mon, 19 Feb 2024 19:59:53 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Feb 2024 03:59:51 +0800
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
Message-Id: <20240220-mux-v1-1-3ee0807ec219@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708372793; l=1451;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=fggch9mxMQ8SzPlFXnQcVvzDJCD3ro+vLZXoDYu1RGE=;
 b=K0K7C5//41mDeCsJpdfDjHd3GisENzOiqi+JFzD56RKu1hD13WdtTBCyC9JVc/ZoWoU2bXhfi
 hvk+d/xORxzDWdGIgmJtDjbupDM9vfr5aPKfaG5zFF1x6olZjKdqkcI
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


