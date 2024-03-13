Return-Path: <linux-kernel+bounces-102069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A641A87AE23
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207801F2D28C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD02515B0E8;
	Wed, 13 Mar 2024 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNKQXbmk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E439C15AAD1;
	Wed, 13 Mar 2024 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348450; cv=none; b=r2Q5lvAECS+30KECJdQ2yy3r8SUzx1h2jOKjX0QHeFUvkxjPYuveQ2fT6uYeNa6CW+Y8G8vuRuWdIoCNUCkkUGmv/vKxy5Qf7pefqfosrT4WyAgJvB53W3BM3Ts3vZ4P82B4KUJVTtnVBt8UA3TOkKOQLDZm1YnEtI71A9t5dDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348450; c=relaxed/simple;
	bh=uB6Kmj+7UuWh5REtj+8LBvTzv9j9EamYzrZD7GF8gUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHF/NMATbd5HVsavbx7v/eIMJjgcILN8/ie2SKDr4R9rMHW6y68x6AfFybBDo18HFDFnRIJMKDu3VvLbtqJS9BMYbm/WiulFt9avKjEtJXqkz8+XRtVXtx2wRK+5jjhYsfEUMSmh4aXbjnq8mOy65pRVIegWPs1llmoBbaFku5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNKQXbmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62A2C43390;
	Wed, 13 Mar 2024 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348449;
	bh=uB6Kmj+7UuWh5REtj+8LBvTzv9j9EamYzrZD7GF8gUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNKQXbmkhJ7LCg9xnmCMTjudcpvJfWmWRIdPQ9m3/qoTCiMYmTqi0Gv6QUwUEDef1
	 ogDIxx91ZK0YaTMqwxy+o06mcz/Fn9C9HpAkQZwvpptCqc7FLLHyejqWkGwjooDvFl
	 mSdt2TcgOew5lz/lOaBmiIkjLi83AyjwvU6wmQLSXh6jdiggMpkxIw6qcKierVjEte
	 MDPSwnsnwciXICRYAnqggjMJ80c9PdsGJTN2so3UlrdznFl314HRuTo9dUecmieUbK
	 rGRZVNqIQYFitGjciT3ip771sS8k2yr4pPsYOR8Ms1mFUuPgls6ACf5Jcm10MnxX5N
	 0W9wzBpLGr+uA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 43/73] serial: max310x: prevent infinite while() loop in port startup
Date: Wed, 13 Mar 2024 12:46:10 -0400
Message-ID: <20240313164640.616049-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
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
index 80298a5714bcb..978d9d93127e5 100644
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
@@ -1316,6 +1320,9 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		goto out_clk;
 
 	for (i = 0; i < devtype->nr; i++) {
+		bool started = false;
+		unsigned int try = 0, val = 0;
+
 		/* Reset port */
 		regmap_write(regmaps[i], MAX310X_MODE2_REG,
 			     MAX310X_MODE2_RST_BIT);
@@ -1324,8 +1331,17 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
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


