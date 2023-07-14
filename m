Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545E275356B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbjGNIrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235623AbjGNIrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:47:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EA3270D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:47:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e57870becso1892316a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689324451; x=1691916451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FA7l8IIaj4aslYJzQ2fc8TOlfhX9HZt+/RtZQq7WtRA=;
        b=IjRI/ni/znH5CfUK0qL5zLtrjXUMOaLNLSrIjp94+7qxfkRqsKiVPVS+QG7xDnOTp5
         zqVS8raXsnlmrk4UofwpwgzbCex35dBTyD18hk9u7sFl1jpNKPh+lX72cNrhFb5pbBau
         V9OQY57fR7x8DEGW5GblZVYzOMBpn48qmiyKffhHB53Iyrdr6hZAsU4FQbUnwglf0/nI
         1kAtgRohXmRo0S3MxwHv2JDA9+VJB2NkEIrC22nQKOinVipQiTkZ1HD8QXSiTDj7O8G9
         8Z11gWKpFdHJY5N91jzvPamwh1Gp414zZHdDII2AF50a8m+nDyOXIdVbgKbwR7/E1CZB
         rFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689324451; x=1691916451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FA7l8IIaj4aslYJzQ2fc8TOlfhX9HZt+/RtZQq7WtRA=;
        b=OrqkRr6YgyGdIdIVzJsDD+0476iWHYQH/0H671hwr/pHRwUiSQ9ipOrWssMVEUnbhd
         RpfcTP0/qRLUIQE+S8d/0RCjtdrl0/K6xNV2/ndmExPvSUTi6ZKknwJZrs7Hev3GPtkG
         RyWiY+DvrWujDz7/YKMRNPS9D5M6H6r57SZ3+aRnullFFlvWPYIpBpzU0QwKYNv7tZ8k
         s1HOwSFtTwb9qAB454fHimdBYM21j/hjuDD05g3c3+PXsTEWNrnLtlAs6i2ZRFBYcRxG
         sEBLxp99BIrYm1dGcynJ+TRBmtiLZVLLkP01v9asd7a4iyo61HoNYVWvBeoS00woHmGB
         +kGA==
X-Gm-Message-State: ABy/qLZzhlRusPa3QCpey1fY2z4/CITM+buVk/gWPAQ+CpMqCdDw0/k4
        wRExi7aC2AazlcjBV/3uUiwLdDDw5AMA31HQIW8=
X-Google-Smtp-Source: APBJJlGbRMLTxhL0KR5Vo3tgekUEa/KYea9Ns8LQK2+4AHZpZEZ1JvWe0hTShfEvBphmXA2MIroU3Q==
X-Received: by 2002:a05:6402:1210:b0:51d:ec25:ce38 with SMTP id c16-20020a056402121000b0051dec25ce38mr3932884edw.10.1689324450843;
        Fri, 14 Jul 2023 01:47:30 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w24-20020aa7cb58000000b0051e0f8aac74sm5480662edt.8.2023.07.14.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:47:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nishanth Menon <nm@ti.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] Documentation/process: maintainer-soc: add clean platforms profile
Date:   Fri, 14 Jul 2023 10:47:24 +0200
Message-Id: <20230714084725.27847-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714084725.27847-1-krzysztof.kozlowski@linaro.org>
References: <20230714084725.27847-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
---
 .../process/maintainer-handbooks.rst          |  1 +
 .../process/maintainer-soc-clean-dts.rst      | 22 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 24 insertions(+), 1 deletion(-)
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
index 000000000000..87feeb5543ff
--- /dev/null
+++ b/Documentation/process/maintainer-soc-clean-dts.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+SoC Platforms with Strict DTS
+=============================
+
+Overview
+--------
+
+SoC platforms or subarchitectures follow all the rules from
+Documentation/process/maintainer-soc.rst.  However platforms referencing this
+document impose additional requirements listed below.
+
+Strict DTS DT schema compliance
+-------------------------------
+None of the changes to the SoC platform Devicetree sources (DTS files) can
+bring new ``make dtbs_check W=1`` warnings.  The platform maintainers have
+automation in place which should point out any new warnings.
+
+If a commit introducing new warning gets accepted somehow, the resulting issues
+shall be fixed in reasonable time (e.g. within one release) or the commit
+reverted.
diff --git a/MAINTAINERS b/MAINTAINERS
index b61289fa7891..7405fb6e38c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1561,7 +1561,7 @@ S:	Maintained
 P:	Documentation/process/maintainer-soc.rst
 C:	irc://irc.libera.chat/armlinux
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
-F:	Documentation/process/maintainer-soc.rst
+F:	Documentation/process/maintainer-soc*.rst
 F:	arch/arm/boot/dts/Makefile
 F:	arch/arm64/boot/dts/Makefile
 
-- 
2.34.1

