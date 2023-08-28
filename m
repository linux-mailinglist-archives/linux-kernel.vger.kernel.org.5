Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C06778B862
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjH1T2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjH1T12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:27:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A544CEE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:27:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31dd10c2b8bso476116f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693250822; x=1693855622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+I1TnLNwxszbN8M9umRNZG7t7BQhMYgFfgmkLe46H00=;
        b=zL2r5Fa2OvovZvTJsUmtRlvcM7/4bDbHwz/+SAizjrHGB3/bwjeR2RJvwhXrRdpMxb
         RoqIv+AwrqiCQ0a7aQ+HPnVTTq5Qqa8zaWkc16WVSH4vELEvlDQUb/FPRQXBOccEcAgB
         xSDgMDQqG4YF4Bj+o1fsth7TGz8marxRdL1FQaFxCcvfENBHV5DeLdEDKG+lEcSNUXnO
         oT7RIOYq6Z/rRrOINKZUD3uEI7LQ+UyaLZ3nHlYALsxIUeUOgXvUHnYOpx7h1J9phke5
         ByaenlZwxJa0vsq6DZnNhB9Ecind5uYaCRv2r6K88FeuG7Q3wphNehOj5IqZhWcxEB/v
         Dtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693250822; x=1693855622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+I1TnLNwxszbN8M9umRNZG7t7BQhMYgFfgmkLe46H00=;
        b=JFTg7uNzmkXZ/l6tslNsuqOBWcK8ZHE1vb4uJhVwoHce3EI8JqhUUBnbyf3lEgigxm
         YBeb1h8jlCrU+dZnJa/r+C9SB04DJtqvqVyYc2jEPJXBFoV7a5cDD81E529r5S3cxjTV
         yqcMfmZnZpky6Jfmcv7mnxUBpO7fPpgh1fsXaylYbv4UpeAuqoz2inVUQTEiDia2Ct8p
         HiOb/wy9VPubQpjlviXJkwrfKYRwt1n/gBoKiJPI+eJKjtRDbxmtw6fsKnZM52DfP62L
         N7Vr8IaJ0rq1ycs08s/VFYJpF7K+Ws8vUJeMpUBxABnQBcKZ1w4pcQ4WqP1anAd0vcVA
         ziRg==
X-Gm-Message-State: AOJu0Yz0XnRPTEvPw3BAw0qg1BXm16w+/ykg/Px5Cg0rqFw8Ce9T6hoN
        VZEB4ZyQzxQHOt3YLsRgvnhOtg==
X-Google-Smtp-Source: AGHT+IFRafmDLjtEsJDP5s4bwx95AqWgutFAhLrZ8P//xmtwHnCubkYIeaz/6yYQH4/b3yQUfIZ6EQ==
X-Received: by 2002:adf:f112:0:b0:317:5e91:5588 with SMTP id r18-20020adff112000000b003175e915588mr21843348wro.3.1693250822360;
        Mon, 28 Aug 2023 12:27:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8bd:7f16:d368:115f])
        by smtp.gmail.com with ESMTPSA id i20-20020a5d5234000000b003141f96ed36sm11435319wra.0.2023.08.28.12.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:27:01 -0700 (PDT)
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 00/11] arm64: qcom: add and enable SHM Bridge support
Date:   Mon, 28 Aug 2023 21:24:56 +0200
Message-Id: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SHM Bridge is a mechanism allowing to map limited areas of kernel's
virtual memory to physical addresses and share those with the
trustzone in order to not expose the entire RAM for SMC calls.

This series adds support for Qualcomm SHM Bridge in form of a platform
driver and library functions available to users. It enables SHM Bridge
support for three platforms and contains a bunch of cleanups for
qcom-scm.

Bartosz Golaszewski (11):
  firmware: qcom-scm: drop unneeded 'extern' specifiers
  firmware: qcom-scm: order includes alphabetically
  firmware: qcom-scm: atomically assign and read the global __scm
    pointer
  firmware: qcom-scm: add support for SHM bridge operations
  dt-bindings: document the Qualcomm TEE Shared Memory Bridge
  firmware: qcom-shm-bridge: new driver
  firmware: qcom-scm: use SHM bridge if available
  arm64: defconfig: enable Qualcomm SHM bridge module
  arm64: dts: qcom: sm8450: enable SHM bridge
  arm64: dts: qcom: sa8775p: enable SHM bridge
  arm64: dts: qcom: sm8150: enable SHM bridge

 .../bindings/firmware/qcom,shm-bridge.yaml    |  36 ++
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |   4 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |   4 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |   4 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/firmware/Kconfig                      |   8 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/qcom-shm-bridge.c            | 452 ++++++++++++++++++
 drivers/firmware/qcom_scm-smc.c               |  20 +-
 drivers/firmware/qcom_scm.c                   | 106 +++-
 drivers/firmware/qcom_scm.h                   |   3 +
 include/linux/firmware/qcom/qcom_scm.h        | 109 +++--
 include/linux/firmware/qcom/shm-bridge.h      |  32 ++
 13 files changed, 712 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/qcom,shm-bridge.yaml
 create mode 100644 drivers/firmware/qcom-shm-bridge.c
 create mode 100644 include/linux/firmware/qcom/shm-bridge.h

-- 
2.39.2

