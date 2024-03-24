Return-Path: <linux-kernel+bounces-114171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660B68888DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973C41C27151
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631D5206072;
	Sun, 24 Mar 2024 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFEiS2ex"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D32057F9;
	Sun, 24 Mar 2024 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321491; cv=none; b=hwWceyWaJaa6EJf88tP1mz4a9gfSmKdsDi3849yeQKd9373LNQcHlwRHC9/uPvgY7/sAyN9Vb6FoA/EWWBZilsMSy3A7VckjTCGXv6b6nKg8uq/Qj2XU21oKzmWrsuFavEBugkNYmtln7VweMd1fes02v1tKJXS29XSHef4dUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321491; c=relaxed/simple;
	bh=z9jUFiSp3MUg0mH6coUgrT0+E54jL2MUqfmnswH9CjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7cvxyfyWimISkwm3oJVcKi+TpCrO2353AFAB3xbhtlfgAFkIAGcNkO+XIolWHI0bKNeLPLPURi7vmrPNLNPIrFlyzI4NN+hOGwVf+YTjRvPXHWd/or1dVQ9d7NckX4WJNz9rxNaj/plHyCkzCW3HTxl6JNXmAwJe5XCbKW+TqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFEiS2ex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C903C43390;
	Sun, 24 Mar 2024 23:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321490;
	bh=z9jUFiSp3MUg0mH6coUgrT0+E54jL2MUqfmnswH9CjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFEiS2exCdKKt7wvDiPm10iriDzXh2lGMZMMnSZoEruQaK8x0jo3g9asIba6D08Pb
	 HwRf2rk9feUZdNoE46S1nYLqPYqS7vRSjHxxD+gf6NCWuLDj3gevv0EbY26IhqAJ9s
	 fYFMf363IDWvbFJH72oiAkQKjbwD7fwvB6dZD7xrqVy4W2YtxVe9BTyPEe21x6aaUi
	 rmBkzL9gki8Csxr9kziOtdDF93kZpCDFW+ur7EWl71MYewVbMkegTkfwyTu4S+X7XU
	 X98LJTXBStvK06+idG8IRNmAWvXlic/31H9x6/uZ5Z47X2I9KF1j/Wh9oJPpPqKXRi
	 cyYFKj55ppqsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	Simon Horman <horms@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 215/638] can: m_can: Start/Cancel polling timer together with interrupts
Date: Sun, 24 Mar 2024 18:54:12 -0400
Message-ID: <20240324230116.1348576-216-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


