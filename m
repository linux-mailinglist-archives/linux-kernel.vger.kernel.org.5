Return-Path: <linux-kernel+bounces-36444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB7883A0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD7928E078
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88321C8EC;
	Wed, 24 Jan 2024 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5hqdQI0"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E334684
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706072546; cv=none; b=Zbus4nISVNZ56RLXw5Vcz6qqcVB+Txa7RT34zoKwUueiMowvIIq83huvPu4Pru6uSXNw2S9wJhsrkf2CuGtSEaobIx6vVqgZEgujm3BmRY2l5qaWoeSpWsjlLzvmcvp/9msl+mPlA996QOtaC1Ud0YQ5u/ec2Jn1y20stllEP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706072546; c=relaxed/simple;
	bh=QrLe4l6tUvy4yjcm1YiMZuA6FEvLl4W5POoznrEmBKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2HRoRNXN91fJ9SevZu+rtbnNtkOK5qqwFbxLv0w+KlhwegHD2SM8yD55+jx9A1GN8k6yLXlL2oqczFDxTXdl/VQKzD2+T1Bs3UAtZnfQjqu6Ul6xHc4goybR5f9cuPQcKh1e/5k3UA1QuLESs/9UheA1DoY92OSjCA5NmUUHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5hqdQI0; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706072545; x=1737608545;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QrLe4l6tUvy4yjcm1YiMZuA6FEvLl4W5POoznrEmBKU=;
  b=n5hqdQI06HzLUdWKA/rVfgIkQeM3urevjapahCqEDOOtKLS3e1xiOa2c
   CSGbfsnHY+YJ4M1yjSJjfuTiG3ruQpZ9Urdvqh/EFq9+dGc8Fbc9anuzS
   AYJ/D6kEkfM6L+rO1ANNgFmm3RBZ3b6foRptVOBYkuOWK2XelhlcEWzOU
   OfJkGtCcbESkeBhiUS27M86X0hljbDkUpPBqw8JgBqguIViW5pdCrTq53
   eDD7BAhpld11A559dG+4cZbtq+9/s6gzvzOCnnu0FoTRVC0GPUh72p5OS
   pt1FSarfwm+bpd1+o6x1TvhaHMH4vVEdQXnbw30CoAkEw1oTfn7M2ahOR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401399353"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401399353"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 21:02:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="909551502"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="909551502"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 21:02:23 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 0/3] Fixed-type GENMASK/BIT
Date: Tue, 23 Jan 2024 21:02:02 -0800
Message-ID: <20240124050205.3646390-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the implementation of REG_GENMASK/REG_BIT to a more appropriate
place to be shared by i915, xe and possibly other parts of the kernel.

For now this re-defines the old macros. In future we may start using the
new macros directly, but that's a more intrusive search-and-replace.

Yury, I added a little bit more information to the commit message in
patch 1. First 2 patches may go through your tree. For the last one we
may have potential conflicts, so I'm not sure. +Jani from i915 side to
chime in.

v1: https://lore.kernel.org/intel-xe/20230509051403.2748545-1-lucas.demarchi@intel.com/

Lucas De Marchi (2):
  bits: Introduce fixed-type BIT
  drm/i915: Convert REG_GENMASK* to fixed-width GENMASK_*

Yury Norov (1):
  bits: introduce fixed-type genmasks

 drivers/gpu/drm/i915/i915_reg_defs.h | 108 +++------------------------
 include/linux/bitops.h               |   1 -
 include/linux/bits.h                 |  33 +++++---
 3 files changed, 33 insertions(+), 109 deletions(-)

-- 
2.43.0


