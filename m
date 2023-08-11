Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89348779027
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjHKNES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjHKNEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:04:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2BF270C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe934c4decso1989551e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691759053; x=1692363853;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WrhwGbOx8CihAahdmmG7RyQQcE2/SAvxhO4tfnZYR+I=;
        b=XKAnCNNljArIYwMz/AVTfqf50sU9BEWE0cVE+1XwjV9aKrLUtR1fsA8TuqxsNOYhJq
         guUP1EsGFaMYDHruEz1jBJjhp52hK/PpzbOKVM1Qr9rtKuR7IUINKGsVMkdoa/YU6G34
         ONj+HAY1FeXPUWxSBYNITGeZfXHnD6IWxtAny/lRxgiGD6KUg2/1n2gKdj2sV4X2wNGY
         afGxJ7Brsujk1WheS5lunJ7KVH/Be4bFppp6Ll5uRDtoMFbaZSdLjgaCVhDH0pl5hSFZ
         ECiAzNqY++yYE6Lz4SOC8TDHPIB/pSYLUkG7+3Bf5oxoYcSqP0JvpO/eHct3ZEy/l54P
         Mhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691759053; x=1692363853;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrhwGbOx8CihAahdmmG7RyQQcE2/SAvxhO4tfnZYR+I=;
        b=fmz31tgyMOxwZP4QJ4GJRJyQkIooZDRVEdRHvHIaW/yN6aZv79Z1X2uiKMPkmsn+kP
         FW431jJV/jIV6ch3OiX1yF3wqkKLcmZKsQLi9zN8Ecz5Ueqopef5wkEnZsRhaEBMEgcS
         KWYRu5Nos9jA2T1R03APxO3EoWVqdCy1GY835xPs2/OmJgWwG6iwa4caUw+CBErgVucd
         gK1ddFwWmE9aaaE5f1Z300/I2jdHc/UKHU6/WPkZh2yBqPKi+ZvYk2S/4DDFClUOZEIW
         LuK15jui/J1NdYKnvKJ1S0TwhqyjcwxcBqNMHy4qZvcNiYztVPB76/MxIaMwjdISqIeb
         us1w==
X-Gm-Message-State: AOJu0Yw4gzVSJColXCbODEwfVpJJOg6ohGVTa25MPXy1b5SMrKtVzeOx
        4y7cZ3Pyyk5g73So/MnKa7IOLRnHoca+0LK6MxA=
X-Google-Smtp-Source: AGHT+IFsUil/t8SKFOwfoBId7d5Hr9WbziqxHCVQSgG9O4efMG41dDMUpkF4CLOXrGAxIrPyTWDTcw==
X-Received: by 2002:a05:6512:2396:b0:4fc:3756:754e with SMTP id c22-20020a056512239600b004fc3756754emr1781424lfv.56.1691759053213;
        Fri, 11 Aug 2023 06:04:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id v20-20020a197414000000b004fe15a2f0f6sm722491lfe.62.2023.08.11.06.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:04:12 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/11] Hook up ACV enable_mask for everybody
Date:   Fri, 11 Aug 2023 15:04:07 +0200
Message-Id: <20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMcx1mQC/x2NQQqEMAxFryJZT8BWUfEqwyxijBqQKu1YBPHuB
 pfv8z7vgiRRJUFfXBAla9ItGLhPAbxQmAV1NAZf+qrsnMP/tisjccbWE1NHYzPVDswfKAkOkQI
 v9gjHutq4R5n0fAPf330/HV/RsHAAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691759050; l=2046;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EyaDU3nl/mO3PgtI9jo6IYEb6piv8kz5EwfbfPRWcb4=;
 b=IEmubDJ0qot2yOM5UP718MTyOsR36+04r7PPb645c21grCrL05US6MaA16dRMDR77/UAt21Xy
 /Lz8a6PLhXkAimFFTpjPgblJTR9sUDW6v2gHOFwCLPM7I+x+iticW0E
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

In the downstream kernel, ACV enable_mask has not been mentioned
explicitly, rather being handled by a sneaky if-condition [1], [2].

Add it to all RPMh platforms to actually enable that BCM.

Based atop [3].

[1] https://git.codelinaro.org/clo/la/kernel/msm-4.19/-/blob/LA.UM.10.2.1.c25/drivers/soc/qcom/msm_bus/msm_bus_arb_rpmh.c#L556-567
[2] https://git.codelinaro.org/clo/la/kernel/msm-4.19/-/blob/LA.UM.10.2.1.c25/drivers/soc/qcom/msm_bus/msm_bus_arb_rpmh.c#L475-495
[3] https://lore.kernel.org/linux-arm-msm/20230811-topic-icc_retire_macrosd-v1-0-c03aaeffc769@linaro.org/T/#t

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (11):
      interconnect: qcom: qdu1000: Set ACV enable_mask
      interconnect: qcom: sc7180: Set ACV enable_mask
      interconnect: qcom: sc7280: Set ACV enable_mask
      interconnect: qcom: sc8180x: Set ACV enable_mask
      interconnect: qcom: sc8280xp: Set ACV enable_mask
      interconnect: qcom: sdm670: Set ACV enable_mask
      interconnect: qcom: sdm845: Set ACV enable_mask
      interconnect: qcom: sm6350: Set ACV enable_mask
      interconnect: qcom: sm8150: Set ACV enable_mask
      interconnect: qcom: sm8250: Set ACV enable_mask
      interconnect: qcom: sm8350: Set ACV enable_mask

 drivers/interconnect/qcom/bcm-voter.h | 2 ++
 drivers/interconnect/qcom/qdu1000.c   | 1 +
 drivers/interconnect/qcom/sc7180.c    | 1 +
 drivers/interconnect/qcom/sc7280.c    | 1 +
 drivers/interconnect/qcom/sc8180x.c   | 1 +
 drivers/interconnect/qcom/sc8280xp.c  | 1 +
 drivers/interconnect/qcom/sdm670.c    | 1 +
 drivers/interconnect/qcom/sdm845.c    | 1 +
 drivers/interconnect/qcom/sm6350.c    | 1 +
 drivers/interconnect/qcom/sm8150.c    | 1 +
 drivers/interconnect/qcom/sm8250.c    | 1 +
 drivers/interconnect/qcom/sm8350.c    | 1 +
 12 files changed, 13 insertions(+)
---
base-commit: ee4aa20e094643232438b896f49a405361406fbf
change-id: 20230811-topic-acv-72aca8ad6f41

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

