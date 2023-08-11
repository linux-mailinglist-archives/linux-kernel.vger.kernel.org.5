Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E272A778F22
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjHKMP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjHKMPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:15:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B602D79
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:39 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9c0391749so30898471fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691756137; x=1692360937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2D7Me4mB6W2xjUaAJP+BrF8IAn/6v53/VmwfTaw5NKY=;
        b=uMSNH9lnOEN2TM1/W8eO5V03NSWp+p0kmzOgvZmvURjNuzw2PIz1QTL7ywhVoMGhLI
         IohU8fKQFYxTQGk8RlqM/rg2eAX24HgqU3+4T1kD6g9/zsjPIYRFKsiclLHEglb9EWiF
         odh4IXjUiUX5JXA3oshQeMrgVV6c7pekfkfahmoz8UI+IeeCgdvCwIEwL0CYTy5ploJS
         FhB9jJLaXMovdU+WcVJ4DVnUptChSm1prinLXY4VELaRQeLnhdeHmspl9ZmoS1cG+jMu
         CcBccs29KcpMbKp7NRULCqnJMbCvGyy46GYABj/G4zGRBYGoVPLWhSxOpIkILqd4VWnp
         j3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756137; x=1692360937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2D7Me4mB6W2xjUaAJP+BrF8IAn/6v53/VmwfTaw5NKY=;
        b=F93MbX0HU4Lq4SEhH/KOWYXf2Nb7hjMJMAK5lJCC2OaNi/3FgBayH7nrn2b3XK7Gij
         idRXO72hPXGvfwA91HUAFOHj0YizIidoXZ8UJLNv9BtJjnpF2IeCOTaUygP7a6YAWSO/
         Jvz60fc/ZJ1bhiP7etqGbM18snkRnkhOPBJkguktc0IaD1vv9sDCViakm9CsJtKkjCai
         J20EUYvtrKwLc/P7NURql5DD9gD2efTvq5G/vrTqdEZvqJxBaJSdnDSke7Hal8DP+xPu
         VsZtREhnDu9D5vRznU03T/J+JJcRVU9TM3zoQqAACHzEswWFaZwPe2QR4dz1kQPae+Yo
         5HQw==
X-Gm-Message-State: AOJu0Yyf0zVI1BzuiwwM7E12uFxhfn7vd+KmZfvDwdpb0Mbqxxmx/fSu
        JN0WBBaQoMA6+lg1iVRVYjmV0Q==
X-Google-Smtp-Source: AGHT+IE0XMkCJyeRF9PYXOhlXzH+1dJQbkEbKTa2/xsUDyDgKypjzoxm1IaJNgR7M1aXUbiSYWdZmg==
X-Received: by 2002:a2e:9d18:0:b0:2b8:4100:b565 with SMTP id t24-20020a2e9d18000000b002b84100b565mr1493911lji.15.1691756137420;
        Fri, 11 Aug 2023 05:15:37 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id m12-20020a2e870c000000b002b9ec22d9fasm848487lji.29.2023.08.11.05.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:15:37 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 14:15:19 +0200
Subject: [PATCH 08/20] interconnect: qcom: sm8250: Retire DEFINE_QNODE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-icc_retire_macrosd-v1-8-c03aaeffc769@linaro.org>
References: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
In-Reply-To: <20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691756124; l=45391;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gSoXP3It0NHeRuwN1fRxmdGoT40ppVhuDfPSCCtDADA=;
 b=Yr3r0nRp1U45k0y3VG/fTupolJQHc6IySZssWtRE8uXvo2ASMgeSRKd3PV2S/tlaTgO1v+vdQ
 Rw4UEH8srrQAj21x5k76IxNenO6BzQJaSXugjE0n1hkHs3q5pUqLmSz
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

The struct definition macros are hard to read and comapre, expand them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/sm8250.c | 1478 ++++++++++++++++++++++++++++++++----
 1 file changed, 1330 insertions(+), 148 deletions(-)

diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index b8d265f2c176..f218a7c1d7a6 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -16,154 +16,1336 @@
 #include "icc-rpmh.h"
 #include "sm8250.h"
 
-DEFINE_QNODE(qhm_a1noc_cfg, SM8250_MASTER_A1NOC_CFG, 1, 4, SM8250_SLAVE_SERVICE_A1NOC);
-DEFINE_QNODE(qhm_qspi, SM8250_MASTER_QSPI_0, 1, 4, SM8250_A1NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_qup1, SM8250_MASTER_QUP_1, 1, 4, SM8250_A1NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_qup2, SM8250_MASTER_QUP_2, 1, 4, SM8250_A1NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_tsif, SM8250_MASTER_TSIF, 1, 4, SM8250_A1NOC_SNOC_SLV);
-DEFINE_QNODE(xm_pcie3_modem, SM8250_MASTER_PCIE_2, 1, 8, SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1);
-DEFINE_QNODE(xm_sdc4, SM8250_MASTER_SDCC_4, 1, 8, SM8250_A1NOC_SNOC_SLV);
-DEFINE_QNODE(xm_ufs_mem, SM8250_MASTER_UFS_MEM, 1, 8, SM8250_A1NOC_SNOC_SLV);
-DEFINE_QNODE(xm_usb3_0, SM8250_MASTER_USB3, 1, 8, SM8250_A1NOC_SNOC_SLV);
-DEFINE_QNODE(xm_usb3_1, SM8250_MASTER_USB3_1, 1, 8, SM8250_A1NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_a2noc_cfg, SM8250_MASTER_A2NOC_CFG, 1, 4, SM8250_SLAVE_SERVICE_A2NOC);
-DEFINE_QNODE(qhm_qdss_bam, SM8250_MASTER_QDSS_BAM, 1, 4, SM8250_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qhm_qup0, SM8250_MASTER_QUP_0, 1, 4, SM8250_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qnm_cnoc, SM8250_MASTER_CNOC_A2NOC, 1, 8, SM8250_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qxm_crypto, SM8250_MASTER_CRYPTO_CORE_0, 1, 8, SM8250_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qxm_ipa, SM8250_MASTER_IPA, 1, 8, SM8250_A2NOC_SNOC_SLV);
-DEFINE_QNODE(xm_pcie3_0, SM8250_MASTER_PCIE, 1, 8, SM8250_SLAVE_ANOC_PCIE_GEM_NOC);
-DEFINE_QNODE(xm_pcie3_1, SM8250_MASTER_PCIE_1, 1, 8, SM8250_SLAVE_ANOC_PCIE_GEM_NOC);
-DEFINE_QNODE(xm_qdss_etr, SM8250_MASTER_QDSS_ETR, 1, 8, SM8250_A2NOC_SNOC_SLV);
-DEFINE_QNODE(xm_sdc2, SM8250_MASTER_SDCC_2, 1, 8, SM8250_A2NOC_SNOC_SLV);
-DEFINE_QNODE(xm_ufs_card, SM8250_MASTER_UFS_CARD, 1, 8, SM8250_A2NOC_SNOC_SLV);
-DEFINE_QNODE(qnm_npu, SM8250_MASTER_NPU, 2, 32, SM8250_SLAVE_CDSP_MEM_NOC);
-DEFINE_QNODE(qnm_snoc, SM8250_SNOC_CNOC_MAS, 1, 8, SM8250_SLAVE_CDSP_CFG, SM8250_SLAVE_CAMERA_CFG, SM8250_SLAVE_TLMM_SOUTH, SM8250_SLAVE_TLMM_NORTH, SM8250_SLAVE_SDCC_4, SM8250_SLAVE_TLMM_WEST, SM8250_SLAVE_SDCC_2, SM8250_SLAVE_CNOC_MNOC_CFG, SM8250_SLAVE_UFS_MEM_CFG, SM8250_SLAVE_SNOC_CFG, SM8250_SLAVE_PDM, SM8250_SLAVE_CX_RDPM, SM8250_SLAVE_PCIE_1_CFG, SM8250_SLAVE_A2NOC_CFG, SM8250_SLAVE_QDSS_CFG, SM8250_SLAVE_DISPLAY_CFG, SM8250_SLAVE_PCIE_2_CFG, SM8250_SLAVE_TCSR, SM8250_SLAVE_DCC_CFG, SM8250_SLAVE_CNOC_DDRSS, SM8250_SLAVE_IPC_ROUTER_CFG, SM8250_SLAVE_PCIE_0_CFG, SM8250_SLAVE_RBCPR_MMCX_CFG, SM8250_SLAVE_NPU_CFG, SM8250_SLAVE_AHB2PHY_SOUTH, SM8250_SLAVE_AHB2PHY_NORTH, SM8250_SLAVE_GRAPHICS_3D_CFG, SM8250_SLAVE_VENUS_CFG, SM8250_SLAVE_TSIF, SM8250_SLAVE_IPA_CFG, SM8250_SLAVE_IMEM_CFG, SM8250_SLAVE_USB3, SM8250_SLAVE_SERVICE_CNOC, SM8250_SLAVE_UFS_CARD_CFG, SM8250_SLAVE_USB3_1, SM8250_SLAVE_LPASS, SM8250_SLAVE_RBCPR_CX_CFG, SM8250_SLAVE_A1NOC_CFG, SM8250_SLAVE_AOSS, SM8250_SLAVE_
 PRNG, SM8250_SLAVE_VSENSE_CTRL_CFG, SM8250_SLAVE_QSPI_0, SM8250_SLAVE_CRYPTO_0_CFG, SM8250_SLAVE_PIMEM_CFG, SM8250_SLAVE_RBCPR_MX_CFG, SM8250_SLAVE_QUP_0, SM8250_SLAVE_QUP_1, SM8250_SLAVE_QUP_2, SM8250_SLAVE_CLK_CTL);
