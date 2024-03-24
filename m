Return-Path: <linux-kernel+bounces-114996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D5888C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6698C288E06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714162E5387;
	Mon, 25 Mar 2024 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i681koWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D328453A;
	Sun, 24 Mar 2024 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323788; cv=none; b=cGC6a/dbRXBwWl+o1tK8z+BX9yGOPoJ+8W0sXPdqgJd+1QouJy8BXLGoWSXODTUzGiSs2/LSFbEJ9wont//RK3pud19Vy6o4PrR1AQGpwMaUcM/r5NZ74TiYCljIftxZZphDG5miFy6h+9NxpOObS2DmSd/E6Vx94Ft0vlowH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323788; c=relaxed/simple;
	bh=IzdRU3IdcMNYWKy4HXT890rMU1sqwkd081iJnDt2tYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c04w0tYZt93K3xc1bTtMsOFx0UqWmq9z3wIfbXQYvfpaRxgRbCXjNZDVerOMeaBJFa8FdN5dnFwWrn6WkCpwKewEQgYFNS1ibOa1wF2/xE9IsQ0Vro/E/PhH6abbgGBZrQMM/7WsOqIdw+y7+l3vJQ1kYhgelUgskGclycLaIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i681koWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA9EC43390;
	Sun, 24 Mar 2024 23:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323786;
	bh=IzdRU3IdcMNYWKy4HXT890rMU1sqwkd081iJnDt2tYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i681koWQ2rVVeGJIZCeAf1VOKYNOFNiixfzNF6qvy9Puy7Ny+3fY4Zc+DvCJuIIvS
	 Zq2xUwS9eZv/rPLb8nAVPPZKDcsSvyysfjTAoaTK516JnsZqs+ZZJyfuuWbJsbFFgw
	 XUE3mVRb0cVJW+wax4YOgRJ5pvwBGfJRtXo4OuY1SscM2PrhS+JqsHU9hrDcJCswLc
	 oR97/vkIwsu4LL9gO/lk8EhAJ9u+xmEhlGEkd19Nqr1KoM13cOMQdPpXQMow7MNcr1
	 zoet7RGz9WlDn0iwBSi/XASy2Kti4ciO9Sv/DTd19d+6s4WNCIdhVuLiOzRdG4LYip
	 ZT+4h6c10KTPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 163/238] mfd: syscon: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 19:39:11 -0400
Message-ID: <20240324234027.1354210-164-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 60f74144a4f88..4d536a097e8cb 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -224,7 +224,9 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
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


