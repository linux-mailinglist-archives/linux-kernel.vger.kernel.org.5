Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000F2800E57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379477AbjLAPPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379415AbjLAPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:15:16 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CEB1BD5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:15:16 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cde11fb647so2217999b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443715; x=1702048515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRvflStZ/vTcP5B8zVnsU2ULybvGH2B1eMnhOvB9jfI=;
        b=GtWJ/wzcoOW5Jc3UDjFMV81ANMdOg5e0pedMcEQBThMVaiJvZeoMKfs8uaoECnZFNx
         orK42lnrM+sIthwFggaw6nUl7gpytq02A5vlbNO/t13babiolophin53U7p4xwymiWfm
         GRbi0RbNy3Z6WeFd4UL9nN6YjqzSNE92cxJ/hcXdRHTifM7L/oYTE/qs8JhEGvv4INbi
         F/XiVrm7fcCwWr2+HkEpY4FdYE0IZKzQAdna0U5OTkSCrbAxdBbhi3Llq42NvstM1JXj
         MgSYEbSGzSpj3RGkBuH4jqSqc7m4ZCie7zJfamt2BQU5JiB0EU0JnYgCXXNtqL0vFxZZ
         CNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443715; x=1702048515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRvflStZ/vTcP5B8zVnsU2ULybvGH2B1eMnhOvB9jfI=;
        b=OuPIcBm/9M4GDphlZZMOtUusHmw15na1KV436Nns/MbCk5ot8i2PNTC/I7v8/HaIdC
         cBCGyD+a113Kj7T+ZLAm9wzc0SdloLZ9K7ajUdTNOps/MXUO+E6Y6Qt5ezYDPbMko9Jv
         pu+HHmHCXY5uYvmE9R0zQZC+3U8eF80GowCgcprLMW6jeFLvIhdkaDyPGMdEQY6HNf+5
         KTOpgwfLPXwcYal56kpulHSnhUQzdyEZzlrDLQ01o7XCbAUJOhxyBA7Q/wpxk6WpQNJi
         AMrNTgt7OXkOusBXMsePVmbFlLYcv9dJCSgnvreiEfwlsaxg5nTR2NIAX5/yqAapHQtC
         qIhQ==
X-Gm-Message-State: AOJu0YxoRdjPwKRMk54x6NcLDPheGXLrhSpmdBtEQDq1rj8ZEy1UfKft
        5aXidzHugzAvycLUduuL7PS+DDPxk8ePhgHkNQ==
X-Google-Smtp-Source: AGHT+IFL+VdkT8Jx4gdpedUqkKxN/i8MfrhTGRszx2lMQkD1Yq8i2V0FL16deBTMgMSjHw0oq7LBQQ==
X-Received: by 2002:a05:6a00:1401:b0:68a:5cf8:dac5 with SMTP id l1-20020a056a00140100b0068a5cf8dac5mr29042906pfu.22.1701443715471;
        Fri, 01 Dec 2023 07:15:15 -0800 (PST)
Received: from localhost.localdomain ([117.213.98.226])
        by smtp.gmail.com with ESMTPSA id s14-20020a65644e000000b00578afd8e012sm2765824pgv.92.2023.12.01.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:15:15 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 12/13] scsi: ufs: qcom: Sort includes alphabetically
Date:   Fri,  1 Dec 2023 20:44:16 +0530
Message-Id: <20231201151417.65500-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
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

Sort includes alphabetically.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 824c006be093..590a2c67cf7d 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -4,26 +4,26 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/time.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/devfreq.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/platform_device.h>
 #include <linux/phy/phy.h>
-#include <linux/gpio/consumer.h>
+#include <linux/platform_device.h>
 #include <linux/reset-controller.h>
-#include <linux/devfreq.h>
+#include <linux/time.h>
 
 #include <soc/qcom/ice.h>
 
 #include <ufs/ufshcd.h>
-#include "ufshcd-pltfrm.h"
-#include <ufs/unipro.h>
-#include "ufs-qcom.h"
 #include <ufs/ufshci.h>
 #include <ufs/ufs_quirks.h>
+#include <ufs/unipro.h>
+#include "ufshcd-pltfrm.h"
+#include "ufs-qcom.h"
 
 #define MCQ_QCFGPTR_MASK	GENMASK(7, 0)
 #define MCQ_QCFGPTR_UNIT	0x200
-- 
2.25.1

