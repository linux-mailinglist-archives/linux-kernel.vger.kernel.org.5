Return-Path: <linux-kernel+bounces-41702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC9383F6C8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D87D1C20431
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4525524B4;
	Sun, 28 Jan 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzDFgHKp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE2524CC;
	Sun, 28 Jan 2024 16:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458327; cv=none; b=m5qKnB4VeAde83Zk+g5VFuQ09MvDHvMYSBU2VTU5k1fPtn1SzXYckwgbA93yffzB2zuE1pl1WAXy0IMdTDCVLPreBVxpSUb9KoRERxWVRiOv7Nmy0o5ifJms+5LShOuA0HAiQYo3f1VrNE+6ao2ZyZZq+UEjgNJrQgCbB9xn8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458327; c=relaxed/simple;
	bh=ix8XBCGUm23P7dIAwb+lQE/fHDfnA07Y2g69GvMJYpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mo2CzbuMlH8DolGafKijQRcMl0XIf83aVVFsOCvfiHgmir6O9zvVsTpdDJ1YB9XbGpBB4JNmafOx3eSUH0esMGa5JbwmLwEasZAd7zpj5wImnwMJBa5ZGNdwSdbRpwXHOw/aN7g3DPzSaZd1HLKUBNQCwtiwdLcZOp7bz35K/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzDFgHKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2541C433B2;
	Sun, 28 Jan 2024 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458326;
	bh=ix8XBCGUm23P7dIAwb+lQE/fHDfnA07Y2g69GvMJYpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzDFgHKpoBhdxNKBHijKbQPj/rtRnky77mXtQGkBiWkS/rG/vdff2FlXmdhHiTBZm
	 13k1PPCdjW8x69XQThZ7RBmigLeo8w6Fx2IrlnVe2AorM9B8JT+6v6IKAYBZEX31N0
	 ayPPw9JUHMJA9YTttu80FEuUhNvVkFqiGzm3gvnprmkiOdK8fF3zYVi0iFAogA0B0g
	 Wti4IAZiNk6OIoiam1OEVIagSDMP/tbFKCNi0fJHDPjbHQ/f2fSyJ7QiDN0YOua73F
	 ZImn9+VRi7x3rNTd7Bkx9RoBBM4BIvkHfp1qR9UrAGT4cBdacE+LKO02IHs+ZyFVqB
	 a+6a52K074yxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	mathias.nyman@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 20/39] usb: xhci-plat: fix usb disconnect issue after s4
Date: Sun, 28 Jan 2024 11:10:40 -0500
Message-ID: <20240128161130.200783-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Yinbo Zhu <zhuyinbo@loongson.cn>

[ Upstream commit 6d6887c42e946f43bed2e64571a40c8476a1e4a9 ]

The xhci retaining bogus hardware states cause usb disconnect devices
connected before hibernation(s4) and refer to the commit 'f3d478858be
("usb: ohci-platform: fix usb disconnect issue after s4")' which set
flag "hibernated" as true when resume-from-hibernation and that the
drivers will reset the hardware to get rid of any existing state and
make sure resume from hibernation re-enumerates everything for xhci.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
Link: https://lore.kernel.org/r/20231228071113.1719-1-zhuyinbo@loongson.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-plat.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 732cdeb73920..f0853c4478f5 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -433,7 +433,7 @@ void xhci_plat_remove(struct platform_device *dev)
 }
 EXPORT_SYMBOL_GPL(xhci_plat_remove);
 
-static int __maybe_unused xhci_plat_suspend(struct device *dev)
+static int xhci_plat_suspend(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
@@ -461,7 +461,7 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused xhci_plat_resume(struct device *dev)
+static int xhci_plat_resume_common(struct device *dev, struct pm_message pmsg)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
@@ -483,7 +483,7 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
 	if (ret)
 		goto disable_clks;
 
-	ret = xhci_resume(xhci, PMSG_RESUME);
+	ret = xhci_resume(xhci, pmsg);
 	if (ret)
 		goto disable_clks;
 
@@ -502,6 +502,16 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
 	return ret;
 }
 
+static int xhci_plat_resume(struct device *dev)
+{
+	return xhci_plat_resume_common(dev, PMSG_RESUME);
+}
+
+static int xhci_plat_restore(struct device *dev)
+{
+	return xhci_plat_resume_common(dev, PMSG_RESTORE);
+}
+
 static int __maybe_unused xhci_plat_runtime_suspend(struct device *dev)
 {
 	struct usb_hcd  *hcd = dev_get_drvdata(dev);
@@ -524,7 +534,12 @@ static int __maybe_unused xhci_plat_runtime_resume(struct device *dev)
 }
 
 const struct dev_pm_ops xhci_plat_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(xhci_plat_suspend, xhci_plat_resume)
+	.suspend = pm_sleep_ptr(xhci_plat_suspend),
+	.resume = pm_sleep_ptr(xhci_plat_resume),
+	.freeze = pm_sleep_ptr(xhci_plat_suspend),
+	.thaw = pm_sleep_ptr(xhci_plat_resume),
+	.poweroff = pm_sleep_ptr(xhci_plat_suspend),
+	.restore = pm_sleep_ptr(xhci_plat_restore),
 
 	SET_RUNTIME_PM_OPS(xhci_plat_runtime_suspend,
 			   xhci_plat_runtime_resume,
-- 
2.43.0


