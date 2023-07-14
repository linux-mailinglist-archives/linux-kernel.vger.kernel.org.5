Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130967530D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjGNFCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbjGNFCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:02:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965732D5F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:02:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3158a5e64b6so1559006f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689310948; x=1691902948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf5b8Tn7imiJAgp4f2GnrUX+ZsHyR0cjspo9UaU3mm0=;
        b=vn74eK0wTQrm0bnz5we6gJrxJYUWJC/mkcsdNfYD6rmqFLZUcT/0VlTUEaEIZoaFhy
         E+xWactO0Sw8wuU6tIEgnv1YZz7bP0glPtgo0SAQE7So2hKyahpBDPFgrNZZVh5iPL9X
         adIC+mAQmgFHN31lQFvE5z0QNSOc3vX3LHcb3DPxzx9LAFwImiDsBeqT/buK/0p4GqXH
         PJTH3TktTvDRRn2oq8mgRs2Yi9YjbXVNdF3cMwuNqu4BLXl1boeTghoftdAzYDKgJz/g
         JEf9u0S/p/Tw+5ljrrVRwfiuwvPAwc3cSLZZ/C7LGF2ZhOSn87Z/Ar1u56lQBanWhcxD
         OSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689310948; x=1691902948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf5b8Tn7imiJAgp4f2GnrUX+ZsHyR0cjspo9UaU3mm0=;
        b=TWO7/CwHc8NqFfKTt7pJlKlHothf+XQXT9/7rPnu4bl7dGyIktpQVptpjqcUWJ8e4n
         8IDSRd9/G3x+AkF45CF7bcpSl5JxEt00X7hR9G//AZq7uRhnsyiHNBlUyzdmzdJCCS1+
         0RK86Vn1AnMXS1DEhI0V9omrgvgj2NqWRPJk1ZMdnpA8Pmng2sscK4++RxD4eYvEOj/n
         v17+CqbmIX4silyCP3JlnIIM0KlLhd+qBGRW7C0rVAXPUlpdv/PjvjBeGl23MeEUXQqg
         56nMmijUx9jDoDHmf6c0WucvY0FtbNNeNYbCIjAJh0Z3N81Uig3JWaZEzqs2yPWpPQut
         2evA==
X-Gm-Message-State: ABy/qLZWKlmIF9ONroKfACA6xNyB+GkSAPK/++Mydfda34cDRk7IG/3k
        KEkM99/a3xCrLdPsEYhvhhYtVg==
X-Google-Smtp-Source: APBJJlE7MWlijdk9HFLnOuXlNpCUrmW1MbQ7xwX+Wx1gDld9/egD9byTvG9qACKRUnAyZxRd0RN52g==
X-Received: by 2002:adf:f1ca:0:b0:314:5f6f:68ce with SMTP id z10-20020adff1ca000000b003145f6f68cemr3050264wro.66.1689310948133;
        Thu, 13 Jul 2023 22:02:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d684e000000b003145559a691sm9710883wrw.41.2023.07.13.22.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 22:02:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH] MAINTAINERS: samsung: Un-support cpuidle and clock drivers
Date:   Fri, 14 Jul 2023 07:02:23 +0200
Message-Id: <20230714050223.8327-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Since few years no one is really paid to support drivers for Samsung
Exynos SoC CPU idle and clock controllers.  Correct the status to keep
them as maintained.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b8cd03f5e52..f646ba70a01b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5367,7 +5367,7 @@ M:	Kukjin Kim <kgene@kernel.org>
 R:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
-S:	Supported
+S:	Maintained
 F:	arch/arm/mach-exynos/pm.c
 F:	drivers/cpuidle/cpuidle-exynos.c
 F:	include/linux/platform_data/cpuidle-exynos.h
@@ -18881,7 +18881,7 @@ M:	Tomasz Figa <tomasz.figa@gmail.com>
 M:	Chanwoo Choi <cw00.choi@samsung.com>
 R:	Alim Akhtar <alim.akhtar@samsung.com>
 L:	linux-samsung-soc@vger.kernel.org
-S:	Supported
+S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/snawrocki/clk.git
 F:	Documentation/devicetree/bindings/clock/samsung,*.yaml
-- 
2.34.1

