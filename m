Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9094976C64F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjHBHUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjHBHUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:20:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE4119B9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 00:19:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68336d06620so6310198b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 00:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1690960797; x=1691565597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DIEz7PEpoXqLNAIoTJaElKAOuje3DArMjPsGb95DjQ4=;
        b=xB307vaKkQvkNM/Ouzu+wBpRMCShyBIUtnlUtPurzJhL9NQz+B5xG0hdgAoDjSZ6+d
         EqNnVptK7EcwaE/a6b4ctTMg14h+lX6+NzGidc6QbAXUqg7YQwePU9UE083GgDk+7eDL
         GnmxNVXY9Uk9GxsfDjjfY+pPMjRVvhN39vjRD0xh2sc4JDWy79fw06Dj5Xd1mbGqzcHT
         5nv1OiNbzBT6rZNIRIyyXP0iFe1lcLOTg8qRXmb+UVnKAIxl4FEjfMzDVA750m/1uGZd
         cTKUN6N/GuJMZL/9Y5cLRpQi6kUw8FkuYsOVA8HoE7zAAIjBRK7CofQV5MAWfpj2gW6p
         udlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690960797; x=1691565597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIEz7PEpoXqLNAIoTJaElKAOuje3DArMjPsGb95DjQ4=;
        b=Mi82Arxgz7jBAVLZ6LFUFbJ53jGrKBtN7Mm786Qs/PrfaKtzKuvzVCxabfcNw6FyaP
         tMrsPyPGHhiQ9EwKARg3fsnp6S/J9A0mG/7gpCsRYH9gNQvz3IloUiQABMX+zkKE/n7S
         TnexOLEh233fNbhKVKTSvNNFRQMnbo4U0bw+x0vaiiXRe2gl53VSc3isHNKNrGD4xRcB
         utdE0zz5sCAMoNDSDnw7EDQRYNQJZn05b68ijEzGcx6rapO7aj69FAy5SCbqim9xVLX5
         4Cg1Frw1RWqD1cdtb+hVtHpEi05BiQQ7E9csFKogUMX5kLCKsSB7um2fjwBB4h/ZDhJj
         0fdw==
X-Gm-Message-State: ABy/qLYuhNbuBsvAViXjGpDNHXjIWLDHxbMe8TtB1iRU+A5U9D4BZaIw
        ECkgLEKY/raueHJgU5+HY0kKmoRelvEbIpBqYKvoDw==
X-Google-Smtp-Source: APBJJlEMrq8IjkffZFX3fYXd6HStNNHMPCYRGwP0LyZYRI8CDxG46/jOYIM7Xw3BC1r0wYlUvV63BQ==
X-Received: by 2002:aa7:888c:0:b0:686:4dd4:d56e with SMTP id z12-20020aa7888c000000b006864dd4d56emr18815965pfe.2.1690960796968;
        Wed, 02 Aug 2023 00:19:56 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id fe12-20020a056a002f0c00b00684ca1b45b9sm10732543pfb.149.2023.08.02.00.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:19:56 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com,
        dianders@google.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v6 0/2] Add ili9882t bindings and timing
Date:   Wed,  2 Aug 2023 15:19:45 +0800
Message-Id: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for Ilitek. The ili9882t touch screen chip same as
Elan eKTH6915 controller has a reset gpio. The difference is that
ilitek9882 needs to use vccio-supply instead of vcc33-supply. 
From Dmitry suggestion, it would make more sense to distinguish the
binging of ili9882 and eKTH6915.

From The datasheet specifies there should be 60ms between touch SDA
sleep and panel RESX. so we can add the 65 ms delay in i2c_hid_core_suspend.

As Doug said, only the panel follower patch series[1] land makes sense, and now the panel follower
patch series[1] has land.
[1]: https://lore.kernel.org/all/20230727171750.633410-1-dianders@chromium.org

Changes in v6:
- PATCH 1/2: Modify subject.
- Link to v5: https://lore.kernel.org/all/20230609063615.758676-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v5:
- PATCH 1/2: Add panel as a required in property and examples.
- PATCH 2/2: Set a NULL to ili9882t_chip_data for vcc33-supply, then not use vcc33 regulator.
- Link to v4: https://lore.kernel.org/all/20230608130147.2835818-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v4:
- PATCH 1/2: Remove compatible items and add reset maxItems.
- PATCH 1/2: Refer to the panel description in Doug serias[1].
  [1] https://lore.kernel.org/all/20230607144931.v2.1.Id68e30343bb1e11470582a9078b086176cfec46b@changeid/ 
- PATCH 2/2: Set a "null" to ili9882t_chip_data for vcc33-supply, then using dummy regulator.
- Link to v3: https://lore.kernel.org/all/20230607133458.4075667-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v3:
- PATCH 1/2: Introduce bindings for Ilitek.
- Link to v2: https://lore.kernel.org/all/20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com/

Changes in v2:
- PATCH 1/2: fix ran make dt_binding_check warnings/errors.
- PATCH 1/2: remove oneOf,just enum.
- Link to v1: https://lore.kernel.org/all/20230602140948.2138668-1-yangcong5@huaqin.corp-partner.google.com/

Cong Yang (2):
  dt-bindings: input: i2c-hid: Introduce Ilitek ili9882t
  HID: i2c-hid: elan: Add ili9882t timing

 .../bindings/input/ilitek,ili9882t.yaml       | 67 +++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid-of-elan.c         | 50 ++++++++++----
 2 files changed, 105 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml

-- 
2.25.1

