Return-Path: <linux-kernel+bounces-118075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C24688B358
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CFF305669
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD35D71739;
	Mon, 25 Mar 2024 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmy3NfcN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222966F520;
	Mon, 25 Mar 2024 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404221; cv=none; b=RO/qHg52QmFGF5N5iBXcBXEKFYoX3VTs+w7kxt1O/bQXbE0UZGeKA6tnZS7AAELkDvLXzmyE4/QtSRZHznNRLBEa/eZMdJBf527NsuA/LLt1iPJozRvuooVJvUOvTdFpN9CIJV9DMReiRSUplNsAL1IQIB40DF94cKm3xMs5IYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404221; c=relaxed/simple;
	bh=D97d//ulthFFq6JCivdJH/deBny3cPZs6rJuoK7JpQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ke65kddUVT+Pwg2R7L+9VkVNEpRDCUXOMigyOgCifafu8EIQcNuHfWtedOlm/cyiFQmlxKieqL7jRiarqYGWa+1Ow6YWGabzBl5GQw/v3vq0BVuQp8i8xigHIJbBx+0BW+VM8CKFWqgQ3E0TOLw13CJy/dj54CA6T+IvpR455mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmy3NfcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C049C433C7;
	Mon, 25 Mar 2024 22:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711404220;
	bh=D97d//ulthFFq6JCivdJH/deBny3cPZs6rJuoK7JpQw=;
	h=From:To:Cc:Subject:Date:From;
	b=cmy3NfcNjDauCP4cDEVtxa5U/8SyAPO4uteTio8mgrr69A3++NzjhU4JgYgu6a2rW
	 EHMGWxvvvWA0noRlZjmZLP+5k3G+M4QepPbHaLrwK8xqD7Foy833vVl9cnoIBH+OPh
	 eo38gLscF7hnDKz/Fh59o76XSzrcmALSD8gT3zoMwAtkjkLFuZ/wYJSfwGpMyH55vT
	 11Knta282UUb2sUllPB6X7351UnG+14dEY5QMGVmlJOwhCgorGv+HRbEEuJ8klOXom
	 yZDEJndsaWaFjRlaCTICEDsjnvXLE+LQuZp5qxAg0jFsACXF2sA572UJqouGi92T3Z
	 E63066cu/qz4w==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yong Zhi <yong.zhi@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Dan Scally <djrscally@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tianshu Qiu <tian.shu.qiu@intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hyungwoo Yang <hyungwoo.yang@intel.com>,
	Rajmohan Mani <rajmohan.mani@intel.com>,
	Vijaykumar Ramya <ramya.vijaykumar@intel.com>,
	Samu Onkalo <samu.onkalo@intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Jouni Ukkonen <jouni.ukkonen@intel.com>,
	Antti Laakso <antti.laakso@intel.com>
Subject: [PATCH] media: ipu-cio2: Remove unnecessary runtime PM power state setting
Date: Mon, 25 Mar 2024 17:03:25 -0500
Message-Id: <20240325220325.1452712-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

ipu-cio2 uses generic power management, and pci_pm_runtime_suspend() and
pci_pm_runtime_resume() already take care of setting the PCI device power
state, so the driver doesn't need to do it explicitly.

Remove explicit setting to D3hot or D0 during runtime suspend and resume.

Remove #defines that are no longer used.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Hyungwoo Yang <hyungwoo.yang@intel.com>
Cc: Rajmohan Mani <rajmohan.mani@intel.com>
Cc: Vijaykumar Ramya <ramya.vijaykumar@intel.com>
Cc: Samu Onkalo <samu.onkalo@intel.com>
Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: Jouni Ukkonen <jouni.ukkonen@intel.com>
Cc: Antti Laakso <antti.laakso@intel.com>
---
This code was initially added by c2a6a07afe4a ("media: intel-ipu3: cio2:
add new MIPI-CSI2 driver").

Even at that time, the explicit power state setting should not have been
necessary, so maybe there's a reason for it.  I have no way to test this,
so if it *is* needed, please:

  - Add a comment about the reason and

  - Convert it to use pci_set_power_state() so the PCI core knows about the
    change and all the required state transition delays are observed.
---
 drivers/media/pci/intel/ipu3/ipu3-cio2.c | 9 ---------
 drivers/media/pci/intel/ipu3/ipu3-cio2.h | 4 ----
 2 files changed, 13 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index c42adc5a408d..cdc43373d4e8 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1812,11 +1812,6 @@ static int __maybe_unused cio2_runtime_suspend(struct device *dev)
 	writel(CIO2_D0I3C_I3, base + CIO2_REG_D0I3C);
 	dev_dbg(dev, "cio2 runtime suspend.\n");
 
-	pci_read_config_word(pci_dev, pci_dev->pm_cap + CIO2_PMCSR_OFFSET, &pm);
-	pm = (pm >> CIO2_PMCSR_D0D3_SHIFT) << CIO2_PMCSR_D0D3_SHIFT;
-	pm |= CIO2_PMCSR_D3;
-	pci_write_config_word(pci_dev, pci_dev->pm_cap + CIO2_PMCSR_OFFSET, pm);
-
 	return 0;
 }
 
@@ -1830,10 +1825,6 @@ static int __maybe_unused cio2_runtime_resume(struct device *dev)
 	writel(CIO2_D0I3C_RR, base + CIO2_REG_D0I3C);
 	dev_dbg(dev, "cio2 runtime resume.\n");
 
-	pci_read_config_word(pci_dev, pci_dev->pm_cap + CIO2_PMCSR_OFFSET, &pm);
-	pm = (pm >> CIO2_PMCSR_D0D3_SHIFT) << CIO2_PMCSR_D0D3_SHIFT;
-	pci_write_config_word(pci_dev, pci_dev->pm_cap + CIO2_PMCSR_OFFSET, pm);
-
 	return 0;
 }
 
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.h b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
index d731ce8adbe3..d7cb7dae665b 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.h
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.h
@@ -320,10 +320,6 @@ struct pci_dev;
 #define CIO2_CSIRX_DLY_CNT_TERMEN_DEFAULT		0x4
 #define CIO2_CSIRX_DLY_CNT_SETTLE_DEFAULT		0x570
 
-#define CIO2_PMCSR_OFFSET				4U
-#define CIO2_PMCSR_D0D3_SHIFT				2U
-#define CIO2_PMCSR_D3					0x3
-
 struct cio2_csi2_timing {
 	s32 clk_termen;
 	s32 clk_settle;
-- 
2.34.1


