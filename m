Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF25E7AA03B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjIUUeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjIUUdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:33:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708778DEC2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:44:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1230014f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695318244; x=1695923044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9YCZ78k5Zg5KKitr5PpHsZw/Rz0qYyLXQR2L135bIs=;
        b=TZ/cVj3BtM2LyOm9DpFOV7gOkoRa7TUkjblhakk106DhTxxjy3BOMUnnp2BEhtbsEg
         yLi7vpgkforM2Eb90Si9ejD/U4TvG+0z8iXs1EwASpE3LiChVwBjnuxj7sic1FJjOpV1
         LPb2lH06pQPBtV4YgChseIROWsvlA6ghUAG1MWc2lEwNLgu+AZGm4bxRv4kuhIpVt00a
         ab5Kelj7CGdHMUEpRtMmJUgr0kquoJuWAMGsBi3fF7B+qawt/C4hrDv803FPHIi3poU3
         CSzAF01rLePGAVUQhqXk5hQlrlhoa8Ot5XVxrTi8rhWWFuu3A6WybJ4qWQ5/jp/UQmhq
         c6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318244; x=1695923044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9YCZ78k5Zg5KKitr5PpHsZw/Rz0qYyLXQR2L135bIs=;
        b=wpMRC+ab7Dma+HweglXr3ZGq1yMF0z3jMvM3IqlKEyeiUXNObiJqh1xny63N3AeX9d
         61qN1WzaD1Tj1r6rqwuV1Gkz44nMseljVo+RLrkESvsZZ+ClHvYsMmfAb9NNfErLvqzx
         vLkVP8i9t8NUWYWlbUuQJY6f1vfM75TB3zJslpA5fu69GWD2MZHInX0mEDSsefPgKWyd
         QRmzGP/hcoko31dgSkLl4rMxGA7qcuAep4VuVByIDDFHUjdQsWd4meJv+o6k8K/jKfU6
         +9iGGNxcReUFZGCbV3N19c7MxUJn+T5GHou/8DzbRt5dv5W/j3wT2sRSqfz0lQWKV5q/
         mpsw==
X-Gm-Message-State: AOJu0YxwNn+BT47c6g6jyDlff8JwRwWb9TFzMxMG9z8jWn49NWy/MZ6S
        ftmw6OdNFPj+2ejv451yaWC5uwaRvnBp5psQRlZoj/6f
X-Google-Smtp-Source: AGHT+IEpFrDSoMcGwkX92bs0KANrkQRic6vkb2g8vJmtLIHbFG/3F3REKUYxWKXB+6gaHaSm9uvZwA==
X-Received: by 2002:a05:600c:ce:b0:401:d2cb:e6f2 with SMTP id u14-20020a05600c00ce00b00401d2cbe6f2mr5107214wmm.32.1695307456325;
        Thu, 21 Sep 2023 07:44:16 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003fe2a40d287sm2125515wmc.1.2023.09.21.07.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:44:16 -0700 (PDT)
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
Subject: [PATCH v2 04/19] staging: iio: resolver: ad2s1210: fix not restoring sample gpio in channel read
Date:   Thu, 21 Sep 2023 09:43:45 -0500
Message-Id: <20230921144400.62380-5-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921144400.62380-1-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
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

In theory, this code path should not be reachable because of the
previous switch statement. But just in case we should make sure we
are restoring the SAMPLE gpio to its original state before returning
in addition to releasing the mutex lock.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 84743e31261a..0bdd5a30d45d 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -510,8 +510,8 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 		ret = IIO_VAL_INT;
 		break;
 	default:
-		mutex_unlock(&st->lock);
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
 
 error_ret:
-- 
2.34.1

