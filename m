Return-Path: <linux-kernel+bounces-114328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A277F888FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5229A28F071
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8CF16F85A;
	Sun, 24 Mar 2024 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPdL9zuE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D4211D14;
	Sun, 24 Mar 2024 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321713; cv=none; b=OYe2lvS5/VDs8rPJxNSAaxTjloJGjZ5dQMUNARUIf6u37sAg/VGfFbRqQW6Uepsw2jyInRKk+6t0qGBfxFc/z568H0NbwS0XeeGFwadVI1vJmjjuAi4uaIzw2tdg9i5S2nqZJpVBRyVEZK3p80kBAoeM/AfjmR6mptQnjXqG+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321713; c=relaxed/simple;
	bh=6QT672QOnXtfVyI1jQ2OIfo7bcqP0hm5arRscEAGI0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwD4PZfOVBxWmnBxSc98BKXDDLN5+fiPUJY2ksblKLZ+Z74oo+jwXbuAdYlnkUR+WVoKzgOGSchgjljjDmiQ6+bAxbZtrW1OW7oFHyYVhsJ3lqZRRKEeY6rO8BPePF6duml+i9rg78m1Z01vLIAt+309ETaWkcLjyyhyKgfvGDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPdL9zuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8697C433C7;
	Sun, 24 Mar 2024 23:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321712;
	bh=6QT672QOnXtfVyI1jQ2OIfo7bcqP0hm5arRscEAGI0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPdL9zuEMafeJaKDvZjqbis89fqyrTW9D67TKYIfKVs8/tCtoCDPoV0xqOURxgsTv
	 suSfCAiSP/ve+F7FQnILiOlk3zDkKsOh9h+7I2j0zXsL01zdFFcdazmsv2fDap+tcX
	 LrAh+Mq94mVbCWi2pIWurQiXklF8KWWzF8cdWy/OXxBjkmhHF3+HKrhCP37/uGMJq2
	 OR/e7FqKmcmkdLLN129mZNkKF60hpazsiECE0eZL5v4xa0TFOkGACu5ofbU3Uqzqye
	 MM2/SEQdDurSdmH0+Ecq9NmuZyOoJTh8pIzulcPf7LbFB6sPaaizNBd/1cW1NvEPPX
	 xPJwpilULrQeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 441/638] mfd: syscon: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 18:57:58 -0400
Message-ID: <20240324230116.1348576-442-sashal@kernel.org>
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


