Return-Path: <linux-kernel+bounces-139097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A478589FE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E691C219D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A66A17BB26;
	Wed, 10 Apr 2024 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVkRjWbV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CC017BB10
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770020; cv=none; b=b++Urhd1dT6QZapp7C9Ke29mVd+HcRuVrnrI4V0uI2e+FsQk118WLEd9KklNARA+RL+4U+DkKBvqDsMmeZxOWkRhrlgz5HAFy23vuQHmCJl+uo0Hd0fIhare8jAzfc9Cw0kbyTpLxB03GXAUwclbexofyEtPbVVgFt2o3VWK60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770020; c=relaxed/simple;
	bh=PyToWV/okY5b6RHThwqWggcm0DKW3OA4KIKTaosbhUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E8/JDl/rnBapOHC8CeEKbamQpPR8kC9ahqfxowDKpASQlDIeq7J2OP3ZfI1hdeVhSOtTdlkQPjy0TPhCZxwaDYMvNnuPHp9pWI4EDEEYkancKim6FZ2DSCoGbo2jNvyZSjaDOJI/GWQrFdHtrOrT3ofTaROuwOzZAnU0Hj3Uu6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVkRjWbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A19C433F1;
	Wed, 10 Apr 2024 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712770020;
	bh=PyToWV/okY5b6RHThwqWggcm0DKW3OA4KIKTaosbhUc=;
	h=From:To:Cc:Subject:Date:From;
	b=CVkRjWbVMx1VhxmiwdzkgS/29EysYmq/NAhzg6MuCDJmZmtvuB5ZM2BHbGmgANqVW
	 8naqltGLSkvunA54vsXUV9qoX8VNmW1wnquntHJRZ4y98UCvg86RMB8i+JUSkc6xZk
	 x+Jh4Drp20aF4riEjJDfFe1hSeVHU9bPqDJ+r5RwtfeybplZoxWt6X05vJXSKmKrCh
	 LVwaKDwq6s941Leml35idQCbiIgPQ1W4vIQwOP6ehfCAFpkyvIbx6bc+UG17naw5Ve
	 v7XplMu2HBeQH3yVx6YYXjGdAWiW6oOIcjUjVboFEYmZdunXJ0hxtATu5PamqzJ5Zn
	 xbCiX7uDtGQLQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] bus: brcmstb_gisb: fix module autoloading
Date: Wed, 10 Apr 2024 19:26:54 +0200
Message-Id: <20240410172654.255525-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/bus/brcmstb_gisb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 65ae758f3194..ee29162da4ee 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -410,6 +410,7 @@ static const struct of_device_id brcmstb_gisb_arb_of_match[] = {
 	{ .compatible = "brcm,bcm74165-gisb-arb", .data = gisb_offsets_bcm74165 },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, brcmstb_gisb_arb_of_match);
 
 static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 {
-- 
2.34.1


