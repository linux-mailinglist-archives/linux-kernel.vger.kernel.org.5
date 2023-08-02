Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68A476CCFC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjHBMi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjHBMig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:38:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24D52D68
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:38:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so106514071fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690979907; x=1691584707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7foxAvTJNjxpzEzinqawhuOf8tl6MaxX0nC0Wnx2ikg=;
        b=DyBfrGhBAsiIZdO7TJN93/vtpKO4LaRGlAv16qGMa8VqcN3ltSc8bnr+G59OPKexX1
         LG9E0K1FaTpy/ie/7lHW0c2LyYFY+UMWN+ToyyOPVYQRaf9IY9r5iRG7fuv2GU0SfVcN
         KTp1uKmROwLb7tGNcGuy7WPxUDAT1Y7Ml2m4lHA8CegJopXAgMhthh6UF7RI21w3/9m8
         3i0vH82+pmDlFto4t+U8+fPBGNyCvLVVrML3Di1c3YX34qRR84jeKLsM9VbzWxviCIZ7
         61YMDE1EJtgmF5mwSNLi0se/erX7XWGcwdMnPxVRqYx4PZWDZSOUlD/mxM9k9dZFIAqU
         4LlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690979907; x=1691584707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7foxAvTJNjxpzEzinqawhuOf8tl6MaxX0nC0Wnx2ikg=;
        b=NKDQkFWLyFNPXVfIy/k6DPbWtVy/ThI4Iv6p1Nw5uqveAf/yT+ntp9uUHWHjTYWCkF
         1LrZYj7qQ27DB9TpPtyk9xMZmlJgCjK/1MDvhCbuXepJguOZRnYrkrpG4oKA+MqMlr0P
         8g25MhRFSn9KtRkjaepGWX5N9tbM5wTVfnmfdrfeI1DMQgQGnJu9dXrNXivjc+u1yBZm
         opdQ7nMwmu9yJEVM0YvMJG+iltC62Vj04o2WItceBlmm6uq+PKJeWAw9G+h5nBR0WQtO
         OHKZG26jRcVPZ5a/Tke/cTAJ0FRZvsH+BNjbFqc7oo3otlgcXPkYw4P+MySofiZNHgJP
         rWIw==
X-Gm-Message-State: ABy/qLaHZ++aL6uzIU2eLhS0LphUTjtF948y/GFu6IGFBhWc1l0BMtcH
        GRA+4IDCTWn8DBXFQjC5ov508w==
X-Google-Smtp-Source: APBJJlG+3X4+auOVzEcNE0Cn8nt2k7EAORrey5jm4Y8eQvSJIel5w4MeBykWcSYCLKeZEuPSf9oLoA==
X-Received: by 2002:a2e:9903:0:b0:2b9:b904:74d7 with SMTP id v3-20020a2e9903000000b002b9b90474d7mr5078871lji.18.1690979906812;
        Wed, 02 Aug 2023 05:38:26 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id h8-20020a2e9ec8000000b002b9e5fe86dasm1897050ljk.81.2023.08.02.05.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:38:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 02 Aug 2023 14:37:46 +0200
Subject: [PATCH v13 06/10] soc: qcom: cpr-common: Add support for flat fuse
 adjustment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v13-6-d01cff1c54cf@linaro.org>
References: <20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690979891; l=2102;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=/XcIm6aoB0M2m9RzHO8vr3y3r5RlnUHq0kq7ECIZUN0=;
 b=05407jLR9+kDlBp3QnNsjeFHTBJWo5qa2ankRUPVRlSZhnrlXf9N5TAkr4Odf0Kj/Xo6UWflS
 seOIpoabXUHDDUVJx8f/HxRMvUwP62kU1wqBCfbDbjUD10GtKJCha77
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

CPR3 makes use of post-calculation flat value adjustments. Add the
necessary bits to the common functions to support it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: separate this patch out of a bigger one]
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/genpd/qcom/cpr-common.c | 9 ++++++---
 drivers/genpd/qcom/cpr-common.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/genpd/qcom/cpr-common.c b/drivers/genpd/qcom/cpr-common.c
index ea85f6b4bef8..44c681bbbf13 100644
--- a/drivers/genpd/qcom/cpr-common.c
+++ b/drivers/genpd/qcom/cpr-common.c
@@ -49,7 +49,7 @@ int cpr_populate_ring_osc_idx(struct device *dev,
 EXPORT_SYMBOL_GPL(cpr_populate_ring_osc_idx);
 
 static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
-			    int step_volt, const char *init_v_efuse,
+			    int adj, int step_volt, const char *init_v_efuse,
 			    struct device *dev)
 {
 	int steps, uV;
@@ -67,6 +67,9 @@ static int cpr_read_fuse_uV(int init_v_width, int step_size_uV, int ref_uV,
 
 	uV = ref_uV + steps * step_size_uV;
 
+	/* Apply open-loop fixed adjustments to fused values */
+	uV += adj;
+
 	return DIV_ROUND_UP(uV, step_volt) * step_volt;
 }
 
@@ -119,8 +122,8 @@ int cpr_populate_fuse_common(struct device *dev,
 
 	/* Populate uV */
 	uV = cpr_read_fuse_uV(init_v_width, init_v_step,
-			      fdata->ref_uV, step_volt,
-			      cpr_fuse->init_voltage, dev);
+			      fdata->ref_uV, fdata->volt_oloop_adjust,
+			      step_volt, cpr_fuse->init_voltage, dev);
 	if (uV < 0)
 		return uV;
 
diff --git a/drivers/genpd/qcom/cpr-common.h b/drivers/genpd/qcom/cpr-common.h
index 1f2ebf9394cf..0aa227617d2f 100644
--- a/drivers/genpd/qcom/cpr-common.h
+++ b/drivers/genpd/qcom/cpr-common.h
@@ -22,6 +22,7 @@ struct fuse_corner_data {
 	int ref_uV;
 	int max_uV;
 	int min_uV;
+	int volt_oloop_adjust;
 	int max_volt_scale;
 	int max_quot_scale;
 	/* fuse quot */

-- 
2.41.0

