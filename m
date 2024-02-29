Return-Path: <linux-kernel+bounces-87472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4BA86D4D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C43A4B22AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3013B14402C;
	Thu, 29 Feb 2024 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrnzslHX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CF415E5C7;
	Thu, 29 Feb 2024 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239203; cv=none; b=rwh2rqrORhgri/mU6AV57s3Jd3zMkPQfCFCNFeXK2Qq4b/eWt+4TpStV9M8WxHJiG8GJf1GwDQwtjypgR9zBi9ZHKCk2ExXwqG2j8uf1zZIWd2qjV/1bTilsXH7iH0a0Hanqs5XExgKO6EI5plh5hSmG/kFpSejt9g4fOFQkQFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239203; c=relaxed/simple;
	bh=z7qh1e8vbDVQ4yzcCgshluBRHXqVwd2S32PdSJRIBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb5ubABpR06uGdatUJgAe29HP3W5JU+mnPXp46xTVmWmb2bzyheuUZv9Vg8DIU7Sff9pdbSycTpCxkBRpvs3hCRScnwohmcRLEnzd0W447Bpug1G2YnHtReZP4yQ/6vTdRwIk3/XXrBsjZXeNGXfFmS/FkyOD6CBiSG7xhhuOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrnzslHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE28C433C7;
	Thu, 29 Feb 2024 20:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239203;
	bh=z7qh1e8vbDVQ4yzcCgshluBRHXqVwd2S32PdSJRIBvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mrnzslHXY7KxmMF3JSlEXTJGr5jpPpUjDOnjOLY84G7JVybY6rjcJkSebGaxvMzsV
	 0JpB+JZ6ya1dmuBBb9S3GVglIRQ39aq0ZKwqyd/JUJ8YghQmHhxcoeeKAJ7yqjdBl2
	 /uGOxil6eHmbgVf2GsKdv+RJO+JEvTUAQzO4x4q1+trO9zFaW2wn2Jkf36BheqEvIc
	 nDMU53EUZMnQKdH4sFb20FgqfhB2U0XwxntbcOjHCCrEU9oveLU7gnCBmgmSdkqrjv
	 21ikhnJzq/XTYx69f0b2L7doMwBPZaShOJa8nWreI5+MehGJlOZ4hQhTmzUUTcXdXh
	 dzBJDFbDgFn7A==
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
Subject: [PATCH AUTOSEL 6.6 13/22] cxl/region: Allow out of order assembly of autodiscovered regions
Date: Thu, 29 Feb 2024 15:39:06 -0500
Message-ID: <20240229203933.2861006-13-sashal@kernel.org>
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

[ Upstream commit cb66b1d60c283bb340a2fc19deff7de8acea74b1 ]

Autodiscovered regions can fail to assemble if they are not discovered
in HPA decode order. The user will see failure messages like:

[] cxl region0: endpoint5: HPA order violation region1
[] cxl region0: endpoint5: failed to allocate region reference

The check that is causing the failure helps the CXL driver enforce
a CXL spec mandate that decoders be committed in HPA order. The
check is needless for autodiscovered regions since their decoders
are already programmed. Trying to enforce order in the assembly of
these regions is useless because they are assembled once all their
member endpoints arrive, and there is no guarantee on the order in
which endpoints are discovered during probe.

Keep the existing check, but for autodiscovered regions, allow the
out of order assembly after a sanity check that the lesser numbered
decoder has the lesser HPA starting address.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Wonjae Lee <wj28.lee@samsung.com>
Link: https://lore.kernel.org/r/3dec69ee97524ab229a20c6739272c3000b18408.1706736863.git.alison.schofield@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/region.c | 48 +++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a3d82ef5599e8..e2a82ee4ff0cf 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -757,8 +757,31 @@ cxl_region_find_decoder(struct cxl_port *port,
 	return to_cxl_decoder(dev);
 }
 
-static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
-					       struct cxl_region *cxlr)
+static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
+			  struct cxl_decoder *cxld)
+{
+	struct cxl_region_ref *rr = cxl_rr_load(port, cxlr_iter);
+	struct cxl_decoder *cxld_iter = rr->decoder;
+
+	/*
+	 * Allow the out of order assembly of auto-discovered regions.
+	 * Per CXL Spec 3.1 8.2.4.20.12 software must commit decoders
+	 * in HPA order. Confirm that the decoder with the lesser HPA
+	 * starting address has the lesser id.
+	 */
+	dev_dbg(&cxld->dev, "check for HPA violation %s:%d < %s:%d\n",
+		dev_name(&cxld->dev), cxld->id,
+		dev_name(&cxld_iter->dev), cxld_iter->id);
+
+	if (cxld_iter->id > cxld->id)
+		return true;
+
+	return false;
+}
+
+static struct cxl_region_ref *
+alloc_region_ref(struct cxl_port *port, struct cxl_region *cxlr,
+		 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_region_ref *cxl_rr, *iter;
@@ -768,16 +791,21 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
 	xa_for_each(&port->regions, index, iter) {
 		struct cxl_region_params *ip = &iter->region->params;
 
-		if (!ip->res)
+		if (!ip->res || ip->res->start < p->res->start)
 			continue;
 
-		if (ip->res->start > p->res->start) {
-			dev_dbg(&cxlr->dev,
-				"%s: HPA order violation %s:%pr vs %pr\n",
-				dev_name(&port->dev),
-				dev_name(&iter->region->dev), ip->res, p->res);
-			return ERR_PTR(-EBUSY);
+		if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
+			struct cxl_decoder *cxld;
+
+			cxld = cxl_region_find_decoder(port, cxled, cxlr);
+			if (auto_order_ok(port, iter->region, cxld))
+				continue;
 		}
+		dev_dbg(&cxlr->dev, "%s: HPA order violation %s:%pr vs %pr\n",
+			dev_name(&port->dev),
+			dev_name(&iter->region->dev), ip->res, p->res);
+
+		return ERR_PTR(-EBUSY);
 	}
 
 	cxl_rr = kzalloc(sizeof(*cxl_rr), GFP_KERNEL);
@@ -954,7 +982,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 			nr_targets_inc = true;
 		}
 	} else {
-		cxl_rr = alloc_region_ref(port, cxlr);
+		cxl_rr = alloc_region_ref(port, cxlr, cxled);
 		if (IS_ERR(cxl_rr)) {
 			dev_dbg(&cxlr->dev,
 				"%s: failed to allocate region reference\n",
-- 
2.43.0


