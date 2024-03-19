Return-Path: <linux-kernel+bounces-107655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A2E87FFAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EB11C21A81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79212657C8;
	Tue, 19 Mar 2024 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="S7/1h4rU"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72541F608;
	Tue, 19 Mar 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858806; cv=none; b=uMzfOJCo+4s+3VW5A9ea4RLooOq4Wk/ijQc9imJhEyZk0jKQhJcUV8CCxZE51UhUxjC55ovB3KaJQ7qoVF4SpFSdEyEUkHxPAN6xVRNNyE5XLwZVzhN7FAmozULYBDoCK+V/IcXAZIe8ikaVTy5+0w8uvrc9X3a447UkilahKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858806; c=relaxed/simple;
	bh=Nl4bkJNbQyhAtavoaz14N2Rq3aUzmmBrorGsRwloGmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDeqfL2NiU8qTVA20twBqimgJKnx9THosJDEiV4ItOfTYiWHtNjckdHbfQa1xSsLPPfQ+jFA9iXyXitjHmYWXVzt5fNq4TPycGd7fk0qCGSt6delHIxMgecW0yFVeQY9fjUMzX1dJw+Q/UxNbyDlVNOTXP+MXP4IvxTEnqVMx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=S7/1h4rU; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710858805; x=1742394805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rwn0ekYo1tnoNE3SYSolZc3xYMZlKQKYCAUM+58pS+E=;
  b=S7/1h4rUFKwy0DuhyEh4EOCN1q+2TWArHtKtBj8gUkCyKNhmJfbv0g4e
   i+dR8uz+3hokxhjsK0YYgI5QvJKq65guB79EtAMDe+VnIC2Fbx5SQ8csj
   XAcckVNmU2Dya3HUo8ljcE2RJscMR/QQF4gEw6miHDxAYc/j31lmqQYGW
   8=;
X-IronPort-AV: E=Sophos;i="6.07,137,1708387200"; 
   d="scan'208";a="394339031"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 14:33:24 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:35707]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.20.163:2525] with esmtp (Farcaster)
 id 1209ae3c-a02c-438f-8b73-91d9dc067d39; Tue, 19 Mar 2024 14:33:23 +0000 (UTC)
X-Farcaster-Flow-ID: 1209ae3c-a02c-438f-8b73-91d9dc067d39
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 14:33:23 +0000
Received: from bcd074994f7f.amazon.com (10.106.83.11) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 14:33:18 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v1 3/4] dt-bindings: Add bindings for vmgenid
Date: Tue, 19 Mar 2024 14:32:52 +0000
Message-ID: <20240319143253.22317-4-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240319143253.22317-1-sudanl@amazon.com>
References: <20240319143253.22317-1-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)

Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
("virt: vmgenid: notify RNG of VM fork and supply generation ID"), as an
ACPI only device.

Add a devicetree binding support for vmgenid so that hypervisors
can support vmgenid without the need to support ACPI.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
---
 .../devicetree/bindings/vmgenid/vmgenid.yaml  | 57 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/vmgenid/vmgenid.yaml

diff --git a/Documentation/devicetree/bindings/vmgenid/vmgenid.yaml b/Documentation/devicetree/bindings/vmgenid/vmgenid.yaml
new file mode 100644
index 000000000000..17773aa96f8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/vmgenid/vmgenid.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/vmgenid/vmgenid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual Machine Generation Counter ID device.
+
+maintainers:
+  - Jason A. Donenfeld <Jason@zx2c4.com>
+
+description: |+
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
+    vmgenid@80000000 {
+      compatible = "linux,vmgenctr";
+      reg = <0x80000000 0x1000>;
+      interrupts = <0x00 0x23 0x01>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d818866d6d73..e602a51b9bd7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18359,6 +18359,7 @@ M:	"Theodore Ts'o" <tytso@mit.edu>
 M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
+F:	Documentation/devicetree/bindings/vmgenid/vmgenid.yaml
 F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
 
-- 
2.40.1



