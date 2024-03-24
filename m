Return-Path: <linux-kernel+bounces-115497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23256889BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBEF1F35A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30534233198;
	Mon, 25 Mar 2024 02:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir0JGfTe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A112AADB;
	Sun, 24 Mar 2024 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320930; cv=none; b=rEIt/72157QRhESCcfyOWOEU42JAQEQKqE/KmuawYW31zHqMNbAm1d0a0GyZXQYdhRvu45fn5oy5yyZzU/q+x0hFmDwnQLaAdkxSZ/IpzmwlSvyRWSMVSlEzylyiSQq4OKEvQaiYvMsVWhW3Bc9JkUUHi/1p67NCDR0Ir3sokcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320930; c=relaxed/simple;
	bh=6QT672QOnXtfVyI1jQ2OIfo7bcqP0hm5arRscEAGI0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gP2Bo53+45v4BPl9wuW8Yep7LfTixqHZX7mkI4IG1/ZDF0BMXW/gyOBBZfF71ZtjF+xxFjGsTXf2DSYsD5hae6/Ks4UZQuXR2sRNjAxJ0W82Wxf0ML+5T6kwbekIu+4E1tf9ZekN7O2DvZ7HgnvxUm0p2LgCEieCH0YMkPqzcNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir0JGfTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83225C433C7;
	Sun, 24 Mar 2024 22:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320929;
	bh=6QT672QOnXtfVyI1jQ2OIfo7bcqP0hm5arRscEAGI0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ir0JGfTeSy+9L90kA+xs9gqbanfOlhtDk2JuHJLIU2L8b2e4u5IhnCmyHW81uY7M/
	 E2dPOkQPyX1eorFl5GnOt94SuOeP7IaiW4kWhujEeKNPWGuHCXcSouXNSYzdl4qkKO
	 JgjoR97tD+qOh62ZRgyN/k2zAGIhSHFhi67sjNb9OCADV/PWu88U+wkzJOm54AOa9H
	 rpKiukhZhwbxkdMEGEKYCPs1b8VHYU10yh4MpL/cmry7BhVAyRm76n/PjnX8F7rkcg
	 jm96Kmiob8bLiFc03K87LszZrXk0pk/OetzJ97i4f8z9OqaWFRwbToUUjNEYmFoRr9
	 57C0GroPnDAhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 493/713] mfd: syscon: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 18:43:39 -0400
Message-ID: <20240324224720.1345309-494-sashal@kernel.org>
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


