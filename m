Return-Path: <linux-kernel+bounces-11214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D111281E349
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6D01C212A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E68847F7B;
	Tue, 26 Dec 2023 00:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqb0uMgI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640D257A;
	Tue, 26 Dec 2023 00:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79498C433CA;
	Tue, 26 Dec 2023 00:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550075;
	bh=f0LkiSEzhA8hh57iaOnmy9coJXv9QRr2+lj0T9ucHf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tqb0uMgIHS+nBTRriTRuQPtosTAg1NWXzNaNy8yTCoKuPq2ISbcLwRWb0BVxCp29R
	 RtI2h+t1Xsl76rKwUqKX1oTk+9VXFcec1Go4HHYp1CrJFB5Lj+0FBggh0zsQ8+WQO0
	 QRtC/tXWot9MpoM4LKFkNhUUUW5xjj9r7SdEgb0aP0GYxso9ZV2T1uuNMJU/7XDsPX
	 ltMKDr3Q0WLvBMi/CDQY43elRQJGudb3cPVPJyf/32xwmcMMJBNB09Uxmoc4FF0EcD
	 lMgBqc54JTh2rQx1Wzegh3nDBfB2WZZJ2EatvpkTp9Obc2ljpD5CGauwlMRa9KdvrS
	 mJDxM7ibffyuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Shyam-sundar.S-k@amd.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 21/39] platform/x86/amd/pmc: Only run IRQ1 firmware version check on Cezanne
Date: Mon, 25 Dec 2023 19:19:11 -0500
Message-ID: <20231226002021.4776-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 2d53c0ab61e62302d7b62d660fe76de2bff6bf45 ]

amd_pmc_wa_czn_irq1() only runs on Cezanne platforms currently but
may be extended to other platforms in the future.  Rename the function
and only check platform firmware version when it's called for a Cezanne
based platform.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20231212045006.97581-3-mario.limonciello@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/pmc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index 3fea32880ac8d..f28bee6854f4c 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -704,19 +704,22 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
 	return -EINVAL;
 }
 
-static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
+static int amd_pmc_wa_irq1(struct amd_pmc_dev *pdev)
 {
 	struct device *d;
 	int rc;
 
-	if (!pdev->major) {
-		rc = amd_pmc_get_smu_version(pdev);
-		if (rc)
-			return rc;
-	}
+	/* cezanne platform firmware has a fix in 64.66.0 */
+	if (pdev->cpu_id == AMD_CPU_ID_CZN) {
+		if (!pdev->major) {
+			rc = amd_pmc_get_smu_version(pdev);
+			if (rc)
+				return rc;
+		}
 
-	if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
-		return 0;
+		if (pdev->major > 64 || (pdev->major == 64 && pdev->minor > 65))
+			return 0;
+	}
 
 	d = bus_find_device_by_name(&serio_bus, NULL, "serio0");
 	if (!d)
@@ -876,7 +879,7 @@ static int amd_pmc_suspend_handler(struct device *dev)
 	struct amd_pmc_dev *pdev = dev_get_drvdata(dev);
 
 	if (pdev->cpu_id == AMD_CPU_ID_CZN && !disable_workarounds) {
-		int rc = amd_pmc_czn_wa_irq1(pdev);
+		int rc = amd_pmc_wa_irq1(pdev);
 
 		if (rc) {
 			dev_err(pdev->dev, "failed to adjust keyboard wakeup: %d\n", rc);
-- 
2.43.0


