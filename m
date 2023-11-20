Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF3D7F1D17
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjKTTHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjKTTHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:07:51 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E62110F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:07:45 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991c786369cso655295666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 11:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700507263; x=1701112063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTpXl/MjWFr4GOxbA7yucE3ugQ9dkFJq52yIdGzpXCM=;
        b=itYyRfKlJ0k+Z5DM/8/r+qJotBFH0gQ4rizZjMjKZ04IyE5HryhW9ctYufd9bNwR3/
         QoxuuPxSsfEpHY1O2Yr+4VA9+HiVNKVVGZU+U3jqtCnF2U75+w2bQjZm9+M9tz+xEh1G
         rwd2to9rK00jQyKGR/vNxEEf/WLu4ZIh3C0TSUBgETriwa9zIXTb46Aa2qGXmTq4jaQ4
         fu6bzoOkEjb2UFLRBz/yZKiGQxORgG8JLBIiVURE1b9IVo30gS9wgaZ00sp+wUYb4ZZt
         Q2UmcP9rONk/T0mh8KDlR2DQCpenddeXS3Kb0nyOtXeBM7X3ZOuQbUuvXVC3kRKRWGRe
         BI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700507263; x=1701112063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTpXl/MjWFr4GOxbA7yucE3ugQ9dkFJq52yIdGzpXCM=;
        b=uEITbcRhymA+TauYmot1go4+3zlicNpOkbd/t0mzt+nL2w8omrqKPPEMv5IQ9T3h51
         IKoIR8ZZz5g2/JZoO/fw4xR7RQVkxRaJmRLuiBlDOJvhT29YUvRiZoeOBK28jTyv0qUU
         khPaVPhsVG6wiYDs3GNl78TNnSSm76eSsMEscmCLImhgiC5eGgrOBcXShn5Imskl/g6h
         XXpBiqFzKBJYaFwiZWqa2SrvaXgbOp+Yd0c9IpSCxYLmH0ZAT0yYENbzeHbbEx7Xf0Lf
         ajkYelHVl4NePoSqo+29kqSQdV4ypJ7Df7W0b3l/SWR+MFpyk+5ds3bbHBo0832xOs6F
         Kx9g==
X-Gm-Message-State: AOJu0YyWsPp8jkeozM3w1SDeCgbw40cRQOOaaS/bi25b8nmoKxNf/XdL
        EeGzh8BBsIRDaRMimBCjakU6xw==
X-Google-Smtp-Source: AGHT+IHCotI7oUSuFgXAQc4G4brytJuxRZwajqwIVB16jasq+WxHZRt/dsvF1AgDGC0xrVfamLAQ5A==
X-Received: by 2002:a17:906:c244:b0:9db:e46c:569 with SMTP id bl4-20020a170906c24400b009dbe46c0569mr6001995ejb.45.1700507263410;
        Mon, 20 Nov 2023 11:07:43 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709066d5200b00977cad140a8sm4177521ejt.218.2023.11.20.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:07:43 -0800 (PST)
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
Subject: [PATCH 1/2] soundwire: qcom: drop unneeded qcom_swrm_stream_alloc_ports() cleanup
Date:   Mon, 20 Nov 2023 20:07:39 +0100
Message-Id: <20231120190740.339350-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cleanup in "err" goto label clears bits from pconfig array which is
a local variable.  This does not have any effect outside of this
function, so drop this useless code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/qcom.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index a1e2d6c98186..754870a4a047 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1157,7 +1157,7 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 	struct sdw_port_runtime *p_rt;
 	struct sdw_slave *slave;
 	unsigned long *port_mask;
-	int i, maxport, pn, nports = 0, ret = 0;
+	int maxport, pn, nports = 0, ret = 0;
 	unsigned int m_port;
 
 	mutex_lock(&ctrl->port_lock);
@@ -1183,7 +1183,7 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 				if (pn > maxport) {
 					dev_err(ctrl->dev, "All ports busy\n");
 					ret = -EBUSY;
-					goto err;
+					goto out;
 				}
 				set_bit(pn, port_mask);
 				pconfig[nports].num = pn;
@@ -1205,12 +1205,7 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 	sconfig.bps = 1;
 	sdw_stream_add_master(&ctrl->bus, &sconfig, pconfig,
 			      nports, stream);
-err:
-	if (ret) {
-		for (i = 0; i < nports; i++)
-			clear_bit(pconfig[i].num, port_mask);
-	}
-
+out:
 	mutex_unlock(&ctrl->port_lock);
 
 	return ret;
-- 
2.34.1

