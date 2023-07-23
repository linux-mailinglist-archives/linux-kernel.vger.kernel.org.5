Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997DF75E210
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGWNTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 09:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjGWNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 09:19:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A28D10E5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 06:19:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso26706295e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690118377; x=1690723177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cq9s2MRmoeFpX577eLT/PXRHWoFvAvb+qfQGOwk/Af8=;
        b=W0lU3lshIhNR/8v9wa76sGNoC3/gt0Z0TcGHF/M2q51rgSHr0Fel0v6nJ3tqEJDjJt
         J6EU4FkyqOCOwTRmyMYTz8EFGcbEQAmOid+D85GXPZkMn+GqIFI6u31mQEvS3ia6gYkE
         VRyL00WcwDUTtKXOhdn47xSXqaam9KqD0/SNTMhvqGP6qTkrm/niqeQgBh5NHOeJFWWC
         R24IFPBAtM7OdWhPP5WKGZGI/PIgu0OUPXB2QiEjCf7D7vMYntFvHE6VBKxbGgkvgufQ
         m+U80+wXzPThWbrDYlJhlo8hRfhDDMpCGD7AZlN11oAQnn5eRu0ks4C81zzmR5cBBdKq
         ywmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690118377; x=1690723177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cq9s2MRmoeFpX577eLT/PXRHWoFvAvb+qfQGOwk/Af8=;
        b=VwIWrbxghgNnrPoT2xX61ynlndfvm9SgBPWdTQRfc7ACdA2+C973CSnyxXfBKN/fE+
         OP/uBbnWQ1JkMKKxzKJ41CRMQzdl1l1HnjtdmnKAVAPAtbjlqouj+ccEe109kP2xU4sS
         ScpiJt/iklkFNGS4VmdOmWnh7JgRgwTOPWChXGtpiuRcOMJAatoxPdu+0RhhhwpJX7FJ
         HW72Fklts35H38yyiR8RNAxmgHZIFV0Cp2QhJ48dx6ce9Cu0SxrLlvi8g1H8MlJVu3OP
         KyQvpNl0yE9TFdZAdEHcETPVlQiCIkozF5XxzAEXfwJhf6A68qR1hYjnng8pCdqwYSmi
         uNkg==
X-Gm-Message-State: ABy/qLZhYQFOUdq3ephwkbdErXzOp8IBaLEQcsyod5aclV8w2yO8EwdV
        mvI0mJN0lHFU72QlEK43XDbEVWVF9jl2yXyeMcY=
X-Google-Smtp-Source: APBJJlEF3DVK7Nm+ZYwiYQ2FdzbEw4bJ8lmL4Nhtpd0CxQPE5O2W9Bh4hUdzsrZ66YAwaJvSWSixFA==
X-Received: by 2002:adf:fe12:0:b0:317:54d9:eb48 with SMTP id n18-20020adffe12000000b0031754d9eb48mr1484877wrr.11.1690118376994;
        Sun, 23 Jul 2023 06:19:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d49cf000000b003143765e207sm9700257wrs.49.2023.07.23.06.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 06:19:36 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/3] MAINTAINER: samsung: document dtbs_check requirement for Samsung
Date:   Sun, 23 Jul 2023 15:19:24 +0200
Message-Id: <20230723131924.78190-3-krzysztof.kozlowski@linaro.org>
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

Samsung ARM/ARM64 SoCs (including legacy S3C64xx and S5PV210) are also
expected not to bring any new dtbs_check warnings.  In fact this have
been already enforced and tested since few release.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. None

Changes in v2:
1. None
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9fe3870300f2..4b299e39111d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2646,6 +2646,7 @@ R:	Alim Akhtar <alim.akhtar@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
+P:	Documentation/process/maintainer-soc-clean-dts.rst
 Q:	https://patchwork.kernel.org/project/linux-samsung-soc/list/
 B:	mailto:linux-samsung-soc@vger.kernel.org
 C:	irc://irc.libera.chat/linux-exynos
-- 
2.34.1

