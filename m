Return-Path: <linux-kernel+bounces-153884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284228AD474
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A89B220AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D45155326;
	Mon, 22 Apr 2024 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uCHaCjGq"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4DA1552E0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812295; cv=none; b=MqzPMrYImyo5WUacmdjnJDqA0yG6E70oEx2JmXuAEjjwK6WrxZ4YOHkmlPUq0odHeY5uZdoLMie5YVgGujk2/5idACi8F6P0S4imDJ3UomUmSrN4ZQeBKlhr/8ZOz+9ZOi91dG7PblW+x1NKG4oorccdq5NmrRM9InuDyaYrURk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812295; c=relaxed/simple;
	bh=Wc/0TtAsnuRIJQ+QqKxYwNeHR8aDs67Dl4cfZRFVIv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GJAU/dZvf7BOjCZfsjk4khYmmcJGGRbVjLeteFukdQGrjbBx1LfmJTtb4hUJYs7ztEcKkv/rEwQcZYt3C3oeQJmIgQBTzfYY7U2emR2iKfLHO3aB4LIXMCYog3w7hSA8QPUaeZ23OIIjytR0ZMpA/SMYOpc/Fe3UEqW/q5Xwq14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uCHaCjGq; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713812292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l0jxaPV6Y3HOhLaJSxMJEdsj1DNm8Hvs/A17Ws337Lo=;
	b=uCHaCjGqVCKxdnL8akAeXt/gf1cmbM6CrS64Bto5sd6LkQN2GIvy5USUvU579AfNIW39+S
	atFAOlQX2azeVi65ZXVrGEhYy48Y8pdsHHejitjwjmH9SvN+1Au3zc+0j1FJAMkR5otDN5
	7gZIqExtajv0USY/SZMZccTWNjuBx7I=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 2/3] phy: zynqmp: Don't wait for PLL lock on nonzero PCIe lanes
Date: Mon, 22 Apr 2024 14:58:02 -0400
Message-Id: <20240422185803.3575319-3-sean.anderson@linux.dev>
In-Reply-To: <20240422185803.3575319-1-sean.anderson@linux.dev>
References: <20240422185803.3575319-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Similarly to DisplayPort, nonzero PCIe lanes never achieve PLL lock [1].
Don't wait for them.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---
Maybe it's actually that only the final lane configured locks? I haven't
tested this out.

 drivers/phy/xilinx/phy-zynqmp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index b507ed4c3053..08c88dcd7799 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -624,11 +624,13 @@ static int xpsgtr_phy_power_on(struct phy *phy)
 	if (!xpsgtr_phy_init_required(gtr_phy))
 		return ret;
 	/*
-	 * Wait for the PLL to lock. For DP, only wait on DP0 to avoid
-	 * cumulating waits for both lanes. The user is expected to initialize
-	 * lane 0 last.
+	 * Wait for the PLL to lock. For DP and PCIe, only wait on instance 0
+	 * to avoid cumulative waits for both lanes. The user is expected to
+	 * initialize lane 0 last.
 	 */
-	if (gtr_phy->protocol != ICM_PROTOCOL_DP || !gtr_phy->instance)
+	if ((gtr_phy->protocol != ICM_PROTOCOL_DP &&
+	     gtr_phy->protocol != ICM_PROTOCOL_PCIE) ||
+	    !gtr_phy->instance)
 		ret = xpsgtr_wait_pll_lock(phy);
 
 	return ret;
-- 
2.35.1.1320.gc452695387.dirty


