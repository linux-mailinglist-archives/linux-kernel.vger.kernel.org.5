Return-Path: <linux-kernel+bounces-137358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D089E102
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE031F222BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC0C156866;
	Tue,  9 Apr 2024 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nl3uHo+7"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C4155391;
	Tue,  9 Apr 2024 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682141; cv=none; b=KBoQt1gEpr6l2+mJfO/kDHQDZyyfjsxElG8E4t0bZqFrbp2amRaN185+w8/u2tMVN6wwNleftqoNnYKFOuRJDuA/oHbdiwDRD1ZlxqThc7wTsKDlDbAKSU3TulU54OZLNSmtStyANNBPVlDTscLcp/Q8VZWd+aEQtBK6DyBvO3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682141; c=relaxed/simple;
	bh=dn+lAleatEKuaifZlrvPWySPzKxUqpTQLCOmlh50Oqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMuQq0gfMj6XL1QNTyyqVPM0SWEEfg8lCeH71N5uyFZrL2Mdb/Ee1kmQZg2M2m0TEwnWjfbfdlxuZnkGUP4KgN18igx6WdXc8qA+3PlPDyjCemYktRUgDT4oYPFEsUTn/x1pp9ZX7LtrBAFynV7h+9Vzkrmpa+KV3NGvHfgUKvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nl3uHo+7; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712682139; x=1744218139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lgg88BB+Hs9vOysnsDN018CMkG589f+hMJJXDN4bMMc=;
  b=nl3uHo+70CEivZfCEpue9rHMRVPcKF7MEWAFRJ+TxbxCpkWFY8y45Zoi
   ghOzuFrHDK9E54DK/5aqdMTx8i/zt7EAgctT1pJLGW7pO4l6MdIp1JgOT
   k43WID82RCVcvNBLkxHbRCzuIbHuUDcHYSZsTYV1+EXbRGKwHbD2eOxRf
   k=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="79859137"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:02:17 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:33596]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.194:2525] with esmtp (Farcaster)
 id c734f48e-9821-4d47-8048-be66beb41896; Tue, 9 Apr 2024 17:02:16 +0000 (UTC)
X-Farcaster-Flow-ID: c734f48e-9821-4d47-8048-be66beb41896
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 17:02:15 +0000
Received: from bcd074994f7f.amazon.com (10.95.97.144) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 17:02:11 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v4 4/5] dt-bindings: rng: Add vmgenid support
Date: Tue, 9 Apr 2024 18:01:36 +0100
Message-ID: <20240409170137.79197-5-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240409170137.79197-1-sudanl@amazon.com>
References: <20240409170137.79197-1-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
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
Without going into details of why a hypervisor would choose DT over ACPI,
we would like to highlight that the hypervisors that have chose devicetree
and now want to make use of the vmgenid functionality cannot do so today
because vmgenid is an ACPI only device.
This forces these hypervisors to change their design which could have
undesirable impacts on their use-cases, test-scenarios etc.

vmgenid exposes to the guest a 16-byte cryptographically random number,
the value of which changes every time it starts executing from a new
configuration (snapshot, backup, etc.). During initialization, the device
exposes to the guest the address of the generation ID and
an interrupt number, which the device will use to notify the guest when
the generation ID changes.
These attributes can be trivially communicated via device tree bindings.

We believe that adding a devicetree binding for vmgenid is a simpler
alternative way to expose the device to the guest than forcing the
hypervisors to implement ACPI.

More references to vmgenid specs:
 - https://www.qemu.org/docs/master/specs/vmgenid.html
 - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-
machine-generation-identifier

Signed-off-by: Sudan Landge <sudanl@amazon.com>
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
index aea47e04c3a5..243607744b7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18476,6 +18476,7 @@ M:	"Theodore Ts'o" <tytso@mit.edu>
 M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
+F:	Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
 
-- 
2.34.1


