Return-Path: <linux-kernel+bounces-116281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F162288A2FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83561B32325
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693363CB057;
	Mon, 25 Mar 2024 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qy1QBpp8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB0229BE2;
	Sun, 24 Mar 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324129; cv=none; b=MMud+AnCnj5b05XSfj46ZD8jPxyJ6VDmIPzPlZpmhacvC5DqjmDRgCpRJfQQLjLwIORziMP9PpoF7kMetAuJiilirMQ8EDERhgCumYjkubEIo1Hdal02x2AVeBycc9ZW2cnH2OwyoPjPT3tPrJq9K79OseiO5tqudq0sZ4g7i7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324129; c=relaxed/simple;
	bh=SivIxMd8V2PKFtctNm/0bRHV2kuANutFT4M8RmAb+n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1pFRyCqikH5tEO53bbAlw4cxz/BVSi4sbiru57j/E411rqwPZbBedRJ2Z1HM3uBc5Zc8x2ria/2Wl0F97aJ06XXhvYYaQU3Iphb0SUMkMM4qRt/4zjvdpn/s3lgSqf1VVQIffpqWNwKTvCBdD4N56zOWiH+3l2N91EEDNbR3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qy1QBpp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE64C433F1;
	Sun, 24 Mar 2024 23:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324129;
	bh=SivIxMd8V2PKFtctNm/0bRHV2kuANutFT4M8RmAb+n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qy1QBpp8Ng9LlbP2wAhzt/4EHQ1lHJIm9RmSf28TSpJ6JOF43be4zrPozOHFTIvi4
	 8ZiScElp93e5RsJ4hNzc7tQ6bn5wBSMrBRkmHTjYVl8ax5upqHOGYYizG0LcE16P2a
	 F8/8f6u81dR7p4JxkNkSNk5EdK1VG4u7wmRQXcex3JotVbQe4QjRUlko4b4PPPRrF5
	 2or3CUZfwLPOOKQtfmkwkxeAENWyGNP9OOSOyScgOQpUsjuAQSgcpjRiPdMcGChhDD
	 egAon85hFmFOugJ26ATVZH+9tdiofQot0DkgWKjRvIzogox9hZx/M8T/0VX9HH0cGz
	 YWsB4/eKq8JPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 127/183] mfd: altera-sysmgr: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 19:45:40 -0400
Message-ID: <20240324234638.1355609-128-sashal@kernel.org>
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
index d2a13a547a3ca..5610a5d9fad12 100644
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


