Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703E6755DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGQIHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGQIHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:07:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0CF10F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:07:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so38166385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689581222; x=1692173222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdLrDwtRVlCiETdHZ9Bg8wBTj0nvCJljrdRPO2EDfCE=;
        b=GQoSngCNAa6e/H2HL2dco1HWGv/lX7dPI4nmqQkdNYB8VSwivQ0qDPBN1Em8r4F/Tz
         Nl+2l+3yYYdtPgAjNXT2fFq0ByPdbpUR2Paou9MeItiWYsYDfCIgpB1DTpT1v7sBMK1p
         cmbEtTJxN2RHARjQdcI/Pg4ZhR4sBPXvgOCwiNXRkXzv9k0QRWytMCHPm06dXzj+Cj6q
         qxbxCFDGZbarbLghuYHzEbkLf+WuiiCWzbWxawrBRyh/hJphCuIUdURjf6L/UaJyJj5o
         iPotVfPIop5HCxUqRrsNXZwqAteacSxf+bIrjOmrjC+T/ZCpgjG0O6Zw9iBzWrYNPk2P
         BrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689581222; x=1692173222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdLrDwtRVlCiETdHZ9Bg8wBTj0nvCJljrdRPO2EDfCE=;
        b=UcnfwtWrRtnFNk7mdw/Ewbly+S1KI+FWbghIIhfkqJ9cEVTXt6o84NRJJh1XAv50Gp
         VWC+ZYK5feRgcHw5nY8raWSeBFQENwAPTBnmZyPZAAq5hHTOeEoZp0NWuiKgE29DfRvN
         Tp9AiZnfTApf8QYXLQLweQK+QHr13gZPs0Vd+2PK2AF4Evs891AHrQkw6T4M8VvKWnV+
         7qUzSFP2KkIJPiTKb2FDKj+TBJyB0xHyUNcR7ZyJKAEXDn/wHsAQ3lw6fbRd/VrBdDnj
         nNVpCLd3D9WgbOa028D4ASgmrtByWswl6NsGtQ+Y0oKfdOJmD8tOBIS0xP4T5bJ2/D9S
         hatg==
X-Gm-Message-State: ABy/qLZ1GHu487StQ3jMVExb9V67fFXC68WoEsZqXRkw6Yw+5bFHXzPm
        57dkzgq8KseRBCiVPnZvnS/FNA==
X-Google-Smtp-Source: APBJJlFIL/TrZRnOtIE+eIdzD/XIjz6sOl9xKdyQxuncr8P30NcMygIGf8e174N3/uK22gqki9TlzA==
X-Received: by 2002:a7b:cb97:0:b0:3fb:b3aa:1c89 with SMTP id m23-20020a7bcb97000000b003fbb3aa1c89mr8713393wmi.19.1689581222383;
        Mon, 17 Jul 2023 01:07:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:365f:ad52:16de:396c])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d508c000000b00316f9abf073sm5010660wrt.82.2023.07.17.01.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 01:07:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2] arm64: defconfig: enable the SerDes PHY for Qualcomm DWMAC
Date:   Mon, 17 Jul 2023 10:06:53 +0200
Message-Id: <20230717080653.116855-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Enable the SGMII/SerDes PHY driver. This module is required to enable
ethernet on sa8775p platforms.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
I'm resending this again as suggested by Krzysztof. It's been marked in
patchwork as "change requested" for some reason.

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ba9bfd32c741..736cbc1b10ee 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1386,6 +1386,7 @@ CONFIG_PHY_QCOM_USB_HS=m
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
 CONFIG_PHY_QCOM_USB_HS_28NM=m
 CONFIG_PHY_QCOM_USB_SS=m
+CONFIG_PHY_QCOM_SGMII_ETH=m
 CONFIG_PHY_R8A779F0_ETHERNET_SERDES=y
 CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
-- 
2.39.2

