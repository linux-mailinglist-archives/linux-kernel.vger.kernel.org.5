Return-Path: <linux-kernel+bounces-113353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E3E8883A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF37C281C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C2319ABEB;
	Sun, 24 Mar 2024 22:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSWmVBIm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2A19A61C;
	Sun, 24 Mar 2024 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320153; cv=none; b=NDjASuGFEpW0to+be1TBFBVXrVPk1Fzq2eqb2YkUUxuC433JRN4BYe2QKgtu8GO/rIolpZXHli5AgEjkjuVJC92Tb83/i/vJeJaAN/kuWtI0HlP/lOSwuV/siI73MWg7eduexHRTuM6HmLVkOEF6aWF3jRYyiE/S6f1xVYg1O2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320153; c=relaxed/simple;
	bh=6QT672QOnXtfVyI1jQ2OIfo7bcqP0hm5arRscEAGI0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qc8JUAYA2BoFWuwfo++j+n/XMkziCGEJUMavo3SD1DC5zJs1YviZb7/TTfL+ierlN1PXjFRAxw2DMSYIHyhZIdThMHx723YiCLNsuqCE2FaA6x4/qWmGIU+GKunPuiiF1rAxI1u2/+zjFMkgsT4EF0DV2B4mP0Wm9/oBPqLLdOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSWmVBIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09964C43390;
	Sun, 24 Mar 2024 22:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320153;
	bh=6QT672QOnXtfVyI1jQ2OIfo7bcqP0hm5arRscEAGI0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSWmVBImuepcCTV4tKPng4wCuM6BNM/TOl0rWjxtirSkXgyiLb4FmhLmRtq07qV55
	 TqD/7GossVstpkqo8WuViV9cPzhhTFW2ifsSmtXE3xPkOphhC3+5vx1op74wty/GbK
	 LwDSr4qm/303Hs7KAKwTQkYLf3zdf8KnxT2zRiqf8rkpTwA4Fa7FHRnG+9cu8O/Zzz
	 GrHnHOdybuVvVBAwTGESdWgvbzLeUc2YULR4zmpZhXiO1Ly1fvUCqRCKka8/4U93Y+
	 +mfoKKstDgj9QFyjLCzo7DbJ/mnuszfLnXn1lKp4sv8HdwP9qP0YYc25l7RV1XWlqI
	 UrASkEoeg9LlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 462/715] mfd: syscon: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 18:30:41 -0400
Message-ID: <20240324223455.1342824-463-sashal@kernel.org>
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

From: Peter Griffin <peter.griffin@linaro.org>

[ Upstream commit d2b0680cf3b05490b579e71b0df6e07451977745 ]

of_parse_phandle() returns a device_node with refcount incremented, which
the callee needs to call of_node_put() on when done. We should only call
of_node_put() when the property argument is provided though as otherwise
nothing has taken a reference on the node.

Fixes: 45330bb43421 ("mfd: syscon: Allow property as NULL in syscon_regmap_lookup_by_phandle")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Link: https://lore.kernel.org/r/20240220115012.471689-2-peter.griffin@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/syscon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index c9550368d9ea5..7d0e91164cbaa 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -238,7 +238,9 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
 		return ERR_PTR(-ENODEV);
 
 	regmap = syscon_node_to_regmap(syscon_np);
-	of_node_put(syscon_np);
+
+	if (property)
+		of_node_put(syscon_np);
 
 	return regmap;
 }
-- 
2.43.0


