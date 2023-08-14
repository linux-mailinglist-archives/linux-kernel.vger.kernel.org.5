Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6763F77B6FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjHNKlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbjHNKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:41:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBE6E58
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:41:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99c4923195dso567165366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1692009684; x=1692614484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jSw4csycOwpeCvjk1+out8qA4MHRdLgT4XjSRFi9YI4=;
        b=raD8xCmJS5LggmRmeEcYRS9BpLx62slvvmJlaJmLv3zXqb2NxLl83bXkWTa39H2ai/
         1K1tAruj0xQezMsnjHOd4AFYg15nI+uP6swbX78Vd/bmydsYxHVV7ZpyD07eZ8bQ3AYm
         o0xnJE3sTA6YXVuGTOBCa5MW/D5KnrH9mqlKMZMlIbae0Pq8DIduIwtFciGsEIUoiWo+
         XFxUmKIb1etw6Lavv9dKY72eio1Ke47t9i8ob8kDUkhbwV4QAjINwzE6Bn8ryUGP4l+c
         xmQuoQDB0DJ1MB61ouBwFf9v43/M/0adbvH/vqz5YpX526T1z0WGGAd+WxnR8A0PMvAg
         sPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692009684; x=1692614484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSw4csycOwpeCvjk1+out8qA4MHRdLgT4XjSRFi9YI4=;
        b=Ap3kCZht8uWVeyCB04c/Oi4Q7n7feCWOUlYk3rGbaymT9UVUCjpduMPxkIgHeQs7Jm
         EFHp/xNdxzoGFStIXaCjPnnqF0THeWPZF6Ih8qzVuMyOBjywvB7Wft7fH1bdvYq474Tp
         vrzCWzx3CntyzE6xC67ppDWAS4L02vrTjKqTsl8Md81709qwV/YzOORq4Xhy8ID4UbiR
         zIN3FUkQHdZYRuTK852ixEtcvS9ApzzPrXKkWITUqJieOwBQ1Jsr5Xv1LFn5aAcrUXOY
         PASz2fERlPc2PkxU21x317I8ftyxPs/NutNMdV1brkVy9GDzuXscQzl4QGdCDMs5EUdi
         l8UQ==
X-Gm-Message-State: AOJu0YyuHPw2u6ux7G3/4pniukJLW2EQQYCZQThemwujQsgFZTRmy1Rz
        E9buJZjDGlG82aXoy9V4G3nyGQ==
X-Google-Smtp-Source: AGHT+IHIAdYTWJ7gkjJvy6BoDj+4PyTFlCuCnts+3w0Zi2xdzcmv4DYXC1DwBbhekY/xufKSsoDI0A==
X-Received: by 2002:a17:907:801f:b0:992:b3a3:81f9 with SMTP id ft31-20020a170907801f00b00992b3a381f9mr6271991ejc.71.1692009684062;
        Mon, 14 Aug 2023 03:41:24 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-129-24-cbl.xnet.hr. [94.253.129.24])
        by smtp.googlemail.com with ESMTPSA id qw4-20020a170906fca400b009934707378fsm5486586ejb.87.2023.08.14.03.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:41:23 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/2] dt-bindings: clock: qcom: ipq4019: add missing networking resets
Date:   Mon, 14 Aug 2023 12:40:23 +0200
Message-ID: <20230814104119.96858-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the missing networking resets found in IPQ4019 GCC.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 include/dt-bindings/clock/qcom,gcc-ipq4019.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq4019.h b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
index 7e8a7be6dcda..fa0587857547 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq4019.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
@@ -165,5 +165,11 @@
 #define GCC_QDSS_BCR					69
 #define GCC_MPM_BCR					70
 #define GCC_SPDM_BCR					71
+#define ESS_MAC1_ARES					72
+#define ESS_MAC2_ARES					73
+#define ESS_MAC3_ARES					74
+#define ESS_MAC4_ARES					75
+#define ESS_MAC5_ARES					76
+#define ESS_PSGMII_ARES					77
 
 #endif
-- 
2.41.0

