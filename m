Return-Path: <linux-kernel+bounces-71734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4D185A99B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C03B252D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5CE446A1;
	Mon, 19 Feb 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PepnHZIU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0045C1C;
	Mon, 19 Feb 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362234; cv=none; b=nWL2UEUUSnGOxQMsawwnW26SjSHp9A5IWIldP4f12chc9YHa++0hHyUfIuQ9vx5iO8/07Stoy4lNZU0F9529AdoVGVvdNBC4FSKkuTUkUDAegqYh0zwxP0qvTg78Ki02s4eKfCviGNse7QiDGUDibn97aYlKnAGQbTqTTEbdPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362234; c=relaxed/simple;
	bh=6cS5003Ea7vJky8UGZPonoKb3xlJWcOZDue5cut7S5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcSne+Julo800o+vlmTAgd9U4b7ELCNFPhFX3ds8JVLTzx3p92h8NH0g8LF4/kKicOCEaGhd7tSUsUN5TUn1AxzfBX5OkT+NGziPlGBTudA2WhhcyVvYo3mSCWw93U/0kKAgF90THCFcSWz87i3mwzLRPdb57sduraPhm+dxqms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PepnHZIU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708362233; x=1739898233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6cS5003Ea7vJky8UGZPonoKb3xlJWcOZDue5cut7S5o=;
  b=PepnHZIUZJ5Daw45Hcw1iZkn3Ki1ZlXcC2o3xo3dPTs/aBNZ4t5O1SJX
   2KBg/OscV/zASVFcJdhsorCLaCbWA3E4tlKv/kbGx3abuyU/QS9TW/GDa
   VaCegbnSoY6JG5A2F4hCS03au4J7fJlBYAOnQGrt0MhjLf50/9h8CcNut
   lbo86YEoSEpNTh7vnyekuEvR2fBv0MgdxdLSUWWe2Qz5r4FnLVsvUEpm6
   3DLls//6Go6xNgSy05XHZemblxz6qHxxqqOn1JFcGniDPBCAVJ33Z0aGN
   vqGDqOnBzqMjmFNDbXaOuLSx/7bpCapd0O4HQhFRmPoUpbLLqFy7xUlXE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2577449"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2577449"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 09:03:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936315372"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936315372"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 09:03:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8C0F4103D; Mon, 19 Feb 2024 19:03:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: [PATCH v3 8/9] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Date: Mon, 19 Feb 2024 18:58:07 +0200
Message-ID: <20240219170337.2161754-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial device tree documentation for Maxim MAX6958/6959.
As per reviewer's request mention the fact of absence reset and
power enable pins, since the hardware is quite simple.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/auxdisplay/maxim,max6959.yaml    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml b/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
new file mode 100644
index 000000000000..6c78bb185348
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/maxim,max6959.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX6958/6959 7-segment LED display controller
+
+maintainers:
+  - Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+
+description:
+  The Maxim MAX6958/6959 7-segment LED display controller provides
+  an I2C interface to up to four 7-segment LED digits. The MAX6959,
+  in comparison to MAX6958, adds input support. Type of the chip can
+  be autodetected via specific register read, and hence the features
+  may be enabled in the driver at run-time, in case they are requested
+  via Device Tree. A given hardware is simple and does not provide
+  any additional pins, such as reset or enable.
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display-controller@38 {
+            compatible = "maxim,max6959";
+            reg = <0x38>;
+        };
+    };
-- 
2.43.0.rc1.1.gbec44491f096


