Return-Path: <linux-kernel+bounces-109604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 766EE881B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E301F2178A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838406FC5;
	Thu, 21 Mar 2024 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ajILYF2/"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46FDBE4A;
	Thu, 21 Mar 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710989495; cv=none; b=NG6HzJ5t0NTEjE7UARU19JL1wa1ZIKOR0kvys9pIWTyGm/0gBlG5+DwMLy5vPRbdtpjXdvivoc5TZAZOjFnHo1N6z2QF2b1N3qd21UbXmKAjxUqxNN8rWmtOTC3bCzS/g/PieTTBhixeeRm3kjQkUj9Us0vgaTcN1fDoCOJe6nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710989495; c=relaxed/simple;
	bh=i4WFnTjbboOv3N6BjZB4Dczpvy+GhVVvEUDiM6kzroU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fr6eYIDCJ0kYeQDkgFg9Ul+aBeiYuiM9lpjwFC6NbxJE5Lf1DOiZVkRSJvyfhCB/1b/OvG8SevBnXyqUmQNH/Xa7cABAl5rp/rbUEUYvEJ3hZy1bU3Qi5o65QxSqCYk20GEshN+SR7Ut/XsEdZ5c1Ti8vo8gJQGKwNY/lkaeiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ajILYF2/; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710989494; x=1742525494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G5dhZaRQlfB7f7CNYBWHN5QscrDy9JTquI8zOhrJCpk=;
  b=ajILYF2/e62girKfI9IR7p8CYMBfC5O1vvbPosxeorD+l0dN+4N2HFGs
   EXqS5XEBlByxsTjwGCmGfBIs8XVADidEvmTdjM7yZIcLtrzs3Pa+qphk+
   1p6j81rmhagwftGgFoNGn743fgYLZlq8PEphnqAFrdIS+7MN4mkNZFuEG
   4=;
X-IronPort-AV: E=Sophos;i="6.07,141,1708387200"; 
   d="scan'208";a="394817793"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 02:51:33 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:25006]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.23.112:2525] with esmtp (Farcaster)
 id 02fcd6f8-c622-4150-946e-5f418e1db5de; Thu, 21 Mar 2024 02:51:32 +0000 (UTC)
X-Farcaster-Flow-ID: 02fcd6f8-c622-4150-946e-5f418e1db5de
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 02:51:31 +0000
Received: from bcd074994f7f.amazon.com (10.106.82.23) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 02:51:27 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v2 3/4] dt-bindings: rng: Add vmgenid support
Date: Thu, 21 Mar 2024 02:51:04 +0000
Message-ID: <20240321025105.53210-4-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240321025105.53210-1-sudanl@amazon.com>
References: <20240321025105.53210-1-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)

Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
("virt: vmgenid: notify RNG of VM fork and supply generation ID"), as an
ACPI only device.

VMGenID specification http://go.microsoft.com/fwlink/?LinkId=260709 defines
a mechanism for the BIOS/hypervisors to communicate to the virtual machine
that it is executed with a different configuration (e.g. snapshot execution
or creation from a template).
The guest operating system can use the notification for various purposes
such as re-initializing its random number generator etc.

As per the specs, hypervisor should provide a globally unique identified,
or GUID via ACPI.

This patch tries to mimic the mechanism to provide the same functionality
which is for a hypervisor/BIOS to notify the virtual machine when it is
executed with a different configuration.

As part of this support the devicetree bindings requires the hypervisors or
BIOS to provide a memory address which holds the GUID and an IRQ which is
used to notify when there is a change in the GUID.
The memory exposed in the DT should follow the rules defined in the
vmgenid spec mentioned above.

*Reason for this change*:
Chosing ACPI or devicetree is an intrinsic part of an hypervisor design.
Without going into details of why a hypervisor would chose DT over ACPI,
we would like to highlight that the hypervisors that have chose devicetree
and now want to make use of the vmgenid functionality cannot do so today
because vmgenid is an ACPI only device.
This forces these hypervisors to change their design which could have
undesirable impacts on their use-cases, test-scenarios etc.

The point of vmgenid is to provide a mechanism to discover a GUID when
the execution state of a virtual machine changes and the simplest
way to do it is pass a memory location and an interrupt via devicetree.
It would complicate things unnecessarily if instead of using devicetree,
we try to implement a new protocol or modify other protocols to somehow
provide the same functionility.

We believe that adding a devicetree binding for vmgenid is a simpler,
better alternative to provide the same functionality and will allow
such hypervisors as mentioned above to continue using devicetree.

More references to vmgenid specs:
 - https://www.qemu.org/docs/master/specs/vmgenid.html
 - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-machine-generation-identifier

Signed-off-by: Sudan Landge <sudanl@amazon.com>
---
 .../devicetree/bindings/rng/vmgenid.yaml      | 57 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/vmgenid.yaml

diff --git a/Documentation/devicetree/bindings/rng/vmgenid.yaml b/Documentation/devicetree/bindings/rng/vmgenid.yaml
new file mode 100644
index 000000000000..4b6ab62cc2ae
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/vmgenid.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/vmgenid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual Machine Generation Counter ID device
+
+maintainers:
+  - Jason A. Donenfeld <Jason@zx2c4.com>
+
+description:
+  Firmwares or hypervisors can use this devicetree to describe
+  interrupts and the shared resources to inject a Virtual Machine Generation
+  counter.
+
+properties:
+  compatible:
+    const: linux,vmgenctr
+
+  "#interrupt-cells":
+    const: 3
+    description: |
+      The 1st cell is the interrupt type.
+      The 2nd cell contains the interrupt number for the interrupt type.
+      The 3rd cell is for trigger type and level flags.
+
+  interrupt-controller: true
+
+  reg:
+    description: |
+      specifies the base physical address and
+      size of the regions in memory which holds the VMGenID counter.
+    maxItems: 1
+
+  interrupts:
+    description: |
+      interrupt used to notify that a new VMGenID counter is available.
+      The interrupt should be Edge triggered.
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
+    rng@80000000 {
+      compatible = "linux,vmgenctr";
+      reg = <0x80000000 0x1000>;
+      interrupts = <0x00 0x23 0x01>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 43b39956694a..cf4b2e10fb49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18431,6 +18431,7 @@ M:	"Theodore Ts'o" <tytso@mit.edu>
 M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
+F:	Documentation/devicetree/bindings/rng/vmgenid.yaml
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
 
-- 
2.40.1



