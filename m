Return-Path: <linux-kernel+bounces-33441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F373D8369B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B141F23335
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67BE12A172;
	Mon, 22 Jan 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgM0P+06"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB412A169;
	Mon, 22 Jan 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936308; cv=none; b=FRZBIBpJwFJRDRf3f03cZ0aq1amnHK6oQFKfDqz53tIEFsOc032ONc34AgQNnLQaY2UVtBhLo7FEmbn4i/pnoeRpQo4v3Mivnj+fSGg4WS//z5lEuMpOxuTG0L/Mtlm62rDbMF1uWqQyh2Btt/pX+4HLnhgS1NMT9gM8PrAD9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936308; c=relaxed/simple;
	bh=mz7Ui4hv7tkWgv9iDMDaI2SzhQbhQvdDMWnGMMJr6e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7NF3WcMnoIPFbLfoeMyjY0m6ntv2goO2mjhzGRPBNw0FnzOjtb0ZPjY/PknytfnVHnRBCfsfKAWA2tiyINlsS0JAZScn0G1BrDR4eKLWOXuE+oZH7rRqZuuTp4BaBfKx4Nt/lHm4lCxU6SynyK5/l2+eW06dVEj55lXBDhv9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgM0P+06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF64C433C7;
	Mon, 22 Jan 2024 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936307;
	bh=mz7Ui4hv7tkWgv9iDMDaI2SzhQbhQvdDMWnGMMJr6e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kgM0P+06YI+xKnv+774H8JuNajkbTpbiPaYKcahOBIj7VdhRrGC69JyWtSSsI9Qhi
	 eKTyLd0eVPHWj9eaezAW+R29zzwMUNTpz5ew9gVOGOgn0MK/yk3aaFOFk7ZprRWdrb
	 Fbd1vw4d1xS8TxGxOyazhiOmywpfyOynXbKgp73IUEoMcc2b8iFSW+qLPDRNPVCWO6
	 8peFwK+qTzz53lca+KaIrEIUlU0lF0MTykmF1TCmxapovpB1iudNDL5tlu9CI3dLJE
	 IAx0A7i41ONCOvatFecpKleMqAR8QVgHlYNyh4hV5wXveqIuMuAP4uMzszkmGLwteV
	 rwhtgaNcmlsBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	conor.dooley@microchip.com,
	duje.mihanovic@skole.hr,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 40/53] clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
Date: Mon, 22 Jan 2024 10:08:41 -0500
Message-ID: <20240122150949.994249-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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
index 130d1a723879..cb0ebbd82038 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -306,18 +306,21 @@ static void __init pxa168_clk_init(struct device_node *np)
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


