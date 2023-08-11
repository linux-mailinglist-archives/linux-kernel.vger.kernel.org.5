Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910B7779014
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbjHKNEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjHKNES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:04:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F8F270C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:17 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso3055303e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691759055; x=1692363855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbMy2EJg1/HfJ8Ke6dWMRUTNv1lsrcvmOYBylkeVnks=;
        b=cyUqTseuMNNavvl/Rf56R/12jMWk/KxToJhWT1aKCbVn8G12AU+iGbiX82IusyF9D1
         45wMScJvXukq8y0ACKun8KVS4Zn3UXH+Uj4/OZ0wwQPteEVLaMj0ddWQvbpmkb5DHNje
         YjgJfOMVr3mEt3nPJTqawqA7eXjJEY186LgIej9dZ5NN+SgPoqIYrwtjYicXgzk7phCv
         uf7YhwMuy7IFfP8cIexrO4JImuYEjt/bAoUWqaNENTof+8iVn8pxDbW5f4tBVTqLEmmM
         e+AYLur+r3E+AqgN1JstXHnbvC6PuifjQ7JWFMU8Qbf7XIM0eKFbR3LbYBjUOzNDkznK
         KEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759055; x=1692363855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbMy2EJg1/HfJ8Ke6dWMRUTNv1lsrcvmOYBylkeVnks=;
        b=kEdjjX7GkJT/2SGSsSUMgeQIpAfN4sMuqZlSkcU/hc8yySZWyOhekho3kzFeXKDVrq
         jJqw6dKU86K2NK1zXdW+qn3jDdcIaJJ2mCcRkDY8fTXab6KX9u1avxSIFYQb2wdX1WPs
         ZMGLjIuUUqD8uh59XskVhUXK3JXdFq77VDlENulpjjajOwccHavHzGGZOavyIqKELeUO
         VNM4K+10kHWCjz7ZPHqDNblkLTmEpoml8Xfx3dkAm71W3Fxvc38JzsFT2YDEiF2WmBAm
         CLdFOameQvD1qtt6FAyB/I9KnBoVNg2rJtMcwML3YijzrFFzu6kvhUj19TCR1NdxPbjz
         JmzQ==
X-Gm-Message-State: AOJu0YzlSYI8sq0L+6hElXDK/QX1NkVEyMb/KCTxKwWL6TyH0K+QyIYa
        Je/9f6keMAR6C1E7bsAVMCQnHJA9JEvFrzy1tGY=
X-Google-Smtp-Source: AGHT+IH8g+spn5g3JkwOvSskTdTzBcg7cT0meQQYzOj/nIzMRFE97G/jSwlHnsHCQjk0tArWBlANFw==
X-Received: by 2002:a05:6512:3695:b0:4fe:2efa:b847 with SMTP id d21-20020a056512369500b004fe2efab847mr1220902lfs.23.1691759055289;
        Fri, 11 Aug 2023 06:04:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id v20-20020a197414000000b004fe15a2f0f6sm722491lfe.62.2023.08.11.06.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:04:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 15:04:08 +0200
Subject: [PATCH 01/11] interconnect: qcom: qdu1000: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v1-1-a85b6e94f46d@linaro.org>
References: <20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org>
In-Reply-To: <20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Richard Acayan <mailingradian@gmail.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691759050; l=1290;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DxgRmQ1OzR3nEWUhjrHYmNAELDVHgCeW41xvvvTsUgo=;
 b=Brnmp31zihvGRHdQEMbXAiTFp8/XbQXmNqHrn0BraTd4gfvMwpceabzhZjH4oCc5MgPNj+se8
 AAVUbNkM7FDDZ2unVfhZqE2IO0P4bVYbxHyB/semsAqmH8VqxipCJKZ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: 1f51339f7dd0 ("interconnect: qcom: Add QDU1000/QRU1000 interconnect driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.h | 2 ++
 drivers/interconnect/qcom/qdu1000.c   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/bcm-voter.h b/drivers/interconnect/qcom/bcm-voter.h
index b4d36e349f3c..da92267877f9 100644
--- a/drivers/interconnect/qcom/bcm-voter.h
+++ b/drivers/interconnect/qcom/bcm-voter.h
@@ -16,4 +16,6 @@ struct bcm_voter *of_bcm_voter_get(struct device *dev, const char *name);
 void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
 int qcom_icc_bcm_voter_commit(struct bcm_voter *voter);
 
+#define ACV_RSC_APPS		BIT(3)
+
 #endif
diff --git a/drivers/interconnect/qcom/qdu1000.c b/drivers/interconnect/qcom/qdu1000.c
index bf800dd7d4ba..c504bf348294 100644
--- a/drivers/interconnect/qcom/qdu1000.c
+++ b/drivers/interconnect/qcom/qdu1000.c
@@ -769,6 +769,7 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = ACV_RSC_APPS,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };

-- 
2.41.0

