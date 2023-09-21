Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED277A9ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjIUUMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjIUULz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:11:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634B5561ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:17:50 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5334f9a56f6so784143a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316669; x=1695921469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWszhBlTWMiwkXqgF1w4h8oNmYkV0xe9wPBMJvnXBgI=;
        b=gGR9Ph21fAE+az4hS0gxgRHlY8bXY/GswP7AjtctrxJJIQzHJvSEqU+yW5eWlQi9rk
         vlQZmPOu4fM29G7+lE6+DC83crxuHW2xV3nFcgX45kDO3CuC/iDlHUt38EYPJ2/AtfOp
         Fa7na4vIVAIE3w3fZo8N3fRNvyxdRuyZOhnRLmmESpinoGKoz8JQgLx8VjpW/N2KTGlf
         anwn/M+U636gNd83CnJPHwA4toR0LE3oQHGA6SHc0TjKiF9XsdviUK//0i/7hA3HfV9T
         PqJ3R1/lT0hoO67nRgce1Vs/ao3flGEmIv8vDpGd91tKChnVKb4Gw8IIJvXhaep5/lgr
         8weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316669; x=1695921469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWszhBlTWMiwkXqgF1w4h8oNmYkV0xe9wPBMJvnXBgI=;
        b=SgKJ6/riiHg2Az0XBTLGuOnZlsdaJuuExnhYiKSVvpi+jssmyaCRkOEec4ml0Qb0Go
         96EUuQTs2L1xjYxDBdTKU3uYp2hpIFlLwr3yrdvi5hK5hjLiAgBVsEDmt8SImr3O/YpO
         UL6pm0fJsnzsvloHODqLF+8X8e0LdRnVd97Y/7f21Zi0rgiacOsiB+BIcOtncbLqxtq3
         +2fl3hzgLNG73kfMRwhqPZFnKAuj0+ThPIMI+pSiYQioPy8hG8st5RsvQybbyRVpL//0
         s0hKk/1BtXNRw237bngYOtVf70I+zOY1YFRQ22wp1iXbqhzQyi0FOYQlAoLsjj1s5wmv
         fk2w==
X-Gm-Message-State: AOJu0YzwhHyEE93C9NJk9KbL+Nyin7KIprkVyps2OfkPkbQ/l0+gOJ/j
        RU1+HRtA7VqPguu/bnkz5wamb8FA8pkpVQWbc6wq1DaU
X-Google-Smtp-Source: AGHT+IGfS13FEnLVNfJuIWeRBxS2FNjPxoFFMDKS2aE22dbReCOydRtLnM6n0AwKa1SbUdaYxLP7RA==
X-Received: by 2002:a5d:4a82:0:b0:31f:ec91:39a7 with SMTP id o2-20020a5d4a82000000b0031fec9139a7mr5419502wrq.14.1695306154592;
        Thu, 21 Sep 2023 07:22:34 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:34 -0700 (PDT)
From:   David Lechner <dlechner@baylibre.com>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        David Lechner <dlechner@baylibre.com>
Subject: [v2 03/19] staging: iio: resolver: ad2s1210: fix ad2s1210_show_fault
Date:   Thu, 21 Sep 2023 09:19:31 -0500
Message-Id: <20230921141947.57784-6-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading the fault attribute, an empty string was printed if the
fault register value was non-zero.

This is fixed by checking that the return value is less than zero
instead of not zero.

Also always print two hex digits while we are touching this line.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 06de5823eb8e..84743e31261a 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -393,7 +393,7 @@ static ssize_t ad2s1210_show_fault(struct device *dev,
 	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
 	mutex_unlock(&st->lock);
 
-	return ret ? ret : sprintf(buf, "0x%x\n", ret);
+	return (ret < 0) ? ret : sprintf(buf, "0x%02x\n", ret);
 }
 
 static ssize_t ad2s1210_clear_fault(struct device *dev,
-- 
2.34.1

