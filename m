Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6A380A759
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574319AbjLHP1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjLHP10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:27:26 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31379198C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:27:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c05ce04a8so25218145e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702049249; x=1702654049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFcL7TxIadSrBs6FUZQDoVApQi63jw2+bgitGV4KarA=;
        b=beb3Z9vf2UNJp/MYo9+RJDVUpSGUA4jpxq4qHl4lXQAzZQ/daDf+BStSMzh9uIDquI
         RlDPfYpfI3DxNS/xJ41TkpkHjV7JSEudl1yrKaX7uCxpXUD7hNer5LDRztLKVz8KxTKz
         cULABCyTi+tRh/TVVxEoYlG8VFPA+/o+gApsuoKZ0FywExuFzAI8GMCeohiwF6zW37v1
         FG07r++7kVnU9gy6SoaHCGrXApeCEPVxCphE0t41P4DUhfVO6+gq5fUxBArOarMOxwy1
         f3pv0hk80PwK6A4HAomcrVtq0qEA2zWcz+2lot3oHGswPFSEotnyRRD6HAqo1iHDGy+K
         LATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049249; x=1702654049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFcL7TxIadSrBs6FUZQDoVApQi63jw2+bgitGV4KarA=;
        b=gleXoTH4H21y1SHCIts3dwt8PGpMXcvMpot9TqD/kYCJkgY+DsW2KhfHkRW7p34kTX
         4ICyhWdNE/eaHLWQ8GINn3zRTrQ1Wky0yMGmhpi3NcQ7U8cujX/PPVtlhXHtQjZLix+A
         AYGtmqAmiW3e8sBwwlohYf7kXszU10K9vr82CsFwDZZaau34cOlejBH1QMrsdVzeclS/
         goZ2VMHbYHJwBziupI3PlO5qUx061JyD4gc1J3OCGOGmX9Okp9N62LZsHudaHNC8f/qt
         GeoMZeCDEH1ZJUMRFLJ5jo4KNo7Da0j3RBFGRh+jg+Qq4/fuQmafaSbuJ5LnBzLwchVb
         fOww==
X-Gm-Message-State: AOJu0Yxkbessu6g1jhcX6mrC3Qnu6BBFlDRmkWYtDo42Sm2Ag2nojzk3
        wql1nnq0zXR51K0eJij7YjUIUQ==
X-Google-Smtp-Source: AGHT+IH27OqcvKzrJ2TTGUmKoQRxyLG9pq/+thAoHJIbImKSa1l5TdnsD1yfd9bE9kIONdJLhknG0w==
X-Received: by 2002:a05:600c:1e1b:b0:40b:5e1c:2fa6 with SMTP id ay27-20020a05600c1e1b00b0040b5e1c2fa6mr46074wmb.54.1702049249470;
        Fri, 08 Dec 2023 07:27:29 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0040b45356b72sm5443533wms.33.2023.12.08.07.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:27:28 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 08 Dec 2023 16:27:24 +0100
Subject: [PATCH 2/2] usb: typec: mux: add Qualcomm WCD939X USB SubSystem
 Altmode Mux driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231208-topic-sm8650-upstream-wcd939x-usbss-v1-2-91d1ba680fe0@linaro.org>
References: <20231208-topic-sm8650-upstream-wcd939x-usbss-v1-0-91d1ba680fe0@linaro.org>
In-Reply-To: <20231208-topic-sm8650-upstream-wcd939x-usbss-v1-0-91d1ba680fe0@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=27318;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=SHBy3VmG9NjxczRhBpjp/JY0r67n6SkmNSRA5cUEdQw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlczXdzGSlEZowvJKbdd+RxjPT4rorz0ru+Nqbyl6v
 vOEwm8yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXM13QAKCRB33NvayMhJ0VRkD/
 4zsJMyKDqTV1OqXQqm1jn7z5xliT9UTSwJH/IeXygQpaBvz9QWqmIZl/g9q/qis+dlQ8U7FNPZ8hSd
 HlMuHsk4f8gfAcG2z84BHy1t8UTjk0oeLhLYH/7Un2WtNUMWur5qzo3rUMRYJKQyLUIre3sF246NSi
 g8Xx7coAv3X2bJX1BUL+AAHlHXmvNcBhNTbQ+gx8Jd5TzROY7IxQKzZsADmDTxmOXF5VFb/OATgQiS
 jv/D3veyTMd8po9cyTwlVli8wVRAlTYv03VeH+PVF2vIywOn8WZOpIfKjoqaHN1Err/s4spMbuc+MT
 uEhRDaOBgeu3Z1atXSPpxuerGg0vqTGk0zBcohHlPR+Ddtn3VCMPSNwrsbDOmMoSFrD0d2qWHuksh8
 UAweueSDGEh2cf2z7dRvW+O7gpSfx5VGWsZXUC+P51ktfzBRd0k5tt3XUHbE8OzJbtgnDGwN7tvvKm
 cx4W370Cm4LDN/qt3SbbQERlZ6ZB1Fc6rVCYH6z1fecV3bfCKEBSc+KajWzxFV7QdKmmTd+7dmEU67
 ydkHizbUgQQP1bP90b1aiEXTvGpVFNu8vF/lgcFI/cbwsugxuf47PGwXV0ztVoiHBLLTMaP6XWrrf/
 zgHr6WhQKeZLp+lCECpF9+HD1dZiRv7y2ay6ihKBjXyYW+BUntJicWKB8PWg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm WCD9390/WCD9395 is a standalone Hi-Fi audio codec IC with a
functionally separate USB SubSystem for Altmode/Analog Audio Switch
accessible over an I2C interface.

