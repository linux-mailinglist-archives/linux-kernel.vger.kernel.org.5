Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F51D77902F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjHKNEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjHKNE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:04:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8B1270C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:29 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe11652b64so3097429e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691759067; x=1692363867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NI7xsxADN+tiagvuWJJS/HrsFGFTYic5TRr7IrT9Lts=;
        b=kK7zqYmveC4/F6GzdCRMTvwwI7Z+qq37ZqzegHwhkIkMDIDEeEcpy0M7cfYTfYFAnt
         5ADDYLZ7O1kldPDiHafv8Y/Bq29I4QeudBWnLm9JT3wPTan/Z8SyEPkhInLvDRjy/Piz
         34fTfopKfWPEytfUuWbgYLH+ehoTaFyQMzVhOifb4wh9Jn9SzQfwZ4kXLjNryUY1HtWL
         HJOjnUNsQq5SG2rEPxGn81hchOvHvxWXm2h3+PoOde41OxNGoeESvUK8wMT9f4EQ9Fft
         RCKvEGk92zJcRbi96H5USlIZQ2v5RutHFokCb2OuX/4Q0KqQPM0EKXnCAuo2HYoUo+ol
         dK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759067; x=1692363867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NI7xsxADN+tiagvuWJJS/HrsFGFTYic5TRr7IrT9Lts=;
        b=b7j2i4IIolygMkZ9bMLCNg4nH1G0ZYlWC82xywhZNZGdHAn9c43lmQZ/KButmZyt6U
         nQcoXsBrS1TydoCUu3OLpxLk3HMhq7RuKGbGwWLH7QQ/kvqzcljJDk+0hT5CWmBYOsxF
         jKS139XEm4n9DsSdknalgheF1unnZEA7uGkYStJzlP4LGvAVHkioMmX1uZoJLFZAoZbk
         2F5jyQPH3xv6d5GGmT6KslODs1u5aOxq+v2R4ibbBx59ifFz/DTSh5VwVWe4yXK4PvPN
         fxHHFXZI/Cf2KisKHm+wPDeiMClZtzWtAfZOVqYLftRRcFRDmOqu5ei1aFhaZEpnnLH8
         Scbw==
X-Gm-Message-State: AOJu0YxnR2NIRYzOaKlAu8d7SAc3mOhMOe9MUxeznod9q9r477idnMfm
        8gC7esTGqEAmK0F2HxNNm2ePgoyGsMlZy3U38fY=
X-Google-Smtp-Source: AGHT+IF98ZpfIt95asSE62f1gH+0TVQxl+8vQdLLSCLxGGc5Te9skqMxnCJp5VazxuXBPu2DD+YF1Q==
X-Received: by 2002:a05:6512:983:b0:4fd:fedc:2ce5 with SMTP id w3-20020a056512098300b004fdfedc2ce5mr1179356lft.36.1691759067226;
        Fri, 11 Aug 2023 06:04:27 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id v20-20020a197414000000b004fe15a2f0f6sm722491lfe.62.2023.08.11.06.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:04:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 15:04:14 +0200
Subject: [PATCH 07/11] interconnect: qcom: sdm845: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v1-7-a85b6e94f46d@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691759050; l=752;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JWVhioSYHwXPp2cAmpa7AfLQ5YTWzjEJxc1utUfZzA4=;
 b=mqN3ewKHEM0r3ZzuOvBnLRG7RFWiRSwKBZsKa6T+cqIw7TNu0LGA7JT6I8ti1rtidxH0Vne5+
 LCom2TJAZlIDmD3piAI5AtxiafmuUXzpwMXoiaLGJgPLlz7fCxRc0p1
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACV expects an enable_mask corresponding to the APPS RSC, fill it in.

Fixes: b5d2f741077a ("interconnect: qcom: Add sdm845 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index b9243c0aa626..8bd65df3aa86 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -1265,6 +1265,7 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = ACV_RSC_APPS,
 	.keepalive = false,
 	.num_nodes = 1,
 	.nodes = { &ebi },

-- 
2.41.0

