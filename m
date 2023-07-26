Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B516D763781
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGZN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjGZN03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:26:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6078B1FEC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:26:28 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso10770348e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690377986; x=1690982786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlYno703h9Rc07Q4o0xGriJ575A5cS8B+AAXSkAUxQ0=;
        b=u0gVsT2JW2shLoA3VJTEMT68XNaOEiMPGz0lsmF3Xn1zRArnR5Iellu+Yu3PdmWRTm
         IxwO+ywuyR5QWy8G2v2Li0dUNsH1z6Fp7kwBP301kLjlSMfbsS610P1c5shjPX/stse1
         H1jf1MtER0NCWBFDg/fvxEq7Zzog5hpcTiwmuumR9pQEasSOJiGycTr0EuoU+ItXEkGJ
         +u+UY1uvuiAfzT41lNBJOW9IOCppqP6jLNGi/8shD+3JEvCA5WVVka8eparOOgSdAsws
         LsQPDchnI9IoJeYnjSX5wcu59UdrT1VfbWj9Ogpqo4AmDcdGumetwFywhaIw7cOXvcvo
         Bsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690377986; x=1690982786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlYno703h9Rc07Q4o0xGriJ575A5cS8B+AAXSkAUxQ0=;
        b=RKqhR3xJzY4YJJRA80NWUaL5Wo/YnjDW6qnMvVs0xN9gILfBVB3b+4MI8zNG8iVd8P
         NPbzYuCZ885pyDdzAjU07hXLWLdpfJlRGgzRED8Sb0fbaSHsSkHcC+V/gLJaHO7mJ1Z+
         Luzf36cN87/hSHj9pkS3PrDnjfhBJ48WvHRlbrdARqj5iDNptU/MJv92QkyIRCt5yRKg
         3tKfSU0h7zMm4mEraanVpJz8TQ+mbgrO3S1NeE7vc+CPHm/8+zd0MxMmh2QzEejru+2a
         xgUB5EmewKsJCgoZmzpztMeEndqIbFxEnkMPSjOWTz+YhD+jaHiq1hxb7rrU+TnMPRpk
         Usog==
X-Gm-Message-State: ABy/qLYTRLuWKOQcbsA8n69sWlgpZUxD3YBNNrtOmSpxd0FVgGMJgjAw
        MwJQazXDKn3i1fS1QLWed//feEuh23pidZfmyD6/wQ==
X-Google-Smtp-Source: APBJJlEa3UFWx5zArcinnI3/s7D0J7bfh/Ec4Ah/Tj9utH2dc5qQZS4SXEcZAZDog8vIU+UeWBAtZQ==
X-Received: by 2002:ac2:5f81:0:b0:4f8:49a8:a0e2 with SMTP id r1-20020ac25f81000000b004f849a8a0e2mr1380217lfe.16.1690377986567;
        Wed, 26 Jul 2023 06:26:26 -0700 (PDT)
Received: from [192.168.1.101] (abyl59.neoplus.adsl.tpnet.pl. [83.9.31.59])
        by smtp.gmail.com with ESMTPSA id q20-20020ac24a74000000b004fe08e7dfbdsm742265lfp.44.2023.07.26.06.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:26:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 26 Jul 2023 15:26:20 +0200
Subject: [PATCH 2/2] clk: qcom: reset: Use the correct type of sleep/delay
 based on length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-qcom_reset-v1-2-92de6d3e4c7c@linaro.org>
References: <20230726-topic-qcom_reset-v1-0-92de6d3e4c7c@linaro.org>
In-Reply-To: <20230726-topic-qcom_reset-v1-0-92de6d3e4c7c@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690377980; l=1045;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3sxskWG1FiMzGN6odih/2AzgyX1UlY1CqV7tLRwSv/4=;
 b=saOq9jwbZrvjAwZ97NcbMwHI/ViisOkxLpymdQaHubISBRKSsBjABT2TlxD70zhxtbW37nY7H
 7yxUvSV7wOhAYT6i2QpsmQex8EMcwjNG+8KGbr+FDpAO4oYeqoTm2os
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the length of the delay (see: [1]), use the correct sleep/delay
functions.

[1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
Fixes: b36ba30c8ac6 ("clk: qcom: Add reset controller support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/reset.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 0e914ec7aeae..928995c3f369 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -14,9 +14,15 @@
 static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 {
 	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
+	u16 delay_us = rst->reset_map[id].udelay ?: 1;
 
 	rcdev->ops->assert(rcdev, id);
-	udelay(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
+
+	if (delay_us < 10)
+		udelay(delay_us);
+	else
+		usleep_range(delay_us, delay_us + 5);
+
 	rcdev->ops->deassert(rcdev, id);
 	return 0;
 }

-- 
2.41.0

