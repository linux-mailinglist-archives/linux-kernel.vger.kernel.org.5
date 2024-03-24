Return-Path: <linux-kernel+bounces-113706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE362888624
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAA31C25769
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4561292CC;
	Sun, 24 Mar 2024 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S81hY8g5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F84144D27;
	Sun, 24 Mar 2024 22:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320685; cv=none; b=W2tdxrZgCvSvWsRMheuow7Jh0SBpCvz09ewwIjVKpKq02xK/4/JMr8ac0yDDHk/zaTvYC1Ew1YC0agkPMeq12lgzOm7K1vBoeg6ZUyyJXvkBapInkKY5KGKA6wg1LzzdBmKQ5xERDzTAY29auhSdwV2i3P/dcy4qrznsIAiK4vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320685; c=relaxed/simple;
	bh=z9jUFiSp3MUg0mH6coUgrT0+E54jL2MUqfmnswH9CjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUPH+VDhFYoyrWoUdR+NY4y0esLmH1lb0zbD1oNz3wFI/fDazzsH12u760MYeR39oe8ShWQIPn76wej0u8yPCe9pvJMgCS3+vIjcvBC9ySNBFJEQ6FVF68+wr0NhzHO5lCIujIjv9wnkajfl13n0cnK6IXw97FcieQx0+OP3Tic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S81hY8g5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D991C43141;
	Sun, 24 Mar 2024 22:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320684;
	bh=z9jUFiSp3MUg0mH6coUgrT0+E54jL2MUqfmnswH9CjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S81hY8g5OQ1Nw/ZK8Dcit3jLd9Zo5OaYiqVrbVZWvi8gOJl21Ko8DXoIOVGhVWBas
	 qP108h/MtK0ZVjbCyC41PWWIGszdTc2g225PeD55LYKzPO5x3D0qM6ZbACoEVn0Gam
	 tW9aSCvXq64cb9W13FHWVJ6S8sFkBGIVE/KeVTPM6Z2BaVR32wDA8rErSaH+VVgeVB
	 fH0Vyi2pB7qi4BfYO8CuDtcNyaX3q0LN17AoI6rjKUEXxHJnPPtAu6j1oxdbHYwB9V
	 HwEKHPMzmxevj7PoAtViudvmjaLuGzUn9eNsqShzbEc7Iy50BnsfPcJKFRehxsS8zC
	 vn5ov24NisslQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	Simon Horman <horms@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 247/713] can: m_can: Start/Cancel polling timer together with interrupts
Date: Sun, 24 Mar 2024 18:39:33 -0400
Message-ID: <20240324224720.1345309-248-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Markus Schneider-Pargmann <msp@baylibre.com>

[ Upstream commit a163c5761019b94258ca655b27b46e82657fd6f5 ]

Interrupts are enabled/disabled in more places than just m_can_start()
and m_can_stop(). Couple the polling timer with enabling/disabling of
all interrupts to achieve equivalent behavior.

Cc: Judith Mendez <jm@ti.com>
Fixes: b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/all/20240207093220.2681425-2-msp@baylibre.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/m_can/m_can.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16ecc11c7f62a..2395b1225cc8a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -418,6 +418,13 @@ static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
 
 static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 {
+	if (!cdev->net->irq) {
+		dev_dbg(cdev->dev, "Start hrtimer\n");
+		hrtimer_start(&cdev->hrtimer,
+			      ms_to_ktime(HRTIMER_POLL_INTERVAL_MS),
+			      HRTIMER_MODE_REL_PINNED);
+	}
+
 	/* Only interrupt line 0 is used in this driver */
 	m_can_write(cdev, M_CAN_ILE, ILE_EINT0);
 }
@@ -425,6 +432,11 @@ static inline void m_can_enable_all_interrupts(struct m_can_classdev *cdev)
 static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 {
 	m_can_write(cdev, M_CAN_ILE, 0x0);
+
+	if (!cdev->net->irq) {
+		dev_dbg(cdev->dev, "Stop hrtimer\n");
+		hrtimer_cancel(&cdev->hrtimer);
+	}
 }
 
 /* Retrieve internal timestamp counter from TSCV.TSC, and shift it to 32-bit
@@ -1417,12 +1429,6 @@ static int m_can_start(struct net_device *dev)
 
 	m_can_enable_all_interrupts(cdev);
 
-	if (!dev->irq) {
-		dev_dbg(cdev->dev, "Start hrtimer\n");
-		hrtimer_start(&cdev->hrtimer, ms_to_ktime(HRTIMER_POLL_INTERVAL_MS),
-			      HRTIMER_MODE_REL_PINNED);
-	}
-
 	return 0;
 }
 
@@ -1577,11 +1583,6 @@ static void m_can_stop(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
-	if (!dev->irq) {
-		dev_dbg(cdev->dev, "Stop hrtimer\n");
-		hrtimer_cancel(&cdev->hrtimer);
-	}
-
 	/* disable all interrupts */
 	m_can_disable_all_interrupts(cdev);
 
-- 
2.43.0


