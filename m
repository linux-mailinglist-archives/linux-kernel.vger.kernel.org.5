Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1182376960E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjGaMUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjGaMUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:20:35 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7EF1729
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:20:18 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe3e88bd5fso49122e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690806016; x=1691410816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1y6paI5uebxybxrRxiiWIURpG14DnOR3pPpr3BR6Gs=;
        b=jI+rLFlOKtoUSK3ZhwD2Eqmpbs1rrnWl76r2NBpt4ui+CmdTy+aJPlPc6Xvz0EZHnM
         EQ+r535iSvwW4ZPh3IRnS3+y6J+fcTxnyr9yuOj2km8aPnvzxavgKA//8jW2ho/lppWC
         S4YGCxXKFywDOGdH5Yw86dIeDWkPl/eF5SX/rY46Zl+rPzLzwKvnC01Xpqjex2Z1d/C2
         ZD9MbCqUqxr6Fw2M5OgZ2N73icIAAcFwLvgpDs+mwxHBo+YFfAAggBbw9jm0wC3M+lYt
         TZSw8XNehjaWbkO0ABn+dFo9bAwJNXzkHJwpdECU59j38A3damwFQZhA5OHoWW8h94pE
         v/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806016; x=1691410816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1y6paI5uebxybxrRxiiWIURpG14DnOR3pPpr3BR6Gs=;
        b=RWntksuAurVdCN4F4tvcU9vUEzFltoI7WWaL/BDjRWkgNqKlgdbaePQM8FH+DKgQEA
         H8rZcoHMg+5TnjpjDwpUhab37P82lAv5Z2igaW40NsLdVlQ2lfxYNM+DHBijitQrxWtF
         D3mqaYRJsN+CrbeB+KYioyZj6vGN6WXMAdT7N+0CBRF8A5j27S/gFl/rnR2HZ93e9QbO
         5IfcnmiO8AJThhc1keLDslF3iK9upof1u1alZqHegcNxshHNmn+RMScpqMRZvc0DaBFG
         6hMo8DLYtCwIbZnF42zZtmVU+xWXbdFC5UBjNV5Z4TEdN8tI3gc0uvSf8vQXhmP7COqZ
         bqdQ==
X-Gm-Message-State: ABy/qLYywAQGDY9k1gEr3P11/9vvYnbJX7IEj+JpfYi9y4DQ0CUtmEhN
        71O2njoG1d7Zux8cmCSLxCn6Wg==
X-Google-Smtp-Source: APBJJlEm03oeFirz31CUV3y33d9dJ2EjbIhcTJMTdhyURruMj/Z/g2APOxH48WZHWTTWzzVJE6jN/w==
X-Received: by 2002:a05:6512:542:b0:4fe:54f:6cdb with SMTP id h2-20020a056512054200b004fe054f6cdbmr6031349lfl.33.1690806016062;
        Mon, 31 Jul 2023 05:20:16 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id u9-20020a056512040900b004fe11366146sm2079096lfk.51.2023.07.31.05.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:20:15 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 31 Jul 2023 14:20:12 +0200
Subject: [PATCH 1/2] clk: qcom: smd-rpm: Add a way to define bus clocks
 with rate and flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-topic-pcnoc-v1-1-452dd36d11d7@linaro.org>
References: <20230731-topic-pcnoc-v1-0-452dd36d11d7@linaro.org>
In-Reply-To: <20230731-topic-pcnoc-v1-0-452dd36d11d7@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690806013; l=3511;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=pFdKDOz3A2TAZm4zvWo5pV/dny5w465aaIYk1XlaQHM=;
 b=hIa0gd0F7jVV5AEG9z3KULs2ji9hcLHZsI5JO+d3wk+BXNhRK/MrxfyJUq6HjjPZCByv+SbQh
 PGmyYc24RTpDXAU87rOGJlRkrNFa9z88usy7DGTLKLAqAYKAMw4I+zc
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks, at least PCNoC (a.k.a CNoC_PERIPH) need to be always on,
at least on the ACTIVE side, regardless of whether they're used for bus
scaling or not.

Introduce a new macro to preset non-INT_MAX rates and clk flags to make
it easy and work implicitly through the CCF.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 9b5411932594..ebb8d9aac89d 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -18,7 +18,7 @@
 #include <dt-bindings/clock/qcom,rpmcc.h>
 
 #define __DEFINE_CLK_SMD_RPM_PREFIX(_prefix, _name, _active,		      \
