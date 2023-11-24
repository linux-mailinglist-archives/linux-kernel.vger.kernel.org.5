Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED427F7CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345682AbjKXSRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjKXSRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:17:18 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D919AA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:17:24 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7b063a6420dso51481139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700849844; x=1701454644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdemZMUaHLvbgIQeYpkHPsZSBKipx/K1siuFsuVeo40=;
        b=k9VROuIAAOUImHFOc1hGKYOem/1ZqTDbFMHD1VKTSgfKN474XwLay5UMGcJ3eHWv/M
         Kw9ZYkGUn1peucjYX/qrzyioyXINj1yACzLfT4nRLd1HWsmJeFkDwyXkIKzKuJDsOJZw
         eB5SGIasmlq1/t//q2hgZ8wsnJnPDTR5oKxO65xTCItF3B/Uw+8rD4OdKXn1v4B3O9gL
         cnYaOIjfNDLtbDGQysTrd/vm11g9KIlAWucOp4D/KL/IE5hBCYi/1pnk1hpu3ibEYNak
         JjBswn61uHy29GvfE2p4v9v+hAguYHx2B6ORODnGtkmhTZLljxoMv8J/NmT8MjmGkh+L
         8YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700849844; x=1701454644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdemZMUaHLvbgIQeYpkHPsZSBKipx/K1siuFsuVeo40=;
        b=EkujtdqNI9/BQxl6VIyJf1ZN2QVWy6uFD0HHIB9aGL1F0+xtaKLXL9GhWEbcUXBwPu
         YduxzSXgo6RvD/1gX7T7LiE4+xxZcVJ45KClWvbgZBrF2STZ0qRLwEyWAKcKRu0J5mng
         d0XgIrMiot89502kyXe4WVMCuAil5F4G0wovdeLN7/oNs0SRSQ6aSTEvEvAmOOSEZY0k
         fo81GjREjlDuPSjtf5JlAxu+Eln0DSJ7R1rbm0gfPuRB0NGzXGv4y2tNC6uw3P9+r2RN
         QX/+xE4WNtw32P3RMGjBs+41lL1sK5wx6mm5ZV2ZpriMln6UqHenfJsDHbNtXK5ZRYCf
         ID7w==
X-Gm-Message-State: AOJu0Yw/DrWII00mBa0TrgOpvDLsY1XhPxb+0V+SQisgbBxkymcZB0+m
        KCNE52OM5Ff5cwRhByZePp12IA==
X-Google-Smtp-Source: AGHT+IHIhq5dXURp2uD4Ir7/hFdML3568dF0Pu58bcTRL5x15Elbkl4QdkPBuZPtVxgjzCiy/kuyYQ==
X-Received: by 2002:a05:6602:3992:b0:79f:e800:ea95 with SMTP id bw18-20020a056602399200b0079fe800ea95mr7285009iob.3.1700849844178;
        Fri, 24 Nov 2023 10:17:24 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id et21-20020a0566382a1500b004665cf3e94dsm937031jab.2.2023.11.24.10.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:17:23 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, agross@kernel.org
Cc:     mka@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sm8550-qrd: enable IPA
Date:   Fri, 24 Nov 2023 12:17:18 -0600
Message-Id: <20231124181718.915208-3-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124181718.915208-1-elder@linaro.org>
References: <20231124181718.915208-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable IPA on the SM8550 QRD.  The GSI firmware on this platform is
loaded by the AP.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index eef811def39bc..34c760549f3ee 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -585,6 +585,13 @@ fsa4480_sbu_mux: endpoint {
 	};
 };
 
+&ipa {
+	qcom,gsi-loader = "self";
+	memory-region = <&ipa_fw_mem>;
+	firmware-name = "qcom/sm8550/ipa_fws.mbn";
+	status = "okay";
+};
+
 &gcc {
 	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
 		 <&pcie0_phy>,
-- 
2.34.1

