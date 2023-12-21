Return-Path: <linux-kernel+bounces-7810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC181AD84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76E21F23448
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818C48F54;
	Thu, 21 Dec 2023 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="L/RCuuyg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C38BFA;
	Thu, 21 Dec 2023 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (1.general.khfeng.us.vpn [10.172.68.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8938A4137C;
	Thu, 21 Dec 2023 03:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703128982;
	bh=JDoM9KmI2fADFTTBZyhTDsMQjnYqWfo8M3InT6pF8C0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=L/RCuuygH3nkZok0q+OQmCLG1t82JOr+LJxC0TJLTlGTMdhm/kznRpEl6a1b5Z9+d
	 jH3ch5c2vhmzl7yuO9fMcqU8ozw54Lj0U3LgYNNELnipGYavWdEg9pD76OJPaPKXdl
	 SXl3ANcKr/iAHBjhX++S3tOooxXDa2mRQ9v6fMOCZKvXM5ZB6CKhbb7fsXy+Pll9om
	 VynDqo5EbbJn0upDiH86NXjimahnccMPj2AIc6nVdeEvONJZdYkFcMTW9kHoEAJbTO
	 DxAMSozl6Yg2gBEL/9l0LSnPjKOgZglb2yXWiRBWx+jyKgPDhlFzyqE/AgspUVBiwx
	 TojLeQerzAxZg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <benchuanggli@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay timer timeout during suspend
Date: Thu, 21 Dec 2023 11:21:47 +0800
Message-Id: <20231221032147.434647-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spamming `lspci -vv` can still observe the replay timer timeout error
even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the
replay timer timeout of AER"), albeit with a lower reproduce rate.

Such AER interrupt can still prevent the system from suspending, so let
root port mask and unmask replay timer timeout during suspend and
resume, respectively.

Cc: Victor Shih <victor.shih@genesyslogic.com.tw>
Cc: Ben Chuang <benchuanggli@gmail.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Change subject to reflect it works on GL9750 & GL9755
 - Fix when aer_cap is missing
 
 drivers/mmc/host/sdhci-pci-core.c |  2 +-
 drivers/mmc/host/sdhci-pci-gli.c  | 55 +++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci-pci.h      |  1 +
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 025b31aa712c..59ae4da72974 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -68,7 +68,7 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
 	return 0;
 }
 
-static int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
+int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip)
 {
 	int i, ret;
 
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 77911a57b12c..54943e9df835 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -1429,6 +1429,55 @@ static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
 	return sdhci_pci_resume_host(chip);
 }
 
+#ifdef CONFIG_PCIEAER
+static void mask_replay_timer_timeout(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(pdev);
+	u32 val;
+
+	if (!parent || !parent->aer_cap)
+		return;
+
+	pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, &val);
+	val |= PCI_ERR_COR_REP_TIMER;
+	pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK, val);
+}
+
+static void unmask_replay_timer_timeout(struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(pdev);
+	u32 val;
+
+	if (!parent || !parent->aer_cap)
+		return;
+
+	pci_read_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, &val);
+	val &= ~PCI_ERR_COR_REP_TIMER;
+	pci_write_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, val);
+}
+#else
+static inline void mask_replay_timer_timeout(struct pci_dev *pdev) { }
+static inline void unmask_replay_timer_timeout(struct pci_dev *pdev) {  }
+#endif
+
+static int sdhci_pci_gl975x_suspend(struct sdhci_pci_chip *chip)
+{
+	mask_replay_timer_timeout(chip->pdev);
+
+	return sdhci_pci_suspend_host(chip);
+}
+
+static int sdhci_pci_gl975x_resume(struct sdhci_pci_chip *chip)
+{
+	int ret;
+
+	ret = sdhci_pci_gli_resume(chip);
+
+	unmask_replay_timer_timeout(chip->pdev);
+
+	return ret;
+}
+
 static int gl9763e_resume(struct sdhci_pci_chip *chip)
 {
 	struct sdhci_pci_slot *slot = chip->slots[0];
@@ -1547,7 +1596,8 @@ const struct sdhci_pci_fixes sdhci_gl9755 = {
 	.probe_slot	= gli_probe_slot_gl9755,
 	.ops            = &sdhci_gl9755_ops,
 #ifdef CONFIG_PM_SLEEP
-	.resume         = sdhci_pci_gli_resume,
+	.suspend	= sdhci_pci_gl975x_suspend,
+	.resume         = sdhci_pci_gl975x_resume,
 #endif
 };
 
@@ -1570,7 +1620,8 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
 	.probe_slot	= gli_probe_slot_gl9750,
 	.ops            = &sdhci_gl9750_ops,
 #ifdef CONFIG_PM_SLEEP
-	.resume         = sdhci_pci_gli_resume,
+	.suspend	= sdhci_pci_gl975x_suspend,
+	.resume         = sdhci_pci_gl975x_resume,
 #endif
 };
 
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 153704f812ed..19253dce687d 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -190,6 +190,7 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
 }
 
 #ifdef CONFIG_PM_SLEEP
+int sdhci_pci_suspend_host(struct sdhci_pci_chip *chip);
 int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
 #endif
 int sdhci_pci_enable_dma(struct sdhci_host *host);
-- 
2.34.1


