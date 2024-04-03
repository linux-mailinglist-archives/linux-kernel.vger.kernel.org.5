Return-Path: <linux-kernel+bounces-129645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D28896DBB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B3C1C25CA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C9F1411F8;
	Wed,  3 Apr 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8OpL00w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74057317F;
	Wed,  3 Apr 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142646; cv=none; b=Ilnii5JTbp4IZEAwYdEKXL40jP6+pXFyY5JeUEJvlv0jaQR++3r+J7qfRtlIwM9GzJDj/xu3+jUeDVXyHxUskaslcsZbUvVC6IxBYHSMDHS0n974k+A+e5IZtB8dcgHXBHEwfFxprLDkYP8+nZ1Q6Z5gS5CQS4YCsPJMKkMHytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142646; c=relaxed/simple;
	bh=yemH83Y1IBRrxs46KNsj+mhkx+dw4Xz7CPBdGbd26JA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fv8kHGhfZH1yG5LILSiyZ5D3Q+EBd9mt6IH1Pi7aORjc8B6Qb+nsSChQEaRoVIcV4jEIlgddoQagp6jc2+ssZPONrwcEdQknL5S4bYRO6LvkDufp+sHOLBJ3Zf+hfi4cdIfSYMD/V0Bj6fcrHIbfgicrZW+C9jK8Si/9QGPiOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8OpL00w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF05CC433F1;
	Wed,  3 Apr 2024 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712142646;
	bh=yemH83Y1IBRrxs46KNsj+mhkx+dw4Xz7CPBdGbd26JA=;
	h=From:To:Cc:Subject:Date:From;
	b=p8OpL00wcZVyQKOBcHjcsrO2JtE29/xzGT0Gm/uzql1T88/EYGguTdJTo4G+RluYH
	 4PJ3QF4DDjlmPalPT9IFnXWYuk8bEmWM0AXG3wzvWJGLeabh7IlGUxYFHdG+H/HVIn
	 ng39qgroZoJ62mm7YlyhKTfC4NGLh0qy2OAJ1dhZI4muA4LhpG11rWrjdL+njYfDMo
	 1M4oWR2oLmk+v4PW5MvlFCOQCbNFnBbuvQqYuaQUnZioz5HzbvQtiBd/ElkRQZdNyO
	 Y1Mes2KzffMbvkeR/I2dKYRHgCDeCkEmadaNLkA7zk1eWRNf5Z5tmaNVK9Q/XpuMp4
	 l1HG00ANDz4jg==
From: Arnd Bergmann <arnd@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nikunj Kela <quic_nkela@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] firmware: arm_scmi: Avoid non-constant printk format strings
Date: Wed,  3 Apr 2024 13:10:24 +0200
Message-Id: <20240403111040.3924658-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A recent rework changed the constant format strings to a local variable,
which causes warnings from clang when -Wformat-security is enabled:

drivers/firmware/arm_scmi/driver.c: In function 'scmi_probe':
drivers/firmware/arm_scmi/driver.c:2936:25: error: format not a string literal and no format arguments [-Werror=format-security]
 2936 |                         dev_err(dev, err_str);
      |                         ^~~~~~~
drivers/firmware/arm_scmi/driver.c:2993:9: error: format not a string literal and no format arguments [-Werror=format-security]
 2993 |         return dev_err_probe(dev, ret, err_str);

Print these using an explicit "%s" string instead.

Fixes: 3a7d93d1f71b ("firmware: arm_scmi: Use dev_err_probe to bail out")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/arm_scmi/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index d0091459a276..36e3eb50a8d4 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2933,7 +2933,7 @@ static int scmi_probe(struct platform_device *pdev)
 	if (ret) {
 		err_str = "unable to communicate with SCMI\n";
 		if (coex) {
-			dev_err(dev, err_str);
+			dev_err(dev, "%s", err_str);
 			return 0;
 		}
 		goto notification_exit;
@@ -2990,7 +2990,7 @@ static int scmi_probe(struct platform_device *pdev)
 clear_ida:
 	ida_free(&scmi_id, info->id);
 
-	return dev_err_probe(dev, ret, err_str);
+	return dev_err_probe(dev, ret, "%s", err_str);
 }
 
 static void scmi_remove(struct platform_device *pdev)
-- 
2.39.2


