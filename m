Return-Path: <linux-kernel+bounces-102063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F49E87AE17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A250281860
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C52158D84;
	Wed, 13 Mar 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4ahr/5C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530A158D75;
	Wed, 13 Mar 2024 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348443; cv=none; b=CWdDJkHwqdUlb+P+/576OX7ithJA7w96lepquigPLzeO3Gp/Se+yCWa6+hSYZBZs4vhmIee7eNOhEoI+ALYXUWe3FitWMaDP+FxtU4SoN7DUv0FLcWgT1xpvJT6jVm1hcnar/TgTxopx0xfolmw4zzLAbGM+rrELm7zoEs/Y7tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348443; c=relaxed/simple;
	bh=EwYFc6u/vRmEQVBhKndW0cFn92ioVA9ZTpiDm23xcUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOeXlBgnHaeoXDZ0CedvioxXRu1cDBVKzweTXrmwbUui3ZwjpQN7am+WeTDJJKkun1ueQx5fLKRS+NnQfJTaeKKu1Mn3bqvf6chfklAAHBjpL5CluutaO9Bv4IATzVlr1kvq0LDw3fbO8Y4a8fitUKGSzPz3OqM+IljNw8Qq1dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4ahr/5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7251BC433C7;
	Wed, 13 Mar 2024 16:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348443;
	bh=EwYFc6u/vRmEQVBhKndW0cFn92ioVA9ZTpiDm23xcUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4ahr/5CoXYxhBzevLiigzC95ArZnJEWrxE960QIfn1E8oulRCDfdat1oga0AiOcB
	 o7APPzCkmgaggf8aSpA0HrwDMnO23UbeppxY82MSz2CjcMQWA9HZqXFCNdHGd3SM80
	 nAgedQ7Sq8fOt/N3ps6xpyRLMeXLYWiqtD8gEZ2ujaxEdGIGQBbw+MCCy1zzFPuma9
	 Wiov/YAZB+dauO6irkKditKOMfMNaauEaKFewqc0YQP0ZDfn3wGUGgENHRJXK3voea
	 ybJygIxZy10jKgfwgydeAimDWXT6gBetMfUTu0Hw0TneA/41I7YrABYq26dhmU14US
	 R2azWwxZhyFWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 37/73] serial: max310x: Use devm_clk_get_optional() to get the input clock
Date: Wed, 13 Mar 2024 12:46:04 -0400
Message-ID: <20240313164640.616049-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andy.shevchenko@gmail.com>

[ Upstream commit 974e454d6f96da0c0ab1b4115b92587dd9406f6a ]

Simplify the code which fetches the input clock by using
devm_clk_get_optional(). If no input clock is present
devm_clk_get_optional() will return NULL instead of an error
which matches the behavior of the old code.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20201007084635.594991-2-andy.shevchenko@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 8afa6c6decea ("serial: max310x: fail probe if clock crystal is unstable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 14537878f9855..8bf3c5ab59431 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1265,7 +1265,6 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 			 struct regmap *regmap, int irq)
 {
 	int i, ret, fmin, fmax, freq, uartclk;
-	struct clk *clk_osc, *clk_xtal;
 	struct max310x_port *s;
 	bool xtal = false;
 
@@ -1279,23 +1278,24 @@ static int max310x_probe(struct device *dev, struct max310x_devtype *devtype,
 		return -ENOMEM;
 	}
 
-	clk_osc = devm_clk_get(dev, "osc");
-	clk_xtal = devm_clk_get(dev, "xtal");
-	if (!IS_ERR(clk_osc)) {
-		s->clk = clk_osc;
+	s->clk = devm_clk_get_optional(dev, "osc");
+	if (IS_ERR(s->clk))
+		return PTR_ERR(s->clk);
+	if (s->clk) {
 		fmin = 500000;
 		fmax = 35000000;
-	} else if (!IS_ERR(clk_xtal)) {
-		s->clk = clk_xtal;
-		fmin = 1000000;
-		fmax = 4000000;
-		xtal = true;
-	} else if (PTR_ERR(clk_osc) == -EPROBE_DEFER ||
-		   PTR_ERR(clk_xtal) == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
 	} else {
-		dev_err(dev, "Cannot get clock\n");
-		return -EINVAL;
+		s->clk = devm_clk_get_optional(dev, "xtal");
+		if (IS_ERR(s->clk))
+			return PTR_ERR(s->clk);
+		if (s->clk) {
+			fmin = 1000000;
+			fmax = 4000000;
+			xtal = true;
+		} else {
+			dev_err(dev, "Cannot get clock\n");
+			return -EINVAL;
+		}
 	}
 
 	ret = clk_prepare_enable(s->clk);
-- 
2.43.0