-DEFINE_QNODE(xm_qdss_dap, SM8250_MASTER_QDSS_DAP, 1, 8, SM8250_SLAVE_CDSP_CFG, SM8250_SLAVE_CAMERA_CFG, SM8250_SLAVE_TLMM_SOUTH, SM8250_SLAVE_TLMM_NORTH, SM8250_SLAVE_SDCC_4, SM8250_SLAVE_TLMM_WEST, SM8250_SLAVE_SDCC_2, SM8250_SLAVE_CNOC_MNOC_CFG, SM8250_SLAVE_UFS_MEM_CFG, SM8250_SLAVE_SNOC_CFG, SM8250_SLAVE_PDM, SM8250_SLAVE_CX_RDPM, SM8250_SLAVE_PCIE_1_CFG, SM8250_SLAVE_A2NOC_CFG, SM8250_SLAVE_QDSS_CFG, SM8250_SLAVE_DISPLAY_CFG, SM8250_SLAVE_PCIE_2_CFG, SM8250_SLAVE_TCSR, SM8250_SLAVE_DCC_CFG, SM8250_SLAVE_CNOC_DDRSS, SM8250_SLAVE_IPC_ROUTER_CFG, SM8250_SLAVE_CNOC_A2NOC, SM8250_SLAVE_PCIE_0_CFG, SM8250_SLAVE_RBCPR_MMCX_CFG, SM8250_SLAVE_NPU_CFG, SM8250_SLAVE_AHB2PHY_SOUTH, SM8250_SLAVE_AHB2PHY_NORTH, SM8250_SLAVE_GRAPHICS_3D_CFG, SM8250_SLAVE_VENUS_CFG, SM8250_SLAVE_TSIF, SM8250_SLAVE_IPA_CFG, SM8250_SLAVE_IMEM_CFG, SM8250_SLAVE_USB3, SM8250_SLAVE_SERVICE_CNOC, SM8250_SLAVE_UFS_CARD_CFG, SM8250_SLAVE_USB3_1, SM8250_SLAVE_LPASS, SM8250_SLAVE_RBCPR_CX_CFG, SM8250_SLAVE_A1NOC_CFG, SM
 8250_SLAVE_AOSS, SM8250_SLAVE_PRNG, SM8250_SLAVE_VSENSE_CTRL_CFG, SM8250_SLAVE_QSPI_0, SM8250_SLAVE_CRYPTO_0_CFG, SM8250_SLAVE_PIMEM_CFG, SM8250_SLAVE_RBCPR_MX_CFG, SM8250_SLAVE_QUP_0, SM8250_SLAVE_QUP_1, SM8250_SLAVE_QUP_2, SM8250_SLAVE_CLK_CTL);
