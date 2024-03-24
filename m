Return-Path: <linux-kernel+bounces-113441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA0488845C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738252813E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC701ABFB0;
	Sun, 24 Mar 2024 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWA0+k4E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218911AC78E;
	Sun, 24 Mar 2024 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320243; cv=none; b=d0PC73TPoLtakv2NuIodg5MHbkmOWzpnvplV0jf9e8Pn5nINV46kRe1dL+gwvXUdJioC6T4S9ykqHiflrxwI0wfdF17tDNY1JuiDYEKWf30O1XNcrEbD9vlK7SRS1Kb3T6Vu+hgsjyafpXvzCJaZaxXia16tZ8D5fcp4xefybJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320243; c=relaxed/simple;
	bh=Oogw3Hic7l05PWmvSezChOkLZ3/Hxs5aL8UyfkjHwD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzZOEQ+mK+Ttc5FLr3u4uUnUk5MaZCYQjiY0+Xq5+H93MZ0DBb+1OwaqwPAf+266fV4FRiLygpO7X+KN7PpyRE9N6MtID6FtrcNFtRS85zNzRTz9u9+fiuXITMkSVA4EnaJqDweMfab8AR30uVrzTYmFPUbZCuWCVeC6zZes1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWA0+k4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47043C43394;
	Sun, 24 Mar 2024 22:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320243;
	bh=Oogw3Hic7l05PWmvSezChOkLZ3/Hxs5aL8UyfkjHwD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWA0+k4Eh9E0Xm1YqjHYXx/0m1in74daOu/A+ZqTGl2qLTL2TtxtImLDQKXd4GTXX
	 L7801Y69vSgFPUMz/7zWDJBYGPeVpV06+HvOe2ChH92aIyEac5SPTEJvfYI6FbXSXi
	 wVWFhk6hczAPaPXLuOr0zMa4/Ko0VYJS8qE6bbzfsboxwIzjFRv7jbyix+6xTRIq9y
	 DGHHL61SPPmFuguOX8aalrXuEkztG0N8QDf83fyM70x9nxTZ6njP7k3sc0IQMBRV4s
	 76ExoPBjdVN25o3uGExsJF2l+3wAM+Kuz1MVM/91z/wnt7pLbrgxnJkhYpFrzuUtAd
	 DhTi0GrZEo7dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "David E. Box" <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 550/715] platform/x86/intel/pmc/arl: Put GNA device in D3
Date: Sun, 24 Mar 2024 18:32:09 -0400
Message-ID: <20240324223455.1342824-551-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: "David E. Box" <david.e.box@linux.intel.com>

[ Upstream commit ac2d1fd9688fcdfba5acc815fb2b13fec83e5dad ]

As is the case on Meteor Lake, the Gaussian & Neural Accelerator (GNA)
device is powered by BIOS to D0 by default. If no driver is loaded, this
will cause the Package C state to be limited to PC2, leading to
significant power consumption and decrease in batter life.  Put the GNA
device in D3 by default if no driver is loaded for it.

Fixes: 83f168a1a437 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
Signed-off-by: "David E. Box" <david.e.box@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://lore.kernel.org/r/20240227190134.1592072-3-david.e.box@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/pmc/arl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 683ae828276b8..34b4cd23bfe59 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -673,6 +673,7 @@ static struct pmc_info arl_pmc_info_list[] = {
 };
 
 #define ARL_NPU_PCI_DEV			0xad1d
+#define ARL_GNA_PCI_DEV			0xae4c
 /*
  * Set power state of select devices that do not have drivers to D3
  * so that they do not block Package C entry.
@@ -680,6 +681,7 @@ static struct pmc_info arl_pmc_info_list[] = {
 static void arl_d3_fixup(void)
 {
 	pmc_core_set_device_d3(ARL_NPU_PCI_DEV);
+	pmc_core_set_device_d3(ARL_GNA_PCI_DEV);
 }
 
 static int arl_resume(struct pmc_dev *pmcdev)
-- 
2.43.0


