Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893B77FD5C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjK2LcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjK2LcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:32:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170D5B5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:32:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CACC433C7;
        Wed, 29 Nov 2023 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701257533;
        bh=FoQpCy80/A7NqecYX8XoNLwYAiGxzFge1aoT7zCvJgk=;
        h=From:To:Cc:Subject:Date:From;
        b=g6onjRbp37be+UMRU4JvdY3eUKTCkvMRbNQdJISR5P0C0cHBFzvn45SqowYRO6O+W
         zt+Ut32KRpAA9xRfATcxZGQjXmoq2Lsx2rUL4iI6Eun4Qio3/42KHgeBNxFnSHt3w/
         6ckbFvzNL91Eg52WEdie6zUUlHkQhFuAtExVz7qVs41p4h0y8ZonUHbW/2aIw7kGyp
         eY5LcYo9Y5wfIP2A4yCpJxdzmhqrOziZInD6mmXjr4W7NW1kVDhP4PFHQoEe60KFiJ
         A/oJm1U3ygRPM8lKEBCisgKnn+LyUjMcOQjGihOxXcaRcP7S6I3idBNy08i8vpG55C
         sl6cXQOXhcCHg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chancel Liu <chancel.liu@nxp.com>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_rpmsg: update Kconfig dependencies
Date:   Wed, 29 Nov 2023 12:31:17 +0100
Message-Id: <20231129113204.2869356-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

SND_SOC_IMX_RPMSG gained a new dependency and gets selected by SND_SOC_FSL_RPMSG,
which as a result needs to have the same dependency, or produce a build failure
based on that:

WARNING: unmet direct dependencies detected for SND_SOC_IMX_RPMSG
  Depends on [n]: SOUND [=y] && SND [=y] && SND_SOC [=y] && SND_IMX_SOC [=y] && RPMSG [=y] && OF [=y] && I2C [=n]
  Selected by [y]:
  - SND_SOC_FSL_RPMSG [=y] && SOUND [=y] && SND [=y] && SND_SOC [=y] && COMMON_CLK [=y] && RPMSG [=y] && (SND_IMX_SOC [=y] || SND_IMX_SOC [=y]=n) && SND_IMX_SOC [=y]!=n
x86_64-linux-ld: sound/soc/fsl/imx-rpmsg.o: in function `imx_rpmsg_late_probe':
imx-rpmsg.c:(.text+0x11e): undefined reference to `i2c_find_device_by_fwnode'

Fixes: f83d38def6b1 ("ASoC: imx-rpmsg: SND_SOC_IMX_RPMSG should depend on OF and I2C")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index acb518f7ae79..270726c134b3 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -121,6 +121,7 @@ config SND_SOC_FSL_UTILS
 config SND_SOC_FSL_RPMSG
 	tristate "NXP Audio Base On RPMSG support"
 	depends on COMMON_CLK
+	depends on OF && I2C
 	depends on RPMSG
 	depends on SND_IMX_SOC || SND_IMX_SOC = n
 	select SND_SOC_IMX_RPMSG if SND_IMX_SOC != n
-- 
2.39.2

