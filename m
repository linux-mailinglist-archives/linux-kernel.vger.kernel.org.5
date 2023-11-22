Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB07F5434
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbjKVXJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjKVXJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:09:17 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0257A10E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:09:14 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7b34ddcc625so33925639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700694553; x=1701299353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zZ8JfNM2OMcgGqYzXA4poHKbJA5XfysSinrC2/AyhA=;
        b=jdDYayGdZgMUaezeNXDhadUTmPAgbIyiPX1K/D8ryz/xR2RSW2+Y4P8E3DGCAwNjaN
         rqxRV5EM1dx1ad9o71rpzRW3kGNQ/9E3jenb5pYu5VjpWrSaC8kcsJhBK9DmplaMi9l9
         Vutvfn+yIVigWCmzLsXMzy6NksTE4jIRcPWRJTIEA9Gv/yk+YxqJ25cs4ZrUOBq9gp8t
         2SBT3jPONXVuPcQAkoYPyE2rHh9cnGZe7NZp39kTeprt2czeXbgzWph8A5KEEjdPJXhh
         9WcJn2l3DZrZBcrAeWP3ngwsVJs5sTHjGWCEO/KrnfKIz6LLAS1oPDU3wHaoL+bZT8tc
         8etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700694553; x=1701299353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zZ8JfNM2OMcgGqYzXA4poHKbJA5XfysSinrC2/AyhA=;
        b=Tr2BReJNvzsNKK0Sq+ryY/gUulYqsNx25PTxLa9HFhay4HGMUfIZTVAPmDp83TF8+y
         UepgCmU69wckMIsWuINTmoGTeb9DamVnxleO2sp3l3TDIPfObm80kSWUgm5fvUIh7tGB
         /qLOoftARzYMXB6LBZPP1PGVsuYjXAnDm9rzuVfDAkzLRfR4tRc4S2zUgMUpwlKvtF/M
         4VzSj7+YjeX/y44sa1qwW0DwUQWAKroSnGmyPFNAFXt4QUjYZHP7i4wu0gglXu8YXW6y
         8zMOcrr+8jodqMTrnBX4kA4/krIbJLwdh4TT5XgZJxtckA8AXJhyjBXuImqtehCk+uhC
         7Nwg==
X-Gm-Message-State: AOJu0Yxwd9gdLGoV42vI7+Dj1Q4XJteMrJ1O/MR9ULO2SSSy+whBXPLG
        YR/bCh4e7kUW0puUXWH8zIGzhA==
X-Google-Smtp-Source: AGHT+IGfvFvNtX9o31O98ivh6qmCBRyGBdUZt6yHaaXOlhuOzKQhxaFCldwPqv8IM4y4OZJkMkipuQ==
X-Received: by 2002:a05:6602:4f03:b0:79d:1b4e:fb8a with SMTP id gl3-20020a0566024f0300b0079d1b4efb8amr813367iob.9.1700694553309;
        Wed, 22 Nov 2023 15:09:13 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id fm29-20020a0566382b1d00b0043a20ad93c8sm117754jab.41.2023.11.22.15.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:09:12 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mka@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: ipa: add IPA v5.5 support
Date:   Wed, 22 Nov 2023 17:09:04 -0600
Message-Id: <20231122230909.895482-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds IPA support for the Qualcomm SM8550 SoC, which uses
IPA v5.5.

The first patch adds a new compatible string for the SM8550.  The
second cleans up "ipa_reg.h" a bit for consistency.  The third patch
adds definitions and some minor code changes related to IPA v5.5.
The fourth defines IPA register offsets and fields used for IPA
v5.0; most--but not all--register definitions are the same as used
in IPA v5.0.  The final patch adds configuration data used for IPA
v5.5 (here again this mostly duplicates IPA v5.0 definitions).

					-Alex

Alex Elder (5):
  dt-bindings: net: qcom,ipa: add SM8550 compatible
  net: ipa: update IPA version comments in "ipa_reg.h"
  net: ipa: prepare for IPA v5.5
  net: ipa: add IPA v5.5 register definitions
  net: ipa: add IPA v5.5 configuration data

 .../devicetree/bindings/net/qcom,ipa.yaml     |   1 +
 drivers/net/ipa/Makefile                      |   4 +-
 drivers/net/ipa/data/ipa_data-v5.5.c          | 487 +++++++++++++++
 drivers/net/ipa/gsi_reg.c                     |   1 +
 drivers/net/ipa/ipa_data.h                    |   1 +
 drivers/net/ipa/ipa_main.c                    |  13 +-
 drivers/net/ipa/ipa_mem.c                     |   2 +-
 drivers/net/ipa/ipa_reg.c                     |   6 +-
 drivers/net/ipa/ipa_reg.h                     | 111 ++--
 drivers/net/ipa/ipa_version.h                 |   1 +
 drivers/net/ipa/reg/ipa_reg-v5.5.c            | 565 ++++++++++++++++++
 11 files changed, 1130 insertions(+), 62 deletions(-)
 create mode 100644 drivers/net/ipa/data/ipa_data-v5.5.c
 create mode 100644 drivers/net/ipa/reg/ipa_reg-v5.5.c

-- 
2.34.1

