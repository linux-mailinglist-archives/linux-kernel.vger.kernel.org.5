Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00C5786CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbjHXKmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240384AbjHXKly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:41:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E3F1991
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:41:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdc19b782aso45183835ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692873712; x=1693478512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/I5taWqYocU0OpThCzxV/acNgUnkDEENY3xVb7wNfc=;
        b=lFjArl4n/ZcVrdCFJS0q4L0NJTCnLVp9Ig2zjEjsYqkNjmafnMaHjD4iOwjtcS2Jy7
         jFJtBo9q6C5RKuSUAbV8J/W3jSs9v2yZJyDWL0gN7UCBhh9C3X4iSdM3GcihiLaqZ75y
         SlxwBbOXIUIF5AN7UafZJsT2wIb5QaxB2wJwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692873712; x=1693478512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/I5taWqYocU0OpThCzxV/acNgUnkDEENY3xVb7wNfc=;
        b=eM7xI7TpjT9rFiucZYdo0qJQeKgwkZq8XYPBe6CdlD2hmXqrqG0jYGef7QlJRMSbNB
         iRkv5RR1kDTy+8iAZhog0a9odx0csPfZ9AwZkqFk+hP5CnctXOhEMETtdsWm+9xnf0dt
         zeNHpbtEP2FwCwcdFUnyRsPNNfTjvr5FfLcB5PnYaRLVc1Gqv76W6Ecd871ExHLTBH05
         HQfPie2bgnqXPamQyVmzgzuobRtRjP/NxkXAdrld1q6DAmudzd01fRhp6OlooPtN3uWp
         zEpGG5O7XTuzpP6cOp9h2yByzIjTjSW0SQGZHGYibeZh57aI6SYNLiO7MsjBe2G89GLg
         1n8A==
X-Gm-Message-State: AOJu0YzxK9TJlUPRTJns5UEP4KUIgcmYBbso+mtceU3w/vsl54GF/Kzt
        Za72Q1f73rasp6ijUaqOno+dxg==
X-Google-Smtp-Source: AGHT+IEz6LdCYMosyZ5GXgijBrljcB9v//RQ3p4COqu2hVs6APjaJVb3ECJXw5jyUglsTIDBX4leOw==
X-Received: by 2002:a17:903:491:b0:1b6:6b90:7c2f with SMTP id jj17-20020a170903049100b001b66b907c2fmr10968815plb.55.1692873712648;
        Thu, 24 Aug 2023 03:41:52 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:ed6d:42e3:a23:8316])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902dac200b001b5247cac3dsm12524645plx.110.2023.08.24.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:41:52 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, Fei Shao <fshao@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] spmi: Add and use managed resource helpers
Date:   Thu, 24 Aug 2023 18:40:07 +0800
Message-ID: <20230824104101.4083400-1-fshao@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds and converts to the devm_* helpers in the SPMI driver,
based on the suggestion in [1].

While at it, I have some patches fixing other minor issues as well, like
reordering the remove sequence in spmi-mtk-pmif and using proper error
return code etc.

This patch is based on next-20230824 and [2] which is not yet applied,
in order to avoid potential conflicts.

[1]: https://lore.kernel.org/all/20230821033532.GA21555@google.com/
[2]: https://lore.kernel.org/all/20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid/


Fei Shao (5):
  spmi: Introduce device-managed functions
  spmi: Use devm_spmi_controller_alloc()
  spmi: mtk-pmif: Reorder driver remove sequence
  spmi: hisi-spmi-controller: Use devm_spmi_controller_add()
  spmi: Return meaningful errors in spmi_controller_alloc()

 drivers/spmi/Makefile               |  2 +-
 drivers/spmi/devres.c               | 61 ++++++++++++++++++++
 drivers/spmi/hisi-spmi-controller.c | 32 +++--------
 drivers/spmi/spmi-mtk-pmif.c        | 28 ++++------
 drivers/spmi/spmi-pmic-arb.c        | 87 ++++++++++-------------------
 drivers/spmi/spmi.c                 |  6 +-
 include/linux/spmi.h                |  3 +
 7 files changed, 116 insertions(+), 103 deletions(-)
 create mode 100644 drivers/spmi/devres.c

-- 
2.42.0.rc1.204.g551eb34607-goog

