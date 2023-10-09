Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E26B7BE4ED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377673AbjJIPfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377672AbjJIPfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:35:04 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D35100
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:34:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3231df68584so4355849f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696865691; x=1697470491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbTZKQqdpJrILRniIPDrMxLXgf0p/DyB9D6pPMY/qic=;
        b=KJ3dKPSYGlF5YXQvSCsKFnLtazljwjTv4z3Im9+iMKPq4tMMALPgm+N03DzJan/xLI
         ARUXXAynf2XM1E04MGNYUPEMoZoksuEhholJZFK/OPv4g09wOVIAkzZOkybSOyZlMbKg
         Y/jQ0cDGvIiykedS4H7iG0Z/0KjW1tSH4JbgPjkGKplULmQ2c7DRkNqxCPfbPbAL2Esm
         WxIUZn5dEMrtA7H3snvyUIvaLbwmjK6Ub7/sWljlP3zbFbmHA6phESKaowpMzHUSl7oz
         3wwbYFvaeJlA32SIKH/RqieGBNgLxydzkgAAp6FTmq/U1i8/1icF9AWmWHjvBUJzWUYv
         CE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865691; x=1697470491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbTZKQqdpJrILRniIPDrMxLXgf0p/DyB9D6pPMY/qic=;
        b=KSmZjbT1i5f9/hKnNP/EXbjlB+GziTVxvxRBqEWEWHohhrGlC6BaEMJpBpcIqz0+s0
         CAjaX1jv0pGPrHvFMnK1CsisYwS2hm6Pc0y/cAObykZvBegDnrBs9IB0RpVba7V+nZGB
         5KpCKTShirhg2D5hJaEIvPY5q1ssscyzVtwOxqttJmAtB/ds590GCQjX3ZMFvRmT0mBp
         SwelHapCJWFBHxbtDoLyZX+A82pcu6JRxqPZbjRMOWcd9DpmpXV9VqD9KfoEka+I2J+J
         LSB6w80n3xOxkNu7BRQesdAHlL+VLv9LAhxEztw7RbpOwqpG5zzP88fMxVsPpo/OSikz
         lwWQ==
X-Gm-Message-State: AOJu0YywASLwTGeLEegecQ+8r7cJgLHbRZPpbhC9e2wgqJlCw8D4uVF7
        DV1QdWvLvNJj5mYXAYEQkfifOQ==
X-Google-Smtp-Source: AGHT+IGQF2q6zQswu+XOUXPGnGNpbRCfcHwX//5E5r9lPC5kW2bwvkYXF5J2WzPCCp+4tjNW7qT8Jw==
X-Received: by 2002:a5d:54cf:0:b0:31f:9838:dfc4 with SMTP id x15-20020a5d54cf000000b0031f9838dfc4mr13054433wrv.33.1696865690821;
        Mon, 09 Oct 2023 08:34:50 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f20d:2959:7545:e99f])
        by smtp.gmail.com with ESMTPSA id b3-20020adff243000000b0031431fb40fasm10016521wrp.89.2023.10.09.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:34:50 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 09/15] firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
Date:   Mon,  9 Oct 2023 17:34:21 +0200
Message-Id: <20231009153427.20951-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009153427.20951-1-brgl@bgdev.pl>
References: <20231009153427.20951-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of using dma_alloc_coherent().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 31071a714cf1..11638daa2fe5 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1340,8 +1340,6 @@ EXPORT_SYMBOL_GPL(qcom_scm_lmh_profile_change);
 int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		       u64 limit_node, u32 node_id, u64 version)
 {
-	dma_addr_t payload_phys;
-	u32 *payload_buf;
 	int ret, payload_size = 5 * sizeof(u32);
 
 	struct qcom_scm_desc desc = {
@@ -1356,7 +1354,9 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 		.owner = ARM_SMCCC_OWNER_SIP,
 	};
 
-	payload_buf = dma_alloc_coherent(__scm->dev, payload_size, &payload_phys, GFP_KERNEL);
+	u32 *payload_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							       payload_size,
+							       GFP_KERNEL);
 	if (!payload_buf)
 		return -ENOMEM;
 
@@ -1366,11 +1366,10 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
 	payload_buf[3] = 1;
 	payload_buf[4] = payload_val;
 
-	desc.args[0] = payload_phys;
+	desc.args[0] = qcom_tzmem_to_phys(payload_buf);
 
 	ret = qcom_scm_call(__scm->dev, &desc, NULL);
 
-	dma_free_coherent(__scm->dev, payload_size, payload_buf, payload_phys);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh);
-- 
2.39.2

