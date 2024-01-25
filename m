Return-Path: <linux-kernel+bounces-39430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C01483D107
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEEC28C6DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992D71B7E8;
	Thu, 25 Jan 2024 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsXN9eHn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8590175A1;
	Thu, 25 Jan 2024 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227058; cv=none; b=J4ouqNL1UeZ9T71jh3ph9t2+lLvf4rVGTFYft0gvVNxV6DX0tbLZNdfHlXFa8HVRdiomtLU1V9mwUmVTt+c2nhMkHajoqRz+rWWr3DS/gl/85NY9D+nM/z1fq8Jd97G3p7x51nvkvdyYqdd1gFqgOLHYcTSuEf/ZeUrdb+jMrYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227058; c=relaxed/simple;
	bh=yZBuOVK56XcD+IZGWPAQUigedfDATjZAltUsMaV/oCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0Cb6Q18M/7N8d41M04swciBYTGuNJ9DHTIAfN94cqVYtliLkLeKJi4aBf18UCcATxj/MEDiwzTp8mJP/Q/1akCmdqrvc8Sjb6L9OBCrv8QNGMzlxbdTYgvjQ3dsCcaAtdyZ1j8M9fOkJz8Z+0g7gGKAD+ZyZ4aHSC6E6AAdCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsXN9eHn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706227057; x=1737763057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yZBuOVK56XcD+IZGWPAQUigedfDATjZAltUsMaV/oCg=;
  b=AsXN9eHnOETaFKprBaa7HPHK0s94neoXJrTN+3vH99Sk9bxO707483Hp
   Qkhufllppwk+HZi7/QRnG3b6Y8/icnD/Kpp0RFDLNxN8EkyQtfcv2mt6I
   Z7SnN9ZW1p1QXVoBhNMbyZE4Lp84XuCbcDz4IQTFMSzjIeyqaP7hc+Srb
   ZYzATNSaVvp6CGg8tugSfpu4PkWHY53ZvqNEVWrTQo9PPF8s5mUkHT09z
   yzgClk6rO8oj+0A8OgVr5YGXYAexbbWxatDX9TbPF/ycmfHGMwmMfvBEy
   Es7U8iYzSmdaDODftDzaO7d5sRVTIdgJaSzTzb9ppPWn2JKwhz3DYwU2E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15867562"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15867562"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:57:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930191098"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930191098"
Received: from vcostago-mobl3.jf.intel.com ([10.24.14.99])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 15:57:34 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: brauner@kernel.org,
	amir73il@gmail.com,
	hu1.chen@intel.com
Cc: miklos@szeredi.hu,
	malini.bhandaru@intel.com,
	tim.c.chen@intel.com,
	mikko.ylinen@intel.com,
	lizhen.you@intel.com,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [RFC v2 1/4] cleanup: Fix discarded const warning when defining guards
Date: Thu, 25 Jan 2024 15:57:20 -0800
Message-ID: <20240125235723.39507-2-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125235723.39507-1-vinicius.gomes@intel.com>
References: <20240125235723.39507-1-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When defining guards for const types the void* return implicitly
discards the const modifier. Be explicit about it.

Compiler warning (gcc 13.2.1):

/include/linux/cleanup.h:154:18: warning: return discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  154 |         { return *_T; }
      |                  ^~~
/include/linux/cred.h:193:1: note: in expansion of macro ‘DEFINE_GUARD’
  193 | DEFINE_GUARD(cred, const struct cred *, _T = override_creds_light(_T),
      | ^~~~~~~~~~~~

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/linux/cleanup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..ac521c4521cd 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -151,7 +151,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return *_T; }
+	{ return (void *)*_T; }
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	EXTEND_CLASS(_name, _ext, \
-- 
2.43.0


