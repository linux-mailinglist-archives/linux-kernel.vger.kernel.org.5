Return-Path: <linux-kernel+bounces-144017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CB78A40D8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A341F21490
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBE12BD0F;
	Sun, 14 Apr 2024 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2t74mPG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0562868D;
	Sun, 14 Apr 2024 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713078944; cv=none; b=U2mlrCJzGNDt15KRXg+Ms3+VxfaObAHjEyWZClprrapVmsMAF/eAYvM4qdeKzGKz/DVWrdtKSst+Q7WuOAxi/PgzzhWrRq5WVmk0OFqdHZfPOaNVoBcPdkBbtwM/GO9dMXxXc09jJE9EVw8l81gmhsmvdWyjgxVOZvnPJQZQSRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713078944; c=relaxed/simple;
	bh=uD+ViLOa9S8ut1fdu47zbr3AGnB2izGuU5i0gc4OfAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQt1laV5tJElGr9Qir/YUBvCemSv7br+6q9wSy+oAheZay3x/Gtmno7XrR6uIowbu6OskkWCbRsyM6RCbq5zKDwxTd5MS+jyAW6MS6mvsS6LYuBxqYV3DNdnw/8DC5u2dsc+F4x5kAy/saiZcCwJQYyiaBQWlnrZvRBKbPtcsVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2t74mPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B004C32781;
	Sun, 14 Apr 2024 07:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713078944;
	bh=uD+ViLOa9S8ut1fdu47zbr3AGnB2izGuU5i0gc4OfAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L2t74mPGBiOvi7SZmrw2Zd5cmuKDERFwSFI94FyJSyPATx/JFsaaiRv8ujBIier5R
	 pMhzFsEl01Qn0yrivjsJ7G8zAAn2BDNoGbRCk7iaMqBBLogcwQhDzpr91mZnOHTlN4
	 YLneMMiR26xlocl6L8RjetRsVEXfeDxeNXgcViVB0dRGnVc+w8TLyJsijHSBKwp8Vl
	 QgyB+RGty58zZ3iLXGinHOBbzQeHxOP4uqEZHdkEjDAVm/bitGe1rwOQIJLt8OiBU7
	 p9DtFQVUtYgEJ8CgzhJ4J1CC4iJ0yCkaOyiqI0V/GWFqmCx7mSTEke9Ktzr+vpCcpz
	 YxmuNcgGqisZw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 09:15:17 +0200
Subject: [PATCH 4/5] mmc: sdhci_am654: Constify struct sdhci_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-mmc-const-sdhci-ops-v1-4-178539d68093@kernel.org>
References: <20240414-mmc-const-sdhci-ops-v1-0-178539d68093@kernel.org>
In-Reply-To: <20240414-mmc-const-sdhci-ops-v1-0-178539d68093@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Ben Dooks <ben-linux@fluff.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1685; i=krzk@kernel.org;
 h=from:subject:message-id; bh=uD+ViLOa9S8ut1fdu47zbr3AGnB2izGuU5i0gc4OfAY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmG4KMj8KzBrNkHRumdl2yl7nMeq2VMN9nMd7Jp
 VuF8Mpro1KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhuCjAAKCRDBN2bmhouD
 16AbD/wNDEAPEB0gmb+3xBdMBEtR4LzHruYj/ZsrADoAJ3C9E+UQzK3hHINhq/uJvrzXiMDipM8
 hgHI2Og0p81JxX7wBUXc4ffpSIfCQpopMyUn1qJHQZWbZKdyrHMMo6KH/cKf77FA03VWxyX0ZZd
 //FBBlbSuCb3kJgshzBYtARueKCipvfTMVTT0xHHmRndCJrs9EapdfeIXZH+rPjNhV3qmRX4ut1
 eF6CheLsMFYmFpQueWu/jWsjRDRtAdc2fA0HPWVnBuviMfWGzDU2vwuHfjk2oA39Tg2EqnuqOEa
 dCivszHPLOw45c5swXdbrAhNvvbmTgS2h9rZQ2iyvd1thV2LAM3QQ+TTCJRhHmRNlTIp3YS6lWA
 enxqz/9jlemDZr84zE4nkUnVXXw4nrBVid8ZthjFGtfblJSbIwLPQMODRT36X3dfgcLzq0JEzUH
 2VY2XdQXVySqW3Ed+Gu9ERtZHQS5BQP/5rxk8PE1aB0bLgJltcWDj2m1P0N5ia0TEK2X1XrCnDr
 inR0VfvMl70Z4ZPt3U4fajyuxGrbzEFe2aQhTEC06qH0nLpSW6hSh9UFqq2iluKTYd6RolrmtvR
 ZCRDAWAL30w1+75nE2p1cx3m0lExjQ4VtAlSbbDe4A0I/3T0PpXqHkBoGbe63e/B9MR7b2Wa+6V
 EbPnjpuSgvr4MKw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The local struct sdhci_ops can be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci_am654.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index ba36123e4ccc..17ad32cfc0c3 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -543,7 +543,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	return 0;
 }
 
-static struct sdhci_ops sdhci_am654_ops = {
+static const struct sdhci_ops sdhci_am654_ops = {
 	.platform_execute_tuning = sdhci_am654_platform_execute_tuning,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
@@ -573,7 +573,7 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
 	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
 };
 
-static struct sdhci_ops sdhci_j721e_8bit_ops = {
+static const struct sdhci_ops sdhci_j721e_8bit_ops = {
 	.platform_execute_tuning = sdhci_am654_platform_execute_tuning,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
@@ -597,7 +597,7 @@ static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
 	.flags = DLL_PRESENT | DLL_CALIB,
 };
 
-static struct sdhci_ops sdhci_j721e_4bit_ops = {
+static const struct sdhci_ops sdhci_j721e_4bit_ops = {
 	.platform_execute_tuning = sdhci_am654_platform_execute_tuning,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,

-- 
2.34.1


