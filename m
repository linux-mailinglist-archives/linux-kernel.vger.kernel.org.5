Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808677A9E79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjIUUBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjIUUBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:01:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDB057B08
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:18:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-503f39d3236so2125504e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316726; x=1695921526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9YCZ78k5Zg5KKitr5PpHsZw/Rz0qYyLXQR2L135bIs=;
        b=p725f+u/GCXMgTcmvd17mKS+XZWOteY2gYOCuBCh3vzHoy4MPBVGu8WPx52QLOOrxJ
         /YD14zD1WxUTKzA2AjDjFfdV9UNlqtY9DrGghfgJ5F2KSjb/xJmhhQNS2EApCbOFz/GA
         LTrqISiUfpoTveqcCnArZJWaHZhqo/E0InpkUaDXWv2GcZBnfSkYbz/dlD9+7YyFguFR
         gI2LWTPZBBXU/H35iS4XTC0FaShVnZGoC5soqgO4C2AyqcRaD5J799xNJXZRDUc8QbuW
         ++AcZviGCZZARa6wMF5gGVps2bi3DFxPpMw4pDVhEYPCbx5a3GxhCsbXWW6lJM37f5/m
         oTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316726; x=1695921526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9YCZ78k5Zg5KKitr5PpHsZw/Rz0qYyLXQR2L135bIs=;
        b=i6mLRe7MfYJ1Wcfl7IKifNASPdE+i9SybKXCY4Hs2hsQb5wwJ7rCahgMAakC9dHwsc
         glWkaKEFQodtq7r4tDsi1pLXMzinfBqZgjJAVkvX3WLL0X9i/RWrlarwESARqFd4QQ23
         SfGzmjg8IdvuolRx2f4hHcQo/kNwb2ERuPrkF7n5nE2SNRzgzbji9TUIWo61QzvaDftA
         hfrrslY+cwQg/AZYRMY5VudEHkGCfqp3TjMA4/0EK3SCOKUxUkiIeDGHxqJUAaHGAbQ+
         NwAkYNb7uTKf2M7J9Ty5G72zVE2hwGy9Se+FRgySW8VoDVWRR7Wdj0AHVRLrJnxP7nxG
         c35w==
X-Gm-Message-State: AOJu0YwcPqN9AQYkIZ/nV5GioALAxL+4fbZ50LKl9EcHoXxQn9PvLI3b
        FO5JE70pwEHAsIrDLvA2rDPIkIoMYbA2RepfcbO96NQl
X-Google-Smtp-Source: AGHT+IFLOeeKjkZXzmrmyjj61SlCO4QtLumxRWkUp/uZ0wPGaqOzHFNXTE+bvD2TXSjNSCu16d/fHw==
X-Received: by 2002:adf:fe8e:0:b0:319:f9d6:a769 with SMTP id l14-20020adffe8e000000b00319f9d6a769mr5207822wrr.45.1695306155398;
        Thu, 21 Sep 2023 07:22:35 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:35 -0700 (PDT)
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
Subject: [v2 04/19] staging: iio: resolver: ad2s1210: fix not restoring sample gpio in channel read
Date:   Thu, 21 Sep 2023 09:19:32 -0500
Message-Id: <20230921141947.57784-7-dlechner@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921141947.57784-1-dlechner@baylibre.com>
References: <20230921141947.57784-1-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
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

