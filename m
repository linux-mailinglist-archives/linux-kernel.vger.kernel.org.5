Return-Path: <linux-kernel+bounces-83244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07EC8690BD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1731C24355
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37381386CF;
	Tue, 27 Feb 2024 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SF33v3So"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD16F1384BF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037552; cv=none; b=lAl8CuwgjXBvr2hKcy//HvaxJdnfQ+cI5zSojqEiHjxdNS1OFD8rpgH6bVe28mngAe+RY6I+zFqeIA1/OkgComvtQT3qhAvnmpq5GjgpfxdDqReIqM5OfOQwfcZbJsUKN7opf+VW3sqn8qtE0JndewDMNutOCCHYznibbuaRl9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037552; c=relaxed/simple;
	bh=WXMtQm657FAu5vA4c7tJQaFJh29ORtj1lqGV9ucikA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AG2w5eoEgApzWrhtrOOfJ+HKQF/+FSM41jCghH4c7iVlyWo6fYVHwj/tPE24BjMT/dOtNJisP9aqlkWSh+KwOvpYDIEttebWLpiERIAiArMaNpnbOHGty9Ctalt1s9kdSnZgHeUCiv6an7oLNA7N3ZG+P/0NCHbZN2dVH/gEmQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SF33v3So; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709037550; x=1740573550;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WXMtQm657FAu5vA4c7tJQaFJh29ORtj1lqGV9ucikA8=;
  b=SF33v3So3glpQpwJMHAeatE9uG+lu1chzmnG5uevbMmTs0wLPDQmv+ps
   1PH5g5Iiv4jcNk7XPkhIWWXpovqrJc3lIrcPTjWNzzCZ/7pPTT/qni/uC
   6uwzMIbTJooxy9qGD4xvDF+hOdg7bQX6EGbaLbmc+y27bscPtb9qtTiOC
   1VdHy8H2CtqCUgldPCbcobqFb9oPczMnVFuHNnfqR4unhzCjLY8Vq2ca8
   T7buThcI4oK6MKhxs92u4tpmI4QC87PmBakG6vlRCc7HADB5vOYfb9SfE
   EUcJy/2yaEtw6uayEnkDYuNzdOqyKUrFs+kZT6LJCESB4odwN5k4+9U/j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3240081"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3240081"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 04:39:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="38062783"
Received: from wufei-optiplex-7090.sh.intel.com ([10.239.158.51])
  by fmviesa001.fm.intel.com with ESMTP; 27 Feb 2024 04:39:07 -0800
From: Fei Wu <fei2.wu@intel.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	guoren@kernel.org,
	jszhang@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Fei Wu <fei2.wu@intel.com>
Subject: [PATCH] riscv: Fix definition of _PAGE_NOCACHE_THEAD
Date: Tue, 27 Feb 2024 20:44:12 +0800
Message-Id: <20240227124412.2565716-1-fei2.wu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_PAGE_NOCACHE_THEAD is not used but the definition is wrong.

Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 arch/riscv/include/asm/pgtable-64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index b42017d76924..b99bd66107a6 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -136,7 +136,7 @@ enum napot_cont_order {
  * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
  */
 #define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
-#define _PAGE_NOCACHE_THEAD	((1UL < 61) | (1UL << 60))
+#define _PAGE_NOCACHE_THEAD	((1UL << 61) | (1UL << 60))
 #define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
 #define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
 
-- 
2.34.1


