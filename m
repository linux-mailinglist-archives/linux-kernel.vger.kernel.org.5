Return-Path: <linux-kernel+bounces-114589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAA0889077
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB721C2C3BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD61869EC;
	Sun, 24 Mar 2024 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fURUrsfK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F422308CF;
	Sun, 24 Mar 2024 23:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322232; cv=none; b=O/Fhl35xVtvhqWx5AtBO0u6JeCnN8lGgbxgdtxPxEBuuPxHJ+yD3o2eJ3Th2Ker8LsgSREUr94Naq+TQiSwDTpoaHQsQQF1re9G9Wfg7rch0ps3Nt6tRWva6hMVD97xY3HbiceZop8LsoKq5SGXStsTZkgumnZ5iGSNQVqAXv5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322232; c=relaxed/simple;
	bh=TYK28TeZGa/OFOO34UMom8LLO0Z98SnbL7GGLyYtOWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeX5ahZ1rE1b6ViSGJZCMtnj2l2EqqdxxTmtqL4rm30Y7pJAr3dSiZUaGG26qly4iuyq++s64YlFxhkmwldUuIPOYCh2osSGa0nVSlfxIY68a28oE5Ai9UHusakdpSWIhIP8IzL7YU6sTh7mCLQGUTym4Qt51DScF7qJ9hKcGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fURUrsfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D48C433F1;
	Sun, 24 Mar 2024 23:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322231;
	bh=TYK28TeZGa/OFOO34UMom8LLO0Z98SnbL7GGLyYtOWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fURUrsfKqynb9aq+fbzGEG+tJZKYraE3IPOKa2Ae3gLoXL4r/naNjd50f2LMnH0T1
	 E/UC5fwkrQYqDVdeZNDgwVMD6HTOWUhHwMMiv1c4abLEK8SF4y90a8ZyyMV7hZ0Mk9
	 hUQlFOYiRw/za9dBMyPHSy7/gY35W7P34mcZwig4T16P+10rMd+2MsEFztkQJ9FTO+
	 nOjD6dkVO5XBYg83hV53oLOX8LlrcDF2Or3+ivA2E9xH1zyRzWKX8FuNf9H1woZ9pe
	 oCgiIHz5MP1Aaql3wIQ4HJBHt17eBcWv9HZgAyOJKYa7aeG3HhKQ+D/skKLlXWbDC2
	 uuVELjUsb7igg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 312/451] mfd: altera-sysmgr: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 19:09:48 -0400
Message-ID: <20240324231207.1351418-313-sashal@kernel.org>
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

From: Peter Griffin <peter.griffin@linaro.org>

[ Upstream commit e28c28a34ee9fa2ea671a20e5e7064e6220d55e7 ]

of_parse_phandle() returns a device_node with refcount incremented, which
the callee needs to call of_node_put() on when done. We should only call
of_node_put() when the property argument is provided though as otherwise
nothing has taken a reference on the node.

Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Link: https://lore.kernel.org/r/20240220115012.471689-4-peter.griffin@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/altera-sysmgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 5d3715a28b28e..dbe1009943718 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -110,7 +110,9 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 
 	dev = driver_find_device_by_of_node(&altr_sysmgr_driver.driver,
 					    (void *)sysmgr_np);
-	of_node_put(sysmgr_np);
+	if (property)
+		of_node_put(sysmgr_np);
+
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-- 
2.43.0


