Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C536779B39
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbjHKXVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHKXVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:21:00 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973961704
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:20:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so39676761fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691796055; x=1692400855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ze1t2TaU2/Zq6VAB/piXFhhZjmjyCZkfu2nGzj+/Ok8=;
        b=TCidr8B6+swhVByaPQw/NNsIae6HoD9a6HM3lOnP3JEkOyS+P0s4l8U79JpaBDrtVl
         KFRKBFebPoT2wRgSATp8+xHTwJpEe+9DfMhaAvoavNweJ+bKn4MIAWxnqEqyOeilWQiN
         +/2WZf1wh7mxUv5srEWW5rFcCR/4ZhyNaVFigaN2sGolFAQdrlKa3P64GbEMdQvSByen
         lkj4T1ZJM3Bu3JHGMV7BYyUSqJini0JSi3bvzJVEsf5tF+okjBdGVNcJJ9+KYKXROy05
         mOgv7rq3fyTlKxeN4JCVknbqN0pSGor63AB4KKmCppQjTOeTyO+eN0bao8Dz83J2kugK
         A0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796055; x=1692400855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ze1t2TaU2/Zq6VAB/piXFhhZjmjyCZkfu2nGzj+/Ok8=;
        b=AMm9z8kHkjqZ1xb3Zn7MiD3Fw4aCDn/Xy79LcLeGd4KOX1+5uvIw9wmt1R/8CIKQwi
         w+UD4JbDVgVadkzVa9zZVkQWSbcAzGl6VKnkGGqZBS9SiadmSYmyKiT6IMWV94lnXAHy
         DMePlFZbVKdipKCCgZGV+we9tfGAS/ub89dwcEtGcGYi4VR7DepDpJB5OsRl3TqEWnpJ
         RjzywQv68iYtmpLEY/Tr/Ee2N43m4FnKN0paUZYyd8QoO7i3zvZDO6A5PhxDcyJH0Cq2
         CsBVftkLLMNd4UEE9i3mRVGxUS8Nw/9bAB2/vWBr+ljLzUfygroZYqkgX9KznS5h6rLx
         4qbg==
X-Gm-Message-State: AOJu0YzBXyzs2NcO0Nu3bwQru9cZlhS5i+1NPNUDDJF9CrWj44wtiUih
        PO8lCCrjHLXrbHobzs3vi9ow4g==
X-Google-Smtp-Source: AGHT+IHcAZxcAjPRZpfTt19J2Itgfw5LwHH0H2bmO85XoEqziK7La2ms3bzUxsfrQIRmZh1LlGN1MQ==
X-Received: by 2002:a2e:9d85:0:b0:2b9:c644:414a with SMTP id c5-20020a2e9d85000000b002b9c644414amr2574717ljj.46.1691796054937;
        Fri, 11 Aug 2023 16:20:54 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id z26-20020a2e965a000000b002b9ea00a7bbsm1038210ljh.60.2023.08.11.16.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:20:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 12 Aug 2023 01:20:47 +0200
Subject: [PATCH v2 04/11] interconnect: qcom: sc8180x: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v2-4-765ad70e539a@linaro.org>
References: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
In-Reply-To: <20230811-topic-acv-v2-0-765ad70e539a@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691796047; l=718;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=HRtCg9dDu0suN4fTNE/Znr656MINtyBdyGTWDrBj/BI=;
 b=bpFl5965jNpBUdjWcnvsKsBc/OpjYdmGeeWxrxgs4Yu4hgCwrgsvO7lQU/rpxD+BY6zzZ8j0t
 qh78TzoPunaDzpSMZnzCAfjwd8EbqVArGBXBFaP/i2XlZitPMoORZw3
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

Fixes: 9c8c6bac1ae8 ("interconnect: qcom: Add SC8180x providers")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sc8180x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sc8180x.c b/drivers/interconnect/qcom/sc8180x.c
index 0fb4898dabcf..bdd3471d4ac8 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -1345,6 +1345,7 @@ static struct qcom_icc_node slv_qup_core_2 = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = BIT(3),
 	.num_nodes = 1,
 	.nodes = { &slv_ebi }
 };

-- 
2.41.0

