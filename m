Return-Path: <linux-kernel+bounces-90360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8D886FE17
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB28E281968
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018622099;
	Mon,  4 Mar 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8v3+ZIp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E68208A2;
	Mon,  4 Mar 2024 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546131; cv=none; b=KcFNo6xINQv33OLT7DMJS6H5OKNjp2ya/T4kuXbwZAQtGiTUDkiWyOgGPgxmO3PKchuFLFlE5OAi6qCa6Z0rhOT4Btq+QEjy4wc5205Gj5MwYE/py3yCRNSFJGLhf9e4SelLEHV75cvHSFtX1umSXZU+3h0q0+FWS23roPal0Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546131; c=relaxed/simple;
	bh=tGGIjtvf2OqUUpfEvU1EyE4HH8U209KvVuAbHYsXd6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OP2a4+G+8rl7GS7Lhtxe0jZeKcvbC6IgQA2EvtqH68PjOqKs40va/RVJeSQCe8hS4BQ94HDiXOSoWRTHR8nw1CyFH6+Gfpil4MEj5fMKwyzVlr1A9im7x9qcdqUBZQDqCewjOUZ4Lr1DeEJN0VOLRHkv87DtdILP2sz3tfkOvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8v3+ZIp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709546129; x=1741082129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tGGIjtvf2OqUUpfEvU1EyE4HH8U209KvVuAbHYsXd6A=;
  b=C8v3+ZIp8FldoJsjrciDDtKs1srhE/DgqU2INnEKQty6DM9IvBrs0z8/
   Nd/rzDZwkfAvlQ0dABF1pyUawGwkuEmf/pMkYDNX4gON3JB7sacJnsA4u
   gfOXzXidGT1FqJJ3k4Q3Ns2w2+2T1NpRFlPiRo3fZd48caMuJJ5OWGI4v
   CjUkS5li04bjZr+2WCIKJM+Cxpi2z5eKEIMqe50Am+kdPp9sa+coYNBbd
   40Zzbz4qokcKbs4Lc+d3av/sw41zvHh+GbQ98dkznS9HbL+gkzV1+AR88
   9BL/fOXcMyax+TqD/K4AdgxvEGoLGm6LL1TGpa2jN80Le7ki2aNsSS3xN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7799078"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7799078"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:55:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="39934272"
Received: from syakovle-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.51.3])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:55:24 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Cc: jani.nikula@intel.com,
	dri-devel@lists.freedesktop.org,
	lkft-triage@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org
Subject: [PATCH] powerpc: include linux/backlight.h from asm/backlight.h
Date: Mon,  4 Mar 2024 11:55:12 +0200
Message-Id: <20240304095512.742348-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com>
References: <CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Removal of the backlight include from fb.h uncovered an implicit
dependency in powerpc asm/backlight.h. Add the explicit include.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/r/CA+G9fYsAk5TbqqxFC2W4oHLGA0CbTHMxbeq8QayFXTU75YiueA@mail.gmail.com
Fixes: 11b4eedfc87d ("fbdev: Do not include <linux/backlight.h> in header")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

Not even compile tested!
---
 arch/powerpc/include/asm/backlight.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/backlight.h b/arch/powerpc/include/asm/backlight.h
index 1b5eab62ed04..275d5bb9aa04 100644
--- a/arch/powerpc/include/asm/backlight.h
+++ b/arch/powerpc/include/asm/backlight.h
@@ -10,6 +10,7 @@
 #define __ASM_POWERPC_BACKLIGHT_H
 #ifdef __KERNEL__
 
+#include <linux/backlight.h>
 #include <linux/fb.h>
 #include <linux/mutex.h>
 
-- 
2.39.2


