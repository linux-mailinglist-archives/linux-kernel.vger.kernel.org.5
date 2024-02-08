Return-Path: <linux-kernel+bounces-58434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72DC84E67D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E20C1F28D8D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697E823C2;
	Thu,  8 Feb 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVsW2fPu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005EB81AAA;
	Thu,  8 Feb 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412653; cv=none; b=nWdvk0U51g76fnmLnOK6G4Co8PK2StV7Jz6zQo621uefYVyWlYuUr1kZzm82ndOdmse7A+02NgKDt0Jmj/53G0SWwFL6usbTNOKlNQf0swdKMW/HS03V1g/oQcz4sDxbIHSDzXBQpOqr/HRd84JcnDJF5dSqhiuGgeqxPCFemAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412653; c=relaxed/simple;
	bh=xwQv8uq+9wANm7Kp3tnfC+qRvpRyTa5vpEt37Og3eA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2w8G5WazjFI+npjVGfd56gLpTuZwFImHNk4+q/FggEe5ZgMk88xP9NpI6VpopSfNrRwsFqENdGYn73mnol4lJ/tpj/9D2Xi/pcZOvi8z6ywPfqKHoqhfxlglLlchpNtnnuwLgpTAPa4N8jttBk+1IULLkmC0r9DVGtu8+3ko4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVsW2fPu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707412652; x=1738948652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xwQv8uq+9wANm7Kp3tnfC+qRvpRyTa5vpEt37Og3eA0=;
  b=fVsW2fPu6Wt4oEluiIUrQEpRY63dAi5Jkx3Zspqs+4bXHSQrDm6knJqW
   IfAtuGWi2kVtVaJoBdNu2sis9OyfS1MVDspFEZ91NbtizdM4XvBUrCxT3
   CH+nA6IV70lY183aFYXMGm4XrbKBHOdM5WMDFgkdyNUbgWrKBqrSs6nsu
   rHSUtnNUgmiEf4TcPAlIcoAiHgsnT6+mFXGSG3yWJ4CSD6ZOE7tF6j/Oq
   lHmFnBdWMNaWW/9OlvizBJmNJBUF3wRNsyxoMIYtaAF547NbKQO1K4G2R
   bmM6SPU8XqhjEPQVLYP8myagwTUc/oiIMDLHtieoQmkY8w8Fbfhl6jEz/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1565643"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1565643"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934195355"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934195355"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 09:17:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A7AEB168C; Thu,  8 Feb 2024 18:59:41 +0200 (EET)
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
Date: Thu,  8 Feb 2024 18:58:57 +0200
Message-ID: <20240208165937.2221193-15-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
References: <20240208165937.2221193-1-andriy.shevchenko@linux.intel.com>
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


