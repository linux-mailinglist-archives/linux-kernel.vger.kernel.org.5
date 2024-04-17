Return-Path: <linux-kernel+bounces-148113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0338A7DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67868B24001
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355B280626;
	Wed, 17 Apr 2024 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="KgI1r9Jd"
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EC770CC5;
	Wed, 17 Apr 2024 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341640; cv=none; b=HuKZwxzcNWzyhHNt1XHTglhh7TOC0ToSzjrM5pRNnHBlE22Dy3OpWELMmIlosZk8x1pgmzJOomBstvBZPkzMAccKDPDw8HxLS6WiCiRKdIOW35DLqPi40W1hfwBKhqPEaEUX7zcHiJDUrGHHl1lU6pszMx3TTKtsZ8AQ9POnFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341640; c=relaxed/simple;
	bh=qGgurSLdIxnGvvA85OsOEq1/ccq0v9G4qO+hOWnOHJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JeD8aE4b/j5Knli93GQh+88Ue3n6KVEEL5tXTkxW/aV4JwE4dPhjL9vBFF6jMsa3m5QZA/Hrz6/dw122mZIpJp0LQ+3aksI5QmKUp1NCAV3eUROj4aGZjymR2irJU0CeOku2cwwdYdC2Y4gZnZZjoO+1OzUftlcDHcsVH7SL3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=KgI1r9Jd; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713341639; x=1744877639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VlEp8x4nmhRgzt5E/4ESK0iQWjhztHSzvBe82RnWqc0=;
  b=KgI1r9JdcUUIdv53BO66TTndgJkJUfxtzdtRwIMrHU6LZ9RrabTkU8kc
   4a8XMSAzYsMifNPPckZ15hMZV3SU8Yvbwt33XJlONMDHHUaeAlhrq7+r/
   a5rUcs7HzjAJLVlYrFawNRYbIVATlyDm0i9RVO5zYX7hpWzsQhYu0mopI
   0=;
X-IronPort-AV: E=Sophos;i="6.07,208,1708387200"; 
   d="scan'208";a="390310181"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 08:13:58 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:42831]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.19.90:2525] with esmtp (Farcaster)
 id be79949d-0735-4e17-b7ff-5f55a89fc8a5; Wed, 17 Apr 2024 08:13:56 +0000 (UTC)
X-Farcaster-Flow-ID: be79949d-0735-4e17-b7ff-5f55a89fc8a5
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:13:50 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.1.212.48) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:13:44 +0000
From: Babis Chalios <bchalios@amazon.es>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <olivia@selenic.com>,
	<herbert@gondor.apana.org.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <bchalios@amazon.es>, <graf@amazon.de>,
	<xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>
Subject: [PATCH v5 4/5] dt-bindings: rng: Add vmgenid support
Date: Wed, 17 Apr 2024 10:12:11 +0200
Message-ID: <20240417081212.99657-5-bchalios@amazon.es>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240417081212.99657-1-bchalios@amazon.es>
References: <20240417081212.99657-1-bchalios@amazon.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

From: Sudan Landge <sudanl@amazon.com>

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
2.40.1


