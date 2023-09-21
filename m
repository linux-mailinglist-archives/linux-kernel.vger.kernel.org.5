Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4647A98AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjIURvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjIURvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:51:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB991BF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:22:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-501eec0a373so2194305e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316932; x=1695921732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gabiCx8aQ+iMVEJft2DL0LHbd3RWq71VIbUUi+w3JfM=;
        b=Gj1N929OQhSew4rZWjj1I9EtfgztYKeM9fj6JuUS07OyUy9qA1gjz3i35SI5Czt1MN
         Y8Ri5S+zC+BTTYP6zdrVJTkxW+Yh5QM9FkyCOK29dAhm9LE3YdkcSWjHdgdvqP4t3gXF
         jQlOx6CQZImywvD5iOm1mfe73sf+/ejCHlBwPBket5W+9JW7rUqBeAloA2vTg9MzCZIm
         SwS4HvbXwPF1X+TkWh4J9wvrlgc9MOB4YquWu4Nx7iVcw5p4jb5ngw9COMMEURCMdwK7
         biZX5to2UTYSBOVASai28EfL0Sv9Y3mqkUlx6hIej4oaYx//bx2RQ7q//O3Ikcb1UMld
         mp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316932; x=1695921732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gabiCx8aQ+iMVEJft2DL0LHbd3RWq71VIbUUi+w3JfM=;
        b=nG9L4K9XUiUlukpbtajj9nBkKkSRQF9AAJvhujkdk9sW6r28f7HhDeJvBHfKvQXKpV
         bi4mogdt9daNNH7N1WXUbPEvTljz5/V3funt6GMsL3ie00JHcNqhWihWlvJMCJIdlg8g
         tVDSm6H1maKzcC6ZFUzy9JSKPsnR73vXETa2DeKUfUkQZ61lvKj2LE05c7Yq5u4sK2O5
         uZ3a0MbC3FKL8EWwcokejQZoKJXYaned8Kvgg+MReWkpq5e8hfILYlIS+f8mPopf93cB
         15Lclj9ezNQuchPgXHSbABkopmWWLS4RPaXP4gmhWAh4M0a3DIyhUcVA3NiFXYnlhLZZ
         GHzA==
X-Gm-Message-State: AOJu0YyIZd5eF9VjBOHzvXydczZ6kiHK5E178HCo3wddxWBv2gtqJKGw
        J7vdS8MtgJ+mvUNfgTrCKmMeIVqYgpxX3prmpI6A4NQL
X-Google-Smtp-Source: AGHT+IE4sDvMSw/UkfMczfXLxgbpckMACuzljnUTY5SM6KE9BEVvGBveVsOv+3vfUogJ5wktpvrmbA==
X-Received: by 2002:a5d:6e54:0:b0:31a:e8e6:8a96 with SMTP id j20-20020a5d6e54000000b0031ae8e68a96mr5153996wrz.67.1695306157156;
        Thu, 21 Sep 2023 07:22:37 -0700 (PDT)
Received: from localhost.localdomain (abordeaux-655-1-129-86.w90-5.abo.wanadoo.fr. [90.5.10.86])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm1901426wrt.22.2023.09.21.07.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:22:36 -0700 (PDT)
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
Subject: [v2 06/19] staging: iio: resolver: ad2s1210: always use 16-bit value for raw read
Date:   Thu, 21 Sep 2023 09:19:34 -0500
Message-Id: <20230921141947.57784-9-dlechner@baylibre.com>
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

This removes the special handling for resolutions lower than 16 bits.
This will allow us to use a fixed scale independent of the resolution.

Also, for the record, according to the datasheet, the logic for the
special handling based on hysteresis that was removed was incorrect.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/staging/iio/resolver/ad2s1210.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 9c7f76114360..985b8fecd65a 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -465,10 +465,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 			     long m)
 {
 	struct ad2s1210_state *st = iio_priv(indio_dev);
-	u16 negative;
 	int ret = 0;
-	u16 pos;
-	s16 vel;
 
 	mutex_lock(&st->lock);
 	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
@@ -494,20 +491,11 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 
 	switch (chan->type) {
 	case IIO_ANGL:
-		pos = be16_to_cpup((__be16 *)st->rx);
-		if (st->hysteresis)
-			pos >>= 16 - st->resolution;
-		*val = pos;
+		*val = be16_to_cpup((__be16 *)st->rx);
 		ret = IIO_VAL_INT;
 		break;
 	case IIO_ANGL_VEL:
-		vel = be16_to_cpup((__be16 *)st->rx);
-		vel >>= 16 - st->resolution;
-		if (vel & 0x8000) {
-			negative = (0xffff >> st->resolution) << st->resolution;
-			vel |= negative;
-		}
-		*val = vel;
+		*val = (s16)be16_to_cpup((__be16 *)st->rx);
 		ret = IIO_VAL_INT;
 		break;
 	default:
-- 
2.34.1

