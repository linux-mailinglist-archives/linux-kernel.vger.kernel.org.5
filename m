Return-Path: <linux-kernel+bounces-115706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204F889D59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65FE1F36B07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD092118CF;
	Mon, 25 Mar 2024 02:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm56cFqR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0313A87C;
	Sun, 24 Mar 2024 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321705; cv=none; b=MF8emsnJ1f4i6ubxIF5qS70d3wFUs27Dc+OfZVhYYX99Ba6rWU0KNHtQeWk7z4rthv4A9c9KTxU/et2N7OZ7+Xyb3bk7j31CIG9zLIkmAw0IZgXLgEgRazN+FZgbCNCIaERerEApzYQSge94/tJuyQlA6dZeEEfujuqRW31hKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321705; c=relaxed/simple;
	bh=W1qnD+PQflFLeBQuy72HrEwLuX68/y0GgttfO4r6uQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCL0vnW6JLGIwXz65oyR+jcg4PGuXS88OpE5K3FK70eSgFaKohYHYMrWxN0X/8ONz0173iM6O59bCyEl+2zgdo7cldxFfWCsUutXsvoZkineE0ZoDSKuKOpZerzDYSFIXZoiEMClWNWyqSn7CmndKd8XiftksyiEzL4U9jomzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm56cFqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72B4C433F1;
	Sun, 24 Mar 2024 23:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321704;
	bh=W1qnD+PQflFLeBQuy72HrEwLuX68/y0GgttfO4r6uQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qm56cFqRdnf+lL4L6q3m5K/Mf5In1vGR/E2mNZORE7hyM3Zkp8asO+uBNW/dF1/lA
	 MgqNr/Cz43pVbMC5gatjE/arPAEPedrkDMlyOlXgmsSWJ6QPpgbXzbrgKAMO4RzziC
	 ZvbXE5ZimJrxfC3vxXN0amUO3vpHIrz0NVP8vWhPqxKKyj//rZC48ORcUVd8dMwDjB
	 cJVYXOIyd0PfMGqOa8Z9eIynBrvQNhVT2+V537ajqGVnns6mxdByMgPYFd+27h3WwP
	 OIjgFX5Iv/f3r+EBqDgCt15k8soQogg1Q6O4Bqq9LKf+4cA3RGXBP2xxgu8tf1vZ6+
	 WCPWC+t2wpTHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 433/638] clk: hisilicon: hi3559a: Fix an erroneous devm_kfree()
Date: Sun, 24 Mar 2024 18:57:50 -0400
Message-ID: <20240324230116.1348576-434-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 64c6a38136b74a2f18c42199830975edd9fbc379 ]

'p_clk' is an array allocated just before the for loop for all clk that
need to be registered.
It is incremented at each loop iteration.

If a clk_register() call fails, 'p_clk' may point to something different
from what should be freed.

The best we can do, is to avoid this wrong release of memory.

Fixes: 6c81966107dc ("clk: hisilicon: Add clock driver for hi3559A SoC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/773fc8425c3b8f5b0ca7c1d89f15b65831a85ca9.1705850155.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/hisilicon/clk-hi3559a.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index ff4ca0edce06a..4623befafaec4 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -491,7 +491,6 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 
 		clk = clk_register(NULL, &p_clk->hw);
 		if (IS_ERR(clk)) {
-			devm_kfree(dev, p_clk);
 			dev_err(dev, "%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			continue;
-- 
2.43.0


