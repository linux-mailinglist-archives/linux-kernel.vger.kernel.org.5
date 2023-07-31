Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6773C7693CC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjGaKzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjGaKyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:54:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9579A1B1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso6646572e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690800764; x=1691405564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5cHR9R1zj6+fWN0kfJbhPUfhYqf7kqDHOcaH9ExP6c=;
        b=ITduZX8pHxMDTAfEDkZvb/kaPLCDVPp7YfKGtUCrabiH81dy0W9JzDGMhKpW6a4I6N
         ipFYF73jNr440Kvfmup7caVb/ii95satwZK6P6ktUsOTKsRXdzNiI+la/X8tvUZbJI5i
         XD7kaNXQNySCE9M4mH/XFO1XijGbpRljakk3N1O0Bm19j5lpuI6c5IxQby//bSuYfiCI
         HJBp9N4kmvo2QEyNBHsmt9NpojrsUxEqX305bSsEJbBH82q4qtTW9tbE7DArl7hb7t49
         aBg0Bj3OWIOtNgs6GDmzVQ29UzBcshZqgY7FIoR0pZTyVMpTTYlmzFyevY7pLFMuubRv
         UqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800764; x=1691405564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5cHR9R1zj6+fWN0kfJbhPUfhYqf7kqDHOcaH9ExP6c=;
        b=Ms+mSXCZ4oWeJqKZfJ0e4hegv+fYyLerIiCCbYiXV7tspKLXKE3go2uiVwT8JaPGzV
         Sek5TEK/9NEWVSrdc0Q1cIHYo1uWAjuqawvirSBv+LzHB8gsbg94fLEXCJY5L+gsQr7h
         9RjQf4cZClWUfXJHaTngmf4PExG/v520+syybuA0lfbKCOLMQZegxuir+3jzVIjTPrev
         R8njK/N+jMNDRSkrKQV/Nl6EyY9xJevDHMT1WqzCsvW0Mr9tQH6Z2UPfPMWHn0QUKDn3
         cXKYJ+1HT9xJzpFBd5mwD8WEWpT3mkuNeYT7BTQ5zbuBSwCMZyCglIpr2awPw3wsjp2D
         yLCw==
X-Gm-Message-State: ABy/qLbehQDvVG9CvCmNjYKFLU/d0sBEqM47rA4reHA+eJeYRKFfbfJm
        rnIr4mrvFNaaoCJ7TIc89jwviw==
X-Google-Smtp-Source: APBJJlFTpXsYiJ2cAzIhHq+JA8LrXMKtk4kXUSP72oU3vvwY69p4wCVLbaAPSICMAnOiAaIpPWYZAA==
X-Received: by 2002:a05:6512:ad6:b0:4fb:8ee0:b8a5 with SMTP id n22-20020a0565120ad600b004fb8ee0b8a5mr5677308lfu.46.1690800763901;
        Mon, 31 Jul 2023 03:52:43 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id p13-20020a05651238cd00b004fdc7ec5cbesm2016936lft.300.2023.07.31.03.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:52:43 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 31 Jul 2023 12:52:24 +0200
Subject: [PATCH v2 08/10] interconnect: qcom: sdm660: Set AB/IB
 coefficients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v2-8-8c91c6c76076@linaro.org>
References: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690800744; l=1519;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EjLG3n/q4YI8bbEqplfHVOwV0syrmI4lAF1qcHGTJvw=;
 b=4csAkdyLYRJkeElKC43KDJYuv8cjk8AT1BfwDPK8EkJgVn9frMBJ0+Vvqu5Yx0xLNjzG/4aoF
 R7OJJ/et669Dd15b9x5ZJ9dsYFJ2xN36uwKfmqTRmN3+Ag2yKNfqzQA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some buses and nodes need additional manual adjustments atop the usual
calculations. Fill in the missing coefficients.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdm660.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 36962f7bd7bb..7392bebba334 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -602,6 +602,7 @@ static struct qcom_icc_node mas_mdp_p0 = {
 	.name = "mas_mdp_p0",
 	.id = SDM660_MASTER_MDP_P0,
 	.buswidth = 16,
+	.ib_coeff = 50,
 	.mas_rpm_id = 8,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
@@ -621,6 +622,7 @@ static struct qcom_icc_node mas_mdp_p1 = {
 	.name = "mas_mdp_p1",
 	.id = SDM660_MASTER_MDP_P1,
 	.buswidth = 16,
+	.ib_coeff = 50,
 	.mas_rpm_id = 61,
 	.slv_rpm_id = -1,
 	.qos.ap_owned = true,
@@ -1540,6 +1542,7 @@ static const struct qcom_icc_desc sdm660_bimc = {
 	.num_nodes = ARRAY_SIZE(sdm660_bimc_nodes),
 	.bus_clk_desc = &bimc_clk,
 	.regmap_cfg = &sdm660_bimc_regmap_config,
+	.ab_coeff = 153,
 };
 
 static struct qcom_icc_node * const sdm660_cnoc_nodes[] = {
@@ -1659,6 +1662,7 @@ static const struct qcom_icc_desc sdm660_mnoc = {
 	.intf_clocks = mm_intf_clocks,
 	.num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
 	.regmap_cfg = &sdm660_mnoc_regmap_config,
+	.ab_coeff = 153,
 };
 
 static struct qcom_icc_node * const sdm660_snoc_nodes[] = {

-- 
2.41.0

