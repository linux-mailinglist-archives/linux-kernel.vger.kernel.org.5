Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B3B75A5B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjGTFnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjGTFnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:43:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B04E2D59
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:42:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8bbce9980so2176245ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689831751; x=1690436551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVAw7udukL38zwKtT4457ZqK6it2VdBXoqf1V9p3kc4=;
        b=rDv9lnxjRFZ0PZj9f9xOPG18lHjHObFlF6w/mOl7Yd1uLQLmbiZlIdMcolqKvoVdqF
         PkXrrCF85nkj7JfH1Qi48QZ5+08l0aZN91puXJ/F4RamZR+ol/43Rrp8JB3An1wlv9ic
         XCKqJegJO/I4zSGp4gz+pqGlvkj/y9ktuU90Bq146G5r9WsWH1wlg4cY1SYHotrImPmj
         8gsPXgULIlJEBzIy0BeYK42NMRtE5VT1qgx+FcuhgUY1DtiDCqvY5eBA9zxpFIr08AOP
         g28VVO2eJoxOAZeF/P/fvc78hOGXCLrllFdLk4WFTeXGxkzNe6HJlA9uArJYMFZ6pY6n
         oMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689831751; x=1690436551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVAw7udukL38zwKtT4457ZqK6it2VdBXoqf1V9p3kc4=;
        b=hCskjmguYxTrmJCcsLnucHFW1au1AkyHHzXJ0aGnUNbD/mmgNmNa+AKAIUQHMahsv2
         OsStSUEiJdhtmoSjP0dZCyzrEPSx6KKNgHK4TAm/kFEV0SDKHr+3vNpY+BoMQspJIkZC
         n6GeZIEUckRy31/Gc/mMw6hztxw44NqIIx4Cbr65FnxlQevNFwHq+0oe+8DQshFvyLLb
         TkjuDeCxeHZYJLDXJ32nZTk1ATylBO3sYMzgXgsBhVau4SBhLQdKCVVaf92sI2Szig8Q
         gLdsrc0Wf6NxNu7ldSlcbHcnTPJPnhbcRxYnZcnq1UWwehWJupER7sDg0y9FUaD60tf/
         RTbw==
X-Gm-Message-State: ABy/qLZlP6RDY1JnLL3hIpzmRKgph+cR+lgFMpFWfvqW42kG2/Pt7gLT
        a5DYRgDpt1kNKVbbg2I2i/p/
X-Google-Smtp-Source: APBJJlHYtomJPuze89iggnawG/+c5d7mLEXrNSEYPH+1X8ipd9FPklDq7JeVlbSa34RXP5oDshaKEg==
X-Received: by 2002:a17:902:e752:b0:1b9:ce7a:8603 with SMTP id p18-20020a170902e75200b001b9ce7a8603mr4854532plf.66.1689831751480;
        Wed, 19 Jul 2023 22:42:31 -0700 (PDT)
Received: from localhost.localdomain ([117.206.119.70])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001b85bb5fd77sm263367pls.119.2023.07.19.22.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 22:42:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 08/15] OPP: Introduce dev_pm_opp_get_freq_indexed() API
Date:   Thu, 20 Jul 2023 11:10:53 +0530
Message-Id: <20230720054100.9940-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
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

In the case of devices with multiple clocks, drivers need to specify the
frequency index for the OPP framework to get the specific frequency within
the required OPP. So let's introduce the dev_pm_opp_get_freq_indexed() API
accepting the frequency index as an argument.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/opp/core.c     | 22 ++++++++++++++++++++++
 include/linux/pm_opp.h |  8 ++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a6d0b6b18e0e..66dc0d0cfaed 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -197,6 +197,28 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
+/**
+ * dev_pm_opp_get_freq_indexed() - Gets the frequency corresponding to an
+ *				   available opp with specified index
+ * @opp: opp for which frequency has to be returned for
+ * @index: index of the frequency within the required opp
+ *
+ * Return: frequency in hertz corresponding to the opp with specified index,
+ * else return 0
+ */
+unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index)
+{
+	struct opp_table *opp_table = opp->opp_table;
+
+	if (IS_ERR_OR_NULL(opp) || index >= opp_table->clk_count) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	return opp->rates[index];
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq_indexed);
+
 /**
  * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
  * @opp:	opp for which level value has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 991f54da79b5..97eb6159fb93 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -105,6 +105,8 @@ unsigned long dev_pm_opp_get_power(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
+unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp, u32 index);
+
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
 
 unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
@@ -211,6 +213,12 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline unsigned long dev_pm_opp_get_freq_indexed(struct dev_pm_opp *opp,
+						      u32 index)
+{
+	return 0;
+}
+
 static inline unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 {
 	return 0;
-- 
2.25.1

