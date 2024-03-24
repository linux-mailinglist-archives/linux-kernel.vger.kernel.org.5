Return-Path: <linux-kernel+bounces-115282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B3889395
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976C8292508
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9FB15E80A;
	Mon, 25 Mar 2024 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj9q6CX5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D0B482D0;
	Sun, 24 Mar 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320478; cv=none; b=trNdzeUL195I7i0mKIUA9csAlzLuijAlaPD7PP9F6Fs3/rmXY2CZHUOaYuO2IipOMKBlc8BLDfDTQ/oFwp3PSj8gdp/DNvXRoUaMPGmzQgn8+HR2NSXc4RGza6INIzepsF3LiP8h/ERTscqcLX9HdIqs18mNChEISOJqp9uH6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320478; c=relaxed/simple;
	bh=PkKaGziWURDv/ulaxnHD5Dgsz+znc2l24h5KSkIa8qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmsHbmhSC8hD30Ywj9g1ZcSE99RLbLREpLy9szfNomE+AgOOYO5bTnbw0ivXffCVbKV0n5cUiPApqWe4oImeC6QwZFl82B2fLYKajifqYT9iJx+BWIOixUh5OXgNRUXljXMeqv+Z9sDPp+5WVoLPGRtXF4Ec9xw90AfWvay9ft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj9q6CX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FF5C43394;
	Sun, 24 Mar 2024 22:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320478;
	bh=PkKaGziWURDv/ulaxnHD5Dgsz+znc2l24h5KSkIa8qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gj9q6CX5e4hS0zw2+Iz8Vha903eraQ21UrFLM4t3P0iQTYycZnq2wAAacDmDXNKlB
	 seaZca4SQvikY1MwmxNfPmHM1j7PeTTJt/xap0FZ7bNAxNNDy2DfB6xjM30d9x8Cuk
	 HczitB7OW1XkeKrSz6VIFHuKC+ALYo7CHg7Tjd39qy7H4PRzb9xGTwiUQPBTcq/gJO
	 dRkBBvnTGH/MJYAT9GMgyXKPPyhZCiJGHgEqslyhcuEhabqXtBsLbNw8R7UQ/j1tUD
	 LE5T8fnbT9I6HlLBdXZW7MjcnxtlR9cL+zRpDewqIEsXU3Kvz1fs3e+/YjiP5ZNKjl
	 hpRSndH7shDFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 037/713] cxl/region: Handle endpoint decoders in cxl_region_find_decoder()
Date: Sun, 24 Mar 2024 18:36:03 -0400
Message-ID: <20240324224720.1345309-38-sashal@kernel.org>
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
index 7bb656237fa0c..764998fe03edc 100644
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


