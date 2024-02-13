Return-Path: <linux-kernel+bounces-64415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03C853E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D63C1C2850D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB91A62A12;
	Tue, 13 Feb 2024 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Vn+ARP2H"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F473627E6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861786; cv=none; b=TGiWuukEA4TlJwvnRCUtKGPsCadl6R7L3zHOr4QaljLsrbo4dSACbww94aApN7t6rO8Zvhf1K0oBROPokNbEMxYedPtK7oYgFOX4hm27IZrGDx9mxXsMAnfl0nnGVAhIVRorMjxoohjTwSCM1qLUQ3mcQH63oAUEe9+kscYFB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861786; c=relaxed/simple;
	bh=4Cv/DKAqwiMA7u3CWshnEujZInnSy/3vqqV9OZtXUZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQWGnGzowIpGgXXD4RapuBGJb71AKgpOrQiasEOukgziJk8f8PWaLvjT0QnMByxfxLKMlr5IPT6DcxPNptCyr4WToMTd3lmDv4Q8bK26phXL4k1o404/DuU9SVqmpApo9P5MsA4tAWPnDgrX4RCyVSNrQreB36kGi2EbWY5rog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Vn+ARP2H; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=QVjbmkicP3lKRzsUEP3UTuSHN1nf5jzXesx7Ut3oggE=; b=Vn+ARP
	2HJ1vJa25RDdk83FJ+sBNhL0XdCu0s8FlqER6BLSUkqR8pHNwYxxKD8pPB33M8YE
	Pds3/xRfold0LAcpDpz289HO7ei2aGrj5wCvuzNs4RnaYL1syPLPj5LYb8jAGRfz
	VAiQ+Cg9PSammZQvuj3EY2Vjp1qFkuqL8gyzaJ00/JNJdR6+3Z0uFTLrKwZTkjpB
	TqCD4+VCNpyQ+gaU9ZXNJ9zT33zR0g0ASbSt6w2Zf4agbiQkMxb4YOggXKJxhq1d
	JBxg5ihgDVC6aD5fsXQpuzzAnsB3cPVQNyC3jeBJkqTFLw4n1D3BqANfK7/fc874
	Q0pXfz/EK6kqBpNw==
Received: (qmail 1211814 invoked from network); 13 Feb 2024 23:02:53 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Feb 2024 23:02:53 +0100
X-UD-Smtp-Session: l3s3148p1@a5pQjkoR1t8ujnsZ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	kernel test robot <lkp@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] mmc: tmio/sdhi: Fix includes
Date: Tue, 13 Feb 2024 23:02:22 +0100
Message-ID: <20240213220221.2380-11-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213220221.2380-8-wsa+renesas@sang-engineering.com>
References: <20240213220221.2380-8-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TMIO uses an of_* function, and SDHI uses pm_runtime functions. Add the
includes directly, so we can clean up another header properly. Sort the
pagemap include while we are here.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402070323.JpYfFtkQ-lkp@intel.com/
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 ++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 3 ++-
 drivers/mmc/host/tmio_mmc_core.c              | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 53d34c3eddce..24e1c17908d7 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -16,8 +16,9 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_device.h>
 #include <linux/pagemap.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/sys_soc.h>
 
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 9cf7f9feab72..c18581897f8a 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -16,8 +16,9 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_device.h>
 #include <linux/pagemap.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/sys_soc.h>
 
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index be7f18fd4836..c39141a5bd23 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -37,6 +37,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
-- 
2.43.0


