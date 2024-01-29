Return-Path: <linux-kernel+bounces-42231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768CD83FE46
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5DA1F221BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29984D11A;
	Mon, 29 Jan 2024 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRaGXN50"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8641253E02;
	Mon, 29 Jan 2024 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509328; cv=none; b=jVLfxzHh7XSnsI+krpZlY9ZYDIEtpPK1hZH4GebVR6ys/I0eJYkr1aGIhhawrCcdIg/FksOjZ4UXunSYqJOAH3Q3yZA44k2+gddLY+Yk5NpTQ9fMq1VdNJfdFHUfZh3w9pS2NkKmiY/nR1A0b6faVBEgFMExXv6VRvnreY48kKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509328; c=relaxed/simple;
	bh=utYE4hLqczcpZ/LSvSwtG/51QIIizZvq86ERVo6zB2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XnaTq4YoZGASR+WuQYAgrNKkax9r40Cr4VJu5l+lGHl5IHhYUx48nEW1RFAXrESW06fb2BLWfey3lJ2wF1qJ6aGUlpsjViYxkIGc9CEN78ApyErOgMJJxzP+C/JQHZ/9kE0l82o6ffCBmQdszq0eqTdGGwSctGlP68v23+YZeW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRaGXN50; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706509326; x=1738045326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=utYE4hLqczcpZ/LSvSwtG/51QIIizZvq86ERVo6zB2k=;
  b=LRaGXN50JMTxWCW77RPbHj69MQFsLDC9PLNDdSJDjpND6DD6EPzK1vCX
   WH/advzp7V+r2vgNNDioKw01j79a76gZJZw82W9rk/jDiYYv10gcg6AIW
   AHCU0ZOHjoOHpQ962bEHQFFtLPJLUtUpZkNPWcV0lH58NDwiyuRd8nn9e
   dczgE1SKfaZJKohXRYMN9C0jVc4hv05+hVo/AOUtkSSLrdlNtmVnSdbUK
   TxJtVYsM6yOHQP6UgwDS9xUezAN7hgFtfS/D9dl2sT09qpjMou6jK1vRe
   /UU4b1T1a/kunFzCz30G1J3+L8qTytSPvBraLTQqTZTbtKL38Ldx5o7JP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="16219269"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="16219269"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 22:22:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="3270617"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 22:22:03 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Aristeu Rozanski <aris@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lili.li@intel.com,
	ricardo.neri-calderon@linux.intel.com
Subject: [PATCH 2/2] EDAC/i10nm: Add Intel Grand Ridge micro-server support
Date: Mon, 29 Jan 2024 14:20:40 +0800
Message-Id: <20240129062040.60809-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129062040.60809-1-qiuxu.zhuo@intel.com>
References: <20240129062040.60809-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Grand Ridge CPU model uses similar memory controller registers with
Granite Rapids server. Add Grand Ridge CPU model ID for EDAC support.

Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 2b83d6de9352..3fd22a1eb1a9 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -951,6 +951,7 @@ static const struct x86_cpu_id i10nm_cpuids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(EMERALDRAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(GRANITERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ATOM_CRESTMONT_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ATOM_CRESTMONT,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
-- 
2.17.1


