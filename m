Return-Path: <linux-kernel+bounces-11973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FF081EE61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59981F21603
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47294438A;
	Wed, 27 Dec 2023 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzdLFPbw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CD44436F;
	Wed, 27 Dec 2023 11:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662A6C433C8;
	Wed, 27 Dec 2023 11:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703674845;
	bh=qIZiNp07P2dP+2YD1/RkaqTfi12jp8LFaMdjyfCAX6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bzdLFPbwo7Z2ego4pEMqr1JcVoKZSmL2SrqX+3zdXSwRH1u0hXNiAvswuWVVL/S7t
	 hIHU5QB6qFEMlVGoggvmSeXKkgb45SQg12B+02JZLbqws1OWr0OsgxGV72Ym+18f13
	 ndowEg2ethRTsQiN2+WsTChAABkL2fEogfJ5Ni54iqwUj8PaAtIx3zcUujLgvGUyLM
	 ZbncNBWJP80aG7kPZph97WxVLXBJtC1UE/fvDn+mV5cyv31oqORnML9//v+sAfyqx6
	 R0B+mXdLYDxZ7Us9umIPRR35EaqYadBSt9WjiIKliRNqBTrNN3FUu6ZY5W88MbyOWD
	 86yhr3w8q+Jdg==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Fang Xiang <fangxiang3@xiaomi.com>,
	Marc Zyngier <maz@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v4 0/3] irqchip/gic-v3: Enable non-coherent GIC designs probing
Date: Wed, 27 Dec 2023 12:00:35 +0100
Message-Id: <20231227110038.55453-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905104721.52199-1-lpieralisi@kernel.org>
References: <20230905104721.52199-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is v4 of previous series:

v3: https://lore.kernel.org/all/20231006125929.48591-1-lpieralisi@kernel.org
v2: https://lore.kernel.org/all/20230906094139.16032-1-lpieralisi@kernel.org
v1: https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org

v3 -> v4:
	- Dropped patches [1-3], already merged
	- Added Linuxized ACPICA changes accepted upstream
	- Rebased against v6.7-rc3

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

Lorenzo Pieralisi (3):
  ACPICA: MADT: Add GICC online capable bit handling
  ACPICA: MADT: Add new MADT GICC/GICR/ITS non-coherent flags handling
  irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing

 drivers/acpi/processor_core.c    | 21 +++++++++++++++++++++
 drivers/irqchip/irq-gic-common.h |  8 ++++++++
 drivers/irqchip/irq-gic-v3-its.c |  4 ++++
 drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
 include/acpi/actbl2.h            | 12 ++++++++++--
 include/linux/acpi.h             |  3 +++
 6 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.34.1


