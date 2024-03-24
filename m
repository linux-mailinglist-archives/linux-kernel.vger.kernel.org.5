Return-Path: <linux-kernel+bounces-114585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D03C888B27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6EE291025
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F3E29BF12;
	Sun, 24 Mar 2024 23:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDSdSM8O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAAD2308AD;
	Sun, 24 Mar 2024 23:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322229; cv=none; b=WL9TyUSX/ZcSiglKI8iWSpdYnW+YNktVd7cF+vg7zPqjONPtu6QX8ezHzvtDj92nBjX80nZJvYo/eluwym8LVTHbhg/m44McKAdS007bvWx5K1ATrcy8OUrWzxMrPf0AU7EtkGEMLuf5p68aEGA+7l+WjLqnumNp2azkbOtAR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322229; c=relaxed/simple;
	bh=9jN6vKZ98/bJPDMoRNuvk8UuWNbHvTAGirA78gAMS2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAeFPdA/FCpTbCGtAezAw47x8CLbbo5zjb2GDSlZD2wZmF37dGQRO4mPeo2hCEMbW+5PjOiN6Yy/Yidbru0dYDJ92OlJeATjDw2g1OGldBC+DQ9x9LgU/nOHlPmptUgUUxVtKmArW0NAFLPvaFOjya90UM+07kcTN3/cvxQ+4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDSdSM8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AAAC433C7;
	Sun, 24 Mar 2024 23:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322228;
	bh=9jN6vKZ98/bJPDMoRNuvk8UuWNbHvTAGirA78gAMS2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDSdSM8Ob2SkQCrjxeDQEpUAAvU2OmE9OcehPf9sMv2nQWTDPJ9wjE771H5VfIdmn
	 jrsrTT95iQfpAWq14UnI8BlLHZPEWcbLLYOt7UGngSil2YZdlfnkrGuPMo3ULg14w+
	 nwWudp5we4aHAVgYnKO5IPdxW9qQ8TRnC/aV9IdKlgYZNHxbh62VvgkVQgBw0/PqQa
	 eu73i0CVvXM2K3u+irYeMhnvbly5J/glpzwfUs/HHQ1WhdIu/qrxWc/M2cnlbe6ys0
	 1fnoRLCgZHH9qpcDZ51lhpJ4p6FGa2430ieRHszuucwaYdwYWcnuzoH60mKv4eQ+Oe
	 DGj9jKKruV4xg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 309/451] clk: hisilicon: hi3559a: Fix an erroneous devm_kfree()
Date: Sun, 24 Mar 2024 19:09:45 -0400
Message-ID: <20240324231207.1351418-310-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 9ea1a80acbe8b..0272276550ff1 100644
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