-				    type, r_id, key)			      \
+				    type, r_id, key, ao_rate, ao_flags)			      \
 	static struct clk_smd_rpm clk_smd_rpm_##_prefix##_active;	      \
 	static struct clk_smd_rpm clk_smd_rpm_##_prefix##_name = {	      \
 		.rpm_res_type = (type),					      \
@@ -42,7 +42,7 @@
 		.active_only = true,					      \
 		.rpm_key = (key),					      \
 		.peer = &clk_smd_rpm_##_prefix##_name,			      \
-		.rate = INT_MAX,					      \
+		.rate = (ao_rate),					      \
 		.hw.init = &(struct clk_init_data){			      \
 			.ops = &clk_smd_rpm_ops,			      \
 			.name = #_active,				      \
@@ -51,12 +51,14 @@
 					.name = "xo_board",		      \
 			},						      \
 			.num_parents = 1,				      \
+			.flags = (ao_flags),				      \
 		},							      \
 	}
 
-#define __DEFINE_CLK_SMD_RPM(_name, _active, type, r_id, key)		      \
+#define __DEFINE_CLK_SMD_RPM(_name, _active, type, r_id, key,\
+			     ao_rate, ao_flags)				      \
 	__DEFINE_CLK_SMD_RPM_PREFIX(/* empty */, _name, _active,	      \
-				    type, r_id, key)
+				    type, r_id, key, ao_rate, ao_flags)
 
 #define __DEFINE_CLK_SMD_RPM_BRANCH_PREFIX(_prefix, _name, _active,\
 					   type, r_id, r, key, ao_flags)      \
@@ -104,17 +106,22 @@
 
 #define DEFINE_CLK_SMD_RPM(_name, type, r_id)				      \
 		__DEFINE_CLK_SMD_RPM(_name##_clk, _name##_a_clk,	      \
-		type, r_id, QCOM_RPM_SMD_KEY_RATE)
+		type, r_id, QCOM_RPM_SMD_KEY_RATE, INT_MAX, 0)
 
 #define DEFINE_CLK_SMD_RPM_BUS(_name, r_id)				      \
 		__DEFINE_CLK_SMD_RPM_PREFIX(bus_##r_id##_,		      \
 		_name##_clk, _name##_a_clk, QCOM_SMD_RPM_BUS_CLK, r_id,	      \
-		QCOM_RPM_SMD_KEY_RATE)
+		QCOM_RPM_SMD_KEY_RATE, INT_MAX, 0)
+
+#define DEFINE_CLK_SMD_RPM_BUS_A(_name, r_id, ao_rate, ao_flags)		      \
+		__DEFINE_CLK_SMD_RPM_PREFIX(bus_##r_id##_,		      \
+		_name##_clk, _name##_a_clk, QCOM_SMD_RPM_BUS_CLK, r_id,	      \
+		QCOM_RPM_SMD_KEY_RATE, ao_rate, ao_flags)
 
 #define DEFINE_CLK_SMD_RPM_CLK_SRC(_name, type, r_id)			      \
 		__DEFINE_CLK_SMD_RPM(					      \
 		_name##_clk_src, _name##_a_clk_src,			      \
-		type, r_id, QCOM_RPM_SMD_KEY_RATE)
+		type, r_id, QCOM_RPM_SMD_KEY_RATE, INT_MAX, 0)
 
 #define DEFINE_CLK_SMD_RPM_BRANCH(_name, type, r_id, r)			      \
 		__DEFINE_CLK_SMD_RPM_BRANCH_PREFIX(branch_,		      \
@@ -128,7 +135,7 @@
 
 #define DEFINE_CLK_SMD_RPM_QDSS(_name, type, r_id)			      \
 		__DEFINE_CLK_SMD_RPM(_name##_clk, _name##_a_clk,	      \
-		type, r_id, QCOM_RPM_SMD_KEY_STATE)
+		type, r_id, QCOM_RPM_SMD_KEY_STATE, INT_MAX, 0)
 
 #define DEFINE_CLK_SMD_RPM_XO_BUFFER(_name, r_id, r)			      \
 		__DEFINE_CLK_SMD_RPM_BRANCH(_name, _name##_a,		      \

-- 
2.41.0

