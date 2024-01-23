Return-Path: <linux-kernel+bounces-35151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DB4838CE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7DF1F25C66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D65D8ED;
	Tue, 23 Jan 2024 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGmsdftY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263C15D8EA;
	Tue, 23 Jan 2024 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007819; cv=none; b=fDWHI9iI52DtxgjET6HpLZ9/OetqT6P8uQcyNWsTpXBPEYp3VkkmRtBvsIM7ClaWJBTJLC4QNAoP5nR/uRO5PI+97nqOv/vDP1QTmUFXPwiv3Unl44EH/IoDtR1xNEtIJ8oy1+qsfjjlZ1sKysIHT99Gsiqj8uWXEmcDMdIIGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007819; c=relaxed/simple;
	bh=jyHwFlf0bHE9KEIPyirMBwXPxM3oK4/6sY+55qCmc8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cAP3gqpMry0X1myBE8fY7tteBWWHYE8Hj3W/AQtsJZlGXlOk2I/aoPvX6rCLQOQI/Z1l0MerYb9ULBibidGlA35Sy6s7qmMiA+SLB30DJT+m5nJlP/V9MdSauJ3y2vyMnQN9lKcQ25rhJwmncm6FbvDdLoZcmEITYw+o3r74ntw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGmsdftY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8133C32781;
	Tue, 23 Jan 2024 11:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706007818;
	bh=jyHwFlf0bHE9KEIPyirMBwXPxM3oK4/6sY+55qCmc8I=;
	h=From:To:Cc:Subject:Date:From;
	b=RGmsdftYQp083L9bpv+o7IEzQPkf/M5kWaNBeIPefz9etL4hiy9Fqp9dO0FzowKvy
	 G3f5pnPGjSC76upEzAcn9d8gG6lNTY3ApHnPUMg+qCTLPkNc7x9b2D4UUgkcIj8NJN
	 Fxy0urhrplHdVz4yubm4ygqqUZ48b3/ASIr0OK4jxf88wO6lThPNYz5kL/0cr1dO/0
	 NFCWA4pWuSqrPTkCT/pFzj0R2x1YkOlr3tkaLeEfA7JyKqlcMDTg36OqdqkNtOih7H
	 SkOgZ9ynrAHJt+my7fshXN1gm0ysABdHjOkQNTie7II2Br64TB3nq9dks9ZZLLUNNL
	 m51Nn52L3Wm1Q==
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
Subject: [PATCH v5 0/1] irqchip/gic-v3: Enable non-coherent GIC designs probing
Date: Tue, 23 Jan 2024 12:03:31 +0100
Message-Id: <20240123110332.112797-1-lpieralisi@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is v5 of previous series:

v4: https://lore.kernel.org/all/20231227110038.55453-1-lpieralisi@kernel.org
v3: https://lore.kernel.org/all/20231006125929.48591-1-lpieralisi@kernel.org
v2: https://lore.kernel.org/all/20230906094139.16032-1-lpieralisi@kernel.org
v1: https://lore.kernel.org/all/20230905104721.52199-1-lpieralisi@kernel.org

v4 -> v5
	- ACPICA patches merged for v6.8
	- Refactored ACPI parsing code according to review
	- Rebased against v6.8-rc1

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

Lorenzo Pieralisi (1):
  irqchip/gic-v3: Enable non-coherent redistributors/ITSes ACPI probing

 drivers/acpi/processor_core.c    | 15 +++++++++++++++
 drivers/irqchip/irq-gic-v3-its.c |  4 ++++
 drivers/irqchip/irq-gic-v3.c     |  9 +++++++++
 include/linux/acpi.h             |  3 +++
 4 files changed, 31 insertions(+)

-- 
2.34.1


