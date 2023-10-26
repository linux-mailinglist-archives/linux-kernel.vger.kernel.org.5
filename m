Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71BB7D7C91
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbjJZFyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZFyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:54:11 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E84F137;
        Wed, 25 Oct 2023 22:54:09 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C6F39408D9;
        Thu, 26 Oct 2023 10:54:04 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1698299645; bh=gDa6AVN3vo7ERUBFuN7/nhEFecN+h7HA4AxNspjfA74=;
        h=From:Subject:Date:To:Cc:From;
        b=tp2oNbxnkDn0WideMtOIogIjIaTH8HRvTYtEgcbxvqZpdyFHNyM+3TOowjwYxq0P9
         r6WLzcz4p5iOPaJxCl7EKKvkueab8V7JnoP4mKonwBGtp4oMR7nyc3atgM8D4egJiu
         RBhIw1JXVaZq1dVGIPDsDQvsPsU8hj9vFyZjUzS5b+RsytT62+8jNf5Ntc8+I5DeDz
         JU9zt7mSOZ6X6L+alw7H9UIKOx7sh6IyqEn7YQp8jFuBWXH8NHQeJmjYbvBSfh8BsM
         glss2y/nCTPc2AhA6v2y9FuXVaGVVelramX2C/XCWMzVhPCNGAxO/S8OrwKnQ4I/mR
         XQ6IcgrHcK9qA==
From:   Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 0/2] pm8916: Add BMS and charger
Date:   Thu, 26 Oct 2023 10:53:43 +0500
Message-Id: <20231026-pm8916-dtsi-bms-lbc-v3-0-fad1ff22306e@trvn.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOf+OWUC/33NzwrCMAwG8FcZPRtp06HWk+8hHsyauoL7QzuLM
 vrudjvoRTyE8H2QX2YROXiO4ljNInDy0Q99CXpTiaa99jcGb0sWKFFLo3Ywdodl2Sl6oC7CnRp
 AR4qMsYoJRbkcAzv/XNXzpeTWx2kIr/VJUkv730sKJOwtSarRmYKfppD6bXiIRUv4EVSZ3wIWQ
 deatSVXo+avkHN+A1bv+iX2AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=nikita@trvn.ru;
 h=from:subject:message-id; bh=gDa6AVN3vo7ERUBFuN7/nhEFecN+h7HA4AxNspjfA74=;
 b=owEBbQKS/ZANAwAIAUMc7O4oGb91AcsmYgBlOf749S6qy8jn8gFHv8ya0UmTDBMZ9bqqadoK7
 ScEvd5m9xuJAjMEAAEIAB0WIQTAhK9UUj+qg34uxUdDHOzuKBm/dQUCZTn++AAKCRBDHOzuKBm/
 dS9LD/9T7iD5tvyD/ej0dNBcSXEA+mrYHcS+fWieVOrXJJu9QDAdVLRrL09Te/pKn16lv6gYldk
 qcWjgKc/VbJLUU0BPCxjI+cWVuu4oJh7CkL6fKfT5PgXZMv1yTZgNVkuyrJkFlBkVjEhVHgJ7he
 R7zsafIyL0Fm5AwrTl0iExtiAVVK8xYwXjqSfMvuQnE94jegWAf7orBJgq0o9mrhI3KJyP4HSi2
 kTAeRwqe6S9n26O3Ie/Oln6UZXjyiP5eDiXZlfI1eKHfyGys3g7/xcqFeqkZIFUQAKbHgcgKGM/
 dRq1p6GpuVQQCWRgnqJhgaDtzUtMFOopNWLBrt2guSz5oROYiWphHUd8wz/RbbFEX4dW/YmxJV5
 hHauAh5shEmPhheBUxnm/6vq2BbR0nT8dG0Bzel8KazGuIPhUsvizB72MUEIPBM6LQXN/flm5O2
 Q/88tvHbabjoKgtdRG9ZMpalbRBmrJ4Akoid4eAQzsuVYzWsMvns/UgKPaWj2TqHZxkE7dCsGrS
 p8FufmY8iBC7CsQiTzahhEbycqKiO/wnqF9pCTgj2bHwrWq6n37z2YykI8ctnuTDOIkdGthxk8o
 KEK0Daplz5Gcvai2lPjZGWAmKjgWJAtlfZJteIz9gDddVYQ+J3EDckcDnQC1hPcjgVV+x38SfOr
 xCnD4i7oO7WRkGQ==
X-Developer-Key: i=nikita@trvn.ru; a=openpgp;
 fpr=C084AF54523FAA837E2EC547431CECEE2819BF75
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Changes in v3:
- Drop 1/3 (dt-bindings) as it was applied.
- Link to v2: https://lore.kernel.org/r/20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru

Changes in v2:
- No changes - resend with minor commit message edits.
- Link to v1: https://lore.kernel.org/r/20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru

---
Nikita Travkin (2):
      arm64: dts: qcom: pm8916: Add BMS and charger
      arm64: dts: qcom: msm8916-longcheer-l8150: Add battery and charger

 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 43 ++++++++++++++++---
 arch/arm64/boot/dts/qcom/pm8916.dtsi               | 48 ++++++++++++++++++++++
 2 files changed, 85 insertions(+), 6 deletions(-)
---
base-commit: 2ef7141596eed0b4b45ef18b3626f428a6b0a822
change-id: 20230916-pm8916-dtsi-bms-lbc-2fb1b99d1eb2

Best regards,
-- 
Nikita Travkin <nikita@trvn.ru>

