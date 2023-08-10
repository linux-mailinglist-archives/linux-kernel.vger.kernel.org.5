Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476E27773ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjHJJNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjHJJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:13:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1384230C7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:12:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-522ab557632so810812a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691658772; x=1692263572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pmjanwa7FaMhLMYXioPiW0FxTVwb1CQvmQDfKQ4w4Mw=;
        b=gRAU5xo0vansbTMZQipPzyKv6BUKttSBM0Z8Pwx0oTf9igSvGRzAwBhNJRGD+Wxbfs
         ILsx15h2SFw3xik4dIsMek8gEWgmzfuM7hOHHKUtAqRaj/AWMrBcrt5/Y7gY9kHcDmVC
         wpICj2aLXGy0eNaosNro8916UuX0wHTSncHyO6vo3B8/cKGAsbO+aVAxs8H8WpmpVfx1
         4vNNp4/Y60r04F9eLYpjuw4fXenTZuQ7kXGf2Kn/eRJKLFkWcJhi8qShflFyWtv9Yu8v
         imKoZi75xDAkzArXNLNc3Su6Mbjliesx6Q07McCS862F3+8mPkcSQ6q4n9qGf4iOp52U
         AeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658772; x=1692263572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pmjanwa7FaMhLMYXioPiW0FxTVwb1CQvmQDfKQ4w4Mw=;
        b=i9O0bCKBMQxPZ8j7KqsZFMjKDKvRyI6sY0SwD7r0urFYkiFzcGdfTxMyVDqoJNMOqj
         nREODPsB715WPLJwEl9tscYPlZi6Ws8KPAug3ydKgvic2YGS8Cou3K0MqsUq/GPBnCnz
         Mtg9/qvdJY3IRuTxqLq0aEikVMdi7ReWDoktMeb+cUvF1nGFii6V2yL3SKKyhikS4x39
         0GMGpce/AAx8fhvqpTHzernLpEgT0oDo/lozdxC9msnLJhSrefI9TGqey9UHrIDVhbCq
         cv+Vn2SPOx1I2K2J7zzt1WKqwEzv/LtpQ08BIMATPX4Pp4wzKcOZ4JK7Zq0y60h1j6iI
         jzqQ==
X-Gm-Message-State: AOJu0YwuVr29f2lNSjVuUY9HWgjCbeOrx/dXGl2FQREFIsUgznHbDEsr
        UBcwyvpLCVxmlNEkXaYeea8TIw==
X-Google-Smtp-Source: AGHT+IE9OU+bBFAAhGPvuibR9qpZs0k+oOpD0hwuV9OF+L4V2bjPKmr19tJP8nJNFn1nljMgKOjwOA==
X-Received: by 2002:a50:ec99:0:b0:523:372c:24fe with SMTP id e25-20020a50ec99000000b00523372c24femr1332231edr.39.1691658772644;
        Thu, 10 Aug 2023 02:12:52 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id m8-20020a056402050800b0051ff2b6139esm538889edv.5.2023.08.10.02.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:12:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 2/3] spi: pxa2xx: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:12:46 +0200
Message-Id: <20230810091247.70149-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810091247.70149-1-krzysztof.kozlowski@linaro.org>
References: <20230810091247.70149-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  spi-pxa2xx.c:1347:10: error: cast to smaller integer type 'enum pxa_ssp_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-pxa2xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 1bab18a0f262..21f156587669 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1344,7 +1344,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
 	match = device_get_match_data(dev);
 	if (match)
-		type = (enum pxa_ssp_type)match;
+		type = (uintptr_t)match;
 	else if (is_lpss_priv) {
 		u32 value;
 
-- 
2.34.1

