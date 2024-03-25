Return-Path: <linux-kernel+bounces-117857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB21B88B087
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428201FA3633
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A673EA95;
	Mon, 25 Mar 2024 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eNMDJr+2"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AB3482EB;
	Mon, 25 Mar 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396426; cv=none; b=QEnf742qFvnv+d0RqNeoZkLRC3xWoEW9E5UWZHTsldKnns1zzDbhIBLs6vyY77N3n330eBTyoGPdm+0so2dZK4HbVxGGpcO8vEDHRwFe3qoATVhUCbTlWzRlbwdyrQ3DVe3mES0FVMGZ1X4wQktbZIbc3uYtF0iiwr9d+qzQdvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396426; c=relaxed/simple;
	bh=GFGzs9et60G/U08sqKPCyX+gjwPAtjZmArJvI7mOHFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tP3GhLUKFvQjzTfpU/wQtSDRqnJhQtuxbWeYaJsVGFwbbcfljjyLMgCciI2yLSDsoPYtDIdEhGH7wDoOWZXTvrRBaYQXDoIp1uCzaU6+tg0jNfzHSIjjgocvivZ+IbjD6PbGzsyEVyk/WEgzwncu8wepiB4Z2kd+EcQUMVozKWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eNMDJr+2; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711396424; x=1742932424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8vSxYYjnh5jLuw/n28r6x07Vkzh/WohwY3OP2PwKVus=;
  b=eNMDJr+2oREN9fOJhA7BuG6+YaTzHIJVsieinw7gTW5vc707BMNQUiye
   lT+f8I4CZtuRRsL4CcfgD/2lXc+jnQ40RRTXchGsza1F4sLayR41gIX+q
   RydzrHghCOoMjVyPi2yUA/9gkWGkcfLQ3cKTIIOKtSboeJeAh9WPZXDKy
   g=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="390412313"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:53:43 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:40238]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.153:2525] with esmtp (Farcaster)
 id ff591b8d-2c64-4631-85f3-35c0594d0314; Mon, 25 Mar 2024 19:53:43 +0000 (UTC)
X-Farcaster-Flow-ID: ff591b8d-2c64-4631-85f3-35c0594d0314
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 19:53:40 +0000
Received: from bcd074994f7f.amazon.com (10.106.83.11) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 19:53:35 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v3 3/4] dt-bindings: rng: Add vmgenid support
Date: Mon, 25 Mar 2024 19:53:05 +0000
Message-ID: <20240325195306.13133-4-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240325195306.13133-1-sudanl@amazon.com>
References: <20240325195306.13133-1-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
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
 - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-
machine-generation-identifier

Signed-off-by: Sudan Landge <sudanl@amazon.com>
---
 .../devicetree/bindings/rng/vmgenid.yaml      | 58 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/vmgenid.yaml

diff --git a/Documentation/devicetree/bindings/rng/vmgenid.yaml b/Documentation/devicetree/bindings/rng/vmgenid.yaml
new file mode 100644
index 000000000000..24643080d6b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/vmgenid.yaml
@@ -0,0 +1,58 @@
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
+    const: virtual,vmgenctr
+
+  "#interrupt-cells":
+    const: 3
+    description:
+      The 1st cell is the interrupt type.
+      The 2nd cell contains the interrupt number for the interrupt type.
+      The 3rd cell is for trigger type and level flags.
+
+  interrupt-map: true
+
+  reg:
+    description:
+      The 1st cell specifies the base physical address of the 8-byte aligned
+      buffer in guest memory space which is guaranteed not to be used by the
+      operating system.
+      The 2nd cell specifies the size of the buffer which holds the VMGenID.
+    maxItems: 1
+
+  interrupts:
+    description:
+      interrupt used to notify that a new VMGenID counter is available.
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
+      compatible = "virtual,vmgenctr";
+      reg = <0x80000000 0x1000>;
+      interrupts = <0x00 0x23 0x01>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index de6a64b248ae..e295d2f50af4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18461,6 +18461,7 @@ M:	"Theodore Ts'o" <tytso@mit.edu>
 M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
+F:	Documentation/devicetree/bindings/rng/vmgenid.yaml
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
 
-- 
2.40.1



