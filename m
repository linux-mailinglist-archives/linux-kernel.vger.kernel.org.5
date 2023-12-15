Return-Path: <linux-kernel+bounces-1214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CB0814BBB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B089128194F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19473A8D8;
	Fri, 15 Dec 2023 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkGVcrol"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610C39FE4;
	Fri, 15 Dec 2023 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702654020; x=1734190020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZbsUhfpzOlZP4HelxUN8upZJntGREJDIbiHeVV/5Dls=;
  b=HkGVcrolLgzXdpMT82evrSrZmC4MUlvjtQhMLCITOYcSW9NfNrL0ykOv
   gEgndiRKywu3lb9sMY0HaOkVAMbwWJH5thL4lWqmxcbC/3fH5LONnczlc
   +M+rrJkaB8swP5J9tNX7HHbEeJzUFFGaukuoJZfIeAUrq/Hi+T+JB43nz
   F/Kn7LhBRH/7HGuknP50vgY+9rKW2Bmmt2xVfJ5wpSv+cPWmVaiahfywj
   7i50tuOnJMUguewWaCoWsA9oBV37bI6fTemICr7fJxA96+cxdWSDuv0Cq
   OWZadPbYXbmRTYyn5haaAPQXRNwyJgPZccH03ri0C6TDRGfvRWHYfhsKx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2374449"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2374449"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:26:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="750968704"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="750968704"
Received: from r007s007_zp31l10c01.deacluster.intel.com (HELO fedora.deacluster.intel.com) ([10.219.171.169])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2023 07:26:58 -0800
From: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>
Subject: [PATCH 1/5] math.h: Add avg_array()
Date: Fri, 15 Dec 2023 16:24:40 +0100
Message-ID: <20231215152440.34537-1-lucas.segarra.fernandez@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add macro to compute average of values within an array.

This patch is based on earlier work done by Wojciech Ziemba.

Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
---
 include/linux/math.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/math.h b/include/linux/math.h
index dd4152711de7..012416c92e89 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -205,4 +205,37 @@ static inline u32 int_sqrt64(u64 x)
 }
 #endif
 
+/**
+ * avg_array() - Return average of values within an array.
+ * @array: Array of values.
+ * @len: Number of elements.
+ *
+ * This algorithm computes average of an array without running into overflow.
+ *
+ * Return: average of values.
+ */
+#define avg_array(array, len) (				\
+{							\
+	typeof(&(array)[0]) _array = (array);		\
+	__unqual_scalar_typeof(_array[0]) _x = 0;	\
+	__unqual_scalar_typeof(_array[0]) _y = 0;	\
+	__unqual_scalar_typeof(_array[0]) _a, _b;	\
+	typeof(len) _len = (len);			\
+	size_t _i;					\
+							\
+	for (_i = 0; _i < _len; _i++) {			\
+		_a = _array[_i];			\
+		_b = do_div(_a, _len);			\
+		_x += _a;				\
+		if (_y >= _len - _b) {			\
+			_x++;				\
+			_y -= _len - _b;		\
+		} else {				\
+			_y += _b;			\
+		}					\
+	}						\
+	do_div(_y, _len);				\
+	(_x + _y);					\
+})
+
 #endif	/* _LINUX_MATH_H */
-- 
2.41.0


