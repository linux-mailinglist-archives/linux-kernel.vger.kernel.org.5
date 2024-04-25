Return-Path: <linux-kernel+bounces-158520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485FD8B219E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37298B2362A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24C112C487;
	Thu, 25 Apr 2024 12:30:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004A12BF28
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048203; cv=none; b=muL3CtVbjIWeDPAU2vsQ6EYhpYPP+eNNvMIR5OjRlXu8fgy/1wFpTyBa/E3+Lc9fajxHvD7WNaW61ttfajIFy7E5oGKeMoFBIbSu2VkNxM159DeD1+fFg+sKOWuj357UU2R1hWZRkoLEnHazgNThklsIeFnD/G6ou0lb3K8F5uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048203; c=relaxed/simple;
	bh=YtFdR1co+3GAWMeDhxDDM6GjZXQSQT6/FStEqtv924w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U04A5zCAmx5jj3HJPzyxqv/aClVV+8Bc1gkNsTM1n12+fpYk9mhbSAWp3o64qZwdObqVicgWH2g6D/qbVaawRLtDSosoA6TCHROPttfihqsfzWf4S9+tVE9wADx79hIqJ/UANTSdJ+ybeZ0tnBx/ACYqrtyonLYgpkWxEzpv2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD7CB1063;
	Thu, 25 Apr 2024 05:30:28 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2CCE3F7BD;
	Thu, 25 Apr 2024 05:29:59 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn
Subject: [PATCH 1/3] dt-bindings/perf: Add Arm NI-700 PMU
Date: Thu, 25 Apr 2024 13:29:52 +0100
Message-Id: <4992eacd883cbc54519ffea5bd35f80463cf504a.1713972897.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1713972897.git.robin.murphy@arm.com>
References: <cover.1713972897.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an initial binding for the Arm NI-700 interconnect PMU. As with the
Arm CMN family, there are already future NI products on the roadmap, so
the overall binding is named generically just in case any
non-discoverable incompatibility between generations crops up.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 .../devicetree/bindings/perf/arm,ni.yaml      | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/arm,ni.yaml

diff --git a/Documentation/devicetree/bindings/perf/arm,ni.yaml b/Documentation/devicetree/bindings/perf/arm,ni.yaml
new file mode 100644
index 000000000000..d66fffa256d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/arm,ni.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/arm,ni.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm NI (Network-on-Chip Interconnect) Performance Monitors
+
+maintainers:
+  - Robin Murphy <robin.murphy@arm.com>
+
+properties:
+  compatible:
+    const: arm,ni-700
+
+  reg:
+    items:
+      - description: Complete configuration register space
+
+  interrupts:
+    minItems: 1
+    maxItems: 32
+    description: Overflow interrupts, one per clock domain, in order of domain ID
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
-- 
2.39.2.101.g768bb238c484.dirty


