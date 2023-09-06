Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AEE793882
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjIFJlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjIFJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:41:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649D71BB;
        Wed,  6 Sep 2023 02:41:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14B7C433C7;
        Wed,  6 Sep 2023 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693993307;
        bh=oCKfqMVNrxKpZHzFqM4z491hl+uPYruxSgEUicAfYlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IPfvt3V8gQEtfMQf2/0frKr6SedXyogmBexVdS1IpDWWUMYEtBEknaayZlXgNoWvd
         Q8BlxFe5JQJoT8K17x7MbfkCq2wFRMBErHwCI49t+jGx/+uptK69GngE/FFtpphSXD
         GCKMX9xRyvlGNfVP+0m7rxCjmtpP6aacMbVjbAJFB/F325KxDeCSDKfF7BQYkICXWG
         Omo2C+vDpTHmf0+BB0POnecJZQs9JgO/P15bXywSN0VuCrblZrEvy+ZMK8WR9APREi
         UfV2uOdH2NITAKYSIGnvLCJvOPP+mFfjf2nCx9Kf5bqLKj1YdimM/W/jZAGPQEXk5t
         Qgm8oCuAyvOgA==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2 0/2] irqchip/gic-v3: Enable non-coherent GIC designs probing
Date:   Wed,  6 Sep 2023 11:41:37 +0200
Message-Id: <20230906094139.16032-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905104721.52199-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is v2 of a previous version[1].

v1 -> v2:
	- Updated DT bindings as per feedback
	- Updated patch[2] to use GIC quirks infrastructure

[1] https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org

Original cover letter
---
The GICv3 architecture specifications provide a means for the
system programmer to set the shareability and cacheability
attributes the GIC components (redistributors and ITSes) use
to drive memory transactions.

Albeit the architecture give control over shareability/cacheability
memory transactions attributes (and barriers), it is allowed to
connect the GIC interconnect ports to non-coherent memory ports
on the interconnect, basically tying off shareability/cacheability
"wires" and de-facto making the redistributors and ITSes non-coherent
memory observers.

This series aims at starting a discussion over a possible solution
to this problem, by adding to the GIC device tree bindings the
standard dma-noncoherent property. The GIC driver uses the property
to force the redistributors and ITSes shareability attributes to
non-shareable, which consequently forces the driver to use CMOs
on GIC memory tables.

On ARM DT DMA is default non-coherent, so the GIC driver can't rely
on the generic DT dma-coherent/non-coherent property management layer
(of_dma_is_coherent()) which would default all GIC designs in the field
as non-coherent; it has to rely on ad-hoc dma-noncoherent property handling.

When a consistent approach is agreed upon for DT an equivalent binding will
be put forward for ACPI based systems.

Lorenzo Pieralisi (2):
  dt-bindings: interrupt-controller: arm,gic-v3: Add dma-noncoherent
    property
  irqchip/gic-v3: Enable non-coherent redistributors/ITSes probing

 .../interrupt-controller/arm,gic-v3.yaml      | 12 +++++++++++
 drivers/irqchip/irq-gic-common.h              |  4 ++++
 drivers/irqchip/irq-gic-v3-its.c              | 21 +++++++++++++++----
 drivers/irqchip/irq-gic-v3.c                  | 13 ++++++++++++
 4 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.34.1

