Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33AD7AC758
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 11:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjIXJlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 05:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 05:41:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9958CFB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 02:41:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07848C433C7;
        Sun, 24 Sep 2023 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695548477;
        bh=qZWKjqHJJnwVssDnm6P01UEP1ocRSea+ZT/5ximr2mI=;
        h=From:To:Cc:Subject:Date:From;
        b=G4cuq7V8yNkZZ99bYzaBeq95NvlWW/NgL8udvQ3C1vzwyo/wOA4mn+spDChkG2tJk
         /WqknutXpMOp/1rirm4DfOMGG0ospywAKNlrRQN7PPMe1e8kGUgskm2rCzR/tlPeNX
         lOFM+HOH30GwniZALGkGd0qAX706x+1CnKB/lOZyLFa9G89SnjdXF9iu0e1QSIuY3Y
         71T9DFnpMUx4+Q9AIgzrGT0z7vGCHtB7KqsiTynwhlc8R4n91J/07W7rEj23qLVLqp
         aSOuLYQcMYhV3WV6U80sFYwW5/096PxMzXM+AaQbneBMBHDA7GjpcVBYSh4dyEVsXO
         VqMn7SUBgUghw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qkLc2-00FfXZ-CB;
        Sun, 24 Sep 2023 10:41:14 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for 6.6, take #1
Date:   Sun, 24 Sep 2023 10:41:05 +0100
Message-Id: <20230924094105.2361754-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, biju.das.jz@bp.renesas.com, claudiu.beznea.uj@bp.renesas.com, dmitry.baryshkov@linaro.org, geert+renesas@glider.be, konrad.dybcio@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com, quic_mkshah@quicinc.com, neil.armstrong@linaro.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the first cut of irqchip fixes that have graced my Inbox.
The most interesting thing is the fix for some Qualcomm HW, which
has a workaround for broken device trees that do not correctly
describe the hardware. The rest is a couple of fixes for the
Renesas RZG2L irqchip.

Please pull,

	M.

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-6.6-1

for you to fetch changes up to 9b8df572ba3f4e544366196820a719a40774433e:

  irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source (2023-09-24 10:18:19 +0100)

----------------------------------------------------------------
irqchip fixes for 6.6, take #1

- Fix QC PDC v3.2 support by working around broken firmware tables

- Fix rzg2l-irqc missing #interrupt-cells description in the DT binding

- Fix rzg2l-irqc interrupt masking

----------------------------------------------------------------
Biju Das (1):
      irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source

Dmitry Baryshkov (1):
      arm64: dts: qcom: sm8150: extend the size of the PDC resource

Lad Prabhakar (1):
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update description for '#interrupt-cells' property

Neil Armstrong (1):
      irqchip/qcom-pdc: Add support for v3.2 HW

 .../interrupt-controller/renesas,rzg2l-irqc.yaml   |  5 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  2 +-
 drivers/irqchip/irq-renesas-rzg2l.c                |  2 +-
 drivers/irqchip/qcom-pdc.c                         | 69 ++++++++++++++++------
 4 files changed, 56 insertions(+), 22 deletions(-)
