Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE33759125
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjGSJGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGSJF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89E1272D;
        Wed, 19 Jul 2023 02:05:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BD0461342;
        Wed, 19 Jul 2023 09:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BEDC433C7;
        Wed, 19 Jul 2023 09:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689757476;
        bh=6u/M1i70QvhVD9mDK4VniKdAPyDjLdXC4VHlNCq0T00=;
        h=From:To:Cc:Subject:Date:From;
        b=Wy5pQiFIE6+QVmTfbAWWeCzbaQoRlwhpLS0UQHdmltp4L7Zh+2S32xZl305cFNC62
         aE6Wfs941hbiraMDiEVIG0fNE75GLdm7tbJbFbkQqWFcWGBN0k6rZTuyyW2+CWPgrM
         inhJ99Yx1uDyzPTHFe8H6pvMBj4cy2Wp7CR2+QeSJYVdzPMfEkooctdMVXup3sfQT7
         mHHlOVTDFPd0Hr8Bt0TFaeTTFSET9/Xomg/B+pV4X233AODqda7Q7XxrAPiiBWyWdW
         PVBKBUBNRxdxXjf0PfXdE7ldlv9LWV+ce1HDJtRInuDq5mCPlKKD3l8ex6NexViEFp
         M84L1dHtoJDJg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH] mfd: rz-mtu3: link time dependencies
Date:   Wed, 19 Jul 2023 11:02:23 +0200
Message-Id: <20230719090430.1925182-1-arnd@kernel.org>
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

The new set of drivers for RZ/G2L MTU3a tries to enable compile-testing the
individual client drivers even when the MFD portion is disabled but gets it
wrong, causing a link failure when the core is in a loadable module but the
other drivers are built-in:

x86_64-linux-ld: drivers/pwm/pwm-rz-mtu3.o: in function `rz_mtu3_pwm_apply':
pwm-rz-mtu3.c:(.text+0x4bf): undefined reference to `rz_mtu3_8bit_ch_write'
x86_64-linux-ld: pwm-rz-mtu3.c:(.text+0x509): undefined reference to `rz_mtu3_disable'

arm-linux-gnueabi-ld: drivers/counter/rz-mtu3-cnt.o: in function `rz_mtu3_cascade_counts_enable_get':
rz-mtu3-cnt.c:(.text+0xbec): undefined reference to `rz_mtu3_shared_reg_read'

It seems better not to add the extra complexity here but instead just use
a normal hard dependency, so remove the #else portion in the header along
with the "|| COMPILE_TEST". This could also be fixed by having slightly more
elaborate Kconfig dependencies or using the cursed 'IS_REACHABLE()' helper,
but in practice it's already possible to compile-test all these drivers
by enabling the mtd portion.

Fixes: 254d3a727421c ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
Fixes: 0be8907359df4 ("counter: Add Renesas RZ/G2L MTU3a counter driver")
Fixes: 654c293e1687b ("mfd: Add Renesas RZ/G2L MTU3a core driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/counter/Kconfig     |  2 +-
 drivers/pwm/Kconfig         |  2 +-
 include/linux/mfd/rz-mtu3.h | 66 -------------------------------------
 3 files changed, 2 insertions(+), 68 deletions(-)

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 62962ae84b77d..497bc05dca4df 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -92,7 +92,7 @@ config MICROCHIP_TCB_CAPTURE
 
 config RZ_MTU3_CNT
 	tristate "Renesas RZ/G2L MTU3a counter driver"
-	depends on RZ_MTU3 || COMPILE_TEST
+	depends on RZ_MTU3
 	help
 	  Enable support for MTU3a counter driver found on Renesas RZ/G2L alike
 	  SoCs. This IP supports both 16-bit and 32-bit phase counting mode
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 6210babb0741a..8ebcddf91f7b7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -505,7 +505,7 @@ config PWM_ROCKCHIP
 
 config PWM_RZ_MTU3
 	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
-	depends on RZ_MTU3 || COMPILE_TEST
+	depends on RZ_MTU3
 	depends on HAS_IOMEM
 	help
 	  This driver exposes the MTU3a PWM Timer controller found in Renesas
diff --git a/include/linux/mfd/rz-mtu3.h b/include/linux/mfd/rz-mtu3.h
index c5173bc062701..8421d49500bf4 100644
--- a/include/linux/mfd/rz-mtu3.h
+++ b/include/linux/mfd/rz-mtu3.h
@@ -151,7 +151,6 @@ struct rz_mtu3 {
 	void *priv_data;
 };
 
-#if IS_ENABLED(CONFIG_RZ_MTU3)
 static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
 {
 	mutex_lock(&ch->lock);
@@ -188,70 +187,5 @@ void rz_mtu3_32bit_ch_write(struct rz_mtu3_channel *ch, u16 off, u32 val);
 void rz_mtu3_shared_reg_write(struct rz_mtu3_channel *ch, u16 off, u16 val);
 void rz_mtu3_shared_reg_update_bit(struct rz_mtu3_channel *ch, u16 off,
 				   u16 pos, u8 val);
-#else
-static inline bool rz_mtu3_request_channel(struct rz_mtu3_channel *ch)
-{
-	return false;
-}
-
-static inline void rz_mtu3_release_channel(struct rz_mtu3_channel *ch)
-{
-}
-
-static inline bool rz_mtu3_is_enabled(struct rz_mtu3_channel *ch)
-{
-	return false;
-}
-
-static inline void rz_mtu3_disable(struct rz_mtu3_channel *ch)
-{
-}
-
-static inline int rz_mtu3_enable(struct rz_mtu3_channel *ch)
-{
-	return 0;
-}
-
-static inline u8 rz_mtu3_8bit_ch_read(struct rz_mtu3_channel *ch, u16 off)
-{
-	return 0;
-}
-
-static inline u16 rz_mtu3_16bit_ch_read(struct rz_mtu3_channel *ch, u16 off)
-{
-	return 0;
-}
-
-static inline u32 rz_mtu3_32bit_ch_read(struct rz_mtu3_channel *ch, u16 off)
-{
-	return 0;
-}
-
-static inline u16 rz_mtu3_shared_reg_read(struct rz_mtu3_channel *ch, u16 off)
-{
-	return 0;
-}
-
-static inline void rz_mtu3_8bit_ch_write(struct rz_mtu3_channel *ch, u16 off, u8 val)
-{
-}
-
-static inline void rz_mtu3_16bit_ch_write(struct rz_mtu3_channel *ch, u16 off, u16 val)
-{
-}
-
-static inline void rz_mtu3_32bit_ch_write(struct rz_mtu3_channel *ch, u16 off, u32 val)
-{
-}
-
-static inline void rz_mtu3_shared_reg_write(struct rz_mtu3_channel *ch, u16 off, u16 val)
-{
-}
-
-static inline void rz_mtu3_shared_reg_update_bit(struct rz_mtu3_channel *ch,
-						 u16 off, u16 pos, u8 val)
-{
-}
-#endif
 
 #endif /* __MFD_RZ_MTU3_H__ */
-- 
2.39.2

