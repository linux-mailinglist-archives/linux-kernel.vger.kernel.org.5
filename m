Return-Path: <linux-kernel+bounces-62746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CB2852530
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93CE1F2165B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A5112F5BF;
	Tue, 13 Feb 2024 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ357KzO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F129CEA;
	Tue, 13 Feb 2024 00:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783871; cv=none; b=QtqORxJbMX1zn7zpjq+YHLQbERiQl9sBLtmDcO5YyzzyCBJvHG3ukBOTMXHZzZY4Uf6VQpgTTuOasUYbTGfc1oowkFErNtk3T9CJ7mWJAVY20wjvCSqZDiPCMOfHbY3p4ccpdL6oXg6+6vUs+8Z17oPC/fDbNAax0or3BjkgSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783871; c=relaxed/simple;
	bh=f+qJcnnrFfj+Tpxdck62VZq1w0HqiDFabO/FRPH/tCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDiHj/VDEzshFpgp7WuuMJYAZ9z4BNjLg2bI1d8ceM/zoItbNBYLDp3CSg8HRN25eT3bFCwDqAiMoULRbyGl7rJEI8lCq6e0fpMfY/ULtP3GlYsPMcNsNbrtoECmLKXIMKlObVj79osYX45djEnpUPiRhe6yoI66cV3b9JJZO38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ357KzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4A0C43390;
	Tue, 13 Feb 2024 00:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783870;
	bh=f+qJcnnrFfj+Tpxdck62VZq1w0HqiDFabO/FRPH/tCE=;
	h=From:To:Cc:Subject:Date:From;
	b=nJ357KzOlsDY364IRs4fifLVj2laoaH2A3GfjtJtHHWfSox4UjwE5cNa+4wZsYcsp
	 q+4xCTP4ruR07fFBlKQ5Z4pa2O/vRrTytna7cW15Li7T97X8O3AR76zBPlcPYv5Y8z
	 b446WaCmAUMlmYd0IgoeTLIYg4YVfU9gZsa9GYt12V1m//KBf042OGJZkeBGI+FD6K
	 /MGxR7As1nlyKZlBPOxwuWGAoJ7JyWqwoULEmb78CacBzFePBbzwuhm2878R87jhJF
	 9PAb9f9FD01snD89Zi05tKH3d7BDLPmopQHnxRLu/BYIle8DJEEpwJSNGlTNbI1Jql
	 E/XCUgNkA+z4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	fenghua.yu@intel.com,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/3] hwmon: (coretemp) Enlarge per package core count limit
Date: Mon, 12 Feb 2024 19:24:25 -0500
Message-ID: <20240213002428.673310-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit 34cf8c657cf0365791cdc658ddbca9cc907726ce ]

Currently, coretemp driver supports only 128 cores per package.
This loses some core temperature information on systems that have more
than 128 cores per package.
 [   58.685033] coretemp coretemp.0: Adding Core 128 failed
 [   58.692009] coretemp coretemp.0: Adding Core 129 failed
 ...

Enlarge the limitation to 512 because there are platforms with more than
256 cores per package.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20240202092144.71180-4-rui.zhang@intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/coretemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 33371f7a4c0f..e08bb28ec427 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -53,7 +53,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
 #define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
-#define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
+#define NUM_REAL_CORES		512	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
-- 
2.43.0


