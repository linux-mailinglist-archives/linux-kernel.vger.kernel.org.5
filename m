Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1677A74C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjITHsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbjITHrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:47:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9E4CD2;
        Wed, 20 Sep 2023 00:47:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-532c66a105bso1709663a12.3;
        Wed, 20 Sep 2023 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695196040; x=1695800840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28rY4Z706VhStnnBjkizJUKVhlFQfIjXo/tl5cpkk8U=;
        b=k8zBfS/zLjI+VGpiHftUdv7w1RN83ygC7omTGL+cx13zT7kvi2MHp1kkBtpKJTvQvG
         gvcyNn1L91rFSFVzeU1vgWrVNiaDeon3IH//AGdEk9qNjLKtPe97exvhZixsr0bCANt/
         ns4rfuXcf0JKUpJ0JMpwrI5nL7LiQ1LlXGyh09HpVur5vVsS5hDd5T0eBJu2BoHb/AGq
         u+F11+fkRP5o6as9OU8WZDIaeCZsKU7ISfins1HHEt3xQwKBAEgUMy+TV3W6GUITjLiL
         j2y5xMB99OcNZescwQiB3CRC/TQfBRIOHXYJdqTdr/mBrj7m9zO+/OP06+lnWb0MMsBb
         6W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695196040; x=1695800840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28rY4Z706VhStnnBjkizJUKVhlFQfIjXo/tl5cpkk8U=;
        b=paFy/w3NTh5inTQ2OJhV4jqPqw1NCzoC3/tkEdJn/IY56ol1JK8SxfH37vH0VcNavl
         qYMk6f+0cDuefU3Bd0s3XoJjatQB3FNlvDdFuJI2JufeLH4A3apZ75yw8O9Z1iGlCamB
         I7phbUAtjNrxiqNpDWTu2QCFE6RqoctToKFo6TL/Bu1lwaHxP7UhOLGneLAb0QKHbdE4
         U1BoKIq7n0RuN20lSCY3DYUldOiySHP60mZ4xaFTVTuVXiV0ecpgP0WTnIuj7S9+umB1
         TW/L4a+AU4vGJcziMbRXvukeH0frIYtWc+KXJuB9uX61k3NoUUeVO90krN75Qm0QzCND
         IDVQ==
X-Gm-Message-State: AOJu0YzcBqonvFklYc7H2EZjZprb9AzjUsILaF4n9xqS0+FaasqMUg2G
        4/09Z+bIhQbuRQ6LR8UUxJ0=
X-Google-Smtp-Source: AGHT+IGJ43ApLqSeJRixEnKo/cgmqEMOAcdlKq+0hGznVxNqZSgit02ciMUZnX8fvnqI7zIhTCz2Vw==
X-Received: by 2002:aa7:c3c3:0:b0:532:deae:9c1f with SMTP id l3-20020aa7c3c3000000b00532deae9c1fmr1397757edr.18.1695196040241;
        Wed, 20 Sep 2023 00:47:20 -0700 (PDT)
Received: from emanuele-nb.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id p13-20020a056402074d00b005224d960e66sm8438186edy.96.2023.09.20.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:47:20 -0700 (PDT)
From:   Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Joe Hung <joe_hung@ilitek.com>
Subject: [PATCH v2 2/2] Input: ilitek_ts_i2c - add report id message validation
Date:   Wed, 20 Sep 2023 09:46:50 +0200
Message-Id: <20230920074650.922292-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920074650.922292-1-ghidoliemanuele@gmail.com>
References: <20230920074650.922292-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Ilitek touch IC driver answer to plain i2c read request, after it has
generated an interrupt request, with a report id message starting
with an identifier and a series of points.
If a request is sent unsolicited by an interrupt request the answer
do not contain this identifier.
Add a test to discard these messages, making the driver robust to
spurious interrupt requests.

Fixes: 42370681bd46 ("Input: Add support for ILITEK Lego Series")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/input/touchscreen/ilitek_ts_i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index 0c3491e346f4..efce545236cd 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -37,6 +37,8 @@
 #define ILITEK_TP_CMD_GET_MCU_VER			0x61
 #define ILITEK_TP_CMD_GET_IC_MODE			0xC0
 
+#define ILITEK_TP_I2C_REPORT_ID				0x48
+
 #define REPORT_COUNT_ADDRESS				61
 #define ILITEK_SUPPORT_MAX_POINT			40
 
@@ -163,6 +165,11 @@ static int ilitek_process_and_report_v6(struct ilitek_ts_data *ts)
 		goto err_sync_frame;
 	}
 
+	if (buf[0] != ILITEK_TP_I2C_REPORT_ID) {
+		dev_err(dev, "get touch info failed. Wrong id: 0x%02X\n", buf[0]);
+		goto err_sync_frame;
+	}
+
 	report_max_point = buf[REPORT_COUNT_ADDRESS];
 	if (report_max_point > ts->max_tp) {
 		dev_err(dev, "FW report max point:%d > panel info. max:%d\n",
-- 
2.34.1

