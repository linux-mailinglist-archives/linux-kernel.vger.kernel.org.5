Return-Path: <linux-kernel+bounces-113241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD579888293
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FEC1C22BE3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19C1856A4;
	Sun, 24 Mar 2024 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpJx3hUF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AFD184F0E;
	Sun, 24 Mar 2024 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320042; cv=none; b=DrAM481EWMBlxAlxrSSn40lctqx/awQRceo20c9yJD3NMgJ9oNdM1Xedi9rl+fsF5JpCZyOz74OVo2xgNGQKtG1885GOiame4rh1Sp7hd3mMSmnEqDUMBGdXLjEOdLm2hgLXctZCEtbs6YfduPVh8ouAoeps3gOp37iJZaoe4IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320042; c=relaxed/simple;
	bh=1wD1lMemO0UeL75hTPilrXieqNAbYo6cSZgOGib9LQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alQoa0aTNK7GRU+nhuM4RhA89lIvN/oeRuaC4kLeEqcESounLK6muP/yKjJileykuhJKYFxmw1vacu2JWrmDC6u+9qgXILUKYegSMWPVDSmbraFmFpzRYZ/wVrxcDTPUhiwHaSxifPIoS18e4xZn+x4wlS1WX3JlRkkvV+Nbei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpJx3hUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468C0C433C7;
	Sun, 24 Mar 2024 22:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320041;
	bh=1wD1lMemO0UeL75hTPilrXieqNAbYo6cSZgOGib9LQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gpJx3hUFCMHfU7vGziacMttX6Kr8GJN5wAMxLC8drdjiVYMyPoYkLNvZ1/0vAtK84
	 MUCkCqX/lHysGqPbbfbNST6z3Wn2Eh+w4etSFAe5El1gGG2WBkGcvhzGdKvefHjQBR
	 Al8dd0XlCaymXMYnkw35DebDyXs7u5M1aDpNces3z+mqUnNinruUBmi7kYe+fOOhc6
	 SA30XluDD+TKE0NvdyWzS7WWqU62kRH9W4Cc8h4GqAfUEIguuRDwI+ONEDmpcIDT07
	 0UxNa1XrxCjmAP234aJe3oEyHc0qyLIMXXM9bDqtn4q8QnqqPnR+I9htHT9ptI+rDo
	 QzpXgvO9tu/1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 350/715] drm/tegra: dsi: Add missing check for of_find_device_by_node
Date: Sun, 24 Mar 2024 18:28:49 -0400
Message-ID: <20240324223455.1342824-351-sashal@kernel.org>
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


