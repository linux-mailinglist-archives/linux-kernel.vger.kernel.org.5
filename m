Return-Path: <linux-kernel+bounces-113080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733DF88814E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FA2284B29
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE2414D45B;
	Sun, 24 Mar 2024 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1JJ/q3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF75478B;
	Sun, 24 Mar 2024 22:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319888; cv=none; b=bEUKGchqWcfbD0quaNhmi2sP0oH6u/Fx9k/qFg3Nf5zn2rXb3x2JBd7U4fMDcIXSaVNmd2nfVh9xhudK+dW86HGi2K0CTEjWdfVTX3amIAVm+IQkvo77srlsYN8jgUIFj7Ug0vAA8hfTeUPS81J0zXgKGDHOBcZMkZfvdbY2+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319888; c=relaxed/simple;
	bh=z9jUFiSp3MUg0mH6coUgrT0+E54jL2MUqfmnswH9CjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmnyCtoVUlPpVAj1LgPqSWvxB+LLuaPYYi86lkrEYdVeTFr9MFdKBX8aGsjVwpYatEwY0oSjI3OoFvMqd/QGpalywtNp4l6gtiAFxRG2gYeiWLtEyB9lcll32nt0X3aYozlTZ1PHFxJXloPYT8Zpd01EMLu4WDMM2Clq6PYK62o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1JJ/q3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2800C433C7;
	Sun, 24 Mar 2024 22:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319888;
	bh=z9jUFiSp3MUg0mH6coUgrT0+E54jL2MUqfmnswH9CjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1JJ/q3SNaOZWuXw4+j/K3Rpli7oZboruScfIueAoFvruaZmZBGeKXUmAFm6j5mkZ
	 wZyUluhg9+tN+RWOWMXrJsm6d+ebGivq24/+4gi8rTzJ2AtT0h1IPHKa0IB68G7O/a
	 Gpa5/WDR9MXmyrwrhyk6M19TOtcAoTxAN/uhdvWvIS1eIikZQCgGAt33jEvNx/fTgx
	 z6WWb25Q11Tw4CMu4ZOPjp8pkV1oj3T+VPCHVxEZBM+nvaJS1QpyUIWIuIaI1U7nMN
	 8trn+tXCzh+JBYm3Uqygrlvc8qfpuY2NyAzAU+1L8zpADbsHtJNZ/Y0fmng3MmLXaq
	 fuJv4O9tsniUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	Simon Horman <horms@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 193/715] can: m_can: Start/Cancel polling timer together with interrupts
Date: Sun, 24 Mar 2024 18:26:12 -0400
Message-ID: <20240324223455.1342824-194-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


