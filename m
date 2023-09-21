Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64C57AA4EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjIUW0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjIUWZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:25:35 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957AD26B43
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:12:33 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-403004a96eeso12617325e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695316348; x=1695921148; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8I/sU/MGzlvBp47z9yaYHIpn2F7NMoI5l+3Ycr8W4M=;
        b=F+IU4OdKhBjzjjuH2/9be9CxTcXmdJK+2fRyvfgcHE1bSkfsvtKOt8HEf/jatJJaBV
         2LF4YwoTfpgx1Tj8yaF1iNg7xMW8cKLwPyaUdMdC88qIhPXDYaOpHpX4vqdV54gMcClO
         PPSV5m54sMalf4zX0lNlL5GXNuty/M8jU3awAQLnn4eWdNBZ1Q4ANzHf61DOoN+BuU7/
         N0RLs7Eb9tPGRnR7WR8Y1GqrHtKWozaVfgweyQOw7mYutT/WSVCE8LF45wa1hpbXDQwv
         axwV1ZS6PlP4mKoLDiUunz1wf6RCbZtXuG8qvVq97I31Rh+4r9NhATsjs3L3gKgSTzgq
         BbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316348; x=1695921148;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8I/sU/MGzlvBp47z9yaYHIpn2F7NMoI5l+3Ycr8W4M=;
        b=iyfwMX6DPDgyyHaEMyM/AlGVhlVQyILQ54slxBp1ik+z5bkDfiFnU/hI9Luu5WJJAQ
         jV0RguA9p8YmZowddsNcsvWggacQFPkmXN4/rW03fh7iHbUinrTPaIDnfxflgz/jytG5
         +tXvty+ch8aOpV1xXfj2zXyoU7SlmIrnyKJfXwZc8t3a8PLNHNLzZ2aKslls4kQrsAIN
         OmGpNkI298IwV6DfK+KTFLY0rE6zgNoNL3P922dZM0kUPLpDCf22RsE5ZRs5o81QxP8S
         ItmQ40V+Jx2aIVK1pAr5dyggcmFIqZLRr7CyPP3y0mRY3xDsuKpcve0Gd9swr+++NuKZ
         8nHw==
X-Gm-Message-State: AOJu0YzHqZMCx9+TJetuADKWNZXFpo+O642VTFhqixFITUoUYbdnHeCD
        RDJVcC2b3Co/p3WT2TPIElUkS1KAbKUp8zl7Zy0=
X-Google-Smtp-Source: AGHT+IGBqi1U8/tm1kNfARUekhYiWvOvpVhOyz/gfrwkUcN1gBpPMHANIWhYIHaICP4eucLNwKwOQA==
X-Received: by 2002:a17:907:1ddb:b0:9ae:443b:988e with SMTP id og27-20020a1709071ddb00b009ae443b988emr4993019ejc.15.1695306769137;
        Thu, 21 Sep 2023 07:32:49 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id lt12-20020a170906fa8c00b009a219ecbaf1sm1153327ejb.85.2023.09.21.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:32:48 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v5 0/7] Add IOMMU support to MT8365 SoC
