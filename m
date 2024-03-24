Return-Path: <linux-kernel+bounces-113344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9D7888393
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D9DB23EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E0919922F;
	Sun, 24 Mar 2024 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8KqPev+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AD6198B96;
	Sun, 24 Mar 2024 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320145; cv=none; b=ZBABuTqib2u3B/6Y7lRJy2h9jFRMmEvN6WQ7avQyMhsZyp9mZsBTiuy66oHZ7z0/laAb5SD+lxj2yH5FHEXJgFdbSydwdOSYZ2xS/K2qYwv/A3/tsR7y76jVtJjKR/p4EhB0Ocvu5/rOJzdYXx8Tqewg6hRVD+V+Em/xsH/iHKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320145; c=relaxed/simple;
	bh=W1qnD+PQflFLeBQuy72HrEwLuX68/y0GgttfO4r6uQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZVZpgzTRDO+4H6Fq66lnUX9GWyPBj0S6ioMAS0J0BweHT4Ezg3sxsmU5qCnTtdPLcoCZQsmv+OLXRfcfKoUMQbVt/9Qm/oja+7EamtnrhN2QrsbsITkLjMpeQA5H5YNUCTRJNawI/+Zvnpu8DAmVBUj5Dpt/SoDuZGVn2bf1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8KqPev+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BCDC433A6;
	Sun, 24 Mar 2024 22:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320145;
	bh=W1qnD+PQflFLeBQuy72HrEwLuX68/y0GgttfO4r6uQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8KqPev+y/2duZNX1kf4xtAhwiKti6z58DzY5VzSJXqGUS6hgcrTChrTk9fpm+iTv
	 8dE/Hr+4mQT1W37CpHSAy56cVxFPppluDNrX2xLlMebWpReTl9pJ8UbRNbC8D/eplq
	 zVX06bdlYZIdH/Bxf+dxnQnTT3oes6M2++sP1bN2qdQHEp8t2yGAFuIdSdJvCYmIZu
	 mbbas6HnPJnYiEeWVVRdxSvb2/rCuaOzoGzGsGTKFl0wFf7LXmDvzKeyOxscgUm+9t
	 1LcBAy1vgF8t2onGg/Lv/qe7fPMEq1IS4IbMiFl5GVmw/yffhbzk0LIpZ0a+XlDhpR
	 rKJPR3rKGTiJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 453/715] clk: hisilicon: hi3559a: Fix an erroneous devm_kfree()
Date: Sun, 24 Mar 2024 18:30:32 -0400
Message-ID: <20240324223455.1342824-454-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


