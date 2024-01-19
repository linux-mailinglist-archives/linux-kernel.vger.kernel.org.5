Return-Path: <linux-kernel+bounces-30783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4A1832452
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABA11F23AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D223B4A15;
	Fri, 19 Jan 2024 05:47:03 +0000 (UTC)
Received: from TWMBX02.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658854A08
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705643223; cv=none; b=bx0I6I92Hs0fEG2qaRJu/vTFREuiE/bbfxG4RICgrnmuW/yc1k3ZrX7160BRoor+z+WlutNUsL63Ti5zR2f5m622zfG2trGPceXTmClc8GRpNvOSS0mrtsDDh/x6xKXGD2joUH5CBJDSh+lpGNtbxuATGRZCAJqgczrYVDiudUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705643223; c=relaxed/simple;
	bh=vlYQVccxYZ0DiUDfVn1GJR1st0mlyzvE2G+s3xMu0II=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tQmh14g3Y1SZpk/saDiTGW3B+g9ZVpSR+O9DSQ9I8P9+VR+URccTOrlwahdtUOwBmRFGWVR1/G8nwbEpqMUjVY67heP9utvcE/NqubhCx2/88iBL61Woj6wdJ1dRUz09dRPUunUg3UmdjIRl9t2Ce7flTeIW7Uoao/vk1OA9b8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 19 Jan
 2024 13:45:49 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Jan 2024 13:45:49 +0800
From: Dylan Hung <dylan_hung@aspeedtech.com>
To: <alexandre.belloni@bootlin.com>, <jk@codeconstruct.com.au>,
	<joel@jms.id.au>, <u.kleine-koenig@pengutronix.de>, <gustavoars@kernel.org>,
	<krzysztof.kozlowski@linaro.org>, <zenghuchen@google.com>,
	<matt@codeconstruct.com.au>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <BMC-SW@aspeedtech.com>
Subject: [PATCH] i3c: dw: Disable IBI IRQ depends on hot-join and SIR enabling
Date: Fri, 19 Jan 2024 13:45:47 +0800
Message-ID: <20240119054547.983693-1-dylan_hung@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: Fail (TWMBX02.aspeed.com: domain of dylan_hung@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=localhost.localdomain;

Disable IBI IRQ signal and status only when hot-join and SIR enabling of
all target devices attached to the bus are disabled.

Fixes: e389b1d72a62 ("i3c: dw: Add support for in-band interrupts")

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
---
 drivers/i3c/master/dw-i3c-master.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index ef5751e91cc9..276153e10f5a 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1163,8 +1163,10 @@ static void dw_i3c_master_set_sir_enabled(struct dw_i3c_master *master,
 		global = reg == 0xffffffff;
 		reg &= ~BIT(idx);
 	} else {
-		global = reg == 0;
+		bool hj_rejected = !!(readl(master->regs + DEVICE_CTRL) & DEV_CTRL_HOT_JOIN_NACK);
+
 		reg |= BIT(idx);
+		global = (reg == 0xffffffff) && hj_rejected;
 	}
 	writel(reg, master->regs + IBI_SIR_REQ_REJECT);
 
-- 
2.25.1


