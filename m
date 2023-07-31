Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2629769F07
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjGaRLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbjGaRLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:11:22 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3213F5B9C;
        Mon, 31 Jul 2023 10:07:48 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 9534D408FB;
        Mon, 31 Jul 2023 22:06:43 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1690823204; bh=/Y8NyMX0ZcTudJzcfGX7rhtY7K7PI/lPFCPNvoSyTp0=;
        h=From:Subject:Date:To:Cc:From;
        b=3MOH7Qhdh4I8jxunIhBbxu45twtCJH81VP7G0L4dXuDTdiGcc8AItczzaKBhdvfxD
         K4bnCHHbyUIlL31s88Gf1vGISVyPM6dWTO46Gzvh4wutPPdaBkgrzPzy1K/QC6CZcb
         0feYm58z7XU8dirBCQgL++mie38wc8FNo7zBgeAb4CNfm0qYeQXQg2Euxc8wjxsaFX
         +ns1I0B4uWWZjVGzs0VLcEYiR85jznrc9ln9Fr8DT6s4mk0HcXo6JC0Lg9eBvvyA23
         1mHcSY/wlHBgeGVORDtKYJ/C8ZdNYJoPuTPLBlI55ephDVYilgdCtxWpv2UYydQXzT
         JkNAI9jvbxXMA==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 0/4] Add pm8916 VM-BMS and LBC
Date:   Mon, 31 Jul 2023 22:06:23 +0500
Message-Id: <20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA/qx2QC/13MSw7CIBSF4a00d+w1cGkBO3IfpgPaUktiH4FKN
 A17F5s4cfif5Hw7BOudDVAXO3gbXXDLnINOBXSjme8WXZ8biJFgihSuk75wie0U8NF2KAbNBKs
 ESUOQT6u3g3sd4K3JPbqwLf59+JF/1x+l/6nIkWEleyOolKrU6rr5OJ/9E5qU0gdS7weXqgAAA
 A==
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=/Y8NyMX0ZcTudJzcfGX7rhtY7K7PI/lPFCPNvoSyTp0=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBkx+ocLZz7M2fE56E/uyDsW4E0LR5gEKHclKJKJ
 DkomhVWRTKJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZMfqHAAKCRBDHOzuKBm/
 dRTOEACQTZEert5CUPcjG8zrZMg07XRuFzsan5XwR+LpGHguQqAVvb2h8Z4g9zPW1ApBnufeIha
 +7EyYuUvnD7WPhSO0yfw8srgl/krBKZlX1fOorC1toj6Ok0nfjdyUluiiyWj4rSyCXM2vcGV8SS
 xW2g1kSWdr4DX+FvvVIR+eXu+5e/Zt5AIwIse8XESfhkFEfFiYaPoHLoSXZpzM8AQyWY0VczhMJ
 zQj4nKxfc9LuXAWfHJKUndaZcy3rgBpgdhlo9DInvkEBWB50GsXfB9E2BEx1qcqyyZK1t3fFADq
 nNYSB2WRh4x9UVDNB4/dKQSST9AaxvPD6bQvkUPdqNHf7NylvsQ7WbjgH7urL+bQe/1iP9QBqFS
 wS662QZd7zyHZa9G3yUEZOH5sbP3tODZfEfDUGWCbmBgWUZegGau9dIqP2Fr+4yLTLYM+1TCMzW
 R7CcZqHNWHrjg9b32oH+ijHCiVUEtAvZOZnD+/qoXz4QHNaRZXleFAzQ6E0w06mu7bGF1Ct8hpY
 QVkvPHgjTWmMCiiyLjtg7bpAyhznXSoKeN6jlJKHtokpafV2uQvSN3iMHLDDJrWgpykO3KTvR9J
 zgYmduRwazHtDjVyzsEMOHw4XM9/1z8nHUAQaUN/8VC/lyaheT2zjwkus3rR+Fn5gGEBqfA5YTs
 cejVwi3DkJS4oNA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds charger and "fuel-gauge" found in Qualcomm pm8916 PMIC.

The LBC - Linear Battery Charger is a simple CC/CV charger, that works
autonomously after the current and voltage limits are set.

The VM-BMS - Voltage Mode BMS is a simple hardware block that provides
average voltage on the battery terminals.

These two hardware blocks are used as the battery charging and
management solution in some old Qualcomm devices.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Changes in v2:
- Add full interrupt list in the DT bindings. (Conor)
- Link to v1: https://lore.kernel.org/r/20230728-pm8916-bms-lbc-v1-0-56da32467487@trvn.ru

---
Nikita Travkin (4):
      dt-bindings: power: supply: Add pm8916 VM-BMS
      dt-bindings: power: supply: Add pm8916 LBC
      power: supply: Add pm8916 VM-BMS support
      power: supply: Add driver for pm8916 lbc

 .../bindings/power/supply/qcom,pm8916-bms-vm.yaml  |  83 +++++
 .../bindings/power/supply/qcom,pm8916-lbc.yaml     | 128 +++++++
 drivers/power/supply/Kconfig                       |  22 ++
 drivers/power/supply/Makefile                      |   2 +
 drivers/power/supply/pm8916_bms_vm.c               | 296 ++++++++++++++++
 drivers/power/supply/pm8916_lbc.c                  | 383 +++++++++++++++++++++
 6 files changed, 914 insertions(+)
---
base-commit: ec89391563792edd11d138a853901bce76d11f44
change-id: 20230727-pm8916-bms-lbc-3f80305326a2

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

