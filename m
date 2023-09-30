Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB57B44B3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 01:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjI3XrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 19:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjI3XrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 19:47:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D30AC
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 16:47:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11405C433C7;
        Sat, 30 Sep 2023 23:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696117632;
        bh=5eppN813zFoKnPEbkiP4INNThJVSpE2PJsdODGQrVjQ=;
        h=From:Subject:Date:To:Cc:From;
        b=ZWlo+8ja/3Rmd40toQ8rz8Xk7MXvzU3YYPDyV7zfLyEGDIsiJWwOiYIyTIIwJN5nZ
         95fGHhtM8Y6tBc7Pxmgwcm27xUpBbbg4PLf+ut4sPjIv1WxZIJpXACa1oBpZ1wJt23
         6C48nS59BA0xUuvCibreXT/EjxqAh7dXiEkipxwIyVAd6DEiFCY0wVHYNX8urbaT/3
         QI4HZ5S9VlMH13JtOQ/J1jzJU0t3f5zA7+xB6N0QKmSPbvK62w+3nlr0vZ4q0+IyTo
         HCnlE029cI0/OUeCUr+S09aTHOf+CIhzzipFSLl3TGHarQ5TChxU1aeB/Fdl2Z+vuu
         e4GzbK9PiJrOQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] mfd: maxim: Convert to use maple tree cache
Date:   Sun, 01 Oct 2023 00:47:04 +0100
Message-Id: <20231001-mfd-maxim-maple-v1-0-cdfeb48a4d15@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHizGGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDSyNL3dy0FN3cxIrMXCBZkJOqm5RkkmaabJpoZmGSqATUVVCUmpZZATY
 xOra2FgAsyiFbYQAAAA==
To:     Lee Jones <lee@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5eppN813zFoKnPEbkiP4INNThJVSpE2PJsdODGQrVjQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlGLN7FwSJokF9F/NES7So41edjjnqeFKfPB95k
 BhZF9lACmWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRizewAKCRAk1otyXVSH
 0LSZB/99A+wflX2lHIemgg2lzrcG1461IsJc/A/+QG9yNy3DlBAu+am7bcQtY/d6yFe7n4pvCpT
 4yszg5zT8jM5ZMUeAXJxO7f0XkqxeNbpyPB71hGfklzx3cO9cvO5dUpxt/FQRkpW7rkcbxvD8pb
 j+R4C/DGQPhwQlZdtlhfJIAL2zFFn57OYr5XdN2TI9UWqoV3CFec4jv/hBajd+I2Xj5+IwnqoyY
 zOIMSUre+6CbP0wYPIhpyZ8YsUtvV8iyOsVFgetx7TavVRKCFhPT+ZTUWgx/efrUN4DrueigVZf
 bDZWVoDpG1SlubTozt5/7I11R/0H46OjSI2ctVweoNS4nt5J
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache is a more modern replacement for the
rbtree cache, the data structure and surrounding implementation
decisions are more modern.  Convert the Maxim MFDs to use maple tree.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      mfd: max77620: Convert to use maple tree register cache
      mfd: max77686: Convert to use maple tree register cache
      mfd: max8907: Convert to use maple tree register cache

 drivers/mfd/max77620.c | 6 +++---
 drivers/mfd/max77686.c | 2 +-
 drivers/mfd/max8907.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230929-mfd-maxim-maple-bb4f5c5a684a

Best regards,
-- 
Mark Brown <broonie@kernel.org>

