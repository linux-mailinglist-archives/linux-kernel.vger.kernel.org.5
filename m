Return-Path: <linux-kernel+bounces-113805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9360A8886B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A94F2911F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABC912FB3C;
	Sun, 24 Mar 2024 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJLimDeN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A81E5847;
	Sun, 24 Mar 2024 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320825; cv=none; b=PoKOBuqHkWttQ8Pzn6IghYg4gBiiw5YaH0S3ikLPyyKKXlvEJmD3x8HQt7mFJjYUL+vmjelE38DaB8RVChZdM07etVGe8hLoZLH70JlwgIDrftne4/P3fG4225G63ucysKhqBi0eBIk6omtzDBtCVEzwJjeeTPxNnvZ9ghkNceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320825; c=relaxed/simple;
	bh=1wD1lMemO0UeL75hTPilrXieqNAbYo6cSZgOGib9LQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvOoxBBa1BNnZmr2ypYj5VNjyvutjuYO1IpajSMzTv5RvyH3lkpEPpJ7ES4BK6QpDcYpKS3mq1JGvsus06rYxzSaDaMMLP4OhsOsCXf/+hwPSgpkCJt31TBkYK260Ihk94HPOob3DRG2dLCy1baNooEfLycdDl3EPw6Pl8pQp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJLimDeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B37C433C7;
	Sun, 24 Mar 2024 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320824;
	bh=1wD1lMemO0UeL75hTPilrXieqNAbYo6cSZgOGib9LQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJLimDeNHo/puLfJqD4/MPw/2Mna2wR134bWeF8YQgBbF6MmPjX9YESU7ER3hQ/s+
	 4ScuI79CZxMLs1jit+C3JW2OUSMTlzkjdxrTxMb7aCrpbt2eAFwXn6n2AiPjXKENDZ
	 y9ppXPVXreYwkdIql3DvsqbXiMzY6J6dcZmfGvGizO9vDX6cpaEUXISEhpsscReCcw
	 BrAlCc5qsFAXqJtOKsbfPxKnvXji1F1EUXLYM8jfjhZcP6Mkdw+1WVDSf9yMlhSEgO
	 8MuxkmixS/Ov+MEw1rwM2zEm1nyzJbwXJNqmqcb3wMHBuuEGuXVMl960EL1idS++DE
	 Kw1gPLnRQTLYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 389/713] drm/tegra: dsi: Add missing check for of_find_device_by_node
Date: Sun, 24 Mar 2024 18:41:55 -0400
Message-ID: <20240324224720.1345309-390-sashal@kernel.org>
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

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit afe6fcb9775882230cd29b529203eabd5d2a638d ]

Add check for the return value of of_find_device_by_node() and return
the error if it fails in order to avoid NULL pointer dereference.

Fixes: e94236cde4d5 ("drm/tegra: dsi: Add ganged mode support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231024080738.825553-1-nichen@iscas.ac.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index fbfe92a816d4b..e419b76e57d3e 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1544,9 +1544,11 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
 	np = of_parse_phandle(dsi->dev->of_node, "nvidia,ganged-mode", 0);
 	if (np) {
 		struct platform_device *gangster = of_find_device_by_node(np);
+		of_node_put(np);
+		if (!gangster)
+			return -EPROBE_DEFER;
 
 		dsi->slave = platform_get_drvdata(gangster);
-		of_node_put(np);
 
 		if (!dsi->slave) {
 			put_device(&gangster->dev);
-- 
2.43.0


