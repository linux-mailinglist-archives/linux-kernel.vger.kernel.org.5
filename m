Return-Path: <linux-kernel+bounces-11199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFC781E31F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49061F22501
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30EB66E;
	Tue, 26 Dec 2023 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOTBumd4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A163AD;
	Tue, 26 Dec 2023 00:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D4BC433C8;
	Tue, 26 Dec 2023 00:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550040;
	bh=GpwQqUeeo7Qp19pOKugu5fFK+Qp8yciRrnemQCjQ5K8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lOTBumd47DG0/+raW4moeqj05I1oj0ZVuzGWFhEelWmyAphD6LreE1v0KAdbg9Gzm
	 28VcAXVsxXEHL2Qsa+Y7U2k8Fczu/9+0sPlkLOJDj4jjDrYL5+YlcfkjnSspmXkIAd
	 5j63G3HDZ1aaI5YvHtdo1VLzwjZ+H/mkXqv6snad+ayRKz2hB4kFohvrx0Sp4qgTiG
	 FX4MzgCrFv5A3luIYAJGo/b+nPA0rpHM80w0AFHVNaABLQcquIzfqdMmqIUF0aFmn5
	 jgCDI758qY1mppVKM+LRIlh7L/Ki7QNgItGaUXH0RrWZ1F/10A0eWX/N2y+o4lz1mF
	 dbGrUh75ddkXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Marcus Aram <marcus+oss@oxar.nl>,
	Mark Herbert <mark.herbert42@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/39] pinctrl: amd: Mask non-wake source pins with interrupt enabled at suspend
Date: Mon, 25 Dec 2023 19:18:56 -0500
Message-ID: <20231226002021.4776-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 2fff0b5e1a6b9c577b4dd4958902c877159c856b ]

If a pin isn't marked as a wake source processing any interrupts is
just going to destroy battery life.  The APU may wake up from a hardware
sleep state to process the interrupt but not return control to the OS.

Mask interrupt for all non-wake source pins at suspend. They'll be
re-enabled at resume.

Reported-and-tested-by: Marcus Aram <marcus+oss@oxar.nl>
Reported-and-tested-by: Mark Herbert <mark.herbert42@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2812
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20231203032431.30277-3-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-amd.c | 9 +++++++++
 drivers/pinctrl/pinctrl-amd.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 74241b2ff21e3..86034c457c043 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -923,6 +923,15 @@ static int amd_gpio_suspend(struct device *dev)
 
 		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 		gpio_dev->saved_regs[i] = readl(gpio_dev->base + pin * 4) & ~PIN_IRQ_PENDING;
+
+		/* mask any interrupts not intended to be a wake source */
+		if (!(gpio_dev->saved_regs[i] & WAKE_SOURCE)) {
+			writel(gpio_dev->saved_regs[i] & ~BIT(INTERRUPT_MASK_OFF),
+			       gpio_dev->base + pin * 4);
+			pm_pr_dbg("Disabling GPIO #%d interrupt for suspend.\n",
+				  pin);
+		}
+
 		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 	}
 
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 34c5c3e71fb26..cf59089f27763 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -80,6 +80,11 @@
 #define FUNCTION_MASK		GENMASK(1, 0)
 #define FUNCTION_INVALID	GENMASK(7, 0)
 
+#define WAKE_SOURCE	(BIT(WAKE_CNTRL_OFF_S0I3) | \
+			 BIT(WAKE_CNTRL_OFF_S3)   | \
+			 BIT(WAKE_CNTRL_OFF_S4)   | \
+			 BIT(WAKECNTRL_Z_OFF))
+
 struct amd_function {
 	const char *name;
 	const char * const groups[NSELECTS];
-- 
2.43.0


