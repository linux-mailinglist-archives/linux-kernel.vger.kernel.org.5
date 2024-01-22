Return-Path: <linux-kernel+bounces-33568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76B1836B79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9199B28668E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F20158AB7;
	Mon, 22 Jan 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDkZUEgy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01243FE25;
	Mon, 22 Jan 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936753; cv=none; b=AdUsRaY2aF7lnxNsWiqNwVuaUQ/0UoSrRJAuMRMeVR7j/xSw44wb7GLz1e1Ca8PECZMdAjsBHwXo6duSmE/0HIchuqJ7tyLBCXImFh54ZkqC+QT91zg4PsTKEmFHkl58GcqudmW9wO4V60TPiijP7zctaaa2v5tuRYGBJVwVCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936753; c=relaxed/simple;
	bh=RSfFW5hWnDVynWV4jW6qkfYMtLyQ16JOdwenWKS7Wo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtCstxglVcWWzY/jtbWL9dx/v9KzH4uid2sxq/tavb8DZ7tOcAT4osE7zYvpOt7dlLd4pmiJPBP9kCd16RotfZo+vbsT9GLLcZCr/ejvOt2HUyRO30llWCb+ti2e+KiML81lzbcyNgBvH3Nk9Dvo6c3NTv8Es3Y5mAt6TepKqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDkZUEgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B65AC433C7;
	Mon, 22 Jan 2024 15:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936753;
	bh=RSfFW5hWnDVynWV4jW6qkfYMtLyQ16JOdwenWKS7Wo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDkZUEgylSi0pA2H5Sr+O9eH3PK4lIZt/Iae/D9aQ8aH06E+rhK9S/c843zNQZeHG
	 CjApAI+3I/mbgX4a7zArpHF+/LbECkq281LEli4qJjWirhQ4AYpHeCy0rRVsYjoBRv
	 Y972ACG6e9thn5YFdDY+d4SXQz1+CqyTwW1bZjUaHo592/TMP7RG21Xdp6cvf4Yc+d
	 xKHAs4aadRz8PO9RagC/5nhf0uXT8HJ01v6vUwExStFLS+XV7Sx1Inb2qq7oEfgv+J
	 +MNe+7ZziyHLA1jl4BEuqIYsAy967fCMqpdfOo6KkCW3D1WqBpoKb+ilef3PK82yuU
	 Qy9eIKqos3q4A==
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
Subject: [PATCH AUTOSEL 4.19 19/23] clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
Date: Mon, 22 Jan 2024 10:17:59 -0500
Message-ID: <20240122151823.997644-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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