It provides switching USB-C USB2.0 lines between USB and Audio Headphones
speaker lines, and the USB-C SBU lines between DisplayPort AUX and Audio
Headphones Microphone/Ground.

The Audio Headphone and Microphone data path between the Codec and the
USB-C Mux subsystems are external to the IC, thus requiring DT
port-endpoint graph description to handle USB-C altmode & orientation
switching for Audio Accessory Mode.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/mux/Kconfig         |  10 +
 drivers/usb/typec/mux/Makefile        |   1 +
 drivers/usb/typec/mux/wcd939x-usbss.c | 779 ++++++++++++++++++++++++++++++++++
 3 files changed, 790 insertions(+)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 38416fb0cc3c..d2cb5e733e57 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -56,4 +56,14 @@ config TYPEC_MUX_PTN36502
 	  Say Y or M if your system has a NXP PTN36502 Type-C redriver chip
 	  found on some devices with a Type-C port.
 
+config TYPEC_MUX_WCD939X_USBSS
+	tristate "Qualcomm WCD939x USBSS Analog Audio Switch driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Driver for the Qualcomm WCD939x Audio Codec USBSS domain which
+	  provides support for muxing analog audio and sideband signals on a
+	  common USB Type-C connector.
+	  If compiled as a module, the module will be named wcd939x-usbss.
+
 endmenu
diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
index 9d6a5557b0bd..57dc9ac6f8dc 100644
--- a/drivers/usb/typec/mux/Makefile
+++ b/drivers/usb/typec/mux/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+= pi3usb30532.o
 obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)	+= intel_pmc_mux.o
 obj-$(CONFIG_TYPEC_MUX_NB7VPQ904M)	+= nb7vpq904m.o
 obj-$(CONFIG_TYPEC_MUX_PTN36502)	+= ptn36502.o
