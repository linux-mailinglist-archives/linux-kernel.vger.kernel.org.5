Return-Path: <linux-kernel+bounces-87471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A0886D4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA661C220D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1BB15E05D;
	Thu, 29 Feb 2024 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM0OWNOI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF5E15E02C;
	Thu, 29 Feb 2024 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239200; cv=none; b=CsLgZ0yTxbPckY0LODkwD7S3tsEIdKNrhYlJEJObNxroDljCzuRBnrtQ0FaEeJzKCJ85gq7gyPRVsSvps008HJmRV4W1TNxJQkcMWe5aZJWuGIElZCr1ny1DK1se2HKsFn0zmSwCxA9WZzuXDK/Rx9RhvQLUvwlhK39m6i4sBs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239200; c=relaxed/simple;
	bh=qB4HappnWK8PlV2MzfcXsXtLknPnzx6f5UGJ670ViNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEV5asf5X9PBtemtYyhmErhIw2GddKWQpzP+H0iQMl6j8FVek7PLUu+uniD0vI2molSlLV5pQGsfX72U2ZfdMGGRfcGuPnAJYp7GodFLx4mIQmnLOkSB8oPnf9RmGTHBlAOLcck44R/j/LhJ2BBPqjNCLd40NqDDcHKpFZtoL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hM0OWNOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2833C433C7;
	Thu, 29 Feb 2024 20:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239200;
	bh=qB4HappnWK8PlV2MzfcXsXtLknPnzx6f5UGJ670ViNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hM0OWNOIgcJmso6bKk+AQNSQcqhbBb2N0IGB0zvDOO9uhjTb2H3juMNc+Ilq0yVAJ
	 wiD9BcST8SIdPQtbLDrLF+62919QlZ9OgwJXVT2gTQ2kTkWoTUxy/MFpxJba1GK4Lb
	 FmLAez5qQUBqEAQB1tNDkFIhq3K/d8474MYvbUjJW1pa5+GuN/+ZceRu3/4o3Cf4Z9
	 1+JjY5ML/X0B8CW1ryWhqMju3Z67CIY1WK241KJL9szN5ZjqMfRA+3NoaZ5WGxWSHz
	 Cky66N7GkmLF/9FgArbdKm+6D/Cz8SoK97/gI2t8svlcAuysuf3CaD7wBH1qYz9DMv
	 1y1y4kXCE/m2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	jim.harris@samsung.com,
	linux-cxl@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 12/22] cxl/region: Handle endpoint decoders in cxl_region_find_decoder()
Date: Thu, 29 Feb 2024 15:39:05 -0500
Message-ID: <20240229203933.2861006-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203933.2861006-1-sashal@kernel.org>
References: <20240229203933.2861006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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


