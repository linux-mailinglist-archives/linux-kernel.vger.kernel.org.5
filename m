Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD39788CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbjHYPjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243453AbjHYPid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:38:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110FB2680
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50098cc8967so1695889e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692977906; x=1693582706;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K2FKEkZyjj6V24SjjO4zB+B8wq1XPagbrAFque91J1g=;
        b=IPK0r5bgvTcFpuyGIsjCXpkY6obtCTu7AKRXRuMtmFYedEOD6rlMgDWl40nFseiTS8
         UxmrMucqgZHXgDcAnO2KH3xUcDuY3J7yiEL2lx7prWNdJk0g6aONWKHXlbPTECwKlVOh
         YYBQ5kORyn7wmmtXzMJGhQLPzPPuXpE0yVY7564EkFWzXMmCazpo+HWSbUwghZM525lU
         ci07GFynt1GTVKA2TD0rakuK7w3jWZXiiWOunX3+lmZ1wZtKbZ7It2blW0tdfSZKDGW2
         cPvfQVOmogIu+VfhPbG/W2KBf/Z9lx0Rng720ZdXSCqUO/LfGzCtm3WEDrZp4OHivC7r
         2npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977906; x=1693582706;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2FKEkZyjj6V24SjjO4zB+B8wq1XPagbrAFque91J1g=;
        b=CEIwOEL7fFI21Nhn1dTXFTmQbWsTi+6LX0nQcORkUSQiCqeKEE682LCMXlfkOE/m7M
         qRxjaHHXbh02hIyL0j2DUrdTtsJdwtaOP0Hy/Kbx0cd2XTqrcpHLzdQW1ErZXuz12twb
         9/VrwBAoi+h942BuU2RRW/T4ZMBj2POra6aF4zX9rP+T+8Uuo/YQR6JzFicjhKSckPhT
         IvlC+J5k081XYW4oO3l1yWIJDoDJEDSpI6DvWFsbKz+wzMfFSnHmC6msR1+CImn6b72o
         GVikJ1cUnw9s6F6OdirOxCVpW0nf1/KRih/AbztAnubgG8G+ilSkUUKeM2FvhaF060eX
         +Vag==
X-Gm-Message-State: AOJu0YzDNFr+SUkwRuVCSXj0DQZgjpYHSItdK+FQ7eO3gGK7+AhfSV3r
        lri4Rna5pmcdOaWjOSbpmLpxXQ==
X-Google-Smtp-Source: AGHT+IHQtHnr5jxIvT8AA0w5KTbCxwHVQC0UgS+yKaBE6QNGvc4imLosS79IY006zuyT9fdUXDwr6w==
X-Received: by 2002:ac2:4c42:0:b0:4fe:5741:9eb9 with SMTP id o2-20020ac24c42000000b004fe57419eb9mr17276734lfk.49.1692977906194;
        Fri, 25 Aug 2023 08:38:26 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id y17-20020a197511000000b004fe432108absm326002lfe.182.2023.08.25.08.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:38:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v4 00/10] Fix up icc clock rate calculation on some
 platforms
Date:   Fri, 25 Aug 2023 17:38:22 +0200
Message-Id: <20230726-topic-icc_coeff-v4-0-c04b60caa467@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO7K6GQC/4XNzQrCMBAE4FeRnI3kp25bT76HiLSbrV0oSUm0K
 NJ3N+1NRDzOwHzzEokiUxKHzUtEmjhx8DkU243AvvFXkuxyFkYZq0oD8hZGRsmIFwzUdbJVe+v
 2harbuhN51TaJZBsbj33e+fsw5HKM1PFjvTmdc+453UJ8rq+TXtrfB5OWSloNGmpQla7wOLBvY
 tiFeBULNpk/gMlAhbVGwBJUCV+A/QPYDDgiqAoH6Jz5AOZ5fgNbviO7RgEAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692977904; l=2939;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=CdOriWcUvthtCWlJtT0JAJ5c9j3yTZVeonxd9KIr+Bk=;
 b=CP0z8jHAcPGoQxuA32r6loBtrG2IQx/BEkUkS6+Eq6hfPewqhyGIQ3B+QXG9utgUihHIMrTLQ
 iFzCn8DvMzeCW0P4g4O3Z/4rdVkLHKL/ePX88v8k0WS1LZNwTBWwzEg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain platforms require that some buses (or individual nodes) make
some additional changes to the clock rate formula, throwing in some
magic, Qualcomm-defined coefficients, to account for "inefficiencies".

Add the framework for it and utilize it on a couple SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v4:
- Rebase on next-20230825
- Move node bus clock rate variable kerneldoc addition to the correct patch
- Link to v3: https://lore.kernel.org/r/20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org

Changes in v3:
- Allocate the node bus clock on the stack, as dynamically allocating
  it actually wastes memory on systems with 64-bit pointers..
- Add the node bus clock struct member in the correct patch
- Simplify using coefficients by only checking the node-level ones, and
  setting them equal to the bus-specific ones at probe if absent
- Fix building on arm32
- Mention some references to the related downstream code
- Link to v2: https://lore.kernel.org/r/20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org

Changes in v2:
- Use the (arguably less favourable but necessary for precission) 100/x
  instead of x/100 for ib coefficient, update values in consequent
  patches to reflect that
- Rename "_percent" to "_coeff" because of /\
- Add the necessary code to support per-node clocks
- Add the necessary code to support per-node coefficients
- Hook up the CPUSS<->GNoC clock on QCM2290
- Update EBI node on QCM2290
- Link to v1: https://lore.kernel.org/r/20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org

---
Konrad Dybcio (10):
      interconnect: qcom: icc-rpm: Add AB/IB calculations coefficients
      interconnect: qcom: icc-rpm: Separate out clock rate calulcations
      interconnect: qcom: icc-rpm: Let nodes drive their own bus clock
      interconnect: qcom: icc-rpm: Check for node-specific rate coefficients
      interconnect: qcom: qcm2290: Hook up MAS_APPS_PROC's bus clock
      interconnect: qcom: qcm2290: Set AB coefficients
      interconnect: qcom: qcm2290: Update EBI channel configuration
      interconnect: qcom: sdm660: Set AB/IB coefficients
      interconnect: qcom: msm8996: Set AB/IB coefficients
      clk: qcom: smd-rpm: Move CPUSS_GNoC clock to interconnect

 drivers/clk/qcom/clk-smd-rpm.c             | 16 +++++--
 drivers/interconnect/qcom/icc-rpm-clocks.c |  6 +++
 drivers/interconnect/qcom/icc-rpm.c        | 76 +++++++++++++++++++++++++-----
 drivers/interconnect/qcom/icc-rpm.h        | 15 ++++++
 drivers/interconnect/qcom/msm8996.c        |  8 +++-
 drivers/interconnect/qcom/qcm2290.c        |  9 +++-
 drivers/interconnect/qcom/sdm660.c         |  4 ++
 7 files changed, 115 insertions(+), 19 deletions(-)
---
base-commit: 6269320850097903b30be8f07a5c61d9f7592393
change-id: 20230726-topic-icc_coeff-b053d5409b9f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