Date:   Thu, 21 Sep 2023 16:32:39 +0200
Message-Id: <20230207-iommu-support-v5-0-fa6f03680832@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAdUDGUC/33NTQrCMBAF4KtI1kYm06Q/rryHuEiTqQ20TUlsQ
 aR3d3Ap2tXwHrxvXiJTCpTF+fASidaQQ5w4mONBuN5Od5LBcxYIWABCJUMcx0XmZZ5jekhDJUK
 DJWkkwZvWZpJtspPreTUtw8BlH/Ijpufnx6r4XP9xq5IgdQeuVp036NSltc8htIlOLo7ixtiKu
 wAyUII3nQUgTeYHUOwCBQNNRaqxXlNt/A9A7wKagVpXTV2aymkFX8C2bW+R/HtodQEAAA==
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2364; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=+lERs6sTfuno7YX0TSz2xcB2J6IO4eaDpmY1nCNJJWA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlDFQP7HxueRl+iHWVkWR/QMe3SUlmP72T+aCVUvIm
 Gl/k1UWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZQxUDwAKCRArRkmdfjHURc8kD/
 9t5WdY3d4LNtyInO8sKmj+NiC13C0C3D85Ol1QtzIjqt1/MoQaJolscUp7OrRiAUI4PhPJUSOAklmO
 1dA0Upj/p72H8fu6zmEKDQ4MTv6vFCSBTNaVM4iPNcjIopItOjC3gS1aIwW+2CYdaC+yplPHAeJr4l
 NbZ0zjypqlFw76PfAlTVGq/iXNiI3XKMxsbZiKdYmoOGbvIt6XFodwpqSWXodOmHIY2dsbLxH3U+sh
 nNaNh1dnS/EiuZjpTf2qQrVkvgcXdv4A+y95fghxJkx3lf3MTKGkGCjrAgrcz0F31askkJ62SCmVrY
 /tM0iMYVneqV0oPHQnEprei2u1qvQp37Oz9/oPrNImI1yUaPk03GV2dFXl6cpgcFRMpH7VCqpTrb6V
 XjjvlJug5KthFYf/k0KIt8q/DIsH++6l5wABg48Q/j8umJ09qsa9GKCZnGnl2wDNxW4yRKcU00XW75
 L8pXTw/1GuJrVJeHbXl4FfcRoN/unhvbP5PQpAdThDGca9A+dmM2WmMleYLQIjJc5auBiBUfTxOrMc
 nWcC5vL/2vg6hDYDHt1qo13tXoSwmOqiOnLE40SNlwyUgyJrB1GOlVckJsJT1QEOV5nxMysMC03UTB
 S4vNCQuQKM7v0nlllOQc4mfPVgcC2n0e+FSZMs3Nju7gVbOmlVYjqbNvBPuA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits are based on the Fabien Parent <fparent@baylibre.com> work.

The purpose of this series is to add the following HWs / IPs support for
the MT8365 SoC:
- System Power Manager
- MultiMedia Memory Management Unit "M4U" (IOMMU)
  - Smart Multimedia Interface "SMI"
    - Local arbiter "LARB"

This serie depends to another one which add power support for MT8365
SoC [1].

Regards,
Alex

[1]: https://lore.kernel.org/linux-arm-kernel/20230918093751.1188668-1-msp@baylibre.com/

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v5:
- Rebase to v6.6-rc2.
- Link to v4: https://lore.kernel.org/r/20230207-iommu-support-v4-0-84798657c410@baylibre.com

Changes in v4:
- Rebase to v6.5-rc1.
- Link to v3: https://lore.kernel.org/r/20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com

Changes in v3:
- SMI driver support and bindings patches have been removed from
  this series and sent it in another one which should be merged before
  this one.
  - "dt-bindings: memory-controllers: mediatek,smi-larb: add mt8365"
  - "dt-bindings: memory-controllers: mediatek,smi-common: add mt8365"
  - "memory: mtk-smi: mt8365: Add SMI Support"
- Link to v2: https://lore.kernel.org/r/20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com

Changes in v2:
- Split power domain patch (3) in 4 patches to explain in the commit
  messages the added subsystems.
- Add an independent "mediatek,mt8365-smi-common" compatible to have
  its own LARB bus select.
- Link to v1: https://lore.kernel.org/r/20230207-iommu-support-v1-0-4f0c81fd52c1@baylibre.com

---
Alexandre Mergnat (7):
      arm64: dts: mediatek: add mmsys support for mt8365 SoC
      arm64: dts: mediatek: add camsys support for mt8365 SoC
      arm64: dts: mediatek: add apu support for mt8365 SoC
      arm64: dts: mediatek: add power domain support for mt8365 SoC
      arm64: dts: mediatek: add smi support for mt8365 SoC
      arm64: dts: mediatek: add larb support for mt8365 SoC
      arm64: dts: mediatek: add iommu support for mt8365 SoC

 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 210 +++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)
---
base-commit: 2b4f840a1de65d77644236c72b3f252aa2725a42
change-id: 20230207-iommu-support-5e620926e42e

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

