Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A557FDB73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbjK2PbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjK2PbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:31:19 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEF1D47;
        Wed, 29 Nov 2023 07:31:24 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01BDEE0003;
        Wed, 29 Nov 2023 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701271883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WerIBZOnq6P8oT/o/o5rlHVAMWDVtIsPC8yaH6UlHFk=;
        b=efx3Mr/Y1F3Vc6GzFGkw0FVPYoq7B9HKnvqdqyWwV8nFwAyiIX3kJmYw1EuZ7xRaZ6ULbR
        LtwaDlm41FYNS3cR9BvWcouPCKe3Ldj6lCeEwO8De0ozO1ZrIZutYOUxSbEsBmVXm/wqdQ
        7DgjL1vF7jVApL1d67dRJuAXcD2FUeAsyDoGriMrjbvN9VQo+87XUHdMaVNyJlBr4THvAw
        fKhCAsTsX2l+chewhEBuh9OJqnIn5z8H9JOL7TBIpTX140ZfCQMDxOHbuxk4kPGi1RfYx4
        C6szAcd+XgdaCcuxNfG1mcfRbSw0t059X+Hb9SQyvct1KgYCvE9SKZE/5+iG2Q==
From:   Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH 0/5] Add suspend/resume support in ti_sci driver for j7200
Date:   Wed, 29 Nov 2023 16:31:16 +0100
Message-Id: <20231129-j7200-tisci-s2r-v1-0-c1d5964ed574@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAERZZ2UC/x2N0QrCMAxFf2Xk2UCb6qT+ivjQxegiWCUZQxj7d
 7s9Hs493AVcTMXh0i1gMqvrpzaIhw54LPUpqPfGQIFSjJTxdaYQcFJnRSfDPjPFzCkdTz20aig
 uOFipPG7du/gkti/ntPmvyUN/++P1tq5/s4uniYEAAAA=
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, u-kumar1@ti.com,
        Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During suspend, some devices free their irqs and request them at resume.
But there are some devices which don't do it, and assume that it's done
by the resource allocator.
On j7200, during suspend to ram the SoC is powered-off, so the allocated
irqs are lost.
With this series, ti_sci has an internal list of allocated irqs. It will
restore these irqs during its resume_noirq.

Moreover, ti_sci checks that there is at least a reserved memory region for
lpm. These regions are used by TF-A and R5 SPL during suspend and resume. 
We need to reserve some memory from the linux point of view to avoid any
memory corruption. 

A new compatible (ti,j7200-sci) was created for this specific behavior.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Thomas Richard (5):
      dt-bindings: arm: keystone: add ti,j7200-sci compatible
      firmware: ti_sci: add suspend/resume support for irqs
      arm64: dts: ti: k3-j7200: use ti,j7200-sci compatible
      firmware: ti-sci: for j7200 before suspend check the reserved memory for lpm
      arm64: dts: ti: k3-j7200: add reserved memory regions for lpm

 .../devicetree/bindings/arm/keystone/ti,sci.yaml   |   2 +
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    |   2 +-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |  10 ++
 drivers/firmware/ti_sci.c                          | 191 ++++++++++++++++++++-
 4 files changed, 196 insertions(+), 9 deletions(-)
---
base-commit: 2041413d851e6dccd5c91321498e1d159ea432f2
change-id: 20231129-j7200-tisci-s2r-69c219c33456

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>