+obj-$(CONFIG_TYPEC_MUX_WCD939X_USBSS)	+= wcd939x-usbss.o
diff --git a/drivers/usb/typec/mux/wcd939x-usbss.c b/drivers/usb/typec/mux/wcd939x-usbss.c
new file mode 100644
index 000000000000..6fd7afc848eb
--- /dev/null
+++ b/drivers/usb/typec/mux/wcd939x-usbss.c
@@ -0,0 +1,779 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (C) 2023 Linaro Ltd.
+ */
+
+#include <linux/bits.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/usb/typec_dp.h>
+#include <linux/usb/typec_mux.h>
+
+#define WCD_USBSS_PMP_OUT1			0x2
+
+#define WCD_USBSS_DP_DN_MISC1			0x20
+
+#define WCD_USBSS_DP_DN_MISC1_DP_PCOMP_2X_DYN_BST_ON_EN			BIT(3)
+#define WCD_USBSS_DP_DN_MISC1_DN_PCOMP_2X_DYN_BST_ON_EN			BIT(0)
+
+#define WCD_USBSS_MG1_EN			0x24
+
+#define WCD_USBSS_MG1_EN_CT_SNS_EN					BIT(1)
+
+#define WCD_USBSS_MG1_BIAS			0x25
+
+#define WCD_USBSS_MG1_BIAS_PCOMP_DYN_BST_EN				BIT(3)
+
+#define WCD_USBSS_MG1_MISC			0x27
+
+#define WCD_USBSS_MG1_MISC_PCOMP_2X_DYN_BST_ON_EN			BIT(5)
+
+#define WCD_USBSS_MG2_EN			0x28
+
+#define WCD_USBSS_MG2_EN_CT_SNS_EN					BIT(1)
+
+#define WCD_USBSS_MG2_BIAS			0x29
+
+#define WCD_USBSS_MG2_BIAS_PCOMP_DYN_BST_EN				BIT(3)
+
+#define WCD_USBSS_MG2_MISC			0x30
+
+#define WCD_USBSS_MG2_MISC_PCOMP_2X_DYN_BST_ON_EN			BIT(5)
+
+#define WCD_USBSS_DISP_AUXP_THRESH		0x80
+
+#define WCD_USBSS_DISP_AUXP_THRESH_DISP_AUXP_OVPON_CM			GENMASK(7, 5)
+
+#define WCD_USBSS_DISP_AUXP_CTL			0x81
+
+#define WCD_USBSS_DISP_AUXP_CTL_LK_CANCEL_TRK_COEFF			GENMASK(2, 0)
+
+#define WCD_USBSS_CPLDO_CTL2			0xa1
+
+#define WCD_USBSS_SWITCH_SETTINGS_ENABLE	0x403
+
+#define WCD_USBSS_SWITCH_SETTINGS_ENABLE_DEVICE_ENABLE			BIT(7)
+#define WCD_USBSS_SWITCH_SETTINGS_ENABLE_DP_AUXP_TO_MGX_SWITCHES	BIT(6)
+#define WCD_USBSS_SWITCH_SETTINGS_ENABLE_DP_AUXM_TO_MGX_SWITCHES	BIT(5)
+#define WCD_USBSS_SWITCH_SETTINGS_ENABLE_DNL_SWITCHES			BIT(4)
+#define WCD_USBSS_SWITCH_SETTINGS_ENABLE_DPR_SWITCHES			BIT(3)
+#define WCD_USBSS_SWITCH_SETTINGS_ENABLE_SENSE_SWITCHES			BIT(2)
+#define WCD_USBSS_SWITCH_SETTINGS_ENABLE_MIC_SWITCHES			BIT(1)
+#define WCD_USBSS_SWITCH_SETTINGS_ENABLE_AGND_SWITCHES			BIT(0)
+
+#define WCD_USBSS_SWITCH_SELECT0		0x404
+
+#define WCD_USBSS_SWITCH_SELECT0_DP_AUXP_SWITCHES			BIT(7)	/* 1-> MG2 */
+#define WCD_USBSS_SWITCH_SELECT0_DP_AUXM_SWITCHES			BIT(6)	/* 1-> MG2 */
+#define WCD_USBSS_SWITCH_SELECT0_DNL_SWITCHES				GENMASK(5, 4)
+#define WCD_USBSS_SWITCH_SELECT0_DPR_SWITCHES				GENMASK(3, 2)
+#define WCD_USBSS_SWITCH_SELECT0_SENSE_SWITCHES				BIT(1)	/* 1-> SBU2 */
+#define WCD_USBSS_SWITCH_SELECT0_MIC_SWITCHES				BIT(0)	/* 1-> MG2 */
+
+#define WCD_USBSS_SWITCH_SELECT0_DNL_SWITCH_L		0
+#define WCD_USBSS_SWITCH_SELECT0_DNL_SWITCH_DN		1
+#define WCD_USBSS_SWITCH_SELECT0_DNL_SWITCH_DN2		2
+
+#define WCD_USBSS_SWITCH_SELECT0_DPR_SWITCH_R		0
+#define WCD_USBSS_SWITCH_SELECT0_DPR_SWITCH_DP		1
+#define WCD_USBSS_SWITCH_SELECT0_DPR_SWITCH_DR2		2
+
+#define WCD_USBSS_SWITCH_SELECT1		0x405
+
+#define WCD_USBSS_SWITCH_SELECT1_AGND_SWITCHES				BIT(0)	/* 1-> MG2 */
+
+#define WCD_USBSS_DELAY_R_SW			0x40d
+#define WCD_USBSS_DELAY_MIC_SW			0x40e
+#define WCD_USBSS_DELAY_SENSE_SW		0x40f
+#define WCD_USBSS_DELAY_GND_SW			0x410
+#define WCD_USBSS_DELAY_L_SW			0x411
+
+#define WCD_USBSS_FUNCTION_ENABLE		0x413
+
+#define WCD_USBSS_FUNCTION_ENABLE_SOURCE_SELECT				GENMASK(1, 0)
+
+#define WCD_USBSS_FUNCTION_ENABLE_SOURCE_SELECT_MANUAL		1
+#define WCD_USBSS_FUNCTION_ENABLE_SOURCE_SELECT_AUDIO_FSM	2
+
+#define WCD_USBSS_EQUALIZER1			0x415
+
+#define WCD_USBSS_EQUALIZER1_EQ_EN					BIT(7)
+#define WCD_USBSS_EQUALIZER1_BW_SETTINGS				GENMASK(6, 3)
+
+#define WCD_USBSS_USB_SS_CNTL			0x419
+
+#define WCD_USBSS_USB_SS_CNTL_STANDBY_STATE				BIT(4)
+#define WCD_USBSS_USB_SS_CNTL_RCO_EN					BIT(3)
+#define WCD_USBSS_USB_SS_CNTL_USB_SS_MODE				GENMASK(2, 0)
+
+#define WCD_USBSS_USB_SS_CNTL_USB_SS_MODE_AATC		2
+#define WCD_USBSS_USB_SS_CNTL_USB_SS_MODE_USB		5
+
+#define WCD_USBSS_AUDIO_FSM_START		0x433
+
+#define WCD_USBSS_AUDIO_FSM_START_AUDIO_FSM_AUDIO_TRIG			BIT(0)
+
+#define WCD_USBSS_RATIO_SPKR_REXT_L_LSB		0x461
+#define WCD_USBSS_RATIO_SPKR_REXT_L_MSB		0x462
+#define WCD_USBSS_RATIO_SPKR_REXT_R_LSB		0x463
+#define WCD_USBSS_RATIO_SPKR_REXT_R_MSB		0x464
+#define WCD_USBSS_AUD_COEF_L_K0_0		0x475
+#define WCD_USBSS_AUD_COEF_L_K0_1		0x476
+#define WCD_USBSS_AUD_COEF_L_K0_2		0x477
+#define WCD_USBSS_AUD_COEF_L_K1_0		0x478
+#define WCD_USBSS_AUD_COEF_L_K1_1		0x479
+#define WCD_USBSS_AUD_COEF_L_K2_0		0x47a
+#define WCD_USBSS_AUD_COEF_L_K2_1		0x47b
+#define WCD_USBSS_AUD_COEF_L_K3_0		0x47c
+#define WCD_USBSS_AUD_COEF_L_K3_1		0x47d
+#define WCD_USBSS_AUD_COEF_L_K4_0		0x47e
+#define WCD_USBSS_AUD_COEF_L_K4_1		0x47f
+#define WCD_USBSS_AUD_COEF_L_K5_0		0x480
+#define WCD_USBSS_AUD_COEF_L_K5_1		0x481
+#define WCD_USBSS_AUD_COEF_R_K0_0		0x482
+#define WCD_USBSS_AUD_COEF_R_K0_1		0x483
+#define WCD_USBSS_AUD_COEF_R_K0_2		0x484
+#define WCD_USBSS_AUD_COEF_R_K1_0		0x485
+#define WCD_USBSS_AUD_COEF_R_K1_1		0x486
+#define WCD_USBSS_AUD_COEF_R_K2_0		0x487
+#define WCD_USBSS_AUD_COEF_R_K2_1		0x488
+#define WCD_USBSS_AUD_COEF_R_K3_0		0x489
+#define WCD_USBSS_AUD_COEF_R_K3_1		0x48a
+#define WCD_USBSS_AUD_COEF_R_K4_0		0x48b
+#define WCD_USBSS_AUD_COEF_R_K4_1		0x48c
+#define WCD_USBSS_AUD_COEF_R_K5_0		0x48d
+#define WCD_USBSS_AUD_COEF_R_K5_1		0x48e
+#define WCD_USBSS_GND_COEF_L_K0_0		0x48f
+#define WCD_USBSS_GND_COEF_L_K0_1		0x490
+#define WCD_USBSS_GND_COEF_L_K0_2		0x491
+#define WCD_USBSS_GND_COEF_L_K1_0		0x492
+#define WCD_USBSS_GND_COEF_L_K1_1		0x493
+#define WCD_USBSS_GND_COEF_L_K2_0		0x494
+#define WCD_USBSS_GND_COEF_L_K2_1		0x495
+#define WCD_USBSS_GND_COEF_L_K3_0		0x496
+#define WCD_USBSS_GND_COEF_L_K3_1		0x497
+#define WCD_USBSS_GND_COEF_L_K4_0		0x498
+#define WCD_USBSS_GND_COEF_L_K4_1		0x499
+#define WCD_USBSS_GND_COEF_L_K5_0		0x49a
+#define WCD_USBSS_GND_COEF_L_K5_1		0x49b
+#define WCD_USBSS_GND_COEF_R_K0_0		0x49c
+#define WCD_USBSS_GND_COEF_R_K0_1		0x49d
+#define WCD_USBSS_GND_COEF_R_K0_2		0x49e
+#define WCD_USBSS_GND_COEF_R_K1_0		0x49f
+#define WCD_USBSS_GND_COEF_R_K1_1		0x4a0
+#define WCD_USBSS_GND_COEF_R_K2_0		0x4a1
+#define WCD_USBSS_GND_COEF_R_K2_1		0x4a2
+#define WCD_USBSS_GND_COEF_R_K3_0		0x4a3
+#define WCD_USBSS_GND_COEF_R_K3_1		0x4a4
+#define WCD_USBSS_GND_COEF_R_K4_0		0x4a5
+#define WCD_USBSS_GND_COEF_R_K4_1		0x4a6
+#define WCD_USBSS_GND_COEF_R_K5_0		0x4a7
+#define WCD_USBSS_GND_COEF_R_K5_1		0x4a8
+
+#define WCD_USBSS_MAX_REGISTER			0x4c1
+
+struct wcd939x_usbss {
+	struct i2c_client *client;
+	struct gpio_desc *reset_gpio;
+	struct regulator *vdd_supply;
+
+	/* used to serialize concurrent change requests */
+	struct mutex lock;
+
+	struct typec_switch_dev *sw;
+	struct typec_mux_dev *mux;
+
+	struct regmap *regmap;
+
+	struct typec_mux *codec;
+	struct typec_switch *codec_switch;
+
+	enum typec_orientation orientation;
+	unsigned long mode;
+	unsigned int svid;
+};
+
+static const struct regmap_range_cfg wcd939x_usbss_ranges[] = {
+	{
+		.range_min = 0,
+		.range_max = WCD_USBSS_MAX_REGISTER,
+		.selector_reg = 0x0,
+		.selector_mask = 0xff,
+		.selector_shift = 0,
+		.window_start = 0,
+		.window_len = 0x100,
+	},
+};
+
+static const struct regmap_config wcd939x_usbss_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = WCD_USBSS_MAX_REGISTER,
+	.ranges = wcd939x_usbss_ranges,
+	.num_ranges = ARRAY_SIZE(wcd939x_usbss_ranges),
+};
+
+/* Linearlizer coefficients for 32ohm load */
+static const struct {
+	unsigned int offset;
+	unsigned int mask;
+	unsigned int value;
+} wcd939x_usbss_coeff_init[] = {
+	{ WCD_USBSS_AUD_COEF_L_K5_0, GENMASK(7, 0), 0x39 },
+	{ WCD_USBSS_AUD_COEF_R_K5_0, GENMASK(7, 0), 0x39 },
+	{ WCD_USBSS_GND_COEF_L_K2_0, GENMASK(7, 0), 0xe8 },
+	{ WCD_USBSS_GND_COEF_L_K4_0, GENMASK(7, 0), 0x73 },
+	{ WCD_USBSS_GND_COEF_R_K2_0, GENMASK(7, 0), 0xe8 },
+	{ WCD_USBSS_GND_COEF_R_K4_0, GENMASK(7, 0), 0x73 },
+	{ WCD_USBSS_RATIO_SPKR_REXT_L_LSB, GENMASK(7, 0), 0x00 },
+	{ WCD_USBSS_RATIO_SPKR_REXT_L_MSB, GENMASK(6, 0), 0x04 },
+	{ WCD_USBSS_RATIO_SPKR_REXT_R_LSB, GENMASK(7, 0), 0x00 },
+	{ WCD_USBSS_RATIO_SPKR_REXT_R_MSB, GENMASK(6, 0), 0x04 },
+};
+
+static int wcd939x_usbss_set(struct wcd939x_usbss *usbss)
+{
+	bool reverse = (usbss->orientation == TYPEC_ORIENTATION_REVERSE);
+	bool enable_audio = false;
+	bool enable_usb = false;
+	bool enable_dp = false;
+	int ret;
+
+	/* USB Mode */
+	if (usbss->mode < TYPEC_STATE_MODAL ||
+	    (!usbss->svid && (usbss->mode == TYPEC_MODE_USB2 ||
+			      usbss->mode == TYPEC_MODE_USB3))) {
+		enable_usb = true;
+	} else if (usbss->svid) {
+		switch (usbss->mode) {
+		/* DP Only */
+		case TYPEC_DP_STATE_C:
+		case TYPEC_DP_STATE_E:
+			enable_dp = true;
+			break;
+
+		/* DP + USB */
+		case TYPEC_DP_STATE_D:
+		case TYPEC_DP_STATE_F:
+			enable_usb = true;
+			enable_dp = true;
+			break;
+
+		default:
+			return -EOPNOTSUPP;
+		}
+	} else if (usbss->mode == TYPEC_MODE_AUDIO) {
+		enable_audio = true;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	/* Disable all switches */
+	ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
+				WCD_USBSS_SWITCH_SETTINGS_ENABLE_DP_AUXP_TO_MGX_SWITCHES |
+				WCD_USBSS_SWITCH_SETTINGS_ENABLE_DP_AUXM_TO_MGX_SWITCHES |
+				WCD_USBSS_SWITCH_SETTINGS_ENABLE_DPR_SWITCHES |
+				WCD_USBSS_SWITCH_SETTINGS_ENABLE_DNL_SWITCHES |
+				WCD_USBSS_SWITCH_SETTINGS_ENABLE_SENSE_SWITCHES |
+				WCD_USBSS_SWITCH_SETTINGS_ENABLE_MIC_SWITCHES |
+				WCD_USBSS_SWITCH_SETTINGS_ENABLE_AGND_SWITCHES);
+	if (ret)
+		return ret;
+
+	/* Clear switches */
+	ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
+				WCD_USBSS_SWITCH_SELECT0_DP_AUXP_SWITCHES |
+				WCD_USBSS_SWITCH_SELECT0_DP_AUXM_SWITCHES |
+				WCD_USBSS_SWITCH_SELECT0_DPR_SWITCHES |
+				WCD_USBSS_SWITCH_SELECT0_DNL_SWITCHES |
+				WCD_USBSS_SWITCH_SELECT0_SENSE_SWITCHES |
+				WCD_USBSS_SWITCH_SELECT0_MIC_SWITCHES);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT1,
+				WCD_USBSS_SWITCH_SELECT1_AGND_SWITCHES);
+	if (ret)
+		return ret;
+
+	/* Enable OVP_MG1_BIAS PCOMP_DYN_BST_EN */
+	ret = regmap_set_bits(usbss->regmap, WCD_USBSS_MG1_BIAS,
+			      WCD_USBSS_MG1_BIAS_PCOMP_DYN_BST_EN);
+	if (ret)
+		return ret;
+
+	/* Enable OVP_MG2_BIAS PCOMP_DYN_BST_EN */
+	ret = regmap_set_bits(usbss->regmap, WCD_USBSS_MG2_BIAS,
+			      WCD_USBSS_MG2_BIAS_PCOMP_DYN_BST_EN);
+	if (ret)
+		return ret;
+
+	/* Disable Equalizer in safe mode */
+	ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_EQUALIZER1,
+				WCD_USBSS_EQUALIZER1_EQ_EN);
+	if (ret)
+		return ret;
+
+	/* Start FSM with all disabled, force write */
+	ret = regmap_write_bits(usbss->regmap, WCD_USBSS_AUDIO_FSM_START,
+				WCD_USBSS_AUDIO_FSM_START_AUDIO_FSM_AUDIO_TRIG,
+				WCD_USBSS_AUDIO_FSM_START_AUDIO_FSM_AUDIO_TRIG);
+
+	/* 35us to allow the SBU switch to turn off */
+	usleep_range(35, 1000);
+
+	/* Setup Audio Accessory mux/switch */
+	if (enable_audio) {
+		int i;
+
+		/*
+		 * AATC switch configuration:
+		 * "Normal":
+		 * - R: DNR
+		 * - L: DNL
+		 * - Sense: GSBU2
+		 * - Mic: MG1
+		 * - AGND: MG2
+		 * "Swapped":
+		 * - R: DNR
+		 * - L: DNL
+		 * - Sense: GSBU1
+		 * - Mic: MG2
+		 * - AGND: MG1
+		 * Swapped information is given by the codec MBHC logic
+		 */
+
+		/* Set AATC mode */
+		ret = regmap_update_bits(usbss->regmap, WCD_USBSS_USB_SS_CNTL,
+					 WCD_USBSS_USB_SS_CNTL_USB_SS_MODE,
+					 FIELD_PREP(WCD_USBSS_USB_SS_CNTL_USB_SS_MODE,
+						    WCD_USBSS_USB_SS_CNTL_USB_SS_MODE_AATC));
+		if (ret)
+			return ret;
+
+		/* Select L for DNL_SWITCHES and R for DPR_SWITCHES */
+		ret = regmap_update_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
+				WCD_USBSS_SWITCH_SELECT0_DPR_SWITCHES |
+				WCD_USBSS_SWITCH_SELECT0_DNL_SWITCHES,
+				FIELD_PREP(WCD_USBSS_SWITCH_SELECT0_DNL_SWITCHES,
+					WCD_USBSS_SWITCH_SELECT0_DNL_SWITCH_L) |
+				FIELD_PREP(WCD_USBSS_SWITCH_SELECT0_DPR_SWITCHES,
+					WCD_USBSS_SWITCH_SELECT0_DPR_SWITCH_R));
+		if (ret)
+			return ret;
+
+		if (reverse)
+			/* Select MG2 for MIC, SBU1 for Sense */
+			ret = regmap_update_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
+						 WCD_USBSS_SWITCH_SELECT0_MIC_SWITCHES,
+						 WCD_USBSS_SWITCH_SELECT0_MIC_SWITCHES);
+		else
+			/* Select MG1 for MIC, SBU2 for Sense */
+			ret = regmap_update_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
+						 WCD_USBSS_SWITCH_SELECT0_SENSE_SWITCHES,
+						 WCD_USBSS_SWITCH_SELECT0_SENSE_SWITCHES);
+		if (ret)
+			return ret;
+
+		if (reverse)
+			/* Disable OVP_MG1_BIAS PCOMP_DYN_BST_EN */
+			ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_MG1_BIAS,
+						WCD_USBSS_MG1_BIAS_PCOMP_DYN_BST_EN);
+		else
+			/* Disable OVP_MG2_BIAS PCOMP_DYN_BST_EN */
+			ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_MG2_BIAS,
+						WCD_USBSS_MG2_BIAS_PCOMP_DYN_BST_EN);
+		if (ret)
+			return ret;
+
+		/*  Enable SENSE, MIC switches */
+		ret = regmap_set_bits(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
+				      WCD_USBSS_SWITCH_SETTINGS_ENABLE_SENSE_SWITCHES |
+				      WCD_USBSS_SWITCH_SETTINGS_ENABLE_MIC_SWITCHES);
+		if (ret)
+			return ret;
+
+		if (reverse)
+			/* Select MG1 for AGND_SWITCHES */
+			ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT1,
+						WCD_USBSS_SWITCH_SELECT1_AGND_SWITCHES);
+		else
+			/* Select MG2 for AGND_SWITCHES */
+			ret = regmap_set_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT1,
+					      WCD_USBSS_SWITCH_SELECT1_AGND_SWITCHES);
+		if (ret)
+			return ret;
+
+		/* Enable AGND switches */
+		ret = regmap_set_bits(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
+				      WCD_USBSS_SWITCH_SETTINGS_ENABLE_AGND_SWITCHES);
+		if (ret)
+			return ret;
+
+		/* Enable DPR, DNL switches */
+		ret = regmap_set_bits(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
+				      WCD_USBSS_SWITCH_SETTINGS_ENABLE_DNL_SWITCHES |
+				      WCD_USBSS_SWITCH_SETTINGS_ENABLE_DPR_SWITCHES);
+		if (ret)
+			return ret;
+
+		/* Setup FSM delays */
+		ret = regmap_write(usbss->regmap, WCD_USBSS_DELAY_L_SW, 0x02);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(usbss->regmap, WCD_USBSS_DELAY_R_SW, 0x02);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(usbss->regmap, WCD_USBSS_DELAY_MIC_SW, 0x01);
+		if (ret)
+			return ret;
+
+		/* Start FSM, force write */
+		ret = regmap_write_bits(usbss->regmap, WCD_USBSS_AUDIO_FSM_START,
+					WCD_USBSS_AUDIO_FSM_START_AUDIO_FSM_AUDIO_TRIG,
+					WCD_USBSS_AUDIO_FSM_START_AUDIO_FSM_AUDIO_TRIG);
+		if (ret)
+			return ret;
+
+		/* Default Linearlizer coefficients */
+		for (i = 0; i < ARRAY_SIZE(wcd939x_usbss_coeff_init); ++i)
+			regmap_update_bits(usbss->regmap,
+					   wcd939x_usbss_coeff_init[i].offset,
+					   wcd939x_usbss_coeff_init[i].mask,
+					   wcd939x_usbss_coeff_init[i].value);
+
+		return 0;
+	}
+
+	ret = regmap_update_bits(usbss->regmap, WCD_USBSS_USB_SS_CNTL,
+				 WCD_USBSS_USB_SS_CNTL_USB_SS_MODE,
+				 FIELD_PREP(WCD_USBSS_USB_SS_CNTL_USB_SS_MODE,
+					    WCD_USBSS_USB_SS_CNTL_USB_SS_MODE_USB));
+	if (ret)
+		return ret;
+
+	/* Enable USB muxes */
+	if (enable_usb) {
+		/* Do not enable Equalizer in safe mode */
+		if (usbss->mode != TYPEC_STATE_SAFE) {
+			ret = regmap_set_bits(usbss->regmap, WCD_USBSS_EQUALIZER1,
+					      WCD_USBSS_EQUALIZER1_EQ_EN);
+			if (ret)
+				return ret;
+		}
+
+		/* Select DN for DNL_SWITCHES and DP for DPR_SWITCHES */
+		ret = regmap_update_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
+					 WCD_USBSS_SWITCH_SELECT0_DPR_SWITCHES |
+					 WCD_USBSS_SWITCH_SELECT0_DNL_SWITCHES,
+					 FIELD_PREP(WCD_USBSS_SWITCH_SELECT0_DNL_SWITCHES,
+						    WCD_USBSS_SWITCH_SELECT0_DNL_SWITCH_DN) |
+					 FIELD_PREP(WCD_USBSS_SWITCH_SELECT0_DPR_SWITCHES,
+						    WCD_USBSS_SWITCH_SELECT0_DPR_SWITCH_DP));
+		if (ret)
+			return ret;
+
+		/* Enable DNL_SWITCHES and DPR_SWITCHES */
+		ret = regmap_set_bits(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
+				      WCD_USBSS_SWITCH_SETTINGS_ENABLE_DPR_SWITCHES |
+				      WCD_USBSS_SWITCH_SETTINGS_ENABLE_DNL_SWITCHES);
+		if (ret)
+			return ret;
+	}
+
+	/* Enable DP AUX muxes */
+	if (enable_dp) {
+		/* Update Leakage Canceller Coefficient for AUXP pins */
+		ret = regmap_update_bits(usbss->regmap, WCD_USBSS_DISP_AUXP_CTL,
+					 WCD_USBSS_DISP_AUXP_CTL_LK_CANCEL_TRK_COEFF,
+					 FIELD_PREP(WCD_USBSS_DISP_AUXP_CTL_LK_CANCEL_TRK_COEFF,
+						    5));
+		if (ret)
+			return ret;
+
+		ret = regmap_set_bits(usbss->regmap, WCD_USBSS_DISP_AUXP_THRESH,
+				      WCD_USBSS_DISP_AUXP_THRESH_DISP_AUXP_OVPON_CM);
+		if (ret)
+			return ret;
+
+		if (reverse)
+			/* Select MG2 for AUXP and MG1 for AUXM */
+			ret = regmap_update_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
+						 WCD_USBSS_SWITCH_SELECT0_DP_AUXP_SWITCHES |
+						 WCD_USBSS_SWITCH_SELECT0_DP_AUXM_SWITCHES,
+						 WCD_USBSS_SWITCH_SELECT0_DP_AUXP_SWITCHES);
+		else
+			/* Select MG1 for AUXP and MG2 for AUXM */
+			ret = regmap_update_bits(usbss->regmap, WCD_USBSS_SWITCH_SELECT0,
+						 WCD_USBSS_SWITCH_SELECT0_DP_AUXP_SWITCHES |
+						 WCD_USBSS_SWITCH_SELECT0_DP_AUXM_SWITCHES,
+						 WCD_USBSS_SWITCH_SELECT0_DP_AUXM_SWITCHES);
+		if (ret)
+			return ret;
+
+		/* Enable DP_AUXP_TO_MGX and DP_AUXM_TO_MGX switches */
+		ret = regmap_set_bits(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
+				      WCD_USBSS_SWITCH_SETTINGS_ENABLE_DP_AUXP_TO_MGX_SWITCHES |
+				      WCD_USBSS_SWITCH_SETTINGS_ENABLE_DP_AUXM_TO_MGX_SWITCHES);
+
+		/* 15us to allow the SBU switch to turn on again */
+		usleep_range(15, 1000);
+	}
+
+	return 0;
+}
+
+static int wcd939x_usbss_switch_set(struct typec_switch_dev *sw,
+				    enum typec_orientation orientation)
+{
+	struct wcd939x_usbss *usbss = typec_switch_get_drvdata(sw);
+	int ret = 0;
+
+	mutex_lock(&usbss->lock);
+
+	if (usbss->orientation != orientation) {
+		usbss->orientation = orientation;
+
+		ret = wcd939x_usbss_set(usbss);
+	}
+
+	mutex_unlock(&usbss->lock);
+
+	if (ret)
+		return ret;
+
+	/* Report orientation to codec after switch has been done */
+	return typec_switch_set(usbss->codec_switch, orientation);
+}
+
+static int wcd939x_usbss_mux_set(struct typec_mux_dev *mux,
+				 struct typec_mux_state *state)
+{
+	struct wcd939x_usbss *usbss = typec_mux_get_drvdata(mux);
+	int ret = 0;
+
+	mutex_lock(&usbss->lock);
+
+	if (usbss->mode != state->mode) {
+		usbss->mode = state->mode;
+
+		if (state->alt)
+			usbss->svid = state->alt->svid;
+		else
+			usbss->svid = 0; // No SVID
+
+		ret = wcd939x_usbss_set(usbss);
+	}
+
+	mutex_unlock(&usbss->lock);
+
+	if (ret)
+		return ret;
+
+	/* Report event to codec after switch has been done */
+	return typec_mux_set(usbss->codec, state);
+}
+
+static int wcd939x_usbss_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct typec_switch_desc sw_desc = { };
+	struct typec_mux_desc mux_desc = { };
+	struct wcd939x_usbss *usbss;
+	int ret;
+
+	usbss = devm_kzalloc(dev, sizeof(*usbss), GFP_KERNEL);
+	if (!usbss)
+		return -ENOMEM;
+
+	usbss->client = client;
+	mutex_init(&usbss->lock);
+
+	usbss->regmap = devm_regmap_init_i2c(client, &wcd939x_usbss_regmap_config);
+	if (IS_ERR(usbss->regmap))
+		return dev_err_probe(dev, PTR_ERR(usbss->regmap), "failed to initialize regmap\n");
+
+	usbss->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(usbss->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(usbss->reset_gpio),
+				     "unable to acquire reset gpio\n");
+
+	usbss->vdd_supply = devm_regulator_get_optional(dev, "vdd");
+	if (IS_ERR(usbss->vdd_supply))
+		return PTR_ERR(usbss->vdd_supply);
+
+	/* Get Codec's MUX & Switch devices */
+	usbss->codec = fwnode_typec_mux_get(dev->fwnode);
+	if (IS_ERR(usbss->codec))
+		return dev_err_probe(dev, PTR_ERR(usbss->codec),
+				     "failed to acquire codec mode-switch\n");
+
+	usbss->codec_switch = fwnode_typec_switch_get(dev->fwnode);
+	if (IS_ERR(usbss->codec_switch)) {
+		ret = dev_err_probe(dev, PTR_ERR(usbss->codec_switch),
+				    "failed to acquire codec orientation-switch\n");
+		goto err_mux_put;
+	}
+
+	usbss->mode = TYPEC_STATE_SAFE;
+	usbss->orientation = TYPEC_ORIENTATION_NONE;
+
+	gpiod_set_value(usbss->reset_gpio, 1);
+
+	ret = regulator_enable(usbss->vdd_supply);
+	if (ret) {
+		dev_err(dev, "Failed to enable vdd: %d\n", ret);
+		goto err_mux_switch;
+	}
+
+	msleep(20);
+
+	gpiod_set_value(usbss->reset_gpio, 0);
+
+	msleep(20);
+
+	/* Disable standby */
+	ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_USB_SS_CNTL,
+				WCD_USBSS_USB_SS_CNTL_STANDBY_STATE);
+	if (ret)
+		goto err_regulator_disable;
+
+	/* Set manual mode by default */
+	ret = regmap_update_bits(usbss->regmap, WCD_USBSS_FUNCTION_ENABLE,
+				 WCD_USBSS_FUNCTION_ENABLE_SOURCE_SELECT,
+				 FIELD_PREP(WCD_USBSS_FUNCTION_ENABLE_SOURCE_SELECT,
+					    WCD_USBSS_FUNCTION_ENABLE_SOURCE_SELECT_MANUAL));
+	if (ret)
+		goto err_regulator_disable;
+
+	/* Enable dynamic boosting for DP and DN */
+	ret = regmap_set_bits(usbss->regmap, WCD_USBSS_DP_DN_MISC1,
+			      WCD_USBSS_DP_DN_MISC1_DP_PCOMP_2X_DYN_BST_ON_EN |
+			      WCD_USBSS_DP_DN_MISC1_DN_PCOMP_2X_DYN_BST_ON_EN);
+	if (ret)
+		goto err_regulator_disable;
+
+	/* Enable dynamic boosting for MG1 OVP */
+	ret = regmap_set_bits(usbss->regmap, WCD_USBSS_MG1_MISC,
+			      WCD_USBSS_MG1_MISC_PCOMP_2X_DYN_BST_ON_EN);
+	if (ret)
+		goto err_regulator_disable;
+
+	/* Enable dynamic boosting for MG2 OVP */
+	ret = regmap_set_bits(usbss->regmap, WCD_USBSS_MG2_MISC,
+			      WCD_USBSS_MG2_MISC_PCOMP_2X_DYN_BST_ON_EN);
+	if (ret)
+		goto err_regulator_disable;
+
+	/* Write 0xFF to WCD_USBSS_CPLDO_CTL2 */
+	ret = regmap_set_bits(usbss->regmap, WCD_USBSS_CPLDO_CTL2, 0xff);
+	if (ret)
+		goto err_regulator_disable;
+
+	/* Set RCO_EN: WCD_USBSS_USB_SS_CNTL Bit<3> --> 0x0 --> 0x1 */
+	ret = regmap_clear_bits(usbss->regmap, WCD_USBSS_USB_SS_CNTL,
+				WCD_USBSS_USB_SS_CNTL_RCO_EN);
+	if (ret)
+		goto err_regulator_disable;
+
+	ret = regmap_set_bits(usbss->regmap, WCD_USBSS_USB_SS_CNTL,
+			      WCD_USBSS_USB_SS_CNTL_RCO_EN);
+	if (ret)
+		goto err_regulator_disable;
+
+	/* Disable all switches but enable the mux */
+	ret = regmap_write(usbss->regmap, WCD_USBSS_SWITCH_SETTINGS_ENABLE,
+			   WCD_USBSS_SWITCH_SETTINGS_ENABLE_DEVICE_ENABLE);
+	if (ret)
+		goto err_regulator_disable;
+
+	/* Setup in SAFE mode */
+	ret = wcd939x_usbss_set(usbss);
+	if (ret)
+		goto err_regulator_disable;
+
+	sw_desc.drvdata = usbss;
+	sw_desc.fwnode = dev_fwnode(dev);
+	sw_desc.set = wcd939x_usbss_switch_set;
+
+	usbss->sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(usbss->sw)) {
+		ret = dev_err_probe(dev, PTR_ERR(usbss->sw), "failed to register typec switch\n");
+		goto err_regulator_disable;
+	}
+
+	mux_desc.drvdata = usbss;
+	mux_desc.fwnode = dev_fwnode(dev);
+	mux_desc.set = wcd939x_usbss_mux_set;
+
+	usbss->mux = typec_mux_register(dev, &mux_desc);
+	if (IS_ERR(usbss->mux)) {
+		typec_switch_unregister(usbss->sw);
+		ret = dev_err_probe(dev, PTR_ERR(usbss->mux), "failed to register typec mux\n");
+		goto err_switch_unregister;
+	}
+
+	i2c_set_clientdata(client, usbss);
+
+	return 0;
+
+err_switch_unregister:
+	typec_switch_unregister(usbss->sw);
+
+err_regulator_disable:
+	regulator_disable(usbss->vdd_supply);
+
+err_mux_switch:
+	typec_switch_put(usbss->codec_switch);
+
+err_mux_put:
+	typec_mux_put(usbss->codec);
+
+	return ret;
+}
+
+static void wcd939x_usbss_remove(struct i2c_client *client)
+{
+	struct wcd939x_usbss *usbss = i2c_get_clientdata(client);
+
+	typec_mux_unregister(usbss->mux);
+	typec_switch_unregister(usbss->sw);
+
+	regulator_disable(usbss->vdd_supply);
+
+	typec_mux_put(usbss->codec);
+}
+
+static const struct i2c_device_id wcd939x_usbss_table[] = {
+	{ "wcd9390-usbss" },
+	{ "wcd9395-usbss" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, wcd939x_usbss_table);
+
+static const struct of_device_id wcd939x_usbss_of_table[] = {
+	{ .compatible = "qcom,wcd9390-usbss" },
+	{ .compatible = "qcom,wcd9395-usbss" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wcd939x_usbss_of_table);
+
+static struct i2c_driver wcd939x_usbss_driver = {
+	.driver = {
+		.name = "wcd939x-usbss",
+		.of_match_table = wcd939x_usbss_of_table,
+	},
+	.probe		= wcd939x_usbss_probe,
+	.remove		= wcd939x_usbss_remove,
+	.id_table	= wcd939x_usbss_table,
+};
+module_i2c_driver(wcd939x_usbss_driver);
+
+MODULE_DESCRIPTION("Qualcomm WCD939x USBSS driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

