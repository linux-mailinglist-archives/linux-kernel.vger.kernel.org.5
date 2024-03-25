Return-Path: <linux-kernel+bounces-117903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCB488B119
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCC61FA5B64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754C757308;
	Mon, 25 Mar 2024 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="MwMV+aMl"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9244501F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397584; cv=none; b=EzjMcs8HgZUydaO80uDBpokP8ATCna3yw+I9X8pwrOrIWhwJQSOJmBi/wB27kpnvwf5QsKVNq9/0ZGuvCekTg0J1K74d/tfbP/Y2dB4EWZPtv3HlIO7WD+p7WZ/aW4tprqC1maVw4U6J5JSpwRUNRu875Tnp0uQPVZdG0VF20fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397584; c=relaxed/simple;
	bh=v0HPfErSBVJprZR5gRdA6DB5OkU3LBe8NZkysuBx5l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtaQHhJE+y7LDrX06Oub+USFnl+h1yvCCE2KiJNCcmhwqrj2PXic8lDWFRDqBEnur+rvBA1hAYvftw8iRxDBZfA+pfqUF7PXDDdZXHmsfaG47A2+7WcN9FEJRoc7hCEyjvYEGzhozDVNh4nq+jv8JYBGaMMomKXHgM/lQ4jqDLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=MwMV+aMl; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from tundra.lovozera (unknown [31.173.84.243])
	by mail.ispras.ru (Postfix) with ESMTPSA id DCBBB40B2784;
	Mon, 25 Mar 2024 20:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru DCBBB40B2784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1711397574;
	bh=crTIb98cNl+zIlgW+5vvYUir0L3WIPrXhLOuIX0mPI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MwMV+aMl4l33qBNIFmoL0MvQd9pKtZOP4n65eTqFxnWyS4Cppu5cvgqik0FjNumnv
	 S93QePlMOz8pRdRMtUEIpqtIMabtJ9bdHYX5YpbCAO5cU2LOtWYqtMmHUPFjH5t3bV
	 /souhdKdFlFsr9DNvI1AOKSIkn/fBki9RB6ZQy7g=
From: Mikhail Kobuk <m.kobuk@ispras.ru>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mikhail Kobuk <m.kobuk@ispras.ru>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v2 2/2] phy: marvell: a3700-comphy: Fix hardcoded array size
Date: Mon, 25 Mar 2024 23:12:50 +0300
Message-ID: <20240325201254.54445-3-m.kobuk@ispras.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325201254.54445-1-m.kobuk@ispras.ru>
References: <20240325201254.54445-1-m.kobuk@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace hardcoded 'gbe_phy_init' array size with defined value.

Fixes: 934337080c6c ("phy: marvell: phy-mvebu-a3700-comphy: Add native kernel implementation")
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
---
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
index 68710ad1ad70..5d6dccfca1fb 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
@@ -43,6 +43,7 @@
 #define COMPHY_LANE_REG_DIRECT(reg)	(((reg) & 0x7FF) << 1)
 
 /* COMPHY registers */
+#define COMPHY_GBE_PHY_MAX_REGS	512
 #define COMPHY_POWER_PLL_CTRL		0x01
 #define PU_IVREF_BIT			BIT(15)
 #define PU_PLL_BIT			BIT(14)
@@ -296,7 +297,7 @@ static struct gbe_phy_init_data_fix gbe_phy_init_fix[] = {
 };
 
 /* 40M1G25 mode init data */
-static u16 gbe_phy_init[512] = {
+static u16 gbe_phy_init[COMPHY_GBE_PHY_MAX_REGS] = {
 	/* 0       1       2       3       4       5       6       7 */
 	/*-----------------------------------------------------------*/
 	/* 8       9       A       B       C       D       E       F */
@@ -603,7 +604,7 @@ static void comphy_gbe_phy_init(struct mvebu_a3700_comphy_lane *lane,
 	u16 val;
 
 	fix_idx = 0;
-	for (addr = 0; addr < 512; addr++) {
+	for (addr = 0; addr < COMPHY_GBE_PHY_MAX_REGS; addr++) {
 		/*
 		 * All PHY register values are defined in full for 3.125Gbps
 		 * SERDES speed. The values required for 1.25 Gbps are almost
-- 
2.44.0


