Return-Path: <linux-kernel+bounces-87447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF3386D486
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E57B22949
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEBC152DE6;
	Thu, 29 Feb 2024 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwfMsBLL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77ED152DF7;
	Thu, 29 Feb 2024 20:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239080; cv=none; b=AXfbYGOlexOCybIya6K5VqssIpVnxRTxPLNOrqLZYlVeu7WVG/EALvWKuLBC4eWydcEVTTUsuDe1dPqJH23oJ4Eg5aJQnR4/t+wSWN5cOLjoA0T4/IIiuTpSw532R7QT3NNRg9BKZGOaoYg+GE1YPElMCRFjHp8HaiJhtxFn8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239080; c=relaxed/simple;
	bh=231kPemi6KhrEE+kXp4dfXwlWja7tvS8rmabG6VryFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHQ7AYKYEbWeozazQ8BGLL3cUNANzPVzSfIbS2Mgl9JAqXvwnz2JNc/QAqprE7iG7TBXjIxi6x1/8fV8J5b7cyVGFhdZ1WoAfwFQnHA0cT2y8Id2g4ooaf0ZPJRtYU39VfgHrrQAJ0IStLy3HatIRjAZHzhyypabg26yuAAVIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwfMsBLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85002C43390;
	Thu, 29 Feb 2024 20:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239079;
	bh=231kPemi6KhrEE+kXp4dfXwlWja7tvS8rmabG6VryFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwfMsBLLcY7RdFXMFpni2VbzTOYQgOnW02DSslmYgIR0+IAqX0U/jDIDiuiUSTS10
	 1JeSA1NyH7QM5DMrpSTMqa+SimA5UwD5aRrgj5yjbMlSgKqEU80pmM7QwMh4qS+JOZ
	 mmjkt/HtbYUZI7j25HgQWYG2QPNE+aVj12UVbrqcp62xtqW67ZwXILUIMIzivx0O6F
	 tEHJ+Hgwz8Lyxz9D+C2kdfNZ6pxmmeWaU1UgMotIBdfNjHjDn545QyHTZ65P8C3Z3I
	 u2aKI5kdcH9Yvy6GAI1k/I7pxFzPO2RSFzyWw9kCcHC2QAgkEj9zw+3bJxreFe9atV
	 rkxY12LLDvrUQ==
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
Subject: [PATCH AUTOSEL 6.7 14/24] cxl/region: Allow out of order assembly of autodiscovered regions
Date: Thu, 29 Feb 2024 15:36:54 -0500
Message-ID: <20240229203729.2860356-14-sashal@kernel.org>
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
index 764998fe03edc..8f0a2507ddecf 100644
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


