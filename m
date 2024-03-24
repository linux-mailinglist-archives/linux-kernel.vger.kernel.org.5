Return-Path: <linux-kernel+bounces-114870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EA88891E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBF31F2E099
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E762CA43B;
	Mon, 25 Mar 2024 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3saeYix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF617177A89;
	Sun, 24 Mar 2024 23:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323514; cv=none; b=CGcWjO+R1K9gwxq4Ali1dhb6C1CmS8M2Ao/3+/HEn82wx1MFM6FvsYd0FsUEr42TON931fz0EVAAdiF6eZz+qGfgPH4aO9Z4RmmPr3w1TZ4gx+t8QvLJ7BOjL6ySBJTVQ27bLKewNNKYiqw2Ts1dxF5f1yzMwASI8e3JvFEEeRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323514; c=relaxed/simple;
	bh=IV4ylyCe+rLhJ/9f7eLC5kmhrVumZhOvn69bL0YEEUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2AF70pywm6YaC2AGnqpeBSFyxOzuLBqktF9vCeeQMYNKx8ozd3bQI/ywiYMCTrAMDk18zJtIg4obnwenjLRRPUfyiFB2E67ut9LpSJVLgVXAD8xcFD6dhB9ubn6Rtd34nPCpPt8RpNyk31uDN78b7UP2P3NDJAUPLxwTT6k6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3saeYix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D680C43390;
	Sun, 24 Mar 2024 23:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323513;
	bh=IV4ylyCe+rLhJ/9f7eLC5kmhrVumZhOvn69bL0YEEUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3saeYixZdXcpiQoS9aL4XqBS5XXQ5PvuOBjc2OMVbLs93cTni1YfoPonKvtYiaJX
	 qXlvo2Ws1oih4Z7m+q4vaEif2XpJR5TIHcpnP04hzzbkdTAqVa6mcMukMiNX1bMBkx
	 j9nmmJqyey+Su4/O8QMyhEXyxcBcXK+vaL5utoicz+bQ2r1SbO2pVhvrxX/BsJW21z
	 qD2ZgJN9zZAIzana3Le8YWaT1Tq0ouJdnoa4cSQudLPZVmk5NRWMLrbSzDZ2rNIGCS
	 zTIbovR8RDeT+H9F7hHkP4fDvCidh5buNeNJ+MPJZ0AuOFKg9UYTOmWiCf5JdgSU2g
	 K7rUTnGQHvcFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 220/317] mfd: syscon: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 19:33:20 -0400
Message-ID: <20240324233458.1352854-221-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 552b1861adad4..75c732ee9ed6e 100644
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


