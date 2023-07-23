Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE2D75E20C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 15:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjGWNTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 09:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjGWNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 09:19:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1961810F5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 06:19:36 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3110ab7110aso3074894f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 06:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690118374; x=1690723174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENETnkocXZi6dl4NhjFyWgfk3+p5JzgNLDZ8yvhlSSE=;
        b=qwj3Uno2LcoIiU1bvwWEdgC9M4R6885fys9S+g24ZVmcbMOI3G2vBvXkUjm9zozJfO
         o/Cw9C7U70/pHY+mjkfPwtHB3srjLyrb6oMLqn0OW6bYuxpmhwDFBOjvkB7pRSUdR+4w
         esxviqIzSvO0KNzXqTiYUUPCN1lQIk2WwESvnMOqVwDtErHvJVSl4dvAiPS+SrSNLRyn
         aZ1ktFTN6QDhkoJED41ND4fpYliEgX94AD7LU52VSe7XVm944B+/WBci5ooRJbJQpOXF
         fHp06Tw602sklEyo8ODwPA8NVlL8kJ0SPpi5siPg1Ew0YFffTDabX7BXkwwBrPFFWEo7
         1k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690118374; x=1690723174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENETnkocXZi6dl4NhjFyWgfk3+p5JzgNLDZ8yvhlSSE=;
        b=Urb7HhuB+F6TMRoJmiNJaAY9UXPGkCbNUVCX3/GdUH7DptcTDGUqfyh96QGIF4Yc3e
         8EKHLANNkBKaCFeL+ElmztJF83EEb2vYYwZf3ThUN7lC6omGxWLDUagqUVb035G1k8lr
         PtKdnYQKPr4uegzxJ9Wl71MzzDlA54Ux0/pPxVL/U/EDzipk2ITL71JbbTQJglgDv85K
         A+OR9titB3ThIaviijMm/qZDaHlrRiEFTyuCiBa918de7UoDTjLfhu+/HBtp3Hrosemc
         fiJ7CWvsUsXjeYifpH5ZL30XBE1SmxIUHXvyFj2RAjDB5XVBNMiZx+rYrCfegp6A53Ze
         lAfA==
X-Gm-Message-State: ABy/qLaEo/vRvUVeAZrZaWOaHRqAp8ktqkBfe6ReVlREIvcxNZ44x40q
        44MQ8YhbmxVUptr4QoXVhQY58g==
X-Google-Smtp-Source: APBJJlE1mh/A7SHpG1M3wY7olKbn/R8UGGriuIeym+XzmrhUYQAyuTY62uc5V7JdcDXSZqRFR3uajQ==
X-Received: by 2002:adf:e68d:0:b0:313:fe1b:f447 with SMTP id r13-20020adfe68d000000b00313fe1bf447mr5564326wrm.71.1690118374599;
        Sun, 23 Jul 2023 06:19:34 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d49cf000000b003143765e207sm9700257wrs.49.2023.07.23.06.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 06:19:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, arm@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/3] Documentation/process: maintainer-soc: add clean platforms profile
Date:   Sun, 23 Jul 2023 15:19:23 +0200
Message-Id: <20230723131924.78190-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230723131924.78190-1-krzysztof.kozlowski@linaro.org>
References: <20230723131924.78190-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoC platforms require that commits must not bring any new
dtbs_check warnings.  Maintainers of such platforms usually have some
automation set, so any new warning will be spotted sooner or later.
Worst case: they run the tests themselves.  Document requirements for
such platforms, so contributors can expect their patches being dropped
or ignored, if they bring new warnings for existing boards.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

---

Changes in v3:
1. Rephrase according to Rob's comments (this document when referenced
   in maintainers, "... and dtc Compliance", existing warnings are not
   new warnings).

Changes in v2:
1. Add Rb tag.
2. Implement Conor's feedback: change doc title, follow->should follow,
   minor style changes.
---
 .../process/maintainer-handbooks.rst          |  1 +
 .../process/maintainer-soc-clean-dts.rst      | 25 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/process/maintainer-soc-clean-dts.rst

diff --git a/Documentation/process/maintainer-handbooks.rst b/Documentation/process/maintainer-handbooks.rst
index 9992bfd7eaa3..976391cec528 100644
--- a/Documentation/process/maintainer-handbooks.rst
+++ b/Documentation/process/maintainer-handbooks.rst
@@ -17,5 +17,6 @@ Contents:
 
    maintainer-netdev
    maintainer-soc
+   maintainer-soc-clean-dts
    maintainer-tip
    maintainer-kvm-x86
diff --git a/Documentation/process/maintainer-soc-clean-dts.rst b/Documentation/process/maintainer-soc-clean-dts.rst
new file mode 100644
index 000000000000..1b32430d0cfc
--- /dev/null
+++ b/Documentation/process/maintainer-soc-clean-dts.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================================
+SoC Platforms with DTS Compliance Requirements
+==============================================
+
+Overview
+--------
+
+SoC platforms or subarchitectures should follow all the rules from
+Documentation/process/maintainer-soc.rst.  This document referenced in
+MAINTAINERS impose additional requirements listed below.
+
+Strict DTS DT Schema and dtc Compliance
+---------------------------------------
+
+No changes to the SoC platform Devicetree sources (DTS files) should introduce
+new ``make dtbs_check W=1`` warnings.  Warnings in a new board DTS, which are
+results of issues in an included DTSI file, are considered existing, not new
+warnings.  The platform maintainers have automation in place which should point
+out any new warnings.
+
+If a commit introducing new warnings gets accepted somehow, the resulting
+issues shall be fixed in reasonable time (e.g. within one release) or the
+commit reverted.
diff --git a/MAINTAINERS b/MAINTAINERS
index 7624eb231b65..9fe3870300f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1573,7 +1573,7 @@ S:	Maintained
 P:	Documentation/process/maintainer-soc.rst
 C:	irc://irc.libera.chat/armlinux
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
-F:	Documentation/process/maintainer-soc.rst
+F:	Documentation/process/maintainer-soc*.rst
 F:	arch/arm/boot/dts/Makefile
 F:	arch/arm64/boot/dts/Makefile
 
-- 
2.34.1

