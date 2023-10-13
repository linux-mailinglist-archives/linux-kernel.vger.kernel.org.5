Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A057C8C63
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjJMRjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:39:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA1DA9;
        Fri, 13 Oct 2023 10:39:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40537481094so24942685e9.0;
        Fri, 13 Oct 2023 10:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697218742; x=1697823542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QndAysEcjRZb1ANM+BMG6K7yceyFxrhj3DWZc7EYYLs=;
        b=JfiQkx++FMKHJRq6Br3TZ0tE4xHbvZ4JfZ9z9/hrTwu/dpLOhbZ00vQNI0KkLvGWP0
         IlQHwm0EJaKkcTDFeZwUDutfIknErTAjQj3V23epYHz1hJJUuM0dlCYusCGvKeUsz/TO
         nIgTaOJvgJpgPjmzA3H46bivIrBa4QNtwvHNHU5A7KngXBTBMpsjOyoLXiCBjyTtrwjP
         W8W5QNflAT2TriU2zxB4txvGcN/sANeC/hovYsmJJfRPIcoR20UxqznK4mINaYT9wxg5
         p82TlW5ZNzaSqn/XiZhh+hRW0hI3gY7xPB/3x1giACheEA3okFBs/7/Pog6jJGbvgya0
         Jt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218742; x=1697823542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QndAysEcjRZb1ANM+BMG6K7yceyFxrhj3DWZc7EYYLs=;
        b=t2c0JTK0Hu2WIEjQOn6ha1uj17jvE3Eo0ljPvn4cEjM5OulFPMCbZo8XM9iVU+WY/k
         HVt2wYcO85Q7YxuqqwrXKx657qNBRGH2gVLUYrJt+o0u/33wOIerFxNe+GdkG5tUmMNT
         cbC4woePkg4mb1KhgIqMaNoGhrQw5+mndXECYVfkGDBDij/zIW63/6qeCgnjLUCUCBTC
         9II5/RmlMzisk6OUdCMbAuxJqcMpZSUkrI4NX9KZfDBe7BGGG+VSFoN/6dywmvSjWYXy
         F+T61jcI8opkudASTurmZAOq8bpwRAwmekpGhr5xq1TWl8xTclXYIzhEPW4ZLtFzQumM
         9M1A==
X-Gm-Message-State: AOJu0YwuCLFqPRXNANXfCVXvdSNdzvprSXV6+zycADZHlPtG3Y+3BA5V
        Qr8W9znJECDhM0pQ7iwFiZE=
X-Google-Smtp-Source: AGHT+IF1mAM29qk8bZRJzP6vXfCRhRuuBJGhWciqwhN4wgPzqCfeLy2cphnSv9SoceDrPfWNl0Zrhw==
X-Received: by 2002:a7b:c454:0:b0:403:b6bc:dc83 with SMTP id l20-20020a7bc454000000b00403b6bcdc83mr24373034wmi.38.1697218741480;
        Fri, 13 Oct 2023 10:39:01 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j11-20020a05600c42cb00b0040652e8ca13sm692074wme.43.2023.10.13.10.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:39:01 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/4] cpufreq: qcom-nvmem: add support for ipq806x
Date:   Fri, 13 Oct 2023 19:38:50 +0200
Message-Id: <20231013173854.7399-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
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

The first patch of this series was split to a separate series as it
doesn't depend on [1] and can be applied right away,
[1] introduced some breaking change to function that ipq806x, ipq807x
patch was dropped to permit an easier rebase and merge of both.

This small series adds support for ipq806x qcom-cpufreq-nvmem driver.
Special function are required to make use of the opp-supported-hw
binding by hardcoding custom bits based on the qcom SoC ID.

The qcom-cpufreq-nvmem driver had recent changes to also improve
support for apq8064. Because of this, this series depends on a
just merged series.

Depends on [1].

[1] https://lore.kernel.org/linux-pm/20231010063235.rj2ehxugtjr5x2xr@vireshk-i7/T/#t

Christian Marangi (4):
  dt-bindings: cpufreq: qcom-cpufreq-nvmem: Document krait-cpu
  dt-bindings: opp: opp-v2-kryo-cpu: Document named opp-microvolt
    property
  cpufreq: qcom-nvmem: add support for IPQ8064
  ARM: dts: qcom: ipq8064: Add CPU OPP table

 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  |  4 +-
 .../bindings/opp/opp-v2-kryo-cpu.yaml         | 22 ++++++
 arch/arm/boot/dts/qcom/qcom-ipq8062.dtsi      | 30 +++++++++
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi      | 67 +++++++++++++++++++
 arch/arm/boot/dts/qcom/qcom-ipq8065.dtsi      | 65 ++++++++++++++++++
 drivers/cpufreq/qcom-cpufreq-nvmem.c          | 67 ++++++++++++++++++-
 6 files changed, 253 insertions(+), 2 deletions(-)

-- 
2.40.1

