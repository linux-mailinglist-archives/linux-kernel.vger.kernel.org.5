Return-Path: <linux-kernel+bounces-29358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FCC830D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128B928C481
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D581C249E0;
	Wed, 17 Jan 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtgDTjXh"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E0249EB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705519138; cv=none; b=QbZcvgs0bjbV/xQFsSIq2heUPn1cGqbDCBpo0PK/YpDG2jTXpG/CuH+3a1pgk3DNtkLeg11nqYpxnDGBnIq6XXvV/iUBwMcGx8+EUkH9J9Mx7j0VJcgSI01F+dmHARTmjQI8DTiadE58ljpbEPiC9Qm5tUhnw+VTqOmUj77DWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705519138; c=relaxed/simple;
	bh=GGQMmT5N9sfBSSRs9pcu+QkT7m+yWBsSw/myue7XHdc=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=o4A2xHoVlGfan2uR+zSWWSuYDjcuW8GnL10MDRBHfhvcBsEjmU06RNwPmuP7xjY3i8az0DhmCF6pYqYEb1y33BZCCQCj9Xlc3noeViSPbr+M9GtboiVYErPsMzu1CTIX3Hnq4XeZPC8Ta/jhlIn3TgOcc3umyiPcE19eks2yG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtgDTjXh; arc=none smtp.client-ip=134.134.136.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705519135; x=1737055135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GGQMmT5N9sfBSSRs9pcu+QkT7m+yWBsSw/myue7XHdc=;
  b=VtgDTjXhiWLFxtaG4v1PyXK3+8F8QwQ9PVutBcyUVP0prdtND3bYYjXG
   VOzlJpjs8vxzEfMS6vwt+nCV590L0PQ5Su84Tn0g/W+zfxjVTm9F2hKYh
   yEJVCD6kAaeSEwVTOGSmkr6Tlzj2h8VL2aovErFaO6O4B6qyKL5E+Ps/A
   uBqBrhA8cAkqnApb+h0gnXWIUkvscyb/d8vHBb1KzbV2FHlb5c81AmIgG
   6Zr+8J3WnLBBk8JLDVJt1gVjaukvc/ve84V+SYglYEYb/2RfU7BE7Rj0q
   bbnWL36Gc8Ipr05qSHFyFyJti4ndpporjXCSGn6nRSojkaULQ86wT10jU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="466635012"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="466635012"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 11:18:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="32889661"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 11:18:55 -0800
From: Tony Luck <tony.luck@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cpu: Add model number for Intel Clearwater Forest processor
Date: Wed, 17 Jan 2024 11:18:44 -0800
Message-ID: <20240117191844.56180-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Server product based on the Atom Darkmont core.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 197316121f04..b65e9c46b922 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -162,6 +162,8 @@
 #define INTEL_FAM6_ATOM_CRESTMONT_X	0xAF /* Sierra Forest */
 #define INTEL_FAM6_ATOM_CRESTMONT	0xB6 /* Grand Ridge */
 
+#define INTEL_FAM6_ATOM_DARKMONT_X	0xDD /* Clearwater Forest */
+
 /* Xeon Phi */
 
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
-- 
2.43.0


