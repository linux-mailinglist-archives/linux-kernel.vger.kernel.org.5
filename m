Return-Path: <linux-kernel+bounces-89721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A6486F4B4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B4F28349D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346EBE62;
	Sun,  3 Mar 2024 12:07:46 +0000 (UTC)
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C937AD24
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709467665; cv=none; b=cSCmFy8tlQRsY2CT5qmCSYuKdgZF5VTJ2Zv6gOdatNJJtwwfSXHyWE9bAt0mOvliy//GSlShYfNJ5cpczTT2L+QQP7quEQeIX2rIq6Hq9I8BZyfxHuiPwIHcMSafduIWu8MA+PvDJ0nr62HE3fjfy+uHteZ+Bn28d8El9a43hsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709467665; c=relaxed/simple;
	bh=8TfYbH/Sb4JWApIFsRo+aPKWTwj/9+8x40iu73tFba4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5EfG7lPwMaNfa3T6EcRuFQls5fqxT6PkUu/NRjaKWVcAe8KJkd1+QD5vpwLErHSqvG/2ct/pdHWeFYj+ss8bOl98iKAQGSpUNC4jKXvm9w772JYSj8zQcXdn2jeKob/9JZnA4+Lu3qKl5wyKyHuTlZSSyGEbL756WCz6ye6qRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 9ef0446a-d956-11ee-a9de-005056bdf889;
	Sun, 03 Mar 2024 14:07:35 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v1 1/1] clk: fractional-divider: Use bit operations consistently
Date: Sun,  3 Mar 2024 14:07:32 +0200
Message-ID: <20240303120732.240355-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use BIT() where makes sense. This alings usage of bit operations
in the same pieces of code. Moreover, strictly speaking by the
letter of the C standard, left shift of 1 by 31 bits is UB (undefined
behaviour), switching to BIT() addresses that as well.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/clk/clk-fractional-divider.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index 5067e067e906..a0178182fc72 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -140,8 +140,8 @@ void clk_fractional_divider_general_approximation(struct clk_hw *hw,
 	}
 
 	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
-		max_m = 1 << fd->mwidth;
-		max_n = 1 << fd->nwidth;
+		max_m = BIT(fd->mwidth);
+		max_n = BIT(fd->nwidth);
 	} else {
 		max_m = GENMASK(fd->mwidth - 1, 0);
 		max_n = GENMASK(fd->nwidth - 1, 0);
@@ -182,8 +182,8 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 val;
 
 	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
-		max_m = 1 << fd->mwidth;
-		max_n = 1 << fd->nwidth;
+		max_m = BIT(fd->mwidth);
+		max_n = BIT(fd->nwidth);
 	} else {
 		max_m = GENMASK(fd->mwidth - 1, 0);
 		max_n = GENMASK(fd->nwidth - 1, 0);
-- 
2.44.0


