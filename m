Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8EA7A319C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 19:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbjIPRPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 13:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjIPRPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 13:15:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2230018E;
        Sat, 16 Sep 2023 10:14:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so26613005e9.1;
        Sat, 16 Sep 2023 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694884497; x=1695489297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwVNVtyPzvOH/tkYL9HnHQoBXP1en7ett6SkkJcLNRw=;
        b=VJNf4SWQgb9AjGwcUSstXXT2qb3dDQhz5qDrAuQVbEQPI862vmOefFCZua6BAOZQ29
         MZpBiddf3FL3T9JQlrlpp31CwA5vG+zJkkq2irrUDdI3Q7t5l20+xngMEcNhnIQG3TRc
         cWa68neS6L7weduywwkOwt4siHGhFg1byYr0A9jEfLFCnwMolTJ+U9CdO5H8PH2I3AFQ
         Vd/ESkN/YFpRQnhHd+39xP1lgzLERxEh6ZGUrkZvXBW4JTgYvj+KfGZWYS4azIuPBtaf
         0HCT9JgC9gcfHaWM9oin6QYedU+yWxCzoYOvlu7WUEx7N/WOyMM5YbfKKz0dOTskeKlD
         1xpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694884497; x=1695489297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwVNVtyPzvOH/tkYL9HnHQoBXP1en7ett6SkkJcLNRw=;
        b=K+dOKkzYZYL/qbcR4rwDqXUJ95OBIk0CQSnzOLdU3d1VJttwgbvTAD1aZWcVzB5xqI
         /X6mcmXBteZXm/NN0T9GTvLBwWGYaI/hg6fgBg/rtEFhYMejenpcEj6eO50rCR1/rLUv
         QNCLXqZFG8mO5W/+AxT2D8Ppi2fukACzF6yRiEa2649nw+qY7+5A18jj+zJTbwUlvnbl
         ytglhU4aoPTKDWLI+Z+H0fKgQk8mZBdxtcLVSGM9HdPcTyGSN5kertkCEGDGGc7l178C
         htXMLxAAoE/0z8tucBFnq3EMJxdEqxhV79bnjlrEGJ7Q0L8RIFYEkrSStqESM/vCIGyl
         o92Q==
X-Gm-Message-State: AOJu0Yx5VMosoIAic0h9iCFhoMyksOcMuGkVeoz9REkYGJKRixF6RzKM
        kzK5iEIeBJVSuE2gL51hrgc=
X-Google-Smtp-Source: AGHT+IFnnFguUaQbotAYvoYcfnDGoV9RCr3dIgk2DtaFbTSd+bgQ7zbHQzddPeuP9lCgw4H/uv4bCw==
X-Received: by 2002:a5d:5267:0:b0:31f:c89b:91fc with SMTP id l7-20020a5d5267000000b0031fc89b91fcmr6130430wrc.7.1694884497140;
        Sat, 16 Sep 2023 10:14:57 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id w4-20020a5d6804000000b003196e992567sm7712395wru.115.2023.09.16.10.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 10:14:56 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v6 0/3] clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
Date:   Sat, 16 Sep 2023 16:00:43 +0200
Message-Id: <20230916140046.7878-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series fix a current problem with ipq8074 where the 2 uniphy
port doesn't work in some corner case with some clk configuration. The
port to correctly work require a specific frequency, using the wrong one
results in the port not transmitting data.

With the current code with a requested freq of 125MHz, the frequency is
set to 105MHz. This is caused by the fact that there are 2 different
configuration to set 125MHz and it's always selected the first one that
results in 105MHz.

In the original QSDK code, the frequency configuration selection is
different and the CEIL FLOOR logic is not present. Instead it's used a
BEST approach where the frequency table is checked and then it's checked
if there are duplicate entry.

This proposed implementation is more specific and introduce an entire new
set of ops and a specific freq table to support this special configuration.

A union is introduced in rcg2 struct to not duplicate the struct.
A new set of ops clk_rcg2_fm_ops are introduced to support this new kind
of frequency table.

Changes v6:
- Small rework of best_conf selection to mute Sparse warn.
Changes v5:
- Rework selection logic with suggestion from Konrad
- Return -EINVAL and WARN if we fail to find a correct conf
Changes v4:
- Drop suggested but wrong re-search patch
- Move everything to separate ops and struct to not affect current rcg2
  users.
Changes v3:
- Add qcom_find_freq_exact
- Drop re-search on rcg2_set_rate
- Rework multiple conf patch to follow new implementation
Changes v2:
- Out of RFC
- Fix compile warning from buildbot related to F redefinition

Christian Marangi (3):
  clk: qcom: clk-rcg: introduce support for multiple conf for same freq
  clk: qcom: clk-rcg2: add support for rcg2 freq multi ops
  clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf

 drivers/clk/qcom/clk-rcg.h     |  24 ++++-
 drivers/clk/qcom/clk-rcg2.c    | 167 +++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c      |  18 ++++
 drivers/clk/qcom/common.h      |   2 +
 drivers/clk/qcom/gcc-ipq8074.c | 120 ++++++++++++++---------
 5 files changed, 286 insertions(+), 45 deletions(-)

-- 
2.40.1

