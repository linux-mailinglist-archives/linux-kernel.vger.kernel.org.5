Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4133805194
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376665AbjLELJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345153AbjLELJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:09:08 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1FD122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:09:13 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40859dee28cso54667505e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 03:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701774552; x=1702379352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QEX8g9ws8pSAca/CRdznAgAd77RiybUJhIDkQ8ekvP4=;
        b=jWKEf0VeXDkMSYAdZy1IKtXAT0G3ERckDws1B66P7aBJaQW8NSj5myftgwYuV4JetS
         aaObN9fFWVJnWpoHgI0pGLz2IN9gvYeSLuAfZGL7xaJNC0jwspPftZ3yDDU1WymFm4WK
         vcDYN+BMgTw0vwcxZ08d2EYBvVHrq/QDbAu6uF+OeGynKJQyHQMfWfZWO0phRg5j2vCL
         phf5EiRfwexzAqzKT+aFGulJaRMWsvMJT17+ek8xXW4tUyr6NFE2ZA+NqljowmuSgztq
         AldNhrI2a1eOGbcyOWBeOXnDQn0aY5pZprcboAzrPfTO6VsHu+3WVeck8K8yjRPsBrxO
         LTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701774552; x=1702379352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QEX8g9ws8pSAca/CRdznAgAd77RiybUJhIDkQ8ekvP4=;
        b=NXhGxLcd3AUgc5lSiWRW/sKJC49Fm9MCEkOhgWwvSCqesXruwDSHKo01XqRkygkYva
         s24akb5jmRsaH0Px9YMuXizQd5FSE0FoAxt1dH3B91UHYdJ/y5whbcAzvVbM2CY+uuOt
         +aqUgVw4gWA8hj+A9LIlV/jEO9VDJKe/3xIeUnpp+Fsw5QeCtbSzHVewXeqmNADrmdnL
         DGcE455XOae1Lf+huHvW0ldGEiFldwQKAXtVSaH3p6i/7XuvlB5yexMhrZ+cywkVb9iO
         weKkqbYmVoUzAiEGQYnTRCQXyt5CPC44h0TMH3ROA16I8etuJXHuLKZty9BZrsMQnqDx
         eGVg==
X-Gm-Message-State: AOJu0YxdR0Lb94pG9lmiCGfNlRyQvLzK0/N931bsddCJNJmu2TRkDmt6
        niWMmB0mvCKmsgcXioL87u6YGg==
X-Google-Smtp-Source: AGHT+IFsmkGKbKmqRWIAo7hIqZj481lJ2ZLH43Zbo45JEUbbEWAXMQs+nOh6tadL86/0jGr3nEynVQ==
X-Received: by 2002:a05:600c:4506:b0:40b:37ef:3671 with SMTP id t6-20020a05600c450600b0040b37ef3671mr4501417wmo.38.1701774552298;
        Tue, 05 Dec 2023 03:09:12 -0800 (PST)
Received: from brgl-build.home ([2a01:cb1d:334:ac00:2efb:ffdf:fa22:d5ee])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c4fd200b0040b45282f88sm21798166wmq.36.2023.12.05.03.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:09:11 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] Bluetooth: qca: add regulators for QCA6390
Date:   Tue,  5 Dec 2023 12:09:02 +0100
Message-Id: <20231205110903.68898-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add regulators for the QCA6390 module present on the Qualcomm RB5 board.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 35f74f209d1f..7f25931a946e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2044,7 +2044,15 @@ static const struct qca_device_data qca_soc_data_qca2066 __maybe_unused = {
 
 static const struct qca_device_data qca_soc_data_qca6390 __maybe_unused = {
 	.soc_type = QCA_QCA6390,
-	.num_vregs = 0,
+	.vregs = (struct qca_vreg []) {
+		{ "vddio", 20000 },
+		{ "vddaon", 100000 },
+		{ "vddpmu", 1250000 },
+		{ "vddrfa1", 200000 },
+		{ "vddrfa2", 400000 },
+		{ "vddrfa3", 400000 },
+	},
+	.num_vregs = 6,
 };
 
 static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
-- 
2.40.1

