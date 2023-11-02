Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3C7DFB8F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjKBUbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjKBUbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:31:06 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69FF181
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:31:01 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-778925998cbso79298585a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698957060; x=1699561860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gaCHdvbA7W42TY/eQsjS/Lhc+W/VnCugrlrNsZjT78A=;
        b=AdSl+2M6tSCRPHS7/6YzOLh6JtVadUDc03EuQaAx/u9cRXu/jk0+quxX4GIZNOy+Fo
         Fcn7Faloh8DOYkIHzhZ0SDk6tOKdcAsYinSgesjIqNJz4wgv24J/sZzogOYOLjtwHBKN
         h2GDHW/sLRk+s2puHE6OuWNF7kkFAqVWDFmlIQYCbQmZ0ljYnDdFF9hKoASdQ8eWvJWa
         7TiIWazfFZqjEn6lvqyUB3TNqkQ4//OlW1fdrir/tUBnkfMJYCNNd5Fs+ueJAGctH1xN
         LKAGQexCh9z0DKLFocQiMDwOuQq3LqtZuSuXQeQW8xIAvh+Xawvv0kRe//6Ug0Oc83Zj
         acvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698957060; x=1699561860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaCHdvbA7W42TY/eQsjS/Lhc+W/VnCugrlrNsZjT78A=;
        b=EQGb1zMAg3MaHYaoKTgLHPhse0mMD5W+mMibO7GGXlrz+w3fCSjzpR63Jb2Sk70ClK
         WOSzkO8WOHarWkcV39kJMIaeOgc28xg/+Ogdo4PLoADUy8yWwSnRGk11AA+xdEyAinqd
         8OwXSm1rIiqtdEV76HnF+h5fD4T8BLtmsmHb6i8LlEMyN9s/CJXXrUyzp538532pI2XJ
         td6FhRmnlRJ0aKfKhy+zvdBcla8dWYu8YYPMr1TpwFU+5gzihkut8sTP+0iV/svFZuz5
         Ot/E29M5S9hnxIByaCZtmqmwSfw3yRzaj1O+kLh536HVyl+TigJwCk4bzEX5vTw+HzZN
         ev0A==
X-Gm-Message-State: AOJu0Yw37AUdowSgIzOPjH9X5DL59d117xHeTuIJ07eDEktWrcNcBOmp
        NMoaJI/stpXWjxi51MQQXSAVt555ns8XkoEe6GA=
X-Google-Smtp-Source: AGHT+IExNewXrVT/rKvejupjOyIg47K+wiXbEyV1vnElDnuIGiUjLabsjgDa/iAr6RST35WSBWddmw==
X-Received: by 2002:a05:620a:472a:b0:767:923:48e7 with SMTP id bs42-20020a05620a472a00b00767092348e7mr23720188qkb.5.1698957060317;
        Thu, 02 Nov 2023 13:31:00 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id m17-20020a05620a24d100b00774292e636dsm92164qkn.63.2023.11.02.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 13:30:59 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 1/2] regmap: ram: support noinc semantics
Date:   Thu,  2 Nov 2023 16:30:38 -0400
Message-ID: <20231102203039.3069305-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support noinc semantics in RAM backed regmaps, for testing purposes. Add
a new callback that selects registers which should have noinc behavior.
Bulk writes to a noinc register will cause the last value in the buffer
to be assigned to the register, while bulk reads will copy the same
value repeatedly into the buffer.

This patch only adds support to regmap-raw-ram, since regmap-ram does
not support bulk operations.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 drivers/base/regmap/internal.h       |  1 +
 drivers/base/regmap/regmap-raw-ram.c | 27 +++++++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 9a9ea514c2d8..583dd5d7d46b 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -318,6 +318,7 @@ struct regmap_ram_data {
 	bool *read;
 	bool *written;
 	enum regmap_endian reg_endian;
+	bool (*noinc_reg)(struct regmap_ram_data *data, unsigned int reg);
 };
 
 /*
diff --git a/drivers/base/regmap/regmap-raw-ram.c b/drivers/base/regmap/regmap-raw-ram.c
index c9b800885f3b..463adafa9532 100644
--- a/drivers/base/regmap/regmap-raw-ram.c
+++ b/drivers/base/regmap/regmap-raw-ram.c
@@ -41,10 +41,15 @@ static int regmap_raw_ram_gather_write(void *context,
 		return -EINVAL;
 
 	r = decode_reg(data->reg_endian, reg);
-	memcpy(&our_buf[r], val, val_len);
-
-	for (i = 0; i < val_len / 2; i++)
-		data->written[r + i] = true;
+	if (data->noinc_reg && data->noinc_reg(data, r)) {
+		memcpy(&our_buf[r], val + val_len - 2, 2);
+		data->written[r] = true;
+	} else {
+		memcpy(&our_buf[r], val, val_len);
+
+		for (i = 0; i < val_len / 2; i++)
+			data->written[r + i] = true;
+	}
 	
 	return 0;
 }
@@ -70,10 +75,16 @@ static int regmap_raw_ram_read(void *context,
 		return -EINVAL;
 
 	r = decode_reg(data->reg_endian, reg);
-	memcpy(val, &our_buf[r], val_len);
-
-	for (i = 0; i < val_len / 2; i++)
-		data->read[r + i] = true;
+	if (data->noinc_reg && data->noinc_reg(data, r)) {
+		for (i = 0; i < val_len; i += 2)
+			memcpy(val + i, &our_buf[r], 2);
+		data->read[r] = true;
+	} else {
+		memcpy(val, &our_buf[r], val_len);
+
+		for (i = 0; i < val_len / 2; i++)
+			data->read[r + i] = true;
+	}
 
 	return 0;
 }
-- 
2.42.0

