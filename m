Return-Path: <linux-kernel+bounces-87446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277E486D483
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F782854AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F41152DE0;
	Thu, 29 Feb 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upev+3iq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F0151CF4;
	Thu, 29 Feb 2024 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239076; cv=none; b=rxW7Q/1V1GUE53vJL6OnUd1tBMGePkotikLIWk/rkOJUQOOj/sRZR9brZqFl4JMKfWG9x65OB8Pu1+qBr0LVz8bQAj9dd44W9VHxW5IUL63Ipveniv+laWKbiHBrNJgMPVH4OC9Lzkpaf7lm4EhaZZowL4UtDiqmJs0BCmqJTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239076; c=relaxed/simple;
	bh=PkKaGziWURDv/ulaxnHD5Dgsz+znc2l24h5KSkIa8qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpEpZq4gyb2e2gI2PLR5WL6klYk9Z9sXzrhUYxXbS3nZXqEBeb1PbQ1JJrx7rPOCNSgPkuYhysh5+1vscWI7JbZMxrOmpQfxVc2ONcYA9WeokApzOoEF8Vts3FGyX/J73OwPGe/aIfUO0CZf7x6tPIUSjeWKuF4P4jt/IVqbEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upev+3iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06CCC433A6;
	Thu, 29 Feb 2024 20:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239076;
	bh=PkKaGziWURDv/ulaxnHD5Dgsz+znc2l24h5KSkIa8qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=upev+3iqxv85Xumhf1v4amUTmzJaRBYDkWJgVL28LKtWrNvWZo4ZJQF1b6du4Albi
	 ricE+rqfa2KRPaK8piC/TxFLi05OoyV+9+orx2eM3mf/M8JkMmR8en628s8RiZi42J
	 Etf6IxMysqeMqs1tNkNTGLwEFNHw/pamDgGbVllp+tbpjNjKUo0HR97fb0AQOx3Svs
	 KPx//eKfc95rQ25tJ90YIk7gW+eCEkpLoRrvjJdJqnPofzjsFcQjXCUfzBtd3ERcD+
	 Fg8rKwXND2E0QLli7j/IpPD0cPAsAS+EkGTI19DZ8RZe2MpttTEbeQOzJNpdsltFTM
	 HIE1ZhT2k+yaw==
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
Subject: [PATCH AUTOSEL 6.7 13/24] cxl/region: Handle endpoint decoders in cxl_region_find_decoder()
Date: Thu, 29 Feb 2024 15:36:53 -0500
Message-ID: <20240229203729.2860356-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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


