Return-Path: <linux-kernel+bounces-145496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6928A56ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6521C21E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D50823B8;
	Mon, 15 Apr 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pjcCXIxo"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE427F7DA;
	Mon, 15 Apr 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196848; cv=none; b=BfHpo3c3psfWf2Ifc2sXku4YK6F3YYRLHiURtlOytWYUZRrZhcGwsMW44vDDI7SQZH9g3CjSGuk4AD5XSjI3YeLEMOZmnlVSwWW8F2wTVbhF5Qvc/+lAZXMMu8vZghmauGg41diqq1qxWk5lzpryemXhp4Db9gVjv8czfUAIr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196848; c=relaxed/simple;
	bh=q5d8K34P4d8eJgHgXhElAdn8Ywho6XrfAYskz43O1Ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L2AomlbqOT7rjWyeqmr1A5La3D4TV8XCKVDY4RtZih0cNYAsuzo2T1OjDv4Zz6dszolA2dRI9Fa6sYy8xWkAdrKbrKwQeTl0D4KYlJsNV+dhDd0dvNNYPDjuELRWDHmLWEwjY94w25EGDrqZIQOII3bdaOeJcjYjueDjO1VpcbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pjcCXIxo; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 95B12720;
	Mon, 15 Apr 2024 17:59:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713196797;
	bh=q5d8K34P4d8eJgHgXhElAdn8Ywho6XrfAYskz43O1Ow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pjcCXIxogHHjn9WYkB3L2LatIOWVFWC5Vk0NGyhmggt4DtryxMwPFe0JSCVQrTPZ4
	 G4IU3ZJJzdaGpET6ydeZrgBxdBuvJEk8qh4DWdU0oFUlEfy1XiO1nHOW2g6U8K24MT
	 0JY1BSD+r4xZSbkhjU47zbEZmPjM8YKZ870/FMEA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 15 Apr 2024 19:00:23 +0300
Subject: [PATCH RFC 1/2] pmdomain: ti-sci: Fix duplicate PD referrals
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-ti-sci-pd-v1-1-a0e56b8ad897@ideasonboard.com>
References: <20240415-ti-sci-pd-v1-0-a0e56b8ad897@ideasonboard.com>
In-Reply-To: <20240415-ti-sci-pd-v1-0-a0e56b8ad897@ideasonboard.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, 
 J Keerthy <j-keerthy@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Santosh Shilimkar <santosh.shilimkar@oracle.com>, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=q5d8K34P4d8eJgHgXhElAdn8Ywho6XrfAYskz43O1Ow=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmHU8own3DVGbDDPyww4s5hSdGSKy5e80b+VNF6
 Ndomlg9oKqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZh1PKAAKCRD6PaqMvJYe
 9QP1D/4x8fjg/suseu5F8fchpgjbsg7LM0RyS44ePFszB4DYYxMZczYq58Ek9bP07U/sC4/bKCT
 XAOFf0nxkuC3VlnJGdW7Hrg6twZnfsjMZRqB6oQGJrM8etmEWwEwLA7wpfTLeb1tXGep6yjnc9i
 Z+xAdIF9gpjoe74gKCgaYNi4JNmgTdZ5xqBnqxIiltqWXxXLi4aREdQikwnOX+nGzj8J3LFEgmL
 QzGDcSy9VV2L0JtRXka90NyuCjdtwCE3LNyRvZlbM9tz/QhDfKc3nWdRus8wXWKI2tmS69FjwLX
 gcK2IYld6hgdMAVmiiR6qaSadkkYrZsJOfEtFEJEG2gFtoiRAiKaU2KaSe/DZi2Rcut5Cbw/mLh
 jwAgnzBQ6t59mrjgdq/fTjMAF43PKF9CT3qj1j9+5JVrFuv/gW7/ef2LNtyOFrMUlZ/+c1vNml6
 VU8yrskYhF2a8hW5Fdkl0lMKRfleRooJVz7KRxI9QF+TI/xgqeO+gj7gv9+sQb3kCqWub2PxAvF
 xN2tlNApeDG3ZPpbDBULXgU1LrZzPZrFz3Gb/lLs0zU86PFMwyTxK3F06Kxhy69l1xXFdFqpFNN
 b3dUsaAhoDTzWk8uLRuLWJEHrvYv0SOIRlTqRHLEahGybOP1q4AjQcFyuwQPe6HsQEP2naU4gEy
 uSEg4ZQ36OoOXxA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

When the dts file has multiple referrers to a single PD (e.g.
simple-framebuffer and dss nodes both point to the DSS power-domain) the
ti-sci driver will create two power domains, both with the same ID, and
that will cause problems as one of the power domains will hide the other
one.

Fix this checking if a PD with the ID has already been created, and only
create a PD for new IDs.

Fixes: efa5c01cd7ee ("soc: ti: ti_sci_pm_domains: switch to use multiple genpds instead of one")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 9dddf227a3a6..1510d5ddae3d 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -114,6 +114,18 @@ static const struct of_device_id ti_sci_pm_domain_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, ti_sci_pm_domain_matches);
 
+static bool ti_sci_pm_idx_exists(struct ti_sci_genpd_provider *pd_provider, u32 idx)
+{
+	struct ti_sci_pm_domain *pd;
+
+	list_for_each_entry(pd, &pd_provider->pd_list, node) {
+		if (pd->idx == idx)
+			return true;
+	}
+
+	return false;
+}
+
 static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -149,8 +161,14 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				break;
 
 			if (args.args_count >= 1 && args.np == dev->of_node) {
-				if (args.args[0] > max_id)
+				if (args.args[0] > max_id) {
 					max_id = args.args[0];
+				} else {
+					if (ti_sci_pm_idx_exists(pd_provider, args.args[0])) {
+						index++;
+						continue;
+					}
+				}
 
 				pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 				if (!pd) {

-- 
2.34.1


