Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D967824BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjHUHmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjHUHmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:42:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37541130
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:42:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31969580797so2706633f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692603725; x=1693208525;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w80cGmdma0SArN7690HwVB2oaiPgCC1gxMORwl/l+yM=;
        b=cuwrig7BpIvey/SIEWwGCUHu5QkUux+Z16JciqfgeotQJyIcTnFfBH8TzLffymCqFt
         0zLYTilEX6tIK5PQWXiLMra9A09QbH0HHe+YTqYRGwkaguQgFInXbdH1k8DiAZJxZVRl
         uuS7UgBWEn4klOusphXOLRzzyyFCAhRpk20gpnOkoXYNjIC6H5TVyOiyuFhtSI7UGvaX
         9uEKBnFDJbqsMVwfA/GGXaaV6+X9dXxcvfXVdBhj1KiamkPH6wmbnUOgPKyeM59mWS8C
         4QJnl3HdK+TZbVoc/JvoizSpVKW0G4GKneszwd176VzJJF5EktOfR2qVFmFKuk1TC7Ie
         1eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692603725; x=1693208525;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w80cGmdma0SArN7690HwVB2oaiPgCC1gxMORwl/l+yM=;
        b=PUrGIhU64J0YjreDXWFpyiBLBfnDnShEN8NfwPnsM5QBtfhFtVTG4KRtDP+PEo5/9r
         pjJjNRJhtWUi+fqHDNRihr+i8m/NZxlPrYAomnPBoo6v+JituQCYF9C9AgdjwMOKTDWx
         yWuyH59RgeuQBdzlUB2LTls2ITFjJbcC8gmZZIstSFS+qEcz8k7gdlklpCJonfbfWo6A
         VTUIvgubi0OPt2HtP/BJjNrDiHXZdawbyZteeoQCKYLdmpI2H23A7N09BjUTbB6s8gvX
         UBQjqp+CYS64gwERvadXNquzni5fMPBBCr5T4rGTIwVRQ50mr6hTAnEUGBAcm02UwvC0
         fkdQ==
X-Gm-Message-State: AOJu0YzzBqGvTtJFftgNWRmK/imMssESFErQ2IEO5sa4OBDkDdHeuWn8
        kEPZx/2EkrJqVmcM/rIvI/TXtg==
X-Google-Smtp-Source: AGHT+IHBXc3eoMkCGq/zEswMlhcipZ0tI18JVR5M7hVcPjdU8BhR1fVCdVIbUtwBQ1PQs0Gn0mzYPw==
X-Received: by 2002:adf:fc8a:0:b0:317:70da:abdd with SMTP id g10-20020adffc8a000000b0031770daabddmr3793677wrr.59.1692603725476;
        Mon, 21 Aug 2023 00:42:05 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o15-20020adfeacf000000b003197e3520ddsm11499155wrn.109.2023.08.21.00.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:42:05 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 21 Aug 2023 09:41:54 +0200
Subject: [PATCH] scsi: ufs: ufs-qcom: clear qunipro_g4_sel for HW major
 version > 5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-topic-sm8x50-upstream-ufs-major-5-plus-v1-1-c14cce209f21@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEEV42QC/x3NQQrDIBBA0auEWXfAaKTSq5QuJI7tlBrFiSEQc
 vdIl2/z/wFClUngMRxQaWPhvHSMtwHmj1/ehBy6QSttlNMjrrnwjJLcbhW2Imsln7BFweS/uaL
 F8muCE3kfTDTB2Tv0WKkUef+Pnq/zvAAXLcEieAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=DzbUtFSi2ZBAofA9XGfdAYA15y6m4ehnsamRtSjaJsM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk4xVMlpcGodbajHo7KDS+ZF3W1i73C/2bLeWu85K2
 /keJkjKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOMVTAAKCRB33NvayMhJ0dQ+D/
 0eyMqdXR1FkDe6JUBcjKt5+vur3Az8r5/3tjjKQnIDUa0X93cxT9C86dXWAjv3cnPXw0fPXxD0ligO
 RhBvcqxEm5pv9JPRxKq4J7WN5ZBDO7x1IDO/mCpDJ5MzIp1Lhr0gz3QP5Ds+vqN/6NUoOhSNZiEa2u
 Ez70ViWPm85zxD28jzjXrz1kxmmV3tbTaPEPe4wnc2lvP2T/hz4vECJ34nDloEXzSDVDLlJiYmlnSe
 MTCwV83J3dy5RF63d0lhJBcnD/zMOQXFdKZs5H/mwWHDRmGpSQPYekyO65IqPYJp5K4gWghrADUzVp
 iXAsekcfG27S9vPoIyni2uvTYK7YNhvp3iBvrVGu2kM3Ys9YDUCmj2Edqv2Y8xxwLU1fwW80tr9YA0
 +xGgf3zH3HkDp77mseM5phALDx0HZ6dw9mtI2nVGCkJSXUNWtUOEQIfpRvwkRX/jkx9bEEovVY+Pkf
 lP5K+4rqpbCnT/Sv+vgTE0InttHiZU0UyrzQuGk8CCxGYGfXayRrgFauJCD0ZbRTAId5rDZ4pCmhJ7
 8MtYFgsHZXgot0dWKxwMXbzTetDHuHXgjTpF2R0PyBTERCiODNf34ms0gCWIEsAPY7gXLHTwsa+RBA
 RgyibehFtG+uSWbDjIoIrxCXwVPQUnr8YngoIsCICMdqedO6XyvRvryYIP+g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qunipro_g4_sel clear is also needed for new platforms with
major version > 5, fix the version check to take this in account.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index f88febb23123..d1149b1c3ed5 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -365,7 +365,7 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
 		   ufs_qcom_cap_qunipro(host) ? QUNIPRO_SEL : 0,
 		   REG_UFS_CFG1);
 
-	if (host->hw_ver.major == 0x05)
+	if (host->hw_ver.major >= 0x05)
 		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
 
 	/* make sure above configuration is applied before we return */

---
base-commit: 47d9bb711707d15b19fad18c8e2b4b027a264a3a
change-id: 20230821-topic-sm8x50-upstream-ufs-major-5-plus-4eaad3f3d857

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

