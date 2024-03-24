Return-Path: <linux-kernel+bounces-114317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD938889C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490612872E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8509316EBE0;
	Sun, 24 Mar 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ap8FaGYI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2E21149A;
	Sun, 24 Mar 2024 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321707; cv=none; b=K/P17w5+6TbVAuEhGoA5mabiQ9HA2gJ0OapzZZP4I31Xt/z7FyQ8zOivkbyVwBgl6S0PoZ/5E25HjVgB7J1rEvAERmDeJ39yqcH8l6cXb27mBZlpTFgbQQVXv1lwCnH6a6iWyLeLkSmPp7DJzB25oD9RWkL2JORFI5ZJtBS49ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321707; c=relaxed/simple;
	bh=aoaVGp9uRd7q1yvISqaBgafhKrn8LdUJODoUaqJwLec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsAUy/OOztqNOjjBn1BEluDJt8xfmIqFw2QkIsd61+IyF4KQgwW8mHxmGibQKl8+4bdPCHDDEYcuuxFcmTOJPPKYVhdQz6G3ScsMIMAboSmP8bwyz/Nu0h8sqJhsxFYi4TRVLEwfNRtfKMcYvA4JhdZbcfIl0b8XrdtJV+q5lZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ap8FaGYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CD6C433F1;
	Sun, 24 Mar 2024 23:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321706;
	bh=aoaVGp9uRd7q1yvISqaBgafhKrn8LdUJODoUaqJwLec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ap8FaGYIpceEQwIZnG/0FIzkjN4zE72WQFNqUQlco5M2VOfgRf/1rqidcanUs3WFV
	 h2mLc9ro5VQrZvx6xYdLyKEshMT8tl2MmwC880NZJFqdw2D/1wYK/vXHTtoWxJaE+5
	 TId765TimwUECaWZxZvKPATXSDxcoT/nGaJ2bvDAAmjsJtP4UEx5QDZ5hEvRjxqIL+
	 z1kxIBB3F/1TOo9Vq0WrM8tsnQM7NXVhFdDxkNz9J2BXXqDEtIW1PMnIrymMFQi99K
	 iXYu5psa7Q+FWDFhrhuy6V6mR4wjpYW9+/sBvCxlJ+iRsZwIV1g0OkqmLNebhDBl0L
	 D1ea2gAM2Rq6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 435/638] clk: mediatek: mt7622-apmixedsys: Fix an error handling path in clk_mt8135_apmixed_probe()
Date: Sun, 24 Mar 2024 18:57:52 -0400
Message-ID: <20240324230116.1348576-436-sashal@kernel.org>
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

[ Upstream commit a32e88f2b20259f5fe4f8eed598bbc85dc4879ed ]

'clk_data' is allocated with mtk_devm_alloc_clk_data(). So calling
mtk_free_clk_data() explicitly in the remove function would lead to a
double-free.

Remove the redundant call.

Fixes: c50e2ea6507b ("clk: mediatek: mt7622-apmixedsys: Add .remove() callback for module build")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/2c553c2a5077757e4f7af0bb895acc43881cf62c.1704616152.git.christophe.jaillet@wanadoo.fr
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
index 9cffd278e9a43..1b8f859b6b6cc 100644
--- a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
@@ -127,7 +127,6 @@ static void clk_mt7622_apmixed_remove(struct platform_device *pdev)
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-	mtk_free_clk_data(clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt7622_apmixed[] = {
-- 
2.43.0


