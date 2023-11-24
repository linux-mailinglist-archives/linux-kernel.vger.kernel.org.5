Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6523D7F7CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjKXSRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjKXSRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:17:16 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4F71BD8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:17:22 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7b37dbf896eso24080639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700849842; x=1701454642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLADupMmiOI/CuFkP9Hg2IYkHX7ypUPKgw9zZKAkI2A=;
        b=fpvJBbKCHlHCjgDxug3KzmpK54wUIavyxF/EenC9iU7ATUZI1Zd5FMaUNne1s+2GP5
         8SUuebjzGSeK66Mt6vbrGhWg1miFT84FjcCPzW16oO3bPhhZo7EQjycAePsUawRagCx4
         TMekY+kPnraeE0gxcA4m0rRVhLShUpfCLZDyN8kxXFqlq0P6A8FBW59eYIZvV9pgp+gL
         MtjwAItv+7iiC+5QfgsdQZSDq76llxohmD1LYH9E7hJGDq5kAWPAcku1MiSyutcwlsto
         RBS9xxcTIm5OsK/YoEZK8nHJkW8ZWhRWtlx1nHkp0i+lfymTdG/Or2TnTdTXmqkZq4uH
         kXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700849842; x=1701454642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLADupMmiOI/CuFkP9Hg2IYkHX7ypUPKgw9zZKAkI2A=;
        b=H6RSLnAkrMCF6guqkJkYU76GvyKUfjSpwcz//fp+f2zQT4edz49APQEIZKRBiU94JV
         hFRhudwK0TyaopMG6yWYAIxrE/fd4N54CLQBfzTBS1UzLOQbUkSJMpj9Jvq1WpzljTbE
         0d4rIPx3/iAYATKHVE3HQMcA0C9q++CIHh1UWpEl9mMuJUjlTNtaPaUXObzhG3TMyHIP
         Eh/qMpYJPvR4q5wai+9vWABqpydKOeC6BocQzP4+uEtH8XRtriU+eGUOSDEov0/eKB94
         vu2oJ7CTyBgFafLPFlbKqrwAYJ/TBNUd9wLxlfA/+0UjqLWtjPS4Y1ACx9ZQYiAMw4cN
         ShWQ==
X-Gm-Message-State: AOJu0Ywwetm19hvu6NO354sPMTg7ag7I23j+qkDsD2U2IDBvN05M7ydz
        bAV0zmrftaL+ycbK5Y5OuYQ65Q==
X-Google-Smtp-Source: AGHT+IE8paLRQ1z+VbJS//0j9s8uSZfLnbn4pb5jVt8VW26qZ7k45wdDaW9nQ3lb5QTLl6q1IH2Alw==
X-Received: by 2002:a05:6602:3351:b0:7b0:2027:efda with SMTP id c17-20020a056602335100b007b02027efdamr4350310ioz.5.1700849841819;
        Fri, 24 Nov 2023 10:17:21 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id et21-20020a0566382a1500b004665cf3e94dsm937031jab.2.2023.11.24.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:17:21 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, agross@kernel.org
Cc:     mka@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: qcom: enable IPA on sm8550
Date:   Fri, 24 Nov 2023 12:17:16 -0600
Message-Id: <20231124181718.915208-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add the basic DTS information for supporting IPA on the Qualcomm
SM8550 SoC.  Enable IPA on the SM8550 QRD platform; GSI firmware is
loaded by the AP in this case.

					-Alex

Alex Elder (2):
  arm64: dts: qcom: sm8550: add IPA information
  arm64: dts: qcom: sm8550-qrd: enable IPA

 arch/arm64/boot/dts/qcom/sm8550-qrd.dts |  7 +++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 39 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

-- 
2.34.1
