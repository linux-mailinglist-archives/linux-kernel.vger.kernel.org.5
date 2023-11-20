Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AC27F1D19
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjKTTHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjKTTHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:07:51 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A56ED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:07:46 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9e1021dbd28so646756966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700507265; x=1701112065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcghsarjrS3tHRySGsk8wGm4K++pTmTjyafJFK3g/Cs=;
        b=f35kR+nNnKF+FPTdCG1sKB/Lf7bbiCp5lEm6ewPm3RLyGjyTvsg0JpHxOH/1WK8+u8
         /USDkwM1FmL7bNOtE44bi4vKmV3cyXml23u+dyVLZ9L8qPZJMDqwnCxIFS6eiPlMazZJ
         GHVYPhk+frGXbYTlJBBE7RGdLCWudqojLL8KpcadfKBHbKwftIl4sF+jyhEOJ3NkwURU
         DxzDG10X0cPY7g/xXxdyD1KrKRJCXvhEjkI2/7O4ew5DTs4x7QCHp7jwxuhuur4YgON9
         OmRcC/GKWatrR/CxtHwrQ6mpBH1NFEKaGGfrNCrubzpzQdfG04lCpCM+/Zn/HT5WJwMp
         veiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507265; x=1701112065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcghsarjrS3tHRySGsk8wGm4K++pTmTjyafJFK3g/Cs=;
        b=RwSR33Wk/B8aO8TRL89JqOTWiUo213h+h5A3Z5cGZwCIYjlP/Qx0bhvatxClNq1ppp
         Vn3vMnUaw/FmHdOiIiJnQGDr+RLQ2x5J5lLp+OHGxO8Aiv7N2u97WCDgXaOGqPBNyMMd
         lBZZb9s7Sa8VqhHbfJASwjLtS5ALz1XvY0ueWpK4atdim/FyhRaRe0WFvMMlse7ikWSB
         GKfCvL1+pAe16V537dUsatO0b1yXw+dMABcmIsUfrl5BxpTs5TJ22Bva8miLHGzdEzM+
         sQld2mqp2+nILnY6Rmeoz0c0YF1uIk9RycMEg10ZckRhXRUV9V7GEhgUi4dz39ntO49W
         4B5g==
X-Gm-Message-State: AOJu0Yybwc81P7od6DgxkNjuNc95pUoNElHpQEQuJjgouGNwygDKS/Tr
        OVRT56HUWU3d9Tqe3/pVzyZ1cw==
X-Google-Smtp-Source: AGHT+IFzePfbHnSU85wD/UiMsfBrFBH+dK0SBJM1TR0leyATrt8D374mvtWaZJyFxdwoOqbJ+3B6KA==
X-Received: by 2002:a17:906:3f18:b0:9fe:aacb:bf6a with SMTP id c24-20020a1709063f1800b009feaacbbf6amr2737368ejj.69.1700507264786;
        Mon, 20 Nov 2023 11:07:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709066d5200b00977cad140a8sm4177521ejt.218.2023.11.20.11.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:07:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] soundwire: qcom: move sconfig in qcom_swrm_stream_alloc_ports() out of critical section
Date:   Mon, 20 Nov 2023 20:07:40 +0100
Message-Id: <20231120190740.339350-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120190740.339350-1-krzysztof.kozlowski@linaro.org>
References: <20231120190740.339350-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting members of local variable "sconfig" in
qcom_swrm_stream_alloc_ports() does not depend on any earlier code in
this function, so can be moved up before the critical section.  This
makes the code a bit easier to follow because critical section is
smaller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/qcom.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 754870a4a047..e9a52c1bd359 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1160,6 +1160,17 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 	int maxport, pn, nports = 0, ret = 0;
 	unsigned int m_port;
 
+	if (direction == SNDRV_PCM_STREAM_CAPTURE)
+		sconfig.direction = SDW_DATA_DIR_TX;
+	else
+		sconfig.direction = SDW_DATA_DIR_RX;
+
+	/* hw parameters wil be ignored as we only support PDM */
+	sconfig.ch_count = 1;
+	sconfig.frame_rate = params_rate(params);
+	sconfig.type = stream->type;
+	sconfig.bps = 1;
+
 	mutex_lock(&ctrl->port_lock);
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
 		if (m_rt->direction == SDW_DATA_DIR_RX) {
@@ -1193,16 +1204,6 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 		}
 	}
 
-	if (direction == SNDRV_PCM_STREAM_CAPTURE)
-		sconfig.direction = SDW_DATA_DIR_TX;
-	else
-		sconfig.direction = SDW_DATA_DIR_RX;
-
-	/* hw parameters wil be ignored as we only support PDM */
-	sconfig.ch_count = 1;
-	sconfig.frame_rate = params_rate(params);
-	sconfig.type = stream->type;
-	sconfig.bps = 1;
 	sdw_stream_add_master(&ctrl->bus, &sconfig, pconfig,
 			      nports, stream);
 out:
-- 
2.34.1

