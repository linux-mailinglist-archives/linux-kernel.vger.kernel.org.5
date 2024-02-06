Return-Path: <linux-kernel+bounces-54205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0C84AC31
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABDA9B212A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9A656B68;
	Tue,  6 Feb 2024 02:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d1lD9pMP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3097D56B62;
	Tue,  6 Feb 2024 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186567; cv=none; b=FKG6yfP19BronO0p3OhTow8R2SqBxS0rF1sZE8LOkhOuocYPtkrCotoXhwwwgx+KLWVRY1yvrVEZvbSXBYQUfca0rcJ0Ol8QFWg4+JvnI78K/OQ5t69e2AFWJ1Z0eQTX+vq33uLSPijHK/9XCAYr7r7+oWJx42buyWBgSVeD0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186567; c=relaxed/simple;
	bh=D7IRLtF3PH0jQetL8lTh/A1nJy/dExwyhkIVcV8BgRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=L9jUbi9PVjUt1BX+ZhKBB+HkTMw7GGzwOnfe9coeHvt94XzgX3AfilJjJso8k8S5VjZDT96eVBIuBANZlDcjmkqccyqd8IQFQNR/X+VJzNWQQ4mQ5xS+8aOHBRpeOw4GqOlzE4Z4co/AZXJObqcTclih6VTXhqjLFU1L2k9Z/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d1lD9pMP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707186565; x=1738722565;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D7IRLtF3PH0jQetL8lTh/A1nJy/dExwyhkIVcV8BgRY=;
  b=d1lD9pMPlZG5cxQYF4WAZo38G1ngZ5Bgko6ZMLBFdW7vSt/DQNpcGKKd
   NaKXij+IfWasHDC01jAzEKax8ycaknuiry6A8rK7vm/9VQ4EVjiGhahDE
   l2whGhpdcFWIH6/EiQ7BOp4NEZpwnRye3r2+MG1K2iK2AHI1rhv1WjQN9
   OgdxWcmJKEJlm9uot2qDSebFjD5jq7XQmyG0wRh+TV1fqH3kE3SVHvfM4
   ouL21+pby+xcPNg8FXowDzHz7v1XSW64mTfGm+kmm4hiOwmy3pVYdQ/qe
   nLidM+ERwRbGzVDyPwMxs+OHK5loci3SrkJ2QaWF1rtNSL9UqL4HqeJLN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="556643"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="556643"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:29:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1167781"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:29:24 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH net v1] net: intel: fix old compiler regressions
Date: Mon,  5 Feb 2024 18:29:06 -0800
Message-Id: <20240206022906.2194214-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kernel build regressions/improvements email contained a couple of
issues with old compilers (in fact all the reports were on different
architectures, but all gcc 5.5) and the FIELD_PREP() and FIELD_GET()
conversions. They're all because an integer #define that should have
been declared as unsigned, was shifted to the point that it could set
the sign bit.

The fix just involves making sure the defines use the "U" identifier on
the constants to make sure they're unsigned. Should make the checkers
happier.

Confirmed with objdump before/after that there is no change to the
binaries.

Issues were reported as follows:
/drivers/net/ethernet/intel/ice/ice_base.c:238:7: note: in expansion of macro 'FIELD_GET'
      (FIELD_GET(GLINT_CTL_ITR_GRAN_25_M, regval) == ICE_ITR_GRAN_US))
       ^
/include/linux/compiler_types.h:435:38: error: call to '__compiletime_assert_1093' declared with attribute error: FIELD_GET: mask is not constant
drivers/net/ethernet/intel/ice/ice_nvm.c:709:16: note: in expansion of macro ‘FIELD_GET’
  orom->major = FIELD_GET(ICE_OROM_VER_MASK, combo_ver);
                ^
/include/linux/compiler_types.h:435:38: error: call to ‘__compiletime_assert_796’ declared with attribute error: FIELD_GET: mask is not constant
drivers/net/ethernet/intel/ice/ice_common.c:945:18: note: in expansion of macro ‘FIELD_GET’
  u8 max_agg_bw = FIELD_GET(GL_PWR_MODE_CTL_CAR_MAX_BW_M,
                  ^
/include/linux/compiler_types.h:435:38: error: call to ‘__compiletime_assert_420’ declared with attribute error: FIELD_GET: mask is not constant
drivers/net/ethernet/intel/i40e/i40e_dcb.c:458:8: note: in expansion of macro ‘FIELD_GET’
  oui = FIELD_GET(I40E_LLDP_TLV_OUI_MASK, ouisubtype);
        ^

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/lkml/d03e90ca-8485-4d1b-5ec1-c3398e0e8da@linux-m68k.org/ #i40e #ice
Fixes: 62589808d73b ("i40e: field get conversion")
Fixes: 5a259f8e0baf ("ice: field get conversion")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_dcb.h | 2 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h | 2 +-
 drivers/net/ethernet/intel/ice/ice_type.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.h b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
index 6b60dc9b7736..d76497566e40 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.h
@@ -43,7 +43,7 @@
 #define I40E_LLDP_TLV_SUBTYPE_SHIFT	0
 #define I40E_LLDP_TLV_SUBTYPE_MASK	(0xFF << I40E_LLDP_TLV_SUBTYPE_SHIFT)
 #define I40E_LLDP_TLV_OUI_SHIFT		8
-#define I40E_LLDP_TLV_OUI_MASK		(0xFFFFFF << I40E_LLDP_TLV_OUI_SHIFT)
+#define I40E_LLDP_TLV_OUI_MASK		(0xFFFFFFU << I40E_LLDP_TLV_OUI_SHIFT)
 
 /* Defines for IEEE ETS TLV */
 #define I40E_IEEE_ETS_MAXTC_SHIFT	0
diff --git a/drivers/net/ethernet/intel/ice/ice_osdep.h b/drivers/net/ethernet/intel/ice/ice_osdep.h
index 82bc54fec7f3..a2562f04267f 100644
--- a/drivers/net/ethernet/intel/ice/ice_osdep.h
+++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
@@ -24,7 +24,7 @@
 #define rd64(a, reg)		readq((a)->hw_addr + (reg))
 
 #define ice_flush(a)		rd32((a), GLGEN_STAT)
-#define ICE_M(m, s)		((m) << (s))
+#define ICE_M(m, s)		((m ## U) << (s))
 
 struct ice_dma_mem {
 	void *va;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 41ab6d7bbd9e..a508e917ce5f 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1072,7 +1072,7 @@ struct ice_aq_get_set_rss_lut_params {
 #define ICE_OROM_VER_BUILD_SHIFT	8
 #define ICE_OROM_VER_BUILD_MASK		(0xffff << ICE_OROM_VER_BUILD_SHIFT)
 #define ICE_OROM_VER_SHIFT		24
-#define ICE_OROM_VER_MASK		(0xff << ICE_OROM_VER_SHIFT)
+#define ICE_OROM_VER_MASK		(0xffU << ICE_OROM_VER_SHIFT)
 #define ICE_SR_PFA_PTR			0x40
 #define ICE_SR_1ST_NVM_BANK_PTR		0x42
 #define ICE_SR_NVM_BANK_SIZE		0x43
-- 
2.39.3


