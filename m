Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A576769363
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGaKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjGaKrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:47:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AD2E6C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:47:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E96A61013
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B15C433C8;
        Mon, 31 Jul 2023 10:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690800435;
        bh=YnJy0NhEnRLR/JM2gYOkdO9V3g9/7Ef01+MnHCUiCJc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PZ72nFU06LGBPFHONQqduy+pDgblluRx0gmqJElkRxU4F5jnkuGHP6pFYg+bfsc+v
         Llk6VUy9xTSFbbhkVmuGN32BF5/8Zfy5pxTxHRhpkyOqaz7whw6GKEOZGiEFlHq7se
         LZ10qPnfh7F5T0s0f4fKfhRQ+LqQdQyth1Ep1xqGE30BCqPDBgv/X6e12yuQIOp/W6
         9ZhehqQhUQ08LkTtjmRDbwRG7mCm0sqMWhZIRMcHUvwrFLBaM3M+hVMYxfxWzr5Nz0
         HULV5ZqCRC7lUo8NcqQ2YzWSEm6QmuA692njYi/I7UI4NYLjRdHPnAS9Kj9Khz/J8j
         9bpScaWCYpUew==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 31 Jul 2023 11:47:03 +0100
Subject: [PATCH 2/2] ASoC: wm8960: Make automatic the default clocking mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-asoc-wm8960-clk-v1-2-69f9ffa2b10a@kernel.org>
References: <20230731-asoc-wm8960-clk-v1-0-69f9ffa2b10a@kernel.org>
In-Reply-To: <20230731-asoc-wm8960-clk-v1-0-69f9ffa2b10a@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YnJy0NhEnRLR/JM2gYOkdO9V3g9/7Ef01+MnHCUiCJc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkx5EqFH1dsHVKHxX6uua2BB9XrmeAauNdz/12X
 mfWEJ2svueJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMeRKgAKCRAk1otyXVSH
 0CduB/9pfk3JXuSilsdifv0cne2PP4RxftvPIggCM8Hz31wV8ERhQ9IwF20omZL13splslrTxxn
 4wBpSaXnjmge5L2HXnlVucQSGRQHqm5hZoZQHt2B6FACrEhYE9ap8z9rTDCpdIae95JJItOLdoH
 bYmH09RrTAGcZQO9bFPibg2cDA8KG4iQk4LrhUws+UPN75EWKsakLpqioBwB403J1L0X9vPwI++
 HlojDz3LEBRMX3CvCLhw90dGQidMcGTBaImSSYNempGBssDBEcJVC0uc2p/vMc57NDRXG09s0Px
 BC4MmJzN3z4ky7IdslNpwsaaopMUvQqLBuNU6pxssxg/9c0n
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wm8960 driver supports an automatic clocking mode which will use the
MCLK directly where possible and fall back to the PLL if there is no
suitable configuration directly using the MCLK.  Clock 0 will be used by
the generic cards when configuring things, currently this is a MCLK only
mode but using AUTO mode would be more functional.  Since the driver
still prefers to use MCLK directly where possible there should be no
negative impact on systems which are able to use MCLK directly.

As far as I can see nothing is using the system clock as part of the
ABI, the only reference I can see to a mode in a machine driver is the
Freescale i.MX card which uses the automatic mode with an explicit in
kernel call using the constant so will be unaffected.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8960.h b/sound/soc/codecs/wm8960.h
index 63ba6c03c488..e8ff33b188e9 100644
--- a/sound/soc/codecs/wm8960.h
+++ b/sound/soc/codecs/wm8960.h
@@ -77,9 +77,9 @@
 #define WM8960_SYSCLK_DIV_1		(0 << 1)
 #define WM8960_SYSCLK_DIV_2		(2 << 1)
 
-#define WM8960_SYSCLK_MCLK		(0 << 0)
+#define WM8960_SYSCLK_AUTO		(0 << 0)
 #define WM8960_SYSCLK_PLL		(1 << 0)
-#define WM8960_SYSCLK_AUTO		(2 << 0)
+#define WM8960_SYSCLK_MCLK		(2 << 0)
 
 #define WM8960_DAC_DIV_1		(0 << 3)
 #define WM8960_DAC_DIV_1_5		(1 << 3)

-- 
2.39.2

