Return-Path: <linux-kernel+bounces-28153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4604A82FAE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4841C2660A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA3415CD46;
	Tue, 16 Jan 2024 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H37RzDKS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9E15B104;
	Tue, 16 Jan 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435289; cv=none; b=nhiuIs+lH4oddn4JGnKi4mYrho0LZPG+QocNpIdUxUkFIPnlVhlUZY+J7Rjk8/AvjCInjenONMiAz7zBttCFXf6v0mkAwR5TgCuRDEdzg6GyLw9lZFAUCYZTjNI1fB/zyL6kchs2d7Zmfi2YfYnTIyRl8PMhagzN35nMFqQ47GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435289; c=relaxed/simple;
	bh=NgsTHnbiVwnN6GIUkHa49WnVUvfg/+MX78YOYsiIH/w=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=f32Dks540R1Dzu561gArlrOhQwYziZf1U4a41x3WrX8G9ZoeersbH2D0sHofNrP2y3ONUv+zgbQpnTRd9dG0IktFAEooyFwhycajkjmhq3PusiZRUhTIvaOgPLecCRriDGsXTnq+BlSidYP8qoercrQfdGk5XHjvQXhYDkUE7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H37RzDKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CED9C433C7;
	Tue, 16 Jan 2024 20:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435289;
	bh=NgsTHnbiVwnN6GIUkHa49WnVUvfg/+MX78YOYsiIH/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H37RzDKSICVC05+jmoV52OVMBgm10CT+JhGjEHL9azv1NczbZRW6VMOKq1lDsTKbZ
	 e6iU8vdle0sIRDkISLka4pDwoHXoG8DTJhrjMQ/NLilMLoXK/Y1ZqQFLByQsm13/Gg
	 bCIE4ELYV1LrZaZ404VSIBPa9lfbXrCVMngrCG22jank2g5wnb64kLwE+phGi5EW3H
	 2AgHzQqTTJ4RKn0poS/Bh9egr/DV5tNdNf6J6i2r3Z3/ILbqDBSIRjdf245K8/Nu3c
	 YP/Rc9PPM+j4CTfh50SpjgSo/xvD4TyRl/bnTwlrYe81lUOL35vRIGVWsXy/QECDP9
	 jLyx1RKaT33Qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tobias Waldekranz <tobias@waldekranz.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	krzysztof.kozlowski@linaro.org,
	robh@kernel.org,
	u.kleine-koenig@pengutronix.de,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 17/44] net: mvmdio: Avoid excessive sleeps in polled mode
Date: Tue, 16 Jan 2024 14:59:46 -0500
Message-ID: <20240116200044.258335-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Tobias Waldekranz <tobias@waldekranz.com>

[ Upstream commit 7dd12fe34686d89c332b1a05104d18d728591f0a ]

Before this change, when operating in polled mode, i.e. no IRQ is
available, every individual C45 access would be hit with a 150us sleep
after the bus access.

For example, on a board with a CN9130 SoC connected to an MV88X3310
PHY, a single C45 read would take around 165us:

    root@infix:~$ mdio f212a600.mdio-mii mmd 4:1 bench 0xc003
    Performed 1000 reads in 165ms

By replacing the long sleep with a tighter poll loop, we observe a 10x
increase in bus throughput:

    root@infix:~$ mdio f212a600.mdio-mii mmd 4:1 bench 0xc003
    Performed 1000 reads in 15ms

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20231204100811.2708884-3-tobias@waldekranz.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvmdio.c | 53 ++++++++-------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index d14762d93640..28967a7b8df2 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -56,11 +57,6 @@
  * - Armada 370       (Globalscale Mirabox):   41us to 43us (Polled)
  */
 #define MVMDIO_SMI_TIMEOUT		1000 /* 1000us = 1ms */
-#define MVMDIO_SMI_POLL_INTERVAL_MIN	45
-#define MVMDIO_SMI_POLL_INTERVAL_MAX	55
-
-#define MVMDIO_XSMI_POLL_INTERVAL_MIN	150
-#define MVMDIO_XSMI_POLL_INTERVAL_MAX	160
 
 struct orion_mdio_dev {
 	void __iomem *regs;
@@ -82,8 +78,6 @@ enum orion_mdio_bus_type {
 
 struct orion_mdio_ops {
 	int (*is_done)(struct orion_mdio_dev *);
-	unsigned int poll_interval_min;
-	unsigned int poll_interval_max;
 };
 
 /* Wait for the SMI unit to be ready for another operation
@@ -92,34 +86,23 @@ static int orion_mdio_wait_ready(const struct orion_mdio_ops *ops,
 				 struct mii_bus *bus)
 {
 	struct orion_mdio_dev *dev = bus->priv;
-	unsigned long timeout = usecs_to_jiffies(MVMDIO_SMI_TIMEOUT);
-	unsigned long end = jiffies + timeout;
-	int timedout = 0;
+	unsigned long timeout;
+	int done;
 
-	while (1) {
-	        if (ops->is_done(dev))
+	if (dev->err_interrupt <= 0) {
+		if (!read_poll_timeout_atomic(ops->is_done, done, done, 2,
+					      MVMDIO_SMI_TIMEOUT, false, dev))
+			return 0;
+	} else {
+		/* wait_event_timeout does not guarantee a delay of at
+		 * least one whole jiffie, so timeout must be no less
+		 * than two.
+		 */
+		timeout = max(usecs_to_jiffies(MVMDIO_SMI_TIMEOUT), 2);
+
+		if (wait_event_timeout(dev->smi_busy_wait,
+				       ops->is_done(dev), timeout))
 			return 0;
-	        else if (timedout)
-			break;
-
-	        if (dev->err_interrupt <= 0) {
-			usleep_range(ops->poll_interval_min,
-				     ops->poll_interval_max);
-
-			if (time_is_before_jiffies(end))
-				++timedout;
-	        } else {
-			/* wait_event_timeout does not guarantee a delay of at
-			 * least one whole jiffie, so timeout must be no less
-			 * than two.
-			 */
-			if (timeout < 2)
-				timeout = 2;
-			wait_event_timeout(dev->smi_busy_wait,
-				           ops->is_done(dev), timeout);
-
-			++timedout;
-	        }
 	}
 
 	dev_err(bus->parent, "Timeout: SMI busy for too long\n");
@@ -133,8 +116,6 @@ static int orion_mdio_smi_is_done(struct orion_mdio_dev *dev)
 
 static const struct orion_mdio_ops orion_mdio_smi_ops = {
 	.is_done = orion_mdio_smi_is_done,
-	.poll_interval_min = MVMDIO_SMI_POLL_INTERVAL_MIN,
-	.poll_interval_max = MVMDIO_SMI_POLL_INTERVAL_MAX,
 };
 
 static int orion_mdio_smi_read(struct mii_bus *bus, int mii_id,
@@ -198,8 +179,6 @@ static int orion_mdio_xsmi_is_done(struct orion_mdio_dev *dev)
 
 static const struct orion_mdio_ops orion_mdio_xsmi_ops = {
 	.is_done = orion_mdio_xsmi_is_done,
-	.poll_interval_min = MVMDIO_XSMI_POLL_INTERVAL_MIN,
-	.poll_interval_max = MVMDIO_XSMI_POLL_INTERVAL_MAX,
 };
 
 static int orion_mdio_xsmi_read(struct mii_bus *bus, int mii_id,
-- 
2.43.0


