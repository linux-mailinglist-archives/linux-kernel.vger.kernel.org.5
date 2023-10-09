Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9E67BE4F7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376893AbjJIPf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377712AbjJIPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:35:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3010E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:34:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3226b8de467so4462254f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696865693; x=1697470493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nb4tcSfQ92DzRQCExn+0+N39FtrJHx6Q4bK89f1YGng=;
        b=PQdn2UbM5B/lcnwkA6cLVYYn36SDm96vt7/duEnXb3THHtvBosioAqjjHpNols2vFr
         xgBjONrkYv/Sy2aNt84Q2Y/zL9ooQT0Qww1F0ZQqhsV74XiXu5QVXPy9IlekOveCYcaY
         VAW2gHmhLoECrzwdkAfRKsBDsQi5exPyz/62Yp+EDjqhgiS9unI+GG3CI+qPZM7zqmSj
         MB08BbQyvPDmBKQo2RMrxMvdh+e33yL2zATyWrRymZq1EYBw0Ysm4tnNsbvvRJvfUANp
         5q9k3VLIbMZlBpNYl9gKFN12l++B7RTVzPiUGtMhF3nm6nBf+imCvthxRdioBz3mG7cL
         hSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865693; x=1697470493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nb4tcSfQ92DzRQCExn+0+N39FtrJHx6Q4bK89f1YGng=;
        b=ZhcN1PlwQveohakFpGHprBPjsGqwyhnrg39VcYKovOwTrXX+lYiLte1EQfCPuQmOKZ
         8h63t+rPrysnMagtLtHm6ZURprMXQii3IyhqQo6Fs67RvRdSmAGEoDTDkL3kLyrFwzsR
         eP3yf77BMb0IjyKNGMfP4iBNISEEfoIT25MTwC6TKCnLC+9oinjW/kvu/7VRCCVmXh5o
         04kMU+zJ6Yy0iZPiGZ3VJJUBOurL2fxcXB7Qp6Ubgfib0xV4c9tplP80aOYejnrFgQ2Y
         e13joYaqiUCzpa7Xkp/FyVnUXUeb6NMirXgEcqe3zM+rGjdhxgjsietnQbAaoSKHZM6k
         61Dw==
X-Gm-Message-State: AOJu0Yw7y+MMnYwRmCiUvMT9tWqhHRVP411/E8QnR6VU7lo68hbGNAYs
        mqvT+A1B+SpSz68o/iRKbmmoBQ==
X-Google-Smtp-Source: AGHT+IF/ATwNhgOWfbF6ffkoc4v5R/7+WBbSX0OpK95f8UD7VXSz1nm9Y6NL0KGaM1loMPbeBPKrCQ==
X-Received: by 2002:a05:6000:1815:b0:317:e1fb:d56a with SMTP id m21-20020a056000181500b00317e1fbd56amr13467982wrh.40.1696865692794;
        Mon, 09 Oct 2023 08:34:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f20d:2959:7545:e99f])
        by smtp.gmail.com with ESMTPSA id b3-20020adff243000000b0031431fb40fasm10016521wrp.89.2023.10.09.08.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:34:52 -0700 (PDT)
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
Subject: [PATCH v3 10/15] firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ allocator
Date:   Mon,  9 Oct 2023 17:34:22 +0200
Message-Id: <20231009153427.20951-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009153427.20951-1-brgl@bgdev.pl>
References: <20231009153427.20951-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of manually kmalloc()ing it and then mapping to physical space.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 11638daa2fe5..3a6cefb4eb2e 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1525,37 +1525,27 @@ int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
 	unsigned long app_name_len = strlen(app_name);
 	struct qcom_scm_desc desc = {};
 	struct qcom_scm_qseecom_resp res = {};
-	dma_addr_t name_buf_phys;
-	char *name_buf;
 	int status;
 
 	if (app_name_len >= name_buf_size)
 		return -EINVAL;
 
-	name_buf = kzalloc(name_buf_size, GFP_KERNEL);
+	char *name_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							     name_buf_size,
+							     GFP_KERNEL);
 	if (!name_buf)
 		return -ENOMEM;
 
 	memcpy(name_buf, app_name, app_name_len);
 
-	name_buf_phys = dma_map_single(__scm->dev, name_buf, name_buf_size, DMA_TO_DEVICE);
-	status = dma_mapping_error(__scm->dev, name_buf_phys);
-	if (status) {
-		kfree(name_buf);
-		dev_err(__scm->dev, "qseecom: failed to map dma address\n");
-		return status;
-	}
-
 	desc.owner = QSEECOM_TZ_OWNER_QSEE_OS;
 	desc.svc = QSEECOM_TZ_SVC_APP_MGR;
 	desc.cmd = QSEECOM_TZ_CMD_APP_LOOKUP;
 	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL);
-	desc.args[0] = name_buf_phys;
+	desc.args[0] = qcom_tzmem_to_phys(name_buf);
 	desc.args[1] = app_name_len;
 
 	status = qcom_scm_qseecom_call(&desc, &res);
-	dma_unmap_single(__scm->dev, name_buf_phys, name_buf_size, DMA_TO_DEVICE);
-	kfree(name_buf);
 
 	if (status)
 		return status;
-- 
2.39.2

