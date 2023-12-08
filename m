Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56C809CC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbjLHHAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjLHG7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:59:52 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C311733
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:59:57 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d06d42a58aso16237455ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 22:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018797; x=1702623597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYI4r4XUuz71I8vtap69MBMVnAez8i9Yk5eIAeppyug=;
        b=ZBAeNsBYKFU6yv7U6js/AeSEAZxZd4Sb7ZMu8QoIGbq2AirNBiX6RdLDNMBi7cL0Ys
         JjOmpWWcJNU0AZptgaBLjNDy0ZyFvE/jE0lNjwhvOSh5KOfOyaB6zTrFjtMWv1UVVNit
         UCrbsMbSIqWtJnQLWrhkAVNHJYGJPKQVor8+wbfeE6k9da2YxD0R1KFE67g+Tkwf5IzT
         Yefa9zgu96kGnSlXiy2pQMd/+IP5BkSKvFdI4O3UHfYF9AvCis4fw5noOf44RxYDcfrI
         bpdV6jaPr0xhv6u14efok+aUeYTQUJjV+hvd7u9bF+nPpn4frnWrg8gKI5MqkjC+5W53
         qdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018797; x=1702623597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYI4r4XUuz71I8vtap69MBMVnAez8i9Yk5eIAeppyug=;
        b=YHNm/eXtKVuJEBlpGK+9NpmW4dD70NYWuwLAvJmeTj6z7mnDRResn8wVOVN/+esl8v
         tGqOKAlmPDdhnG4e4860j24zKBgnSMyjx86bG9hyF3Koka6LsC7TpfETewvbmaPiUDEz
         NXPqnD9t6QWCvTrejl1PvL0fcSiHHaMJHVoI2ASjeaa8zbO92y5uOHEJeRGVgb0eC+EG
         0enAp7NziuzhP3B5dg9/xmTMZ/rh4pE3mJ9Y8OJUkI6CSlWvLVuy+tCh2seJoBF8ESgk
         dMPt4LucurJLxuDigY2SXChBwStB/2QAqOPG/yX7NnyP8iAcUorItjv+76lAnDWjVbjb
         IMTA==
X-Gm-Message-State: AOJu0Yz6Uyd0qYEtDIRbzfyEXuEoGMZr64BeKP6pNKRA8R2H/qsq6d86
        11jHGlrfzkCYqUOTm3SENQ3wZdxj8dDbdwFHzA==
X-Google-Smtp-Source: AGHT+IHEh7rNunBQCv1jB1S67MBGsxYjecPohm97PlMerUQDMElKauhE5n0VNoRMjq4XB4hV8cNaCQ==
X-Received: by 2002:a17:903:11d1:b0:1d0:8c04:85fe with SMTP id q17-20020a17090311d100b001d08c0485femr4011908plh.12.1702018797069;
        Thu, 07 Dec 2023 22:59:57 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.22.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 22:59:56 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 08/17] scsi: ufs: qcom: Check the return value of ufs_qcom_power_up_sequence()
Date:   Fri,  8 Dec 2023 12:28:53 +0530
Message-Id: <20231208065902.11006-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ufs_qcom_power_up_sequence() fails, then it makes no sense to enable
the lane clocks and continue ufshcd_hba_enable(). So let's check the return
value of ufs_qcom_power_up_sequence().

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 365a61dbf7ea..b141dd2a9346 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -417,7 +417,10 @@ static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
 
 	switch (status) {
 	case PRE_CHANGE:
-		ufs_qcom_power_up_sequence(hba);
+		err = ufs_qcom_power_up_sequence(hba);
+		if (err)
+			return err;
+
 		/*
 		 * The PHY PLL output is the source of tx/rx lane symbol
 		 * clocks, hence, enable the lane clocks only after PHY
-- 
2.25.1

