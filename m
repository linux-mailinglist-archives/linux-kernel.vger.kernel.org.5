Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F637D940D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjJ0JoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbjJ0JoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:44:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F09194;
        Fri, 27 Oct 2023 02:44:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c8a1541232so16754015ad.0;
        Fri, 27 Oct 2023 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698399858; x=1699004658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWwVrucFsHEkQegjlatE8u/QhZ9p9ihyQMPhyc6PM/4=;
        b=UZhyLzzMV3NW4qjVB/a0AOwDSFKdy55Kv+c2At8jqassJwbHE5TPnVh+1rQXvyABaD
         xjg8IvT6++HW9GE6XLyJkujURsAhDhJ+84a7Rx2+b9/gz1izSa2cJgTGbiC6jH4u9NGI
         iUG2Qz+Jx5gy8HMApFLQLMMlZie4+F9XTxCiB9fStcpMmPvt+jAhxM/VQcg/JsEYLANf
         QGsGEKzhL7u2DZ7hUuiYbL5WESUu+avxu5Ilw1MCpgmt+7Pgo8e3sy5hx1aHZGEhbgvk
         BHWJZ9THUTciu7xKrfGZMYWt52ITq1QZyD+6QAQsmEt5amCw97OUywSdG5XzJVx/hxU+
         PMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399858; x=1699004658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWwVrucFsHEkQegjlatE8u/QhZ9p9ihyQMPhyc6PM/4=;
        b=RiAIGlX3+5P2J7tY5fOU458DbjwQgYDKrEOweIcHBM6J6jh86cdLAsNXcH532kqNWR
         Ed/qBdP22EsdEPburFVj9KG/YTPia5UCZl9hCUg7W+yOV5j6ve3my7sLxPL30lviUwfy
         JpML+xqe34t/EkD6EONc+lUCk/cfIPLBs8xER/qGnPVgoBAw9b/mI1ssGTpXCstL0+8B
         U/AybS9kckgD630hPB8nqJnIVejVijHhg4bFrrF9dVgnslzikHDysRXLRjAJiMc7y/eq
         QvdV6hYMW08dHIA+UZmCfDb6mqiMiXAmLYYQKMjzT24zGQ9SL92CLh9b6fGATCbxWG1w
         d5Xg==
X-Gm-Message-State: AOJu0YxIR7WIeb32wbeG1dc1iC1cWgfUAGAGB4rEJe+8t2DUO6AyIq4k
        k9Yg70GMcuqvD6Hs0BRLHs8=
X-Google-Smtp-Source: AGHT+IEzR6hJVyMTznto7NRTUlwv1z4eY2vXeqTSsgzgy5LNB6LpBoZwlW/zzRT6wuUGY+/LClktDg==
X-Received: by 2002:a17:902:ed13:b0:1c6:294c:f89c with SMTP id b19-20020a170902ed1300b001c6294cf89cmr1984834pld.63.1698399857735;
        Fri, 27 Oct 2023 02:44:17 -0700 (PDT)
Received: from brag-vm.. ([2409:40f4:13:48d5:c971:7c89:5be7:c8a2])
        by smtp.gmail.com with ESMTPSA id jb9-20020a170903258900b001c9db5e2929sm1130591plb.93.2023.10.27.02.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:44:17 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     jmaneyrol@invensense.com, jic23@kernel.org, lars@metafoo.de
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio/imu: inv_icm42600: Use max() helper macros
Date:   Fri, 27 Oct 2023 15:14:10 +0530
Message-Id: <20231027094410.3706-1-bragathemanick0908@gmail.com>
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
V1 -> V2: Adding similar changes to inv_icm42600_gyro & inv_icm42600_buffer

 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  | 5 +----
 drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 5 +----
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   | 5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

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
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index 6ef1df9d60b7..b52f328fd26c 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -424,10 +424,7 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 	mutex_unlock(&st->lock);
 
 	/* sleep maximum required time */
-	if (sleep_sensor > sleep_temp)
-		sleep = sleep_sensor;
-	else
-		sleep = sleep_temp;
+	sleep = max(sleep_sensor, sleep_temp);
 	if (sleep)
 		msleep(sleep);
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 3bf946e56e1d..3df0a715e885 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -137,10 +137,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 out_unlock:
 	mutex_unlock(&st->lock);
 	/* sleep maximum required time */
-	if (sleep_gyro > sleep_temp)
-		sleep = sleep_gyro;
-	else
-		sleep = sleep_temp;
+	sleep = max(sleep_gyro, sleep_temp);
 	if (sleep)
 		msleep(sleep);
 	return ret;
-- 
2.34.1

