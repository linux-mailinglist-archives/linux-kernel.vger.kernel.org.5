Return-Path: <linux-kernel+bounces-114370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C707888A12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1A41C287C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D500426FA64;
	Sun, 24 Mar 2024 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2WNO4sV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CAA216938;
	Sun, 24 Mar 2024 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321765; cv=none; b=NsmBfY0f7Tyb/rNF1b/cGxAbL9Aj3/1OJFTFls+jETlhmFKRoUEumwNtt2DU9Ojt35erZQ13N+xt5HKrLnAWRQXvSMS9LTTqIybxOu+kdCABhIACcb/1/r6wIHwBNxWmb+5mjrtmOW3iNQlgkUGEtX5tqU8KGhDnmw6pDEwMJQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321765; c=relaxed/simple;
	bh=NyGVQpR4RLOY36Zw3sDHzVHxgYgxuS6XHiYrBAxK3PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULUs5k+MXutQJx8vUzpE6wjkJZuoKVGCYwR3HaHCAs3KRmyixBC04dFyBoO6Ufk4UHwqFmPaWjHzNiSn3+3ZIIp0wJU7+YRWN6aSFIBOsFzcevptSROq7weA1Xqyn9zLMinIIR12jgeQ/Tk9Ln4EQCTIdGwAbIpRHYxoIPOLu4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2WNO4sV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FA3C433F1;
	Sun, 24 Mar 2024 23:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321764;
	bh=NyGVQpR4RLOY36Zw3sDHzVHxgYgxuS6XHiYrBAxK3PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2WNO4sV9or69Cxi/zdC5+Z+Sc7aniXZCXhtxNah4pSMGIlF6ayg6akZs53bdAIbZ
	 g5uJshA6EjkAXuXreUURwCMBz3190au0sCLhlWyS6Qr2DND2lHJ+8ZHDA4LeNgOb6t
	 4Vf6g/YbOT6meOIXEAFVCuBmk7rzbd5KqUxngR9NSQzMYOM0xkARK1V0XKfKghFrm6
	 XA3Jq3DAPui9Pc02gBiY8oSYs+QcN4gd8uB7UnT4u/ORZmFCKUMf4vJqtrkBhOlBRj
	 f7PhWa8aSiGPQ0ySbx0GXA4a5UkMigAPEv41knWEf/1Noq4tKMQHq2kRtHytwEUcXz
	 JarUDC3Rh34/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 492/638] clk: Fix clk_core_get NULL dereference
Date: Sun, 24 Mar 2024 18:58:49 -0400
Message-ID: <20240324230116.1348576-493-sashal@kernel.org>
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

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

[ Upstream commit e97fe4901e0f59a0bfd524578fe3768f8ca42428 ]

It is possible for clk_core_get to dereference a NULL in the following
sequence:

clk_core_get()
    of_clk_get_hw_from_clkspec()
        __of_clk_get_hw_from_provider()
            __clk_get_hw()

__clk_get_hw() can return NULL which is dereferenced by clk_core_get() at
hw->core.

Prior to commit dde4eff47c82 ("clk: Look for parents with clkdev based
clk_lookups") the check IS_ERR_OR_NULL() was performed which would have
caught the NULL.

Reading the description of this function it talks about returning NULL but
that cannot be so at the moment.

Update the function to check for hw before dereferencing it and return NULL
if hw is NULL.

Fixes: dde4eff47c82 ("clk: Look for parents with clkdev based clk_lookups")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Link: https://lore.kernel.org/r/20240302-linux-next-24-03-01-simple-clock-fixes-v1-1-25f348a5982b@linaro.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 473563bc74960..50228cb0c5590 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -418,6 +418,9 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 
+	if (!hw)
+		return NULL;
+
 	return hw->core;
 }
 
-- 
2.43.0


