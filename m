Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378BC7E8CB0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 21:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjKKUta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 15:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKUt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 15:49:28 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A8330C2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 12:49:23 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4084095722aso25285175e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 12:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699735762; x=1700340562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zzxKG8FmQG/QiSceBe9NLjt7GSztbReGb177SqO02RA=;
        b=kX/kZTonsEkLGMYQZDrFfrZTnwo3Sb46n8qZg1mAIRXC0x4PFPiAs4tBGllovOH36Q
         49bkr3ysua4ADJTjbVg9qKKMH13AOx1qWNI+7KGQBNOPR/eDzgVy85oNehpenN+8RsmS
         AtRh8cPMwMwwFrjcRT69aOf38PDpwTAo9/gHqZjVvC4QnI8yylekj63AdhZ4mPO92RxS
         vsARFk3WFCfoQc8L22AtQq7IDgY3PhxXBkfNpnu8sfzPfqH1nyPl5EnNi74LDGbuzYD/
         ykv8NBZBD7JBL/iDgIb7ZpvqYo2c+7p2fIbbcUJMQP2fcBC1jU3CcTnq+TZpioIe+k+q
         zXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699735762; x=1700340562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzxKG8FmQG/QiSceBe9NLjt7GSztbReGb177SqO02RA=;
        b=Cl0Ndob3GVafXgZycC8k/7elx+9oyXVBzCkteyDbOtN+z/0mH1eIVkBP62Gom/yp/X
         BfR0NehXdudxDtP+8SW6HT45EjZA4t8c6QxmkOKJ0EBh/woWgAE6y0zT9YKMqiZSF5Ue
         8vT7K04vGwWtioXft1TH0daGcS+UI2EoaUDyelR2oA2qdGDx9SKcZ/28leVj/WLM4FNr
         Q0Lyy7bE1Rc4tsZCs+DebEkE0QwOd/i8XsW2EPxYzFDfbKWJfi7/f78sTi3Y1gLQ2MvP
         VKV4b1lCDmsJvHxFZCTuLZ2gHPcbHKAtI4jH37ej+FCWyCCkDKesWT0WTm+tTrwAz02h
         zQiw==
X-Gm-Message-State: AOJu0YyMrecPi6r85hDRXPCM1XYe8KXl/nxPHbx1hG7UBOsYwIOFnW/x
        iwFCpkud5KUeXPLdXaXmSBVYxQ==
X-Google-Smtp-Source: AGHT+IGq6iWtEtCacNYFkoPOd1d+bCOaS3T0W8tGIc01caux6dOOsSo2ncPZB/+eM1mLqDqakLRVAA==
X-Received: by 2002:a05:600c:19cd:b0:405:36a0:108f with SMTP id u13-20020a05600c19cd00b0040536a0108fmr2338642wmq.41.1699735762281;
        Sat, 11 Nov 2023 12:49:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b00407752bd834sm3121226wmq.1.2023.11.11.12.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Nov 2023 12:49:21 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 0/3] mailbox/arm64: qcom: rework compatibles for fallback (continued)
Date:   Sat, 11 Nov 2023 21:49:13 +0100
Message-Id: <20231111204916.35835-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v4
================
v3: https://lore.kernel.org/linux-devicetree/20230322174148.810938-1-krzysztof.kozlowski@linaro.org/
v4: https://lore.kernel.org/linux-devicetree/20230327140752.163009-1-krzysztof.kozlowski@linaro.org/

Important: v3 and v4 are quite different.

v3 did not reach full consensus, so I prepared v4 doing a subset of the
original change. Then DTS pieces from the v3 were applied, without bindings
and driver.  OTOH, bindings and driver were applied from v4.
So we have DTS from v3 and driver+bindings from v4.

This leaves us in inconsistent state and several warnings:
['qcom,msm8976-apcs-kpss-global', 'qcom,msm8994-apcs-kpss-global', 'syscon'] is too long
['qcom,msm8998-apcs-hmss-global', 'qcom,msm8994-apcs-kpss-global'] is too long
['qcom,sm6115-apcs-hmss-global', 'qcom,msm8994-apcs-kpss-global'] is too long
['qcom,sdm660-apcs-hmss-global', 'qcom,msm8994-apcs-kpss-global'] is too long
['qcom,sm6125-apcs-hmss-global', 'qcom,msm8994-apcs-kpss-global'] is too long

Bring back changes from v3, to align bindings and driver with DTS.

Changes since v3
================
1. Narrow the scope of the patches after feedback from Dmitry - only few
   variants are made compatible.

Changes since v2
================
1. Split fixes to separate patchset which is now dependency:
   https://lore.kernel.org/linux-arm-msm/20230322173559.809805-1-krzysztof.kozlowski@linaro.org/T/#t
2. Add Ack
3. No other changes, as discussion with Dmitry did not reach conclusion on incompatibility.

Changes since v1
================
1. Rebase
2. Make msm8994 fallback for several variants, not msm8953, because the latter
   actually might take some clocks.
3. Two new patches for SDX55.
4. Minor corrections in bindings style.
v1: https://lore.kernel.org/all/20230202161856.385825-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  dt-bindings: mailbox: qcom,apcs-kpss-global: drop duplicated
    qcom,ipq8074-apcs-apps-global
  dt-bindings: mailbox: qcom,apcs-kpss-global: use fallbacks
  mailbox: qcom-apcs-ipc: re-organize compatibles with fallbacks

 .../mailbox/qcom,apcs-kpss-global.yaml        | 62 +++++++++++++------
 drivers/mailbox/qcom-apcs-ipc-mailbox.c       | 10 +--
 2 files changed, 48 insertions(+), 24 deletions(-)

-- 
2.34.1

