Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B867A1506
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjIOFCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjIOFB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:01:59 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9CB270C;
        Thu, 14 Sep 2023 22:01:54 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id D7F9A408F4;
        Fri, 15 Sep 2023 10:01:48 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1694754109; bh=bRTOlIXs0GaJZ3RdCo/eBGeEP3W8/vAikoVbTc2AJ34=;
        h=From:Subject:Date:To:Cc:From;
        b=oVdFy9tzVKsWmjw/D5RS62s1npOBflbrpxeFd6/xNgCsqUQPxcradeRENl0Su+lqL
         iOXLjMAUwPYTFerjma0g188SCF2AQZ46j8uV8x8PbXVxjBu2s2f+OthCj7Yi1Qr55p
         Fa4tP4YA/8QBiVm8yGgvV/JNRZQHKA61ApGaTwAAN6HmndzNxnKrxD4uA02Lw02Fw1
         IPAOGpU9LCv1r3Np0wyyy77SzSn0IMI3ojCWf2UsP1aH8TZQqAhP+RPDtxG95ZuOLv
         aeuXxI2Np8aHBqcawDr/+WXc73q3hxVMUigrjwh1G4hecMLp/fhVRDDBjLhVmCRRE+
         JyO/fl+9OTkqQ==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 0/4] Add pm8916 VM-BMS and LBC
Date:   Fri, 15 Sep 2023 10:01:17 +0500
Message-Id: <20230915-pm8916-bms-lbc-v3-0-f30881e951a0@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB7lA2UC/2XM3QrCIBjG8VsZHmfo+27qdtR9RAe6uSa0D3RJM
 XbvuUEUdfg88P8tJFjvbCBVthBvowtuHNLAQ0bqTg9XS12TNgEGyCRIOvWq5IKaPtCbqSm2iiE
 rEIQGkqLJ29Y9dvB8SbtzYR79c/cj3943pX6pyCmjhWg0Qi5kruRp9nE4+jvZoAhfMfK/GFKsQ
 OfWGCxrLj7xuq4vbXCo+ucAAAA=
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>, Rob Herring <robh@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=bRTOlIXs0GaJZ3RdCo/eBGeEP3W8/vAikoVbTc2AJ34=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlA+U7c8u3J61As8/aSeeKHxFN6Dr5shE4jHCda
 YprJj5ecgeJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZQPlOwAKCRBDHOzuKBm/
 ddwuD/9qgJWtTdoAV0ZffCSEmCCyWVW6jiIuo3bErhaIJSV45ffEK4kSwpDmZSbb1XOx4lOia8S
 7GqkNF5dUZ06L3L8tZnes43jFFItc0FbHA/FqfmhNT0QTo4ZgGXkGv6mwa155QEk0uwHfdre/xG
 CeLFtJ/p1GSus2YDZdYht0UVf0GvJ5dzZljcMxduo8UVGwfsV4Gu2wYZJytSa+Th2dnzOpR3Y/m
 8pfEKbM30KlIvhDmKRh6VJ4QrdDEVR88B/iOse8OuHnjnj39F/kCsDqaDOiEHGHm8dgaTiKYPkZ
 y1GjRGV3mROURWe1rnuYn8GTkP4dfD50L6LxN+ibogJDhkRDLxte60a0kTW2M727X+q941Tsnnn
 zz5xa0NKa3Qx36W1J7jz9yheBtgkw0hF1o9dSvB6OqOagVtabclBxc4O2bJV055LHe63LAE4nIj
 nX2EvYRgv1hzP1gB5UpiscJ3YlVwwQ99fzjgMvwMkESz/mFZ607314xx9AR7qcx8E7fx1rTUaD9
 1Go3ADTfcw97Y4FiX+TeKfmBtnnk9XfGRqq8RFRjpqO6Ym4rJvSG7TJg2LgdEp/Kf1wtb008mOg
 hOJ+b95zPziCkdLiJVbNM4lKmQXEq1Qdb+h23s1WF+HlfzUTG7XdvehGdXAIBnKVOt9W47Ad57S
 2MS1sgBy/LxekGA==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v3:
- Use device_property_* instead of of_*
- PROP_INPUT_CURRENT_LIMIT -> PROP_CONSTANT_CHARGE_CURRENT in lbc
- Report OCV with timeout in vm-bms
- Link to v2: https://lore.kernel.org/r/20230731-pm8916-bms-lbc-v2-0-82a4ebb39c16@trvn.ru

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
 drivers/power/supply/pm8916_bms_vm.c               | 305 +++++++++++++++++
 drivers/power/supply/pm8916_lbc.c                  | 381 +++++++++++++++++++++
 6 files changed, 921 insertions(+)
---
base-commit: dfa449a58323de195773cf928d99db4130702bf7
change-id: 20230727-pm8916-bms-lbc-3f80305326a2

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

