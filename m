Return-Path: <linux-kernel+bounces-114029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318748887FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62AC01C27042
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E241414A09A;
	Sun, 24 Mar 2024 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I069xcfC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4212FB38;
	Sun, 24 Mar 2024 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321310; cv=none; b=hEhIHvrdHCjG0oxd0QSnLEwnXeKUnCiELfXJjHVG48mKoSSmXM5IkLRWBlSfySTRPCg3d2YqOIv2iC01AeJ0n5pUo4HN2my5HgAd5YgRMZTVnpQtbQ0nBfliNgWr4Bb7irJ5hDzsK+UxVh/KTma11lKfFqbJbg9RfjDiAWCOeBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321310; c=relaxed/simple;
	bh=qB4HappnWK8PlV2MzfcXsXtLknPnzx6f5UGJ670ViNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlWd37l5G9jRn9kLw614NawYvFX0L6JRkxgVPr042MY70v9iizSgmV9R64avl+fN2u0agG0Oy4O6yt1ilZ8syTwfom012Z64j9hJLOunKPzdnniRbFp/ix/hsHhymPK1DTyMPzz+BSpCoVskar4uyVxTm4UFpotv80gY6Mc8HX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I069xcfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3F5C43390;
	Sun, 24 Mar 2024 23:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321309;
	bh=qB4HappnWK8PlV2MzfcXsXtLknPnzx6f5UGJ670ViNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I069xcfCcZ5neASeNm9qjOctdNAtlna/1Ho2ow5PYK2ubM1lbAB+pPAaiFPouIyZi
	 5QLXsIJvJXN8jmtF2toAyadBTD6bKAqcM9MggLx74g8b+LrSADjZQRUctEuS3q9Au5
	 DN+ghAj/Guok7yeEHPnAGEFn56cTE3gbcm4KpMA6GD/Wu55IEUicaOZt/KwsKz+Ix5
	 bkphwN8nnsLqt7ODthFgMULH2euZ1sX0s1OOwXIvb9TURVOOmo88gTLHfvWvP1nJTe
	 hKbZpMIx3scnrcGbFCHVJ1BvCQwEbjlU2Sken0NfIq/xmEfwV8aksUCUet3sNsLOxM
	 FLbIw9l6YrqUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 032/638] cxl/region: Handle endpoint decoders in cxl_region_find_decoder()
Date: Sun, 24 Mar 2024 18:51:09 -0400
Message-ID: <20240324230116.1348576-33-sashal@kernel.org>
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

From: Alison Schofield <alison.schofield@intel.com>

[ Upstream commit 453a7fde8031a5192ed2f9646ad048c1a5e930dc ]

In preparation for adding a new caller of cxl_region_find_decoders()
teach it to find a decoder from a cxl_endpoint_decoder structure.

Combining switch and endpoint decoder lookup in one function prevents
code duplication in call sites.

Update the existing caller.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Link: https://lore.kernel.org/r/79ae6d72978ef9f3ceec9722e1cb793820553c8e.1706736863.git.alison.schofield@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/region.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 6ebd12f7970bc..a3d82ef5599e8 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -729,12 +729,17 @@ static int match_auto_decoder(struct device *dev, void *data)
 	return 0;
 }
 
-static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
-						   struct cxl_region *cxlr)
+static struct cxl_decoder *
+cxl_region_find_decoder(struct cxl_port *port,
+			struct cxl_endpoint_decoder *cxled,
+			struct cxl_region *cxlr)
 {
 	struct device *dev;
 	int id = 0;
 
+	if (port == cxled_to_port(cxled))
+		return &cxled->cxld;
+
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
@@ -852,10 +857,7 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 {
 	struct cxl_decoder *cxld;
 
-	if (port == cxled_to_port(cxled))
-		cxld = &cxled->cxld;
-	else
-		cxld = cxl_region_find_decoder(port, cxlr);
+	cxld = cxl_region_find_decoder(port, cxled, cxlr);
 	if (!cxld) {
 		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
 			dev_name(&port->dev));
-- 
2.43.0


