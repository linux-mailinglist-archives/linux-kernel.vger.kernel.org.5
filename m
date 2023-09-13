Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0AD79E216
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbjIMI3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbjIMI3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:29:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57381996
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:29:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68cbbff84f6so503931b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694593773; x=1695198573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LS+dPzs/esrRECMW0r4zvqkr3eodLloQmjRx4zag1qY=;
        b=MovustRNPJpVQ+mwySJYRLseU1nlDkjdMgrc6xPCZjwxPlLpdmhU6ixv0RrP9UL+OZ
         lBN85xI79vrvmb01tYXG4j3+LngSuM+oRCvjBbGgRygAn6t8C1RLDV+G6zXr/IPD+9wk
         WLIusnnsGutboUGlIzfUrC3DCwSKSAabPL1RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593773; x=1695198573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LS+dPzs/esrRECMW0r4zvqkr3eodLloQmjRx4zag1qY=;
        b=tN+sRo/hh56BaHWjiemZc79mkpITsZ8asvwS6Qj43JPL+7RH0RUgn2dVZP59lGRudf
         8SdQyO3OFP3NQAhr5AnoKh08H12Dm3wB8nvVUVNkMbPjbJhxJ8cBODHk/3N7U5WxMHAe
         Cc8fcd4ZmRMsyJjNLrZaCRNg4zg17YASv6p3rCEXrUHeH8I7LF7QjbSrPLqH4Sr3PvrK
         uEPWD4pl5/U5rwYSNmcgHI0Xntsh0IyfiZIwXlrzKwdbOPRGZqWpElqsbt2ye0WoBuCG
         JvvXLYz0JhRFaD4uBCZtd/wtXVHK1NyGCxEe8zUIc6iajf5Hmh5t+g95E3knpckD61YK
         FZZQ==
X-Gm-Message-State: AOJu0YxfhBfPSc1fKjr9AGkQBLW+ZQVffnGKR5w3+qUrEUd9cAufi7ME
        fjujIsdes8PR69w5yvDlvj0zdA==
X-Google-Smtp-Source: AGHT+IHbVPdTuFhGeeVxawUbl5Rb0U2ZDVoMhMmu0Yn9YrtDJoRoIvMf+QNC1WT0MA1dyWigw9x1yw==
X-Received: by 2002:a05:6a20:9382:b0:153:4ea6:d12e with SMTP id x2-20020a056a20938200b001534ea6d12emr2727186pzh.17.1694593773090;
        Wed, 13 Sep 2023 01:29:33 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:b24c:3be4:d952:d3b1])
        by smtp.gmail.com with ESMTPSA id g6-20020aa78746000000b006901bd3a9e4sm418781pfo.104.2023.09.13.01.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:29:32 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/3] regulator: mt6358: Remove bogus regulators and improvements
Date:   Wed, 13 Sep 2023 16:29:15 +0800
Message-ID: <20230913082919.1631287-1-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v3 of the remainder of the MT6358 regulator driver cleanup
and improvement series. v1 can be found here [1]; v2 is here [2].

Changes since v2:
- Merged patches dropped
- Fixed up pickable linear ranges' selector values
- Collected tags
- Patch adding missing regulator definitions squashed into patch using
  the definitions; recommended by Krzysztof on my MT6366 series.
- Remaining dts patch split out to be sent separately

Changes since v1:
- Merged patches dropped
- Added patch to move VCN33 regulator status sync after ID check
- Added patch to fix VCN33 sync fail error message
- Added patch to add missing register definitions

Various discrepancies were found while preparing to upstream MT8186
device trees, which utilize the MT6366 PMIC, that is also covered by
this driver.

Patches 1~3 should go through the regulator tree, and patch 4 through
the soc/mediatek tree.

** Note: patch 2 needs an ack from Lee for the mfd header change.

This v3 series can be seen as two parts. v1 had three parts, but one
part was fully merged, and then v2 gained another cleanup. v3 drops
the "fixing bogus regulators" part: driver changes are fully merged
and device tree change will be sent separately.

Part 1 - Robust chip ID checking (patch 1)

Angelo suggested making the driver fail to probe if an unexpected chip
ID was found. Patch 1 implements this.

Part 2 - Output voltage fine tuning support (patches 2, 3)

Many of the LDOs on these PMIC support an extra level of output voltage
fine tuning. Most default to no offset, but a couple have a non-zero
offset by default. Previously this was unaccounted for in the driver and
device tree constraints. On the outputs with non-zero offset, this ends
up becoming a discrepancy between the device tree and actual hardware.
These two patches adds support for this second level of tuning, modeled
as bunch of linear ranges. While it's unlikely we need this level of
control, it's nice to be able to read back the accurate hardware
settings.

Please have a look.

Thanks
ChenYu

[1] https://lore.kernel.org/linux-arm-kernel/20230609083009.2822259-1-wenst@chromium.org/
[2] https://lore.kernel.org/linux-mediatek/20230721082903.2038975-1-wenst@chromium.org/

Chen-Yu Tsai (3):
  regulator: mt6358: Fail probe on unknown chip ID
  regulator: mt6358: Add output voltage fine tuning to fixed regulators
  regulator: mt6358: Add output voltage fine tuning to variable LDOs

 drivers/regulator/mt6358-regulator.c | 304 ++++++++++++---------------
 include/linux/mfd/mt6358/registers.h |   6 +
 2 files changed, 144 insertions(+), 166 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog

