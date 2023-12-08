Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109D4809CC3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573241AbjLHHAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbjLHG77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:59:59 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7228E173B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:00:02 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d1e1edb10bso16238105ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702018802; x=1702623602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMlhD8WS0RVtXNWZq8+Ekz+zAl7Mbew6ctHcI4T3R2A=;
        b=w17CAwjnBiSA5PJez0PVyJiJdKr/bj+JBOG20onw+6Kv5mV1jQX9kB9ucvfRm1QHs/
         c2jwDB3MqsglMdnhWbqWuVqvbrVeQDGTlTDVBigWMpryNNVx3vhS39gDjuuYbyj5c21y
         QwyephmqTeaTT4CfzzCZ41c7fNJfP3LTVWWvLKXlxQnlBA+0NWY+ZTUdV6b8TOnMzk4T
         Cpc3d7vOH+etmycLfQrfGZIq8xioTBmpi/zHcLTL+1KbcWybspNc6wNRzGty9KJxe3yF
         oW8pr+uHjJbTuEO66KtKGY/qFPGm1xz9XXxvboOb5DgLmoGAGnfKvB2JalZ8VVqWecKG
         Yfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702018802; x=1702623602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMlhD8WS0RVtXNWZq8+Ekz+zAl7Mbew6ctHcI4T3R2A=;
        b=CEOi70zrVxmyEcsJTX1O8CSO7YnxiIy5C3ll96s/1MHXmb4fPiwP2wgR6haeHTIOGD
         Wu/60CvvoAWMcpPUcMBNIe1ozg2CENzTChv03SZ9707GbQITcaCnuN6AYCNhLH3BcFYU
         guOLbAWtGyxxn6+GFLv1efFQPNte9XUEfFCswoa8LaCrhqkNFQmIaDESvxd04onEhA2I
         CB7uXxdzv/2/HE+EtWmU1qKbNGH1WxgKSH1c8Yx+L8T586CS63JZgxTPDoxGebKqLcuM
         swOqO63mQP8SMFZJ9yYq1rMaKXsv3627A4zSdlpJ1OIpjBHCPRfAgFORIjirigaq1ZSg
         TBrA==
X-Gm-Message-State: AOJu0Yw8fjZM9l3y2GlAVEUyTAGDebByCQ0j9/6rnh4a7fGadxSsReE2
        nfRvxOfhc96Ld5TcfqPL8jG0
X-Google-Smtp-Source: AGHT+IHccpHpLogCcC55e3YdRrf5zzuYzDmRVH4d9uufAv8PswsFT4A1IbRSAb8WkK22n3+dGsOP0g==
X-Received: by 2002:a17:902:f68e:b0:1cf:ad5f:20ab with SMTP id l14-20020a170902f68e00b001cfad5f20abmr4410627plg.19.1702018801803;
        Thu, 07 Dec 2023 23:00:01 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.142])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001b03f208323sm934263plf.64.2023.12.07.22.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 23:00:01 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 09/17] scsi: ufs: qcom: Remove redundant error print for devm_kzalloc() failure
Date:   Fri,  8 Dec 2023 12:28:54 +0530
Message-Id: <20231208065902.11006-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
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

devm_kzalloc() will itself print the error message on failure. So let's get
rid of the redundant error message in ufs_qcom_init().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index b141dd2a9346..05a9a25bc34c 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1109,10 +1109,8 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	struct ufs_clk_info *clki;
 
 	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
-	if (!host) {
-		dev_err(dev, "%s: no memory for qcom ufs host\n", __func__);
+	if (!host)
 		return -ENOMEM;
-	}
 
 	/* Make a two way bind between the qcom host and the hba */
 	host->hba = hba;
-- 
2.25.1

