Return-Path: <linux-kernel+bounces-114327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42949888FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E786828DABC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A8216F857;
	Sun, 24 Mar 2024 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xzn032Nd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02D211D12;
	Sun, 24 Mar 2024 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321713; cv=none; b=E9cKs1dQPtinmGICXt2TtgT/b/CTAKpZ34LnqygKxrVPaegNPs3nwSnCrPVReaxgQbk5J+dcoEWB7YQWObZhCOOGQXoylt2m9j5au2AoTp0TF3sJAKmtFMomHw94IhCa65r7Qck7i27pCiyPxzQx/4SK74vWiZb8li14h1Tr2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321713; c=relaxed/simple;
	bh=IHQKUG65SlounuAeFf6b0YURdCZEgBFW9Po4H7Hhhfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vD9RKuJ1/p97PdlQ7LkCRrWxKzCeYkul/IXnCWQzpgk7f90bvvgn9BHkPIdfwP2lzQVAprBVSvrQx0F6QSmxOWFSS/VB1C11DFAd3RDU1VWEQ7HmCgW/6CkynAVh9UV7iVorKVJ9LG/YsXqI5kaFw3vW2lLrHlMEd5mu2rIzLdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xzn032Nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBBFC433F1;
	Sun, 24 Mar 2024 23:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321713;
	bh=IHQKUG65SlounuAeFf6b0YURdCZEgBFW9Po4H7Hhhfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xzn032NdD0z+o3XLYAI+/sApyvW3L2666JQPUAflzwu3m+vxMOidGlMfYyDiuZgSG
	 Eu1tmb230SsrE5QduBafR44syZeoEBarBmz5YTT+2zzP9A58vylafD83tTwdZLS36O
	 JbDOZvmxCvCrRcym2g3AqVpYAfCp4xah+g2u0mKkUsvO3isttpqOKZZBk6rsl14h5g
	 FUd26H0l/jwyifeL1Qa5S73yPtQsDneEYvxnm5Et1IAoLuJuxxtwkoKlzBmu6rTpMi
	 AZaLVv+fbBeCtNoVU0C85xVhygPOdElde38DvUYcXKbY4D+ewsF6VvnDW/H2rZIIpJ
	 i5o+tXKfB69CQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 442/638] mfd: altera-sysmgr: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 18:57:59 -0400
Message-ID: <20240324230116.1348576-443-sashal@kernel.org>
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
index 0e52bd2ebd74b..fb5f988e61f37 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -109,7 +109,9 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 
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


