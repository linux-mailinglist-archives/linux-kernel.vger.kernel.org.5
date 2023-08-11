Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7052477902D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjHKNEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbjHKNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:04:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E2430D7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so3151359e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691759063; x=1692363863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIETjFE+YORk91Sd+FK8yX6Tnsoz0FQHlLS1cvn3BDI=;
        b=vqvuT/HZtSDGmvlcOtUNXvE1OiR+3cFlTNIXHJxK8WdVrThvsdM44pj9mmGBysk89N
         3a+55NiZ8aFWXPmB+01naClZtnm7AC5mBuYs3ro8cp+4GU6t7jwEPnRnmYo7oIhiNlKe
         8xXSDDvcjISfWzey4qRC3QJDw5lqysa3vqbtnzbc+462dl+55UlBLIE7BjbodvLFhUtI
         Fx5cfTyOUGP5vZ/VRalGdMjVHVzUHg0TPKouIqmOisnQ8f+NzsWKlKTHdAD7G+Ry9UIP
         SR7HHzVGdztplFiIorxNmUVYZX5TedVMBzpfM82ZVMlYiUYf/c2AKX/7kO3N0jq9F+zK
         2y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759063; x=1692363863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIETjFE+YORk91Sd+FK8yX6Tnsoz0FQHlLS1cvn3BDI=;
        b=WrvBiyjjqhFtVmSh4aEWQwbCCLaMI5mg/JSMelPGcYqnoP2pZQczRmF4Cdf6V12ZZF
         M3j2ZcMeD2FWdB2Gw/dl+uTvGKBli7CWG+/cq0Dh6Vbs2gzKjzD9fkb59/q1j6QHrL3H
         w5oiLcMrq5zdtugLf8cIC0S0al64T1RxKCGWwXkeKpSUJR5eRK5SFFEEKHUuHwdaW6PO
         zOS+WwsZsvawdGLuG3wis86uPo66rhK/V/TKZuTM/2qOLQI7m7fQnrgwhKBsAohmD0DM
         rJWstS08bRYqlp6XE9yhy3q9N4KSn2C1O8qZwFV68eeqlCrsjjzaVv4rVsYXEZ0lhSN1
         Gbjw==
X-Gm-Message-State: AOJu0Yy0OIFTY4p9gxJ0pich3oSdMurVGQ22RBtETfnflJSwRNjZhArN
        yLmBkkJORC361sf1CPAfTf1ut8wXbucW3DKfmU8=
X-Google-Smtp-Source: AGHT+IENexpC4So5+ASxmdhQdyUVzfJHbpRBDMuOrNaJaENY+lbJKH028kpskHvvgIQNdj+I4OXthw==
X-Received: by 2002:a19:650f:0:b0:4fb:897e:21cc with SMTP id z15-20020a19650f000000b004fb897e21ccmr1236897lfb.67.1691759063319;
        Fri, 11 Aug 2023 06:04:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id v20-20020a197414000000b004fe15a2f0f6sm722491lfe.62.2023.08.11.06.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:04:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 15:04:12 +0200
Subject: [PATCH 05/11] interconnect: qcom: sc8280xp: Set ACV enable_mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-acv-v1-5-a85b6e94f46d@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691759050; l=734;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hAS5ZiZPJ7dfWWLTn2/3P6QwpmscNBYEDN+t0XN5dwg=;
 b=935vCxAyYFwUuxcgLgw4wAj1pfzKXnlfByuA07wOthIOskiXNLmfGpUiR7enKw5hasulIyic0
 a1pbDOZSd4UDCeVtTiEKpUFHNUqqWIiosozk7nsSAcBwGDJ/GTzAaIH
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

Fixes: f29dabda7917 ("interconnect: qcom: Add SC8280XP interconnect provider")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sc8280xp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index b82c5493cbb5..141101c1bb44 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -1712,6 +1712,7 @@ static struct qcom_icc_node srvc_snoc = {
 
 static struct qcom_icc_bcm bcm_acv = {
 	.name = "ACV",
+	.enable_mask = ACV_RSC_APPS,
 	.num_nodes = 1,
 	.nodes = { &ebi },
 };

-- 
2.41.0

