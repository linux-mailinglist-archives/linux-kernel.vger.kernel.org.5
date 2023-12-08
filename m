Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D444809CD5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjLHHBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjLHHAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:00:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051A410CF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:00:42 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d0ccda19eeso14903345ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018841; x=1702623641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8r9qoyiwuNkI/B/mT1i1YBAgOapNu0aoaEC6uqX8X6Q=;
        b=fryJCTfQFUs2UIr+j5VmRu/0IFn+E77IV5GLEmtHgQL4Xcz1AZLyQkU2azxcd6RTKZ
         baROwl4joBMzRPY0AdHI6fRgGL2uW4+4I1lnewSAtFUef8CjXcWzAZ9hWPuWwvuGB4cf
         wUF3nLbGyiyv6DoBC/1pZ2jIulYVshpDvF1mWGCnhH4MXZXNyYVxZO+xrRAEAdbFSb8Y
         knMd8c8sapHyEz5/fIv2Kzf2bc4ux0Puo5CKjkS2oCex0vTq0wEOBp5BrUEN3rtQejFN
         I7b81PHbyedxokVf510A/Gg8x8UlEcpTEXEONFhD6aB2/OtQMUyaVHqDyA9YGtyjO8ZE
         m5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018841; x=1702623641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8r9qoyiwuNkI/B/mT1i1YBAgOapNu0aoaEC6uqX8X6Q=;
        b=fbQpTIioLkkCBNaa3wtJqu31VWTysvbpDodBWLiu+MYG5mFmpUDGq6eSwHPIdaZAcf
         CiMqZYsV8odMoG9uB2zc4CcPUcgWPm7Gtw+KczeHXala78xA0kp1akwZ3whbcb/ycnYv
         7s15xSMhYxbQQuEwSddhaaxCBm6065TnBfs1GG9s/XCORnWX0SVRKZjLXsxWG3Oejx3w
         1PDzSrjSByZDhYBHDwFvt1mUxNdZb9drDk3rOATjEfMXL/pSIEjQOvjKb/gCEKuDzDdo
         VOm+IPWKJLWqA62WHUqT0lPTn9uz4HZ5pZ6yZmNfbueb/d8uYA6+ouLYTX57QXUi7MKh
         EmEw==
X-Gm-Message-State: AOJu0Yw5R6pKYSn7cNZqfjy0EESjcNll7F9Dghx1eBcrlumXh8bfaM6M
        ut+NTeE/S/YG6hzJKX3T6Zr2
X-Google-Smtp-Source: AGHT+IHgEMcuEn/X8ZDnC+EdCxJUjvpDhj1d0x67W7LMHi3+pus9pdNpiEMflc2WfBIowYy/3GAfqg==
X-Received: by 2002:a17:903:5c5:b0:1d0:6ffe:1e76 with SMTP id kf5-20020a17090305c500b001d06ffe1e76mr2644177plb.89.1702018841527;
        Thu, 07 Dec 2023 23:00:41 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.23.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 23:00:41 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 17/17] scsi: ufs: qcom: Remove unused definitions
Date:   Fri,  8 Dec 2023 12:29:02 +0530
Message-Id: <20231208065902.11006-18-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
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

Remove unused definitions.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 2ce63a1c7f2f..cdceeb795e70 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -10,22 +10,16 @@
 #include <soc/qcom/ice.h>
 #include <ufs/ufshcd.h>
 
-#define MAX_U32                 (~(u32)0)
 #define MPHY_TX_FSM_STATE       0x41
 #define TX_FSM_HIBERN8          0x1
 #define HBRN8_POLL_TOUT_MS      100
 #define DEFAULT_CLK_RATE_HZ     1000000
-#define BUS_VECTOR_NAME_LEN     32
 #define MAX_SUPP_MAC		64
 
 #define UFS_HW_VER_MAJOR_MASK	GENMASK(31, 28)
 #define UFS_HW_VER_MINOR_MASK	GENMASK(27, 16)
 #define UFS_HW_VER_STEP_MASK	GENMASK(15, 0)
 
-/* vendor specific pre-defined parameters */
-#define SLOW 1
-#define FAST 2
-
 #define UFS_QCOM_LIMIT_HS_RATE		PA_HS_MODE_B
 
 /* QCOM UFS host controller vendor specific registers */
-- 
2.25.1

