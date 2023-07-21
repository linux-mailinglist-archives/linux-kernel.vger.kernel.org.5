Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEABA75C1AD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjGUI3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjGUI3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:29:39 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA587272E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:29:28 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-55e04a83465so1122916eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689928168; x=1690532968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dsW9tUiaMnSTYVVPWIPxNApYubVnBPMgU9idJbKQccw=;
        b=RI/ryzMxMSQ+VKa8HDRrosIKYpZfVgFMqmUw2HHkuJyhFzvVHfiQ11S8jgVDcVHYEA
         DsYRbZT4S36Ax+tmnHP89wLBRCtRFAlRvKMhMwPIMEBmVw+vkuineABH7dXjVfvIoTMC
         mp4OWxxT3BHKdgMyynBbWwhIyeMGELX729oac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689928168; x=1690532968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dsW9tUiaMnSTYVVPWIPxNApYubVnBPMgU9idJbKQccw=;
        b=gUDnWni3sUGpwVl3xx9eRhKQSa2dn8mx7ZwAVqHo534PN1P3Qh9UcW/JoESo7zTqfd
         IfZnU4fujHWzsss9I9NmkBPuyV/S0l7X0vGfBVV9Ns95y7MyTDP5vCFgKT8cauXJzdj4
         5Ws90qp5AyyOUvq08Xbi5JNnCl3dqlCflkO09lcAZPktAEYjQ2OHXVGSS37TxqBh/ANZ
         p4tYdfGnDFLUIXCKsgau60MjFScWNq2EhqreVwbETOAEq48sDHc3nLUaGTd7OHW1AUDk
         59JwicBSxc3RM4q0AGQwjRYQ2cMOxhPEOOlST0h+9i5m5D0+BsqPHhIYt+ghJxPD9d0c
         Jz3g==
X-Gm-Message-State: ABy/qLY9u9CHfqM7U+DcuORGrkpoPJVAbmhAJNFQ2k9UwS08wMrn7lqB
        7LaI1DS0gafq/ILEI5VFjrduqw==
X-Google-Smtp-Source: APBJJlGgKdnvrfMzAc4xtENPdKPVquYpG6nY+Xtz+kPj+B/ieF8jLtF+yAgOOxPqn79rzrAuKfCZ+A==
X-Received: by 2002:a05:6358:938c:b0:134:df5e:4776 with SMTP id h12-20020a056358938c00b00134df5e4776mr1501426rwb.24.1689928167783;
        Fri, 21 Jul 2023 01:29:27 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6d86:d21:714:abab])
        by smtp.gmail.com with ESMTPSA id d26-20020a63991a000000b0055fe64fd3f4sm2594382pge.9.2023.07.21.01.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 01:29:27 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 0/7] regulator: mt6358: Remove bogus regulators and improvements
Date:   Fri, 21 Jul 2023 16:28:52 +0800
Message-ID: <20230721082903.2038975-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending with Lee added to recipients)

Hi,

This is v2 of the remainder of the MT6358 regulator driver cleanup
and improvement series. v1 can be found here [1].

Changes since v1:
- Merged patches dropped
- Added patch to move VCN33 regulator status sync after ID check
- Added patch to fix VCN33 sync fail error message
- Added patch to add missing register definitions

Various discrepancies were found while preparing to upstream MT8186
device trees, which utilize the MT6366 PMIC, that is also covered by
this driver.

Patch 1 should either go through the mfd tree and an immutable branch
created for the regulator tree to consume, or given an Ack, merged
directly through the regulator tree.

Spoiler: a follow-up series dealing with the MT6366 PMIC, which is
covered by the same driver, also has an mfd header patch that would
need the same treatment.

Patches 2~6 should go through the regulator tree, and patch 7 through
the soc tree. Patches 2 and 3 should be merged as fixes for v6.5, as
the commit they fix was just introduced in -rc1.

Patches 5 and 6 depends on "[v3] regulator: Use bitfield values for
range selectors" [2] I sent out earlier.

This v2 series can be seen as three parts. v1 also had three parts, but
one part was fully merged, and then v2 gained another cleanup.


Part 1 - Fixing bogus regulators (patches 2, 3, and 7)

There are some regulators listed in the bindings and driver that have no
corresponding pin on the actual hardware. MediaTek says these are a
hardware construct for shared control of the same regulator in the
VCN33 case and an alternative control scheme for low power suspend.

In the VCN33 case, there's only one actual regulator, so we merge the
two and rename them to match the hardware pin. No existing devices use
these AFAICT, so this should be safe to change.

The driver changes for this part have been merged, but two review
comments were not accounted for. They are addressed here with two new
patches

Part 2 - Robust chip ID checking (patch 4)

Angelo suggested making the driver fail to probe if an unexpected chip
ID was found. Patch 4 implements this.

Part 3 - Output voltage fine tuning support (patches 1, 5, and 6)

Many of the LDOs on these PMIC support an extra level of output voltage
fine tuning. Most default to no offset, but a couple have a non-zero
offset by default. Previously this was unaccounted for in the driver and
device tree constraints. On the outputs with non-zero offset, this ends
up becoming a discrepancy between the device tree and actual hardware.
These two patches adds support for this second level of tuning, modeled
as bunch of linear ranges. While it's unlikely we need this level of
control, it's nice to be able to read back the accurate hardware
settings.

Please have a look. After this series is done I'll send out patches for
the MT6366 PMIC, which is what started this. That will also include
updated YAML bindings for MT6366. I think we can merge MT6358 bindings
into them afterwards.

Thanks
ChenYu

[1] https://lore.kernel.org/linux-arm-kernel/20230609083009.2822259-1-wenst@chromium.org/
[2] https://lore.kernel.org/linux-arm-kernel/20230714081408.274567-1-wenst@chromium.org/


Chen-Yu Tsai (7):
  mfd: mt6358: Add missing registers for LDO voltage calibration
  regulator: mt6358: Sync VCN33_* enable status after checking ID
  regulator: mt6358: Fix incorrect VCN33 sync error message
  regulator: mt6358: Fail probe on unknown chip ID
  regulator: mt6358: Add output voltage fine tuning to fixed regulators
  regulator: mt6358: Add output voltage fine tuning to variable LDOs
  arm64: dts: mediatek: mt6358: Merge ldo_vcn33_* regulators

 arch/arm64/boot/dts/mediatek/mt6358.dtsi |  11 +-
 drivers/regulator/mt6358-regulator.c     | 314 +++++++++++------------
 include/linux/mfd/mt6358/registers.h     |   6 +
 3 files changed, 151 insertions(+), 180 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog

