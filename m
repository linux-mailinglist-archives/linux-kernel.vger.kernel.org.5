Return-Path: <linux-kernel+bounces-57567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CA784DACF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C382F287823
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F35F69D13;
	Thu,  8 Feb 2024 07:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsLMUKHo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40475B1E2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378318; cv=none; b=Cvsnqm1Px47wrNLHQ6orHsEpCLWN4DUICTRibYfutilGTh/9biAI+5b15Ru6zMueXNEeRCUWIbpRd5yubke0vno33jw0Dpj0TkhX53bV7cIxmDKaKjA9AiDfSEg0DXgk4IK+bqgnMZ8I2NjOW7kcuw13OY1dAihSOEEOhp2c7S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378318; c=relaxed/simple;
	bh=roVpI7QEG+N3Gp757y+PaAvh5MTMMTwStLishWClXg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SRnfShcumIP+/cL/VBPtDmDEpax0UBMLaZx23m05rot+j98RRI5VjkYKTcD2BUIQX8apV5W8NY+4UGWgT69SIznjp9smKbx+uwvVbZ2aDgQc+OYvQUX+v2Ecr1M8l8HCus7sNmvbyg4HawIuPJeYYXekgRDiXoGCMRmQtGTvCxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fsLMUKHo; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707378317; x=1738914317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=roVpI7QEG+N3Gp757y+PaAvh5MTMMTwStLishWClXg8=;
  b=fsLMUKHobw0l02PjV4u+HlFomM4aJnF9Qb98q1OBYNCBMuK5fgqiLBm+
   IAWZ+P/aUDcqcrK3VvGavabIouIF3l0cA8g21VbR85rCsJp7XFhC0lqWj
   on/cId/lffGdS2kI8/SfgHucb8zibQqsrK/8JEZNbs/tkVFcXelgz71eB
   /6Gyn2VqMTOAlNuHHQHWmBCUAHF7tQB73AncUERqLY0rIpt22ghkwXHUJ
   IUDuVzfUg/LmdKEg6kNbd+o5AskjRqfoxk3+QmWydy6+m488rCanfGdG0
   LYsxHai+7Y1wC8nuJlo+onvOQYtQBKhWHiwmwA1jPfY9zzKJ3WqIIx/R3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12242632"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12242632"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="6195645"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:45:16 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v3 0/3] Fixed-type GENMASK/BIT
Date: Wed,  7 Feb 2024 23:45:18 -0800
Message-ID: <20240208074521.577076-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ove the implementation of REG_GENMASK/REG_BIT to a more appropriate
place to be shared by i915, xe and possibly other parts of the kernel.

For now this re-defines the old macros. In future we may start using the
new macros directly, but that's a more intrusive search-and-replace.

Changes from v2:

	- Document both in commit message and code about the strict type
	  checking and give examples how it´d break with invalid params.

v1: https://lore.kernel.org/intel-xe/20230509051403.2748545-1-lucas.demarchi@intel.com/
v2: https://lore.kernel.org/intel-xe/20240124050205.3646390-1-lucas.demarchi@intel.com

Lucas De Marchi (2):
  bits: Introduce fixed-type BIT
  drm/i915: Convert REG_GENMASK* to fixed-width GENMASK_*

Yury Norov (1):
  bits: introduce fixed-type genmasks

 drivers/gpu/drm/i915/i915_reg_defs.h | 108 +++------------------------
 include/linux/bitops.h               |   1 -
 include/linux/bits.h                 |  51 ++++++++++---
 3 files changed, 51 insertions(+), 109 deletions(-)

-- 
2.43.0


