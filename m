Return-Path: <linux-kernel+bounces-114030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45DB8887FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649E1B24BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D822BBF0;
	Sun, 24 Mar 2024 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDZBTvsn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86D21FC0E0;
	Sun, 24 Mar 2024 23:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321311; cv=none; b=An2BMUhYvB4S+Ji1ZRhZN1wZXsSk35iaFR7PMlWX2LJAewMNmNM6trLWNLAOKQsNe5rOXdvaKj1TyFQg7v1p4JCj2g+bKLmUig5L+zA+nGlCft+utSWZJBy21jlF2PDsbivDAu9wbawKk4bzjElkI3uhaCgy06ih5OPc4BGi35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321311; c=relaxed/simple;
	bh=z7qh1e8vbDVQ4yzcCgshluBRHXqVwd2S32PdSJRIBvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSioLnOVqUHDC1KX2zy6tmegAzwzXvT3LTZyG219vB/0OW8Qi++xCLcCIWwFyJMek0WIvREwd3jArEouudv4ypwc4Rb5yreTSr5Dsq7ongcah5kou4ADTjOPqJhKM+6kPurO4YTpwpY45Sj4DYBlQHFWa3Qe/ko8R349QC2Vzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDZBTvsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BDDC43394;
	Sun, 24 Mar 2024 23:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321310;
	bh=z7qh1e8vbDVQ4yzcCgshluBRHXqVwd2S32PdSJRIBvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDZBTvsnf0rVlsKX/E7BvYYTYBMEtdkCAP3ITHiVM1mAjPTmYuy82n/QygRV49ERV
	 FK1qJsMxst496z1tlgEuVRmCCmCdwijXgYTSanLYoJxhA0yolGpkTrkvT7xX/2Jb7W
	 KMdsa3W1IrTcsMKeaVfBDeE0Iomv0dOF+8ltA+UhIhrISntp6LJOkk5Q2SL1ElD6FG
	 71X0/54hlFUChmZBXTMUgRdB8JATNfghlStslu4enCcPPJb3uUHSFxQGbWA6ergb1H
	 jqHK6PqdgcIzdnp0sPL5C4iUy+WU7m8JF0/32+JXg4v55L2qmWw4W4myuBpQ+VEKgq
	 a1pKPE+0rjQRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 033/638] cxl/region: Allow out of order assembly of autodiscovered regions
Date: Sun, 24 Mar 2024 18:51:10 -0400
Message-ID: <20240324230116.1348576-34-sashal@kernel.org>
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


