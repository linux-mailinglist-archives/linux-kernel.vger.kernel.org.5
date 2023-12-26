Return-Path: <linux-kernel+bounces-11203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D238D81E329
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D091F22B23
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D35315AB;
	Tue, 26 Dec 2023 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOttoE7/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C02B9A9;
	Tue, 26 Dec 2023 00:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA801C433C7;
	Tue, 26 Dec 2023 00:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550048;
	bh=YwAUDk2O7jZ3ayjcOZqcpgvN3sizoAP2Yh7Qg+NPqhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOttoE7/VrGFWvM83faNC6nx+jV4CpJmaOIgdMcGOPM89KKSoyht+IYoxrOMsCt9N
	 aBMryAMbrUQitOMTgRW5ne32eBkxDMNRF4UsTRPTEvRSU8mq0d6PzH2+gZGYo/IU/s
	 jIMPYWmp45YzpstcElKXWnRdXiZLokz527gy7KEhAZr4I7Ay4D9z3dUu/71CLTWnEq
	 TxD414RiTarajc8Xvr6DygzpjE6sBmw6lSQILZacAOlynR1qIg/Ot7xUxG3Rk1y7w2
	 zKkQlEb5lMS6aFRdfLM8qLvTVHrSd3018FAco/nKgSYzBx7XdoWoceQGSeOJMLZz1m
	 K6awmspZZkTqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/39] ASoC: cs35l45: Prevents spinning during runtime suspend
Date: Mon, 25 Dec 2023 19:19:00 -0500
Message-ID: <20231226002021.4776-10-sashal@kernel.org>
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

From: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>

[ Upstream commit a0ffa8115e1ea9786b03edc3f431d2f4ef3e7a2e ]

Masks the "DSP Virtual Mailbox 2 write" interrupt when before
issuing the hibernate command to the DSP. The interrupt is
unmasked when exiting runtime suspend as it is required for
DSP operation.

Without this change the DSP fires an interrupt when hibernating
causing the system spin between runtime suspend and runtime
resume.

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231206160318.1255034-4-rriveram@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l45.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index 310747b7689d3..9b9fc2d491089 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -775,6 +775,8 @@ static int cs35l45_enter_hibernate(struct cs35l45_private *cs35l45)
 
 	cs35l45_setup_hibernate(cs35l45);
 
+	regmap_set_bits(cs35l45->regmap, CS35L45_IRQ1_MASK_2, CS35L45_DSP_VIRT2_MBOX_MASK);
+
 	// Don't wait for ACK since bus activity would wake the device
 	regmap_write(cs35l45->regmap, CS35L45_DSP_VIRT1_MBOX_1, CSPL_MBOX_CMD_HIBERNATE);
 
@@ -795,6 +797,8 @@ static int cs35l45_exit_hibernate(struct cs35l45_private *cs35l45)
 					  CSPL_MBOX_CMD_OUT_OF_HIBERNATE);
 			if (!ret) {
 				dev_dbg(cs35l45->dev, "Wake success at cycle: %d\n", j);
+				regmap_clear_bits(cs35l45->regmap, CS35L45_IRQ1_MASK_2,
+						 CS35L45_DSP_VIRT2_MBOX_MASK);
 				return 0;
 			}
 			usleep_range(100, 200);
-- 
2.43.0


