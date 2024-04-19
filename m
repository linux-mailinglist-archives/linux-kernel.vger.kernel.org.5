Return-Path: <linux-kernel+bounces-152011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EC28AB751
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4691F22072
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1B13D88B;
	Fri, 19 Apr 2024 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gUeEFWlm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516CF13DB9B;
	Fri, 19 Apr 2024 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713566439; cv=none; b=uSWz3xzmBivick1fM+CTsgeGJQGcWCEdo0YacfyITbicyfMYZEhWjZIluidX8TgVh/TToCwVL7tgMTBZz2vB7x0CNgR/nepkpTHboeQyIb7k3HYWk6joz2DQNpVZmXtT4MAo3I18FDGpdVSJXzR3UxLZzimC7vii20av9ad5pBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713566439; c=relaxed/simple;
	bh=ErwPeRbH++s2//PbjnVZnkQnaI5e9Bqpjk54K44Qia0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq7btYAbudbXhF3TjSFxXiluXlKJFBLI/BH15bVJVgPg7nfx74q3HT0ASdnIQgMbcRtzUNrYdS99hK9mXZOODEnlezy1Y01ZTDQ1pY4iUad9roiHYG7/uq/3BIH1/54ufaeX6xKbs0Ad8tY/dNi881NYUmwyU+/7c6q67MoRcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=gUeEFWlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC67BC072AA;
	Fri, 19 Apr 2024 22:40:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gUeEFWlm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713566436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Npv4DPrEoAcZpMwaWHoET4ASGglyUL7AxON3/pnPZ8s=;
	b=gUeEFWlm2J3Z/tmTyHFu6E9bAnrhl9C7FOnLRyqgkgwwb7l9M08Fqk8umm4kNRsp1dyEOx
	s60O2Z1C9JzVwK5UrrEeKHMVTJGdZpBsYT2d5tmUb/JMnWL8ppMOZar6g4913SIB4fzuBr
	IrQ1z62vQzaT+Ifa8dCfnyZp4Dhu6bU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d83aadf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 22:40:36 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: tytso@mit.edu,
	robh@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sudanl@amazon.com,
	graf@amazon.com,
	dwmw@amazon.co.uk,
	krzysztof.kozlowski@linaro.org,
	bchalios@amazon.es
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v8 2/3] dt-bindings: rng: Add vmgenid support
Date: Sat, 20 Apr 2024 00:39:59 +0200
Message-ID: <20240419224020.780377-3-Jason@zx2c4.com>
In-Reply-To: <20240419224020.780377-1-Jason@zx2c4.com>
References: <20240419224020.780377-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sudan Landge <sudanl@amazon.com>

Virtual Machine Generation ID driver was introduced in commit
af6b54e2b5ba ("virt: vmgenid: notify RNG of VM fork and supply
generation ID"), as an ACPI only device.

VMGenID specification http://go.microsoft.com/fwlink/?LinkId=260709
defines a mechanism for the BIOS/hypervisors to communicate to the
virtual machine that it is executed with a different configuration (e.g.
snapshot execution or creation from a template).  The guest operating
system can use the notification for various purposes such as
re-initializing its random number generator etc.

As per the specs, hypervisor should provide a globally unique
identified, or GUID via ACPI.

This patch tries to mimic the mechanism to provide the same
functionality which is for a hypervisor/BIOS to notify the virtual
machine when it is executed with a different configuration.

As part of this support the devicetree bindings requires the hypervisors
or BIOS to provide a memory address which holds the GUID and an IRQ
which is used to notify when there is a change in the GUID.  The memory
exposed in the DT should follow the rules defined in the vmgenid spec
mentioned above.

Reason for this change: Chosing ACPI or devicetree is an intrinsic part
of an hypervisor design.  Without going into details of why a hypervisor
would chose DT over ACPI, we would like to highlight that the
hypervisors that have chose devicetree and now want to make use of the
vmgenid functionality cannot do so today because vmgenid is an ACPI only
device.  This forces these hypervisors to change their design which
could have undesirable impacts on their use-cases, test-scenarios etc.

The point of vmgenid is to provide a mechanism to discover a GUID when
the execution state of a virtual machine changes and the simplest way to
do it is pass a memory location and an interrupt via devicetree.  It
would complicate things unnecessarily if instead of using devicetree, we
try to implement a new protocol or modify other protocols to somehow
provide the same functionility.

We believe that adding a devicetree binding for vmgenid is a simpler,
better alternative to provide the same functionality and will allow such
hypervisors as mentioned above to continue using devicetree.

More references to the vmgenid specs are found below.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Alexander Graf <graf@amazon.com>
Link: https://www.qemu.org/docs/master/specs/vmgenid.html
Link: https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-machine-generation-identifier
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 .../bindings/rng/microsoft,vmgenid.yaml       | 49 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml

diff --git a/Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml b/Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
new file mode 100644
index 000000000000..8f20dee93e7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/microsoft,vmgenid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual Machine Generation ID
+
+maintainers:
+  - Jason A. Donenfeld <Jason@zx2c4.com>
+
+description:
+  Firmwares or hypervisors can use this devicetree to describe an
+  interrupt and a shared resource to inject a Virtual Machine Generation ID.
+  Virtual Machine Generation ID is a globally unique identifier (GUID) and
+  the devicetree binding follows VMGenID specification defined in
+  http://go.microsoft.com/fwlink/?LinkId=260709.
+
+properties:
+  compatible:
+    const: microsoft,vmgenid
+
+  reg:
+    description:
+      Specifies a 16-byte VMGenID in endianness-agnostic hexadecimal format.
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt used to notify that a new VMGenID is available.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    rng@80000000 {
+      compatible = "microsoft,vmgenid";
+      reg = <0x80000000 0x1000>;
+      interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c23fda1aa1f0..efd8de759d95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18469,6 +18469,7 @@ M:	"Theodore Ts'o" <tytso@mit.edu>
 M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
+F:	Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
 
-- 
2.44.0


