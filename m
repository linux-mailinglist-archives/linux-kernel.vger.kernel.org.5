Return-Path: <linux-kernel+bounces-115098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD2A888D18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3811F29C36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975A52F9F5E;
	Mon, 25 Mar 2024 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vw0WXLQn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6CE28BD4F;
	Sun, 24 Mar 2024 23:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324086; cv=none; b=KBJAyQrWD2OxZPjROYgjIR/9P1HPp564Vd1xlfJ00g9kuhlKqsxIUDm+GnhOKze4T/5Hww/u98ugBoQX+tzQnchiaLu5MhZ4DvUkLIYGGDdiz1MHxqbAvU5fsij0n4KGE1AjQjUTphikam4TOoeMgNGvK53WXL/ZeGwB0Tcx+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324086; c=relaxed/simple;
	bh=zNqYkFbK0N7IoaO0IVeQN2MXCj+9gzGdySn+dJqPGDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpSanH0xEO88rLU39Xo+1abYuXgcToSudfeJSyKPnpVRvgxq5jGXbNSlYbNkm0ia/Q6XExJ0R5YqIAh4Ifzr1dDuAJOot7ED7JJ1NtP49n1mXTJ2mRe6hntfedfUsxLq2i5157hum4EK3JuuzupYWN8PoZnz48uYsh00nQaSMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vw0WXLQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E773C433A6;
	Sun, 24 Mar 2024 23:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324085;
	bh=zNqYkFbK0N7IoaO0IVeQN2MXCj+9gzGdySn+dJqPGDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vw0WXLQnWGqeKsCTHrJIHtGpBEAF99D+DDoYWcNtiKJJS2gvePy6ONsfiK7Ta+w2l
	 t3TF91la7+G9wE8Th/9vYNm22g5oJ1BZx4rBUXNzEUBNSkxmVyvMZspfybws9rxzTZ
	 o+vaw95A6NHMSLZ8uqP2MLScuZ3CTfIjoqBdoDScVngNYjKpD+FLGZ8C1dMX3Lj8xL
	 O1MU3PE8FQvBxir92YnV+OwK89nwo3uakS2SzB4uDUrm1VfPdzV9ul0sVb2yk4+m5d
	 hVezrhgzON1Os24sBruyQceNDYz/hlOgySn56bSjR7/m/7Tu6RKxVVvenKowM/tlc3
	 UHxfhicmmtWWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 085/183] drm/tegra: dsi: Add missing check for of_find_device_by_node
Date: Sun, 24 Mar 2024 19:44:58 -0400
Message-ID: <20240324234638.1355609-86-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 13413d2b26028..4e454479ff157 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1451,9 +1451,11 @@ static int tegra_dsi_ganged_probe(struct tegra_dsi *dsi)
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


