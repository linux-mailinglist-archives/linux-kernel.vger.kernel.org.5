Return-Path: <linux-kernel+bounces-62056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5BB851AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4436F1F29482
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8AF4D9FA;
	Mon, 12 Feb 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8rB7BgP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C34B5CD;
	Mon, 12 Feb 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757497; cv=none; b=i0FqaQ0AgzXbTJcqwchvCeC4tI1XglXk/VAKxAkJ4vleiYWo0qaUU/jagFkMuHDp300C4M3dhF5fwzlJVqnB+1YgV8NRmr2nHS8b5E1gTsr26RqkMCdmmzw2ibEknqy97in5lpOCTuYkXaAe3FUm3WgpCiocXFsD0n7KH3MZtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757497; c=relaxed/simple;
	bh=xwQv8uq+9wANm7Kp3tnfC+qRvpRyTa5vpEt37Og3eA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIX0GcXeT9uDXMJFLZ6r/PWJRukOnAGGOxdnMfFaCWlaqEMyHsJXSwdCPGQT6mmLZp6apuFRVYxUUahWb8J+RgX+k0quVIX8XvbjEH11P7oTGoj44EwobIzXEKN/9iTZ2oa19bh9r+OFib2wffUgKVR+2pgwG8kvsn9EJNbQQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8rB7BgP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707757497; x=1739293497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xwQv8uq+9wANm7Kp3tnfC+qRvpRyTa5vpEt37Og3eA0=;
  b=g8rB7BgPxQR73EpAeiCZdrWaSuvI012tT7YtglB5iG3gDMbO4TZgAwu4
   37mi5uUCy5F45WWniZZ+XFR58A84Skr/WCpzKs8jnoV+5kC1LwdWbgOqB
   5y4L7Sz9nzOUDdOlbknHW6o1HLnOyN4VjYit0Ix6rglaOgXeoXHQGJnh4
   mal66F23svj5MeAgMbrJ4IXDWLIzwxqIku196XGHBfBxaUi79wrELmU3Q
   mSxkpCREH2Y9ku4o3F59Fm8yTVmrgDKMS9mX24T2adQEaHNhiscQxXRbg
   HSH05FS8rSXVsgIRg9R6x1t9K012YjeUQUUBR5eSAl69G6qK41OJYfm0C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19153240"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19153240"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:04:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935116830"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="935116830"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2024 09:04:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 36C4F2E9; Mon, 12 Feb 2024 19:04:43 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v2 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Date: Mon, 12 Feb 2024 19:01:47 +0200
Message-ID: <20240212170423.2860895-15-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial device tree documentation for Maxim MAX6958/6959.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../bindings/auxdisplay/maxim,max6959.yaml    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml b/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
new file mode 100644
index 000000000000..49ce26176797
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/maxim,max6959.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX6958/6959 7-segment LED display controller with keyscan
+
+maintainers:
+  - Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+
+properties:
+  compatible:
+    const: maxim,max6959
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            max6959: max6959@38 {
+                    compatible = "maxim,max6959";
+                    reg = <0x38>;
+            };
+      };
-- 
2.43.0.rc1.1.gbec44491f096


