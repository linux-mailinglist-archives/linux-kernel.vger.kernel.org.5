Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665F57CB3A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjJPUE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjJPUEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:04:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5CB83;
        Mon, 16 Oct 2023 13:04:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76274C433C7;
        Mon, 16 Oct 2023 20:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697486664;
        bh=LicEPcKoL9Sru0ZtpvzVU3YUUcuxZ6s7vspnx7TkER4=;
        h=From:To:Cc:Subject:Date:From;
        b=NF3cSB3najqsbPo3qib9+Dzj+MAvqLUUgu9V+CzC61e/PcC/3U8wuBF+GWcuNlajs
         9PjV3EQnpMyo7CnVqq+v3ODtP8TTKE9CRBmXL5kvpIXalUTeT2UuUTIHPWM8IWXCM7
         wpRkICK80B8j51mS3KMD2R/hsBQ2LoaBMEBFnE32fbJ5l3DOvJm/qxVqJMGXFUCy2W
         UOgVv6nBwGvaTP4yA/h6hvSC+bg37y5ofArWrp75AYj0tDVeT+N/WdFNS0dPgqLVLC
         TBbuYYR6lNGcw95F+epv8LeK9MXgh7bMTweBSxqzd9Ix6379AeQN9e163/BkVcuxf7
         nymLpxS0Ju75A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/a6xx: add QMP dependency
Date:   Mon, 16 Oct 2023 22:04:03 +0200
Message-Id: <20231016200415.791090-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When QMP is in a loadable module, the A6xx GPU driver fails to link
as built-in:

x86_64-linux-ld: drivers/gpu/drm/msm/adreno/a6xx_gmu.o: in function `a6xx_gmu_resume':
a6xx_gmu.c:(.text+0xd62): undefined reference to `qmp_send'

Add the usual dependency that still allows compiling without QMP but
otherwise avoids the broken combination of options.

Fixes: 88a0997f2f949 ("drm/msm/a6xx: Send ACD state to QMP at GMU resume")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 6309a857ca312..ad70b611b44f0 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -6,6 +6,7 @@ config DRM_MSM
 	depends on ARCH_QCOM || SOC_IMX5 || COMPILE_TEST
 	depends on COMMON_CLK
 	depends on IOMMU_SUPPORT
+	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
 	depends on QCOM_OCMEM || QCOM_OCMEM=n
 	depends on QCOM_LLCC || QCOM_LLCC=n
 	depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n
-- 
2.39.2

