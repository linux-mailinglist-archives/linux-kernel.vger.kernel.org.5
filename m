Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDB978CDF5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbjH2U7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240578AbjH2U72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:59:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9996CC3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:59:24 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500c7796d8eso1076335e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693342763; x=1693947563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDiDlbXY5yzxtV/UMHY8DDSwA1Y2sSArumeXUmrmXZw=;
        b=c8o1+BNYPTNZVhHl+goLHv+xrTxunRhO89wvU+igpZ81AGcFG3DJGezxlWnPyHGiKM
         HgSWKwppdMvxYlWHkm2CAdcFth0WbKyI2XXvwAY/NLpENu7QZqrinM8+0c9MQpYCo1Cu
         nGd+0q6Mt4fRmLMSOTS3Zumav2H4ouNbvnySxxdJJHvnxZdI2q+6TMLVKULCyfU1gbdn
         Rg/nsyAlwDSaBJkqPR+Ut8ZilX/fmxGP+Anh8ZS4+gvleuya/fbBl+DT3qvU0IGHHszn
         vXOdd8Juxxta+oCZqQer74Ii4pX4TCFIVsrc5nhcu3VBpsLO6tyNgFh7jyybyVSLp9Tb
         TbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693342763; x=1693947563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDiDlbXY5yzxtV/UMHY8DDSwA1Y2sSArumeXUmrmXZw=;
        b=E2Da2WNSqLPfsAU9ZhwsQrRLiTkFZs+gKsPW23sRMmIwNx4L8DAHCSciwDE51D3Mkh
         eOOfxDqQVwoT1uolJCaz3pHmacTAc4FQXOXltgu6G5ulGIBZMbGedH59SM1SvElHiMMd
         c67tFewKe8LjLKsXrLFrGRyv8Q139TiAe3HUFpoi4WSl469JYQ7y1Yc0+2C2noxWVlom
         YzK5+RcAbovgbdqfvkIZ9a6FBgIOXxOWAGQWjbfjB532u0cbgfDaVX0bvbjIP/WOARZw
         zY5eQVwACRNf++pQc2uoJVznYiJizhCAPE863EEceAsh4aJmhLnVdfN9aWVwPS144JTI
         IdUw==
X-Gm-Message-State: AOJu0YwzFBCRx8TyceSjpOTh/Xj/imgGF5LTnq8a79nz4K6lR044QD8v
        8TUMMh+LKZI6jXucqwbHitDJZg==
X-Google-Smtp-Source: AGHT+IFBt6mCKFv8FjhhTBDDAyZfTvDLM3LO49D3cQx1lhHL5aFnzKrfjknbW6j9TLPvdXrQfK39tw==
X-Received: by 2002:a19:5e1a:0:b0:4fa:21d4:b3ca with SMTP id s26-20020a195e1a000000b004fa21d4b3camr56225lfb.2.1693342763210;
        Tue, 29 Aug 2023 13:59:23 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id q30-20020ac2515e000000b004fbad09317csm2074025lfd.189.2023.08.29.13.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:59:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 29 Aug 2023 22:59:05 +0200
Subject: [PATCH 2/2] phy: qcom-qmp-combo: initialize PCS_USB registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230829-topic-8550_usbphy-v1-2-599ddbfa094a@linaro.org>
References: <20230829-topic-8550_usbphy-v1-0-599ddbfa094a@linaro.org>
In-Reply-To: <20230829-topic-8550_usbphy-v1-0-599ddbfa094a@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Adrien Thierry <athierry@redhat.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693342759; l=1235;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=adVmBzdoCGTsemFqAoQk/FkwFdzWdPC36JGX5NvhpUo=;
 b=aDox5HcEB7BiDj/xATHHbGSkGblXnbMQljwSM6u6KT9zqxT2CPkjQKRfdRFMeyrXHUXoEa/jb
 cTlHVJoE3TxA9rPwoIfEsLI77n93TCXC9YiFRSKD/Ji8qAq6PuntL5b
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, PCS_USB registers that have their initialization data in a
pcs_usb_tbl table are never initialized. Fix that.

Fixes: fc64623637da ("phy: qcom-qmp-combo,usb: add support for separate PCS_USB region")
Reported-by: Adrien Thierry <athierry@redhat.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 843099d314bf..1922b05403ac 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -2555,6 +2555,7 @@ static int qmp_combo_usb_power_on(struct phy *phy)
 	void __iomem *tx2 = qmp->tx2;
 	void __iomem *rx2 = qmp->rx2;
 	void __iomem *pcs = qmp->pcs;
+	void __iomem *pcs_usb = qmp->pcs_usb;
 	void __iomem *status;
 	unsigned int val;
 	int ret;
@@ -2576,6 +2577,9 @@ static int qmp_combo_usb_power_on(struct phy *phy)
 
 	qmp_combo_configure(pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
+	if (pcs_usb)
+		qmp_combo_configure(pcs_usb, cfg->pcs_usb_tbl, cfg->pcs_usb_tbl_num);
+
 	if (cfg->has_pwrdn_delay)
 		usleep_range(10, 20);
 

-- 
2.42.0

