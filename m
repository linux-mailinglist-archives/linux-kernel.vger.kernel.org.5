Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7B17F1539
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjKTOEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjKTOEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:04:21 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EE010E9;
        Mon, 20 Nov 2023 06:03:46 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 7259C401C4;
        Mon, 20 Nov 2023 19:03:38 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1700489020; bh=nIOHU2BvSbaz7wYn1+Axwd2Tlr9Xg7uhFol216/RE2E=;
        h=From:Subject:Date:To:Cc:From;
        b=2N/+xRNfxmXW7nZuv+EfmaIfI2HjnEZ4+Ye8PBc7UsifykBZ/C1TUUcMD2fwzE//v
         wwbTfCej1zmNmyCTrqBZSsveNKD5Y3sN7f0+h5oT5AOF/VnlTlLYJ8jUmn1Vm38jic
         MvphFkJI5VE4jfu+NA0bbQ2tpJn5MN1TPVLkIkQPvL/luT1iLtwmuTLFSO73/YbiFI
         KlnCSFtJkcUtyjKquUfAmpg8DIkizsx83Fy/I9j0xIZDxgMgsc5R3Gh8MEiZ18oCge
         ZhTkrh/Y2k9A5Lkcg/jEgz0sRI9QWsxPkT2e3Itt9pZ9sZuNImDDmvF0isd5Crs492
         AQvcPZJgZWfmg==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v4 0/3] pm8916: Add BMS and charger
Date:   Mon, 20 Nov 2023 19:03:02 +0500
Message-Id: <20231120-pm8916-dtsi-bms-lbc-v4-0-4f91056c8252@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABZnW2UC/33OwQrCMAwG4FcZPVtp0zKtJ99DPCxr6wpujnYWZ
 ezdzXaQCeohhD+QLxlZcjG4xA7FyKLLIYVbR0FvClY3VXdxPFjKDAQoYWTJ+3Y/NzukwLFN/Io
 1B48SjbHSITDa7KPz4bGopzPlJqThFp/LkSzn6X8vSy74zqJADd4Qfhxi7rbxzmYtw1uQVN8FI
 EFp5ZRFr0G5T0GthR8/KBJ8ZaX3QK+WK2Gaphe+1cOdOAEAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=nIOHU2BvSbaz7wYn1+Axwd2Tlr9Xg7uhFol216/RE2E=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlW2c2dDtTASJl+shNwWdZM2UgX4iIQLSzarf18
 BdyRQweCdyJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZVtnNgAKCRBDHOzuKBm/
 dcuZD/0Sw/HYBLqGxk6RzRTOu/mJem7k/rBxtq9qScUHOPnEHJyYVt5Bb97MzeBxjihvrh2FT6+
 kGHsQcN76A6Kmq443xwUhWh88bYrJ1Hbwrl3uYIlrBEkxvtNuAjwbQ1I3HbkWV3SLhgJNY5dtzq
 ANnnphUbhrZr58t9P2gPklf+1G9CkA016+cBH1C2NgyIIV3OSv6ZpcL1gSV7c/EGsWww6GDBKK4
 Enmp0amqSl4mljKmVo7C1LZQeh0TJ3tkohuKEBCc6kTuhN68DsUFf+VAKtByAijXBylEPd5rHCc
 e+XVU9uyHzd/PuW+31OJf9DyI30qRHSrR8hPDSCEYtWV0hhp4vSIuIbJQvtGQqfx+vX1HRlTz/b
 3dC4kYlO5YrBkEwGIxlmvEGdMhPi9wnDFb4nWcz9XVhTVTJlBs+GhMfxIjgy9rGXNIC4PfCswrV
 XyhQzgONTXXtbcixG2RONxD18N7JQaFQdHc+rP0PL+iPoBJWKfOF/6AOPO3cnv6UNX0z5AZknis
 i/XXCi5vw2aC9+OSvHzDso4lV4AAtBLJJ+OZKCX41z3fpWWOQKolfReQ2jcPfKx1AVmdU86vKLR
 g0mctzUnbllm8dVhVVn/8sSYcOamx+UrzjQZoc3/9uSIXGq+udXbdQWtZVoxRmQ/yfINhWNsEEN
 fCpvVkEly6oFsmw==
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

This series enables VM-BMS and LBC blocks in the pm8916 pmic.

The VM-BMS is a simple voltage monitoring block that allows the software
to estimate the battery capacity left.

The LBC is a linear battery charger for lipo batteries.

Add both devices to the pmic dtsi and enable them for Longcheer L8150
which makes use of them.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
Changes in v4:
- Un-drop 1/3 (dt-bindings) as it was un-applied.
- Link to v3: https://lore.kernel.org/r/20231026-pm8916-dtsi-bms-lbc-v3-0-fad1ff22306e@trvn.ru

Changes in v3:
- Drop 1/3 (dt-bindings) as it was applied.
- Link to v2: https://lore.kernel.org/r/20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru

Changes in v2:
- No changes - resend with minor commit message edits.
- Link to v1: https://lore.kernel.org/r/20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru

---
Nikita Travkin (3):
      dt-bindings: mfd: qcom,spmi-pmic: Add pm8916 vm-bms and lbc
      arm64: dts: qcom: pm8916: Add BMS and charger
      arm64: dts: qcom: msm8916-longcheer-l8150: Add battery and charger

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  6 +++
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 43 ++++++++++++++++---
 arch/arm64/boot/dts/qcom/pm8916.dtsi               | 48 ++++++++++++++++++++++
 3 files changed, 91 insertions(+), 6 deletions(-)
---
base-commit: 5a82d69d48c82e89aef44483d2a129f869f3506a
change-id: 20230916-pm8916-dtsi-bms-lbc-2fb1b99d1eb2

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

