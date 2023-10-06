Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875247BB852
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjJFM7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJFM7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:59:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5EECF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:59:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F24AC433C8;
        Fri,  6 Oct 2023 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696597177;
        bh=4MA/LskURMEJ12KVbP+fP6rhRzcvwd/Y3VAARsbtgKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bETbu+rA1puRoxryATnjVCGhe6ye4E0ESqOWM6iYAC/DHD1zut2RX78JHqc+hYyGD
         7z2fo359Izt9OJ6Hs+5nywrwiZ9aa/o4oMbrsFy1GIHGEfRk/LmdxFIrsJsU1uIArh
         rDdSMpM6jmotdHt3qsJXrcIYljGLxAUhLLvdrELcASS5Cs3JVXdvbXUbpats7CgkEC
         dvbaWN4pbyoqOkvFo7ZHQgSMDQv2qyVORbjMuqEA5VGAI8Bg80N522iXxKGc1Ll9c7
         obD9dwFN/dGaGqIOarT0IeFfTcKpMdf9iRq05P2TmVklXSHoZobiMFEGOZa/vvrc9c
         uekebDszGTMxQ==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fang Xiang <fangxiang3@xiaomi.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v3 0/5] irqchip/gic-v3: Enable non-coherent GIC designs probing
Date:   Fri,  6 Oct 2023 14:59:24 +0200
Message-Id: <20231006125929.48591-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905104721.52199-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
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

This series is v3 of previous series:

v2: https://lore.kernel.org/all/20230906094139.16032-1-lpieralisi@kernel.org
v1: https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org

v2 -> v3:
	- Added ACPICA temporary changes and ACPI changes to implement
	  ECR https://bugzilla.tianocore.org/show_bug.cgi?id=4557
	- ACPI changes are for testing purposes - subject to ECR code
	  first approval

v1 -> v2:
	- Updated DT bindings as per feedback
	- Updated patch[2] to use GIC quirks infrastructure

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

Lorenzo Pieralisi (4):
  dt-bindings: interrupt-controller: arm,gic-v3: Add dma-noncoherent
    property
  irqchip/gic-v3: Enable non-coherent redistributors/ITSes DT probing
  ACPICA: Add new MADT GICC/GICR/ITS flags handling [code first]
  irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing

Marc Zyngier (1):
  irqchip/gic-v3-its: Split allocation from initialisation of its_node

 .../interrupt-controller/arm,gic-v3.yaml      |  12 ++
 drivers/acpi/processor_core.c                 |  21 +++
 drivers/irqchip/irq-gic-common.h              |  12 ++
 drivers/irqchip/irq-gic-v3-its.c              | 174 +++++++++++-------
 drivers/irqchip/irq-gic-v3.c                  |  22 +++
 include/acpi/actbl2.h                         |  11 +-
 include/linux/acpi.h                          |   3 +
 7 files changed, 189 insertions(+), 66 deletions(-)

-- 
2.34.1

