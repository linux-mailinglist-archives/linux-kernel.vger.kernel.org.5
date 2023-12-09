Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31680B2E0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 08:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjLIHrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 02:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLIHrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 02:47:15 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34F12E;
        Fri,  8 Dec 2023 23:47:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vy5Az.R_1702108037;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0Vy5Az.R_1702108037)
          by smtp.aliyun-inc.com;
          Sat, 09 Dec 2023 15:47:17 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     neil.armstrong@linaro.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        guanjun@linux.alibaba.com
Subject: [PATCH 1/1] soc: qcom: Fix compile error caused by uncorrectable definition of TRACE_INCLUDE_PATH
Date:   Sat,  9 Dec 2023 15:47:16 +0800
Message-Id: <20231209074716.2689401-1-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guanjun <guanjun@linux.alibaba.com>

Compiler reports the error message when compiling the file drivers/soc/qcom/pmic_pdcharger_ulog.c:
  - ./include/trace/define_trace.h:95:42: fatal error: ./pmic_pdcharger_ulog.h: No such file or directory
      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)

TRACE_INCLUDE_PATH shoule be relative to the path include/trace/define_trace.h, not
the file including it. Fix it.

Fixes: 086fdb48bc65d(soc: qcom: add ADSP PDCharger ULOG driver)
Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
---
 drivers/soc/qcom/pmic_pdcharger_ulog.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.h b/drivers/soc/qcom/pmic_pdcharger_ulog.h
index 9d5d9af4fbe4..3ac994d160bd 100644
--- a/drivers/soc/qcom/pmic_pdcharger_ulog.h
+++ b/drivers/soc/qcom/pmic_pdcharger_ulog.h
@@ -28,7 +28,7 @@ TRACE_EVENT(pmic_pdcharger_ulog_msg,
 /* This part must be outside protection */
 
 #undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_PATH ../../../drivers/soc/qcom/
 
 #undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE pmic_pdcharger_ulog
-- 
2.39.3

