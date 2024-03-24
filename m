Return-Path: <linux-kernel+bounces-114887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C76F88927D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCC41C2BBBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328201BCFC6;
	Mon, 25 Mar 2024 00:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcyifafJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685DD27CBD1;
	Sun, 24 Mar 2024 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323542; cv=none; b=WB53wbZLuv+13nvoHeXOMoEV9xbRWD5e+w12TivDuH2OGNg3o1kB+FZLyf1pvFkmYd9dzMuJwCcYj+taMmf69b1gLoD0iM9TfCiMl/vN+hgjgs7EvTvlbMSACA6CET0RlBTbDndi73QecS2ul8jRqRvuJBpmqkpgZTSmtzVMUME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323542; c=relaxed/simple;
	bh=7xi1OLy1P+SCpV9kh4AUDwMbrQgRJVjW6bDREvVkqis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4rUbxHzOlvlR6HUEKjuPzHGblFMpU72y0horH+9Y77FX6mq36+3aS3y3lcJPtKz3G12yXDOGTChFvU6hoQKxj6X1ViU2LOB3AIQVsvE9/7RzOl1IKNafXdfleKg/9ZX5gbqYxc6L/7eA8AMDA+Ci/rE3E7W/W8970FpGE7ZhzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcyifafJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C49C43390;
	Sun, 24 Mar 2024 23:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323542;
	bh=7xi1OLy1P+SCpV9kh4AUDwMbrQgRJVjW6bDREvVkqis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcyifafJe95qYOHsSw9ZL+sHElESGhs0tIB6EawdocLGQjn8XtHX2Man955Lue1sI
	 pOdmKsJl5GKg8Fj16jzBJu8O0pacYGr2rwpjrErp2ssq/eFEGU3P9xp3RPvlshN2o+
	 M5GPwz6jMTA4MdHNdb/P5rnzNo/tKMB70Re0dfQMYae1bQGMRG1uFGYTcoOysXeRIO
	 /QwRjRn94fkOaXRipEK8UzReiCrrHwYWHzMdFGeuFMMN+Qx7HqjjdhCCTwYntwMqL3
	 23/RpWJ52q/+aiDnwVotkFJSTQDcZnPt8J6o6sps6BEDnSa/0vzAQBsZAKutiGOw2P
	 I2Y59HzqZJcQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 250/317] clk: Fix clk_core_get NULL dereference
Date: Sun, 24 Mar 2024 19:33:50 -0400
Message-ID: <20240324233458.1352854-251-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index bf9057a8fbf06..84397af4fb336 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -425,6 +425,9 @@ static struct clk_core *clk_core_get(struct clk_core *core, u8 p_index)
 	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 
+	if (!hw)
+		return NULL;
+
 	return hw->core;
 }
 
-- 
2.43.0


