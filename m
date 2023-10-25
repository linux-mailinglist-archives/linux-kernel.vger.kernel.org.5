Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272487D6A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 13:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjJYLf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 07:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjJYLfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 07:35:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C8712A;
        Wed, 25 Oct 2023 04:35:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9de3f66e5so36911085ad.3;
        Wed, 25 Oct 2023 04:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698233752; x=1698838552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a++jEb3D87KmIQVIPb5nI/hnUzxvz4mflhHrfKFfvvA=;
        b=DU0IBzArM72vC5FH9oJalL4B63Wnh1Bnsqp7sUZsBT0lFI6/f8V+mMkRzuwxHWvG/n
         /a7k7SAPNRwBsTJQMkrrr/wUz9mvKyp9NcQNrBlDLkuiXkHtcLpYBmOAeD2VtMuwmQsA
         XBPfboEicThS6t1ZtVBWk4P7asUXccteq4sD+XiGSgLEL36MpkotCE7P7/eE58afCI0q
         fRyoXdpEtqB52UZz6mtrH5+83v0vzxAsGynw+uPYzQBLpbXYfWjgna0+aajQMNwu0Tv2
         wzmzGmiNFfwxnFr0x0SMx+430gSh94wj14whkSqAfjbs5av7SDh6D8FaicrZVvAJJ2SJ
         M58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698233752; x=1698838552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a++jEb3D87KmIQVIPb5nI/hnUzxvz4mflhHrfKFfvvA=;
        b=dMSwaeJqUhkx4jGEHtT2w3vXY2tszf38qZfS6G/pOMf4e6l0X27ntn40DLp5fsmbKm
         0UpkGRMBZ2gJX0J+yIi5tG/W1IlLObjvgm7/qUOzeqoXcR5Wfw26NvoHu44xYtEk+fXf
         QLUXbtagIv7JZNz5rm9K158EPVOKjCAioXo8s/DOALEq9hxmR39Jo0wHLxFwIXuilsiI
         NDBDHPfm+O/gpCuiU1cosu/5gloUpyJprW2HsPiGspR8gxuQudq7HHqabNBOGm5gNzgU
         EZkifWJRBuB/l0ABOos3BxsfcBP4xj63GHvUgLghogoR/F6R6qEv0vf2J1FoUD/rPZnz
         OhDA==
X-Gm-Message-State: AOJu0YzZbfuzSSWt75Ay6Ch0wer0OM9V3Unhzrtzm0nCGgjN1A6VMZwV
        i5stsA2z534p4mFPS5egDzw=
X-Google-Smtp-Source: AGHT+IHhGFq+Wxn6FN50Mp/tBx1KgeJMrdqv0Fm34gYV50HNOpBDWkBMD4DBiUig/9uiDjtzXt14MQ==
X-Received: by 2002:a17:903:32c8:b0:1ca:8a38:38c4 with SMTP id i8-20020a17090332c800b001ca8a3838c4mr16041249plr.27.1698233752265;
        Wed, 25 Oct 2023 04:35:52 -0700 (PDT)
Received: from brag-vm.. ([117.243.111.63])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902748100b001c9bc811d59sm9001520pll.307.2023.10.25.04.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:35:51 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     jmaneyrol@invensense.com, jic23@kernel.org, lars@metafoo.de
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio/imu: inv_icm42600: Use max() helper macros
Date:   Wed, 25 Oct 2023 17:05:44 +0530
Message-Id: <20231025113544.4954-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard max() helper macros instead of direct
variable comparison using if/else blocks or ternary
operator. Change identified using minmax.cocci
Coccinelle semantic patch.

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index b1e4fde27d25..f67bd5a39beb 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -137,10 +137,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 out_unlock:
 	mutex_unlock(&st->lock);
 	/* sleep maximum required time */
-	if (sleep_accel > sleep_temp)
-		sleep = sleep_accel;
-	else
-		sleep = sleep_temp;
+	sleep = max(sleep_accel, sleep_temp);
 	if (sleep)
 		msleep(sleep);
 	return ret;
-- 
2.34.1

