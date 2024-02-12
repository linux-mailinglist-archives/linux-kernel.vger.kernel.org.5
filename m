Return-Path: <linux-kernel+bounces-62079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A344A851B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8C11F297DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CEE3EA87;
	Mon, 12 Feb 2024 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i/acnuYh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B1E3F8D0;
	Mon, 12 Feb 2024 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758193; cv=none; b=iA4c8cWa1bkK1RzJLSximNBYKBYLDZDpl51rGBG3nZF6T/sKVIEND0BzKbH3epTQ/ruF0reGTnC6otVxBV26Np2x9cKgWeEV9+H1BLcf+ofxKR2xLsG5IEO4YJoPz0Vmiyvpw8QArPJ6vVVj/aFXTVw+LdQTkwS2w0LIWXS6ddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758193; c=relaxed/simple;
	bh=VMnufid5qErbMfja9S1C5HtGzP6eTvRfvDnZTjXAy0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlV04YPPTrP2jAVIMr4E0U3fdDbqj7vRS4efjAXkT+Pf3+aFqhwr79JbFSCViZo6J3hGkjPvFkpj0Cdu3xQMUqQ1JlvEOoMwnB3bD7FbD8JzOOLqt6dMYJeN7Q2WI9DKu5Ln9P3DDGHa67ISq6xN5IEbclxMlrPteaVOJCPOeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i/acnuYh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707758190; x=1739294190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VMnufid5qErbMfja9S1C5HtGzP6eTvRfvDnZTjXAy0Q=;
  b=i/acnuYhrawXr3F841BQxR0eoykw0cPoatJ268z9kZJQxBTM3NJgwgUb
   Kp4avFoViACYJsrK8wKTBUH4sGaweQ/ITX5ilc8ul5qEtk6Ktt4aVYha4
   B4ZR2zpSVx2wSMEycanohPWw/bvi/SVpMYW60bEch+TjX2LEv7kejjszB
   G0MejiuypqyeDVwJqMuI0XiWNTqgNDvyYSNI4FG25PcC6snM/aICOWX/1
   K1yhEHpVjUV8E2UEuvgsofBs/9tUenGb+fnj+dRQYSdENVT8zC3OrvrIt
   wKaOV6YkoMvmkPxHmbybWUwz30c8v4aovcB8yO0PAp1nJlKykOxkIBf4t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5519185"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="5519185"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911553773"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="911553773"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:16:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZZuq-00000003xbF-31mJ;
	Mon, 12 Feb 2024 19:16:24 +0200
Date: Mon, 12 Feb 2024 19:16:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Message-ID: <ZcpSaHW-RQ3dzywP@smile.fi.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-15-andriy.shevchenko@linux.intel.com>
 <ZcpSDOk-IQVasHud@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcpSDOk-IQVasHud@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 07:14:53PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 12, 2024 at 07:01:47PM +0200, Andy Shevchenko wrote:
> > Add initial device tree documentation for Maxim MAX6958/6959.
> 
> Oh, this is an old version :-(

Here is a new one:

From d8c826e06cf9237cd5fc6b2bb0b1cac5aff4fd8a Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 8 Feb 2024 17:23:38 +0200
Subject: [PATCH 1/1] dt-bindings: auxdisplay: Add Maxim MAX6958/6959

Add initial device tree documentation for Maxim MAX6958/6959.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../bindings/auxdisplay/maxim,max6959.yaml    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml b/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
new file mode 100644
index 000000000000..e7d602d02df1
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
@@ -0,0 +1,44 @@
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
+description:
+  The Maxim MAX6958/6959 7-segment LED display controller provides
+  an I2C interface to up to four 7-segment LED digits. The MAX6959
+  in comparison to MAX6958 has the debounce and interrupt support.
+  Type of the chip can be autodetected via specific register read,
+  and hence the features may be enabled in the driver at run-time.
+  Given hardware is simple and does not provide any additional pins,
+  such as reset or enable.
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
2.43.0



-- 
With Best Regards,
Andy Shevchenko



