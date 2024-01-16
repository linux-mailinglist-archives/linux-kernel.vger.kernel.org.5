Return-Path: <linux-kernel+bounces-28105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A3182FA60
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29843B27964
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF496313D;
	Tue, 16 Jan 2024 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0GmMxBl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25746312D;
	Tue, 16 Jan 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435154; cv=none; b=aGDntkyji+sHGARACnlfPQYDxIDg0aBSPu8l6jZyh8MdT/oUb1UU+H6/u8wG5jx2JiwxG5tstM/Af+TKTJwYyYDT+IhdN+TZbAdiBNTZaf5E+xvp+blSgWEFTCheq4Az+QpGotzQ9UbQrgx+IxnIYAWUwi7WVyKui6bw25+8hZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435154; c=relaxed/simple;
	bh=jg6VgF/EuOdf/AZ8IrPRAm/o2oDTU1Re8n9z1HgWtrI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=uzeT5aVkRNXk/PThxrv0ZVUH19W3nYucTutI/Z+a8vC7Q1k3068xw0LXDEkKFXXAsc5L47VyqF3Cn2PSFD0p8Royzg2c74WDS7g906gqTg4wxymg7mislZft+3LxkZHlrgzLbtads8L4g7CrOzsER4Vl60S7igAn1jcPbdgMpx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0GmMxBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C5CC433F1;
	Tue, 16 Jan 2024 19:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435153;
	bh=jg6VgF/EuOdf/AZ8IrPRAm/o2oDTU1Re8n9z1HgWtrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0GmMxBlXaZDxofH/xMRi+Or5OXPBYepDsKinfRrOR3HGMHbgrWWxEe6ygpfmsoXH
	 IWZowOd9RboJkRrDNqZRtJ9D62hSPyd7dH9TDafUwRddMJ0/lgSasM5yha9NScMfaq
	 jo/s4i3pCCr5mJtj7rPLypsH5ubavfznC+WdrULxeYm+yMtZXAckoTCaoEix+Grgca
	 VtP8H5P5ec6LABw2EuOdX7SpITBHzkNajau71CRLPXdsG2b+bmN1I1gCc3nLbi9pX8
	 BoQR96Sm73D5KTCKVK26HzkY8Ohm05bQJmpZybT4SpXugZrMiuidaDGAQBfLZBoOax
	 DX3TTAdcXZ7pw==
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
	u.kleine-koenig@pengutronix.de,
	robh@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 18/47] net: mvmdio: Avoid excessive sleeps in polled mode
Date: Tue, 16 Jan 2024 14:57:21 -0500
Message-ID: <20240116195834.257313-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index ef878973b859..b4c576e79a95 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -58,11 +59,6 @@
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
@@ -84,8 +80,6 @@ enum orion_mdio_bus_type {
 
 struct orion_mdio_ops {
 	int (*is_done)(struct orion_mdio_dev *);
-	unsigned int poll_interval_min;
-	unsigned int poll_interval_max;
 };
 
 /* Wait for the SMI unit to be ready for another operation
@@ -94,34 +88,23 @@ static int orion_mdio_wait_ready(const struct orion_mdio_ops *ops,
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
@@ -135,8 +118,6 @@ static int orion_mdio_smi_is_done(struct orion_mdio_dev *dev)
 
 static const struct orion_mdio_ops orion_mdio_smi_ops = {
 	.is_done = orion_mdio_smi_is_done,
-	.poll_interval_min = MVMDIO_SMI_POLL_INTERVAL_MIN,
-	.poll_interval_max = MVMDIO_SMI_POLL_INTERVAL_MAX,
 };
 
 static int orion_mdio_smi_read(struct mii_bus *bus, int mii_id,
@@ -200,8 +181,6 @@ static int orion_mdio_xsmi_is_done(struct orion_mdio_dev *dev)
 
 static const struct orion_mdio_ops orion_mdio_xsmi_ops = {
 	.is_done = orion_mdio_xsmi_is_done,
-	.poll_interval_min = MVMDIO_XSMI_POLL_INTERVAL_MIN,
-	.poll_interval_max = MVMDIO_XSMI_POLL_INTERVAL_MAX,
 };
 
 static int orion_mdio_xsmi_read(struct mii_bus *bus, int mii_id,
-- 
2.43.0


