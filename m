Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B4E7D2A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjJWGV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjJWGVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:21:22 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D325410C3;
        Sun, 22 Oct 2023 23:21:19 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 369214C0C6;
        Mon, 23 Oct 2023 11:21:06 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698042069; bh=4dXuAwglO4a/qLy/zzCFzx4geirBGhzMB/dhxgDlnwc=;
        h=From:Subject:Date:To:Cc:From;
        b=zPo5cN9DIYUypUbh53SjjTp8ncPkGgdIiXk6fWHwryaOP+NPtw/4M/7lgAACeup7c
         psGkjznGvc1pWZBWrGlqqJ0DX+9BDJGYX7bed+nhWOeln/40qXhBdVpVdJfRPoGzvV
         RRBzA1f0fuVwxVBRkHMTcy5KZ+p6n9rmkMvyxvJ3qpuukt6znAOIjzUn14H7XFJFfl
         Ir8Gr7cZhNDUtFPOWdfneIVoN3Wri79/Th4BS6Y8s3SqxLpX5SF1s/A6YQpDsDf919
         j/PC72hYDa7BdFte7M1P9zdv4bspc82Zx7SiNrh9HxfGeMviw76JrkwC8Kw5APTC5L
         TD/hzhYVQErfw==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 0/3] pm8916: Add BMS and charger
Date:   Mon, 23 Oct 2023 11:20:31 +0500
Message-Id: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK8QNmUC/32NTQrCMBCFr1Jm7UgSRY0r7yFdOE1iB+wPmRiUk
 rub9gCuHt+D970FxEf2AtdmgegzC09jBbNroOsf49Mju8pglDkoq084D5c1XBJGGgRf1KEJpMl
 apz0ZqMs5+sCfzXpvK/csaYrf7STrtf3vyxoVnh0pOppgq/yWYh738Q1tKeUHGjl1B7QAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=4dXuAwglO4a/qLy/zzCFzx4geirBGhzMB/dhxgDlnwc=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlNhDOBV0ENqhP6SxR45w7p3/0ukR7TyALrk+mZ
 RN+opCke6yJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZTYQzgAKCRBDHOzuKBm/
 dbsrD/wLU8R0DUYQcnXKSryz0M3dtGe0z2es/wcfYOs4bxHdyhV52FVIl9OkuRXqYFdw38pRzVy
 +EQNChnhGwb9sCvWFDQYxWCZVXKmm77JEdGp1yr3On+Mw2T5q48qhxN8IrDH16nfNa9ik/PuztL
 F3kcax9dvxPimtmNifgqW42lgTc+o4zI+L4yVKO+ZnIVLexXIuNZQ8mlJ53c8icCSIPaqZaIDmQ
 qKO+Q5tSGEnjLRL1/5lS+W8DiKJXrblymGejlO9w3OSEjw9JDI20bdsIxym+NF0c9A6UHzrkD7Q
 lvN1y5w768IU06Q5Y8CiSEPMGTJLH7zY8sNqTaHZ+kqf7quSfxM2kW/ohc3umuSGCzHsL77mXss
 w+FdpzsTdQsDzc5Zstzx+L9EX0HD8Cu++6FUVoRJFRr3YpRNFMqclZbQclqnYy91YHYyscdwe+K
 VC88+fcWeOXzPAyTwT6I45NKPFRAEfC5nlJtOooyoeA74WuiCwBI+I/jM5oiVR6C1V/IXkiA8UT
 oAuEcKqOS+nlsUQVnA1ihDwP4UXq6NTYxWyNs14c73r9galqklEVahMgKaia8pQoTfjuUGBPwQD
 oWkG6bNNOpvfjvMGGgxO+FlyT9vGNveRffFIEvD/PV/lQuIxlmL/ag3LXptzxgkRexWWPNlkxNJ
 5lPBbaq0AcxCBHg==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
base-commit: 2030579113a1b1b5bfd7ff24c0852847836d8fd1
change-id: 20230916-pm8916-dtsi-bms-lbc-2fb1b99d1eb2

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

