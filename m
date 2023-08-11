Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B6A779019
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjHKNEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbjHKNEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:04:23 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E2B30D6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso3227881e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691759061; x=1692363861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzUrj2LkXobJFg5OuLlMFJ3XH/1Psa0W4FGun30sHA4=;
        b=BvaTql7c9EdKSCM3K5FY7onS4s80o2E2hC1HnTjhCcbGSJS5iOxcRknR6e6y9MQhP8
         xcA21HVjoJQMvSt1XhTdRwjsvNgQ+NMLYTKfaQDLKOLG5oC3LX4/WpiAQhSiyQc/gP4O
         M2dvUnXg+4NPbaDUSv7wJ9BzSnHrselWP81UZctxY9q+r0LAep0I3c30ydvq0+kaDiuj
         bmQs24Ovv+2D2s8a+AAWywHN3LjjSO5zdt0qv/eGHEPwyJYL4n1NSSPcdQW/cYY1bceI
         785wCShvd1cGxeMcOLiCKLYCTaoXARJOxd9HlXYyGnDTJsp2iiiJ0fHR0SRa/1kUiEsO
         AixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759061; x=1692363861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzUrj2LkXobJFg5OuLlMFJ3XH/1Psa0W4FGun30sHA4=;
        b=RCbeg7Un409MKCbUoMASKhClyM6j+OILIYXYcD33uxPDgTbwGPmYxsqBZ8lIvw/sxC
         P/Qo3QBCjVuvc4rGYlqHb9/UBjPLA614pAh4FR9+o6c04TJlsBVaEF+uc+nyUh/K0Baw
         ZYVy/UKg78X6URWyax241tCD8+yWeiTu+uE6Seg66GvUkSzgoJIFI1HFEg1ibYWPN40+
         4+8xg66/igJA4iimFOYtvgoVQLEgYAOBC/Bz6Bv6htVDlkI4EvQg3UbCQ9NvBRD/iXKK
         wpAVJBPuyPL2/sQATp/uKh7goiHt7XRW/CbZrMTNnlGWSTMbqL/uSoW9AloWUr1pj90q
         iBJQ==
X-Gm-Message-State: AOJu0Yz60nsmpyYSLoUP+C7a5oVwD47FQPqZVw/YtfwGSoTUIeHao359
        YoSkX/cJ9OiP7dMT96GpgLttt0xkUiKxgGfKHHk=
X-Google-Smtp-Source: AGHT+IGeUqlyEyypBaj4HAvJV8SB4dQiU3SzGrekTnnouY2G8nplcTcC9/eXoHh4xn9phlenMm4ZSA==
X-Received: by 2002:ac2:4896:0:b0:4fb:bef0:948e with SMTP id x22-20020ac24896000000b004fbbef0948emr1226728lfc.5.1691759061245;
        Fri, 11 Aug 2023 06:04:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id v20-20020a197414000000b004fe15a2f0f6sm722491lfe.62.2023.08.11.06.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:04:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 15:04:11 +0200
Subject: [PATCH 04/11] interconnect: qcom: sc8180x: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v1-4-a85b6e94f46d@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691759050; l=724;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=j/9WH0FZIh4+IrqqeD1fDhbVxzmI74+9b2EBikA59zQ=;
 b=JIXkRs0NCNgDgcCKM2tbMRPQZ/rKf/4k2NNTEAmqPAuY9c1jxCF7GtQBMWhtIEQQ3Os2zihZU
 cvu4JVNFE9WBBv3R4BCZXxfbQnvlTT0reeWWBtuwTP6WAuSui5I+xv/
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
index 0fb4898dabcf..7d92ef960e7d 100644
--- a/drivers/interconnect/qcom/sc8180x.c
+++ b/drivers/interconnect/qcom/sc8180x.c
@@ -1345,6 +1345,7 @@ static struct qcom_icc_node slv_qup_core_2 = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = ACV_RSC_APPS,
 	.num_nodes = 1,
 	.nodes = { &slv_ebi }
 };

-- 
2.41.0