-DEFINE_QNODE(qhm_cnoc_dc_noc, SM8250_MASTER_CNOC_DC_NOC, 1, 4, SM8250_SLAVE_GEM_NOC_CFG, SM8250_SLAVE_LLCC_CFG);
-DEFINE_QNODE(alm_gpu_tcu, SM8250_MASTER_GPU_TCU, 1, 8, SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(alm_sys_tcu, SM8250_MASTER_SYS_TCU, 1, 8, SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(chm_apps, SM8250_MASTER_AMPSS_M0, 2, 32, SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC, SM8250_SLAVE_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(qhm_gemnoc_cfg, SM8250_MASTER_GEM_NOC_CFG, 1, 4, SM8250_SLAVE_SERVICE_GEM_NOC_2, SM8250_SLAVE_SERVICE_GEM_NOC_1, SM8250_SLAVE_SERVICE_GEM_NOC);
-DEFINE_QNODE(qnm_cmpnoc, SM8250_MASTER_COMPUTE_NOC, 2, 32, SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qnm_gpu, SM8250_MASTER_GRAPHICS_3D, 2, 32, SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qnm_mnoc_hf, SM8250_MASTER_MNOC_HF_MEM_NOC, 2, 32, SM8250_SLAVE_LLCC);
-DEFINE_QNODE(qnm_mnoc_sf, SM8250_MASTER_MNOC_SF_MEM_NOC, 2, 32, SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qnm_pcie, SM8250_MASTER_ANOC_PCIE_GEM_NOC, 1, 16, SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC);
-DEFINE_QNODE(qnm_snoc_gc, SM8250_MASTER_SNOC_GC_MEM_NOC, 1, 8, SM8250_SLAVE_LLCC);
-DEFINE_QNODE(qnm_snoc_sf, SM8250_MASTER_SNOC_SF_MEM_NOC, 1, 16, SM8250_SLAVE_LLCC, SM8250_SLAVE_GEM_NOC_SNOC, SM8250_SLAVE_MEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(llcc_mc, SM8250_MASTER_LLCC, 4, 4, SM8250_SLAVE_EBI_CH0);
-DEFINE_QNODE(qhm_mnoc_cfg, SM8250_MASTER_CNOC_MNOC_CFG, 1, 4, SM8250_SLAVE_SERVICE_MNOC);
-DEFINE_QNODE(qnm_camnoc_hf, SM8250_MASTER_CAMNOC_HF, 2, 32, SM8250_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qnm_camnoc_icp, SM8250_MASTER_CAMNOC_ICP, 1, 8, SM8250_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qnm_camnoc_sf, SM8250_MASTER_CAMNOC_SF, 2, 32, SM8250_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qnm_video0, SM8250_MASTER_VIDEO_P0, 1, 32, SM8250_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qnm_video1, SM8250_MASTER_VIDEO_P1, 1, 32, SM8250_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qnm_video_cvp, SM8250_MASTER_VIDEO_PROC, 1, 32, SM8250_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp0, SM8250_MASTER_MDP_PORT0, 1, 32, SM8250_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_mdp1, SM8250_MASTER_MDP_PORT1, 1, 32, SM8250_SLAVE_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qxm_rot, SM8250_MASTER_ROTATOR, 1, 32, SM8250_SLAVE_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(amm_npu_sys, SM8250_MASTER_NPU_SYS, 4, 32, SM8250_SLAVE_NPU_COMPUTE_NOC);
-DEFINE_QNODE(amm_npu_sys_cdp_w, SM8250_MASTER_NPU_CDP, 2, 16, SM8250_SLAVE_NPU_COMPUTE_NOC);
-DEFINE_QNODE(qhm_cfg, SM8250_MASTER_NPU_NOC_CFG, 1, 4, SM8250_SLAVE_SERVICE_NPU_NOC, SM8250_SLAVE_ISENSE_CFG, SM8250_SLAVE_NPU_LLM_CFG, SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG, SM8250_SLAVE_NPU_CP, SM8250_SLAVE_NPU_TCM, SM8250_SLAVE_NPU_CAL_DP0, SM8250_SLAVE_NPU_CAL_DP1, SM8250_SLAVE_NPU_DPM);
-DEFINE_QNODE(qhm_snoc_cfg, SM8250_MASTER_SNOC_CFG, 1, 4, SM8250_SLAVE_SERVICE_SNOC);
-DEFINE_QNODE(qnm_aggre1_noc, SM8250_A1NOC_SNOC_MAS, 1, 16, SM8250_SLAVE_SNOC_GEM_NOC_SF);
-DEFINE_QNODE(qnm_aggre2_noc, SM8250_A2NOC_SNOC_MAS, 1, 16, SM8250_SLAVE_SNOC_GEM_NOC_SF);
-DEFINE_QNODE(qnm_gemnoc, SM8250_MASTER_GEM_NOC_SNOC, 1, 16, SM8250_SLAVE_PIMEM, SM8250_SLAVE_OCIMEM, SM8250_SLAVE_APPSS, SM8250_SNOC_CNOC_SLV, SM8250_SLAVE_TCU, SM8250_SLAVE_QDSS_STM);
-DEFINE_QNODE(qnm_gemnoc_pcie, SM8250_MASTER_GEM_NOC_PCIE_SNOC, 1, 8, SM8250_SLAVE_PCIE_2, SM8250_SLAVE_PCIE_0, SM8250_SLAVE_PCIE_1);
-DEFINE_QNODE(qxm_pimem, SM8250_MASTER_PIMEM, 1, 8, SM8250_SLAVE_SNOC_GEM_NOC_GC);
-DEFINE_QNODE(xm_gic, SM8250_MASTER_GIC, 1, 8, SM8250_SLAVE_SNOC_GEM_NOC_GC);
-DEFINE_QNODE(qns_a1noc_snoc, SM8250_A1NOC_SNOC_SLV, 1, 16, SM8250_A1NOC_SNOC_MAS);
-DEFINE_QNODE(qns_pcie_modem_mem_noc, SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1, 1, 16, SM8250_MASTER_ANOC_PCIE_GEM_NOC);
-DEFINE_QNODE(srvc_aggre1_noc, SM8250_SLAVE_SERVICE_A1NOC, 1, 4);
-DEFINE_QNODE(qns_a2noc_snoc, SM8250_A2NOC_SNOC_SLV, 1, 16, SM8250_A2NOC_SNOC_MAS);
-DEFINE_QNODE(qns_pcie_mem_noc, SM8250_SLAVE_ANOC_PCIE_GEM_NOC, 1, 16, SM8250_MASTER_ANOC_PCIE_GEM_NOC);
-DEFINE_QNODE(srvc_aggre2_noc, SM8250_SLAVE_SERVICE_A2NOC, 1, 4);
-DEFINE_QNODE(qns_cdsp_mem_noc, SM8250_SLAVE_CDSP_MEM_NOC, 2, 32, SM8250_MASTER_COMPUTE_NOC);
-DEFINE_QNODE(qhs_a1_noc_cfg, SM8250_SLAVE_A1NOC_CFG, 1, 4, SM8250_MASTER_A1NOC_CFG);
-DEFINE_QNODE(qhs_a2_noc_cfg, SM8250_SLAVE_A2NOC_CFG, 1, 4, SM8250_MASTER_A2NOC_CFG);
-DEFINE_QNODE(qhs_ahb2phy0, SM8250_SLAVE_AHB2PHY_SOUTH, 1, 4);
-DEFINE_QNODE(qhs_ahb2phy1, SM8250_SLAVE_AHB2PHY_NORTH, 1, 4);
-DEFINE_QNODE(qhs_aoss, SM8250_SLAVE_AOSS, 1, 4);
-DEFINE_QNODE(qhs_camera_cfg, SM8250_SLAVE_CAMERA_CFG, 1, 4);
-DEFINE_QNODE(qhs_clk_ctl, SM8250_SLAVE_CLK_CTL, 1, 4);
-DEFINE_QNODE(qhs_compute_dsp, SM8250_SLAVE_CDSP_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_cx, SM8250_SLAVE_RBCPR_CX_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_mmcx, SM8250_SLAVE_RBCPR_MMCX_CFG, 1, 4);
-DEFINE_QNODE(qhs_cpr_mx, SM8250_SLAVE_RBCPR_MX_CFG, 1, 4);
-DEFINE_QNODE(qhs_crypto0_cfg, SM8250_SLAVE_CRYPTO_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_cx_rdpm, SM8250_SLAVE_CX_RDPM, 1, 4);
-DEFINE_QNODE(qhs_dcc_cfg, SM8250_SLAVE_DCC_CFG, 1, 4);
-DEFINE_QNODE(qhs_ddrss_cfg, SM8250_SLAVE_CNOC_DDRSS, 1, 4, SM8250_MASTER_CNOC_DC_NOC);
-DEFINE_QNODE(qhs_display_cfg, SM8250_SLAVE_DISPLAY_CFG, 1, 4);
-DEFINE_QNODE(qhs_gpuss_cfg, SM8250_SLAVE_GRAPHICS_3D_CFG, 1, 8);
-DEFINE_QNODE(qhs_imem_cfg, SM8250_SLAVE_IMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_ipa, SM8250_SLAVE_IPA_CFG, 1, 4);
-DEFINE_QNODE(qhs_ipc_router, SM8250_SLAVE_IPC_ROUTER_CFG, 1, 4);
-DEFINE_QNODE(qhs_lpass_cfg, SM8250_SLAVE_LPASS, 1, 4);
-DEFINE_QNODE(qhs_mnoc_cfg, SM8250_SLAVE_CNOC_MNOC_CFG, 1, 4, SM8250_MASTER_CNOC_MNOC_CFG);
-DEFINE_QNODE(qhs_npu_cfg, SM8250_SLAVE_NPU_CFG, 1, 4, SM8250_MASTER_NPU_NOC_CFG);
-DEFINE_QNODE(qhs_pcie0_cfg, SM8250_SLAVE_PCIE_0_CFG, 1, 4);
-DEFINE_QNODE(qhs_pcie1_cfg, SM8250_SLAVE_PCIE_1_CFG, 1, 4);
-DEFINE_QNODE(qhs_pcie_modem_cfg, SM8250_SLAVE_PCIE_2_CFG, 1, 4);
-DEFINE_QNODE(qhs_pdm, SM8250_SLAVE_PDM, 1, 4);
-DEFINE_QNODE(qhs_pimem_cfg, SM8250_SLAVE_PIMEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_prng, SM8250_SLAVE_PRNG, 1, 4);
-DEFINE_QNODE(qhs_qdss_cfg, SM8250_SLAVE_QDSS_CFG, 1, 4);
-DEFINE_QNODE(qhs_qspi, SM8250_SLAVE_QSPI_0, 1, 4);
-DEFINE_QNODE(qhs_qup0, SM8250_SLAVE_QUP_0, 1, 4);
-DEFINE_QNODE(qhs_qup1, SM8250_SLAVE_QUP_1, 1, 4);
-DEFINE_QNODE(qhs_qup2, SM8250_SLAVE_QUP_2, 1, 4);
-DEFINE_QNODE(qhs_sdc2, SM8250_SLAVE_SDCC_2, 1, 4);
-DEFINE_QNODE(qhs_sdc4, SM8250_SLAVE_SDCC_4, 1, 4);
-DEFINE_QNODE(qhs_snoc_cfg, SM8250_SLAVE_SNOC_CFG, 1, 4, SM8250_MASTER_SNOC_CFG);
-DEFINE_QNODE(qhs_tcsr, SM8250_SLAVE_TCSR, 1, 4);
-DEFINE_QNODE(qhs_tlmm0, SM8250_SLAVE_TLMM_NORTH, 1, 4);
-DEFINE_QNODE(qhs_tlmm1, SM8250_SLAVE_TLMM_SOUTH, 1, 4);
-DEFINE_QNODE(qhs_tlmm2, SM8250_SLAVE_TLMM_WEST, 1, 4);
-DEFINE_QNODE(qhs_tsif, SM8250_SLAVE_TSIF, 1, 4);
-DEFINE_QNODE(qhs_ufs_card_cfg, SM8250_SLAVE_UFS_CARD_CFG, 1, 4);
-DEFINE_QNODE(qhs_ufs_mem_cfg, SM8250_SLAVE_UFS_MEM_CFG, 1, 4);
-DEFINE_QNODE(qhs_usb3_0, SM8250_SLAVE_USB3, 1, 4);
-DEFINE_QNODE(qhs_usb3_1, SM8250_SLAVE_USB3_1, 1, 4);
-DEFINE_QNODE(qhs_venus_cfg, SM8250_SLAVE_VENUS_CFG, 1, 4);
-DEFINE_QNODE(qhs_vsense_ctrl_cfg, SM8250_SLAVE_VSENSE_CTRL_CFG, 1, 4);
-DEFINE_QNODE(qns_cnoc_a2noc, SM8250_SLAVE_CNOC_A2NOC, 1, 8, SM8250_MASTER_CNOC_A2NOC);
-DEFINE_QNODE(srvc_cnoc, SM8250_SLAVE_SERVICE_CNOC, 1, 4);
-DEFINE_QNODE(qhs_llcc, SM8250_SLAVE_LLCC_CFG, 1, 4);
-DEFINE_QNODE(qhs_memnoc, SM8250_SLAVE_GEM_NOC_CFG, 1, 4, SM8250_MASTER_GEM_NOC_CFG);
-DEFINE_QNODE(qns_gem_noc_snoc, SM8250_SLAVE_GEM_NOC_SNOC, 1, 16, SM8250_MASTER_GEM_NOC_SNOC);
-DEFINE_QNODE(qns_llcc, SM8250_SLAVE_LLCC, 4, 16, SM8250_MASTER_LLCC);
-DEFINE_QNODE(qns_sys_pcie, SM8250_SLAVE_MEM_NOC_PCIE_SNOC, 1, 8, SM8250_MASTER_GEM_NOC_PCIE_SNOC);
-DEFINE_QNODE(srvc_even_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC_1, 1, 4);
-DEFINE_QNODE(srvc_odd_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC_2, 1, 4);
-DEFINE_QNODE(srvc_sys_gemnoc, SM8250_SLAVE_SERVICE_GEM_NOC, 1, 4);
-DEFINE_QNODE(ebi, SM8250_SLAVE_EBI_CH0, 4, 4);
-DEFINE_QNODE(qns_mem_noc_hf, SM8250_SLAVE_MNOC_HF_MEM_NOC, 2, 32, SM8250_MASTER_MNOC_HF_MEM_NOC);
-DEFINE_QNODE(qns_mem_noc_sf, SM8250_SLAVE_MNOC_SF_MEM_NOC, 2, 32, SM8250_MASTER_MNOC_SF_MEM_NOC);
-DEFINE_QNODE(srvc_mnoc, SM8250_SLAVE_SERVICE_MNOC, 1, 4);
-DEFINE_QNODE(qhs_cal_dp0, SM8250_SLAVE_NPU_CAL_DP0, 1, 4);
-DEFINE_QNODE(qhs_cal_dp1, SM8250_SLAVE_NPU_CAL_DP1, 1, 4);
-DEFINE_QNODE(qhs_cp, SM8250_SLAVE_NPU_CP, 1, 4);
-DEFINE_QNODE(qhs_dma_bwmon, SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG, 1, 4);
-DEFINE_QNODE(qhs_dpm, SM8250_SLAVE_NPU_DPM, 1, 4);
-DEFINE_QNODE(qhs_isense, SM8250_SLAVE_ISENSE_CFG, 1, 4);
-DEFINE_QNODE(qhs_llm, SM8250_SLAVE_NPU_LLM_CFG, 1, 4);
-DEFINE_QNODE(qhs_tcm, SM8250_SLAVE_NPU_TCM, 1, 4);
-DEFINE_QNODE(qns_npu_sys, SM8250_SLAVE_NPU_COMPUTE_NOC, 2, 32);
-DEFINE_QNODE(srvc_noc, SM8250_SLAVE_SERVICE_NPU_NOC, 1, 4);
-DEFINE_QNODE(qhs_apss, SM8250_SLAVE_APPSS, 1, 8);
-DEFINE_QNODE(qns_cnoc, SM8250_SNOC_CNOC_SLV, 1, 8, SM8250_SNOC_CNOC_MAS);
-DEFINE_QNODE(qns_gemnoc_gc, SM8250_SLAVE_SNOC_GEM_NOC_GC, 1, 8, SM8250_MASTER_SNOC_GC_MEM_NOC);
-DEFINE_QNODE(qns_gemnoc_sf, SM8250_SLAVE_SNOC_GEM_NOC_SF, 1, 16, SM8250_MASTER_SNOC_SF_MEM_NOC);
-DEFINE_QNODE(qxs_imem, SM8250_SLAVE_OCIMEM, 1, 8);
-DEFINE_QNODE(qxs_pimem, SM8250_SLAVE_PIMEM, 1, 8);
-DEFINE_QNODE(srvc_snoc, SM8250_SLAVE_SERVICE_SNOC, 1, 4);
-DEFINE_QNODE(xs_pcie_0, SM8250_SLAVE_PCIE_0, 1, 8);
-DEFINE_QNODE(xs_pcie_1, SM8250_SLAVE_PCIE_1, 1, 8);
-DEFINE_QNODE(xs_pcie_modem, SM8250_SLAVE_PCIE_2, 1, 8);
-DEFINE_QNODE(xs_qdss_stm, SM8250_SLAVE_QDSS_STM, 1, 4);
-DEFINE_QNODE(xs_sys_tcu_cfg, SM8250_SLAVE_TCU, 1, 8);
+static struct qcom_icc_node qhm_a1noc_cfg = {
+	.name = "qhm_a1noc_cfg",
+	.id = SM8250_MASTER_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_SERVICE_A1NOC },
+};
+
+static struct qcom_icc_node qhm_qspi = {
+	.name = "qhm_qspi",
+	.id = SM8250_MASTER_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_qup1 = {
+	.name = "qhm_qup1",
+	.id = SM8250_MASTER_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_qup2 = {
+	.name = "qhm_qup2",
+	.id = SM8250_MASTER_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_tsif = {
+	.name = "qhm_tsif",
+	.id = SM8250_MASTER_TSIF,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_pcie3_modem = {
+	.name = "xm_pcie3_modem",
+	.id = SM8250_MASTER_PCIE_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1 },
+};
+
+static struct qcom_icc_node xm_sdc4 = {
+	.name = "xm_sdc4",
+	.id = SM8250_MASTER_SDCC_4,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_ufs_mem = {
+	.name = "xm_ufs_mem",
+	.id = SM8250_MASTER_UFS_MEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_usb3_0 = {
+	.name = "xm_usb3_0",
+	.id = SM8250_MASTER_USB3,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_usb3_1 = {
+	.name = "xm_usb3_1",
+	.id = SM8250_MASTER_USB3_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_A1NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_a2noc_cfg = {
+	.name = "qhm_a2noc_cfg",
+	.id = SM8250_MASTER_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_SERVICE_A2NOC },
+};
+
+static struct qcom_icc_node qhm_qdss_bam = {
+	.name = "qhm_qdss_bam",
+	.id = SM8250_MASTER_QDSS_BAM,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qhm_qup0 = {
+	.name = "qhm_qup0",
+	.id = SM8250_MASTER_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qnm_cnoc = {
+	.name = "qnm_cnoc",
+	.id = SM8250_MASTER_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qxm_crypto = {
+	.name = "qxm_crypto",
+	.id = SM8250_MASTER_CRYPTO_CORE_0,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qxm_ipa = {
+	.name = "qxm_ipa",
+	.id = SM8250_MASTER_IPA,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_pcie3_0 = {
+	.name = "xm_pcie3_0",
+	.id = SM8250_MASTER_PCIE,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_pcie3_1 = {
+	.name = "xm_pcie3_1",
+	.id = SM8250_MASTER_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node xm_qdss_etr = {
+	.name = "xm_qdss_etr",
+	.id = SM8250_MASTER_QDSS_ETR,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_sdc2 = {
+	.name = "xm_sdc2",
+	.id = SM8250_MASTER_SDCC_2,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node xm_ufs_card = {
+	.name = "xm_ufs_card",
+	.id = SM8250_MASTER_UFS_CARD,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_A2NOC_SNOC_SLV },
+};
+
+static struct qcom_icc_node qnm_npu = {
+	.name = "qnm_npu",
+	.id = SM8250_MASTER_NPU,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_CDSP_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_snoc = {
+	.name = "qnm_snoc",
+	.id = SM8250_SNOC_CNOC_MAS,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 49,
+	.links = { SM8250_SLAVE_CDSP_CFG,
+		   SM8250_SLAVE_CAMERA_CFG,
+		   SM8250_SLAVE_TLMM_SOUTH,
+		   SM8250_SLAVE_TLMM_NORTH,
+		   SM8250_SLAVE_SDCC_4,
+		   SM8250_SLAVE_TLMM_WEST,
+		   SM8250_SLAVE_SDCC_2,
+		   SM8250_SLAVE_CNOC_MNOC_CFG,
+		   SM8250_SLAVE_UFS_MEM_CFG,
+		   SM8250_SLAVE_SNOC_CFG,
+		   SM8250_SLAVE_PDM,
+		   SM8250_SLAVE_CX_RDPM,
+		   SM8250_SLAVE_PCIE_1_CFG,
+		   SM8250_SLAVE_A2NOC_CFG,
+		   SM8250_SLAVE_QDSS_CFG,
+		   SM8250_SLAVE_DISPLAY_CFG,
+		   SM8250_SLAVE_PCIE_2_CFG,
+		   SM8250_SLAVE_TCSR,
+		   SM8250_SLAVE_DCC_CFG,
+		   SM8250_SLAVE_CNOC_DDRSS,
+		   SM8250_SLAVE_IPC_ROUTER_CFG,
+		   SM8250_SLAVE_PCIE_0_CFG,
+		   SM8250_SLAVE_RBCPR_MMCX_CFG,
+		   SM8250_SLAVE_NPU_CFG,
+		   SM8250_SLAVE_AHB2PHY_SOUTH,
+		   SM8250_SLAVE_AHB2PHY_NORTH,
+		   SM8250_SLAVE_GRAPHICS_3D_CFG,
+		   SM8250_SLAVE_VENUS_CFG,
+		   SM8250_SLAVE_TSIF,
+		   SM8250_SLAVE_IPA_CFG,
+		   SM8250_SLAVE_IMEM_CFG,
+		   SM8250_SLAVE_USB3,
+		   SM8250_SLAVE_SERVICE_CNOC,
+		   SM8250_SLAVE_UFS_CARD_CFG,
+		   SM8250_SLAVE_USB3_1,
+		   SM8250_SLAVE_LPASS,
+		   SM8250_SLAVE_RBCPR_CX_CFG,
+		   SM8250_SLAVE_A1NOC_CFG,
+		   SM8250_SLAVE_AOSS,
+		   SM8250_SLAVE_PRNG,
+		   SM8250_SLAVE_VSENSE_CTRL_CFG,
+		   SM8250_SLAVE_QSPI_0,
+		   SM8250_SLAVE_CRYPTO_0_CFG,
+		   SM8250_SLAVE_PIMEM_CFG,
+		   SM8250_SLAVE_RBCPR_MX_CFG,
+		   SM8250_SLAVE_QUP_0,
+		   SM8250_SLAVE_QUP_1,
+		   SM8250_SLAVE_QUP_2,
+		   SM8250_SLAVE_CLK_CTL
+	},
+};
+
+static struct qcom_icc_node xm_qdss_dap = {
+	.name = "xm_qdss_dap",
+	.id = SM8250_MASTER_QDSS_DAP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 50,
+	.links = { SM8250_SLAVE_CDSP_CFG,
+		   SM8250_SLAVE_CAMERA_CFG,
+		   SM8250_SLAVE_TLMM_SOUTH,
+		   SM8250_SLAVE_TLMM_NORTH,
+		   SM8250_SLAVE_SDCC_4,
+		   SM8250_SLAVE_TLMM_WEST,
+		   SM8250_SLAVE_SDCC_2,
+		   SM8250_SLAVE_CNOC_MNOC_CFG,
+		   SM8250_SLAVE_UFS_MEM_CFG,
+		   SM8250_SLAVE_SNOC_CFG,
+		   SM8250_SLAVE_PDM,
+		   SM8250_SLAVE_CX_RDPM,
+		   SM8250_SLAVE_PCIE_1_CFG,
+		   SM8250_SLAVE_A2NOC_CFG,
+		   SM8250_SLAVE_QDSS_CFG,
+		   SM8250_SLAVE_DISPLAY_CFG,
+		   SM8250_SLAVE_PCIE_2_CFG,
+		   SM8250_SLAVE_TCSR,
+		   SM8250_SLAVE_DCC_CFG,
+		   SM8250_SLAVE_CNOC_DDRSS,
+		   SM8250_SLAVE_IPC_ROUTER_CFG,
+		   SM8250_SLAVE_CNOC_A2NOC,
+		   SM8250_SLAVE_PCIE_0_CFG,
+		   SM8250_SLAVE_RBCPR_MMCX_CFG,
+		   SM8250_SLAVE_NPU_CFG,
+		   SM8250_SLAVE_AHB2PHY_SOUTH,
+		   SM8250_SLAVE_AHB2PHY_NORTH,
+		   SM8250_SLAVE_GRAPHICS_3D_CFG,
+		   SM8250_SLAVE_VENUS_CFG,
+		   SM8250_SLAVE_TSIF,
+		   SM8250_SLAVE_IPA_CFG,
+		   SM8250_SLAVE_IMEM_CFG,
+		   SM8250_SLAVE_USB3,
+		   SM8250_SLAVE_SERVICE_CNOC,
+		   SM8250_SLAVE_UFS_CARD_CFG,
+		   SM8250_SLAVE_USB3_1,
+		   SM8250_SLAVE_LPASS,
+		   SM8250_SLAVE_RBCPR_CX_CFG,
+		   SM8250_SLAVE_A1NOC_CFG,
+		   SM8250_SLAVE_AOSS,
+		   SM8250_SLAVE_PRNG,
+		   SM8250_SLAVE_VSENSE_CTRL_CFG,
+		   SM8250_SLAVE_QSPI_0,
+		   SM8250_SLAVE_CRYPTO_0_CFG,
+		   SM8250_SLAVE_PIMEM_CFG,
+		   SM8250_SLAVE_RBCPR_MX_CFG,
+		   SM8250_SLAVE_QUP_0,
+		   SM8250_SLAVE_QUP_1,
+		   SM8250_SLAVE_QUP_2,
+		   SM8250_SLAVE_CLK_CTL
+	},
+};
+
+static struct qcom_icc_node qhm_cnoc_dc_noc = {
+	.name = "qhm_cnoc_dc_noc",
+	.id = SM8250_MASTER_CNOC_DC_NOC,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 2,
+	.links = { SM8250_SLAVE_GEM_NOC_CFG,
+		   SM8250_SLAVE_LLCC_CFG
+	},
+};
+
+static struct qcom_icc_node alm_gpu_tcu = {
+	.name = "alm_gpu_tcu",
+	.id = SM8250_MASTER_GPU_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM8250_SLAVE_LLCC,
+		   SM8250_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node alm_sys_tcu = {
+	.name = "alm_sys_tcu",
+	.id = SM8250_MASTER_SYS_TCU,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 2,
+	.links = { SM8250_SLAVE_LLCC,
+		   SM8250_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node chm_apps = {
+	.name = "chm_apps",
+	.id = SM8250_MASTER_AMPSS_M0,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 3,
+	.links = { SM8250_SLAVE_LLCC,
+		   SM8250_SLAVE_GEM_NOC_SNOC,
+		   SM8250_SLAVE_MEM_NOC_PCIE_SNOC
+	},
+};
+
+static struct qcom_icc_node qhm_gemnoc_cfg = {
+	.name = "qhm_gemnoc_cfg",
+	.id = SM8250_MASTER_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 3,
+	.links = { SM8250_SLAVE_SERVICE_GEM_NOC_2,
+		   SM8250_SLAVE_SERVICE_GEM_NOC_1,
+		   SM8250_SLAVE_SERVICE_GEM_NOC
+	},
+};
+
+static struct qcom_icc_node qnm_cmpnoc = {
+	.name = "qnm_cmpnoc",
+	.id = SM8250_MASTER_COMPUTE_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM8250_SLAVE_LLCC,
+		   SM8250_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_gpu = {
+	.name = "qnm_gpu",
+	.id = SM8250_MASTER_GRAPHICS_3D,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM8250_SLAVE_LLCC,
+		   SM8250_SLAVE_GEM_NOC_SNOC },
+};
+
+static struct qcom_icc_node qnm_mnoc_hf = {
+	.name = "qnm_mnoc_hf",
+	.id = SM8250_MASTER_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_mnoc_sf = {
+	.name = "qnm_mnoc_sf",
+	.id = SM8250_MASTER_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 2,
+	.links = { SM8250_SLAVE_LLCC,
+		   SM8250_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_pcie = {
+	.name = "qnm_pcie",
+	.id = SM8250_MASTER_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 2,
+	.links = { SM8250_SLAVE_LLCC,
+		   SM8250_SLAVE_GEM_NOC_SNOC
+	},
+};
+
+static struct qcom_icc_node qnm_snoc_gc = {
+	.name = "qnm_snoc_gc",
+	.id = SM8250_MASTER_SNOC_GC_MEM_NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_LLCC },
+};
+
+static struct qcom_icc_node qnm_snoc_sf = {
+	.name = "qnm_snoc_sf",
+	.id = SM8250_MASTER_SNOC_SF_MEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 3,
+	.links = { SM8250_SLAVE_LLCC,
+		   SM8250_SLAVE_GEM_NOC_SNOC,
+		   SM8250_SLAVE_MEM_NOC_PCIE_SNOC
+	},
+};
+
+static struct qcom_icc_node llcc_mc = {
+	.name = "llcc_mc",
+	.id = SM8250_MASTER_LLCC,
+	.channels = 4,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_EBI_CH0 },
+};
+
+static struct qcom_icc_node qhm_mnoc_cfg = {
+	.name = "qhm_mnoc_cfg",
+	.id = SM8250_MASTER_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_SERVICE_MNOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_hf = {
+	.name = "qnm_camnoc_hf",
+	.id = SM8250_MASTER_CAMNOC_HF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_icp = {
+	.name = "qnm_camnoc_icp",
+	.id = SM8250_MASTER_CAMNOC_ICP,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_camnoc_sf = {
+	.name = "qnm_camnoc_sf",
+	.id = SM8250_MASTER_CAMNOC_SF,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video0 = {
+	.name = "qnm_video0",
+	.id = SM8250_MASTER_VIDEO_P0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video1 = {
+	.name = "qnm_video1",
+	.id = SM8250_MASTER_VIDEO_P1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qnm_video_cvp = {
+	.name = "qnm_video_cvp",
+	.id = SM8250_MASTER_VIDEO_PROC,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp0 = {
+	.name = "qxm_mdp0",
+	.id = SM8250_MASTER_MDP_PORT0,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_mdp1 = {
+	.name = "qxm_mdp1",
+	.id = SM8250_MASTER_MDP_PORT1,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxm_rot = {
+	.name = "qxm_rot",
+	.id = SM8250_MASTER_ROTATOR,
+	.channels = 1,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node amm_npu_sys = {
+	.name = "amm_npu_sys",
+	.id = SM8250_MASTER_NPU_SYS,
+	.channels = 4,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_NPU_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node amm_npu_sys_cdp_w = {
+	.name = "amm_npu_sys_cdp_w",
+	.id = SM8250_MASTER_NPU_CDP,
+	.channels = 2,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_NPU_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qhm_cfg = {
+	.name = "qhm_cfg",
+	.id = SM8250_MASTER_NPU_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 9,
+	.links = { SM8250_SLAVE_SERVICE_NPU_NOC,
+		   SM8250_SLAVE_ISENSE_CFG,
+		   SM8250_SLAVE_NPU_LLM_CFG,
+		   SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG,
+		   SM8250_SLAVE_NPU_CP,
+		   SM8250_SLAVE_NPU_TCM,
+		   SM8250_SLAVE_NPU_CAL_DP0,
+		   SM8250_SLAVE_NPU_CAL_DP1,
+		   SM8250_SLAVE_NPU_DPM
+	},
+};
+
+static struct qcom_icc_node qhm_snoc_cfg = {
+	.name = "qhm_snoc_cfg",
+	.id = SM8250_MASTER_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_SERVICE_SNOC },
+};
+
+static struct qcom_icc_node qnm_aggre1_noc = {
+	.name = "qnm_aggre1_noc",
+	.id = SM8250_A1NOC_SNOC_MAS,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_aggre2_noc = {
+	.name = "qnm_aggre2_noc",
+	.id = SM8250_A2NOC_SNOC_MAS,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_SNOC_GEM_NOC_SF },
+};
+
+static struct qcom_icc_node qnm_gemnoc = {
+	.name = "qnm_gemnoc",
+	.id = SM8250_MASTER_GEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 6,
+	.links = { SM8250_SLAVE_PIMEM,
+		   SM8250_SLAVE_OCIMEM,
+		   SM8250_SLAVE_APPSS,
+		   SM8250_SNOC_CNOC_SLV,
+		   SM8250_SLAVE_TCU,
+		   SM8250_SLAVE_QDSS_STM
+	},
+};
+
+static struct qcom_icc_node qnm_gemnoc_pcie = {
+	.name = "qnm_gemnoc_pcie",
+	.id = SM8250_MASTER_GEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 3,
+	.links = { SM8250_SLAVE_PCIE_2,
+		   SM8250_SLAVE_PCIE_0,
+		   SM8250_SLAVE_PCIE_1
+	},
+};
+
+static struct qcom_icc_node qxm_pimem = {
+	.name = "qxm_pimem",
+	.id = SM8250_MASTER_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node xm_gic = {
+	.name = "xm_gic",
+	.id = SM8250_MASTER_GIC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_SLAVE_SNOC_GEM_NOC_GC },
+};
+
+static struct qcom_icc_node qns_a1noc_snoc = {
+	.name = "qns_a1noc_snoc",
+	.id = SM8250_A1NOC_SNOC_SLV,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8250_A1NOC_SNOC_MAS },
+};
+
+static struct qcom_icc_node qns_pcie_modem_mem_noc = {
+	.name = "qns_pcie_modem_mem_noc",
+	.id = SM8250_SLAVE_ANOC_PCIE_GEM_NOC_1,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8250_MASTER_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node srvc_aggre1_noc = {
+	.name = "srvc_aggre1_noc",
+	.id = SM8250_SLAVE_SERVICE_A1NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_a2noc_snoc = {
+	.name = "qns_a2noc_snoc",
+	.id = SM8250_A2NOC_SNOC_SLV,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8250_A2NOC_SNOC_MAS },
+};
+
+static struct qcom_icc_node qns_pcie_mem_noc = {
+	.name = "qns_pcie_mem_noc",
+	.id = SM8250_SLAVE_ANOC_PCIE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8250_MASTER_ANOC_PCIE_GEM_NOC },
+};
+
+static struct qcom_icc_node srvc_aggre2_noc = {
+	.name = "srvc_aggre2_noc",
+	.id = SM8250_SLAVE_SERVICE_A2NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_cdsp_mem_noc = {
+	.name = "qns_cdsp_mem_noc",
+	.id = SM8250_SLAVE_CDSP_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_MASTER_COMPUTE_NOC },
+};
+
+static struct qcom_icc_node qhs_a1_noc_cfg = {
+	.name = "qhs_a1_noc_cfg",
+	.id = SM8250_SLAVE_A1NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_MASTER_A1NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_a2_noc_cfg = {
+	.name = "qhs_a2_noc_cfg",
+	.id = SM8250_SLAVE_A2NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_MASTER_A2NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_ahb2phy0 = {
+	.name = "qhs_ahb2phy0",
+	.id = SM8250_SLAVE_AHB2PHY_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ahb2phy1 = {
+	.name = "qhs_ahb2phy1",
+	.id = SM8250_SLAVE_AHB2PHY_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_aoss = {
+	.name = "qhs_aoss",
+	.id = SM8250_SLAVE_AOSS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_camera_cfg = {
+	.name = "qhs_camera_cfg",
+	.id = SM8250_SLAVE_CAMERA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_clk_ctl = {
+	.name = "qhs_clk_ctl",
+	.id = SM8250_SLAVE_CLK_CTL,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_compute_dsp = {
+	.name = "qhs_compute_dsp",
+	.id = SM8250_SLAVE_CDSP_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_cx = {
+	.name = "qhs_cpr_cx",
+	.id = SM8250_SLAVE_RBCPR_CX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_mmcx = {
+	.name = "qhs_cpr_mmcx",
+	.id = SM8250_SLAVE_RBCPR_MMCX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cpr_mx = {
+	.name = "qhs_cpr_mx",
+	.id = SM8250_SLAVE_RBCPR_MX_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_crypto0_cfg = {
+	.name = "qhs_crypto0_cfg",
+	.id = SM8250_SLAVE_CRYPTO_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cx_rdpm = {
+	.name = "qhs_cx_rdpm",
+	.id = SM8250_SLAVE_CX_RDPM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dcc_cfg = {
+	.name = "qhs_dcc_cfg",
+	.id = SM8250_SLAVE_DCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ddrss_cfg = {
+	.name = "qhs_ddrss_cfg",
+	.id = SM8250_SLAVE_CNOC_DDRSS,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_MASTER_CNOC_DC_NOC },
+};
+
+static struct qcom_icc_node qhs_display_cfg = {
+	.name = "qhs_display_cfg",
+	.id = SM8250_SLAVE_DISPLAY_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_gpuss_cfg = {
+	.name = "qhs_gpuss_cfg",
+	.id = SM8250_SLAVE_GRAPHICS_3D_CFG,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qhs_imem_cfg = {
+	.name = "qhs_imem_cfg",
+	.id = SM8250_SLAVE_IMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipa = {
+	.name = "qhs_ipa",
+	.id = SM8250_SLAVE_IPA_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ipc_router = {
+	.name = "qhs_ipc_router",
+	.id = SM8250_SLAVE_IPC_ROUTER_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_lpass_cfg = {
+	.name = "qhs_lpass_cfg",
+	.id = SM8250_SLAVE_LPASS,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_mnoc_cfg = {
+	.name = "qhs_mnoc_cfg",
+	.id = SM8250_SLAVE_CNOC_MNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_MASTER_CNOC_MNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_npu_cfg = {
+	.name = "qhs_npu_cfg",
+	.id = SM8250_SLAVE_NPU_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_MASTER_NPU_NOC_CFG },
+};
+
+static struct qcom_icc_node qhs_pcie0_cfg = {
+	.name = "qhs_pcie0_cfg",
+	.id = SM8250_SLAVE_PCIE_0_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie1_cfg = {
+	.name = "qhs_pcie1_cfg",
+	.id = SM8250_SLAVE_PCIE_1_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pcie_modem_cfg = {
+	.name = "qhs_pcie_modem_cfg",
+	.id = SM8250_SLAVE_PCIE_2_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pdm = {
+	.name = "qhs_pdm",
+	.id = SM8250_SLAVE_PDM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_pimem_cfg = {
+	.name = "qhs_pimem_cfg",
+	.id = SM8250_SLAVE_PIMEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_prng = {
+	.name = "qhs_prng",
+	.id = SM8250_SLAVE_PRNG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qdss_cfg = {
+	.name = "qhs_qdss_cfg",
+	.id = SM8250_SLAVE_QDSS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qspi = {
+	.name = "qhs_qspi",
+	.id = SM8250_SLAVE_QSPI_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup0 = {
+	.name = "qhs_qup0",
+	.id = SM8250_SLAVE_QUP_0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup1 = {
+	.name = "qhs_qup1",
+	.id = SM8250_SLAVE_QUP_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_qup2 = {
+	.name = "qhs_qup2",
+	.id = SM8250_SLAVE_QUP_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc2 = {
+	.name = "qhs_sdc2",
+	.id = SM8250_SLAVE_SDCC_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_sdc4 = {
+	.name = "qhs_sdc4",
+	.id = SM8250_SLAVE_SDCC_4,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_snoc_cfg = {
+	.name = "qhs_snoc_cfg",
+	.id = SM8250_SLAVE_SNOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_MASTER_SNOC_CFG },
+};
+
+static struct qcom_icc_node qhs_tcsr = {
+	.name = "qhs_tcsr",
+	.id = SM8250_SLAVE_TCSR,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm0 = {
+	.name = "qhs_tlmm0",
+	.id = SM8250_SLAVE_TLMM_NORTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm1 = {
+	.name = "qhs_tlmm1",
+	.id = SM8250_SLAVE_TLMM_SOUTH,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tlmm2 = {
+	.name = "qhs_tlmm2",
+	.id = SM8250_SLAVE_TLMM_WEST,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tsif = {
+	.name = "qhs_tsif",
+	.id = SM8250_SLAVE_TSIF,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_card_cfg = {
+	.name = "qhs_ufs_card_cfg",
+	.id = SM8250_SLAVE_UFS_CARD_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_ufs_mem_cfg = {
+	.name = "qhs_ufs_mem_cfg",
+	.id = SM8250_SLAVE_UFS_MEM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_0 = {
+	.name = "qhs_usb3_0",
+	.id = SM8250_SLAVE_USB3,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_usb3_1 = {
+	.name = "qhs_usb3_1",
+	.id = SM8250_SLAVE_USB3_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_venus_cfg = {
+	.name = "qhs_venus_cfg",
+	.id = SM8250_SLAVE_VENUS_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_vsense_ctrl_cfg = {
+	.name = "qhs_vsense_ctrl_cfg",
+	.id = SM8250_SLAVE_VSENSE_CTRL_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_cnoc_a2noc = {
+	.name = "qns_cnoc_a2noc",
+	.id = SM8250_SLAVE_CNOC_A2NOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_MASTER_CNOC_A2NOC },
+};
+
+static struct qcom_icc_node srvc_cnoc = {
+	.name = "srvc_cnoc",
+	.id = SM8250_SLAVE_SERVICE_CNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_llcc = {
+	.name = "qhs_llcc",
+	.id = SM8250_SLAVE_LLCC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_memnoc = {
+	.name = "qhs_memnoc",
+	.id = SM8250_SLAVE_GEM_NOC_CFG,
+	.channels = 1,
+	.buswidth = 4,
+	.num_links = 1,
+	.links = { SM8250_MASTER_GEM_NOC_CFG },
+};
+
+static struct qcom_icc_node qns_gem_noc_snoc = {
+	.name = "qns_gem_noc_snoc",
+	.id = SM8250_SLAVE_GEM_NOC_SNOC,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8250_MASTER_GEM_NOC_SNOC },
+};
+
+static struct qcom_icc_node qns_llcc = {
+	.name = "qns_llcc",
+	.id = SM8250_SLAVE_LLCC,
+	.channels = 4,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8250_MASTER_LLCC },
+};
+
+static struct qcom_icc_node qns_sys_pcie = {
+	.name = "qns_sys_pcie",
+	.id = SM8250_SLAVE_MEM_NOC_PCIE_SNOC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_MASTER_GEM_NOC_PCIE_SNOC },
+};
+
+static struct qcom_icc_node srvc_even_gemnoc = {
+	.name = "srvc_even_gemnoc",
+	.id = SM8250_SLAVE_SERVICE_GEM_NOC_1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_odd_gemnoc = {
+	.name = "srvc_odd_gemnoc",
+	.id = SM8250_SLAVE_SERVICE_GEM_NOC_2,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node srvc_sys_gemnoc = {
+	.name = "srvc_sys_gemnoc",
+	.id = SM8250_SLAVE_SERVICE_GEM_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node ebi = {
+	.name = "ebi",
+	.id = SM8250_SLAVE_EBI_CH0,
+	.channels = 4,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_mem_noc_hf = {
+	.name = "qns_mem_noc_hf",
+	.id = SM8250_SLAVE_MNOC_HF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_MASTER_MNOC_HF_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_mem_noc_sf = {
+	.name = "qns_mem_noc_sf",
+	.id = SM8250_SLAVE_MNOC_SF_MEM_NOC,
+	.channels = 2,
+	.buswidth = 32,
+	.num_links = 1,
+	.links = { SM8250_MASTER_MNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node srvc_mnoc = {
+	.name = "srvc_mnoc",
+	.id = SM8250_SLAVE_SERVICE_MNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cal_dp0 = {
+	.name = "qhs_cal_dp0",
+	.id = SM8250_SLAVE_NPU_CAL_DP0,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cal_dp1 = {
+	.name = "qhs_cal_dp1",
+	.id = SM8250_SLAVE_NPU_CAL_DP1,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_cp = {
+	.name = "qhs_cp",
+	.id = SM8250_SLAVE_NPU_CP,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dma_bwmon = {
+	.name = "qhs_dma_bwmon",
+	.id = SM8250_SLAVE_NPU_INT_DMA_BWMON_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_dpm = {
+	.name = "qhs_dpm",
+	.id = SM8250_SLAVE_NPU_DPM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_isense = {
+	.name = "qhs_isense",
+	.id = SM8250_SLAVE_ISENSE_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_llm = {
+	.name = "qhs_llm",
+	.id = SM8250_SLAVE_NPU_LLM_CFG,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_tcm = {
+	.name = "qhs_tcm",
+	.id = SM8250_SLAVE_NPU_TCM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qns_npu_sys = {
+	.name = "qns_npu_sys",
+	.id = SM8250_SLAVE_NPU_COMPUTE_NOC,
+	.channels = 2,
+	.buswidth = 32,
+};
+
+static struct qcom_icc_node srvc_noc = {
+	.name = "srvc_noc",
+	.id = SM8250_SLAVE_SERVICE_NPU_NOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node qhs_apss = {
+	.name = "qhs_apss",
+	.id = SM8250_SLAVE_APPSS,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qns_cnoc = {
+	.name = "qns_cnoc",
+	.id = SM8250_SNOC_CNOC_SLV,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_SNOC_CNOC_MAS },
+};
+
+static struct qcom_icc_node qns_gemnoc_gc = {
+	.name = "qns_gemnoc_gc",
+	.id = SM8250_SLAVE_SNOC_GEM_NOC_GC,
+	.channels = 1,
+	.buswidth = 8,
+	.num_links = 1,
+	.links = { SM8250_MASTER_SNOC_GC_MEM_NOC },
+};
+
+static struct qcom_icc_node qns_gemnoc_sf = {
+	.name = "qns_gemnoc_sf",
+	.id = SM8250_SLAVE_SNOC_GEM_NOC_SF,
+	.channels = 1,
+	.buswidth = 16,
+	.num_links = 1,
+	.links = { SM8250_MASTER_SNOC_SF_MEM_NOC },
+};
+
+static struct qcom_icc_node qxs_imem = {
+	.name = "qxs_imem",
+	.id = SM8250_SLAVE_OCIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node qxs_pimem = {
+	.name = "qxs_pimem",
+	.id = SM8250_SLAVE_PIMEM,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node srvc_snoc = {
+	.name = "srvc_snoc",
+	.id = SM8250_SLAVE_SERVICE_SNOC,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_pcie_0 = {
+	.name = "xs_pcie_0",
+	.id = SM8250_SLAVE_PCIE_0,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_pcie_1 = {
+	.name = "xs_pcie_1",
+	.id = SM8250_SLAVE_PCIE_1,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_pcie_modem = {
+	.name = "xs_pcie_modem",
+	.id = SM8250_SLAVE_PCIE_2,
+	.channels = 1,
+	.buswidth = 8,
+};
+
+static struct qcom_icc_node xs_qdss_stm = {
+	.name = "xs_qdss_stm",
+	.id = SM8250_SLAVE_QDSS_STM,
+	.channels = 1,
+	.buswidth = 4,
+};
+
+static struct qcom_icc_node xs_sys_tcu_cfg = {
+	.name = "xs_sys_tcu_cfg",
+	.id = SM8250_SLAVE_TCU,
+	.channels = 1,
+	.buswidth = 8,
+};
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",

-- 
2.41.0

