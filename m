Return-Path: <linux-kernel+bounces-33543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACE9836B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5071C24C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0965857332;
	Mon, 22 Jan 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5nZQjQC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3514C587;
	Mon, 22 Jan 2024 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936672; cv=none; b=ADKMNe43cb7b/EvDEN0/x7hO8IwdThT5xK05DxTVI6JLSiNmpyojPHF4dBOL9/BeAve9Scyy2gZBtcTW6z4IqTnvOI9C9CMJB02gZZnzBZGPvp2Ip55rb5pQaXFcZMUU+Pvq8105tzu7hPXJvn+T8COe4h2QILcoVC3DJ7d5bE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936672; c=relaxed/simple;
	bh=RSfFW5hWnDVynWV4jW6qkfYMtLyQ16JOdwenWKS7Wo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFWZhXzxV635M6ux+BXTD8fldoMBW5SjMwgEQC2owX5Zy4ZRkZZnmOLfdVe8uaf4khwN78fmKMhi/FjEfewa+ATJkDZdQMVvTMvS4Hf6of4D7v2OWYr0jFNP6PuvpbgJW2zoSoZRLXbKNTrvVOCZy6V9pX3mA6AtdS+4e8FkLIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5nZQjQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184E9C433F1;
	Mon, 22 Jan 2024 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936672;
	bh=RSfFW5hWnDVynWV4jW6qkfYMtLyQ16JOdwenWKS7Wo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o5nZQjQCyp2Uylpougt1e8jhijM+PX9vOUhAXeoGsLVyYIDZvih/jsybu4hYv7xfZ
	 n7wITco6C4udseq77kezJW7LFczdYbrBbKzz2nB4n1lJZwxTx032kIxTok/7ec2U03
	 gUkV5WiQxFl9nIF+EZT2QypqOX8OTzOuC5L37z67ereUUK2ckowlo9e+O8G3SfoazS
	 +5wAdpRznR6KEtpBSNCEVNnkELz13yMyZjVC9e9uqHO0cRAq0+KRaNa/xhpDBng1iB
	 FTwvYYtdkfqr7b0wUPAzLSFp04PAw2oleGrY2yI9oxe/VIBifMCAOzQyM0oXsZeURr
	 xmltN2WJBYZuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	duje.mihanovic@skole.hr,
	conor.dooley@microchip.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 20/24] clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
Date: Mon, 22 Jan 2024 10:16:34 -0500
Message-ID: <20240122151659.997085-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 2fbabea626b6467eb4e6c4cb7a16523da12e43b4 ]

In cases where mapping of mpmu/apmu/apbc registers fails, the code path
does not handle the failure gracefully, potentially leading to a memory
leak. This fix ensures proper cleanup by freeing the allocated memory
for 'pxa_unit' before returning.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Link: https://lore.kernel.org/r/20231210175232.3414584-1-visitorckw@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mmp/clk-of-pxa168.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-pxa168.c b/drivers/clk/mmp/clk-of-pxa168.c
index f110c02e83cb..9674c6c06dca 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -258,18 +258,21 @@ static void __init pxa168_clk_init(struct device_node *np)
 	pxa_unit->mpmu_base = of_iomap(np, 0);
 	if (!pxa_unit->mpmu_base) {
 		pr_err("failed to map mpmu registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
 	pxa_unit->apmu_base = of_iomap(np, 1);
 	if (!pxa_unit->apmu_base) {
 		pr_err("failed to map apmu registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
 	pxa_unit->apbc_base = of_iomap(np, 2);
 	if (!pxa_unit->apbc_base) {
 		pr_err("failed to map apbc registers\n");
+		kfree(pxa_unit);
 		return;
 	}
 
-- 
2.43.0


