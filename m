Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723AE7C8829
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjJMO7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjJMO7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:59:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AEBBE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:59:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40666aa674fso22768255e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697209179; x=1697813979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1Vc2Kb+fvGrXwzKItM5mtCeGvvlBBWnxemcb7WGq+Y=;
        b=e16IAty5ZiZZG2yP+aMbDjcWSye/aDILmq7AgNkkdewW3+oSZUaCdo4VF45OPC5iez
         /CRLGnNjmqsRGem4GulIusGWMFIEzQ3uJPdkdLce4Xde/dePh+JiaYPuq3HYKPmAnGjO
         tY3tj6URGKiiyoDxDIrNgXdWFv1lKRX+Pm0HiCfLxiF1hTu9pMi1GA3NdyQQIM12h4uH
         m8a9cv/PPTb+yfaGIzIhKy9sK6NKfaFuaCbdTqxq30WzQS68J/q8cJt+WqytLw7/Gusl
         5tfh+THOA82n0dqvQnDvHwvApu40vee8aisWUynq6724Ktl0zMxwnI3Oo9RiIipuYUsK
         5gWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697209179; x=1697813979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1Vc2Kb+fvGrXwzKItM5mtCeGvvlBBWnxemcb7WGq+Y=;
        b=s/oJ5y3//IvQTGh3aHUJzYNrkYlji5KP3c8Gv0j6tQEaDs7eeRmxm7cEdE7zJJYq2b
         OdgD5YiUa1cAufQZ0RGMrkNPB0rCoET9FmLR91RdYOFD/qwrzJHSvBWzwO3gVPWnlDZF
         R4rfA3KWqYorY6PUC6XZbuw4RVCldmj95WpB5yz6bDDZuSOi/Eb6y+jtOwguukFmq2ZI
         cPQH1Q1K3QhYKH4uwNFltSQe//TgGqCJI3sEoztYsyOZp1OPEReLqXIeg9MSc28YwiiF
         q1ThRIrDdO6/Brj7EOO1l6b7haX+1iGQVo4I17SeK+DxJ48V41Md+z+u48X7KZfLmeBd
         b4uw==
X-Gm-Message-State: AOJu0YwpEMrK6TCekNskRBms0E4BFuaWssLDyrRYnkatvuS1OM4WASac
        xpCFTxS++XZ6RMyb33G6NUiDlQ==
X-Google-Smtp-Source: AGHT+IGyacFrN5NZgj9skR4No00lFAHiwfkqiNFuBFZhKR/WSNVB9jxcDW9rQnvv9wAEOLzc2489pA==
X-Received: by 2002:a5d:58d4:0:b0:32d:a13e:acce with SMTP id o20-20020a5d58d4000000b0032da13eaccemr606242wrf.13.1697209178741;
        Fri, 13 Oct 2023 07:59:38 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id dh13-20020a0560000a8d00b00327cd5e5ac1sm6428267wrb.1.2023.10.13.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 07:59:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/2] pinctrl: qcom: lpass-lpi: allow slew rate bit in main pin config register
Date:   Fri, 13 Oct 2023 16:59:33 +0200
Message-Id: <20231013145935.220945-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v2
=============
1. Reversed xmas tree
v1: https://lore.kernel.org/all/20230901090224.27770-1-krzysztof.kozlowski@linaro.org/

Description
===========
Prepare LPASS (Low Power Audio SubSystem) pin controller for newer
Qualcomm SoCs.  The patchset does not bring the newer SoCs yet, but only
re-organizes the code for future changes.

I understand that patch #2 (adding flag) makes little sense without
actual user of that flag, but such user I cannot post yet.

Dependency
==========
Context depends on my previous fix:
https://lore.kernel.org/linux-arm-msm/20230815110625.317971-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  pinctrl: qcom: lpass-lpi: split slew rate set to separate function
  pinctrl: qcom: lpass-lpi: allow slew rate bit in main pin config
    register

 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 69 +++++++++++++++---------
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h |  7 +++
 2 files changed, 52 insertions(+), 24 deletions(-)

-- 
2.34.1

