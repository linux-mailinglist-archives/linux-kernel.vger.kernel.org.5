Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC16C779B1E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbjHKXQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjHKXQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:16:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA21718
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:16:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe0c566788so3914884e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691795781; x=1692400581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czw8itWeaD9VouL3BdJnjgMtHFcsN8021NNdf8QkGZ0=;
        b=bxivqnRMY7Sdkr94n5F/Px3mN3lKykrZetZCwiqpmT8px96/eATphvq+hWbDzMMUl8
         9FWKvSrtnqj1iyBjSq0s588zZXDIyp+zq+Vtu3gjHaFQmwsnO2FWli/40X+lk4CL6KEE
         oSWPwAxzEcavH7rLGjW/6HDD/F17zcfrvs30AnepJpPUUIuJLqhgAP2Wx7UvpoxBWKOW
         hgBIEJmTvV2/14wWRnobDvt2cJgdSjapGuqR14zWhJTCoRhZA67QtK8OeTtfbKQNZftX
         P4g0AoG6mKARBLBeR+B9rC1yqtjfEEcz9An6kT7fe1D9yi8WMFKi37mHVFLRac8udreF
         Ra4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691795781; x=1692400581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czw8itWeaD9VouL3BdJnjgMtHFcsN8021NNdf8QkGZ0=;
        b=MBtiai/XtkSN+wd/t3TuU+S2jKojZDGnhNsPdvnf1EPM1RaP1B6PyrJ9uKRPpvWt8h
         uhUquDVuEtU+DQE8Ahog9lwp38fVl2mZ+HWDiy7GeKf+HzQd+MX8Rn4rcw2KyzMLDj2U
         xxztIlbW6CzwW5k1zKV2YNSMd3T5UxRy8HlgKxTGPbxhSfevVvJASgoBIAZplP0yKWPe
         Lbrz1UJ1s7AqPGrC7hP90Tqq7xl56Nj1LbtKKrYL0ehJc3xhE7NbbXjk19Z3o1PlqVUd
         Dm3Pr3n/WG3JzLfuwgMKASylFt0o9z1DNiWD0HukOOOOWI0gXQ/h6cleocDJZZIJ4MAJ
         YA9A==
X-Gm-Message-State: AOJu0YykmvLwlQysyeSaO4VJDupDpEFgISf9qazRW7+v+7JwbQe/6gPF
        8go/95Y0683Vunbmri94gWXalg==
X-Google-Smtp-Source: AGHT+IFC0RfJs+jy5tG9FdZA6p1sWmCHtVavUaRElhKoUqQtGcJ6LzumYfbu7KmdkrhRXjykxEpXGQ==
X-Received: by 2002:a05:6512:2315:b0:4fd:fef7:95a5 with SMTP id o21-20020a056512231500b004fdfef795a5mr2782946lfu.11.1691795781383;
        Fri, 11 Aug 2023 16:16:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m16-20020a195210000000b004fe48332852sm884773lfb.136.2023.08.11.16.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:16:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 12 Aug 2023 01:16:16 +0200
Subject: [PATCH v2 2/2] interconnect: qcom: bcm-voter: Use enable_maks for
 keepalive voting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_fix_1he-v2-2-0620af8ac133@linaro.org>
References: <20230811-topic-icc_fix_1he-v2-0-0620af8ac133@linaro.org>
In-Reply-To: <20230811-topic-icc_fix_1he-v2-0-0620af8ac133@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691795777; l=1366;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9+dhJntssIo8yKCa0lMm05/Qxhg0nhjKsOE59k2uJ5g=;
 b=9Vg8m5lBfUabDMntbvIW95/q5rc6Ri8b0OPHS+v5ebQyY+Oc2oOcbZ+pyrBBtktQslHwm1Caw
 QZdPS83XTl9BbSNqi2BF+uey/N9R0FlXEHosB4zOljW4OtilqNJycXI
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCMs with an enable_mask expect to only have that specific value written
to them. The current implementation only works by miracle for BCMs with
enable mask == BIT(0), as the minimal vote we've been using so far just
so happens to be equal to that.

Use the correct value with keepalive voting.

Fixes: d8630f050d3f ("interconnect: qcom: Add support for mask-based BCMs")
Reported-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index d857eb8838b9..a2d437a05a11 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -81,10 +81,10 @@ static void bcm_aggregate_mask(struct qcom_icc_bcm *bcm)
 	}
 
 	if (bcm->keepalive) {
-		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
-		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
-		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
-		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
+		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
+		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
+		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
+		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
 	}
 }
 

-- 
2.41.0

