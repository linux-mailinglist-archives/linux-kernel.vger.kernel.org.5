Return-Path: <linux-kernel+bounces-115132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66452888D58
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEC028D851
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007692FFFE8;
	Mon, 25 Mar 2024 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+xABXX6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652B229BE4;
	Sun, 24 Mar 2024 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324130; cv=none; b=p64Eb7ElusAC8DaGIKXktLzJjDHNxHJNROygF2RuzgElLRqgT9Iv+MUKi2FmdypAS84WPVg4hnFCu1+KZGVXiU9XGB533ixi0Lm0eXXm7/S9yJgAZWhP9nhACf4wZIviIrIeA7RA7FjJZgx0s2KHvBwc3Njwnypgx+1va73sc4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324130; c=relaxed/simple;
	bh=7MrEm1QVokqmLB43b20sXLc56N+gXSom4+OqZ57+/do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ToQSjpOjhujLOtOj7vxxC4JrYeuyT4O03qPCtldd72UV8abZmxG084goQDVo3xicGJ8yF8KtXc9rRAjFBvKfVIHysuqoD+4IjD5Ff/FHvnJn/W554VqV52DYhod5jhAd5Q9W20z2BSoutCq43cL/k1LNaFx6NS7p3Zp+ByjL54g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+xABXX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39EAC433C7;
	Sun, 24 Mar 2024 23:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324128;
	bh=7MrEm1QVokqmLB43b20sXLc56N+gXSom4+OqZ57+/do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+xABXX6FK98LaOJ0wMt1E81AP2zkRNrFTvMG9gJ4iZZlHzrOam3b95LyF0P1yhxC
	 KeOdkdnPTOZxFUeA5dqb4wgVL8fcOHWSHpIJlv9ijkU08NCSOQ+hb8fAcQkooAzI0/
	 aQgY2cNE96X7o1z4X1suY4E2rQcBtdEAqHNjQmiMnKGEawhz+u4II+DtXp1KGreWAf
	 z9a7L7R1dtENvp/yZVx9ZRQEkx//XKhGnPwFxwTHnfk7UxUcsgWGBm0DAnLfnyYaTR
	 5ZkEMt0QQZvuXfM2VFwzjy65IOR576ssnpDgTCWzk87O1g/4d2XUVPIokjENbBfEsO
	 qbMgs5xwEex/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 126/183] mfd: syscon: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 19:45:39 -0400
Message-ID: <20240324234638.1355609-127-sashal@kernel.org>
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
index 660723276481c..9ec90ce12f4d7 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -219,7 +219,9 @@ struct regmap *syscon_regmap_lookup_by_phandle(struct device_node *np,
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


