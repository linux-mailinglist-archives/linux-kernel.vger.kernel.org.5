Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A097DBAA4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjJ3NZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjJ3NZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:25:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DB98E;
        Mon, 30 Oct 2023 06:25:29 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D8CD4660297B;
        Mon, 30 Oct 2023 13:25:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698672328;
        bh=4eqeiWumk4iSfUH1LnoCuerSUI7m7wgrGgGcR0jKt20=;
        h=From:To:Cc:Subject:Date:From;
        b=D6EovCptxO0ZxALbuNpnoq/13GJgRkqwpxgY1tqF99+c3Qnj7nIkTOP+QIiv7pD0t
         4fDwG08rEhEJR6D71qtxH+M6nmNJvAtM/E22zOWd8lw4ZZz+fXgjOqee58z3woKI2n
         UbQD1ZHF3OS287on70DQp2TfzNBbNAhmmdaM12nCgkNMp4LnayH5XXqxrm5UYd5YSP
         8KBrgXvkbsWrzNpFEHQKZCGkiuMisVhcIl1T9bnp+PKnFQ47tOXGGN2XUXZc/g+P8l
         4rNYb3/WCXBHkB9MV230pIx0/4ibr29eBHxrKm9Rt4/LPxnr3X9qqzvZ7Oz8t0JbFT
         eHh9awnUnUCtQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 0/2] MT8195 Cherry: Assign MFG vregs for power saving
Date:   Mon, 30 Oct 2023 14:25:21 +0100
Message-ID: <20231030132523.86123-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series assigns the right regulators to MFG0 and MFG1, respectively
VGPU (GPU Core) and VSRAM_OTHERS (GPU SRAM), and removes the property
regulator-always-on from both.

This allows to save power both during runtime suspend and during system
sleep; specifically because:
 1. The GPU SRAM regulator is switched off during runtime suspend
 2. The GPU Core regulator is switched off during system sleep

Of course, in order for those power saving actions to actually take
place, it is required to also have the code in [1].
Anyway, even without series [1], this will not introduce any unstability
as the Vgpu regulator will simply not ever get turned off.

[1]: https://lore.kernel.org/r/20231030132257.85379-1-angelogioacchino.delregno@collabora.com

AngeloGioacchino Del Regno (2):
  arm64: dts: mediatek: mt8195-cherry: Add MFG0 domain supply
  arm64: dts: mediatek: mt8195-cherry: Assign sram supply to MFG1 pd

 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 10 ++++++++--
 arch/arm64/boot/dts/mediatek/mt8195.dtsi        |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.42.0

