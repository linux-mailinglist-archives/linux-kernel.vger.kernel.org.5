Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6DE788CC2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343994AbjHYPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343933AbjHYPit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:38:49 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E701A26A5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5009d4a4897so1617181e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692977918; x=1693582718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJY9igvv29s/2ZAufEy7n6/wB5s/2TDnBd7ycBc9ECA=;
        b=M1fIp6tUYMwcgIdgVQ/9NtMrqbPki3FKGT66kq83HlqNZT7yDF4qvM5W/auZgzwrJq
         XMSw+k+eEny3oNGB53VUrp10iXIn8HqaNsRDrPlGM3mGiL/x92RRFQCQvf78MjuvIhOX
         91tvzsuGTz+/oKe8gzs5PgGxWD+I6Sq29NZ+UIbTRObZwoOwHsoiQoa4D2GpkCwcZa3F
         W28Lju+8mOPdHfMOMI0CXGxILOEhCjZ/EG0bCghoMv3bZvDUG8O0QlF0O0UXkRg6Dq2y
         JrhkiWT0HGTFNkz0GINg80ppi2ME1p9B+Gi9Q8CEy1jilGfXHrGQroY6AkuwLY9MgTYc
         QjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977918; x=1693582718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJY9igvv29s/2ZAufEy7n6/wB5s/2TDnBd7ycBc9ECA=;
        b=ZBaSZYoBR7G0jbOaLMD6KaR6gwzYMM6NhGKhRqlmIvpbm354yinqKbmdPIY88kEh+M
         Htz6snTIQpaYMCmK4pxxo/PVYF2Y4NAq1ulKhJCEsUUN5ixnWZaud7w4YbMv1d7ii+zs
         6B/9+tiQobxmprPFiB5yZCdxWo77xvJdzf3DVGc+63sDwxuIegxA2gB1awxXhW+l4Ka6
         MxliuZqGneJaX+przTMQS7v+xKP7C8i01SnriZICyU3x5PSfdGtGtUdtZ3tSDMPM51t8
         dV93Ir+f6YG62jFAprhVGcb1CW7GZ8xq6nPHwIfq9JggO5w/pxPxQ2iUpfKxf6dVveKs
         W3ug==
X-Gm-Message-State: AOJu0YxqAuYOdpVtvPblxBb6z06er8XT2jkE2uuz5YW182Cd8/2hLy1V
        3jZAqlINw0shzLdkwxOeLfayqg==
X-Google-Smtp-Source: AGHT+IHWFphSWAlFFuMyw/5UzF7Se2TZEW85zEnhmjsNx4dreiQuZ9JdDWT7CKvB/misba8Rh2T0Kw==
X-Received: by 2002:a05:6512:532:b0:4f8:ff52:93b7 with SMTP id o18-20020a056512053200b004f8ff5293b7mr13864840lfc.30.1692977918323;
        Fri, 25 Aug 2023 08:38:38 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b004fe432108absm326002lfe.182.2023.08.25.08.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:38:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 25 Aug 2023 17:38:32 +0200
Subject: [PATCH v4 10/10] clk: qcom: smd-rpm: Move CPUSS_GNoC clock to
 interconnect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v4-10-c04b60caa467@linaro.org>
References: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692977905; l=1855;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1hMkhZWxur5L+rhPpwUgnrX9/5Tg532/CoJi6zLeNH8=;
 b=MB0amdZ8IojDpftW0N18+PFf6RGXezelKkXI5Q5AX1tFcS/pZP5a10Kr/yyb3xJzwMECMk/NT
 VYSL59tDDYVApm86CxFYG76N36i9tt8xTTFgK7mSlLUyjPe6Vrtkwh2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it turns out, it's yet another interconnect bus clock. Move it
there. See [1] for reference.

[1] https://android.googlesource.com/kernel/msm-extra/devicetree/+/02f8c342b23c20a5cf967df649814be37a08227c%5E%21/#F0
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/clk-smd-rpm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 0191fc0dd7da..8602c02047d0 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -574,6 +574,16 @@ static const struct clk_smd_rpm *sm_qnoc_icc_clks[] = {
 	&clk_smd_rpm_bus_2_snoc_clk,
 };
 
+static const struct clk_smd_rpm *qcm2290_icc_clks[] = {
+	&clk_smd_rpm_bimc_clk,
+	&clk_smd_rpm_bus_1_cnoc_clk,
+	&clk_smd_rpm_mmnrt_clk,
+	&clk_smd_rpm_mmrt_clk,
+	&clk_smd_rpm_qup_clk,
+	&clk_smd_rpm_bus_2_snoc_clk,
+	&clk_smd_rpm_cpuss_gnoc_clk,
+};
+
 static struct clk_smd_rpm *msm8909_clks[] = {
 	[RPM_SMD_QPIC_CLK]		= &clk_smd_rpm_qpic_clk,
 	[RPM_SMD_QPIC_CLK_A]		= &clk_smd_rpm_qpic_a_clk,
@@ -1189,15 +1199,13 @@ static struct clk_smd_rpm *qcm2290_clks[] = {
 	[RPM_SMD_PKA_A_CLK] = &clk_smd_rpm_pka_a_clk,
 	[RPM_SMD_BIMC_GPU_CLK] = &clk_smd_rpm_bimc_gpu_clk,
 	[RPM_SMD_BIMC_GPU_A_CLK] = &clk_smd_rpm_bimc_gpu_a_clk,
-	[RPM_SMD_CPUSS_GNOC_CLK] = &clk_smd_rpm_cpuss_gnoc_clk,
-	[RPM_SMD_CPUSS_GNOC_A_CLK] = &clk_smd_rpm_cpuss_gnoc_a_clk,
 };
 
 static const struct rpm_smd_clk_desc rpm_clk_qcm2290 = {
 	.clks = qcm2290_clks,
 	.num_clks = ARRAY_SIZE(qcm2290_clks),
-	.icc_clks = sm_qnoc_icc_clks,
-	.num_icc_clks = ARRAY_SIZE(sm_qnoc_icc_clks)
+	.icc_clks = qcm2290_icc_clks,
+	.num_icc_clks = ARRAY_SIZE(qcm2290_icc_clks)
 };
 
 static const struct of_device_id rpm_smd_clk_match_table[] = {

-- 
2.42.0

