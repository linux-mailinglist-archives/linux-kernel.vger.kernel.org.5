Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFB275E623
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGXBPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjGXBPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:15:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F18171F;
        Sun, 23 Jul 2023 18:14:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4229D60F12;
        Mon, 24 Jul 2023 01:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E122C433C9;
        Mon, 24 Jul 2023 01:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161282;
        bh=d4eXRz0DdDLvFLaxxi/lCZokUOFZ/nt3xxZcPl9Zuo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nv9B7ec5jSFyOeJwCgCS2XKMXG/43j7xqHWI19hJjSHfPupRzjcT4zcm153cM8K2M
         RU7oBbrlHipoWzRO1O6wRpK1sirp4SFneBSEjWMPtUcXZ1Ms7nE6ndz7j8f0Pm80e+
         gzklUDYYqw3X6O+hIy9FDCRRmu/F70mz7sJkmL1kMcijAoKExsnKW9cInJcBchddMZ
         5CszfXw+zFSnXEWLtNshjS0DhY7q8UZV/6wGQJvh8MOYbFB1YAHxWDBJDu61iuY/IU
         shbKsvXVf8PjtJR8TCXKFUE/yguFQF1oNzh3rK3/X9Tx3QzS+r0cC5I4eFReNSBjZW
         hqjIQfiVN6Fsg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, james.schulman@cirrus.com,
        david.rhodes@cirrus.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 6.4 13/58] ASoC: cs35l56: Move DSP part string generation so that it is done only once
Date:   Sun, 23 Jul 2023 21:12:41 -0400
Message-Id: <20230724011338.2298062-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit 608f1b0dbddec6b2fd766c10bcce2b651995e936 ]

Each time we go through dsp_work() it does a devm_kasprintf() to
allocate memory to hold the part name string. It's not strictly a memory
leak because devm will free it all if the driver is removed. But we keep
allocating more and more memory to hold the same string.

Move the allocation so that it is performed after the version and
secured state information is gathered and handle allocation errors.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://lore.kernel.org/r/Message-Id: <20230518150250.1121006-2-rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index e0d2b9bb23262..f3fee448d759e 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -834,12 +834,6 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	if (!cs35l56->init_done)
 		return;
 
-	cs35l56->dsp.part = devm_kasprintf(cs35l56->dev, GFP_KERNEL, "cs35l56%s-%02x",
-					   cs35l56->secured ? "s" : "", cs35l56->rev);
-
-	if (!cs35l56->dsp.part)
-		return;
-
 	pm_runtime_get_sync(cs35l56->dev);
 
 	/*
@@ -1505,6 +1499,12 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 	dev_info(cs35l56->dev, "Cirrus Logic CS35L56%s Rev %02X OTP%d\n",
 		 cs35l56->secured ? "s" : "", cs35l56->rev, otpid);
 
+	/* Populate the DSP information with the revision and security state */
+	cs35l56->dsp.part = devm_kasprintf(cs35l56->dev, GFP_KERNEL, "cs35l56%s-%02x",
+					   cs35l56->secured ? "s" : "", cs35l56->rev);
+	if (!cs35l56->dsp.part)
+		return -ENOMEM;
+
 	/* Wake source and *_BLOCKED interrupts default to unmasked, so mask them */
 	regmap_write(cs35l56->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
 	regmap_update_bits(cs35l56->regmap, CS35L56_IRQ1_MASK_1,
-- 
2.39.2

