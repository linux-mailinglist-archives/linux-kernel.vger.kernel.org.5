Return-Path: <linux-kernel+bounces-110409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABC885ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7B91F21D93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5519D136643;
	Thu, 21 Mar 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="BDfOSsfV"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE552135416
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039667; cv=none; b=bSESpuSCCwT8Ne9TYyC2cxyJCYE09w7rRysTpxeqOZExGEwmVxA3YKIMrVEhd7MRixdnbjbyvWgqKgMxHr7/xwV4Sb0bZALmYspOOULuMSsHu8eSEfjBWiUWUDo2GqK8CmyZ9q0VI1QdihiJyIpdteLQVAYXHeqCbADga1Wl79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039667; c=relaxed/simple;
	bh=ObSkPqFRupEoH5y/NCq6OrbSWOqqf4R3pFWwnS4ji9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=htbpHary3wd00AskKzaG77eeToBx/uZXumQJzYXmSN7VDp7QrxeyLOuYWGJ6mcoTc5/6AS2huJ5zkxm9GDMnLIjrVvZDcigP9Q3OZ233gKmuPpYEQJQuKBNN/8j9JXolPjt4zQk963mX2Gu7xlnEHpVS0F4VTek4lqE8At50B2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=BDfOSsfV; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from tundra.lovozera (unknown [83.149.199.65])
	by mail.ispras.ru (Postfix) with ESMTPSA id F250040762DC;
	Thu, 21 Mar 2024 16:47:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F250040762DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1711039655;
	bh=rS+8oI4jnnlG0/QZtTc1eLuWcBGGVJJauaKM2Qw7ri8=;
	h=From:To:Cc:Subject:Date:From;
	b=BDfOSsfVeGPh5T+R82Aje3euP6f6ftZ+CKtxP5L1EhePArHYJkbCD9gA2hcrC/x74
	 nvlTSpqLefevcP/JPjm1V6SXYEel4zVaC9vA16bWILz4ml+/B6l/JMTJumfCgSb4fh
	 R7c4xUg2F+danH1/bxbOgILAFnr4LcrIHnvh+7cM=
From: Mikhail Kobuk <m.kobuk@ispras.ru>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mikhail Kobuk <m.kobuk@ispras.ru>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 1/2] phy: marvell: a3700-comphy: Fix out of bounds read
Date: Thu, 21 Mar 2024 19:47:30 +0300
Message-ID: <20240321164734.49273-1-m.kobuk@ispras.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is an out of bounds read access of 'gbe_phy_init_fix[fix_idx].addr'
every iteration after 'fix_idx' reaches 'ARRAY_SIZE(gbe_phy_init_fix)'.

Make sure 'gbe_phy_init[addr]' is used when all elements of
'gbe_phy_init_fix' array are handled.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 934337080c6c ("phy: marvell: phy-mvebu-a3700-comphy: Add native kernel implementation")
Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
---
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
index 15bf10710de0..1d1db1737422 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
@@ -611,11 +611,12 @@ static void comphy_gbe_phy_init(struct mvebu_a3700_comphy_lane *lane,
 		 * comparison to 3.125 Gbps values. These register values are
 		 * stored in "gbe_phy_init_fix" array.
 		 */
-		if (!is_1gbps && gbe_phy_init_fix[fix_idx].addr == addr) {
+		if (!is_1gbps &&
+		    fix_idx < ARRAY_SIZE(gbe_phy_init_fix) &&
+		    gbe_phy_init_fix[fix_idx].addr == addr) {
 			/* Use new value */
 			val = gbe_phy_init_fix[fix_idx].value;
-			if (fix_idx < ARRAY_SIZE(gbe_phy_init_fix))
-				fix_idx++;
+			fix_idx++;
 		} else {
 			val = gbe_phy_init[addr];
 		}
-- 
2.44.0


