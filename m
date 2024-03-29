Return-Path: <linux-kernel+bounces-124045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E93B891181
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16AC1F24A43
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30544C85;
	Fri, 29 Mar 2024 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvHL/maD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04A3F9CF;
	Fri, 29 Mar 2024 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678201; cv=none; b=Tid+fYHLhnKEb8G5arpuoVAOXHHwbV4c9tjJCf7JgK5VFIIe8JsYXzmVOCGpLkAJE1tnAutIkrq2JhONGpqU201ir1Tvio+v59fcFf5zDBXZ7xkW6xKRVJzrsOysYfKpbJBgcm29c6fgADpC00p7qiwz2elP4Q4Ph2/7EYG4kG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678201; c=relaxed/simple;
	bh=aiMV3JLKvNdSNk+9oWcbdjK3Hl15dermhyqrKf1VLgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y86n8k0V3/llQXsp3mFb1NCC7w1ASo1t01g5U2YKsKe08gnI/l7+tZz0zdzItVbQb7c+eVNNpXs+ek2q9tZcl41gVdMrbbFQ5uPzeARPZX6NoQyM76DyeBJoWbfvtAOpEoufNCiXStgk/ZPwK5bADryZuz1K1ChHGkng70wI/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DvHL/maD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711678200; x=1743214200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aiMV3JLKvNdSNk+9oWcbdjK3Hl15dermhyqrKf1VLgg=;
  b=DvHL/maDgm/EZ3rLOBOdSW4bX/B2lOnWkK60iqSm8rXSH+QTQ0K74DKx
   IChexcaB1nPej5IGvdbt+gpPWXEfh+p8Pikq/2ym0FzOzo5+uCvUKCXV8
   3To9QSbmWpXwvfLp/LjiHUtffeTmc5V2s1ueXFe2mvLLYOZI4itze5ViC
   acEIa8KO6slBmDxCS/gO8aQPcLVegYhqOgmSs3HhPwdQADQNsLlmB67AV
   jP3VP8kRc3BHX+Lrw/ic9eRCN0bdkoeJXKOkuTmoxUVRRKLMqLRgGXYN0
   dPnOay1U8ri82z4yjjqPJ/r/Z04ybgTevRINPsMzXqJ5K/fOv9wq6gt5O
   g==;
X-CSE-ConnectionGUID: Tt4UX0zvQKefSWm704dOCg==
X-CSE-MsgGUID: SyPsO9KXQi2u14yo97DYnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6700127"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6700127"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17301427"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 19:09:51 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dm-devel@redhat.com
Cc: ebiggers@kernel.org,
	luto@kernel.org,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@kernel.org,
	x86@kernel.org,
	herbert@gondor.apana.org.au,
	ardb@kernel.org,
	elliott@hpe.com,
	dan.j.williams@intel.com,
	bernie.keany@intel.com,
	charishma1.gairuboyina@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 12/14] x86/Kconfig: Add a configuration for Key Locker
Date: Thu, 28 Mar 2024 18:53:44 -0700
Message-Id: <20240329015346.635933-13-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329015346.635933-1-chang.seok.bae@intel.com>
References: <20230603152227.12335-1-chang.seok.bae@intel.com>
 <20240329015346.635933-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CONFIG_X86_KEYLOCKER to gate whether Key Locker is initialized at
boot. The option is selected by the Key Locker cipher module
CRYPTO_AES_KL (to be added in a later patch).

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
---
Changes from v8:
* Drop the "nokeylocker" option. (Borislav Petkov)

Changes from v6:
* Rebase on the upstream: commit a894a8a56b57 ("Documentation:
  kernel-parameters: sort all "no..." parameters")

Changes from RFC v2:
* Make the option selected by CRYPTO_AES_KL. (Dan Williams)
* Massage the changelog and the config option description.
---
 arch/x86/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39886bab943a..41eb88dcfb62 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1878,6 +1878,9 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 
 	  If unsure, say y.
 
+config X86_KEYLOCKER
+	bool
+
 choice
 	prompt "TSX enable mode"
 	depends on CPU_SUP_INTEL
-- 
2.34.1


