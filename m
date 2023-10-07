Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2867BC829
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 16:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjJGOBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343979AbjJGOBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 10:01:05 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEB9B6;
        Sat,  7 Oct 2023 07:01:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3296b87aa13so1299585f8f.3;
        Sat, 07 Oct 2023 07:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687263; x=1697292063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSyejUmIYUE/ugRzpClD0C9mW54tD2QmJtfXKPfskwA=;
        b=Winbecs3XtfFJBD6YRpgzeEHPN9b9fhATawleORt+UMR+aqYYXT3B/m7IxXHxUgKCS
         k56eMuVZZK/DQox0ZR4CngRdvXvBPaxAf9v7lEg4nXgxbearng8aS51Jy/kJGpS0oaN/
         AUpd8JP7GcfEo2YDPoAxSNpeuX75Iju6LB+dLd//cLhvg/tGJ8IPteovWniNs79YQAoH
         xTmtmHSYSxRXCI987WPLG5pLJKiXdcX4T1U1DW1qCN+OeWyJ4A4fvu6DHM4tvfMyHWvu
         PlpM9wKF4vt/1Kf0Zk7Yrp1fy8x2qjIs46JcxCLt500cOIFYMu0+bUFHq+BWx5Iiokfg
         E2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687263; x=1697292063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSyejUmIYUE/ugRzpClD0C9mW54tD2QmJtfXKPfskwA=;
        b=uqOUSqvkPqs7/rMwloQnLanNTaBefwauaL7WKgqUJxL1bKuxnyrt0CM/oK3m8WfI0X
         H5bhqyKrFtk4bFL/SOP+KhC2mj+qu0fajdjNxaDf/dcg0UB2Sssfs4Ux5ViTH7CwnLXx
         zbj+1ksgG5lUlsczdPhWMMoaEKt81ngNV8ixp+7pBjr469XAvq+nNTbLUEjjL+geiVxp
         y6pt97Wr/TRMBi3BgV1/sqC374/ZbjlcKL8vSUx42wriLc4gLu6jfVHzpX7v5wMbKnDo
         2LvbhZ0gwrdhGMAJ9LeC5U7shYjDs2JFLb/9ZdNmtEiwg3yvRqUBV0zI+ZVJfCABhAmq
         PvLA==
X-Gm-Message-State: AOJu0Yxa/gQ2QVgMK12SaRymX3rI+CzjtHSs/4EIiJbyP5OtyNM+9klz
        bNU6gu4l8085mBWLDsbhxVg=
X-Google-Smtp-Source: AGHT+IGU9FhqUnrVQzrFhL1KtxM6QZuUbG2ri1efmrRV6OD4JzIZ4VoDEnddJbWUGYgeWXdqywDcEA==
X-Received: by 2002:a5d:5607:0:b0:31c:6591:d415 with SMTP id l7-20020a5d5607000000b0031c6591d415mr9239447wrv.39.1696687262498;
        Sat, 07 Oct 2023 07:01:02 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([77.22.112.104])
        by smtp.googlemail.com with ESMTPSA id q8-20020a05600000c800b0032415213a6fsm4332043wrx.87.2023.10.07.07.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:01:02 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Joe Mason <buddyjojo06@outlook.com>
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        hexdump0815@googlemail.com, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, David Wronek <davidwronek@gmail.com>
Subject: [PATCH 4/7] phy: qcom: qmp-ufs: Add SC7180 support
Date:   Sat,  7 Oct 2023 15:58:28 +0200
Message-ID: <20231007140053.1731245-5-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007140053.1731245-1-davidwronek@gmail.com>
References: <20231007140053.1731245-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC7180 UFS PHY is identical to the one found on SM7150. Add a
compatible for it.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 514fa14df634..1919b8bf5a85 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -1787,6 +1787,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sa8775p-qmp-ufs-phy",
 		.data = &sa8775p_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sc7180-qmp-ufs-phy",
+		.data = &sm7150_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,sc7280-qmp-ufs-phy",
 		.data = &sc7280_ufsphy_cfg,
-- 
2.42.0

