Return-Path: <linux-kernel+bounces-101990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B11387AD62
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161EC282EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE431487E1;
	Wed, 13 Mar 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfQX2Qdo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6344149019;
	Wed, 13 Mar 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348201; cv=none; b=r6VAkfG8KpZvUNP4xCdEzzfM9Vx/1rc7QDBR/E6b81AVUYxyHyeX8P+hbyjMF9ppZbtN15EXw5X1GznqN4Ml3iKTpb+Ec4j/2v3JAnIO/E9RFx6BXdw36Gdw47Qfl4CV49GOv8UPi3vCOil8771sDalQMP9NhlFyLYAzRwthvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348201; c=relaxed/simple;
	bh=E+O2824pnAebbyG8An1Pn9KJS1r4lPV+GKukQp0+tR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qzo6Go7FwAKUNCvtAoH/+9y86KAr+jq6T7oQB8mofHwIuZadhir/5Gb118ZCbe4UN0V5XxP5IQKajomRPHSmOwpDVUo0K+infoLSDWpDPvaRdWTyDDheqkwsa5nk1uM0xh/nfXfBxQMLYUjicfFx4ZyEFCMtXfoEqRSP686ZRLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfQX2Qdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CF4C433F1;
	Wed, 13 Mar 2024 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348201;
	bh=E+O2824pnAebbyG8An1Pn9KJS1r4lPV+GKukQp0+tR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfQX2Qdor89Ccr7z4rO+ILZB74KkMWL2jzSgQ9tuyphUDng4EsGjOiapl8C8qoA8k
	 /JaObncRMoXf1FADuXKWwhqDa4ELbcfgt1lHxtXX78dYf+ACleuvBeW/Nct/KfmXMq
	 4SPu+9LLgV61n3vXqA4Z20cobKg5DkMN/r0D6Sben5yigC0juf5yleKCXTL6ckmAsc
	 mbMzNOTkqHrErG9kbf+RHmETbPBkwtdUhMvjv8w45nwoajjvXqcsxTe8/LHT+dh7xZ
	 f3TOKuCaMtBntNItZNvYFuRgz8sM3PoHHIwQw3gXZ7hyGEBiEaYKvQCE8KLnMfLcwy
	 2Klz3aqWSXd4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 50/76] serial: max310x: prevent infinite while() loop in port startup
Date: Wed, 13 Mar 2024 12:41:57 -0400
Message-ID: <20240313164223.615640-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit b35f8dbbce818b02c730dc85133dc7754266e084 ]

If there is a problem after resetting a port, the do/while() loop that
checks the default value of DIVLSB register may run forever and spam the
I2C bus.

Add a delay before each read of DIVLSB, and a maximum number of tries to
prevent that situation from happening.

Also fail probe if port reset is unsuccessful.

Fixes: 10d8b34a4217 ("serial: max310x: Driver rework")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240116213001.3691629-5-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/max310x.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index d61e8a6bc99dd..41251fdf7c845 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -235,6 +235,10 @@
 #define MAX310x_REV_MASK		(0xf8)
 #define MAX310X_WRITE_BIT		0x80
 
+/* Port startup definitions */
+#define MAX310X_PORT_STARTUP_WAIT_RETRIES	20 /* Number of retries */
+#define MAX310X_PORT_STARTUP_WAIT_DELAY_MS	10 /* Delay between retries */
+
 /* Crystal-related definitions */
 #define MAX310X_XTAL_WAIT_RETRIES	20 /* Number of retries */
 #define MAX310X_XTAL_WAIT_DELAY_MS	10 /* Delay between retries */
@@ -1312,6 +1316,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		goto out_clk;
 
 	for (i = 0; i < devtype->nr; i++) {
+		bool started = false;
+		unsigned int try = 0, val = 0;
+
 		/* Reset port */
 		regmap_write(regmaps[i], MAX310X_MODE2_REG,
 			     MAX310X_MODE2_RST_BIT);
@@ -1320,8 +1327,17 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 		/* Wait for port startup */
 		do {
-			regmap_read(regmaps[i], MAX310X_BRGDIVLSB_REG, &ret);
-		} while (ret != 0x01);
+			msleep(MAX310X_PORT_STARTUP_WAIT_DELAY_MS);
+			regmap_read(regmaps[i], MAX310X_BRGDIVLSB_REG, &val);
+
+			if (val == 0x01)
+				started = true;
+		} while (!started && (++try < MAX310X_PORT_STARTUP_WAIT_RETRIES));
+
+		if (!started) {
+			ret = dev_err_probe(dev, -EAGAIN, "port reset failed\n");
+			goto out_uart;
+		}
 
 		regmap_write(regmaps[i], MAX310X_MODE1_REG, devtype->mode1);
 	}
-- 
2.43.0


