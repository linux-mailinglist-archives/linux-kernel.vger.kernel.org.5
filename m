Return-Path: <linux-kernel+bounces-116189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886C889A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59241C32D85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3EB22B693;
	Mon, 25 Mar 2024 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkJSDXcK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD824284529;
	Sun, 24 Mar 2024 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323787; cv=none; b=isoy2EFG5gLxtme4TCK0Q/pZt22On/H9HdGzKl/XerID8ZeaftqxTrRtPZKnch2hzdhzSRnG+Ke0igSURD05y6yoU+4FuWuPjE7nsVy+h01/Ix42EckUuNQNGAyJ50oCDrkXHmS5s1IGYFF4rMaWF9MjIinafTni0M4CwxDv71E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323787; c=relaxed/simple;
	bh=xzg6Cl94C/B0zCZhufvQBgehOCoHAT1Tchoclmig22g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiVkBpX1EXBCWTEhIzi7X+evtfS7uFXi7i/IMjkHVMOawzCWVChVqLf6YwT8vwjeS+m6EpLFWnLJbbjw+rLWUA8J91Qz4z8nbv4X5o1GIgJgKjEdSTIdWlIl33ooOC1L4ME2Pv+i4BZQ9Z8yty7xdREkFoaxKGL0YKo6SIFN3x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkJSDXcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC38C43394;
	Sun, 24 Mar 2024 23:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323787;
	bh=xzg6Cl94C/B0zCZhufvQBgehOCoHAT1Tchoclmig22g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkJSDXcKx882l53HutnOB5ctUCoHSakeLrW/YoHfIZyEx1KugVS1DGBswEVWBsL2+
	 QOAsg8DE/3h9xWapfYxwAyJ28GDYJKN343zmVrK1kALDeX0/PQg0O8gYLQCMzz0lPh
	 1niPhSHGjal77evERboPchm1tpOB1HcFrsgCVzbcF3Son+yoYbnyU2CG676nl8raGB
	 8/EOE6dRmKlI0eyW2CM6rndBjZ36Fv0JsbAO2bfhAXi00l8DdvmAUEKQxw9u5J/ppT
	 7w6DOFrqM6u5g1U/aQN2lwhJDbEYTyZa9YWKke6PZjPMUjmEYylUlKGyCgupUZ6HpI
	 B5dHcKA6wrW0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 164/238] mfd: altera-sysmgr: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 19:39:12 -0400
Message-ID: <20240324234027.1354210-165-sashal@kernel.org>
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
index 591b300d90953..59efe7d5dcaa9 100644
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


