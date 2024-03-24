Return-Path: <linux-kernel+bounces-113869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6DA888EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF56B1F2D857
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A4E152163;
	Sun, 24 Mar 2024 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY2Jdx1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821AA148822;
	Sun, 24 Mar 2024 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320922; cv=none; b=WBmWiI1kzCC5REVh5BxNetzZFv2d8yq0e7fvM8iTa64vGMhBeRv6hVnu8qbivzFpEifkiGeKdq7aMC0F7mQ1AGysCNRj9xcZjmYtV/JubHyKHDHWRABCGM1oxeh7XuCiZiX1XULhYaETH8WOs/Gocme6YennxTB9pubN6rmQQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320922; c=relaxed/simple;
	bh=W1qnD+PQflFLeBQuy72HrEwLuX68/y0GgttfO4r6uQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcp41KGZmthR5qt7DaFGtO5DR/3K9QQEANo+jA1tVNei5iwWT0QDyrlpMUHOHShlhzexNhYYgOMlJMNaumyWxgv93mtS5Fh6ngkp/ZOMCoNivOPGBJySl1elAuKMDgoO75pECnSwpKRl6soC/MfaMk2WO21WV4c9Z2W2K6RMd1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY2Jdx1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7A9C433C7;
	Sun, 24 Mar 2024 22:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320921;
	bh=W1qnD+PQflFLeBQuy72HrEwLuX68/y0GgttfO4r6uQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DY2Jdx1DwCWVsjsLS9WImuL0SVmuX4fP9/bLjTozXKO+B0WXdxyVcfSgZ41d/tXZr
	 AqU8u+otrD4kB7N7NUbcQeTf5uA+13uJdrbbjW036qHeMvFCi6OqGcW9IVf427RIiB
	 zBBPr9HACLOyj8lrF5DEzmWLr9NZ6m/qznD0yWJm/hVb3DqRDa5dwGGvSaJ41TjWlB
	 GK89d+18f1kBzqMKlc0ATXy23nyazTsmKnO6eSQb0wVwr8o9Q57HssixBBW2sXXQ7q
	 dpiqXXaKhm+TAvLUoN6F70DM68Qpd6PRxLTXegUcTKXia+EQKoGf4C/DrkQcZWAn0/
	 x8E54sWm02KEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 485/713] clk: hisilicon: hi3559a: Fix an erroneous devm_kfree()
Date: Sun, 24 Mar 2024 18:43:31 -0400
Message-ID: <20240324224720.1345309-486-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


