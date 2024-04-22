Return-Path: <linux-kernel+bounces-153550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858238ACF83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F301C217CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9781514F5;
	Mon, 22 Apr 2024 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+EFfEpm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EFF31A60
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796427; cv=none; b=ZxwAnc5BAQeq1v+kzwPOG/i/H/DSrfvTC4ZsorGVdpVdiqtn2V8uLxF8pKCVn10hXqxxTBvt7vk1ls8NSSs4LE43jVXtxWT8uoFvmrg7oj3KDqM07TxAE38OTxODw0CotDiAZorENIty5QbyxwJh4Vvyvpl7hG3JqQXqaIfAx0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796427; c=relaxed/simple;
	bh=kUSH5icI3VbYb/9ZFjrv+Z3d0DVDjFWYXsZm49p18/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1fWe+xwbbJkkc+sX6xteR3HSo3wtIz/tsOYoXfgvaDteBtdC7l2ydUFPPKygIWDBlc0gxgFxwK9km1T5JfjXzqvHmi0DtwibS+wcZ5oTl/9Ye/nnn+HuCvXcZUuIXDrgIAX8rXA1qJ389m0maXb4XL8dbKBOs7TubJ6yO2UM9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+EFfEpm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713796426; x=1745332426;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kUSH5icI3VbYb/9ZFjrv+Z3d0DVDjFWYXsZm49p18/Y=;
  b=Q+EFfEpm/tXGKflxbgHIUDzctg121378DLLUxluXGSe9kTBXC/JuVGwS
   VU9GtBB90B2NQvOsO/wVtv2fOtedJLTBKTJcvZuKh5quvmAeL0ZFr/3na
   DM9V5B3RQXwuopkWm8Kgn2IXr2LIK7+tT69rg7W2PgFVKNJueHoQP9gGF
   JMrg8mODSn5CYkR+8hWyjv+FEOwjwQ+GrpE1ptTZT/ODyEaN7i9fHciyI
   RxD4v05SAt12Gd2fnVk4ZKE9xTCzW4AutMDGT2yYfn+OvUQwybO4LH7tO
   7QaSTK46enVX7nrAn2vH7THziTVNZrsxpYA7I+QzY+9oxWNxFqlA/u2YM
   Q==;
X-CSE-ConnectionGUID: tJiMf1E3RBOcDsk3nPZw+w==
X-CSE-MsgGUID: O6nKnqUhTWKC+PT+1IRYQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="13118792"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="13118792"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 07:33:44 -0700
X-CSE-ConnectionGUID: tiLdCrN6RNWgar1Aq6aroA==
X-CSE-MsgGUID: T4jz1+MkSLaC0tbKPPSypg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28545254"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 22 Apr 2024 07:33:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 70B38FD; Mon, 22 Apr 2024 17:33:39 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Melissa Wen <mwen@igalia.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] drm: fixed: Don't use "proxy" headers
Date: Mon, 22 Apr 2024 17:33:38 +0300
Message-ID: <20240422143338.2026791-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/drm/drm_fixed.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
index 81572d32db0c..387fb81d5b81 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -25,8 +25,9 @@
 #ifndef DRM_FIXED_H
 #define DRM_FIXED_H
 
-#include <linux/kernel.h>
 #include <linux/math64.h>
+#include <linux/types.h>
+#include <linux/wordpart.h>
 
 typedef union dfixed {
 	u32 full;
-- 
2.43.0.rc1.1336.g36b5255a03ac


