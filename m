Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5FA7AE4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjIZEkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjIZEkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:40:18 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB18497
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:40:10 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3aca0934e74so4013055b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695703210; x=1696308010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3E1i8LSIOlwTyuk1XAeWZA24GferWyjzighda7xVvfs=;
        b=XOYSWW9XBJ3dT+M3gewHuPnivD84GR8MqGPbUjjpj90ajXt2xoKXT1mHbE5VA8ErPW
         JUJBE+AN8elsPdCjcEhmRITbg0wiVOakpDpH6CyuQj80g/ogHJTR7Niu2CWXfFkyMVVt
         PfgbVZ+uy4p+A3+bDn8VHJXXTXnmO8cQ39QDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695703210; x=1696308010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3E1i8LSIOlwTyuk1XAeWZA24GferWyjzighda7xVvfs=;
        b=T60gmV+Cm1s+2APMfL4COnOXeK4bLFtn2SMwtsqSbRGXfVOEufkSthrdDU8mwsEqPs
         2HsRrTO1WzU7WvItrjnb/U5RMPxZV+ILIxRAd8VtNKGReK/ZGPx7VeFlkKAzGe/0XDL3
         TvWyaPpm1f2F/XrtuSlg2KHjczVGbwadtUo0lOpHC9XYA9xDmzTiN39OTS2+EV/U+ZYT
         2GrVstlQF9u+QlfQikDDFFakLv7NYsNotpFxpaipydIbGJfYKFMfN431N4Nu9q8Kjadw
         uyTtlwofKdsezcqcnM+oh1QeBHUNc1Pue6cW+dLpZfGRhDPn6Zp0gzRd03x9f6nFceTm
         QdsQ==
X-Gm-Message-State: AOJu0Yw5Dekm365CjAFVb4iYkz7kgPTI3rsK/s1HX0FeVF4czFsLse2T
        sa4wKycQGcp0N1LeINxBCIJy4g==
X-Google-Smtp-Source: AGHT+IE1o3rIsLU2bGltTLnHyrko+WsamuoFNkx5JhLKgydhfKe82ipsXYX70K9cDmuDGQev2xoeMA==
X-Received: by 2002:a05:6808:8f9:b0:3a7:6213:6897 with SMTP id d25-20020a05680808f900b003a762136897mr8120224oic.11.1695703210209;
        Mon, 25 Sep 2023 21:40:10 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ba86:87c4:df1a:be60])
        by smtp.gmail.com with ESMTPSA id p11-20020a63ab0b000000b00563590be25esm8667210pgf.29.2023.09.25.21.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 21:40:09 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH RESEND v3 0/3] regulator: mt6358: Remove bogus regulators and improvements
Date:   Tue, 26 Sep 2023 12:34:45 +0800
Message-ID: <20230926043450.2353320-1-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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

This seems to have fallen through the cracks, so I'm resending with tags
collected and patches rebased onto next-20230925. The diffs remain the
same.

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

This v3 series can be seen as two parts. v1 had three parts, but one
part was fully merged, and then v2 gained another cleanup. v3 drops
the "fixing bogus regulators" part: driver changes are fully merged
and device tree change has been sent separately [3]. All patches here
should go through the regulator tree.

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

The series has been reviewed, and the mfd header change has been acked
by Lee. Please merge.

Thanks
ChenYu

[1] https://lore.kernel.org/linux-arm-kernel/20230609083009.2822259-1-wenst@chromium.org/
[2] https://lore.kernel.org/linux-mediatek/20230721082903.2038975-1-wenst@chromium.org/
[3] https://lore.kernel.org/linux-mediatek/20230913084457.1638690-1-wenst@chromium.org/

Chen-Yu Tsai (3):
  regulator: mt6358: Fail probe on unknown chip ID
  regulator: mt6358: Add output voltage fine tuning to fixed regulators
  regulator: mt6358: Add output voltage fine tuning to variable LDOs

 drivers/regulator/mt6358-regulator.c | 304 ++++++++++++---------------
 include/linux/mfd/mt6358/registers.h |   6 +
 2 files changed, 144 insertions(+), 166 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog

