Return-Path: <linux-kernel+bounces-11294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741E681E425
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715B128287A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8459360BB5;
	Tue, 26 Dec 2023 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G22Hqhsf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D042260BA4;
	Tue, 26 Dec 2023 00:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCDFC433C8;
	Tue, 26 Dec 2023 00:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550453;
	bh=CNBU/Y9sLgZ+fGEB2eCCzMGg0xo/YT9sWLvCQfkKNrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G22HqhsfdcixYRmDteh+9SCeR58N2wEBQ2+JWRSi0cMT2asEvcHxRZAcjc4x3JKLh
	 8bym3OqGbGKerGKuG+N8fI7OQ1KnwCv3LOeUtk1kh8kuzv61Ya1XbdPiliNp6iJX9w
	 E6pARRXK8/BTwH5MxtYbn+TZqA5bTOLCAgIS/kuhtMf02jzl6xQah/QfVlEUtMi/it
	 K4UhV7k2Y0QvIf2ijf6Qc92at4u8Vi3MfZO4KjkoDUFdtqOevf3qUWLuDgr2JYExcf
	 /bYWxwkq1pT0v7s9Mwt/MqcD2NEBhlWa8L1Sc+p9SH4Otfi0f3HOYqWOuEBcBuB9Dg
	 /kCq0hHcMRpNA==
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
Subject: [PATCH AUTOSEL 4.14 3/6] pinctrl: amd: Mask non-wake source pins with interrupt enabled at suspend
Date: Mon, 25 Dec 2023 19:27:10 -0500
Message-ID: <20231226002725.7471-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002725.7471-1-sashal@kernel.org>
References: <20231226002725.7471-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.334
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
index 509ba4bceefcb..a5cd88c5dd844 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -766,6 +766,15 @@ int amd_gpio_suspend(struct device *dev)
 
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
index 884f48f7a6a36..065419dabffb5 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -80,6 +80,11 @@ struct amd_pingroup {
 	unsigned npins;
 };
 
+#define WAKE_SOURCE	(BIT(WAKE_CNTRL_OFF_S0I3) | \
+			 BIT(WAKE_CNTRL_OFF_S3)   | \
+			 BIT(WAKE_CNTRL_OFF_S4)   | \
+			 BIT(WAKECNTRL_Z_OFF))
+
 struct amd_function {
 	const char *name;
 	const char * const *groups;
-- 
2.43.0


