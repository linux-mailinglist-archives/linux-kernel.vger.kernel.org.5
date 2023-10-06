Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176EA7BC022
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbjJFURO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjJFURN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:17:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F32C2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:17:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso2057961b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696623430; x=1697228230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1eBnvmyPH2CZ9nM0L4OdqfRabPTQXIENd6RkEgpAic=;
        b=K/BMsDKnBX4LyJETsKidzzFjYBgMstd12+yf3lq/HGbPmyDvyR2pKB7NeeL+entCxA
         3Y0vjXXj2keeWn8iw/IXNce3THRUSs7TZiXMlrcsUkHapFLTaoxjMsP+gY2zBfJEdhRT
         BUZ6bxMP8lMEzZ6oLkXv+tCftdzNj7enupxxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696623430; x=1697228230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1eBnvmyPH2CZ9nM0L4OdqfRabPTQXIENd6RkEgpAic=;
        b=GxcABV5eF4AMFkOHQubY9nFfXPx/hSzBXLzDl5cI6rK73GtjJ2CKzkm+vqblI8QN3i
         uGy8kGFdv7lKHEOsZrd6FI+9Gte/C6GhoYidw+YQdflWyHqAoZn9yyoHQFUXfnhbXbeQ
         Pbc4Bly04I6hC2BmPvAA+BbgXkZj/z01HLGRMIjy7lWRI0SJlfckqmsfMvrpWt6RPC/c
         ksSERKn+nnNqBYw3OEtT36SuzJs8oY9mVQVusu5O42i3/gJH3IjRXA1T4H4a2faZFDPU
         aBIekn7ih8h9apflAwEFXkCdC0wSRr4tc70N/kOaFI90V+z2MxvEvNVa24ZjrBTAlQmq
         rv9w==
X-Gm-Message-State: AOJu0YwlSyua4LBVvJiTcBre2IfZbAeb1fIdixclvT4H/mTgVTgwyCLn
        n61jaVq0NXxwLCQsqaJdKSobRg==
X-Google-Smtp-Source: AGHT+IEtlTeDLTCL/lFi+oJBgl0DcZtNH+OVNahSkKRT97SzL7fnVmB7IYgd/mR8i75HJAy9DMPCdg==
X-Received: by 2002:a05:6a20:2451:b0:14d:5580:8ff0 with SMTP id t17-20020a056a20245100b0014d55808ff0mr10184865pzc.25.1696623430379;
        Fri, 06 Oct 2023 13:17:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 15-20020aa7914f000000b00692c5b1a731sm1875791pfi.186.2023.10.06.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 13:17:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] pinctrl: samsung: Annotate struct exynos_muxed_weint_data with __counted_by
Date:   Fri,  6 Oct 2023 13:17:07 -0700
Message-Id: <20231006201707.work.405-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2568; i=keescook@chromium.org;
 h=from:subject:message-id; bh=lsTbTj1Qtp6GgXJHYDIN0GpRbyjpp/e7Ct6QQbjSy0Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlIGtDy9BWBe1i4kwKNKaTCXh1WjWe/M2wbybFm
 RGQGh5dTv+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZSBrQwAKCRCJcvTf3G3A
 JkxPEACXFEGhNrvxBkTKUfgVjkyDrnxC4WfPJdhQxqmOPOzyY7EPwkDCEoiad2SUhfNal9NNCX2
 YG6o8XD/Uh2tW7jyIlkOfT6uBfN7mpF6v8hCUD+fj68+miZhqVOIS/HHe0lZoS+pIPABq9VOexQ
 jjhxKYKoT8/9zXbQpD73TUCh9JHPIVlA3/ogT3ZoqWFJxtyNsuR//kYxSK3cTmx7KTH2cjdhNfE
 FOVAGIaap8Ql40LUwC7YnOL3GgFklirZ49tih0ydJ92l/cBHsNFOneuAL9sAORZPXrC9U3zx2wl
 5PwxcY6gIE6Qt+/crsR7qoAO5VwSQGiDcgv/NfhyFZ8WIeDnffMI47fj8qHurqCTH2to25FGThw
 Wae7K4YrpBU7BQ1VjmJpSAT3vTjH/7gsV1m6n93iTXw6A+M8li7P5V1kpw1VTdyRmEvikJfo5SL
 HIJ89R8z5r9OZLteo3msJf6liREQIfgVYXvyAFMP5F/MRQO2jV2nRG9V9Q9epbB6SdpTjzxiO3Q
 971qa3ROTD5xraPe3iEYKh/b5jWN9fzoYD4WWl+ptluj6FTIhL0MqsPBkRwH2EkTIYRsncnJZd+
 Yrf3FjEvpL7AzCI34QOyMBEeP2ttb4NVoGGAQWWt5I97UEdH5QyqDsOL/vI8bR3Oj3ccd8l77Eq
 6vqzydT cWFqXEJQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct
exynos_muxed_weint_data. Additionally, since the element count member
must be set before accessing the annotated flexible array member, move
its initialization earlier.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 2 +-
 drivers/pinctrl/samsung/pinctrl-exynos.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index a8212fc126bf..6b58ec84e34b 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -616,6 +616,7 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 		+ muxed_banks*sizeof(struct samsung_pin_bank *), GFP_KERNEL);
 	if (!muxed_data)
 		return -ENOMEM;
+	muxed_data->nr_banks = muxed_banks;
 
 	irq_set_chained_handler_and_data(irq, exynos_irq_demux_eint16_31,
 					 muxed_data);
@@ -628,7 +629,6 @@ __init int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
 
 		muxed_data->banks[idx++] = bank;
 	}
-	muxed_data->nr_banks = muxed_banks;
 
 	return 0;
 }
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.h b/drivers/pinctrl/samsung/pinctrl-exynos.h
index 7bd6d82c9f36..3ac52c2cf998 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.h
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.h
@@ -159,7 +159,7 @@ struct exynos_weint_data {
  */
 struct exynos_muxed_weint_data {
 	unsigned int nr_banks;
-	struct samsung_pin_bank *banks[];
+	struct samsung_pin_bank *banks[] __counted_by(nr_banks);
 };
 
 int exynos_eint_gpio_init(struct samsung_pinctrl_drv_data *d);
-- 
2.34.1

