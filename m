Return-Path: <linux-kernel+bounces-58574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD2384E871
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03471C2366D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF6245BFE;
	Thu,  8 Feb 2024 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPpVkpOw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1B36AE1;
	Thu,  8 Feb 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418177; cv=none; b=Yt4z4mqEwKZOENMev72htaE3ycuKJaGyZqz+t6rqM1hufnEE1dCDPW8vHhAEjXirdN8TQ0eJINkLoJQoPBCmJ86ieIYEe0V3q4n0GAFnINUICT0u55021fpLlXnTTKTo89q8Xwbg7chikdZhC+rfdWAeKfhK5NS/yq6ViJK0QTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418177; c=relaxed/simple;
	bh=xwQv8uq+9wANm7Kp3tnfC+qRvpRyTa5vpEt37Og3eA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmtedN/pFCbYVpQKWQkl/hlMakijeAK80rLrX9goH1Deu7FXp6DdqpGY5fb2c1KeL+f4iaRU5N72dD54qHflPWd8K3yUPxQnQt3yGps4D4SRbdzwxQTJIBOyP9br82FN3xxKP+x9hg+ghXY0OsByMsS7xuF8krg77D3WSwntwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPpVkpOw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418175; x=1738954175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xwQv8uq+9wANm7Kp3tnfC+qRvpRyTa5vpEt37Og3eA0=;
  b=KPpVkpOwmpcbJaEuStBBJXt9pcDyw0Yp21ENfTOk3WWVq0SuxU1K9G0+
   694OQtFllPE+ThKBqsS+dqOuZGZTi+Nt1s+hOVi/yCA5ZXjj0s4Xd+dJo
   /8gpsSpXXGmOY0ONR+q1WypL+1mJO9J70UrMvsWMzjj1bhND6+uk3WfHU
   ur2qQwGbR3JxHg567nzcRNqdwb3jjgNg1tIjDHNW+FBorwuLoSWtnkW8I
   oqwVFS/PbVyZoSs1O/uY0CaggrCsegxSf2OchqwGKBwVFHcHFfxdx5eH2
   455QXbR7NIGFQE3Q09iWlV1GzxyrvuA/y/wcZL09mEHoXwDvVRb6xIJpT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186141"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186141"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215540"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215540"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BBA6112FC; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v1 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Date: Thu,  8 Feb 2024 20:48:12 +0200
Message-ID: <20240208184919.2224986-15-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
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


